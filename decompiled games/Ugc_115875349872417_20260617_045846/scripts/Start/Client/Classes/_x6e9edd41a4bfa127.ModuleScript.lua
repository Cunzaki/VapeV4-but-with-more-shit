-- Decompiled from: Start.Client.Classes._x6e9edd41a4bfa127
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
local l__Signal__3 = require(l__ModuleScripts__1.Signal);
local l__Trove__4 = require(l__ModuleScripts__1.Trove);
local u1 = {};
u1.__index = u1;
local function u6(p2) --[[ Line: 20 ]]
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
function u1._x83ed94bfb82a8c9f() --[[ Line: 33 ]]
    -- upvalues: u1 (copy), l__Trove__4 (copy), l__Signal__3 (copy)
    local v7 = setmetatable({}, u1);
    v7._xc74e01ec7295b965 = l__Trove__4.new();
    v7._xcb792201aa4fac14 = {};
    v7._xd1a4e36891739b9e = v7._xc74e01ec7295b965:Add(l__Signal__3.new());
    v7._x101c44920212f79c = v7._xc74e01ec7295b965:Add(l__Signal__3.new());
    v7._xbeadb63fa96718e1 = v7._xc74e01ec7295b965:Add(l__Signal__3.new());
    return v7;
end;
function u1._x84b7ea74a9cdaa56(p8) --[[ Line: 45 ]]
    return p8._xcb792201aa4fac14;
end;
function u1._xd9e0953a5041b902(p9, p10) --[[ Line: 49 ]]
    return p9._xcb792201aa4fac14[p10];
end;
function u1._x042a62efa5274aac(_, p11) --[[ Line: 53 ]]
    -- upvalues: l__Packets__2 (copy)
    l__Packets__2._xa5cd30aff568ab2b:Fire({
        op = "claim",
        uid = p11
    });
end;
function u1._xd21cd4d26a85c2cf(p12, p13) --[[ Line: 60 ]]
    -- upvalues: u6 (copy)
    if type(p13) == "table" and p13.uid ~= nil then
        p12._xcb792201aa4fac14[p13.uid] = u6(p13);
        p12._xd1a4e36891739b9e:Fire(p13.uid, p12._xcb792201aa4fac14[p13.uid]);
    end;
end;
function u1._xdf2ae0981111799b(p14, p15) --[[ Line: 69 ]]
    if p14._xcb792201aa4fac14[p15] == nil then
    else
        p14._xcb792201aa4fac14[p15] = nil;
        p14._x101c44920212f79c:Fire(p15);
    end;
end;
function u1._x44bcd6af41218f92(u16) --[[ Line: 79 ]]
    -- upvalues: l__Packets__2 (copy), u6 (copy)
    u16._xc74e01ec7295b965:Connect(l__Packets__2._xa5cd30aff568ab2b.OnClientEvent, function(p17) --[[ Line: 80 ]]
        -- upvalues: u16 (copy), u6 (ref)
        if type(p17) == "table" then
            if p17.op == "bootstrap" then
                u16._xcb792201aa4fac14 = {};
                for _, v18 in pairs(p17.contracts or {}) do
                    if type(v18) == "table" and v18.uid then
                        u16._xcb792201aa4fac14[v18.uid] = u6(v18);
                    end;
                end;
                u16._xbeadb63fa96718e1:Fire(u16._xcb792201aa4fac14);
            elseif p17.op == "upsert" then
                u16:_xd21cd4d26a85c2cf(p17.contract);
            else
                if p17.op == "remove" then
                    u16:_xdf2ae0981111799b(p17.uid);
                end;
            end;
        end;
    end);
end;
return u1;
