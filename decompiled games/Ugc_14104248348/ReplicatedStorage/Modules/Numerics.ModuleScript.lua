-- Decompiled from: ReplicatedStorage.Modules.Numerics
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = utf8.char(8734);
local u3 = {
    "k",
    "M",
    "B",
    "T",
    "P",
    "E",
    "Z",
    "Y"
};
function u1.FormatPercentage(p4) --[[ Line: 48 ]]
    return string.format("%3.2f", p4 * 100) .. "%";
end;
function u1.Round(p5, p6) --[[ Line: 55 ]]
    local v7 = p6 or 0;
    local v8 = 10 ^ v7;
    if v7 == 0 then
        return math.round(p5);
    else
        return math.round(p5 * v8) / v8;
    end;
end;
function u1.TruncateNumber(p9, p10) --[[ Line: 67 ]]
    -- upvalues: u2 (copy), u1 (copy), u3 (copy)
    if p9 == (1 / 0) then
        return u2;
    end;
    local v11 = p10 or 1;
    local v12 = 3;
    local v13 = p9 / 10 ^ v12;
    if v13 < 1 then
        local v14 = u1.Round(v13 * 1000, v11);
        return tostring(v14);
    end;
    local v15 = 0;
    while v13 >= 1 do
        local _ = math.floor(v15 / #u3) + 1;
        v12 = v12 + 3;
        v15 = v15 + 1;
        v13 = p9 / 10 ^ v12;
    end;
    local v16 = u1.Round(v13 * 1000, v11);
    local v17 = "";
    repeat
        local v18 = math.clamp(v15, 1, 8);
        v17 = ((v18 <= 0 or v18 > #u3) and "*" or u3[v18]) .. v17;
        v15 = v15 - #u3;
    until v15 <= 0;
    return tostring(v16) .. v17;
end;
function u1.Clamp01(p19) --[[ Line: 109 ]]
    return math.clamp(p19, 0, 1);
end;
function u1.Lerp(p20, p21, p22) --[[ Line: 114 ]]
    return (p21 - p20) * p22 + p20;
end;
function u1.Map(p23, p24, p25, p26, p27) --[[ Line: 119 ]]
    return (p23 - p24) * (p27 - p26) / (p25 - p24) + p26;
end;
function u1.Map01(p28, p29, p30) --[[ Line: 124 ]]
    return (p28 - p29) / p30;
end;
function u1.WithCommas(p31, p32) --[[ Line: 129 ]]
    local v33 = math.abs(p31);
    local v34 = math.floor(v33);
    local v35 = tostring(v34);
    local v36 = p31 - math.floor(p31);
    local v37 = tostring(v36);
    local v38 = "";
    local v39 = 0;
    local v40 = p32 and "." or ",";
    local v41 = p32 and "," or ".";
    for v42 = #v35, 1, -1 do
        v38 = v35:sub(v42, v42) .. v38;
        v39 = v39 + 1;
        if v39 == 3 and v42 ~= 1 then
            v38 = v40 .. v38;
            v39 = 0;
        end;
    end;
    if v37 ~= "0" and #v37 > 2 then
        v38 = v38 .. v41 .. v37:sub(3);
    end;
    if math.sign(p31) == -1 then
        v38 = "-" .. v38;
    end;
    return v38;
end;
function u1.SecondsToClock(p43, p44) --[[ Line: 159 ]]
    if p43 <= 0 then
        warn("Something called SecondsToClock with negative time!");
        p43 = math.abs(p43);
    end;
    local v45 = string.format("%02.f", (math.floor(p43 / 3600)));
    local v46 = string.format("%02.f", (math.floor(p43 / 60 - v45 * 60)));
    local v47 = string.format("%02.f", (math.floor(p43 - v45 * 3600 - v46 * 60)));
    if p44 then
        return string.format("%02.f", (math.floor(p43 / 60))) .. ":" .. v47;
    else
        return v45 .. ":" .. v46 .. ":" .. v47;
    end;
end;
return u1;
