-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.KoreanBBQ
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    RecipeMatches = { "BeefBulgogi", "Porkbelly" },
    ApplyRules = {
        Raw = Color3.new(1, 1, 1),
        Boiled = Color3.fromRGB(125, 145, 109),
        Cooked = Color3.fromRGB(163, 133, 133),
        WellDone = Color3.fromRGB(111, 56, 57)
    }
};
function u1.ApplyToTool(_, p2, p3) --[[ Line: 13 ]]
    -- upvalues: u1 (copy)
    local v4 = u1.ApplyRules[p2];
    local v5 = `'{p2}' is an invalid apply index!`;
    assert(v4, v5);
    p3.Handle.SurfaceAppearance.Color = v4;
end;
function u1.Apply(p6, p7) --[[ Line: 20 ]]
    p6:ApplyToTool(p7:GetAttribute("WellDone") and "WellDone" or (p7:GetAttribute("Cooked") and "Cooked" or (p7:GetAttribute("Boiled") and "Boiled" or "Raw")), p7);
end;
return u1;
