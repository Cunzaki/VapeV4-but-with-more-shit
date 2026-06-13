-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.ClubComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__TweenService__2 = game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__rbxbpm__5 = require(script.rbxbpm);
local l__Mince__6 = require(l__ReplicatedStorage__4.Modules.Mince);
local u1 = l__Mince__6:Get("TriggerHandler");
local u2 = l__Mince__6:Get("InterfaceHandler");
local u3 = l__Mince__6:Get("MarketHandler");
local u4 = l__Mince__6:Get("SoundHandler");
local l__CurrentCamera__7 = workspace.CurrentCamera;
local u5 = l__Mince__6:Get("Bobbing");
local u6 = l__Mince__6:GetEvent("ClubInteract");
local v7 = l__Mince__6.Component({
    Tag = "Club"
});
local u8 = {};
local u9 = {};
local u10 = {};
local u11 = {
    LightReciever = "Lights",
    BassReciever = "Bass"
};
local u12 = CFrame.Angles(1.5707963267948966, 3.141592653589793, 1.5707963267948966);
function v7.OnBeat(p13, p14, _) --[[ Line: 43 ]]
    local l__CurrentLightMode__8 = p13.CurrentLightMode;
    if p14 % 1 == 1 - p13.CurrentLightMode.Beat.DanceFloorSubBeat then
        for _, v15 in p13.DanceFloorParts do
            if v15:IsA("BasePart") then
                v15.Color = l__CurrentLightMode__8.FloorColors[math.random(1, #l__CurrentLightMode__8.FloorColors)];
            end;
        end;
        if #l__CurrentLightMode__8.LightTargets > 0 then
            for _, v16 in p13.Interactive.Lights do
                if v16.Parent:IsA("Model") and v16.Parent.PrimaryPart then
                    local v17 = math.random(1, #l__CurrentLightMode__8.LightTargets);
                    p13:SetLightReciever(v16, p13.Instance.LightTarget[l__CurrentLightMode__8.LightTargets[v17]].Position);
                end;
            end;
        else
            for _, v18 in p13.Interactive.Lights do
                if v18.Parent:IsA("Model") and v18.Parent.PrimaryPart then
                    p13:SetLightReciever(v18, nil);
                end;
            end;
        end;
    end;
    if p14 % 1 == 1 - p13.CurrentLightMode.Beat.LightSubBeat then
        local v19 = l__CurrentLightMode__8.Colors[p13.PlaybackLevel];
        local v20 = v19[math.random(1, #v19)];
        p13.SurfaceLight.Color = v20;
    end;
    if l__CurrentLightMode__8.Flash.Mode == "Constant" then
        p13.LightsOn = not p13.LightsOn;
        p13:UpdateLights(p13.LightsOn and 1 or 0, l__CurrentLightMode__8.Flash.Bias);
    end;
end;
function v7.SetLightReciever(_, p21, p22) --[[ Line: 90 ]]
    -- upvalues: u10 (copy), u9 (copy), u12 (copy)
    local l__Parent__9 = p21.Parent;
    local v23 = l__Parent__9:GetPivot();
    local v24 = math.random();
    if not u10[p21] then
        u10[p21] = v23;
    end;
    u9[p21] = v24;
    for v25 = 0, 1, 0.05 do
        if u9[p21] ~= v24 then
            break;
        end;
        if p22 then
            l__Parent__9:PivotTo(v23:Lerp(CFrame.lookAt(v23.Position, p22) * u12, v25));
        else
            l__Parent__9:PivotTo(v23:Lerp(u10[p21], v25));
        end;
        task.wait();
    end;
end;
function v7.UpdateLights(p26, p27, p28) --[[ Line: 125 ]]
    local l__CurrentLightMode__10 = p26.CurrentLightMode;
    for v29, v30 in p26.Interactive.Lights do
        local v31 = l__CurrentLightMode__10.Colors[p26.PlaybackLevel];
        local v32 = v31[math.max(v29 % (#v31 + 1), 1)];
        if p28 and p28 > 0 then
            p27 = v29 % p28 == 0 and p27 and p27 or 1 - p27;
        end;
        if v30:IsA("BasePart") then
            local v33 = v30:FindFirstChildOfClass("Beam");
            v30.Color = v32;
            v30.LocalTransparencyModifier = p27;
            if v33 then
                v33.Color = ColorSequence.new(v32);
                v33.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, p27), NumberSequenceKeypoint.new(0.867, 1), NumberSequenceKeypoint.new(1, 1) });
            end;
        end;
    end;
end;
function v7.OnLogin(p34) --[[ Line: 154 ]]
    -- upvalues: l__Mince__6 (copy), u3 (copy), u4 (copy)
    local l__DJMaster__11 = l__Mince__6.Config.Products.Passes.DJMaster;
    if u3.GetStatus(l__DJMaster__11) then
        u4.PlaySound("club_log_in");
        p34.LoginPage.Visible = false;
        p34.ConsolePage.Visible = true;
    else
        u3.StartGamepassPurchase(l__DJMaster__11);
    end;
end;
function v7.OnLogout(p35) --[[ Line: 167 ]]
    -- upvalues: u4 (copy)
    u4.PlaySound("club_log_out");
    p35.LoginPage.Visible = true;
    p35.ConsolePage.Visible = false;
end;
function v7.Update(p36, p37) --[[ Line: 174 ]]
    -- upvalues: u8 (copy), u5 (copy)
    local v38 = p37 * 60;
    local l__PlaybackLoudness__12 = p36.Sound.Object.PlaybackLoudness;
    local v39 = "Low";
    local l__CurrentLightMode__13 = p36.CurrentLightMode;
    if p36.HighestPlaybackLoudness < l__PlaybackLoudness__12 then
        p36.HighestPlaybackLoudness = l__PlaybackLoudness__12;
    end;
    p36.PlaybackLevel = l__PlaybackLoudness__12 < p36.HighestPlaybackLoudness * 0.3 and "Low" or (p36.HighestPlaybackLoudness * 0.5 <= l__PlaybackLoudness__12 and "Mid" or (p36.HighestPlaybackLoudness * 0.7 < l__PlaybackLoudness__12 and "High" or v39));
    local v40 = l__PlaybackLoudness__12 / p36.HighestPlaybackLoudness;
    for _, v41 in p36.Interactive.Bass do
        if not u8[v41] then
            u8[v41] = v41.Size;
        end;
        v41.Size = v41.Size:Lerp(u8[v41] * math.min(v40 + 0.5, 1), v38 * 0.3);
    end;
    if l__CurrentLightMode__13.Flash.Mode == "Volume" then
        p36:UpdateLights(v40);
    end;
    if p36.FOVMult ~= p36.FOVMult then
        p36.FOVMult = 1;
    end;
    local l__FOVMult__14 = p36.FOVMult;
    p36.FOVMult = l__FOVMult__14 + (1 + p36.FieldOfViewAdditive * v40 - l__FOVMult__14) * (v38 * 0.1);
    u5.SetFOVMult(p36.FOVMult);
end;
function v7.LoadOptions(_) --[[ Line: 222 ]] end;
function v7.LoadNewMusicMode(p42, p43) --[[ Line: 229 ]]
    -- upvalues: l__Mince__6 (copy)
    p42.bpmClass:SetBpm(l__Mince__6.Config.Club.MusicModes[p43].BPM);
end;
function v7.SetStatusOfGroup(_, p44, p45) --[[ Line: 234 ]]
    local v46 = Color3.new(0.0823529, 0, 1);
    local v47 = Color3.new(0.14902, 1, 0);
    for v48, v49 in p44 do
        if v48 == p45 then
            v49.BackgroundColor3 = v47;
            v49.UIStroke.Color = v47;
        else
            v49.BackgroundColor3 = v46;
            v49.UIStroke.Color = v46;
        end;
    end;
end;
function v7.Construct(u50) --[[ Line: 247 ]]
    -- upvalues: u2 (copy), l__LocalPlayer__1 (copy), l__Mince__6 (copy), u6 (copy), u11 (copy), l__rbxbpm__5 (copy), l__TweenService__2 (copy), l__CurrentCamera__7 (copy), u1 (copy), l__RunService__3 (copy)
    u50.FieldOfViewAdditive = 0.13;
    u50.LightsOn = false;
    u50.HighestPlaybackLoudness = 0;
    u50.PlaybackLevel = "Low";
    u50.Interactive = {
        Lights = {},
        Bass = {}
    };
    u50.FOVMult = 1;
    u50.SurfaceLight = u50.Instance:WaitForChild("SurfaceLight"):WaitForChild("SurfaceLight");
    u50.DanceFloorParts = u50.Instance:WaitForChild("DanceFloor"):GetChildren();
    u50.Panel = u2.GetScreenGui("ClubPanel");
    u50.ConsolePage = u50.Panel.Container.Console;
    u50.LightModePage = u50.ConsolePage.Selection.Light;
    u50.LightModeList = u50.LightModePage.Container.Scroll;
    u50.MusicModePage = u50.ConsolePage.Selection.Music;
    u50.MusicModeList = u50.MusicModePage.Container.Scroll;
    u50.LoginPage = u50.Panel.Container.Login;
    u50.ConsolePage.WelcomeText.Text = `Welcome {l__LocalPlayer__1.Name}`;
    u50.MusicUI = {};
    u50.LightUI = {};
    u2.NewButton(u50.ConsolePage.Logout).Triggered:Connect(function() --[[ Line: 274 ]]
        -- upvalues: u50 (copy)
        u50:Logout();
    end);
    u2.NewButton(u50.LoginPage.StartButton).Triggered:Connect(function() --[[ Line: 278 ]]
        -- upvalues: u50 (copy)
        u50:OnLogin();
    end);
    for u51, v52 in l__Mince__6.Config.Club.LightModes do
        local v53 = u50.LightModeList.Layout.Template:Clone();
        v53.Label.Text = v52.Name;
        v53.Parent = u50.LightModeList;
        u50.LightUI[u51] = v53;
        u2.NewButton(v53).Triggered:Connect(function() --[[ Line: 290 ]]
            -- upvalues: u6 (ref), u50 (copy), u51 (copy)
            u6:Fire(u50.Instance, "WriteConfig", "LightMode", u51);
        end);
    end;
    for u54, v55 in l__Mince__6.Config.Club.MusicModes do
        local v56 = u50.LightModeList.Layout.Template:Clone();
        v56.Parent = u50.MusicModeList;
        v56.Label.Text = v55.Name;
        u50.MusicUI[u54] = v56;
        u2.NewButton(v56).Triggered:Connect(function() --[[ Line: 303 ]]
            -- upvalues: u6 (ref), u50 (copy), u54 (copy)
            u6:Fire(u50.Instance, "WriteConfig", "MusicMode", u54);
        end);
    end;
    u50.Sound = {
        FadeIn = nil,
        FadeOut = nil,
        Tween = TweenInfo.new(2),
        Object = u50.Instance.ENTER_BOX.ClubSound
    };
    for _, v57 in u50.Instance:GetDescendants() do
        local v58 = u11[v57.Name];
        if v58 then
            table.insert(u50.Interactive[v58], v57);
        end;
    end;
    u50.bpmClass = l__rbxbpm__5.new(u50.Sound.Object);
    u50.Sound.FadeIn = l__TweenService__2:Create(u50.Sound.Object, u50.Sound.Tween, {
        Volume = 0.5
    });
    u50.Sound.FadeOut = l__TweenService__2:Create(u50.Sound.Object, u50.Sound.Tween, {
        Volume = 0
    });
    u50.Sound.Object.Volume = 0;
    u50.NormalFieldOfViewTween = l__TweenService__2:Create(l__CurrentCamera__7, TweenInfo.new(1.5), {
        FieldOfView = 70
    });
    u50.CurrentLightMode = l__Mince__6.Config.Club.LightModes[u50.LightMode or 1];
    u50.bpmClass:SetSubBeat(u50.CurrentLightMode.Beat.SongSubBeat);
    u50:SetStatusOfGroup(u50.LightUI, u50.LightMode or 1);
    u50:LoadNewMusicMode(u50.MusicMode);
    u50:SetStatusOfGroup(u50.MusicUI, u50.MusicMode);
    u50.Trigger = u1.GetTrigger("Club");
    u50.Trigger.Entered:Connect(function() --[[ Line: 354 ]]
        -- upvalues: l__RunService__3 (ref), u50 (copy)
        l__RunService__3:BindToRenderStep("UpdateClub", Enum.RenderPriority.Last.Value - 1, function(p59) --[[ Line: 358 ]]
            -- upvalues: u50 (ref)
            u50:Update(p59);
        end);
        u50.BeatConnection = u50.bpmClass.OnBeat:Connect(function(...) --[[ Line: 363 ]]
            -- upvalues: u50 (ref)
            u50:OnBeat(...);
        end);
        u50.Sound.FadeIn:Play();
    end);
    u50.Trigger.Leaved:Connect(function() --[[ Line: 370 ]]
        -- upvalues: l__RunService__3 (ref), u50 (copy)
        l__RunService__3:UnbindFromRenderStep("UpdateClub");
        u50.Sound.FadeOut:Play();
        u50.NormalFieldOfViewTween:Play();
        if u50.BeatConnection then
            u50.BeatConnection:Disconnect();
            u50.BeatConnection = nil;
        end;
    end);
    u50.Sound.Object:GetPropertyChangedSignal("SoundId"):Connect(function() --[[ Line: 381 ]]
        -- upvalues: u50 (copy)
        u50.HighestPlaybackLoudness = 0;
    end);
    u50.Instance:GetAttributeChangedSignal("LightMode"):Connect(function() --[[ Line: 385 ]]
        -- upvalues: u50 (copy), l__Mince__6 (ref)
        u50.CurrentLightMode = l__Mince__6.Config.Club.LightModes[u50.LightMode];
        local v60 = u50.CurrentLightMode.Colors[u50.PlaybackLevel];
        local v61 = v60[math.random(1, #v60)];
        u50.SurfaceLight.Color = v61;
        u50.bpmClass:SetSubBeat(u50.CurrentLightMode.Beat.SongSubBeat);
        u50:SetStatusOfGroup(u50.LightUI, u50.LightMode);
    end);
    u50.Instance:GetAttributeChangedSignal("MusicMode"):Connect(function() --[[ Line: 396 ]]
        -- upvalues: u50 (copy)
        u50:LoadNewMusicMode(u50.MusicMode);
        u50:SetStatusOfGroup(u50.MusicUI, u50.MusicMode);
    end);
end;
return v7;
