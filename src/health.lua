local function clamp(a, b, t)
	if t < a then
		return a
	elseif t > b then
		return b
	else return t end
end

local function colour_lerp(a, b, t)
	local out = { 0, 0, 0, 0 }
	
	-- RGBA values have 4 indexes
	for i = 1, 4 do
		out[i] = a[i] * (1-t) + b[i] * t
	end
	
	return out
end

local function inverse_lerp(a, b, val)
	return (val - a) / (b - a)
end

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
		
		local percent_decimal_conversion = 100
		
		local normal_min_health = 0
		G.GAME.health_min = G.GAME.health_min or normal_min_health
		
		local health_as_percentage = G.GAME.health / percent_decimal_conversion
		local shield_as_percentage = G.GAME.shield / percent_decimal_conversion
		local blind_completion_as_percentage = to_number(current_score / target_score)
		local blind_remaining_as_percentage = 1 - blind_completion_as_percentage
		
		if context.end_of_round and not context.game_over and context.main_eval then 
			if blind_completion_as_percentage >= 1 and G.GAME.current_round.hands_played == 1 then
				local shield_bonus = 5
				ALLOY.ease_shield(shield_bonus)
			end
		end
		if context.end_of_round and context.game_over and context.main_eval then
			if health_as_percentage + G.GAME.health_min + shield_as_percentage - (G.GAME.health_min or 0) >= blind_remaining_as_percentage then
				local damage = -math.ceil(blind_remaining_as_percentage * percent_decimal_conversion)
				
				local used_shield = false
				if G.GAME.shield > G.GAME.shield_min then
					used_shield = true
					local delta_shield = clamp(G.GAME.shield_min, G.GAME.shield_max, G.GAME.shield + damage) - G.GAME.shield
					
					ALLOY.ease_shield(damage)
					damage = damage - delta_shield
				end
				
				if damage < 0 then
					ALLOY.ease_health(damage, used_shield)
				end
				
				SMODS.calculate_context({ survived_death = true })
				
				return {
					message = localize('k_saved_ex'),
					saved = 'ph_health',
					colour = G.C.RED
				}
			else
				G.GAME.health = 0
				
				SMODS.calculate_context({ survived_death = false })
			end
		end
	end
}

local function update_health_colour()
	local health_text_UI = G.HUD:get_UIE_by_ID('health_UI_count')
	
	local health_negative = { G.C.SECONDARY_SET.Enhanced }
	local health_normal = { G.C.UI.TEXT_LIGHT }
	local health_shielded = { ALLOY.shield_colour_white }
	
	local normal_min_health = 0
	local normal_max_health = 100
	G.GAME.health_max = G.GAME.health_max or normal_max_health
	
	ALLOY.total_health = G.GAME.health + G.GAME.shield
	if ALLOY.total_health < normal_min_health then
		health_text_UI.config.object.colours = health_negative
	elseif ALLOY.total_health > G.GAME.health_max then
		health_text_UI.config.object.colours = health_shielded
	else
		health_text_UI.config.object.colours = health_normal
	end
end

ALLOY.ease_health = function(delta_health, silent)
	local health_text_UI = G.HUD:get_UIE_by_ID('health_UI_count')
	
	delta_health = delta_health or 0
	silent = silent or false
	
	local normal_min_health = 0
	local normal_max_health = 100
	G.GAME.health_min = G.GAME.health_min or normal_min_health
	G.GAME.health_max = G.GAME.health_max or normal_max_health
	
	delta_health = clamp(G.GAME.health_min, G.GAME.health_max, G.GAME.health + delta_health) - G.GAME.health

	G.GAME.health = G.GAME.health + delta_health
	update_health_colour()
	
	SMODS.calculate_context({ health_changed = delta_health })

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

ALLOY.ease_shield = function(delta_shield, silent)
	local shield_UI = G.HUD:get_UIE_by_ID('shield_UI_bar')
	
	local delta_shield = delta_shield or 0
	silent = silent or false

	local normal_min_shield = 0
	local normal_max_shield = 50
	G.GAME.shield_min = G.GAME.shield_min or normal_min_shield
	G.GAME.shield_max = G.GAME.shield_max or normal_max_shield
	
	delta_shield = delta_shield or 0
	delta_shield = clamp(G.GAME.shield_min, G.GAME.shield_max, G.GAME.shield + delta_shield) - G.GAME.shield
	
	if delta_shield == 0 then return end
	
	G.GAME.shield = G.GAME.shield + delta_shield
	update_health_colour()
	
	SMODS.calculate_context({ shield_changed = delta_shield })
	
	if not silent then
		local bonus = HEX('4CDFFC')
		local damage = G.C.SUITS.Spades
		
		local col = (delta_shield > 0) and bonus or damage
		local text = (delta_shield > 0) and 'BONUS!' or ''
		attention_text({
			text = text,
			scale = 0.8,
			hold = 0.7,
			cover = shield_UI,
			cover_colour = col,
			align = 'cm'
		})
		
		play_sound('chips2')
	end
end

G.FUNCS.update_health = function(e)
	if not G.GAME.health then return end
	
	local normal_min_health = 0
	local normal_max_health = 100
	G.GAME.health_min = G.GAME.health_min or normal_min_health
	G.GAME.health_max = G.GAME.health_max or normal_max_health
	
	local percent_factor = 100
	
	local health_negative = G.C.SUITS.Spades
	local health_normal = G.C.RED
	local health_bonus = G.C.MONEY
	local health_shielded = G.C.CHIPS
	
	if G.GAME.health > normal_max_health then
		e.config.colour = health_bonus
	elseif G.GAME.health < normal_min_health then
		e.config.colour = health_negative
	elseif ALLOY.total_health > G.GAME.health_max then
		e.config.colour = health_shielded
	else
		e.config.colour = health_normal
	end
	
	local clamped_health = (G.GAME.health >= normal_min_health) and clamp(normal_min_health, normal_max_health, G.GAME.health) 
						    or clamp(G.GAME.health_min, normal_min_health, G.GAME.health) - G.GAME.health_min
	
	local width = clamped_health / percent_factor * e.config.maxw
	
	e.config.minw = width
	e.T.minw = width
	e.T.w = width
end

G.FUNCS.update_shield = function(e)
	if not G.GAME.shield then return end
	
	local normal_min_shield = 0
	local normal_max_shield = 25
	G.GAME.shield_min = G.GAME.shield_min or normal_min_shield
	G.GAME.shield_max = G.GAME.shield_max or normal_max_shield
	
	local percent_factor = 100
	
	local shield_colour_pulse_effect = 1 - math.abs(math.sin(G.TIMERS.REAL * 1.8))
	shield_colour_pulse_effect = shield_colour_pulse_effect ^ 2 -- This is just to make the pulse sharper
	
	local shield_colour = colour_lerp(ALLOY.shield_colour_dull, ALLOY.shield_colour_bright, shield_colour_pulse_effect)
	local no_shield_colour = G.C.DYN_UI.BOSS_DARK
	
	local t = inverse_lerp(G.GAME.shield_min, G.GAME.shield_max, G.GAME.shield)
	e.config.colour = colour_lerp(no_shield_colour, shield_colour, t)
end

local calculate_context = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
	if ALLOY.health_area and not ALLOY.health_area.cards then return {} end
	
	local ret = calculate_context(context, return_table)
	return ret
end