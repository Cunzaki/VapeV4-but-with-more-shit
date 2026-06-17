-- Decompiled from: Start.Client.Classes._x5020bee128c37399
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
game:GetService("TweenService");
local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
require(l__ModuleScripts__1.Signal);
require(l__ModuleScripts__1.Promise);
require(l__ModuleScripts__1.Trove);
local l___x7749231778538ccb__3 = require(script.Parent.Parent._x7749231778538ccb);
local u1 = {};
u1.__index = u1;
local u2 = {
    Pointer = script._xb50fe318602dd4a2
};
local _ = require(script.Parent.Parent.ClientRoot).Classes;
local l__LocalPlayer__4 = game.Players.LocalPlayer;
local l__UIAssets__5 = game:GetService("ReplicatedStorage").Assets.UIAssets;
function u1._x83ed94bfb82a8c9f() --[[ Line: 36 ]]
    -- upvalues: u1 (copy), l__UIAssets__5 (copy)
    local v3 = setmetatable({}, u1);
    v3._x31ac605b18fd46d5 = l__UIAssets__5.GuideScreen:Clone();
    v3._xa50717ccd8be9ccb = {};
    return v3;
end;
function u1._xfe34c1fc068c1996(u4, p5, p6, p7) --[[ Line: 45 ]]
    -- upvalues: u2 (copy), l___x7749231778538ccb__3 (copy)
    local v8 = u2[p5];
    if v8 then
        local u9 = p7 or game:GetService("HttpService"):GenerateGUID();
        local v10 = l___x7749231778538ccb__3._xd644d9e3ba63f27f("", require(v8))._x83ed94bfb82a8c9f(u4._x31ac605b18fd46d5, p6);
        u4._xa50717ccd8be9ccb[u9] = v10;
        v10._xc74e01ec7295b965:Connect(v10._x01d94ee49508ae0f, function() --[[ Line: 53 ]]
            -- upvalues: u4 (copy), u9 (copy)
            u4._xa50717ccd8be9ccb[u9] = nil;
        end);
    else
        warn("NO SUCH COMPONENT TYPE :", p5);
    end;
end;
function u1._xe9769be1b2da87db(p11, p12) --[[ Line: 58 ]]
    -- upvalues: l___x7749231778538ccb__3 (copy)
    local u13 = l___x7749231778538ccb__3._xd644d9e3ba63f27f("", p11._xa50717ccd8be9ccb[p12]);
    pcall(function() --[[ Line: 60 ]]
        -- upvalues: u13 (copy)
        u13:destroy();
    end);
end;
function u1._x44bcd6af41218f92(u14) --[[ Line: 63 ]]
    -- upvalues: l__LocalPlayer__4 (copy), l__Packets__2 (copy)
    u14._x31ac605b18fd46d5.Parent = l__LocalPlayer__4.PlayerGui;
    l__Packets__2._x3c371686e12243c1.OnClientEvent:Connect(function(p15) --[[ Line: 66 ]]
        -- upvalues: u14 (copy)
        if p15.op == "construct" then
            u14:_xfe34c1fc068c1996(p15.component_type, p15.params, p15.id);
        else
            if p15.op == "destroy" then
                u14:_xe9769be1b2da87db(p15.id);
            end;
        end;
    end);
end;
return u1;
