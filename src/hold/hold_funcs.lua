ALLOY.start_holding = function(cards)
	local negative_count = 0
	local card_count = #cards

	for i = 1, card_count do
		local card = cards[1]
		if not card.getting_sliced then
			negative_count = negative_count + ((card.edition and card.edition.negative) and 1 or 0)
			
			G.hand:remove_card(card)
			ALLOY.offhand:emplace(card)
		end
	end
	
	SMODS.calculate_context({ card_sent_to_hold = true, hand_sent_to_offhand = cards })
	G.hand.config.card_limit = G.hand.config.card_limit - negative_count
	G.GAME.offhand_count = (G.GAME.offhand_count or 0) + card_count
	
	ALLOY.current_hand_changed = true
end

ALLOY.stop_holding = function(cards)
	local negative_count = 0
	local card_count = #cards

	for i = 1, card_count do
		local card = cards[1]
		
		negative_count = negative_count + ((card.edition and card.edition.negative) and 1 or 0)
		
		ALLOY.offhand:remove_card(card)
		G.hand:emplace(card)
	end
	
	SMODS.calculate_context({ card_returned_from_hold = true, hand_sent_from_offhand = cards })
	G.hand.config.card_limit = G.hand.config.card_limit + negative_count
	G.GAME.offhand_count = (G.GAME.offhand_count or 0) - card_count
	
	ALLOY.current_hand_changed = true
end

-- UI Functions

G.FUNCS.toggle_hold = function(e)
	if 0 < #G.hand.highlighted and #G.hand.highlighted == #ALLOY.offhand.highlighted then
		ALLOY.stop_holding(ALLOY.offhand.highlighted)
		ALLOY.start_holding(G.hand.highlighted)
	else
		ALLOY.start_holding(G.hand.highlighted)
		G.STATE = G.STATES.DRAW_TO_HAND
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                G.STATE_COMPLETE = false
                return true
            end
        }))
	end
end

G.FUNCS.can_hold = function(e)
	if 0 < #G.hand.highlighted and #G.hand.highlighted == #ALLOY.offhand.highlighted then
		e.config.colour = G.C.GOLD
		e.config.button = "toggle_hold"
		G.GAME.offhand_action = localize("b_swap")
	elseif 0 < #G.hand.highlighted and #G.hand.highlighted <= ALLOY.offhand_limit - (G.GAME.offhand_count or 0) and #ALLOY.offhand.highlighted <= 0 then
		e.config.colour = G.C.GOLD
		e.config.button = "toggle_hold"
		G.GAME.offhand_action = localize("b_hold")
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
		G.GAME.offhand_action = localize("b_hold")
	end
end

G.FUNCS.draw_from_hold_to_discard = function(e)
	local hold_count = #ALLOY.offhand.cards
	local it = 1
	
	for k, v in ipairs(ALLOY.offhand.cards) do
		draw_card(ALLOY.offhand, G.discard, it*100/hold_count, 'down', false, v, nil, true)
		it = it + 1
	end
	
	G.GAME.offhand_count = 0
end