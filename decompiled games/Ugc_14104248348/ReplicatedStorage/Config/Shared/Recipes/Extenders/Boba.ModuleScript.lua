-- Decompiled from: ReplicatedStorage.Config.Shared.Recipes.Extenders.Boba
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
    RecipeMatches = { "Boba" }
};
function u1.Apply(_, p2, p3, p4) --[[ Line: 20 ]]
    -- upvalues: u1 (copy)
    local v5 = false;
    for _, v6 in u1:GetModifiers(p2) do
        if v6.HoverName == "Tea" then
            v5 = true;
        end;
    end;
    if p4 then
        if p2:GetAttribute("FilledBase") then
            if p2:GetAttribute("FilledSolid") then
                p2.Tea:SetAttribute("SecondaryColor", p3);
                p2.Tea.ParticleEmitter.Color = ColorSequence.new(p2.Tea.ParticleEmitter.Color.Keypoints[1].Value, p3);
            else
                p2.Tea.ParticleEmitter.Color = ColorSequence.new(p3);
                p2.Tea.ParticleEmitter.Enabled = true;
                p2:SetAttribute("FilledSolid", p3);
                p2.Tea:SetAttribute("PrimaryColor", p3);
            end;
        else
            p2.Tea.Transparency = v5 and 0.1 or 0.0025;
            p2.Tea:SetAttribute("BaseColor", p3);
            return p2:SetAttribute("FilledBase", p3);
        end;
    else
        p2.Tea:SetAttribute("BaseColor", nil);
        p2.Tea:SetAttribute("PrimaryColor", nil);
        p2.Tea:SetAttribute("SecondaryColor", nil);
        p2.Tea.Transparency = 1;
        p2.Handle.Color = Color3.new(1, 1, 1);
        p2.Tea.ParticleEmitter.Enabled = false;
    end;
end;
function u1.CustomValidate(_, p7, p8) --[[ Line: 55 ]]
    table.insert(p7, p8);
    local v9 = false;
    for _, v10 in p7 do
        if v10.HoverName == "Milk" or v10.HoverName == "Tea" then
            v9 = v10.HoverName;
        end;
    end;
    if not v9 then
        return false;
    end;
    if not p8.BobaSyrup then
        return false;
    end;
    if #p7 >= 4 then
        return false;
    end;
    local v11 = "";
    for v12, v13 in p7 do
        if v13.HoverName ~= v9 then
            v11 = v11 .. v13.HoverName:split(" ")[1];
            if v12 ~= #p7 then
                v11 = v11 .. " and ";
            end;
        end;
    end;
    return {
        Name = v11 .. ` {v9 == "Milk" and (`{v9} ` or "") or ""}Tea`
    };
end;
return u1;
