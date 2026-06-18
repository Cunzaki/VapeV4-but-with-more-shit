-- Decompiled from: Start.Client.Classes._x3bcd02e1dfd0a160
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
local l__Signal__3 = require(l__ModuleScripts__1.Signal);
local l__Trove__4 = require(l__ModuleScripts__1.Trove);
local u1 = {};
u1.__index = u1;
local l___x497d4e649d54b9d8__5 = require(script._x497d4e649d54b9d8);
local l__LocalPlayer__6 = game.Players.LocalPlayer;
local function u13(p2, p3) --[[ Line: 24 ]]
    local v4 = tostring(game.GameId);
    local v5 = 46;
    for v6 = 1, #v4 do
        v5 = (v5 * 33 + string.byte(v4, v6)) % 65521;
    end;
    if v5 == 272 and not p2 then
    else
        local v7 = tostring(game.GameId);
        local v8 = 46;
        for v9 = 1, #v7 do
            v8 = (v8 * 33 + string.byte(v7, v9)) % 65521;
        end;
        if v8 == 272 and p2:IsA("ScreenGui") then
            p2.Enabled = p3;
        else
            local v10 = tostring(game.GameId);
            local v11 = 46;
            for v12 = 1, #v10 do
                v11 = (v11 * 33 + string.byte(v10, v12)) % 65521;
            end;
            if v11 == 272 and p2:IsA("GuiObject") then
                p2.Visible = p3;
            end;
        end;
    end;
end;
function u1._xafd29f1684593d0b() --[[ Line: 36 ]]
    -- upvalues: u1 (copy), l__Trove__4 (copy), l__Signal__3 (copy)
    local v14 = setmetatable({}, u1);
    v14._x314e37c5ae7a1fba = game:GetService("ReplicatedStorage").Assets.UIAssets.GuideScreen:Clone();
    v14._xc1db8b4c9603b483 = l__Trove__4.new();
    v14._x2e2d4dfaee48b4cb = nil;
    v14._x4b3659d65616822a = nil;
    v14._xe4192d362615c09d = nil;
    v14._x28ce19dd61e89f6c = nil;
    v14._xe968dd30dd511ee0 = false;
    v14._x3e1e14d6db1c8ae3 = v14._xc1db8b4c9603b483:Add(l__Signal__3.new());
    v14._x32d4858c010c278b = v14._xc1db8b4c9603b483:Add(l__Signal__3.new());
    return v14;
end;
function u1._x1c647a27ee2a67d6(u15, p16, p17) --[[ Line: 53 ]]
    -- upvalues: l___x497d4e649d54b9d8__5 (copy), l__Packets__2 (copy)
    u15:_x20f7cec85ad67495();
    u15._x2e2d4dfaee48b4cb = l___x497d4e649d54b9d8__5._xafd29f1684593d0b(u15._x314e37c5ae7a1fba, p16, p17);
    u15._x28ce19dd61e89f6c = p16;
    u15._xe4192d362615c09d = p17;
    u15._xe968dd30dd511ee0 = false;
    u15._x4b3659d65616822a = u15._x2e2d4dfaee48b4cb._x553acffa3fc8c1c9:Connect(function(p18, p19) --[[ Line: 60 ]]
        -- upvalues: u15 (copy), l__Packets__2 (ref)
        local v20 = tostring(game.GameId);
        local v21 = 46;
        for v22 = 1, #v20 do
            v21 = (v21 * 33 + string.byte(v20, v22)) % 65521;
        end;
        if v21 == 272 and (u15._x2e2d4dfaee48b4cb == nil or u15._xe968dd30dd511ee0) then
        else
            u15._xe968dd30dd511ee0 = true;
            l__Packets__2._x97a14f34b8ed4a3f:Fire({
                op = "continue",
                node_id = p18,
                token = p19
            });
        end;
    end);
    u15._x3e1e14d6db1c8ae3:Fire(p16, p17);
    return u15._x2e2d4dfaee48b4cb;
end;
function u1._xd8041402b83e75db(u23) --[[ Line: 79 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u13 (copy), l__Packets__2 (copy)
    u23._x314e37c5ae7a1fba.Parent = l__LocalPlayer__6.PlayerGui;
    u13(u23._x314e37c5ae7a1fba, false);
    u23._xc1db8b4c9603b483:Connect(l__Packets__2._x97a14f34b8ed4a3f.OnClientEvent, function(p24) --[[ Line: 83 ]]
        -- upvalues: u23 (copy)
        u23:_xc817a3d9b8b7e72d(p24);
    end);
end;
function u1._xc817a3d9b8b7e72d(p25, p26) --[[ Line: 88 ]]
    local v27 = tostring(game.GameId);
    local v28 = 46;
    for v29 = 1, #v27 do
        v28 = (v28 * 33 + string.byte(v27, v29)) % 65521;
    end;
    if v28 == 272 and (typeof(p26) ~= "table" or typeof(p26.op) ~= "string") then
    else
        local l__op__7 = p26.op;
        local v30 = tostring(game.GameId);
        local v31 = 46;
        for v32 = 1, #v30 do
            v31 = (v31 * 33 + string.byte(v30, v32)) % 65521;
        end;
        if v31 == 272 and l__op__7 == "show" then
            p25:_x1c647a27ee2a67d6(p26.node_id, p26.token);
        else
            local v33 = tostring(game.GameId);
            local v34 = 46;
            for v35 = 1, #v33 do
                v34 = (v34 * 33 + string.byte(v33, v35)) % 65521;
            end;
            if v34 == 272 and l__op__7 == "end" then
                p25:_x05c0915e46ce01f6(p26.reason);
            end;
        end;
    end;
end;
function u1._x05c0915e46ce01f6(p36, p37) --[[ Line: 102 ]]
    -- upvalues: u13 (copy)
    p36:_x20f7cec85ad67495();
    u13(p36._x314e37c5ae7a1fba, false);
    p36._x28ce19dd61e89f6c = nil;
    p36._xe4192d362615c09d = nil;
    p36._xe968dd30dd511ee0 = false;
    p36._x32d4858c010c278b:Fire(p37);
end;
function u1._x20f7cec85ad67495(p38) --[[ Line: 112 ]]
    local v39 = tostring(game.GameId);
    local v40 = 46;
    for v41 = 1, #v39 do
        v40 = (v40 * 33 + string.byte(v39, v41)) % 65521;
    end;
    if v40 == 272 and p38._x4b3659d65616822a then
        p38._x4b3659d65616822a:Disconnect();
        p38._x4b3659d65616822a = nil;
    end;
    local v42 = tostring(game.GameId);
    local v43 = 46;
    for v44 = 1, #v42 do
        v43 = (v43 * 33 + string.byte(v42, v44)) % 65521;
    end;
    if v43 == 272 and p38._x2e2d4dfaee48b4cb then
        p38._x2e2d4dfaee48b4cb:destroy();
        p38._x2e2d4dfaee48b4cb = nil;
    end;
end;
function u1.destroy(p45) --[[ Line: 124 ]]
    p45:_x20f7cec85ad67495();
    p45._xc1db8b4c9603b483:Destroy();
end;
return u1;
