-- Decompiled from: Start.Client.Classes._x2399ab4dd9b69ab8
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__UIAssets__4 = l__ReplicatedStorage__3.Assets.UIAssets;
local l__ModuleScripts__5 = l__ReplicatedStorage__3.Assets.ModuleScripts;
local l__Trove__6 = require(l__ModuleScripts__5.Trove);
local l__BuildInfo__7 = require(l__ModuleScripts__5.BuildInfo);
local u1 = {};
u1.__index = u1;
local l__Classes__8 = require(script.Parent.Parent.ClientRoot).Classes;
local l__LocalPlayer__9 = game.Players.LocalPlayer;
local l__main_version__10 = l__BuildInfo__7.main_version;
local l__sub_version__11 = l__BuildInfo__7.sub_version;
local l__build_version__12 = l__BuildInfo__7.build_version;
function u1._xafd29f1684593d0b() --[[ Line: 60 ]]
    -- upvalues: u1 (copy), l__Trove__6 (copy)
    local v2 = setmetatable({}, u1);
    v2._x81e48bc426728de3 = Instance.new("ScreenGui");
    v2._x81e48bc426728de3.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    v2._x81e48bc426728de3.Name = "InfoDisplay";
    v2._x81e48bc426728de3.ResetOnSpawn = false;
    v2._x81e48bc426728de3.DisplayOrder = 0;
    v2._x81e48bc426728de3.IgnoreGuiInset = true;
    v2._x81e48bc426728de3.Enabled = true;
    v2._x81e48bc426728de3.Parent = game.Players.LocalPlayer.PlayerGui;
    v2._xf518fa512acbd9e5 = l__Trove__6.new();
    v2._xe12f52132b4439ea = {};
    v2._x7d859dbf17af9ff8 = {};
    return v2;
end;
function u1._x49430f33fdce6bac(p3, p4, p5) --[[ Line: 80 ]]
    -- upvalues: l__UIAssets__4 (copy)
    local v6 = l__UIAssets__4.InfoLineLabel:Clone();
    v6.Text = p4;
    v6.LayoutOrder = p5 or 2;
    v6.Parent = p3._x89942723350a628d.GameInfo;
    return v6;
end;
function u1._xbf2788ede80d0711(p7, p8) --[[ Line: 89 ]]
    local v9 = p7._xe12f52132b4439ea[p8];
    local v10 = tostring(game.GameId);
    local v11 = 46;
    for v12 = 1, #v10 do
        v11 = (v11 * 33 + string.byte(v10, v12)) % 65521;
    end;
    if v11 == 272 and v9 then
        v9:Destroy();
        p7._xe12f52132b4439ea[p8] = nil;
    end;
    local v13 = p7._x7d859dbf17af9ff8[p8];
    local v14 = tostring(game.GameId);
    local v15 = 46;
    for v16 = 1, #v14 do
        v15 = (v15 * 33 + string.byte(v14, v16)) % 65521;
    end;
    if v15 == 272 and v13 then
        v13:Destroy();
        p7._x7d859dbf17af9ff8[p8] = nil;
    end;
end;
function u1._xe3c4e16e2f92b7a6(p17, p18) --[[ Line: 103 ]]
    local v19 = {};
    for _, v20 in p18:GetChildren() do
        local v21 = tostring(game.GameId);
        local v22 = 46;
        for v23 = 1, #v21 do
            v22 = (v22 * 33 + string.byte(v21, v23)) % 65521;
        end;
        if v22 == 272 and (v20:IsA("NumberValue") and v20.Value > 0) then
            table.insert(v19, v20);
        end;
    end;
    table.sort(v19, function(p24, p25) --[[ Line: 111 ]]
        local v26 = p24:GetAttribute("reason");
        local v27 = tostring(game.GameId);
        local v28 = 46;
        for v29 = 1, #v27 do
            v28 = (v28 * 33 + string.byte(v27, v29)) % 65521;
        end;
        if v28 == 272 and (typeof(v26) ~= "string" or v26 == "") then
            v26 = p24.Name;
        end;
        local v30 = string.upper(v26);
        local v31 = p25:GetAttribute("reason");
        local v32 = tostring(game.GameId);
        local v33 = 46;
        for v34 = 1, #v32 do
            v33 = (v33 * 33 + string.byte(v32, v34)) % 65521;
        end;
        if v33 == 272 and (typeof(v31) ~= "string" or v31 == "") then
            v31 = p25.Name;
        end;
        return v30 < string.upper(v31);
    end);
    local v35 = {};
    for v36, v37 in v19 do
        v35[v37] = true;
        local v38 = p17._xe12f52132b4439ea[v37];
        local v39 = tostring(game.GameId);
        local v40 = 46;
        for v41 = 1, #v39 do
            v40 = (v40 * 33 + string.byte(v39, v41)) % 65521;
        end;
        if v40 == 272 and not v38 then
            v38 = p17:_x49430f33fdce6bac("", 3);
            p17._xe12f52132b4439ea[v37] = v38;
        end;
        local l__Value__13 = v37.Value;
        local v42 = tostring(game.GameId);
        local v43 = 46;
        local v44 = "<b>+";
        for v45 = 1, #v42 do
            v43 = (v43 * 33 + string.byte(v42, v45)) % 65521;
        end;
        local v46;
        if v43 == 272 and l__Value__13 % 1 == 0 then
            v46 = tostring(l__Value__13);
        else
            v46 = string.format("%.1f", l__Value__13):gsub("%.?0+$", "");
        end;
        local v47 = v37:GetAttribute("reason");
        local v48 = tostring(game.GameId);
        local v49 = 46;
        local v50 = "% YEN FROM ";
        for v51 = 1, #v48 do
            v49 = (v49 * 33 + string.byte(v48, v51)) % 65521;
        end;
        if v49 == 272 and (typeof(v47) ~= "string" or v47 == "") then
            v47 = v37.Name;
        end;
        v38.Text = v44 .. v46 .. v50 .. string.upper(v47) .. "!</b>";
        v38.LayoutOrder = 3 + v36;
    end;
    local v52 = {};
    for v53 in p17._xe12f52132b4439ea do
        local v54 = tostring(game.GameId);
        local v55 = 46;
        for v56 = 1, #v54 do
            v55 = (v55 * 33 + string.byte(v54, v56)) % 65521;
        end;
        if v55 == 272 and not v35[v53] then
            table.insert(v52, v53);
        end;
    end;
    for _, v57 in v52 do
        p17:_xbf2788ede80d0711(v57);
    end;
end;
function u1._xa3ee5e2745bac48e(u58, u59, p60) --[[ Line: 141 ]]
    -- upvalues: l__Trove__6 (copy)
    local v61 = tostring(game.GameId);
    local v62 = 46;
    for v63 = 1, #v61 do
        v62 = (v62 * 33 + string.byte(v61, v63)) % 65521;
    end;
    if v62 == 272 and (not p60:IsA("NumberValue") or u58._x7d859dbf17af9ff8[p60]) then
    else
        local v64 = l__Trove__6.new();
        u58._x7d859dbf17af9ff8[p60] = v64;
        v64:Connect(p60.Changed, function() --[[ Line: 148 ]]
            -- upvalues: u58 (copy), u59 (copy)
            u58:_xe3c4e16e2f92b7a6(u59);
        end);
        v64:Connect(p60:GetAttributeChangedSignal("reason"), function() --[[ Line: 151 ]]
            -- upvalues: u58 (copy), u59 (copy)
            u58:_xe3c4e16e2f92b7a6(u59);
        end);
    end;
end;
function u1._x1437380ee448850c(u65) --[[ Line: 156 ]]
    -- upvalues: l__ReplicatedStorage__3 (copy), l__LocalPlayer__9 (copy)
    local function u73(u66) --[[ Line: 157 ]]
        -- upvalues: u65 (copy)
        local v67 = tostring(game.GameId);
        local v68 = 46;
        for v69 = 1, #v67 do
            v68 = (v68 * 33 + string.byte(v67, v69)) % 65521;
        end;
        if v68 == 272 and u65._x98a3b381ebe3d714 == u66 then
        else
            u65._x98a3b381ebe3d714 = u66;
            for _, v70 in u66:GetChildren() do
                u65:_xa3ee5e2745bac48e(u66, v70);
            end;
            u65:_xe3c4e16e2f92b7a6(u66);
            u65._xf518fa512acbd9e5:Connect(u66.ChildAdded, function(p71) --[[ Line: 170 ]]
                -- upvalues: u65 (ref), u66 (copy)
                u65:_xa3ee5e2745bac48e(u66, p71);
                u65:_xe3c4e16e2f92b7a6(u66);
            end);
            u65._xf518fa512acbd9e5:Connect(u66.ChildRemoved, function(p72) --[[ Line: 175 ]]
                -- upvalues: u65 (ref), u66 (copy)
                u65:_xbf2788ede80d0711(p72);
                u65:_xe3c4e16e2f92b7a6(u66);
            end);
        end;
    end;
    local l__Players__14 = l__ReplicatedStorage__3.ReadOnly.Players;
    local v74 = l__Players__14:FindFirstChild((tostring(l__LocalPlayer__9.UserId)));
    local v75 = tostring(game.GameId);
    local v76 = 46;
    local function u86(p77) --[[ Line: 181 ]]
        -- upvalues: u73 (copy), u65 (copy)
        local v78 = p77:FindFirstChild("yen_bonuses");
        local v79 = tostring(game.GameId);
        local v80 = 46;
        for v81 = 1, #v79 do
            v80 = (v80 * 33 + string.byte(v79, v81)) % 65521;
        end;
        if v80 == 272 and v78 then
            u73(v78);
        else
            u65._xf518fa512acbd9e5:Connect(p77.ChildAdded, function(p82) --[[ Line: 188 ]]
                -- upvalues: u73 (ref)
                local v83 = tostring(game.GameId);
                local v84 = 46;
                for v85 = 1, #v83 do
                    v84 = (v84 * 33 + string.byte(v83, v85)) % 65521;
                end;
                if v84 == 272 and p82.Name == "yen_bonuses" then
                    u73(p82);
                end;
            end);
        end;
    end;
    for v87 = 1, #v75 do
        v76 = (v76 * 33 + string.byte(v75, v87)) % 65521;
    end;
    if v76 == 272 and v74 then
        u86(v74);
    else
        u65._xf518fa512acbd9e5:Connect(l__Players__14.ChildAdded, function(p88) --[[ Line: 202 ]]
            -- upvalues: l__LocalPlayer__9 (ref), u86 (copy)
            local v89 = tostring(game.GameId);
            local v90 = 46;
            for v91 = 1, #v89 do
                v90 = (v90 * 33 + string.byte(v89, v91)) % 65521;
            end;
            if v90 == 272 and p88.Name == tostring(l__LocalPlayer__9.UserId) then
                u86(p88);
            end;
        end);
    end;
end;
function u1._xd8041402b83e75db(u92) --[[ Line: 209 ]]
    -- upvalues: l__UIAssets__4 (copy), l__RunService__1 (copy), l__ReplicatedStorage__3 (copy), l__main_version__10 (copy), l__sub_version__11 (copy), l__build_version__12 (copy), l__LocalPlayer__9 (copy), l__Classes__8 (copy), l__TweenService__2 (copy)
    u92._x89942723350a628d = l__UIAssets__4.InfoFrame:Clone();
    u92._x89942723350a628d.Parent = u92._x81e48bc426728de3;
    u92:_x1437380ee448850c();
    local v93 = tostring(game.GameId);
    local v94 = 46;
    for v95 = 1, #v93 do
        v94 = (v94 * 33 + string.byte(v93, v95)) % 65521;
    end;
    if v94 == 272 and not l__RunService__1:IsStudio() then
        local l__ServerRegion__15 = l__ReplicatedStorage__3.ReadOnly.ServerRegion;
        l__ServerRegion__15.Changed:Connect(function() --[[ Name: updRegion, Line 217 ]]
            -- upvalues: u92 (copy), l__ServerRegion__15 (copy)
            u92._x89942723350a628d.GameInfo.Region.Text = "SERVER_REGION : " .. l__ServerRegion__15.Value;
        end);
        u92._x89942723350a628d.GameInfo.Region.Text = "SERVER_REGION : " .. l__ServerRegion__15.Value;
    end;
    u92._x89942723350a628d.GameInfo.Game.Text = "REDLINER" .. " " .. "[ALPHA]" .. " v." .. l__main_version__10 .. "." .. l__sub_version__11 .. "." .. l__build_version__12;
    u92._x89942723350a628d.GameInfo.UUID.Text = "USER : " .. l__LocalPlayer__9.Name .. " (" .. l__LocalPlayer__9.UserId .. ")";
    local l__TotalSeconds__16 = l__ReplicatedStorage__3:WaitForChild("ReadOnly"):WaitForChild("TotalSeconds");
    task.spawn(function() --[[ Line: 230 ]]
        -- upvalues: u92 (copy), l__Classes__8 (ref), l__TotalSeconds__16 (copy)
        while true do
            u92._x89942723350a628d.GameInfo.Time.Text = "SERVER_UPTIME : " .. l__Classes__8.Util:formatTime(l__TotalSeconds__16.Value, true);
            task.wait(0.1);
        end;
    end);
    l__Classes__8._x596eb619070480ba:_x0b64af9146930e4b("pingChanged"):Connect(function(p96) --[[ Line: 237 ]]
        -- upvalues: u92 (copy)
        u92._x89942723350a628d.GameInfo.Ping.Text = "PING : " .. p96 .. "ms";
        local v97 = tostring(game.GameId);
        local v98 = 46;
        for v99 = 1, #v97 do
            v98 = (v98 * 33 + string.byte(v97, v99)) % 65521;
        end;
        if v98 == 272 and p96 > 130 then
            u92._x89942723350a628d.GameInfo.Ping.TextColor3 = Color3.fromRGB(255, 211, 0);
        else
            local v100 = tostring(game.GameId);
            local v101 = 46;
            for v102 = 1, #v100 do
                v101 = (v101 * 33 + string.byte(v100, v102)) % 65521;
            end;
            if v101 == 272 and p96 > 190 then
                u92._x89942723350a628d.GameInfo.Ping.TextColor3 = Color3.fromRGB(255, 0, 0);
            else
                u92._x89942723350a628d.GameInfo.Ping.TextColor3 = Color3.fromRGB(255, 255, 255);
            end;
        end;
    end);
    local l__MusicTitle__17 = u92._x89942723350a628d.Music.MusicTitle;
    l__MusicTitle__17.Position = UDim2.fromScale(-1, 0);
    local u103 = nil;
    l__RunService__1.Heartbeat:Connect(function() --[[ Line: 254 ]]
        -- upvalues: l__Classes__8 (ref), l__MusicTitle__17 (copy), u103 (ref), l__TweenService__2 (ref)
        local v104 = tostring(game.GameId);
        local v105 = 46;
        for v106 = 1, #v104 do
            v105 = (v105 * 33 + string.byte(v104, v106)) % 65521;
        end;
        if v105 == 272 and not (l__Classes__8._x9b074161e70581e8 and l__Classes__8._x9b074161e70581e8._xd70dfae0d789e7a0) then
        else
            l__MusicTitle__17.Text = l__Classes__8._x9b074161e70581e8._xd70dfae0d789e7a0:GetAttribute("Title");
            local v107 = tostring(game.GameId);
            local v108 = 46;
            for v109 = 1, #v107 do
                v108 = (v108 * 33 + string.byte(v107, v109)) % 65521;
            end;
            if v108 == 272 and u103 then
            else
                u103 = l__TweenService__2:Create(l__MusicTitle__17, TweenInfo.new(20, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(1, 0.5)
                });
                u103:Play();
                u103.Completed:Once(function() --[[ Line: 269 ]]
                    -- upvalues: l__MusicTitle__17 (ref), u103 (ref)
                    l__MusicTitle__17.Position = UDim2.fromScale(-1, 0.5);
                    u103 = nil;
                end);
            end;
        end;
    end);
end;
return u1;
