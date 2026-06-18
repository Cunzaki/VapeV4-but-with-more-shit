-- Decompiled from: Start.Client.Classes._x8c96abfd9981a439
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
local l__Signal__3 = require(l__ModuleScripts__1.Signal);
local l__Trove__4 = require(l__ModuleScripts__1.Trove);
local u1 = {};
u1.__index = u1;
local function u6(p2) --[[ Line: 11 ]]
    -- upvalues: u6 (copy)
    if type(p2) ~= "table" then
        return p2;
    end;
    local v3 = {};
    for v4, v5 in pairs(p2) do
        v3[v4] = u6(v5);
    end;
    return v3;
end;
function u1._x90d4581ac99dd483() --[[ Line: 24 ]]
    -- upvalues: u1 (copy), l__Trove__4 (copy), l__Signal__3 (copy)
    local v7 = setmetatable({}, u1);
    v7._xbd519c918208ce0e = l__Trove__4.new();
    v7._xb7c986f3188d5b5f = {};
    v7._x42e15310c9d8b835 = v7._xbd519c918208ce0e:Add(l__Signal__3.new());
    v7._xfd274174b9df963f = v7._xbd519c918208ce0e:Add(l__Signal__3.new());
    v7._xf88440d3e07bfe35 = v7._xbd519c918208ce0e:Add(l__Signal__3.new());
    return v7;
end;
function u1._xa9dd9c8e498c5e89(p8) --[[ Line: 36 ]]
    return p8._xb7c986f3188d5b5f;
end;
function u1._x90bdaba3435818c3(p9, p10) --[[ Line: 40 ]]
    return p9._xb7c986f3188d5b5f[p10];
end;
function u1._xedd262c03ff71135(_, p11) --[[ Line: 44 ]]
    -- upvalues: l__Packets__2 (copy)
    l__Packets__2._x63e68dbc76b16aa6:Fire({
        op = "claim",
        uid = p11
    });
end;
function u1._x2805c92aa195b286(p12, p13) --[[ Line: 51 ]]
    -- upvalues: u6 (copy)
    if type(p13) == "table" and p13.uid ~= nil then
        p12._xb7c986f3188d5b5f[p13.uid] = u6(p13);
        p12._x42e15310c9d8b835:Fire(p13.uid, p12._xb7c986f3188d5b5f[p13.uid]);
    end;
end;
function u1._xcfc439c952b2b80d(p14, p15) --[[ Line: 60 ]]
    if p14._xb7c986f3188d5b5f[p15] == nil then
    else
        p14._xb7c986f3188d5b5f[p15] = nil;
        p14._xfd274174b9df963f:Fire(p15);
    end;
end;
function u1._xe53615d96cf36a6b(u16) --[[ Line: 70 ]]
    -- upvalues: l__Packets__2 (copy), u6 (copy)
    u16._xbd519c918208ce0e:Connect(l__Packets__2._x63e68dbc76b16aa6.OnClientEvent, function(p17) --[[ Line: 71 ]]
        -- upvalues: u16 (copy), u6 (ref)
        if type(p17) == "table" then
            if p17.op == "bootstrap" then
                u16._xb7c986f3188d5b5f = {};
                for _, v18 in pairs(p17.contracts or {}) do
                    if type(v18) == "table" and v18.uid then
                        u16._xb7c986f3188d5b5f[v18.uid] = u6(v18);
                    end;
                end;
                u16._xf88440d3e07bfe35:Fire(u16._xb7c986f3188d5b5f);
            elseif p17.op == "upsert" then
                u16:_x2805c92aa195b286(p17.contract);
            else
                if p17.op == "remove" then
                    u16:_xcfc439c952b2b80d(p17.uid);
                end;
            end;
        end;
    end;
end;
return u1;
