-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__abs__1 = math.abs;
local l__sqrt__2 = math.sqrt;
local l__remove__3 = table.remove;
local u1 = _G.obtain("CurTime");
local u2 = {};
local function u8(p3, p4, p5, p6, p7) --[[ Line: 20 ]]
    -- upvalues: l__abs__1 (copy)
    if p7 * (p5 + p6) + 2 * p3 > 2 * p4 and p5 < p6 or p6 < p5 and p7 * (p5 + p6) + 2 * p3 < 2 * p4 then
        return 2 / p7 * l__abs__1(p5 + 2 * p6 + 3 / p7 * (p3 - p4));
    end;
    if p7 * (p5 + p6) + 2 * p3 == 2 * p4 and p5 ~= p6 or (p7 * (p5 + p6) + 2 * p3 > 2 * p4 and p6 <= p5 or p7 * (p5 + p6) + 2 * p3 < 2 * p4 and p5 <= p6) then
        return 2 / p7 * l__abs__1(2 * p5 + p6 + 3 / p7 * (p3 - p4));
    end;
    print("lol", p3, p4, p5, p6, p7);
    print(debug.traceback());
    return 1;
end;
local function u16(p9, p10, p11, p12, p13) --[[ Line: 32 ]]
    -- upvalues: l__sqrt__2 (copy)
    if p9 == p10 and p11 == p12 then
        return 0;
    elseif p13 * p13 < 1e-8 then
        return (1 / 0);
    else
        local v14 = p10 < p9;
        local v15 = p11 < 0;
        if v14 and (v15 and p9 - p11 * p11 / (2 * p13) < p10) or not v14 and (v15 or not v15 and p9 + p11 * p11 / (2 * p13) < p10) then
            return (l__sqrt__2(2 * p11 * p11 + 4 * p13 * (p10 - p9)) - p11) / p13;
        else
            return (l__sqrt__2(2 * p11 * p11 - 4 * p13 * (p10 - p9)) + p11) / p13;
        end;
    end;
end;
local function u29(p17, p18, p19) --[[ Line: 52 ]]
    -- upvalues: u1 (copy), u16 (copy)
    local v20 = u1();
    local l__t0__4 = p17.t0;
    local l__t1__5 = p17.t1;
    local v21 = nil;
    local v22 = nil;
    local v23 = nil;
    local v24 = nil;
    if l__t0__4 < v20 and v20 < l__t1__5 then
        local v25 = l__t1__5 - l__t0__4;
        local v26 = (v20 - l__t0__4) / v25;
        local l__x0__6 = p17.x0;
        local l__x1__7 = p17.x1;
        local l__v0__8 = p17.v0;
        local l__v1__9 = p17.v1;
        local v27 = 1 - v26;
        v21 = l__x0__6 * v27 * v27 * v27 + (3 * l__x0__6 + l__v0__8 * v25) * v26 * v27 * v27 + (3 * l__x1__7 - l__v1__9 * v25) * v26 * v26 * v27 + l__x1__7 * v26 * v26 * v26;
        v23 = (1 - 4 * v26 + 3 * v26 * v26) * p17.v0 + v26 * (3 * v26 - 2) * p17.v1 + 6 / v25 * (v26 - 1) * v26 * (p17.x0 - p17.x1);
        v24 = p18 * 0;
    elseif l__t1__5 <= v20 then
        v21 = p17.x1;
        v23 = p18 * 0;
        v24 = p18 * 0;
    elseif v20 <= l__t0__4 then
        v21 = p17.x0;
        v23 = p18 * 0;
        v24 = p18 * 0;
    else
        p18 = v22;
    end;
    p17.Callback = p19;
    local v28 = v20 + u16(v21, p18, v23, v24, p17.MaxAcceleration);
    p17.x0 = v21;
    p17.x1 = p18;
    p17.v0 = v23;
    p17.v1 = v24;
    p17.t0 = v20;
    p17.t1 = v28;
    p17.Tweening = true;
end;
local function u45(p30, p31, p32, p33) --[[ Line: 67 ]]
    -- upvalues: u1 (copy), u8 (copy), u16 (copy)
    local v34 = u1();
    local l__t0__10 = p30.t0;
    local l__t1__11 = p30.t1;
    local v35 = nil;
    local v36 = nil;
    local v37 = nil;
    local v38 = nil;
    if l__t0__10 < v34 and v34 < l__t1__11 then
        local v39 = l__t1__11 - l__t0__10;
        local v40 = (v34 - l__t0__10) / v39;
        local l__x0__12 = p30.x0;
        local l__x1__13 = p30.x1;
        local l__v0__14 = p30.v0;
        local l__v1__15 = p30.v1;
        local v41 = 1 - v40;
        v35 = l__x0__12 * v41 * v41 * v41 + (3 * l__x0__12 + l__v0__14 * v39) * v40 * v41 * v41 + (3 * l__x1__13 - l__v1__15 * v39) * v40 * v40 * v41 + l__x1__13 * v40 * v40 * v40;
        v37 = ((1 - 4 * v40 + 3 * v40 * v40) * p30.v0 + v40 * (3 * v40 - 2) * p30.v1 + 6 / v39 * (v40 - 1) * v40 * (p30.x0 - p30.x1)) / v39;
    elseif l__t1__11 <= v34 then
        v35 = p30.x1;
        v37 = p32 * 0;
    elseif v34 <= l__t0__10 then
        v35 = p30.x0;
        v37 = p32 * 0;
    else
        p32 = v38;
        p31 = v36;
    end;
    if p33 then
        p30.MaxAcceleration = u8(v35, p31, v37, p32, p33);
    else
        p33 = u16(v35, p31, v37, p32, p30.MaxAcceleration) or p30.DefaultTime;
    end;
    local v42 = p33 * v37;
    local v43 = p33 * p32;
    local v44 = v34 + p33;
    p30.x0 = v35;
    p30.x1 = p31;
    p30.v0 = v42;
    p30.v1 = v43;
    p30.t0 = v34;
    p30.t1 = v44;
    p30.Tweening = true;
end;
local function u51(p46, p47) --[[ Line: 86 ]]
    if p46 then
        local l__Update__16 = p46.Update;
        local l__t0__17 = p46.t0;
        local l__t1__18 = p46.t1;
        if l__Update__16 then
            if p46.Tweening then
                if l__t0__17 < p47 and p47 < l__t1__18 then
                    local v48 = l__t1__18 - l__t0__17;
                    local l__x0__19 = p46.x0;
                    local l__x1__20 = p46.x1;
                    local l__v0__21 = p46.v0;
                    local l__v1__22 = p46.v1;
                    local v49 = (p47 - l__t0__17) / v48;
                    local v50 = 1 - v49;
                    l__Update__16(l__x0__19 * v50 * v50 * v50 + (3 * l__x0__19 + l__v0__21 * v48) * v49 * v50 * v50 + (3 * l__x1__20 - l__v1__22 * v48) * v49 * v49 * v50 + l__x1__20 * v49 * v49 * v49);
                    return;
                end;
                if l__t1__18 <= p47 then
                    l__Update__16(p46.x1);
                    p46.Tweening = false;
                    local l__Callback__23 = p46.Callback;
                    if l__Callback__23 then
                        if p46.TempCallback then
                            p46.Callback = nil;
                        end;
                        l__Callback__23();
                    end;
                end;
            elseif p47 <= l__t0__17 then
                p46.Tweening = true;
            end;
        end;
    end;
end;
local function u57(p52) --[[ Line: 112 ]]
    -- upvalues: u1 (copy)
    local v53 = u1();
    local l__t0__24 = p52.t0;
    local l__t1__25 = p52.t1;
    if l__t0__24 < v53 and v53 < l__t1__25 then
        local v54 = l__t1__25 - l__t0__24;
        local l__x0__26 = p52.x0;
        local l__x1__27 = p52.x1;
        local l__v0__28 = p52.v0;
        local l__v1__29 = p52.v1;
        local v55 = (v53 - l__t0__24) / v54;
        local v56 = 1 - v55;
        return l__x0__26 * v56 * v56 * v56 + (3 * l__x0__26 + l__v0__28 * v54) * v55 * v56 * v56 + (3 * l__x1__27 - l__v1__29 * v54) * v55 * v55 * v56 + l__x1__27 * v55 * v55 * v55;
    elseif l__t1__25 <= v53 then
        return p52.x1;
    else
        return p52.x0;
    end;
end;
local function u60(p58) --[[ Line: 125 ]]
    -- upvalues: u2 (copy), l__remove__3 (copy)
    for v59 = #u2, 1, -1 do
        if u2[v59] == p58 then
            l__remove__3(u2, v59);
        end;
    end;
end;
local function u65(p61, p62, p63) --[[ Line: 133 ]]
    -- upvalues: u1 (copy), u29 (copy), u45 (copy), u60 (copy), u57 (copy), u2 (copy)
    local v64 = {
        t0 = 0,
        MaxAcceleration = 6,
        DefaultTime = 1,
        x0 = p61,
        v0 = p61 * 0,
        x1 = p61,
        v1 = p61 * 0,
        t1 = u1(),
        Update = p62,
        Callback = p63,
        Target = u29,
        Custom = u45,
        Remove = u60,
        Value = u57,
        TempCallback = not p63
    };
    if p62 then
        p62(p61);
    end;
    u2[#u2 + 1] = v64;
    return v64;
end;
game:GetService("RunService").RenderStepped:connect(function() --[[ Line: 154 ]]
    -- upvalues: u1 (copy), u2 (copy), u51 (copy)
    local v66 = u1();
    for v67 = 1, #u2 do
        u51(u2[v67], v66);
    end;
end);
return {
    New = u65,
    Once = function(p68, p69, p70, p71, u72) --[[ Name: Once, Line 142 ]]
        -- upvalues: u65 (copy), u8 (copy)
        local u73 = u65(p68, p71);
        u73.MaxAcceleration = u8(p68, p69, 0, 0, p70);
        u73:Target(p69, function() --[[ Line: 145 ]]
            -- upvalues: u73 (copy), u72 (copy)
            u73:Remove();
            if u72 then
                u72();
            end;
        end);
    end,
    Target = u29,
    Custom = u45,
    MaxAcceleration = u8,
    MaximizeAccelerationDuration = u16,
    Update = u51,
    Remove = u60
};
