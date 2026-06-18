-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Shared.Ticker
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local u1 = {};
require(script.Parent.Types);
local l__Warn__1 = require(script.Parent.Warn);
function u1.new(p2) --[[ Line: 20 ]]
    return {
        tickedHalf = false,
        lastTicked = 0,
        tickedFrame = 0,
        dt = 0,
        halfdt = 0,
        tickHalfRate = p2.TICK_RATE * 2,
        tickRate = p2.TICK_RATE,
        objects = {},
        callbacks = {},
        config = p2
    };
end;
function u1.AddCallback(p3, p4) --[[ Line: 36 ]]
    table.insert(p3.callbacks, p4);
end;
function u1.RemoveCallback(p5, p6) --[[ Line: 40 ]]
    local v7 = table.find(p5.callbacks, p6);
    if v7 then
        table.remove(p5.callbacks, v7);
    end;
end;
function u1.Add(p8, p9) --[[ Line: 47 ]]
    table.insert(p8.objects, p9);
    p9._ticker = p8;
    p9._tickerIndex = #p8.objects;
end;
function u1.Remove(p10, p11) --[[ Line: 53 ]]
    -- upvalues: l__Warn__1 (copy)
    local l___tickerIndex__2 = p11._tickerIndex;
    if l___tickerIndex__2 then
        local l__objects__3 = p10.objects;
        local v12 = #l__objects__3;
        if l___tickerIndex__2 ~= v12 then
            local v13 = l__objects__3[v12];
            l__objects__3[l___tickerIndex__2] = v13;
            v13._tickerIndex = l___tickerIndex__2;
        end;
        l__objects__3[v12] = nil;
        p11._ticker = nil;
        p11._tickerIndex = nil;
    else
        l__Warn__1.low("Ticker.remove called on object not in ticker", p11.id);
    end;
end;
function u1.move(p14, p15) --[[ Line: 66 ]]
    -- upvalues: u1 (copy)
    local l___ticker__4 = p14._ticker;
    if l___ticker__4 then
        u1.Remove(l___ticker__4, p14);
    end;
    u1.Add(p15, p14);
end;
function u1.CheckUpdate(p16) --[[ Line: 74 ]]
    local v17 = os.clock() - p16.lastTicked;
    if p16.tickRate > v17 then
        return false;
    end;
    p16.lastTicked = os.clock();
    p16.tickedFrame = time();
    p16.tickedHalf = not p16.tickedHalf;
    if p16.tickedHalf then
        p16.halfdt = v17 + p16.dt;
    else
        p16.halfdt = v17;
    end;
    p16.dt = v17;
    if #p16.callbacks > 0 then
        for _, v18 in p16.callbacks do
            v18(p16, v17);
        end;
    end;
    return true;
end;
return u1;
