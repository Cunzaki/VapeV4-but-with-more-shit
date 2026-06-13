-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.CafeNameFillIn
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
require(l__ReplicatedStorage__1.Modules.Utility);
return {
    Disabled = false,
    IgnoreEquippedBlocked = false,
    ForceIgnoreNormalRecipes = false,
    WhenToDoCustomValidate = "After",
    RecipeMatches = { "CoffeeCup", "IceCoffeeCup", "GlassCoffeeMug" },
    GenericRecipe = {
        {
            "Coffee",
            "Syrup",
            Format = function(p1) --[[ Name: Format, Line 12 ]]
                return `{p1[2].SubName} {p1[1].HoverName}`;
            end
        },
        {
            "Coffee",
            "Syrup",
            "Syrup",
            Format = function(p2) --[[ Name: Format, Line 15 ]]
                return `{p2[2].SubName} {p2[3].SubName} {p2[1].HoverName}`;
            end
        }
    },
    GenericModifierMatches = {
        Coffee = { "Coffee", "Espresso" },
        Syrup = function(p3) --[[ Line: 21 ]]
            local v4 = {
                Coffee = true,
                Espresso = true
            };
            local l__CanBeUsedForCafeMix__2 = p3.CanBeUsedForCafeMix;
            if l__CanBeUsedForCafeMix__2 then
                l__CanBeUsedForCafeMix__2 = not v4[p3.Name];
            end;
            return l__CanBeUsedForCafeMix__2;
        end
    },
    CustomValidate = function(_, p5, p6) --[[ Name: CustomValidate, Line 41 ]]
        table.insert(p5, p6);
        if not p6.CanBeUsedForCafeMix then
            return false;
        end;
        if #p5 >= 3 then
            return false;
        end;
        local v7 = "";
        for v8, v9 in p5 do
            v7 = v7 .. v9.HoverName;
            if v8 ~= #p5 then
                v7 = v7 .. " And ";
            end;
        end;
        return {
            Name = v7
        };
    end
};
