-- Decompiled from: ReplicatedStorage.Modules.FastCastRedux.Table
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = Random.new();
local u2 = table;
local u3 = {};
function u3.contains(p4, p5) --[[ Line: 27 ]]
    -- upvalues: u3 (copy)
    return u3.indexOf(p4, p5) ~= nil;
end;
function u3.indexOf(p6, p7) --[[ Line: 32 ]]
    -- upvalues: u3 (copy)
    return table.find(p6, p7) or u3.keyOf(p6, p7);
end;
function u3.keyOf(p8, p9) --[[ Line: 41 ]]
    for v10, v11 in pairs(p8) do
        if v11 == p9 then
            return v10;
        end;
    end;
    return nil;
end;
function u3.insertAndGetIndexOf(p12, p13) --[[ Line: 51 ]]
    p12[#p12 + 1] = p13;
    return #p12;
end;
function u3.skip(p14, p15) --[[ Line: 57 ]]
    return table.move(p14, p15 + 1, #p14, 1, table.create(#p14 - p15));
end;
function u3.take(p16, p17) --[[ Line: 62 ]]
    return table.move(p16, 1, p17, 1, table.create(p17));
end;
function u3.range(p18, p19, p20) --[[ Line: 67 ]]
    return table.move(p18, p19, p20, 1, table.create(p20 - p19 + 1));
end;
function u3.skipAndTake(p21, p22, p23) --[[ Line: 72 ]]
    return table.move(p21, p22 + 1, p22 + p23, 1, table.create(p23));
end;
function u3.random(p24) --[[ Line: 77 ]]
    -- upvalues: u1 (copy)
    return p24[u1:NextInteger(1, #p24)];
end;
function u3.join(p25, p26) --[[ Line: 82 ]]
    local v27 = table.create(#p25 + #p26);
    table.move(p25, 1, #p25, 1, v27);
    return table.move(p26, 1, #p26, #p25 + 1, v27);
end;
function u3.removeObject(p28, p29) --[[ Line: 89 ]]
    -- upvalues: u3 (copy)
    local v30 = u3.indexOf(p28, p29);
    if v30 then
        table.remove(p28, v30);
    end;
end;
return setmetatable({}, {
    __index = function(_, p31) --[[ Name: __index, Line 97 ]]
        -- upvalues: u3 (copy), u2 (copy)
        if u3[p31] == nil then
            return u2[p31];
        else
            return u3[p31];
        end;
    end,
    __newindex = function(_, _, _) --[[ Name: __newindex, Line 105 ]]
        error("Add new table entries by editing the Module itself.");
    end
});
