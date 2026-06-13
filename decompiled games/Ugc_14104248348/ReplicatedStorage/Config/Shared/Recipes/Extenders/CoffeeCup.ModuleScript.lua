-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.CoffeeCup
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    RecipeMatches = { "CoffeeCup" }
};
function u1.Apply(_, p2, p3, p4) --[[ Line: 7 ]]
    -- upvalues: u1 (copy)
    local v5 = false;
    for _, v6 in u1:GetModifiers(p2) do
        if v6.Name == "Coffee" or v6.Name == "Espresso" then
            v5 = true;
        end;
    end;
    p2.Drink.Steam.Enabled = v5;
    if p4 then
        p2.Drink.Transparency = 0;
    else
        p2.Drink.Transparency = 1;
    end;
    if p3 then
        p2.Drink.Color = p3;
    end;
end;
return u1;
