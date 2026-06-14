-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Special.Legacy.ThrowCake
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__TweenService__3 = game:GetService("TweenService");
local l__RunService__4 = game:GetService("RunService");
local l__Workspace__5 = game:GetService("Workspace");
local u1 = game:GetService("Players").LocalPlayer:GetMouse();
local l__Mince__6 = require(l__ReplicatedStorage__2.Modules.Mince);
local l__Projectile__7 = require(l__ReplicatedStorage__2.Modules.Projectile);
require(l__ReplicatedStorage__2.Modules.RotatedRegion3);
l__Mince__6:Get("Frostbite");
local u2 = l__Mince__6:Get("Bobbing");
local u3 = l__Mince__6:Get("Settings");
local u4 = l__Mince__6:Get("Intoxication");
local u5 = l__Mince__6:Get("SoundHandler");
local u6 = l__Mince__6:Get("UserProfile");
local u7 = l__Mince__6:Get("ToolHandler");
local u8 = l__Mince__6:Get("BindManager");
local u9 = l__Mince__6:Get("NotifPrompt");
l__Mince__6:Get("DrinkHandler");
local u10 = l__Mince__6:Get("InterfaceHandler");
l__Mince__6:Get("SelectInteractor");
local u11 = l__Mince__6:GetEvent("InteractDrink");
local u12 = l__Mince__6:GetEvent("ExpireIntent");
local v13 = l__Mince__6:GetEvent("ThrowCakes");
local u14 = v13:Extend("ThrowBall");
local u15 = v13:Extend("PlayerHit");
local u16 = l__Mince__6:GetEvent("CakeReplicate", true):Extend("Spawn");
function lerp(p17, p18, p19)
    return p17 * (1 - p19) + p18 * p19;
end;
local u20 = {
    IsHeld = false,
    MaxDistance = 200,
    HoldTime = 0,
    MaxHoldTime = 0.7,
    LoadedAnimations = {},
    CONST = l__Mince__6.Config.Snowball,
    HitTween = TweenInfo.new(4)
};
function u20.Update(p21) --[[ Line: 69 ]]
    -- upvalues: u20 (copy), u2 (copy), l__Workspace__5 (copy), u1 (copy), l__Mince__6 (copy)
    if u20.IsHeld then
        local v22 = u20;
        v22.HoldTime = v22.HoldTime + p21;
        local v23 = math.clamp(u20.HoldTime / u20.MaxHoldTime, 0, 1);
        u2.SetFOVMult(v23 * 0.1 + math.sin(u20.HoldTime * 4) * 0.005 + 1);
        local l__Position__8 = l__Workspace__5.CurrentCamera.CFrame.Position;
        local v24 = l__Workspace__5:Raycast(l__Position__8, (u1.Hit.Position - l__Position__8).Unit * u20.MaxDistance, u20.CastParams);
        local v25;
        if v24 then
            v25 = v24.Position;
        else
            v25 = nil;
        end;
        local l__HumanoidRootPart__9 = l__Mince__6.Config.HumanoidRootPart;
        if l__HumanoidRootPart__9 then
            local l__Rotation__10 = CFrame.new(l__HumanoidRootPart__9.Position * Vector3.new(1, 0, 1), (v25 or u1.Hit.Position) * Vector3.new(1, 0, 1)).Rotation;
            l__HumanoidRootPart__9.CFrame = CFrame.new(l__HumanoidRootPart__9.Position) * l__HumanoidRootPart__9.CFrame.Rotation:Lerp(l__Rotation__10, p21 * 10);
        end;
    else
        u20.HoldTime = 0;
    end;
end;
function u20.ActivateTool(p26) --[[ Line: 101 ]]
    -- upvalues: u4 (copy), u20 (copy), u14 (copy), u1 (copy), u2 (copy), l__TweenService__3 (copy)
    if u4.IsPassedOut() then
    elseif u20.ToolActive then
        if u20.IsDisabled then
        elseif p26 == Enum.UserInputState.Begin then
            u20.IsHeld = true;
            u20.LoadedAnimations.Pull:Play();
            task.wait();
            task.wait();
            u20.LoadedAnimations.HoldIdle:Play();
        else
            if p26 == Enum.UserInputState.End then
                u20.LoadedAnimations.HoldIdle:Stop();
                u20.LoadedAnimations.Pull:Stop();
                u20.LoadedAnimations.Throw:Play();
                local v27 = math.clamp(u20.HoldTime / u20.MaxHoldTime, 0, 1);
                u20.IsHeld = false;
                u20.ToolActive = false;
                u20.IsDisabled = true;
                task.wait(0.2);
                u14:Fire(v27, u20.Tool.Handle.Position, u1.Hit.Position - u20.Tool.Handle.Position);
                task.spawn(function() --[[ Line: 126 ]]
                    -- upvalues: u2 (ref), l__TweenService__3 (ref)
                    local v28 = u2.GetFOVMult();
                    local v29 = 0;
                    local v30 = 0.5;
                    repeat
                        v29 = v29 + task.wait();
                        local v31 = l__TweenService__3:GetValue(v29 / 0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out);
                        u2.SetFOVMult(lerp(v28, 1, v31));
                    until v30 < v29;
                end);
                task.wait(0.1);
                u20.LoadedAnimations.Throw.Ended:Wait();
                u20.IsDisabled = false;
                if u20.Tool.Parent then
                    u20.Tool:Destroy();
                end;
                u20.IsDisabled = true;
            end;
        end;
    end;
end;
function u20.ForceInteractDrink() --[[ Line: 147 ]]
    -- upvalues: u20 (copy), u11 (copy), u4 (copy)
    u20.LastDrink = os.clock();
    u11:Fire();
    local v32 = u20.CurrentTool:GetAttribute("ALCLevel") or 0;
    u4.Consume(v32);
end;
function u20.CheckToolAsync(p33) --[[ Line: 156 ]]
    -- upvalues: u6 (copy), l__Mince__6 (copy), u12 (copy), u9 (copy), u3 (copy)
    u6:WaitUntilLoaded();
    if p33:GetAttribute("UserCreator") and l__Mince__6.Config.LocalProfile.Intents.FIRST_USE_PLAYER_CREATED then
        u12:Fire("FIRST_USE_PLAYER_CREATED");
        u9.Display("This is a player generated item! Any item that has \'\' is created by players, not us.", function() --[[ Line: 161 ]]
            -- upvalues: u3 (ref)
            u3.ChangeSetting("GraphicMode", 2);
        end);
    end;
end;
function u20.StartTool(p34) --[[ Line: 167 ]]
    -- upvalues: l__Mince__6 (copy), u20 (copy), u2 (copy)
    if l__Mince__6.Config.Humanoid then
        u20.ToolActive = true;
        u20.IsDisabled = false;
        u20.Events = {};
        u20.Tool = p34;
        u2.SetFOVMult(1);
        u20.LoadedAnimations = {};
        for _, v35 in p34:WaitForChild("Animations"):GetChildren() do
            u20.LoadedAnimations[v35.Name] = l__Mince__6.Config.Humanoid:LoadAnimation(v35);
        end;
    end;
end;
function u20.GetHitLocal() --[[ Line: 183 ]]
    -- upvalues: u20 (copy), u5 (copy), l__TweenService__3 (copy)
    u20.MainPriority.ScreenEffects.Cake.Emitter.Emit:Fire(1);
    u5.PlaySound("cake_smash");
    local v36 = game.Lighting:FindFirstChild("FightBlur");
    if not v36 then
        v36 = Instance.new("BlurEffect", game.Lighting);
        v36.Name = "FightBlur";
    end;
    v36.Size = 10;
    l__TweenService__3:Create(v36, u20.HitTween, {
        Size = 0
    }):Play();
end;
function u20.SpawnLocalSnowball(p37, p38, p39) --[[ Line: 199 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy), l__Projectile__7 (copy), u20 (copy)
    print("throwing ball");
    local u40 = l__ReplicatedStorage__2.Assets.Spawnables.Cake:Clone();
    u40.Parent = game.Workspace;
    if l__Projectile__7.new({
        Position = p38,
        Velocity = p39.Unit * (u20.CONST.PROJECTILE_POWER * p37),
        Lifetime = u20.CONST.PROJECTILE_LIFETIME,
        Gravity = u20.CONST.PROJECTILE_GRAVITY,
        Params = u20.CastParams
    }, function(p41) --[[ Line: 211 ]]
        -- upvalues: u40 (copy)
        u40.CFrame = CFrame.new(p41);
    end) then
        local v42 = l__ReplicatedStorage__2.Assets.Spawnables.CakeHit:Clone();
        v42.Parent = game.Workspace;
        v42.Position = u40.Position;
        u40:Destroy();
        for _, v43 in v42:GetDescendants() do
            if v43:IsA("ParticleEmitter") then
                v43:Emit(v43.Rate * 2);
            end;
            if v43:IsA("Sound") then
                v43:Play();
            end;
        end;
        task.wait(3);
        v42:Destroy();
    else
        u40:Destroy();
    end;
end;
function u20.EndTool() --[[ Line: 240 ]]
    -- upvalues: u20 (copy)
    u20.ToolActive = false;
    u20.IsHeld = false;
    for _, v44 in u20.LoadedAnimations do
        v44:Stop();
    end;
    for _, v45 in u20.Events do
        v45:Disconnect();
    end;
end;
function u20.Setup() --[[ Line: 253 ]]
    -- upvalues: u20 (copy), u10 (copy), u7 (copy), u8 (copy), u3 (copy), l__RunService__4 (copy), u15 (copy), u16 (copy), l__CollectionService__1 (copy)
    u20.MainPriority = u10.GetScreenGui("MainPriority");
    local v46 = u7.TagEquipped({ "ThrowCake" });
    v46.Equipped:Connect(u20.StartTool);
    v46.Unequipped:Connect(u20.EndTool);
    u8.Get("Interact").OnAction:Connect(u20.ActivateTool);
    u3.SettingChanged("Drinking"):Connect(function(p47) --[[ Line: 262 ]]
        -- upvalues: u20 (ref)
        u20.DrinkingEnabled = p47;
    end);
    l__RunService__4.Heartbeat:Connect(function(p48) --[[ Line: 266 ]]
        -- upvalues: u20 (ref)
        u20.Update(p48);
    end);
    u15.Event:Connect(u20.GetHitLocal);
    u16.Event:Connect(u20.SpawnLocalSnowball);
    local v49 = l__CollectionService__1:GetTagged("IgnoreOnRay");
    local v50 = RaycastParams.new();
    v50.FilterType = Enum.RaycastFilterType.Exclude;
    v50.FilterDescendantsInstances = v49;
    u20.CastParams = v50;
end;
return u20;
