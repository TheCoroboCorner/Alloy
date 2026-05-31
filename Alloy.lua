ALLOY = SMODS.current_mod

ALLOY.CALCS = {}
ALLOY.calculate = function(self, context)
    local full_effs = {}
    for k, v in pairs(ALLOY.CALCS) do
        local eff = v(self, context)
        if eff then
            table.insert(full_effs, eff)
        end
    end
    if #full_effs == 0 then
        return nil
    elseif #full_effs == 1 then
        return full_effs[1]
    else
        return SMODS.merge_effects(unpack(full_effs))
    end
end

assert(SMODS.load_file("src/functions_init.lua"))()
assert(SMODS.load_file("src/variables_init.lua"))()

assert(SMODS.load_file("src/hold_init.lua"))()
assert(SMODS.load_file("src/lock_init.lua"))()
assert(SMODS.load_file("src/play_last_hand_init.lua"))()
assert(SMODS.load_file("src/health_init.lua"))()

assert(SMODS.load_file("src/hero_init.lua"))()
assert(SMODS.load_file("src/defs_init.lua"))()

assert(SMODS.load_file("src/hook_init.lua"))()
