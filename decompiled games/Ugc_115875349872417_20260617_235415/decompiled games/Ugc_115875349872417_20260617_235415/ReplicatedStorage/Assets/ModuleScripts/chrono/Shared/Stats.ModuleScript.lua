-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Shared.Stats
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__Config__3 = require(script.Parent.Config);
local l__Entity__4 = require(script.Parent.Entity);
local l__Holder__5 = require(script.Parent.Holder);
require(script.Parent.Types);
local u2 = {
    REPLICATE_PERMISSIONS = {},
    CLIENT = {
        _PAUSE = false,
        TOTAL_ENTITIES_CULLED = 0,
        ENTITIES_MOVED_THIS_FRAME = 0,
        TOTAL_CLIENT_ENTITIES_CHECKED_THIS_FRAME = 0,
        TOTAL_CLIENT_ENTITIES = 0,
        AVG_INTERPOLATION_TIME_MS = 0,
        BYTES_RECEIVED_PER_SEC = 0,
        NEW_ENTITIES_PER_SEC = 0,
        ENTITY_CHANGES_PER_SEC = 0,
        ENTITY_REMOVALS_PER_SEC = 0,
        CLIENT_ENTITIES = {}
    },
    SERVER = {
        _SHOULD_REPLICATE = false,
        AVG_TICKER_TIME_MS = 0,
        ENTITY_GRID_UPDATE_TIME_MS = 0,
        GRID_UPDATE_SECTIONS = 0,
        NUMBER_OF_ENTITIES = 0,
        NON_TICKED = 0,
        ENTITIES_FULL_TICKED = 0,
        ENTITIES_HALF_TICKED = 0,
        REPLICATE_PLAYER_TIME_MS = 0,
        BYTES_RECEIVED_PER_SEC = 0,
        BYTES_SENT_PER_SEC = 0,
        PACKETS_SENT_PER_SEC = 0,
        SERVER_ENTITIES = {}
    },
    HasPermissionToReplicate = function(p1) --[[ Name: HasPermissionToReplicate, Line 56 ]]
        if typeof(p1) == "Instance" and p1:IsA("Player") then
            p1 = p1.UserId;
        end;
        return script:GetAttribute((tostring(p1))) == true;
    end
};
function u2.ReplicateStatsForPlayer(p3) --[[ Line: 63 ]]
    -- upvalues: l__RunService__2 (copy), u2 (copy)
    if l__RunService__2:IsClient() then
        warn("Stats.ReplicateStatsForPlayer should only be called on the server.");
    else
        if typeof(p3) == "Instance" and p3:IsA("Player") then
            p3 = p3.UserId;
        end;
        u2.REPLICATE_PERMISSIONS[p3] = true;
        script:SetAttribute(tostring(p3), true);
    end;
end;
function u2.StopReplicatingStatsForPlayer(p4) --[[ Line: 75 ]]
    -- upvalues: l__RunService__2 (copy), u2 (copy)
    if l__RunService__2:IsClient() then
        warn("Stats.StopReplicatingStatsForPlayer should only be called on the server.");
    else
        if typeof(p4) == "Instance" and p4:IsA("Player") then
            p4 = p4.UserId;
        end;
        u2.REPLICATE_PERMISSIONS[p4] = nil;
        script:SetAttribute(tostring(p4), false);
    end;
end;
local u5 = {};
for v6, v7 in u2.REPLICATE_PERMISSIONS do
    script:SetAttribute(tostring(v6), v7);
end;
if l__RunService__2:IsServer() then
    local u8 = Instance.new("RemoteEvent", script);
    u8.Name = "Stats";
    l__RunService__2.Heartbeat:Connect(function() --[[ Line: 111 ]]
        -- upvalues: u2 (copy), l__Players__1 (copy), u5 (copy), u8 (copy)
        local v9 = false;
        if next(u2.REPLICATE_PERMISSIONS) then
            for _, v10 in l__Players__1:GetPlayers() do
                if u2.REPLICATE_PERMISSIONS[v10.UserId] and u5[v10.UserId] then
                    u8:FireClient(v10, "REPLICATE_SERVER_STATS", u2.SERVER);
                    v9 = true;
                end;
            end;
        end;
        u2.SERVER._SHOULD_REPLICATE = v9;
    end);
    u8.OnServerEvent:Connect(function(p11, p12, ...) --[[ Line: 125 ]]
        -- upvalues: u5 (copy), u2 (copy), l__Config__3 (copy), u8 (copy), l__Holder__5 (copy), l__Entity__4 (copy)
        if p12 == "DEBUGGER_OPENED" then
            u5[p11.UserId] = ...;
        elseif u2.REPLICATE_PERMISSIONS and not u2.REPLICATE_PERMISSIONS[p11.UserId] then
        elseif p12 == "UPDATE_STAT" then
            local v13, v14, v15 = ...;
            if v14 == "WARNING_SEVERITY" then
                l__Config__3.SetWarningSeverity(v15);
            end;
            if v13 == "FFLAG" then
                l__Config__3.FLAGS[v14] = v15;
            end;
            u8:FireAllClients("UPDATE_STAT", v13, v14, v15);
        else
            if p12 == "CLIENT_STATS_ACTION" then
                local v16, v17 = ...;
                local v18 = l__Holder__5.GetEntityFromId(v17);
                if not v18 then
                    return;
                end;
                if v16 == "CHANGE_NATIVE" then
                    local v19 = l__Entity__4.GetModelReplicationType(v18);
                    if v19 == "NATIVE" then
                        l__Entity__4.LockNativeServerCFrameReplication(v18);
                        return;
                    end;
                    if v19 == "NATIVE_WITH_LOCK" then
                        l__Entity__4.UnlockNativeServerCFrameReplication(v18);
                    end;
                else
                    if v16 == "TOGGLE_PAUSE" then
                        if v18.paused then
                            l__Entity__4.ResumeReplication(v18);
                            return;
                        else
                            l__Entity__4.PauseReplication(v18);
                            return;
                        end;
                    end;
                    if v16 == "CHANGE_CONFIG" then
                        local v20 = select(3, ...);
                        l__Entity__4.SetConfig(v18, v20);
                    end;
                end;
            end;
        end;
    end);
    return u2;
end;
local l__Stats__6 = script:WaitForChild("Stats");
l__Stats__6.OnClientEvent:Connect(function(p21, ...) --[[ Name: handleServerEvent, Line 168 ]]
    -- upvalues: u2 (copy), l__Config__3 (copy)
    if p21 == "REPLICATE_SERVER_STATS" then
        local v22 = ...;
        if u2.CLIENT._PAUSE then
        else
            for v23, v24 in v22 do
                u2.SERVER[v23] = v24;
            end;
        end;
    else
        if p21 == "UPDATE_STAT" then
            local v25, v26, v27 = ...;
            if v26 == "WARNING_SEVERITY" then
                l__Config__3.SetWarningSeverity(v27);
            end;
            if v25 == "FFLAG" then
                l__Config__3.FLAGS[v26] = v27;
            end;
        end;
    end;
end);
function u2._openedDebugger() --[[ Line: 185 ]]
    -- upvalues: u2 (copy), l__Stats__6 (copy)
    u2.SERVER._SHOULD_REPLICATE = true;
    l__Stats__6:FireServer("DEBUGGER_OPENED", true);
end;
function u2._closedDebugger() --[[ Line: 189 ]]
    -- upvalues: u2 (copy), l__Stats__6 (copy)
    u2.SERVER._SHOULD_REPLICATE = false;
    l__Stats__6:FireServer("DEBUGGER_OPENED", false);
end;
function u2._updateStat(p28, p29, p30) --[[ Line: 194 ]]
    -- upvalues: l__Stats__6 (copy)
    l__Stats__6:FireServer("UPDATE_STAT", p28, p29, p30);
end;
function u2._fireClientStatsEvent(...) --[[ Line: 198 ]]
    -- upvalues: l__Stats__6 (copy)
    l__Stats__6:FireServer("CLIENT_STATS_ACTION", ...);
end;
return u2;
