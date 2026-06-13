-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.RecipeBook
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("MarketplaceService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("Players");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("ToolHandler");
local u2 = l__Mince__2:Get("DrinkRecipes");
local u3 = {
    Tags = { "RecipeBook" },
    Equipped = function(_) --[[ Name: Equipped, Line 15 ]]
        -- upvalues: u2 (copy)
        u2.Interface:Open();
    end,
    Unequipped = function(_) --[[ Name: Unequipped, Line 19 ]]
        -- upvalues: u2 (copy)
        u2.Interface:Close();
    end
};
function u3.Setup() --[[ Line: 23 ]]
    -- upvalues: u1 (copy), u3 (copy)
    u1.Component(u3);
end;
return u3;
