-- If it's usable during a certain context
function ALLOY.usable_in_context(scenario)
	return function(self, card, context)
		return context[scenario]
	end
end

-- If it's usable when certain contexts are true
function ALLOY.usable_in_contexts(tbl)
	return function(self, card, context)
		for _, scenario in ipairs(tbl) do
			if not context[scenario] then
				return false
			end
		end
		return true
	end
end