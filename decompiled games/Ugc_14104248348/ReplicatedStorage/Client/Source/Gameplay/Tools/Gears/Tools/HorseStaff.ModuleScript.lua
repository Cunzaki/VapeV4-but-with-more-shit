-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.HorseStaff
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("Players");
game:GetService("Debris");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("ToolHandler");
local u2 = l__Mince__2:Get("Locomotion");
local u3 = l__Mince__2:GetEvent("HorseStaffFire");
local u7 = {
    Tags = { "HorseStaff" },
    Animations = {},
    Activate = function(u4) --[[ Name: Activate, Line 19 ]]
        -- upvalues: u2 (copy), u3 (copy)
        if u4.AnimPlaying then
            return "Pass";
        end;
        u2.SetLocomotionEnabled(false);
        local l__Animation__3 = u4.Animation;
        local l__Swaft__4 = u4.Tool.Handle.Swaft;
        if u4.Tool:GetAttribute("Timeout") and u4.Tool:GetAttribute("Timeout") > game.Workspace:GetServerTimeNow() then
            l__Animation__3 = u4.Busy;
            l__Swaft__4 = u4.Tool.Handle.Error;
        end;
        l__Animation__3:Play();
        l__Swaft__4:Play();
        u4.AnimPlaying = true;
        task.wait(0.2);
        l__Animation__3.Ended:Once(function() --[[ Line: 41 ]]
            -- upvalues: u4 (copy), u2 (ref)
            u4.AnimPlaying = false;
            u2.SetLocomotionEnabled(true);
        end);
        u3:Fire();
        return "Sink";
    end,
    Equipped = function(p5) --[[ Name: Equipped, Line 53 ]]
        -- upvalues: l__Mince__2 (copy)
        if l__Mince__2.Config.Humanoid then
            p5.Animation = l__Mince__2.Config.Humanoid.Animator:LoadAnimation(p5.Tool.Animations.Staff);
            p5.Busy = l__Mince__2.Config.Humanoid.Animator:LoadAnimation(p5.Tool.Animations.StaffFail);
        end;
    end,
    Unequipped = function(p6) --[[ Name: Unequipped, Line 59 ]]
        p6.Animation:Stop();
        p6.Busy:Stop();
    end
};
function u7.Setup() --[[ Line: 64 ]]
    -- upvalues: u1 (copy), u7 (copy)
    u1.Component(u7);
end;
return u7;
