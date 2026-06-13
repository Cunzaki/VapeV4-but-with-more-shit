-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.UniversalParticleRecolor
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
return {
    RecipeMatches = { "FancyGlass" },
    SodaModifiers = require(l__ReplicatedStorage__1.Modules.Utility).CreateFuzzyFinder({
        "Zest",
        "Cola",
        "TonicWater",
        "WitchesBrew"
    }),
    Apply = function(_, p1, p2, _) --[[ Name: Apply, Line 10 ]]
        if p1:GetAttribute("RecolorParticles") then
            if p2 then
                for _, v3 in p1:GetDescendants() do
                    if v3:IsA("ParticleEmitter") then
                        v3.Color = ColorSequence.new(p2);
                    end;
                end;
            end;
        end;
    end
};
