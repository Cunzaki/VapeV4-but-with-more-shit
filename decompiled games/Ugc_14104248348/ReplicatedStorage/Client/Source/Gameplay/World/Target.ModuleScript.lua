-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.Target
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__2.Modules.Mince);
local l__Signal__5 = require(l__ReplicatedStorage__2.Modules.Signal);
l__Mince__4:Get("Voiceline");
local u1 = l__Mince__4:Get("SoundHandler");
local u2 = l__Mince__4:Get("InterfaceHandler");
local u3 = l__Mince__4:Get("Effects");
local u4 = nil;
local u5 = {
    Tag = "Target",
    BeatWhenEnemySeesPlayer = false,
    MaxCheckViewDistance = 100,
    IsBeating = false,
    BeatTime = 0,
    BeatIntervalMinimum = 1,
    BeatIntervalAdditional = 6,
    ChasePitchPerStudFalloff = 20,
    ChasePitchTargetDistance = 100,
    MaxChasePitch = 2,
    Targets = {},
    TargetsByName = {}
};
local u6 = RaycastParams.new();
u5.BeatIntervalMinimum = u5.BeatIntervalMinimum + u5.BeatIntervalAdditional;
function Inv2(p7)
    local v8 = math.abs(p7 - 0.5) - 0.5;
    return math.abs(v8) * 2;
end;
function u5.CharacterAdded(p9) --[[ Line: 53 ]]
    -- upvalues: u5 (copy), u6 (copy)
    u5.HumanoidRootPart = p9:WaitForChild("HumanoidRootPart");
    u6.FilterDescendantsInstances = { p9, game.Workspace.CurrentCamera:FindFirstChild("ViewModel") };
end;
function u5.SetupTarget(p10) --[[ Line: 62 ]]
    -- upvalues: l__Signal__5 (copy), u5 (copy)
    local l__Parent__6 = p10.Parent;
    local u11 = p10:FindFirstChildWhichIsA("ObjectValue");
    if u11 then
        if l__Parent__6 and l__Parent__6:IsA("BasePart") then
            local u12 = p10:GetAttributes();
            u12.Hit = l__Signal__5.new();
            u12.BasePart = l__Parent__6;
            u12.TargetObject = p10;
            u12.CurrentTarget = u11.Value;
            u11:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 84 ]]
                -- upvalues: u12 (copy), u11 (copy)
                u12.CurrentTarget = u11.Value;
            end);
            table.insert(u5.Targets, u12);
            return u12;
        end;
        warn("The target object must be parented to a basepart!");
    else
        warn("The target object needs a \'target\' objectvalue.");
    end;
end;
function u5.Update(p13) --[[ Line: 93 ]]
    -- upvalues: u5 (copy), l__LocalPlayer__3 (copy), u3 (copy), u1 (copy), u6 (copy), u4 (ref)
    local l__CurrentCamera__7 = game.Workspace.CurrentCamera;
    local v14 = false;
    local v15 = false;
    local v16 = 0;
    for _, u17 in u5.Targets do
        local l__Magnitude__8 = (u17.BasePart.Position - u5.HumanoidRootPart.Position).Magnitude;
        local l__TriggerDistance__9 = u17.TriggerDistance;
        if not u17.Viewed and u17.PlayerViewWhenNotViewed then
            l__TriggerDistance__9 = u17.PlayerViewDistance;
        end;
        if l__LocalPlayer__3.Character ~= nil and u17.CurrentTarget == l__LocalPlayer__3.Character then
            local _ = math.max(0, u5.ChasePitchTargetDistance - l__Magnitude__8) / u5.ChasePitchTargetDistance;
            v15 = true;
        end;
        if l__Magnitude__8 < u5.MaxCheckViewDistance and (l__Magnitude__8 < u17.PlayerViewDistance and not u17.Viewed) then
            local _, v18 = l__CurrentCamera__7:WorldToScreenPoint(u17.BasePart.Position);
            local function v19() --[[ Line: 115 ]]
                -- upvalues: u17 (copy), u3 (ref), u1 (ref)
                warn("Nothing obsecuring!");
                u17.Viewed = true;
                u17.Hit:Fire();
                if u17.DontScare then
                    u3.FocusEffect(u17.BasePart, 0.4);
                else
                    task.spawn(function() --[[ Line: 126 ]]
                        -- upvalues: u1 (ref)
                        u1.PlaySound("Scare.Hard");
                        u1.PlaySound("Scare.Light");
                        u1.PlaySound("Scare.Reverb1");
                    end);
                    u3.ImageEffect();
                    u3.CorrectionSharpEffect({
                        Contrast = 0.9,
                        Saturation = -1,
                        TintColor = Color3.new(1, 0, 0)
                    });
                    u3.SharpCameraEffect({
                        FieldOfView = 40
                    });
                    u3.FocusEffect(u17.BasePart, 0.4);
                end;
            end;
            if v18 and u17.BypassLineOfSight then
                v19();
            else
                local v20 = v18 and game.Workspace:Raycast(l__CurrentCamera__7.CFrame.Position, CFrame.new(l__CurrentCamera__7.CFrame.Position, u17.BasePart.Position).LookVector.Unit * 100, u6);
                if v20 then
                    local l__Instance__10 = v20.Instance;
                    if l__Instance__10 == u17.BasePart or l__Instance__10.Parent == u17.BasePart.Parent then
                        v19();
                    end;
                end;
            end;
        end;
        if not u17.SkipUpdates and (l__Magnitude__8 < l__TriggerDistance__9 and (not u17.IndicateWhenViewed or u17.Viewed)) then
            local _, v21 = l__CurrentCamera__7:WorldToScreenPoint(u17.BasePart.Position);
            if v21 then
                local v22 = game.Workspace:Raycast(l__CurrentCamera__7.CFrame.Position, CFrame.new(l__CurrentCamera__7.CFrame.Position, u17.BasePart.Position).LookVector.Unit * 100, u6);
                if v22 then
                    local l__Instance__11 = v22.Instance;
                    if l__Instance__11 == u17.BasePart or l__Instance__11.Parent == u17.BasePart.Parent then
                        local v23 = u17.TriggerDistance - l__Magnitude__8;
                        local v24 = (v23 + u17.MostTriggerDistance) / u17.TriggerDistance;
                        if u17.MostTriggerDistance < l__Magnitude__8 then
                            v24 = v23 / (u17.TriggerDistance - u17.MostTriggerDistance);
                        end;
                        v16 = math.min(1, v24);
                        v14 = true;
                    end;
                end;
            end;
        end;
    end;
    if v14 and not v15 then
        if not u5.IsBeating then
            u5.IsBeating = true;
            u5.BeatTime = 0;
        end;
    else
        u5.IsBeating = false;
    end;
    if u5.IsBeating or u5.OverwriteBeating then
        if u5.OverwriteBeating then
            v16 = u5.BeatDecimal;
        end;
        local v25 = u5;
        v25.BeatTime = v25.BeatTime + p13;
        local v26 = u5.BeatIntervalMinimum - u5.BeatIntervalAdditional * v16;
        if v26 < u5.BeatTime then
            u5.BeatTime = 0;
            warn("playing...");
            u1.PlaySound("Player.Heartbeat");
        end;
        u4.ImageTransparency = u5.BeatTime / v26;
    else
        u4.ImageTransparency = 1;
    end;
end;
function u5.Setup() --[[ Line: 230 ]]
    -- upvalues: u4 (ref), u2 (copy), u1 (copy), l__Mince__4 (copy), u6 (copy), u5 (copy), l__LocalPlayer__3 (copy), l__CollectionService__1 (copy)
    u4 = u2.GetScreenGui("MainPriority").Graident;
    u1.WaitUntilSoundLoaded();
    l__Mince__4.SetupComponent("Interaction", function(p27) --[[ Line: 235 ]]
        -- upvalues: u6 (ref)
        table.insert(u6.FilterDescendantsInstances, p27.Instance);
    end);
    task.spawn(function() --[[ Line: 242 ]]
        -- upvalues: u5 (ref)
        while true do
            u5.Update(task.wait());
        end;
    end);
    l__LocalPlayer__3.CharacterAdded:Connect(u5.CharacterAdded);
    if l__LocalPlayer__3.Character then
        u5.CharacterAdded(l__LocalPlayer__3.Character);
    end;
    for _, v28 in l__CollectionService__1:GetTagged(u5.Tag) do
        u5.SetupTarget(v28);
    end;
    l__CollectionService__1:GetInstanceAddedSignal(u5.Tag):Connect(function(p29) --[[ Line: 259 ]]
        -- upvalues: u5 (ref)
        u5.SetupTarget(p29);
    end);
end;
return u5;
