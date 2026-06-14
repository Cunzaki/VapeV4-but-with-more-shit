-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_enigma@0.5.2.enigma.Input.CombinedInput
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 21 ]]
    -- upvalues: u1 (copy)
    local v3 = {};
    for _, v4 in p2 do
        v3[v4] = v4:GetCurrentText();
    end;
    return setmetatable({
        Inputs = p2,
        LastText = v3[p2[1]],
        LastTextValues = v3
    }, u1);
end;
function u1.GetCurrentText(p5) --[[ Line: 40 ]]
    local v6 = {};
    for _, v7 in p5.Inputs do
        v6[v7] = v7:GetCurrentText();
    end;
    for _, v8 in p5.Inputs do
        if v6[v8] ~= p5.LastTextValues[v8] then
            p5.LastText = v6[v8];
            break;
        end;
    end;
    return p5.LastText;
end;
return u1;
