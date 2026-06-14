-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.AnnTable
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
game:GetService("RunService");
local l__StarterGui__2 = game:GetService("StarterGui");
local l__PolicyService__3 = game:GetService("PolicyService");
local l__TweenService__4 = game:GetService("TweenService");
local l__ReplicatedStorage__5 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local l__Maid__7 = require(l__ReplicatedStorage__5.Modules.Maid);
local l__Mince__8 = require(l__ReplicatedStorage__5.Modules.Mince);
local l__Bucket__9 = require(l__ReplicatedStorage__5.Modules.Bucket);
local l__Numerics__10 = require(l__ReplicatedStorage__5.Modules.Numerics);
local u1 = l__Mince__8:Get("Voicelines");
local u2 = l__Mince__8:Get("LootPrompt");
local u3 = l__Mince__8:Get("NotifPrompt");
local u4 = l__Mince__8:Get("ConfirmPrompt");
local u5 = l__Mince__8:Get("OpeningHandler");
local u6 = l__Mince__8:Get("SelectInteractor");
local u7 = l__Mince__8:Get("InterfaceHandler");
local u8 = l__PolicyService__3:GetPolicyInfoForPlayerAsync(l__LocalPlayer__6);
local u9 = l__Mince__8:GetFunction("LootboxRequest");
local u10 = l__Mince__8.Component({
    Tag = "AnnTable",
    IsMultiCurrency = true,
    ExitCameraSpeedMult = 1.25,
    CameraStudsPerSecond = 48,
    MinimumCameraDistanceVariable = 22,
    MaximumCameraDistanceVariable = 40,
    Translations = {
        Holiday = l__Mince__8.Config.HolidayConfigure.EVENT_CURRENCY_NAME,
        GatchaKeys = l__Mince__8.Config.HolidayConfigure.ALT_CURRENCY.EVENT_CURRENCY_NAME
    },
    Tween1 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In),
    Tween2 = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
    AnnVoicelines = l__Bucket__9.new(l__Mince__8.Config.HolidayConfigure.VOICELINES.GATCHA_GET)
});
function QuadBezier(p11, p12, p13, p14)
    return p12:Lerp(p13, p11):Lerp(p13:Lerp(p14, p11), p11);
end;
function u10.DistanceRoundedCameraPan(p15, p16) --[[ Line: 59 ]]
    -- upvalues: l__TweenService__4 (copy)
    local l__CurrentCamera__11 = game.Workspace.CurrentCamera;
    local v17 = l__CurrentCamera__11:GetRenderCFrame();
    l__CurrentCamera__11.CameraType = Enum.CameraType.Scriptable;
    p15.LastStartingCFrame = v17;
    if l__CurrentCamera__11.CameraSubject:IsA("Humanoid") then
        local l__Parent__12 = l__CurrentCamera__11.CameraSubject.Parent;
        if l__Parent__12 then
            l__Parent__12 = l__Parent__12:FindFirstChild("HumanoidRootPart");
        end;
        if l__Parent__12 then
            p15.LastRelativeCFrame = CFrame.new(l__Parent__12.Position + l__CurrentCamera__11.CameraSubject.CameraOffset):ToObjectSpace(v17);
        end;
    end;
    local l__Position__13 = v17.Position;
    local l__Position__14 = p16.Position;
    local v18 = l__Position__13 * Vector3.new(1, 0, 1) + l__Position__14 * Vector3.new(0, 1, 0);
    local v19 = math.clamp((l__Position__13 - l__Position__14).Magnitude, p15.MinimumCameraDistanceVariable, p15.MaximumCameraDistanceVariable);
    local l__Rotation__15 = v17.Rotation;
    local l__Rotation__16 = p16.Rotation;
    local v20 = 1 / p15.CameraStudsPerSecond * v19;
    local v21 = 0;
    repeat
        v21 = v21 + task.wait();
        local v22 = l__TweenService__4:GetValue(math.clamp(v21 / v20, 0, 1), Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        l__CurrentCamera__11.CFrame = CFrame.new(QuadBezier(v22, l__Position__13, v18, l__Position__14)) * l__Rotation__15:Lerp(l__Rotation__16, v22);
    until v20 < v21;
    l__CurrentCamera__11.CFrame = p16;
end;
function u10.DistanceLinearRevertCamera(p23) --[[ Line: 103 ]]
    -- upvalues: l__Mince__8 (copy), l__TweenService__4 (copy)
    if not p23.LastStartingCFrame then
        return;
    end;
    local l__HumanoidRootPart__17 = l__Mince__8.Config.HumanoidRootPart;
    local l__CurrentCamera__18 = game.Workspace.CurrentCamera;
    local v24 = l__CurrentCamera__18:GetRenderCFrame();
    local l__LastStartingCFrame__19 = p23.LastStartingCFrame;
    local v25 = math.clamp((v24.Position - l__LastStartingCFrame__19.Position).Magnitude, p23.MinimumCameraDistanceVariable, p23.MaximumCameraDistanceVariable);
    local v26 = 1 / p23.CameraStudsPerSecond * v25 * p23.ExitCameraSpeedMult;
    local v27 = 0;
    while true do
        v27 = v27 + task.wait();
        local v28 = l__TweenService__4:GetValue(math.clamp(v27 / v26, 0, 1), Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        if p23.LastRelativeCFrame and l__HumanoidRootPart__17 then
            l__LastStartingCFrame__19 = CFrame.new(l__HumanoidRootPart__17.Position):ToWorldSpace(p23.LastRelativeCFrame);
        end;
        l__CurrentCamera__18.CFrame = v24:Lerp(l__LastStartingCFrame__19, v28);
        if v26 < v27 then
            if l__Mince__8.Config.Humanoid then
                l__CurrentCamera__18.CameraSubject = l__Mince__8.Config.Humanoid;
            else
                task.spawn(function() --[[ Line: 134 ]]
                    -- upvalues: l__Mince__8 (ref), l__CurrentCamera__18 (copy)
                    repeat
                        task.wait();
                    until l__Mince__8.Config.Humanoid;
                    l__CurrentCamera__18.CameraSubject = l__Mince__8.Config.Humanoid;
                end);
            end;
            l__CurrentCamera__18.CameraType = Enum.CameraType.Custom;
            return;
        end;
    end;
end;
function u10.Start(u29, p30) --[[ Line: 143 ]]
    -- upvalues: l__Mince__8 (copy), l__StarterGui__2 (copy), l__LocalPlayer__6 (copy), u1 (copy), u10 (copy)
    if u29.InMachine then
    else
        u29.UseAlternate = p30;
        u29.InteractGrabPoint.Disabled = true;
        if l__Mince__8.Config.Humanoid then
            l__Mince__8.Config.Humanoid:UnequipTools();
        end;
        l__StarterGui__2:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
        u29.InMachine = true;
        u29.Maid:Add(l__LocalPlayer__6.CharacterAdded:Connect(function() --[[ Line: 156 ]]
            -- upvalues: u29 (copy)
            u29:Exit();
        end));
        u1.PlayLine(u10.AnnVoicelines:Next());
        u29.Animations.Bring:AdjustSpeed(1);
        u29.Animations.Bring:Play();
        u29.Animations.Idle:Stop();
        task.wait(0.1);
        u29.Handle.Transparency = 0;
        u29.Handle.Parent.Box.Transparency = 0;
        u29.Handle.Parent.Lid.Transparency = 0;
        u29.Animations.Bring:GetMarkerReachedSignal("Freeze"):Once(function() --[[ Line: 171 ]]
            -- upvalues: u29 (copy)
            u29.InteractGrabPoint.Disabled = false;
            u29.Animations.Bring:AdjustSpeed(0);
        end);
        u29.ProximityPrompt.Enabled = false;
        u29:DistanceRoundedCameraPan(u29.CamerasPart.Focus.WorldCFrame);
        if l__Mince__8.Config.HumanoidRootPart then
            l__Mince__8.Config.HumanoidRootPart.Anchored = true;
        end;
    end;
end;
function u10.Exit(u31) --[[ Line: 183 ]]
    -- upvalues: u9 (copy), l__Mince__8 (copy), u5 (copy)
    if u31.InMachine then
        u31.InMachine = false;
        local v32, v33 = pcall(function() --[[ Line: 187 ]]
            -- upvalues: u9 (ref), u31 (copy)
            return u9:Invoke(u31.LootboxName, u31.UseAlternate);
        end);
        u31.UseAlternate = nil;
        u31.InteractGrabPoint.Disabled = true;
        if l__Mince__8.Config.HumanoidRootPart then
            l__Mince__8.Config.HumanoidRootPart.Anchored = false;
        end;
        u31.Handle.Transparency = 1;
        u31.Handle.Parent.Box.Transparency = 1;
        u31.Handle.Parent.Lid.Transparency = 1;
        u31.Animations.Bring:AdjustSpeed(1);
        u31.Animations.Bring:Stop();
        u31.Animations.Idle:Play();
        u31.Maid:Clean();
        u31:DistanceLinearRevertCamera();
        if v32 and v33 then
            u31.Maid:Add(u5.NextClose:ConnectOnce(function() --[[ Line: 212 ]]
                -- upvalues: u31 (copy)
                u31.ProximityPrompt.Enabled = true;
            end));
            u5[l__Mince__8.Config.HolidayConfigure.EVENT_OPENING_METHOD]({
                IVID = v33
            });
        else
            u31.ProximityPrompt.Enabled = true;
        end;
    end;
end;
function u10.Construct(u34) --[[ Line: 224 ]]
    -- upvalues: u8 (copy), l__Mince__8 (copy), u7 (copy), l__Numerics__10 (copy), u10 (copy), l__Maid__7 (copy), u6 (copy), u2 (copy), u3 (copy), u4 (copy)
    local l__Interact__20 = u34.Instance:WaitForChild("Interact");
    local l__Cameras__21 = u34.Instance:WaitForChild("Cameras");
    local l__Character__22 = u34.Instance:WaitForChild("Character");
    local l__Animations__23 = u34.Instance:WaitForChild("Animations");
    local l__Handle__24 = l__Character__22:WaitForChild("Hand"):WaitForChild("Handle");
    local v35 = Instance.new("ProximityPrompt");
    v35:SetAttribute("Type", "Radial");
    v35:SetAttribute("SizeMultipler", 2);
    v35.MaxActivationDistance = 5;
    v35.Style = Enum.ProximityPromptStyle.Custom;
    v35.Parent = l__Interact__20;
    v35.RequiresLineOfSight = false;
    if u8.ArePaidRandomItemsRestricted and not u34.IsMultiCurrency then
        v35.ObjectText = "Paid Random Items are restricted in your Country/Region!";
    else
        u34.LootboxConfig = l__Mince__8.Config.Lootboxes[u34.LootboxName];
        assert(u34.LootboxConfig, "AnnTable has been refactored to pull data from lootbox config please add LootboxName!");
        if u34.LootboxConfig.AllowUnrestrictedPriceType then
            local v36 = u7.GetScreenGui("LootConfirm");
            v36.Main.Options.BuyOption1.CoinLabel.Text = u34.LootboxConfig.UnrestrictedCost.Amount;
            v36.Main.Options.BuyOption2.CoinLabel.Text = u34.LootboxConfig.Cost.Amount;
            v35.ObjectText = `Play ({l__Numerics__10.TruncateNumber(u34.LootboxConfig.UnrestrictedCost.Amount)} {u10.Translations[u34.LootboxConfig.UnrestrictedCost.Currency] or u34.LootboxConfig.UnrestrictedCost.Currency})`;
        else
            v35.ObjectText = `Play ({l__Numerics__10.TruncateNumber(u34.LootboxConfig.Cost.Amount)} {u34.LootboxConfig.Cost.Currency})`;
        end;
        u34.Events = {};
        u34.Maid = l__Maid__7.new();
        u34.ProximityPrompt = v35;
        u34.CamerasPart = l__Cameras__21;
        u34.Character = l__Character__22;
        u34.Handle = l__Handle__24;
        u34.Handle.Transparency = 1;
        u34.Handle.Parent.Box.Transparency = 1;
        u34.Handle.Parent.Lid.Transparency = 1;
        u34.Animations = {};
        for _, v37 in l__Animations__23:GetChildren() do
            u34.Animations[v37.Name] = u34.Character.Humanoid:LoadAnimation(v37);
        end;
        u34.Animations.Idle:Play();
        local u38 = {
            HoverName = "Grab Present!",
            MaxCharacterDistance = (1 / 0),
            Disabled = true,
            Target = l__Handle__24.Parent,
            HitCollider = l__Handle__24.Parent.Box
        };
        function u38.Interact(_, p39) --[[ Line: 286 ]]
            -- upvalues: u38 (copy), u34 (copy)
            if u38.Disabled then
            else
                task.spawn(function() --[[ Line: 289 ]]
                    -- upvalues: u34 (ref)
                    u34:Exit();
                end);
                p39();
            end;
        end;
        u6.NewInteractionClass(u38);
        u34.InteractGrabPoint = u38;
        v35.Triggered:Connect(function() --[[ Line: 300 ]]
            -- upvalues: u34 (copy), u2 (ref), l__Mince__8 (ref), u3 (ref), u4 (ref)
            if u34.InMachine then
            elseif u34.LootboxConfig.AllowUnrestrictedPriceType then
                u2.Display(l__Mince__8.Config.HolidayConfigure.EVENT_LOOBOX_WOULD_LIKE, function() --[[ Line: 307 ]]
                    -- upvalues: l__Mince__8 (ref), u34 (ref), u3 (ref)
                    if l__Mince__8.Config.LocalProfile[u34.LootboxConfig.UnrestrictedCost.Currency] < u34.LootboxConfig.UnrestrictedCost.Amount then
                        u3.Display("You don\'t have enough to use this!");
                    else
                        u34:Start(true);
                    end;
                end, function() --[[ Line: 315 ]]
                    -- upvalues: l__Mince__8 (ref), u34 (ref), u3 (ref)
                    if l__Mince__8.Config.LocalProfile[u34.LootboxConfig.Cost.Currency] < u34.LootboxConfig.Cost.Amount then
                        u3.Display("You don\'t have enough to use this!");
                    else
                        u34:Start();
                    end;
                end);
            elseif l__Mince__8.Config.LocalProfile[u34.LootboxConfig.Cost.Currency] < u34.LootboxConfig.Cost.Amount then
                u3.Display("You don\'t have enough to use this!");
            else
                local l__Currency__25 = u34.LootboxConfig.Cost.Currency;
                if l__Currency__25 == "Holiday" then
                    l__Currency__25 = l__Mince__8.Config.HolidayConfigure.EVENT_CURRENCY_NAME;
                end;
                u4.Display(`Would you like to open a {l__Mince__8.Config.HolidayConfigure.EVENT_BOX_NAME} for {u34.LootboxConfig.Cost.Amount} {l__Currency__25}?`, function() --[[ Line: 335 ]]
                    -- upvalues: u34 (ref)
                    u34:Start();
                end);
            end;
        end);
    end;
end;
function u10.Setup(_) --[[ Line: 343 ]] end;
return u10;
