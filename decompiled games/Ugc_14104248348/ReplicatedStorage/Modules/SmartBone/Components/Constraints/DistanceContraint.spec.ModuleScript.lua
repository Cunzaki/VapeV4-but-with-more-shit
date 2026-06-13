-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Constraints.DistanceContraint.spec
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__DistanceConstraint__1 = require(script.Parent:WaitForChild("DistanceConstraint"));
return function() --[[ Line: 11 ]]
    -- upvalues: l__DistanceConstraint__1 (copy)
    local u1 = {
        Bones = {
            {
                Position = Vector3.new(0, 0, 0),
                FreeLength = 3,
                ParentIndex = 0
            },
            {
                Position = Vector3.new(0, 1, 0),
                FreeLength = 3,
                ParentIndex = 1
            }
        }
    };
    describe("Distance Constraint", function() --[[ Line: 19 ]]
        -- upvalues: u1 (copy), l__DistanceConstraint__1 (ref)
        local u2 = u1.Bones[2];
        local function v4() --[[ Line: 22 ]]
            -- upvalues: l__DistanceConstraint__1 (ref), u2 (copy), u1 (ref)
            local v3 = l__DistanceConstraint__1(u2, u2.Position, u1);
            expect(v3.Magnitude).to.equal(u2.FreeLength);
            u2.Position = v3;
        end;
        for v5 = 1, 10 do
            it(`Should limit to {u2.FreeLength} studs #{v5}`, v4);
            u2.FreeLength = math.random(1, 20);
        end;
    end);
end;
