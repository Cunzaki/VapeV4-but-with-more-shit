-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.Vial
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = {
    IgnoreEquippedBlocked = false,
    ForceIgnoreNormalRecipes = false,
    WhenToDoCustomValidate = "After",
    RecipeMatches = { "Vial" }
};
local u2 = {
    "HardTacoShell",
    "ShreddedLettuce",
    "Tortilla",
    "HotdogBun",
    "BurgerBun",
    "FoodTray",
    "FryCup"
};
function v1.Apply(_, p3) --[[ Line: 27 ]]
    p3:SetAttribute("CanDrink", false);
end;
function v1.CustomValidate(_, p4, p5) --[[ Line: 31 ]]
    -- upvalues: u2 (copy)
    table.insert(p4, p5);
    if table.find(u2, p5.Name) then
        return false;
    end;
    if #p4 >= 2 then
        return false;
    end;
    local v6 = "";
    for _, v7 in p4 do
        v6 = `{v7.HoverName} Sample`;
    end;
    return {
        Name = v6
    };
end;
return v1;
