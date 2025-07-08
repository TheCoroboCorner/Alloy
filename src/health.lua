SMODS.Joker {
	key = "health_object",
	order = 0,
	rarity = 1,
	cost = 0,
	
	blueprint_compat = false,
	perishable_compat = false,
	no_collection = true,
	no_doe = true,
	
	in_pool = function(self, args)
		return false
	end,
	
	loc_vars = function(self, info_queue, card) return {} end,
	
	calculate = function(self, card, context)
		local current_score = G.GAME.chips
		local target_score = G.GAME.blind.chips
		
		local health_as_percentage = G.GAME.health / 100
		local blind_completion_as_percentage = to_number(current_score / target_score)
		local blind_remaining_as_percentage = 1 - blind_completion_as_percentage
	
		if context.end_of_round and context.game_over and context.main_eval then
			if health_as_percentage >= blind_remaining_as_percentage then
				ALLOY.ease_health(-math.ceil(100 * blind_remaining_as_percentage))
				
				return {
					message = localize('k_saved_ex'),
					saved = 'ph_health',
					colour = G.C.RED
				}
			else
				G.GAME.health = 0
			end
		end
	end
}

ALLOY.ease_health = function(delta_health, silent)
	local health_text_UI = G.HUD:get_UIE_by_ID('health_UI_count')
	
	delta_health = delta_health or 0
	silent = silent or false

	G.GAME.health = G.GAME.health + delta_health

	if not silent then
		local text = '+'
		local col = G.C.GREEN
		if delta_health < 0 then
			text = ''
			col = G.C.RED
		end
		
		attention_text({
			text = text .. tostring(delta_health),
			scale = 0.8,
			hold = 0.7,
			cover = health_text_UI.parent,
			cover_colour = col,
			align = 'cm'
		})
	
		play_sound('chips2')
	end
end

G.FUNCS.update_health = function(e)
	local width = ((G.GAME.health or 100) / 100) * e.config.maxw
	
	e.config.minw = width
	e.T.minw = width
	e.T.w = width
end

local calculate_context = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
	if ALLOY.health_area and not ALLOY.health_area.cards then return {} end
	
	local ret = calculate_context(context, return_table)
	return ret
end