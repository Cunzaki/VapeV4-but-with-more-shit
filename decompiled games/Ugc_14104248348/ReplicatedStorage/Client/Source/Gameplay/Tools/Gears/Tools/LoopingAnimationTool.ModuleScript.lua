-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.LoopingAnimationTool
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Players");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("Notices");
local u2 = l__Mince__2:Get("Locomotion");
local u3 = l__Mince__2:Get("ToolHandler");
local u4 = l__Mince__2:Get("Emote");
local u5 = {
    InteractBind = 150,
    Tags = { "LoopingAnimationTool" }
};
function u5.Activate(u6) --[[ Line: 21 ]]
    -- upvalues: l__Mince__2 (copy), u2 (copy), u1 (copy), u5 (copy)
    if l__Mince__2.Config.Humanoid and not (u6.Active or u6.Stopping) then
        if not u2.IsMoving() then
            if l__Mince__2.Config.Humanoid.Sit and not u6.Tool:GetAttribute("UsableWhileSitting") then
                return u1.Error("You can\'t be sitting to use this tool!");
            end;
            u6.Animations.Idle:Stop();
            u6.Active = true;
            u6.Animations.Start:Play();
            task.spawn(function() --[[ Line: 31 ]]
                -- upvalues: u6 (copy), u5 (ref)
                u6.Animations.Start.Stopped:Wait();
                if u6.Active and not u6.Stopping then
                    u5.EmoteExtendCase:Set(false);
                    u6.Animations.Loop:Play();
                end;
            end);
            u6.EquipMaid:Add(u2.Capture():Connect(function() --[[ Line: 40 ]]
                -- upvalues: u6 (copy)
                if u6.Active then
                    u6:Stop();
                end;
            end));
            return "Sink";
        end;
    end;
end;
function u5.Equipped(p7) --[[ Line: 49 ]]
    -- upvalues: l__Mince__2 (copy)
    warn("equip---->!");
    if l__Mince__2.Config.Humanoid then
        p7.Animations = {};
        p7.AnimationFolder = p7.Tool:FindFirstChild("Animations");
        for _, v8 in p7.AnimationFolder:GetChildren() do
            p7.Animations[v8.Name] = l__Mince__2.Config.Humanoid:LoadAnimation(v8);
        end;
        p7.Animations.Idle:Play();
        p7.IsEquipped = true;
    end;
end;
function u5.Unequipped(p9) --[[ Line: 62 ]]
    -- upvalues: u5 (copy)
    p9.IsEquipped = false;
    if p9.Active then
        p9:Stop();
    end;
    p9.Animations.Idle:Stop();
    u5.EmoteExtendCase:Set(true);
end;
function u5.Stop(p10) --[[ Line: 72 ]]
    -- upvalues: u5 (copy)
    if p10.Stopping then
    else
        p10.Stopping = true;
        local l__IsPlaying__3 = p10.Animations.Loop.IsPlaying;
        for _, v11 in p10.Animations do
            if v11.Name ~= "End" or not l__IsPlaying__3 then
                v11:Stop();
            end;
        end;
        if l__IsPlaying__3 then
            p10.Animations.End:Play();
            task.wait(p10.Animations.End.Length);
        end;
        if p10.IsEquipped then
            p10.Animations.Idle:Play();
        end;
        p10.Stopping = false;
        p10.Active = false;
        u5.EmoteExtendCase:Set(true);
    end;
end;
function u5.Setup() --[[ Line: 99 ]]
    -- upvalues: u5 (copy), u4 (copy), u3 (copy)
    u5.EmoteExtendCase = u4.EmoteCase:Extend();
    u3.Component(u5);
end;
return u5;
