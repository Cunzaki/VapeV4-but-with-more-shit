-- Decompiled from: Start.Client.Classes._x18cb1d13e08978ef
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

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
    Pointer = script._xd6d66346117fd661
};
local _ = require(script.Parent.Parent.ClientRoot).Classes;
local l__LocalPlayer__4 = game.Players.LocalPlayer;
local l__UIAssets__5 = game:GetService("ReplicatedStorage").Assets.UIAssets;
function u1._x90d4581ac99dd483() --[[ Line: 27 ]]
    -- upvalues: u1 (copy), l__UIAssets__5 (copy)
    local v3 = setmetatable({}, u1);
    v3._x55127f699e2d4902 = l__UIAssets__5.GuideScreen:Clone();
    v3._x45ab59bf58b89265 = {};
    return v3;
end;
function u1._xf6a769078634b1ad(u4, p5, p6, p7) --[[ Line: 36 ]]
    -- upvalues: u2 (copy), l__InternalSymbols__3 (copy)
    local v8 = u2[p5];
    if v8 then
        local u9 = p7 or game:GetService("HttpService"):GenerateGUID();
        local v10 = l__InternalSymbols__3.owner("", require(v8))._x90d4581ac99dd483(u4._x55127f699e2d4902, p6);
        u4._x45ab59bf58b89265[u9] = v10;
        v10._xbd519c918208ce0e:Connect(v10._x3a474ee727097ae2, function() --[[ Line: 44 ]]
            -- upvalues: u4 (copy), u9 (copy)
            u4._x45ab59bf58b89265[u9] = nil;
        end;
    else
        warn("NO SUCH COMPONENT TYPE :", p5);
    end;
end;
function u1._xb9f2d9f1ab2a7abc(p11, p12) --[[ Line: 49 ]]
    -- upvalues: l__InternalSymbols__3 (copy)
    local u13 = l__InternalSymbols__3.owner("", p11._x45ab59bf58b89265[p12]);
    pcall(function() --[[ Line: 51 ]]
        -- upvalues: u13 (copy)
        u13:destroy();
    end;
end;
function u1._xe53615d96cf36a6b(u14) --[[ Line: 54 ]]
    -- upvalues: l__LocalPlayer__4 (copy), l__Packets__2 (copy)
    u14._x55127f699e2d4902.Parent = l__LocalPlayer__4.PlayerGui;
    l__Packets__2._xb597a1f2d80824ed.OnClientEvent:Connect(function(p15) --[[ Line: 57 ]]
        -- upvalues: u14 (copy)
        if p15.op == "construct" then
            u14:_xf6a769078634b1ad(p15.component_type, p15.params, p15.id);
        else
            if p15.op == "destroy" then
                u14:_xb9f2d9f1ab2a7abc(p15.id);
            end;
        end;
    end;
end;
return u1;
