-- Decompiled from: Start.Client.ReplicatedEntities._xc670a553526675a0
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

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
local l___x001ddfb7a4bdeb77__4 = require(script.Parent._x001ddfb7a4bdeb77);
local u1 = {};
u1.__index = u1;
setmetatable(u1, l___x001ddfb7a4bdeb77__4);
local l__Classes__5 = require(script.Parent.Parent.ClientRoot).Classes;
local _ = game.Players.LocalPlayer;
function u1._x90d4581ac99dd483(p2, p3) --[[ Line: 25 ]]
    -- upvalues: l___x001ddfb7a4bdeb77__4 (copy), u1 (copy)
    local v4 = l___x001ddfb7a4bdeb77__4._x90d4581ac99dd483(p2, p3);
    setmetatable(v4, u1);
    v4._x9696773bef6a2f50 = p3.launchpad_data;
    return v4;
end;
function u1._x6ffb8b18ef4549c8(_) --[[ Line: 34 ]] end;
function u1._x41a643b20ca024fa(u5) --[[ Line: 37 ]]
    -- upvalues: l__Easer__3 (copy), l__Classes__5 (copy), l__Packets__2 (copy)
    u5._x215be72d3f881056 = false;
    task.delay(0.5, function() --[[ Line: 39 ]]
        -- upvalues: u5 (copy)
        u5._x215be72d3f881056 = true;
    end;
    if u5._xe6b273660fc7b65e then
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
        l__Classes__5._x32ae459de0772e82:_x89ab120f43b710d2(v6, true, true);
        v6.easer:Run();
        l__Classes__5._x255cd8d76027f039:_x4447e49e11da5640(u5._xe6b273660fc7b65e);
        l__Classes__5._x7058397dabccd000:_x020f529dfd2d84c0(u5._xe6b273660fc7b65e, u5._x9696773bef6a2f50);
        l__Classes__5._x7058397dabccd000._x657bfe0ac4411e25 = false;
        local v7 = l__Classes__5._xd1706540247308ea:_x372c01be8a28bc70("augment");
        if v7._xcaef75cb09b92ea0 then
            v7:_xcaef75cb09b92ea0();
        end;
        task.delay(0.2, function() --[[ Line: 79 ]]
            -- upvalues: l__Classes__5 (ref)
            l__Classes__5._x7058397dabccd000._x657bfe0ac4411e25 = true;
        end;
        l__Packets__2._x1b774e73c6cfb3a6:Fire(u5._xe6b273660fc7b65e);
    end;
end;
return u1;
