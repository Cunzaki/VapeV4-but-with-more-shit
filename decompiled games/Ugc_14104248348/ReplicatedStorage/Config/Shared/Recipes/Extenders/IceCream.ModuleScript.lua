-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.IceCream
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
    RecipeMatches = { "IceCreamCone" },
    Apply = function(p1, p2, _, p3) --[[ Name: Apply, Line 21 ]]
        if p3 then
            local v4 = {};
            for v5 = 1, 3 do
                local v6 = `Cream{v5}`;
                local v7 = p2:GetAttribute(v6);
                if v7 then
                    v4[v7] = v6;
                end;
            end;
            local v8 = {};
            local v9 = {};
            for _, v10 in p1:GetModifiers(p2) do
                if v10.IceCreamModifier then
                    table.insert(v8, v10);
                elseif v10.IceCreamGarnish then
                    table.insert(v9, v10);
                end;
            end;
            for _, v11 in v9 do
                local v12 = p2:FindFirstChild(v11.Part);
                if v12 then
                    v12.Transparency = 0;
                    if v11.Color then
                        v12.Color = v11.Color;
                    end;
                end;
            end;
            for v13, v14 in v8 do
                if v13 <= 3 then
                    local v15 = v4[v14.Name] or `Cream{v13}`;
                    if v14.MaterialVariant then
                        p2[v15].MaterialVariant = v14.MaterialVariant;
                    end;
                    p2[v15].Material = v14.Material or Enum.Material.SmoothPlastic;
                    p2[v15].Color = v14.Color;
                    p2[v15].Transparency = 0;
                end;
            end;
        else
            p2.Cream1.Transparency = 1;
            p2.Cream2.Transparency = 1;
            p2.Cream3.Transparency = 1;
            p2.Sauce.Transparency = 1;
            p2.Sprinkles.Transparency = 1;
            p2.Berries.Transparency = 1;
            p2.Almonds.Transparency = 1;
            p2.GummySharks.Transparency = 1;
        end;
    end,
    CustomValidate = function(_, p16, p17) --[[ Name: CustomValidate, Line 74 ]]
        table.insert(p16, p17);
        if #p16 > 3 then
            return p17.IceCreamGarnish and {
                Name = "Mixed Cone"
            } or false;
        end;
        if p17.IceCreamModifier then
            local v18 = `Cream{#p16}`;
            return {
                Name = #p16 ~= 0 and "Mixed Cone" or p17.HoverName,
                Attributes = {
                    [v18] = p17.Name
                }
            };
        end;
    end
};
