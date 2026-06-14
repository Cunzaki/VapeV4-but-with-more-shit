-- Decompiled from: ReplicatedStorage.Pathfinder
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 39 ]]
    -- upvalues: u1 (copy)
    if typeof(p2) ~= "Instance" or not p2:IsA("Folder") then
        error("Failure whilst creating nodemap, Nodemap.new([1]) requires a folder instance.");
    end;
    local v3 = {};
    setmetatable(v3, u1);
    v3.ProjectFolder = p2;
    v3.pathNodes = {};
    v3:__BuildNodes();
    return v3;
end;
function u1.__BuildNodes(p4) --[[ Line: 55 ]]
    local l__ProjectFolder__2 = p4.ProjectFolder;
    local v5 = {};
    local v6 = {};
    for _, v7 in ipairs(l__ProjectFolder__2:GetChildren()) do
        if v7:IsA("Configuration") then
            local v8 = {
                F = 0,
                G = 0,
                H = 0,
                Parent = nil,
                Position = v7:GetAttribute("NodePosition"),
                NodeType = v7:GetAttribute("NodeType"),
                Neighbors = {}
            };
            table.insert(v5, v8);
            v6[v7:GetAttribute("NodeId")] = v8;
        end;
    end;
    for _, v9 in ipairs(l__ProjectFolder__2:GetChildren()) do
        if v9:IsA("Configuration") then
            local v10 = v9:GetAttribute("NodeLinks"):split(",");
            local v11 = v6[v9:GetAttribute("NodeId")];
            for _, v12 in ipairs(v10) do
                if v12 ~= "" then
                    local v13 = v6[v12];
                    table.insert(v11.Neighbors, v13);
                    table.insert(v13.Neighbors, v11);
                end;
            end;
        end;
    end;
    p4.pathNodes = v5;
end;
function u1.FindNearestNode(p14, p15) --[[ Line: 93 ]]
    local v16 = (1 / 0);
    local v17 = nil;
    for _, v18 in ipairs(p14.pathNodes) do
        local l__Magnitude__3 = (p15 - v18.Position).Magnitude;
        if l__Magnitude__3 < v16 then
            v17 = v18;
            v16 = l__Magnitude__3;
        end;
    end;
    return v17;
end;
function u1.GetFirstNodeWhichIsA(p19, p20) --[[ Line: 105 ]]
    for _, v21 in ipairs(p19.pathNodes) do
        if v21.NodeType == p20 then
            return v21;
        end;
    end;
end;
function u1.GetRandomNode(p22) --[[ Line: 113 ]]
    if #p22.pathNodes ~= 0 then
        return p22.pathNodes[math.random(1, #p22.pathNodes)];
    end;
end;
function u1.FindPath(p23, p24, p25) --[[ Line: 118 ]]
    local v26 = p23:FindNearestNode(p24);
    local v27 = p23:FindNearestNode(p25);
    local v28 = {
        [v26] = true
    };
    local v29 = {};
    local v30 = false;
    local v31 = {};
    while next(v28) do
        local v32 = (1 / 0);
        local v33 = nil;
        for v34 in pairs(v28) do
            if v34.F < v32 then
                v32 = v34.F;
                v33 = v34;
            end;
        end;
        v28[v33] = nil;
        v29[v33] = true;
        if v33 == v27 then
            v30 = true;
            break;
        end;
        for _, v35 in ipairs(v33.Neighbors) do
            if not v29[v35] then
                if v28[v35] then
                    if v35.G < v33.G then
                        v35.Parent = v33;
                        v35.G = v33.G + (v35.Position - v33.Position).Magnitude;
                        v35.F = v35.G + v35.H;
                    end;
                else
                    v28[v35] = true;
                    v35.Parent = v33;
                    v35.G = v33.G + (v35.Position - v33.Position).Magnitude;
                    v35.H = (v35.Position - v27.Position).Magnitude;
                    v35.F = v35.G + v35.H;
                end;
            end;
        end;
    end;
    if v30 then
        while v27 do
            table.insert(v31, 1, v27);
            v27 = v27.Parent;
        end;
    end;
    for v36 in pairs(v28) do
        v36.F = 0;
        v36.G = 0;
        v36.H = 0;
        v36.Parent = nil;
    end;
    for v37 in pairs(v29) do
        v37.F = 0;
        v37.G = 0;
        v37.H = 0;
        v37.Parent = nil;
    end;
    return v30 and v31 and v31 or nil;
end;
local u38 = {
    TotalNodeMaps = {}
};
function u38.LoadMaps(_, p39) --[[ Line: 206 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u1 (copy), u38 (copy)
    local v40 = p39 or l__ReplicatedStorage__1.NodeMaps;
    if not v40 then
        return warn("Invalid or cannot find a ProjectFolder location.");
    end;
    for _, v41 in v40:GetChildren() do
        local v42 = u1.new(v41);
        u38.TotalNodeMaps[v41.Name] = v42;
    end;
end;
function u38.GetNodeMap(_, p43) --[[ Line: 218 ]]
    -- upvalues: u38 (copy)
    return u38.TotalNodeMaps[p43] or warn(("There is no NodeMap by the name of \'%s\'"):format(p43));
end;
return u38;
