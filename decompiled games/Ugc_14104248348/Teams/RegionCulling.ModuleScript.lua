-- Decompiled from: Teams.RegionCulling
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ModelCulling__1 = require(script:WaitForChild("Culling"):WaitForChild("ModelCulling"));
local l__RegionState__2 = require(script:WaitForChild("State"):WaitForChild("RegionState"));
local v1 = {
    RegionState = require(script:WaitForChild("State"):WaitForChild("BufferedRegionState")).new(l__RegionState__2.new())
};
v1.ModelCulling = l__ModelCulling__1.new(v1.RegionState);
function v1.Start(p2) --[[ Line: 19 ]]
    p2.RegionState:StartUpdating();
    p2.ModelCulling:StartProcessingQueue();
    p2.ModelCulling:StartModelFlattening();
end;
return v1;
