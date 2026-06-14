-- Decompiled from: ReplicatedStorage.Client.Source.AnalyticsTracker
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Unify);
local l__Utility__3 = require(l__ReplicatedStorage__1.Modules.Utility);
local u1 = l__Mince__2:Get("InterfaceHandler");
local v2 = l__Mince__2:GetEvent("Analytics");
v2:Extend("ReportInterfaceTrakcing");
local u3 = v2:Extend("ReportTimeTrack");
local u8 = {
    TimeEntered = {},
    TimeOpened = {},
    TimeTrack = {
        InterfaceOpened = {},
        RegionEntered = {},
        MinigameEntered = {}
    },
    LocalMemoryRecords = {},
    CooldownRecords = {},
    CreateTimeTrack = function(u4) --[[ Name: CreateTimeTrack, Line 32 ]]
        -- upvalues: u3 (copy)
        u4.TimeActive = {};
        return function(p5, p6) --[[ Line: 35 ]]
            -- upvalues: u4 (copy), u3 (ref)
            if u4.TimeActive[p5] and not p6 then
                local v7 = os.clock() - u4.TimeActive[p5];
                u4.TimeActive[p5] = nil;
                u3:Fire(u4.Name, p5, v7);
            else
                if not u4.TimeActive[p5] then
                    u4.TimeActive[p5] = os.clock();
                end;
            end;
        end;
    end
};
function u8.TrackThisRecord(p9, p10) --[[ Line: 49 ]]
    -- upvalues: l__Utility__3 (copy), u8 (copy)
    assert(l__Utility__3.AssertTypes(p9, "string"));
    local v11 = nil;
    local v12 = nil;
    local v13 = u8.CooldownRecords[p9] or (u8.CooldownRecords[p10] or (p10 or 10));
    local v14 = u8.LocalMemoryRecords[p9];
    if not v14 then
        u8.LocalMemoryRecords[p9] = os.time() + v13;
        return true, v12;
    end;
    local v15 = v14 - os.time();
    if v15 < 0 then
        u8.LocalMemoryRecords[p9] = os.time() + v13;
        v11 = true;
    end;
    return v11, v15;
end;
function u8.Setup() --[[ Line: 70 ]]
    -- upvalues: u1 (copy), u8 (copy)
    u1.ScreenShown:Connect(function(...) --[[ Line: 71 ]]
        -- upvalues: u8 (ref)
        u8.InterfaceOpened(...);
    end);
    for v16, v17 in u8.TimeTrack do
        v17.Name = v16;
        u8[v16] = u8.CreateTimeTrack(v17);
    end;
end;
return u8;
