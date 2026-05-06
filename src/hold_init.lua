assert(SMODS.load_file("src/hold/hold_funcs.lua"))()

function ALLOY.init_hold()
	ALLOY.offhand_limit = 5

	G.offhand = CardArea(
		15.5,
		3.75,
		G.CARD_W * 1.95,
		G.CARD_H * 0.95,
		{
			card_limit = ALLOY.offhand_limit,
			type = 'hand',
			highlight_limit = 5
		}
	)
	G.offhand.states.visible = true
	ALLOY.offhand = G.offhand
end