function ALLOY.update_health_colour()
	ALLOY.total_health_value = ALLOY.total_health()
	ALLOY.health_val = ALLOY.health_value()
	ALLOY.shield_val = ALLOY.shield_value()

	local health_text_UI = G.HUD:get_UIE_by_ID('health_UI_count')
	
	local usual_min_health = 0
	local usual_max_health = 100
	
	if ALLOY.total_health() < usual_min_health then
		health_text_UI.config.object.colours = ALLOY.health_text_colours_negative
	else
		health_text_UI.config.object.colours = ALLOY.health_text_colours_normal
	end
end
function ALLOY.update_shield_colour()
	ALLOY.total_health_value = ALLOY.total_health()
	ALLOY.health_val = ALLOY.health_value()
	ALLOY.shield_val = ALLOY.shield_value()

	local shield_text_UI = G.HUD:get_UIE_by_ID('shield_UI_count')

	if get_var("alloy_shield") > 0 then
		shield_text_UI.config.object.colours = ALLOY.health_text_colours_shielded
	else
		shield_text_UI.config.object.colours = ALLOY.health_text_colours_normal
	end
end
ALLOY.HP_VARS = {}
ALLOY.HP_VARS.TARGET_HP_VIAL_COLOR = ALLOY.health_colour_normal
ALLOY.HP_VARS.CURRENT_HP_VIAL_COLOR = ALLOY.health_colour_normal
ALLOY.HP_VARS.VIAL_SCALE = 1
ALLOY.HP_VARS.HP_VIAL_BOX_SCALE = 1

G.FUNCS.update_health = function(e)
	local usual_min_health = 0
	local usual_max_health = 100
	
	ALLOY.total_health_value = ALLOY.total_health()
	ALLOY.health_val = ALLOY.health_value()
	ALLOY.shield_val = ALLOY.shield_value()

	if get_var("alloy_health_mode") == "hp" then
		if get_var("alloy_health") > usual_max_health then
			ALLOY.HP_VARS.TARGET_HP_VIAL_COLOR = ALLOY.health_colour_bonus
		elseif get_var("alloy_health") < usual_min_health then
			ALLOY.HP_VARS.TARGET_HP_VIAL_COLOR = ALLOY.health_colour_negative
		else
			ALLOY.HP_VARS.TARGET_HP_VIAL_COLOR = ALLOY.health_colour_normal
		end
	elseif get_var("alloy_health_mode") == "sp" then
		ALLOY.HP_VARS.TARGET_HP_VIAL_COLOR = ALLOY.health_colour_slime
	end
	e.config.colour = ALLOY.HP_VARS.CURRENT_HP_VIAL_COLOR
	local hp_percentage = CUTIL.clamp01(ALLOY.hp_percentage(true, true))
	
	local width = hp_percentage * e.config.maxw * ALLOY.HP_VARS.VIAL_SCALE
	
	e.config.minw = width
	e.T.minw = width
	e.T.w = width
end
G.FUNCS.update_shield_vial = function(e)

	ALLOY.total_health_value = ALLOY.total_health()
	ALLOY.health_val = ALLOY.health_value()
	ALLOY.shield_val = ALLOY.shield_value()

	e.config.colour = ALLOY.health_colour_shielded

	local sh_percentage = CUTIL.clamp01(ALLOY.sh_percentage(true, true))

	local width = sh_percentage * e.config.maxw

	e.config.minw = width
	e.T.minw = width
	e.T.w = width
end
G.FUNCS.alloy_box_func = function(e)
	local h = 1.2
	local w = 1.5
	e.config.minw = w * ALLOY.HP_VARS.HP_VIAL_BOX_SCALE
	e.T.minw = w * ALLOY.HP_VARS.HP_VIAL_BOX_SCALE
	e.T.w = w * ALLOY.HP_VARS.HP_VIAL_BOX_SCALE
	e.config.minh = h * ALLOY.HP_VARS.HP_VIAL_BOX_SCALE
	e.T.minh = h * ALLOY.HP_VARS.HP_VIAL_BOX_SCALE
	e.T.h = h * ALLOY.HP_VARS.HP_VIAL_BOX_SCALE
end
local gupdate_ref = Game.update
function Game:update(dt)
	ALLOY.HP_VARS.CURRENT_HP_VIAL_COLOR = vec_lerp_dt(ALLOY.HP_VARS.CURRENT_HP_VIAL_COLOR, ALLOY.HP_VARS.TARGET_HP_VIAL_COLOR,
	0.1, dt)
	gupdate_ref(self, dt)
end
G.FUNCS.update_shield = function(e)
	
	ALLOY.total_health_value = ALLOY.total_health()
	ALLOY.health_val = ALLOY.health_value()
	ALLOY.shield_val = ALLOY.shield_value()
	
	local shield_colour_pulse_effect = 1 - math.abs(math.sin(G.TIMERS.REAL * 1.8))
	shield_colour_pulse_effect = shield_colour_pulse_effect ^ 2 -- This is just to make the pulse sharper
	
	local shield_colour = CUTIL.vec_lerp(ALLOY.shield_colour_dull, ALLOY.shield_colour_bright, shield_colour_pulse_effect) or
	ALLOY.health_text_colours_normal[1]
	local no_shield_colour = ALLOY.shield_colour_none
	
	local t = ALLOY.sh_percentage()
	e.config.colour = CUTIL.vec_lerp(no_shield_colour, shield_colour, t) or ALLOY.health_text_colours_negative[1]
end

G.FUNCS.update_health_bg = function(e)
	ALLOY.total_health_value = ALLOY.total_health()
	ALLOY.health_val = ALLOY.health_value()
	ALLOY.shield_val = ALLOY.shield_value()

	local health_colour_pulse_effect = 1 - math.abs(math.sin(G.TIMERS.REAL * 1.8 + 1))
	health_colour_pulse_effect = (health_colour_pulse_effect ^ 2) * 0.7 -- This is just to make the pulse sharper
	local health_colour
	local no_health_colour
	
	if get_var("alloy_health") > 100 then
		health_colour = CUTIL.vec_lerp(ALLOY.health_colour_overdrive_dull, ALLOY.health_colour_overdrive_bright,
		health_colour_pulse_effect) or ALLOY.health_text_colours_normal[1]
		no_health_colour = ALLOY.health_colour_overdrive
	else
		health_colour = ALLOY.health_colour_bg
		no_health_colour = ALLOY.health_colour_bg
	end

	local t = math.min((get_var("alloy_health") / 100) - 1, 1)
	e.config.colour = CUTIL.vec_lerp(no_health_colour, health_colour, t) or ALLOY.health_text_colours_negative[1]
end

-- SP Jank

G.FUNCS.alloy_food_joker_sp_click = function(e)
	local card = e.config.ref_table

	ALLOY.consume_food_joker(card, false, true)
end

G.FUNCS.alloy_food_joker_sp_func = function(e)
	local card = e.config.ref_table

	local can_use = card:has_attribute("food")

	-- Removes the button when the card can't be used, otherwise makes it use the previously defined button click
	e.config.button = can_use and 'alloy_food_joker_sp_click' or nil
	-- Changes the color of the button depending on whether it can be used or not
	e.config.colour = can_use and G.C.MONEY or G.C.UI.BACKGROUND_INACTIVE
end
local function create_my_button_ui(card)
	return UIBox {
		definition = {
			n = G.UIT.ROOT,
			config = {
				colour = G.C.CLEAR
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						align = 'cm',
						padding = 0.15,
						r = 0.08,
						hover = true,
						shadow = true,
						colour = G.C.MONEY,
						button = 'alloy_food_joker_sp_click',
						func = 'alloy_food_joker_sp_func',
						ref_table = card,
					},
					nodes = {
						{
							n = G.UIT.R,
							nodes = {
								{
									n = G.UIT.T,
									config = {
										text = localize("alloy_food_button"),
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.4,
									}
								},
								{
									n = G.UIT.B,
									config = {
										w = 0.1,
										h = 0.4
									}
								}
							}
						}
					}
				}
			}
		},
		config = {
			align = 'cl',
			major = card,
			parent = card,
			offset = { x = 0.2, y = 0 }
		}
	}
end
SMODS.DrawStep {
	key = 'food_joker_sp',
	order = -30,
	func = function(card, layer)
		if card.children.alloy_food_joker_sp then
			card.children.alloy_food_joker_sp:draw()
		end
	end
}

SMODS.draw_ignore_keys.alloy_food_joker_sp = true

local highlight_ref = Card.highlight
function Card.highlight(self, is_highlighted)
	if is_highlighted and self.ability.set == "Joker" and self.area == G.jokers and self:has_attribute("food") and get_var("alloy_health_mode") == "sp" --[[and get_var("alloy_health")< get_var("alloy_health_max")]] then
		self.children.alloy_food_joker_sp = create_my_button_ui(self)
	elseif self.children.alloy_food_joker_sp then
		self.children.alloy_food_joker_sp:remove()
		self.children.alloy_food_joker_sp = nil
	end

	return highlight_ref(self, is_highlighted)
end

function G.FUNCS.update_health_text(e)
	e.config.text = get_var("alloy_health_vial_label")
	e.UIBox:recalculate()
end
function SPify()
	CUTIL.set_variable("alloy_health_mode", "sp")
	add_aevent(AEvent({
		extra = {
			original = get_var("alloy_health_vial_label"),
			scaleEaseFunc = easeSplinesLib.createEase(1, 0.5, nil, {preset = "eioc", param = 2}),
			scaleEaseFunc2 = easeSplinesLib.createEase(1, 1.15, nil, {preset = "eioc", param = 2})
		},
		easeFunc = function (t, s)
			local cur_index = math.floor((1-t) * #s.extra.original + 0.5)
			if cur_index > 0 then
				CUTIL.set_variable("alloy_health_vial_label", string.sub(s.extra.original, 1, cur_index))
			else
				CUTIL.set_variable("alloy_health_vial_label", "")
			end
			ALLOY.HP_VARS.VIAL_SCALE = s.extra.scaleEaseFunc(t)
			ALLOY.HP_VARS.HP_VIAL_BOX_SCALE = s.extra.scaleEaseFunc2(t)
		end,
		duration = 1
	}), "sp_jank")

	add_aevent(AEvent ({
		extra = {
			goal = localize("alloy_sp_label"),
			scaleEaseFunc = easeSplinesLib.createEase(0.5, 1, nil, { preset = "eioc", param = 2 }),
			scaleEaseFunc2 = easeSplinesLib.createEase(1.15, 1, nil, {preset = "eioc", param = 2})
		},
		easeFunc = function(t, s)
			local cur_index = math.floor(t * #s.extra.goal + 0.5)
			if cur_index > 0 then
				CUTIL.set_variable("alloy_health_vial_label", string.sub(s.extra.goal, 1, cur_index))
			else
				CUTIL.set_variable("alloy_health_vial_label", "")
			end
			ALLOY.HP_VARS.VIAL_SCALE = s.extra.scaleEaseFunc(t)
			ALLOY.HP_VARS.HP_VIAL_BOX_SCALE = s.extra.scaleEaseFunc2(t)
		end,
		duration = 1
	}), "sp_jank")
end

function HPify()
	CUTIL.set_variable("alloy_health_mode", "hp")
	add_aevent(AEvent ({
		extra = {
			original = get_var("alloy_health_vial_label"),
			scaleEaseFunc = easeSplinesLib.createEase(1, 0.5, nil, { preset = "eioc", param = 2 }),
			scaleEaseFunc2 = easeSplinesLib.createEase(1, 1.15, nil, { preset = "eioc", param = 2 })
		},
		easeFunc = function(t, s)
			local cur_index = math.floor((1 - t) * #s.extra.original + 0.5)
			if cur_index > 0 then
				CUTIL.set_variable("alloy_health_vial_label", string.sub(s.extra.original, 1, cur_index))
			else
				CUTIL.set_variable("alloy_health_vial_label", "")
			end
			ALLOY.HP_VARS.VIAL_SCALE = s.extra.scaleEaseFunc(t)
			ALLOY.HP_VARS.HP_VIAL_BOX_SCALE = s.extra.scaleEaseFunc2(t)
		end,
		duration = 1
	}), "sp_jank")

	add_aevent(AEvent({
		extra = {
			goal = localize("alloy_hp_label"),
			scaleEaseFunc = easeSplinesLib.createEase(0.5, 1, nil, { preset = "eioc", param = 2 }),
			scaleEaseFunc2 = easeSplinesLib.createEase(1.15, 1, nil, { preset = "eioc", param = 2 })
		},
		easeFunc = function(t, s)
			local cur_index = math.floor(t * #s.extra.goal + 0.5)
			if cur_index > 0 then
				CUTIL.set_variable("alloy_health_vial_label", string.sub(s.extra.goal, 1, cur_index))
			else
				CUTIL.set_variable("alloy_health_vial_label", "")
			end
			ALLOY.HP_VARS.VIAL_SCALE = s.extra.scaleEaseFunc(t)
			ALLOY.HP_VARS.HP_VIAL_BOX_SCALE = s.extra.scaleEaseFunc2(t)
		end,
		duration = 1
	}), "sp_jank")
end

function get_hp_text_color()
	return get_var("alloy_health_mode") == "sp" and G.C.CHIPS or
	(get_var("alloy_health_mode") == "hp" and G.C.GREEN or G.C.BLACK)
end

function get_hp_text()
	return get_var("alloy_health_mode") == "sp" and localize("alloy_sp") or
		(get_var("alloy_health_mode") == "hp" and localize("alloy_hp") or "Error!")
end
