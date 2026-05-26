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
  no_overlay = true
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
				card.ability.extra.health_healed
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
				card.ability.extra.health_healed
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
				get_var("alloy_health_min") - card.ability.extra.extra_health
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
				card.ability.extra.extra_shield
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
				card.ability.extra.xmult,
				card.ability.extra.xmult_loss,
				card.ability.extra.health_healed
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