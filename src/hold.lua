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

	raw_hands = get_combinations(G.hand.cards, G.hand.config.highlighted_limit)
	refined_hands = {}
	
	for _, hand in ipairs(raw_hands) do
		if next(evaluate_poker_hand(hand)[G.GAME.last_hand_played]) then
			refined_hands[#refined_hands + 1] = hand
		end
	end
	
	return refined_hands
end

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
	local hold_count = #ALLOY.offhand
	local it = 1
	
	for k, v in ipairs(ALLOY.offhand.cards) do
		draw_card(ALLOY.offhand, G.discard, it*100/hold_count, 'down', false, v, nil, true)
		it = it + 1
	end
	
	G.GAME.offhand_count = 0
end

local game_start_run = Game.start_run
function Game:start_run(args)

	local ret = game_start_run(self, args)
	
	-- Creates the offhand cardarea
	
	ALLOY.offhand_limit = 5

	self.offhand = CardArea(
		15.5,
		3.75,
		self.CARD_W * 1.95,
		self.CARD_H * 0.95,
		{
			card_limit = ALLOY.offhand_limit,
			type = 'hand',
			highlight_limit = 5
		}
	)
	self.offhand.states.visible = true
	ALLOY.offhand = G.offhand
	
	-- Sets health to 100 on run start
	
	G.GAME.health_min = G.GAME.health_min or ALLOY.default_health_min
	G.GAME.health_max = G.GAME.health_max or ALLOY.default_health_max
	G.GAME.health = G.GAME.health or ALLOY.starting_health
	
	-- Sets shield to 0 on run start
	
	G.GAME.shield_min = G.GAME.shield_min or ALLOY.default_shield_min
	G.GAME.shield_max = G.GAME.shield_max or ALLOY.default_shield_max
	G.GAME.shield = G.GAME.shield or ALLOY.starting_shield
	
	-- Set total HP to health + shield
	
	ALLOY.total_health = G.GAME.health + G.GAME.shield
	
	self.alloy_health_area = CardArea(
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
	
	return ret
end