-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.ActionHandsetTool
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
local u8 = {
    InteractBind = 150,
    Tags = { "ActionHandsetTool" },
    Activate = function(p3) --[[ Name: Activate, Line 21 ]]
        p3.Playing = not p3.Playing;
        if p3.Playing then
            p3.Animations.Action:Play();
        else
            p3.Animations.Action:Stop();
        end;
    end,
    Equipped = function(p4) --[[ Name: Equipped, Line 31 ]]
        -- upvalues: l__Mince__2 (copy), u2 (copy)
        warn("equip---->!");
        if l__Mince__2.Config.Humanoid then
            p4.Animations = {};
            p4.AnimationFolder = p4.Tool:FindFirstChild("Animations");
            if p4.AnimationFolder then
                for _, v5 in p4.AnimationFolder:GetChildren() do
                    p4.Animations[v5.Name] = l__Mince__2.Config.Humanoid:LoadAnimation(v5);
                end;
            end;
            if p4.Animations.Idle then
                p4.Animations.Idle:Play();
            end;
            u2.SetHandset(p4.Tool:GetAttribute("Handset"));
            p4.IsEquipped = true;
        end;
    end,
    Unequipped = function(p6) --[[ Name: Unequipped, Line 51 ]]
        -- upvalues: u2 (copy)
        p6.IsEquipped = false;
        for _, v7 in p6.Animations do
            v7:Stop();
        end;
        u2.SetHandset(nil);
    end
};
function u8.Setup() --[[ Line: 61 ]]
    -- upvalues: u1 (copy), u8 (copy)
    u1.Component(u8);
end;
return u8;
