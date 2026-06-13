-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.Bento
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
require(l__ReplicatedStorage__1.Modules.Utility);
local u1 = {
    Disabled = false,
    IgnoreEquippedBlocked = false,
    ForceIgnoreNormalRecipes = false,
    WhenToDoCustomValidate = "After",
    RecipeMatches = { "Bento" }
};
function u1.Apply(_, p2, _, p3) --[[ Line: 11 ]]
    -- upvalues: u1 (copy)
    local v4 = u1:GetModifiers(p2);
    if p3 then
        for _, v5 in v4 do
            local v6 = p2:FindFirstChild(v5.HoverName:gsub(" ", ""));
            if v6 then
                for _, v7 in v6:GetChildren() do
                    v7.Transparency = 0;
                end;
            else
                warn("Could not find " .. v5.HoverName);
            end;
        end;
    else
        for _, v8 in v4 do
            local v9 = p2:FindFirstChild(v8.HoverName:gsub(" ", ""));
            if v9 then
                for _, v10 in v9:GetChildren() do
                    v10.Transparency = 1;
                end;
            else
                warn("Could not find " .. v8.HoverName);
            end;
        end;
    end;
end;
function u1.CustomValidate(_, p11, p12) --[[ Line: 43 ]]
    local v13 = {};
    for _, v14 in p11 do
        v13[v14.BentoSection] = true;
    end;
    table.insert(p11, p12);
    if p12.BentoSection then
        if #p11 >= 5 then
            return false;
        else
            return not v13[p12.BentoSection] and {
                Name = "Bento"
            } or false;
        end;
    else
        return false;
    end;
end;
return u1;
