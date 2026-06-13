-- Decompiled from: ReplicatedStorage.Modules.RotatedRegion3
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__GJK__1 = require(script:WaitForChild("GJK"));
local l__Supports__2 = require(script:WaitForChild("Supports"));
local l__Vertices__3 = require(script:WaitForChild("Vertices"));
local u1 = {};
u1.__index = u1;
local function u4(p2, p3) --[[ Line: 86 ]]
    return {
        p2:PointToWorldSpace((Vector3.new(-p3.x, p3.y, p3.z))),
        p2:PointToWorldSpace((Vector3.new(-p3.x, -p3.y, p3.z))),
        p2:PointToWorldSpace((Vector3.new(-p3.x, -p3.y, -p3.z))),
        p2:PointToWorldSpace((Vector3.new(p3.x, -p3.y, -p3.z))),
        p2:PointToWorldSpace((Vector3.new(p3.x, p3.y, -p3.z))),
        p2:PointToWorldSpace((Vector3.new(p3.x, p3.y, p3.z))),
        p2:PointToWorldSpace((Vector3.new(p3.x, -p3.y, p3.z))),
        p2:PointToWorldSpace((Vector3.new(-p3.x, p3.y, -p3.z)))
    };
end;
local function u17(p5) --[[ Line: 99 ]]
    local v6 = {};
    local v7 = {};
    local v8 = {};
    for v9 = 1, #p5 do
        local l__x__4 = p5[v9].x;
        local l__y__5 = p5[v9].y;
        local l__z__6 = p5[v9].z;
        v6[v9] = l__x__4;
        v7[v9] = l__y__5;
        v8[v9] = l__z__6;
    end;
    local v10 = math.min(unpack(v6));
    local v11 = math.min(unpack(v7));
    local v12 = math.min(unpack(v8));
    local v13 = Vector3.new(v10, v11, v12);
    local v14 = math.max(unpack(v6));
    local v15 = math.max(unpack(v7));
    local v16 = math.max(unpack(v8));
    return v13, Vector3.new(v14, v15, v16);
end;
function u1.new(p18, p19) --[[ Line: 109 ]]
    -- upvalues: u1 (copy), l__Vertices__3 (copy), l__Supports__2 (copy), u17 (copy)
    local v20 = setmetatable({}, u1);
    v20.CFrame = p18;
    v20.Size = p19;
    v20.Shape = "Block";
    v20.Set = l__Vertices__3.Block(p18, p19 / 2);
    v20.Support = l__Supports__2.PointCloud;
    v20.Centroid = p18.p;
    v20.AlignedRegion3 = Region3.new(u17(v20.Set));
    return v20;
end;
u1.Block = u1.new;
function u1.Wedge(p21, p22) --[[ Line: 127 ]]
    -- upvalues: u1 (copy), l__Vertices__3 (copy), l__Supports__2 (copy), u17 (copy)
    local v23 = setmetatable({}, u1);
    v23.CFrame = p21;
    v23.Size = p22;
    v23.Shape = "Wedge";
    v23.Set = l__Vertices__3.Wedge(p21, p22 / 2);
    v23.Support = l__Supports__2.PointCloud;
    v23.Centroid = l__Vertices__3.GetCentroid(v23.Set);
    v23.AlignedRegion3 = Region3.new(u17(v23.Set));
    return v23;
end;
function u1.CornerWedge(p24, p25) --[[ Line: 143 ]]
    -- upvalues: u1 (copy), l__Vertices__3 (copy), l__Supports__2 (copy), u17 (copy)
    local v26 = setmetatable({}, u1);
    v26.CFrame = p24;
    v26.Size = p25;
    v26.Shape = "CornerWedge";
    v26.Set = l__Vertices__3.CornerWedge(p24, p25 / 2);
    v26.Support = l__Supports__2.PointCloud;
    v26.Centroid = l__Vertices__3.GetCentroid(v26.Set);
    v26.AlignedRegion3 = Region3.new(u17(v26.Set));
    return v26;
end;
function u1.Cylinder(p27, p28) --[[ Line: 159 ]]
    -- upvalues: u1 (copy), l__Supports__2 (copy), u17 (copy), u4 (copy)
    local v29 = setmetatable({}, u1);
    v29.CFrame = p27;
    v29.Size = p28;
    v29.Shape = "Cylinder";
    v29.Set = { p27, p28 / 2 };
    v29.Support = l__Supports__2.Cylinder;
    v29.Centroid = p27.p;
    v29.AlignedRegion3 = Region3.new(u17((u4(unpack(v29.Set)))));
    return v29;
end;
function u1.Ball(p30, p31) --[[ Line: 175 ]]
    -- upvalues: u1 (copy), l__Supports__2 (copy), u17 (copy), u4 (copy)
    local v32 = setmetatable({}, u1);
    v32.CFrame = p30;
    v32.Size = p31;
    v32.Shape = "Ball";
    v32.Set = { p30, p31 / 2 };
    v32.Support = l__Supports__2.Ellipsoid;
    v32.Centroid = p30.p;
    v32.AlignedRegion3 = Region3.new(u17((u4(unpack(v32.Set)))));
    return v32;
end;
function u1.FromPart(p33) --[[ Line: 191 ]]
    -- upvalues: u1 (copy), l__Vertices__3 (copy)
    return u1[l__Vertices__3.Classify(p33)](p33.CFrame, p33.Size);
end;
function u1.CastPoint(p34, p35) --[[ Line: 197 ]]
    -- upvalues: l__GJK__1 (copy), l__Supports__2 (copy)
    return l__GJK__1.new(p34.Set, { p35 }, p34.Centroid, p35, p34.Support, l__Supports__2.PointCloud):IsColliding();
end;
function u1.CastPart(p36, p37) --[[ Line: 202 ]]
    -- upvalues: u1 (copy), l__GJK__1 (copy)
    local v38 = u1.FromPart(p37);
    return l__GJK__1.new(p36.Set, v38.Set, p36.Centroid, v38.Centroid, p36.Support, v38.Support):IsColliding();
end;
function u1.FindPartsInRegion3(p39, p40, p41) --[[ Line: 208 ]]
    local v42 = game.Workspace:FindPartsInRegion3(p39.AlignedRegion3, p40, p41);
    local v43 = {};
    for v44 = 1, #v42 do
        if p39:CastPart(v42[v44]) then
            table.insert(v43, v42[v44]);
        end;
    end;
    return v43;
end;
function u1.FindPartsInRegion3WithIgnoreList(p45, p46, p47) --[[ Line: 219 ]]
    local v48 = game.Workspace:FindPartsInRegion3WithIgnoreList(p45.AlignedRegion3, p46 or {}, p47);
    local v49 = {};
    for v50 = 1, #v48 do
        if p45:CastPart(v48[v50]) then
            table.insert(v49, v48[v50]);
        end;
    end;
    return v49;
end;
function u1.FindPartsInRegion3WithWhiteList(p51, p52, p53) --[[ Line: 231 ]]
    local v54 = game.Workspace:FindPartsInRegion3WithWhiteList(p51.AlignedRegion3, p52 or {}, p53);
    local v55 = {};
    for v56 = 1, #v54 do
        if p51:CastPart(v54[v56]) then
            table.insert(v55, v54[v56]);
        end;
    end;
    return v55;
end;
function u1.Cast(p57, p58, p59) --[[ Line: 243 ]]
    return p57:FindPartsInRegion3WithIgnoreList(type(p58) == "table" and p58 and p58 or { p58 }, p59);
end;
return u1;
