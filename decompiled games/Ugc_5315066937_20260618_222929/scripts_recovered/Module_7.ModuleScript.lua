-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("LabelPrint");
local v2 = l__obtain__1("Class");
local u3 = l__obtain__1("Timers");
local v4 = l__obtain__1("StateCalculus");
local v5 = v2();
v4({
    "Started",
    "InProgress",
    "Finished",
    "Valid",
    "FlagTime",
    "FlagReason"
}):Simple(v5);
function v5.Constructor(p6, p7, p8) --[[ Line: 14 ]]
    -- upvalues: u3 (copy)
    local v9 = u3(p8);
    v9:SetScale(p7, 0);
    v9:SetTime(p7, 0);
    p6.Timer = v9;
    p6.Valid = true;
    p6.Created = p7;
    p6.Started = false;
    p6.InProgress = false;
    p6.Finished = false;
    p6.States = {};
end;
function v5.Clear(p10, p11) --[[ Line: 27 ]]
    p10.Timer:SetScale(p11, 0);
end;
function v5.Start(p12, p13) --[[ Line: 32 ]]
    -- upvalues: u1 (copy)
    if p12.Started then
        if p12.RunStartedPrinted then
        else
            p12.RunStartedPrinted = true;
            u1("Attempt to RunStart a started run Player=", p12.Player);
        end;
    else
        p12.Started = p13;
        p12.InProgress = true;
        p12.Timer:SetScale(p13, 1);
        return true;
    end;
end;
function v5.Finish(p14, p15) --[[ Line: 46 ]]
    -- upvalues: u1 (copy)
    if p14.Finished then
        if p14.RunFinishPrinted then
        else
            p14.RunFinishPrinted = true;
            u1("Attempt to RunFinish a finished run Player=", p14.Player);
        end;
    else
        p14.Finished = p15;
        p14.InProgress = false;
        p14.Timer:SetScale(p15, 0);
        return true;
    end;
end;
function v5.Flag(p16, p17, p18) --[[ Line: 60 ]]
    p16.Valid = false;
    if not p16.FlagReason then
        p16.FlagTime = p17;
        p16.FlagReason = p18;
    end;
end;
return v5;
