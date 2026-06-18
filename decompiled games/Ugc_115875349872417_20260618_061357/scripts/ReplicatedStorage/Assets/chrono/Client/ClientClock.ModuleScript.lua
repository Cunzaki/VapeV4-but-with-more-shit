-- Decompiled from: ReplicatedStorage.Assets.chrono.Client.ClientClock
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local l__RunService__1 = game:GetService("RunService");
local l__Warn__2 = require(script.Parent.Parent.Shared.Warn);
local l__Config__3 = require(script.Parent.Parent.Shared.Config);
require(script.Parent.Parent.Shared.Types);
local l__InterpolationBuffer__4 = require(script.Parent.InterpolationBuffer);
local u1 = {};
local function u3(p2) --[[ Line: 19 ]]
    p2.lastClockAt = nil;
    p2.lastClockDuration = 0;
    p2.renderAt = nil;
    if p2.buffer then
        p2.buffer.init = false;
    end;
end;
local function u5(p4) --[[ Line: 29 ]]
    -- upvalues: l__Warn__2 (copy)
    if p4.renderAt then
        return p4.renderAt;
    end;
    l__Warn__2.low("ClientClock: Render time not yet established for", p4.name);
    return 0;
end;
local function u7(p6) --[[ Line: 38 ]]
    -- upvalues: l__Warn__2 (copy)
    if p6.lastClockAt then
        return p6.lastClockAt + (os.clock() - p6.lastClockDuration);
    end;
    l__Warn__2.low("ClientClock: Estimated server time not yet established for", p6.name);
    return 0;
end;
local function u12(p8, p9) --[[ Line: 47 ]]
    -- upvalues: l__InterpolationBuffer__4 (copy)
    local v10 = os.clock();
    if p8.buffer then
        l__InterpolationBuffer__4.Register(p8.buffer, p9);
    end;
    if p8.lastClockAt then
        if p8.lastClockAt < p9 then
            p8.lastClockAt = p9;
            p8.lastClockDuration = v10;
            if not p8.renderAt then
                local v11;
                if p8.buffer then
                    v11 = l__InterpolationBuffer__4.GetBuffer(p8.buffer, p8.tickRate);
                else
                    v11 = p8.bufferConst or 0;
                end;
                p8.renderAt = p9 - v11;
            end;
        end;
    else
        p8.lastClockAt = p9;
        p8.lastClockDuration = v10;
        p8.renderAt = nil;
    end;
end;
local function u15(p13, p14) --[[ Line: 71 ]]
    if p13.tickRate == p14 then
    else
        p13.tickRate = p14;
    end;
end;
local function u17(p16) --[[ Line: 79 ]]
    -- upvalues: u1 (copy)
    u1[p16] = nil;
end;
local function u25(p18, p19) --[[ Line: 83 ]]
    -- upvalues: l__InterpolationBuffer__4 (copy)
    local v20 = os.clock();
    local v21;
    if p18.buffer then
        v21 = l__InterpolationBuffer__4.GetBuffer(p18.buffer, p18.tickRate);
    else
        v21 = p18.bufferConst or 0;
    end;
    if p18.lastClockAt then
        local v22 = p18.lastClockAt + (v20 - p18.lastClockDuration);
        local v23 = (p18.renderAt or v22 - v21) + p19;
        local v24 = v21 - (v22 - v23);
        if math.abs(v24) > 0.1 then
            v23 = v22 - v21;
        elseif v24 > 0.01 then
            v23 = math.max(v22 - v21, v23 - p19 * 0.1);
        elseif v24 < -0.01 then
            v23 = math.min(v22 - v21, v23 + p19 * 0.1);
        end;
        p18.renderAt = v23;
    end;
end;
local function u30(p26, p27, p28) --[[ Line: 105 ]]
    -- upvalues: u12 (copy), u7 (copy), u5 (copy), u3 (copy), u15 (copy), u17 (copy), l__InterpolationBuffer__4 (copy), u1 (copy)
    local v29 = {
        lastClockAt = nil,
        lastClockDuration = 0,
        renderAt = nil,
        buffer = nil,
        name = p27,
        tickRate = p26,
        _baseTickRate = p26,
        bufferConst = p28,
        OnSnapShot = u12,
        GetEstimatedServerTime = u7,
        GetTargetRenderTime = u5,
        Clear = u3,
        SetTickRate = u15,
        Destroy = u17
    };
    if not p28 then
        v29.buffer = l__InterpolationBuffer__4.new(v29);
    end;
    u1[v29] = true;
    return v29;
end;
l__Config__3._WaitForLock(function() --[[ Line: 137 ]]
    -- upvalues: l__RunService__1 (copy), l__Config__3 (copy), l__Warn__2 (copy), u30 (copy)
    if l__RunService__1:IsServer() then
    else
        for v31, v32 in l__Config__3._EntityConfigs do
            local l__CLIENT_CLOCK__5 = v32.CLIENT_CLOCK;
            if not l__CLIENT_CLOCK__5 then
                l__Warn__2.high("Entity Config", v31, "is missing client clocks");
                return;
            end;
            l__CLIENT_CLOCK__5.NORMAL = u30(v32.TICK_RATE, v31 .. "_NORMAL", v32.BUFFER);
            if v32.HALF_TICK_DISTANCE < (1 / 0) then
                l__CLIENT_CLOCK__5.HALF = u30(v32.TICK_RATE * 2, v31 .. "_HALF", v32.BUFFER);
            end;
        end;
    end;
end);
return {
    _getBuffer = function(p33) --[[ Name: GetBuffer, Line 11 ]]
        -- upvalues: l__InterpolationBuffer__4 (copy)
        return not p33.buffer and (p33.bufferConst or 0) or l__InterpolationBuffer__4.GetBuffer(p33.buffer, p33.tickRate);
    end,
    new = u30,
    clientClocks = u1,
    UpdateAll = function(p34) --[[ Name: UpdateAll, Line 131 ]]
        -- upvalues: u1 (copy), u25 (copy)
        for v35, _ in u1 do
            u25(v35, p34);
        end;
    end
};
