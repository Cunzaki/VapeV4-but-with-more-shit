-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Legacy.ToolEquippedDeprecated.CloneStaff
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("ToolHandler");
local u2 = l__Mince__2:Get("SelectInteractor");
local u3 = l__Mince__2:Get("Notices");
local u4 = l__Mince__2:Get("Locomotion");
local u5 = l__Mince__2:GetEvent("CloneStaffFire");
local u6 = {};
function u6.StartTool(p7) --[[ Line: 13 ]]
    -- upvalues: l__Mince__2 (copy), u6 (copy)
    if l__Mince__2.Config.Humanoid then
        u6.ToolActive = true;
        u6.CurrentTool = p7;
        u6.Animation = l__Mince__2.Config.Humanoid.Animator:LoadAnimation(p7.Animations.Staff);
        u6.Busy = l__Mince__2.Config.Humanoid.Animator:LoadAnimation(p7.Animations.StaffFail);
        if not p7:GetAttribute("Uses") then
            p7:SetAttribute("Uses", 0);
        end;
    end;
end;
function u6.EndTool() --[[ Line: 25 ]]
    -- upvalues: u6 (copy)
    u6.ToolActive = false;
end;
function u6.Activate() --[[ Line: 29 ]]
    -- upvalues: u6 (copy), u4 (copy), u3 (copy), u5 (copy)
    if not u6.ToolActive or u6.AnimPlaying then
        return "Pass";
    end;
    if u6.CurrentTool:GetAttribute("Disabled") then
        return "Pass";
    end;
    u4.SetLocomotionEnabled(false);
    print("Start");
    local l__Animation__3 = u6.Animation;
    local v8 = true;
    local l__Swaft__4 = u6.CurrentTool.Handle.Swaft;
    if u6.CurrentTool:GetAttribute("Timeout") and u6.CurrentTool:GetAttribute("Timeout") > game.Workspace:GetServerTimeNow() then
        l__Animation__3 = u6.Busy;
        l__Swaft__4 = u6.CurrentTool.Handle.Error;
    end;
    local v9 = game.Players.LocalPlayer:GetMouse();
    local v10 = workspace:Raycast(v9.UnitRay.Origin, v9.UnitRay.Direction * 1000);
    if not v10 or v10.Normal:Dot(Vector3.new(0, 1, 0)) < 0.5 then
        u3.Error("Clones have to be placed on flat ground!");
        l__Animation__3 = u6.Busy;
        l__Swaft__4 = u6.CurrentTool.Handle.Error;
        v8 = false;
    end;
    l__Animation__3:Play();
    l__Swaft__4:Play();
    u6.AnimPlaying = true;
    task.wait(0.2);
    l__Animation__3.Ended:Once(function() --[[ Line: 62 ]]
        -- upvalues: u6 (ref), u4 (ref)
        u6.AnimPlaying = false;
        print("End");
        u4.SetLocomotionEnabled(true);
    end);
    if v8 then
        u5:Fire(v9.Hit);
    end;
    if u6.CurrentTool:GetAttribute("Uses") >= 4 then
        u6.CurrentTool:SetAttribute("Disabled", true);
        u6.CurrentTool.Name = "Broken Staff";
        u6.CurrentTool.Head:ClearAllChildren();
        u6.CurrentTool.Head.Material = Enum.Material.Plastic;
    end;
    return "Sink";
end;
function u6.Setup() --[[ Line: 82 ]]
    -- upvalues: u1 (copy), u6 (copy), u2 (copy)
    local v11 = u1.TagEquipped({ "CloneStaff" });
    v11.Equipped:Connect(u6.StartTool);
    v11.Unequipped:Connect(u6.EndTool);
    u2.BindToInteract(500, u6.Activate);
end;
return u6;
