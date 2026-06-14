-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Client.Sender
-- Class: ModuleScript
-- Place: Ugc (126691165749976)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__Shared__2 = script.Parent.Parent.Shared;
local l__Holder__3 = require(l__Shared__2.Holder);
require(l__Shared__2.Types);
local l__Entity__4 = require(l__Shared__2.Entity);
local l__Replicate__5 = l__Shared__2.Remotes.Replicate;
local l___clientOwned__6 = l__Holder__3._clientOwned;
if not l___clientOwned__6[l__LocalPlayer__1] then
    l___clientOwned__6[l__LocalPlayer__1] = {};
end;
local u1 = l___clientOwned__6[l__LocalPlayer__1];
local u2 = buffer.create(950);
local u3 = 0;
local u4 = 0;
local u5 = nil;
local function u9(p6, p7, ...) --[[ Line: 44 ]]
    local l___events__7 = p6._events;
    if l___events__7 then
        local v8 = l___events__7[p7];
        if v8 then
            v8:Fire(p6, ...);
        end;
    end;
end;
local function u24(p10, p11, p12) --[[ Line: 55 ]]
    local l__X__8 = p11.X;
    local l__Y__9 = p11.Y;
    local l__Z__10 = p11.Z;
    local v13, v14, v15 = p11:ToOrientation();
    buffer.writef32(p10, p12, l__X__8);
    local v16 = p12 + 4;
    buffer.writef32(p10, v16, l__Y__9);
    local v17 = v16 + 4;
    buffer.writef32(p10, v17, l__Z__10);
    local v18 = v17 + 4;
    local v19 = math.round((v13 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p10, v18, v19);
    local v20 = v18 + 2;
    local v21 = math.round((v14 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p10, v20, v21);
    local v22 = v20 + 2;
    local v23 = math.round((v15 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p10, v22, v23);
    return v22 + 2;
end;
local function u39(p25, p26, p27, p28, p29) --[[ Line: 121 ]]
    -- upvalues: u3 (ref), u4 (ref), u2 (copy), l__Replicate__5 (copy), u24 (copy)
    if u3 + (p27 and 21 or 17) > 900 and u3 ~= 0 then
        local v30 = buffer.create(u3 + 4);
        buffer.writef32(v30, 0, u4);
        buffer.copy(v30, 4, u2, 0, u3);
        l__Replicate__5:FireServer(v30);
        u3 = 0;
    end;
    buffer.writeu16(u2, u3, p25);
    u3 = u3 + 2;
    local v31 = p27 and 1 or 0;
    if p28 then
        v31 = v31 + 2;
    end;
    if p29 then
        v31 = v31 + 4;
    end;
    buffer.writeu8(u2, u3, v31);
    u3 = u3 + 1;
    if p27 then
        u3 = u24(u2, p26, u3);
    else
        local v32 = u2;
        local v33 = u3;
        local l__X__11 = p26.X;
        local l__Y__12 = p26.Y;
        local l__Z__13 = p26.Z;
        local _, v34, _ = p26:ToOrientation();
        buffer.writef32(v32, v33, l__X__11);
        local v35 = v33 + 4;
        buffer.writef32(v32, v35, l__Y__12);
        local v36 = v35 + 4;
        buffer.writef32(v32, v36, l__Z__13);
        local v37 = v36 + 4;
        local v38 = math.round((v34 + 3.141592653589793) / 0.00009587526218325454);
        buffer.writeu16(v32, v37, v38);
        u3 = v37 + 2;
    end;
end;
local function u45(p40) --[[ Line: 160 ]]
    -- upvalues: u4 (ref), u9 (copy), l__Entity__4 (copy), u39 (copy)
    if p40.destroyed or p40.paused then
    else
        local l__entityConfig__14 = p40.entityConfig;
        local l__TICK_RATE__15 = l__entityConfig__14.TICK_RATE;
        if p40.isHalfTicked then
            l__TICK_RATE__15 = l__TICK_RATE__15 * 2;
        elseif p40.isHalfTicked == nil then
            return;
        end;
        local v41 = u4;
        local v42 = v41 - (p40.lastReplicatedTime or 0);
        if v42 < l__TICK_RATE__15 then
        else
            u9(p40, "Ticked", v42);
            local v43 = l__Entity__4.GetPrimaryPart(p40);
            if p40.autoUpdatePosition and v43 then
                l__Entity__4.Push(p40, v41, v43.CFrame);
            end;
            local l__latestCFrame__16 = p40.latestCFrame;
            local l__lastCheckedCFrame__17 = p40.lastCheckedCFrame;
            if l__latestCFrame__16 then
                local v44;
                if l__lastCheckedCFrame__17 == l__latestCFrame__16 then
                    v44 = false;
                else
                    v44 = (l__lastCheckedCFrame__17 == nil or l__latestCFrame__16 == nil) and true or l__lastCheckedCFrame__17:FuzzyEq(l__latestCFrame__16, 0.0001) == false;
                end;
                if v44 then
                    p40.lastReplicatedTime = v41;
                    local l__FULL_ROTATION__18 = l__entityConfig__14.FULL_ROTATION;
                    p40.lastCheckedCFrame = l__latestCFrame__16;
                    u39(p40.id, l__latestCFrame__16, l__FULL_ROTATION__18, p40.isHalfTicked, p40._teleport);
                    p40._teleport = nil;
                end;
            end;
        end;
    end;
end;
return {
    Update = function() --[[ Name: Update, Line 220 ]]
        -- upvalues: u4 (ref), u1 (copy), u45 (copy), u5 (ref), u3 (ref), u2 (copy), l__Replicate__5 (copy)
        u4 = os.clock();
        for v46 in u1 do
            u45(v46);
        end;
        local l__CurrentCamera__19 = workspace.CurrentCamera;
        if l__CurrentCamera__19 then
            local l__LookVector__20 = l__CurrentCamera__19.CFrame.LookVector;
            local l__Magnitude__21 = l__LookVector__20.Magnitude;
            local v47;
            if l__Magnitude__21 == l__Magnitude__21 and l__Magnitude__21 > 0 then
                v47 = l__LookVector__20 / l__Magnitude__21;
            else
                v47 = nil;
            end;
            if v47 and (not u5 or (u5 - v47).Magnitude > 0.001) then
                u5 = v47;
                if u3 + 15 > 900 and u3 ~= 0 then
                    local v48 = buffer.create(u3 + 4);
                    buffer.writef32(v48, 0, u4);
                    buffer.copy(v48, 4, u2, 0, u3);
                    l__Replicate__5:FireServer(v48);
                    u3 = 0;
                end;
                buffer.writeu16(u2, u3, 0);
                u3 = u3 + 2;
                buffer.writeu8(u2, u3, 1);
                u3 = u3 + 1;
                buffer.writef32(u2, u3, v47.X);
                u3 = u3 + 4;
                buffer.writef32(u2, u3, v47.Y);
                u3 = u3 + 4;
                buffer.writef32(u2, u3, v47.Z);
                u3 = u3 + 4;
            end;
        end;
        if u3 == 0 then
        else
            local v49 = buffer.create(u3 + 4);
            buffer.writef32(v49, 0, u4);
            buffer.copy(v49, 4, u2, 0, u3);
            l__Replicate__5:FireServer(v49);
            u3 = 0;
        end;
    end
};
