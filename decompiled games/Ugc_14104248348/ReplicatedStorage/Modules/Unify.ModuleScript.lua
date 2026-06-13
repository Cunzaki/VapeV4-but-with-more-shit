-- Decompiled from: ReplicatedStorage.Modules.Unify
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    UnitTable = {
        years = 31556926,
        months = 2629744,
        weeks = 604800,
        Days = 86400,
        hours = 3600,
        minutes = 60,
        seconds = 1,
        y = 31556926,
        mon = 2629744,
        w = 604800,
        d = 86400,
        h = 3600,
        m = 60,
        s = 1
    }
};
function u1.GetStandardTimeFrom(p2) --[[ Line: 25 ]]
    -- upvalues: u1 (copy)
    return u1.GetStandardTime() - p2;
end;
function u1.GetStandardTimeUntil(p3) --[[ Line: 28 ]]
    -- upvalues: u1 (copy)
    return p3 - u1.GetStandardTime();
end;
function u1.GetStandardTimeIn(p4) --[[ Line: 31 ]]
    -- upvalues: u1 (copy)
    return u1.GetStandardTime() + p4;
end;
function u1.GetStandardTime() --[[ Line: 34 ]]
    return os.time(os.date("!*t"));
end;
function u1.GetServerTimeFrom(p5) --[[ Line: 39 ]]
    -- upvalues: u1 (copy)
    return u1.GetServerTime() - p5;
end;
function u1.GetServerTimeUntil(p6) --[[ Line: 42 ]]
    -- upvalues: u1 (copy)
    return p6 - u1.GetServerTime();
end;
function u1.GetServerTimeIn(p7) --[[ Line: 45 ]]
    -- upvalues: u1 (copy)
    return u1.GetServerTime() + p7;
end;
function u1.GetServerTime() --[[ Line: 48 ]]
    return workspace:GetServerTimeNow();
end;
function u1.ParseTimeString(p8) --[[ Line: 52 ]]
    -- upvalues: u1 (copy)
    local v9 = 0;
    for v10 in p8:gmatch("(%d+%a+)") do
        local v11, v12 = v10:match("(%d+)(%a+)");
        if not (v11 and v12) then
            error("Invalid unit format: " .. v10);
        end;
        local v13 = u1.UnitTable[v12:lower()];
        if not v13 then
            error("Unsupported unit: " .. v12);
        end;
        v9 = v9 + tonumber(v11) * v13;
    end;
    return v9;
end;
function u1.ShortenedClockTime(p14, p15) --[[ Line: 73 ]]
    local v16 = { math.floor(p14 / 3600), math.floor(p14 % 3600 / 60), (math.floor(p14 % 60)) };
    local v17 = p15 or 2;
    local v18 = "";
    for v19, v20 in ipairs(v16) do
        if v19 < v17 then
            if v20 > 0 then
                v18 = v18 .. string.format("%.2d", v20) .. ":";
            end;
        else
            v18 = v18 .. string.format("%.2d", v20);
            if v19 % 2 == 0 then
                v18 = v18 .. ":";
            end;
        end;
    end;
    return v18;
end;
function u1.ClockTime(p21) --[[ Line: 96 ]]
    return string.gsub("0Hours:0Minutes:0Seconds", "%a+", {
        Hours = math.floor(p21 / 3600),
        Minutes = math.floor(p21 % 3600 / 60),
        Seconds = math.floor(p21 % 60)
    }):gsub("%d%d%d", function(p22) --[[ Line: 101 ]]
        return p22:sub(2, 3);
    end);
end;
function u1.AbbreviatedTime(p23) --[[ Line: 106 ]]
    local v24 = math.floor(p23 / 3600);
    local v25 = math.floor(p23 % 3600 / 60);
    local v26 = math.floor(p23 % 60);
    return string.gsub("h m s", "%a+", {
        h = v24 <= 0 and "" or tostring(v24) .. "h",
        m = v24 <= 0 and v25 <= 0 and "" or tostring(v25) .. "m",
        s = tostring(v26) .. "s"
    }):gsub("^%s*(.-)%s*$", "%1");
end;
return u1;
