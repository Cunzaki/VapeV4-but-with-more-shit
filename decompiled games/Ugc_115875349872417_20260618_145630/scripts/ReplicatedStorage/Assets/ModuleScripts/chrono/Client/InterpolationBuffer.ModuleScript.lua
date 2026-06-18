-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Client.InterpolationBuffer
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local l__Warn__1 = require(script.Parent.Parent.Shared.Warn);
local l__Config__2 = require(script.Parent.Parent.Shared.Config);
require(script.Parent.Parent.Shared.Types);
local u1 = nil;
local u2 = nil;
l__Config__2._WaitForLock(function() --[[ Line: 11 ]]
    -- upvalues: u1 (ref), l__Config__2 (copy), u2 (ref)
    u1 = l__Config__2._GetConfig("MIN_BUFFER");
    u2 = l__Config__2._GetConfig("MAX_BUFFER");
end;
return {
    new = function(p3) --[[ Name: new, Line 17 ]]
        return {
            init = false,
            averageLatency = 0,
            deviation = 0,
            lastLatency = 0,
            clientClock = p3
        };
    end,
    Register = function(p4, p5) --[[ Name: Register, Line 28 ]]
        -- upvalues: l__Warn__1 (copy)
        local l__clientClock__3 = p4.clientClock;
        local v6 = l__clientClock__3:GetEstimatedServerTime() - p5;
        if math.abs(v6) > 1 then
            l__clientClock__3:Clear();
            l__Warn__1.low(p4.clientClock.name, (` latency too high, cleared cache to repredict in case of error:! {v6}`));
        end;
        if p4.init then
            if p4.lastLatency then
                local v7 = math.abs(v6 - p4.lastLatency);
                p4.deviation = p4.deviation + (v7 - p4.deviation) * 0.1;
            end;
            p4.averageLatency = p4.averageLatency + (v6 - p4.averageLatency) * 0.1;
            p4.lastLatency = v6;
        else
            p4.averageLatency = v6;
            p4.deviation = 0;
            p4.lastLatency = v6;
            p4.init = true;
        end;
    end,
    GetBuffer = function(p8, p9) --[[ Name: GetBuffer, Line 59 ]]
        -- upvalues: u1 (ref), u2 (ref), l__Warn__1 (copy)
        if not p8 then
            return u1;
        end;
        local v10 = p9 + p8.deviation * 2;
        if v10 < u1 then
            v10 = u1 + (u1 - v10) * 0.2;
        end;
        if u2 < v10 then
            l__Warn__1.low(`Interpolation buffer exceeded max! Was {v10}, clamped to {u2} for`, p8.clientClock.name);
            v10 = u2;
        end;
        return v10;
    end
};
