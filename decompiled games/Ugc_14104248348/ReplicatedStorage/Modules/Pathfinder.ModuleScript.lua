-- Decompiled from: ReplicatedStorage.Modules.Pathfinder
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 40 ]]
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
function u1.__BuildNodes(p4) --[[ Line: 56 ]]
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
                Meta = v7:GetAttribute("Meta") or "None",
                Neighbors = {},
                Z = math.random(),
                __Lookup = {}
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
                    if v13 then
                        if not v11.__Lookup[v13] then
                            v11.__Lookup[v13] = true;
                            table.insert(v11.Neighbors, v13);
                        end;
                        if not v13.__Lookup[v11] then
                            v13.__Lookup[v11] = true;
                            table.insert(v13.Neighbors, v11);
                        end;
                    end;
                end;
            end;
        end;
    end;
    for _, v14 in v5 do
        v14.__Lookup = nil;
    end;
    p4.pathNodes = v5;
end;
function u1.FindNearestNode(p15, p16) --[[ Line: 118 ]]
    local v17 = (1 / 0);
    local v18 = nil;
    for _, v19 in ipairs(p15.pathNodes) do
        local l__Magnitude__3 = (p16 - v19.Position).Magnitude;
        if l__Magnitude__3 < v17 then
            v18 = v19;
            v17 = l__Magnitude__3;
        end;
    end;
    return v18;
end;
function u1.GetFirstNodeWhichIsA(p20, p21) --[[ Line: 130 ]]
    for _, v22 in ipairs(p20.pathNodes) do
        if v22.NodeType == p21 then
            return v22;
        end;
    end;
end;
function u1.GetAllNodesWhichIsA(p23, p24) --[[ Line: 138 ]]
    local v25 = {};
    for _, v26 in ipairs(p23.pathNodes) do
        if v26.NodeType == p24 then
            table.insert(v25, v26);
        end;
    end;
    return v25;
end;
function u1.GetRandomNode(p27) --[[ Line: 149 ]]
    if #p27.pathNodes ~= 0 then
        return p27.pathNodes[math.random(1, #p27.pathNodes)];
    end;
end;
function u1.FindPath(p28, p29, p30) --[[ Line: 154 ]]
    local v31 = p28:FindNearestNode(p29);
    local v32 = p28:FindNearestNode(p30);
    local v33 = {
        [v31] = true
    };
    local v34 = {};
    local v35 = false;
    local v36 = {};
    while next(v33) do
        local v37 = (1 / 0);
        local v38 = nil;
        for v39 in pairs(v33) do
            if v39.F < v37 then
                v37 = v39.F;
                v38 = v39;
            end;
        end;
        v33[v38] = nil;
        v34[v38] = true;
        if v38 == v32 then
            v35 = true;
            break;
        end;
        for _, v40 in ipairs(v38.Neighbors) do
            if not v34[v40] then
                if v33[v40] then
                    if v40.G < v38.G then
                        v40.Parent = v38;
                        v40.G = v38.G + (v40.Position - v38.Position).Magnitude;
                        v40.F = v40.G + v40.H;
                    end;
                else
                    v33[v40] = true;
                    v40.Parent = v38;
                    v40.G = v38.G + (v40.Position - v38.Position).Magnitude;
                    v40.H = (v40.Position - v32.Position).Magnitude;
                    v40.F = v40.G + v40.H;
                end;
            end;
        end;
    end;
    if v35 then
        while v32 do
            table.insert(v36, 1, v32);
            v32 = v32.Parent;
        end;
    end;
    for v41 in pairs(v33) do
        v41.F = 0;
        v41.G = 0;
        v41.H = 0;
        v41.Parent = nil;
    end;
    for v42 in pairs(v34) do
        v42.F = 0;
        v42.G = 0;
        v42.H = 0;
        v42.Parent = nil;
    end;
    return v35 and v36 and v36 or nil;
end;
local u43 = {
    TotalNodeMaps = {}
};
function u43.LoadMaps(_, p44) --[[ Line: 242 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u1 (copy), u43 (copy)
    local v45 = p44 or l__ReplicatedStorage__1:FindFirstChild("NodeMaps");
    if not v45 then
        return warn("Invalid or cannot find a ProjectFolder location.");
    end;
    for _, v46 in v45:GetChildren() do
        local v47 = u1.new(v46);
        u43.TotalNodeMaps[v46.Name] = v47;
    end;
end;
function u43.GetNodeMap(_, p48) --[[ Line: 254 ]]
    -- upvalues: u43 (copy)
    return u43.TotalNodeMaps[p48] or warn(("There is no NodeMap by the name of \'%s\'"):format(p48));
end;
return u43;
