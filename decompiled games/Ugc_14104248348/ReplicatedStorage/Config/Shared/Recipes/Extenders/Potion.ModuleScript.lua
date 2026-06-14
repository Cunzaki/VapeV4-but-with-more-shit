-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.Potion
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    RecipeMatches = { "Potion" },
    Apply = function(_, p1, _, p2) --[[ Name: Apply, Line 7 ]]
        if p2 then
            for _, v3 in p1:GetDescendants() do
                if v3:IsA("ParticleEmitter") then
                    v3.Enabled = true;
                end;
            end;
        else
            for _, v4 in p1:GetDescendants() do
                if v4:IsA("ParticleEmitter") then
                    v4.Enabled = false;
                end;
            end;
        end;
    end
};
