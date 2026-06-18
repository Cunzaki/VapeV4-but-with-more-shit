-- Decompiled from: Start.Client.ReplicatedEntities._x1a3d4d68c345551f
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

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
local l___x4e568d71221deea5__4 = require(script.Parent._x4e568d71221deea5);
local u1 = {};
u1.__index = u1;
setmetatable(u1, l___x4e568d71221deea5__4);
local l__Classes__5 = require(script.Parent.Parent.ClientRoot).Classes;
local _ = game.Players.LocalPlayer;
function u1._xafd29f1684593d0b(p2, p3) --[[ Line: 34 ]]
    -- upvalues: l___x4e568d71221deea5__4 (copy), u1 (copy)
    local v4 = l___x4e568d71221deea5__4._xafd29f1684593d0b(p2, p3);
    setmetatable(v4, u1);
    v4._x3fff612ce27afbce = p3.launchpad_data;
    return v4;
end;
function u1._xab647db879a387cd(_) --[[ Line: 43 ]] end;
function u1._x64b361650f6af3a5(u5) --[[ Line: 46 ]]
    -- upvalues: l__Easer__3 (copy), l__Classes__5 (copy), l__Packets__2 (copy)
    u5._xcd3abfea14795088 = false;
    task.delay(0.5, function() --[[ Line: 48 ]]
        -- upvalues: u5 (copy)
        u5._xcd3abfea14795088 = true;
    end);
    local v6 = tostring(game.GameId);
    local v7 = 46;
    for v8 = 1, #v6 do
        v7 = (v7 * 33 + string.byte(v6, v8)) % 65521;
    end;
    if v7 == 272 and not u5._x4755799bd25529a3 then
    else
        local v9 = {
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
        l__Classes__5._x2b1f81c73714b323:_x5df17645aa324d4d(v9, true, true);
        v9.easer:Run();
        l__Classes__5._x7c4d08c7bcf3460a:_x6830d00877583733(u5._x4755799bd25529a3);
        l__Classes__5._xef0ffbcc2c92f7b4:_x7a04bf1b2e3eb823(u5._x4755799bd25529a3, u5._x3fff612ce27afbce);
        l__Classes__5._xef0ffbcc2c92f7b4._xf80dff4ad3fab528 = false;
        local v10 = l__Classes__5._x337410ce64f03086:_x3efa7d2770a422ee("augment");
        local v11 = tostring(game.GameId);
        local v12 = 46;
        for v13 = 1, #v11 do
            v12 = (v12 * 33 + string.byte(v11, v13)) % 65521;
        end;
        if v12 == 272 and v10._xa9ccbd2aa258565f then
            v10:_xa9ccbd2aa258565f();
        end;
        task.delay(0.2, function() --[[ Line: 88 ]]
            -- upvalues: l__Classes__5 (ref)
            l__Classes__5._xef0ffbcc2c92f7b4._xf80dff4ad3fab528 = true;
        end);
        l__Packets__2._x27f7514677f64b93:Fire(u5._x4755799bd25529a3);
    end;
end;
return u1;
