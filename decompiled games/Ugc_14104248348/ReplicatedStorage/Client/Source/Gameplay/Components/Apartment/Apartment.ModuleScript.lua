-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Apartment.Apartment
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__Players__2 = game:GetService("Players");
local l__LocalPlayer__3 = l__Players__2.LocalPlayer;
local l__Maid__4 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__5:Get("LoftShop");
local u2 = l__Mince__5:Get("AnchorLofts");
local u3 = l__Mince__5:Get("ConfirmPrompt");
local u4 = l__Mince__5:Get("InterfaceHandler");
local v5 = l__Mince__5:GetEvent("ApartmentEvents");
local u6 = v5:Extend("LeaveApartment");
local u7 = v5:Extend("KickFromApartment");
function CreateProximityPrompt(p8, p9)
    local v10 = Instance.new("ProximityPrompt");
    v10:SetAttribute("Type", "Radial");
    v10:SetAttribute("SizeMultipler", 2);
    v10.ObjectText = p8;
    v10.MaxActivationDistance = 5;
    v10.Style = Enum.ProximityPromptStyle.Custom;
    v10.Parent = p9;
    v10.RequiresLineOfSight = false;
    p9.Transparency = 1;
    p9.Anchored = true;
    return v10;
end;
local u11 = l__Mince__5.Component({
    Tag = "Apartment",
    Maid = l__Maid__4.new(),
    Tween1 = TweenInfo.new(0.3, Enum.EasingStyle.Quint)
});
function u11.Construct(u12) --[[ Line: 46 ]]
    -- upvalues: u3 (copy), u6 (copy)
    local l__Apartment__6 = u12.Instance:WaitForChild("Apartment");
    local l__Leave__7 = u12.Instance:WaitForChild("Leave");
    local u13 = CreateProximityPrompt("Leave Apartment", l__Leave__7);
    u13.TriggerEnded:Connect(function() --[[ Line: 51 ]]
        -- upvalues: l__Apartment__6 (copy), u13 (copy), u3 (ref), u12 (copy), u6 (ref)
        if l__Apartment__6.Value then
            u13.Enabled = false;
            u3.Display(`Are you sure you'd like to leave '{u12.Name}'?`, function() --[[ Line: 55 ]]
                -- upvalues: u6 (ref), l__Apartment__6 (ref), u13 (ref)
                u6:Fire(l__Apartment__6.Value);
                u13.Enabled = true;
            end, function() --[[ Line: 58 ]]
                -- upvalues: u13 (ref)
                u13.Enabled = true;
            end);
        end;
    end);
end;
function u11.StartTracking(u14) --[[ Line: 62 ]]
    -- upvalues: u11 (copy), l__LocalPlayer__3 (copy), l__ReplicatedStorage__1 (copy), l__Players__2 (copy), u4 (copy), u3 (copy), u7 (copy)
    u11.Maid:Clean();
    if u11.Frame.Visible then
    else
        u11.Frame.Visible = true;
        u11.MainPriority.Right.Apartment.PlaceName.Text = u14.Name;
        u11.Frame.PlaceName.Text = u14.Name;
        u11.Frame.TopBar.Shop.Visible = u14.Config:GetAttribute("Owner") == l__LocalPlayer__3.UserId;
        u11.Frame.TopBar.Settings.Visible = u14.Config:GetAttribute("Owner") == l__LocalPlayer__3.UserId;
        u11.MainPriority.Right.Apartment.Visible = u14.Config:GetAttribute("Owner") == l__LocalPlayer__3.UserId;
        local u15 = {};
        local function u16() --[[ Line: 73 ]]
            -- upvalues: u14 (copy), u11 (ref), l__LocalPlayer__3 (ref)
            task.wait();
            if u14.Config.Parent then
                u11.MainPriority.Right.Apartment.PlaceName.Text = u14.Name;
                u11.Frame.TopBar.Capacity.Text = `{#u14.Config.Players:GetChildren() - 1}/5`;
                u11.Frame.PlaceName.Text = u14.Config.Name;
                u11.Frame.TopBar.Shop.Visible = u14.Config:GetAttribute("Owner") == l__LocalPlayer__3.UserId;
                u11.Frame.TopBar.Settings.Visible = u14.Config:GetAttribute("Owner") == l__LocalPlayer__3.UserId;
                u11.MainPriority.Right.Apartment.Visible = u14.Config:GetAttribute("Owner") == l__LocalPlayer__3.UserId;
            end;
        end;
        local function u20() --[[ Line: 88 ]]
            -- upvalues: u14 (copy), u15 (copy)
            local v17 = u14.Config:GetAttribute("Owner");
            for v18, v19 in u15 do
                v19.UIStroke.Color = v18 == v17 and Color3.new(1, 0.835294, 0) or Color3.new(0, 0, 0);
            end;
        end;
        local function u24(u21) --[[ Line: 95 ]]
            -- upvalues: u16 (copy), u15 (copy), l__ReplicatedStorage__1 (ref), u11 (ref), l__Players__2 (ref), u4 (ref), l__LocalPlayer__3 (ref), u14 (copy), u3 (ref), u7 (ref), u20 (copy)
            u16();
            if u15[u21] then
            else
                local v22 = l__ReplicatedStorage__1.Assets.Interface.ProfileItem:Clone();
                v22.Parent = u11.Frame.Container;
                u15[u21] = v22;
                local u23 = l__Players__2:GetPlayerByUserId(u21);
                u4.NewButton(v22).Activated:Connect(function() --[[ Line: 106 ]]
                    -- upvalues: l__LocalPlayer__3 (ref), u14 (ref), u21 (copy), u3 (ref), u23 (copy), u7 (ref)
                    if l__LocalPlayer__3.UserId == u14.Config:GetAttribute("Owner") then
                        if u21 == l__LocalPlayer__3.UserId then
                        else
                            u3.Display(`Are you sure you'd like to ban '{u23.Name}' from the apartment?`, function() --[[ Line: 115 ]]
                                -- upvalues: u7 (ref), u14 (ref), u21 (ref)
                                u7:Fire(u14.Config, u21);
                            end);
                        end;
                    end;
                end);
                v22.Image = l__Players__2:GetUserThumbnailAsync(u21, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size60x60);
                u20();
            end;
        end;
        local function u26() --[[ Line: 135 ]]
            -- upvalues: u11 (ref), u14 (copy)
            u11.MainPriority.Right.Apartment.Container.ProgressBar.CompleteLabel.Text = `{u14.Config:GetAttribute("MemoryUsage")}/{u14.Config:GetAttribute("MemoryLimit")}`;
            local l__Fill__8 = u11.MainPriority.Right.Apartment.Container.ProgressBar.Fill;
            local l__fromScale__9 = UDim2.fromScale;
            local v25 = u14.Config:GetAttribute("MemoryUsage") / u14.Config:GetAttribute("MemoryLimit");
            l__Fill__8.Size = l__fromScale__9(math.clamp(v25, 0, 1), 1);
        end;
        for _, u27 in u14.Config.Players:GetChildren() do
            task.defer(function() --[[ Line: 144 ]]
                -- upvalues: u24 (copy), u27 (copy)
                u24((tonumber(u27.Name)));
            end);
        end;
        u11.Maid:Add(u14.Config:GetAttributeChangedSignal("MemoryLimit"):Connect(function() --[[ Line: 149 ]]
            -- upvalues: u26 (copy)
            u26();
        end));
        u11.Maid:Add(u14.Config:GetAttributeChangedSignal("MemoryUsage"):Connect(function() --[[ Line: 153 ]]
            -- upvalues: u26 (copy)
            u26();
        end));
        u11.Maid:Add(function() --[[ Line: 157 ]]
            -- upvalues: u15 (copy)
            for _, v28 in u15 do
                v28:Destroy();
            end;
        end);
        u11.Maid:Add(u14.Config:GetPropertyChangedSignal("Name"):Connect(u16));
        u11.Maid:Add(u14.Config:GetAttributeChangedSignal("Owner"):Connect(function() --[[ Line: 164 ]]
            -- upvalues: u20 (copy), u16 (copy)
            u20();
            u16();
        end));
        u11.Maid:Add(u14.Config.Players.ChildRemoved:Connect(function(p29) --[[ Line: 168 ]]
            -- upvalues: u16 (copy), u15 (copy)
            local v30 = tonumber(p29.Name);
            u16();
            if u15[v30] then
                u15[v30]:Destroy();
                u15[v30] = nil;
            end;
        end));
        u11.Maid:Add(u14.Config.Players.ChildAdded:Connect(function(p31) --[[ Line: 171 ]]
            -- upvalues: u24 (copy)
            u24((tonumber(p31.Name)));
        end));
        u11.Maid:Add(function() --[[ Line: 174 ]]
            -- upvalues: u11 (ref)
            u11.MainPriority.Right.Apartment.Visible = false;
        end);
        task.defer(u26);
    end;
end;
function u11.EndTracking() --[[ Line: 181 ]]
    -- upvalues: u11 (copy)
    warn("end..");
    u11.Maid:Clean();
    u11.MainPriority.Right.Apartment.Visible = false;
    u11.Frame.Visible = false;
end;
function u11.Setup() --[[ Line: 188 ]]
    -- upvalues: u11 (copy), u4 (copy), u1 (copy), u2 (copy)
    u11.MainPriority = u4.GetScreenGui("MainPriority");
    u11.MainPriorityInset = u4.GetScreenGui("MainPriorityInset");
    u11.Frame = u11.MainPriorityInset.Apartment;
    u4.NewButton(u11.Frame.TopBar.Shop).Activated:Connect(function() --[[ Line: 193 ]]
        -- upvalues: u1 (ref)
        u1.Interface.Switch();
    end);
    u4.NewButton(u11.Frame.TopBar.Settings).Activated:Connect(function() --[[ Line: 197 ]]
        -- upvalues: u2 (ref)
        u2.OpenConfiguration();
    end);
    u2.ApartmentJoinLocal:Connect(u11.StartTracking);
    u2.ApartmentLeaveLocal:Connect(u11.EndTracking);
end;
return u11;
