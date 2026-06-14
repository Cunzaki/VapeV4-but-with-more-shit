-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.GrilledFoods
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    RecipeMatches = {
        "Hotdog",
        "Burger",
        "TacoMeat",
        "Ribs"
    },
    ApplyRules = {
        Raw = {
            BasePart = {
                RawColor = "Color",
                RawTexture = "TextureID"
            }
        },
        Cooked = {
            BasePart = {
                CookedColor = "Color",
                CookedTexture = "TextureID"
            }
        }
    }
};
function u1.ApplyToTool(_, p2, p3) --[[ Line: 21 ]]
    -- upvalues: u1 (copy)
    local v4 = u1.ApplyRules[p2];
    local v5 = `'{p2}' is an invalid apply index!`;
    assert(v4, v5);
    for _, v6 in p3:GetChildren() do
        local v7 = nil;
        for v8, v9 in v4 do
            if v6:IsA(v8) then
                v7 = v9;
                break;
            end;
        end;
        if v7 then
            for v10, v11 in v7 do
                local v12 = v6:GetAttribute(v10);
                if v12 then
                    v6[v11] = v12;
                end;
            end;
        end;
    end;
    for v13, _ in u1.ApplyRules do
        local v14 = p3:FindFirstChild(v13);
        if v14 then
            v14.Transparency = 1;
        end;
    end;
    local v15 = p3:FindFirstChild(p2);
    if v15 then
        v15.Transparency = 0;
    end;
    if p2 == "Cooked" then
        p3:SetAttribute("PlaceAttachment", nil);
    end;
end;
function u1.Apply(p16, p17) --[[ Line: 56 ]]
    p16:ApplyToTool(p17:GetAttribute("Grilled") and "Cooked" or "Raw", p17);
end;
return u1;
