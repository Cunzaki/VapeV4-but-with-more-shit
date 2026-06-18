-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.ViewportModel
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local u1 = {
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7
};
local u2 = {
    0,
    1,
    3,
    4,
    5,
    7
};
local u3 = {
    0,
    1,
    4,
    5,
    6
};
local u4 = {};
u4.__index = u4;
u4.ClassName = "ViewportModel";
local function u13(p5, p6, p7) --[[ Line: 46 ]]
    local v8 = {};
    for v9, v10 in pairs(p7) do
        local v11 = math.floor(v10 / 4) % 2 * 2 - 1;
        local v12 = math.floor(v10 / 2) % 2 * 2 - 1;
        v8[v9] = p5 * (p6 * Vector3.new(v11, v12, 2 * (v10 % 2) - 1));
    end;
    return v8;
end;
local function u20(p14) --[[ Line: 58 ]]
    -- upvalues: u2 (copy), u3 (copy), u1 (copy), u13 (copy)
    local v15 = {};
    for _, v16 in pairs(p14:GetDescendants()) do
        if v16:IsA("BasePart") then
            local v17;
            if v16:IsA("WedgePart") then
                v17 = u2;
            elseif v16:IsA("CornerWedgePart") then
                v17 = u3;
            else
                v17 = u1;
            end;
            local v18 = u13(v16.CFrame, v16.Size / 2, v17);
            for _, v19 in pairs(v18) do
                table.insert(v15, v19);
            end;
        end;
    end;
    return v15;
end;
local function u31(p21, p22, p23, p24) --[[ Line: 72 ]]
    local v25 = (-1 / 0);
    local v26 = (1 / 0);
    for _, v27 in pairs(p21) do
        local v28 = p24 * (p23 - v27.Z);
        local v29 = v27[p22] + v28;
        local v30 = v27[p22] - v28;
        v25 = math.max(v25, v29, v30);
        v26 = math.min(v26, v29, v30);
    end;
    return v25, v26;
end;
function u4.new(p32, p33) --[[ Line: 91 ]]
    -- upvalues: u4 (copy)
    local v34 = setmetatable({}, u4);
    v34.Model = nil;
    v34.ViewportFrame = p32;
    v34.Camera = p33;
    v34._points = {};
    v34._modelCFrame = CFrame.new();
    v34._modelSize = Vector3.new();
    v34._modelRadius = 0;
    v34._viewport = {};
    v34:Calibrate();
    return v34;
end;
function u4.SetModel(p35, p36) --[[ Line: 115 ]]
    -- upvalues: u20 (copy)
    p35.Model = p36;
    local v37, v38 = p36:GetBoundingBox();
    p35._points = u20(p36);
    p35._modelCFrame = v37;
    p35._modelSize = v38;
    p35._modelRadius = v38.Magnitude / 2;
end;
function u4.Calibrate(p39) --[[ Line: 128 ]]
    local v40 = {};
    local l__AbsoluteSize__1 = p39.ViewportFrame.AbsoluteSize;
    v40.aspect = l__AbsoluteSize__1.X / l__AbsoluteSize__1.Y;
    v40.yFov2 = math.rad(p39.Camera.FieldOfView / 2);
    v40.tanyFov2 = math.tan(v40.yFov2);
    v40.xFov2 = math.atan(v40.tanyFov2 * v40.aspect);
    v40.tanxFov2 = math.tan(v40.xFov2);
    local v41 = v40.tanyFov2 * math.min(1, v40.aspect);
    v40.cFov2 = math.atan(v41);
    v40.sincFov2 = math.sin(v40.cFov2);
    p39._viewport = v40;
end;
function u4.GetFitDistance(p42, p43) --[[ Line: 150 ]]
    return (p42._modelRadius + (p43 and ((p43 - p42._modelCFrame.Position).Magnitude or 0) or 0)) / p42._viewport.sincFov2;
end;
function u4.GetMinimumFitCFrame(p44, p45) --[[ Line: 162 ]]
    -- upvalues: u31 (copy)
    if not p44.Model then
        return CFrame.new();
    end;
    local v46 = (p45 - p45.Position):Inverse();
    local l___points__2 = p44._points;
    local v47 = { v46 * l___points__2[1] };
    local l__Z__3 = v47[1].Z;
    for v48 = 2, #l___points__2 do
        local v49 = v46 * l___points__2[v48];
        l__Z__3 = math.min(l__Z__3, v49.Z);
        v47[v48] = v49;
    end;
    local v50, v51 = u31(v47, "X", l__Z__3, p44._viewport.tanxFov2);
    local v52, v53 = u31(v47, "Y", l__Z__3, p44._viewport.tanyFov2);
    local v54 = math.max((v50 - v51) / 2 / p44._viewport.tanxFov2, (v52 - v53) / 2 / p44._viewport.tanyFov2);
    return p45 * CFrame.new((v50 + v51) / 2, (v52 + v53) / 2, l__Z__3 + v54);
end;
return u4;
