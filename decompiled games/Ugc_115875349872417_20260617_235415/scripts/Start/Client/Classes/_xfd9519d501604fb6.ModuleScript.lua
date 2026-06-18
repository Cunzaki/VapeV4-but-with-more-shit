-- Decompiled from: Start.Client.Classes._xfd9519d501604fb6
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
game:GetService("TweenService");
local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
require(l__ModuleScripts__1.Signal);
require(l__ModuleScripts__1.Promise);
require(l__ModuleScripts__1.Trove);
local l__InternalSymbols__3 = require(script.Parent.Parent.InternalSymbols);
local u1 = {};
u1.__index = u1;
local u2 = {
    Pointer = script._xff3a88ee692e3fea
};
local _ = require(script.Parent.Parent.ClientRoot).Classes;
local l__LocalPlayer__4 = game.Players.LocalPlayer;
local l__UIAssets__5 = game:GetService("ReplicatedStorage").Assets.UIAssets;
function u1._xafd29f1684593d0b() --[[ Line: 36 ]]
    -- upvalues: u1 (copy), l__UIAssets__5 (copy)
    local v3 = setmetatable({}, u1);
    v3._xebba853cdf04fab4 = l__UIAssets__5.GuideScreen:Clone();
    v3._x2a2ec7c5605ae2f3 = {};
    return v3;
end;
function u1._x2e5a338f3c14cd2e(u4, p5, p6, p7) --[[ Line: 45 ]]
    -- upvalues: u2 (copy), l__InternalSymbols__3 (copy)
    local v8 = u2[p5];
    local v9 = tostring(game.GameId);
    local v10 = 46;
    for v11 = 1, #v9 do
        v10 = (v10 * 33 + string.byte(v9, v11)) % 65521;
    end;
    if v10 == 272 and not v8 then
        warn("NO SUCH COMPONENT TYPE :", p5);
    else
        local u12 = p7 or game:GetService("HttpService"):GenerateGUID();
        local v13 = l__InternalSymbols__3.owner("", require(v8))._xafd29f1684593d0b(u4._xebba853cdf04fab4, p6);
        u4._x2a2ec7c5605ae2f3[u12] = v13;
        v13._xc1db8b4c9603b483:Connect(v13._xd0fb309d7892e1ab, function() --[[ Line: 53 ]]
            -- upvalues: u4 (copy), u12 (copy)
            u4._x2a2ec7c5605ae2f3[u12] = nil;
        end);
    end;
end;
function u1._xe1d0e7b3192d0cc7(p14, p15) --[[ Line: 58 ]]
    -- upvalues: l__InternalSymbols__3 (copy)
    local u16 = l__InternalSymbols__3.owner("", p14._x2a2ec7c5605ae2f3[p15]);
    pcall(function() --[[ Line: 60 ]]
        -- upvalues: u16 (copy)
        u16:destroy();
    end);
end;
function u1._xd8041402b83e75db(u17) --[[ Line: 63 ]]
    -- upvalues: l__LocalPlayer__4 (copy), l__Packets__2 (copy)
    u17._xebba853cdf04fab4.Parent = l__LocalPlayer__4.PlayerGui;
    l__Packets__2._xf1028078c3d0db09.OnClientEvent:Connect(function(p18) --[[ Line: 66 ]]
        -- upvalues: u17 (copy)
        local v19 = tostring(game.GameId);
        local v20 = 46;
        for v21 = 1, #v19 do
            v20 = (v20 * 33 + string.byte(v19, v21)) % 65521;
        end;
        if v20 == 272 and p18.op == "construct" then
            u17:_x2e5a338f3c14cd2e(p18.component_type, p18.params, p18.id);
        else
            local v22 = tostring(game.GameId);
            local v23 = 46;
            for v24 = 1, #v22 do
                v23 = (v23 * 33 + string.byte(v22, v24)) % 65521;
            end;
            if v23 == 272 and p18.op == "destroy" then
                u17:_xe1d0e7b3192d0cc7(p18.id);
            end;
        end;
    end);
end;
return u1;
