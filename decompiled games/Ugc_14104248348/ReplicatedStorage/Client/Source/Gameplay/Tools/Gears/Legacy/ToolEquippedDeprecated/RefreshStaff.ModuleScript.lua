-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Legacy.ToolEquippedDeprecated.RefreshStaff
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("ToolHandler");
local u2 = l__Mince__2:Get("SelectInteractor");
l__Mince__2:Get("Notices");
local u3 = l__Mince__2:Get("Locomotion");
local u4 = l__Mince__2:GetEvent("RefreshStaffFire");
local u5 = {};
function u5.StartTool(p6) --[[ Line: 13 ]]
    -- upvalues: l__Mince__2 (copy), u5 (copy)
    if l__Mince__2.Config.Humanoid then
        u5.ToolActive = true;
        u5.CurrentTool = p6;
        u5.Animation = l__Mince__2.Config.Humanoid.Animator:LoadAnimation(p6.Animations.Staff);
        u5.Busy = l__Mince__2.Config.Humanoid.Animator:LoadAnimation(p6.Animations.StaffFail);
        if not p6:GetAttribute("Uses") then
            p6:SetAttribute("Uses", 0);
        end;
    end;
end;
function u5.EndTool() --[[ Line: 25 ]]
    -- upvalues: u5 (copy)
    u5.ToolActive = false;
end;
function u5.Activate() --[[ Line: 29 ]]
    -- upvalues: u5 (copy), u3 (copy), u4 (copy)
    if not u5.ToolActive or u5.AnimPlaying then
        return "Pass";
    end;
    if u5.CurrentTool:GetAttribute("Disabled") then
        return "Pass";
    end;
    u3.SetLocomotionEnabled(false);
    local l__Animation__3 = u5.Animation;
    local l__Swaft__4 = u5.CurrentTool.Handle.Swaft;
    if u5.CurrentTool:GetAttribute("Timeout") and u5.CurrentTool:GetAttribute("Timeout") > game.Workspace:GetServerTimeNow() then
        l__Animation__3 = u5.Busy;
        l__Swaft__4 = u5.CurrentTool.Handle.Error;
    end;
    l__Animation__3:Play();
    l__Swaft__4:Play();
    u5.AnimPlaying = true;
    task.wait(0.2);
    l__Animation__3.Ended:Once(function() --[[ Line: 51 ]]
        -- upvalues: u5 (ref), u3 (ref)
        u5.AnimPlaying = false;
        u3.SetLocomotionEnabled(true);
    end);
    u4:Fire();
    return "Sink";
end;
function u5.Setup() --[[ Line: 63 ]]
    -- upvalues: u1 (copy), u5 (copy), u2 (copy)
    local v7 = u1.TagEquipped({ "RefreshStaff" });
    v7.Equipped:Connect(u5.StartTool);
    v7.Unequipped:Connect(u5.EndTool);
    u2.BindToInteract(500, u5.Activate);
end;
return u5;
