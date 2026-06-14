-- Decompiled from: ReplicatedStorage.Modules.Mince.MicroID
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    benchsize = 1000000,
    range = { 33, 126 },
    r = Random.new()
};
function u1.factor() --[[ Line: 7 ]]
    -- upvalues: u1 (copy)
    local v2 = os.time() + os.clock();
    for _ = 1, u1.benchsize do

    end;
    local v3 = os.time() + os.clock();
    u1.r = Random.new((v2 + (v3 - v2)) * 10000);
end;
function u1.gent(p4) --[[ Line: 16 ]]
    -- upvalues: u1 (copy)
    local v5 = os.time() % 1000000 * 1000000 + os.clock() * 10000000;
    local v6 = math.floor(v5);
    local v7 = u1.range[2] - u1.range[1];
    local v8 = p4 or 16;
    local v9 = "";
    while true do
        v6 = math.floor(v6 / v7);
        if v6 ~= 0 then
            v9 = v9 .. string.char(u1.range[1] + (v6 % v7 + 1) + 1);
        end;
        if v6 == 0 then
            for _ = 1, v8 do
                v9 = string.char(u1.r:NextInteger(u1.range[1], u1.range[2])) .. v9;
            end;
            return v9;
        end;
    end;
end;
function u1.gen(p10) --[[ Line: 32 ]]
    -- upvalues: u1 (copy)
    local v11 = "";
    for _ = 1, p10 or 16 do
        v11 = v11 .. string.char(u1.r:NextInteger(u1.range[1], u1.range[2]));
    end;
    return v11;
end;
task.defer(u1.factor);
return u1;
