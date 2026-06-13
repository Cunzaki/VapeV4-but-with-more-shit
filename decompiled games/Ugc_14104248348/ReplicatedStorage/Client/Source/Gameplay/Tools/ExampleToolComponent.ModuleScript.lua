-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.ExampleToolComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local u1 = require(l__ReplicatedStorage__1.Modules.Mince):Get("ToolHandler");
local u4 = {
    Tags = { "ExampleTool" },
    CustomMethod = function(_) --[[ Name: CustomMethod, Line 24 ]] end,
    Activate = function(_) --[[ Name: Activate, Line 28 ]] end,
    Equipped = function(p2) --[[ Name: Equipped, Line 32 ]]
        warn("ThisIsTheTool->", p2.Tool);
        p2.RandomNumber = math.random();
        warn("ThisIsARandomNumber", p2.RandomNumber);
        p2:CustomMethod();
    end,
    Unequipped = function(p3) --[[ Name: Unequipped, Line 48 ]]
        warn("ThisIsTheTool->", p3.Tool);
        warn("ICanPrintTheSameRandomNumbHere->", p3.RandomNumber);
    end
};
function u4.Setup() --[[ Line: 54 ]]
    -- upvalues: u1 (copy), u4 (copy)
    u1.Component(u4);
end;
return u4;
