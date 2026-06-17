-- Decompiled from: Start.Client.Classes._xf1ad98d2d70b7408
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets:WaitForChild("ModuleScripts");
local l__Signal__3 = require(l__ModuleScripts__2.Signal);
local u1 = {};
u1.__index = u1;
local u2 = false;
local l__Classes__4 = require(script.Parent.Parent.ClientRoot).Classes;
function u1._x83ed94bfb82a8c9f() --[[ Line: 34 ]]
    -- upvalues: u1 (copy), l__Signal__3 (copy)
    local v3 = setmetatable({}, u1);
    v3._x6f2fa52c1f2c55f9 = {};
    v3._xf23b77e3c359ad70 = {};
    v3._x32615503ed019f5b = {
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
    for v4, v5 in pairs(v3._x32615503ed019f5b) do
        local v6 = {
            Held = false,
            Enabled = true,
            KeyCode = v5[1],
            Context = v5[2],
            Blockers = {},
            Pressed = l__Signal__3.new(),
            Released = l__Signal__3.new()
        };
        v3._x6f2fa52c1f2c55f9[v4] = v6;
    end;
    return v3;
end;
function u1._x112ee96acc25a960(_, p7) --[[ Line: 87 ]]
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
function u1._x763b942ca9e02775(p8) --[[ Line: 99 ]]
    return p8._xf23b77e3c359ad70;
end;
function u1._xc3a3137d642c21e6(p9) --[[ Line: 103 ]]
    for v10, _ in p9._xf23b77e3c359ad70 do
        p9:_x9a7b8c3e8ffd27b6(v10, false);
    end;
    p9:_x9a7b8c3e8ffd27b6("universal", true);
end;
function u1._x9a7b8c3e8ffd27b6(u11, p12, p13) --[[ Line: 110 ]]
    -- upvalues: l__UserInputService__1 (copy)
    if u11._xf23b77e3c359ad70[p12] == p13 then
        print("returned", p12);
    else
        if p13 then
            local u14 = l__UserInputService__1:GetKeysPressed();
            task.defer(function() --[[ Line: 126 ]]
                -- upvalues: u14 (copy), u11 (copy)
                for _, v15 in u14 do
                    u11:_x910a1860f6fe9860(v15);
                end;
            end);
        else
            for _, v16 in pairs(u11._x6f2fa52c1f2c55f9) do
                if v16.Context == p12 and v16.Held then
                    v16.Held = false;
                    v16.Released:Fire();
                end;
            end;
        end;
        u11._xf23b77e3c359ad70[p12] = p13 == true and true or nil;
    end;
end;
function u1._x235841831c72ea6f(p17, p18) --[[ Line: 136 ]]
    -- upvalues: u2 (ref)
    if u2 == p18 then
    else
        u2 = p18;
        if u2 then
            for _, v19 in pairs(p17._x6f2fa52c1f2c55f9) do
                if v19.Held then
                    v19.Held = false;
                    v19.Released:Fire();
                end;
            end;
        end;
    end;
end;
function u1._x93fd21adac562b5e(p20, p21) --[[ Line: 151 ]]
    if p20._x6f2fa52c1f2c55f9[p21] then
        return p20._x6f2fa52c1f2c55f9[p21];
    end;
    warn("getAction FAILED FOR : ", p21);
end;
function u1._x9afb0bbcc2b58dcd(_, p22) --[[ Line: 159 ]]
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
function u1._x04d44a8b4905cf86(p24, p25, p26) --[[ Line: 181 ]]
    local v27 = p24._x6f2fa52c1f2c55f9[p25];
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
function u1._x9ae7704f928a015f(p28, p29) --[[ Line: 197 ]]
    local v30 = p28._x6f2fa52c1f2c55f9[p29];
    if v30 and v30.Held then
        v30.Held = false;
        v30.Released:Fire();
    end;
end;
function u1._x699126f0fae5b271(p31, p32, p33, p34) --[[ Line: 208 ]]
    local v35 = p31._x6f2fa52c1f2c55f9[p32];
    if v35 then
        if not p34 then
            for v36, v37 in pairs(p31._x6f2fa52c1f2c55f9) do
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
function u1._x910a1860f6fe9860(p38, p39) --[[ Line: 229 ]]
    -- upvalues: u2 (ref), l__Classes__4 (copy)
    if u2 then
    else
        local v40 = p38:_x112ee96acc25a960(p39);
        for _, v41 in pairs(p38._x6f2fa52c1f2c55f9) do
            if #v41.Blockers == 0 and (v41.Enabled and (v41.KeyCode == v40 and p38._xf23b77e3c359ad70[v41.Context])) then
                if (v41.Context == "active" or v41.Context == "movement") and (l__Classes__4._x1a4ce4062771e36e and (l__Classes__4._x1a4ce4062771e36e._xde8b8f659627fa3f and l__Classes__4._x1a4ce4062771e36e._xde8b8f659627fa3f.Anchored)) then
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
function u1._xda0973ce6c4216b1(p42, p43) --[[ Line: 249 ]]
    local v44 = p42:_x112ee96acc25a960(p43);
    for _, v45 in pairs(p42._x6f2fa52c1f2c55f9) do
        if v45.KeyCode == v44 and v45.Held then
            v45.Held = false;
            v45.Released:Fire();
        end;
    end;
end;
function u1._x44bcd6af41218f92(u46) --[[ Line: 262 ]]
    -- upvalues: l__UserInputService__1 (copy)
    u46:_x9a7b8c3e8ffd27b6("universal", true);
    l__UserInputService__1.InputBegan:Connect(function(p47, p48) --[[ Line: 265 ]]
        -- upvalues: u46 (copy)
        if p48 then
        else
            u46:_x910a1860f6fe9860(p47);
        end;
    end);
    l__UserInputService__1.InputEnded:Connect(function(p49) --[[ Line: 269 ]]
        -- upvalues: u46 (copy)
        u46:_xda0973ce6c4216b1(p49);
    end);
end;
return u1;
