-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.ProjectileBlaster
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("Players");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("ToolHandler");
l__Mince__2:Get("SoundHandler");
local u2 = l__Mince__2:Get("Locomotion");
local u3 = l__Mince__2:GetEvent("BlastProjectileBlaster");
local u4 = {
    Tags = { "ProjectileBlaster" },
    Animations = {}
};
local u5 = {};
function u4.Activate(u6) --[[ Line: 20 ]]
    -- upvalues: u2 (copy), u3 (copy)
    if not (u2.IsMoving() or u6.Active) then
        u6.Active = true;
        local u7 = u6.Animations[u6:GetNextActionName()];
        u7:Play();
        task.delay(u7.Length, function() --[[ Line: 29 ]]
            -- upvalues: u6 (copy)
            u6.Active = false;
        end);
        task.delay(u7.Length / 2, function() --[[ Line: 33 ]]
            -- upvalues: u6 (copy), u3 (ref)
            if u6.Active then
                u3:Fire();
            end;
        end);
        if u6.LastCapture then
            u6.LastCapture:Disconnect();
        end;
        u6.LastCapture = u2.Capture():Connect(function() --[[ Line: 40 ]]
            -- upvalues: u6 (copy), u7 (copy)
            if u6.Active then
                u7:Stop();
                u6.Active = false;
            end;
        end);
        u6.EquipMaid:Add(u6.LastCapture);
        return "Sink";
    end;
end;
function u4.Equipped(p8) --[[ Line: 52 ]]
    -- upvalues: l__Mince__2 (copy)
    if l__Mince__2.Config.Humanoid then
        p8.CursorPosition = 0;
        p8.Animations = {};
        p8.AnimationFolder = p8.Tool:FindFirstChild("Animations");
        for _, v9 in p8.AnimationFolder:GetChildren() do
            p8.Animations[v9.Name] = l__Mince__2.Config.Humanoid:LoadAnimation(v9);
        end;
        p8.Animations.Idle:Play();
    end;
end;
function u4.Unequipped(p10) --[[ Line: 64 ]]
    for _, v11 in p10.Animations do
        v11:Stop();
        p10.Active = false;
    end;
end;
function u4.GetNextActionName(p12) --[[ Line: 71 ]]
    p12.CursorPosition = p12.CursorPosition + 1;
    if p12.CursorPosition == 1 then
        return "Action";
    end;
    if p12.Animations[`Action{p12.CursorPosition}`] then
        return `Action{p12.CursorPosition}`;
    end;
    p12.CursorPosition = 1;
    return "Action";
end;
function u4.DoEvent(u13, p14) --[[ Line: 87 ]]
    -- upvalues: u5 (copy)
    if u5[u13] then
        if u5[u13]:GetAttribute("CanDestroyAt") > game.Workspace.DistributedGameTime then
            return;
        end;
        u5[u13]:Destroy();
        u5[u13] = nil;
    end;
    local u15 = p14.Projectile:Clone();
    if u15:FindFirstChildOfClass("Weld") then
        u15:FindFirstChildOfClass("Weld"):Destroy();
    end;
    u15.Transparency = 0;
    u15.Parent = workspace;
    u15.CanCollide = true;
    u15.AssemblyLinearVelocity = u13.Character.PrimaryPart.CFrame.LookVector * Vector3.new(1, 0, 1) * 2 * (p14:GetAttribute("VelocityMultiplier") or 1);
    u15:SetAttribute("CanDestroyAt", game.Workspace.DistributedGameTime + 1);
    u5[u13] = u15;
    task.delay(7, function() --[[ Line: 109 ]]
        -- upvalues: u5 (ref), u13 (copy), u15 (copy)
        if u5[u13] and u5[u13] == u15 then
            u15:Destroy();
            u5[u13] = nil;
        end;
    end);
end;
function u4.Setup() --[[ Line: 117 ]]
    -- upvalues: u1 (copy), u4 (copy), u3 (copy)
    u1.Component(u4);
    u3.Event:Connect(u4.DoEvent);
end;
return u4;
