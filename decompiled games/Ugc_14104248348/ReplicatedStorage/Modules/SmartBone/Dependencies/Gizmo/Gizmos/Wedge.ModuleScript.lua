-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Gizmo.Gizmos.Wedge
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.Init(p2, p3, p4, p5, p6) --[[ Line: 4 ]]
    -- upvalues: u1 (copy)
    local v7 = setmetatable({}, u1);
    v7.Ceive = p2;
    v7.Propertys = p3;
    v7.Request = p4;
    v7.Release = p5;
    v7.Retain = p6;
    return v7;
end;
function u1.Draw(p8, p9, p10, u11) --[[ Line: 16 ]]
    local l__Ceive__1 = p8.Ceive;
    if l__Ceive__1.Enabled then
        local l__Position__2 = p9.Position;
        local l__UpVector__3 = p9.UpVector;
        local l__RightVector__4 = p9.RightVector;
        local l__LookVector__5 = p9.LookVector;
        local v12 = p10 * 0.5;
        local v13 = l__UpVector__3 * v12.Y;
        local v14 = l__RightVector__4 * v12.X;
        local v15 = l__LookVector__5 * v12.Z;
        local u16 = nil;
        local u17 = nil;
        local u18 = nil;
        local u19 = nil;
        local function v27(p20, p21, p22) --[[ Line: 58 ]]
            -- upvalues: l__Position__2 (copy), u18 (ref), u19 (ref), l__Ceive__1 (copy), u11 (copy)
            local v23 = l__Position__2 + (p20 - p21 + p22);
            local v24 = l__Position__2 + (p20 + p21 + p22);
            local v25 = l__Position__2 + (-p20 - p21 + p22);
            local v26 = l__Position__2 + (-p20 + p21 + p22);
            u18 = v23;
            u19 = v24;
            l__Ceive__1.Ray:Draw(v23, v24);
            l__Ceive__1.Ray:Draw(v23, v25);
            l__Ceive__1.Ray:Draw(v24, v26);
            if u11 ~= false then
                l__Ceive__1.Ray:Draw(v24, v25);
            end;
            l__Ceive__1.Ray:Draw(v25, v26);
        end;
        (function(p28, p29, p30) --[[ Name: CalculateYFace, Line 38 ]]
            -- upvalues: l__Position__2 (copy), u16 (ref), u17 (ref), l__Ceive__1 (copy), u11 (copy)
            local v31 = l__Position__2 + (p28 - p29 + p30);
            local v32 = l__Position__2 + (p28 + p29 + p30);
            local v33 = l__Position__2 + (p28 - p29 - p30);
            local v34 = l__Position__2 + (p28 + p29 - p30);
            u16 = v31;
            u17 = v32;
            l__Ceive__1.Ray:Draw(v31, v32);
            l__Ceive__1.Ray:Draw(v31, v33);
            l__Ceive__1.Ray:Draw(v32, v34);
            if u11 ~= false then
                l__Ceive__1.Ray:Draw(v32, v33);
            end;
            l__Ceive__1.Ray:Draw(v33, v34);
        end)(-v13, v14, v15);
        v27(v13, v14, -v15);
        l__Ceive__1.Ray:Draw(u16, u18);
        l__Ceive__1.Ray:Draw(u17, u19);
        if u11 ~= false then
            l__Ceive__1.Ray:Draw(u17, u18);
        end;
    end;
end;
function u1.Create(p35, p36, p37, p38) --[[ Line: 89 ]]
    local v39 = {
        Enabled = true,
        Destroy = false,
        Transform = p36,
        Size = p37,
        DrawTriangles = p38,
        AlwaysOnTop = p35.Propertys.AlwaysOnTop,
        Transparency = p35.Propertys.Transparency,
        Color3 = p35.Propertys.Color3
    };
    p35.Retain(p35, v39);
    return v39;
end;
function u1.Update(p40, p41) --[[ Line: 106 ]]
    local l__Ceive__6 = p40.Ceive;
    l__Ceive__6.PushProperty("AlwaysOnTop", p41.AlwaysOnTop);
    l__Ceive__6.PushProperty("Transparency", p41.Transparency);
    l__Ceive__6.PushProperty("Color3", p41.Color3);
    p40:Draw(p41.Transform, p41.Size, p41.DrawTriangles);
end;
return u1;
