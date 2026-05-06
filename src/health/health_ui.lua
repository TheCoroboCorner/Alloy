function ALLOY.update_health_colour()
	local health_text_UI = G.HUD:get_UIE_by_ID('health_UI_count')
	
	ALLOY.total_health_value = ALLOY.total_health()
	
	local usual_min_health = 0
	local usual_max_health = 100
	
	if ALLOY.total_health() < usual_min_health then
		health_text_UI.config.object.colours = ALLOY.health_text_colours_negative
	elseif get_var("alloy_shield") > 0 then
		health_text_UI.config.object.colours = ALLOY.health_text_colours_shielded
	else
		health_text_UI.config.object.colours = ALLOY.health_text_colours_normal
	end
end

G.FUNCS.update_health = function(e)
	local usual_min_health = 0
	local usual_max_health = 100
	
	ALLOY.total_health_value = ALLOY.total_health()
	
	if get_var("alloy_health") > usual_max_health then
		e.config.colour = ALLOY.health_colour_bonus
	elseif get_var("alloy_health") < usual_min_health then
		e.config.colour = ALLOY.health_colour_negative
	elseif get_var("alloy_shield") > 0 then
		e.config.colour = ALLOY.health_colour_shielded
	else
		e.config.colour = ALLOY.health_colour_normal
	end
	
	local hp_percentage = CUTIL.clamp01(ALLOY.hp_percentage())
	
	local width = hp_percentage * e.config.maxw
	
	e.config.minw = width
	e.T.minw = width
	e.T.w = width
end

G.FUNCS.update_shield = function(e)
	local normal_min_shield = get_var("alloy_shield_min")
	local normal_max_shield = get_var("alloy_shield_max")
	
	ALLOY.total_health_value = ALLOY.total_health()
	
	local percent_factor = 100
	
	local shield_colour_pulse_effect = 1 - math.abs(math.sin(G.TIMERS.REAL * 1.8))
	shield_colour_pulse_effect = shield_colour_pulse_effect ^ 2 -- This is just to make the pulse sharper
	
	local shield_colour = CUTIL.vec_lerp(ALLOY.shield_colour_dull, ALLOY.shield_colour_bright, shield_colour_pulse_effect)
	local no_shield_colour = G.C.DYN_UI.BOSS_DARK
	
	local t = ALLOY.sh_percentage()
	e.config.colour = CUTIL.vec_lerp(no_shield_colour, shield_colour, t)
end