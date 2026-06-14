-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.FriedFoods
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    RecipeMatches = {
        "Fries",
        "OnionRings",
        "MozSticks",
        "Wings",
        "BatteredFish",
        "Calamari",
        "Taquito"
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
    if p2 == "Cooked" then
        p3:SetAttribute("PlaceAttachment", nil);
    end;
end;
function u1.Apply(p13, p14) --[[ Line: 47 ]]
    if p14:GetAttribute("TextureMatch") then
        local v15 = p14:GetAttribute("TextureMatch");
        for _, v16 in p14:GetChildren() do
            if v16:IsA("BasePart") and v16:GetAttribute("TextureMatch") then
                v16.TextureID = v15;
            end;
        end;
    else
        p13:ApplyToTool(p14:GetAttribute("Fried") and "Cooked" or "Raw", p14);
    end;
end;
return u1;
