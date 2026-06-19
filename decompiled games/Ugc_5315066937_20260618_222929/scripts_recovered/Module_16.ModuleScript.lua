-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("Class");
local u2 = l__obtain__1("MulticallObjectMethod");
local v3 = v1();
function v3.SetActive(p4, p5, p6) --[[ Line: 11 ]]
    if p6 then
        p4.Active[p5] = true;
    else
        p4.Active[p5] = nil;
    end;
end;
function v3.SetQueued(p7, p8, p9) --[[ Line: 18 ]]
    if p9 then
        p7.Queued[p8] = true;
    else
        p7.Queued[p8] = nil;
    end;
end;
function v3.Flush(p10) --[[ Line: 26 ]]
    for v11 in p10.Queued do
        v11:Flush();
    end;
end;
function v3.Run(p12, p13) --[[ Line: 32 ]]
    for v14 in p12.Active do
        v14:AdvanceToTime(p13);
    end;
    p12:Flush();
end;
function v3.Advance(p15) --[[ Line: 40 ]]
    for v16 in p15.Active do
        v16:AdvanceToLast();
    end;
    p15:Flush();
end;
function v3.Soonest(p17) --[[ Line: 47 ]]
    local v18 = (1 / 0);
    local v19 = nil;
    for v20 in p17.Active do
        local v21 = v20.Queued:After();
        if v21 and v21[1] < v18 then
            v18 = v21[1];
            v19 = v20;
        end;
    end;
    if v19 then
        return v19, v18;
    end;
end;
function v3.Constructor(p22) --[[ Line: 62 ]]
    -- upvalues: u2 (copy)
    p22.Multicall = u2();
    p22.Active = {};
    p22.Queued = {};
end;
return v3;
