ALLOY.event_queue = {}

function AEvent(args)
    local self = {}
    args = args or {}
    self.nid = args.nid or "_"
    self.ease = args.ease == nil and true or args.ease
    self.curTime = 0
    self.easeFunc = args.easeFunc or function(t, s) end
    self.endFunc = args.endFunc or function(s) end
    self.duration = args.duration or 1
    self.extra = args.extra
    self.type = "aevent"
    return self
end

function add_aevent(aevent, queue, front)
    queue = queue or "main"
    front = front or false
    if type(ALLOY.event_queue[queue]) ~= "table" then
        ALLOY.event_queue[queue] = {}
    end
    if front then
        table.insert(ALLOY.event_queue[queue], 1, aevent)
    else
        table.insert(ALLOY.event_queue[queue], aevent)
    end
end

local gugihrglistgsbglsregserlbgseyglsegblsegsbgylerbglerbglbglagblr_ref = Game.update
function Game:update(dt)
    for k, queue in pairs(ALLOY.event_queue) do
        local aevent = queue[1]
        if aevent.type == "aevent" then
            if aevent.easeFunc then
                aevent.easeFunc(aevent.curTime / aevent.duration, aevent)
            end
            aevent.curTime = aevent.curTime + dt
            if aevent.curTime > aevent.duration then
                if aevent.endFunc then aevent.endFunc(aevent) end
                table.remove(queue, 1)
            end
            if #queue == 0 then
                ALLOY.event_queue[k] = nil
            end
        end
    end
    gugihrglistgsbglsregserlbgseyglsegblsegsbgylerbglerbglbglagblr_ref(self, dt)
end