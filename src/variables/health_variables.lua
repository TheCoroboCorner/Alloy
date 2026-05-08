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

function ALLOY.hp_percentage(absolute_min, absolute_max)
	local hp = get_var("alloy_health")
	
	local hp_min = absolute_min and get_var("alloy_health_min") or 0
	local hp_max = absolute_max and get_var("alloy_health_max") or 100
	
	return CUTIL.inverse_lerp(hp_min, hp_max, hp)
end

function ALLOY.hp_absolute()
	return get_var("alloy_health") - get_var("alloy_health_min")
end

function ALLOY.sh_percentage(absolute_min, absolute_max)
	local sh = get_var("alloy_shield")
	
	local sh_min = absolute_min and get_var("alloy_shield_min") or 0
	local sh_max = absolute_max and get_var("alloy_shield_max") or 100
	
	return CUTIL.inverse_lerp(sh_min, sh_max, sh)
end

function ALLOY.sh_absolute()
	return get_var("alloy_shield") - get_var("alloy_shield_min")
end

function ALLOY.health_percentage(absolute_min_hp, absolute_max_hp, absolute_min_sh, absolute_max_sh)
	local hp = get_var("alloy_health")
	local sh = get_var("alloy_shield")
	
	local hp_min = absolute_min_hp and get_var("alloy_health_min") or 0
	local sh_min = absolute_min_sh and get_var("alloy_shield_min") or 0
	
	local hp_max = absolute_max_hp and get_var("alloy_health_max") or 100
	local sh_max = absolute_max_sh and get_var("alloy_shield_max") or 100
	
	return CUTIL.inverse_lerp(hp_min + sh_min, hp_max + sh_max, hp + sh)
end

function ALLOY.health_absolute()
	return ALLOY.hp_absolute() + ALLOY.sh_absolute()
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