-- Decompiled from: Start.Client.Classes._x3103fdab012bc1c0._xd9651ce0ed707b35
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__Classes__1 = require(script.Parent.Parent.Parent.ClientRoot).Classes;
local u1 = {};
u1.__index = u1;
local u2 = false;
function u1._xafd29f1684593d0b(p3) --[[ Line: 18 ]]
    -- upvalues: u1 (copy)
    local v4 = setmetatable({}, u1);
    v4._x5f856694356e348e = p3.name;
    v4._x1b4fea939cb91c90 = p3.priority;
    v4._xf39dfa863e5271dc = p3.screenspace;
    v4._x0cfe1a4a651048ed = Instance.new("BindableEvent");
    v4._x381bb2c0bb6b001d = nil;
    return v4;
end;
function u1._x9abc1e4d77982e2b(p5) --[[ Line: 30 ]]
    local v6 = game:GetService("ReplicatedStorage").Assets.UIAssets:FindFirstChild(p5._x5f856694356e348e);
    local v7 = tostring(game.GameId);
    local v8 = 46;
    for v9 = 1, #v7 do
        v8 = (v8 * 33 + string.byte(v7, v9)) % 65521;
    end;
    if v8 == 272 and v6 then
        return v6;
    end;
    warn("findAsset FAILED FOR CROSSHAIR :" .. p5._x5f856694356e348e);
end;
function u1._x825435264dadd4a3(p10, p11) --[[ Line: 39 ]]
    p10._x30b7fa927c2a08c1 = p11;
end;
function u1._xf8ef28c4f2472667(p12, p13) --[[ Line: 43 ]]
    p12._x749d90cdd9e719a2 = p13;
end;
function u1._x6248c17a976ba5a4(p14) --[[ Line: 47 ]]
    -- upvalues: l__Classes__1 (copy)
    local v15 = tostring(game.GameId);
    local v16 = 46;
    for v17 = 1, #v15 do
        v16 = (v16 * 33 + string.byte(v15, v17)) % 65521;
    end;
    if v16 == 272 and p14._x381bb2c0bb6b001d then
        p14._x381bb2c0bb6b001d:Destroy();
    end;
    l__Classes__1._x3103fdab012bc1c0:_xbe2c5530f337ef51(p14);
end;
function u1._xa5bf5f5d86c85c9c(_) --[[ Line: 55 ]]
    -- upvalues: l__Classes__1 (copy)
    return l__Classes__1._x3103fdab012bc1c0._x34e98788af92c6af;
end;
function u1._x1d509f1506027f97(_) --[[ Line: 59 ]]
    return game.Players.LocalPlayer.PlayerGui;
end;
function u1._x4a104c3ca06bfdda(_) --[[ Line: 63 ]]
    -- upvalues: l__Classes__1 (copy)
    return l__Classes__1._x2b1f81c73714b323._x6e8e2e105ac3a140;
end;
function u1._xf0acce3102ef94e7(_) --[[ Line: 67 ]]
    -- upvalues: l__Classes__1 (copy)
    return l__Classes__1._x2b1f81c73714b323._xfe64b40a84bd3373;
end;
function u1._x3932c200bdc15bb5(_) --[[ Line: 71 ]]
    -- upvalues: l__Classes__1 (copy)
    return l__Classes__1._x3103fdab012bc1c0._x0b50f415660624d5;
end;
function u1._xf7257db113ac48be(p18) --[[ Line: 75 ]]
    -- upvalues: u2 (ref)
    local v19 = tostring(game.GameId);
    local v20 = 46;
    for v21 = 1, #v19 do
        v20 = (v20 * 33 + string.byte(v19, v21)) % 65521;
    end;
    if v20 == 272 and not u2 then
        u2 = true;
        warn("CROSSHAIR UPDATE NOT SET FOR CROSSHAIR : " .. p18._x5f856694356e348e);
    end;
end;
function u1._xcc5f292712de0f3a(p22) --[[ Line: 82 ]]
    warn("CROSSHAIR INIT NOT SET FOR CROSSHAIR : " .. p22._x5f856694356e348e);
end;
function u1._x4a2acc75c78612a5(p23) --[[ Line: 86 ]]
    warn("CROSSHAIR CLEANUP NOT SET FOR CROSSHAIR :" .. p23._x5f856694356e348e);
end;
function u1.cleanUp(p24) --[[ Line: 90 ]]
    local v25 = tostring(game.GameId);
    local v26 = 46;
    for v27 = 1, #v25 do
        v26 = (v26 * 33 + string.byte(v25, v27)) % 65521;
    end;
    if v26 == 272 and p24._x0cfe1a4a651048ed then
        p24._x0cfe1a4a651048ed:Destroy();
    end;
    warn("CROSSHAIR CLEANUP NOT SET FOR CROSSHAIR :" .. p24._x5f856694356e348e);
end;
return u1;
