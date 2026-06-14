-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Special.Legacy.Snowball
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__TweenService__3 = game:GetService("TweenService");
local l__RunService__4 = game:GetService("RunService");
game:GetService("Workspace");
local u1 = game:GetService("Players").LocalPlayer:GetMouse();
local l__Mince__5 = require(l__ReplicatedStorage__2.Modules.Mince);
local l__Projectile__6 = require(l__ReplicatedStorage__2.Modules.Projectile);
require(l__ReplicatedStorage__2.Modules.RotatedRegion3);
local u2 = l__Mince__5:Get("Frostbite");
local u3 = l__Mince__5:Get("Bobbing");
local u4 = l__Mince__5:Get("Settings");
local u5 = l__Mince__5:Get("Intoxication");
local u6 = l__Mince__5:Get("SoundHandler");
local u7 = l__Mince__5:Get("UserProfile");
local u8 = l__Mince__5:Get("ToolHandler");
local u9 = l__Mince__5:Get("BindManager");
local u10 = l__Mince__5:Get("NotifPrompt");
l__Mince__5:Get("DrinkHandler");
local u11 = l__Mince__5:Get("InterfaceHandler");
l__Mince__5:Get("SelectInteractor");
local u12 = l__Mince__5:GetEvent("InteractDrink");
local u13 = l__Mince__5:GetEvent("ExpireIntent");
local v14 = l__Mince__5:GetEvent("Snowballs");
local u15 = v14:Extend("ThrowBall");
local u16 = v14:Extend("PlayerHit");
local u17 = l__Mince__5:GetEvent("SnowballReplicate", true):Extend("Spawn");
function lerp(p18, p19, p20)
    return p18 * (1 - p20) + p19 * p20;
end;
local u21 = {
    IsHeld = false,
    MaxDistance = 200,
    HoldTime = 0,
    MaxHoldTime = 0.7,
    LoadedAnimations = {},
    CONST = l__Mince__5.Config.Snowball,
    HitTween = TweenInfo.new(4)
};
function u21.Update(p22) --[[ Line: 69 ]]
    -- upvalues: u21 (copy), u3 (copy), l__Mince__5 (copy), u1 (copy)
    if u21.IsHeld then
        local v23 = u21;
        v23.HoldTime = v23.HoldTime + p22;
        local v24 = math.clamp(u21.HoldTime / u21.MaxHoldTime, 0, 1);
        u3.SetFOVMult(v24 * 0.1 + math.sin(u21.HoldTime * 4) * 0.005 + 1);
        local l__HumanoidRootPart__7 = l__Mince__5.Config.HumanoidRootPart;
        if l__HumanoidRootPart__7 then
            local l__Rotation__8 = CFrame.new(l__HumanoidRootPart__7.Position * Vector3.new(1, 0, 1), u1.Hit.Position * Vector3.new(1, 0, 1)).Rotation;
            l__HumanoidRootPart__7.CFrame = CFrame.new(l__HumanoidRootPart__7.Position) * l__HumanoidRootPart__7.CFrame.Rotation:Lerp(l__Rotation__8, p22 * 10);
        end;
    else
        u21.HoldTime = 0;
    end;
end;
function u21.ActivateTool(p25) --[[ Line: 90 ]]
    -- upvalues: u5 (copy), u21 (copy), u15 (copy), u1 (copy), u3 (copy), l__TweenService__3 (copy)
    if u5.IsPassedOut() then
    elseif u21.ToolActive then
        if u21.IsDisabled then
        elseif p25 == Enum.UserInputState.Begin then
            u21.IsHeld = true;
            u21.LoadedAnimations.Pull:Play();
            task.wait();
            task.wait();
            u21.LoadedAnimations.Idle:Play();
        else
            if p25 == Enum.UserInputState.End then
                u21.LoadedAnimations.Idle:Stop();
                u21.LoadedAnimations.Pull:Stop();
                u21.LoadedAnimations.Throw:Play();
                local v26 = math.clamp(u21.HoldTime / u21.MaxHoldTime, 0, 1);
                u21.IsHeld = false;
                u21.ToolActive = false;
                u21.IsDisabled = true;
                task.wait(0.2);
                u15:Fire(v26, u21.Tool.Handle.Position, u1.Hit.Position - u21.Tool.Handle.Position);
                task.spawn(function() --[[ Line: 115 ]]
                    -- upvalues: u3 (ref), l__TweenService__3 (ref)
                    local v27 = u3.GetFOVMult();
                    local v28 = 0;
                    local v29 = 0.5;
                    repeat
                        v28 = v28 + task.wait();
                        local v30 = l__TweenService__3:GetValue(v28 / 0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out);
                        u3.SetFOVMult(lerp(v27, 1, v30));
                    until v29 < v28;
                end);
                task.wait(0.1);
                u21.LoadedAnimations.Throw.Ended:Wait();
                u21.IsDisabled = false;
                if u21.Tool.Parent then
                    u21.Tool:Destroy();
                end;
                u21.IsDisabled = true;
            end;
        end;
    end;
end;
function u21.ForceInteractDrink() --[[ Line: 136 ]]
    -- upvalues: u21 (copy), u12 (copy), u5 (copy)
    u21.LastDrink = os.clock();
    u12:Fire();
    local v31 = u21.CurrentTool:GetAttribute("ALCLevel") or 0;
    u5.Consume(v31);
end;
function u21.CheckToolAsync(p32) --[[ Line: 145 ]]
    -- upvalues: u7 (copy), l__Mince__5 (copy), u13 (copy), u10 (copy), u4 (copy)
    u7:WaitUntilLoaded();
    if p32:GetAttribute("UserCreator") and l__Mince__5.Config.LocalProfile.Intents.FIRST_USE_PLAYER_CREATED then
        u13:Fire("FIRST_USE_PLAYER_CREATED");
        u10.Display("This is a player generated item! Any item that has \'\' is created by players, not us.", function() --[[ Line: 150 ]]
            -- upvalues: u4 (ref)
            u4.ChangeSetting("GraphicMode", 2);
        end);
    end;
end;
function u21.StartTool(p33) --[[ Line: 156 ]]
    -- upvalues: l__Mince__5 (copy), u21 (copy), u3 (copy)
    if l__Mince__5.Config.Humanoid then
        u21.ToolActive = true;
        u21.IsDisabled = false;
        u21.Events = {};
        u21.Tool = p33;
        u3.SetFOVMult(1);
        u21.LoadedAnimations = {};
        for _, v34 in p33:WaitForChild("Animations"):GetChildren() do
            u21.LoadedAnimations[v34.Name] = l__Mince__5.Config.Humanoid:LoadAnimation(v34);
        end;
    end;
end;
function u21.GetHitLocal() --[[ Line: 172 ]]
    -- upvalues: u2 (copy), l__TweenService__3 (copy), u21 (copy), u6 (copy)
    task.spawn(function() --[[ Line: 173 ]]
        -- upvalues: u2 (ref)
        u2.Consume(0.5);
    end);
    game.Lighting.Snow.Size = 30;
    l__TweenService__3:Create(game.Lighting.Snow, u21.HitTween, {
        Size = 0
    }):Play();
    u21.MainPriority.ScreenEffects.Snow.Emitter.Emit:Fire();
    u6.PlaySound("snowhit");
end;
function u21.SpawnLocalSnowball(p35, p36, p37) --[[ Line: 185 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy), l__Projectile__6 (copy), u21 (copy)
    print("throwing ball");
    local u38 = l__ReplicatedStorage__2.Assets.Spawnables.Snowball:Clone();
    u38.Parent = game.Workspace;
    if l__Projectile__6.new({
        Position = p36,
        Velocity = p37.Unit * (u21.CONST.PROJECTILE_POWER * p35),
        Lifetime = u21.CONST.PROJECTILE_LIFETIME,
        Gravity = u21.CONST.PROJECTILE_GRAVITY,
        Params = u21.CastParams
    }, function(p39) --[[ Line: 197 ]]
        -- upvalues: u38 (copy)
        u38.CFrame = CFrame.new(p39);
    end) then
        local v40 = l__ReplicatedStorage__2.Assets.Spawnables.IceExplosion:Clone();
        v40.Parent = game.Workspace;
        v40.Position = u38.Position;
        u38:Destroy();
        for _, v41 in v40:GetDescendants() do
            if v41:IsA("ParticleEmitter") then
                v41:Emit(v41.Rate * 2);
            end;
            if v41:IsA("Sound") then
                v41:Play();
            end;
        end;
        task.wait(3);
        v40:Destroy();
    else
        u38:Destroy();
    end;
end;
function u21.EndTool() --[[ Line: 226 ]]
    -- upvalues: u21 (copy)
    u21.ToolActive = false;
    u21.IsHeld = false;
    for _, v42 in u21.LoadedAnimations do
        v42:Stop();
    end;
    for _, v43 in u21.Events do
        v43:Disconnect();
    end;
end;
function u21.Setup() --[[ Line: 239 ]]
    -- upvalues: u21 (copy), u11 (copy), u8 (copy), u9 (copy), u4 (copy), l__RunService__4 (copy), u16 (copy), u17 (copy), l__CollectionService__1 (copy)
    u21.MainPriority = u11.GetScreenGui("MainPriority");
    local v44 = u8.TagEquipped({ "Snowball" });
    v44.Equipped:Connect(u21.StartTool);
    v44.Unequipped:Connect(u21.EndTool);
    u9.Get("UnifiedInteract").OnAction:Connect(u21.ActivateTool);
    u4.SettingChanged("Drinking"):Connect(function(p45) --[[ Line: 248 ]]
        -- upvalues: u21 (ref)
        u21.DrinkingEnabled = p45;
    end);
    l__RunService__4.Heartbeat:Connect(function(p46) --[[ Line: 252 ]]
        -- upvalues: u21 (ref)
        u21.Update(p46);
    end);
    u16.Event:Connect(u21.GetHitLocal);
    u17.Event:Connect(u21.SpawnLocalSnowball);
    local v47 = l__CollectionService__1:GetTagged("IgnoreOnRay");
    local v48 = RaycastParams.new();
    v48.FilterType = Enum.RaycastFilterType.Exclude;
    v48.FilterDescendantsInstances = v47;
    u21.CastParams = v48;
end;
return u21;
