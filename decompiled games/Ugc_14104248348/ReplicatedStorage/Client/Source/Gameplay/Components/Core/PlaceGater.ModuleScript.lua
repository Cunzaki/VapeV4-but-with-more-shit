-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Core.PlaceGater
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Players__2 = game:GetService("Players");
local l__LocalPlayer__3 = l__Players__2.LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__4:GetEvent("PlaceGatorInteract");
l__Mince__4:Get("DrinkCreator");
local u2 = l__Mince__4:Get("InterfaceHandler");
l__Mince__4:Get("SelectInteractor");
local u3 = {
    Connections = {},
    Elements = {}
};
local u4 = l__Mince__4.Component({
    Tag = "PlaceGater"
});
function CreateProximityPrompt(p5, p6)
    local v7 = Instance.new("ProximityPrompt");
    v7:SetAttribute("Type", "Radial");
    v7:SetAttribute("SizeMultipler", 2);
    v7.ObjectText = p5;
    v7.MaxActivationDistance = 5;
    v7.Style = Enum.ProximityPromptStyle.Custom;
    v7.RequiresLineOfSight = false;
    v7.Parent = p6;
    p6.Transparency = 1;
    return v7;
end;
function u4.Construct(u8) --[[ Line: 41 ]]
    -- upvalues: u1 (copy)
    local l__Exit__5 = u8.Instance:WaitForChild("Exit");
    local l__Enter__6 = u8.Instance:WaitForChild("Enter");
    local l__Exit__7 = u8.Instance:WaitForChild("Exit");
    u8.Teleport = l__Exit__5.Position;
    CreateProximityPrompt(`Enter '{u8.Name}'`, l__Enter__6).Triggered:Connect(function() --[[ Line: 48 ]]
        -- upvalues: u1 (ref), u8 (copy)
        u1:Fire(u8.Instance, "Enter");
    end);
    CreateProximityPrompt(`Leave '{u8.Name}`, l__Exit__7).Triggered:Connect(function() --[[ Line: 52 ]]
        -- upvalues: u1 (ref), u8 (copy)
        u1:Fire(u8.Instance, "Leave");
    end);
end;
function u4.LoadBioDetails(p9) --[[ Line: 58 ]]
    -- upvalues: u4 (copy)
    u4.BioFrame.Visible = true;
    u4.BioFrame.BioText.Text = p9.Bio;
    u4.BioFrame.PlayersName.Text = `{p9.Player.Name}'s Bio:`;
    local v10 = game.Players:GetUserThumbnailAsync(p9.Player.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size60x60);
    u4.BioFrame.ProfileItem.Image = v10;
end;
function u4.StartGaterUIPreview(u11) --[[ Line: 66 ]]
    -- upvalues: u4 (copy), u3 (copy), l__ReplicatedStorage__1 (copy), l__Players__2 (copy), u2 (copy)
    u4:EndGaterUIPreview();
    u4.Interface.PlaceName.Text = u11.Name;
    u3.LastEntered = u11;
    u4.Interface.Capacity.Visible = not u11.IgnoreCapacity;
    local function v12() --[[ Line: 74 ]]
        -- upvalues: u4 (ref), u11 (copy)
        u4.Interface.Capacity.Text = `{u11.Count}/{u11.Capacity}`;
    end;
    local function u18(p13) --[[ Line: 78 ]]
        -- upvalues: u3 (ref), l__ReplicatedStorage__1 (ref), u4 (ref), l__Players__2 (ref), u2 (ref)
        if u3.Elements[p13] then
        else
            local v14 = l__ReplicatedStorage__1.Assets.Interface.PlayerContainer:Clone();
            v14.Parent = u4.Interface.Container;
            u3.Elements[p13] = v14;
            local v15 = l__Players__2:GetUserThumbnailAsync(p13, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size60x60);
            v14.Thumbnail.Image = v15;
            local v16 = l__ReplicatedStorage__1.Matchmaking:FindFirstChild(p13);
            if v16 then
                local u17 = v16:GetAttributes();
                u17.Player = l__Players__2:GetPlayerByUserId(p13);
                u2.NewButton(v14.Thumbnail).Activated:Connect(function() --[[ Line: 93 ]]
                    -- upvalues: u4 (ref), u17 (copy)
                    u4.LoadBioDetails(u17);
                end);
            end;
        end;
    end;
    for _, v19 in u11.Instance.Blockers:GetChildren() do
        v19.Transparency = 1;
    end;
    task.delay(0.3, function() --[[ Line: 110 ]]
        -- upvalues: u4 (ref)
        u4.Interface.Visible = true;
    end);
    for _, u20 in u11.Instance.Players:GetChildren() do
        task.defer(function() --[[ Line: 113 ]]
            -- upvalues: u18 (copy), u20 (copy)
            u18((tonumber(u20.Name)));
        end);
    end;
    task.defer(v12);
    u3.Connections.CountUpdated = u11.Instance:GetAttributeChangedSignal("Count"):Connect(v12);
    u3.Connections.ChildRemoved = u11.Instance.Players.ChildRemoved:Connect(function(p21) --[[ Line: 121 ]]
        -- upvalues: u3 (ref)
        local v22 = tonumber(p21.Name);
        if u3.Elements[v22] then
            u3.Elements[v22]:Destroy();
            u3.Elements[v22] = nil;
        end;
    end);
    u3.Connections.ChildAdded = u11.Instance.Players.ChildAdded:Connect(function(p23) --[[ Line: 124 ]]
        -- upvalues: u18 (copy)
        u18((tonumber(p23.Name)));
    end);
end;
function u4.EndGaterUIPreview(_) --[[ Line: 129 ]]
    -- upvalues: u4 (copy), u3 (copy)
    u4.Interface.Visible = false;
    for _, v24 in u3.Connections do
        v24:Disconnect();
    end;
    u3.Connections = {};
    for _, v25 in u3.Elements do
        v25:Destroy();
    end;
    u3.Elements = {};
    if u3.LastEntered then
        for _, v26 in u3.LastEntered.Instance.Blockers:GetChildren() do
            v26.Transparency = 0;
        end;
    end;
end;
local function u30(u27) --[[ Line: 151 ]]
    -- upvalues: l__LocalPlayer__3 (copy), u4 (copy), u30 (ref)
    if (u27 or 0) > 5 then
    else
        local v28 = l__LocalPlayer__3:GetAttribute("PlaceGater");
        if v28 then
            local v29 = u4:Get((game.Workspace.PlaceGaters:FindFirstChild(v28)));
            if v29 then
                v29:StartGaterUIPreview();
            else
                task.delay(1, function() --[[ Line: 162 ]]
                    -- upvalues: u30 (ref), u27 (copy)
                    u30((u27 or 0) + 1);
                end);
                warn((`Could not find the associated component with the ID {v28} retrying in 5 seconds... retries({u27 or 0})`));
            end;
        else
            u4:EndGaterUIPreview();
        end;
    end;
end;
function u4.Setup() --[[ Line: 169 ]]
    -- upvalues: u2 (copy), u4 (copy), l__LocalPlayer__3 (copy), u30 (ref)
    local v31 = u2.GetScreenGui("Matching");
    u4.Interface = u2.GetScreenGui("MainPriority").PlaceGater;
    u4.BioFrame = v31.BioFrame;
    l__LocalPlayer__3:GetAttributeChangedSignal("PlaceGater"):Connect(u30);
    u30();
end;
return u4;
