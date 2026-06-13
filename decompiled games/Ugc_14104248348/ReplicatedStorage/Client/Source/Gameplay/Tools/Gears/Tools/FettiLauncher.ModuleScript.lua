-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.FettiLauncher
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local l__Players__3 = game:GetService("Players");
local l__Mince__4 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__4:Get("ToolHandler");
local u2 = l__Mince__4:Get("SoundHandler");
local u3 = l__Mince__4:GetEvent("ConfettiPopper");
local u4 = l__Players__3.LocalPlayer:GetMouse();
local u11 = {
    IsHeld = false,
    Tags = { "FettiLauncher" },
    Animations = {},
    Update = function(p5, p6) --[[ Name: Update, Line 21 ]]
        -- upvalues: l__Mince__4 (copy), u4 (copy)
        local v7 = p5.IsHeld and l__Mince__4.Config.HumanoidRootPart;
        if v7 then
            local l__Rotation__5 = CFrame.new(v7.Position * Vector3.new(1, 0, 1), u4.Hit.Position * Vector3.new(1, 0, 1)).Rotation;
            v7.CFrame = CFrame.new(v7.Position) * v7.CFrame.Rotation:Lerp(l__Rotation__5, p6 * 10);
        end;
    end,
    Activate = function(_) --[[ Name: Activate, Line 34 ]]
        -- upvalues: u3 (copy)
        u3:Fire();
        return "Sink";
    end,
    Equipped = function(u8) --[[ Name: Equipped, Line 39 ]]
        -- upvalues: l__RunService__1 (copy)
        u8.IsHeld = true;
        u8.UpdateConnection = l__RunService__1.RenderStepped:Connect(function(p9) --[[ Line: 41 ]]
            -- upvalues: u8 (copy)
            u8:Update(p9);
        end);
    end,
    Unequipped = function(p10) --[[ Name: Unequipped, Line 46 ]]
        p10.IsHeld = false;
        p10.UpdateConnection:Disconnect();
    end
};
function u11.Setup() --[[ Line: 51 ]]
    -- upvalues: u1 (copy), u11 (copy), u3 (copy), u2 (copy)
    u1.Component(u11);
    u3.Event:Connect(function() --[[ Line: 54 ]]
        -- upvalues: u2 (ref)
        u2.PlaySound("error_confetti");
    end);
end;
return u11;
