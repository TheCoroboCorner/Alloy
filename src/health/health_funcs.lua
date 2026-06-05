ALLOY.ease_health = function(delta_health, silent, ignore_limits)
	if get_var("alloy_health_mode") == "hp" then
		debug_log("Easing health")

		local health_text_UI = G.HUD:get_UIE_by_ID('health_UI_count')

		delta_health = delta_health or 0
		silent = silent or false

		local health = get_var("alloy_health")
		local min_health = get_var("alloy_health_min")
		local max_health = get_var("alloy_health_max")

		local legal_health = ignore_limits and (health + delta_health) or
		CUTIL.clamp(health + delta_health, math.min(health, min_health), math.max(health, max_health))
		local legal_delta = legal_health - health

		debug_log("health + delta_health: " .. health + delta_health)
		debug_log("min health: " .. min_health)
		debug_log("max delta: " .. max_health)
		debug_log("legal health: " .. legal_health)
		debug_log("legal delta: " .. legal_delta)

		if legal_delta == 0 then return end
		CUTIL.set_variable("alloy_health", legal_health)
		if not silent then
			add_aevent(AEvent({
				extra = {
					goal = legal_health,
					scaleEaseFunc = easeSplinesLib.createEase(health, legal_health, nil, { preset = "eioc", param = 2 }),
				},
				easeFunc = function(t, s)
					CUTIL.set_variable("alloy_health_display", math.floor(s.extra.scaleEaseFunc(t) + 0.5))
					ALLOY.update_health_colour()
				end,
				endFunc = function(s)
					CUTIL.set_variable("alloy_health_display", legal_health)
					ALLOY.update_health_colour()
				end,
				duration = 1.5
			}), "healthMod")
		end
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
	elseif get_var("alloy_health_mode") == "sp" then
		if delta_health < 0 then
			debug_log("Easing health")

			local health_text_UI = G.HUD:get_UIE_by_ID('health_UI_count')

			delta_health = delta_health or 0
			silent = silent or false

			local health = get_var("alloy_health")
			local min_health = get_var("alloy_health_min")
			local max_health = get_var("alloy_health_max")

			local legal_health = ignore_limits and (health + delta_health) or
				CUTIL.clamp(health + delta_health, math.min(health, min_health), math.max(health, max_health))
			local legal_delta = legal_health - health

			debug_log("health + delta_health: " .. health + delta_health)
			debug_log("min health: " .. min_health)
			debug_log("max delta: " .. max_health)
			debug_log("legal health: " .. legal_health)
			debug_log("legal delta: " .. legal_delta)

			if legal_delta == 0 then return end
			CUTIL.set_variable("alloy_health", legal_health)
			if not silent then
				add_aevent(AEvent({
					extra = {
						goal = legal_health,
						scaleEaseFunc = easeSplinesLib.createEase(health, legal_health, nil, { preset = "eioc", param = 2 }),
					},
					easeFunc = function(t, s)
						CUTIL.set_variable("alloy_health_display", math.floor(s.extra.scaleEaseFunc(t) + 0.5))
						ALLOY.update_health_colour()
					end,
					endFunc = function(s)
						CUTIL.set_variable("alloy_health_display", legal_health)
						ALLOY.update_health_colour()
					end,
					duration = 1.5
				}), "healthMod")
			end
			ALLOY.update_health_colour()

			SMODS.calculate_context({ health_changed = legal_delta })

			if not silent then
				attention_text({
					text = legal_delta and tostring(legal_delta) or "Error",
					scale = 0.8,
					hold = 0.7,
					cover = health_text_UI.parent,
					cover_colour = G.C.RED,
					align = 'cm'
				})

				play_sound('chips2')
			end
		end
	end
end

ALLOY.ease_shield = function(delta_shield, silent, ignore_limits)
	debug_log("Easing shields")

	local shield_UI = G.HUD:get_UIE_by_ID('shield_UI_bar')
	
	delta_shield = delta_shield or 0
	silent = silent or false

	local shield = get_var("alloy_shield")
	local min_shield = get_var("alloy_shield_min")
	local max_shield = get_var("alloy_shield_max")
	
	local legal_shield = ignore_limits and (shield + delta_shield) or CUTIL.clamp(shield + delta_shield, math.min(shield, min_shield), math.max(shield, max_shield))
	local legal_delta = legal_shield - shield
	
	debug_log("legal shields: " .. legal_shield)
	debug_log("legal delta: " .. legal_delta)
	
	if legal_delta == 0 then return end
	CUTIL.set_variable("alloy_shield", legal_shield)
	if not silent then
		add_aevent(AEvent({
			extra = {
				scaleEaseFunc = easeSplinesLib.createEase(shield, legal_shield, nil, { preset = "eioc", param = 2 }),
			},
			easeFunc = function(t, s)
				CUTIL.set_variable("alloy_shield_display", math.floor(s.extra.scaleEaseFunc(t) + 0.5))
				ALLOY.update_shield_colour()
			end,
			endFunc = function(s)
				CUTIL.set_variable("alloy_shield_display", legal_shield)
				ALLOY.update_shield_colour()
			end,
			duration = 1.5
		}), "shieldMod")
	end
	ALLOY.update_shield_colour()
	
	SMODS.calculate_context({ shield_changed = legal_delta or 0 })
	
	if not silent then
		local bonus = HEX('4CDFFC')
		local damage = G.C.SUITS.Spades
		local text = '+'
		if legal_delta < 0 then
			text = ''
		end

		local col = ((legal_delta or 0) > 0) and bonus or damage
		attention_text({
			text = text .. legal_delta and tostring(legal_delta) or "Error",
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
		
		if G.heroes.cards[1] then
			local hero = G.heroes.cards[1]
			
			hero.ability.extra.hp = math.min(hero.ability.extra.hp + hero.ability.extra.defense + delta_damage, hero.ability.extra.hp)
			delta_damage = hero.ability.extra.hp
			if hero.ability.extra.hp >= 0 then
				if hero.ability.extra.hp == 0 then
					hero.ability.extra.hp = math.max(hero.ability.extra.hp, 0)
					SMODS.destroy_cards(hero, true, true)
				end
				return
			end
			
			hero.ability.extra.hp = math.max(hero.ability.extra.hp, 0)
			SMODS.destroy_cards(hero, true, true)
		end

		local Jolynes = SMODS.find_card("c_alloy_jolyne")
		if #Jolynes > 0 then
			local k
			local maxSeen = 0
			for kk, card in ipairs(Jolynes) do
				if card.sell_cost > maxSeen then
					k = kk
					maxSeen = card.sell_cost
				end
			end
			local MaxCostCard = Jolynes[k]
			ALLOY.ease_shield(maxSeen)
			card_eval_status_text(MaxCostCard, 'extra', nil, nil, nil,
				{ message = localize('k_jolyne_saved'), colour = G.C.ORANGE })
			delay(0.1)
			SMODS.destroy_cards(MaxCostCard)
		end

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

ALLOY.consume_food_joker = function(card, silent, ignore_limits)
	local function get_dh_by_joker(j)
		if j:is_rarity(1) then -- common
			return 10
		elseif j:is_rarity(2) then -- uncommon
			return 20
		elseif j:is_rarity(3) then -- rare
			return 40
		elseif j:is_rarity(4) then -- legendary
			return 80
		else -- modded
			return 30
		end
	end
	local delta_health = get_dh_by_joker(card)
	if get_var("alloy_health_mode") == "sp" then
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0,
			func = function()
				card:start_dissolve(nil, nil, 0.9)
				return true
			end,
		}))
		debug_log("Easing health")

		local health_text_UI = G.HUD:get_UIE_by_ID('health_UI_count')

		delta_health = delta_health or 0
		silent = silent or false

		local health = get_var("alloy_health")
		local min_health = get_var("alloy_health_min")
		local max_health = get_var("alloy_health_max")

		local legal_health = ignore_limits and (health + delta_health) or
			CUTIL.clamp(health + delta_health, math.min(health, min_health), math.max(health, max_health))
		local legal_delta = legal_health - health

		debug_log("health + delta_health: " .. health + delta_health)
		debug_log("min health: " .. min_health)
		debug_log("max delta: " .. max_health)
		debug_log("legal health: " .. legal_health)
		debug_log("legal delta: " .. legal_delta)

		if legal_delta == 0 then return end
		CUTIL.set_variable("alloy_health", legal_health)
		if not silent then
			add_aevent(AEvent({
				extra = {
					goal = legal_health,
					scaleEaseFunc = easeSplinesLib.createEase(health, legal_health, nil, { preset = "eioc", param = 2 }),
				},
				easeFunc = function(t, s)
					CUTIL.set_variable("alloy_health_display", math.floor(s.extra.scaleEaseFunc(t) + 0.5))
					ALLOY.update_health_colour()
				end,
				endFunc = function(s)
					CUTIL.set_variable("alloy_health_display", legal_health)
					ALLOY.update_health_colour()
				end,
				duration = 1.5
			}), "healthMod")
		end
		ALLOY.update_health_colour()

		SMODS.calculate_context({ health_changed = legal_delta })

		if not silent then
			local text = '+'
			local col = G.C.GREEN

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
end

local function check_if_dead()
	if ALLOY.min_health() >= ALLOY.total_health() and not get_var("already_killed") then
		CUTIL.set_variable("already_killed", true)
		CUTIL.game_lose()
	end
end

ALLOY.CALCS.health = function(self, context)
	if not G.GAME.blind then return nil end
	local current_score = G.GAME.chips
	local target_score = G.GAME.blind.chips

	local blind_completion_as_percentage = to_number(current_score / target_score)
	local blind_remaining_as_percentage = 1 - blind_completion_as_percentage

	if context.end_of_round and not context.game_over and context.main_eval then
		if blind_completion_as_percentage >= 1 and G.GAME.current_round.hands_played == 1 then
			local shield_bonus = get_var("alloy_shield_bonus")
			ALLOY.ease_shield(shield_bonus, false, true)

			SMODS.calculate_context({ shield_boost = true })
		end
	end

	if context.end_of_round and context.game_over and context.main_eval then
		if (ALLOY.total_health() - ALLOY.min_health()) / 100 > blind_remaining_as_percentage then
			local damage = -math.ceil(blind_remaining_as_percentage * 100)

			ALLOY.ease_damage(damage, false, true)

			SMODS.calculate_context({ survived_death = true })
			
			return {
				saved = 'ph_health',
				colour = G.C.RED
			}
		else
			SMODS.calculate_context({ survived_death = false })
		end
	end
	check_if_dead()
end