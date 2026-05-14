return {
	descriptions = {
		Joker = {
			j_alloy_cowardly_joker = {
				name = "Cowardly Joker",
				text = {
					"Gives more {C:chips}Chips{} the more",
					"{C:uncommon}HP{} you have",
					"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
					
				}
			},
			j_alloy_brave_joker = {
				name = "Brave Joker",
				text = {
					"Gives more {C:mult}Mult{} the less",
					"{C:uncommon}HP{} you have",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
					
				}
			},
			j_alloy_saiyan_joker = {
				name = "Saiyan Joker",
				text = {
					"This Joker gains",
					"{X:mult,C:white}X#1#{} Mult for every",
					"point of {C:uncommon}HP{} recovered",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
					
				}
			},
			j_alloy_zombie_joker = {
				name = "Zombie Joker",
				text = {
					"{X:mult,C:white}X#1#{} Mult if {C:uncommon}HP{} is",
					"currently below {C:attention}0"
				}
			},
			j_alloy_nurse_joker = {
				name = "Nurse Joker",
				text = {
					"{C:green}#1# in #2#{} chance to heal",
					"between {C:attention}#3#{} and {C:attention}#4# {C:uncommon}HP",
					"at the end of round"
				}
			},
			j_alloy_angel_joker = {
				name = "Angel Joker",
				text = {
					"{X:chips,C:white}X#1#{} Chips if {C:uncommon}HP{} is",
					"currently above {C:attention}100"
				}
			},
		},
		Stake = {
			stake_alloy_blood = {
				name = "Blood Stake",
				text = {
					"Maximum health is",
					"decreased by {C:attention}50",
					"{s:0.8}Applies all previous Stakes"
				}
			},
			stake_alloy_tall = {
				name = "Tall Stake",
				text = {
					"Required score scales",
					"much faster for each {C:attention}Ante",
					"{s:0.8}Applies all previous Stakes"
				}
			},
			stake_alloy_wood = {
				name = "Wooden Stake",
				text = {
					"Shop can have {C:attention}Vampiric{} Jokers",
					"{C:inactive,s:0.8}(Attacks you for one damage at the",
					"{C:inactive,s:0.8}end of round, ignores shield)",
					"{s:0.8}Applies all previous Stakes"
				}
			},
			stake_alloy_jammed = {
				name = "Jammed Stake",
				text = {
					"{C:red}-1{} Hand",
					"{s:0.8}Applies all previous Stakes"
				}
			},
			stake_alloy_mountain = {
				name = "Mountain Stake",
				text = {
					"Required score scales",
					"a lot faster for each {C:attention}Ante",
					"{s:0.8}Applies all previous Stakes"
				}
			},
			stake_alloy_unstable = {
				name = "Unstable Stake",
				text = {
					"Shop can have {C:attention}Explosive{} Jokers",
					"{C:inactive,s:0.8}(Explodes after {C:attention,s:0.8}6 {C:inactive,s:0.8}rounds, taking itself and",
					"{C:inactive,s:0.8}and adjacent Jokers out, ignoring Eternal)",
					"{s:0.8}Applies all previous Stakes"
				}
			},
			stake_alloy_platinum = {
				name = "Platinum Stake",
				text = {
					"Take {C:attention}5{} damage at",
					"the end of each round",
					"{s:0.8}Applies all previous Stakes"
				}
			},
			stake_alloy_warrior = {
				name = "Warrior Stake",
				text = {
					"Skipping a blind now",
					"makes you take {C:attention}10{} damage",
					"{s:0.8}Applies all previous Stakes"
				}
			},
			stake_alloy_champion = {
				name = "Champion Stake",
				text = {
					"Required score scales",
					"{C:attention}drastically{} for each {C:attention}Ante",
					"{s:0.8}Applies all previous Stakes"
				}
			},
			stake_alloy_legend = {
				name = "Legend Stake",
				text = {
					"{C:legendary,E:1}Beat four more Antes to win",
					"{s:0.8}Applies all previous Stakes"
				}
			}
		},
		Product = {
			c_alloy_medkit = {
				name = "Medkit",
				text = {
					"Heals {C:uncommon}#1#{} HP"
				}
			},
			c_alloy_golden_apple = {
				name = "Golden Apple",
				text = {
					"Heals {C:uncommon}#1#{} HP",
					"{s:0.8}(Ignores the usual limit)"
				}
			},
			c_alloy_adrenaline = {
				name = "Adrenaline",
				text = {
					"Allows you to {C:attention}survive",
					"until your health reaches {C:red}#1#{}"
				}
			},
			c_alloy_plating = {
				name = "Metal Plating",
				text = {
					"Decreases your maximum",
					"{C:uncommon}HP{} by {C:attention}#1#{}, but increases",
					"your maximum {C:common}Shield",
					"by {C:attention}#1#"
				}
			},
			c_alloy_energy_drink = {
				name = "Energy Drink",
				text = {
					"Gain {C:common}#1#{} Shield"
				}
			},
		},
		Other = {
			alloy_vampire = {
				name = "Vampire Sticker",
				text = {
					"Lose {C:red}#1#{} HP at end of round"
				}
			},
			alloy_explosive = {
				name = "Explosive Sticker",
				text = {
					"{C:red}Explodes{} in #1# rounds and",
					"{C:red}destroys{} all adjacent Jokers,",
					"{C:attention}ignores Eternal"
				}
			},
			alloy_blood_sticker = {
				name = "Blood Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Blood",
                    "{C:attention}Stake{} difficulty",
                },
			},
			alloy_tall_sticker = {
				name = "Tall Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Tall",
                    "{C:attention}Stake{} difficulty",
                },
			},
			alloy_wood_sticker = {
				name = "Wood Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Wood",
                    "{C:attention}Stake{} difficulty",
                },
			},
			alloy_jammed_sticker = {
				name = "Jammed Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Jammed",
                    "{C:attention}Stake{} difficulty",
                },
			},
			alloy_mountain_sticker = {
				name = "Mountain Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Mountain",
                    "{C:attention}Stake{} difficulty",
                },
			},
			alloy_unstable_sticker = {
				name = "Unstable Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Unstable",
                    "{C:attention}Stake{} difficulty",
                },
			},
			alloy_platinum_sticker = {
				name = "Platinum Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Platinum",
                    "{C:attention}Stake{} difficulty",
                },
			},
			alloy_warrior_sticker = {
				name = "Warrior Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Warrior",
                    "{C:attention}Stake{} difficulty",
                },
			},
			alloy_champion_sticker = {
				name = "Champion Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Champion",
                    "{C:attention}Stake{} difficulty",
                },
			},
			alloy_legend_sticker = {
				name = "Legend Sticker",
                text = {
                    "Used this Joker",
                    "to win on {C:attention}Legend",
                    "{C:attention}Stake{} difficulty",
                },
			},
		}
	},
	misc = {
		dictionary = {
			ph_health = "But it refused.",
			
			b_hold = "Hold",
			b_swap = "Swap ",
			b_last = "Play Last\n   Hand",
			
			b_locked = "Locked ",
			b_unlocked = "Unlocked ",
			
			k_product = "Product",
			b_product_cards = "Products",

			alloy_hero_button_j = "BECOME HERO",
			alloy_hero_button_h = "RETURN TO JOKERS",
		},
		labels = {
			alloy_vampire = "Vampire",
			alloy_explosive = "Explosive",
			
			product = "Product",
		}
	}
}
