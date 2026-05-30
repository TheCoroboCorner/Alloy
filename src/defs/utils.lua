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

--- Same as lerp but accounting with deltatime.\
--- More info: https://www.youtube.com/watch?v=LSNQuFEDOyQ
--- @param a number The starting value.
--- @param b number The ending value.
--- @param r number The `"slowness"`, or fraction of the distance left to traverse in 1 second.
--- @param dt number Deltatime.
lerp_dt = function(a, b, r, dt)
    local v = 1 - (r ^ dt)
    return CUTIL.lerp(a, b, v)
end

--- Same as vec lerp but accounting with deltatime.\
--- More info: https://www.youtube.com/watch?v=LSNQuFEDOyQ
--- @param a table The starting value.
--- @param b table The ending value.
--- @param r number The `"slowness"`, or fraction of the distance left to traverse in 1 second.
--- @param dt number Deltatime.
vec_lerp_dt = function(a, b, r, dt)
    assert(a ~= nil and b ~= nil, "Both interpolation variables must be non-nil")
    assert(#a == #b, "The dimensions of both interpolation variables must be compatible")

    local out = {}
    for i = 1, #a do
        out[i] = lerp_dt(a[i], b[i], r, dt)
    end
    return out
end

-- ported these from bos

easeSplinesLib = {}

--- Scales the function down relative to the origin by scale, so its idealized range & domain becomes 1 for `create_ease` to use
--- @param func fun(x:number):number
--- @param scale number
--- @return fun(x:number):number
function easeSplinesLib.normalizeFunc(func, scale)
    return function(x) return (func(x * scale)) / scale end
end

--- Returns an easing function easing from the origin to the target with a parameter t signaling for time.\
--- Please format origin and target to be {name = num, name = num...} or just regular numbers.
--- @param origin table|number
--- @param target table|number
--- @param funct (fun(x:number):number)? Optional arguement. Isnt used if preset is set
--- @param preset {preset:string, param:number}? The present to use for easing.
--- @return fun(t:number):(number) easing_function
--- Presets are:\
--- `linear`: returns the function y = x for the interval 0 to 1.\
--- `singleease`: returns the function y = x ^ param (manipulated, of course), ranging from -1 to 1, with negative values being ease out and positive meaning ease in.\
--- `doubleease`: param ranging from -1 to 1, with negative values being ease in out and positive meaning ease out in.\
--- `eic`: short for "ease in circle", eases in smoothly.\
--- `eoc`: short for "ease out circle", eases out smoothly.\
--- `eioc`: short for "ease in out circle", eases in and out smoothly.\
--- `eob`: short for "ease out back", overshoots the target slightly, then comes back.
function easeSplinesLib.createEase(origin, target, funct, preset)
    preset = preset or {}
    funct = funct or function()

    end
    if preset.preset == "linear" then
        funct = function(x)
            return x
        end
    elseif preset.preset == "singleease" then
        funct = function(x)
            if preset.param == 0 then
                return x
            elseif preset.param > 0 then
                return x ^ (10 * preset.param)
            else
                return x ^ (1 / (-10 * preset.param))
            end
        end
    elseif preset.preset == "doubleease" then
        local funct1 = function(x)
            if preset.param == 0 then
                return x
            elseif preset.param > 0 then
                return x ^ (10 * preset.param)
            else
                return x ^ (1 / (-10 * preset.param))
            end
        end
        local funct2 = function(x)
            return -funct1(-x + 2) + 2
        end
        local funct3 = function(x)
            if x <= 1 then
                return funct1(x)
            else
                return funct2(x)
            end
        end
        funct = function(x)
            return easeSplinesLib.normalizeFunc(funct3, 2)(x)
        end
    elseif preset.preset == "eic" then
        funct = function(x)
            local pr = preset.param or 2
            return -(1 - math.abs((x) ^ pr)) ^ (1 / pr) + 1
        end
    elseif preset.preset == "eoc" then
        funct = function(x)
            local pr = preset.param or 2
            return (1 - math.abs((1 - x)) ^ pr) ^ (1 / pr)
        end
    elseif preset.preset == "eioc" then
        local funct1 = function(x)
            local pr = preset.param or 2
            return -(1 - math.abs((x) ^ pr)) ^ (1 / pr) + 1
        end
        local funct2 = function(x)
            local pr = preset.param or 2
            return (1 - math.abs((1 - x)) ^ pr) ^ (1 / pr)
        end
        local funct3 = function(x)
            if x < 1 then
                return funct1(x)
            else
                return funct2(x - 1) + 1
            end
        end
        funct = function(x)
            return easeSplinesLib.normalizeFunc(funct3, 2)(x)
        end
    elseif preset.preset == "eob" then -- ease out back
        funct = function(x)
            local c1 = preset.param
            local c3 = c1 + 1
            return 1 + c3 * ((x - 1) ^ 3) + c1 * ((x - 1) ^ 2)
        end
    end
    --- An easing function generated by UTIL.Path_or_Splines.create_ease.
    --- @param t number Time, between 0 and 1.
    return function(t)
        local function extended_funct(x)
            if x <= 0 then return 0 end
            if x >= 1 then return 1 end
            return funct(x)
        end
        local function j(t)
            local tab
            if type(origin) == "table" then
                tab = {}
                for k, v in pairs(origin) do
                    if type(v) == "number" and type(target[k]) == "number" then
                        tab[k] = v + extended_funct(t) * (target[k] - v)
                    end
                end
            elseif type(origin) == "number" then
                tab = origin + extended_funct(t) * (target - origin)
            end
            return tab
        end
        return j(t)
    end
end
