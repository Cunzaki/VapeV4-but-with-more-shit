-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__floor__1 = math.floor;
local u1 = {
    "New",
    "Newb",
    "Bad",
    "Okay",
    "Not Bad",
    "Decent",
    "Getting There",
    "Advanced",
    "Good",
    "Great",
    "Superb",
    "Amazing",
    "Sick",
    "Master",
    "Insane",
    "Majestic",
    "Baby Jesus",
    "Jesus",
    "Half God",
    "God"
};
return function(p2, p3) --[[ Name: GetRankName, Line 10 ]]
    -- upvalues: u1 (copy), l__floor__1 (copy)
    local v4 = (#u1 - 1) * (1 - p2);
    local v5 = l__floor__1(v4) + 1;
    local v6 = u1[v5];
    if v6 then
        if p3 then
            return v6 .. " (" .. v5 .. ")", v4 % 1;
        else
            return v6;
        end;
    else
        if p2 > 1 then
            return p3 and "Winner (???)" or "Winner", 1;
        end;
    end;
end;
