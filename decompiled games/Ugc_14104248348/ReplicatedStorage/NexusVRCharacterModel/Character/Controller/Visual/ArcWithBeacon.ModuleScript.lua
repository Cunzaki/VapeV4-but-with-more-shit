-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Character.Controller.Visual.ArcWithBeacon
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Arc__1 = require(script.Parent:WaitForChild("Arc"));
local l__Beacon__2 = require(script.Parent:WaitForChild("Beacon"));
local u1 = {};
u1.__index = u1;
setmetatable(u1, l__Arc__1);
function u1.new() --[[ Line: 20 ]]
    -- upvalues: l__Arc__1 (copy), u1 (copy), l__Beacon__2 (copy)
    local v2 = l__Arc__1.new();
    local v3 = setmetatable(v2, u1);
    v3.Beacon = l__Beacon__2.new();
    v3:Hide();
    return v3;
end;
function u1.Update(p4, p5) --[[ Line: 31 ]]
    -- upvalues: l__Arc__1 (copy)
    local v6, v7 = l__Arc__1.Update(p4, p5);
    local l__Beacon__3 = p4.Beacon;
    if v6 then
        l__Beacon__3:Update(CFrame.new(v7) * CFrame.new(0, 0.001, 0), v6);
        return v6, v7;
    else
        l__Beacon__3:Hide();
        return v6, v7;
    end;
end;
function u1.Hide(p8) --[[ Line: 50 ]]
    -- upvalues: l__Arc__1 (copy)
    l__Arc__1.Hide(p8);
    p8.Beacon:Hide();
end;
function u1.Destroy(p9) --[[ Line: 58 ]]
    -- upvalues: l__Arc__1 (copy)
    l__Arc__1.Destroy(p9);
    p9.Beacon:Destroy();
end;
return u1;
