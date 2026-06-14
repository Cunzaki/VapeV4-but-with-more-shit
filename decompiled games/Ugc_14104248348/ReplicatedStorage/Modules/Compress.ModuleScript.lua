-- Decompiled from: ReplicatedStorage.Modules.Compress
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__char__1 = string.char;
local u1 = type;
local _ = select;
local l__sub__2 = string.sub;
local l__concat__3 = table.concat;
local u2 = {};
local u3 = {};
for v4 = 0, 255 do
    local v5 = l__char__1(v4);
    local v6 = l__char__1(v4, 0);
    u2[v5] = v6;
    u3[v6] = v5;
end;
return {
    compress = function(p7) --[[ Name: compress, Line 29 ]]
        -- upvalues: u1 (copy), l__sub__2 (copy), u2 (copy), l__char__1 (copy), l__concat__3 (copy)
        if u1(p7) == "string" then
            local v8 = #p7;
            if v8 <= 1 then
                return "u" .. p7;
            else
                local v9 = "";
                local v10 = {};
                local v11 = 1;
                local v12 = { "c" };
                local v13 = 2;
                local v14 = 1;
                local v15 = 0;
                for v16 = 1, v8 do
                    local v17 = l__sub__2(p7, v16, v16);
                    local v18 = v9 .. v17;
                    if u2[v18] or v10[v18] then
                        v9 = v18;
                    else
                        local v19 = u2[v9] or v10[v9];
                        if not v19 then
                            return nil, "algorithm error, could not fetch word";
                        end;
                        v12[v13] = v19;
                        v14 = v14 + #v19;
                        v13 = v13 + 1;
                        if v8 <= v14 then
                            return "u" .. p7;
                        end;
                        if v15 >= 256 then
                            v15 = 0;
                            v11 = v11 + 1;
                            if v11 >= 256 then
                                v11 = 1;
                                v10 = {};
                            end;
                        end;
                        v10[v18] = l__char__1(v15, v11);
                        v15 = v15 + 1;
                        v9 = v17;
                    end;
                end;
                v12[v13] = u2[v9] or v10[v9];
                local v20 = v14 + #v12[v13];
                local _ = v13 + 1;
                if v8 <= v20 then
                    return "u" .. p7;
                else
                    return l__concat__3(v12);
                end;
            end;
        else
            return nil, "string expected, got " .. u1(p7);
        end;
    end,
    decompress = function(p21) --[[ Name: decompress, Line 87 ]]
        -- upvalues: u1 (copy), l__sub__2 (copy), u3 (copy), l__char__1 (copy), l__concat__3 (copy)
        if u1(p21) ~= "string" then
            return nil, "string expected, got " .. u1(p21);
        end;
        if #p21 < 1 then
            return nil, "invalid input - not a compressed string";
        end;
        local v22 = l__sub__2(p21, 1, 1);
        if v22 == "u" then
            return l__sub__2(p21, 2);
        end;
        if v22 ~= "c" then
            return nil, "invalid input - not a compressed string";
        end;
        local v23 = l__sub__2(p21, 2);
        local v24 = #v23;
        if v24 < 2 then
            return nil, "invalid input - not a compressed string";
        end;
        local v25 = {};
        local v26 = {};
        local v27 = 1;
        local v28 = l__sub__2(v23, 1, 2);
        v26[v27] = u3[v28] or v25[v28];
        local v29 = v27 + 1;
        local v30 = 0;
        local v31 = 1;
        for v32 = 3, v24, 2 do
            local v33 = l__sub__2(v23, v32, v32 + 1);
            local v34 = u3[v28] or v25[v28];
            if not v34 then
                return nil, "could not find last from dict. Invalid input?";
            end;
            local v35 = u3[v33] or v25[v33];
            if v35 then
                v26[v29] = v35;
                v29 = v29 + 1;
                local v36 = v34 .. l__sub__2(v35, 1, 1);
                if v30 >= 256 then
                    v30 = 0;
                    v31 = v31 + 1;
                    if v31 >= 256 then
                        v31 = 1;
                        v25 = {};
                    end;
                end;
                v25[l__char__1(v30, v31)] = v36;
                v30 = v30 + 1;
            else
                local v37 = v34 .. l__sub__2(v34, 1, 1);
                v26[v29] = v37;
                v29 = v29 + 1;
                if v30 >= 256 then
                    v30 = 0;
                    v31 = v31 + 1;
                    if v31 >= 256 then
                        v31 = 1;
                        v25 = {};
                    end;
                end;
                v25[l__char__1(v30, v31)] = v37;
                v30 = v30 + 1;
            end;
            v28 = v33;
        end;
        return l__concat__3(v26);
    end
};
