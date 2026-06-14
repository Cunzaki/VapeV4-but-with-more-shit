-- Decompiled from: ReplicatedStorage.Modules.Mince.Crypto
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u2 = {
    Layout = "oxyzoxyzoxyzoxyzoxyzoxyzoxyzoxyzoxyzoxyzoxyzoxyzoxyzoxyzoxyzoxyz",
    IntRange = { 33, 126 },
    NewKey = function(_, u1) --[[ Name: NewKey, Line 6 ]]
        function u1.Serialize(_) --[[ Line: 7 ]]
            -- upvalues: u1 (copy)
            return `{u1.Seed}:{u1.Parts[1]}:{u1.Parts[2]}:{u1.Parts[3]}`;
        end;
        return u1;
    end
};
function u2.ParseKey(_, p3) --[[ Line: 14 ]]
    -- upvalues: u2 (copy)
    local v9 = (function(p4, p5) --[[ Line: 15 ]]
        local v6 = {};
        for v7 in string.gmatch(p4, "([^" .. (p5 == nil and "%s" or p5) .. "]+)") do
            local v8 = tonumber(v7);
            table.insert(v6, v8);
        end;
        return v6;
    end)(p3, ":");
    local v10, v11, v12, v13 = table.unpack(v9);
    return u2:NewKey({
        Seed = v10,
        Parts = { v11, v12, v13 }
    });
end;
function u2.GenKey(_) --[[ Line: 33 ]]
    -- upvalues: u2 (copy)
    local v14 = Random.new(os.clock());
    local v15 = {
        Parts = { v14:NextNumber() * 100000000, v14:NextNumber() * 100000000, v14:NextNumber() * 100000000 }
    };
    local v16 = os.clock() * 10000000;
    v15.Seed = math.floor(v16);
    return u2:NewKey(v15);
end;
function u2.String(_, u17, u18) --[[ Line: 44 ]]
    -- upvalues: u2 (copy)
    local l__Seed__1 = u17.Seed;
    local u19 = 0;
    local u20 = 0;
    local function u25(p21, p22) --[[ Line: 53 ]]
        -- upvalues: u19 (ref), l__Seed__1 (ref), u17 (copy), u18 (copy), u20 (ref), u25 (ref)
        local v23;
        if p22 then
            local v24 = u19;
            l__Seed__1 = l__Seed__1 - 0;
            l__Seed__1 = (u17.Parts[1] * l__Seed__1 + u17.Parts[2]) % u17.Parts[3];
            v23 = v24 + l__Seed__1 % math.floor(#u18 / 2);
            if v23 then
                u19 = v23;
                if not p21 and u19 == u20 then
                    return u25();
                end;
                if u19 > #u18 then
                    u19 = 1;
                end;
                u20 = u19;
                return string.byte(u18:sub(u19, u19));
            end;
        end;
        v23 = u19 + 1;
        u19 = v23;
        if not p21 and u19 == u20 then
            return u25();
        end;
        if u19 > #u18 then
            u19 = 1;
        end;
        u20 = u19;
        return string.byte(u18:sub(u19, u19));
    end;
    return string.gsub(u2.Layout, "[xyzo]", function(p26) --[[ Line: 67 ]]
        -- upvalues: u25 (ref), l__Seed__1 (ref), u17 (copy), u2 (ref)
        local v27 = 0;
        if p26 == "x" then
            local v28 = u25(nil, true);
            l__Seed__1 = l__Seed__1 - (v28 and v28 * l__Seed__1 or 0);
            l__Seed__1 = (u17.Parts[1] * l__Seed__1 + u17.Parts[2]) % u17.Parts[3];
            v27 = l__Seed__1;
        elseif p26 == "y" then
            local v29 = u25();
            l__Seed__1 = l__Seed__1 - (v29 and v29 * l__Seed__1 or 0);
            l__Seed__1 = (u17.Parts[1] * l__Seed__1 + u17.Parts[2]) % u17.Parts[3];
            v27 = l__Seed__1;
        elseif p26 == "z" then
            l__Seed__1 = l__Seed__1 - 0;
            l__Seed__1 = (u17.Parts[1] * l__Seed__1 + u17.Parts[2]) % u17.Parts[3];
            v27 = l__Seed__1;
        elseif p26 == "o" then
            v27 = u25(true, true);
        end;
        local v30 = math.abs(v27 or 1);
        local v31 = u2.IntRange[1];
        return string.char((v30 - 1) % (u2.IntRange[2] - v31 + 1) + v31);
    end), u18;
end;
return u2;
