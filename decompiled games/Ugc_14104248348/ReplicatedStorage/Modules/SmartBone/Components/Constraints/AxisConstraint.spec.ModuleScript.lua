-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Constraints.AxisConstraint.spec
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__AxisConstraint__1 = require(script.Parent:WaitForChild("AxisConstraint"));
return function() --[[ Line: 3 ]]
    -- upvalues: l__AxisConstraint__1 (copy)
    local u1 = {
        Radius = 0,
        XAxisLimits = NumberRange.new((-1 / 0), (1 / 0)),
        YAxisLimits = NumberRange.new((-1 / 0), (1 / 0)),
        ZAxisLimits = NumberRange.new((-1 / 0), (1 / 0)),
        AxisLocked = { false, false, false },
        ClipVelocity = function() --[[ Name: ClipVelocity, Line 10 ]] end
    };
    afterEach(function() --[[ Line: 13 ]]
        -- upvalues: u1 (copy)
        u1.AxisLocked = { false, false, false };
    end);
    describe("Axis Lock", function() --[[ Line: 17 ]]
        -- upvalues: u1 (copy), l__AxisConstraint__1 (ref)
        it("Should lock X Axis", function() --[[ Line: 18 ]]
            -- upvalues: u1 (ref), l__AxisConstraint__1 (ref)
            u1.AxisLocked = { true, false, false };
            local v2 = l__AxisConstraint__1(u1, Vector3.new(-10, 0, 0), Vector3.new(0, 0, 0), CFrame.identity);
            expect(v2.X).to.equal(0);
        end);
        it("Should lock Y Axis", function() --[[ Line: 26 ]]
            -- upvalues: u1 (ref), l__AxisConstraint__1 (ref)
            u1.AxisLocked = { false, true, false };
            local v3 = l__AxisConstraint__1(u1, Vector3.new(0, -10, 0), Vector3.new(0, 0, 0), CFrame.identity);
            expect(v3.Y).to.equal(0);
        end);
        it("Should lock Z Axis", function() --[[ Line: 34 ]]
            -- upvalues: u1 (ref), l__AxisConstraint__1 (ref)
            u1.AxisLocked = { false, false, true };
            local v4 = l__AxisConstraint__1(u1, Vector3.new(0, 0, -10), Vector3.new(0, 0, 0), CFrame.identity);
            expect(v4.Z).to.equal(0);
        end);
    end);
    describe("Axis Limit", function() --[[ Line: 43 ]]
        -- upvalues: u1 (copy), l__AxisConstraint__1 (ref)
        describe("Should limit X Axis", function() --[[ Line: 44 ]]
            -- upvalues: u1 (ref), l__AxisConstraint__1 (ref)
            it("Min Limit", function() --[[ Line: 45 ]]
                -- upvalues: u1 (ref), l__AxisConstraint__1 (ref)
                u1.XAxisLimits = NumberRange.new(-5, (1 / 0));
                local v5 = l__AxisConstraint__1(u1, Vector3.new(-10, 0, 0), Vector3.new(0, 0, 0), CFrame.identity);
                expect(v5.X).to.equal(-5);
            end);
            it("Max Limit", function() --[[ Line: 53 ]]
                -- upvalues: u1 (ref), l__AxisConstraint__1 (ref)
                u1.XAxisLimits = NumberRange.new((-1 / 0), 5);
                local v6 = l__AxisConstraint__1(u1, Vector3.new(10, 0, 0), Vector3.new(0, 0, 0), CFrame.identity);
                expect(v6.X).to.equal(5);
            end);
        end);
        describe("Should limit Y Axis", function() --[[ Line: 62 ]]
            -- upvalues: u1 (ref), l__AxisConstraint__1 (ref)
            it("Min Limit", function() --[[ Line: 63 ]]
                -- upvalues: u1 (ref), l__AxisConstraint__1 (ref)
                u1.YAxisLimits = NumberRange.new(-5, (1 / 0));
                local v7 = l__AxisConstraint__1(u1, Vector3.new(0, -10, 0), Vector3.new(0, 0, 0), CFrame.identity);
                expect(v7.Y).to.equal(-5);
            end);
            it("Max Limit", function() --[[ Line: 71 ]]
                -- upvalues: u1 (ref), l__AxisConstraint__1 (ref)
                u1.YAxisLimits = NumberRange.new((-1 / 0), 5);
                local v8 = l__AxisConstraint__1(u1, Vector3.new(0, 10, 0), Vector3.new(0, 0, 0), CFrame.identity);
                expect(v8.Y).to.equal(5);
            end);
        end);
        describe("Should limit Z Axis", function() --[[ Line: 80 ]]
            -- upvalues: u1 (ref), l__AxisConstraint__1 (ref)
            it("Min Limit", function() --[[ Line: 81 ]]
                -- upvalues: u1 (ref), l__AxisConstraint__1 (ref)
                u1.ZAxisLimits = NumberRange.new(-5, (1 / 0));
                local v9 = l__AxisConstraint__1(u1, Vector3.new(0, 0, -10), Vector3.new(0, 0, 0), CFrame.identity);
                expect(v9.Z).to.equal(-5);
            end);
            it("Max Limit", function() --[[ Line: 89 ]]
                -- upvalues: u1 (ref), l__AxisConstraint__1 (ref)
                u1.ZAxisLimits = NumberRange.new((-1 / 0), 5);
                local v10 = l__AxisConstraint__1(u1, Vector3.new(0, 0, 10), Vector3.new(0, 0, 0), CFrame.identity);
                expect(v10.Z).to.equal(5);
            end);
        end);
    end);
end;
