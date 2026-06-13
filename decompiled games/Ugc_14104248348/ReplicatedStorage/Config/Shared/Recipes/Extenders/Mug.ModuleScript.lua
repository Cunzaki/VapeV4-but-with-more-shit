-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.Mug
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    RecipeMatches = { "Mug" },
    Apply = function(_, p1, p2, p3) --[[ Name: Apply, Line 7 ]]
        if p3 then
            p1.Bottom.Emitter.Enabled = true;
            p1.DrinkFull.Transparency = 0;
            p1.Foam.Transparency = 0;
        else
            p1.Bottom.Emitter.Enabled = false;
            p1.DrinkFull.Transparency = 1;
            p1.Foam.Transparency = 1;
        end;
        if p2 then
            p1.DrinkFull.Color = p2;
        end;
    end
};
