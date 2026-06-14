-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_enigma@0.5.2.enigma.Util.CalculateRolloff
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) --[[ Line: 4 ]]
    if p3 <= p1 then
        return p3;
    else
        return p1 + math.min(p3 - p1, p2) / 2;
    end;
end;
