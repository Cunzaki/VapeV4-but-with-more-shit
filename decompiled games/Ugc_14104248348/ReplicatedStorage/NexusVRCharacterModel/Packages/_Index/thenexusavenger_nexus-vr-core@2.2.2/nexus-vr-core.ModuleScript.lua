-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-vr-core@2.2.2.nexus-vr-core
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    BaseScreenGui = require(script:WaitForChild("Container"):WaitForChild("BaseScreenGui")),
    ScreenGui = require(script:WaitForChild("Container"):WaitForChild("ScreenGui")),
    ScreenGui2D = require(script:WaitForChild("Container"):WaitForChild("ScreenGui2D")),
    ScreenGui3D = require(script:WaitForChild("Container"):WaitForChild("ScreenGui3D")),
    PartUtility = require(script:WaitForChild("Utility"):WaitForChild("PartUtility")),
    GetResource = function(_, p1) --[[ Name: GetResource, Line 30 ]]
        local v2 = script;
        for _, v3 in string.split(p1, ".") do
            v2 = v2[v3];
        end;
        return require(v2);
    end
};
