function ALLOY.update_health_colour()
	ALLOY.total_health_value = ALLOY.total_health()

	local health_text_UI = G.HUD:get_UIE_by_ID('health_UI_count')
	
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

	if get_var("alloy_health_mode") == "hp" then
		if get_var("alloy_health") > usual_max_health then
			e.config.colour = ALLOY.health_colour_bonus
		elseif get_var("alloy_health") < usual_min_health then
			e.config.colour = ALLOY.health_colour_negative
		elseif get_var("alloy_shield") > 0 then
			e.config.colour = ALLOY.health_colour_shielded
		else
			e.config.colour = ALLOY.health_colour_normal
		end
	elseif get_var("alloy_health_mode") == "sp" then
		e.config.colour = ALLOY.health_colour_slime
	end
	
	local hp_percentage = CUTIL.clamp01(ALLOY.hp_percentage(true, true))
	
	local width = hp_percentage * e.config.maxw
	
	e.config.minw = width
	e.T.minw = width
	e.T.w = width
end

G.FUNCS.update_shield = function(e)
	local normal_min_shield = get_var("alloy_shield_min")
	local normal_max_shield = get_var("alloy_shield_max")
	
	ALLOY.total_health_value = ALLOY.total_health()
	
	local shield_colour_pulse_effect = 1 - math.abs(math.sin(G.TIMERS.REAL * 1.8))
	shield_colour_pulse_effect = shield_colour_pulse_effect ^ 2 -- This is just to make the pulse sharper
	
	local shield_colour = CUTIL.vec_lerp(ALLOY.shield_colour_dull, ALLOY.shield_colour_bright, shield_colour_pulse_effect) or ALLOY.health_text_colours_normal[1]
	local no_shield_colour = G.C.DYN_UI.BOSS_DARK
	
	local t = ALLOY.sh_percentage()
	e.config.colour = CUTIL.vec_lerp(no_shield_colour, shield_colour, t) or ALLOY.health_text_colours_negative[1]
end

-- SP Jank

G.FUNCS.alloy_food_joker_sp_click = function(e)
	local card = e.config.ref_table

	ALLOY.consume_food_joker(card)
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
	if is_highlighted and self.ability.set == "Joker" and self.area == G.jokers and self:has_attribute("food") and get_var("alloy_health_mode") == "sp" and get_var("alloy_health")< get_var("alloy_health_max") then
		self.children.alloy_food_joker_sp = create_my_button_ui(self)
	elseif self.children.alloy_food_joker_sp then
		self.children.alloy_food_joker_sp:remove()
		self.children.alloy_food_joker_sp = nil
	end

	return highlight_ref(self, is_highlighted)
end

function G.FUNCS.update_health_text(e)
	e.config.text = get_var("alloy_health_mode") == "sp" and localize("alloy_sp_label") or
		(get_var("alloy_health_mode") == "hp" and localize("alloy_hp_label") or "Error!")
	e.UIBox:recalculate()
end
function SPify()
	CUTIL.set_variable("alloy_health_mode", "sp")
end

function HPify()
	CUTIL.set_variable("alloy_health_mode", "hp")
end

function get_hp_text_color()
	return get_var("alloy_health_mode") == "sp" and G.C.CHIPS or
	(get_var("alloy_health_mode") == "hp" and G.C.GREEN or G.C.BLACK)
end

function get_hp_text()
	return get_var("alloy_health_mode") == "sp" and localize("alloy_sp") or
		(get_var("alloy_health_mode") == "hp" and localize("alloy_hp") or "Error!")
end
