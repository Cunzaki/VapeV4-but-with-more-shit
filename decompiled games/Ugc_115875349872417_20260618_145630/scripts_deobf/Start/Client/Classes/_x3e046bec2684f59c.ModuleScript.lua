-- Decompiled from: Start.Client.Classes._x3e046bec2684f59c
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets:WaitForChild("ModuleScripts");
local l__Signal__3 = require(l__ModuleScripts__2.Signal);
local u1 = {};
u1.__index = u1;
local u2 = false;
local l__Classes__4 = require(script.Parent.Parent.ClientRoot).Classes;
function u1._x90d4581ac99dd483() --[[ Line: 25 ]]
    -- upvalues: u1 (copy), l__Signal__3 (copy)
    local v3 = setmetatable({}, u1);
    v3._x24b501331259d581 = {};
    v3._x97e647b7a9d407c6 = {};
    v3._xaf67c8fd76efa090 = {
        MELEE = { Enum.KeyCode.MouseLeftButton, "active" },
        PARRY = { Enum.KeyCode.F, "active" },
        GUN = { Enum.KeyCode.Q, "active" },
        AUGMENT = { Enum.KeyCode.E, "active" },
        MENU_OPEN = { Enum.KeyCode.M, "active" },
        INTERACT = { Enum.KeyCode.R, "universal" },
        LEADERBOARD_OPEN = { Enum.KeyCode.Tab, "universal" },
        FORWARD = { Enum.KeyCode.W, "movement" },
        BACKWARD = { Enum.KeyCode.S, "movement" },
        LEFT = { Enum.KeyCode.A, "movement" },
        RIGHT = { Enum.KeyCode.D, "movement" },
        JUMP = { Enum.KeyCode.Space, "movement" },
        DASH = { Enum.KeyCode.LeftShift, "movement" },
        SLIDE = { Enum.KeyCode.LeftControl, "movement" }
    };
    for v4, v5 in pairs(v3._xaf67c8fd76efa090) do
        local v6 = {
            Held = false,
            Enabled = true,
            KeyCode = v5[1],
            Context = v5[2],
            Blockers = {},
            Pressed = l__Signal__3.new(),
            Released = l__Signal__3.new()
        };
        v3._x24b501331259d581[v4] = v6;
    end;
    return v3;
end;
function u1._xa9cc6ab994677574(_, p7) --[[ Line: 68 ]]
    if p7.KeyCode ~= Enum.KeyCode.Unknown then
        return p7.KeyCode;
    end;
    if p7.UserInputType == Enum.UserInputType.MouseButton1 then
        return Enum.KeyCode.MouseLeftButton;
    end;
    if p7.UserInputType == Enum.UserInputType.MouseButton2 then
        return Enum.KeyCode.MouseRightButton;
    end;
    if p7.UserInputType == Enum.UserInputType.MouseButton3 then
        return Enum.KeyCode.MouseMiddleButton;
    end;
end;
function u1._x61c57a82e02b88c2(p8) --[[ Line: 80 ]]
    return p8._x97e647b7a9d407c6;
end;
function u1._xb8c1a4d190637d84(p9) --[[ Line: 84 ]]
    for v10, _ in p9._x97e647b7a9d407c6 do
        p9:_x4c9977b827e9b5fa(v10, false);
    end;
    p9:_x4c9977b827e9b5fa("universal", true);
end;
function u1._x4c9977b827e9b5fa(u11, p12, p13) --[[ Line: 91 ]]
    -- upvalues: l__UserInputService__1 (copy)
    if u11._x97e647b7a9d407c6[p12] == p13 then
    else
        if p13 then
            local u14 = l__UserInputService__1:GetKeysPressed();
            task.defer(function() --[[ Line: 106 ]]
                -- upvalues: u14 (copy), u11 (copy)
                for _, v15 in u14 do
                    u11:_xf6dea22e71abdd09(v15);
                end;
            end;
        else
            for _, v16 in pairs(u11._x24b501331259d581) do
                if v16.Context == p12 and v16.Held then
                    v16.Held = false;
                    v16.Released:Fire();
                end;
            end;
        end;
        u11._x97e647b7a9d407c6[p12] = p13 == true and true or nil;
    end;
end;
function u1._xc7d90d6af08271a9(p17, p18) --[[ Line: 116 ]]
    -- upvalues: u2 (ref)
    if u2 == p18 then
    else
        u2 = p18;
        if u2 then
            for _, v19 in pairs(p17._x24b501331259d581) do
                if v19.Held then
                    v19.Held = false;
                    v19.Released:Fire();
                end;
            end;
        end;
    end;
end;
function u1._xc9966245cd0a44a8(p20, p21) --[[ Line: 131 ]]
    if p20._x24b501331259d581[p21] then
        return p20._x24b501331259d581[p21];
    end;
    warn("getAction FAILED FOR : ", p21);
end;
function u1._xfeef7f7b762e94d9(_, p22) --[[ Line: 139 ]]
    -- upvalues: l__UserInputService__1 (copy)
    if p22 == Enum.KeyCode.Space then
        return "Space";
    end;
    local v23 = l__UserInputService__1:GetStringForKeyCode(p22);
    if v23 == "" then
        v23 = p22.Name;
    end;
    return v23 == "MouseRightButton" and "RMB" or (v23 == "MouseLeftButton" and "LMB" or (v23 == "MouseMiddleButton" and "MMB" or v23));
end;
function u1._x845513e49e9d386b(p24, p25, p26) --[[ Line: 161 ]]
    local v27 = p24._x24b501331259d581[p25];
    if v27 then
        v27.Enabled = p26;
        if v27.Held and not p26 then
            v27.Held = false;
            v27.Released:Fire();
        end;
    else
        warn("SetActionEnabled FAILED FOR ", p25);
    end;
end;
function u1._xfb4a3db782d53e1e(p28, p29) --[[ Line: 177 ]]
    local v30 = p28._x24b501331259d581[p29];
    if v30 and v30.Held then
        v30.Held = false;
        v30.Released:Fire();
    end;
end;
function u1._xe8233003806bed87(p31, p32, p33, p34) --[[ Line: 188 ]]
    local v35 = p31._x24b501331259d581[p32];
    if v35 then
        if not p34 then
            for v36, v37 in pairs(p31._x24b501331259d581) do
                if v36 ~= p32 and v37.KeyCode == p33 then
                    warn("REBIND CONFICT IN CONTEXT \'" .. v35.Context .. "\': " .. v36 .. " AND " .. p32 .. " BOTH ON " .. p33.Name);
                    return nil;
                end;
            end;
        end;
        v35.KeyCode = p33;
        return v35;
    end;
    warn("NO SUCH ACTION : \'" .. p32 .. "\'");
end;
function u1._xf6dea22e71abdd09(p38, p39) --[[ Line: 209 ]]
    -- upvalues: u2 (ref), l__Classes__4 (copy)
    if u2 then
    else
        local v40 = p38:_xa9cc6ab994677574(p39);
        for _, v41 in pairs(p38._x24b501331259d581) do
            if #v41.Blockers == 0 and (v41.Enabled and (v41.KeyCode == v40 and p38._x97e647b7a9d407c6[v41.Context])) then
                if (v41.Context == "active" or v41.Context == "movement") and (l__Classes__4._x7058397dabccd000 and (l__Classes__4._x7058397dabccd000._x1cdffaf9f62b92e9 and l__Classes__4._x7058397dabccd000._x1cdffaf9f62b92e9.Anchored)) then
                    return;
                end;
                if not v41.Held then
                    v41.Held = true;
                    v41.Pressed:Fire();
                end;
            end;
        end;
    end;
end;
function u1._x9c11a0430ee7f3bd(p42, p43) --[[ Line: 229 ]]
    local v44 = p42:_xa9cc6ab994677574(p43);
    for _, v45 in pairs(p42._x24b501331259d581) do
        if v45.KeyCode == v44 and v45.Held then
            v45.Held = false;
            v45.Released:Fire();
        end;
    end;
end;
function u1._xe53615d96cf36a6b(u46) --[[ Line: 242 ]]
    -- upvalues: l__UserInputService__1 (copy)
    u46:_x4c9977b827e9b5fa("universal", true);
    l__UserInputService__1.InputBegan:Connect(function(p47, p48) --[[ Line: 245 ]]
        -- upvalues: u46 (copy)
        if p48 then
        else
            u46:_xf6dea22e71abdd09(p47);
        end;
    end;
    l__UserInputService__1.InputEnded:Connect(function(p49) --[[ Line: 249 ]]
        -- upvalues: u46 (copy)
        u46:_x9c11a0430ee7f3bd(p49);
    end;
end;
return u1;
