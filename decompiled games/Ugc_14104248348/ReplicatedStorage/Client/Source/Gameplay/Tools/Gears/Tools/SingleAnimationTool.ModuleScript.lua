-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.SingleAnimationTool
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Players");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("Locomotion");
local u2 = l__Mince__2:Get("ToolHandler");
local u10 = {
    InteractBind = 500,
    Tags = { "SingleAnimationTool" },
    Activate = function(u3) --[[ Name: Activate, Line 18 ]]
        -- upvalues: u1 (copy)
        if not (u1.IsMoving() or u3.Active) then
            u3.Active = true;
            local u4 = u3.Animations[u3:GetNextActionName()];
            u4:Play();
            task.delay(u4.Length, function() --[[ Line: 27 ]]
                -- upvalues: u3 (copy)
                u3.Active = false;
            end);
            if u3.LastCapture then
                u3.LastCapture:Disconnect();
            end;
            u3.LastCapture = u1.Capture():Connect(function() --[[ Line: 32 ]]
                -- upvalues: u3 (copy), u4 (copy)
                if u3.Active then
                    u4:Stop();
                end;
            end);
            u3.EquipMaid:Add(u3.LastCapture);
            return "Sink";
        end;
    end,
    GetNextActionName = function(p5) --[[ Name: GetNextActionName, Line 44 ]]
        p5.CursorPosition = p5.CursorPosition + 1;
        if p5.CursorPosition == 1 then
            return "Action";
        end;
        if p5.Animations[`Action{p5.CursorPosition}`] then
            return `Action{p5.CursorPosition}`;
        end;
        p5.CursorPosition = 1;
        return "Action";
    end,
    Equipped = function(p6) --[[ Name: Equipped, Line 60 ]]
        -- upvalues: l__Mince__2 (copy)
        if l__Mince__2.Config.Humanoid then
            p6.CursorPosition = 0;
            p6.Animations = {};
            p6.AnimationFolder = p6.Tool:FindFirstChild("Animations");
            for _, v7 in p6.AnimationFolder:GetChildren() do
                p6.Animations[v7.Name] = l__Mince__2.Config.Humanoid:LoadAnimation(v7);
            end;
            p6.Animations.Idle:Play();
        end;
    end,
    Unequipped = function(p8) --[[ Name: Unequipped, Line 72 ]]
        for _, v9 in p8.Animations do
            v9:Stop();
        end;
    end
};
function u10.Setup() --[[ Line: 78 ]]
    -- upvalues: u2 (copy), u10 (copy)
    u2.Component(u10);
end;
return u10;
