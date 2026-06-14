-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.SwordTool
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("ToolHandler");
local u2 = l__Mince__2:GetEvent("BossEvents"):Extend("GiveMyselfTargeting");
local u3 = {
    InteractBind = 500,
    Tags = { "ZombieOffense" },
    Equipped = function(_) --[[ Name: Equipped, Line 16 ]]
        -- upvalues: u2 (copy)
        u2:Fire(true);
    end,
    Unequipped = function(_) --[[ Name: Unequipped, Line 20 ]]
        -- upvalues: u2 (copy)
        u2:Fire(false);
    end
};
function u3.Setup() --[[ Line: 24 ]]
    -- upvalues: u1 (copy), u3 (copy)
    u1.Component(u3);
end;
return u3;
