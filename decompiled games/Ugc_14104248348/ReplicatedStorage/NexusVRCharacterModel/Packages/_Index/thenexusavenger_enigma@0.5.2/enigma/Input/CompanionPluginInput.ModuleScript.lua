-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_enigma@0.5.2.enigma.Input.CompanionPluginInput
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 18 ]]
    -- upvalues: u1 (copy)
    return setmetatable({}, u1);
end;
function u1.GetCurrentText(_) --[[ Line: 26 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy)
    local v2 = l__ReplicatedStorage__1:FindFirstChild("__EnigmaPluginData");
    return not v2 and "" or v2.Value;
end;
return u1;
