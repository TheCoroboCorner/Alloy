local highlight_ref = Card.highlight
Card.highlight = function(self, is_highlighted)
    if is_highlighted and self:has_attribute("alloy_hero") and self.config.center.set == "Joker" then
        local txt = localize("alloy_hero_button_j")
        if self.area == G.heroes then txt = localize("alloy_hero_button_h") end
        self.children.alloy_hero_button = UIBox {
            definition = {
                n = G.UIT.ROOT,
                config = {
                    minh = 0.3,
                    maxh = 0.5,
                    minw = 0.4,
                    maxw = 4,
                    r = 0.08,
                    padding = 0.1,
                    align = "cm",
                    hover = true,
                    shadow = true,
                    colour = G.C.GOLD,
                    button = "alloy_hero",
                    func = "alloy_can_hero",
                    ref_table = self
                },
                nodes = { {
                    n = G.UIT.T,
                    config = {
                        text = txt,
                        scale = 0.25,
                        colour = G.C.UI.TEXT_LIGHT
                    }
                } }
            },
            config = {
                align = "bmi",
                offset = { x = 0, y = 0.45 },
                bond = "Strong",
                parent = self
            }
        }
    elseif self.children.alloy_hero_button then
        self.children.alloy_hero_button:remove()
        self.children.alloy_hero_button = nil
    end
    return highlight_ref(self, is_highlighted)
end

G.FUNCS.alloy_hero = function(e)
    local card = e.config.ref_table
    if card.area == G.jokers then
        draw_card(G.jokers, G.heroes, 1, 'up', true, card, nil, mute)
    elseif card.area == G.heroes then
        draw_card(G.heroes, G.jokers, 1, 'up', true, card, nil, mute)
    else
        print("??? hero button appeared on a non-joker, pls fix")
    end
end

G.FUNCS.alloy_can_hero = function(e)
    local card = e.config.ref_table
    if card.area == G.jokers then
        if #G.heroes.cards < G.heroes.config.card_limit then
            e.config.colour = G.C.GOLD
            e.config.hover = true
            e.config.button = "alloy_hero"
        else
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.hover = false
            e.config.button = nil
        end
    elseif card.area == G.heroes then
        if #G.jokers.cards < G.jokers.config.card_limit then
            e.config.colour = G.C.GOLD
            e.config.hover = true
            e.config.button = "alloy_hero"
        else
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.hover = false
            e.config.button = nil
        end
    end
end
