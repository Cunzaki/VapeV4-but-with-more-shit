-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = tick;
local _ = type;
local u2 = error;
local u3 = tostring;
local l__clear__1 = table.clear;
local v4 = _G.obtain("serializer");
local l__serialize__2 = v4.serialize;
local l__deserialize__3 = v4.deserialize;
local v5 = game:GetService("ReplicatedStorage"):GetChildren();
local u6 = nil;
local u7 = nil;
for v8 = 1, #v5 do
    local v9 = v5[v8];
    if v9.Name == "RemoteCall" and v9.ClassName == "RemoteEvent" then
        u6 = v9;
    end;
    if v9.Name == "RemoteFetch" and v9.ClassName == "RemoteFunction" then
        u7 = v9;
    end;
end;
local u10 = {};
local u11 = {};
local u12 = false;
local u13 = {};
local function v15(p14) --[[ Line: 37 ]]
    -- upvalues: u12 (ref), u13 (copy)
    if u12 then
        p14();
    else
        u13[#u13 + 1] = p14;
    end;
end;
local l__spawn__4 = task.spawn;
local function u18(_, u16, ...) --[[ Line: 54 ]]
    -- upvalues: l__spawn__4 (copy)
    local u17 = { ... };
    l__spawn__4(function() --[[ Line: 56 ]]
        -- upvalues: u16 (copy), u17 (copy)
        u16(unpack(u17));
    end);
end;
u6.OnClientEvent:connect(function(...) --[[ Name: ReceiveCall, Line 62 ]]
    -- upvalues: l__deserialize__3 (copy), u11 (copy), u18 (copy), u3 (copy)
    local v19, v20 = ...;
    local v21 = l__deserialize__3(v19, v20);
    for v22 = 1, #v21 do
        local v23 = v21[v22];
        local v24 = v23[1];
        local v25 = v23[2];
        local v26 = u11[v24];
        if v26 then
            u18(v24, v26, unpack(v23, 3, v25));
        else
            print("[Remote] Attempt to call unregistered function \'" .. u3(v24) .. "\' with arguments: ", unpack(v23, 3, v25));
        end;
    end;
end);
function u7.OnClientInvoke(...) --[[ Line: 78 ]]
    -- upvalues: l__deserialize__3 (copy), u11 (copy), u3 (copy)
    local v27, v28 = ...;
    local v29 = l__deserialize__3(v27, v28);
    local v30 = v29[1];
    local v31 = v29[2];
    local v32 = u11[v30];
    if v32 then
        return v32(unpack(v29, 3, v31));
    end;
    print("[Remote] Attempt to call unregistered function \'" .. u3(v30) .. "\' with arguments: ", unpack(v29, 3, v31));
end;
local l__FireServer__5 = u6.FireServer;
local l__InvokeServer__6 = u7.InvokeServer;
local function u34(p33, ...) --[[ Line: 105 ]]
    -- upvalues: u10 (copy)
    u10[#u10 + 1] = { p33, 2 + select("#", ...), ... };
end;
return {
    InitLast = function() --[[ Name: Init, Line 115 ]]
        -- upvalues: u1 (copy), u10 (copy), l__serialize__2 (copy), l__FireServer__5 (copy), u6 (ref), l__clear__1 (copy), u12 (ref), u13 (copy)
        local u35 = u1() - 0.1;
        game:GetService("RunService").Stepped:connect(function() --[[ Line: 118 ]]
            -- upvalues: u1 (ref), u35 (ref), u10 (ref), l__serialize__2 (ref), l__FireServer__5 (ref), u6 (ref), l__clear__1 (ref)
            local v36 = u1();
            if v36 - u35 > 0.05 and #u10 > 0 then
                if v36 - u35 > 0.1 then
                    u35 = v36;
                else
                    u35 = u35 + 0.05;
                end;
                local v37, v38 = l__serialize__2(u10);
                l__FireServer__5(u6, v37, v38);
                l__clear__1(u10);
            end;
        end);
        u12 = true;
        for v39 = 1, #u13 do
            u13[v39]();
        end;
        l__clear__1(u13);
    end,
    Add = function(p40, p41) --[[ Name: Add, Line 97 ]]
        -- upvalues: u11 (copy), u2 (copy), u3 (copy)
        if u11[p40] then
            u2("[Remote] A function with the id \'" .. u3(p40) .. "\' already exists.");
        else
            u11[p40] = p41;
        end;
    end,
    Call = u34,
    GetCallFunction = function(u42) --[[ Name: GetCallFunction, Line 136 ]]
        -- upvalues: u34 (copy)
        return function(...) --[[ Line: 136 ]]
            -- upvalues: u34 (ref), u42 (copy)
            u34(u42, ...);
        end;
    end,
    Fetch = function(p43, ...) --[[ Name: Fetch, Line 109 ]]
        -- upvalues: l__serialize__2 (copy), l__InvokeServer__6 (copy), u7 (ref)
        local v44, v45 = l__serialize__2({ p43, 2 + select("#", ...), ... });
        return l__InvokeServer__6(u7, v44, v45);
    end,
    OnReady = v15
};
