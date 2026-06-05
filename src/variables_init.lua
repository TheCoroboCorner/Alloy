assert(SMODS.load_file("src/variables/health_variables.lua"))()
assert(SMODS.load_file("src/variables/sticker_variables.lua"))()
assert(SMODS.load_file("src/variables/debug_flags.lua"))()

ALLOY.reset_game_globals = function(run_start)
	if run_start then
		CUTIL.set_variable("alloy_health", get_var("alloy_starting_health"))
		CUTIL.set_variable("alloy_shield", get_var("alloy_starting_shield"))
		CUTIL.set_variable("alloy_health_display", get_var("alloy_starting_health"))
		CUTIL.set_variable("alloy_shield_display", get_var("alloy_starting_shield"))
	end
end

ALLOY.UIDEF = {}