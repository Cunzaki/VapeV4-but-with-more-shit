-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.OrnamentStand
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__StarterGui__3 = game:GetService("StarterGui");
local l__TweenService__4 = game:GetService("TweenService");
local l__ReplicatedStorage__5 = game:GetService("ReplicatedStorage");
local l__MarketplaceService__6 = game:GetService("MarketplaceService");
local l__LocalPlayer__7 = l__Players__1.LocalPlayer;
local l__Maid__8 = require(l__ReplicatedStorage__5.Modules.Maid);
local l__Mince__9 = require(l__ReplicatedStorage__5.Modules.Mince);
local l__Bucket__10 = require(l__ReplicatedStorage__5.Modules.Bucket);
local l__ModelTweenOG__11 = require(game.ReplicatedStorage.Modules.ModelTweenOG);
local u1 = l__Mince__9:Get("Voicelines");
l__Mince__9:Get("NotifPrompt");
local u2 = l__Mince__9:Get("Notices");
l__Mince__9:Get("ConfirmPrompt");
local u3 = l__Mince__9:Get("InterfaceHandler");
l__Mince__9:Get("SelectInteractor");
local u4 = l__Mince__9:GetEvent("RequestOrnament");
local u5 = l__Mince__9.Component({
    Tag = "OrnamentStand",
    OrnamentRotationSpeed = 40,
    CurrentRotation = 0,
    ExitCameraSpeedMult = 1.25,
    CameraStudsPerSecond = 48,
    MinimumCameraDistanceVariable = 22,
    MaximumCameraDistanceVariable = 40,
    Tween1 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In),
    Tween2 = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
    ColorHSV = { 1, 1, 1 },
    Voicelines = l__Bucket__10.new({
        "CHRS24OrnamentJoin1",
        "CHRS24OrnamentJoin2",
        "CHRS24OrnamentJoin3",
        "CHRS24OrnamentJoin4"
    }),
    LeavingLines = l__Bucket__10.new({
        "CHRS24OrnamentLeave1",
        "CHRS24OrnamentLeave2",
        "CHRS24OrnamentLeave3",
        "CHRS24OrnamentLeave4"
    })
});
function QuadBezier(p6, p7, p8, p9)
    return p7:Lerp(p8, p6):Lerp(p8:Lerp(p9, p6), p6);
end;
function u5.DistanceRoundedCameraPan(p10, p11) --[[ Line: 57 ]]
    -- upvalues: l__TweenService__4 (copy)
    local l__CurrentCamera__12 = game.Workspace.CurrentCamera;
    local v12 = l__CurrentCamera__12:GetRenderCFrame();
    l__CurrentCamera__12.CameraType = Enum.CameraType.Scriptable;
    p10.LastStartingCFrame = v12;
    if l__CurrentCamera__12.CameraSubject:IsA("Humanoid") then
        local l__Parent__13 = l__CurrentCamera__12.CameraSubject.Parent;
        if l__Parent__13 then
            l__Parent__13 = l__Parent__13:FindFirstChild("HumanoidRootPart");
        end;
        if l__Parent__13 then
            p10.LastRelativeCFrame = CFrame.new(l__Parent__13.Position + l__CurrentCamera__12.CameraSubject.CameraOffset):ToObjectSpace(v12);
        end;
    end;
    local l__Position__14 = v12.Position;
    local l__Position__15 = p11.Position;
    local v13 = l__Position__14 * Vector3.new(1, 0, 1) + l__Position__15 * Vector3.new(0, 1, 0);
    local v14 = math.clamp((l__Position__14 - l__Position__15).Magnitude, p10.MinimumCameraDistanceVariable, p10.MaximumCameraDistanceVariable);
    local l__Rotation__16 = v12.Rotation;
    local l__Rotation__17 = p11.Rotation;
    local v15 = 1 / p10.CameraStudsPerSecond * v14;
    local v16 = 0;
    repeat
        v16 = v16 + task.wait();
        local v17 = l__TweenService__4:GetValue(math.clamp(v16 / v15, 0, 1), Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        l__CurrentCamera__12.CFrame = CFrame.new(QuadBezier(v17, l__Position__14, v13, l__Position__15)) * l__Rotation__16:Lerp(l__Rotation__17, v17);
    until v15 < v16;
    l__CurrentCamera__12.CFrame = p11;
end;
function u5.DistanceLinearRevertCamera(p18) --[[ Line: 101 ]]
    -- upvalues: l__Mince__9 (copy), l__TweenService__4 (copy)
    if not p18.LastStartingCFrame then
        return;
    end;
    local l__HumanoidRootPart__18 = l__Mince__9.Config.HumanoidRootPart;
    local l__CurrentCamera__19 = game.Workspace.CurrentCamera;
    local v19 = l__CurrentCamera__19:GetRenderCFrame();
    local l__LastStartingCFrame__20 = p18.LastStartingCFrame;
    local v20 = math.clamp((v19.Position - l__LastStartingCFrame__20.Position).Magnitude, p18.MinimumCameraDistanceVariable, p18.MaximumCameraDistanceVariable);
    local v21 = 1 / p18.CameraStudsPerSecond * v20 * p18.ExitCameraSpeedMult;
    local v22 = 0;
    while true do
        v22 = v22 + task.wait();
        local v23 = l__TweenService__4:GetValue(math.clamp(v22 / v21, 0, 1), Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        if p18.LastRelativeCFrame and l__HumanoidRootPart__18 then
            l__LastStartingCFrame__20 = CFrame.new(l__HumanoidRootPart__18.Position):ToWorldSpace(p18.LastRelativeCFrame);
        end;
        l__CurrentCamera__19.CFrame = v19:Lerp(l__LastStartingCFrame__20, v23);
        if v21 < v22 then
            if l__Mince__9.Config.Humanoid then
                l__CurrentCamera__19.CameraSubject = l__Mince__9.Config.Humanoid;
            else
                task.spawn(function() --[[ Line: 132 ]]
                    -- upvalues: l__Mince__9 (ref), l__CurrentCamera__19 (copy)
                    repeat
                        task.wait();
                    until l__Mince__9.Config.Humanoid;
                    l__CurrentCamera__19.CameraSubject = l__Mince__9.Config.Humanoid;
                end);
            end;
            l__CurrentCamera__19.CameraType = Enum.CameraType.Custom;
            return;
        end;
    end;
end;
function u5.Start(u24) --[[ Line: 141 ]]
    -- upvalues: l__Mince__9 (copy), l__StarterGui__3 (copy), l__LocalPlayer__7 (copy), u1 (copy), u5 (copy), l__ReplicatedStorage__5 (copy), l__RunService__2 (copy)
    if u24.InMachine then
    else
        u24.CurrentOrnament = 1;
        u24.AllowNextAttempt = true;
        u24.CurrentDecal = nil;
        u24.Interface.TextBox.TextBox.Text = "";
        if l__Mince__9.Config.Humanoid then
            l__Mince__9.Config.Humanoid:UnequipTools();
        end;
        l__StarterGui__3:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
        u24.InMachine = true;
        u24.Maid:Add(l__LocalPlayer__7.CharacterAdded:Connect(function() --[[ Line: 156 ]]
            -- upvalues: u24 (copy)
            u24:Exit();
        end));
        u1.PlayLine(u5.Voicelines:Next());
        u24.ProximityPrompt.Enabled = false;
        u24:DistanceRoundedCameraPan(u24.CameraPoint);
        if l__Mince__9.Config.HumanoidRootPart then
            l__Mince__9.Config.HumanoidRootPart.Anchored = true;
        end;
        u24.Interface.Visible = true;
        u24.Ornaments = l__ReplicatedStorage__5.Assets.Misc.Ornaments:Clone();
        u24.Ornaments.Parent = u24.Instance;
        for _, v25 in u24.Ornaments:GetChildren() do
            v25:PivotTo(u24.HidePoint);
        end;
        local v26 = l__RunService__2.RenderStepped:Connect(function(...) --[[ Line: 177 ]]
            -- upvalues: u24 (copy)
            u24:Update(...);
        end);
        u24.Maid:Add(v26);
    end;
end;
function u5.Exit(p27) --[[ Line: 184 ]]
    -- upvalues: l__Mince__9 (copy), l__StarterGui__3 (copy)
    if p27.InMachine then
        if l__Mince__9.Config.HumanoidRootPart then
            l__Mince__9.Config.HumanoidRootPart.Anchored = false;
        end;
        l__StarterGui__3:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true);
        p27.Interface.Visible = false;
        p27.ProximityPrompt.Enabled = true;
        p27.Maid:Clean();
        p27.Ornaments:Destroy();
        p27:DistanceLinearRevertCamera();
        p27.InMachine = false;
    end;
end;
function u5.Update(p28, p29) --[[ Line: 203 ]]
    local v30 = p28.Ornaments[`{p28.CurrentOrnament}`];
    p28.CurrentRotation = p28.CurrentRotation + p28.OrnamentRotationSpeed * p29;
    if p28.CurrentRotation > 360 then
        p28.CurrentRotation = 0;
    end;
    v30:PivotTo(CFrame.new(p28.OrnamentPoint.Position) * CFrame.Angles(0, math.rad(p28.CurrentRotation), 0));
end;
function u5.UpdateImage(p31) --[[ Line: 217 ]]
    -- upvalues: u2 (copy), l__MarketplaceService__6 (copy)
    local u32 = tonumber(p31.Interface.TextBox.TextBox.Text);
    if u32 then
        local v33, v34 = pcall(function() --[[ Line: 221 ]]
            -- upvalues: l__MarketplaceService__6 (ref), u32 (copy)
            return l__MarketplaceService__6:GetProductInfo(u32, Enum.InfoType.Asset);
        end);
        if v33 then
            p31.IsDecal = false;
            if v34.IconImageAssetId and v34.IconImageAssetId ~= 0 then
                if v34.AssetTypeId ~= 1 then
                    u32 = v34.IconImageAssetId;
                end;
            elseif not v34 or v34.AssetTypeId ~= 1 then
                if v34.AssetTypeId ~= 13 then
                    u2.Error("Failed to retrieve IconImageAssetId!");
                    return;
                end;
                p31.IsDecal = true;
            end;
            u2.CreateNotice("Image changed!");
            p31.CurrentDecal = u32;
            for _, v35 in p31.Ornaments:GetChildren() do
                for _, v36 in v35.Danglybit:GetChildren() do
                    v36.Texture = p31.IsDecal and `rbxthumb://type=Asset&id={u32}&w=420&h=420` or `http://www.roblox.com/asset/?id={u32}`;
                end;
            end;
        else
            u2.Error("Invalid ID or failed to retrieve info!");
        end;
    else
        return u2.Error("Invalid ID!");
    end;
end;
function u5.Cycle(p37, p38) --[[ Line: 256 ]]
    p37.CurrentOrnament = (p37.CurrentOrnament + p38 - 1) % 3 + 1;
    for _, v39 in p37.Ornaments:GetChildren() do
        v39:PivotTo(p37.HidePoint);
    end;
end;
function u5.DoMeltdown(p40) --[[ Line: 264 ]]
    -- upvalues: u1 (copy), l__ModelTweenOG__11 (copy)
    p40.MoveToStare:Play();
    p40.Interface.Visible = false;
    task.wait(0.6);
    u1.PlayLine("CHRS24OrnamentMeltdown");
    task.wait(11);
    p40.Instance.PrimaryPart.Fire.Flames1.Enabled = true;
    p40.Instance.PrimaryPart.Fire.Fire:Play();
    task.wait(4);
    p40.Instance.PrimaryPart.Fire.Flames1.Enabled = false;
    p40.Instance.PrimaryPart.Fire.Fire:Pause();
    p40.Character:PivotTo(p40.Instance.StandSpot.CFrame);
    p40.MoveToStare = l__ModelTweenOG__11.new(p40.Character, TweenInfo.new(1), p40.Instance.MeltdownSpot.CFrame);
end;
function u5.ToggleColorPicker(p41) --[[ Line: 280 ]]
    local l__Visible__21 = p41.Interface.TextBox.Visible;
    p41.Interface.TextBox.Visible = not l__Visible__21;
    p41.Interface.Buttons.Visible = not l__Visible__21;
    p41.Interface.TextLabel.Visible = not l__Visible__21;
    p41.Interface.ColorPicker.Visible = l__Visible__21;
end;
function u5.SetupColorPickers(u42) --[[ Line: 290 ]]
    -- upvalues: u3 (copy)
    local v43 = u3.NewSlider(u42.ColorPicker.Value, "Y");
    v43.Changed:Connect(function(p44) --[[ Line: 292 ]]
        -- upvalues: u42 (copy)
        u42:ConstructNewColor({
            [3] = 1 - p44
        });
    end);
    local v45 = u3.NewSlidepad(u42.ColorPicker.Color);
    v45.Changed:Connect(function(p46) --[[ Line: 299 ]]
        -- upvalues: u42 (copy)
        u42:ConstructNewColor({ p46.X, 1 - p46.Y });
    end);
    u42.Slider = v43;
    u42.Slidepad = v45;
end;
function u5.ConstructNewColor(p47, p48) --[[ Line: 310 ]]
    for v49, v50 in pairs(p48) do
        p47.ColorHSV[v49] = v50;
    end;
    p47.CurrentColor = Color3.fromHSV(table.unpack(p47.ColorHSV));
    p47:UpdateOrnamentColor();
end;
function u5.UpdateOrnamentColor(p51) --[[ Line: 319 ]]
    for _, v52 in p51.Ornaments:GetChildren() do
        v52.Danglybit.Color = p51.CurrentColor;
    end;
end;
function u5.Construct(u53) --[[ Line: 325 ]]
    -- upvalues: l__Maid__8 (copy), u3 (copy), l__ModelTweenOG__11 (copy), u4 (copy), u1 (copy), u5 (copy)
    local l__PrimaryPart__22 = u53.Instance.PrimaryPart;
    local l__Character__23 = u53.Instance:WaitForChild("Character");
    local l__Animations__24 = l__Character__23:WaitForChild("Animations");
    local v54 = Instance.new("ProximityPrompt");
    v54:SetAttribute("Type", "Radial");
    v54:SetAttribute("SizeMultipler", 1);
    v54.ObjectText = "Create Ornament";
    v54.MaxActivationDistance = 5;
    v54.Style = Enum.ProximityPromptStyle.Custom;
    v54.Parent = l__PrimaryPart__22.Prompt;
    v54.RequiresLineOfSight = false;
    u53.Events = {};
    u53.ColorHSV = {};
    u53.Maid = l__Maid__8.new();
    u53.ProximityPrompt = v54;
    u53.CameraPoint = CFrame.new(l__PrimaryPart__22.Camera.WorldPosition, l__PrimaryPart__22.Focus.WorldPosition);
    u53.Character = l__Character__23;
    u53.Interface = u3.GetScreenGui("OrnamentUI").Main;
    u53.OrnamentPoint = l__PrimaryPart__22.Ornament.WorldCFrame;
    u53.HidePoint = l__PrimaryPart__22.Hide.WorldCFrame;
    u53.ColorPicker = u53.Interface.ColorPicker;
    u53.ColorHSV = { 1, 1, 1 };
    u53.MoveToStare = l__ModelTweenOG__11.new(u53.Character, TweenInfo.new(1), u53.Instance.MeltdownSpot.CFrame);
    u53.Animations = {};
    for _, v55 in l__Animations__24:GetChildren() do
        u53.Animations[v55.Name] = u53.Character.Humanoid:LoadAnimation(v55);
    end;
    u53.Animations.Idle:Play();
    local v56 = u3.NewButton(u53.Interface.TextBox.OkayButton);
    local v57 = u3.NewButton(u53.Interface.Bar.LeftArrowButton);
    local v58 = u3.NewButton(u53.Interface.Bar.RightArrowButton);
    local v59 = u3.NewButton(u53.Interface.Buttons.OkayButton);
    local v60 = u3.NewButton(u53.Interface.Buttons.ColorButton);
    local v61 = u3.NewButton(u53.Interface.ColorPicker.OkayButton);
    u53:SetupColorPickers();
    v56.Activated:Connect(function() --[[ Line: 371 ]]
        -- upvalues: u53 (copy)
        u53:UpdateImage();
    end);
    v57.Activated:Connect(function() --[[ Line: 375 ]]
        -- upvalues: u53 (copy)
        u53:Cycle(-1);
    end);
    v58.Activated:Connect(function() --[[ Line: 379 ]]
        -- upvalues: u53 (copy)
        u53:Cycle(1);
    end);
    v60.Activated:Connect(function() --[[ Line: 383 ]]
        -- upvalues: u53 (copy)
        u53:ToggleColorPicker();
    end);
    v61.Activated:Connect(function() --[[ Line: 387 ]]
        -- upvalues: u53 (copy)
        u53:ToggleColorPicker();
    end);
    v59.Activated:Connect(function() --[[ Line: 391 ]]
        -- upvalues: u53 (copy), u4 (ref), u1 (ref), u5 (ref)
        if math.random(1, 40) == 1 then
            u53:DoMeltdown();
            u53:Exit();
        else
            u53.Interface.Visible = false;
            u4:Fire(u53.CurrentOrnament, u53.CurrentColor, u53.CurrentDecal, u53.IsDecal);
            u1.PlayLine(u5.LeavingLines:Next());
            task.wait(2);
            u53:Exit();
        end;
    end);
    v54.Triggered:Connect(function() --[[ Line: 405 ]]
        -- upvalues: u53 (copy)
        if u53.InMachine then
        else
            u53:Start();
        end;
    end);
end;
return u5;
