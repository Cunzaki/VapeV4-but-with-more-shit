-- Decompiled from: Start.Client.Classes._xa3a7603ddee2d1dc
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
local l__Signal__3 = require(l__ModuleScripts__1.Signal);
local l__Trove__4 = require(l__ModuleScripts__1.Trove);
local u1 = {};
u1.__index = u1;
local l___x2554b4c6100d2904__5 = require(script._x2554b4c6100d2904);
local l__LocalPlayer__6 = game.Players.LocalPlayer;
function u1._x83ed94bfb82a8c9f() --[[ Line: 36 ]]
    -- upvalues: u1 (copy), l__Trove__4 (copy), l__Signal__3 (copy)
    local v2 = setmetatable({}, u1);
    v2._x5701b2ec5956067a = game:GetService("ReplicatedStorage").Assets.UIAssets.GuideScreen:Clone();
    v2._xc74e01ec7295b965 = l__Trove__4.new();
    v2._xfd0e3f4a1699a6e1 = nil;
    v2._xbc23cb477bc0f5b2 = nil;
    v2._x6e16b3138d228782 = nil;
    v2._x90295bf2c4f78bd7 = nil;
    v2._x002874026488e641 = false;
    v2._xbec79af343bed749 = v2._xc74e01ec7295b965:Add(l__Signal__3.new());
    v2._x19df84d439cdb0fd = v2._xc74e01ec7295b965:Add(l__Signal__3.new());
    return v2;
end;
function u1._x27687cdfa456ce9b(u3, p4, p5) --[[ Line: 53 ]]
    -- upvalues: l___x2554b4c6100d2904__5 (copy), l__Packets__2 (copy)
    u3:_x3bf86598f3de8c9b();
    u3._xfd0e3f4a1699a6e1 = l___x2554b4c6100d2904__5._x83ed94bfb82a8c9f(u3._x5701b2ec5956067a, p4, p5);
    u3._x90295bf2c4f78bd7 = p4;
    u3._x6e16b3138d228782 = p5;
    u3._x002874026488e641 = false;
    u3._xbc23cb477bc0f5b2 = u3._xfd0e3f4a1699a6e1._xd71422846bfec0a3:Connect(function(p6, p7) --[[ Line: 60 ]]
        -- upvalues: u3 (copy), l__Packets__2 (ref)
        if u3._xfd0e3f4a1699a6e1 == nil or u3._x002874026488e641 then
        else
            u3._x002874026488e641 = true;
            l__Packets__2._xcbe604ff7aa7a075:Fire({
                op = "continue",
                node_id = p6,
                token = p7
            });
        end;
    end);
    u3._xbec79af343bed749:Fire(p4, p5);
    return u3._xfd0e3f4a1699a6e1;
end;
function u1._x44bcd6af41218f92(u8) --[[ Line: 79 ]]
    -- upvalues: l__LocalPlayer__6 (copy), l__Packets__2 (copy)
    u8._x5701b2ec5956067a.Parent = l__LocalPlayer__6.PlayerGui;
    local l___x5701b2ec5956067a__7 = u8._x5701b2ec5956067a;
    if l___x5701b2ec5956067a__7 then
        if l___x5701b2ec5956067a__7:IsA("ScreenGui") then
            l___x5701b2ec5956067a__7.Enabled = false;
        elseif l___x5701b2ec5956067a__7:IsA("GuiObject") then
            l___x5701b2ec5956067a__7.Visible = false;
        end;
    end;
    u8._xc74e01ec7295b965:Connect(l__Packets__2._xcbe604ff7aa7a075.OnClientEvent, function(p9) --[[ Line: 83 ]]
        -- upvalues: u8 (copy)
        u8:_x4f4fb8114ec383bd(p9);
    end);
end;
function u1._x4f4fb8114ec383bd(p10, p11) --[[ Line: 88 ]]
    if typeof(p11) == "table" and typeof(p11.op) == "string" then
        local l__op__8 = p11.op;
        if l__op__8 == "show" then
            p10:_x27687cdfa456ce9b(p11.node_id, p11.token);
        else
            if l__op__8 == "end" then
                p10:_x1f6458e38e77459c(p11.reason);
            end;
        end;
    end;
end;
function u1._x1f6458e38e77459c(p12, p13) --[[ Line: 102 ]]
    p12:_x3bf86598f3de8c9b();
    local l___x5701b2ec5956067a__9 = p12._x5701b2ec5956067a;
    if l___x5701b2ec5956067a__9 then
        if l___x5701b2ec5956067a__9:IsA("ScreenGui") then
            l___x5701b2ec5956067a__9.Enabled = false;
        elseif l___x5701b2ec5956067a__9:IsA("GuiObject") then
            l___x5701b2ec5956067a__9.Visible = false;
        end;
    end;
    p12._x90295bf2c4f78bd7 = nil;
    p12._x6e16b3138d228782 = nil;
    p12._x002874026488e641 = false;
    p12._x19df84d439cdb0fd:Fire(p13);
end;
function u1._x3bf86598f3de8c9b(p14) --[[ Line: 112 ]]
    if p14._xbc23cb477bc0f5b2 then
        p14._xbc23cb477bc0f5b2:Disconnect();
        p14._xbc23cb477bc0f5b2 = nil;
    end;
    if p14._xfd0e3f4a1699a6e1 then
        p14._xfd0e3f4a1699a6e1:destroy();
        p14._xfd0e3f4a1699a6e1 = nil;
    end;
end;
function u1.destroy(p15) --[[ Line: 124 ]]
    p15:_x3bf86598f3de8c9b();
    p15._xc74e01ec7295b965:Destroy();
end;
return u1;
