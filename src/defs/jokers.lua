SMODS.Joker {
	key = "cowardly_joker",
	rarity = 1,
	
	atlas = "alloy_jokers",
	pos = {
		x = 0,
		y = 0
	},
	
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
	
	atlas = "alloy_jokers",
	pos = {
		x = 1,
		y = 0
	},
	
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
	
	atlas = "alloy_jokers",
	pos = {
		x = 2,
		y = 0
	},
	
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
			return {
                message = "X" .. card.ability.extra.growth .. " Mult",
            }
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
	
	atlas = "alloy_jokers",
	pos = {
		x = 3,
		y = 0
	},
	
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
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			if SMODS.pseudorandom_probability(card, "alloy_nurse", card.ability.extra.numerator, card.ability.extra.denominator) then
				local health = pseudorandom("alloy_nurse", card.ability.extra.health_lower, card.ability.extra.health_upper)
				ALLOY.ease_health(health)
				return {
					message = "+" .. health .. " HP",
					colour = G.C.RARITY.Uncommon,
				}
			else
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
						attention_text({
							text = localize('k_nope_ex'),
							scale = 1.3,
							hold = 1.4,
							major = card,
							backdrop_colour = G.C.SECONDARY_SET.Tarot,
							align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
								'tm' or 'cm',
							offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
							silent = true
						})
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.06 * G.SETTINGS.GAMESPEED,
							blockable = false,
							blocking = false,
							func = function()
								play_sound('tarot2', 0.76, 0.4)
								return true
							end
						}))
						play_sound('tarot2', 1, 0.4)
						card:juice_up(0.3, 0.5)
						return true
					end
				}))
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
				xchips = (get_var("alloy_health") > 100) and card.ability.extra.chips or 1
			}
		end
	end
}
