-- Decompiled from: Start.Client.Classes._x2b1f81c73714b323._x97adb7b7dfd4838d
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__Easer__1 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Easer);
local v1 = require(script.Parent._x1331baa573aa1e96)._xafd29f1684593d0b();
return {
    landing_pos = l__Easer__1.new(0, v1._x1e1f66d9a99edfb4, {
        {
            goal = 0,
            goal_alpha = 0,
            easing_style = "QuadOut"
        },
        {
            goal = v1._x182255e685febbc1,
            goal_alpha = 0.1,
            easing_style = "CircOut"
        }
    }),
    landing_rot = l__Easer__1.new(0, v1._x8b743c7a49af1732, {
        {
            goal = 0,
            goal_alpha = 0,
            easing_style = "QuadOut"
        },
        {
            goal = v1._x5f3bb74de6a42c6f,
            goal_alpha = 0.3,
            easing_style = "QuadInOut"
        }
    }),
    slide_began = l__Easer__1.new(0, v1._xb9452e4caba40139, {
        {
            goal = 0,
            goal_alpha = 0,
            easing_style = "QuadOut"
        },
        {
            goal = v1._xfce3ca014e1b2602,
            goal_alpha = 0.1,
            easing_style = "QuadInOut"
        },
        {
            goal = v1._x3c8b7edc15ec3225,
            goal_alpha = 0.4,
            easing_style = "QuadInOut"
        }
    }),
    slide_ended = l__Easer__1.new(0, v1._xd40fa9b18295b7e0, {
        {
            goal = 0,
            goal_alpha = 0,
            easing_style = "QuadOut"
        },
        {
            goal = v1._x895c5bc8068ea3b5,
            goal_alpha = 0.2,
            easing_style = "QuadInOut"
        }
    }),
    wall_kick = l__Easer__1.new(0, v1._x40f5982974fc1c1b, {
        {
            goal = 0,
            goal_alpha = 0,
            easing_style = "QuadOut"
        },
        {
            goal = v1._x957e5ae8bd64ca11,
            goal_alpha = 0.2,
            easing_style = "QuadInOut"
        }
    })
};
