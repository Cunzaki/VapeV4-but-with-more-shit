-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__modf__1 = math.modf;
local l__floor__2 = math.floor;
local l__concat__3 = table.concat;
local l__format__4 = string.format;
local u1 = {
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
};
local u2 = {
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
};
local u3 = {
    31,
    28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
};
local u4 = {
    31,
    29,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
};
local function u13(p5, p6) --[[ Line: 29 ]]
    -- upvalues: l__modf__1 (copy), l__format__4 (copy)
    local v7, v8 = l__modf__1(p5 * 24);
    local v9, v10 = l__modf__1(v8 * 60);
    local v11, _ = l__modf__1(v10 * 60);
    local v12 = l__format__4("%d:%02i", (v7 - 1) % 12 + 1, v9) .. (v7 < 12 and "AM" or "PM");
    if p6 then
        return v12 .. l__format__4(";%02is", v11);
    else
        return v12;
    end;
end;
return {
    ToDate = function(p14, p15, p16, p17, p18, p19, p20) --[[ Name: ToDate, Line 45 ]]
        -- upvalues: l__floor__2 (copy), u4 (copy), u3 (copy), u2 (copy), l__modf__1 (copy), u13 (copy), u1 (copy), l__concat__3 (copy)
        local v21 = l__floor__2((p14 + 62167219200) / 12622780800);
        local v22 = (p14 - (v21 * 12622780800 - 62167219200)) / 86400;
        local v23 = v21 * 400;
        local v24 = 1;
        for _ = 1, 400 do
            if v23 % 400 == 0 or v23 % 100 ~= 0 and v23 % 4 == 0 then
                if u4[v24] > v22 then
                    break;
                end;
                v22 = v22 - u4[v24];
            else
                if u3[v24] > v22 then
                    break;
                end;
                v22 = v22 - u3[v24];
            end;
            v24 = v24 + 1;
            if #u2 < v24 then
                v23 = v23 + 1;
                v24 = 1;
            end;
        end;
        local v25 = { v23 };
        local v26, v27 = l__modf__1(v22);
        local v28 = {};
        if p15 or p15 == nil then
            v28[#v28 + 1] = u13(v27, p16 or p16 == nil);
        end;
        if p17 or p17 == nil then
            v28[#v28 + 1] = u1[l__floor__2(p14 / 86400 + 3) % 7 + 1];
        end;
        if p18 or p18 == nil then
            v28[#v28 + 1] = u2[v24];
        end;
        if p19 or p19 == nil then
            local v29 = #v28 + 1;
            local v30 = v26 + 1;
            local v31 = v30 % 10;
            local v32 = v30 % 100;
            local v33;
            if v31 == 1 and v32 ~= 11 then
                v33 = v30 .. "st";
            elseif v31 == 2 and v32 ~= 12 then
                v33 = v30 .. "nd";
            elseif v31 == 3 and v32 ~= 13 then
                v33 = v30 .. "rd";
            else
                v33 = v30 .. "th";
            end;
            v28[v29] = v33;
        end;
        if p20 or p20 == nil then
            v28[#v28 + 1] = v23;
        end;
        return l__concat__3(v28, " "), v25;
    end,
    FromDate = function(p34, p35, p36) --[[ Name: FromDate, Line 85 ]]
        -- upvalues: l__floor__2 (copy), u4 (copy), u3 (copy)
        local v37 = l__floor__2(p34 / 400);
        local v38 = v37 * 12622780800 - 62167219200;
        local v39 = p35 or 1;
        local v40 = p36 or 1;
        for v41 = v37 * 400, p34 - 1 do
            if v41 % 400 == 0 or v41 % 100 ~= 0 and v41 % 4 == 0 then
                v38 = v38 + 31622400;
            else
                v38 = v38 + 31536000;
            end;
        end;
        if p34 % 400 == 0 or p34 % 100 ~= 0 and p34 % 4 == 0 then
            for v42 = 1, v39 - 1 do
                v38 = v38 + u4[v42] * 86400;
            end;
        else
            for v43 = 1, v39 - 1 do
                v38 = v38 + u3[v43] * 86400;
            end;
        end;
        return v38 + (v40 - 1) * 86400;
    end,
    WeekDay = function(p44) --[[ Name: wkday, Line 41 ]]
        -- upvalues: u1 (copy), l__floor__2 (copy)
        return u1[l__floor__2(p44 / 86400 + 3) % 7 + 1];
    end
};
