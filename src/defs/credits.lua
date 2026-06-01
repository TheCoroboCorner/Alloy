ALLOY.DEVS = {}

ALLOY.CREDITS = {
    SPRITES = {}
}
local function register_dev(args)
    table.insert(ALLOY.DEVS, 
        {
            atlas = "alloy_credits",
            pos = args.pos or {x = 0, y = 0},
            name = args.name or "NakuAutumn",
            posText = args.posText or "Page 1"
        }
    )
    
SMODS.DrawStep({
    key = args.name.."Drawstep",
    order = 101,
    func = function(card)
        local scale = 0.82
        if card.who == args.name then
            local obj = ALLOY.CREDITS.SPRITES[args.name]
            obj = obj
                or Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["alloy_creditsChar"], args.soul_pos or { x = 0, y = 0 })
            obj.role.draw_major = card
            obj:draw_shader("dissolve", 0, nil, nil, card.children.center, scale - 1, 0,
            - card.T.w * scale + 0.17,
            - card.T.h * scale, nil, 0.6)
            obj:draw_shader("dissolve", nil, nil, nil, card.children.center, scale - 1, 0,
            - card.T.w * scale + 0.17,
            - card.T.h * scale)
        end
    end,
    conditions = { vortex = false, facing = "front" },
})
end
register_dev({
    pos = {x = 0, y = 0},
    name = "NakuAutumn",
    posText = "Page 1",
    soul_pos = { x = 0, y = 0 }
})
SMODS.Gradient {
    key = 'naku_credit_green',
    colours = { HEX("#60f0a7"), HEX("#60f0a7") },
    cycle = 5
}
SMODS.Gradient {
    key = 'naku_credit_pink',
    colours = { HEX("#e944d3"), HEX("#e944d3") },
    cycle = 5
}
-- Largely taken (and modified) from Potato Patch Utils. Shoutout to them!
local function create_person_credit(person)
    if ALLOY.CREDITS.AREA then
        ALLOY.CREDITS.AREA:remove()
    end

        -- Create area for card credit
        ALLOY.CREDITS.AREA = CardArea(G.ROOM.T.x, G.ROOM.T.y, G.CARD_W, G.CARD_H,
            { type = 'title_2', card_limit = 1, highlight_limit = 0 })

        -- Create card for credit, set states
        local card = Card(G.ROOM.T.x, G.ROOM.T.y, G.CARD_W / 1.25, G.CARD_H / 1.25, nil, G.P_CENTERS.c_base)
        card.children.center:remove()
        card.children.center = SMODS.create_sprite(card.T.x, card.T.y, card.T.w, card.T.h, person.atlas or "Joker",
            person.pos or { x = 0, y = 0 })
        card.children.center.states.hover = card.states.hover
        card.children.center.states.click = card.states.click
        card.children.center.states.drag = card.states.drag
        card.children.center.states.collide.can = true
        card.children.center:set_role({ major = card, role_type = 'Glued', draw_major = card })
        
		card.hover = function(self)
			self:juice_up(0.05, 0.03)
			play_sound('paper1', math.random() * 0.2 + 0.9, 0.35)
			card.config.h_popup = {n = G.UIT.R, config = { align = "cm", padding = 0, colour = G.C.CLEAR }, nodes = {}}
			card.config.h_popup_config = self:align_h_popup()
			Moveable.hover(self)
		end

        -- Emplace card credit in its own area
        ALLOY.CREDITS.AREA:emplace(card)

        -- Attach member and team information to the card
        card.who = person.name
        card.click = person.click or card.click
        card.states.drag.can = false

        ALLOY.CREDITS.NODE = {
            n = G.UIT.C,
            config = { align = "cm", id = "alloy_credit_node_" .. person.name },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { r = 0.2, align = "cm", padding = 0.125, colour = G.C.L_BLACK, minw = G.CARD_W / 1.2 + 0.2, minh = G.CARD_H * 1.2 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { r = 0.2, align = "tm", padding = 0.1, colour = G.C.BLACK, minw = G.CARD_W / 1.2, minh = G.CARD_H },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        { n = G.UIT.O, config = { object = ALLOY.CREDITS.AREA } }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        local function generateText()
            local retTable = {}
            local text = G.localization.descriptions.AlloyCredits[person.name].text_parsed or nil
            if text then
                local node = { n = G.UIT.R, config = { colour = G.C.CLEAR, r = 0.1, padding = 0.15, align = 'cm', shadow = true }, nodes = {} }
                for _, v in ipairs(text) do
                    table.insert(node.nodes,
                        {
                            n = G.UIT.R,
                            config = { align = 'cm' },
                            nodes = SMODS.localize_box(v,
                                { text_colour = G.C.UI.TEXT_LIGHT })
                        })
                end
                retTable[#retTable + 1] = { n = G.UIT.R, config = { align = 'cm' }, nodes = { { n = G.UIT.C, config = { align = 'cm', colour = G.C.CLEAR, r = 0.1, padding = 0.025 }, nodes = { node } } } }
            end
            return unpack(retTable)
    end
    local function generateName()
        local retTable = {}
        local text = G.localization.descriptions.AlloyCredits[person.name].name_parsed or nil
        if text then
            local node = { n = G.UIT.R, config = { colour = G.C.CLEAR, r = 0.1, padding = 0.15, align = 'cm', shadow = true }, nodes = {} }
            for _, v in ipairs(text) do
                table.insert(node.nodes,
                    {
                        n = G.UIT.R,
                        config = { align = 'cm' },
                        nodes = SMODS.localize_box(v,
                            { text_colour = G.C.UI.TEXT_LIGHT })
                    })
            end
            retTable[#retTable + 1] = { n = G.UIT.R, config = { align = 'cm' }, nodes = { { n = G.UIT.C, config = { align = 'cm', colour = G.C.CLEAR, r = 0.1, padding = 0.025 }, nodes = { node } } } }
        end
        return unpack(retTable)
    end
    -- create a card for this member
    return {
        n = G.UIT.R,
        config = { minw = 7, colour = G.C.CLEAR, align = "cm", id = "alloy_credits_page" },
        nodes = {
            {
                n = G.UIT.C,
                config = { align = 'cm', padding = 0.1 },
                nodes = {
                    { n = G.UIT.R, config = { align = 'cm', minh = 5, padding = 0.1 }, nodes =
                        { 
                            ALLOY.CREDITS.NODE,
                            {
                                n = G.UIT.C, config = { minw = 0.4, minh = 0.1, r = 0.2, align = "tm", padding = 0.1, colour = G.C.CLEAR }
                            },
                            {
                                n = G.UIT.C,
                                config = { align = 'cm', padding = 0.1 },
                                nodes = {
                                    {
                                        n = G.UIT.R, config = { minw = 4, minh = 1, r = 0.2, align = "cm", padding = 0.1, colour = G.C.L_BLACK }, nodes = {
                                            generateName()
                                        }
                                    },
                                    {
                                        n = G.UIT.R, config = { minw = 4, minh = 0.1, r = 0.2, align = "tm", padding = 0.1, colour = G.C.CLEAR }
                                    },
                                    {
                                        n = G.UIT.R, config = { minw = 4, minh = 3, r = 0.2, align = "tm", padding = 0.1, colour = G.C.L_BLACK }, nodes = {
                                            generateText()
                                        }
                                    },
                                }
                            }
                        } 
                    },
                    {
                        n = G.UIT.R,
                        config = { align = 'cm', padding = 0.1 },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = { minw = 0.7, minh = 0.7, align = 'cm', r = 0.1, colour = G.C.RED, hover = true, button = 'alloy_toggle_credit_page', change = -1, shadow = true },
                                nodes = {
                                    { n = G.UIT.T, config = { text = '<', scale = 0.5, colour = G.C.WHITE } }
                                }
                            },
                            { n = G.UIT.C, config = { minw = 0.2, colour = G.C.CLEAR } },
                            { n = G.UIT.C, config = { minw = 2, minh = 0.7, align = 'cm', r = 0.1, colour = G.C.RED, hover = true, shadow = true }, nodes = { { n = G.UIT.T, config = { scale = 0.4, colour = G.C.WHITE, text = person.posText, shadow = true  } } } },
                            { n = G.UIT.C, config = { minw = 0.2, colour = G.C.CLEAR } },
                            {
                                n = G.UIT.C,
                                config = { minw = 0.7, minh = 0.5, align = 'cm', r = 0.1, colour = G.C.RED, hover = true, button = 'alloy_toggle_credit_page', change = 1, shadow = true },
                                nodes = {
                                    { n = G.UIT.T, config = { text = '>', scale = 0.5, colour = G.C.WHITE } }
                                }
                            },
                        }
                    },
                }
            }
        }
    }
end
function G.FUNCS.alloy_toggle_credit_page(e)
    if not e then return end
    local credit_nodes = G.OVERLAY_MENU:get_UIE_by_ID("alloy_credits_page_nodes")
    if credit_nodes then
        local people = credit_nodes.config.people
        local new_selection = (credit_nodes.config.current_person + e.config.change - 1) % #people + 1
        -- if new_selection > #teams then new_selection = 1 elseif new_selection == 0 then new_selection = #teams end
        credit_nodes:remove()
        local uibox = create_person_credit(people[new_selection])
        credit_nodes.config.current_person = new_selection
        credit_nodes.UIBox:add_child(uibox, credit_nodes)
        credit_nodes.UIBox:recalculate()
    end
end
ALLOY.extra_tabs = function()
    return {
        {
            label = localize("alloy_tab_label"),
            tab_definition_function = function()
                return {n = G.UIT.ROOT, config = { align = "m", r = 0.1, padding = 0.05, colour = G.C.BLACK, minw = 9, minh = 5 }, nodes = {
                    {n=G.UIT.C, config = {align = 'cm', id = 'alloy_credits_page_nodes', people = ALLOY.DEVS, current_person = 1}, nodes = {
                        create_person_credit(ALLOY.DEVS[1]),
                    }}
                }}
            end,
        },
    }
end
