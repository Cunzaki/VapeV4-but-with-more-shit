-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__clear__1 = table.clear;
local l__clone__2 = table.clone;
local l__insert__3 = table.insert;
local l__obtain__4 = _G.obtain;
local u1 = l__obtain__4("L1Copy");
local v2 = l__obtain__4("CustomEnums");
local l__MODE_MAIN__5 = v2.MODE_MAIN;
local l__MODE_BONUS__6 = v2.MODE_BONUS;
local v3 = l__obtain__4("Game");
local l__GameID__7 = v3.GameID;
local l__UseSpoofedGameIDForStyles__8 = v3.UseSpoofedGameIDForStyles;
local l__UseSpoofedGameIDForDefaultStyleInfo__9 = v3.UseSpoofedGameIDForDefaultStyleInfo;
local u4 = {
    tickrate = 100,
    mv = 2.7,
    jump_time = 0.715588,
    platform_stand_time = 0.1,
    use_vstate = true,
    autohop = true,
    scroll_jump = nil,
    air_accel = nil,
    allow_fly = false,
    allow_jump = true,
    allow_pause = true,
    allow_strafe = true,
    allow_gravity = false,
    allow_timescale = false,
    allow_timetravel = false,
    rocket_force = nil,
    fly_mode = 0,
    fly_speed = 80,
    timescale = 1,
    hitbox = "Cylinder",
    hitbox_slope = 1,
    size = Vector3.new(2, 5, 2),
    camera_offset = Vector3.new(0, 2, 0),
    gravity = Vector3.new(0, -100, 0),
    gravity_scale = 1,
    hitbox_offset = Vector3.new()
};
local v5 = {
    {
        name = "Autohop",
        id = 1,
        keys = {
            w = 1,
            a = 1,
            s = 1,
            d = 1
        },
        cmds = {
            "n",
            "normal",
            "a",
            "auto",
            "autohop"
        }
    },
    {
        name = "Scroll",
        id = 2,
        autohop = false,
        scroll_jump = true,
        keys = {
            w = 1,
            a = 1,
            s = 1,
            d = 1
        },
        cmds = { "s", "scroll" }
    },
    {
        name = "Sideways",
        id = 3,
        keys = {
            w = 1,
            a = 0,
            s = 1,
            d = 0
        },
        cmds = { "sw", "side", "sideways" }
    },
    {
        name = "Half-Sideways",
        id = 4,
        total = 3,
        keys = {
            w = 2,
            a = 1,
            s = 0,
            d = 1
        },
        cmds = { "hsw", "half", "halfsideways" }
    },
    {
        name = "W-Only",
        id = 5,
        keys = {
            w = 1,
            a = 0,
            s = 0,
            d = 0
        },
        cmds = {
            "w",
            "wo",
            "wonly",
            "w-only"
        }
    },
    {
        name = "A-Only",
        id = 6,
        keys = {
            w = 0,
            a = 2,
            s = 0,
            d = 0
        },
        cmds = { "ao", "aonly", "a-only" }
    },
    {
        name = "Backwards",
        id = 7,
        keys = {
            w = 0,
            a = 1,
            s = 0,
            d = 1
        },
        allow_strafe_dir = Vector2.new(0, -1),
        cmds = {
            "ba",
            "bw",
            "back",
            "backwards"
        }
    },
    {
        name = "Faste",
        id = 8,
        mv = 10,
        keys = {
            w = 1,
            a = 1,
            s = 1,
            d = 1
        },
        cmds = {
            "f",
            "fa",
            "fast",
            "faste"
        }
    },
    {
        name = "Pinpoint-LongPocket",
        id = 10,
        hitbox = "BiPyramidMidRiff",
        keys = {
            w = 1,
            a = 1,
            s = 1,
            d = 1
        },
        cmds = {
            "ppl",
            "pi",
            "pin",
            "pinpoint",
            "long",
            "longpocket"
        }
    },
    {
        name = "Low Gravity",
        id = 14,
        jump_time = 2,
        gravity_scale = 0.5,
        keys = {
            w = 1,
            a = 1,
            s = 1,
            d = 1
        },
        cmds = { "lg", "lowgrav" }
    },
    {
        name = "CS:S",
        id = 16,
        tickrate = 66,
        mv = 1.875,
        air_accel = 618.75,
        jump_time = 0.7211102550927978,
        size = Vector3.new(2.0625, 4.5625, 2.0625),
        camera_offset = Vector3.new(0, 1.71875, 0),
        gravity = Vector3.new(0, -50, 0),
        keys = {
            w = 1,
            a = 1,
            s = 1,
            d = 1
        },
        cmds = {
            "css",
            "src",
            "counter",
            "strike",
            "source",
            "counter strike",
            "Counter-Strike: Source"
        }
    },
    {
        name = "Double Size",
        id = 17,
        mv = 5.4,
        gravity_scale = 2,
        size = Vector3.new(4, 10, 4),
        camera_offset = Vector3.new(0, 4, 0),
        keys = {
            w = 1,
            a = 1,
            s = 1,
            d = 1
        },
        cmds = { "db", "double", "doublesize" }
    },
    {
        name = "Boost",
        id = 18,
        allow_boost = true,
        boost_per_second = 10,
        boost_cap = 80,
        boost_cooldown = 2,
        keys = {
            w = 1,
            a = 1,
            s = 1,
            d = 1
        },
        cmds = { "boost" }
    },
    {
        name = "Nerfhop",
        id = 401,
        walkspeed = 12,
        tickrate = 100,
        mv = 1.8,
        gravity = Vector3.new(0, -70, 0),
        air_accel = 300,
        keys = {
            w = 1,
            a = 1,
            s = 1,
            d = 1
        },
        cmds = { "dr", "nerf", "nerfhop" }
    },
    {
        name = "Fly",
        id = 501,
        use_vstate = false,
        allow_jump = false,
        allow_strafe = false,
        gravity = Vector3.new(0, 0, 0),
        fly_mode = 1,
        fly_speed = 80,
        allow_fly_speed = false,
        allow_sprint = false,
        allow_noclip = false,
        keys = {
            w = 1,
            a = 1,
            q = 1,
            e = 1,
            s = 1,
            d = 1
        },
        cmds = { "fl", "fly" }
    },
    {
        name = "Fly Sustain",
        id = 502,
        use_vstate = false,
        allow_jump = false,
        allow_strafe = false,
        gravity = Vector3.new(0, 0, 0),
        fly_mode = 1,
        fly_speed = 50,
        fly_acceleration = 50,
        fly_turn_penalty = 80,
        allow_fly_speed = false,
        allow_sprint = false,
        allow_noclip = false,
        keys = {
            w = 1,
            a = 1,
            q = 1,
            e = 1,
            s = 1,
            d = 1
        },
        cmds = { "fs", "flysus", "flysustain" }
    },
    {
        name = "Rocket",
        id = 503,
        allow_jump = true,
        allow_strafe = false,
        rocket_force = 200,
        keys = {
            w = 1,
            a = 1,
            q = 1,
            e = 1,
            s = 1,
            d = 1
        },
        cmds = { "ro", "rock", "rocket" }
    },
    {
        name = "3D Strafe",
        id = 504,
        use_3d_strafe = true,
        keys = {
            w = 1,
            a = 1,
            q = 1,
            e = 1,
            s = 1,
            d = 1
        },
        cmds = { "3", "3d" }
    },
    {
        name = "Rocket Strafe",
        id = 505,
        allow_jump = true,
        allow_strafe = true,
        use_3d_strafe = true,
        rocket_force = 200,
        keys = {
            w = 1,
            a = 1,
            q = 1,
            e = 1,
            s = 1,
            d = 1
        },
        cmds = { "rs", "rocks", "rocketstrafe" }
    },
    {
        name = "Edgeboost",
        id = 19,
        hitbox = "BiPyramidMidRiff",
        hitbox_slope = 0.88,
        keys = {
            w = 1,
            a = 1,
            s = 1,
            d = 1
        },
        cmds = { "eb", "edge", "edgeboost" }
    },
    {
        name = "TAS",
        id = 20,
        timescale = 0.5,
        allow_timescale = true,
        allow_timetravel = true,
        keys = {
            w = 1,
            a = 1,
            s = 1,
            d = 1
        },
        cmds = { "t", "tas" }
    },
    {
        name = "TAS Faste",
        id = 21,
        mv = 10,
        timescale = 0.5,
        allow_timescale = true,
        allow_timetravel = true,
        keys = {
            w = 1,
            a = 1,
            s = 1,
            d = 1
        },
        cmds = { "tf", "tasfaste" }
    },
    {
        name = "Walk",
        id = 601,
        platform_stand_time = false,
        keys = {
            w = 0,
            a = 0,
            s = 0,
            d = 0
        },
        cmds = { "wa", "walk" }
    },
    {
        name = "Spicy Walk",
        id = 602,
        keys = {
            w = 0,
            a = 0,
            s = 0,
            d = 0
        },
        cmds = { "swa", "swalk", "spi" }
    }
};
local v6 = {};
local u7 = {};
for v8 = 1, #v5 do
    local v9 = v5[v8];
    v6[v9.id] = v9;
end;
local u10 = {};
u7.Type = u10;
local u11 = {
    [0] = {
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        16,
        17,
        20,
        21,
        501,
        502,
        503,
        504,
        505,
        601,
        602
    },
    [1] = {
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8
    },
    [2] = {
        1,
        3,
        4,
        5,
        6,
        7,
        8
    },
    [4] = { 1, 401 },
    [5] = {
        501,
        502,
        503,
        504,
        505
    }
};
u11[3] = u11[1];
local u12 = {};
for v13, v14 in u11 do
    local v15 = {};
    for v16 = 1, #v14 do
        v15[v14[v16]] = v6[v14[v16]];
    end;
    u12[v13] = v15;
end;
local v17 = l__clone__2(u4);
v17.gravity = Vector3.new(0, -50, 0);
local v18 = v6[4];
local v19 = l__clone__2(v18);
v19.keys = l__clone__2(v18.keys);
v19.keys.w = 1;
v19.keys.s = 1;
v19.total = 2;
u12[2][4] = v19;
local u20 = {
    [2] = v17
};
assert(l__GameID__7 ~= nil, "GameID cannot be nil");
local v21 = u20[l__GameID__7] or u4;
assert(l__GameID__7 ~= nil, "GameID cannot be nil");
l__clear__1(u10);
local u22 = v21;
for _, v23 in u12[l__GameID__7] do
    u10[v23.id] = v23;
end;
u7.DefaultStyle = u11[l__GameID__7][1];
local u24 = {
    [l__MODE_MAIN__5] = {
        name = "Main",
        id = l__MODE_MAIN__5
    },
    [l__MODE_BONUS__6] = {
        name = "Bonus",
        id = l__MODE_BONUS__6
    }
};
u7.Mode = u24;
local v25 = {};
for _, v26 in u10 do
    l__insert__3(v25, v26);
end;
table.sort(v25, function(p27, p28) --[[ Line: 530 ]]
    if p27 and p28 then
        return p27.id < p28.id;
    end;
end);
local v29 = {};
local v30 = {};
for v31 = 1, #v25 do
    local v32 = v25[v31];
    v29[v31] = v32.name;
    v30[v31] = v32.id;
end;
u7.Types = v25;
u7.TypeNames = v29;
u7.TypeNumberToId = v30;
local v33 = {};
for _, v34 in u24 do
    l__insert__3(v33, v34);
end;
table.sort(v33, function(p35, p36) --[[ Line: 550 ]]
    if p35 and p36 then
        return p35.id < p36.id;
    end;
end);
local v37 = {};
local v38 = {};
for v39 = 1, #v33 do
    local v40 = v33[v39];
    v37[v39] = v40.name;
    v38[v39] = v40.id;
end;
u7.Modes = v33;
u7.ModeNames = v37;
u7.ModeNumberToId = v38;
local v41 = {};
for _, v42 in u10 do
    l__insert__3(v41, {
        Mode = l__MODE_MAIN__5,
        Style = v42.id
    });
end;
l__insert__3(v41, {
    Mode = l__MODE_BONUS__6,
    Style = u7.DefaultStyle
});
u7.LoadModeStyleList = v41;
function u7.GetStyleName(p43) --[[ Line: 573 ]]
    -- upvalues: u10 (copy)
    local v44 = u10[p43];
    if v44 then
        return v44.name;
    end;
end;
function u7.GetModeName(p45) --[[ Line: 581 ]]
    -- upvalues: u24 (copy)
    local v46 = u24[p45];
    if v46 then
        return v46.name;
    else
        return "Bonus" .. p45;
    end;
end;
function u7.StyleStringFromTimeObject(p47) --[[ Line: 590 ]]
    -- upvalues: l__MODE_MAIN__5 (copy), u10 (copy), u24 (copy)
    local v48;
    if p47.Mode == l__MODE_MAIN__5 then
        local v49 = u10[p47.Style];
        if v49 then
            v48 = v49.name;
        else
            v48 = nil;
        end;
        if v48 then
            return v48;
        end;
    end;
    local l__Mode__10 = p47.Mode;
    local v50 = u24[l__Mode__10];
    local v51;
    if v50 then
        v51 = v50.name;
    else
        v51 = "Bonus" .. l__Mode__10;
    end;
    local v52 = "-";
    local v53 = u10[p47.Style];
    local v54;
    if v53 then
        v54 = v53.name;
    else
        v54 = nil;
    end;
    v48 = v51 .. v52 .. v54;
    return v48;
end;
function u7.GetStyle(p55) --[[ Line: 595 ]]
    -- upvalues: u10 (copy)
    for v56 = 1, #u10 do
        local v57 = u10[v56];
        if v57.id == p55 then
            return v56;
        end;
        if v57.name == p55 then
            return v56;
        end;
        local l__cmds__11 = v57.cmds;
        if l__cmds__11 then
            for v58 = 1, #l__cmds__11 do
                if l__cmds__11[v58] == p55 then
                    return v56;
                end;
            end;
        end;
    end;
end;
function u7.CreateStyleInfo(p59, p60) --[[ Line: 615 ]]
    -- upvalues: l__UseSpoofedGameIDForDefaultStyleInfo__9 (copy), u22 (ref), u20 (copy), u4 (copy), l__UseSpoofedGameIDForStyles__8 (copy), l__clear__1 (copy), u10 (copy), u12 (copy), u7 (copy), u11 (copy), l__clone__2 (copy), u1 (copy)
    if p60 then
        if l__UseSpoofedGameIDForDefaultStyleInfo__9 then
            assert(p60 ~= nil, "GameID cannot be nil");
            u22 = u20[p60] or u4;
        end;
        if l__UseSpoofedGameIDForStyles__8 then
            assert(p60 ~= nil, "GameID cannot be nil");
            l__clear__1(u10);
            for _, v61 in u12[p60] do
                u10[v61.id] = v61;
            end;
            u7.DefaultStyle = u11[p60][1];
        end;
    end;
    local v62 = u10[p59];
    if v62 then
        local v63 = l__clone__2(u22);
        u1(v62, v63);
        v63.gravity = v63.gravity_scale * v63.gravity;
        return v63;
    end;
end;
return u7;
