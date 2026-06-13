-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Util.BufferProtocol
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    {
        Name = "UpdateTime",
        Type = "number"
    },
    {
        Name = "CurrentWalkspeed",
        Type = "number"
    },
    {
        Name = "HeadCFrame",
        Type = "CFrame"
    },
    {
        Name = "LeftHandCFrame",
        Type = "CFrame"
    },
    {
        Name = "RightHandCFrame",
        Type = "CFrame"
    },
    {
        Name = "LeftFootCFrame",
        Type = "CFrame"
    },
    {
        Name = "RightFootCFrame",
        Type = "CFrame"
    }
};
local u2 = {
    number = 8,
    CFrame = 28
};
local u29 = {
    Serialize = function(p3) --[[ Name: Serialize, Line 62 ]]
        -- upvalues: u1 (copy), u2 (copy)
        local v4 = 1;
        local v5 = {};
        for v6, v7 in u1 do
            local v8 = p3[v7.Name];
            if v8 and typeof(v8) == v7.Type then
                local v9 = u2[v7.Type];
                v4 = v4 + (1 + u2[v7.Type]);
                table.insert(v5, {
                    Index = v6,
                    Length = v9,
                    Data = v8
                });
            end;
        end;
        local v10 = buffer.create(v4);
        buffer.writei8(v10, 0, #v5);
        local v11 = 1;
        for _, v12 in v5 do
            buffer.writei8(v10, v11, v12.Index);
            local v13 = v11 + 1;
            local l__Data__1 = v12.Data;
            local v14 = typeof(l__Data__1);
            if v14 == "number" then
                buffer.writef64(v10, v13, l__Data__1);
            elseif v14 == "CFrame" then
                local l__Position__2 = l__Data__1.Position;
                local v15, v16 = l__Data__1:ToAxisAngle();
                buffer.writef32(v10, v13, l__Position__2.X);
                buffer.writef32(v10, v13 + 4, l__Position__2.Y);
                buffer.writef32(v10, v13 + 8, l__Position__2.Z);
                buffer.writef32(v10, v13 + 12, v15.X);
                buffer.writef32(v10, v13 + 16, v15.Y);
                buffer.writef32(v10, v13 + 20, v15.Z);
                buffer.writef32(v10, v13 + 24, v16);
            end;
            v11 = v13 + v12.Length;
        end;
        return v10;
    end,
    DeserializeSection = function(p17, p18) --[[ Name: DeserializeSection, Line 111 ]]
        -- upvalues: u1 (copy)
        local v19 = buffer.readi8(p17, p18);
        local v20 = p18 + 1;
        local v21 = {};
        for _ = 1, v19 do
            local v22 = u1[buffer.readi8(p17, v20)];
            v20 = v20 + 1;
            if v22.Type == "number" then
                v21[v22.Name] = buffer.readf64(p17, v20);
                v20 = v20 + 8;
            elseif v22.Type == "CFrame" then
                local v23 = CFrame.new(buffer.readf32(p17, v20), buffer.readf32(p17, v20 + 4), (buffer.readf32(p17, v20 + 8)));
                local v24 = buffer.readf32(p17, v20 + 12);
                local v25 = buffer.readf32(p17, v20 + 16);
                local v26 = buffer.readf32(p17, v20 + 20);
                local v27 = Vector3.new(v24, v25, v26);
                local v28 = buffer.readf32(p17, v20 + 24);
                v21[v22.Name] = v23 * CFrame.fromAxisAngle(v27, v28);
                v20 = v20 + 28;
            end;
        end;
        return v21, v20 - p18;
    end
};
function u29.Deserialize(p30) --[[ Line: 135 ]]
    -- upvalues: u29 (copy)
    local v31 = buffer.len(p30);
    local v32 = 0;
    local v33 = {};
    while v32 < v31 do
        local v34 = buffer.readf64(p30, v32);
        local v35 = v32 + 8;
        local v36, v37 = u29.DeserializeSection(p30, v35);
        v33[v34] = v36;
        v32 = v35 + v37;
    end;
    return v33;
end;
return u29;
