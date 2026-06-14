-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Consumable.Tools.PixelCanvasTool
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("Players");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__2:Get("Notices");
local u1 = l__Mince__2:Get("ToolHandler");
local u2 = l__Mince__2:GetEvent("HoldPetition");
local u9 = {
    InteractBind = 500,
    Tags = { "PixelCanvas" },
    Equipped = function(p3) --[[ Name: Equipped, Line 16 ]]
        -- upvalues: l__Mince__2 (copy), u2 (copy)
        if l__Mince__2.Config.Humanoid then
            u2:Fire(false);
            local l__Animations__3 = p3.Tool:WaitForChild("Animations");
            p3.Animations = {};
            for _, v4 in l__Animations__3:GetChildren() do
                local v5 = l__Mince__2.Config.Humanoid.Animator:LoadAnimation(v4);
                if v5:GetAttribute("Speed") then
                    v5:AdjustSpeed(v5:GetAttribute("Speed"));
                end;
                p3.Animations[v4.Name] = v5;
            end;
            p3.HoldingOut = false;
            p3.Animations.Idle:Play();
        end;
    end,
    Unequipped = function(p6) --[[ Name: Unequipped, Line 37 ]]
        p6.HoldingOut = false;
        for _, v7 in p6.Animations do
            v7:Stop();
        end;
    end,
    Activate = function(p8) --[[ Name: Activate, Line 45 ]]
        -- upvalues: u2 (copy)
        (p8.HoldingOut and p8.Animations.HoldingOut or p8.Animations.Idle):Stop();
        p8.HoldingOut = not p8.HoldingOut;
        (p8.HoldingOut and p8.Animations.HoldingOut or p8.Animations.Idle):Play();
        u2:Fire(p8.HoldingOut);
        return "Sink";
    end
};
function u9.Setup() --[[ Line: 58 ]]
    -- upvalues: u1 (copy), u9 (copy)
    u1.Component(u9);
end;
return u9;
