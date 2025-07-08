ALLOY = SMODS.current_mod

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