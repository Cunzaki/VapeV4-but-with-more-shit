-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-appendage@1.2.0.nexus-appendage.Limb
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 14 ]]
    -- upvalues: u1 (copy)
    return setmetatable({}, u1);
end;
function u1.GetAttachmentCFrame(_, p2, p3) --[[ Line: 23 ]]
    local v4 = p2:FindFirstChild(p3);
    return v4 and v4.CFrame or CFrame.identity;
end;
return u1;
