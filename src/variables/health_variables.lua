-- Shield Colours

ALLOY.shield_colour_dull = HEX('164E75')
ALLOY.shield_colour_bright = HEX('4CDFFC')
ALLOY.shield_colour_white = HEX('99EEFF')

-- Health Colours

ALLOY.health_colour_negative = G.C.SUITS.Spades
ALLOY.health_colour_normal = G.C.RED
ALLOY.health_colour_bonus = G.C.MONEY
ALLOY.health_colour_shielded = G.C.CHIPS

ALLOY.health_text_colours_negative = { G.C.SECONDARY_SET.Enhanced }
ALLOY.health_text_colours_normal = { G.C.UI.TEXT_LIGHT }
ALLOY.health_text_colours_shielded = { ALLOY.shield_colour_white }

-- HP

CUTIL.add_variable("alloy_health", 100) -- Current HP
CUTIL.add_variable("alloy_starting_health", 100)
CUTIL.add_variable("alloy_health_min", 0)
CUTIL.add_variable("alloy_health_max", 100)

-- SH

CUTIL.add_variable("alloy_shield", 0)
CUTIL.add_variable("alloy_starting_shield", 0)
CUTIL.add_variable("alloy_shield_min", 0)
CUTIL.add_variable("alloy_shield_max", 25)

CUTIL.add_variable("alloy_shield_bonus", 5)

-- Functions

function ALLOY.min_health()
	local hp_min = get_var("alloy_health_min")
	local sh_min = get_var("alloy_shield_min")
	
	return hp_min + sh_min
end

function ALLOY.total_health()
	local hp = get_var("alloy_health")
	local sh = get_var("alloy_shield")
	
	return hp + sh
end

ALLOY.total_health_value = ALLOY.total_health()

function ALLOY.max_health()
	local hp_max = get_var("alloy_health_max")
	local sh_max = get_var("alloy_shield_max")
	
	return hp_max + sh_max
end

function ALLOY.hp_percentage()
	local hp = get_var("alloy_health")
	
	local hp_min = get_var("alloy_health_min")
	local hp_max = get_var("alloy_health_max")
	
	return CUTIL.inverse_lerp(hp_min, hp_max, hp)
end

function ALLOY.hp_percentage_points()
	local hp = get_var("alloy_health")
	
	local hp_min = get_var("alloy_health_min")
	local usual_hp_max = hp_min + 100
	
	return CUTIL.inverse_lerp(hp_min, usual_hp_max, hp)
end

function ALLOY.sh_percentage()
	local sh = get_var("alloy_shield")
	
	local sh_min = get_var("alloy_shield_min")
	local sh_max = get_var("alloy_shield_max")
	
	return CUTIL.inverse_lerp(sh_min, sh_max, sh)
end

function ALLOY.sh_percentage_points()
	local sh = get_var("alloy_shield")
	
	local sh_min = get_var("alloy_shield_min")
	local usual_sh_max = sh_min + 100
	
	return CUTIL.inverse_lerp(sh_min, usual_sh_max, sh)
end

function ALLOY.health_percentage()
	local hp = get_var("alloy_health")
	local sh = get_var("alloy_shield")
	
	local hp_min = get_var("alloy_health_min")
	local sh_min = get_var("alloy_shield_min")
	
	local hp_max = get_var("alloy_health_max")
	local sh_max = get_var("alloy_shield_max")
	
	return CUTIL.inverse_lerp(hp_min + sh_min, hp_max + sh_max, hp + sh)
end

function ALLOY.health_percentage_points()
	return ALLOY.hp_percentage_points() + ALLOY.sh_percentage_points()
end

function ALLOY.init_health()
	G.alloy_health_area = CardArea(
		G.TILE_W - 600 * G.CARD_W - 200.95,
		-100.1 * G.jokers.T.h,
		G.jokers.T.w,
		G.jokers.T.h,
		{ 
			card_limit = 1,
			type = "joker",
			highlighted_limit = 0 
		}
	)
	ALLOY.health_area = G.alloy_health_area
	
	if #ALLOY.health_area.cards == 0 then
		local health_joker = SMODS.add_card {
			key = "j_alloy_health_object",
			area = ALLOY.health_area,
			skip_materialize = true,
			no_edition = true
		}
	end
end
