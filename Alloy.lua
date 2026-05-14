ALLOY = SMODS.current_mod

assert(SMODS.load_file("src/functions_init.lua"))()
assert(SMODS.load_file("src/variables_init.lua"))()

assert(SMODS.load_file("src/hold_init.lua"))()
assert(SMODS.load_file("src/lock_init.lua"))()
assert(SMODS.load_file("src/play_last_hand_init.lua"))()
assert(SMODS.load_file("src/health_init.lua"))()

assert(SMODS.load_file("src/defs_init.lua"))()

assert(SMODS.load_file("src/hook_init.lua"))()

assert(SMODS.load_file("src/hero_init.lua"))()
