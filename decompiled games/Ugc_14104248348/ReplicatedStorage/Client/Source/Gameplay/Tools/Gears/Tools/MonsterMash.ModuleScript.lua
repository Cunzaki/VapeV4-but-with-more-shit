-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.MonsterMash
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:GetEvent("MonsterMash");
local u2 = l__Mince__2:Get("ToolHandler");
local u4 = {
    InteractBind = 500,
    Tags = { "MonsterMash" },
    Activate = function(p3) --[[ Name: Activate, Line 14 ]]
        -- upvalues: u1 (copy)
        if p3.Tool:GetAttribute("Active") then
            return "Pass";
        end;
        u1:Fire();
        return "Sink";
    end,
    Equipped = function(_) --[[ Name: Equipped, Line 25 ]] end,
    Unequipped = function(_) --[[ Name: Unequipped, Line 28 ]] end
};
function u4.Setup() --[[ Line: 31 ]]
    -- upvalues: u2 (copy), u4 (copy)
    u2.Component(u4);
end;
return u4;
