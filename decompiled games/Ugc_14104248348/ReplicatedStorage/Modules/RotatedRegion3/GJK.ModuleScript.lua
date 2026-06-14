-- Decompiled from: ReplicatedStorage.Modules.RotatedRegion3.GJK
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local function u20(_, p2, _) --[[ Line: 15 ]]
    local v3 = p2[#p2];
    local v4 = -v3;
    local v5;
    if #p2 == 4 then
        local v6 = p2[3];
        local v7 = p2[2];
        local v8 = p2[1];
        local v9 = v6 - v3;
        local v10 = v7 - v3;
        local v11 = v8 - v3;
        v5 = v9:Cross(v10);
        local v12 = v10:Cross(v11);
        local v13 = v11:Cross(v9);
        if v5:Dot(v11) > 0 then
            v5 = -v5 or v5;
        end;
        if v12:Dot(v9) > 0 then
            v12 = -v12 or v12;
        end;
        if v13:Dot(v10) > 0 then
            v13 = -v13 or v13;
        end;
        if v5:Dot(v4) > 0 then
            table.remove(p2, 1);
        elseif v12:Dot(v4) > 0 then
            table.remove(p2, 2);
            v5 = v12;
        else
            if v13:Dot(v4) <= 0 then
                return true;
            end;
            table.remove(p2, 3);
            v5 = v13;
        end;
    elseif #p2 == 3 then
        local v14 = p2[2];
        local v15 = p2[1];
        local v16 = v14 - v3;
        local v17 = v15 - v3;
        local v18 = v16:Cross(v17);
        v5 = (v16 * v16:Dot(v17) - v17 * v16:Dot(v16)).Unit;
        local l__Unit__1 = (v17 * v17:Dot(v16) - v16 * v17:Dot(v17)).Unit;
        if v5:Dot(v4) > 0 then
            table.remove(p2, 1);
        elseif l__Unit__1:Dot(v4) > 0 then
            table.remove(p2, 2);
            v5 = l__Unit__1;
        else
            if v3 - v3 ~= Vector3.new(0, 0, 0) then
                return true;
            end;
            v5 = v18:Dot(v4) > 0 and v18 and v18 or -v18;
        end;
    else
        local v19 = p2[1] - v3;
        v5 = (v4 * v19:Dot(v19) - v19 * v19:Dot(v4)).Unit;
    end;
    return false, v5;
end;
function u1.new(p21, p22, p23, p24, p25, p26) --[[ Line: 74 ]]
    -- upvalues: u1 (copy)
    local v27 = setmetatable({}, u1);
    v27.SetA = p21;
    v27.SetB = p22;
    v27.CentroidA = p23;
    v27.CentroidB = p24;
    v27.SupportA = p25;
    v27.SupportB = p26;
    return v27;
end;
function u1.IsColliding(p28) --[[ Line: 89 ]]
    -- upvalues: u20 (copy)
    local l__Unit__2 = (p28.CentroidA - p28.CentroidB).Unit;
    local v29 = { p28.SupportA(p28.SetA, l__Unit__2) - p28.SupportB(p28.SetB, -l__Unit__2) };
    local v30 = -l__Unit__2;
    for _ = 1, 20 do
        local v31 = p28.SupportA(p28.SetA, v30) - p28.SupportB(p28.SetB, -v30);
        table.insert(v29, v31);
        if v29[#v29]:Dot(v30) <= 0 then
            return false;
        end;
        local v32;
        v32, v30 = u20(p28, v29, v30);
        if v32 then
            return true;
        end;
    end;
    return false;
end;
return u1;
