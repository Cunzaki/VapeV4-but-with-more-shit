-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local v1 = tick;
local u2 = type;
local u3 = tostring;
local l__atan__1 = math.atan;
local l__cos__2 = math.cos;
local l__sin__3 = math.sin;
local l__log__4 = math.log;
local l__random__5 = math.random;
local l__concat__6 = table.concat;
local l__insert__7 = table.insert;
local l__remove__8 = table.remove;
local l__gmatch__9 = string.gmatch;
local l__format__10 = string.format;
local l__obtain__11 = _G.obtain;
local v4 = l__obtain__11("QBox");
local l__New__12 = v4.New;
local l__Image__13 = v4.Image;
local l__TextBox__14 = v4.TextBox;
local l__FadeReveal__15 = v4.FadeReveal;
local l__ResizeToText__16 = v4.ResizeToText;
local u5 = l__obtain__11("Tween");
local l__Update__17 = u5.Update;
local l__Enumify__18 = l__obtain__11("Enums").Enumify;
local u6 = l__obtain__11("CurTime");
local v7 = l__obtain__11("TextInfo");
local l__CharSize__19 = v7.CharSize;
local l__TextSize__20 = v7.TextSize;
local l__GetHeight__21 = v7.GetHeight;
local function u16(p8, p9, p10, p11) --[[ Line: 45 ]]
    local v12 = p10 or 255;
    local v13 = p11 or 255;
    local v14 = v12 * (1 - (p9 or 255) / 255);
    local v15 = p8 * 6;
    return v15 < 1 and {
        r = v12,
        g = v12 * v15 + v14,
        b = v14,
        a = v13 or 255
    } or (v15 < 2 and {
        r = v12 * (2 - v15) + v14,
        g = v12,
        b = v14,
        a = v13 or 255
    } or (v15 < 3 and {
        r = v14,
        g = v12,
        b = v12 * (v15 - 2) + v14,
        a = v13 or 255
    } or (v15 < 4 and {
        r = v14,
        g = v12 * (4 - v15) + v14,
        b = v12,
        a = v13 or 255
    } or (v15 < 5 and {
        r = v12 * (v15 - 4) + v14,
        g = v14,
        b = v12,
        a = v13 or 255
    } or {
        r = v12,
        g = v14,
        b = v12 * (6 - v15) + v14,
        a = v13 or 255
    }))));
end;
local function u24(p17, p18, p19, p20) --[[ Line: 67 ]]
    -- upvalues: l__cos__2 (copy)
    local v21 = p19 or 255;
    local v22 = v21 * (1 - (p18 or 255) / 255);
    local v23 = 6.283185307179586 * p17;
    return {
        r = v21 * (l__cos__2(v23) + 1) / 2 + v22,
        g = v21 * (l__cos__2(v23 - 2.0943951023931953) + 1) / 2 + v22,
        b = v21 * (l__cos__2(v23 + 2.0943951023931953) + 1) / 2 + v22,
        a = p20 or 255 or 255
    };
end;
local u25 = {};
local u46 = {
    Flash = function(u26, u27, u28) --[[ Name: Flash, Line 83 ]]
        return function(p29) --[[ Line: 84 ]]
            -- upvalues: u26 (copy), u27 (copy), u28 (copy)
            return p29 * u26 % 1 < 0.5 and u27 or u28;
        end;
    end,
    Glow = function(u30) --[[ Name: Glow, Line 88 ]]
        -- upvalues: u24 (copy)
        return function(p31) --[[ Line: 89 ]]
            -- upvalues: u24 (ref), u30 (copy)
            return u24(p31 * u30 % 1);
        end;
    end,
    Fade = function(p32, p33, p34) --[[ Name: Fade, Line 93 ]]
        -- upvalues: l__cos__2 (copy)
        local u35 = p32 * 6.283185307179586;
        local u36 = (p34.r + p33.r) / 2;
        local u37 = (p34.g + p33.g) / 2;
        local u38 = (p34.b + p33.b) / 2;
        local u39 = (p34.a + p33.a) / 2;
        local u40 = (p34.r - p33.r) / 2;
        local u41 = (p34.g - p33.g) / 2;
        local u42 = (p34.b - p33.b) / 2;
        local u43 = (p34.a - p33.a) / 2;
        return function(p44) --[[ Line: 97 ]]
            -- upvalues: u35 (copy), l__cos__2 (ref), u40 (copy), u36 (copy), u41 (copy), u37 (copy), u42 (copy), u38 (copy), u43 (copy), u39 (copy)
            local v45 = l__cos__2(u35 * p44);
            return {
                r = v45 * u40 + u36,
                g = v45 * u41 + u37,
                b = v45 * u42 + u38,
                a = v45 * u43 + u39 or 255
            };
        end;
    end
};
local u91 = {
    Rainbow = function(u47) --[[ Name: Rainbow, Line 105 ]]
        -- upvalues: u16 (copy)
        local u48 = 0;
        return function() --[[ Line: 107 ]]
            -- upvalues: u48 (ref), u16 (ref), u47 (copy)
            u48 = u48 + 1;
            return u16((u48 - 1) / (u47 - 1));
        end;
    end,
    Gradient = function(u49, p50, p51) --[[ Name: Gradient, Line 112 ]]
        local u52 = 0;
        local l__r__22 = p50.r;
        local l__g__23 = p50.g;
        local l__b__24 = p50.b;
        local l__a__25 = p50.a;
        local u53 = p51.r - l__r__22;
        local u54 = p51.g - l__g__23;
        local u55 = p51.b - l__b__24;
        local u56 = p51.a - l__a__25;
        return function() --[[ Line: 116 ]]
            -- upvalues: u52 (ref), u49 (copy), l__r__22 (copy), u53 (copy), l__g__23 (copy), u54 (copy), l__b__24 (copy), u55 (copy), l__a__25 (copy), u56 (copy)
            u52 = u52 + 1;
            local v57 = (u52 - 1) / (u49 - 1);
            return {
                r = l__r__22 + u53 * v57,
                g = l__g__23 + u54 * v57,
                b = l__b__24 + u55 * v57,
                a = l__a__25 + u56 * v57 or 255
            };
        end;
    end,
    FadeWave = function(p58, p59, u60, u61) --[[ Name: FadeWave, Line 122 ]]
        -- upvalues: l__cos__2 (copy)
        local l__r__26 = p58.r;
        local l__g__27 = p58.g;
        local l__b__28 = p58.b;
        local l__a__29 = p58.a;
        local u62 = p59.r - l__r__26;
        local u63 = p59.g - l__g__27;
        local u64 = p59.b - l__b__28;
        local u65 = p59.a - l__a__29;
        local u66 = 0;
        return function(p67) --[[ Line: 126 ]]
            -- upvalues: u66 (ref), u60 (copy), u61 (copy), l__cos__2 (ref), l__r__26 (copy), u62 (copy), l__g__27 (copy), u63 (copy), l__b__28 (copy), u64 (copy), l__a__29 (copy), u65 (copy)
            local l__SizeX__30 = p67.SizeX;
            local u68 = (u66 + l__SizeX__30 / 2) / u60;
            u66 = u66 + l__SizeX__30;
            return function(p69) --[[ Line: 130 ]]
                -- upvalues: u68 (copy), u61 (ref), l__cos__2 (ref), l__r__26 (ref), u62 (ref), l__g__27 (ref), u63 (ref), l__b__28 (ref), u64 (ref), l__a__29 (ref), u65 (ref)
                local v70 = l__cos__2((u68 - u61 * p69) % 1 * 6.283185307179586) * 0.5 + 0.5;
                return {
                    r = l__r__26 + u62 * v70,
                    g = l__g__27 + u63 * v70,
                    b = l__b__28 + u64 * v70,
                    a = l__a__29 + u65 * v70 or 255
                };
            end;
        end;
    end,
    Wave = function(u71, u72, u73) --[[ Name: Wave, Line 136 ]]
        -- upvalues: l__sin__3 (copy), l__cos__2 (copy), l__atan__1 (copy)
        local u74 = 0;
        return function(u75) --[[ Line: 138 ]]
            -- upvalues: u74 (ref), u72 (copy), u71 (copy), u73 (copy), l__sin__3 (ref), l__cos__2 (ref), l__atan__1 (ref)
            local l__SizeX__31 = u75.SizeX;
            local u76 = (u74 + l__SizeX__31 / 2) / u72;
            u74 = u74 + l__SizeX__31;
            local u77 = true;
            local u78 = 0;
            local u79 = 0;
            local l__PosOffsetX__32 = u75.PosOffsetX;
            local l__PosOffsetY__33 = u75.PosOffsetY;
            function u75.Moved() --[[ Line: 145 ]]
                -- upvalues: u77 (ref), l__PosOffsetX__32 (ref), l__PosOffsetY__33 (ref), u75 (copy), u78 (ref), u79 (ref)
                if u77 then
                    local v80 = u75.PosOffsetX - u78;
                    local v81 = u75.PosOffsetY - u79;
                    l__PosOffsetX__32 = v80;
                    l__PosOffsetY__33 = v81;
                end;
            end;
            local u82 = 6.283185307179586 * u71 / u72;
            return function(p83) --[[ Line: 151 ]]
                -- upvalues: u77 (ref), u78 (ref), u79 (ref), u71 (ref), u76 (copy), u73 (ref), l__sin__3 (ref), u75 (copy), l__PosOffsetX__32 (ref), l__PosOffsetY__33 (ref), u82 (copy), l__cos__2 (ref), l__atan__1 (ref)
                u77 = false;
                local v84 = u71 * l__sin__3((u76 - u73 * p83) % 1 * 6.283185307179586);
                u78 = 0;
                u79 = v84;
                u75.PosOffsetX = l__PosOffsetX__32 + u78;
                u75.PosOffsetY = l__PosOffsetY__33 + u79;
                u75.Rotation = l__atan__1(u82 * l__cos__2((u76 - u73 * p83) % 1 * 6.283185307179586));
                u77 = true;
            end;
        end;
    end,
    RainbowGlow = function(u85, u86) --[[ Name: RainbowGlow, Line 161 ]]
        -- upvalues: u16 (copy)
        local u87 = 0;
        return function(p88) --[[ Line: 163 ]]
            -- upvalues: u87 (ref), u85 (copy), u16 (ref), u86 (copy)
            local u89 = u87 / u85;
            u87 = u87 + p88.SizeX;
            return function(p90) --[[ Line: 166 ]]
                -- upvalues: u16 (ref), u89 (copy), u86 (ref)
                return u16((u89 - p90 * u86) % 1);
            end;
        end;
    end
};
local u92 = 0;
local u93 = 0;
local u94 = 0;
local u95 = 0;
local l__SourceSans__34 = Enum.Font.SourceSans;
local u96 = {
    r = 34,
    g = 34,
    b = 34,
    a = 64
};
local u97 = {
    r = 255,
    g = 255,
    b = 255,
    a = 255
};
local u98 = {
    r = 0,
    g = 0,
    b = 0,
    a = 0
};
local u99 = 0;
local u100 = { l__SourceSans__34 };
local u101 = { 18 };
local u102 = { u96 };
local u103 = { u97 };
local u104 = { u98 };
local u105 = {};
local u106 = {};
local u107 = {};
local u108 = {};
local u109 = {};
local u110 = {};
local u111 = {};
local u112 = {};
local u113 = {};
local u114 = {};
local u115 = {};
local u116 = {};
local function u117() --[[ Line: 204 ]]
    -- upvalues: u92 (ref), u93 (ref), u94 (ref), u95 (ref), u99 (ref), u100 (ref), l__SourceSans__34 (copy), u101 (ref), u103 (ref), u97 (copy), u102 (ref), u96 (copy), u104 (ref), u98 (copy), u105 (ref), u106 (ref), u107 (ref), u108 (ref), u109 (ref), u110 (ref), u111 (ref), u112 (ref), u113 (ref), u114 (ref), u115 (ref), u116 (ref)
    u92 = 0;
    u93 = 0;
    u94 = 0;
    u95 = 0;
    u99 = 0;
    u100 = { l__SourceSans__34 };
    u101 = { 18 };
    u103 = { u97 };
    u102 = { u96 };
    u104 = { u98 };
    u105 = {};
    u106 = {};
    u107 = {};
    u108 = {};
    u109 = {};
    u110 = {};
    u111 = {};
    u112 = {};
    u113 = {};
    u114 = {};
    u115 = {};
    u116 = {};
end;
u25.ClearFormatting = u117;
function u25.List(...) --[[ Line: 231 ]]
    -- upvalues: l__New__12 (copy)
    local v118 = { ... };
    local v119 = #v118;
    if v119 > 1 then
        local v120 = l__New__12();
        v120.DrawBackground = false;
        local v121 = 0;
        local v122 = 0;
        for v123 = 1, v119 do
            local v124 = v118[v123];
            v124.Parent = v120;
            v124.PosOffsetX = v121;
            v121 = v121 + v124.SizeX;
            if v122 < v124.SizeY then
                v122 = v124.SizeY;
            end;
        end;
        for v125 = 1, v119 do
            local v126 = v118[v125];
            v126.PosOffsetY = (v122 - v126.SizeY) / 2;
        end;
        v120.SizeOffsetX = v121;
        v120.SizeOffsetY = v122;
        return v120;
    end;
    if v119 == 1 then
        return ...;
    end;
end;
function u25.Column(...) --[[ Line: 259 ]]
    -- upvalues: l__New__12 (copy)
    local v127 = { ... };
    local v128 = #v127;
    if v128 > 1 then
        local v129 = l__New__12();
        v129.DrawBackground = false;
        local v130 = 0;
        local v131 = 0;
        for v132 = 1, v128 do
            local v133 = v127[v132];
            v133.Parent = v129;
            v133.PosOffsetY = v130;
            v130 = v130 + v133.SizeY;
            if v131 < v133.SizeX then
                v131 = v133.SizeX;
            end;
        end;
        for v134 = 1, v128 do
            local v135 = v127[v134];
            v135.PosOffsetX = (v131 - v135.SizeX) / 2;
        end;
        v129.SizeOffsetY = v130;
        v129.SizeOffsetX = v131;
        return v129;
    end;
    if v128 == 1 then
        return ...;
    end;
end;
function u25.SetDelay(p136) --[[ Line: 287 ]]
    -- upvalues: u99 (ref)
    u99 = p136;
end;
function u25.IncrementDelay(p137) --[[ Line: 290 ]]
    -- upvalues: u99 (ref)
    u99 = u99 + p137;
end;
local u138 = l__Enumify__18(Enum.Font);
function u25.Font(p139) --[[ Line: 294 ]]
    -- upvalues: u100 (ref), l__SourceSans__34 (copy), u138 (copy)
    if p139 == "Default" then
        u100[#u100] = l__SourceSans__34;
    else
        u100[#u100] = u138[p139];
    end;
end;
function u25.PushFont(p140, ...) --[[ Line: 301 ]]
    -- upvalues: u100 (ref), l__SourceSans__34 (copy), l__insert__7 (copy), u91 (copy), u138 (copy)
    if p140 == "Default" then
        l__insert__7(u100, l__SourceSans__34);
    else
        local v141 = u91[p140];
        if v141 then
            l__insert__7(u100, v141(...));
        else
            l__insert__7(u100, u138[p140]);
        end;
    end;
end;
function u25.PopFont() --[[ Line: 313 ]]
    -- upvalues: l__remove__8 (copy), u100 (ref), l__SourceSans__34 (copy)
    l__remove__8(u100);
    u100[1] = u100[1] or l__SourceSans__34;
end;
function u25.FontSize(p142) --[[ Line: 317 ]]
    -- upvalues: u101 (ref)
    if p142 == "Default" then
        u101[#u101] = 18;
    else
        u101[#u101] = p142;
    end;
end;
function u25.PushFontSize(p143, ...) --[[ Line: 324 ]]
    -- upvalues: u101 (ref), l__insert__7 (copy), u91 (copy)
    if p143 == "Default" then
        l__insert__7(u101, 18);
    else
        local v144 = u91[p143];
        if v144 then
            l__insert__7(u101, v144(...));
        else
            l__insert__7(u101, p143);
        end;
    end;
end;
function u25.PopFontSize() --[[ Line: 336 ]]
    -- upvalues: l__remove__8 (copy), u101 (ref)
    l__remove__8(u101);
    u101[1] = u101[1] or 18;
end;
function u25.TextStroke(p145) --[[ Line: 340 ]]
    -- upvalues: u102 (ref), u96 (copy)
    if p145 == "Default" then
        u102[#u102] = u96;
    else
        u102[#u102] = p145;
    end;
end;
function u25.PushTextStroke(p146, ...) --[[ Line: 347 ]]
    -- upvalues: u102 (ref), u96 (copy), l__insert__7 (copy), u91 (copy)
    if p146 == "Default" then
        l__insert__7(u102, u96);
    else
        local v147 = u91[p146];
        if v147 then
            l__insert__7(u102, v147(...));
        else
            l__insert__7(u102, p146);
        end;
    end;
end;
function u25.PopTextStroke() --[[ Line: 359 ]]
    -- upvalues: l__remove__8 (copy), u102 (ref), u96 (copy)
    l__remove__8(u102);
    u102[1] = u102[1] or u96;
end;
function u25.FGColor(p148) --[[ Line: 363 ]]
    -- upvalues: u103 (ref), u97 (copy)
    if p148 == "Default" then
        u103[#u103] = u97;
    else
        u103[#u103] = p148;
    end;
end;
function u25.PushFGColor(p149, ...) --[[ Line: 370 ]]
    -- upvalues: u103 (ref), u97 (copy), l__insert__7 (copy), u91 (copy)
    if p149 == "Default" then
        l__insert__7(u103, u97);
    else
        local v150 = u91[p149];
        if v150 then
            l__insert__7(u103, v150(...));
        else
            l__insert__7(u103, p149);
        end;
    end;
end;
function u25.PopFGColor() --[[ Line: 382 ]]
    -- upvalues: l__remove__8 (copy), u103 (ref), u97 (copy)
    l__remove__8(u103);
    u103[1] = u103[1] or u97;
end;
function u25.BGColor(p151) --[[ Line: 386 ]]
    -- upvalues: u104 (ref), u98 (copy)
    if p151 == "Default" then
        u104[#u104] = u98;
    else
        u104[#u104] = p151;
    end;
end;
function u25.PushBGColor(p152, ...) --[[ Line: 393 ]]
    -- upvalues: u104 (ref), u98 (copy), l__insert__7 (copy), u91 (copy)
    if p152 == "Default" then
        l__insert__7(u104, u98);
    else
        local v153 = u91[p152];
        if v153 then
            l__insert__7(u104, v153(...));
        else
            l__insert__7(u104, p152);
        end;
    end;
end;
function u25.PopBGColor() --[[ Line: 405 ]]
    -- upvalues: l__remove__8 (copy), u104 (ref), u98 (copy)
    l__remove__8(u104);
    u104[1] = u104[1] or u98;
end;
function u25.ThinkFunc(p154, ...) --[[ Line: 409 ]]
    -- upvalues: u105 (ref), u111 (ref), u46 (copy), u91 (copy)
    if p154 == "Default" then
        u105[#u105] = false;
        u111[#u111] = false;
    else
        local v155 = u46[p154];
        if v155 then
            u105[#u105] = v155(...);
            u111[#u111] = false;
        else
            local v156 = u91[p154];
            if v156 then
                u105[#u105] = v156(...);
                u111[#u111] = true;
            end;
        end;
    end;
end;
function u25.PushThinkFunc(p157, ...) --[[ Line: 427 ]]
    -- upvalues: u105 (ref), l__insert__7 (copy), u111 (ref), u46 (copy), u91 (copy)
    if p157 == "Default" then
        l__insert__7(u105, false);
        l__insert__7(u111, false);
    else
        local v158 = u46[p157];
        if v158 then
            l__insert__7(u105, v158(...));
            l__insert__7(u111, false);
        else
            local v159 = u91[p157];
            if v159 then
                l__insert__7(u105, v159(...));
                l__insert__7(u111, true);
            end;
        end;
    end;
end;
function u25.PopThinkFunc() --[[ Line: 445 ]]
    -- upvalues: l__remove__8 (copy), u105 (ref), u111 (ref)
    l__remove__8(u105);
    l__remove__8(u111);
end;
function u25.FontThinkFunc(p160, ...) --[[ Line: 449 ]]
    -- upvalues: u106 (ref), u112 (ref), u46 (copy), u91 (copy)
    if p160 == "Default" then
        u106[#u106] = false;
        u112[#u112] = false;
    else
        local v161 = u46[p160];
        if v161 then
            u106[#u106] = v161(...);
            u112[#u112] = false;
        else
            local v162 = u91[p160];
            if v162 then
                u106[#u106] = v162(...);
                u112[#u112] = true;
            end;
        end;
    end;
end;
function u25.PushFontThinkFunc(p163, ...) --[[ Line: 467 ]]
    -- upvalues: u106 (ref), l__insert__7 (copy), u112 (ref), u46 (copy), u91 (copy)
    if p163 == "Default" then
        l__insert__7(u106, false);
        l__insert__7(u112, false);
    else
        local v164 = u46[p163];
        if v164 then
            l__insert__7(u106, v164(...));
            l__insert__7(u112, false);
        else
            local v165 = u91[p163];
            if v165 then
                l__insert__7(u106, v165(...));
                l__insert__7(u112, true);
            end;
        end;
    end;
end;
function u25.PopFontThinkFunc() --[[ Line: 485 ]]
    -- upvalues: l__remove__8 (copy), u106 (ref), u112 (ref)
    l__remove__8(u106);
    l__remove__8(u112);
end;
function u25.FontSizeThinkFunc(p166, ...) --[[ Line: 489 ]]
    -- upvalues: u107 (ref), u113 (ref), u46 (copy), u91 (copy)
    if p166 == "Default" then
        u107[#u107] = false;
        u113[#u113] = false;
    else
        local v167 = u46[p166];
        if v167 then
            u107[#u107] = v167(...);
            u113[#u113] = false;
        else
            local v168 = u91[p166];
            if v168 then
                u107[#u107] = v168(...);
                u113[#u113] = true;
            end;
        end;
    end;
end;
function u25.PushFontSizeThinkFunc(p169, ...) --[[ Line: 507 ]]
    -- upvalues: u107 (ref), l__insert__7 (copy), u113 (ref), u46 (copy), u91 (copy)
    if p169 == "Default" then
        l__insert__7(u107, false);
        l__insert__7(u113, false);
    else
        local v170 = u46[p169];
        if v170 then
            l__insert__7(u107, v170(...));
            l__insert__7(u113, false);
        else
            local v171 = u91[p169];
            if v171 then
                l__insert__7(u107, v171(...));
                l__insert__7(u113, true);
            end;
        end;
    end;
end;
function u25.PopFontSizeThinkFunc() --[[ Line: 525 ]]
    -- upvalues: l__remove__8 (copy), u107 (ref), u113 (ref)
    l__remove__8(u107);
    l__remove__8(u113);
end;
function u25.TextStrokeThinkFunc(p172, ...) --[[ Line: 529 ]]
    -- upvalues: u108 (ref), u114 (ref), u46 (copy), u91 (copy)
    if p172 == "Default" then
        u108[#u108] = false;
        u114[#u114] = false;
    else
        local v173 = u46[p172];
        if v173 then
            u108[#u108] = v173(...);
            u114[#u114] = false;
        else
            local v174 = u91[p172];
            if v174 then
                u108[#u108] = v174(...);
                u114[#u114] = true;
            end;
        end;
    end;
end;
function u25.PushTextStrokeThinkFunc(p175, ...) --[[ Line: 547 ]]
    -- upvalues: u108 (ref), l__insert__7 (copy), u114 (ref), u46 (copy), u91 (copy)
    if p175 == "Default" then
        l__insert__7(u108, false);
        l__insert__7(u114, false);
    else
        local v176 = u46[p175];
        if v176 then
            l__insert__7(u108, v176(...));
            l__insert__7(u114, false);
        else
            local v177 = u91[p175];
            if v177 then
                l__insert__7(u108, v177(...));
                l__insert__7(u114, true);
            end;
        end;
    end;
end;
function u25.PopTextStrokeThinkFunc() --[[ Line: 565 ]]
    -- upvalues: l__remove__8 (copy), u108 (ref), u114 (ref)
    l__remove__8(u108);
    l__remove__8(u114);
end;
function u25.FGColorThinkFunc(p178, ...) --[[ Line: 569 ]]
    -- upvalues: u109 (ref), u115 (ref), u46 (copy), u91 (copy)
    if p178 == "Default" then
        u109[#u109] = false;
        u115[#u115] = false;
    else
        local v179 = u46[p178];
        if v179 then
            u109[#u109] = v179(...);
            u115[#u115] = false;
        else
            local v180 = u91[p178];
            if v180 then
                u109[#u109] = v180(...);
                u115[#u115] = true;
            end;
        end;
    end;
end;
function u25.PushFGColorThinkFunc(p181, ...) --[[ Line: 587 ]]
    -- upvalues: u109 (ref), l__insert__7 (copy), u115 (ref), u46 (copy), u91 (copy)
    if p181 == "Default" then
        l__insert__7(u109, false);
        l__insert__7(u115, false);
    else
        local v182 = u46[p181];
        if v182 then
            l__insert__7(u109, v182(...));
            l__insert__7(u115, false);
        else
            local v183 = u91[p181];
            if v183 then
                l__insert__7(u109, v183(...));
                l__insert__7(u115, true);
            end;
        end;
    end;
end;
function u25.PopFGColorThinkFunc() --[[ Line: 605 ]]
    -- upvalues: l__remove__8 (copy), u109 (ref), u115 (ref)
    l__remove__8(u109);
    l__remove__8(u115);
end;
function u25.BGColorThinkFunc(p184, ...) --[[ Line: 609 ]]
    -- upvalues: u110 (ref), u116 (ref), u46 (copy), u91 (copy)
    if p184 == "Default" then
        u110[#u110] = false;
        u116[#u116] = false;
    else
        local v185 = u46[p184];
        if v185 then
            u110[#u110] = v185(...);
            u116[#u116] = false;
        else
            local v186 = u91[p184];
            if v186 then
                u110[#u110] = v186(...);
                u116[#u116] = true;
            end;
        end;
    end;
end;
function u25.PushBGColorThinkFunc(p187, ...) --[[ Line: 627 ]]
    -- upvalues: u110 (ref), l__insert__7 (copy), u116 (ref), u46 (copy), u91 (copy)
    if p187 == "Default" then
        l__insert__7(u110, false);
        l__insert__7(u116, false);
    else
        local v188 = u46[p187];
        if v188 then
            l__insert__7(u110, v188(...));
            l__insert__7(u116, false);
        else
            local v189 = u91[p187];
            if v189 then
                l__insert__7(u110, v189(...));
                l__insert__7(u116, true);
            end;
        end;
    end;
end;
function u25.PopBGColorThinkFunc() --[[ Line: 645 ]]
    -- upvalues: l__remove__8 (copy), u110 (ref), u116 (ref)
    l__remove__8(u110);
    l__remove__8(u116);
end;
function u25.Concat(...) --[[ Line: 649 ]]
    -- upvalues: l__concat__6 (copy)
    return l__concat__6({ ... });
end;
u25.Tick = v1;
function u25.TimeStamp(p190) --[[ Line: 653 ]]
    -- upvalues: u99 (ref), l__format__10 (copy)
    local v191 = (p190 + u99) % 86400;
    local v192 = (v191 - v191 % 60) / 60;
    local v193 = (v192 - v192 % 60) / 60 % 24;
    return l__format__10("%d:%.2i", (v193 - 1) % 12 + 1, v192 % 60) .. (v193 < 12 and "AM" or "PM");
end;
function u25.Space(p194, p195) --[[ Line: 659 ]]
    -- upvalues: l__New__12 (copy)
    local v196 = l__New__12();
    v196.Visible = false;
    v196.SizeOffsetX = p194;
    v196.SizeOffsetY = p195;
    return v196;
end;
function u25.Text(p197) --[[ Line: 666 ]]
    -- upvalues: u99 (ref), u100 (ref), u101 (ref), u102 (ref), u103 (ref), u104 (ref), u105 (ref), u106 (ref), u107 (ref), u108 (ref), u109 (ref), u110 (ref), u2 (copy), u111 (ref), u112 (ref), u113 (ref), u114 (ref), u115 (ref), u116 (ref), l__New__12 (copy), l__gmatch__9 (copy), l__TextBox__14 (copy), l__CharSize__19 (copy), l__ResizeToText__16 (copy), u6 (copy), l__TextSize__20 (copy)
    local u198 = u99;
    local v199 = u100[#u100];
    local v200 = u101[#u101];
    local v201 = u102[#u102];
    local v202 = u103[#u103];
    local v203 = u104[#u104];
    local u204 = u105[#u105];
    local u205 = u106[#u106];
    local u206 = u107[#u107];
    local u207 = u108[#u108];
    local u208 = u109[#u109];
    local u209 = u110[#u110];
    local v210 = u2(v199) == "function";
    local v211 = u2(v200) == "function";
    local v212 = u2(v201) == "function";
    local v213 = u2(v202) == "function";
    local v214 = u2(v203) == "function";
    local v215 = u111[#u111];
    local v216 = u112[#u112];
    local v217 = u113[#u113];
    local v218 = u114[#u114];
    local v219 = u115[#u115];
    local v220 = u116[#u116];
    if v210 or (v211 or (v212 or (v213 or (v214 or (v215 or (v216 or (v217 or (v218 or (v219 or v220))))))))) then
        local v221 = l__New__12();
        v221.DrawBackground = false;
        local v222 = 0;
        local v223 = 0;
        for v224 in l__gmatch__9(p197, ".") do
            local u225 = l__TextBox__14(v221, v224);
            local v226;
            if v210 then
                v226 = v199() or v199;
            else
                v226 = v199;
            end;
            local v227;
            if v211 then
                v227 = v200() or v200;
            else
                v227 = v200;
            end;
            u225.TextFont = v226;
            u225.TextSize = v227;
            local v228;
            if v212 then
                v228 = v201() or v201;
            else
                v228 = v201;
            end;
            u225.TextStrokeColor = v228;
            local v229;
            if v213 then
                v229 = v202() or v202;
            else
                v229 = v202;
            end;
            u225.TextColor = v229;
            local v230;
            if v214 then
                v230 = v203() or v203;
            else
                v230 = v203;
            end;
            u225.BackgroundColor = v230;
            local v231, v232 = l__CharSize__19(v226, v227, v224);
            u225.SizeOffsetX = v231;
            u225.SizeOffsetY = v232;
            u225.PosOffsetX = v222;
            u225.TextResize = l__ResizeToText__16;
            v222 = v222 + u225.SizeX;
            if v223 < u225.SizeY then
                v223 = u225.SizeY;
            end;
            if u204 or (u205 or (u206 or (u207 or (u208 or u209)))) then
                local u233;
                if v215 then
                    u233 = u204(u225) or u204;
                else
                    u233 = u204;
                end;
                local u234;
                if v216 then
                    u234 = u205(u225) or u205;
                else
                    u234 = u205;
                end;
                local u235;
                if v217 then
                    u235 = u206(u225) or u206;
                else
                    u235 = u206;
                end;
                local u236;
                if v218 then
                    u236 = u207(u225) or u207;
                else
                    u236 = u207;
                end;
                local u237;
                if v219 then
                    u237 = u208(u225) or u208;
                else
                    u237 = u208;
                end;
                local u238;
                if v220 then
                    u238 = u209(u225) or u209;
                else
                    u238 = u209;
                end;
                function u225.Think() --[[ Line: 719 ]]
                    -- upvalues: u6 (ref), u198 (copy), u233 (copy), u234 (copy), u225 (copy), u235 (copy), u236 (copy), u237 (copy), u238 (copy)
                    local v239 = u6() - u198;
                    if u233 then
                        u233(v239);
                    end;
                    if u234 then
                        u225.TextFont = u234(v239);
                    end;
                    if u235 then
                        u225.TextSize = u235(v239);
                    end;
                    if u236 then
                        u225.TextStrokeColor = u236(v239);
                    end;
                    if u237 then
                        u225.TextColor = u237(v239);
                    end;
                    if u238 then
                        u225.BackgroundColor = u238(v239);
                    end;
                end;
            end;
        end;
        local l__Children__35 = v221.Children;
        for v240 = 1, #l__Children__35 do
            local v241 = l__Children__35[v240];
            v241.PosOffsetY = (v223 - v241.SizeY) / 2;
        end;
        v221.SizeOffsetX = v222;
        v221.SizeOffsetY = v223;
        return v221;
    end;
    local u242 = l__TextBox__14(nil, p197);
    u242.TextAlignment = "Left";
    u242.TextFont = v199;
    u242.TextSize = v200;
    u242.TextStrokeColor = v201;
    u242.TextColor = v202;
    u242.BackgroundColor = v203;
    local v243, v244 = l__TextSize__20(v199, v200, p197);
    u242.SizeOffsetX = v243;
    u242.SizeOffsetY = v244;
    if u204 or (u205 or (u206 or (u207 or (u208 or u209)))) then
        function u242.Think() --[[ Line: 760 ]]
            -- upvalues: u6 (ref), u198 (copy), u204 (copy), u205 (copy), u242 (copy), u206 (copy), u207 (copy), u208 (copy), u209 (copy)
            local v245 = u6() - u198;
            if u204 then
                u204(v245);
            end;
            if u205 then
                u242.TextFont = u205(v245);
            end;
            if u206 then
                u242.TextSize = u206(v245);
            end;
            if u207 then
                u242.TextStrokeColor = u207(v245);
            end;
            if u208 then
                u242.TextColor = u208(v245);
            end;
            if u209 then
                u242.BackgroundColor = u209(v245);
            end;
        end;
    end;
    return u242;
end;
u25.TextNoCensor = u25.Text;
function u25.Image(u246, u247, p248, p249) --[[ Line: 1057 ]]
    -- upvalues: u95 (ref), l__Image__13 (copy), u99 (ref), u100 (ref), u101 (ref), u103 (ref), u104 (ref), u105 (ref), u106 (ref), u107 (ref), u109 (ref), u110 (ref), u2 (copy), u111 (ref), u112 (ref), u113 (ref), u115 (ref), u116 (ref), l__GetHeight__21 (copy), u6 (copy), u3 (copy), l__TextBox__14 (copy), u98 (copy), l__SourceSans__34 (copy), u97 (copy), u96 (copy), l__TextSize__20 (copy), l__FadeReveal__15 (copy)
    u95 = u95 + 1;
    local u250 = l__Image__13(nil, "rbxassetid://" .. (u95 > 2 and 512104556 or p248));
    local u251 = u99;
    local u252 = u100[#u100];
    local u253 = u101[#u101];
    local v254 = u103[#u103];
    local v255 = u104[#u104];
    local u256 = u105[#u105];
    local u257 = u106[#u106];
    local u258 = u107[#u107];
    local u259 = u109[#u109];
    local u260 = u110[#u110];
    if u2(v254) == "function" then
        v254 = v254() or v254;
    end;
    u250.ImageColor = v254;
    if u2(v255) == "function" then
        v255 = v255() or v255;
    end;
    u250.BackgroundColor = v255;
    local v261 = u111[#u111];
    local v262 = u112[#u112];
    local v263 = u113[#u113];
    local v264 = u115[#u115];
    local v265 = u116[#u116];
    if p249 then
        u250.SizeOffsetX = u246;
        u250.SizeOffsetY = u247;
    else
        local v266 = l__GetHeight__21;
        local v267;
        if u2(u252) == "function" then
            v267 = u252() or u252;
        else
            v267 = u252;
        end;
        local v268;
        if u2(u253) == "function" then
            v268 = u253() or u253;
        else
            v268 = u253;
        end;
        local v269 = u247 * v266(v267, v268);
        u250.SizeOffsetX = v269 * u246;
        u250.SizeOffsetY = v269;
    end;
    if u256 or (u257 or (u258 or (u259 or u260))) then
        if v261 then
            u256 = u256(u250) or u256;
        end;
        if v262 then
            u257 = u257(u250) or u257;
        end;
        if v263 then
            u258 = u258(u250) or u258;
        end;
        if v264 then
            u259 = u259(u250) or u259;
        end;
        if v265 then
            u260 = u260(u250) or u260;
        end;
        function u250.Think() --[[ Line: 1092 ]]
            -- upvalues: u6 (ref), u251 (copy), u256 (copy), u257 (copy), u258 (copy), u247 (copy), l__GetHeight__21 (ref), u250 (copy), u246 (copy), u253 (copy), u252 (copy), u259 (copy), u260 (copy)
            local v270 = u6() - u251;
            if u256 then
                u256(v270);
            end;
            if u257 and u258 then
                local v271 = u247 * l__GetHeight__21(u257(v270), u258(v270));
                u250.SizeOffsetX = v271 * u246;
                u250.SizeOffsetY = v271;
            elseif u257 then
                local v272 = u247 * l__GetHeight__21(u257(v270), u253);
                u250.SizeOffsetX = v272 * u246;
                u250.SizeOffsetY = v272;
            elseif u258 then
                local v273 = u247 * l__GetHeight__21(u252, u258(v270));
                u250.SizeOffsetX = v273 * u246;
                u250.SizeOffsetY = v273;
            end;
            if u259 then
                u250.ImageColor = u259(v270);
            end;
            if u260 then
                u250.BackgroundColor = u260(v270);
            end;
        end;
    end;
    local v274 = u3(p248);
    local v275 = l__TextBox__14(nil, v274);
    v275.BackgroundColor = u98;
    v275.Font = l__SourceSans__34;
    v275.FontSize = 18;
    v275.TextColor = u97;
    v275.TextStrokeColor = u96;
    local v276, v277 = l__TextSize__20(l__SourceSans__34, 18, v274);
    v275.SizeOffsetX = v276;
    v275.SizeOffsetY = v277;
    l__FadeReveal__15(u250, v275);
    return u250;
end;
u25.FadeReveal = v4.FadeReveal;
function u25.Roll(u278, u279) --[[ Line: 1130 ]]
    -- upvalues: u99 (ref), l__New__12 (copy), u6 (copy)
    local u280 = u99;
    local v281 = l__New__12();
    v281.DrawBackground = false;
    u279.Parent = v281;
    v281.SizeOffsetX = u279.SizeX;
    v281.SizeOffsetY = u279.SizeY;
    function v281.Think() --[[ Line: 1137 ]]
        -- upvalues: u279 (copy), u6 (ref), u280 (copy), u278 (copy)
        u279.Rotation = (u6() - u280) * u278 * 6.283185307179586;
    end;
    return v281;
end;
function u25.Spin(u282, u283) --[[ Line: 1142 ]]
    -- upvalues: u99 (ref), l__New__12 (copy), u6 (copy)
    local u284 = u99;
    local v285 = l__New__12();
    v285.DrawBackground = false;
    u283.Parent = v285;
    v285.SizeOffsetX = u283.SizeX;
    v285.SizeOffsetY = u283.SizeY;
    function v285.Think() --[[ Line: 1149 ]]
        -- upvalues: u6 (ref), u284 (copy), u282 (copy), u283 (copy)
        local v286 = 2 * (u6() - u284) * u282 % 2;
        if v286 < 1 then
            u283.Rotation = v286 * v286 * (-49.31183276961498 + v286 * (260.0791841502558 + v286 * (-340.8069434557687 + v286 * 136.3227773823075)));
        else
            u283.Rotation = 0;
        end;
    end;
    return v285;
end;
function u25.Rotate(p287, p288) --[[ Line: 1159 ]]
    -- upvalues: l__New__12 (copy)
    local v289 = l__New__12();
    v289.DrawBackground = false;
    p288.Parent = v289;
    v289.SizeOffsetX = p288.SizeX;
    v289.SizeOffsetY = p288.SizeY;
    p288.Rotation = p287;
    return v289;
end;
function u25.Intensify(u290, u291) --[[ Line: 1168 ]]
    -- upvalues: l__New__12 (copy), l__random__5 (copy), l__log__4 (copy), l__cos__2 (copy), l__sin__3 (copy)
    local v292 = l__New__12();
    v292.DrawBackground = false;
    u291.Parent = v292;
    v292.SizeOffsetX = u291.SizeX;
    v292.SizeOffsetY = u291.SizeY;
    function v292.Think() --[[ Line: 1174 ]]
        -- upvalues: l__random__5 (ref), u290 (copy), l__log__4 (ref), u291 (copy), l__cos__2 (ref), l__sin__3 (ref)
        local v293 = 6.283185307179586 * l__random__5();
        local v294 = u290 * l__log__4(l__random__5());
        u291.PosOffsetX = v294 * l__cos__2(v293);
        u291.PosOffsetY = v294 * l__sin__3(v293);
    end;
    return v292;
end;
function u25.Wander(p295, u296, u297) --[[ Line: 1182 ]]
    -- upvalues: l__New__12 (copy), u5 (copy), u6 (copy), l__random__5 (copy), l__log__4 (copy), l__cos__2 (copy), l__sin__3 (copy), l__Update__17 (copy)
    local v298 = l__New__12();
    v298.DrawBackground = false;
    u297.Parent = v298;
    v298.SizeOffsetX = u297.SizeX;
    v298.SizeOffsetY = u297.SizeY;
    local u300 = u5.New(0, function(p299) --[[ Line: 1188 ]]
        -- upvalues: u297 (copy)
        u297.PosOffsetX = p299;
    end);
    local u302 = u5.New(0, function(p301) --[[ Line: 1191 ]]
        -- upvalues: u297 (copy)
        u297.PosOffsetY = p301;
    end);
    local u304 = u5.New(0, function(p303) --[[ Line: 1194 ]]
        -- upvalues: u297 (copy)
        u297.Rotation = p303;
    end);
    u300:Remove();
    u302:Remove();
    u304:Remove();
    local u305 = 1 / p295;
    local u306 = u6() + u305;
    function v298.Think() --[[ Line: 1202 ]]
        -- upvalues: u6 (ref), u306 (ref), u305 (copy), l__random__5 (ref), u296 (copy), l__log__4 (ref), u300 (copy), l__cos__2 (ref), u302 (copy), l__sin__3 (ref), u304 (copy), l__Update__17 (ref)
        local v307 = u6();
        if u306 < v307 then
            u306 = u306 + u305;
            local v308 = 6.283185307179586 * l__random__5();
            local v309 = u296 * l__log__4(l__random__5());
            u300:Custom(v309 * l__cos__2(v308), 0, 3 * u305);
            u302:Custom(v309 * l__sin__3(v308), 0, 3 * u305);
            u304:Custom(u296 * (l__random__5() - 0.5) / 32, 0, 3 * u305);
        end;
        l__Update__17(u300, v307);
        l__Update__17(u302, v307);
        l__Update__17(u304, v307);
    end;
    return v298;
end;
function u25.Bounce(u310, u311, u312) --[[ Line: 1246 ]]
    -- upvalues: u99 (ref), l__New__12 (copy), u6 (copy)
    local u313 = u99;
    local v314 = l__New__12();
    v314.DrawBackground = false;
    u312.Parent = v314;
    v314.SizeOffsetX = u312.SizeX;
    v314.SizeOffsetY = u312.SizeY;
    function v314.Think() --[[ Line: 1253 ]]
        -- upvalues: u6 (ref), u313 (copy), u311 (copy), u312 (copy), u310 (copy)
        local v315 = (u6() - u313) * u311 % 1;
        u312.PosOffsetY = u310 * 4 * v315 * (v315 - 1);
    end;
    return v314;
end;
function u25.Wiggle(u316, u317, u318) --[[ Line: 1259 ]]
    -- upvalues: u99 (ref), l__New__12 (copy), u6 (copy), l__cos__2 (copy)
    local u319 = u99;
    local v320 = l__New__12();
    v320.DrawBackground = false;
    u318.Parent = v320;
    v320.SizeOffsetX = u318.SizeX;
    v320.SizeOffsetY = u318.SizeY;
    function v320.Think() --[[ Line: 1266 ]]
        -- upvalues: u318 (copy), u316 (copy), u6 (ref), u319 (copy), u317 (copy), l__cos__2 (ref)
        u318.Rotation = u316 * l__cos__2((u6() - u319) * u317 * 6.283185307179586);
    end;
    return v320;
end;
local u321 = false;
local function u328(p322) --[[ Line: 1277 ]]
    -- upvalues: u321 (ref), u2 (copy), u25 (copy), u328 (copy)
    if not u321 then
        local v323 = u2(p322) == "table" and p322[1];
        if v323 then
            local v324 = u25[v323];
            if v324 then
                local v325 = {};
                for v326 = 2, #p322 do
                    local v327 = u328(p322[v326]);
                    if v327 then
                        v325[#v325 + 1] = v327;
                    end;
                end;
                if not u321 then
                    return v324(unpack(v325));
                end;
                return;
            end;
            print("[Chat] Malformed structure");
            u321 = true;
        end;
        return p322;
    end;
end;
return {
    Gen = function(p329, _) --[[ Name: Gen, Line 1314 ]]
        -- upvalues: u117 (copy), u321 (ref), u328 (copy)
        u117();
        u321 = false;
        return u328(p329);
    end
};
