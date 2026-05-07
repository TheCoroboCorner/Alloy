SMODS.Joker {
	key = "cowardly_joker",
	rarity = 1,
	
	--atlas = so and so,
	--pos = { x = something, y = something else },
	
	blueprint_compat = true,
	cost = 4,
	
	config = {
		extra = {
			chips_per_point = 75
		}
	},
	loc_vars = function(self, info_queue, card)
		local points = ALLOY.hp_percentage_points()
		local chips = card.ability.extra.chips_per_point * points
		
		return {
			vars = {
				math.max(0, chips)
			}
		}
	end,
	
	calculate = function(self, card, context)
		if context.joker_main then
			local points = ALLOY.health_percentage_points()
			local chips = card.ability.extra.chips_per_point * points
			
			return {
				chips = math.max(0, chips)
			}
		end
	end
}

SMODS.Joker {
	key = "brave_joker",
	rarity = 1,
	
	--atlas = so and so,
	--pos = { x = something, y = something else },
	
	blueprint_compat = true,
	cost = 4,
	
	config = {
		extra = {
			a_0 = 50, -- degree 0 coefficient
			a_1 = -50 -- degree 1 coefficient
		}
	},
	loc_vars = function(self, info_queue, card)
		local points = ALLOY.hp_percentage_points()
		local mult = card.ability.extra.a_1 * points + card.ability.extra.a_0
		
		return {
			vars = {
				math.max(0, mult)
			}
		}
	end,
	
	calculate = function(self, card, context)
		if context.joker_main then
			local points = ALLOY.hp_percentage_points()
			local mult = card.ability.extra.a_1 * points + card.ability.extra.a_0
			
			return {
				mult = math.max(0, mult)
			}
		end
	end
}
