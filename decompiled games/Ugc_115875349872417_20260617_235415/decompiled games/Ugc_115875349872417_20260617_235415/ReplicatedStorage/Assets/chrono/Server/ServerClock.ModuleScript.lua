-- Decompiled from: ReplicatedStorage.Assets.chrono.Server.ServerClock
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local u1 = {};
return {
    Store = function(p2, p3, p4) --[[ Name: Store, Line 6 ]]
        -- upvalues: u1 (copy)
        local v5 = u1[p2];
        if not v5 then
            v5 = {
                clockOffset = 0,
                oneWayDelay = 0.05
            };
            u1[p2] = v5;
        end;
        if p4 then
            local v6 = workspace:GetServerTimeNow() - p4;
            if v6 > 0 and v6 <= p2:GetNetworkPing() + 0.05 then
                v5.oneWayDelay = v6;
            end;
        end;
        local v7 = os.clock() - p3;
        local l__oneWayDelay__1 = v5.oneWayDelay;
        local v8 = p2:GetNetworkPing() + 0.05;
        local v9 = v7 - math.clamp(l__oneWayDelay__1, 0, v8);
        v5.clockOffset = v5.clockOffset + 0.2 * (v9 - v5.clockOffset);
    end,
    ConvertTo = function(p10, p11, p12) --[[ Name: ConvertTo, Line 27 ]]
        -- upvalues: u1 (copy)
        local v13 = u1[p10];
        if v13 then
            if p12 == "Server" then
                return p11 + v13.clockOffset;
            else
                return p11 - v13.clockOffset;
            end;
        else
            return p11;
        end;
    end,
    Remove = function(p14) --[[ Name: Remove, Line 40 ]]
        -- upvalues: u1 (copy)
        u1[p14] = nil;
    end
};
