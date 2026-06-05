local c = HEX("#132878")
SMODS.ConsumableType {
	key = "Product",
	collection_rows = { 3, 3 },
	primary_colour = c,
	secondary_colour = c,
	shop_rate = 0.10,
	loc_txt = {
        undiscovered = {
            name = "Not Discovered",
            text = { 
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does",
            },
        }
    },
}

SMODS.UndiscoveredSprite {
  key = "Product",
  atlas = "alloy_products",
  pos = { x = 0, y = 3 },
  overlay_pos = { x = 1, y = 3 },
}

SMODS.Consumable {
	key = "medkit",
	set = "Product",
	
	atlas = "alloy_products",
	pos = {
		x = 0,
		y = 0
	},
	soul_pos = {
		x = 1,
		y = 0
	},
	
	config = {
		extra = {
			health_healed = 30
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				colours = { get_hp_text_color() },
				card.ability.extra.health_healed,
				get_hp_text()
			}
		}
	end,
	
	can_use = function(self, card)
		return ALLOY.hp_percentage(true, true) < 1
	end,
	use = function(self, card, area, copier)
		ALLOY.ease_health(card.ability.extra.health_healed)
	end
}

SMODS.Consumable {
	key = "golden_apple",
	set = "Product",
	
	atlas = "alloy_products",
	pos = {
		x = 2,
		y = 0
	},
	soul_pos = {
		x = 3,
		y = 0
	},
	
	config = {
		extra = {
			health_healed = 20
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				colours = { get_hp_text_color() },
				card.ability.extra.health_healed,
				get_hp_text()
			}
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		ALLOY.ease_health(card.ability.extra.health_healed, false, true)
	end
}

local function var_decrease(var, params)
	return var - params.delta
end
CUTIL.register_modifier_type("var_decrease", var_decrease)

SMODS.Consumable {
	key = "adrenaline",
	set = "Product",
	
	atlas = "alloy_products",
	pos = {
		x = 4,
		y = 0
	},
	soul_pos = {
		x = 5,
		y = 0
	},
	
	config = {
		extra = {
			extra_health = 10
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				colours = { get_hp_text_color() },
				get_var("alloy_health_min") - card.ability.extra.extra_health,
				get_hp_text()
			}
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		CUTIL.add_modifier("alloy_health_min", "var_decrease", { delta = card.ability.extra.extra_health }, 99999999)
	end
}

SMODS.Consumable {
	key = "plating",
	set = "Product",
	
	atlas = "alloy_products",
	pos = {
		x = 6,
		y = 0
	},
	soul_pos = {
		x = 7,
		y = 0
	},
	
	config = {
		extra = {
			extra_shield = 15
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				colours = { get_hp_text_color() },
				card.ability.extra.extra_shield,
				get_hp_text()
			}
		}
	end,
	
	can_use = function(self, card)
		return (get_var("alloy_health_max") >= card.ability.extra.extra_shield + get_var("alloy_health_min"))
		   and (get_var("alloy_health")     >= card.ability.extra.extra_shield + get_var("alloy_health_min"))
	end,
	use = function(self, card, area, copier)
		ALLOY.ease_health(-card.ability.extra.extra_shield, false, true)
		CUTIL.add_modifier("alloy_health_max", "var_decrease", { delta = card.ability.extra.extra_shield }, 99999999)
		CUTIL.add_modifier("alloy_shield_max", "var_decrease", { delta = -card.ability.extra.extra_shield }, 99999999)
	end
}

SMODS.Consumable {
	key = "energy_drink",
	set = "Product",
	
	atlas = "alloy_products",
	pos = {
		x = 8,
		y = 0
	},
	soul_pos = {
		x = 9,
		y = 0
	},
	
	config = {
		extra = {
			extra_shield = 10
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.extra_shield
			}
		}
	end,
	
	can_use = function(self, card)
		return get_var("alloy_shield") < get_var("alloy_shield_max")
	end,
	use = function(self, card, area, copier)
		ALLOY.ease_shield(card.ability.extra.extra_shield)
	end
}

SMODS.Consumable {
	key = "cake",
	set = "Product",
	
	atlas = "alloy_products",
	pos = {
		x = 0,
		y = 1
	},
	soul_pos = {
		x = 1,
		y = 1
	},
	
	config = {
		extra = {
			xmult = 1.5,
			xmult_loss = 0.1,
			health_healed = 4
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				colours = { get_hp_text_color() },
				card.ability.extra.xmult,
				card.ability.extra.xmult_loss,
				card.ability.extra.health_healed,
				get_hp_text()
			}
		}
	end,

	calculate = function(self, card, context)
		if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
	end,
	keep_on_use = function(self, card)
        return card.ability.extra.xmult - card.ability.extra.xmult_loss >= 1
    end,
	can_use = function(self, card)
		return ALLOY.hp_percentage(true, true) < 1
	end,
	use = function(self, card, area, copier)
		card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_loss
		ALLOY.ease_health(card.ability.extra.health_healed)
		SMODS.calculate_effect({message = "-X" .. card.ability.extra.xmult_loss .. " Mult", colour = G.C.MULT}, card)
	end
}

-- CoroPals

SMODS.Consumable {
	key = "corobo",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return #G.heroes.cards >= 1
	end,
	
	use = function(self, card, area, copier)
		for _, other_card in pairs(G.heroes.cards) do
			other_card.ability.extra.energy = other_card.ability.extra.max_energy
			card_eval_status_text(
				other_card,
				"extra",
				nil,
				nil,
				nil,
				{ message = localize("alloy_hero_charged_ex"), colour = G.C.CHIPS }
			)
		end
	end
}

SMODS.Consumable {
	key = "sylvia",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 2, y = 0 },
	soul_pos = { x = 3, y = 0 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "alloy_slime_points", set = "Other" }
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
		if get_var("alloy_health_mode") == "hp" then
			SPify()
		elseif get_var("alloy_health_mode") == "sp" then
			HPify()
		end
	end
}

SMODS.Consumable {
	key = "thunderedge",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 4, y = 0 },
	soul_pos = { x = 5, y = 0 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "nxkoo",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 6, y = 0 },
	soul_pos = { x = 7, y = 0 },
	config = { 
		extra = { 
			health = 2, suit = 'Hearts'
		} 
	},

	loc_vars = function(self, info_queue, card)
		local heart_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_suit(card.ability.extra.suit) then 
					heart_tally = heart_tally + 1 
				end
            end
        end
		return {
			vars = { 
				colours = { get_hp_text_color() },
				card.ability.extra.health, 
				card.ability.extra.health * heart_tally, 
				localize(card.ability.extra.suit, 'suits_singular'),
				get_hp_text()
			}
		}
	end,
	
	can_use = function(self, card)
		return ALLOY.hp_percentage(true, true) < 1
	end,

	use = function(self, card, area, copier)
		local heart_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_suit(card.ability.extra.suit) then 
					heart_tally = heart_tally + 1 
				end
            end
        end
		ALLOY.ease_health(card.ability.extra.health * heart_tally)
	end
}

SMODS.Consumable {
	key = "notmario",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 8, y = 0 },
	soul_pos = { x = 9, y = 0 },
	config = { extra = {
		times_left = 3,
		handtype = "Three of a Kind",
		shield_inc = 50
	} },

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				colours = { get_hp_text_color() },
				card.ability.extra.times_left,
				localize(card.ability.extra.handtype, 'poker_hands'),
				card.ability.extra.shield_inc,
				get_hp_text()
			}
		}
	end,
	
	calculate = function(self, card, context)
		if context.before and context.scoring_name == card.ability.extra.handtype then
			ALLOY.ease_shield(card.ability.extra.shield_inc, false, true)
			delay(0.1)
			local HP = get_var("alloy_health")
			local S = get_var("alloy_shield")
			ALLOY.ease_shield(math.min(HP, get_var("alloy_shield_max")) - S)
			ALLOY.ease_health(S - HP)
			card.ability.extra.times_left = card.ability.extra.times_left - 1
			if card.ability.extra.times_left == 0 then
				SMODS.destroy_cards(card)
			else
				card_eval_status_text(card, 'extra', nil, nil, nil,
					{
						message = localize({ type = "variable", key = "a_remaining", vars = { card.ability.extra.times_left } }),
						colour =
							G.C.ORANGE
					})
			end
		end
	end,

	can_use = function(self, card)
		return false
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "naku",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 0, y = 1 },
	soul_pos = { x = 1, y = 1 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "gabby",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 2, y = 1 },
	soul_pos = { x = 3, y = 1 },
	config = { extra = { amount = 2, enhancement = 'm_steel' } },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.enhancement]
		return {
			vars = { card.ability.extra.amount, localize { type = 'name_text', set = 'Enhanced', key = card.ability.extra.enhancement } }
		}
	end,
	
	can_use = function(self, card)
		return G.offhand and #G.offhand.cards > 1
	end,
	
	use = function(self, card, area, copier)
        local temp_hand = {}

        for _, playing_card in ipairs(G.offhand.cards) do temp_hand[#temp_hand + 1] = playing_card end
        table.sort(temp_hand,
            function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end
        )

        pseudoshuffle(temp_hand, 'alloy_gabby')

		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, card.ability.extra.amount do
            local percent = 1.15 - (i - 0.999) / (card.ability.extra.amount - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    temp_hand[i]:flip()
                    play_sound('card1', percent)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, card.ability.extra.amount do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    temp_hand[i]:set_ability(card.ability.extra.enhancement)
                    return true
                end
            }))
        end
        for i = 1, card.ability.extra.amount do
            local percent = 0.85 + (i - 0.999) / (card.ability.extra.amount - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    temp_hand[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    return true
                end
            }))
        end

		--[[local lookup = {}
		local function getSize(t)
			local counter = 0
			for _, _ in pairs(t) do
				counter = counter + 1
			end
			return counter
		end
		local function chooseRandomCard()
			if getSize(lookup) == #G.offhand.cards then return end
			local ccard = pseudorandom_element(G.offhand.cards, pseudoseed("seed"))
			if not lookup[ccard] then
				lookup[ccard] = true
			else
				chooseRandomCard()
			end
		end
		for _ = 1, card.ability.extra.amount do
			chooseRandomCard()
		end
		for cardd, _ in pairs(lookup) do
			quick_enhance_card(cardd, card.ability.extra.enhancement)
		end]]
	end
}

SMODS.Consumable {
	key = "foo",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 4, y = 1 },
	soul_pos = { x = 5, y = 1 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "typ0",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 6, y = 1 },
	soul_pos = { x = 7, y = 1 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		local r_mults = {}
		r_mults[#r_mults + 1] = { string = '_shield', colour = CUTIL.vec_lerp(G.C.JOKER_GREY, G.C.CHIPS, 0.25) }
		for i = 1, math.max(get_var("alloy_shield"), 2) do
			r_mults[#r_mults + 1] = tostring(i)
		end
		local loc_mult = { string = ' ' .. (localize('k_mult')) .. ', ', colour = G.C.MULT }
		local r_chips = {}
		for i = 1, math.max(get_var("alloy_health"), 2) do
			r_chips[#r_chips + 1] = tostring(i)
		end
		r_chips[#r_chips + 1] = { string = '_health', colour = CUTIL.vec_lerp(G.C.JOKER_GREY, G.C.MULT, 0.25) }
		local loc_chips = { string = ' ' .. 'Chips' .. ', ', colour = G.C.CHIPS }
		local main_start = {
			{
				n = G.UIT.C, config = {colour = G.C.CLEAR, padding = 0.02}, nodes = {
					{
						n = G.UIT.R, config = {colour = G.C.CLEAR, padding = 0.1}, nodes = {
							{ n = G.UIT.T, config = { text = '  +', colour = G.C.MULT, scale = 0.32 } },
							{ n = G.UIT.O, config = { object = DynaText({ string = r_mults, colours = { G.C.MULT }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = {
											{ string = 'rand()', colour = G.C.JOKER_GREY }, { string = "#@" .. (G.deck and G.deck.cards[1] and G.deck.cards[1].base.id or 11) .. (G.deck and G.deck.cards[1] and G.deck.cards[1].base.suit:sub(1, 1) or 'D'), colour = G.C.RED },
											loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult,
											loc_mult, loc_mult, loc_mult, loc_mult },
										colours = { G.C.UI.TEXT_DARK },
										pop_in_rate = 9999999,
										silent = true,
										random_element = true,
										pop_delay = 0.2011,
										scale = 0.32,
										min_cycle_time = 0
									})
								}
							},
						},
					},
					{
						n = G.UIT.R,
						config = { colour = G.C.CLEAR, padding = 0.1 },
						nodes = {
							{ n = G.UIT.T, config = { text = '  +', colour = G.C.CHIPS, scale = 0.32 } },
							{ n = G.UIT.O, config = { object = DynaText({ string = r_chips, colours = { G.C.CHIPS }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = {
											{ string = 'rand()', colour = G.C.JOKER_GREY }, { string = "#@" .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11) .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1, 1) or 'D'), colour = G.C.CHIPS },
											loc_chips, loc_chips, loc_chips, loc_chips, loc_chips, loc_chips, loc_chips, loc_chips,
											loc_chips,
											loc_chips, loc_chips, loc_chips, loc_chips },
										colours = { G.C.UI.TEXT_DARK },
										pop_in_rate = 9999999,
										silent = true,
										random_element = true,
										pop_delay = 0.2011,
										scale = 0.32,
										min_cycle_time = 0
									})
								}
							},
						},
					}
				}
			}
		}
		return { main_start = main_start }
	end,
	
	can_use = function(self, card)
		return false
	end,
	
	use = function(self, card, area, copier)
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            return {
				mult = pseudorandom('alloy_typ0', 1, math.max(get_var("alloy_shield"), 2)),
				chips = pseudorandom('alloy_typ1', 1, math.max(get_var("alloy_health"), 2) ),
            }
        end

	end
}

SMODS.Consumable {
	key = "violet",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 8, y = 1 },
	soul_pos = { x = 9, y = 1 },
	config = { extra = { shield = 1, requirement = 0.2 } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.shield, card.ability.extra.requirement }
		}
	end,

	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			local shield = math.floor( (to_number(G.GAME.chips) - to_number(G.GAME.blind.chips)) / (to_number(G.GAME.blind.chips) * card.ability.extra.requirement) )
			ALLOY.ease_shield(card.ability.extra.shield * shield)
			SMODS.calculate_effect({message = "+" .. (card.ability.extra.shield * shield) .. " Shield", colour = G.C.CHIPS}, card)
			SMODS.destroy_cards(card, nil, nil, true)
		end
	end,
	
	can_use = function(self, card)
		return false
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "jolyne",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 0, y = 2 },
	soul_pos = { x = 1, y = 2 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return false
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "argel",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 2, y = 2 },
	soul_pos = { x = 3, y = 2 },
	config = { extra = { hp_inc = 8 } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				colours = { get_hp_text_color() },
				card.ability.extra.hp_inc, card.ability.extra.hp_inc * ((G.GAME.alloy_argels_used or 0) + 1),
				get_hp_text()
			}
		}
	end,
	
	can_use = function(self, card)
		return ALLOY.hp_percentage(true, true) < 1
	end,
	
	use = function(self, card, area, copier)
		G.GAME.alloy_argels_used = (G.GAME.alloy_argels_used or 0) + 1
		ALLOY.ease_health(card.ability.extra.hp_inc * G.GAME.alloy_argels_used)
	end
}

SMODS.Consumable {
	key = "astra",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 4, y = 2 },
	soul_pos = { x = 5, y = 2 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "meta",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 6, y = 2 },
	soul_pos = { x = 7, y = 2 },
	config = { extra = { health_loss = 5, xchips = 1, xchips_gain = 0.1 } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				colours = { get_hp_text_color() },
				card.ability.extra.health_loss,
				card.ability.extra.xchips,
				card.ability.extra.xchips_gain,
				get_hp_text()
			}
		}
	end,

	calculate = function(self, card, context)
		if context.end_of_round and G.GAME.blind.boss and context.game_over == false and context.main_eval and not context.blueprint then
			SMODS.destroy_cards(card, nil, nil, true)
			return {
                message = ":(",
            }
		end

		if context.joker_main then
            return {
                xchips = card.ability.extra.xchips
            }
        end
	end,
	
	keep_on_use = function(self, card)
        return true
    end,

	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
		ALLOY.ease_damage(-card.ability.extra.health_loss)
		card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_gain
		SMODS.calculate_effect({message = "X" .. card.ability.extra.xchips .. " Chips", colour = G.C.CHIPS}, card)
	end
}

SMODS.Consumable {
	key = "max",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 8, y = 2 },
	soul_pos = { x = 9, y = 2 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "feli",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 0, y = 3 },
	soul_pos = { x = 1, y = 3 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "lily",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 2, y = 3 },
	soul_pos = { x = 3, y = 3 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "inky",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 4, y = 3 },
	soul_pos = { x = 5, y = 3 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "ruby",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 6, y = 3 },
	soul_pos = { x = 7, y = 3 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "incognito",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 8, y = 3 },
	soul_pos = { x = 9, y = 3 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "lexi",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 0, y = 4 },
	soul_pos = { x = 1, y = 4 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "opal",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 2, y = 4 },
	soul_pos = { x = 3, y = 4 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "ali",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 4, y = 4 },
	soul_pos = { x = 5, y = 4 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "soulware",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 6, y = 4 },
	soul_pos = { x = 7, y = 4 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "lizzie",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 8, y = 4 },
	soul_pos = { x = 9, y = 4 },
	config = {
		max_highlighted = 3,
		extra = {
			suit = 'Clubs',
		}
	},

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
		return {
			vars = { card.ability.max_highlighted, localize(card.ability.extra.suit, 'suits_plural') }
		}
	end,
	
	-- covered by max_highlighted
	-- can_use = function(self, card)
	-- 	return true
	-- end,
	
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    SMODS.change_base(G.hand.highlighted[i], card.ability.extra.suit, '3')
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:set_edition("e_foil", true)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
	end
}

SMODS.Consumable {
	key = "omega",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 0, y = 5 },
	soul_pos = { x = 1, y = 5 },
	config = { extra = { percent = 0.555 } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				colours = { get_hp_text_color() },
				card.ability.extra.percent * 100,
				get_hp_text()
			}
		}
	end,
	can_use = function(self, card)
		return ALLOY.hp_percentage(true, true) < 1
	end,
	
	use = function(self, card, area, copier)
		ALLOY.ease_health(math.ceil(get_var("alloy_health") * card.ability.extra.percent))
	end
}

SMODS.Consumable {
	key = "haya",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 2, y = 5 },
	soul_pos = { x = 3, y = 5 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "elle",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 4, y = 5 },
	soul_pos = { x = 5, y = 5 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "willow",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 6, y = 5 },
	soul_pos = { x = 7, y = 5 },
	config = { extra = { rounds_left = 3, heal_amt = 1 } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				colours = { get_hp_text_color() },
				card.ability.extra.rounds_left,
				card.ability.extra.heal_amt,
				get_hp_text()
			}
		}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and card.ability.extra.heal_amt ~= 0 then
			card_eval_status_text(card, 'extra', nil, nil, nil,
		{ message = SMODS.signed(card.ability.extra.heal_amt), colour = card.ability.extra.heal_amt > 0 and G.C.GREEN or G.C.RED })
			ALLOY.ease_health(card.ability.extra.heal_amt)
		end
		if context.end_of_round and context.game_over == false then
			card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1
			if card.ability.extra.rounds_left == 0 then
				SMODS.destroy_cards(card)
			else
				card_eval_status_text(card, 'extra', nil, nil, nil,
					{ message = localize({ type = "variable", key = "a_remaining", vars = { card.ability.extra.rounds_left } }), colour =
					G.C.ORANGE })
			end
		end
	end,
	can_use = function(self, card)
		return false
	end,
}

SMODS.Consumable {
	key = "missingnumber",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 8, y = 5 },
	soul_pos = { x = 9, y = 5 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "pastel",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 0, y = 6 },
	soul_pos = { x = 1, y = 6 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "the_long_quiet",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 2, y = 6 },
	soul_pos = { x = 3, y = 6 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "stoat",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 4, y = 6 },
	soul_pos = { x = 5, y = 6 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "sophie",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 6, y = 6 },
	soul_pos = { x = 7, y = 6 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}

SMODS.Consumable {
	key = "mother",
	set = "Product",
	atlas = "alloy_coropal",
	pos = { x = 8, y = 6 },
	soul_pos = { x = 9, y = 6 },
	config = { extra = { } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { }
		}
	end,
	
	can_use = function(self, card)
		return true
	end,
	
	use = function(self, card, area, copier)
	end
}