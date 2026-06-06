ALLOY.Hero {
	config = {
		key = 'knight',
		rarity = 1,
		atlas = "alloy_heroes",
		pos = {
			x = 0,
			y = 0
		},
		cost = 5,
		blueprint_compat = false,
		config = {
			extra = {
				mult_per_energy = 2
			}
		},
		
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.extra.mult_per_energy,
					card.ability.extra.energy,
					card.ability.extra.max_energy,
					card.ability.extra.hp,
					card.ability.extra.attack,
					card.ability.extra.defense
				}
			}
		end
	},
	
	max_energy = 10,
	
	hp = 7,
	attack = 4,
	defense = 2,
	
	preferences = { ALLOY.prefer_card_scored(1) },
	ability = {
		cost = ALLOY.all_energy_cost(5),
		ready = ALLOY.usable_in_context("joker_main"),
		effect = function(self, card, context)
			return {
				mult = card.ability.extra.mult_per_energy * card.ability.extra.energy,
				repetitions = 0
			}
		end
	}
}

ALLOY.Hero {
	config = {
		key = 'golem',
		rarity = 2,
		atlas = "alloy_heroes",
		pos = {
			x = 1,
			y = 0
		},
		cost = 8,
		blueprint_compat = false,
		config = {
			extra = {
				gained_hp = 8
			}
		},
		
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.extra.gained_hp,
					card.ability.extra.energy,
					card.ability.extra.max_energy,
					card.ability.extra.hp,
					card.ability.extra.attack,
					card.ability.extra.defense
				}
			}
		end
	},
	
	max_energy = 100,
	
	hp = 15,
	attack = 1,
	defense = 5,
	
	preferences = { 
		function(self, card, context) 
			if context.individual and context.cardarea == G.play then
				return context.other_card:get_chip_bonus()
			end
		end 
	},
	ability = {
		cost = ALLOY.max_energy_cost(),
		ready = ALLOY.usable_in_context("joker_main"),
		effect = function(self, card, context)
			card.ability.extra.hp = card.ability.extra.hp + card.ability.extra.gained_hp
			return { repetitions = 0 }
		end
	}
}

ALLOY.Hero {
	config = {
		key = 'dilettante',
		rarity = 1,
		atlas = "alloy_heroes",
		pos = {
			x = 2,
			y = 0
		},
		cost = 6,
		blueprint_compat = false,
		config = {
			extra = {
				delta_energy = 1,
				delta_xmult = 0.1,
				base_xmult = 1,
				last_hand = "Nothing"
			}
		},
		
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					localize(card.ability.extra.last_hand, 'poker_hands'),
					card.ability.extra.delta_xmult,
					card.ability.extra.energy,
					card.ability.extra.max_energy,
					card.ability.extra.hp,
					card.ability.extra.attack,
					card.ability.extra.defense
				}
			}
		end
	},
	
	max_energy = 90,
	
	hp = 4,
	attack = 6,
	defense = 2,
	
	preferences = { 
		function(self, card, context) 
			return function(self, card, context)
				if context.joker_main then
					if context.scoring_name ~= card.ability.extra.last_hand then
						return card.ability.extra.delta_energy
					else
						card.ability.extra.last_hand = context.scoring_name
					end
				end
			end
		end 
	},
	ability = {
		cost = ALLOY.all_energy_cost(),
		ready = function(self, card, context)
			if context.joker_main then
				return context.scoring_name == card.ability.extra.last_hand
			end
		end,
		effect = function(self, card, context)
			return {
				xmult = card.ability.extra.energy * card.ability.extra.delta_xmult + card.ability.extra.base_xmult,
				repetitions = 0
			}
		end
	}
}

ALLOY.Hero {
	config = {
		key = 'assassin',
		rarity = 2,
		atlas = "alloy_heroes",
		pos = {
			x = 3,
			y = 0
		},
		cost = 9,
		blueprint_compat = false,
		config = {
			extra = {
				
			},
		},
		
		loc_vars = function(self, info_queue, card)
			return {
				vars = {
					card.ability.extra.energy,
					card.ability.extra.max_energy,
					card.ability.extra.hp,
					card.ability.extra.attack,
					card.ability.extra.defense
				}
			}
		end
	},
	
	max_energy = 2,
	
	hp = 8,
	attack = 8,
	defense = 4,
	
	preferences = { 
		ALLOY.prefer_hand_suit(1, "Spades")
	},
	ability = {
		cost = ALLOY.max_energy_cost(),
		ready = ALLOY.usable_in_context("joker_main"),
		effect = function(self, card, context) return { repetitions = 0 }end
	}
}