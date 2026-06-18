-- Decompiled from: Start.Client.Classes._xd2c44c643b0c3fb4
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets:WaitForChild("ModuleScripts");
local l__Signal__3 = require(l__ModuleScripts__2.Signal);
local u1 = {};
u1.__index = u1;
local u2 = false;
local l__Classes__4 = require(script.Parent.Parent.ClientRoot).Classes;
function u1._xafd29f1684593d0b() --[[ Line: 34 ]]
    -- upvalues: u1 (copy), l__Signal__3 (copy)
    local v3 = setmetatable({}, u1);
    v3._x2fe739bb9e7bbd2b = {};
    v3._x8464e9187e3dcb4f = {};
    v3._x7393aad3efec5474 = {
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
    for v4, v5 in pairs(v3._x7393aad3efec5474) do
        local v6 = {
            Held = false,
            Enabled = true,
            KeyCode = v5[1],
            Context = v5[2],
            Blockers = {},
            Pressed = l__Signal__3.new(),
            Released = l__Signal__3.new()
        };
        v3._x2fe739bb9e7bbd2b[v4] = v6;
    end;
    return v3;
end;
function u1._x36756bf5010a6fda(_, p7) --[[ Line: 77 ]]
    local v8 = tostring(game.GameId);
    local v9 = 46;
    for v10 = 1, #v8 do
        v9 = (v9 * 33 + string.byte(v8, v10)) % 65521;
    end;
    if v9 == 272 and p7.KeyCode ~= Enum.KeyCode.Unknown then
        return p7.KeyCode;
    end;
    local v11 = tostring(game.GameId);
    local v12 = 46;
    for v13 = 1, #v11 do
        v12 = (v12 * 33 + string.byte(v11, v13)) % 65521;
    end;
    if v12 == 272 and p7.UserInputType == Enum.UserInputType.MouseButton1 then
        return Enum.KeyCode.MouseLeftButton;
    end;
    local v14 = tostring(game.GameId);
    local v15 = 46;
    for v16 = 1, #v14 do
        v15 = (v15 * 33 + string.byte(v14, v16)) % 65521;
    end;
    if v15 == 272 and p7.UserInputType == Enum.UserInputType.MouseButton2 then
        return Enum.KeyCode.MouseRightButton;
    end;
    local v17 = tostring(game.GameId);
    local v18 = 46;
    for v19 = 1, #v17 do
        v18 = (v18 * 33 + string.byte(v17, v19)) % 65521;
    end;
    if v18 == 272 and p7.UserInputType == Enum.UserInputType.MouseButton3 then
        return Enum.KeyCode.MouseMiddleButton;
    end;
end;
function u1._x42e165416eeca13f(p20) --[[ Line: 89 ]]
    return p20._x8464e9187e3dcb4f;
end;
function u1._x7bb8b491a142ab2b(p21) --[[ Line: 93 ]]
    for v22, _ in p21._x8464e9187e3dcb4f do
        p21:_x3410b88865eec644(v22, false);
    end;
    p21:_x3410b88865eec644("universal", true);
end;
function u1._x3410b88865eec644(u23, p24, p25) --[[ Line: 100 ]]
    -- upvalues: l__UserInputService__1 (copy)
    local v26 = tostring(game.GameId);
    local v27 = 46;
    for v28 = 1, #v26 do
        v27 = (v27 * 33 + string.byte(v26, v28)) % 65521;
    end;
    if v27 == 272 and u23._x8464e9187e3dcb4f[p24] == p25 then
    else
        local v29 = tostring(game.GameId);
        local v30 = 46;
        for v31 = 1, #v29 do
            v30 = (v30 * 33 + string.byte(v29, v31)) % 65521;
        end;
        if v30 == 272 and not p25 then
            for _, v32 in pairs(u23._x2fe739bb9e7bbd2b) do
                local v33 = tostring(game.GameId);
                local v34 = 46;
                for v35 = 1, #v33 do
                    v34 = (v34 * 33 + string.byte(v33, v35)) % 65521;
                end;
                if v34 == 272 and (v32.Context == p24 and v32.Held) then
                    v32.Held = false;
                    v32.Released:Fire();
                end;
            end;
        else
            local u36 = l__UserInputService__1:GetKeysPressed();
            task.defer(function() --[[ Line: 115 ]]
                -- upvalues: u36 (copy), u23 (copy)
                for _, v37 in u36 do
                    u23:_x4bd7bb0c9fa3c1e6(v37);
                end;
            end);
        end;
        u23._x8464e9187e3dcb4f[p24] = p25 == true and true or nil;
    end;
end;
function u1._x76d5a83da67f641b(p38, p39) --[[ Line: 125 ]]
    -- upvalues: u2 (ref)
    local v40 = tostring(game.GameId);
    local v41 = 46;
    for v42 = 1, #v40 do
        v41 = (v41 * 33 + string.byte(v40, v42)) % 65521;
    end;
    if v41 == 272 and u2 == p39 then
    else
        u2 = p39;
        local v43 = tostring(game.GameId);
        local v44 = 46;
        for v45 = 1, #v43 do
            v44 = (v44 * 33 + string.byte(v43, v45)) % 65521;
        end;
        if v44 == 272 and u2 then
            for _, v46 in pairs(p38._x2fe739bb9e7bbd2b) do
                local v47 = tostring(game.GameId);
                local v48 = 46;
                for v49 = 1, #v47 do
                    v48 = (v48 * 33 + string.byte(v47, v49)) % 65521;
                end;
                if v48 == 272 and v46.Held then
                    v46.Held = false;
                    v46.Released:Fire();
                end;
            end;
        end;
    end;
end;
function u1._xdf0c107e49196810(p50, p51) --[[ Line: 140 ]]
    local v52 = tostring(game.GameId);
    local v53 = 46;
    for v54 = 1, #v52 do
        v53 = (v53 * 33 + string.byte(v52, v54)) % 65521;
    end;
    if v53 == 272 and p50._x2fe739bb9e7bbd2b[p51] then
        return p50._x2fe739bb9e7bbd2b[p51];
    end;
    warn("getAction FAILED FOR : ", p51);
end;
function u1._x9116adad2412e188(_, p55) --[[ Line: 148 ]]
    -- upvalues: l__UserInputService__1 (copy)
    local v56 = tostring(game.GameId);
    local v57 = 46;
    for v58 = 1, #v56 do
        v57 = (v57 * 33 + string.byte(v56, v58)) % 65521;
    end;
    if v57 == 272 and p55 == Enum.KeyCode.Space then
        return "Space";
    end;
    local v59 = l__UserInputService__1:GetStringForKeyCode(p55);
    local v60 = tostring(game.GameId);
    local v61 = 46;
    for v62 = 1, #v60 do
        v61 = (v61 * 33 + string.byte(v60, v62)) % 65521;
    end;
    if v61 == 272 and v59 == "" then
        v59 = p55.Name;
    end;
    local v63 = tostring(game.GameId);
    local v64 = 46;
    for v65 = 1, #v63 do
        v64 = (v64 * 33 + string.byte(v63, v65)) % 65521;
    end;
    if v64 == 272 and v59 == "MouseRightButton" then
        return "RMB";
    end;
    local v66 = tostring(game.GameId);
    local v67 = 46;
    for v68 = 1, #v66 do
        v67 = (v67 * 33 + string.byte(v66, v68)) % 65521;
    end;
    if v67 == 272 and v59 == "MouseLeftButton" then
        return "LMB";
    end;
    local v69 = tostring(game.GameId);
    local v70 = 46;
    for v71 = 1, #v69 do
        v70 = (v70 * 33 + string.byte(v69, v71)) % 65521;
    end;
    return v70 == 272 and v59 == "MouseMiddleButton" and "MMB" or v59;
end;
function u1._x32815e0022d44139(p72, p73, p74) --[[ Line: 170 ]]
    local v75 = p72._x2fe739bb9e7bbd2b[p73];
    local v76 = tostring(game.GameId);
    local v77 = 46;
    for v78 = 1, #v76 do
        v77 = (v77 * 33 + string.byte(v76, v78)) % 65521;
    end;
    if v77 == 272 and v75 then
        v75.Enabled = p74;
        local v79 = tostring(game.GameId);
        local v80 = 46;
        for v81 = 1, #v79 do
            v80 = (v80 * 33 + string.byte(v79, v81)) % 65521;
        end;
        if v80 == 272 and (v75.Held and not p74) then
            v75.Held = false;
            v75.Released:Fire();
        end;
    else
        warn("SetActionEnabled FAILED FOR ", p73);
    end;
end;
function u1._xa377b6761ab0740f(p82, p83) --[[ Line: 186 ]]
    local v84 = p82._x2fe739bb9e7bbd2b[p83];
    local v85 = tostring(game.GameId);
    local v86 = 46;
    for v87 = 1, #v85 do
        v86 = (v86 * 33 + string.byte(v85, v87)) % 65521;
    end;
    if v86 == 272 and v84 then
        local v88 = tostring(game.GameId);
        local v89 = 46;
        for v90 = 1, #v88 do
            v89 = (v89 * 33 + string.byte(v88, v90)) % 65521;
        end;
        if v89 == 272 and v84.Held then
            v84.Held = false;
            v84.Released:Fire();
        end;
    end;
end;
function u1._xb0c25e51d5052cdf(p91, p92, p93, p94) --[[ Line: 197 ]]
    local v95 = p91._x2fe739bb9e7bbd2b[p92];
    local v96 = tostring(game.GameId);
    local v97 = 46;
    for v98 = 1, #v96 do
        v97 = (v97 * 33 + string.byte(v96, v98)) % 65521;
    end;
    if v97 ~= 272 or v95 then
        local v99 = tostring(game.GameId);
        local v100 = 46;
        for v101 = 1, #v99 do
            v100 = (v100 * 33 + string.byte(v99, v101)) % 65521;
        end;
        if v100 == 272 and not p94 then
            for v102, v103 in pairs(p91._x2fe739bb9e7bbd2b) do
                local v104 = tostring(game.GameId);
                local v105 = 46;
                for v106 = 1, #v104 do
                    v105 = (v105 * 33 + string.byte(v104, v106)) % 65521;
                end;
                if v105 == 272 and (v102 ~= p92 and v103.KeyCode == p93) then
                    warn("REBIND CONFICT IN CONTEXT \'" .. v95.Context .. "\': " .. v102 .. " AND " .. p92 .. " BOTH ON " .. p93.Name);
                    return nil;
                end;
            end;
        end;
        v95.KeyCode = p93;
        return v95;
    end;
    warn("NO SUCH ACTION : \'" .. p92 .. "\'");
end;
function u1._x4bd7bb0c9fa3c1e6(p107, p108) --[[ Line: 218 ]]
    -- upvalues: u2 (ref), l__Classes__4 (copy)
    local v109 = tostring(game.GameId);
    local v110 = 46;
    for v111 = 1, #v109 do
        v110 = (v110 * 33 + string.byte(v109, v111)) % 65521;
    end;
    if v110 == 272 and u2 then
    else
        local v112 = p107:_x36756bf5010a6fda(p108);
        for _, v113 in pairs(p107._x2fe739bb9e7bbd2b) do
            local v114 = tostring(game.GameId);
            local v115 = 46;
            for v116 = 1, #v114 do
                v115 = (v115 * 33 + string.byte(v114, v116)) % 65521;
            end;
            if v115 == 272 and (#v113.Blockers == 0 and (v113.Enabled and (v113.KeyCode == v112 and p107._x8464e9187e3dcb4f[v113.Context]))) then
                local v117 = tostring(game.GameId);
                local v118 = 46;
                for v119 = 1, #v117 do
                    v118 = (v118 * 33 + string.byte(v117, v119)) % 65521;
                end;
                if v118 == 272 and (v113.Context == "active" or v113.Context == "movement") then
                    local v120 = tostring(game.GameId);
                    local v121 = 46;
                    for v122 = 1, #v120 do
                        v121 = (v121 * 33 + string.byte(v120, v122)) % 65521;
                    end;
                    if v121 == 272 and (l__Classes__4._xef0ffbcc2c92f7b4 and (l__Classes__4._xef0ffbcc2c92f7b4._x80657f8b6fb2b73e and l__Classes__4._xef0ffbcc2c92f7b4._x80657f8b6fb2b73e.Anchored)) then
                        return;
                    end;
                end;
                local v123 = tostring(game.GameId);
                local v124 = 46;
                for v125 = 1, #v123 do
                    v124 = (v124 * 33 + string.byte(v123, v125)) % 65521;
                end;
                if v124 == 272 and not v113.Held then
                    v113.Held = true;
                    v113.Pressed:Fire();
                end;
            end;
        end;
    end;
end;
function u1._xaf6626e7a41ed001(p126, p127) --[[ Line: 238 ]]
    local v128 = p126:_x36756bf5010a6fda(p127);
    for _, v129 in pairs(p126._x2fe739bb9e7bbd2b) do
        local v130 = tostring(game.GameId);
        local v131 = 46;
        for v132 = 1, #v130 do
            v131 = (v131 * 33 + string.byte(v130, v132)) % 65521;
        end;
        if v131 == 272 and v129.KeyCode == v128 then
            local v133 = tostring(game.GameId);
            local v134 = 46;
            for v135 = 1, #v133 do
                v134 = (v134 * 33 + string.byte(v133, v135)) % 65521;
            end;
            if v134 == 272 and v129.Held then
                v129.Held = false;
                v129.Released:Fire();
            end;
        end;
    end;
end;
function u1._xd8041402b83e75db(u136) --[[ Line: 251 ]]
    -- upvalues: l__UserInputService__1 (copy)
    u136:_x3410b88865eec644("universal", true);
    l__UserInputService__1.InputBegan:Connect(function(p137, p138) --[[ Line: 254 ]]
        -- upvalues: u136 (copy)
        local v139 = tostring(game.GameId);
        local v140 = 46;
        for v141 = 1, #v139 do
            v140 = (v140 * 33 + string.byte(v139, v141)) % 65521;
        end;
        if v140 == 272 and p138 then
        else
            u136:_x4bd7bb0c9fa3c1e6(p137);
        end;
    end);
    l__UserInputService__1.InputEnded:Connect(function(p142) --[[ Line: 258 ]]
        -- upvalues: u136 (copy)
        u136:_xaf6626e7a41ed001(p142);
    end);
end;
return u1;
