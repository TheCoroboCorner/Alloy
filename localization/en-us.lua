return {
	descriptions = {
		AlloyCredits = {
			NakuAutumn = {
				name = "{s:1.5,C:alloy_naku_credit_pink}Naku{s:1.5,C:alloy_naku_credit_green}Autumn",
				text = {
					"{s:1.1,E:1,C:alloy_naku_gradient}haii!! :3333",
					"I'm {C:alloy_naku_credit_pink}Naku{C:alloy_naku_credit_green}Autumn{}, proud",
					"{C:attention,E:2}Programmer{} and{C:attention,E:2} Artist",
					"for Alloy!",
					"^v^"
				}
			}
		},
		Joker = {
			j_alloy_cowardly_joker = {
				name = "Cowardly Joker",
				text = {
					"Gives more {C:chips}Chips{} the more",
					"{V:1}#2#{} you have",
					"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
					
				}
			},
			j_alloy_brave_joker = {
				name = "Brave Joker",
				text = {
					"Gives more {C:mult}Mult{} the less",
					"{V:1}#2#{} you have",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
					
				}
			},
			j_alloy_saiyan_joker = {
				name = "Saiyan Joker",
				text = {
					"This Joker gains",
					"{X:mult,C:white}X#1#{} Mult for every",
					"point of {V:1}#3#{} recovered",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
					
				}
			},
			j_alloy_zombie_joker = {
				name = "Zombie Joker",
				text = {
					"{X:mult,C:white}X#1#{} Mult if {V:1}#2#{} is",
					"currently below {C:attention}0"
				}
			},
			j_alloy_nurse_joker = {
				name = "Nurse Joker",
				text = {
					"{C:green}#1# in #2#{} chance to heal",
					"between {C:attention}#3#{} and {C:attention}#4# {V:1}#5#",
					"at the end of round"
				}
			},
			j_alloy_angel_joker = {
				name = "Angel Joker",
				text = {
					"{X:chips,C:white}X#1#{} Chips if {V:1}#2#{} is",
					"currently above {C:attention}100"
				}
			},
			
			j_alloy_knight = {
				name = "Brave Knight",
				text = {
					"Gains {C:chips}1{} Energy when a card is scored",
					"Unleashes {C:mult}+#1#{} Mult per {C:chips}Energy{} stored",
					"{C:inactive}(Unleashes when Energy is at least {C:chips}5{C:inactive})",
					"{C:inactive,s:0.85}(Currently {C:chips,s:0.85}#2#{C:inactive,s:0.85}/{C:chips,s:0.85}#3#{C:inactive,s:0.853} Energy)",
					"{C:inactive,s:0.7}HP: #4#, ATK: #5#, DEF: #6#"
				}
			},
			j_alloy_golem = {
				name = "Tough Golem",
				text = {
					"Gains {C:chips}1{} Energy per {C:chips}chip value{} scored",
					"HP increases by {C:uncommon}#1#{} HP when Energy is maxed out",
					"{C:inactive,s:0.85}(Currently {C:chips,s:0.85}#2#{C:inactive,s:0.85}/{C:chips,s:0.85}#3#{C:inactive,s:0.853} Energy)",
					"{C:inactive,s:0.7}HP: #4#, ATK: #5#, DEF: #6#"
				}
			},
			j_alloy_dilettante = {
				name = "Indecisive Dilettante",
				text = {
					"Gains {C:chips}1{} Energy when hand played is not",
					"your {C:attention}last played hand {C:inactive}(#1#)",
					"Unleashes {X:mult,C:white}X#2#{} Mult per {C:chips}Energy{} stored",
					"{C:inactive}(Unleashes when hand played is your last played hand)",
					"{C:inactive,s:0.85}(Currently {C:chips,s:0.85}#3#{C:inactive,s:0.85}/{C:chips,s:0.85}#4#{C:inactive,s:0.853} Energy)",
					"{C:inactive,s:0.7}HP: #5#, ATK: #6#, DEF: #7#"
				}
			},
			j_alloy_assassin = {
				name = "Patient Assassin",
				text = {
					"Gains {C:chips}1{} Energy when a {C:spades}Spade Flush{} is played",
					"Can only attack, has no other abilities",
					"{C:inactive}(Attacks when Energy is maxed out)",
					"{C:inactive,s:0.85}(Currently {C:chips,s:0.85}#1#{C:inactive,s:0.85}/{C:chips,s:0.85}#2#{C:inactive,s:0.853} Energy)",
					"{C:inactive,s:0.7}HP: #3#, ATK: #4#, DEF: #5#"
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
					"Heals {C:attention}#1# {V:1}#2#"
				}
			},
			c_alloy_golden_apple = {
				name = "Golden Apple",
				text = {
					"Heals {C:attention}#1# {V:1}#2#",
					"{s:0.8,C:inactive}(Ignores the usual limit)"
				}
			},
			c_alloy_adrenaline = {
				name = "Adrenaline",
				text = {
					"Allows you to {C:attention}survive",
					"until your {V:1}#2#{} reaches {C:red}#1#{}"
				}
			},
			c_alloy_plating = {
				name = "Metal Plating",
				text = {
					"Decreases your maximum",
					"{V:1}#2#{} by {C:attention}#1#{}, but increases",
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
			c_alloy_cake = {
				name = "Cake",
				text = {
					"{X:mult,C:white}X#1#{} Mult,",
					"heals {C:attention}#3# {V:1}#4#{} and loses",
					"{X:mult,C:white}X#2#{} Mult per use",
				}
			},

			-- CoroPals

			c_alloy_corobo = {
				name = "Corobo",
				text = {
					"Fully {C:chips}charges{} the current",
					"{C:attention}Hero Joker"
				}
			},
			c_alloy_sylvia = {
				name = "Sylvia",
				text = {
					"Switch the current",
					"health vial between",
					"{C:green}HP {C:inactive}(Regular){} and {C:chips}SP{}",
				}
			},
			c_alloy_thunderedge = {
				name = "ThunderEdge",
				text = {
				}
			},
			c_alloy_nxkoo = {
				name = "Nxkoo",
				text = {
					"Heals {C:attention}#1# {V:1}#4#{} for",
					"each {C:hearts}#3#{} Card",
					"in your {C:attention}full deck",
                    "{C:inactive}(Currently {V:1}+#2#{C:inactive} #4#)",
				}
			},
			c_alloy_notmario = {
				name = "NotMario",
				text = {
					"For the next {C:attention}#1#{} played",
					"{C:attention}#2#s{}, gain",
					"{C:attention}#3# {C:common}Shield{} and swap",
					"current {C:common}Shield{} and {V:1}#4#{}",
					"{s:0.8,C:inactive}(Ignores the usual limit)",
				}
			},
			c_alloy_naku = {
				name = "Naku",
				text = {
				}
			},
			c_alloy_gabby = {
				name = "Gabby",
				text = {
					"Enhance {C:attention}#1#{} random",
					"cards in your offhand",
					"into {C:attention}#2#",
				}
			},
			c_alloy_foo = {
				name = "Foo",
				text = {
				}
			},
			c_alloy_typ0 = {
				name = "Typ0",
				text = {
				}
			},
			c_alloy_violet = {
				name = "Violet",
				text = {
				}
			},
			c_alloy_jolyne = {
				name = "Jolyne",
				text = {
					"Before the next time you",
					"take {C:red}damage{}, this {C:product}Product{}",
					"gives {C:common}Shield{} equivalent to its",
					"{C:attention}sell value{} and {C:red,E:2}self destructs{}",
				}
			},
			c_alloy_argel = {
				name = "Argel",
				text = {
					"Heals {C:attention}#1# {V:1}#3#{} for",
					"each {C:attention}Argel{} that has",
					"been used this run",
                    "{C:inactive}(Currently {V:1}+#2#{C:inactive} #3#)",
				}
			},
			c_alloy_astra = {
				name = "Astra",
				text = {
				}
			},
			c_alloy_meta = {
				name = "Meta",
				text = {
					"Lose {C:attention}#1#{} {V:1}#4#{} and",
					"gain {X:chips,C:white}X#3#{} per use,",
					"{C:red,E:2}self destructs{} when",
					"{C:attention}Boss Blind{} is defeated",
					"{C:inactive}(Currently {X:chips,C:white}X#2#{C:inactive} Chips)",
				}
			},
			c_alloy_max = {
				name = "Max",
				text = {
				}
			},
			c_alloy_feli = {
				name = "Feli",
				text = {
				}
			},
			c_alloy_lily = {
				name = "Lily",
				text = {
				}
			},
			c_alloy_inky = {
				name = "Inky",
				text = {
				}
			},
			c_alloy_ruby = {
				name = "Ruby",
				text = {
				}
			},
			c_alloy_incognito = {
				name = "Incognito",
				text = {
				}
			},
			c_alloy_lexi = {
				name = "Lexi",
				text = {
				}
			},
			c_alloy_opal = {
				name = "Opal",
				text = {
				}
			},
			c_alloy_ali = {
				name = "Ali",
				text = {
				}
			},
			c_alloy_soulware = {
				name = "Soulware",
				text = {
				}
			},
			c_alloy_lizzie = {
				name = "Lizzie",
				text = {
					"Converts up to {C:attention}#1#{}",
					"selected cards into",
					"{C:dark_edition}Foil{} {C:attention}3s{} of {C:clubs}#2#"
				}
			},
			c_alloy_omega = {
				name = "Omega",
				text = {
					"Heal {C:attention}#1#%{} of",
					"your current {V:1}#2#",
				}
			},
			c_alloy_haya = {
				name = "Haya",
				text = {
				}
			},
			c_alloy_elle = {
				name = "Elle",
				text = {
				}
			},
			c_alloy_willow = {
				name = "Willow",
				text = {
					"For the next {C:attention}#1#{}",
					"rounds, every {C:attention}scored{}",
					"{C:attention}card{} gives {C:attention}#2# {V:1}#3#"
				}
			},
			c_alloy_missingnumber = {
				name = "Missing Number",
				text = {
				}
			},
			c_alloy_pastel = {
				name = "Pastel",
				text = {
				}
			},
			c_alloy_the_long_quiet = {
				name = "The Long Quiet",
				text = {
				}
			},
			c_alloy_stoat = {
				name = "Stoat",
				text = {
				}
			},
			c_alloy_sophie = {
				name = "Sophie",
				text = {
				}
			},
			c_alloy_mother = {
				name = "Møther",
				text = {
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
			alloy_slime_points = {
				name = "Slime Points",
				text = {
					"Consuming {C:attention}Food{} Jokers",
					"heals a certain amount",
					"based on {C:attention}rarity{}",
					"{s:0.3} ",
					"{C:common}Common{} -> {C:attention}10 {C:chips}SP{}",
					"{C:uncommon}Uncommon{} -> {C:attention}20 {C:chips}SP{}",
					"{C:rare}Rare{} -> {C:attention}40 {C:chips}SP{}",
					"{C:legendary}Legendary{} -> {C:attention}80 {C:chips}SP{}",
				}
			}
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
			
			alloy_hero_charging = "Charging...",
			
			-- use for fully charged hero
			-- e.g. corobo coropal
			alloy_hero_charged_ex = "Charged!",

			alloy_hp = "HP",
			alloy_sp = "SP",
			alloy_food_button = "Eat Joker",

			alloy_hp_label = "Health",
			alloy_sp_label = "Slime",

			alloy_sh_label = "Shield",

			alloy_tab_label = "Credits",
			k_jolyne_saved = "I'll save u!!"
		},
		labels = {
			alloy_vampire = "Vampire",
			alloy_explosive = "Explosive",
			
			product = "Product",
		}
	}
}
