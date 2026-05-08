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
		local points = ALLOY.hp_percentage(false, false)
		local chips = card.ability.extra.chips_per_point * points
		
		return {
			vars = {
				chips
			}
		}
	end,
	
	calculate = function(self, card, context)
		if context.joker_main then
			local points = ALLOY.hp_percentage(false, false)
			local chips = card.ability.extra.chips_per_point * points
			
			return {
				chips = chips
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
		local points = ALLOY.hp_percentage(false, false)
		local mult = card.ability.extra.a_1 * points + card.ability.extra.a_0
		
		return {
			vars = {
				mult
			}
		}
	end,
	
	calculate = function(self, card, context)
		if context.joker_main then
			local points = ALLOY.hp_percentage(false, false)
			local mult = card.ability.extra.a_1 * points + card.ability.extra.a_0
			
			return {
				mult = mult
			}
		end
	end
}

SMODS.Joker {
	key = "saiyan_joker",
	rarity = 2,
	
	--atlas = so and so,
	--pos = { x = something, y = something else },
	
	blueprint_compat = true,
	cost = 4,
	
	config = {
		extra = {
			scaling_factor = 1/100,
			growth = 1
		}
	},
	loc_vars = function(self, info_queue, card)
		
		return {
			vars = {
				card.ability.extra.scaling_factor,
				card.ability.extra.growth
			}
		}
	end,
	
	calculate = function(self, card, context)
		if context.health_changed and context.health_changed > 0 then
			card.ability.extra.growth = card.ability.extra.growth + context.health_changed * card.ability.extra.scaling_factor
		end
		
		if context.joker_main then			
			return {
				xmult = card.ability.extra.growth
			}
		end
	end
}

SMODS.Joker {
	key = "zombie_joker",
	rarity = 2,
	
	--atlas = so and so,
	--pos = { x = something, y = something else },
	
	blueprint_compat = true,
	cost = 4,
	
	config = {
		extra = {
			mult = 2.5
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult
			}
		}
	end,
	
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = (get_var("alloy_health") < 0) and card.ability.extra.mult or 1
			}
		end
	end
}

SMODS.Joker {
	key = "nurse_joker",
	rarity = 2,
	
	--atlas = so and so,
	--pos = { x = something, y = something else },
	
	blueprint_compat = false,
	cost = 4,
	
	config = {
		extra = {
			numerator = 1,
			denominator = 4,
			health_lower = 10,
			health_upper = 30
		}
	},
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
		return {
			vars = {
				numerator,
				denominator,
				card.ability.extra.health_lower,
				card.ability.extra.health_upper
			}
		}
	end,
	
	calculate = function(self, card, context)
		if context.end_of_round and context.joker_main and not context.blueprint then
			if SMODS.pseudorandom_probability(card, "alloy_nurse", card.ability.extra.numerator, card.ability.extra.denominator) then
				ALLOY.ease_health(SMODS.pseudorandom("alloy_nurse", card.ability.extra.health_lower, card.ability.extra.health_upper))
			end
		end
	end
}

SMODS.Joker {
	key = "angel_joker",
	rarity = 1,
	
	--atlas = so and so,
	--pos = { x = something, y = something else },
	
	blueprint_compat = true,
	cost = 4,
	
	config = {
		extra = {
			chips = 2
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.chips
			}
		}
	end,
	
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = (get_var("alloy_health") > 100) and card.ability.extra.chips or 1
			}
		end
	end
}

SMODS.Joker {
	key = "divining_joker",
	rarity = 1,
	
	--atlas = so and so,
	--pos = { x = something, y = something else },
	
	blueprint_compat = false,
	cost = 4,
	
	config = {
		extra = {
			health = 10,
			poker_hand = 'Royal Flush'
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.health,
				localize(card.ability.extra.poker_hand, 'poker_hands')
			}
		}
	end,
	
	calculate = function(self, card, context)
		if context.joker_main and not context.blueprint and next(context.poker_hands[card.ability.extra.poker_hand]) then
			ALLOY.ease_health(card.ability.extra.health, false, true)
		end
	end
}