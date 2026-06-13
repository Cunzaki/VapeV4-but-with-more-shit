-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.HandsetTool
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Players");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__2:Get("Notices");
local u1 = l__Mince__2:Get("ToolHandler");
local u2 = l__Mince__2:Get("PlayerCharacterReplication");
local u6 = {
    InteractBind = 150,
    Tags = { "HandsetTool" },
    Equipped = function(p3) --[[ Name: Equipped, Line 21 ]]
        -- upvalues: l__Mince__2 (copy), u2 (copy)
        warn("equip---->!");
        if l__Mince__2.Config.Humanoid then
            p3.Animations = {};
            p3.AnimationFolder = p3.Tool:FindFirstChild("Animations");
            if p3.AnimationFolder then
                for _, v4 in p3.AnimationFolder:GetChildren() do
                    p3.Animations[v4.Name] = l__Mince__2.Config.Humanoid:LoadAnimation(v4);
                end;
            end;
            if p3.Animations.Idle then
                p3.Animations.Idle:Play();
            end;
            u2.SetHandset(p3.Tool:GetAttribute("Handset"));
            p3.IsEquipped = true;
        end;
    end,
    Unequipped = function(p5) --[[ Name: Unequipped, Line 41 ]]
        -- upvalues: u2 (copy)
        p5.IsEquipped = false;
        if p5.Animations.Idle then
            p5.Animations.Idle:Stop();
        end;
        u2.SetHandset(nil);
    end
};
function u6.Setup() --[[ Line: 51 ]]
    -- upvalues: u1 (copy), u6 (copy)
    u1.Component(u6);
end;
return u6;
