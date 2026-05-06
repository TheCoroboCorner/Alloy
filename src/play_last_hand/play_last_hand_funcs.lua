-- Local QoL functions

local function get_combinations(t, max_k)
	local n = #t
	local result = {}

	local function recurse(start, k, prefix)
		if k == 0 then
			local combo = {}
			for i = 1, #prefix do combo[i] = prefix[i] end
			table.insert(result, combo)
		else
			for i = start, n - k + 1 do
				prefix[#prefix + 1] = t[i]
				recurse(i + 1, k - 1, prefix)
				prefix[#prefix] = nil
			end
		end
    end
	
	for k = 1, math.min(max_k, n) do
		recurse(1, k, {})
	end

	return result
end

local function get_all_hands()
	if not G.GAME.last_hand_played then return nil end

	local raw_hands = get_combinations(G.hand.cards, G.hand.config.highlighted_limit)
	local refined_hands = {}
	
	for _, hand in ipairs(raw_hands) do
		if next(evaluate_poker_hand(hand)[G.GAME.last_hand_played]) then
			refined_hands[#refined_hands + 1] = hand
		end
	end
	
	return refined_hands
end

-- Actual functionality

G.FUNCS.play_last_hand = function(e)
	G.hand.highlighted = ALLOY.hand_matching_last_type
	G.FUNCS.play_cards_from_highlighted(e)
end

G.FUNCS.can_play_last_hand = function(e)
	if ALLOY.current_hand_changed then
		ALLOY.current_hand_changed = false
	
		ALLOY.hand_matching_last_type = get_all_hands()
		ALLOY.hand_matching_last_type = ALLOY.hand_matching_last_type and ALLOY.hand_matching_last_type[1] or nil
	end
	
	if ALLOY.hand_matching_last_type then
		e.config.colour = G.C.GREEN
		e.config.button = "play_last_hand"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end