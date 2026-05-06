function get_var(var_name)
	return G.GAME and G.GAME.cutil_vars and G.GAME.cutil_vars[var_name] or CUTIL.get_variable(var_name)
end

to_number = to_number or function(x) return x end

function debug_log(str)
	if ALLOY.debug.show_logs then
		print(str)
	end
end