-- Decompiled from: Vote
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local u1 = next;
local u2 = print;
local l__min__1 = math.min;
local l__max__2 = math.max;
local u3 = tick;
local l__obtain__3 = _G.obtain;
local v4 = l__obtain__3("Remote");
local l__Call__4 = v4.Call;
local u5 = l__obtain__3("QBox");
local l__New__5 = u5.New;
local l__DragBar__6 = u5.DragBar;
local l__TextBox__7 = u5.TextBox;
local l__Image__8 = u5.Image;
local l__FromList__9 = u5.FromList;
local l__Color__10 = u5.Color;
local u6 = l__obtain__3("Tween");
local l__GetCompletion__11 = l__obtain__3("MapLists").GetCompletion;
local u7 = nil;
local l__Vote__12 = l__obtain__3("InputBinds").Vote;
local u8 = l__Color__10(255, 242, 0, 192);
local u9 = l__Color__10(255, 242, 0, 255);
local u10 = l__Color__10(80, 80, 80, 128);
local u11 = l__Color__10(80, 80, 80, 255);
local u12 = l__Color__10(255, 255, 255, 255);
local u13 = l__Color__10(137, 232, 148, 255);
local u14 = l__Color__10(97, 164, 105, 255);
local u15 = l__Color__10(60, 60, 60, 192);
local u16 = l__Color__10(255, 255, 255, 255);
local u17 = l__Color__10(40, 40, 40, 192);
local u18 = l__Color__10(10, 10, 10, 192);
local u19 = l__Color__10(255, 255, 255, 255);
local u20 = l__Color__10(255, 0, 0, 255);
local u21 = {};
local u22 = nil;
local u23 = {};
v4.Add("PlayerVote", function(p24, p25, p26) --[[ Name: PlayerVote, Line 62 ]]
    -- upvalues: u23 (copy)
    local v27 = u23[p25];
    if v27 then
        v27.Votes[p24] = p26;
    end;
end);
v4.Add("Vote.New", function(u28, p29, u30, u31, p32) --[[ Name: New, Line 71 ]]
    -- upvalues: u2 (copy), u22 (ref), l__New__5 (copy), l__TextBox__7 (copy), u15 (copy), u16 (copy), u17 (copy), u18 (copy), l__Color__10 (copy), u19 (copy), u20 (copy), u3 (copy), l__Call__4 (copy), l__FromList__9 (copy), u10 (copy), u5 (copy), u12 (copy), u8 (copy), u9 (copy), u11 (copy), u7 (ref), u13 (copy), u14 (copy), l__Image__8 (copy), u6 (copy), l__max__2 (copy), l__min__1 (copy), l__DragBar__6 (copy), u23 (copy), l__GetCompletion__11 (copy)
    u2("A VOTE WAS STARTED");
    u22 = u28;
    local u33 = l__New__5();
    u33.PosOffsetX = -u33.SizeX;
    u33.PosScaleY = 0.6;
    local u34 = 15;
    function u33.Resize() --[[ Line: 78 ]]
        -- upvalues: u33 (copy), u34 (ref)
        u33.PosOffsetY = u33.SizeY / -2 + u34;
    end;
    u33.SizeOffsetX = 400;
    u33.SizeScaleY = 0;
    u33.DrawBackground = false;
    local u35 = l__TextBox__7(u33, p29);
    u35.BackgroundColor = u15;
    u35.TextColor = u16;
    u35.TextAlignment = "Center";
    u35.SizeScaleX = 1;
    u35.SizeOffsetX = -30;
    u35.SizeOffsetY = 30;
    u35.PosOffsetY = -30;
    local u36 = l__TextBox__7(u33, "x");
    u36.TextAlignment = "Center";
    u36.BackgroundColor = u17;
    u36.SizeOffsetX = 30;
    u36.SizeOffsetY = 30;
    u36.PosOffsetX = -30;
    u36.PosOffsetY = -30;
    u36.PosScaleX = 1;
    function u36.Fade(p37) --[[ Line: 102 ]]
        -- upvalues: u36 (copy), u17 (ref), u18 (ref), l__Color__10 (ref), u19 (ref), u20 (ref)
        local v38 = u36;
        local v39 = u17;
        local v40 = u18;
        local v41 = 1 - p37;
        v38.BackgroundColor = l__Color__10(v39.r * v41 + v40.r * p37, v39.g * v41 + v40.g * p37, v39.b * v41 + v40.b * p37, v39.a * v41 + v40.a * p37);
        local v42 = u36;
        local v43 = u19;
        local v44 = u20;
        local v45 = 1 - p37;
        v42.TextColor = l__Color__10(v43.r * v45 + v44.r * p37, v43.g * v45 + v44.g * p37, v43.b * v45 + v44.b * p37, v43.a * v45 + v44.a * p37);
    end;
    local u46 = {
        Selected = nil,
        Hovered = nil,
        VoteID = u28,
        Entries = u31,
        StartTime = u3(),
        Duration = p32,
        Votes = {},
        VoteGui = u33
    };
    local u47 = nil;
    local function u51(p48) --[[ Line: 109 ]]
        -- upvalues: u46 (copy), l__Call__4 (ref), u28 (copy), u47 (ref)
        local l__Selected__13 = u46.Selected;
        if l__Selected__13 ~= p48 then
            u46.Selected = p48;
            l__Call__4("PlayerVote", u28, p48);
            local v49 = u47[l__Selected__13];
            if v49 then
                v49.Fade(v49.FadeTween:Value());
            end;
            local v50 = u47[p48];
            if v50 then
                v50.Fade(v50.FadeTween:Value());
            end;
        end;
    end;
    u46.ChooseEntry = u51;
    function u46.HoverEntry(p52) --[[ Line: 125 ]]
        -- upvalues: u46 (copy), u47 (ref)
        if u46.Hovered ~= p52 then
            local v53 = u47[u46.Hovered];
            if v53 then
                v53.ForceHovering = false;
            end;
            u46.Hovered = p52;
            local v54 = u47[p52];
            if v54 then
                v54.ForceHovering = true;
            end;
        end;
    end;
    u47 = l__FromList__9(u31, function(u55, p56) --[[ Line: 139 ]]
        -- upvalues: l__New__5 (ref), u33 (copy), u10 (ref), l__TextBox__7 (ref), u30 (copy), u5 (ref), u12 (ref), u51 (copy), u46 (copy), u8 (ref), u9 (ref), l__Color__10 (ref), u11 (ref), u7 (ref), u13 (ref), u14 (ref), u47 (ref), l__Image__8 (ref)
        local u57 = l__New__5(u33);
        u57.BackgroundColor = u10;
        local u58 = l__TextBox__7(u57, u30[u55]);
        u58.DrawBackground = false;
        u58.TextAlignment = "Center";
        u58.TextSize = 12 * u5.roblox_messing_with_guis_factor;
        u58.TextColor = u12;
        u58.TextWraps = true;
        u58.SizeScaleX = 1;
        u58.SizeScaleY = 1;
        function u58.Resize() --[[ Line: 151 ]]
            -- upvalues: u58 (copy)
            u58.SizeOffsetX = -u58.SizeY;
        end;
        function u57.Button1Down() --[[ Line: 154 ]]
            -- upvalues: u51 (ref), u55 (copy)
            u51(u55);
        end;
        u57.FadeDuration = 0.15;
        local l__Map__14 = p56.Map;
        function u57.Fade(p59) --[[ Line: 159 ]]
            -- upvalues: u57 (copy), u46 (ref), u55 (copy), u8 (ref), u9 (ref), l__Color__10 (ref), u10 (ref), u11 (ref), u7 (ref), l__Map__14 (copy), u13 (ref), u14 (ref)
            u57.SizeOffsetX = u57.SizeY * p59;
            if u46.Selected == u55 then
                local v60 = u57;
                local v61 = u8;
                local v62 = u9;
                local v63 = 1 - p59;
                v60.BackgroundColor = l__Color__10(v61.r * v63 + v62.r * p59, v61.g * v63 + v62.g * p59, v61.b * v63 + v62.b * p59, v61.a * v63 + v62.a * p59);
            else
                local v64 = u10;
                local v65 = u11;
                if u7 and u7[l__Map__14] then
                    v64 = u13;
                    v65 = u14;
                end;
                local v66 = u57;
                local v67 = 1 - p59;
                v66.BackgroundColor = l__Color__10(v64.r * v67 + v65.r * p59, v64.g * v67 + v65.g * p59, v64.b * v67 + v65.b * p59, v64.a * v67 + v65.a * p59);
            end;
        end;
        function u57.MouseEnter() --[[ Line: 173 ]]
            -- upvalues: u55 (copy), u46 (ref), u47 (ref)
            local v68 = u55;
            if u46.Hovered ~= v68 then
                local v69 = u47[u46.Hovered];
                if v69 then
                    v69.ForceHovering = false;
                end;
                u46.Hovered = v68;
                local v70 = u47[v68];
                if v70 then
                    v70.ForceHovering = true;
                end;
            end;
        end;
        function u57.MouseLeave() --[[ Line: 176 ]]
            -- upvalues: u46 (ref), u55 (copy), u47 (ref)
            if u46.Hovered == u55 and u46.Hovered ~= nil then
                local v71 = u47[u46.Hovered];
                if v71 then
                    v71.ForceHovering = false;
                end;
                u46.Hovered = nil;
                local v72 = u47[nil];
                if v72 then
                    v72.ForceHovering = true;
                end;
            end;
        end;
        local l__Rating__15 = p56.Rating;
        if l__Rating__15 then
            local u73 = u5.Rating(u57);
            u57.Rating = u73;
            u73.AllowRating = false;
            u73.PosScaleX = 1;
            u73.SizeScaleY = 1;
            u73.SizeOffsetX = 5 * u57.SizeY;
            u73.PosOffsetX = -5 * u57.SizeY;
            function u57.Resize() --[[ Line: 190 ]]
                -- upvalues: u73 (copy), u57 (copy)
                u73.SizeOffsetX = 5 * u57.SizeY;
                u73.PosOffsetX = -5 * u57.SizeY;
            end;
            u73.Rating = l__Rating__15;
        end;
        local l__Thumbnail__16 = p56.Thumbnail;
        if l__Thumbnail__16 then
            local v74 = l__New__5(u57);
            v74.DrawBackground = false;
            v74.SizeScaleX = 1;
            v74.SizeScaleY = 1;
            local u75 = l__New__5(v74);
            u75.DrawBackground = false;
            u75.PosScaleX = 1;
            u75.SizeScaleY = 1;
            function u75.Resize() --[[ Line: 206 ]]
                -- upvalues: u75 (copy)
                u75.PosOffsetX = -u75.SizeY;
                u75.SizeOffsetX = u75.SizeY;
            end;
            local u76 = l__Image__8(u75, l__Thumbnail__16);
            u76.SizeScaleX = 1;
            u76.SizeScaleY = 1;
            function v74.Fade(p77) --[[ Line: 213 ]]
                -- upvalues: u76 (copy)
                u76.PosScaleX = -8 * p77 / 2;
                u76.PosScaleY = -8 * p77 / 2;
                u76.SizeScaleX = 1 - p77 + 8 * p77;
                u76.SizeScaleY = 1 - p77 + 8 * p77;
            end;
            u76.ZIndex = 5;
            function v74.MouseEnter() --[[ Line: 220 ]]
                -- upvalues: u76 (copy)
                u76.ZIndex = 6;
            end;
            function v74.MouseLeave() --[[ Line: 223 ]]
                -- upvalues: u76 (copy)
                u76.ZIndex = 5;
            end;
        end;
        return u57;
    end);
    u46.Items = u47;
    u6.Once(-u33.SizeX, 0, 0.5, function(p78) --[[ Line: 231 ]]
        -- upvalues: u33 (copy)
        u33.PosOffsetX = p78;
    end, function() --[[ Line: 234 ]]
        -- upvalues: u6 (ref), u31 (copy), l__max__2 (ref), l__min__1 (ref), u33 (copy), l__DragBar__6 (ref), u35 (copy)
        u6.Once(0, l__min__1(0.8, (l__max__2(0.2, #u31 * 0.05))), 0.5, function(p79) --[[ Line: 235 ]]
            -- upvalues: u33 (ref)
            u33.SizeScaleY = p79;
        end, function() --[[ Line: 237 ]]
            -- upvalues: l__DragBar__6 (ref), u35 (ref), u33 (ref)
            l__DragBar__6(u35, u33);
        end);
    end);
    local function v84() --[[ Line: 241 ]]
        -- upvalues: u22 (ref), u28 (copy), u36 (copy), u35 (copy), u47 (ref), u34 (ref), u33 (copy), u6 (ref)
        if u22 == u28 then
            u22 = nil;
        end;
        u36.Button1Down = nil;
        u35.Button1Down = nil;
        u35.Think = nil;
        u35.Button1Up = nil;
        for v80 = 1, #u47 do
            local v81 = u47[v80];
            v81.Button1Down = nil;
            local l__Fade__17 = v81.Fade;
            if l__Fade__17 then
                l__Fade__17(0);
                v81.Fade = nil;
            end;
        end;
        u34 = u33.PosOffsetY + u33.SizeY / 2 + 15;
        u6.Once(u33.SizeScaleY, 0, 0.5, function(p82) --[[ Line: 259 ]]
            -- upvalues: u33 (ref)
            u33.SizeScaleY = p82;
        end, function() --[[ Line: 262 ]]
            -- upvalues: u6 (ref), u33 (ref)
            u6.Once(u33.PosOffsetX, -u33.SizeX, u6.MaximizeAccelerationDuration(u33.PosOffsetX, -u33.SizeX, 0, 0, u6.MaxAcceleration(0, u33.SizeX, 0, 0, 0.5)), function(p83) --[[ Line: 263 ]]
                -- upvalues: u33 (ref)
                u33.PosOffsetX = p83;
            end, function() --[[ Line: 266 ]]
                -- upvalues: u33 (ref)
                u33:Remove();
            end);
        end);
    end;
    u36.Button1Down = v84;
    u46.Close = v84;
    u23[u28] = u46;
    if p29 == "Scroll wheel + left click, or hold tab" and not u7 then
        u7 = l__GetCompletion__11();
        local v85 = u47;
        for v86 = 1, #u47 do
            local v87 = v85[v86];
            v87.Fade(v87.FadeTween:Value());
        end;
    end;
end);
v4.Add("SetVoteRatings", function(p88) --[[ Line: 285 ]]
    -- upvalues: u1 (copy), u21 (copy)
    for v89, v90 in u1, p88 do
        u21[v89] = v90;
    end;
end);
v4.Add("Vote.End", function(p91, _, _) --[[ Name: End, Line 328 ]]
    -- upvalues: u23 (copy)
    local v92 = u23[p91];
    local v93 = v92 and v92.Close;
    if v93 then
        v93();
    end;
end);
local u94 = false;
local u95 = false;
local u96 = 0;
l__Vote__12:RegisterBindable("VotePick", function(p97) --[[ Line: 342 ]]
    -- upvalues: u95 (ref)
    u95 = p97;
end, "MouseButton1");
l__Vote__12:RegisterBindable("VoteCycle", function(p98) --[[ Line: 345 ]]
    -- upvalues: u96 (ref)
    if p98 < 0 then
        u96 = u96 + 1;
    else
        if p98 > 0 then
            u96 = u96 - 1;
        end;
    end;
end, "MouseWheel");
return function() --[[ Line: 354 ]]
    -- upvalues: u23 (copy), u22 (ref), u96 (ref), u95 (ref), u94 (ref)
    game:GetService("RunService").Stepped:connect(function() --[[ Line: 356 ]]
        -- upvalues: u23 (ref), u22 (ref), u96 (ref), u95 (ref), u94 (ref)
        local v99 = u23[u22];
        if v99 then
            local v100 = #v99.Entries;
            if u96 ~= 0 then
                local l__Hovered__18 = v99.Hovered;
                if l__Hovered__18 then
                    v99.HoverEntry((l__Hovered__18 + u96 - 1) % v100 + 1);
                else
                    local l__Selected__19 = v99.Selected;
                    if l__Selected__19 then
                        v99.HoverEntry((l__Selected__19 + u96 - 1) % v100 + 1);
                    elseif u96 < 0 then
                        v99.HoverEntry((v100 + u96) % v100 + 1);
                    else
                        v99.HoverEntry((u96 - 1) % v100 + 1);
                    end;
                end;
            end;
        end;
        u96 = 0;
        local v101 = u23[u22];
        local v102 = v101 and u95 and (not u94 and v101.Hovered);
        if v102 then
            v101.ChooseEntry(v102);
        end;
        u94 = u95;
    end);
end;
