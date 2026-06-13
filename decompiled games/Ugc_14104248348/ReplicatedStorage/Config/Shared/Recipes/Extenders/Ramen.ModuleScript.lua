-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.Ramen
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
require(l__ReplicatedStorage__1.Modules.Utility);
return {
    Disabled = false,
    RecipeMatches = { "Ramen" },
    Apply = function(_, p1, _, _) --[[ Name: Apply, Line 8 ]]
        p1.Noodles.Transparency = 0;
    end
};
