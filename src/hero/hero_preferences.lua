-- Just an internal function, made global just in case you want to use it
-- Gain energy when context[scenario] is truthy
function ALLOY.prefer_context(gain, scenario)
	return function(self, card, context)
		if context[scenario] then
			return gain
		end
	end
end

-- Gain energy when a card is scored
function ALLOY.prefer_card_scored(gain)
	return function(self, card, context)
		if context.individual and context.cardarea == G.play then
			return gain
		end
	end
end

-- Gain energy when the currently scored card is of a given suit
function ALLOY.prefer_card_suit(gain, suit)
	return function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit(suit) then
				return gain
			end
		end
	end
end

-- Gain energy when all cards in the given hand are a given suit
function ALLOY.prefer_hand_suit(gain, suit)
	return function(self, card, context)
		if context.joker_main then
			for i = 1, #context.full_hand do
				if not context.full_hand[i]:is_suit(suit) then
					return
				end
			end
			
			return gain
		end
	end
end

-- Gain energy when the hand played is a given hand
function ALLOY.prefer_hand_type(gain, hand)
	return function(self, card, context)
		if context.joker_main then
			if context.scoring_name == hand then
				return gain
			end
		end
	end
end

-- Gain energy when a card is bought
function ALLOY.prefer_cards_bought(gain)
	return ALLOY.prefer_context(gain, "buying_card")
end

-- If scales_with_cost, gain is a multiplier, otherwise, it's a fixed amount
-- Gain energy when a card is sold
function ALLOY.prefer_cards_sold(gain, scales_with_cost)
	return function(self, card, context)
		if context.selling_card then
			if scales_with_cost then
				return gain * context.card.sell_cost
			else
				return gain
			end
		end
	end
end

-- Gain energy when a card is discarded
function ALLOY.prefer_cards_discarded(gain)
	return ALLOY.prefer_context(gain, "discard")
end

-- Gain energy when a hand is played
function ALLOY.prefer_hands_played(gain)
	return ALLOY.prefer_context(gain, "before")
end

-- Gain energy when a hand is discarded
function ALLOY.prefer_hands_discarded(gain)
	return ALLOY.prefer_context(gain, "pre_discard")
end

-- Gain energy when a blind is defeated
function ALLOY.prefer_blind_defeated(gain)
	return ALLOY.prefer_context(gain, "blind_defeated")
end

-- Gain energy when the ante is changed
function ALLOY.prefer_ante_change(gain)
	return ALLOY.prefer_context(gain, "modify_ante")
end

-- Gain energy when a booster pack is opened
function ALLOY.prefer_booster_opened(gain)
	return ALLOY.prefer_context(gain, "open_booster")
end

-- Gain energy when a booster pack is skipped
function ALLOY.prefer_booster_skipped(gain)
	return ALLOY.prefer_context(gain, "skipping_booster")
end