-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local v1 = _G.obtain("Class");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local v2 = v1();
function v2.Send(p3, ...) --[[ Line: 7 ]]
    p3.RemoteEvent:FireServer(...);
end;
function v2.Listen(p4, p5) --[[ Line: 10 ]]
    local v6 = p4.RemoteEvent.OnClientEvent:connect(p5);
    p4.Listeners[p5] = v6;
    return v6;
end;
function v2.StopListening(p7, p8) --[[ Line: 15 ]]
    local v9 = p7.Listeners[p8];
    if v9 then
        p7.Listeners[p8] = nil;
        v9:disconnect();
    else
        print("[NetworkChannel] Was not listening");
    end;
end;
function v2.Constructor(p10, p11) --[[ Line: 24 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy)
    local v12 = l__ReplicatedStorage__1:WaitForChild(p11);
    v12.Name = p11;
    p10.RemoteEvent = v12;
    p10.Listeners = {};
end;
return v2;
