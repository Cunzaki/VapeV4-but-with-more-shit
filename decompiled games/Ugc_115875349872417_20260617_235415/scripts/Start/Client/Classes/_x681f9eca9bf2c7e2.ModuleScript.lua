-- Decompiled from: Start.Client.Classes._x681f9eca9bf2c7e2
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__3 = require(l__ModuleScripts__2.Packets);
local l__Trove__4 = require(l__ModuleScripts__2.Trove);
local u1 = {};
u1.__index = u1;
local l__Classes__5 = require(script.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__6 = require(script.Parent.Parent.InternalSymbols);
function u1._xafd29f1684593d0b() --[[ Line: 26 ]]
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._x9940262d98abc0e2 = {};
    v2._x0101e6348c998de3 = false;
    return v2;
end;
function u1._xa4ae76b6076416c1(_, p3, p4) --[[ Line: 35 ]]
    -- upvalues: l__TweenService__1 (copy)
    local v5 = tostring(game.GameId);
    local v6 = 46;
    for v7 = 1, #v5 do
        v6 = (v6 * 33 + string.byte(v5, v7)) % 65521;
    end;
    if v6 == 272 and not p3 then
    else
        local v8 = tostring(game.GameId);
        local v9 = 46;
        for v10 = 1, #v8 do
            v9 = (v9 * 33 + string.byte(v8, v10)) % 65521;
        end;
        if v9 == 272 and p4.objective_text then
            p3.Main.ObjectiveLabel.Text = p4.objective_text;
        end;
        local v11 = tostring(game.GameId);
        local v12 = 46;
        for v13 = 1, #v11 do
            v12 = (v12 * 33 + string.byte(v11, v13)) % 65521;
        end;
        if v12 == 272 and (p4.progress_text and p3.Main.ProgressLabel) then
            p3.Main.ProgressLabel.Text = p4.progress_text;
        end;
        local v14 = tostring(game.GameId);
        local v15 = 46;
        for v16 = 1, #v14 do
            v15 = (v15 * 33 + string.byte(v14, v16)) % 65521;
        end;
        if v15 == 272 and (p4.progress_fill and p3.Main.Progress.Frame) then
            l__TweenService__1:Create(p3.Main.Progress.Frame, TweenInfo.new(0.33, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(p4.progress_fill, 1)
            }):Play();
        end;
    end;
end;
function u1._x72553c4684dbd4e7(u17, u18) --[[ Line: 55 ]]
    -- upvalues: l__Classes__5 (copy), l__InternalSymbols__6 (copy)
    local v19 = l__Classes__5._xce372113b7898ad8:_xce8c9135e90d31e0();
    local v20 = tostring(game.GameId);
    local v21 = 46;
    for v22 = 1, #v20 do
        v21 = (v21 * 33 + string.byte(v20, v22)) % 65521;
    end;
    if v21 == 272 and not v19 then
        return nil, nil;
    end;
    local v23 = u17._x9940262d98abc0e2[u18.id];
    local l__owner__7 = l__InternalSymbols__6.owner;
    local v24 = "";
    local v25;
    if v23 then
        v25 = v23.side_notif;
    else
        v25 = v23;
    end;
    local v26 = l__owner__7(v24, v25);
    local l__payload__8 = u18.payload;
    local v27 = tostring(game.GameId);
    local v28 = 46;
    for v29 = 1, #v27 do
        v28 = (v28 * 33 + string.byte(v27, v29)) % 65521;
    end;
    if v28 == 272 and not l__payload__8 then
        return nil, nil;
    end;
    local v30 = tostring(game.GameId);
    local v31 = 46;
    for v32 = 1, #v30 do
        v31 = (v31 * 33 + string.byte(v30, v32)) % 65521;
    end;
    if v31 == 272 and (v23 and (v26 and (v26:_x8aeec7386ebf0211() and v26._x7acf8a646ff9d4e7 == v19))) then
        return v26, v23.goal_asset;
    end;
    local u33 = l__InternalSymbols__6.owner("", l__Classes__5._xce372113b7898ad8:_x80404b1f52c3b823({
        play_sound = false,
        lifetime = l__payload__8.notif_appearance == "Persistent" and -1 or 5,
        Reactive = l__payload__8.notif_appearance == "Reactive",
        members = {
            {
                kind = "Header",
                args = { l__payload__8.header_text, l__payload__8.icon_name, l__payload__8.icon_color }
            }
        }
    }));
    u33._xc1db8b4c9603b483:Add(function() --[[ Line: 91 ]]
        -- upvalues: u17 (copy), u18 (copy), u33 (copy)
        local v34 = u17._x9940262d98abc0e2[u18.id];
        local v35 = tostring(game.GameId);
        local v36 = 46;
        for v37 = 1, #v35 do
            v36 = (v36 * 33 + string.byte(v35, v37)) % 65521;
        end;
        if v36 == 272 and (v34 and v34.side_notif == u33) then
            v34.visible = false;
            v34.side_notif = nil;
            v34.goal_asset = nil;
        end;
    end);
    local v38 = tostring(game.GameId);
    local v39 = 46;
    local v40 = nil;
    for v41 = 1, #v38 do
        v39 = (v39 * 33 + string.byte(v38, v41)) % 65521;
    end;
    if v39 == 272 and l__payload__8.notif_type == "Goal" then
        local v42;
        v42, v40 = u33:_xf10933860a30d41f();
        _ = v42;
    else
        local v43 = tostring(game.GameId);
        local v44 = 46;
        for v45 = 1, #v43 do
            v44 = (v44 * 33 + string.byte(v43, v45)) % 65521;
        end;
        if v44 == 272 and l__payload__8.notif_type == "GoalTracker" then
            local v46;
            v46, v40 = u33:_x9ba48bb79f8a5517();
            _ = v46;
        end;
    end;
    local v47 = tostring(game.GameId);
    local v48 = 46;
    for v49 = 1, #v47 do
        v48 = (v48 * 33 + string.byte(v47, v49)) % 65521;
    end;
    if v48 == 272 and not v40 then
        warn("ObjectiveClient: unknown notif_type \'" .. tostring(l__payload__8.notif_type) .. "\' for id " .. tostring(u18.id));
        return u33, nil;
    end;
    local v50 = tostring(game.GameId);
    local v51 = 46;
    for v52 = 1, #v50 do
        v51 = (v51 * 33 + string.byte(v50, v52)) % 65521;
    end;
    if v51 == 272 and v23 then
        v23.latest_full = u18;
        v23.side_notif = u33;
        v23.goal_asset = v40;
        v23.visible = true;
    end;
    u17:_xa4ae76b6076416c1(v40, l__payload__8);
    return u33, v40;
end;
function u1._x4189a1a26a2b5d0f(u53, u54) --[[ Line: 124 ]]
    -- upvalues: l__Trove__4 (copy), l__Classes__5 (copy)
    local v55 = {
        latest_full = u54,
        trove = l__Trove__4.new(),
        is_completing = false
    };
    v55.trove:Connect(l__Classes__5._xce372113b7898ad8._x5158dda5649c520d, function(_) --[[ Line: 130 ]]
        -- upvalues: u53 (copy), u54 (copy)
        local v56 = u53._x9940262d98abc0e2[u54.id];
        local v57 = tostring(game.GameId);
        local v58 = 46;
        for v59 = 1, #v57 do
            v58 = (v58 * 33 + string.byte(v57, v59)) % 65521;
        end;
        if v58 == 272 and not v56 then
        else
            local v60 = tostring(game.GameId);
            local v61 = 46;
            for v62 = 1, #v60 do
                v61 = (v61 * 33 + string.byte(v60, v62)) % 65521;
            end;
            if v61 == 272 and v56.is_completing then
            else
                local v63 = tostring(game.GameId);
                local v64 = 46;
                for v65 = 1, #v63 do
                    v64 = (v64 * 33 + string.byte(v63, v65)) % 65521;
                end;
                if v64 == 272 and not (v56.latest_full and v56.latest_full.payload) then
                else
                    local l__payload__9 = v56.latest_full.payload;
                    local v66 = tostring(game.GameId);
                    local v67 = 46;
                    for v68 = 1, #v66 do
                        v67 = (v67 * 33 + string.byte(v66, v68)) % 65521;
                    end;
                    if v67 == 272 and l__payload__9.notif_appearance == "Reactive" then
                    else
                        u53:_x72553c4684dbd4e7(v56.latest_full);
                    end;
                end;
            end;
        end;
    end);
    u53._x9940262d98abc0e2[u54.id] = v55;
    local v69 = tostring(game.GameId);
    local v70 = 46;
    for v71 = 1, #v69 do
        v70 = (v70 * 33 + string.byte(v69, v71)) % 65521;
    end;
    if v70 == 272 and (u54.payload and u54.payload.notif_appearance ~= "Reactive") then
        u53:_x72553c4684dbd4e7(u54);
    end;
end;
function u1._x61588bfc4bc8ebf9(p72, p73, p74) --[[ Line: 151 ]]
    -- upvalues: l__InternalSymbols__6 (copy)
    local v75 = p72._x9940262d98abc0e2[p73];
    local v76 = tostring(game.GameId);
    local v77 = 46;
    for v78 = 1, #v76 do
        v77 = (v77 * 33 + string.byte(v76, v78)) % 65521;
    end;
    if v77 == 272 and not v75 then
    else
        v75.latest_full.payload = p74;
        local v79, v80 = p72:_x72553c4684dbd4e7(v75.latest_full);
        local v81 = l__InternalSymbols__6.owner("", v79);
        p72:_xa4ae76b6076416c1(v80, p74);
        local v82 = tostring(game.GameId);
        local v83 = 46;
        for v84 = 1, #v82 do
            v83 = (v83 * 33 + string.byte(v82, v84)) % 65521;
        end;
        if v83 == 272 and (p74.notif_appearance == "Reactive" and v81) then
            v81:_x8e063418afe1e44c(5);
        end;
    end;
end;
function u1._x0d6c89b75b5fa226(p85, p86, p87) --[[ Line: 165 ]]
    -- upvalues: l__Classes__5 (copy), l__TweenService__1 (copy)
    local v88 = p85._x9940262d98abc0e2[p86];
    local v89 = tostring(game.GameId);
    local v90 = 46;
    for v91 = 1, #v89 do
        v90 = (v90 * 33 + string.byte(v89, v91)) % 65521;
    end;
    if v90 == 272 and not v88 then
    else
        v88.is_completing = true;
        v88.trove:Clean();
        local v92 = tostring(game.GameId);
        local v93 = 46;
        for v94 = 1, #v92 do
            v93 = (v93 * 33 + string.byte(v92, v94)) % 65521;
        end;
        if v93 == 272 and not p87 then
            l__Classes__5._x02c5f8f89640473a:_xa2c2f0587694a915("GOAL_COMPLETE", true);
        end;
        local l__goal_asset__10 = v88.goal_asset;
        local l__side_notif__11 = v88.side_notif;
        local v95 = tostring(game.GameId);
        local v96 = 46;
        for v97 = 1, #v95 do
            v96 = (v96 * 33 + string.byte(v95, v97)) % 65521;
        end;
        if v96 == 272 and l__goal_asset__10 then
            local l__CompleteImage__12 = l__goal_asset__10.Main.CompleteImage;
            local l__CompleteFlash__13 = l__goal_asset__10.Main.CompleteFlash;
            l__CompleteImage__12.Visible = true;
            l__TweenService__1:Create(l__CompleteImage__12.Outward, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(5, 5)
            }):Play();
            l__TweenService__1:Create(l__CompleteImage__12.Outward, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
            l__CompleteFlash__13.BackgroundTransparency = 0;
            l__TweenService__1:Create(l__CompleteFlash__13, TweenInfo.new(0.83, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            l__TweenService__1:Create(l__CompleteFlash__13, TweenInfo.new(0.83, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(2, 1)
            }):Play();
        end;
        task.delay(5, function() --[[ Line: 192 ]]
            -- upvalues: l__side_notif__11 (copy)
            local v98 = tostring(game.GameId);
            local v99 = 46;
            for v100 = 1, #v98 do
                v99 = (v99 * 33 + string.byte(v98, v100)) % 65521;
            end;
            if v99 == 272 and l__side_notif__11 then
                pcall(function() --[[ Line: 194 ]]
                    -- upvalues: l__side_notif__11 (ref)
                    l__side_notif__11:close();
                end);
            end;
        end);
    end;
end;
function u1._x70c5cb7da06f1e63(p101, p102) --[[ Line: 201 ]]
    local v103 = p101._x9940262d98abc0e2[p102];
    local v104 = tostring(game.GameId);
    local v105 = 46;
    for v106 = 1, #v104 do
        v105 = (v105 * 33 + string.byte(v104, v106)) % 65521;
    end;
    if v105 == 272 and not v103 then
    else
        v103.trove:Clean();
        local l__side_notif__14 = v103.side_notif;
        local v107 = tostring(game.GameId);
        local v108 = 46;
        for v109 = 1, #v107 do
            v108 = (v108 * 33 + string.byte(v107, v109)) % 65521;
        end;
        if v108 == 272 and l__side_notif__14 then
            pcall(function() --[[ Line: 209 ]]
                -- upvalues: l__side_notif__14 (copy)
                l__side_notif__14:close();
            end);
        end;
        p101._x9940262d98abc0e2[p102] = nil;
    end;
end;
function u1._xd8041402b83e75db(u110) --[[ Line: 217 ]]
    -- upvalues: l__Packets__3 (copy)
    l__Packets__3._x02ac3521dbed3d9d.OnClientEvent:Connect(function(p111) --[[ Line: 218 ]]
        -- upvalues: u110 (copy)
        local v112 = tostring(game.GameId);
        local v113 = 46;
        for v114 = 1, #v112 do
            v113 = (v113 * 33 + string.byte(v112, v114)) % 65521;
        end;
        if v113 == 272 and p111.op == "update" then
            local v115 = tostring(game.GameId);
            local v116 = 46;
            for v117 = 1, #v115 do
                v116 = (v116 * 33 + string.byte(v115, v117)) % 65521;
            end;
            if v116 ~= 272 or u110._x9940262d98abc0e2[p111.id] then
                u110:_x61588bfc4bc8ebf9(p111.id, p111.payload);
                return;
            end;
            u110:_x4189a1a26a2b5d0f(p111);
            local v118 = tostring(game.GameId);
            local v119 = 46;
            for v120 = 1, #v118 do
                v119 = (v119 * 33 + string.byte(v118, v120)) % 65521;
            end;
            if v119 == 272 and (p111.payload and p111.payload.notif_appearance == "Reactive") then
                u110:_x61588bfc4bc8ebf9(p111.id, p111.payload);
            end;
        else
            local v121 = tostring(game.GameId);
            local v122 = 46;
            for v123 = 1, #v121 do
                v122 = (v122 * 33 + string.byte(v121, v123)) % 65521;
            end;
            if v122 == 272 and p111.op == "complete" then
                local v124 = tostring(game.GameId);
                local v125 = 46;
                for v126 = 1, #v124 do
                    v125 = (v125 * 33 + string.byte(v124, v126)) % 65521;
                end;
                if v125 == 272 and p111.silence == true then
                    local v127 = tostring(game.GameId);
                    local v128 = 46;
                    for v129 = 1, #v127 do
                        v128 = (v128 * 33 + string.byte(v127, v129)) % 65521;
                    end;
                    if v128 == 272 and u110._x0101e6348c998de3 then
                        return;
                    end;
                end;
                local v130 = tostring(game.GameId);
                local v131 = 46;
                for v132 = 1, #v130 do
                    v131 = (v131 * 33 + string.byte(v130, v132)) % 65521;
                end;
                if v131 == 272 and not u110._x9940262d98abc0e2[p111.id] then
                    local v133 = tostring(game.GameId);
                    local v134 = 46;
                    for v135 = 1, #v133 do
                        v134 = (v134 * 33 + string.byte(v133, v135)) % 65521;
                    end;
                    if v134 ~= 272 or not p111.payload then
                        return;
                    end;
                    u110:_x4189a1a26a2b5d0f({
                        id = p111.id,
                        key = p111.key,
                        payload = p111.payload
                    });
                    u110:_x61588bfc4bc8ebf9(p111.id, p111.payload);
                else
                    local v136 = tostring(game.GameId);
                    local v137 = 46;
                    for v138 = 1, #v136 do
                        v137 = (v137 * 33 + string.byte(v136, v138)) % 65521;
                    end;
                    if v137 == 272 and p111.payload then
                        u110:_x61588bfc4bc8ebf9(p111.id, p111.payload);
                    end;
                end;
                u110:_x0d6c89b75b5fa226(p111.id, p111.silence);
                return;
            end;
            local v139 = tostring(game.GameId);
            local v140 = 46;
            for v141 = 1, #v139 do
                v140 = (v140 * 33 + string.byte(v139, v141)) % 65521;
            end;
            if v140 == 272 and p111.op == "destroy" then
                local v142 = tostring(game.GameId);
                local v143 = 46;
                for v144 = 1, #v142 do
                    v143 = (v143 * 33 + string.byte(v142, v144)) % 65521;
                end;
                if v143 == 272 and not u110._x9940262d98abc0e2[p111.id] then
                    return;
                end;
                u110:_x70c5cb7da06f1e63(p111.id);
            end;
        end;
    end);
end;
return u1;
