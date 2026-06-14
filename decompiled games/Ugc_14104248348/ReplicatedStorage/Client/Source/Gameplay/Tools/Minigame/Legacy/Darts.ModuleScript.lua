-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Minigame.Legacy.Darts
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__Debris__4 = game:GetService("Debris");
local l__TweenService__5 = game:GetService("TweenService");
local l__RunService__6 = game:GetService("RunService");
local l__LocalPlayer__7 = game:GetService("Players").LocalPlayer;
local u1 = l__LocalPlayer__7:GetMouse();
local l__CurrentCamera__8 = workspace.CurrentCamera;
local l__Mince__9 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Projectile);
require(l__ReplicatedStorage__1.Modules.RotatedRegion3);
l__Mince__9:Get("Frostbite");
local u2 = l__Mince__9:Get("Bobbing");
local u3 = l__Mince__9:Get("Settings");
local u4 = l__Mince__9:Get("Intoxication");
l__Mince__9:Get("SoundHandler");
local u5 = l__Mince__9:Get("UserProfile");
local u6 = l__Mince__9:Get("ToolHandler");
local u7 = l__Mince__9:Get("BindManager");
local u8 = l__Mince__9:Get("NotifPrompt");
l__Mince__9:Get("DrinkHandler");
local u9 = l__Mince__9:Get("InterfaceHandler");
l__Mince__9:Get("SelectInteractor");
l__Mince__9:GetEvent("InteractDrink");
local u10 = l__Mince__9:GetEvent("ExpireIntent");
local v11 = l__Mince__9:GetEvent("Darts");
local u12 = v11:Extend("Throw");
v11:Extend("TargetHit");
local u13 = l__Mince__9:GetEvent("DartReplicate", true):Extend("Spawn");
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = Vector3.new(0, -workspace.Gravity / 2, 0);
local u18 = Color3.fromRGB(255, 255, 255);
local u19 = Color3.fromRGB(255, 0, 0);
function lerp(p20, p21, p22)
    return p20 * (1 - p22) + p21 * p22;
end;
local u33 = {
    IsHeld = false,
    HoldingDown = false,
    HoldTime = 0,
    MaxHoldTime = 1,
    LoadedAnimations = {},
    CONST = l__Mince__9.Config.Snowball,
    Position = {
        X = 0,
        Y = 0
    },
    HitTween = TweenInfo.new(4),
    SimulateDart = function(p23, p24, p25, p26) --[[ Name: SimulateDart, Line 83 ]]
        -- upvalues: u17 (copy), l__CurrentCamera__8 (copy), l__RunService__6 (copy), l__Debris__4 (copy)
        local v27 = (p24 - p23 - u17 * 0.5 * p26 * p26) / p26;
        local v28 = p25:Clone();
        v28.CanCollide = true;
        v28.Anchored = true;
        v28.Parent = l__CurrentCamera__8;
        local v29 = 0;
        while v29 < p26 do
            local v30 = CFrame.new(u17 * 0.5 * v29 * v29 + v27 * v29 + p23);
            v28.CFrame = CFrame.lookAt(v30.Position, p24);
            v29 = v29 + l__RunService__6.RenderStepped:Wait();
        end;
        v28.CanCollide = false;
        l__Debris__4:AddItem(v28, 5);
        return v28;
    end,
    DartHit = function(p31) --[[ Name: DartHit, Line 104 ]]
        local v32 = Instance.new("Sound");
        v32.SoundId = "rbxassetid://6732342375";
        v32.RollOffMaxDistance = 100;
        v32.Parent = p31;
        p31.Material = Enum.Material.Neon;
        v32:Play();
        task.wait(2);
        v32:Destroy();
        p31.Material = Enum.Material.Plastic;
    end
};
function u33.ActivateTool(p34) --[[ Line: 119 ]]
    -- upvalues: u4 (copy), u33 (copy), l__TweenService__5 (copy), l__CurrentCamera__8 (copy), l__LocalPlayer__7 (copy), u12 (copy)
    if u4.IsPassedOut() then
    elseif u33.ToolActive then
        if u33.IsDisabled then
        elseif p34 == Enum.UserInputState.Begin then
            if u4.IntoxLevel < 0 then
                l__TweenService__5:Create(game.Workspace.CurrentCamera, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    FieldOfView = 60
                }):Play();
            end;
            u33.HoldingDown = true;
            local l__Pull__10 = u33.LoadedAnimations.Pull;
            l__Pull__10:Play();
            task.wait(l__Pull__10.Length - 0.1);
            l__Pull__10:AdjustSpeed(0);
            u33.ExpectingThrow = true;
        else
            if p34 == Enum.UserInputState.End then
                local v35 = l__CurrentCamera__8:ScreenPointToRay(u33.UITrajectory.AbsolutePosition.X, u33.UITrajectory.AbsolutePosition.Y);
                local u36 = workspace:Raycast(v35.Origin, v35.Direction * 40, u33.CastParams);
                u33.HoldingDown = false;
                if u4.IntoxLevel < 0 then
                    l__TweenService__5:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        FieldOfView = 70
                    }):Play();
                end;
                if not u33.ExpectingThrow then
                    u33.LoadedAnimations.Pull:Stop(0.5);
                    return;
                end;
                u33.LoadedAnimations.Pull:AdjustSpeed(1);
                u33.LoadedAnimations.Throw:Play();
                if u36 and u33.MouseTarget.Visible then
                    local l__Position__11 = l__LocalPlayer__7.Character.RightHand.Position;
                    local l__Position__12 = u36.Position;
                    local l__Magnitude__13 = (l__Position__12 - l__Position__11).Magnitude;
                    local u37 = u36.Instance.Parent:HasTag("DartBoard");
                    local v38 = u12;
                    local v39;
                    if u37 then
                        v39 = u36.Instance;
                    else
                        v39 = u37;
                    end;
                    v38:Fire(l__Position__11, l__Position__12, v39);
                    task.spawn(function() --[[ Line: 182 ]]
                        -- upvalues: u33 (ref), l__Position__11 (copy), l__Position__12 (copy), l__Magnitude__13 (copy), u37 (copy), u36 (copy)
                        u33.SimulateDart(l__Position__11, l__Position__12, u33.Tool.Handle, l__Magnitude__13 / 40);
                        if u37 then
                            u33.DartHit(u36.Instance);
                        end;
                    end);
                    u33.Tool:Destroy();
                end;
                u33.ExpectingThrow = false;
                u33.ExpectingInput = false;
                u33.LoadedAnimations.Throw.Ended:Wait();
                u33.EndTool();
                u33.ExpectingInput = true;
            end;
        end;
    end;
end;
function u33.Update(p40, p41) --[[ Line: 208 ]]
    -- upvalues: l__CurrentCamera__8 (copy), u1 (copy), u18 (copy), u19 (copy), u33 (copy), u15 (ref), u16 (ref)
    math.random(-100, 100);
    math.random(-100, 100);
    local v42 = l__CurrentCamera__8:ScreenPointToRay(u1.X, u1.Y);
    local v43 = workspace:Raycast(v42.Origin, v42.Direction * 40);
    local l__X__14 = u1.X;
    local l__Y__15 = u1.Y;
    local v44 = true;
    u33.UITrajectory.BackgroundColor3 = v43 and u18 or u19;
    if v43 and not u33.HoldingDown then
        local v45;
        v45, v44 = l__CurrentCamera__8:WorldToScreenPoint(v43.Position);
        l__X__14 = v45.X;
        l__Y__15 = v45.Y;
        u15 = v43.Position;
        u16 = p40;
    elseif u15 and u33.HoldingDown then
        local v46;
        v46, v44 = l__CurrentCamera__8:WorldToScreenPoint(u15);
        l__X__14 = v46.X;
        l__Y__15 = v46.Y;
    else
        u16 = nil;
    end;
    local v47 = 50;
    if (u33.HoldingDown or v47 < 49) and u16 then
        v47 = math.cos(p40 - u16) * 50;
    end;
    u33.Position = {
        X = math.sin(p40),
        Y = math.sin(p40 * 2)
    };
    u33.MouseTarget.Visible = v44;
    u33.MouseTarget.Position = u33.MouseTarget.Position:Lerp(UDim2.fromOffset(l__X__14, l__Y__15), p41 * 20);
    u33.UITrajectory.Position = UDim2.fromOffset(u33.Position.X * v47, u33.Position.Y * v47);
    u33.MainPriority.Enabled = true;
end;
function u33.CheckToolAsync(p48) --[[ Line: 261 ]]
    -- upvalues: u5 (copy), l__Mince__9 (copy), u10 (copy), u8 (copy), u3 (copy)
    u5:WaitUntilLoaded();
    if p48:GetAttribute("UserCreator") and l__Mince__9.Config.LocalProfile.Intents.FIRST_USE_PLAYER_CREATED then
        u10:Fire("FIRST_USE_PLAYER_CREATED");
        u8.Display("This is a player generated item! Any item that has \'\' is created by players, not us.", function() --[[ Line: 266 ]]
            -- upvalues: u3 (ref)
            u3.ChangeSetting("GraphicMode", 2);
        end);
    end;
end;
function u33.StartTool(p49) --[[ Line: 272 ]]
    -- upvalues: l__Mince__9 (copy), u33 (copy), u2 (copy), l__LocalPlayer__7 (copy), u14 (ref), l__RunService__6 (copy), l__UserInputService__3 (copy)
    if l__Mince__9.Config.Humanoid then
        u33.ToolActive = true;
        u33.IsDisabled = false;
        u33.Events = {};
        u33.Tool = p49;
        u2.SetFOVMult(1);
        u33.LoadedAnimations = {};
        for _, v50 in p49:WaitForChild("Animations"):GetChildren() do
            u33.LoadedAnimations[v50.Name] = l__Mince__9.Config.Humanoid:LoadAnimation(v50);
        end;
        local l__CastParams__16 = u33.CastParams;
        local l__FilterDescendantsInstances__17 = l__CastParams__16.FilterDescendantsInstances;
        if not table.find(l__FilterDescendantsInstances__17, l__LocalPlayer__7.Character) then
            table.insert(l__FilterDescendantsInstances__17, l__LocalPlayer__7.Character);
            l__CastParams__16.FilterDescendantsInstances = l__FilterDescendantsInstances__17;
        end;
        u14 = l__RunService__6.Stepped:Connect(u33.Update);
        l__UserInputService__3.MouseIconEnabled = false;
        u33.MainPriority.Enabled = true;
        u33.LoadedAnimations.Idle:Play();
    end;
end;
function u33.EndTool() --[[ Line: 300 ]]
    -- upvalues: u33 (copy), u14 (ref), l__UserInputService__3 (copy), u2 (copy)
    u33.ToolActive = false;
    u33.IsHeld = false;
    for _, v51 in u33.LoadedAnimations do
        v51:Stop();
    end;
    for _, v52 in u33.Events do
        v52:Disconnect();
    end;
    if u14 then
        u14:Disconnect();
        u14 = nil;
    end;
    l__UserInputService__3.MouseIconEnabled = true;
    u33.MainPriority.Enabled = false;
    u33.LoadedAnimations.Idle:Stop();
    u2.SetFOVMult(1);
end;
function u33.Setup() --[[ Line: 322 ]]
    -- upvalues: u33 (copy), u9 (copy), u6 (copy), u7 (copy), u3 (copy), l__UserInputService__3 (copy), u13 (copy), l__ReplicatedStorage__1 (copy), l__CollectionService__2 (copy)
    u33.MainPriority = u9.GetScreenGui("Dart");
    u33.MouseTarget = u33.MainPriority.Dart;
    u33.UITrajectory = u33.MouseTarget.Trajectory;
    local v53 = u6.TagEquipped({ "Dart" });
    v53.Equipped:Connect(u33.StartTool);
    v53.Unequipped:Connect(u33.EndTool);
    u7.Get("Interact").OnAction:Connect(u33.ActivateTool);
    u3.SettingChanged("Drinking"):Connect(function(p54) --[[ Line: 333 ]]
        -- upvalues: u33 (ref)
        u33.DrinkingEnabled = p54;
    end);
    u7.Get("Interact").OnAction:Connect(function(p55) --[[ Line: 337 ]]
        -- upvalues: u33 (ref)
        u33.ActivateTool(p55);
    end);
    l__UserInputService__3.TouchStarted:Connect(function() --[[ Line: 341 ]]
        -- upvalues: u33 (ref)
        u33.ActivateTool(Enum.UserInputState.Begin);
    end);
    l__UserInputService__3.TouchEnded:Connect(function() --[[ Line: 345 ]]
        -- upvalues: u33 (ref)
        u33.ActivateTool(Enum.UserInputState.End);
    end);
    u13.Event:Connect(function(p56, p57, p58) --[[ Line: 350 ]]
        -- upvalues: u33 (ref), l__ReplicatedStorage__1 (ref)
        u33.SimulateDart(p56, p57, l__ReplicatedStorage__1.Assets.Tools.Dart.Handle, (p57 - p56).Magnitude / 40);
        if p58 then
            u33.DartHit(p58);
        end;
    end);
    local v59 = l__CollectionService__2:GetTagged("IgnoreOnRay");
    local v60 = RaycastParams.new();
    v60.FilterType = Enum.RaycastFilterType.Exclude;
    v60.FilterDescendantsInstances = v59;
    u33.CastParams = v60;
end;
return u33;
