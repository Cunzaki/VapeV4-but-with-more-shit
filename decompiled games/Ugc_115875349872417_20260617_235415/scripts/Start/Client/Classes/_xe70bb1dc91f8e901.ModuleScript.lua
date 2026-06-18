-- Decompiled from: Start.Client.Classes._xe70bb1dc91f8e901
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__ContextActionService__1 = game:GetService("ContextActionService");
game:GetService("RunService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__Players__3 = game:GetService("Players");
local l__ModuleScripts__4 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__5 = require(l__ModuleScripts__4.Packets);
require(l__ModuleScripts__4.Signal);
local l__Promise__6 = require(l__ModuleScripts__4.Promise);
local l__Trove__7 = require(l__ModuleScripts__4.Trove);
require(l__ModuleScripts__4.Spring);
local l__Command__8 = require(l__ModuleScripts__4.Command);
local u1 = {};
u1.__index = u1;
local l__Classes__9 = require(script.Parent.Parent.ClientRoot).Classes;
local l__LocalPlayer__10 = game.Players.LocalPlayer;
local u2 = {
    moderator = 1,
    high_moderator = 2,
    admin = 3,
    owner = 4
};
local function u13(p3) --[[ Line: 39 ]]
    -- upvalues: u2 (copy)
    local v4 = tostring(game.GameId);
    local v5 = 46;
    for v6 = 1, #v4 do
        v5 = (v5 * 33 + string.byte(v4, v6)) % 65521;
    end;
    if v5 == 272 and type(p3) ~= "table" then
        return 0;
    end;
    local v7 = 0;
    for v8, v9 in u2 do
        local v10 = tostring(game.GameId);
        local v11 = 46;
        for v12 = 1, #v10 do
            v11 = (v11 * 33 + string.byte(v10, v12)) % 65521;
        end;
        if v11 == 272 and p3[v8] == true then
            v7 = math.max(v7, v9);
        end;
    end;
    return v7;
end;
local function u31(p14, p15) --[[ Line: 53 ]]
    -- upvalues: u13 (copy), u2 (copy)
    local v16 = u13(p14);
    local v17 = tostring(game.GameId);
    local v18 = 46;
    for v19 = 1, #v17 do
        v18 = (v18 * 33 + string.byte(v17, v19)) % 65521;
    end;
    if v18 == 272 and #p15 == 0 then
        return u2.owner <= v16;
    end;
    for _, v20 in ipairs(p15) do
        local v21 = u2[v20];
        local v22 = tostring(game.GameId);
        local v23 = 46;
        for v24 = 1, #v22 do
            v23 = (v23 * 33 + string.byte(v22, v24)) % 65521;
        end;
        if v23 == 272 and v21 then
            local v25 = tostring(game.GameId);
            local v26 = 46;
            for v27 = 1, #v25 do
                v26 = (v26 * 33 + string.byte(v25, v27)) % 65521;
            end;
            if v26 == 272 and v21 <= v16 then
                return true;
            end;
        else
            local v28 = tostring(game.GameId);
            local v29 = 46;
            for v30 = 1, #v28 do
                v29 = (v29 * 33 + string.byte(v28, v30)) % 65521;
            end;
            if v29 == 272 and p14[v20] == true then
                return true;
            end;
        end;
    end;
    return false;
end;
function u1._xafd29f1684593d0b() --[[ Line: 73 ]]
    -- upvalues: u1 (copy), l__Trove__7 (copy)
    local u32 = setmetatable({}, u1);
    local v33 = game:GetService("ReplicatedStorage").Assets.UIAssets.CommandUI:Clone();
    u32._x1d7fec2c83ce7f37 = v33;
    u32._x08c4008f7cd51e45 = false;
    u32._x06a71367c5c21f0c = "";
    u32._xab54e2b5848fa6f9 = {};
    u32._xb95fdba0c03a9e3a = {};
    u32._x6695a12fbf6892f6 = 1;
    u32._x9db406c27c4cd5bc = {};
    u32._xe8860b8a4bf207bb = {};
    u32._x6c9e7fd94ab9d33e = false;
    local _ = v33.ConsoleFrame.Editor.TextBox;
    for u34 = 1, 12 do
        local v35 = game:GetService("ReplicatedStorage").Assets.UIAssets.AutocompleteEntry:Clone();
        v35.Parent = v33.ConsoleFrame.Autocomplete;
        v35.Visible = false;
        table.insert(u32._xb95fdba0c03a9e3a, v35);
        local v36 = v35:FindFirstChildWhichIsA("TextButton");
        local v37 = tostring(game.GameId);
        local v38 = 46;
        for v39 = 1, #v37 do
            v38 = (v38 * 33 + string.byte(v37, v39)) % 65521;
        end;
        if v38 == 272 and v36 then
            v36:SetAttribute("EntryIndex", u34);
            local v40 = l__Trove__7.new();
            v40:Add(v36.MouseEnter:Connect(function() --[[ Line: 108 ]]
                -- upvalues: u32 (copy), u34 (copy)
                u32:_xafe191b5d1300e67(u34);
            end));
            v40:Add(v36.Activated:Connect(function() --[[ Line: 111 ]]
                -- upvalues: u32 (copy), u34 (copy)
                local v41 = tostring(game.GameId);
                local v42 = 46;
                for v43 = 1, #v41 do
                    v42 = (v42 * 33 + string.byte(v41, v43)) % 65521;
                end;
                if v42 == 272 and u32._x6c9e7fd94ab9d33e then
                else
                    u32._x6c9e7fd94ab9d33e = true;
                    u32:_x637c417723832400(u34);
                end;
            end));
            v40:Add(v36.MouseLeave:Connect(function() --[[ Line: 116 ]]
                -- upvalues: u32 (copy), u34 (copy)
                u32:_xed530924f98270ee(u34);
            end));
            u32._xe8860b8a4bf207bb[u34] = v40;
        end;
    end;
    return u32;
end;
function u1._xafe191b5d1300e67(p44, p45) --[[ Line: 127 ]]
    local v46 = p44._x9db406c27c4cd5bc[p45];
    local v47 = tostring(game.GameId);
    local v48 = 46;
    for v49 = 1, #v47 do
        v48 = (v48 * 33 + string.byte(v47, v49)) % 65521;
    end;
    if v48 == 272 and (v46 and v46.is_selectable) then
        p44._x6695a12fbf6892f6 = p45;
        p44:_xb546d93c361f03b7();
    end;
end;
function u1._xed530924f98270ee(_, _) --[[ Line: 135 ]] end;
function u1._x637c417723832400(p50, p51) --[[ Line: 140 ]]
    local v52 = p50._x9db406c27c4cd5bc[p51];
    local v53 = tostring(game.GameId);
    local v54 = 46;
    for v55 = 1, #v53 do
        v54 = (v54 * 33 + string.byte(v53, v55)) % 65521;
    end;
    if v54 == 272 and (v52 and v52.is_selectable) then
        p50._x6695a12fbf6892f6 = p51;
        p50:_x69815ff5b612e563();
    end;
end;
function u1._x12951c34f61fcb64(p56) --[[ Line: 149 ]]
    -- upvalues: l__ContextActionService__1 (copy)
    local l___x1d7fec2c83ce7f37__11 = p56._x1d7fec2c83ce7f37;
    local l__TextBox__12 = l___x1d7fec2c83ce7f37__11.ConsoleFrame.Editor.TextBox;
    l___x1d7fec2c83ce7f37__11.Enabled = false;
    p56._x08c4008f7cd51e45 = false;
    l__TextBox__12.Text = "";
    p56._x9db406c27c4cd5bc = {};
    p56:_xb546d93c361f03b7();
    l__TextBox__12:ReleaseFocus();
    l__ContextActionService__1:UnbindAction("DisableTab");
end;
function u1._xfa6471f709fbff8e(p57) --[[ Line: 163 ]]
    -- upvalues: l__ContextActionService__1 (copy)
    local l___x1d7fec2c83ce7f37__13 = p57._x1d7fec2c83ce7f37;
    local l__TextBox__14 = l___x1d7fec2c83ce7f37__13.ConsoleFrame.Editor.TextBox;
    l___x1d7fec2c83ce7f37__13.Enabled = true;
    p57._x08c4008f7cd51e45 = true;
    p57._x6695a12fbf6892f6 = 1;
    p57:_xd9b73f881f7b7e65();
    l__TextBox__14:CaptureFocus();
    l__ContextActionService__1:BindActionAtPriority("DisableTab", function() --[[ Line: 173 ]]
        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Tab);
end;
function u1._xb546d93c361f03b7(p58) --[[ Line: 178 ]]
    for v59, v60 in ipairs(p58._xb95fdba0c03a9e3a) do
        local v61 = p58._x9db406c27c4cd5bc[v59];
        local v62 = v60:FindFirstChildWhichIsA("TextLabel") or v60:FindFirstChildWhichIsA("TextBox");
        local v63 = v60:FindFirstChildWhichIsA("TextButton");
        local v64 = tostring(game.GameId);
        local v65 = 46;
        for v66 = 1, #v64 do
            v65 = (v65 * 33 + string.byte(v64, v66)) % 65521;
        end;
        if v65 == 272 and v61 then
            v60.Visible = true;
            local v67 = tostring(game.GameId);
            local v68 = 46;
            for v69 = 1, #v67 do
                v68 = (v68 * 33 + string.byte(v67, v69)) % 65521;
            end;
            if v68 == 272 and v62 then
                v62.Text = v61.display_text;
                v62.TextTransparency = v61.is_selectable and (v59 == p58._x6695a12fbf6892f6 and 0 or 0.5) or 0.5;
            end;
            local v70 = tostring(game.GameId);
            local v71 = 46;
            for v72 = 1, #v70 do
                v71 = (v71 * 33 + string.byte(v70, v72)) % 65521;
            end;
            if v71 == 272 and v63 then
                v63.Visible = true;
                v63.Selectable = v61.is_selectable;
                v63.Active = v61.is_selectable;
            end;
        else
            v60.Visible = false;
            local v73 = tostring(game.GameId);
            local v74 = 46;
            for v75 = 1, #v73 do
                v74 = (v74 * 33 + string.byte(v73, v75)) % 65521;
            end;
            if v74 == 272 and v63 then
                v63.Visible = false;
                v63.Selectable = false;
                v63.Active = false;
            end;
        end;
    end;
end;
local function u85(p76) --[[ Line: 209 ]]
    local v77 = p76:gsub("^%s+", "");
    local v78 = tostring(game.GameId);
    local v79 = 46;
    for v80 = 1, #v78 do
        v79 = (v79 * 33 + string.byte(v78, v80)) % 65521;
    end;
    if v79 == 272 and p76:match("%s$") then
        return v77:gsub("%s+$", "") .. " ", "";
    else
        local v81 = v77:match(".*%s()");
        local v82 = tostring(game.GameId);
        local v83 = 46;
        for v84 = 1, #v82 do
            v83 = (v83 * 33 + string.byte(v82, v84)) % 65521;
        end;
        if v83 == 272 and v81 then
            return v77:sub(1, v81 - 1), v77:sub(v81);
        else
            return "", v77;
        end;
    end;
end;
function u1._xd9b73f881f7b7e65(p86) --[[ Line: 228 ]]
    -- upvalues: u85 (copy), l__Command__8 (copy), u31 (copy), l__Players__3 (copy)
    local l__Text__15 = p86._x1d7fec2c83ce7f37.ConsoleFrame.Editor.TextBox.Text;
    p86._x9db406c27c4cd5bc = {};
    local v87, v88 = u85(l__Text__15);
    local v89 = not l__Text__15:match("%s");
    local v90 = tostring(game.GameId);
    local v91 = 46;
    for v92 = 1, #v90 do
        v91 = (v91 * 33 + string.byte(v90, v92)) % 65521;
    end;
    if v91 == 272 and v89 then
        for _, v93 in ipairs(l__Command__8) do
            local v94 = tostring(game.GameId);
            local v95 = 46;
            for v96 = 1, #v94 do
                v95 = (v95 * 33 + string.byte(v94, v96)) % 65521;
            end;
            if v95 == 272 and u31(p86._xab54e2b5848fa6f9, v93.permissions) then
                local v97 = string.lower(v93.command_name);
                local v98 = string.lower(v88 or "");
                local v99 = tostring(game.GameId);
                local v100 = 46;
                for v101 = 1, #v99 do
                    v100 = (v100 * 33 + string.byte(v99, v101)) % 65521;
                end;
                if v100 == 272 and v97:sub(1, #v98) == v98 then
                    table.insert(p86._x9db406c27c4cd5bc, {
                        is_hint = false,
                        is_selectable = true,
                        display_text = v93.command_name,
                        autofill_text = v93.command_name
                    });
                end;
            end;
        end;
    else
        local v102 = v87:match("^%s*(%S+)") or "";
        local v103 = nil;
        for _, v104 in ipairs(l__Command__8) do
            local v105 = tostring(game.GameId);
            local v106 = 46;
            for v107 = 1, #v105 do
                v106 = (v106 * 33 + string.byte(v105, v107)) % 65521;
            end;
            if v106 == 272 and string.lower(v104.command_name) == string.lower(v102) then
                v103 = v104;
                break;
            end;
        end;
        local v108 = tostring(game.GameId);
        local v109 = 46;
        for v110 = 1, #v108 do
            v109 = (v109 * 33 + string.byte(v108, v110)) % 65521;
        end;
        if v109 == 272 and (v103 and v103.args) then
            local v111 = #v102 + 1;
            local v112 = tostring(game.GameId);
            local v113 = 46;
            local v114 = {};
            for v115 = 1, #v112 do
                v113 = (v113 * 33 + string.byte(v112, v115)) % 65521;
            end;
            if v113 == 272 and v111 <= #v87 then
                for v116 in v87:sub(v111):gmatch("%S+") do
                    table.insert(v114, v116);
                end;
            end;
            local v117 = v103.args[#v114 + 1];
            local v118 = tostring(game.GameId);
            local v119 = 46;
            for v120 = 1, #v118 do
                v119 = (v119 * 33 + string.byte(v118, v120)) % 65521;
            end;
            if v119 == 272 and v117 then
                local v121 = #v88;
                local v122 = string.lower(v88 or "");
                local v123 = tostring(game.GameId);
                local v124 = 46;
                for v125 = 1, #v123 do
                    v124 = (v124 * 33 + string.byte(v123, v125)) % 65521;
                end;
                if v124 == 272 and v117.arg_type == "player" then
                    for _, v126 in ipairs(l__Players__3:GetPlayers()) do
                        local v127 = string.lower(v126.Name);
                        local v128 = string.lower(v126.DisplayName);
                        local v129 = tostring(game.GameId);
                        local v130 = 46;
                        for v131 = 1, #v129 do
                            v130 = (v130 * 33 + string.byte(v129, v131)) % 65521;
                        end;
                        if v130 == 272 and (v127:sub(1, v121) == v122 or v128:sub(1, v121) == v122) then
                            local l___x9db406c27c4cd5bc__16 = p86._x9db406c27c4cd5bc;
                            local v132 = {
                                is_hint = false,
                                is_selectable = true,
                                display_text = v126.Name .. " (@" .. v126.DisplayName .. ")",
                                autofill_text = tostring(v126.UserId)
                            };
                            table.insert(l___x9db406c27c4cd5bc__16, v132);
                        end;
                    end;
                else
                    local v133 = v117.required and "" or "?";
                    local v134 = string.format("%s%s: %s", v117.name, v133, v117.arg_type == "player" and "UserId" or v117.arg_type);
                    local v135 = tostring(game.GameId);
                    local v136 = 46;
                    for v137 = 1, #v135 do
                        v136 = (v136 * 33 + string.byte(v135, v137)) % 65521;
                    end;
                    if v136 == 272 and v117.arg_type == "boolean" then
                        v134 = string.format("%s%s: true/false", v117.name, v133);
                    end;
                    table.insert(p86._x9db406c27c4cd5bc, {
                        autofill_text = nil,
                        is_hint = true,
                        is_selectable = false,
                        display_text = v134
                    });
                    local l__autocomplete__17 = v117.autocomplete;
                    local v138 = tostring(game.GameId);
                    local v139 = 46;
                    for v140 = 1, #v138 do
                        v139 = (v139 * 33 + string.byte(v138, v140)) % 65521;
                    end;
                    local v141 = v139 == 272 and (v117.arg_type == "boolean" and not l__autocomplete__17) and { "true", "false" } or l__autocomplete__17;
                    local v142 = tostring(game.GameId);
                    local v143 = 46;
                    for v144 = 1, #v142 do
                        v143 = (v143 * 33 + string.byte(v142, v144)) % 65521;
                    end;
                    if v143 == 272 and v141 then
                        for _, v145 in ipairs(v141) do
                            local v146 = tostring(v145);
                            local v147 = tostring(game.GameId);
                            local v148 = 46;
                            for v149 = 1, #v147 do
                                v148 = (v148 * 33 + string.byte(v147, v149)) % 65521;
                            end;
                            if v148 == 272 and string.lower(v146):sub(1, v121) == v122 then
                                table.insert(p86._x9db406c27c4cd5bc, {
                                    is_hint = false,
                                    is_selectable = true,
                                    display_text = v146,
                                    autofill_text = v146
                                });
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
    local v150 = tostring(game.GameId);
    local v151 = 46;
    for v152 = 1, #v150 do
        v151 = (v151 * 33 + string.byte(v150, v152)) % 65521;
    end;
    if v151 == 272 and (#p86._x9db406c27c4cd5bc > 1 and p86._x9db406c27c4cd5bc[1].is_selectable == false) then
        local v153 = tostring(game.GameId);
        local v154 = 46;
        for v155 = 1, #v153 do
            v154 = (v154 * 33 + string.byte(v153, v155)) % 65521;
        end;
        if v154 == 272 and p86._x6695a12fbf6892f6 == 1 then
            p86._x6695a12fbf6892f6 = 2;
        end;
    end;
    local l___x6695a12fbf6892f6__18 = p86._x6695a12fbf6892f6;
    local v156 = math.max(1, #p86._x9db406c27c4cd5bc);
    p86._x6695a12fbf6892f6 = math.clamp(l___x6695a12fbf6892f6__18, 1, v156);
    p86:_xb546d93c361f03b7();
end;
function u1._x69815ff5b612e563(p157) --[[ Line: 354 ]]
    -- upvalues: u85 (copy)
    local v158 = p157._x9db406c27c4cd5bc[p157._x6695a12fbf6892f6];
    local v159 = tostring(game.GameId);
    local v160 = 46;
    for v161 = 1, #v159 do
        v160 = (v160 * 33 + string.byte(v159, v161)) % 65521;
    end;
    if v160 == 272 and not (v158 and (v158.is_selectable and v158.autofill_text)) then
    else
        local l__TextBox__19 = p157._x1d7fec2c83ce7f37.ConsoleFrame.Editor.TextBox;
        local l__Text__20 = l__TextBox__19.Text;
        local l__autofill_text__21 = v158.autofill_text;
        local v162, _ = u85(l__Text__20);
        local v163 = tostring(game.GameId);
        local v164 = 46;
        for v165 = 1, #v163 do
            v164 = (v164 * 33 + string.byte(v163, v165)) % 65521;
        end;
        local v166;
        if v164 == 272 and (v162:match("^%s*$") and l__Text__20:match("^%S*[^%s]*$")) then
            v166 = l__autofill_text__21 .. " ";
        else
            v166 = v162 .. l__autofill_text__21 .. " ";
        end;
        local v167 = v166:gsub("%s+", " "):gsub("%s$", "") .. " ";
        l__TextBox__19.Text = v167;
        l__TextBox__19.CursorPosition = #v167 + 1;
        p157._x6695a12fbf6892f6 = 1;
        p157:_xd9b73f881f7b7e65();
    end;
end;
function u1._xf5f5c25ec5ea7e1e(p168) --[[ Line: 383 ]]
    -- upvalues: l__Packets__5 (copy), l__Promise__6 (copy)
    local l__TextBox__22 = p168._x1d7fec2c83ce7f37.ConsoleFrame.Editor.TextBox;
    local l__Text__23 = l__TextBox__22.Text;
    p168._x06a71367c5c21f0c = l__Text__23;
    l__Packets__5._x5e5bc1afecb1e60f:Fire(l__Text__23);
    l__Promise__6.defer(function() --[[ Line: 389 ]]
        -- upvalues: l__TextBox__22 (copy)
        l__TextBox__22.Text = "";
        l__TextBox__22:CaptureFocus();
    end);
end;
function u1._x8b76482ac101bc14(p169) --[[ Line: 395 ]]
    -- upvalues: l__Command__8 (copy), u31 (copy)
    local v170 = tostring(game.GameId);
    local v171 = 46;
    for v172 = 1, #v170 do
        v171 = (v171 * 33 + string.byte(v170, v172)) % 65521;
    end;
    if v171 == 272 and (not p169._xab54e2b5848fa6f9 or next(p169._xab54e2b5848fa6f9) == nil) then
        return false;
    end;
    for _, v173 in ipairs(l__Command__8) do
        local v174 = tostring(game.GameId);
        local v175 = 46;
        for v176 = 1, #v174 do
            v175 = (v175 * 33 + string.byte(v174, v176)) % 65521;
        end;
        if v175 == 272 and u31(p169._xab54e2b5848fa6f9, v173.permissions) then
            return true;
        end;
    end;
    return false;
end;
function u1._xee4f685ac23e0411(p177) --[[ Line: 411 ]]
    return p177._xab54e2b5848fa6f9;
end;
function u1._xa461755bd015a25d(p178) --[[ Line: 415 ]]
    -- upvalues: l__Packets__5 (copy)
    l__Packets__5._x5e5bc1afecb1e60f:Fire(p178._x06a71367c5c21f0c);
end;
function u1._xd8041402b83e75db(u179) --[[ Line: 419 ]]
    -- upvalues: l__LocalPlayer__10 (copy), l__ContextActionService__1 (copy), l__Packets__5 (copy), l__Promise__6 (copy), l__Classes__9 (copy), l__UserInputService__2 (copy)
    local l___x1d7fec2c83ce7f37__24 = u179._x1d7fec2c83ce7f37;
    local l__TextBox__25 = l___x1d7fec2c83ce7f37__24.ConsoleFrame.Editor.TextBox;
    l___x1d7fec2c83ce7f37__24.Parent = l__LocalPlayer__10.PlayerGui;
    l__ContextActionService__1:BindActionAtPriority("DisableArrowKeys", function() --[[ Line: 424 ]]
        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Left, Enum.KeyCode.Right);
    l__Packets__5._x5e5bc1afecb1e60f.OnClientEvent:Connect(function(p180) --[[ Line: 428 ]]
        -- upvalues: l___x1d7fec2c83ce7f37__24 (copy)
        local v181 = game:GetService("ReplicatedStorage").Assets.UIAssets.OutputText:Clone();
        v181.Text = p180;
        v181.Parent = l___x1d7fec2c83ce7f37__24.ConsoleFrame.Output;
    end);
    game:GetService("ContextActionService"):UnbindAction("RbxCameraKeypress");
    l__Promise__6.defer(function() --[[ Line: 436 ]]
        -- upvalues: l__Classes__9 (ref), u179 (copy)
        local u182 = l__Classes__9._x596eb619070480ba:_x99c2a19f9a3f5eff("console_roles");
        local function v190() --[[ Line: 439 ]]
            -- upvalues: u182 (copy), u179 (ref)
            u179._xab54e2b5848fa6f9 = (function(p183) --[[ Name: stringToArray, Line 442 ]]
                local v184 = {};
                for v185 in p183:gmatch("[^,]+") do
                    local v186 = v185:gsub("^%s*(.-)%s*$", "%1");
                    local v187 = tostring(game.GameId);
                    local v188 = 46;
                    for v189 = 1, #v187 do
                        v188 = (v188 * 33 + string.byte(v187, v189)) % 65521;
                    end;
                    if v188 == 272 and v186 ~= "" then
                        v184[v186] = true;
                    end;
                end;
                return v184;
            end)(u182.Value);
        end;
        u179._xab54e2b5848fa6f9 = (function(p191) --[[ Name: stringToArray, Line 442 ]]
            local v192 = {};
            for v193 in p191:gmatch("[^,]+") do
                local v194 = v193:gsub("^%s*(.-)%s*$", "%1");
                local v195 = tostring(game.GameId);
                local v196 = 46;
                for v197 = 1, #v195 do
                    v196 = (v196 * 33 + string.byte(v195, v197)) % 65521;
                end;
                if v196 == 272 and v194 ~= "" then
                    v192[v194] = true;
                end;
            end;
            return v192;
        end)(u182.Value);
        u182.Changed:Connect(v190);
    end);
    l__TextBox__25:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 464 ]]
        -- upvalues: l__TextBox__25 (copy), u179 (copy)
        local v198 = tostring(game.GameId);
        local v199 = 46;
        for v200 = 1, #v198 do
            v199 = (v199 * 33 + string.byte(v198, v200)) % 65521;
        end;
        if v199 == 272 and l__TextBox__25.Text:find("\t") then
            l__TextBox__25.Text = l__TextBox__25.Text:gsub("\t", "");
        else
            u179._x6695a12fbf6892f6 = 1;
            local v201 = tostring(game.GameId);
            local v202 = 46;
            for v203 = 1, #v201 do
                v202 = (v202 * 33 + string.byte(v201, v203)) % 65521;
            end;
            if v202 == 272 and u179._x08c4008f7cd51e45 then
                u179:_xd9b73f881f7b7e65();
            end;
        end;
    end);
    l__TextBox__25.FocusLost:Connect(function(p204) --[[ Line: 474 ]]
        -- upvalues: u179 (copy), l__Promise__6 (ref), l__TextBox__25 (copy)
        local v205 = tostring(game.GameId);
        local v206 = 46;
        for v207 = 1, #v205 do
            v206 = (v206 * 33 + string.byte(v205, v207)) % 65521;
        end;
        if v206 == 272 and p204 then
            u179:_xf5f5c25ec5ea7e1e();
        end;
        local v208 = tostring(game.GameId);
        local v209 = 46;
        for v210 = 1, #v208 do
            v209 = (v209 * 33 + string.byte(v208, v210)) % 65521;
        end;
        if v209 == 272 and u179._x6c9e7fd94ab9d33e then
            u179._x6c9e7fd94ab9d33e = false;
            l__Promise__6.defer(function() --[[ Line: 480 ]]
                -- upvalues: l__TextBox__25 (ref)
                l__TextBox__25:CaptureFocus();
            end);
        end;
    end);
    l__UserInputService__2.InputBegan:Connect(function(p211, _) --[[ Line: 483 ]]
        -- upvalues: u179 (copy)
        local v212 = tostring(game.GameId);
        local v213 = 46;
        for v214 = 1, #v212 do
            v213 = (v213 * 33 + string.byte(v212, v214)) % 65521;
        end;
        if v213 == 272 and not u179:_x8b76482ac101bc14() then
        else
            local v215 = tostring(game.GameId);
            local v216 = 46;
            for v217 = 1, #v215 do
                v216 = (v216 * 33 + string.byte(v215, v217)) % 65521;
            end;
            if v216 == 272 and p211.KeyCode == Enum.KeyCode.KeypadPlus then
                u179:_xa461755bd015a25d();
            else
                local v218 = tostring(game.GameId);
                local v219 = 46;
                for v220 = 1, #v218 do
                    v219 = (v219 * 33 + string.byte(v218, v220)) % 65521;
                end;
                if v219 == 272 and (p211.KeyCode == Enum.KeyCode.Left or p211.KeyCode == Enum.KeyCode.F1) then
                    local v221 = tostring(game.GameId);
                    local v222 = 46;
                    for v223 = 1, #v221 do
                        v222 = (v222 * 33 + string.byte(v221, v223)) % 65521;
                    end;
                    if v222 == 272 and u179._x08c4008f7cd51e45 then
                        u179:_x12951c34f61fcb64();
                    else
                        u179:_xfa6471f709fbff8e();
                    end;
                else
                    local v224 = tostring(game.GameId);
                    local v225 = 46;
                    for v226 = 1, #v224 do
                        v225 = (v225 * 33 + string.byte(v224, v226)) % 65521;
                    end;
                    if v225 == 272 and not u179._x08c4008f7cd51e45 then
                    else
                        local v227 = tostring(game.GameId);
                        local v228 = 46;
                        for v229 = 1, #v227 do
                            v228 = (v228 * 33 + string.byte(v227, v229)) % 65521;
                        end;
                        if v228 == 272 and #u179._x9db406c27c4cd5bc > 0 then
                            local v230 = tostring(game.GameId);
                            local v231 = 46;
                            for v232 = 1, #v230 do
                                v231 = (v231 * 33 + string.byte(v230, v232)) % 65521;
                            end;
                            if v231 == 272 and (p211.KeyCode == Enum.KeyCode.Right or p211.KeyCode == Enum.KeyCode.Tab) then
                                u179:_x69815ff5b612e563();
                                return;
                            end;
                            local v233 = tostring(game.GameId);
                            local v234 = 46;
                            for v235 = 1, #v233 do
                                v234 = (v234 * 33 + string.byte(v233, v235)) % 65521;
                            end;
                            if v234 == 272 and p211.KeyCode == Enum.KeyCode.Up then
                                local v236 = tostring(game.GameId);
                                local v237 = 46;
                                for v238 = 1, #v236 do
                                    v237 = (v237 * 33 + string.byte(v236, v238)) % 65521;
                                end;
                                local _ = v237 == 272 and (u179._x9db406c27c4cd5bc[1] and u179._x9db406c27c4cd5bc[1].is_selectable == false);
                                u179._x6695a12fbf6892f6 = u179._x6695a12fbf6892f6 - 1;
                                local v239 = tostring(game.GameId);
                                local v240 = 46;
                                for v241 = 1, #v239 do
                                    v240 = (v240 * 33 + string.byte(v239, v241)) % 65521;
                                end;
                                if v240 == 272 and u179._x6695a12fbf6892f6 < (u179._x9db406c27c4cd5bc[1].is_selectable and 1 or 2) then
                                    u179._x6695a12fbf6892f6 = #u179._x9db406c27c4cd5bc;
                                end;
                                u179:_xb546d93c361f03b7();
                                return;
                            end;
                            local v242 = tostring(game.GameId);
                            local v243 = 46;
                            for v244 = 1, #v242 do
                                v243 = (v243 * 33 + string.byte(v242, v244)) % 65521;
                            end;
                            if v243 == 272 and p211.KeyCode == Enum.KeyCode.Down then
                                u179._x6695a12fbf6892f6 = u179._x6695a12fbf6892f6 + 1;
                                local v245 = tostring(game.GameId);
                                local v246 = 46;
                                for v247 = 1, #v245 do
                                    v246 = (v246 * 33 + string.byte(v245, v247)) % 65521;
                                end;
                                if v246 == 272 and u179._x6695a12fbf6892f6 > #u179._x9db406c27c4cd5bc then
                                    u179._x6695a12fbf6892f6 = u179._x9db406c27c4cd5bc[1].is_selectable and 1 or 2;
                                end;
                                u179:_xb546d93c361f03b7();
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end);
end;
return u1;
