SMODS.Sticker {
	key = "vampire",
	badge_colour = HEX('911911'), -- heh
	needs_enable_flag = false,
	rate = 0.3,
	
	sets = {
		Joker = true
	},
	
	atlas = "alloy_stickers",
	pos = {
		x = 0,
		y = 0
	},
	
	should_apply = function(self, card, center, area, bypass_roll)
		return SMODS.Sticker.should_apply(self, card, center, area, bypass_roll) and G.GAME.blood_stake_active
	end,
	
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				get_var("alloy_vampire_sticker_damage") * (-1) -- -1 * vampire_damage; there's no ability table so I have nowhere to put it
			}
		}
	end,
	
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			local vampire_damage = get_var("alloy_vampire_sticker_damage")
			ALLOY.ease_health(vampire_damage)
		end
	end
}

SMODS.Sticker {
	key = "explosive",
	badge_colour = HEX('524D4D'),
	needs_enable_flag = false,
	rate = 0.3,
	
	sets = {
		Joker = true
	},
	
	atlas = "alloy_stickers",
	pos = {
		x = 1,
		y = 0
	},
	
	should_apply = function(self, card, center, area, bypass_roll)
		return SMODS.Sticker.should_apply(self, card, center, area, bypass_roll) and G.GAME.unstable_stake_active
	end,
	
	apply = function(self, card, val)
		card.ability[self.key] = val
		if card.ability[self.key] then
			card.ability.explosive_fuse = (G.GAME.cutil_vars and G.GAME.cutil_vars.alloy_explosive_fuse_rounds) or CUTIL.get_variable("alloy_explosive_fuse_rounds")
		end
	end,
	
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.explosive_fuse or G.GAME.cutil_vars.alloy_explosive_fuse_rounds
			}
		}
	end,
	
	calculate = function(self, card, context)
		local function destroy_card(c)
			if c and not c.getting_sliced then
				c.getting_sliced = true
				G.GAME.joker_buffer = G.GAME.joker_buffer - 1
				G.E_MANAGER:add_event(Event({
					func = function()
						G.GAME.joker_buffer = 0
						c:start_dissolve({ HEX('524D4D') }, nil, 1.6)
						play_sound('slice1', 0.96 + math.random() * 0.08)
						return true
					end
				}))
			end
		end
	
		if context.end_of_round and context.main_eval then
			card.ability.explosive_fuse = card.ability.explosive_fuse - 1
			if card.ability.explosive_fuse == 0 then
				local my_pos = nil
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i] == card then
						my_pos = i
						break
					end
				end
				
				local left_card = my_pos and G.jokers.cards[my_pos - 1]
				local right_card = my_pos and G.jokers.cards[my_pos + 1]
				
				destroy_card(left_card)
				destroy_card(right_card)
				destroy_card(card)				
			end
		end
	end
}
