-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.RegionHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Players__2 = game:GetService("Players");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Signal__4 = require(l__ReplicatedStorage__1.Modules.Signal);
require(l__ReplicatedStorage__1.Modules.microid);
local u1 = require(l__ReplicatedStorage__1.Modules.PlayerConnections).Get();
local u2 = l__Mince__3:Get("AnalyticsTracker");
local u3 = l__Mince__3:Get("TriggerHandler");
local u4 = l__Mince__3:Get("InterfaceHandler");
local u5 = l__Mince__3:Get("LeaderboardReplicator");
local v6 = l__Mince__3:GetEvent("SyncRegion");
local u7 = v6:Extend("Add");
local u8 = v6:Extend("Remove");
local u9 = {};
local u10 = {
    PlayerAdded = l__Signal__4.new(),
    PlayerRemoved = l__Signal__4.new()
};
u10.__index = u10;
function u10.new(p11) --[[ Line: 26 ]]
    -- upvalues: u10 (copy)
    local v12 = setmetatable(p11, u10);
    v12:Init();
    return v12;
end;
function u10.Init(p13) --[[ Line: 32 ]]
    -- upvalues: l__Signal__4 (copy)
    p13.Added = l__Signal__4.new();
    p13.Removed = l__Signal__4.new();
    p13.Players = {};
end;
function u10.Has(p14, p15) --[[ Line: 39 ]]
    return p14.Players[p15] ~= nil;
end;
function u10.Add(p16, p17) --[[ Line: 43 ]]
    -- upvalues: u10 (copy), u9 (copy)
    if not p16.Players[p17] then
        p16.Players[p17] = p17;
        p16.Added:Fire(p17);
        u10.PlayerAdded:Fire(p17, p16);
        if not u9[p17] then
            u9[p17] = {};
        end;
        u9[p17][p16] = true;
    end;
end;
function u10.Remove(p18, p19) --[[ Line: 56 ]]
    -- upvalues: u10 (copy), u9 (copy)
    if p18.Players[p19] then
        p18.Players[p19] = nil;
        p18.Removed:Fire(p19);
        u10.PlayerRemoved:Fire(p19, p18);
        if u9[p19] then
            u9[p19][p18] = nil;
            if not next(u9[p19]) then
                u9[p19] = nil;
            end;
        end;
    end;
end;
function u10.GetPlayers(p20) --[[ Line: 72 ]]
    local v21 = {};
    for _, v22 in p20.Players do
        table.insert(v21, v22);
    end;
    return v21;
end;
local u23 = {
    RegionInd = "REGION_",
    RegionData = {},
    RegionConfig = {},
    RegionExistanceMaster = u9,
    EventRecords = {}
};
function u23.IsPlayerInRegion(p24) --[[ Line: 92 ]]
    -- upvalues: u23 (copy)
    local v25 = u23.RegionExistanceMaster[p24];
    if v25 then
        return next(v25) ~= nil;
    else
        return false;
    end;
end;
function u23.GetPlayerRegionsFast(p26) --[[ Line: 101 ]]
    -- upvalues: u23 (copy)
    local v27 = u23.RegionExistanceMaster[p26];
    if not v27 then
        return {};
    end;
    local v28 = {};
    for v29, _ in v27 do
        if v29:Has(p26) then
            table.insert(v28, v29);
        end;
    end;
    return v28;
end;
function u23.GetEventRecord(p30, p31, p32) --[[ Line: 117 ]]
    -- upvalues: u23 (copy), l__Signal__4 (copy)
    u23.EventRecords[p30] = u23.EventRecords[p30] or {};
    local v33 = u23.EventRecords[p30][p31] == nil;
    u23.EventRecords[p30][p31] = u23.EventRecords[p30][p31] or l__Signal__4.new();
    if v33 then
        p32(u23.EventRecords[p30][p31]);
    end;
    return u23.EventRecords[p30][p31];
end;
function u23.GetPlayerRegionsChangedSignal(u34) --[[ Line: 128 ]]
    -- upvalues: u23 (copy), u10 (copy)
    return u23.GetEventRecord(u34, "PlayerRegionsChanged", function(u35) --[[ Line: 129 ]]
        -- upvalues: u10 (ref), u34 (copy), u23 (ref)
        u10.PlayerAdded:Connect(function(p36, _) --[[ Line: 130 ]]
            -- upvalues: u34 (ref), u35 (copy), u23 (ref)
            if u34 == p36 then
                u35:Fire(u23.GetPlayerRegions(u34));
            end;
        end);
        u10.PlayerRemoved:Connect(function(p37, _) --[[ Line: 135 ]]
            -- upvalues: u34 (ref), u35 (copy), u23 (ref)
            if u34 == p37 then
                u35:Fire(u23.GetPlayerRegions(u34));
            end;
        end);
    end);
end;
function u23.GetPlayerRegionsEvents(p38) --[[ Line: 143 ]]
    -- upvalues: l__Signal__4 (copy), u23 (copy)
    local u39 = {};
    local u40 = l__Signal__4.new();
    local u41 = l__Signal__4.new();
    u23.GetPlayerRegionsChangedSignal(p38):Connect(function(p42) --[[ Line: 146 ]]
        -- upvalues: u39 (copy), u40 (copy), u41 (copy)
        local v43 = {};
        for _, v44 in p42 do
            if not u39[v44] then
                u40:Fire(v44);
                u39[v44] = true;
            end;
            v43[v44] = true;
        end;
        for v45, _ in u39 do
            if not v43[v45] then
                u41:Fire(v45);
                u39[v45] = nil;
            end;
        end;
    end);
    return {
        Added = u40,
        Removed = u41
    };
end;
function u23.GetPlayerRegionsPlayerAddingRemoving(p46) --[[ Line: 171 ]]
    -- upvalues: l__Signal__4 (copy), u23 (copy)
    local u47 = {};
    local u48 = {};
    local u49 = l__Signal__4.new();
    local u50 = l__Signal__4.new();
    local v51 = u23.GetPlayerRegionsEvents(p46);
    v51.Added:Connect(function(u52) --[[ Line: 203 ]]
        -- upvalues: u47 (copy), u48 (copy), u49 (copy), u50 (copy)
        if not u47[u52] then
            local v53 = {
                Events = {}
            };
            for _, v54 in u52:GetPlayers() do
                local v55 = u48[v54] == nil;
                u48[v54] = u48[v54] or {};
                u48[v54][u52] = true;
                if v55 then
                    u49:Fire(v54);
                end;
            end;
            v53.Events.Added = u52.Added:Connect(function(p56) --[[ Line: 213 ]]
                -- upvalues: u52 (copy), u48 (ref), u49 (ref)
                local v57 = u52;
                local v58 = u48[p56] == nil;
                u48[p56] = u48[p56] or {};
                u48[p56][v57] = true;
                if v58 then
                    u49:Fire(p56);
                end;
            end);
            v53.Events.Removed = u52.Removed:Connect(function(p59) --[[ Line: 217 ]]
                -- upvalues: u52 (copy), u48 (ref), u50 (ref)
                local v60 = u52;
                if u48[p59] then
                    u48[p59][v60] = nil;
                    if not next(u48[p59]) then
                        u48[p59] = nil;
                        u50:Fire(p59);
                    end;
                end;
            end);
            u47[u52] = v53;
        end;
    end);
    v51.Removed:Connect(function(p61) --[[ Line: 226 ]]
        -- upvalues: u47 (copy), u48 (copy), u50 (copy)
        if u47[p61] then
            for _, v62 in u47[p61].Events do
                v62:Disconnect();
            end;
            for _, v63 in p61:GetPlayers() do
                if u48[v63] then
                    u48[v63][p61] = nil;
                    if not next(u48[v63]) then
                        u48[v63] = nil;
                        u50:Fire(v63);
                    end;
                end;
            end;
            u47[p61] = nil;
        end;
    end);
    return {
        Added = u49,
        Removed = u50
    }, v51;
end;
function u23.GetRegion(p64) --[[ Line: 251 ]]
    -- upvalues: u23 (copy), u10 (copy)
    assert(u23.RegionConfig[p64], "Not found in config!");
    if not u23.RegionData[p64] then
        u23.RegionData[p64] = u10.new(u23.RegionConfig[p64]);
    end;
    return u23.RegionData[p64];
end;
function u23.GetPlayerRegions(p65) --[[ Line: 261 ]]
    -- upvalues: u23 (copy)
    local v66 = {};
    for _, v67 in u23.RegionData do
        if v67:Has(p65) then
            table.insert(v66, v67);
        end;
    end;
    return v66;
end;
function u23.AddPlayerToRegion(p68, p69) --[[ Line: 272 ]]
    -- upvalues: u23 (copy)
    u23.GetRegion(p69):Add(p68);
end;
function u23.RemovePlayerFromRegion(p70, p71) --[[ Line: 278 ]]
    -- upvalues: u23 (copy)
    u23.GetRegion(p71):Remove(p70);
end;
function u23.RemovePlayerFromAllRegionsFast(p72) --[[ Line: 283 ]]
    -- upvalues: u23 (copy)
    for _, v73 in u23.GetPlayerRegionsFast(p72) do
        v73:Remove(p72);
    end;
end;
function u23.RemovePlayerFromAllRegions(p74) --[[ Line: 291 ]]
    -- upvalues: u23 (copy)
    for _, v75 in u23.GetPlayerRegions(p74) do
        v75:Remove(p74);
    end;
end;
function u23.PlayerCharacterAttributeChange(p76, p77, p78) --[[ Line: 299 ]]
    -- upvalues: u23 (copy)
    if p77:sub(1, #u23.RegionInd) == u23.RegionInd then
        local v79 = p77:sub(#u23.RegionInd + 1, #p77);
        if p78 then
            u23.AddPlayerToRegion(p76, v79);
            return;
        end;
        u23.RemovePlayerFromRegion(p76, v79);
    end;
end;
function u23.NewPlayerCharacter(u80, u81) --[[ Line: 314 ]]
    -- upvalues: u23 (copy), u1 (copy)
    u23.RemovePlayerFromAllRegionsFast(u80);
    u1:AddCharacterConnection(u80, u81.AttributeChanged:Connect(function(p82) --[[ Line: 324 ]]
        -- upvalues: u23 (ref), u80 (copy), u81 (copy)
        u23.PlayerCharacterAttributeChange(u80, p82, u81:GetAttribute(p82));
    end));
    for v83, v84 in u81:GetAttributes() do
        u23.PlayerCharacterAttributeChange(u80, v83, v84);
    end;
end;
function u23.PlayerRemoving(p85) --[[ Line: 333 ]]
    -- upvalues: u23 (copy)
    u23.RemovePlayerFromAllRegions(p85);
end;
function u23.PlayerAdded(u86) --[[ Line: 337 ]]
    -- upvalues: u1 (copy), u23 (copy)
    u1:AddPlayerConnection(u86, u86.CharacterAdded:Connect(function(p87) --[[ Line: 338 ]]
        -- upvalues: u23 (ref), u86 (copy)
        u23.NewPlayerCharacter(u86, p87);
    end));
    if u86.Character then
        u23.NewPlayerCharacter(u86, u86.Character);
    end;
end;
function u23.LoadRegions() --[[ Line: 345 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u23 (copy), u3 (copy), u7 (copy), u8 (copy)
    for _, v88 in l__ReplicatedStorage__1.Regions:GetChildren() do
        if not v88:GetAttribute("Disabled") then
            local u89 = v88:GetAttribute("RegionID");
            local _ = v88.Name;
            u23.RegionConfig[u89] = v88:GetAttributes();
            for _, v90 in v88:GetChildren() do
                if v90:IsA("BasePart") then
                    v90:SetAttribute("Name", u89);
                    u3.SetupTrigger(v90);
                end;
            end;
            local v91 = u3.GetTrigger(u89);
            v91.Entered:Connect(function() --[[ Line: 365 ]]
                -- upvalues: u7 (ref), u89 (copy)
                u7:Fire(u89);
            end);
            v91.Exited:Connect(function() --[[ Line: 369 ]]
                -- upvalues: u8 (ref), u89 (copy)
                u8:Fire(u89);
            end);
        end;
    end;
end;
function u23.Count(p92) --[[ Line: 375 ]]
    local v93 = 0;
    for _, _ in p92 do
        v93 = v93 + 1;
    end;
    return v93;
end;
function u23.SetupGUI() --[[ Line: 381 ]]
    -- upvalues: u23 (copy), l__ReplicatedStorage__1 (copy), u5 (copy), u2 (copy)
    local u94 = {};
    local v95, v96 = u23.GetPlayerRegionsPlayerAddingRemoving(game.Players.LocalPlayer);
    v95.Added:Connect(function(u97) --[[ Line: 384 ]]
        -- upvalues: u94 (copy), l__ReplicatedStorage__1 (ref), u23 (ref), u5 (ref)
        if not u94[u97] then
            local u98 = {
                GUI = l__ReplicatedStorage__1.Assets.Interface.PlayerTrack:Clone(),
                Position = #u94 + 1
            };
            u98.GUI.Visible = true;
            u98.GUI.Parent = u23.MainPriority.Right.PlayerTracker;
            task.spawn(function() --[[ Line: 395 ]]
                -- upvalues: u98 (copy), u5 (ref), u97 (copy)
                u98.GUI.PlayerIcon.Image = u5.GetThumbnail(u97.UserId);
                u98.GUI.Visible = true;
            end);
            u94[u97] = u98;
            table.insert(u94, u98);
        end;
    end);
    v95.Removed:Connect(function(p99) --[[ Line: 408 ]]
        -- upvalues: u94 (copy)
        if u94[p99] then
            u94[p99].GUI:Destroy();
            u94[p99] = nil;
        end;
    end);
    v96.Added:Connect(function(p100) --[[ Line: 419 ]]
        -- upvalues: u2 (ref)
        u2.RegionEntered(p100.Name, true);
    end);
    v96.Removed:Connect(function(p101) --[[ Line: 423 ]]
        -- upvalues: u2 (ref)
        u2.RegionEntered(p101.Name, false);
    end);
    u23.GetPlayerRegionsChangedSignal(game.Players.LocalPlayer):Connect(function(p102) --[[ Line: 427 ]]
        -- upvalues: u23 (ref)
        local v103 = "";
        local v104 = false;
        for v105, v106 in p102 do
            v103 = v103 .. v106.Name;
            if v105 ~= #p102 then
                v103 = v103 .. ", ";
            end;
            if v106.HidePlayerTracker then
                v104 = true;
            end;
        end;
        u23.MainPriority.Right.RegionText.Text = v103;
        u23.MainPriority.Right.RegionText.Visible = #p102 > 0;
        local l__PlayerTracker__5 = u23.MainPriority.Right.PlayerTracker;
        local v107;
        if #p102 > 0 then
            v107 = not v104;
        else
            v107 = false;
        end;
        l__PlayerTracker__5.Visible = v107;
    end);
end;
function u23.Setup() --[[ Line: 449 ]]
    -- upvalues: u23 (copy), l__Players__2 (copy), u4 (copy)
    u23.LoadRegions();
    for _, v108 in l__Players__2:GetPlayers() do
        task.defer(u23.PlayerAdded, v108);
    end;
    l__Players__2.PlayerAdded:Connect(u23.PlayerAdded);
    l__Players__2.PlayerRemoving:Connect(u23.PlayerRemoving);
    u23.MainPriority = u4.GetScreenGui("MainPriority");
    u23.SetupGUI();
end;
return u23;
