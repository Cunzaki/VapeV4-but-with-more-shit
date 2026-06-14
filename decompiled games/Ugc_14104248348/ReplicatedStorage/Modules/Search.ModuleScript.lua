-- Decompiled from: ReplicatedStorage.Modules.Search
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

function spairs(u1)
    local u2 = {};
    for v3 in pairs(u1) do
        u2[#u2 + 1] = v3;
    end;
    table.sort(u2);
    local u4 = 0;
    return function() --[[ Line: 19 ]]
        -- upvalues: u4 (ref), u2 (copy), u1 (copy)
        u4 = u4 + 1;
        if u2[u4] then
            return u2[u4], u1[u2[u4]];
        end;
    end;
end;
function a(p5, p6)
    local v7 = #p5;
    local v8 = math.min(300, #p5 / 300);
    local v9 = 0;
    for v10 = 1, v7, math.max(1, v8) do
        if string.sub(p5, v10, v10) ~= string.sub(p6, v10, v10) then
            v9 = v9 + 1;
        end;
    end;
    return v9;
end;
function b(p11, p12)
    local v13 = #p12;
    local v14 = math.min(300, #p11 / 300);
    local v15 = 0;
    for v16 = 1, v13, math.max(1, v14) do
        if string.sub(p12, v16, v16) ~= string.sub(p11, v16, v16) then
            v15 = v15 + 1;
        end;
    end;
    return v15;
end;
function c(p17, p18)
    return a(p17, p18) + b(p17, p18);
end;
function d(p19, p20)
    local v21 = string.len(p19);
    local v22 = string.len(p20);
    local v23 = math.min(300, v21 / 300);
    local v24 = math.max(1, v23);
    local v25 = math.min(300, v22 / 300);
    local v26 = math.max(1, v25);
    local v27 = {};
    if v21 == 0 then
        return v22;
    end;
    if v22 == 0 then
        return v21;
    end;
    if p19 == p20 then
        return 0;
    end;
    for v28 = 0, v21, v24 do
        v27[v28] = {};
        v27[v28][0] = v28;
    end;
    for v29 = 0, v22, v26 do
        v27[0][v29] = v29;
    end;
    for v30 = 1, v21, v24 do
        for v31 = 1, v22, v26 do
            local v32 = p19:byte(v30) == p20:byte(v31) and 0 or 1;
            v27[v30][v31] = math.min(v27[v30 - 1][v31] + 1, v27[v30][v31 - 1] + 1, v27[v30 - 1][v31 - 1] + v32);
        end;
    end;
    return v27[v21][v22];
end;
function e(p33, p34)
    return p33 == p34 and 0 or #p33 + #p34;
end;
function f(p35, p36)
    return string.find(p35, p36) and (string.find(p36, p35) and 0 or 1) or (string.find(p36, p35) and (string.find(p35, p36) and 0 or 1) or #p35 + #p36);
end;
local u39 = {
    HammingB = b,
    HammingA = a,
    HammingC = c,
    Levenshtein = d,
    Match = e,
    Quadmatch = f,
    AutoMatch = function(p37, p38) --[[ Name: g, Line 137 ]]
        return p37 ~= p38:sub(1, #p37) and 100000 or -(100 - math.min(100, d(p37, p38)));
    end
};
return {
    GetMethods = function() --[[ Line: 156 ]]
        -- upvalues: u39 (copy)
        return u39;
    end,
    GetRankings = function(p40, p41) --[[ Line: 168 ]]
        -- upvalues: u39 (copy)
        local v42 = u39[p41.method or "HammingB"] or a;
        if p41.method and type(p41.method) == "function" then
            v42 = p41.method;
        end;
        local l__data__1 = p41.data;
        local v43 = #p40 * (p41.maxDistance or 1);
        local v44 = {};
        for _, v45 in ipairs(l__data__1) do
            if v45 then
                local v46 = v42(p40, v45);
                if v46 < v43 then
                    v44[v46 + 1] = v44[v46 + 1] or {};
                    table.insert(v44[v46 + 1], 1, v45);
                end;
            end;
        end;
        return v44;
    end,
    ReadRankings = function(p47, p48) --[[ Line: 158 ]]
        local v49 = 0;
        for v50, v51 in spairs(p47) do
            for _, v52 in ipairs(v51) do
                v49 = v49 + 1;
                p48(v52, v49, v50);
            end;
        end;
    end
};
