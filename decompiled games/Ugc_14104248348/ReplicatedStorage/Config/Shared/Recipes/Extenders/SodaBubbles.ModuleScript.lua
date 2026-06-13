-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.SodaBubbles
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
return {
    RecipeMatches = { "SmallGlass" },
    SodaModifiers = require(l__ReplicatedStorage__1.Modules.Utility).CreateFuzzyFinder({
        "Zest",
        "Cola",
        "TonicWater",
        "WitchesBrew"
    }),
    Apply = function(p1, p2, _, p3) --[[ Name: Apply, Line 10 ]]
        -- upvalues: l__ReplicatedStorage__1 (copy)
        local v4 = p2:FindFirstChild("Drink");
        if v4 then
            if p3 then
                local v5 = p1:GetModifiers(p2);
                local v6 = 0;
                for _, v7 in v5 do
                    if p1.SodaModifiers[v7.Name] then
                        v6 = v6 + 1;
                    end;
                end;
                local v8 = v6 / #v5;
                if (v8 ~= v8 and 0 or v8) < 0.3 then
                    local v9 = v4:FindFirstChild("TopBubbles");
                    if v9 then
                        v9:Destroy();
                    end;
                elseif v4:FindFirstChild("TopBubbles") then
                else
                    local v10 = l__ReplicatedStorage__1.Assets.Particles.Groups.TopBubbles:Clone();
                    v10.CFrame = CFrame.new(v4.Size * Vector3.new(0, 1, 0) * 0.5);
                    v10.Parent = v4;
                end;
            else
                local v11 = v4:FindFirstChild("TopBubbles");
                if v11 then
                    v11:Destroy();
                end;
            end;
        end;
    end
};
