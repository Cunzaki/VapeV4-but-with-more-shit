-- Decompiled from: Start.Client.ReplicatedEntities._xad983143164c7284
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
require(l__ModuleScripts__1.Signal);
require(l__ModuleScripts__1.Promise);
require(l__ModuleScripts__1.Trove);
require(l__ModuleScripts__1.Spring);
require(l__ModuleScripts__1.CEnum);
local l__Easer__3 = require(l__ModuleScripts__1.Easer);
local l___x74b71dc9fd65af04__4 = require(script.Parent._x74b71dc9fd65af04);
local u1 = {};
u1.__index = u1;
setmetatable(u1, l___x74b71dc9fd65af04__4);
local l__Classes__5 = require(script.Parent.Parent.ClientRoot).Classes;
local _ = game.Players.LocalPlayer;
function u1._x83ed94bfb82a8c9f(p2, p3) --[[ Line: 34 ]]
    -- upvalues: l___x74b71dc9fd65af04__4 (copy), u1 (copy)
    local v4 = l___x74b71dc9fd65af04__4._x83ed94bfb82a8c9f(p2, p3);
    setmetatable(v4, u1);
    v4._xb6400efafc726277 = p3.launchpad_data;
    return v4;
end;
function u1._x91f1a55d9b284c4f(_) --[[ Line: 43 ]] end;
function u1._x35224e4a48526095(u5) --[[ Line: 46 ]]
    -- upvalues: l__Easer__3 (copy), l__Classes__5 (copy), l__Packets__2 (copy)
    u5._x0b7325c049f4fdb4 = false;
    task.delay(0.5, function() --[[ Line: 48 ]]
        -- upvalues: u5 (copy)
        u5._x0b7325c049f4fdb4 = true;
    end);
    if u5._x2401f1dccc8d59b5 then
        local v6 = {
            angle_type = "pitch",
            easer = l__Easer__3.new(0, 1, {
                {
                    goal = 0,
                    goal_alpha = 0,
                    easing_style = "QuadOut"
                },
                {
                    goal = -0.007,
                    goal_alpha = 0.15,
                    easing_style = "CubicOut"
                },
                {
                    goal = 0.001,
                    goal_alpha = 0.5,
                    easing_style = "QuadIn"
                }
            })
        };
        l__Classes__5._xdca80115d2839102:_x67da5f869bceed5d(v6, true, true);
        v6.easer:Run();
        l__Classes__5._x181e05d210129765:_xd3d48950a766775d(u5._x2401f1dccc8d59b5);
        l__Classes__5._x1a4ce4062771e36e:_x27cc3134a5c21ebc(u5._x2401f1dccc8d59b5, u5._xb6400efafc726277);
        l__Classes__5._x1a4ce4062771e36e._xc3a6f78161f2390a = false;
        local v7 = l__Classes__5._x8613500a592ecb35:_x743a226b34a5008a("augment");
        if v7._x533b8ba3e275f336 then
            v7:_x533b8ba3e275f336();
        end;
        task.delay(0.2, function() --[[ Line: 88 ]]
            -- upvalues: l__Classes__5 (ref)
            l__Classes__5._x1a4ce4062771e36e._xc3a6f78161f2390a = true;
        end);
        l__Packets__2._xdce6104c079e4c66:Fire(u5._x2401f1dccc8d59b5);
    end;
end;
return u1;
