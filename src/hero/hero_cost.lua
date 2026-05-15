-- This is a constant cost that doesn't vary
function ALLOY.constant_cost(cost)
	return function(self, card, context)
		return cost
	end
end

-- This is a cost that varies with energy amount for abilities that might vary depending on charge count
function ALLOY.all_energy_cost(min, max)
	return function(self, card, context)
		return CUTIL.clamp(card.ability.extra.energy, min or 0, max or card.ability.extra.max_energy)
	end
end

-- This cost is just automatically the highest possible
function ALLOY.max_energy_cost()
	return function(self, card, context)
		return card.ability.extra.max_energy
	end
end