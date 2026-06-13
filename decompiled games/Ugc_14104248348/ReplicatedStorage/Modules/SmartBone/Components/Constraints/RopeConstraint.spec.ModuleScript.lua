-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Constraints.RopeConstraint.spec
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RopeConstraint__1 = require(script.Parent:WaitForChild("RopeConstraint"));
return function() --[[ Line: 11 ]]
    -- upvalues: l__RopeConstraint__1 (copy)
    local u1 = {
        Bones = {
            {
                Position = Vector3.new(0, 0, 0),
                FreeLength = 3,
                ParentIndex = 0
            },
            {
                Position = Vector3.new(0, 10, 0),
                FreeLength = 3,
                ParentIndex = 1
            }
        }
    };
    describe("Rope Constraint", function() --[[ Line: 19 ]]
        -- upvalues: u1 (copy), l__RopeConstraint__1 (ref)
        local u2 = u1.Bones[2];
        local u3 = 0;
        local u4 = nil;
        local function u6() --[[ Line: 25 ]]
            -- upvalues: l__RopeConstraint__1 (ref), u2 (copy), u1 (ref), u4 (ref)
            local v5 = l__RopeConstraint__1(u2, u2.Position, u1);
            expect(v5.Magnitude).to.equal(u2.FreeLength);
            u2.FreeLength = math.random(1, 20);
            u4();
        end;
        local function u8() --[[ Line: 35 ]]
            -- upvalues: l__RopeConstraint__1 (ref), u2 (copy), u1 (ref), u4 (ref)
            local v7 = l__RopeConstraint__1(u2, u2.Position, u1);
            expect(v7.Magnitude).to.equal(u2.Position.Magnitude);
            u2.FreeLength = math.random(1, 20);
            u4();
        end;
        u4 = function() --[[ Line: 45 ]]
            -- upvalues: u3 (ref), u2 (copy), u8 (copy), u6 (copy)
            if u3 >= 10 then
            else
                u3 = u3 + 1;
                if u2.Position.Magnitude < u2.FreeLength then
                    it(`Should stay the same #{u3}`, u8);
                else
                    it(`Should limit to {u2.FreeLength} studs #{u3}`, u6);
                end;
            end;
        end;
        u4();
    end);
end;
