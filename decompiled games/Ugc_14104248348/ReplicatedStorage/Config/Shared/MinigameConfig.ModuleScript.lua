-- Decompiled from: ReplicatedStorage.Config.Shared.MinigameConfig
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
local function u7(p2) --[[ Line: 4 ]]
    -- upvalues: u1 (copy)
    u1[p2.Name] = {};
    for v3, v4 in p2:GetAttributes() do
        local v5 = string.split(v3, "SPLICE");
        if v5[2] then
            local v6 = v5[1];
            if not u1[p2.Name][v6] then
                u1[p2.Name][v6] = {};
            end;
            u1[p2.Name][v6][v5[2]] = v4;
        else
            u1[p2.Name][v3] = v4;
        end;
    end;
end;
script.ChildAdded:Connect(function(p8) --[[ Line: 23 ]]
    -- upvalues: u7 (copy)
    u7(p8);
end);
for _, v9 in script:GetChildren() do
    u7(v9);
end;
return u1;
