-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Special.Tools.Mop
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Players").LocalPlayer:GetMouse();
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Projectile);
require(l__ReplicatedStorage__1.Modules.RotatedRegion3);
l__Mince__2:Get("Frostbite");
local u1 = l__Mince__2:Get("Bobbing");
l__Mince__2:Get("Settings");
l__Mince__2:Get("Intoxication");
l__Mince__2:Get("SoundHandler");
l__Mince__2:Get("UserProfile");
local u2 = l__Mince__2:Get("ToolHandler");
l__Mince__2:Get("BindManager");
l__Mince__2:Get("NotifPrompt");
l__Mince__2:Get("DrinkHandler");
l__Mince__2:Get("InterfaceHandler");
local u3 = l__Mince__2:Get("Locomotion");
l__Mince__2:Get("SelectInteractor");
l__Mince__2:GetEvent("InteractDrink");
l__Mince__2:GetEvent("ExpireIntent");
function lerp(p4, p5, p6)
    return p4 * (1 - p6) + p5 * p6;
end;
local u7 = {
    IsHeld = false,
    HoldTime = 0,
    MaxHoldTime = 0.7,
    LoadedAnimations = {},
    CONST = l__Mince__2.Config.Snowball,
    HitTween = TweenInfo.new(4)
};
function u7.StartClean() --[[ Line: 52 ]]
    -- upvalues: u3 (copy), u7 (copy)
    u3.SetEnabled(false);
    u7.Animations.Use:Play();
end;
function u7.StopClean() --[[ Line: 57 ]]
    -- upvalues: u3 (copy), u7 (copy)
    u3.SetEnabled(true);
    u7.Animations.Use:Stop();
end;
function u7.StartTool(p8) --[[ Line: 65 ]]
    -- upvalues: l__Mince__2 (copy), u7 (copy), u1 (copy)
    if l__Mince__2.Config.Humanoid then
        u7.ToolActive = true;
        u7.IsDisabled = false;
        u7.Events = {};
        u7.Tool = p8;
        u1.SetFOVMult(1);
        u7.Animations = {};
        for _, v9 in p8:WaitForChild("Animations"):GetChildren() do
            u7.Animations[v9.Name] = l__Mince__2.Config.Humanoid:LoadAnimation(v9);
        end;
        u7.Animations.Idle:Play();
    end;
end;
function u7.EndTool() --[[ Line: 83 ]]
    -- upvalues: u7 (copy)
    u7.ToolActive = false;
    u7.IsHeld = false;
    for _, v10 in u7.Animations do
        v10:Stop();
    end;
    for _, v11 in u7.Events do
        v11:Disconnect();
    end;
end;
function u7.Setup() --[[ Line: 96 ]]
    -- upvalues: u2 (copy), u7 (copy)
    local v12 = u2.TagEquipped({ "Mop" });
    v12.Equipped:Connect(u7.StartTool);
    v12.Unequipped:Connect(u7.EndTool);
end;
return u7;
