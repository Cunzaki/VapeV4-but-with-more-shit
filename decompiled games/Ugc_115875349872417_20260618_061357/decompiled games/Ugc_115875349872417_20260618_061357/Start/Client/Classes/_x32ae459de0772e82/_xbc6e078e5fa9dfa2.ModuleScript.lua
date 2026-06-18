-- Decompiled from: Start.Client.Classes._x32ae459de0772e82._xbc6e078e5fa9dfa2
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__Easer__1 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Easer);
local v1 = require(script.Parent._xc2cf86a485f928f6)._x90d4581ac99dd483();
return {
    landing_pos = l__Easer__1.new(0, v1._x2c16d851d30e407b, {
        {
            goal = 0,
            goal_alpha = 0,
            easing_style = "QuadOut"
        },
        {
            goal = v1._x3f8074c0a8b372b1,
            goal_alpha = 0.1,
            easing_style = "CircOut"
        }
    }),
    landing_rot = l__Easer__1.new(0, v1._xae507c695a1342fe, {
        {
            goal = 0,
            goal_alpha = 0,
            easing_style = "QuadOut"
        },
        {
            goal = v1._xe2f87e2125e6075f,
            goal_alpha = 0.3,
            easing_style = "QuadInOut"
        }
    }),
    slide_began = l__Easer__1.new(0, v1._x2336aecf7641c3d9, {
        {
            goal = 0,
            goal_alpha = 0,
            easing_style = "QuadOut"
        },
        {
            goal = v1._xbe77601bf907e80a,
            goal_alpha = 0.1,
            easing_style = "QuadInOut"
        },
        {
            goal = v1._x179f278519f2ce12,
            goal_alpha = 0.4,
            easing_style = "QuadInOut"
        }
    }),
    slide_ended = l__Easer__1.new(0, v1._xf01f6ff93ee658c3, {
        {
            goal = 0,
            goal_alpha = 0,
            easing_style = "QuadOut"
        },
        {
            goal = v1._x73e951e13b43cc70,
            goal_alpha = 0.2,
            easing_style = "QuadInOut"
        }
    }),
    wall_kick = l__Easer__1.new(0, v1._x4b2f845bff40e0dd, {
        {
            goal = 0,
            goal_alpha = 0,
            easing_style = "QuadOut"
        },
        {
            goal = v1._x74df838c7270e13b,
            goal_alpha = 0.2,
            easing_style = "QuadInOut"
        }
    })
};
