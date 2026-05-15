function ALLOY.Hero(args)
	args = args or {}
	
	local in_config = args.config or {}
	assert(in_config.key, "Heroes require a key")
	
	local base_config = {
		extra = {
			energy = 0,
			max_energy = args.max_energy or 5,
			
			hp = args.hp or 5,
			attack = args.attack or 2,
			defense = args.defense or 1
		}
	}
	if in_config.config then
		if in_config.config.extra then
			for k, v in pairs(in_config.config.extra) do
				base_config.extra[k] = v
			end
		end
		for k, v in pairs(in_config.config) do
			if k ~= "extra" then
				base_config[k] = v
			end
		end
	end
	
	local prefs = args.preferences or {}
	local ability = args.ability
	
	local forwarded = {
		set_ability = in_config.set_ability,
		add_to_deck = in_config.add_to_deck,
		remove_from_deck = in_config.remove_from_deck,
		calc_dollar_bonus = in_config.calc_dollar_bonus,
        update = in_config.update,
        set_sprites = in_config.set_sprites,
        load = in_config.load,
        check_for_unlock = in_config.check_for_unlock,
        set_badges = in_config.set_badges,
        set_card_type_badge = in_config.set_card_type_badge,
        draw = in_config.draw,
        in_pool = in_config.in_pool,
	}
	
	local joker_prototype = {
		key = in_config.key,
		loc_txt = in_config.loc_txt,
        atlas = in_config.atlas,
        pos = in_config.pos,
        rarity = in_config.rarity,
        pools = in_config.pools,
        cost = in_config.cost,
        prefix_config = in_config.prefix_config,
        dependencies = in_config.dependencies,
        display_size = in_config.display_size,
        pixel_size = in_config.pixel_size,
        badge_colour = in_config.badge_colour,
        badge_text_colour = in_config.badge_text_colour,
        config = base_config,
		attributes = { "alloy_hero" }
	}
	
	for k, v in pairs(forwarded) do
		if v ~= nil then
			joker_prototype[k] = v
		end
	end
	
	joker_prototype.calculate = function(self, card, context)
		local return_table = {}
		
		for _, preference in ipairs(prefs) do
			local ok, gain = pcall(preference, self, card, context)
			if ok and type(gain) == "number" and gain > 0 then
				card.ability.extra.energy = math.min(card.ability.extra.energy + gain, card.ability.extra.max_energy)
				
				return_table.message = localize({ "alloy_hero_charging" })
				return_table.colour = G.C.CHIPS
				return_table.message_card = card
				return_table.repetitions = 0
			end
		end
		
		local cost = ability.cost(self, card, context) or 0
		if ability and type(ability.ready) == "function" and ability.ready(self, card, context) and card.ability.extra.energy >= cost then
			return_table.repetitions = 0
			
			if (card.area == G.heroes) and G.enemies and G.enemies.jokers and G.enemies.jokers[1] then
				local enemy = G.enemies.jokers[1]
				
				local h_atk = card.ability.extra.attack
				local e_def = enemy.ability.extra.defense
				local damage = math.max(0, h_atk - e_def)
				
				enemy.ability.extra.hp = enemy.ability.extra.hp - damage
				if enemy.ability.extra.hp <= 0 then
					SMODS.destroy_cards(enemy, true, true)
				end
			else
				local ability_ret = ability.effect(self, card, context)
				
				for k, v in pairs(ability_ret or {}) do
					return_table[k] = v
				end
			end
			
			card:juice_up(0.8, 0.8)
			card.ability.extra.energy = math.max(0, card.ability.extra.energy - cost)
		end
		
		return return_table
	end
	
	joker_prototype.loc_vars = in_config.loc_vars or function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.energy or base_config.extra.energy,
				card.ability.extra.max_energy or base_config.extra.max_energy
			}
		}
	end
	
	SMODS.Joker(joker_prototype)
end