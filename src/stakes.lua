CUTIL.register_modifier_type("blood_stake_health_max", function(health_max, params) return G.GAME.blood_stake_active and (health_max - params.penalty) or health_max end)
CUTIL.register_modifier_type("blood_stake_starting_health", function(starting_health, params) return G.GAME.blood_stake_active and (starting_health - params.penalty) or starting_health end)

CUTIL.add_modifier("alloy_health_max", "blood_stake_health_max", { penalty = 50 })
CUTIL.add_modifier("alloy_starting_health", "blood_stake_starting_health", { penalty = 50 })

SMODS.Stake {
	name = "Blood Stake",
	key = "blood",
	
	unlocked = ALLOY.debug.unlock_all_stakes,
	unlocked_stake = "tall",
	applied_stakes = { "gold" },
	prefix_config = { applied_stakes = { mod = false } },
	
	atlas = "alloy_stakes",
	pos = {
		x = 0,
		y = 0
	},
	sticker_atlas = "alloy_stickers",
	sticker_pos = {
		x = 0,
		y = 1
	},


	modifiers = function()
		G.GAME.blood_stake_active = true
	end,
	
	colour = G.C.SUITS.Hearts,
	loc_txt = {}
}

SMODS.Stake {
	name = "Tall Stake",
	key = "tall",
		
	unlocked = ALLOY.debug.unlock_all_stakes,
	unlocked_stake = "wood",
	applied_stakes = { "blood" },
	
	atlas = "alloy_stakes",
	pos = {
		x = 1,
		y = 0
	},
	sticker_atlas = "alloy_stickers",
	sticker_pos = {
		x = 1,
		y = 1
	},


	modifiers = function()
		G.GAME.tall_stake_active = true
		G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
	end,
	
	colour = G.C.SUITS.Spades,
	loc_txt = {}
}

SMODS.Stake {
	name = "Wooden Stake",
	key = "wood",
		
	unlocked = ALLOY.debug.unlock_all_stakes,
	unlocked_stake = "jammed",
	applied_stakes = { "tall" },
	
	atlas = "alloy_stakes",
	pos = {
		x = 2,
		y = 0
	},
	sticker_atlas = "alloy_stickers",
	sticker_pos = {
		x = 2,
		y = 1
	},


	modifiers = function()
		-- 30% chance for Jokers in shops or booster packs to have a Vampire sticker (take 1 health of damage per round, ignores shield)
		G.GAME.wood_stake_active = true
		G.GAME.modifiers.enable_vampire = true
	end,
	
	colour = G.C.UI.TEXT_DARK,
	loc_txt = {}
}

SMODS.Stake {
	name = "Jammed Stake",
	key = "jammed",
		
	unlocked = ALLOY.debug.unlock_all_stakes,
	unlocked_stake = "mountain",
	applied_stakes = { "wood" },
	
	atlas = "alloy_stakes",
	pos = {
		x = 3,
		y = 0
	},
	sticker_atlas = "alloy_stickers",
	sticker_pos = {
		x = 3,
		y = 1
	},

	modifiers = function()
		G.GAME.jammed_stake_active = true
		G.GAME.starting_params.hands = G.GAME.starting_params.hands - 1
	end,
	
	colour = G.C.SECONDARY_SET.Tarot,
	loc_txt = {}
}

SMODS.Stake {
	name = "Mountain Stake",
	key = "mountain",
		
	unlocked = ALLOY.debug.unlock_all_stakes,
	unlocked_stake = "unstable",
	applied_stakes = { "jammed" },
	
	atlas = "alloy_stakes",
	pos = {
		x = 4,
		y = 0
	},
	sticker_atlas = "alloy_stickers",
	sticker_pos = {
		x = 4,
		y = 1
	},

	modifiers = function()
		G.GAME.mountain_stake_active = true
		G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
	end,
	
	colour = G.C.SUITS.Diamonds,
	loc_txt = {}
}

SMODS.Stake {
	name = "Unstable Stake",
	key = "unstable",
		
	unlocked = ALLOY.debug.unlock_all_stakes,
	unlocked_stake = "platinum",
	applied_stakes = { "mountain" },
	
	atlas = "alloy_stakes",
	pos = {
		x = 0,
		y = 1
	},
	sticker_atlas = "alloy_stickers",
	sticker_pos = {
		x = 0,
		y = 2
	},

	modifiers = function()
		-- 30% chance for Jokers in shops or booster packs to have an Explosive sticker (explodes in 6 rounds and takes out all adjacent Jokers with it, ignoring Eternal)
		G.GAME.unstable_stake_active = true
		G.GAME.modifiers.enable_explosive = true
	end,
	
	colour = G.C.GREEN,
	loc_txt = {}
}

CUTIL.Events.add("Alloy", "platinum_stake", function(...) if G.GAME.platinum_stake_active then ALLOY.ease_damage(-5) end end, { filter = { "end_of_round", "main_eval" } })

SMODS.Stake {
	name = "Platinum Stake",
	key = "platinum",
		
	unlocked = ALLOY.debug.unlock_all_stakes,
	unlocked_stake = "warrior",
	applied_stakes = { "unstable" },
	
	atlas = "alloy_stakes",
	pos = {
		x = 1,
		y = 1
	},
	sticker_atlas = "alloy_stickers",
	sticker_pos = {
		x = 1,
		y = 2
	},

	modifiers = function()
		G.GAME.platinum_stake_active = true
	end,
	
	colour = G.C.SECONDARY_SET.Enhanced,
	loc_txt = {}
}

CUTIL.Events.add("Alloy", "warrior_stake", function(...) if G.GAME.warrior_stake_active then ALLOY.ease_damage(-10) end end, { filter = { "skip_blind", "main_eval" } })

SMODS.Stake {
	name = "Warrior Stake",
	key = "warrior",
		
	unlocked = ALLOY.debug.unlock_all_stakes,
	unlocked_stake = "champion",
	applied_stakes = { "platinum" },
	
	atlas = "alloy_stakes",
	pos = {
		x = 2,
		y = 1
	},
	sticker_atlas = "alloy_stickers",
	sticker_pos = {
		x = 2,
		y = 2
	},

	modifiers = function()
		G.GAME.warrior_stake_active = true
	end,
	
	colour = G.C.MULT,
	loc_txt = {}
}

SMODS.Stake {
	name = "Champion Stake",
	key = "champion",
		
	unlocked = ALLOY.debug.unlock_all_stakes,
	unlocked_stake = "legend",
	applied_stakes = { "warrior" },
	
	atlas = "alloy_stakes",
	pos = {
		x = 3,
		y = 1
	},
	sticker_atlas = "alloy_stickers",
	sticker_pos = {
		x = 3,
		y = 2
	},
	shiny = true,

	modifiers = function()
		G.GAME.champion_stake_active = true
		G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 2
	end,
	
	colour = G.C.MONEY,
	loc_txt = {}
}

SMODS.Stake {
	name = "Legend Stake",
	key = "legend",
		
	unlocked = ALLOY.debug.unlock_all_stakes,
	applied_stakes = { "champion" },
	
	atlas = "alloy_stakes",
	pos = {
		x = 4,
		y = 1
	},
	sticker_atlas = "alloy_stickers",
	sticker_pos = {
		x = 4,
		y = 2
	},
	shiny = true,

	modifiers = function()
		G.GAME.legend_stake_active = true
		G.GAME.win_ante = G.GAME.win_ante + 4
	end,
	
	colour = G.C.RARITY.Legendary,
	loc_txt = {}
}