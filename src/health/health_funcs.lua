ALLOY.ease_health = function(delta_health, silent, ignore_limits)
	debug_log("Easing health")
	
	local health_text_UI = G.HUD:get_UIE_by_ID('health_UI_count')
	
	delta_health = delta_health or 0
	silent = silent or false
	
	local health = get_var("alloy_health")
	local min_health = get_var("alloy_health_min")
	local max_health = get_var("alloy_health_max")
	
	local legal_health = ignore_limits and (health + delta_health) or CUTIL.clamp(health + delta_health, math.min(health, min_health), math.max(health, max_health))
	local legal_delta = legal_health - health
	
	debug_log("health + delta_health: " .. health + delta_health)
	debug_log("min health: " .. min_health)
	debug_log("max delta: " .. max_health)
	debug_log("legal health: " .. legal_health)
	debug_log("legal delta: " .. legal_delta)

	if legal_delta == 0 then return end

	CUTIL.set_variable("alloy_health", legal_health)
	ALLOY.update_health_colour()
	
	SMODS.calculate_context({ health_changed = legal_delta })

	if not silent then
		local text = '+'
		local col = G.C.GREEN
		if delta_health < 0 then
			text = ''
			col = G.C.RED
		end
		
		attention_text({
			text = text .. legal_delta and tostring(legal_delta) or "Error",
			scale = 0.8,
			hold = 0.7,
			cover = health_text_UI.parent,
			cover_colour = col,
			align = 'cm'
		})
	
		play_sound('chips2')
	end
end

ALLOY.ease_shield = function(delta_shield, silent, ignore_limits)
	debug_log("Easing shields")

	local shield_UI = G.HUD:get_UIE_by_ID('shield_UI_bar')
	
	local delta_shield = delta_shield or 0
	silent = silent or false

	local shield = get_var("alloy_shield")
	local min_shield = get_var("alloy_shield_min")
	local max_shield = get_var("alloy_shield_max")
	
	local legal_shield = ignore_limits and (shield + delta_shield) or CUTIL.clamp(shield + delta_shield, math.min(shield, min_shield), math.max(shield, max_shield))
	local legal_delta = legal_shield - shield
	
	debug_log("legal shields: " .. legal_shield)
	debug_log("legal delta: " .. legal_delta)
	
	if legal_delta == 0 then return end
	
	CUTIL.set_variable("alloy_shield", legal_shield or 0)
	ALLOY.update_health_colour()
	
	SMODS.calculate_context({ shield_changed = legal_delta or 0 })
	
	if not silent then
		local bonus = HEX('4CDFFC')
		local damage = G.C.SUITS.Spades
		
		local col = ((legal_delta or 0) > 0) and bonus or damage
		local text = legal_delta and ((legal_delta > 0) and 'BONUS!' or '') or "Error"
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

ALLOY.ease_damage = function(delta_damage, silent, ignore_limits)
	debug_log("Easing damage")

	local hp = get_var("alloy_health")
	local sh = get_var("alloy_shield")
	
	local hp_min = get_var("alloy_health_min")
	local sh_min = get_var("alloy_shield_min")
	
	local hp_max = get_var("alloy_health_max")
	local sh_max = get_var("alloy_shield_max")
	
	if not delta_damage or delta_damage == 0 then 
		debug_log("zero delta: " .. delta_damage)
		
		return
	elseif delta_damage < 0 then -- Damage
		debug_log("negative delta: " .. delta_damage)
		
		local shield_remaining = sh + delta_damage
		
		local health_remaining = hp
		local shield_underflow = false
		if shield_remaining <= sh_min then
			health_remaining = health_remaining + shield_remaining
			shield_remaining = sh_min
			shield_underflow = true
		end
		
		if shield_remaining ~= sh then
			local delta_shield = shield_remaining - sh
			ALLOY.ease_shield(delta_shield, silent)
		end
		
		debug_log("delta shield: " .. shield_remaining - sh)
		
		local delta_health = health_remaining - hp
		ALLOY.ease_health(delta_health, silent or not shield_underflow, ignore_limits)
		
		debug_log("delta health: " .. delta_health)
	else
		debug_log("positive delta: " .. delta_damage)
		
		local health_until_full = hp_max - hp
		
		if health_until_full >= delta_damage then
			ALLOY.ease_health(delta_damage, silent)
			return
		end
		
		local delta_health = health_until_full
		local delta_shield = delta_damage - delta_health
		
		ALLOY.ease_health(delta_health, true)
		ALLOY.ease_shield(delta_shield, silent, ignore_limits)
		
		debug_log("delta shield: " .. delta_shield)
		debug_log("delta health: " .. delta_health)
	end
end