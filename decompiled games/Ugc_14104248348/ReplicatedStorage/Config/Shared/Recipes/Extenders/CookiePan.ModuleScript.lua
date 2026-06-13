-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.CookiePan
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    IgnoreEquippedBlocked = false,
    ForceIgnoreNormalRecipes = false,
    WhenToDoCustomValidate = "After",
    RecipeMatches = { "CookiePan" },
    CustomValidate = function(_, p1, p2) --[[ Name: CustomValidate, Line 20 ]]
        table.insert(p1, p2);
        for _, v4 in p1 do
            if v4.Name == "Baked" then
                return {
                    DrinkID = "CookiePan",
                    Name = `{v4 and "Cooked" or "Uncooked"} Cookie Pan`
                };
            end;
        end;
        local v4 = nil;
        return {
            DrinkID = "CookiePan",
            Name = `{v4 and "Cooked" or "Uncooked"} Cookie Pan`
        };
    end,
    Apply = function(_, p5, _, _) --[[ Name: Apply, Line 34 ]]
        if p5:GetAttribute("Baked") then
            for _, v6 in p5.Filling:GetDescendants() do
                if v6:IsA("BasePart") and v6:FindFirstChild("CookedColor") then
                    v6.Color = v6.CookedColor.Value;
                end;
            end;
            if p5.Name:match("Uncooked") then
                p5.Name = string.gsub(p5.Name, "Uncooked", "Cooked");
            end;
        elseif not p5.Name:match("Uncooked") then
            p5.Name = "Uncooked " .. p5.Name;
        end;
    end
};
