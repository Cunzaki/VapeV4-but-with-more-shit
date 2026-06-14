-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.PIzza
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    IgnoreEquippedBlocked = false,
    ForceIgnoreNormalRecipes = false,
    WhenToDoCustomValidate = "After",
    RecipeMatches = { "Pizza" },
    CustomValidate = function(_, p1, p2) --[[ Name: CustomValidate, Line 20 ]]
        table.insert(p1, p2);
        local v3, v4, v5, v6;
        for _, v10 in p1 do
            if v10.Name == "Baked" then
                v3 = {
                    "Empty",
                    "Sauce",
                    "Cheese",
                    "Pepperoni"
                };
                v4 = 1;
                v5 = v10 and "Cooked" or "Uncooked";
                for v11, v12 in p1 do
                    v6 = table.find(v3, v12.Name);
                    if v6 and v4 < v6 then
                        v4 = v6;
                    end;
                end;
                return {
                    DrinkID = "Pizza",
                    Name = `{v5} {v3[v4]} Pizza`
                };
            end;
        end;
        local v10 = nil;
        v3 = {
            "Empty",
            "Sauce",
            "Cheese",
            "Pepperoni"
        };
        v4 = 1;
        v5 = v10 and "Cooked" or "Uncooked";
        for v11, v12 in p1 do
            v6 = table.find(v3, v12.Name);
            if v6 and v4 < v6 then
                v4 = v6;
            end;
        end;
        return {
            DrinkID = "Pizza",
            Name = `{v5} {v3[v4]} Pizza`
        };
    end,
    Apply = function(_, p13, _, _) --[[ Name: Apply, Line 52 ]]
        if p13:GetAttribute("Baked") then
            for _, v14 in p13.Slices:GetDescendants() do
                if v14:IsA("BasePart") then
                    if v14:FindFirstChild("CookedColor") then
                        v14.Color = v14.CookedColor.Value;
                    else
                        local v15 = v14:FindFirstChildOfClass("SurfaceAppearance");
                        if v15 then
                            p13.Textures.Cooked:Clone().Parent = v14;
                            v15:Destroy();
                        end;
                    end;
                end;
            end;
            if p13.Name:match("Uncooked") then
                p13.Name = string.gsub(p13.Name, "Uncooked", "Cooked");
            end;
        elseif not p13.Name:match("Uncooked") then
            p13.Name = "Uncooked " .. p13.Name;
        end;
    end
};
