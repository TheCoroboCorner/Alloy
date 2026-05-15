ALLOY.custom_card_areas = function(game)
    game.heroes = CardArea(
        game.hand.T.x - 0.1, 0,
        1.1 * G.CARD_W,
        0.95 * G.CARD_H,
        { card_limit = 1, type = "joker", highlight_limit = 1, negative_info = "joker" }
    )

    game.heroes.config.align_buttons = true
end
