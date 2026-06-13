-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.TacoMeat
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    RecipeMatches = { "TacoMeat" },
    HideMeatModifiers = { "HardTacoShell" },
    Apply = function(p1, p2, _, _) --[[ Name: Apply, Line 8 ]]
        local v3 = false;
        for _, v4 in p1.HideMeatModifiers do
            if p2:GetAttribute(v4) then
                v3 = true;
                break;
            end;
        end;
        if v3 then
            p2.Meat.Transparency = 1;
        end;
    end
};
