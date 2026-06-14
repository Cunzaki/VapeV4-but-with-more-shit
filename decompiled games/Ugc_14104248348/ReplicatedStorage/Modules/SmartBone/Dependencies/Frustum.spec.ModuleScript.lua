-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Frustum.spec
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Frustum__1 = require(script.Parent:WaitForChild("Frustum"));
return function() --[[ Line: 3 ]]
    -- upvalues: l__Frustum__1 (copy)
    local u1 = {
        FieldOfView = 70,
        CFrame = CFrame.identity,
        ViewportSize = Vector2.new(1920, 1080)
    };
    local u2 = {};
    describe("Generates CFrames", function() --[[ Line: 12 ]]
        -- upvalues: u2 (ref), l__Frustum__1 (ref), u1 (copy)
        local v3 = os.clock();
        u2 = table.pack(l__Frustum__1.GetCFrames(u1, 500));
        local v4 = os.clock();
        u2.n = nil;
        print((`Solved view frustum in {string.format("%.2f", (v4 - v3) * 1000000)}μs`));
    end);
    describe("Point In View", function() --[[ Line: 24 ]]
        -- upvalues: l__Frustum__1 (ref), u2 (ref)
        it("Close In View Point", function() --[[ Line: 29 ]]
            -- upvalues: l__Frustum__1 (ref), u2 (ref)
            expect(l__Frustum__1.InViewFrustum(Vector3.new(0, 0, -5), table.unpack(u2))).to.equal(true);
        end);
        it("Past FarPlane Point", function() --[[ Line: 33 ]]
            -- upvalues: l__Frustum__1 (ref), u2 (ref)
            expect(l__Frustum__1.InViewFrustum(Vector3.new(0, 0, -550), table.unpack(u2))).to.equal(false);
        end);
        it("Out Of View Point", function() --[[ Line: 37 ]]
            -- upvalues: l__Frustum__1 (ref), u2 (ref)
            expect(l__Frustum__1.InViewFrustum(Vector3.new(0, 0, 5), table.unpack(u2))).to.equal(false);
        end);
    end);
    describe("Object In View", function() --[[ Line: 42 ]]
        -- upvalues: l__Frustum__1 (ref), u2 (ref)
        local u5 = {
            Size = Vector3.new(1, 1, 3),
            CFrame = CFrame.new(0, 0, -5)
        };
        local u6 = {
            Size = Vector3.new(1, 1, 3),
            CFrame = CFrame.new(0, 0, -550)
        };
        local u7 = {
            Size = Vector3.new(1, 1, 3),
            CFrame = CFrame.new(0, 0, 5)
        };
        it("Close In View Object", function() --[[ Line: 58 ]]
            -- upvalues: l__Frustum__1 (ref), u5 (copy), u2 (ref)
            expect(l__Frustum__1.ObjectInFrustum(u5, table.unpack(u2))).to.equal(true);
        end);
        it("Past FarPlane Object", function() --[[ Line: 62 ]]
            -- upvalues: l__Frustum__1 (ref), u6 (copy), u2 (ref)
            expect(l__Frustum__1.ObjectInFrustum(u6, table.unpack(u2))).to.equal(false);
        end);
        it("Out Of View Object", function() --[[ Line: 66 ]]
            -- upvalues: l__Frustum__1 (ref), u7 (copy), u2 (ref)
            expect(l__Frustum__1.ObjectInFrustum(u7, table.unpack(u2))).to.equal(false);
        end);
    end);
end;
