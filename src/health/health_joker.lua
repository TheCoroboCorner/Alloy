local function check_if_dead()	
	if ALLOY.min_health() >= ALLOY.total_health() then
		CUTIL.game_lose()
	end
end	

SMODS.Joker {
	key = "health_object",
	order = 0,
	rarity = 1,
	cost = 0,
	
	blueprint_compat = false,
	perishable_compat = false,
	no_collection = true,
	no_doe = true,
	
	in_pool = function(self, args)
		return false
	end,
	
	loc_vars = function(self, info_queue, card) 
		return {} 
	end,
	
	calculate = function(self, card, context)
		for k, v in pairs(SMODS.Stickers) do
			if card.ability[v.key] then
				card:remove_sticker(v.key)
			end
		end
	
		local current_score = G.GAME.chips
		local target_score = G.GAME.blind.chips
		
		local blind_completion_as_percentage = to_number(current_score / target_score)
		local blind_remaining_as_percentage = 1 - blind_completion_as_percentage
		
		if context.end_of_round and not context.game_over and context.main_eval then
			if blind_completion_as_percentage >= 1 and G.GAME.current_round.hands_played == 1 then
				local shield_bonus = get_var("alloy_shield_bonus")
				ALLOY.ease_shield(shield_bonus, false, true)
				
				SMODS.calculate_context({ shield_boost = true })
			end
		end
		
		if context.end_of_round and context.game_over and context.main_eval then
			if (ALLOY.total_health() - ALLOY.min_health())/100 > blind_remaining_as_percentage then
				local damage = -math.ceil(blind_remaining_as_percentage * 100)
				
				ALLOY.ease_damage(damage, false, true)
				
				SMODS.calculate_context({ survived_death = true })
				
				return {
					message = localize('k_saved_ex'),
					saved = 'ph_health',
					colour = G.C.RED
				}
			else
				SMODS.calculate_context({ survived_death = false })
			end
		end
		
		check_if_dead()
	end
}

function ALLOY.init_health_cardarea()
	G.alloy_health_area = CardArea(
		G.TILE_W - 600 * G.CARD_W - 200.95,
		-100.1 * G.jokers.T.h,
		G.jokers.T.w,
		G.jokers.T.h,
		{ 
			card_limit = 1,
			type = "joker",
			highlighted_limit = 0
		}
	)
	ALLOY.health_area = G.alloy_health_area
	
	if #ALLOY.health_area.cards == 0 then
		local health_joker = SMODS.add_card {
			key = "j_alloy_health_object",
			area = ALLOY.health_area,
			skip_materialize = true,
			no_edition = true
		}
	end
end