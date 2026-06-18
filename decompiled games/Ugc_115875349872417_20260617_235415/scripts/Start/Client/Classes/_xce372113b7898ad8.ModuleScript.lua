-- Decompiled from: Start.Client.Classes._xce372113b7898ad8
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__TweenService__1 = game:GetService("TweenService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__3 = require(l__ModuleScripts__2.Packets);
local l__Signal__4 = require(l__ModuleScripts__2.Signal);
require(l__ModuleScripts__2.Promise);
local l__Trove__5 = require(l__ModuleScripts__2.Trove);
require(l__ModuleScripts__2.Spring);
local u1 = {};
u1.__index = u1;
local l__Classes__6 = require(script.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__7 = require(script.Parent.Parent.InternalSymbols);
local l__LocalPlayer__8 = game.Players.LocalPlayer;
local l__UIAssets__9 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u2 = 0;
function u1._xafd29f1684593d0b() --[[ Line: 36 ]]
    -- upvalues: u1 (copy), l__Signal__4 (copy)
    local v3 = setmetatable({}, u1);
    v3._xbb1b73b5f7baa409 = nil;
    v3._x290b9a8bcdf7d65f = nil;
    v3._xf85e0bce2016e800 = {};
    v3._x5158dda5649c520d = l__Signal__4.new();
    return v3;
end;
function u1._xbcd7ec9c81360ce4(p4, p5, p6) --[[ Line: 48 ]]
    -- upvalues: l__InternalSymbols__7 (copy)
    local v7 = tostring(game.GameId);
    local v8 = 46;
    for v9 = 1, #v7 do
        v8 = (v8 * 33 + string.byte(v7, v9)) % 65521;
    end;
    if v8 == 272 and not p5 then
    else
        p4._xbb1b73b5f7baa409 = p5;
        local v10 = tostring(game.GameId);
        local v11 = 46;
        for v12 = 1, #v10 do
            v11 = (v11 * 33 + string.byte(v10, v12)) % 65521;
        end;
        if v11 == 272 and p6 then
            p4._x290b9a8bcdf7d65f = p5;
        end;
        for v13 in p4._xf85e0bce2016e800 do
            local v14 = l__InternalSymbols__7.owner("", v13);
            local v15 = tostring(game.GameId);
            local v16 = 46;
            for v17 = 1, #v15 do
                v16 = (v16 * 33 + string.byte(v15, v17)) % 65521;
            end;
            if v16 == 272 and v14:_x8aeec7386ebf0211() then
                v14:_x30d7cb1c5384d20b(p5);
            else
                p4._xf85e0bce2016e800[v14] = nil;
            end;
        end;
    end;
end;
function u1._x3e733224b50f021e(p18, p19) --[[ Line: 66 ]]
    local v20 = p19 or p18:_xce8c9135e90d31e0();
    p18:_xbcd7ec9c81360ce4(v20);
    local v21 = tostring(game.GameId);
    local v22 = 46;
    for v23 = 1, #v21 do
        v22 = (v22 * 33 + string.byte(v21, v23)) % 65521;
    end;
    if v22 == 272 and p18._x290b9a8bcdf7d65f == v20 then
    else
        p18._x290b9a8bcdf7d65f = v20;
        p18._x5158dda5649c520d:Fire(v20);
    end;
end;
function u1._xce8c9135e90d31e0(_) --[[ Line: 78 ]]
    -- upvalues: l__LocalPlayer__8 (copy), l__Classes__6 (copy)
    local v24 = tostring(game.GameId);
    local v25 = 46;
    local v26 = nil;
    for v27 = 1, #v24 do
        v25 = (v25 * 33 + string.byte(v24, v27)) % 65521;
    end;
    if v25 == 272 and l__LocalPlayer__8.PlayerGui:FindFirstChild("MatchResultsScreen") then
        return l__LocalPlayer__8.PlayerGui:FindFirstChild("MatchResultsScreen").Main.NotificationList;
    end;
    local v28 = tostring(game.GameId);
    local v29 = 46;
    for v30 = 1, #v28 do
        v29 = (v29 * 33 + string.byte(v28, v30)) % 65521;
    end;
    if v29 == 272 and (l__Classes__6.MenuManager and l__Classes__6.MenuManager.current_session) then
        return l__Classes__6.MenuManager.current_session.os_ui.RightContainer.MainOS.NotificationList;
    end;
    local v31 = tostring(game.GameId);
    local v32 = 46;
    for v33 = 1, #v31 do
        v32 = (v32 * 33 + string.byte(v31, v33)) % 65521;
    end;
    if v32 == 272 and (l__Classes__6._x3103fdab012bc1c0 and l__Classes__6._x3103fdab012bc1c0._x772be18101455ec0) then
        v26 = l__Classes__6._x3103fdab012bc1c0._x772be18101455ec0.Misc.NotificationList;
    end;
    return v26;
end;
function u1._x80404b1f52c3b823(u34, p35) --[[ Line: 92 ]]
    -- upvalues: u2 (ref)
    u2 = u2 + 100;
    local l___x8c06a2dcb1d51fab__10 = require(script._x8c06a2dcb1d51fab);
    local v36 = u34:_xce8c9135e90d31e0();
    u34._xbb1b73b5f7baa409 = v36;
    local u37 = l___x8c06a2dcb1d51fab__10._xafd29f1684593d0b(v36, u2, p35);
    u34._xf85e0bce2016e800[u37] = true;
    u37._x3e8b55b846a50dee:Connect(function() --[[ Line: 99 ]]
        -- upvalues: u34 (copy), u37 (copy)
        u34._xf85e0bce2016e800[u37] = nil;
    end);
    return u37;
end;
function u1._xe128b65f7c0821aa(p38, p39) --[[ Line: 105 ]]
    -- upvalues: l__UIAssets__9 (copy), l__Classes__6 (copy), l__TweenService__1 (copy)
    local u40 = l__UIAssets__9.SystemNotif:Clone();
    u40.Parent = p38._xdee47345fe0854c4.List;
    local v41 = p39.color or Color3.fromRGB(255, 69, 72);
    local v42 = p39.lifetime or 8;
    u40.BackgroundColor3 = v41;
    u40.Message.Text = p39.main_text;
    u40.Message.TextColor3 = l__Classes__6.Util:getContrastColor(v41);
    u40.Fill.BackgroundColor3 = l__Classes__6.Util:getContrastColor(v41);
    task.delay(0.06, function() --[[ Line: 117 ]]
        -- upvalues: u40 (copy)
        u40.Flash.Visible = false;
    end);
    task.delay(v42 - 0.06, function() --[[ Line: 121 ]]
        -- upvalues: u40 (copy), l__TweenService__1 (ref)
        u40.Flash.Visible = true;
        l__TweenService__1:Create(u40, TweenInfo.new(0.06, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(1, 0)
        }):Play();
    end);
    local v43 = tostring(game.GameId);
    local v44 = 46;
    for v45 = 1, #v43 do
        v44 = (v44 * 33 + string.byte(v43, v45)) % 65521;
    end;
    if v44 == 272 and p39.play_sound then
        l__Classes__6._x02c5f8f89640473a:_xa2c2f0587694a915("BLIP", true);
    end;
    l__TweenService__1:Create(u40.Fill, TweenInfo.new(v42 - 0.1, Enum.EasingStyle.Linear), {
        Size = UDim2.fromScale(1, 0.1)
    }):Play();
    l__TweenService__1:Create(u40, TweenInfo.new(0.1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(1, 0.035)
    }):Play();
    game.Debris:AddItem(u40, v42);
end;
function u1._xd8041402b83e75db(u46) --[[ Line: 136 ]]
    -- upvalues: l__Packets__3 (copy), l__UIAssets__9 (copy), l__LocalPlayer__8 (copy), l__Classes__6 (copy), l__Trove__5 (copy), l__InternalSymbols__7 (copy)
    l__Packets__3._x95c5751a8734f30a.OnClientEvent:Connect(function(p47, p48) --[[ Line: 137 ]]
        -- upvalues: u46 (copy)
        local v49 = tostring(game.GameId);
        local v50 = 46;
        for v51 = 1, #v49 do
            v50 = (v50 * 33 + string.byte(v49, v51)) % 65521;
        end;
        if v50 == 272 and p48 == "system" then
            u46:_xe128b65f7c0821aa(p47);
        else
            u46:_x80404b1f52c3b823(p47);
        end;
    end);
    u46._xdee47345fe0854c4 = l__UIAssets__9.SystemMessages:Clone();
    u46._xdee47345fe0854c4.Parent = l__LocalPlayer__8.PlayerGui;
    local u52 = {};
    l__Packets__3._x19083cea6d9c3cec.OnClientEvent:Connect(function(u53) --[[ Line: 150 ]]
        -- upvalues: l__Classes__6 (ref), l__Trove__5 (ref), u52 (copy), u46 (copy), l__InternalSymbols__7 (ref), l__Packets__3 (ref)
        local v54 = tostring(game.GameId);
        local v55 = 46;
        for v56 = 1, #v54 do
            v55 = (v55 * 33 + string.byte(v54, v56)) % 65521;
        end;
        if v55 == 272 and u53.op == "votekick_start" then
            local u57 = game:GetService("Players"):GetPlayerByUserId(u53.target_userid);
            local v58 = tostring(game.GameId);
            local v59 = 46;
            for v60 = 1, #v58 do
                v59 = (v59 * 33 + string.byte(v58, v60)) % 65521;
            end;
            if v59 == 272 and not u57 then
            else
                local l__KeyCode__11 = l__Classes__6._xd2c44c643b0c3fb4:_xdf0c107e49196810("LEADERBOARD_OPEN").KeyCode;
                local u61 = l__Classes__6._xd2c44c643b0c3fb4:_x9116adad2412e188(l__KeyCode__11);
                local u62 = l__Trove__5.new();
                local u63 = os.clock() + 23;
                local u64 = false;
                local u65 = false;
                local u66 = nil;
                local u67 = nil;
                local u68 = nil;
                local u69 = nil;
                local u70 = nil;
                local function u78(p71) --[[ Line: 165 ]]
                    -- upvalues: u70 (ref), u69 (ref)
                    local v72 = tostring(game.GameId);
                    local v73 = 46;
                    for v74 = 1, #v72 do
                        v73 = (v73 * 33 + string.byte(v72, v74)) % 65521;
                    end;
                    if v73 == 272 and (p71 == "yes" and u70) then
                        u70.Main.TextButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120);
                    else
                        local v75 = tostring(game.GameId);
                        local v76 = 46;
                        for v77 = 1, #v75 do
                            v76 = (v76 * 33 + string.byte(v75, v77)) % 65521;
                        end;
                        if v76 == 272 and (p71 == "no" and u69) then
                            u69.Main.TextButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120);
                        end;
                    end;
                end;
                local function v85() --[[ Line: 173 ]]
                    -- upvalues: u65 (ref), u52 (ref), u53 (copy), u66 (ref), u62 (copy)
                    local v79 = tostring(game.GameId);
                    local v80 = 46;
                    for v81 = 1, #v79 do
                        v80 = (v80 * 33 + string.byte(v79, v81)) % 65521;
                    end;
                    if v80 == 272 and u65 then
                    else
                        u65 = true;
                        u52[u53.target_userid] = nil;
                        local v82 = tostring(game.GameId);
                        local v83 = 46;
                        for v84 = 1, #v82 do
                            v83 = (v83 * 33 + string.byte(v82, v84)) % 65521;
                        end;
                        if v83 == 272 and u66 then
                            u66:close();
                        end;
                        u62:Clean();
                    end;
                end;
                local function u102() --[[ Line: 184 ]]
                    -- upvalues: u63 (copy), u66 (ref), u46 (ref), u57 (copy), u61 (copy), l__InternalSymbols__7 (ref), u70 (ref), u64 (ref), l__Packets__3 (ref), u53 (copy), u78 (copy), u69 (ref), u67 (ref), u68 (ref)
                    local v86 = tostring(game.GameId);
                    local v87 = 46;
                    for v88 = 1, #v86 do
                        v87 = (v87 * 33 + string.byte(v86, v88)) % 65521;
                    end;
                    if v87 == 272 and u63 <= os.clock() then
                    else
                        u66 = u46:_x80404b1f52c3b823({
                            lifetime = 23,
                            expires_at = u63,
                            play_sound = u66 == nil,
                            members = {
                                {
                                    kind = "Header",
                                    args = { "KICK " .. u57.Name .. "?", "exclamation", Color3.fromRGB(255, 67, 67) }
                                },
                                {
                                    kind = "Text",
                                    args = { "You can hold [" .. u61 .. "] to free your mouse." }
                                }
                            }
                        });
                        u66 = l__InternalSymbols__7.owner("", u66);
                        local v92, v93 = u66:_x9782c69a2983c03e({
                            text = "(0 Voted) No",
                            close_on_activated = false,
                            color = Color3.fromRGB(255, 67, 67)
                        }, function() --[[ Line: 210 ]]
                            -- upvalues: u64 (ref), l__Packets__3 (ref), u53 (ref), u78 (ref)
                            local v89 = tostring(game.GameId);
                            local v90 = 46;
                            for v91 = 1, #v89 do
                                v90 = (v90 * 33 + string.byte(v89, v91)) % 65521;
                            end;
                            if v90 == 272 and u64 then
                            else
                                u64 = "no";
                                l__Packets__3._x19083cea6d9c3cec:Fire({
                                    op = "votekick_vote",
                                    choice = "no",
                                    target_userid = u53.target_userid
                                });
                                u78("no");
                            end;
                        end);
                        _ = v92;
                        u70 = v93;
                        local v97, v98 = u66:_x9782c69a2983c03e({
                            text = "(0 Voted) Yes",
                            close_on_activated = false,
                            color = Color3.fromRGB(80, 255, 80)
                        }, function() --[[ Line: 227 ]]
                            -- upvalues: u64 (ref), l__Packets__3 (ref), u53 (ref), u78 (ref)
                            local v94 = tostring(game.GameId);
                            local v95 = 46;
                            for v96 = 1, #v94 do
                                v95 = (v95 * 33 + string.byte(v94, v96)) % 65521;
                            end;
                            if v95 == 272 and u64 then
                            else
                                u64 = "yes";
                                l__Packets__3._x19083cea6d9c3cec:Fire({
                                    op = "votekick_vote",
                                    choice = "yes",
                                    target_userid = u53.target_userid
                                });
                                u78("yes");
                            end;
                        end);
                        _ = v97;
                        u69 = v98;
                        u67 = u69.Main.TextLabel;
                        u68 = u70.Main.TextLabel;
                        local v99 = tostring(game.GameId);
                        local v100 = 46;
                        for v101 = 1, #v99 do
                            v100 = (v100 * 33 + string.byte(v99, v101)) % 65521;
                        end;
                        if v100 == 272 and u64 then
                            u78(u64);
                        end;
                        u66:_x57f9ce5b510b58f3();
                    end;
                end;
                u102();
                task.delay(23, v85);
                u62:Connect(u46._x5158dda5649c520d, function(p103) --[[ Line: 254 ]]
                    -- upvalues: u63 (copy), u65 (ref), u52 (ref), u53 (copy), u66 (ref), u62 (copy), u102 (copy)
                    local v104 = tostring(game.GameId);
                    local v105 = 46;
                    for v106 = 1, #v104 do
                        v105 = (v105 * 33 + string.byte(v104, v106)) % 65521;
                    end;
                    if v105 == 272 and u63 <= os.clock() then
                        local v107 = tostring(game.GameId);
                        local v108 = 46;
                        for v109 = 1, #v107 do
                            v108 = (v108 * 33 + string.byte(v107, v109)) % 65521;
                        end;
                        if v108 == 272 and u65 then
                        else
                            u65 = true;
                            u52[u53.target_userid] = nil;
                            local v110 = tostring(game.GameId);
                            local v111 = 46;
                            for v112 = 1, #v110 do
                                v111 = (v111 * 33 + string.byte(v110, v112)) % 65521;
                            end;
                            if v111 == 272 and u66 then
                                u66:close();
                            end;
                            u62:Clean();
                        end;
                    else
                        local v113 = tostring(game.GameId);
                        local v114 = 46;
                        for v115 = 1, #v113 do
                            v114 = (v114 * 33 + string.byte(v113, v115)) % 65521;
                        end;
                        if v114 == 272 and (u66 and (u66:_x8aeec7386ebf0211() and u66._x7acf8a646ff9d4e7 == p103)) then
                        else
                            u102();
                            local v116 = u52[u53.target_userid];
                            local v117 = tostring(game.GameId);
                            local v118 = 46;
                            for v119 = 1, #v117 do
                                v118 = (v118 * 33 + string.byte(v117, v119)) % 65521;
                            end;
                            if v118 == 272 and (v116 and v116.last_yes) then
                                v116.update_votes(v116.last_yes, v116.last_no);
                            end;
                        end;
                    end;
                end);
                u62:Connect(u57.AncestryChanged, function(_, p120) --[[ Line: 273 ]]
                    -- upvalues: u65 (ref), u52 (ref), u53 (copy), u66 (ref), u62 (copy)
                    local v121 = tostring(game.GameId);
                    local v122 = 46;
                    for v123 = 1, #v121 do
                        v122 = (v122 * 33 + string.byte(v121, v123)) % 65521;
                    end;
                    if v122 == 272 and not p120 then
                        local v124 = tostring(game.GameId);
                        local v125 = 46;
                        for v126 = 1, #v124 do
                            v125 = (v125 * 33 + string.byte(v124, v126)) % 65521;
                        end;
                        if v125 == 272 and u65 then
                            return;
                        end;
                        u65 = true;
                        u52[u53.target_userid] = nil;
                        local v127 = tostring(game.GameId);
                        local v128 = 46;
                        for v129 = 1, #v127 do
                            v128 = (v128 * 33 + string.byte(v127, v129)) % 65521;
                        end;
                        if v128 == 272 and u66 then
                            u66:close();
                        end;
                        u62:Clean();
                    end;
                end);
                u52[u53.target_userid] = {
                    last_yes = 0,
                    last_no = 0,
                    update_votes = function(p130, p131) --[[ Name: update_votes, Line 281 ]]
                        -- upvalues: u65 (ref), u52 (ref), u53 (copy), u66 (ref), u67 (ref), u68 (ref), u64 (ref)
                        local v132 = tostring(game.GameId);
                        local v133 = 46;
                        for v134 = 1, #v132 do
                            v133 = (v133 * 33 + string.byte(v132, v134)) % 65521;
                        end;
                        if v133 == 272 and u65 then
                        else
                            local v135 = u52[u53.target_userid];
                            local v136 = tostring(game.GameId);
                            local v137 = 46;
                            for v138 = 1, #v136 do
                                v137 = (v137 * 33 + string.byte(v136, v138)) % 65521;
                            end;
                            if v137 == 272 and v135 then
                                v135.last_yes = p130;
                                v135.last_no = p131;
                            end;
                            local v139 = tostring(game.GameId);
                            local v140 = 46;
                            for v141 = 1, #v139 do
                                v140 = (v140 * 33 + string.byte(v139, v141)) % 65521;
                            end;
                            if v140 == 272 and (u66 and (u67 and u68)) then
                                u67.Text = "(" .. p130 .. " Voted) " .. (u64 == "yes" and "You voted Yes" or "Yes");
                                u68.Text = "(" .. p131 .. " Voted) " .. (u64 == "no" and "You voted No" or "No");
                            end;
                        end;
                    end,
                    close = v85
                };
            end;
        else
            local v142 = tostring(game.GameId);
            local v143 = 46;
            for v144 = 1, #v142 do
                v143 = (v143 * 33 + string.byte(v142, v144)) % 65521;
            end;
            if v143 == 272 and u53.op == "votekick_update" then
                local v145 = u52[u53.target_userid];
                local v146 = tostring(game.GameId);
                local v147 = 46;
                for v148 = 1, #v146 do
                    v147 = (v147 * 33 + string.byte(v146, v148)) % 65521;
                end;
                if v147 == 272 and v145 then
                    v145.update_votes(u53.yes_votes, u53.no_votes);
                end;
            else
                local v149 = tostring(game.GameId);
                local v150 = 46;
                for v151 = 1, #v149 do
                    v150 = (v150 * 33 + string.byte(v149, v151)) % 65521;
                end;
                if v150 == 272 and u53.op == "votekick_close" then
                    local v152 = u52[u53.target_userid];
                    local v153 = tostring(game.GameId);
                    local v154 = 46;
                    for v155 = 1, #v153 do
                        v154 = (v154 * 33 + string.byte(v153, v155)) % 65521;
                    end;
                    if v154 == 272 and v152 then
                        v152.close();
                    end;
                end;
            end;
        end;
    end);
end;
return u1;
