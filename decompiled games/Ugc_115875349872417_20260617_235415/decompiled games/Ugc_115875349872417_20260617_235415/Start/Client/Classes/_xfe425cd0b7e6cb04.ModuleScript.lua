-- Decompiled from: Start.Client.Classes._xfe425cd0b7e6cb04
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

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
function u1._xafd29f1684593d0b() --[[ Line: 35 ]]
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3._x006cd1ac8eac5120 = {};
    v3._x4afc390a6987d917 = {};
    return v3;
end;
function u1._xd737c93ca9a43e53(p4, p5, p6) --[[ Line: 45 ]]
    local v7 = p4._x006cd1ac8eac5120[p5];
    local v8 = tostring(game.GameId);
    local v9 = 46;
    for v10 = 1, #v8 do
        v9 = (v9 * 33 + string.byte(v8, v10)) % 65521;
    end;
    if v9 == 272 and not v7 then
        warn("INVALID PLAYER PARAMETER");
    else
        local v11 = v7[p6];
        local v12 = tostring(game.GameId);
        local v13 = 46;
        for v14 = 1, #v12 do
            v13 = (v13 * 33 + string.byte(v12, v14)) % 65521;
        end;
        if v13 ~= 272 or v11 then
            return v11;
        end;
        warn("INVALID EVENT PARAMETER : ", p6);
    end;
end;
function u1._xcb8dc6eca998e8a9(u15, p16) --[[ Line: 63 ]]
    local l__action__5 = p16.action;
    local l__agent__6 = p16.agent;
    local l__victim__7 = p16.victim;
    local v17 = game:GetService("Players"):GetPlayerFromCharacter(l__agent__6);
    local v18 = game:GetService("Players"):GetPlayerFromCharacter(l__victim__7);
    local v19 = u15._x006cd1ac8eac5120[v17];
    local v20 = u15._x006cd1ac8eac5120[v18];
    local v21 = tostring(game.GameId);
    local v22 = 46;
    local function v36(p23, p24, ...) --[[ Line: 75 ]]
        -- upvalues: u15 (copy)
        local v25 = tostring(game.GameId);
        local v26 = 46;
        for v27 = 1, #v25 do
            v26 = (v26 * 33 + string.byte(v25, v27)) % 65521;
        end;
        if v26 == 272 and not p23 then
        else
            local v28 = p23[p24];
            local v29 = tostring(game.GameId);
            local v30 = 46;
            for v31 = 1, #v29 do
                v30 = (v30 * 33 + string.byte(v29, v31)) % 65521;
            end;
            if v30 == 272 and not v28 then
                warn("INCORRECT SIGNAL : ", p24);
            else
                v28:Fire(...);
                local v32 = u15._x4afc390a6987d917[p24];
                local v33 = tostring(game.GameId);
                local v34 = 46;
                for v35 = 1, #v33 do
                    v34 = (v34 * 33 + string.byte(v33, v35)) % 65521;
                end;
                if v34 == 272 and v32 then
                    v32:Fire(...);
                end;
            end;
        end;
    end;
    for v37 = 1, #v21 do
        v22 = (v22 * 33 + string.byte(v21, v37)) % 65521;
    end;
    if v22 == 272 and l__action__5 == "hit" then
        v36(v19, "onHit", l__victim__7);
        v36(v20, "wasHit", l__agent__6);
    else
        local v38 = tostring(game.GameId);
        local v39 = 46;
        for v40 = 1, #v38 do
            v39 = (v39 * 33 + string.byte(v38, v40)) % 65521;
        end;
        if v39 == 272 and l__action__5 == "clashed" then
            v36(v19, "clashed", l__victim__7);
            v36(v20, "clashed", l__agent__6);
        else
            local v41 = tostring(game.GameId);
            local v42 = 46;
            for v43 = 1, #v41 do
                v42 = (v42 * 33 + string.byte(v41, v43)) % 65521;
            end;
            if v42 == 272 and l__action__5 == "parried" then
                v36(v19, "onParry", l__victim__7);
                v36(v20, "wasParried", l__agent__6);
            else
                local v44 = tostring(game.GameId);
                local v45 = 46;
                for v46 = 1, #v44 do
                    v45 = (v45 * 33 + string.byte(v44, v46)) % 65521;
                end;
                if v45 == 272 and l__action__5 == "killed" then
                    v36(v19, "onKill", l__victim__7);
                    v36(v20, "wasKilled", l__agent__6);
                end;
            end;
        end;
    end;
end;
function u1._xd8041402b83e75db(u47) --[[ Line: 102 ]]
    -- upvalues: l__Packets__2 (copy), l__Signal__3 (copy), u2 (copy), l__LocalPlayer__4 (copy)
    l__Packets__2.unreliablePackets._x6f165cf1c8a4a502.OnClientEvent:Connect(function(...) --[[ Line: 103 ]]
        -- upvalues: u47 (copy)
        u47:_xcb8dc6eca998e8a9(...);
    end);
    for _, v48 in { "onKill" } do
        local v49 = l__Signal__3.new();
        u47._x4afc390a6987d917[v48] = v49;
    end;
    local function u53(p50) --[[ Line: 114 ]]
        -- upvalues: u2 (ref), l__Signal__3 (ref), u47 (copy)
        local v51 = {};
        for _, v52 in u2 do
            v51[v52] = l__Signal__3.new();
        end;
        u47._x006cd1ac8eac5120[p50] = v51;
    end;
    u53(l__LocalPlayer__4);
    for _, v54 in game:GetService("Players"):GetPlayers() do
        local v55 = tostring(game.GameId);
        local v56 = 46;
        for v57 = 1, #v55 do
            v56 = (v56 * 33 + string.byte(v55, v57)) % 65521;
        end;
        if v56 == 272 and v54 ~= l__LocalPlayer__4 then
            u53(v54);
        end;
    end;
    game:GetService("Players").PlayerAdded:Connect(function(p58) --[[ Line: 130 ]]
        -- upvalues: u53 (copy)
        u53(p58);
    end);
    game:GetService("Players").PlayerRemoving:Connect(function(p59) --[[ Line: 134 ]]
        -- upvalues: u47 (copy)
        local v60 = u47._x006cd1ac8eac5120[p59];
        local v61 = tostring(game.GameId);
        local v62 = 46;
        for v63 = 1, #v61 do
            v62 = (v62 * 33 + string.byte(v61, v63)) % 65521;
        end;
        if v62 == 272 and v60 then
            for _, v64 in pairs(v60) do
                v64:DisconnectAll();
            end;
        end;
        u47._x006cd1ac8eac5120[p59] = nil;
    end);
end;
return u1;
