-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Special.Legacy.FightBottle
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__TweenService__2 = game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
local u1 = game:GetService("Players").LocalPlayer:GetMouse();
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Projectile__5 = require(l__ReplicatedStorage__1.Modules.Projectile);
require(l__ReplicatedStorage__1.Modules.RotatedRegion3);
l__Mince__4:Get("Frostbite");
local u2 = l__Mince__4:Get("Bobbing");
local u3 = l__Mince__4:Get("Settings");
local u4 = l__Mince__4:Get("Intoxication");
l__Mince__4:Get("SoundHandler");
local u5 = l__Mince__4:Get("UserProfile");
local u6 = l__Mince__4:Get("ToolHandler");
local u7 = l__Mince__4:Get("BindManager");
local u8 = l__Mince__4:Get("NotifPrompt");
l__Mince__4:Get("DrinkHandler");
local u9 = l__Mince__4:Get("InterfaceHandler");
l__Mince__4:Get("SelectInteractor");
local u10 = l__Mince__4:GetEvent("InteractDrink");
local u11 = l__Mince__4:GetEvent("ExpireIntent");
local v12 = l__Mince__4:GetEvent("FightBottle");
local u13 = v12:Extend("ThrowBall");
local u14 = v12:Extend("PlayerHit");
local u15 = l__Mince__4:GetEvent("BottleReplicate", true):Extend("Spawn");
function lerp(p16, p17, p18)
    return p16 * (1 - p18) + p17 * p18;
end;
local u19 = {
    IsHeld = false,
    HoldTime = 0,
    MaxHoldTime = 0.7,
    LoadedAnimations = {},
    CONST = l__Mince__4.Config.Snowball,
    HitTween = TweenInfo.new(2, Enum.EasingStyle.Bounce)
};
function u19.Update(p20) --[[ Line: 61 ]]
    -- upvalues: u19 (copy), u2 (copy), l__Mince__4 (copy), u1 (copy)
    if u19.IsHeld then
        local v21 = u19;
        v21.HoldTime = v21.HoldTime + p20;
        local v22 = math.clamp(u19.HoldTime / u19.MaxHoldTime, 0, 1);
        u2.SetFOVMult(v22 * 0.1 + math.sin(u19.HoldTime * 4) * 0.005 + 1);
        local l__HumanoidRootPart__6 = l__Mince__4.Config.HumanoidRootPart;
        if l__HumanoidRootPart__6 then
            local l__Rotation__7 = CFrame.new(l__HumanoidRootPart__6.Position * Vector3.new(1, 0, 1), u1.Hit.Position * Vector3.new(1, 0, 1)).Rotation;
            l__HumanoidRootPart__6.CFrame = CFrame.new(l__HumanoidRootPart__6.Position) * l__HumanoidRootPart__6.CFrame.Rotation:Lerp(l__Rotation__7, p20 * 10);
        end;
    else
        u19.HoldTime = 0;
    end;
end;
function u19.ActivateTool(p23) --[[ Line: 82 ]]
    -- upvalues: u4 (copy), u19 (copy), u13 (copy), u1 (copy), u2 (copy), l__TweenService__2 (copy)
    if u4.IsPassedOut() then
    elseif u19.ToolActive then
        if u19.IsDisabled then
        elseif p23 == Enum.UserInputState.Begin then
            u19.IsHeld = true;
            u19.LoadedAnimations.Pull:Play();
            task.wait();
            task.wait();
            u19.LoadedAnimations.Idle:Play();
        else
            if p23 == Enum.UserInputState.End then
                u19.LoadedAnimations.Idle:Stop();
                u19.LoadedAnimations.Pull:Stop();
                u19.LoadedAnimations.Throw:Play();
                local v24 = math.clamp(u19.HoldTime / u19.MaxHoldTime, 0, 1);
                u19.IsHeld = false;
                u19.ToolActive = false;
                u19.IsDisabled = true;
                task.wait(0.2);
                u13:Fire(v24, u19.Tool.Handle.Position, u1.Hit.Position - u19.Tool.Handle.Position);
                task.spawn(function() --[[ Line: 107 ]]
                    -- upvalues: u2 (ref), l__TweenService__2 (ref)
                    local v25 = u2.GetFOVMult();
                    local v26 = 0;
                    local v27 = 0.5;
                    repeat
                        v26 = v26 + task.wait();
                        local v28 = l__TweenService__2:GetValue(v26 / 0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out);
                        u2.SetFOVMult(lerp(v25, 1, v28));
                    until v27 < v26;
                end);
                task.wait(0.1);
                u19.LoadedAnimations.Throw.Ended:Wait();
                u19.IsDisabled = false;
                if u19.Tool.Parent then
                    u19.Tool:Destroy();
                end;
                u19.IsDisabled = true;
            end;
        end;
    end;
end;
function u19.ForceInteractDrink() --[[ Line: 128 ]]
    -- upvalues: u19 (copy), u10 (copy), u4 (copy)
    u19.LastDrink = os.clock();
    u10:Fire();
    local v29 = u19.CurrentTool:GetAttribute("ALCLevel") or 0;
    u4.Consume(v29);
end;
function u19.CheckToolAsync(p30) --[[ Line: 137 ]]
    -- upvalues: u5 (copy), l__Mince__4 (copy), u11 (copy), u8 (copy), u3 (copy)
    u5:WaitUntilLoaded();
    if p30:GetAttribute("UserCreator") and l__Mince__4.Config.LocalProfile.Intents.FIRST_USE_PLAYER_CREATED then
        u11:Fire("FIRST_USE_PLAYER_CREATED");
        u8.Display("This is a player generated item! Any item that has \'\' is created by players, not us.", function() --[[ Line: 142 ]]
            -- upvalues: u3 (ref)
            u3.ChangeSetting("GraphicMode", 2);
        end);
    end;
end;
function u19.StartTool(p31) --[[ Line: 148 ]]
    -- upvalues: l__Mince__4 (copy), u19 (copy), u2 (copy)
    if l__Mince__4.Config.Humanoid then
        u19.ToolActive = true;
        u19.IsDisabled = false;
        u19.Events = {};
        u19.Tool = p31;
        u2.SetFOVMult(1);
        u19.LoadedAnimations = {};
        for _, v32 in p31:WaitForChild("Animations"):GetChildren() do
            u19.LoadedAnimations[v32.Name] = l__Mince__4.Config.Humanoid:LoadAnimation(v32);
        end;
    end;
end;
function u19.GetHitLocal() --[[ Line: 164 ]]
    -- upvalues: u19 (copy), l__TweenService__2 (copy)
    u19.MainPriority.ScreenEffects.Glass.Emitter.Emit:Fire(24);
    local v33 = game.Lighting:FindFirstChild("FightBlur");
    if not v33 then
        v33 = Instance.new("BlurEffect", game.Lighting);
        v33.Name = "FightBlur";
    end;
    v33.Size = 10;
    l__TweenService__2:Create(v33, u19.HitTween, {
        Size = 0
    }):Play();
end;
function u19.SpawnLocalBottle(p34, p35, p36) --[[ Line: 178 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), l__Projectile__5 (copy), u19 (copy)
    local u37 = l__ReplicatedStorage__1.Assets.Spawnables.FightBottle:Clone();
    u37.Parent = game.Workspace;
    if l__Projectile__5.new({
        Position = p35,
        Velocity = p36.Unit * (u19.CONST.PROJECTILE_POWER * p34),
        Lifetime = u19.CONST.PROJECTILE_LIFETIME,
        Gravity = u19.CONST.PROJECTILE_GRAVITY
    }, function(p38) --[[ Line: 187 ]]
        -- upvalues: u37 (copy)
        u37.CFrame = CFrame.new(p38);
    end) then
        local v39 = l__ReplicatedStorage__1.Assets.Spawnables.GlassExplosion:Clone();
        v39.Parent = game.Workspace;
        v39.Position = u37.Position;
        u37:Destroy();
        for _, v40 in v39:GetDescendants() do
            if v40:IsA("ParticleEmitter") then
                v40:Emit(v40.Rate * 2);
            end;
            if v40:IsA("Sound") then
                v40.PlaybackSpeed = 0.8 + math.random() * 0.4;
                v40:Play();
            end;
        end;
        task.wait(3);
        v39:Destroy();
    else
        u37:Destroy();
    end;
end;
function u19.EndTool() --[[ Line: 217 ]]
    -- upvalues: u19 (copy)
    u19.ToolActive = false;
    u19.IsHeld = false;
    for _, v41 in u19.LoadedAnimations do
        v41:Stop();
    end;
    for _, v42 in u19.Events do
        v42:Disconnect();
    end;
end;
function u19.Setup() --[[ Line: 230 ]]
    -- upvalues: u19 (copy), u9 (copy), u6 (copy), u7 (copy), u3 (copy), l__RunService__3 (copy), u14 (copy), u15 (copy)
    u19.MainPriority = u9.GetScreenGui("MainPriority");
    local v43 = u6.TagEquipped({ "FightBottle" });
    v43.Equipped:Connect(u19.StartTool);
    v43.Unequipped:Connect(u19.EndTool);
    u7.Get("UnifiedInteract").OnAction:Connect(u19.ActivateTool);
    u3.SettingChanged("Drinking"):Connect(function(p44) --[[ Line: 240 ]]
        -- upvalues: u19 (ref)
        u19.DrinkingEnabled = p44;
    end);
    l__RunService__3.Heartbeat:Connect(function(p45) --[[ Line: 244 ]]
        -- upvalues: u19 (ref)
        u19.Update(p45);
    end);
    u14.Event:Connect(u19.GetHitLocal);
    u15.Event:Connect(u19.SpawnLocalBottle);
end;
return u19;
