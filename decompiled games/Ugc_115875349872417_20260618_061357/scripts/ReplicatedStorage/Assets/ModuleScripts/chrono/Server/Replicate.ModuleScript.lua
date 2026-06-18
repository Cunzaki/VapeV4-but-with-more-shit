-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Server.Replicate
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__Shared__3 = script.Parent.Parent.Shared;
local l__Warn__4 = require(l__Shared__3.Warn);
local l__Bin__5 = require(l__Shared__3.Bin);
local l__Holder__6 = require(l__Shared__3.Holder);
local l__Events__7 = require(l__Shared__3.Events);
local l__Ticker__8 = require(l__Shared__3.Ticker);
local l__Config__9 = require(l__Shared__3.Config);
require(l__Shared__3.Types);
local l__Entity__10 = require(l__Shared__3.Entity);
local l__EntityGrid__11 = require(script.Parent.EntityGrid);
require(script.Parent.Player);
local l__Sender__12 = require(script.Parent.Sender);
local l__Receiver__13 = require(script.Parent.Receiver);
local l__SERVER__14 = require(l__Shared__3.Stats).SERVER;
local u1 = {};
l__Config__9._WaitForLock(function() --[[ Line: 24 ]]
    -- upvalues: l__Config__9 (copy), u1 (copy), l__Warn__4 (copy)
    for _, v2 in l__Config__9._EntityConfigs do
        if v2.TICKER then
            table.insert(u1, v2.TICKER);
        else
            l__Warn__4.high(v2, "TICKERS not found on server config load");
        end;
    end;
end);
local function u6(p3, p4, ...) --[[ Line: 34 ]]
    local l___events__15 = p3._events;
    if l___events__15 then
        local v5 = l___events__15[p4];
        if v5 then
            v5:Fire(p3, ...);
        end;
    end;
end;
local function u21(p7, p8, p9) --[[ Line: 54 ]]
    local l__X__16 = p8.X;
    local l__Y__17 = p8.Y;
    local l__Z__18 = p8.Z;
    local v10, v11, v12 = p8:ToOrientation();
    buffer.writef32(p7, p9, l__X__16);
    local v13 = p9 + 4;
    buffer.writef32(p7, v13, l__Y__17);
    local v14 = v13 + 4;
    buffer.writef32(p7, v14, l__Z__18);
    local v15 = v14 + 4;
    local v16 = math.round((v10 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p7, v15, v16);
    local v17 = v15 + 2;
    local v18 = math.round((v11 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p7, v17, v18);
    local v19 = v17 + 2;
    local v20 = math.round((v12 + 3.141592653589793) / 0.00009587526218325454);
    buffer.writeu16(p7, v19, v20);
    return v19 + 2;
end;
local function u25(p22, p23) --[[ Line: 96 ]]
    -- upvalues: l__Entity__10 (copy), l__Warn__4 (copy)
    if p22.autoUpdatePosition and (p22.isContextOwner and p22.model) then
        local v24 = l__Entity__10.GetPrimaryPart(p22);
        if not v24 then
            l__Warn__4.medium("Entity", p22, "has no primary part");
            return;
        end;
        l__Entity__10.Push(p22, p23, v24.CFrame);
    end;
end;
local function u39(p26, p27, p28, p29) --[[ Line: 119 ]]
    -- upvalues: l__Ticker__8 (copy), u6 (copy), u25 (copy), u21 (copy)
    if p26.destroyed then
        l__Ticker__8.Remove(p27, p26);
    elseif p26.isContextOwner then
        local l__isHalfTicked__19 = p26.isHalfTicked;
        if l__isHalfTicked__19 and not p29 or p26.paused then
            p26.cframeBuffer = nil;
        else
            if l__isHalfTicked__19 then
                u6(p26, "Ticked", p27.halfdt);
            else
                u6(p26, "Ticked", p27.dt);
            end;
            u25(p26, p27.lastTicked);
            local l__lastCheckedCFrame__20 = p26.lastCheckedCFrame;
            local l__latestCFrame__21 = p26.latestCFrame;
            local v30;
            if l__lastCheckedCFrame__20 == l__latestCFrame__21 then
                v30 = false;
            else
                v30 = (l__lastCheckedCFrame__20 == nil or l__latestCFrame__21 == nil) and true or l__lastCheckedCFrame__20:FuzzyEq(l__latestCFrame__21, 0.0001) == false;
            end;
            if v30 then
                p26.lastCheckedCFrame = l__latestCFrame__21;
            else
                l__latestCFrame__21 = nil;
            end;
            if l__latestCFrame__21 then
                if p26.id == 0 then
                    error("Entity Should not have and id of 0");
                end;
                if p28 then
                    local v31 = buffer.create(20);
                    buffer.writeu16(v31, 0, p26.id);
                    u21(v31, l__latestCFrame__21, 2);
                    p26.cframeBuffer = v31;
                else
                    local v32 = buffer.create(16);
                    buffer.writeu16(v32, 0, p26.id);
                    local v33 = 2;
                    local l__X__22 = l__latestCFrame__21.X;
                    local l__Y__23 = l__latestCFrame__21.Y;
                    local l__Z__24 = l__latestCFrame__21.Z;
                    local _, v34, _ = l__latestCFrame__21:ToOrientation();
                    buffer.writef32(v32, v33, l__X__22);
                    local v35 = v33 + 4;
                    buffer.writef32(v32, v35, l__Y__23);
                    local v36 = v35 + 4;
                    buffer.writef32(v32, v36, l__Z__24);
                    local v37 = v36 + 4;
                    local v38 = math.round((v34 + 3.141592653589793) / 0.00009587526218325454);
                    buffer.writeu16(v32, v37, v38);
                    local _ = v37 + 2;
                    p26.cframeBuffer = v32;
                end;
            else
                p26.cframeBuffer = nil;
            end;
        end;
    end;
end;
local u40 = {};
local function u46() --[[ Line: 166 ]]
    -- upvalues: l__Entity__10 (copy), u40 (copy)
    for v41, v42 in l__Entity__10._Changes do
        local v43 = {
            id = v41.id,
            data = {}
        };
        for v44, v45 in v42 do
            table.insert(v43.data, { v44, v45 or v41[v44] });
        end;
        l__Entity__10._Changes[v41] = nil;
        v41._changes = v43;
        table.insert(u40, v41);
    end;
end;
local u47 = 0;
local u48 = 0;
local function u53() --[[ Line: 182 ]]
    -- upvalues: u1 (copy), l__Ticker__8 (copy), u39 (copy), u47 (ref), u48 (ref), l__SERVER__14 (copy)
    debug.profilebegin("UpdateTickers");
    local v49 = os.clock();
    for _, v50 in u1 do
        if next(v50.objects) then
            debug.profilebegin((`{v50.config.NAME}`));
            if l__Ticker__8.CheckUpdate(v50) then
                local v51 = v50.config.FULL_ROTATION == true;
                local l__tickedHalf__25 = v50.tickedHalf;
                for _, v52 in v50.objects do
                    u39(v52, v50, v51, l__tickedHalf__25);
                end;
            end;
            debug.profileend();
        end;
    end;
    debug.profileend();
    u47 = u47 + (os.clock() - v49);
    u48 = u48 + 1;
    l__SERVER__14.AVG_TICKER_TIME_MS = u47 / u48 * 1000;
    if u48 >= 60 then
        u47 = 0;
        u48 = 0;
    end;
end;
local function u57() --[[ Line: 214 ]]
    -- upvalues: l__Holder__6 (copy), l__Entity__10 (copy), l__EntityGrid__11 (copy)
    for _, v54 in l__Holder__6._playerChars do
        local l__networkOwner__26 = v54.networkOwner;
        local v55 = l__Entity__10.GetPrimaryPart(v54);
        local v56 = v55 and v55.CFrame or v54.latestCFrame;
        if l__networkOwner__26 and v56 then
            l__EntityGrid__11.UpdatePlayerPosition(l__networkOwner__26, v56.Position);
        end;
    end;
end;
local function u67() --[[ Line: 226 ]]
    -- upvalues: l__SERVER__14 (copy), l__Holder__6 (copy), l__Entity__10 (copy)
    if l__SERVER__14._SHOULD_REPLICATE then
        local v58 = {};
        for _, v59 in l__Holder__6.idMap do
            local l__networkOwner__27 = v59.networkOwner;
            local v60 = v59._player ~= nil;
            local l__entityConfig__28 = v59.entityConfig;
            local v61 = l__entityConfig__28 and (l__entityConfig__28.NAME or "DEFAULT") or "DEFAULT";
            local v62 = 1 / l__entityConfig__28.TICK_RATE;
            local l__isHalfTicked__29 = v59.isHalfTicked;
            local v63;
            if v59.latestCFrame then
                v63 = v59.latestCFrame.Position or nil;
            else
                v63 = nil;
            end;
            local v64;
            if l__isHalfTicked__29 == true then
                v64 = v62 / 2;
            else
                v64 = l__isHalfTicked__29 == nil and 0 or v62;
            end;
            local v65 = v64 // 1;
            local v66 = {
                isPaused = v59.paused,
                id = v59.id,
                networkOwner = l__networkOwner__27,
                isCharacter = v60,
                config = v61,
                tickRate = (v65 ~= v65 or v65 == (1 / 0)) and 0 or v65,
                lastTicked = v59.latestTime,
                lastPosition = v63,
                modelType = l__Entity__10.GetModelReplicationType(v59)
            };
            table.insert(v58, v66);
        end;
        l__SERVER__14.SERVER_ENTITIES = v58;
    else
        l__SERVER__14.SERVER_ENTITIES = {};
    end;
end;
local function u70() --[[ Line: 269 ]]
    -- upvalues: l__EntityGrid__11 (copy), u57 (copy), u53 (copy), u46 (copy), l__Players__1 (copy), l__Sender__12 (copy), u40 (copy), u67 (copy)
    l__EntityGrid__11.Update();
    u57();
    u53();
    u46();
    for _, v68 in l__Players__1:GetPlayers() do
        l__Sender__12.ReplicatePlayer(v68);
    end;
    for _, v69 in u40 do
        v69._changes = nil;
    end;
    table.clear(u40);
    u67();
end;
local function u83(_, u71) --[[ Line: 284 ]]
    -- upvalues: l__Bin__5 (copy), l__Entity__10 (copy), l__Receiver__13 (copy)
    local u72, u73 = l__Bin__5();
    local function u80(u74) --[[ Line: 287 ]]
        -- upvalues: l__Entity__10 (ref), l__Receiver__13 (ref), u72 (copy)
        if u74.model then
            local v75 = l__Entity__10.GetPrimaryPart(u74);
            if v75 then
                local u76 = v75;
                local function v77() --[[ Line: 297 ]]
                    -- upvalues: u76 (ref), u74 (copy), l__Receiver__13 (ref), l__Entity__10 (ref)
                    local l__CFrame__30 = u76.CFrame;
                    if l__CFrame__30 == u74.latestCFrame then
                    else
                        local l__networkOwner__31 = u74.networkOwner;
                        if l__networkOwner__31 and l__Receiver__13.ShouldBlockEntityCFrame(l__networkOwner__31, u74, l__CFrame__30, os.clock()) then
                        else
                            l__Entity__10.SetCFrame(u74, l__CFrame__30);
                        end;
                    end;
                end;
                if u74._lockedCFReplication then
                    local v78 = v75:FindFirstChild("__CHRONO_LOCKER");
                    if not v78 then
                        return;
                    end;
                    local v79 = v78:FindFirstChild("__CHRONO_LOCKER_PART");
                    if not (v79 and v79:IsA("BasePart")) then
                        return;
                    end;
                    u76 = v79;
                    u72(v79:GetPropertyChangedSignal("CFrame"):Connect(v77));
                else
                    u72(v75:GetPropertyChangedSignal("CFrame"):Connect(v77));
                end;
            end;
        end;
    end;
    local v81, u82 = l__Bin__5();
    v81(l__Entity__10.GetEvent(u71, "ModelChanged"):Connect(function() --[[ Line: 327 ]]
        -- upvalues: u73 (copy), u80 (copy), u71 (copy)
        u73();
        u80(u71);
    end));
    v81(l__Entity__10.GetEvent(u71, "LockChanged"):Connect(function() --[[ Line: 331 ]]
        -- upvalues: u73 (copy), u80 (copy), u71 (copy)
        u73();
        u80(u71);
    end));
    l__Entity__10.GetEvent(u71, "NetworkOwnerChanged"):Once(function() --[[ Line: 336 ]]
        -- upvalues: u73 (copy), u82 (copy)
        u73();
        u82();
    end);
    u80(u71);
end;
l__Config__9._WaitForLock(function() --[[ Line: 356 ]]
    -- upvalues: l__RunService__2 (copy), l__Config__9 (copy), l__Events__7 (copy), u83 (copy), u70 (copy)
    if l__RunService__2:IsServer() then
        local v84 = l__Config__9._GetConfig("REPLICATE_CFRAME_SETTERS");
        if v84 ~= "NONE" then
            if v84 == "PLAYER_ENTITIES" then
                l__Events__7.PlayerOwnedAdded:Connect(u83, true);
            else
                l__Events__7.PlayerCharacterRegistered:Connect(u83, true);
            end;
        end;
        l__RunService__2.PreSimulation:Connect(u70);
    end;
end);
return nil;
