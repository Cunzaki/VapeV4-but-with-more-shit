-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Server.EntityGrid
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__Config__3 = require(script.Parent.Parent.Shared.Config);
local l__ReplicationRules__4 = require(script.Parent.Parent.Shared.ReplicationRules);
local l__Stats__5 = require(script.Parent.Parent.Shared.Stats);
for _, _ in { "ALL_ENTITIES" } do

end;
local l__Shared__6 = script.Parent.Parent.Shared;
require(l__Shared__6.Types);
local l__Holder__7 = require(l__Shared__6.Holder);
local l__Ticker__8 = require(l__Shared__6.Ticker);
local l__Entity__9 = require(l__Shared__6.Entity);
local l___SetTickMode__10 = l__Entity__9._SetTickMode;
local u1 = 0.1;
local u2 = 0.0005;
local u3 = 0;
local u4 = 0;
local u5 = 0;
local u6 = 0;
local l__idMap__11 = l__Holder__7.idMap;
local u7 = {};
local u8 = {};
local function u20(p9) --[[ Line: 97 ]]
    -- upvalues: l__Entity__9 (copy), u8 (copy), u7 (copy), l__ReplicationRules__4 (copy), l___SetTickMode__10 (copy), u5 (ref), u4 (ref), u6 (ref), l__Ticker__8 (copy)
    local v10 = l__Entity__9.GetPrimaryPart(p9);
    local v11 = v10 and v10.CFrame or p9.latestCFrame;
    if v11 and not p9.destroyed then
        if p9.id < 1 then
            warn(p9, " has invalid id, cannot check for proximity");
        else
            local l__Position__12 = v11.Position;
            local l__entityConfig__13 = p9.entityConfig;
            local v12 = false;
            local v13 = false;
            local v14 = l__entityConfig__13.HALF_TICK_DISTANCE or (1 / 0);
            local v15 = l__entityConfig__13.NORMAL_TICK_DISTANCE or (1 / 0);
            local l__networkOwner__14 = p9.networkOwner;
            if l__networkOwner__14 then
                l__networkOwner__14 = u8[l__networkOwner__14];
            end;
            local v16 = p9.modelReplicationMode ~= "NATIVE";
            for v17, v18 in u7 do
                if l__ReplicationRules__4.Allows(p9, v17.PLAYER) then
                    local v19 = vector.magnitude(l__Position__12 - v18);
                    if v14 < v19 and v16 then
                        if v17 == l__networkOwner__14 then
                            table.insert(v17._TEMP_NORMAL, p9);
                        end;
                    elseif v19 <= v15 then
                        table.insert(v17._TEMP_NORMAL, p9);
                        v12 = true;
                    else
                        table.insert(v17._TEMP_HALF, p9);
                        v13 = true;
                    end;
                end;
            end;
            local l__TICKER__15 = l__entityConfig__13.TICKER;
            if l__TICKER__15 then
                local l___ticker__16 = p9._ticker;
                if v13 and not v12 then
                    local _ = p9.isHalfTicked == false;
                    l___SetTickMode__10(p9, true);
                    u5 = u5 + 1;
                elseif v12 then
                    local _ = p9.isHalfTicked;
                    l___SetTickMode__10(p9, false);
                    u4 = u4 + 1;
                else
                    u6 = u6 + 1;
                end;
                if (v12 or v13) and p9._ticker ~= l__TICKER__15 then
                    l__Ticker__8.move(p9, l__TICKER__15);
                else
                    if not v12 and (not v13 and l___ticker__16) then
                        l___SetTickMode__10(p9, nil);
                        l__Ticker__8.Remove(l___ticker__16, p9);
                    end;
                end;
            end;
        end;
    end;
end;
local u21 = nil;
local u22 = 0;
local function u31() --[[ Line: 175 ]]
    -- upvalues: u22 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (copy), l__idMap__11 (copy), u20 (copy), u2 (ref), u21 (ref), l__Stats__5 (copy), u8 (copy)
    u22 = 0;
    u4 = 0;
    u5 = 0;
    u6 = 0;
    for v23, _ in u7 do
        table.clear(v23._TEMP_HALF);
        table.clear(v23._TEMP_NORMAL);
    end;
    debug.profilebegin("EntityGrid.Update");
    local v24 = os.clock();
    local v25 = 0;
    local v26 = 1;
    for _, v27 in l__idMap__11 do
        debug.profilebegin("Check One");
        u20(v27);
        v25 = v25 + 1;
        debug.profileend();
        if u2 < os.clock() - v24 then
            v26 = v26 + 1;
            debug.profileend();
            u22 = u22 + (os.clock() - v24);
            u21 = coroutine.running();
            coroutine.yield();
            u21 = nil;
            v24 = os.clock();
            debug.profilebegin("EntityGrid.ResumeUpdate");
        end;
    end;
    debug.profileend();
    u22 = u22 + (os.clock() - v24);
    l__Stats__5.SERVER.GRID_UPDATE_SECTIONS = v26;
    l__Stats__5.SERVER.ENTITY_GRID_UPDATE_TIME_MS = u22 * 1000;
    l__Stats__5.SERVER.NUMBER_OF_ENTITIES = v25;
    l__Stats__5.SERVER.ENTITIES_FULL_TICKED = u4;
    l__Stats__5.SERVER.ENTITIES_HALF_TICKED = u5;
    l__Stats__5.SERVER.NON_TICKED = u6;
    for _, v28 in u8 do
        local l___TEMP_NORMAL__17 = v28._TEMP_NORMAL;
        local l___TEMP_HALF__18 = v28._TEMP_HALF;
        table.clear(v28.HALF);
        table.clear(v28.NORMAL);
        for _, v29 in l___TEMP_NORMAL__17 do
            table.insert(v28.NORMAL, v29);
        end;
        for _, v30 in l___TEMP_HALF__18 do
            table.insert(v28.HALF, v30);
        end;
    end;
end;
local function v32() --[[ Line: 227 ]]
    -- upvalues: u21 (ref), u3 (ref), u1 (ref), l__Config__3 (copy), u2 (ref), u31 (copy)
    if u21 then
        task.spawn(u21);
    elseif os.clock() - u3 < u1 then
    else
        u1 = l__Config__3._GetConfig("GRID_UPDATE_INTERVAL") or u1;
        u2 = l__Config__3._GetConfig("GRID_MAX_UPDATE_TIME") or u2;
        u3 = os.clock();
        task.spawn(u31);
    end;
end;
local function v36(p33, p34) --[[ Line: 242 ]]
    -- upvalues: u8 (copy), u7 (copy)
    local v35 = u8[p33];
    if v35 then
        u7[v35] = p34;
    end;
end;
local function v38(p37) --[[ Line: 250 ]]
    -- upvalues: u8 (copy)
    return u8[p37];
end;
local function v41(p39) --[[ Line: 254 ]]
    -- upvalues: u8 (copy), u7 (copy)
    if u8[p39] then
    else
        local v40 = {
            PLAYER = p39,
            HALF = {},
            NORMAL = {},
            REPLICATED = {},
            _TEMP_HALF = {},
            _TEMP_NORMAL = {}
        };
        u8[p39] = v40;
        u7[v40] = Vector3.new(0, 0, 0);
    end;
end;
if l__RunService__2:IsServer() then
    l__Shared__6.Remotes.ClientLoaded.OnServerEvent:Connect(v41);
    l__Players__1.PlayerRemoving:Connect(function(p42) --[[ Line: 272 ]]
        -- upvalues: u8 (copy), u7 (copy)
        local v43 = u8[p42];
        if v43 then
            u7[v43] = nil;
            u8[p42] = nil;
        end;
    end);
end;
return {
    Update = v32,
    UpdatePlayerPosition = v36,
    GetEntityHolder = v38
};
