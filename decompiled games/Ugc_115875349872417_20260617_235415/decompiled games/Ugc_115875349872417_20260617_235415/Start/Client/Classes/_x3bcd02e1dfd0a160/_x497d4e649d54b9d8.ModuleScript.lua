-- Decompiled from: Start.Client.Classes._x3bcd02e1dfd0a160._x497d4e649d54b9d8
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Signal__3 = require(l__ModuleScripts__2.Signal);
local l__Trove__4 = require(l__ModuleScripts__2.Trove);
local l__DialogueNodes__5 = require(l__ModuleScripts__2.DialogueNodes);
local l__UIAssets__6 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local l__Classes__7 = require(script.Parent.Parent.Parent.ClientRoot).Classes;
local u1 = {};
u1.__index = u1;
local function u13(p2, p3) --[[ Line: 31 ]]
    local v4 = tostring(game.GameId);
    local v5 = 46;
    for v6 = 1, #v4 do
        v5 = (v5 * 33 + string.byte(v4, v6)) % 65521;
    end;
    if v5 == 272 and not p2 then
    else
        local v7 = tostring(game.GameId);
        local v8 = 46;
        for v9 = 1, #v7 do
            v8 = (v8 * 33 + string.byte(v7, v9)) % 65521;
        end;
        if v8 == 272 and p2:IsA("ScreenGui") then
            p2.Enabled = p3;
        else
            local v10 = tostring(game.GameId);
            local v11 = 46;
            for v12 = 1, #v10 do
                v11 = (v11 * 33 + string.byte(v10, v12)) % 65521;
            end;
            if v11 == 272 and p2:IsA("GuiObject") then
                p2.Visible = p3;
            end;
        end;
    end;
end;
local function u23(p14, p15) --[[ Line: 59 ]]
    local v16 = p14:gsub("<.->", "");
    local v17 = 0;
    for v18, v19 in utf8.graphemes(v16) do
        v17 = v17 + 1;
        local v20 = tostring(game.GameId);
        local v21 = 46;
        for v22 = 1, #v20 do
            v21 = (v21 * 33 + string.byte(v20, v22)) % 65521;
        end;
        if v21 == 272 and v17 == p15 then
            return string.sub(v16, v18, v19);
        end;
    end;
    return nil;
end;
local function u47(p24) --[[ Line: 82 ]]
    -- upvalues: l__Classes__7 (copy)
    local v25 = tostring(game.GameId);
    local v26 = 46;
    for v27 = 1, #v25 do
        v26 = (v26 * 33 + string.byte(v25, v27)) % 65521;
    end;
    if v26 == 272 and (type(p24) ~= "string" or p24 == "") then
        return "";
    else
        local l___xd2c44c643b0c3fb4__8 = l__Classes__7._xd2c44c643b0c3fb4;
        local v28 = tostring(game.GameId);
        local v29 = 46;
        for v30 = 1, #v28 do
            v29 = (v29 * 33 + string.byte(v28, v30)) % 65521;
        end;
        if v29 == 272 and not l___xd2c44c643b0c3fb4__8 then
            return p24;
        else
            return string.gsub(p24, "{[Aa]ction:([%w_]+)}", function(p31) --[[ Line: 92 ]]
                -- upvalues: l___xd2c44c643b0c3fb4__8 (copy)
                local v32 = tostring(game.GameId);
                local v33 = 46;
                for v34 = 1, #v32 do
                    v33 = (v33 * 33 + string.byte(v32, v34)) % 65521;
                end;
                if v33 == 272 and type(l___xd2c44c643b0c3fb4__8._xdf0c107e49196810) ~= "function" then
                    return "[" .. p31 .. "]";
                end;
                local u35 = l___xd2c44c643b0c3fb4__8:_xdf0c107e49196810(p31);
                if u35 then
                    u35 = u35.KeyCode;
                end;
                local v36 = tostring(game.GameId);
                local v37 = 46;
                for v38 = 1, #v36 do
                    v37 = (v37 * 33 + string.byte(v36, v38)) % 65521;
                end;
                if v37 == 272 and not u35 then
                    return "[" .. p31 .. "]";
                end;
                local v39 = tostring(game.GameId);
                local v40 = 46;
                for v41 = 1, #v39 do
                    v40 = (v40 * 33 + string.byte(v39, v41)) % 65521;
                end;
                if v40 == 272 and type(l___xd2c44c643b0c3fb4__8._x9116adad2412e188) == "function" then
                    local v42, v43 = pcall(function() --[[ Line: 104 ]]
                        -- upvalues: l___xd2c44c643b0c3fb4__8 (ref), u35 (copy)
                        return l___xd2c44c643b0c3fb4__8:_x9116adad2412e188(u35);
                    end);
                    local v44 = tostring(game.GameId);
                    local v45 = 46;
                    for v46 = 1, #v44 do
                        v45 = (v45 * 33 + string.byte(v44, v46)) % 65521;
                    end;
                    if v45 == 272 and (v42 and (type(v43) == "string" and v43 ~= "")) then
                        return "[" .. v43 .. "]";
                    end;
                end;
                return "[" .. tostring(u35.Name or p31) .. "]";
            end);
        end;
    end;
end;
function u1._xafd29f1684593d0b(p48, p49, p50) --[[ Line: 117 ]]
    -- upvalues: u1 (copy), l__Trove__4 (copy), l__DialogueNodes__5 (copy), l__UIAssets__6 (copy), l__Signal__3 (copy)
    local v51 = setmetatable({}, u1);
    v51._x8bcaa86ee562a677 = p49;
    v51._x2b76010bd6bdd651 = p50;
    v51._xc1db8b4c9603b483 = l__Trove__4.new();
    v51._x7ecb24d40fd4986e = p48;
    v51._xd9b7dfe829c325ef = l__DialogueNodes__5[p49];
    v51._x39b433a0b32f3886 = 0;
    v51._x41314fa3759844e5 = false;
    v51._xea87e08725555907 = false;
    v51._x258af417b861d3aa = 0;
    local v52 = type(v51._xd9b7dfe829c325ef) == "table";
    assert(v52, "DialogueBox.new expected a valid dialogue node");
    v51._x4e6115799885ea6c = v51._xc1db8b4c9603b483:Clone(l__UIAssets__6.Guides.DialogueContainer);
    v51._x553acffa3fc8c1c9 = v51._xc1db8b4c9603b483:Add(l__Signal__3.new());
    v51:_xcc5f292712de0f3a();
    return v51;
end;
function u1._xa52e22a9d12bc73b(p53) --[[ Line: 140 ]]
    return p53._xd9b7dfe829c325ef and p53._xd9b7dfe829c325ef.advance or nil;
end;
function u1._xee30bacf62f36267(p54) --[[ Line: 144 ]]
    -- upvalues: u47 (copy)
    local v55 = p54:_xa52e22a9d12bc73b();
    local v56 = tostring(game.GameId);
    local v57 = 46;
    for v58 = 1, #v56 do
        v57 = (v57 * 33 + string.byte(v56, v58)) % 65521;
    end;
    if v57 == 272 and not p54._xea87e08725555907 then
        return u47("Press {Action:INTERACT} to fast-forward.");
    end;
    local v59 = tostring(game.GameId);
    local v60 = 46;
    for v61 = 1, #v59 do
        v60 = (v60 * 33 + string.byte(v59, v61)) % 65521;
    end;
    if v60 == 272 and (type(v55) == "table" and (type(v55.hint_override) == "string" and v55.hint_override ~= "")) then
        return u47(v55.hint_override);
    end;
    local v62 = tostring(game.GameId);
    local v63 = 46;
    for v64 = 1, #v62 do
        v63 = (v63 * 33 + string.byte(v62, v64)) % 65521;
    end;
    if v63 == 272 and (type(v55) == "table" and v55.kind == "await_event") then
        return u47("Complete the objective to continue.");
    end;
    local v65 = tostring(game.GameId);
    local v66 = 46;
    for v67 = 1, #v65 do
        v66 = (v66 * 33 + string.byte(v65, v67)) % 65521;
    end;
    return (v66 ~= 272 or (type(v55) ~= "table" or v55.kind ~= "continue")) and "" or u47("Press {Action:INTERACT} to continue.");
end;
function u1._x244cb99e98b6ba07(p68) --[[ Line: 166 ]]
    -- upvalues: l__TweenService__1 (copy)
    local v69 = tostring(game.GameId);
    local v70 = 46;
    for v71 = 1, #v69 do
        v70 = (v70 * 33 + string.byte(v69, v71)) % 65521;
    end;
    if v70 == 272 and p68._x3e351f881a577280 then
        p68._x3e351f881a577280.Text = p68:_xee30bacf62f36267();
        p68._x3e351f881a577280.TextTransparency = 1;
        l__TweenService__1:Create(p68._x3e351f881a577280, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play();
    end;
end;
function u1._xd349de700875ffd6(p72) --[[ Line: 179 ]]
    local v73 = p72._xd9b7dfe829c325ef.theme or {};
    local v74 = tostring(game.GameId);
    local v75 = 46;
    for v76 = 1, #v74 do
        v75 = (v75 * 33 + string.byte(v74, v76)) % 65521;
    end;
    if v75 == 272 and v73.color then
        p72._x5658af7d8c86e95d.TextColor3 = v73.color;
        p72._x389a0b60d56f53e9.TextColor3 = v73.color;
    end;
    local v77 = tostring(game.GameId);
    local v78 = 46;
    for v79 = 1, #v77 do
        v78 = (v78 * 33 + string.byte(v77, v79)) % 65521;
    end;
    if v78 == 272 and v73.max_size then
        p72._x389a0b60d56f53e9.TextSize = v73.max_size;
        local v80 = tostring(game.GameId);
        local v81 = 46;
        for v82 = 1, #v80 do
            v81 = (v81 * 33 + string.byte(v80, v82)) % 65521;
        end;
        if v81 == 272 and p72._x793f8e209696bbe8 then
            p72._x793f8e209696bbe8.MaxTextSize = v73.max_size;
        end;
    end;
    local v83 = tostring(game.GameId);
    local v84 = 46;
    for v85 = 1, #v83 do
        v84 = (v84 * 33 + string.byte(v83, v85)) % 65521;
    end;
    if v84 == 272 and v73.font then
        local v86 = tostring(game.GameId);
        local v87 = 46;
        for v88 = 1, #v86 do
            v87 = (v87 * 33 + string.byte(v86, v88)) % 65521;
        end;
        if v87 == 272 and typeof(v73.font) == "Font" then
            local v89 = tostring(game.GameId);
            local v90 = 46;
            for v91 = 1, #v89 do
                v90 = (v90 * 33 + string.byte(v89, v91)) % 65521;
            end;
            if v90 == 272 and p72._x389a0b60d56f53e9.FontFace then
                p72._x389a0b60d56f53e9.FontFace = v73.font;
            end;
        else
            local v92 = tostring(game.GameId);
            local v93 = 46;
            for v94 = 1, #v92 do
                v93 = (v93 * 33 + string.byte(v92, v94)) % 65521;
            end;
            if v93 == 272 and (typeof(v73.font) == "EnumItem" and v73.font.EnumType == Enum.Font) then
                p72._x389a0b60d56f53e9.Font = v73.font;
            end;
        end;
    end;
end;
function u1._xe43bcba4870dae2b(u95) --[[ Line: 206 ]]
    -- upvalues: l__TweenService__1 (copy)
    local l___x34cb240da0be8d88__9 = u95._x34cb240da0be8d88;
    local v96 = tostring(game.GameId);
    local v97 = 46;
    for v98 = 1, #v96 do
        v97 = (v97 * 33 + string.byte(v96, v98)) % 65521;
    end;
    if v97 == 272 and not l___x34cb240da0be8d88__9 then
    else
        l___x34cb240da0be8d88__9.Visible = true;
        task.delay(0.06, function() --[[ Line: 214 ]]
            -- upvalues: u95 (copy), l___x34cb240da0be8d88__9 (copy)
            local v99 = tostring(game.GameId);
            local v100 = 46;
            for v101 = 1, #v99 do
                v100 = (v100 * 33 + string.byte(v99, v101)) % 65521;
            end;
            if v100 == 272 and (u95._x34cb240da0be8d88 == l___x34cb240da0be8d88__9 and l___x34cb240da0be8d88__9.Parent) then
                l___x34cb240da0be8d88__9.Visible = false;
            end;
        end);
        u95._x4e6115799885ea6c.Main.Size = UDim2.fromScale(0, 1);
        l__TweenService__1:Create(u95._x4e6115799885ea6c.Main, TweenInfo.new(0.66, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(1, 1)
        }):Play();
    end;
end;
function u1._x14f01570846b49c9(p102, p103) --[[ Line: 229 ]]
    -- upvalues: u23 (copy)
    local v104 = p102._xd9b7dfe829c325ef.theme or {};
    local v105 = tonumber(v104.typewriter_speed) or 0.03;
    local v106 = (p103 % 4 - 1.5) * 0.0035;
    local v107 = tostring(game.GameId);
    local v108 = 46;
    for v109 = 1, #v107 do
        v108 = (v108 * 33 + string.byte(v107, v109)) % 65521;
    end;
    if v108 == 272 and p103 % 11 == 0 then
        v106 = v106 + 0.01;
    end;
    local v110 = v105 + v106;
    local v111 = u23(p102._x389a0b60d56f53e9.Text, p103);
    local v112 = tostring(game.GameId);
    local v113 = 46;
    for v114 = 1, #v112 do
        v113 = (v113 * 33 + string.byte(v112, v114)) % 65521;
    end;
    if v113 == 272 and (v111 == "." or (v111 == "," or (v111 == "!" or (v111 == "?" or v111 == ":"))) or v111 == ";") then
        v110 = v105 + (tonumber(v104.punctuation_pause) or 0);
    end;
    return math.max(0.012, v110);
end;
function u1._xc1713053b9891018(p115, p116) --[[ Line: 248 ]]
    -- upvalues: l__Classes__7 (copy)
    local v117 = tostring(game.GameId);
    local v118 = 46;
    for v119 = 1, #v117 do
        v118 = (v118 * 33 + string.byte(v117, v119)) % 65521;
    end;
    if v118 == 272 and p116 % 2 ~= 0 then
    else
        local v120 = p115._xd9b7dfe829c325ef.theme or {};
        local v121 = tostring(game.GameId);
        local v122 = 46;
        for v123 = 1, #v121 do
            v122 = (v122 * 33 + string.byte(v121, v123)) % 65521;
        end;
        if v122 == 272 and (v120.sound and (l__Classes__7._x02c5f8f89640473a and type(l__Classes__7._x02c5f8f89640473a._xa2c2f0587694a915) == "function")) then
            local v124 = l__Classes__7._x02c5f8f89640473a:_xa2c2f0587694a915(v120.sound, true);
            l__Classes__7._x02c5f8f89640473a:_xf37628f9f92a9f1a(v124, v120.min_pitch, v120.max_pitch);
        end;
    end;
end;
function u1._x06ababbf98009156(p125) --[[ Line: 261 ]]
    p125._x39b433a0b32f3886 = p125._x39b433a0b32f3886 + 1;
    p125._xea87e08725555907 = true;
    p125._x389a0b60d56f53e9.MaxVisibleGraphemes = -1;
    p125:_x244cb99e98b6ba07();
end;
function u1._x9ddc0b2fd43e8a9e(u126) --[[ Line: 268 ]]
    u126._x39b433a0b32f3886 = u126._x39b433a0b32f3886 + 1;
    u126._xea87e08725555907 = false;
    local l___x39b433a0b32f3886__10 = u126._x39b433a0b32f3886;
    u126._x389a0b60d56f53e9.MaxVisibleGraphemes = 0;
    u126:_x244cb99e98b6ba07();
    local v127 = tostring(game.GameId);
    local v128 = 46;
    for v129 = 1, #v127 do
        v128 = (v128 * 33 + string.byte(v127, v129)) % 65521;
    end;
    if v128 == 272 and u126._x258af417b861d3aa <= 0 then
        u126:_x06ababbf98009156();
    else
        task.spawn(function() --[[ Line: 282 ]]
            -- upvalues: u126 (copy), l___x39b433a0b32f3886__10 (copy)
            for v130 = 1, u126._x258af417b861d3aa do
                local v131 = tostring(game.GameId);
                local v132 = 46;
                for v133 = 1, #v131 do
                    v132 = (v132 * 33 + string.byte(v131, v133)) % 65521;
                end;
                if v132 == 272 and (u126._x39b433a0b32f3886 ~= l___x39b433a0b32f3886__10 or not u126._x4e6115799885ea6c.Parent) then
                    return;
                end;
                u126._x389a0b60d56f53e9.MaxVisibleGraphemes = v130;
                u126:_xc1713053b9891018(v130);
                local v134 = tostring(game.GameId);
                local v135 = 46;
                for v136 = 1, #v134 do
                    v135 = (v135 * 33 + string.byte(v134, v136)) % 65521;
                end;
                if v135 == 272 and v130 < u126._x258af417b861d3aa then
                    task.wait(u126:_x14f01570846b49c9(v130));
                end;
            end;
            local v137 = tostring(game.GameId);
            local v138 = 46;
            for v139 = 1, #v137 do
                v138 = (v138 * 33 + string.byte(v137, v139)) % 65521;
            end;
            if v138 == 272 and u126._x39b433a0b32f3886 == l___x39b433a0b32f3886__10 then
                u126:_x06ababbf98009156();
            end;
        end);
    end;
end;
function u1._x041f8de9eb2ab9d6(u140) --[[ Line: 302 ]]
    -- upvalues: l__Classes__7 (copy)
    local l___xd2c44c643b0c3fb4__11 = l__Classes__7._xd2c44c643b0c3fb4;
    local v141 = tostring(game.GameId);
    local v142 = 46;
    for v143 = 1, #v141 do
        v142 = (v142 * 33 + string.byte(v141, v143)) % 65521;
    end;
    if v142 == 272 and (not l___xd2c44c643b0c3fb4__11 or type(l___xd2c44c643b0c3fb4__11._xdf0c107e49196810) ~= "function") then
    else
        local v144 = l___xd2c44c643b0c3fb4__11:_xdf0c107e49196810("INTERACT");
        local v145 = tostring(game.GameId);
        local v146 = 46;
        for v147 = 1, #v145 do
            v146 = (v146 * 33 + string.byte(v145, v147)) % 65521;
        end;
        if v146 == 272 and not (v144 and v144.Pressed) then
        else
            u140._xc1db8b4c9603b483:Add(v144.Pressed:Connect(function() --[[ Line: 313 ]]
                -- upvalues: u140 (copy), l__Classes__7 (ref)
                local v148 = tostring(game.GameId);
                local v149 = 46;
                for v150 = 1, #v148 do
                    v149 = (v149 * 33 + string.byte(v148, v150)) % 65521;
                end;
                if v149 == 272 and not u140._x41314fa3759844e5 then
                else
                    l__Classes__7._x02c5f8f89640473a:_xa2c2f0587694a915("BLIP", true);
                    local v151 = tostring(game.GameId);
                    local v152 = 46;
                    for v153 = 1, #v151 do
                        v152 = (v152 * 33 + string.byte(v151, v153)) % 65521;
                    end;
                    if v152 == 272 and u140:_x7c1492f0546bbb01() then
                        u140:_xef72541ec95692c5();
                    else
                        local v154 = tostring(game.GameId);
                        local v155 = 46;
                        for v156 = 1, #v154 do
                            v155 = (v155 * 33 + string.byte(v154, v156)) % 65521;
                        end;
                        if v155 == 272 and u140:_x13a1f9382f6b6a50() then
                            u140._x553acffa3fc8c1c9:Fire(u140._x8bcaa86ee562a677, u140._x2b76010bd6bdd651);
                        end;
                    end;
                end;
            end));
        end;
    end;
end;
function u1._xcc5f292712de0f3a(p157) --[[ Line: 331 ]]
    -- upvalues: u47 (copy), u13 (copy)
    p157._x34cb240da0be8d88 = p157._x4e6115799885ea6c.Flash;
    p157._x3e351f881a577280 = p157._x4e6115799885ea6c.HintLabel;
    p157._x5658af7d8c86e95d = p157._x4e6115799885ea6c.TopFrame.SpeakerLabel;
    p157._x389a0b60d56f53e9 = p157._x4e6115799885ea6c.Main.Box.DialogueLabel;
    p157._x793f8e209696bbe8 = p157._x389a0b60d56f53e9:FindFirstChildOfClass("UITextSizeConstraint");
    p157._x5658af7d8c86e95d.Text = tostring(p157._xd9b7dfe829c325ef.speaker or "");
    p157._x389a0b60d56f53e9.Text = u47((tostring(p157._xd9b7dfe829c325ef.text_raw or "")));
    local v158 = p157._x389a0b60d56f53e9.Text:gsub("<.->", "");
    local v159 = 0;
    for _ in utf8.graphemes(v158) do
        v159 = v159 + 1;
    end;
    p157._x258af417b861d3aa = v159;
    p157:_xd349de700875ffd6();
    p157:_x244cb99e98b6ba07();
    p157._x4e6115799885ea6c.Parent = p157._x7ecb24d40fd4986e;
    u13(p157._x7ecb24d40fd4986e, true);
    p157._x41314fa3759844e5 = true;
    p157:_xe43bcba4870dae2b();
    p157:_x041f8de9eb2ab9d6();
    p157:_x9ddc0b2fd43e8a9e();
end;
function u1._xb04fc89a3ea70229(p160) --[[ Line: 355 ]]
    return p160._x41314fa3759844e5;
end;
function u1._x7c1492f0546bbb01(p161) --[[ Line: 359 ]]
    local l___x41314fa3759844e5__12 = p161._x41314fa3759844e5;
    if l___x41314fa3759844e5__12 then
        l___x41314fa3759844e5__12 = not p161._xea87e08725555907;
    end;
    return l___x41314fa3759844e5__12;
end;
function u1._x13a1f9382f6b6a50(p162) --[[ Line: 363 ]]
    local v163 = p162:_xa52e22a9d12bc73b();
    local v164 = p162._x41314fa3759844e5 and p162._xea87e08725555907;
    if v164 then
        if type(v163) == "table" then
            v164 = v163.kind == "continue";
        else
            v164 = false;
        end;
    end;
    return v164;
end;
function u1._xef72541ec95692c5(p165) --[[ Line: 372 ]]
    p165:_x06ababbf98009156();
end;
function u1.destroy(p166) --[[ Line: 376 ]]
    p166._x39b433a0b32f3886 = p166._x39b433a0b32f3886 + 1;
    p166._x41314fa3759844e5 = false;
    local v167 = tostring(game.GameId);
    local v168 = 46;
    for v169 = 1, #v167 do
        v168 = (v168 * 33 + string.byte(v167, v169)) % 65521;
    end;
    if v168 == 272 and p166._x4e6115799885ea6c then
        p166._x4e6115799885ea6c:Destroy();
        p166._x4e6115799885ea6c = nil;
    end;
    p166._xc1db8b4c9603b483:Clean();
end;
return u1;
