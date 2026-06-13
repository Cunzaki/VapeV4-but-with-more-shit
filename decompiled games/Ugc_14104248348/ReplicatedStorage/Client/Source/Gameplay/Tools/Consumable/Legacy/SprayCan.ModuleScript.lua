-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Consumable.Legacy.SprayCan
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__MarketplaceService__2 = game:GetService("MarketplaceService");
local l__CollectionService__3 = game:GetService("CollectionService");
local l__TweenService__4 = game:GetService("TweenService");
local l__LocalPlayer__5 = game:GetService("Players").LocalPlayer;
local u1 = game.Players.LocalPlayer:GetMouse();
local l__Mince__6 = require(l__ReplicatedStorage__1.Modules.Mince);
local u2 = l__Mince__6:Get("Notices");
local u3 = l__Mince__6:Get("Locomotion");
local u4 = l__Mince__6:Get("ToolHandler");
local u5 = l__Mince__6:Get("SelectInteractor");
local u6 = l__Mince__6:Get("InterfaceHandler");
local u7 = l__Mince__6:GetEvent("SprayDecal");
local u8 = {
    CurrentDecal = 2629754614,
    AllowNextOn = os.clock(),
    Animations = {}
};
function u8.StartTool(p9) --[[ Line: 28 ]]
    -- upvalues: l__Mince__6 (copy), u8 (copy), u1 (copy)
    if l__Mince__6.Config.Humanoid then
        u8.ToolActive = true;
        u8.CurrentTool = p9;
        u8.ToolEvents = {};
        u8.Part.Parent = game.Workspace;
        u8.Part.CFrame = CFrame.new(0, 0, 0);
        if not p9:GetAttribute("Uses") then
            p9:SetAttribute("Uses", 0);
        end;
        u8.UI.Main.Visible = p9:GetAttribute("Uses") <= 7;
        local l__Animations__7 = p9:WaitForChild("Animations");
        u8.Animations = {};
        for _, v10 in l__Animations__7:GetChildren() do
            local v11 = l__Mince__6.Config.Humanoid.Animator:LoadAnimation(v10);
            if v11:GetAttribute("Speed") then
                v11:AdjustSpeed(v11:GetAttribute("Speed"));
            end;
            u8.Animations[v10.Name] = v11;
        end;
        task.defer(u8.MouseMoved);
        u8.ToolEvents.Move = u1.Move:Connect(u8.MouseMoved);
    end;
end;
function u8.EndTool() --[[ Line: 60 ]]
    -- upvalues: u8 (copy)
    u8.ToolActive = false;
    u8.UI.Main.Visible = false;
    u8.Part.Parent = game.ReplicatedStorage;
    for _, v12 in u8.ToolEvents do
        v12:Disconnect();
    end;
end;
function u8.Activate() --[[ Line: 70 ]]
    -- upvalues: l__Mince__6 (copy), u8 (copy), u2 (copy), u3 (copy), u7 (copy)
    if l__Mince__6.Config.HumanoidRootPart then
        if u8.ToolActive and u8.Animations.Spray then
            if u8.CurrentTool:GetAttribute("Disabled") then
                return "Pass";
            else
                u8.CurrentTool:SetAttribute("Disabled", true);
                if os.clock() <= u8.AllowNextOn then
                    u2.Error("You can only create a spray every 10 seconds!");
                    task.wait(3);
                    u8.CurrentTool:SetAttribute("Disabled", false);
                    return "Pass";
                else
                    local v13 = game.Players.LocalPlayer:GetMouse();
                    local u14 = workspace:Raycast(v13.UnitRay.Origin, v13.UnitRay.Direction * 1000, u8.SprayParams);
                    task.spawn(function() --[[ Line: 87 ]]
                        -- upvalues: u14 (copy), u8 (ref), u2 (ref), u3 (ref), u7 (ref)
                        if u14 and u14.Instance:HasTag("DecalSprayable") then
                            u8.UI.Main.Visible = false;
                            u3.SetEnabled(false);
                            u8.CurrentTool.Handle.Spray:Play();
                            u8.Animations.Spray:Play();
                            u8.Animations.Spray.Stopped:Wait();
                            u3.SetEnabled(true);
                            u8.AllowNextOn = os.clock() + 10;
                            u7:Fire(CFrame.lookAt(u14.Position, u14.Position + u14.Normal * 100), u8.CurrentDecal, u8.IsDecal);
                            if u8.ToolActive then
                                u8.UI.Main.Visible = true;
                            end;
                            if u8.CurrentTool:GetAttribute("Uses") >= 7 then
                                u8.CurrentTool:SetAttribute("Disabled", true);
                                u8.CurrentTool.Name = "Used Intykan";
                                u8.UI.Main.Visible = false;
                            else
                                u8.CurrentTool:SetAttribute("Disabled", false);
                            end;
                        else
                            u8.CurrentTool:SetAttribute("Disabled", false);
                            u2.Error("Decals can only be sprayed on the oustide of buildings!");
                            return "Pass";
                        end;
                    end);
                    return "Sink";
                end;
            end;
        else
            return "Pass";
        end;
    else
        return "Pass";
    end;
end;
function u8.MouseMoved() --[[ Line: 127 ]]
    -- upvalues: u8 (copy), l__LocalPlayer__5 (copy)
    local v15 = game.Players.LocalPlayer:GetMouse();
    local v16 = workspace:Raycast(v15.UnitRay.Origin, v15.UnitRay.Direction * 50, u8.SprayParams);
    if v16 and not (l__LocalPlayer__5.Character and (v16.Instance and v16.Instance:IsDescendantOf(l__LocalPlayer__5.Character))) and (u8.ToolActive and not u8.CurrentTool:GetAttribute("Disabled")) then
        if u8.Part.Parent == game.ReplicatedStorage then
            u8.Part.Parent = game.Workspace;
        end;
        u8.Part.CFrame = CFrame.lookAt(v16.Position, v16.Position + v16.Normal * 100);
        if v16.Instance:HasTag("DecalSprayable") then
            u8.Part.Color = Color3.new(0.305882, 1, 0.113725);
        else
            u8.Part.Color = Color3.new(1, 0.227451, 0.227451);
        end;
    else
        if u8.Part.Parent == game.Workspace then
            u8.Part.Parent = game.ReplicatedStorage;
        end;
    end;
end;
function u8.SetupUI() --[[ Line: 150 ]]
    -- upvalues: u6 (copy), u8 (copy), u2 (copy), l__MarketplaceService__2 (copy)
    u6.NewButton(u8.UI.Main.TextBox.OkayButton).Activated:Connect(function() --[[ Line: 153 ]]
        -- upvalues: u8 (ref), u2 (ref), l__MarketplaceService__2 (ref)
        local u17 = tonumber(u8.UI.Main.TextBox.TextBox.Text);
        if u17 then
            local v18, v19 = pcall(function() --[[ Line: 157 ]]
                -- upvalues: l__MarketplaceService__2 (ref), u17 (copy)
                return l__MarketplaceService__2:GetProductInfo(u17, Enum.InfoType.Asset);
            end);
            if v18 then
                u8.IsDecal = false;
                if v19.IconImageAssetId and v19.IconImageAssetId ~= 0 then
                    if v19.AssetTypeId ~= 1 then
                        u17 = v19.IconImageAssetId;
                    end;
                elseif not v19 or v19.AssetTypeId ~= 1 then
                    if v19.AssetTypeId ~= 13 then
                        u2.Error("Failed to retrieve IconImageAssetId!");
                        return;
                    end;
                    u8.IsDecal = true;
                end;
                u2.CreateNotice("Image changed!");
                u8.CurrentDecal = u17;
            else
                u2.Error("Invalid ID or failed to retrieve info!");
            end;
        else
            return u2.Error("Invalid ID!");
        end;
    end);
end;
function u8.Setup() --[[ Line: 191 ]]
    -- upvalues: u8 (copy), u6 (copy), l__CollectionService__3 (copy), u4 (copy), l__TweenService__4 (copy), u5 (copy)
    u8.UI = u6.GetScreenGui("SprayUI");
    u8.SetupUI();
    local u20 = RaycastParams.new();
    u20.FilterType = Enum.RaycastFilterType.Include;
    u20.FilterDescendantsInstances = l__CollectionService__3:GetTagged("DecalSprayable");
    l__CollectionService__3:GetInstanceAddedSignal("DecalSprayable"):Connect(function(p21) --[[ Line: 198 ]]
        -- upvalues: u20 (copy)
        table.insert(u20.FilterDescendantsInstances, p21);
    end);
    u8.SprayParams = u20;
    local v22 = u4.TagEquipped({ "Spray" });
    v22.Equipped:Connect(u8.StartTool);
    v22.Unequipped:Connect(u8.EndTool);
    u8.Part = Instance.new("Part", workspace);
    u8.Part.Size = Vector3.new(5, 5, 0.1);
    u8.Part.Anchored = true;
    u8.Part.CanCollide = false;
    u8.Part.CanQuery = false;
    u8.Part.CanCollide = false;
    u8.Part.Transparency = 1;
    u8.Part.Color = Color3.new(1, 0.227451, 0.227451);
    l__TweenService__4:Create(u8.Part, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
        Transparency = 0.7
    }):Play();
    u5.BindToInteract(500, u8.Activate);
end;
return u8;
