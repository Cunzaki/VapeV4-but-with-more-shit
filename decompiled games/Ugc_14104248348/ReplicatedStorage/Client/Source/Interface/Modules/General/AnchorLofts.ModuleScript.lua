-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.AnchorLofts
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Players__2 = game:GetService("Players");
local l__LocalPlayer__3 = l__Players__2.LocalPlayer;
local l__Maid__4 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Signal__6 = require(l__ReplicatedStorage__1.Modules.Signal);
local u1 = l__Mince__5:Get("Notices");
local u2 = l__Mince__5:Get("SoundHandler");
local u3 = l__Mince__5:Get("ConfirmPrompt");
local u4 = l__Mince__5:Get("InterfaceHandler");
local v5 = l__Mince__5:GetEvent("ApartmentEvents");
local u6 = v5:Extend("JoinApartment");
local u7 = v5:Extend("AcceptRequest");
local u8 = v5:Extend("KnockApartment");
v5:Extend("LeaveApartment");
local u9 = v5:Extend("RequestCreateApartment");
local u10 = v5:Extend("RequestChangeApartmentSettings");
local u11 = {
    OtherStates = { "Viewer", "Creator" },
    LoadedItems = {},
    CycleButtonResetFns = {},
    CycleButtonSettingResetFns = {},
    ApartmentJoinLocal = l__Signal__6.new(),
    ApartmentLeaveLocal = l__Signal__6.new()
};
function u11.CreateApartmentItem(u12) --[[ Line: 38 ]]
    -- upvalues: u11 (copy), l__Maid__4 (copy), l__ReplicatedStorage__1 (copy), l__LocalPlayer__3 (copy), l__Players__2 (copy), u4 (copy), u8 (copy), u6 (copy)
    u11.CheckIfAddPartyEnabled();
    u12:WaitForChild("Players");
    local u13 = {
        Maid = l__Maid__4.new(),
        Elements = {},
        Name = u12.Name,
        Config = u12,
        Attributes = u12:GetAttributes(),
        UI = l__ReplicatedStorage__1.Assets.Interface.ApartmentPartyItem:Clone()
    };
    u13.Maid:Add(u13.UI);
    u13.UI.Parent = u11.Viewer;
    u13.UI.Info.PartyName.Text = u12.Name;
    u13.UI.Info.Options.KnockButton.Visible = u12:GetAttribute("KnockingEnabled");
    function u13.UpdatePrivacyButtons(_) --[[ Line: 61 ]]
        -- upvalues: u12 (copy), u13 (copy), l__LocalPlayer__3 (ref)
        local v14 = u12:GetAttribute("Privacy");
        u13.UI.Info.PartyName.Text = u12.Name;
        if v14 == "Public" then
            u13.UI.Info.Options.JoinButton.Visible = true;
        elseif v14 == "Friends" then
            u13.UI.Info.Options.JoinButton.Visible = l__LocalPlayer__3:IsFriendsWith(u12:GetAttribute("Owner"));
        elseif v14 == "Private" then
            u13.UI.Info.Options.JoinButton.Visible = false;
        end;
        if u13.UI.Info.Options.JoinButton.Visible then
            u13.UI.Info.Options.KnockButton.Visible = false;
        else
            u13.UI.Info.Options.KnockButton.Visible = u12:GetAttribute("KnockingEnabled");
        end;
    end;
    function u13.UpdateAllColors(p15) --[[ Line: 81 ]]
        -- upvalues: u12 (copy)
        local v16 = u12:GetAttribute("Owner");
        for v17, v18 in p15.Elements do
            v18.UIStroke.Color = v17 == v16 and Color3.new(1, 0.835294, 0) or Color3.new(0, 0, 0);
        end;
    end;
    function u13.Add(p19, p20) --[[ Line: 88 ]]
        -- upvalues: u13 (copy), u12 (copy), l__LocalPlayer__3 (ref), u11 (ref), l__ReplicatedStorage__1 (ref), l__Players__2 (ref)
        u13.UI.Info.Capacity.Text = `{#u12.Players:GetChildren() - 1}/5`;
        if p19.Elements[p20] then
        else
            if l__LocalPlayer__3.UserId == tonumber(p20) then
                warn("join local!");
                u11.ApartmentJoinLocal:Fire(u13);
            end;
            local v21 = l__ReplicatedStorage__1.Assets.Interface.ProfileItem2:Clone();
            v21.Parent = u13.UI.Players;
            p19.Elements[p20] = v21;
            v21.Image = l__Players__2:GetUserThumbnailAsync(p20, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100);
            u13:UpdateAllColors();
        end;
    end;
    function u13.Remove(p22, p23) --[[ Line: 110 ]]
        -- upvalues: l__LocalPlayer__3 (ref), u11 (ref), u13 (copy), u12 (copy)
        if l__LocalPlayer__3.UserId == tonumber(p23) then
            warn("LeaveLocal");
            u11.ApartmentLeaveLocal:Fire();
        end;
        u13.UI.Info.Capacity.Text = `{#u12.Players:GetChildren() - 1}/5`;
        if p22.Elements[p23] then
            p22.Elements[p23]:Destroy();
            p22.Elements[p23] = nil;
        end;
    end;
    function u13.Destroy(_) --[[ Line: 124 ]]
        -- upvalues: u13 (copy)
        u13.Maid:Clean();
    end;
    u4.NewButton(u13.UI.Info.Options.KnockButton).Activated:Connect(function() --[[ Line: 128 ]]
        -- upvalues: u8 (ref), u12 (copy)
        u8:Fire(u12);
    end);
    u4.NewButton(u13.UI.Info.Options.JoinButton).Activated:Connect(function() --[[ Line: 132 ]]
        -- upvalues: u6 (ref), u12 (copy)
        u6:Fire(u12);
    end);
    u12.Destroying:Connect(function() --[[ Line: 137 ]]
        -- upvalues: u13 (copy)
        u13:Destroy();
    end);
    for _, u24 in u12.Players:GetChildren() do
        task.defer(function() --[[ Line: 142 ]]
            -- upvalues: u13 (copy), u24 (copy)
            u13:Add((tonumber(u24.Name)));
        end);
    end;
    u13.Maid:Add(u12:GetPropertyChangedSignal("Name"):Connect(function() --[[ Line: 147 ]]
        -- upvalues: u13 (copy)
        u13:UpdatePrivacyButtons();
    end));
    u13.Maid:Add(u12:GetAttributeChangedSignal("KnockingEnabled"):Connect(function() --[[ Line: 151 ]]
        -- upvalues: u13 (copy)
        u13:UpdatePrivacyButtons();
    end));
    u13.Maid:Add(u12:GetAttributeChangedSignal("Privacy"):Connect(function() --[[ Line: 155 ]]
        -- upvalues: u13 (copy)
        u13:UpdatePrivacyButtons();
    end));
    u13.Maid:Add(u12:GetAttributeChangedSignal("Owner"):Connect(function() --[[ Line: 159 ]]
        -- upvalues: u13 (copy)
        u13:UpdatePrivacyButtons();
        u13:UpdateAllColors();
    end));
    u13.Maid:Add(u12.Players.ChildRemoved:Connect(function(p25) --[[ Line: 164 ]]
        -- upvalues: u13 (copy)
        u13:Remove((tonumber(p25.Name)));
    end));
    u13.Maid:Add(u12.Players.ChildAdded:Connect(function(p26) --[[ Line: 168 ]]
        -- upvalues: u13 (copy)
        u13:Add((tonumber(p26.Name)));
    end));
    task.defer(function() --[[ Line: 173 ]]
        -- upvalues: u13 (copy)
        u13:UpdatePrivacyButtons();
    end);
    u11.LoadedItems[u12] = u13;
end;
function u11.KnockRequest(u27) --[[ Line: 180 ]]
    -- upvalues: u2 (copy), u3 (copy), u7 (copy)
    u2.PlaySound("ApartmentKnock");
    u3.Display(`{u27.Name} is knocking! Let them in?`, function() --[[ Line: 182 ]]
        -- upvalues: u7 (ref), u27 (copy)
        u7:Fire(u27.UserId);
    end);
end;
function u11.ChangePartySettings() --[[ Line: 188 ]]
    -- upvalues: u11 (copy), l__LocalPlayer__3 (copy), u1 (copy), u10 (copy)
    local l__TweenFrame__7 = u11.Settings.TweenFrame;
    local v28 = l__TweenFrame__7.PartyName.Text or `{l__LocalPlayer__3.DisplayName}'s Apartment!`;
    if v28 and v28 ~= "" then
        local v29 = {
            PartyName = v28,
            AllowKnocking = ({
                Yes = true,
                No = false
            })[l__TweenFrame__7.KnockButton.Text] or false,
            Privacy = l__TweenFrame__7.PartyButton.Text
        };
        u11.Settings.Close();
        u10:Fire(v29);
    else
        u1.Error("Party name cannot be empty!");
    end;
end;
function u11.AttemptPartyCreation() --[[ Line: 211 ]]
    -- upvalues: u11 (copy), l__LocalPlayer__3 (copy), u1 (copy), u9 (copy)
    local v30 = u11.Creator.PartyName.Text or `{l__LocalPlayer__3.DisplayName}'s Apartment!`;
    if v30 and v30 ~= "" then
        if l__LocalPlayer__3.Character:GetAttribute("Ragdolled") then
            u1.Error("You\'re ragdolled!");
        else
            u9:Fire({
                PartyName = v30,
                AllowKnocking = ({
                    Yes = true,
                    No = false
                })[u11.Creator.KnockButton.Text] or false,
                Privacy = u11.Creator.PartyButton.Text
            });
            u11.Interface.Close();
            u11.SwitchToScreen("Viewer");
        end;
    else
        u1.Error("Party name cannot be empty!");
    end;
end;
function u11.CycleButton(u31, u32) --[[ Line: 240 ]]
    -- upvalues: u4 (copy)
    local u33 = 1;
    local v34 = u4.NewButton(u31);
    u31.Text = u32[u33];
    v34.Activated:Connect(function() --[[ Line: 246 ]]
        -- upvalues: u33 (ref), u32 (copy), u31 (copy)
        u33 = u33 + 1;
        if u33 > #u32 then
            u33 = 1;
        end;
        u31.Text = u32[u33];
    end);
    return function() --[[ Line: 255 ]]
        -- upvalues: u33 (ref), u31 (copy), u32 (copy)
        u33 = 1;
        u31.Text = u32[u33];
    end;
end;
function u11.ResetCreatorPage() --[[ Line: 261 ]]
    -- upvalues: u11 (copy)
    for _, v35 in u11.CycleButtonResetFns do
        v35();
    end;
    u11.Creator.PartyName.Text = "";
end;
function u11.CheckIfAddPartyEnabled() --[[ Line: 266 ]]
    -- upvalues: u11 (copy), l__ReplicatedStorage__1 (copy)
    u11.Viewer.AddParty.Visible = #l__ReplicatedStorage__1.Assets.Apartments:GetChildren() < 3;
end;
function u11.SwitchToScreen(p36) --[[ Line: 270 ]]
    -- upvalues: u11 (copy)
    for _, v37 in u11.OtherStates do
        u11.Interface.TweenFrame[v37].Visible = v37 == p36;
    end;
end;
function u11.OpenConfiguration() --[[ Line: 276 ]]
    -- upvalues: u11 (copy)
    u11.Settings.Open();
end;
function u11.SetupGUI() --[[ Line: 280 ]]
    -- upvalues: u4 (copy), u11 (copy)
    local v38 = u4.NewButton(u11.Viewer.AddParty.Button);
    local v39 = u4.NewButton(u11.Creator.BackButton);
    local v40 = u4.NewButton(u11.Creator.CreateButton);
    local v41 = u4.NewButton(u11.Interface.TweenFrame.CloseButton);
    table.insert(u11.CycleButtonResetFns, u11.CycleButton(u11.Creator.PartyButton, { "Public", "Friends", "Private" }));
    table.insert(u11.CycleButtonResetFns, u11.CycleButton(u11.Creator.KnockButton, { "Yes", "No" }));
    v39.Activated:Connect(function() --[[ Line: 290 ]]
        -- upvalues: u11 (ref)
        u11.SwitchToScreen("Viewer");
    end);
    v38.Activated:Connect(function() --[[ Line: 293 ]]
        -- upvalues: u11 (ref)
        u11.ResetCreatorPage();
        u11.SwitchToScreen("Creator");
    end);
    v40.Activated:Connect(u11.AttemptPartyCreation);
    v41.Activated:Connect(u11.Interface.Close);
    local l__TweenFrame__8 = u11.Settings.TweenFrame;
    local v42 = u4.NewButton(l__TweenFrame__8.CloseButton);
    local v43 = u4.NewButton(l__TweenFrame__8.ChangeButton);
    table.insert(u11.CycleButtonSettingResetFns, u11.CycleButton(l__TweenFrame__8.PartyButton, { "Public", "Friends", "Private" }));
    table.insert(u11.CycleButtonSettingResetFns, u11.CycleButton(l__TweenFrame__8.KnockButton, { "Yes", "No" }));
    v43.Activated:Connect(u11.ChangePartySettings);
    v42.Activated:Connect(u11.Settings.Close);
end;
function u11.Setup() --[[ Line: 314 ]]
    -- upvalues: u11 (copy), u4 (copy), l__ReplicatedStorage__1 (copy), u8 (copy), u6 (copy)
    u11.Interface = u4.Get("AnchorLofts");
    u11.Settings = u4.Get("AnchorSettings");
    u11.Viewer = u11.Interface.TweenFrame.Viewer;
    u11.Creator = u11.Interface.TweenFrame.Creator;
    u11.SetupGUI();
    for _, v44 in l__ReplicatedStorage__1.Assets.Apartments:GetChildren() do
        task.spawn(u11.CreateApartmentItem, v44);
    end;
    l__ReplicatedStorage__1.Assets.Apartments.ChildRemoved:Connect(u11.CheckIfAddPartyEnabled);
    l__ReplicatedStorage__1.Assets.Apartments.ChildAdded:Connect(u11.CreateApartmentItem);
    u8.Event:Connect(u11.KnockRequest);
    u6.Event:Connect(u11.Interface.Close);
end;
return u11;
