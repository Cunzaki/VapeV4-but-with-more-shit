-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.InifiteDrinks
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
require(l__ReplicatedStorage__1.Modules.Utility);
return {
    Disabled = true,
    IgnoreEquippedBlocked = false,
    ForceIgnoreNormalRecipes = false,
    WhenToDoCustomValidate = "After",
    RecipeMatches = { "SmallGlass" },
    CustomValidate = function(_, p1, p2) --[[ Name: CustomValidate, Line 20 ]]
        table.insert(p1, p2);
        if p2.Garnish then
            return false;
        end;
        local v3 = "";
        for v4, v5 in p1 do
            v3 = v3 .. v5.HoverName;
            if v4 ~= #p1 then
                v3 = v3 .. " And ";
            end;
        end;
        return {
            Name = v3
        };
    end
};
