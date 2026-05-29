SMODS.ConsumableType {
	key = "Product",
	collection_rows = { 3, 3 },
	primary_colour = HEX("132878"),
	secondary_colour = HEX("132878"),
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
		return true
	end,
	
	use = function(self, card, area, copier)
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
	key = "notmario",
	set = "Product",
	
	atlas = "alloy_coropal",
	pos = { x = 8, y = 0 },
	soul_pos = { x = 9, y = 0 },
	
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
		local lookup = {}
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
		end
		--[[for i = 1, card.ability.extra.amount do
			local convert = pseudorandom_element(pool, 'gabby_convert')
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
                delay = 0.1,
				func = function()
					convert:set_ability(card.ability.extra.enhancement)
					convert:juice_up()
					return true
				end
			}))
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
	key = "violet",
	set = "Product",
	
	atlas = "alloy_coropal",
	pos = { x = 8, y = 1 },
	soul_pos = { x = 9, y = 1 },
	
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
		return true
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
			vars = { card.ability.extra.health_loss, card.ability.extra.xchips, card.ability.extra.xchips_gain }
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
	key = "maxbo",
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