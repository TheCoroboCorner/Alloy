G.FUNCS.lock_toggle = function(e)
	local card = e.config.ref_table
	card.ability.locked = not (card.ability.locked or false)
end

G.FUNCS.can_lock_card = function(e)
	local card = e.config.ref_table

	if card.ability.locked then
		card.ability.lock_text = localize("b_locked")
	else
		card.ability.lock_text = localize("b_unlocked")
	end
end