-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_enigma@0.5.2.enigma.Serialization.DeserializeOpenVrInputs
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    X = 0,
    Y = 0,
    Z = 0,
    W = 1
};
local l__TrackerRole__1 = require(script.Parent.Parent:WaitForChild("Data"):WaitForChild("TrackerRole"));
local l__StringDeserializer__2 = require(script.Parent:WaitForChild("StringDeserializer"));
local u2 = {};
return function(p3) --[[ Line: 30 ]]
    -- upvalues: l__StringDeserializer__2 (copy), u2 (copy), l__TrackerRole__1 (copy), u1 (copy)
    local v4 = l__StringDeserializer__2.new(p3);
    local v5 = v4:ReadNumber();
    local v6 = v4:ReadNumber();
    if v5 ~= 1 and v5 ~= 2 then
        local v7 = `Enigma protocol version {v5} is unsupported and might not work as expected. Supported versions: 1, 2`;
        if not u2[v7] then
            u2[v7] = true;
            warn(v7);
        end;
    end;
    local v8 = {};
    if v5 == 1 then
        for _ = 1, v6 do
            local v9 = l__TrackerRole__1[v4:ReadNumber() + 1] or "Unsupported";
            local v10 = v4:ReadVector3();
            local v11 = v4:ReadQuaternion();
            local v12 = v4:ReadVector3();
            local v13 = {
                TrackerRole = v9,
                FloorRelativeCFrame = CFrame.new(v10.X, v10.Y, v10.Z, v11.X, v11.Y, v11.Z, v11.W),
                FloorRelativeVelocity = v12
            };
            table.insert(v8, v13);
        end;
        return v8;
    else
        for _ = 1, v6 do
            local v14 = u1;
            local v15 = "Unsupported";
            local v16 = Vector3.new(0, 0, 0);
            local v17 = Vector3.new(0, 0, 0);
            for _ = 1, v4:ReadNumber() do
                local v18 = v4:ReadNumber();
                local v19 = v4:ReadNumber();
                if v18 == 0 then
                    v15 = l__TrackerRole__1[v4:ReadNumber() + 1] or "Unsupported";
                elseif v18 == 1 then
                    v16 = v4:ReadVector3();
                elseif v18 == 2 then
                    v14 = v4:ReadQuaternion();
                elseif v18 == 3 then
                    v17 = v4:ReadVector3();
                else
                    local v20 = {};
                    for _ = 1, v19 do
                        table.insert(v20, v4:ReadString());
                    end;
                    local v21 = `Unsupported property id {v18} sent with {v19} values: {table.concat(v20, "|")}`;
                    if not u2[v21] then
                        u2[v21] = true;
                        warn(v21);
                    end;
                end;
            end;
            local v22 = {
                TrackerRole = v15,
                FloorRelativeCFrame = CFrame.new(v16.X, v16.Y, v16.Z, v14.X, v14.Y, v14.Z, v14.W),
                FloorRelativeVelocity = v17
            };
            table.insert(v8, v22);
        end;
        return v8;
    end;
end;
