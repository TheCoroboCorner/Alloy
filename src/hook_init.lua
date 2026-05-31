local calculate_context = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
	if ALLOY.health_area and not ALLOY.health_area.cards then return {} end
	
	return calculate_context(context, return_table)
end

local game_start_run = Game.start_run
function Game:start_run(args)
	local ret = game_start_run(self, args)
	
	ALLOY.init_hold()
	
	return ret
end

local can_sell = Card.can_sell_card
function Card.can_sell_card(self, context)
	local locked = self.ability.locked or false
	
	return can_sell(self, context) and not locked
end