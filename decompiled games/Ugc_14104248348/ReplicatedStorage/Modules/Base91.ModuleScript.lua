-- Decompiled from: ReplicatedStorage.Modules.Base91
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
for v3 = 1, 91 do
    u1[v3 - 1] = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,./:;<=>?@[]^_`{|}~\"", v3, v3);
    u2[string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,./:;<=>?@[]^_`{|}~\"", v3, v3)] = v3 - 1;
end;
return {
    encode = function(p4) --[[ Name: encodeBase91, Line 10 ]]
        -- upvalues: u1 (copy)
        local v5 = 0;
        local v6 = 0;
        local v7 = {};
        local v8 = 1;
        for v9 = 1, #p4 do
            local v10 = string.byte(p4, v9);
            local v11 = bit32.lshift(v10, v5);
            v6 = bit32.bor(v6, v11);
            v5 = v5 + 8;
            if v5 > 13 then
                local v12 = bit32.band(v6, 8191);
                if v12 > 88 then
                    v6 = bit32.rshift(v6, 13);
                    v5 = v5 - 13;
                else
                    v12 = bit32.band(v6, 16383);
                    v6 = bit32.rshift(v6, 14);
                    v5 = v5 - 14;
                end;
                v7[v8] = u1[v12 % 91] .. u1[math.floor(v12 / 91)];
                v8 = v8 + 1;
            end;
        end;
        if v5 > 0 then
            v7[v8] = u1[v6 % 91];
            if v5 > 7 or v6 > 90 then
                v7[v8 + 1] = u1[math.floor(v6 / 91)];
            end;
        end;
        return table.concat(v7);
    end,
    decode = function(p13, p14) --[[ Name: decodeBase91, Line 45 ]]
        -- upvalues: u2 (copy)
        local v15 = 1;
        local v16 = -1;
        local v17 = 0;
        local v18 = 0;
        local v19 = {};
        for v20 = 1, #p13 do
            if u2[string.sub(p13, v20, v20)] then
                if v16 == -1 then
                    v16 = u2[string.sub(p13, v20, v20)];
                else
                    local v21 = v16 + u2[string.sub(p13, v20, v20)] * 91;
                    local v22 = bit32.lshift(v21, v17);
                    v18 = bit32.bor(v18, v22);
                    if bit32.band(v21, 8191) > 88 then
                        v17 = v17 + 13;
                    else
                        v17 = v17 + 14;
                    end;
                    while v17 > 7 do
                        v19[v15] = string.char(v18 % 256);
                        v15 = v15 + 1;
                        v18 = bit32.rshift(v18, 8);
                        v17 = v17 - 8;
                        if p14 then
                            p14();
                        end;
                    end;
                    v16 = -1;
                end;
            end;
        end;
        if v16 ~= -1 then
            local v23 = bit32.lshift(v16, v17);
            local v24 = bit32.bor(v18, v23) % 256;
            v19[v15] = string.char(v24);
        end;
        return table.concat(v19);
    end
};
