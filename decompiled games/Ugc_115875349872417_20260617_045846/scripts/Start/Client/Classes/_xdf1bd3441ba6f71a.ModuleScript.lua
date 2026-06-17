-- Decompiled from: Start.Client.Classes._xdf1bd3441ba6f71a
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
local l__Signal__3 = require(l__ModuleScripts__1.Signal);
require(l__ModuleScripts__1.Promise);
require(l__ModuleScripts__1.Trove);
local u1 = {};
u1.__index = u1;
local _ = require(script.Parent.Parent.ClientRoot).Classes;
local l__LocalPlayer__4 = game.Players.LocalPlayer;
local u2 = {
    "onHit",
    "wasHit",
    "clashed",
    "onParry",
    "wasParried",
    "onKill",
    "wasKilled"
};
function u1._x83ed94bfb82a8c9f() --[[ Line: 35 ]]
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3._x30ee16a791b361ba = {};
    v3._xeac352f2453cfe63 = {};
    return v3;
end;
function u1._xb9853b4b7ca133d8(p4, p5, p6) --[[ Line: 45 ]]
    local v7 = p4._x30ee16a791b361ba[p5];
    if v7 then
        local v8 = v7[p6];
        if v8 then
            return v8;
        end;
        warn("INVALID EVENT PARAMETER : ", p6);
    else
        warn("INVALID PLAYER PARAMETER : ", p5);
    end;
end;
function u1._xa509dd8160f371f3(u9, p10) --[[ Line: 63 ]]
    local l__action__5 = p10.action;
    local l__agent__6 = p10.agent;
    local l__victim__7 = p10.victim;
    local v11 = game:GetService("Players"):GetPlayerFromCharacter(l__agent__6);
    local v12 = game:GetService("Players"):GetPlayerFromCharacter(l__victim__7);
    local v13 = u9._x30ee16a791b361ba[v11];
    local v14 = u9._x30ee16a791b361ba[v12];
    local function v19(p15, p16, ...) --[[ Line: 75 ]]
        -- upvalues: u9 (copy)
        if p15 then
            local v17 = p15[p16];
            if v17 then
                v17:Fire(...);
                local v18 = u9._xeac352f2453cfe63[p16];
                if v18 then
                    v18:Fire(...);
                end;
            else
                warn("INCORRECT SIGNAL : ", p16);
            end;
        end;
    end;
    if l__action__5 == "hit" then
        v19(v13, "onHit", l__victim__7);
        v19(v14, "wasHit", l__agent__6);
    elseif l__action__5 == "clashed" then
        v19(v13, "clashed", l__victim__7);
        v19(v14, "clashed", l__agent__6);
    elseif l__action__5 == "parried" then
        v19(v13, "onParry", l__victim__7);
        v19(v14, "wasParried", l__agent__6);
    else
        if l__action__5 == "killed" then
            v19(v13, "onKill", l__victim__7);
            v19(v14, "wasKilled", l__agent__6);
        end;
    end;
end;
function u1._x44bcd6af41218f92(u20) --[[ Line: 102 ]]
    -- upvalues: l__Packets__2 (copy), l__Signal__3 (copy), u2 (copy), l__LocalPlayer__4 (copy)
    l__Packets__2.unreliablePackets._x8e4db6c83cd1f1b6.OnClientEvent:Connect(function(...) --[[ Line: 103 ]]
        -- upvalues: u20 (copy)
        u20:_xa509dd8160f371f3(...);
    end);
    for _, v21 in { "onKill" } do
        local v22 = l__Signal__3.new();
        u20._xeac352f2453cfe63[v21] = v22;
    end;
    local function u26(p23) --[[ Line: 114 ]]
        -- upvalues: u2 (ref), l__Signal__3 (ref), u20 (copy)
        local v24 = {};
        for _, v25 in u2 do
            v24[v25] = l__Signal__3.new();
        end;
        u20._x30ee16a791b361ba[p23] = v24;
    end;
    u26(l__LocalPlayer__4);
    for _, v27 in game:GetService("Players"):GetPlayers() do
        if v27 ~= l__LocalPlayer__4 then
            u26(v27);
        end;
    end;
    game:GetService("Players").PlayerAdded:Connect(function(p28) --[[ Line: 134 ]]
        -- upvalues: u26 (copy)
        u26(p28);
    end);
    game:GetService("Players").PlayerRemoving:Connect(function(p29) --[[ Line: 138 ]]
        -- upvalues: u20 (copy)
        local v30 = u20._x30ee16a791b361ba[p29];
        if v30 then
            for _, v31 in pairs(v30) do
                v31:DisconnectAll();
            end;
        end;
        u20._x30ee16a791b361ba[p29] = nil;
    end);
end;
return u1;
