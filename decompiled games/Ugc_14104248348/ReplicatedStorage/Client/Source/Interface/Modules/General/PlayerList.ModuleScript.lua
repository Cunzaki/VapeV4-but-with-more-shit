-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.PlayerList
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Players__2 = game:GetService("Players");
local l__Maid__3 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Signal__5 = require(l__ReplicatedStorage__1.Modules.Signal);
local u1 = l__Mince__4:Get("InterfaceHandler");
local u2 = {
    Players = {},
    ListRule = {},
    Added = l__Signal__5.new(),
    Icons = {
        Robux = "",
        Premium = "",
        Verified = ""
    }
};
function ModifyColor(p3, p4)
    local v5, v6, v7 = p3:ToHSV();
    return Color3.fromHSV(v5 * (p4.H or 1), v6 * (p4.S or 1), v7 * (p4.V or 1));
end;
local u8 = {};
u8.__index = u8;
function u8.new(p9) --[[ Line: 49 ]]
    -- upvalues: u8 (copy), u2 (copy)
    local v10 = setmetatable({}, u8);
    v10:Init(p9);
    u2.Players[v10.Player] = v10;
    u2.Added:Fire(v10);
    v10.GUI.Parent = u2.Scroll;
    return v10;
end;
function u8.Apply(p11, p12) --[[ Line: 60 ]]
    warn(p12);
    if p12.ButtonGone then
        p11.GUI.Choice1.Visible = false;
        p11.GUI.AltText.Visible = true;
        if p12.ButtonText then
            p11.GUI.AltText.Text = p12.ButtonText;
        end;
    else
        if p12.ButtonText then
            p11.GUI.Choice1.TextLabel.Text = p12.ButtonText;
        end;
        p11.GUI.Choice1.Visible = true;
        p11.GUI.AltText.Visible = false;
        local v13 = p12.Color or Color3.new(0, 1, 0);
        p11.GUI.Choice1.BackgroundColor3 = ModifyColor(v13, {
            V = 0.8
        });
        p11.GUI.Choice1.UIStroke.Color = v13;
    end;
end;
function u8.Init(u14, p15) --[[ Line: 85 ]]
    -- upvalues: l__Maid__3 (copy), l__ReplicatedStorage__1 (copy), u2 (copy), u1 (copy)
    u14.Player = p15;
    u14.Maid = l__Maid__3.new();
    u14.GUI = l__ReplicatedStorage__1.Assets.Interface.PlayerListItem:Clone();
    u14.GUI.DisplayName.Text = u2:GenerateName(p15);
    u14.GUI.ActualName.Text = `(@{p15.Name})`;
    u14.GUI.Thumbnail.Image = game.Players:GetUserThumbnailAsync(p15.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size60x60);
    u14.Maid:Add(u14.GUI);
    u14.Maid:Add(u1.NewButton(u14.GUI.Choice1).Activated:Connect(function() --[[ Line: 100 ]]
        -- upvalues: u14 (copy), u2 (ref)
        u14:CallListRule("WhenPressed");
        u2:ForEachListItem(function(p16) --[[ Line: 102 ]]
            p16:CallListRule("ForEachWhenPressed");
        end);
        if u2.ListRules and u2.ListRules.CloseWhenSelect then
            u2:CloseList();
        end;
    end));
end;
function u8.SetVisible(p17, p18) --[[ Line: 114 ]]
    p17.GUI.Visible = p18;
end;
function u8.IfListRule(p19, p20, p21) --[[ Line: 118 ]]
    -- upvalues: u2 (copy)
    if u2.ListRules[p20] then
        p21(p19, p19.Player);
    end;
end;
function u8.CallListRule(p22, p23) --[[ Line: 126 ]]
    -- upvalues: u2 (copy)
    local v24 = u2.ListRules[p23];
    if v24 then
        v24(p22, p22.Player);
    end;
end;
function u8.Destroy(p25) --[[ Line: 134 ]]
    -- upvalues: u2 (copy)
    p25.Maid:Destroy();
    u2.Players[p25.Player] = nil;
end;
function u2.GenerateName(_, p26) --[[ Line: 139 ]]
    -- upvalues: u2 (copy)
    local v27 = "";
    if p26.MembershipType == Enum.MembershipType.Premium then
        v27 = v27 .. u2.Icons.Premium;
    end;
    if p26.HasVerifiedBadge then
        v27 = v27 .. u2.Icons.Verified;
    end;
    return `{p26.DisplayName}{v27}`;
end;
function u2.ForEachListItem(_, p28) --[[ Line: 152 ]]
    -- upvalues: u2 (copy)
    for _, v29 in u2.Players do
        p28(v29);
    end;
end;
function u2.WhenNewListItem(_, u30, p31) --[[ Line: 158 ]]
    -- upvalues: u2 (copy)
    u30:SetVisible(p31);
    u30:IfListRule("ApplyToAll", function() --[[ Line: 160 ]]
        -- upvalues: u30 (copy), u2 (ref)
        u30:Apply(u2.ListRules.ApplyToAll);
    end);
    u30:CallListRule("ForEach");
end;
function u2.OpenList(_, p32) --[[ Line: 166 ]]
    -- upvalues: u2 (copy), l__Maid__3 (copy)
    if u2.Interface.IsActive then
    else
        if u2.ListRules then
            u2.ListRules.Maid:Destroy();
        end;
        if p32.Title then
            u2.Interface.TweenFrame.Title.Title.Text = p32.Title;
        end;
        local u33 = p32 or {};
        u2.ListRules = u33;
        u33.Maid = l__Maid__3.new();
        u33.Maid:Add(u2.Added:Connect(function(p34) --[[ Line: 185 ]]
            -- upvalues: u2 (ref), u33 (ref)
            u2:WhenNewListItem(p34, u33.DefaultVisibility);
        end));
        u2:ForEachListItem(function(p35) --[[ Line: 189 ]]
            -- upvalues: u2 (ref), u33 (ref)
            u2:WhenNewListItem(p35, u33.DefaultVisibility);
        end);
        u2.Interface:Open(true);
    end;
end;
function u2.CloseList(_) --[[ Line: 196 ]]
    -- upvalues: u2 (copy)
    if u2.ListRules then
        u2.ListRules = nil;
        u2.Interface:Close();
    end;
end;
function u2.PlayerAdded(_, p36) --[[ Line: 203 ]]
    -- upvalues: u8 (copy)
    u8.new(p36);
end;
function u2.PlayerRemoving(_, p37) --[[ Line: 207 ]]
    -- upvalues: u2 (copy)
    local v38 = u2.Players[p37];
    if v38 then
        v38:Destroy();
    end;
end;
function u2.SetupGUI(_) --[[ Line: 214 ]]
    -- upvalues: u1 (copy), u2 (copy)
    u1.NewButton(u2.Interface.TweenFrame.CloseButton).Activated:Connect(function() --[[ Line: 218 ]]
        -- upvalues: u2 (ref)
        u2.Interface:Close();
    end);
end;
function u2.Setup(_) --[[ Line: 223 ]]
    -- upvalues: u2 (copy), u1 (copy), l__Players__2 (copy)
    u2.Interface = u1.Get("PlayerList");
    u2.Scroll = u2.Interface.TweenFrame.Scroll;
    u2:SetupGUI();
    for _, u39 in l__Players__2:GetPlayers() do
        task.spawn(function() --[[ Line: 230 ]]
            -- upvalues: u2 (ref), u39 (copy)
            u2:PlayerAdded(u39);
        end);
    end;
    u2.Interface.Closed:Connect(function() --[[ Line: 235 ]]
        -- upvalues: u2 (ref)
        u2:CloseList();
    end);
    l__Players__2.PlayerRemoving:Connect(function(p40) --[[ Line: 239 ]]
        -- upvalues: u2 (ref)
        u2:PlayerRemoving(p40);
    end);
    l__Players__2.PlayerAdded:Connect(function(p41) --[[ Line: 243 ]]
        -- upvalues: u2 (ref)
        u2:PlayerAdded(p41);
    end);
end;
return u2;
