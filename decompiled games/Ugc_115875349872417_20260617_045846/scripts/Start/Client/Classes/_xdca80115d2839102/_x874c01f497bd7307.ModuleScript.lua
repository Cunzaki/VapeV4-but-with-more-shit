-- Decompiled from: Start.Client.Classes._xdca80115d2839102._x874c01f497bd7307
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__Easer__1 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Easer);
local v1 = require(script.Parent._x569c479bf6ea5ebc)._x83ed94bfb82a8c9f();
return {
    landing_pos = l__Easer__1.new(0, v1._x64f86c6740274843, {
        {
            goal = 0,
            goal_alpha = 0,
            easing_style = "QuadOut"
        },
        {
            goal = v1._x29e80e4c64d3eb79,
            goal_alpha = 0.1,
            easing_style = "CircOut"
        }
    }),
    landing_rot = l__Easer__1.new(0, v1._x3f7b7507e5a74f41, {
        {
            goal = 0,
            goal_alpha = 0,
            easing_style = "QuadOut"
        },
        {
            goal = v1._xfb43913e7cfa1dbd,
            goal_alpha = 0.3,
            easing_style = "QuadInOut"
        }
    }),
    slide_began = l__Easer__1.new(0, v1._x947c943fe4bba9d0, {
        {
            goal = 0,
            goal_alpha = 0,
            easing_style = "QuadOut"
        },
        {
            goal = v1._xd5873462ef3563a9,
            goal_alpha = 0.1,
            easing_style = "QuadInOut"
        },
        {
            goal = v1._xcf4168cdb7cea3b7,
            goal_alpha = 0.4,
            easing_style = "QuadInOut"
        }
    }),
    slide_ended = l__Easer__1.new(0, v1._xab480d55b55b33e8, {
        {
            goal = 0,
            goal_alpha = 0,
            easing_style = "QuadOut"
        },
        {
            goal = v1._xabc4ddba5b3b3b12,
            goal_alpha = 0.2,
            easing_style = "QuadInOut"
        }
    }),
    wall_kick = l__Easer__1.new(0, v1._xf8a6077e1be286bb, {
        {
            goal = 0,
            goal_alpha = 0,
            easing_style = "QuadOut"
        },
        {
            goal = v1._x90a398e4e7bc50ac,
            goal_alpha = 0.2,
            easing_style = "QuadInOut"
        }
    })
};
