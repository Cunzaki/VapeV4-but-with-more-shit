-- Decompiled from: ReplicatedStorage.Client.Class.UserProfile
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
require(l__ReplicatedStorage__1.Modules.LoadingPoint);
local l__Signal__2 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__LTCS__4 = require(l__ReplicatedStorage__1.Modules.LTCS);
local u1 = {
    RemoteEvent = l__Mince__3:GetEvent("StatUpdate"),
    PartialRemote = l__Mince__3:GetEvent("PartialStatUpdate"),
    Listeners = {}
};
function u1.RequestUpdate(p2) --[[ Line: 32 ]]
    -- upvalues: u1 (copy)
    u1.RemoteEvent:Fire(p2);
end;
function u1.RecievePartialUpdate(p3, p4) --[[ Line: 36 ]]
    -- upvalues: l__LTCS__4 (copy), l__Mince__3 (copy), u1 (copy)
    if p4 then
        p3 = l__LTCS__4.Decode(p3);
    end;
    for v5, v6 in p3 do
        if not l__Mince__3.Config.LocalProfile[v5] then
            l__Mince__3.Config.LocalProfile[v5] = {};
        end;
        for v7, v8 in v6 do
            l__Mince__3.Config.LocalProfile[v5][v7] = v8;
        end;
    end;
    for v9, _ in p3 do
        local v10 = u1.Listeners[v9];
        if v10 and v10.Index == v9 then
            v10.Event:Fire(l__Mince__3.Config.LocalProfile[v9]);
        end;
    end;
end;
function u1.RecieveUpdate(p11) --[[ Line: 58 ]]
    -- upvalues: l__Mince__3 (copy), u1 (copy)
    l__Mince__3.Config.HasRecievedAnUpdate = true;
    for v12, v13 in p11 do
        l__Mince__3.Config.LocalProfile[v12] = v13;
    end;
    for v14, v15 in p11 do
        local v16 = u1.Listeners[v14];
        if v16 and v16.Index == v14 then
            v16.Event:Fire(v15);
        end;
    end;
end;
function u1.IndexUpdated(p17) --[[ Line: 74 ]]
    -- upvalues: u1 (copy), l__Signal__2 (copy)
    local v18 = u1.Listeners[p17];
    if v18 then
        return v18.Event;
    end;
    local v19 = l__Signal__2.new();
    u1.Listeners[p17] = {
        Index = p17,
        Event = v19
    };
    return v19;
end;
function u1.Upon(p20, p21) --[[ Line: 87 ]]
    -- upvalues: u1 (copy)
    if u1.HasRecievedAnUpdate and u1.LocalProfile[p20] then
        p21(u1.LocalProfile[p20]);
    end;
    u1.IndexUpdated(p20):Connect(p21);
end;
function u1.WaitUntilLoaded(_) --[[ Line: 95 ]]
    -- upvalues: l__Mince__3 (copy)
    repeat
        task.wait();
    until l__Mince__3.Config.HasRecievedAnUpdate;
end;
function u1.IsLoaded(_) --[[ Line: 99 ]]
    -- upvalues: l__Mince__3 (copy)
    return l__Mince__3.Config.HasRecievedAnUpdate;
end;
function u1.Init() --[[ Line: 103 ]]
    -- upvalues: l__Mince__3 (copy), u1 (copy)
    l__Mince__3.Config.LocalProfile = {};
    u1.RemoteEvent:Fire();
    u1.RemoteEvent.Event:Connect(u1.RecieveUpdate);
    u1.PartialRemote.Event:Connect(u1.RecievePartialUpdate);
end;
u1.Init();
return u1;
