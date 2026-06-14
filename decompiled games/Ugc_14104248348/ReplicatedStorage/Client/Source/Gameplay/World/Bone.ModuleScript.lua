-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.Bone
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__SmartBone__2 = require(l__ReplicatedStorage__1.Modules.SmartBone);
return {
    Setup = function() --[[ Name: Setup, Line 8 ]]
        -- upvalues: l__SmartBone__2 (copy)
        l__SmartBone__2.Start();
    end
};
