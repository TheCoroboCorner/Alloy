--- Enhances a card and handles visual effects via events.
--- @param card Card
--- @param enhancement string
function quick_enhance_card(card, enhancement)
	G.E_MANAGER:add_event(Event({
		trigger = 'before',
		delay = 0.15,
		func = function()
			card:flip()
			play_sound('card1', percent)
            card:juice_up(0.3, 0.3)
			return true
		end
	}))

	delay(0.05)

	G.E_MANAGER:add_event(Event({
		trigger = 'before',
		delay = 0.15,
		func = function()
            card:set_ability(enhancement)
			return true
		end
	}))

	delay(0.05)
	
	G.E_MANAGER:add_event(Event({
		trigger = 'before',
		delay = 0.15,
		func = function()
			card:flip()
			play_sound('tarot2', percent, 0.6)
            card:juice_up(0.3, 0.3)
			return true
		end
	}))
end