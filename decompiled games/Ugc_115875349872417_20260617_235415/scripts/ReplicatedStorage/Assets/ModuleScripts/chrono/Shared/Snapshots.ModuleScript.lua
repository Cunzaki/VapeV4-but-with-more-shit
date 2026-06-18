-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Shared.Snapshots
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
local l__Config__1 = require(script.Parent.Config);
local l__Warn__2 = require(script.Parent.Warn);
local u1 = nil;
l__Config__1._WaitForLock(function() --[[ Line: 14 ]]
    -- upvalues: u1 (ref), l__Config__1 (copy)
    u1 = l__Config__1._GetConfig("MAX_SNAPSHOT_COUNT");
end);
local function u6(p2, p3) --[[ Line: 22 ]]
    -- upvalues: u1 (ref)
    local l__count__3 = p2.count;
    if l__count__3 == 0 then
        return 1;
    end;
    local l__cache__4 = p2.cache;
    local l__head__5 = p2.head;
    local v4 = 1;
    while v4 <= l__count__3 do
        local v5 = (v4 + l__count__3) // 2;
        if l__cache__4[(l__head__5 + v5 - 2) % u1 + 1].t < p3 then
            v4 = v5 + 1;
        else
            l__count__3 = v5 - 1;
        end;
    end;
    return v4;
end;
local function u11(p7, p8, p9) --[[ Line: 48 ]]
    -- upvalues: u1 (ref)
    local l__cache__6 = p7.cache;
    local l__head__7 = p7.head;
    for v10 = p9, p8, -1 do
        l__cache__6[(l__head__7 + (v10 + 1) - 2) % u1 + 1] = l__cache__6[(l__head__7 + v10 - 2) % u1 + 1];
    end;
end;
local function u13(p12) --[[ Line: 59 ]]
    -- upvalues: u1 (ref)
    if p12.count == 0 then
        return nil;
    else
        return p12.cache[(p12.head + p12.count - 2) % u1 + 1];
    end;
end;
local function u21(p14, p15, p16, p17) --[[ Line: 68 ]]
    -- upvalues: u6 (copy), u1 (ref), u11 (copy)
    local v18 = {
        t = p15,
        value = p16,
        velocity = p17
    };
    if p14.count == 0 then
        p14.cache[p14.head] = v18;
        p14.count = 1;
    else
        local v19 = u6(p14, p15);
        if p14.count < v19 then
            if p14.count < u1 then
                p14.cache[(p14.head + (p14.count + 1) - 2) % u1 + 1] = v18;
                p14.count = p14.count + 1;
            else
                p14.cache[p14.head] = v18;
                p14.head = p14.head % u1 + 1;
            end;
        elseif p14.count < u1 then
            u11(p14, v19, p14.count);
            p14.cache[(p14.head + v19 - 2) % u1 + 1] = v18;
            p14.count = p14.count + 1;
        else
            for v20 = 1, v19 - 1 do
                p14.cache[(p14.head + v20 - 2) % u1 + 1] = p14.cache[(p14.head + (v20 + 1) - 2) % u1 + 1];
            end;
            p14.cache[(p14.head + v19 - 2) % u1 + 1] = v18;
        end;
    end;
end;
local function u28(p22, p23, p24, p25, p26) --[[ Line: 107 ]]
    -- upvalues: u1 (ref), l__Config__1 (copy), u21 (copy)
    local v27;
    if p22.count == 0 then
        v27 = nil;
    else
        v27 = p22.cache[(p22.head + p22.count - 2) % u1 + 1];
    end;
    if v27 and (p23 - v27.t > p26 * 3 and l__Config__1.FLAGS.SNAPSHOT_INTERPOLATION_FIX) then
        u21(p22, p23 - p26, v27.value, Vector3.new(0, 0, 0), true);
    end;
    u21(p22, p23, p24, p25);
end;
local function u42(p29, p30, p31) --[[ Line: 121 ]]
    -- upvalues: u1 (ref), u6 (copy), l__Warn__2 (copy)
    local l__count__8 = p29.count;
    if l__count__8 == 0 then
        return nil;
    end;
    if l__count__8 == 1 then
        return p29.cache[(p29.head + 1 - 2) % u1 + 1].value;
    end;
    local l__cache__9 = p29.cache;
    local l__head__10 = p29.head;
    local l__Lerp__11 = p29.Lerp;
    local l__lockedTime__12 = p29.lockedTime;
    if p30 < l__lockedTime__12 then
        if p31 then
            l__lockedTime__12 = p30;
        end;
    else
        l__lockedTime__12 = p30;
    end;
    local v32 = u6(p29, l__lockedTime__12);
    local v33 = v32 - 1;
    local v34 = nil;
    local v35;
    if v33 >= 1 and v33 <= l__count__8 then
        v35 = l__cache__9[(l__head__10 + v33 - 2) % u1 + 1];
    else
        v35 = nil;
    end;
    if v32 >= 1 and v32 <= l__count__8 then
        v34 = l__cache__9[(l__head__10 + v32 - 2) % u1 + 1];
    end;
    if not (v35 and v34) then
        if v35 then
            l__Warn__2.low("Tried to fetch a time that was ahead of snapshot storage!");
            return v35.value;
        end;
        if not v34 then
            return nil;
        end;
        l__Warn__2.low("Tried to fetch a time that was behind snapshot storage!");
        return v34.value;
    end;
    local v36 = v34.t - v35.t;
    if v36 == 0 then
        return v35.value;
    end;
    local v37 = (l__lockedTime__12 - v35.t) / v36;
    local v38 = l__Lerp__11(v35.value.Position, v34.value.Position, v35.velocity, v34.velocity, v37, v36);
    local v39, v40 = (v34.value.Rotation * v35.value.Rotation:Inverse()):ToAxisAngle();
    local v41 = v35.value.Rotation * CFrame.fromAxisAngle(v39, v40 * v37);
    return CFrame.new(v38) * v41;
end;
local function u44(p43) --[[ Line: 186 ]]
    p43.head = 1;
    p43.count = 0;
end;
return function(p45) --[[ Name: New, Line 191 ]]
    -- upvalues: u1 (ref), u21 (copy), u28 (copy), u13 (copy), u42 (copy), u44 (copy)
    local v46 = table.create(u1);
    for v47 = 1, u1 do
        v46[v47] = {
            t = 0,
            value = nil,
            velocity = nil
        };
    end;
    return {
        head = 1,
        count = 0,
        lockedTime = 0,
        cache = v46,
        Lerp = p45,
        Push = u21,
        PushWithCheck = u28,
        GetLatest = u13,
        GetAt = u42,
        Clear = u44
    };
end;
