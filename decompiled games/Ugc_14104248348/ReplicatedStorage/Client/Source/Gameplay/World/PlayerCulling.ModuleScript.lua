-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.PlayerCulling
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__StarterPlayer__2 = game:GetService("StarterPlayer");
game:GetService("ConfigService");
game:GetService("RunService");
local l__Workspace__3 = game:GetService("Workspace");
local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Regions__6 = require(l__ReplicatedStorage__1.Config.Regions);
local l__Utility__7 = require(l__ReplicatedStorage__1.Modules.Utility);
local u1 = require(l__ReplicatedStorage__1.Modules.PlayerConnections).Get();
local u2 = l__Mince__5:Get("WorldCulling");
l__Mince__5:Get("ConfigHandler");
local u3 = l__Mince__5:Get("CharacterSounds");
local u4 = l__Mince__5:GetEvent("SyncCullingRegion");
local v5 = Instance.new("Folder");
v5.Name = "CharacterStorage";
v5.Parent = game.ReplicatedStorage;
local u6 = {
    Disabled = false,
    MaxServerAdjustSyncRate = 0.1,
    TimeElapsed = 0,
    UpdateRegionsInRate = 0.1,
    VisibleRegions = {},
    VisibleRegionsWhenOutside = {},
    LoadedCharacters = {},
    RegionsIn = {},
    PlayerInLocalVisibleRegions = {},
    LastSync = os.clock()
};
function u6.Update(_, p7) --[[ Line: 39 ]]
    -- upvalues: u2 (copy), u6 (copy), l__LocalPlayer__4 (copy), u4 (copy)
    if u2.Disabled then
        local v8 = u6;
        v8.TimeElapsed = v8.TimeElapsed + p7;
        if u6.TimeElapsed > u6.UpdateRegionsInRate then
            local v9 = u6;
            v9.TimeElapsed = v9.TimeElapsed - u6.UpdateRegionsInRate;
            u6:UpdateRegionsIn(u6:GetInRegionsIn());
        end;
    end;
    if l__LocalPlayer__4.Character then
        if os.clock() - u6.LastSync < u6.MaxServerAdjustSyncRate then
        else
            local v10 = u6:GenerateString(u6.RegionsIn);
            if v10 ~= l__LocalPlayer__4.Character:GetAttribute("CullRegions") then
                u4:Fire(u6.RegionsIn);
                u6.LastSync = os.clock();
                warn("ClientSync Because out of sync with server");
                warn(v10, l__LocalPlayer__4.Character:GetAttribute("CullRegions"));
            end;
        end;
    end;
end;
function u6.SetVisible(_, p11, p12) --[[ Line: 65 ]]
    -- upvalues: u3 (copy), u6 (copy)
    if p11.Visible == p12 then
    else
        local v13 = u3.GetCharacterMap(p11.Character);
        if v13 then
            v13.Enabled = false;
        end;
        if p11.Player:GetAttribute("Ragdolled") then
        else
            p11.Visible = p12;
            u6.PlayerInLocalVisibleRegions[p11.Player] = p12 and true or nil;
        end;
    end;
end;
function u6.SetVisibleBasedOnRegions(_, p14) --[[ Line: 90 ]]
    -- upvalues: u6 (copy)
    if not (p14.RegionsIn and next(p14.RegionsIn)) then
        u6:SetVisible(p14, true);
        return;
    end;
    local v15 = false;
    for _, v16 in p14.RegionsIn do
        if u6.VisibleRegions[v16] then
            v15 = true;
            break;
        end;
    end;
    u6:SetVisible(p14, v15);
end;
function u6.PlayerCharacterAdded(_, u17, u18) --[[ Line: 111 ]]
    -- upvalues: u6 (copy)
    u6:ClearInstances(u17);
    local u19 = {
        Events = {},
        Character = u18,
        Player = u17,
        HideParts = {}
    };
    for _, v20 in u18:GetDescendants() do
        if v20:IsA("BasePart") then
            table.insert(u19.HideParts, v20);
        end;
    end;
    u19.Events.CharacterRemoving = u18.AncestryChanged:Connect(function() --[[ Line: 127 ]]
        -- upvalues: u18 (copy), u6 (ref), u17 (copy)
        if u18.Parent == nil then
            u6:ClearInstances(u17);
        end;
    end);
    u19.Events.UpdateCullRegions = u18:GetAttributeChangedSignal("CullRegions"):Connect(function() --[[ Line: 133 ]]
        -- upvalues: u6 (ref), u19 (copy)
        u6:UpdateCullRegions(u19);
    end);
    u6.LoadedCharacters[u17] = u19;
    u6:UpdateCullRegions(u19);
end;
function u6.UpdateCullRegions(_, p21) --[[ Line: 142 ]]
    -- upvalues: u6 (copy)
    local v22 = p21.Character:GetAttribute("CullRegions");
    if v22 then
        v22 = string.split(v22, ":");
    end;
    p21.RegionsIn = v22;
    u6:SetVisibleBasedOnRegions(p21);
end;
function u6.ClearInstances(_, p23) --[[ Line: 153 ]]
    -- upvalues: u6 (copy)
    local v24 = u6.LoadedCharacters[p23];
    if v24 then
        for _, v25 in v24.Events do
            v25:Disconnect();
        end;
        u6.LoadedCharacters[p23] = nil;
    end;
end;
function u6.PlayerAdded(_, u26) --[[ Line: 167 ]]
    -- upvalues: u6 (copy), l__LocalPlayer__4 (copy), u1 (copy)
    if u6.ActuallyCullPlayers then
        if u26 == l__LocalPlayer__4 then
        else
            u1:AddPlayerConnection(u26, u26.CharacterAdded:Connect(function() --[[ Line: 171 ]]
                -- upvalues: u6 (ref), u26 (copy)
                u6:PlayerCharacterAdded(u26, u26.Character);
            end));
            if u26.Character then
                u6:PlayerCharacterAdded(u26, u26.Character);
            end;
        end;
    end;
end;
function u6.IsInRegion(p27, p28) --[[ Line: 180 ]]
    -- upvalues: l__Regions__6 (copy)
    for _, v29 in l__Regions__6[p27].Bounds do
        local v30 = v29.CFrame:Inverse() * p28;
        local v31 = v29.Size / 2;
        if math.abs(v30.X) <= v31.X and (math.abs(v30.Y) <= v31.Y and math.abs(v30.Z) <= v31.Z) then
            return true;
        end;
    end;
    return false;
end;
function u6.GetInRegionsIn(_) --[[ Line: 191 ]]
    -- upvalues: l__Workspace__3 (copy), l__StarterPlayer__2 (copy), l__Regions__6 (copy), u6 (copy)
    local v32 = nil;
    local l__CurrentCamera__8 = l__Workspace__3.CurrentCamera;
    local l__Position__9 = l__CurrentCamera__8:GetRenderCFrame().Position;
    if l__CurrentCamera__8.CameraSubject and l__CurrentCamera__8.CameraSubject:IsA("Humanoid") then
        if l__CurrentCamera__8.CameraSubject.RootPart then
            v32 = l__CurrentCamera__8.CameraSubject.RootPart.Position;
            if (v32 - l__Position__9).Magnitude > l__StarterPlayer__2.CameraMaxZoomDistance * 1.1 then
                if not l__CurrentCamera__8.CameraSubject:GetAttribute("DebugIgnoreDistance") then
                    v32 = l__Position__9;
                end;
            end;
        end;
        v32 = l__CurrentCamera__8.CameraSubject:GetAttribute("RenderFocus") or v32;
    end;
    local v33 = v32 or l__Position__9;
    local v34 = {};
    for v35, _ in l__Regions__6 do
        if u6.IsInRegion(v35, v33) then
            v34[v35] = true;
        end;
    end;
    return v34;
end;
function u6.UpdateRegionsIn(_, p36) --[[ Line: 217 ]]
    -- upvalues: u6 (copy), u4 (copy), l__Regions__6 (copy), l__Utility__7 (copy), l__Mince__5 (copy)
    u6.RegionsIn = p36;
    u4:Fire(p36);
    u6.LastSync = os.clock();
    local l__VisibleRegions__10 = u6.VisibleRegions;
    local v37 = {};
    for v38, _ in p36 or {} do
        local v39 = l__Regions__6[v38];
        local v40 = `Failed to get the '{v38}' regiondata!`;
        assert(v39, v40);
        v37[v38] = true;
        for _, v41 in v39.ConnectedTo or {} do
            v37[v41] = true;
        end;
        for _, v42 in v39.VoiceConnectedTo or {} do
            v37[v42] = true;
        end;
    end;
    if p36 and next(p36) then
        u6.VisibleRegions = v37;
    else
        u6.VisibleRegions = u6.VisibleRegionsWhenOutside;
    end;
    if u6.ActuallyCullPlayers and not l__Utility__7.TableEq(l__VisibleRegions__10, u6.VisibleRegions) then
        for _, v43 in u6.LoadedCharacters do
            u6:SetVisibleBasedOnRegions(v43);
        end;
    end;
    l__Mince__5.Config.Stats.PlayerCulling[2] = `DetectedRegion: {u6:GenerateString(p36) or "Outside"}`;
end;
function u6.GenerateString(_, p44) --[[ Line: 254 ]]
    if p44 then
        if next(p44) then
            local v45 = "";
            for v46, _ in p44 do
                v45 = v45 .. v46 .. ":";
            end;
            return v45:sub(1, -2);
        end;
    end;
end;
function u6.IsBeingCulled(_, p47) --[[ Line: 270 ]]
    -- upvalues: u6 (copy), l__LocalPlayer__4 (copy)
    if u6.ActuallyCullPlayers then
        if p47 == l__LocalPlayer__4 then
            return false;
        else
            return not u6.PlayerInLocalVisibleRegions[p47];
        end;
    else
        return false;
    end;
end;
function u6.Setup(_) --[[ Line: 282 ]]
    -- upvalues: u6 (copy)
    if u6.Disabled then
    end;
end;
return u6;
