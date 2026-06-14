-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Legacy.ToolEquippedDeprecated.Hoverboard
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__UserInputService__2 = game:GetService("UserInputService");
game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
local l__VRService__4 = game:GetService("VRService");
local l__Players__5 = game:GetService("Players");
local l__StarterGui__6 = game:GetService("StarterGui");
local l__LocalPlayer__7 = l__Players__5.LocalPlayer;
l__LocalPlayer__7:GetMouse();
local l__CurrentCamera__8 = workspace.CurrentCamera;
local l__PlayerModule__9 = l__LocalPlayer__7.PlayerScripts:WaitForChild("PlayerModule");
local l__ControlModule__10 = require(l__PlayerModule__9.ControlModule);
local l__Mince__11 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Utility__12 = require(l__ReplicatedStorage__1.Modules.Utility);
require(l__ReplicatedStorage__1.Modules.Projectile);
require(l__ReplicatedStorage__1.Modules.RotatedRegion3);
l__Mince__11:Get("Frostbite");
l__Mince__11:Get("Bobbing");
local u1 = l__Mince__11:Get("Notices");
local u2 = l__Mince__11:Get("Settings");
local u3 = l__Mince__11:Get("Emote");
l__Mince__11:Get("Intoxication");
l__Mince__11:Get("SoundHandler");
l__Mince__11:Get("UserProfile");
local u4 = l__Mince__11:Get("ToolHandler");
local u5 = l__Mince__11:Get("BindManager");
l__Mince__11:Get("NotifPrompt");
l__Mince__11:Get("DrinkHandler");
local u6 = l__Mince__11:Get("InterfaceHandler");
local u7 = l__Mince__11:Get("Locomotion");
local u8 = l__Mince__11:Get("Bobbing");
local u9 = l__Mince__11:Get("SeatHandler");
local u10 = l__Mince__11:Get("SelectInteractor");
local u11 = l__Mince__11:GetEvent("Hoverboard");
l__Mince__11:GetEvent("InteractDrink");
l__Mince__11:GetEvent("ExpireIntent");
function lerp(p12, p13, p14)
    return p12 * (1 - p14) + p13 * p14;
end;
function avg(p15)
    local v16 = 0;
    if p15.Magnitude == 0 then
        return 0;
    end;
    if math.abs(p15.X) > 0 then
        v16 = v16 + 1;
    end;
    if math.abs(p15.Y) > 0 then
        v16 = v16 + 1;
    end;
    if math.abs(p15.Z) > 0 then
        v16 = v16 + 1;
    end;
    return (math.abs(p15.X) + math.abs(p15.Y) + math.abs(p15.Z)) / v16;
end;
local u17 = {
    Orientation = nil,
    Height = nil,
    RaycastParams = nil,
    IsHeld = false,
    ToolActive = false,
    IsDisabled = true,
    DefaultCustomProperties = nil,
    Dashing = false,
    DashCost = 10,
    RegenSpeed = 20,
    MaxStamina = 100,
    Stamina = 100,
    TurnSpeed = 4,
    BaseSpeed = 30,
    DashSpeed = 40,
    Elevation = 5,
    Speed = 0,
    Rotation = 0,
    Bar = nil,
    DepleteCooldown = 7,
    LastDeplete = 0,
    Depleted = false,
    FOV = 1,
    ToolListener = nil,
    VeriticalVelocity = 0,
    Animations = {},
    AllowRegenOn = os.clock(),
    BlacklistedMeshIDs = l__Utility__12.CreateFuzzyFinder({ "rbxassetid://8470128824" })
};
local u18 = 5;
function GetAABB(p19)
    local v20 = p19.CFrame:VectorToWorldSpace(p19.Size);
    local v21 = math.abs(v20.X);
    local v22 = math.abs(v20.Y);
    local v23 = math.abs(v20.Z);
    return Vector3.new(v21, v22, v23);
end;
function u17.Update(p24) --[[ Line: 120 ]]
    -- upvalues: l__LocalPlayer__7 (copy), l__ControlModule__10 (copy), l__CurrentCamera__8 (copy), u17 (copy), u8 (copy), l__Mince__11 (copy)
    local l__Character__13 = l__LocalPlayer__7.Character;
    local v25 = l__Character__13:FindFirstChild("Humanoid");
    local v26 = l__Character__13:FindFirstChild("HumanoidRootPart");
    if v26 then
        local v27 = l__Character__13:FindFirstChildWhichIsA("Tool");
        if v27 and not v27:HasTag("Hoverboard") then
            v25:UnequipTools();
        else
            local v28 = l__ControlModule__10:GetMoveVector();
            local v29 = l__CurrentCamera__8.CFrame:VectorToWorldSpace(v28) * Vector3.new(1, 0, 1);
            local v30 = v28 == Vector3.new(0, 0, 0);
            local v31 = workspace:Blockcast(v26.CFrame, Vector3.new(2, 1, 6), Vector3.new(0, -10, 0), u17.RaycastParams);
            if v30 then
                u17.Dashing = false;
                v26.AssemblyLinearVelocity = v26.AssemblyLinearVelocity:Lerp(Vector3.new(0, 0, 0), p24 * 5 * u17.LinearMult);
            else
                local l__CFrame__14 = u17.Orientation.CFrame;
                u17.Orientation.CFrame = l__CFrame__14:Lerp(CFrame.lookAt(l__CFrame__14.Position, l__CFrame__14.Position + v29), p24 * 2 * u17.SteerMult);
            end;
            if u17.Dashing then
                if u17.Stamina > 0 then
                    local v32 = u17;
                    v32.Stamina = v32.Stamina - p24 * u17.RegenSpeed;
                else
                    u17.LastDeplete = os.clock();
                    u17.Depleted = true;
                    u17.Dashing = false;
                end;
            elseif u17.Depleted and os.clock() - u17.LastDeplete > u17.DepleteCooldown then
                u17.Stamina = math.min(u17.Stamina + p24 * u17.RegenSpeed, u17.MaxStamina);
                if u17.Stamina == u17.MaxStamina then
                    u17.Depleted = false;
                end;
            end;
            local v33 = u17.DashSpeed - u17.BaseSpeed;
            local v34 = u17.Dashing and u17.DashSpeed or u17.BaseSpeed;
            local v35 = os.clock() * u17.SideFreq;
            local v36 = math.sin(v35) / 2;
            u17.Rotation = lerp(u17.Rotation, v28.X * u17.TurnSpeed, p24 * 3);
            local v37 = u17;
            local v38 = lerp;
            local l__FOV__15 = u17.FOV;
            local l__DashSpeed__16 = u17.DashSpeed;
            local v39 = math.abs(u17.Speed);
            v37.FOV = v38(l__FOV__15, (l__DashSpeed__16 - math.max(v39, u17.BaseSpeed)) / v33, p24 * 10);
            u8.SetFOVMult(1 + (1 - u17.FOV) / 5);
            if v30 then
                u17.Speed = lerp(u17.Speed, 0, p24 * u17.BreakMult);
            else
                local v40 = u17;
                local v41 = avg(v28);
                v40.Speed = v34 * -math.abs(v41);
                local v42 = u17;
                v42.Speed = v42.Speed * u17.SpeedMult;
            end;
            if v31 then
                u17.OnGround = true;
                if not v30 and (v31.Instance ~= workspace.Terrain and v31.Instance:IsA("BasePart")) and (GetAABB(v31.Instance).Y > 15 and not v31.Instance:HasTag("HoverboardIgnore") or (v31.Instance.Transparency == 1 and not v31.Instance:HasTag("HoverboardIgnore") or v31.Instance:IsA("MeshPart") and (u17.BlacklistedMeshIDs[v31.Instance.MeshId] and not v31.Instance:HasTag("HoverboardIgnore")))) then
                    local l__FilterDescendantsInstances__17 = u17.RaycastParams.FilterDescendantsInstances;
                    table.insert(l__FilterDescendantsInstances__17, v31.Instance);
                    u17.RaycastParams.FilterDescendantsInstances = l__FilterDescendantsInstances__17;
                    return;
                end;
                u17.Height.Position = v31.Position + Vector3.new(0, u17.Elevation + v36 * u17.SineDepth + u17.ExtraHeight, 0);
            else
                u17.OnGround = false;
                local l__Height__18 = u17.Height;
                l__Height__18.Position = l__Height__18.Position - Vector3.new(0, u17.FallRate * p24 * 60, 0);
            end;
            u17.Bar.Size = UDim2.fromScale(math.max(u17.Stamina / u17.MaxStamina, 0.01), 1);
            v26.AssemblyLinearVelocity = -Vector3.new(u17.Speed, 0, u17.Speed) * v26.CFrame.LookVector;
            u17.Particles:SetAttribute("Enabled", v26.AssemblyLinearVelocity.Magnitude > 5);
            l__Mince__11.Config.Stats.Hoverboard[2] = `Speed:{u17.Speed}, MoveVector: {tostring(v28)}`;
        end;
    end;
end;
function u17.Weld(p43) --[[ Line: 243 ]]
    -- upvalues: l__LocalPlayer__7 (copy), l__Mince__11 (copy), u18 (ref), u17 (copy)
    local l__Character__19 = l__LocalPlayer__7.Character;
    local l__Humanoid__20 = l__Mince__11.Config.Humanoid;
    local l__HumanoidRootPart__21 = l__Character__19.HumanoidRootPart;
    local l__HipHeight__22 = l__Humanoid__20.HipHeight;
    local v44 = l__Character__19:FindFirstChild("HoverboardWeld");
    if v44 then
        v44:Destroy();
    end;
    local u45 = p43.Handle:Clone();
    u45.Name = "ClientHoverboard";
    local v46 = Instance.new("Weld");
    v46.Name = "HoverboardWeld";
    v46.Part0 = l__HumanoidRootPart__21;
    v46.Part1 = u45;
    v46.C0 = p43:GetAttribute("Offset") or CFrame.Angles(0, 0, 0);
    v46.C1 = CFrame.new(0, l__HipHeight__22 + l__HumanoidRootPart__21.Size.Y / 2 + 0.1, 0) * CFrame.Angles(0, 3.141592653589793, 0);
    v46.Parent = l__LocalPlayer__7.Character;
    u18 = l__HipHeight__22 + l__HumanoidRootPart__21.Size.Y / 2 + 2;
    u17.Elevation = u18;
    v46.Destroying:Connect(function() --[[ Line: 267 ]]
        -- upvalues: u45 (copy), u17 (ref)
        u45:Destroy();
        u17.Hoverboard = nil;
    end);
    u45.Parent = p43;
    u17.Hoverboard = u45;
end;
function u17.OnDash(p47) --[[ Line: 276 ]]
    -- upvalues: u17 (copy)
    if p47 == Enum.UserInputState.Begin then
        u17.Dashing = true;
        u17.Depleted = false;
    else
        u17.Dashing = false;
    end;
end;
function u17.StartTool(u48) --[[ Line: 285 ]]
    -- upvalues: l__VRService__4 (copy), u1 (copy), l__LocalPlayer__7 (copy), u17 (copy), l__Mince__11 (copy), u5 (copy), u11 (copy), u7 (copy), l__CurrentCamera__8 (copy), u10 (copy), l__StarterGui__6 (copy)
    if l__VRService__4.VREnabled then
        u1.Error("The hoverboard is currently disabled for VR!");
        u48.Parent = l__LocalPlayer__7.Backpack;
    else
        local _ = u17.BlockFutureEntries;
        if l__Mince__11.Config.Humanoid then
            u17.IsDisabled = false;
            u17.Events = {};
            u17.Tool = u48;
            u17.ExtraHeight = u48:GetAttribute("ExtraHeight") or 0;
            u17.SineDepth = u48:GetAttribute("SineDepth") or 1;
            u17.SideFreq = u48:GetAttribute("SineFreq") or 1;
            u17.SteerMult = u48:GetAttribute("SteerMult") or 1;
            u17.SpeedMult = u48:GetAttribute("SpeedMult") or 1;
            u17.FallRate = u48:GetAttribute("FallRate") or 0.05;
            u17.LinearMult = u48:GetAttribute("LinearMult") or 1;
            u17.BreakMult = u48:GetAttribute("BreakMult") or 1;
            u17.VeriticalVelocity = 0;
            local l__Humanoid__23 = l__Mince__11.Config.Humanoid;
            local l__Character__24 = l__LocalPlayer__7.Character;
            local v49 = l__Character__24:FindFirstChild("RootAttachment", true);
            local l__Head__25 = l__Character__24.Head;
            local l__HumanoidRootPart__26 = l__Character__24.HumanoidRootPart;
            if not u17.DefaultCustomProperties then
                u17.DefaultCustomProperties = l__HumanoidRootPart__26.CurrentPhysicalProperties;
            end;
            l__HumanoidRootPart__26.CustomPhysicalProperties = PhysicalProperties.new(2, 0, 0);
            local v50 = RaycastParams.new();
            v50.FilterType = Enum.RaycastFilterType.Exclude;
            v50.FilterDescendantsInstances = { l__LocalPlayer__7.Character };
            local v51 = Instance.new("AlignPosition");
            v51.Mode = Enum.PositionAlignmentMode.OneAttachment;
            v51.Attachment0 = v49;
            v51.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
            v51.MaxAxesForce = Vector3.new(0, 300000, 0);
            v51.Position = v49.WorldPosition + Vector3.new(0, u17.Elevation, 0);
            v51.Responsiveness = 30;
            v51.Parent = l__Character__24;
            local v52 = Instance.new("AlignOrientation");
            v52.RigidityEnabled = true;
            v52.Mode = Enum.OrientationAlignmentMode.OneAttachment;
            v52.AlignType = Enum.AlignType.AllAxes;
            v52.Attachment0 = v49;
            v52.CFrame = l__HumanoidRootPart__26.CFrame;
            v52.Parent = l__Character__24;
            u17.HRP = l__HumanoidRootPart__26;
            u17.Orientation = v52;
            u17.Height = v51;
            u17.RaycastParams = v50;
            u17.Particles = u48.Handle.Attachment;
            u17.EmoteCase:Set(false);
            u17.SitCase:Set(false);
            u5.SetMobileBindButtonsEnabled("Sprint", true);
            u17.Weld(u48);
            u17.Events.ToolListener = u48.ChildAdded:Connect(function(p53) --[[ Line: 360 ]]
                if p53.Name == "ServerHoverboard" then
                    p53.Transparency = 1;
                    p53:WaitForChild("Attachment"):Destroy();
                end;
            end);
            u17.Events.Particles = u48.Handle.Attachment:GetAttributeChangedSignal("Enabled"):Connect(function() --[[ Line: 367 ]]
                -- upvalues: u48 (copy), u17 (ref), u11 (ref)
                local v54 = u48.Handle.Attachment:GetAttribute("Enabled");
                for _, v55 in u17.Hoverboard.Attachment:GetChildren() do
                    v55.Enabled = v54;
                end;
                u11:Fire("Toggle", u48, v54);
            end);
            u17.Events.Death = l__Humanoid__23.Died:Once(function() --[[ Line: 377 ]]
                -- upvalues: u17 (ref)
                u17.Hoverboard:Destroy();
                u17.Hoverboard = nil;
            end);
            u7.SetLocomotionEnabled(false);
            for _, v56 in u48:WaitForChild("Animations"):GetChildren() do
                u17.Animations[v56.Name] = l__Humanoid__23:LoadAnimation(v56);
            end;
            local l__Start__27 = u17.Animations.Start;
            local l__Length__28 = l__Start__27.Length;
            local l__Idle__29 = u17.Animations.Idle;
            for _, v57 in l__LocalPlayer__7.Character:GetDescendants() do
                if v57:IsA("BasePart") and v57 ~= l__HumanoidRootPart__26 then
                    v57.Massless = true;
                end;
            end;
            l__Humanoid__23.AutoRotate = false;
            l__Humanoid__23.PlatformStand = true;
            l__CurrentCamera__8.CameraSubject = l__Head__25;
            u17.Bar.Parent.Visible = true;
            u10.StartInteractions();
            l__Start__27:Play();
            task.wait(l__Length__28 * 0.3);
            u11:Fire("Weld", u48);
            u17.Hoverboard.Transparency = 0;
            task.wait(l__Length__28 * 0.65);
            l__Idle__29:Play();
            l__HumanoidRootPart__26.Massless = false;
            l__StarterGui__6:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true);
            u17.ToolActive = true;
            if u48.Parent ~= l__Character__24 then
                u17.EndTool();
            end;
        end;
    end;
end;
function u17.EndTool() --[[ Line: 424 ]]
    -- upvalues: l__VRService__4 (copy), l__Mince__11 (copy), u17 (copy), u7 (copy), u10 (copy), l__LocalPlayer__7 (copy), u5 (copy), l__CurrentCamera__8 (copy)
    if l__VRService__4.VREnabled then
    else
        local l__Humanoid__30 = l__Mince__11.Config.Humanoid;
        u17.BlockFutureEntries = true;
        u17.ToolActive = false;
        u7.Locked = false;
        u17.IsHeld = false;
        u17.Bar.Parent.Visible = false;
        u10.StartInteractions();
        for _, v58 in u17.Animations do
            v58:Stop();
        end;
        u17.Animations.End:Play();
        u17.Animations.End.Ended:Once(function() --[[ Line: 448 ]]
            -- upvalues: u7 (ref), u10 (ref)
            u7.SetLocomotionEnabled(true);
            u10.EndInteractions();
        end);
        for _, v59 in u17.Events do
            v59:Disconnect();
        end;
        for _, v60 in l__LocalPlayer__7.Character:GetDescendants() do
            if v60:IsA("BasePart") then
                v60.Massless = false;
            end;
        end;
        u5.SetMobileBindButtonsEnabled("Sprint", false);
        u17.EmoteCase:Set(true);
        u17.SitCase:Set(true);
        u17.Speed = 0;
        l__Humanoid__30.AutoRotate = true;
        l__Humanoid__30.PlatformStand = false;
        l__CurrentCamera__8.CameraSubject = l__Mince__11.Config.Humanoid;
        l__LocalPlayer__7.Character.HumanoidRootPart.CustomPhysicalProperties = u17.DefaultCustomProperties;
        u17.Height:Destroy();
        u17.Orientation:Destroy();
        task.delay(1, function() --[[ Line: 474 ]]
            -- upvalues: u17 (ref)
            u17.BlockFutureEntries = false;
        end);
    end;
end;
function u17.Setup() --[[ Line: 479 ]]
    -- upvalues: u17 (copy), u6 (copy), u3 (copy), u9 (copy), u4 (copy), u5 (copy), u2 (copy), l__UserInputService__2 (copy), u18 (ref), l__RunService__3 (copy), l__Mince__11 (copy)
    u17.HoverboardGui = u6.GetScreenGui("Hoverboard");
    u17.Bar = u17.HoverboardGui.Bar.Progress;
    u17.EmoteCase = u3.EmoteCase:Extend();
    u17.SitCase = u9.CanSitCase:Extend();
    local v61 = u4.TagEquipped({ "Hoverboard" });
    v61.Equipped:Connect(u17.StartTool);
    v61.Unequipped:Connect(u17.EndTool);
    u5.Get("Sprint").OnAction:Connect(u17.OnDash);
    u2.SettingChanged("Drinking"):Connect(function(p62) --[[ Line: 491 ]]
        -- upvalues: u17 (ref)
        u17.DrinkingEnabled = p62;
    end);
    l__UserInputService__2.JumpRequest:Connect(function() --[[ Line: 495 ]]
        -- upvalues: u17 (ref), u18 (ref)
        if u17.OnGround then
            u17.Elevation = u18 + 3;
            task.wait(0.3);
            u17.Elevation = u18;
        end;
    end);
    l__RunService__3.Heartbeat:Connect(function(p63) --[[ Line: 502 ]]
        -- upvalues: u17 (ref)
        if u17.ToolActive then
            u17.Update(p63);
        end;
    end);
    l__Mince__11.Config.Stats.Hoverboard = { 100, "Idle:Gear" };
end;
return u17;
