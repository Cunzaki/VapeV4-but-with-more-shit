-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.ChampionAura
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
return {
    RecipeMatches = { "SmallGlass" },
    MatchModifiers = require(l__ReplicatedStorage__1.Modules.Utility).CreateFuzzyFinder({ "ChampionDrink" }),
    Apply = function(p1, p2, _, p3) --[[ Name: Apply, Line 10 ]]
        -- upvalues: l__ReplicatedStorage__1 (copy)
        local v4 = p2:FindFirstChild("Drink");
        if not v4 then
            return;
        end;
        if not p3 then
            local v5 = v4:FindFirstChild("ChampionAura");
            if v5 then
                v5:Destroy();
                return;
            else
                return;
            end;
        end;
        local v6 = false;
        for _, v7 in p1:GetModifiers(p2) do
            if p1.MatchModifiers[v7.Name] then
                v6 = true;
                break;
            end;
        end;
        if v6 then
            if v4:FindFirstChild("ChampionAura") then
            else
                local v8 = l__ReplicatedStorage__1.Assets.Particles.Groups.ChampionAura:Clone();
                v8.CFrame = CFrame.new(v4.Size * Vector3.new(0, 1, 0) * 0.5);
                v8.Parent = v4;
            end;
        else
            local v9 = v4:FindFirstChild("ChampionAura");
            if v9 then
                v9:Destroy();
            end;
        end;
    end
};
