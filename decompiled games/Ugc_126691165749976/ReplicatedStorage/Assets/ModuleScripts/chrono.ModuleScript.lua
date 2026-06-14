-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono
-- Class: ModuleScript
-- Place: Ugc (126691165749976)

-- Decompiled with Potassium's decompiler.

local u1 = game:GetService("RunService"):IsServer();
local l__Config__1 = require(script.Shared.Config);
game:GetService("HttpService");
local l__Stats__2 = require(script.Shared.Stats);
local l__Player__3 = require(script.Server.Player);
local l__Receiver__4 = require(script.Server.Receiver);
local l__ServerClock__5 = require(script.Server.ServerClock);
local l__Entity__6 = require(script.Shared.Entity);
local l__Events__7 = require(script.Shared.Events);
local l__Holder__8 = require(script.Shared.Holder);
local l__ReplicationRules__9 = require(script.Shared.ReplicationRules);
local l__Snapshots__10 = require(script.Shared.Snapshots);
require(script.Shared.Types);
local u2 = false;
return {
    Start = function(p3) --[[ Name: Start, Line 36 ]]
        -- upvalues: u2 (ref), u1 (copy), l__Config__1 (copy)
        if u2 then
            warn("Chrono: Already Started. Ignoring subsequent calls.");
        else
            u2 = true;
            if p3 then
                require(p3);
            end;
            if u1 then
                require(script.Server.Replicate);
            else
                require(script.Client.Replicate);
            end;
            l__Config__1._Lock();
            l__Config__1._GetConfig("__VERSION");
        end;
    end,
    Holder = l__Holder__8,
    Entity = l__Entity__6,
    Stats = l__Stats__2,
    Config = l__Config__1,
    ReplicationRules = l__ReplicationRules__9,
    Events = l__Events__7,
    Snapshots = l__Snapshots__10,
    ServerClock = l__ServerClock__5,
    Player = l__Player__3,
    ServerReceiver = l__Receiver__4,
    GetCameraLookVector = l__Receiver__4.GetCameraLookVector
};
