ALLOY = SMODS.current_mod

ALLOY.total_health = 100

ALLOY.shield_colour_dull = HEX('164E75')
ALLOY.shield_colour_bright = HEX('4CDFFC')
ALLOY.shield_colour_white = HEX('99EEFF')

-- default_health_min is the lowest value HP can be before game over triggers
ALLOY.default_health_min = 0
-- default_health_max is the highest value HP can be
ALLOY.default_health_max = 100
-- starting_health is the starting HP value
ALLOY.starting_health = ALLOY.default_health_max

-- default_shield_min is the lowest value shield can be before depleting HP
ALLOY.default_shield_min = 0
-- default_shield_max is the highest value shield can be
ALLOY.default_shield_max = 25
-- starting_shield is the starting shield value
ALLOY.starting_shield = ALLOY.default_shield_min

to_number = to_number or function(x) return x end

assert(SMODS.load_file("src/hold.lua"))()
assert(SMODS.load_file("src/lock.lua"))()
assert(SMODS.load_file("src/health.lua"))()

--[[

	Note to self about mechanics to add:
	
	HP -- You start with 100% HP. If you fail a blind, you lose HP proportional to the completion percentage of the blind. When your HP <= 0, you lose.
	
	Hold -- You can hold up to five cards on the side of the screen. You can't play them *directly*, but you can swap those cards for cards currently in your hand. Also, steel/gold cards don't trigger in your held hand.
	
	Last Hand -- If it's possible to play the last played hand with the current hand, play the highest variation of it. (i.e. if the last hand was a High Card, play the highest rank card)
	
	Lock -- Used on an item/Joker. Prevents you from clicking Sell until you unlock it

]]--