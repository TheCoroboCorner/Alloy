ALLOY = SMODS.current_mod

ALLOY.total_health = 100

ALLOY.shield_colour_dull = HEX('164E75')
ALLOY.shield_colour_bright = HEX('4CDFFC')
ALLOY.shield_colour_white = HEX('99EEFF')

-- ALLOY.default = {}
-- ALLOY.modifiers = {}
-- ALLOY.actions = {}
-- ALLOY.debug = {}

CUTIL.add_variable("alloy_health", 100)
CUTIL.add_variable("alloy_shield", 0)

-- default.health_min is the lowest value HP can be before game over triggers
--ALLOY.default.health_min = 0
CUTIL.add_variable("alloy_health_min", 0)

-- default.health_max is the highest value HP can be
-- ALLOY.default.health_max = 100
CUTIL.add_variable("alloy_health_max", 100)

-- starting_health is the starting HP value
-- ALLOY.starting_health = ALLOY.default.health_max
CUTIL.add_variable("alloy_starting_health", 100)

-- default.shield_min is the lowest value shield can be before depleting HP
-- ALLOY.default.shield_min = 0
CUTIL.add_variable("alloy_shield_min", 0)

-- default.shield_max is the highest value shield can be
-- ALLOY.default.shield_max = 25
CUTIL.add_variable("alloy_shield_max", 25)

-- default.shield_bonus is the bonus given at the end of a round where only one hand was played
-- ALLOY.default.shield_bonus = 5
CUTIL.add_variable("alloy_shield_bonus", 5)

-- default.explosive_fuse_rounds is how many rounds it takes before explosive cards blow up
-- ALLOY.default.explosive_fuse_rounds = 6
CUTIL.add_variable("alloy_explosive_fuse_rounds", 6)

-- starting_shield is the starting shield value
-- ALLOY.starting_shield = ALLOY.default.shield_min
CUTIL.add_variable("alloy_starting_shield", 0)

-- Modifiers (for use in Stakes and whatnot
-- ALLOY.modifiers.health_min = 0
-- ALLOY.modifiers.health_max = 0
-- ALLOY.modifiers.starting_health = 0

-- ALLOY.modifiers.shield_min = 0
-- ALLOY.modifiers.shield_max = 0
-- ALLOY.modifiers.starting_shield = 0
-- ALLOY.modifiers.shield_bonus = 0

-- ALLOY.modifiers.explosive_fuse_rounds = 0

-- These are Actions. You use ALLOY.add_modifier to use these
-- ALLOY.actions.health_drain = {}
-- ALLOY.actions.shield_drain = {}
-- ALLOY.actions.dot = {}

-- Debug protocols
ALLOY.debug = {}
ALLOY.debug.unlock_all_stakes = true

to_number = to_number or function(x) return x end

ALLOY.game_end = function(win)
	if win then CUTIL.game_win()
	else CUTIL.game_lose()
	end
end

assert(SMODS.load_file("src/hold.lua"))()
assert(SMODS.load_file("src/lock.lua"))()
assert(SMODS.load_file("src/health.lua"))()
assert(SMODS.load_file("src/stakes.lua"))()
assert(SMODS.load_file("src/stickers.lua"))()

--[[

	Note to self about mechanics to add:
	
	HP -- You start with 100% HP. If you fail a blind, you lose HP proportional to the completion percentage of the blind. When your HP <= 0, you lose.
	
	Hold -- You can hold up to five cards on the side of the screen. You can't play them *directly*, but you can swap those cards for cards currently in your hand. Also, steel/gold cards don't trigger in your held hand.
	
	Last Hand -- If it's possible to play the last played hand with the current hand, play the highest variation of it. (i.e. if the last hand was a High Card, play the highest rank card)
	
	Lock -- Used on an item/Joker. Prevents you from clicking Sell until you unlock it

]]--
