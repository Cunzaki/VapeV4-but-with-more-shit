-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_enigma@0.5.2.enigma.Serialization.StringDeserializer
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 24 ]]
    -- upvalues: u1 (copy)
    local v3 = {
        Index = 1,
        Data = string.split(p2, "|")
    };
    return setmetatable(v3, u1);
end;
function u1.ReadString(p4) --[[ Line: 34 ]]
    local l__Index__1 = p4.Index;
    if not p4.Data[l__Index__1] then
        error("Reached end of serialized string.");
    end;
    p4.Index = p4.Index + 1;
    return p4.Data[l__Index__1];
end;
function u1.ReadNumber(p5) --[[ Line: 44 ]]
    return tonumber(p5:ReadString());
end;
function u1.ReadVector3(p6) --[[ Line: 51 ]]
    local v7 = p6:ReadNumber();
    local v8 = p6:ReadNumber();
    return Vector3.new(v7, v8, p6:ReadNumber());
end;
function u1.ReadQuaternion(p9) --[[ Line: 58 ]]
    return {
        X = p9:ReadNumber(),
        Y = p9:ReadNumber(),
        Z = p9:ReadNumber(),
        W = p9:ReadNumber()
    };
end;
return u1;
