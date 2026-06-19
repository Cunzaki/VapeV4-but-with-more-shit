-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__time__1 = os.time;
local l__gsub__2 = string.gsub;
local l__format__3 = string.format;
local u1 = {
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
local u2 = {
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
local u3 = {
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
};
local u4 = {
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
};
local u5 = {
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
local u6 = {
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sept",
    "Oct",
    "Nov",
    "Dec"
};
local function u13(p7) --[[ Line: 35 ]]
    local v8 = p7 % 3600;
    local v9 = (p7 - v8) / 3600;
    local v10 = v8 % 60;
    local v11 = (v8 - v10) / 60;
    local v12 = v10 % 1;
    return v9, v11, v10 - v12, 1000 * v12;
end;
local function u21(p14, p15) --[[ Line: 46 ]]
    -- upvalues: u13 (copy)
    local v16 = p15 % 86400;
    local v17 = (p15 - v16) / 86400;
    local v18 = 0;
    for v19 = 1, 12 do
        local v20 = p14[v19];
        if v17 < v18 + v20 then
            return v19, v17 - v18 + 1, u13(v16);
        end;
        v18 = v18 + v20;
    end;
end;
local function u34(p22) --[[ Line: 61 ]]
    -- upvalues: l__time__1 (copy), u21 (copy), u1 (copy), u2 (copy)
    local v23 = (p22 or l__time__1()) - -62135596800;
    local v24 = v23 % 12622780800;
    local v25 = 0 + (v23 - v24) / 12622780800 * 400;
    if v24 < 12591158400 then
        local v26 = v24 % 3155673600;
        local v27 = v25 + (v24 - v26) / 3155673600 * 100;
        if v26 < 3124137600 then
            local v28 = v26 % 126230400;
            local v29 = v27 + (v26 - v28) / 126230400 * 4;
            if v28 < 94608000 then
                local v30 = v28 % 31536000;
                return v29 + (v28 - v30) / 31536000 * 1 + 1, v30, u21(u1, v30);
            else
                local v31 = v28 - 94608000;
                return v29 + 3 + 1, v31, u21(u2, v31);
            end;
        else
            local v32 = v26 - 3124137600;
            return v27 + 99 + 1, v32, u21(u1, v32);
        end;
    else
        local v33 = v24 - 12591158400;
        return v25 + 399 + 1, v33, u21(u2, v33);
    end;
end;
return function(p35, p36) --[[ Name: date, Line 94 ]]
    -- upvalues: l__time__1 (copy), u34 (copy), l__format__3 (copy), l__gsub__2 (copy), u4 (copy), u3 (copy), u6 (copy), u5 (copy)
    local v37 = p36 or l__time__1();
    local u38, v39, u40, u41, u42, u43, u44, u45 = u34(v37);
    local u46 = ((v37 - v37 % 86400) / 86400 + 3) % 7 + 1;
    if p35 then
        return p35 == "*t" and {
            year = u38,
            month = u40,
            day = u41,
            yday = v39,
            wday = v39,
            hour = u42,
            minute = u43,
            second = u44,
            millisecond = u45
        } or l__gsub__2(p35, "%%(.)", function(p47) --[[ Line: 113 ]]
            -- upvalues: u4 (ref), u46 (copy), u3 (ref), u6 (ref), u40 (copy), u5 (ref), l__format__3 (ref), u41 (copy), u38 (copy), u42 (copy), u43 (copy), u44 (copy), u45 (copy)
            if p47 == "a" then
                return u4[u46];
            elseif p47 == "A" then
                return u3[u46];
            elseif p47 == "b" then
                return u6[u40];
            elseif p47 == "B" then
                return u5[u40];
            elseif p47 == "c" then
                return l__format__3("%02d/%02d/%04d %02d:%02d:%02d", u40, u41, u38, u42, u43, u44);
            elseif p47 == "d" then
                return u41;
            elseif p47 == "H" then
                return u42;
            elseif p47 == "I" then
                return (u42 - 1) % 12 + 1;
            elseif p47 == "M" then
                return u43;
            elseif p47 == "m" then
                return u40;
            elseif p47 == "p" then
                return u42 < 12 and "am" or "pm";
            elseif p47 == "S" then
                return u44;
            elseif p47 == "s" then
                return u45;
            elseif p47 == "w" then
                return u46;
            elseif p47 == "x" then
                return l__format__3("%02d/%02d/%04d", u40, u41, u38);
            elseif p47 == "X" then
                return l__format__3("%02d:%02d:%02d", u42, u43, u44);
            elseif p47 == "Y" then
                return u38;
            else
                return p47 ~= "y" and (p47 == "%" and "%" or "") or u38 % 100;
            end;
        end);
    else
        return l__format__3("%02d/%02d/%04d %02d:%02d:%02d", u40, u41, u38, u42, u43, u44);
    end;
end;
