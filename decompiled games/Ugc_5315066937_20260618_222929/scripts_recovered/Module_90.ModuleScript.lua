-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__IsA__1 = game.IsA;
local l__FindFirstChild__2 = game.FindFirstChild;
local l__Clone__3 = game.Clone;
local u1 = _G.obtain("rsearch");
local u2 = CFrame.new(0, 1.25, 0);
local u3 = CFrame.new(0, -0.25, 0);
local function u5(p4) --[[ Line: 12 ]]
    -- upvalues: l__IsA__1 (copy)
    return l__IsA__1(p4, "BasePart") or p4.ClassName == "Decal";
end;
local u6 = {
    Fire = true,
    Smoke = true,
    Sparkles = true,
    ParticleEmitter = true
};
local function u8(p7) --[[ Line: 21 ]]
    -- upvalues: u6 (copy)
    return u6[p7.ClassName];
end;
local u9 = l__FindFirstChild__2(game:GetService("ReplicatedStorage"), "Characters");
return {
    CreateCharacterInfo = function(p10) --[[ Name: CreateCharacterInfo, Line 27 ]]
        -- upvalues: l__FindFirstChild__2 (copy), u2 (copy), u3 (copy)
        local v11 = {
            Character = p10,
            LocalEquipData = {}
        };
        local v12 = l__FindFirstChild__2(p10, "HumanoidRootPart");
        local v13 = l__FindFirstChild__2(p10, "Head");
        local v14 = l__FindFirstChild__2(p10, "Torso");
        local v15 = l__FindFirstChild__2(p10, "Right Arm");
        local v16 = l__FindFirstChild__2(p10, "Left Arm");
        local v17 = l__FindFirstChild__2(p10, "Right Leg");
        local v18 = l__FindFirstChild__2(p10, "Left Leg");
        v11.HRP = v12;
        v11.Head = v13;
        v11.Torso = v14;
        v11.RightArm = v15;
        v11.LeftArm = v16;
        v11.RightLeg = v17;
        v11.LeftLeg = v18;
        if v13 then
            v11.HeadMesh = l__FindFirstChild__2(v13, "Mesh");
        end;
        if v14 then
            local v19 = l__FindFirstChild__2(v14, "Neck");
            if v19 then
                v19.C0 = u2;
                v19.C1 = u3;
                v11.Neck = v19;
            end;
            v11.RightShoulder = l__FindFirstChild__2(v14, "Right Shoulder");
            v11.LeftShoulder = l__FindFirstChild__2(v14, "Left Shoulder");
            v11.RightHip = l__FindFirstChild__2(v14, "Right Hip");
            v11.LeftHip = l__FindFirstChild__2(v14, "Left Hip");
        end;
        return v11;
    end,
    CreateCharacterClone = function(p20) --[[ Name: CreateCharacterClone, Line 63 ]]
        -- upvalues: l__FindFirstChild__2 (copy), u9 (copy), l__Clone__3 (copy)
        local v21 = l__FindFirstChild__2(u9, (tostring(p20.userId)));
        if v21 then
            local v22 = l__Clone__3(v21);
            v22.Name = p20.Name;
            return v22;
        end;
    end,
    WriteInfoState = function(p23) --[[ Name: WriteInfoState, Line 71 ]]
        -- upvalues: u1 (copy), u5 (copy), u8 (copy)
        local l__Character__4 = p23.Character;
        local v24 = u1(l__Character__4, u5);
        local v25 = {};
        for v26 = 1, #v24 do
            local v27 = v24[v26];
            v25[v27] = v27.Transparency;
        end;
        p23.TransparencyInfo = v25;
        local v28 = u1(l__Character__4, u8);
        local v29 = {};
        for v30 = 1, #v28 do
            local v31 = v28[v30];
            v29[v31] = v31.Enabled;
        end;
        p23.EnabledInfo = v29;
    end,
    AppendInfoState = function(p32) --[[ Name: AppendInfoState, Line 89 ]]
        -- upvalues: u1 (copy), u5 (copy), u8 (copy)
        local l__Character__5 = p32.Character;
        local v33 = u1(l__Character__5, u5);
        local l__TransparencyInfo__6 = p32.TransparencyInfo;
        for v34 = 1, #v33 do
            local v35 = v33[v34];
            if not l__TransparencyInfo__6[v35] then
                l__TransparencyInfo__6[v35] = v35.Transparency;
            end;
        end;
        local v36 = u1(l__Character__5, u8);
        local l__EnabledInfo__7 = p32.EnabledInfo;
        for v37 = 1, #v36 do
            local v38 = v36[v37];
            if not l__EnabledInfo__7[v38] then
                l__EnabledInfo__7[v38] = v38.Enabled;
            end;
        end;
    end,
    CullInfoState = function(p39) --[[ Name: CullInfoState, Line 109 ]]
        local l__TransparencyInfo__8 = p39.TransparencyInfo;
        for v40 in next, l__TransparencyInfo__8 do
            if not v40.Parent then
                l__TransparencyInfo__8[v40] = nil;
            end;
        end;
        local l__EnabledInfo__9 = p39.EnabledInfo;
        for v41 in next, l__EnabledInfo__9 do
            if not v41.Parent then
                l__EnabledInfo__9[v41] = nil;
            end;
        end;
    end
};
