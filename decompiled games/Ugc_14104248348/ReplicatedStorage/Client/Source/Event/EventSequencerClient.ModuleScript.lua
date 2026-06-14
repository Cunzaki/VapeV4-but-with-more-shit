-- Decompiled from: ReplicatedStorage.Client.Source.Event.EventSequencerClient
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:GetState("EventState");
local u2 = {
    __IsAsyncSetup = true,
    DateConfiguration = {},
    EventModuleName = l__Mince__3.Config.HolidayConfigure.EVENT_MODULE
};
function u2.LoadSequenceEvents(p3) --[[ Line: 14 ]]
    -- upvalues: u2 (copy)
    u2.MemoryNumberLookup = {
        Ranges = {}
    };
    local v4 = typeof(p3) == "table";
    assert(v4, "SequenceArray must contain SequenceEvents, {table} see type. ^^^");
    for _, v5 in ipairs(p3) do
        local v6 = typeof(v5) == "table";
        assert(v6, "must be table");
        local v7 = type(v5.EventCallbackFn) == "function";
        assert(v7, "...");
        if type(v5.EventSeconds) == "number" then
            u2.MemoryNumberLookup[v5.EventSeconds] = v5.EventCallbackFn;
        elseif type(v5.EventSeconds) == "table" then
            v5.EventSeconds[1] = v5.EventSeconds[1] or 0;
            v5.EventSeconds[2] = v5.EventSeconds[2] or 0;
            table.insert(u2.MemoryNumberLookup.Ranges, {
                v5.EventSeconds[1],
                v5.EventSeconds[2],
                EventCallbackFn = v5.EventCallbackFn
            });
        end;
    end;
    table.sort(u2.MemoryNumberLookup.Ranges, function(p8, p9) --[[ Line: 40 ]]
        if p8[2] > p9[2] then
            return true;
        elseif p8[2] < p9[2] then
            return false;
        else
            return p8[1] > p9[1];
        end;
    end);
    warn(u2.MemoryNumberLookup);
end;
function u2.Heartbeat(_) --[[ Line: 53 ]]
    -- upvalues: u2 (copy)
    local v10 = game.Workspace:GetServerTimeNow();
    local v11 = math.floor(v10);
    local v12 = u2.DateConfiguration.EventDate - v11;
    if u2.LatestTimelineEvent and u2.DateConfiguration.EventDate == 0 then
        v12 = v11 % (u2.LatestTimelineEvent + 1);
    end;
    local _ = v12 < 0;
    if v12 < 0 and not u2.EventIsOver then
        u2.EventIsOver = true;
        if u2.EventModule and u2.EventModule.EndEvent then
            u2.EventModule.EndEvent();
        end;
    end;
    if v12 ~= u2.LastRecordedTimeDifference then
        local v13 = u2.LastRecordedTimeDifference or v12 - 1;
        if v13 then
            for v14 = v13 - 1, v12 do
                u2.HandleSecondUpdate(v14);
            end;
        else
            u2.HandleSecondUpdate(v12);
        end;
        u2.LastRecordedTimeDifference = v12;
    end;
end;
function u2.HandleSecondUpdate(p15) --[[ Line: 85 ]]
    -- upvalues: u2 (copy)
    local v16 = u2.MemoryNumberLookup[p15];
    if v16 then
        u2.Call(v16, p15);
    end;
    if u2.MemoryNumberLookup and #u2.MemoryNumberLookup.Ranges > 0 then
        for _, v17 in ipairs(u2.MemoryNumberLookup.Ranges) do
            if v17[1] <= p15 and p15 <= v17[2] then
                u2.Call(v17.EventCallbackFn, p15);
            end;
        end;
    end;
end;
function u2.Call(u18, u19) --[[ Line: 101 ]]
    -- upvalues: u2 (copy)
    local v20, v21 = pcall(function() --[[ Line: 102 ]]
        -- upvalues: u18 (copy), u19 (copy), u2 (ref)
        return u18(u19, u2);
    end);
    if not v20 then
        warn((`Failure on EventSequencer second : {u19}!`));
        warn(v21);
    end;
end;
function u2.Setup() --[[ Line: 112 ]]
    -- upvalues: u1 (copy), u2 (copy), l__RunService__2 (copy)
    if not u1.EventDate then
        u1("Get"):GetAttributeChangedSignal("EventDate"):Wait();
    end;
    u2.DateConfiguration.EventDate = u1.EventDate;
    if u2.EventModuleName and script.Parent:FindFirstChild(u2.EventModuleName) then
        u2.EventModule = require(script.Parent[u2.EventModuleName]);
        u2.EventPointing = setmetatable(u2.EventModule, {
            __index = u2
        });
        if u2.EventModule.When then
            for u22, u23 in u2.EventModule.When do
                local function v24() --[[ Line: 126 ]]
                    -- upvalues: u23 (copy), u2 (ref), u1 (ref), u22 (copy)
                    u23(u2.EventPointing, u1[u22]);
                end;
                u1("IndexChanged", u22):Connect(v24);
                if u1[u22] then
                    u23(u2.EventPointing, u1[u22]);
                end;
            end;
        end;
        if u2.EventModule.Timeline then
            local v25 = {};
            for _, v26 in u2.EventModule.Timeline do
                local u27, v28 = table.unpack(v26);
                table.insert(v25, {
                    EventSeconds = v28,
                    EventCallbackFn = function(u29) --[[ Name: EventCallbackFn, Line 144 ]]
                        -- upvalues: u2 (ref), u27 (copy)
                        task.spawn(function() --[[ Line: 145 ]]
                            -- upvalues: u2 (ref), u27 (ref), u29 (copy)
                            u2.EventModule[u27](u2.EventPointing, u29);
                        end);
                    end
                });
            end;
            u2.LoadSequenceEvents(v25);
            u2.LatestTimelineEvent = 0;
        end;
    end;
    l__RunService__2.Heartbeat:Connect(u2.Heartbeat);
end;
return u2;
