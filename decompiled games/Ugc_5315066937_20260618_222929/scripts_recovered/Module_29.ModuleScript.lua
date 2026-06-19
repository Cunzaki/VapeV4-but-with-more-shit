-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("TimerSynchronization");
local v2 = {
    Buffer = 0.5,
    Channel = l__obtain__1("NetworkChannel")("TimelineEvents"),
    AdvanceLimit = 32,
    SampleCleared = v1.SampleCleared,
    SubmitSample = v1.SubmitSample,
    ReplicationTargetEnums = {
        REPLICATION_TARGET_ALL = 1,
        REPLICATION_TARGET_OTHER = 2
    }
};
local u3 = {};
v2.ExternalHandlers = u3;
function v2.SetHandler(p4, p5) --[[ Line: 19 ]]
    -- upvalues: u3 (copy)
    u3[p4] = p5;
end;
return v2;
