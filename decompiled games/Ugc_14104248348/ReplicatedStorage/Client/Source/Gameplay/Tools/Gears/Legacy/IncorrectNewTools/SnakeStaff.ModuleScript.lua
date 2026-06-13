-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Legacy.IncorrectNewTools.SnakeStaff
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local l__Players__2 = game:GetService("Players");
game:GetService("Debris");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("ToolHandler");
local u2 = l__Mince__3:Get("Locomotion");
local u3 = l__Mince__3:GetEvent("SyncState");
l__Players__2.LocalPlayer:GetMouse();
local u4 = {
    Tags = { "SnakeStaff" },
    Animations = {}
};
local u5 = false;
function u4.Activate(_) --[[ Line: 23 ]]
    -- upvalues: u4 (copy), u2 (copy), u5 (ref), u3 (copy)
    if not u4.ToolActive or u4.AnimPlaying then
        return "Pass";
    end;
    if u4.CurrentTool:GetAttribute("Disabled") then
        return "Pass";
    end;
    u2.SetLocomotionEnabled(false);
    local l__Animation__4 = u4.Animation;
    local l__Swaft__5 = u4.CurrentTool.Handle.Swaft;
    l__Animation__4:Play();
    l__Swaft__5:Play();
    u4.AnimPlaying = true;
    task.wait(0.2);
    u5 = not u5;
    u3:Fire("SpectralClone", u5);
    l__Animation__4.Ended:Once(function() --[[ Line: 41 ]]
        -- upvalues: u4 (ref), u2 (ref)
        u4.AnimPlaying = false;
        u2.SetLocomotionEnabled(true);
    end);
end;
function u4.Equipped(p6) --[[ Line: 47 ]]
    -- upvalues: l__Mince__3 (copy), u4 (copy)
    if l__Mince__3.Config.Humanoid then
        u4.ToolActive = true;
        u4.CurrentTool = p6.Tool;
        u4.Animation = l__Mince__3.Config.Humanoid.Animator:LoadAnimation(p6.Tool.Animations.Staff);
        u4.Busy = l__Mince__3.Config.Humanoid.Animator:LoadAnimation(p6.Tool.Animations.StaffFail);
    end;
end;
function u4.Unequipped(_) --[[ Line: 55 ]]
    -- upvalues: u4 (copy)
    u4.ToolActive = false;
end;
function u4.Setup() --[[ Line: 59 ]]
    -- upvalues: u1 (copy), u4 (copy)
    u1.Component(u4);
end;
return u4;
