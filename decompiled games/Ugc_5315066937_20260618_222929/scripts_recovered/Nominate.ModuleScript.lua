-- Decompiled from: Nominate
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__time__1 = os.time;
local l__floor__2 = math.floor;
local l__sort__3 = table.sort;
local l__clone__4 = table.clone;
local l__insert__5 = table.insert;
local l__obtain__6 = _G.obtain;
local v1 = l__obtain__6("L1Copy");
local l__ToDate__7 = l__obtain__6("DateTime").ToDate;
local u2 = l__obtain__6("QBox");
local l__Color__8 = u2.Color;
local l__FreeMouse__9 = u2.FreeMouse;
local l__New__10 = u2.New;
local l__Image__11 = u2.Image;
local l__TextBox__12 = u2.TextBox;
local v3 = l__obtain__6("Tween");
local v4 = l__obtain__6("Local");
local v5 = l__obtain__6("Remote");
local l__Call__13 = v5.Call;
local v6 = l__obtain__6("MapLists");
local l__AllMaps__14 = v6.AllMaps;
local l__GetCompletion__15 = v6.GetCompletion;
local v7 = l__obtain__6("Styles");
local l__TypeNumberToId__16 = v7.TypeNumberToId;
local v8 = v1(v7.TypeNames);
l__insert__5(v8, 1, "All");
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = l__Color__8(137, 232, 148, 255);
local u13 = l__Color__8(97, 164, 105, 255);
local u14 = u2.New();
u14.Visible = false;
u14.DrawBackground = false;
u14.SizeOffsetX = 400;
u14.SizeOffsetY = 600;
u14.PosScaleX = 0.5;
u14.PosScaleY = 1;
local u15 = false;
local u17 = v3.New(0, function(p16) --[[ Line: 60 ]]
    -- upvalues: u15 (ref), u14 (copy)
    u15 = true;
    u14.PosOffsetY = p16;
    u15 = false;
end);
u17.MaxAcceleration = v3.MaxAcceleration(0, u14.SizeY, 0, 0, 1);
u14.Callbacks[{
    PosOffsetY = true
}] = function() --[[ Line: 66 ]]
    -- upvalues: u15 (ref), u17 (copy), u14 (copy)
    if not u15 then
        u17.x1 = u14.PosOffsetY;
    end;
end;
function u14.Resize() --[[ Line: 72 ]]
    -- upvalues: u14 (copy), u17 (copy)
    u14.PosOffsetX = u14.SizeX / -2;
    u14.PosOffsetY = u17:Value();
end;
local v18 = u2.TextBox(u14, "Nominate a Map");
v18.TextSize = 12 * u2.roblox_messing_with_guis_factor;
v18.TextAlignment = "Center";
v18.BackgroundColor = u2.Color2;
v18.SizeScaleX = 1;
v18.SizeOffsetX = -40;
v18.SizeOffsetY = 40;
u2.DragBar(v18, u14);
local v19 = u2.TextBox(u14, "x");
v19.TextSize = 12 * u2.roblox_messing_with_guis_factor;
v19.TextAlignment = "Center";
v19.SizeOffsetX = 40;
v19.SizeOffsetY = 40;
v19.PosOffsetX = -40;
v19.PosScaleX = 1;
local u20 = u2.New();
u20.ZIndex = -1;
u20.DrawBackground = false;
u20.SizeScaleX = 1;
local u21 = u2.New(u14);
u21.ZIndex = -1;
u21.PosOffsetY = 70;
u21.SizeScaleX = 1;
u21.SizeScaleY = 1;
u21.SizeOffsetY = -70;
u2.Scroll(u20, u21);
local v22 = l__New__10(u14);
v22.BackgroundColor = u2.Color2;
v22.SizeScaleX = 1;
v22.SizeOffsetY = 30;
v22.PosOffsetY = 40;
local u23 = u2.TextBox(v22, "Completion (Released maps): <???>%");
u23.TextSize = 10 * u2.roblox_messing_with_guis_factor;
u23.TextAlignment = "Center";
u23.BackgroundColor = u2.Color2;
u23.SizeScaleX = 1;
u23.SizeScaleY = 1;
local v25 = u2.Dropdown(v22, v8, function(p24) --[[ Line: 124 ]]
    -- upvalues: u9 (ref), l__GetCompletion__15 (copy), l__TypeNumberToId__16 (copy), u10 (ref), u11 (ref)
    u9 = l__GetCompletion__15(l__TypeNumberToId__16[p24 - 1]);
    if u10 and u11 then
        u10();
        u11();
    end;
end, v8[1]);
v25.PosOffsetY = 5;
v25.SizeOffsetY = 20;
v25.SizeOffsetX = v25.GetWidth() + 10;
v25.PosOffsetX = -5 - v25.SizeX;
v25.PosScaleX = 1;
u23.SizeOffsetX = -v25.SizeOffsetX;
local u26 = false;
function v19.Button1Down() --[[ Line: 140 ]]
    -- upvalues: u26 (ref), l__FreeMouse__9 (copy), u17 (copy), u14 (copy)
    u26 = false;
    l__FreeMouse__9("Nominate", false);
    u17:Target(0, function() --[[ Line: 143 ]]
        -- upvalues: u14 (ref)
        u14.Visible = false;
    end);
end;
local u27 = l__Image__11(u14, nil);
u27.Visible = false;
u27.DrawBackground = false;
u27.SizeOffsetX = 500;
u27.SizeOffsetY = 500;
function u27.Think() --[[ Line: 155 ]]
    -- upvalues: u27 (copy), u2 (copy)
    local l__Target__17 = u27.Target;
    if l__Target__17 then
        local l__MouseX__18 = u2.MouseX;
        local l__MouseY__19 = u2.MouseY;
        if l__MouseX__18 < l__Target__17.PosX or (l__Target__17.PosX + l__Target__17.SizeX < l__MouseX__18 or (l__MouseY__19 < l__Target__17.PosY or l__Target__17.PosY + l__Target__17.SizeY < l__MouseY__19)) then
            u27.Visible = false;
        end;
    end;
end;
u27.ZIndex = 6;
function u27.MouseWheeled(p28) --[[ Line: 165 ]]
    -- upvalues: u27 (copy), u21 (copy)
    local l__Target__20 = u27.Target;
    if l__Target__20 then
        u21.MouseWheeled(p28 * l__Target__20.SizeY / (0.2 * u21.SizeY));
    end;
end;
local u29 = l__TextBox__12(u27, "");
u29.DrawBackground = false;
u29.TextAlignment = "Center";
u29.TextSize = 18;
u29.PosScaleY = 1;
u29.PosOffsetY = -60;
u29.SizeScaleX = 1;
u29.SizeOffsetY = 60;
u29.ZIndex = 6;
local u30 = {};
local function u50(u31) --[[ Line: 184 ]]
    -- upvalues: l__New__10 (copy), u20 (copy), l__TextBox__12 (copy), l__time__1 (copy), l__floor__2 (copy), l__ToDate__7 (copy), u9 (ref), u12 (copy), u13 (copy), l__Color__8 (copy), u2 (copy), u26 (ref), l__Call__13 (copy), l__FreeMouse__9 (copy), u17 (copy), u14 (copy), l__Image__11 (copy), u29 (copy), u27 (copy)
    local l__Date__21 = u31.Date;
    local l__DisplayName__22 = u31.DisplayName;
    local l__AssetId__23 = u31.AssetId;
    local u32 = l__DisplayName__22;
    local u33;
    if u31.Creator then
        u33 = "by " .. u31.Creator;
    else
        u33 = nil;
    end;
    local u34 = l__New__10(u20);
    u34.SizeScaleX = 1;
    u34.SizeOffsetY = 40;
    u34.DisplayName = l__DisplayName__22;
    u34.Date = l__Date__21;
    u34.MapId = l__AssetId__23;
    local u35 = l__TextBox__12(u34, u32);
    u35.DrawBackground = false;
    u35.TextAlignment = "Center";
    u35.SizeScaleX = 1;
    u35.SizeScaleY = 1;
    u35.SizeOffsetX = -40;
    u35.PosOffsetX = 40;
    function u35.Think() --[[ Line: 208 ]]
        -- upvalues: u35 (copy), l__time__1 (ref), l__Date__21 (copy), l__floor__2 (ref), u32 (ref), l__DisplayName__22 (copy), l__ToDate__7 (ref)
        if not u35.Hovering then
            local v36 = l__time__1();
            local v37 = tick();
            if l__Date__21 then
                local v38 = v36 - l__Date__21;
                if v38 < 0 then
                    local v39 = l__floor__2((v37 - v38) / 60 + 0.5) * 60;
                    local v40 = l__floor__2(v39 / 86400) - l__floor__2(v37 / 86400);
                    if v40 == 0 then
                        u32 = l__DisplayName__22 .. " (today at " .. l__ToDate__7(v39, true, false, false, false, false, false) .. ")";
                    elseif v40 == 1 then
                        u32 = l__DisplayName__22 .. " (tomorrow at " .. l__ToDate__7(v39, true, false, false, false, false, false) .. ")";
                    elseif v40 < 7 then
                        u32 = l__DisplayName__22 .. " (on " .. l__ToDate__7(v39, false, false, true, false, false, false) .. ")";
                    elseif select(2, l__ToDate__7(v37, false, false, false, false, false, false))[1] == select(2, l__ToDate__7(v39, false, false, false, false, true, false))[1] then
                        u32 = l__DisplayName__22 .. " (on " .. l__ToDate__7(v39, false, false, false, true, true, false) .. ")";
                    else
                        u32 = l__DisplayName__22 .. " (in " .. l__ToDate__7(v39, false, false, false, true, false, true) .. ")";
                    end;
                elseif v38 < 2628000 then
                    local v41 = l__floor__2(v37 / 86400) - l__floor__2((v37 - v38) / 86400);
                    if v41 == 1 then
                        u32 = l__DisplayName__22 .. " (Released yesterday)";
                    elseif v38 < 86400 then
                        u32 = l__DisplayName__22 .. " (NEW)";
                    else
                        u32 = l__DisplayName__22 .. " (Released " .. v41 .. " days ago)";
                    end;
                end;
            end;
            u35.Text = u32;
        end;
    end;
    function u34.Fade(p42) --[[ Line: 248 ]]
        -- upvalues: u9 (ref), l__AssetId__23 (copy), u34 (copy), u12 (ref), u13 (ref), l__Color__8 (ref), u2 (ref)
        if u9 and u9[l__AssetId__23] then
            local v43 = u34;
            local v44 = u12;
            local v45 = u13;
            local v46 = 1 - p42;
            v43.BackgroundColor = l__Color__8(v44.r * v46 + v45.r * p42, v44.g * v46 + v45.g * p42, v44.b * v46 + v45.b * p42, v44.a * v46 + v45.a * p42);
        else
            local v47 = u34;
            local l__Color1__24 = u2.Color1;
            local l__Color2__25 = u2.Color2;
            local v48 = 1 - p42;
            v47.BackgroundColor = l__Color__8(l__Color1__24.r * v48 + l__Color2__25.r * p42, l__Color1__24.g * v48 + l__Color2__25.g * p42, l__Color1__24.b * v48 + l__Color2__25.b * p42, l__Color1__24.a * v48 + l__Color2__25.a * p42);
        end;
    end;
    u34.FadeDuration = 0.15;
    function u34.Button1Down() --[[ Line: 257 ]]
        -- upvalues: u26 (ref), l__Call__13 (ref), u31 (copy), l__FreeMouse__9 (ref), u17 (ref), u14 (ref)
        if u26 then
            l__Call__13("NominateMap", u31.AssetId);
            u26 = false;
            l__FreeMouse__9("Nominate", false);
            u17:Target(0, function() --[[ Line: 143 ]]
                -- upvalues: u14 (ref)
                u14.Visible = false;
            end);
        end;
    end;
    function u34.MouseEnter() --[[ Line: 263 ]]
        -- upvalues: u33 (ref), u35 (copy)
        if u33 then
            u35.Text = u33;
        end;
    end;
    function u34.MouseLeave() --[[ Line: 268 ]]
        -- upvalues: u35 (copy), u32 (ref)
        u35.Text = u32;
    end;
    local l__Thumbnail__26 = u31.Thumbnail;
    if l__Thumbnail__26 then
        local u49 = l__Image__11(u34, "rbxassetid://" .. l__Thumbnail__26);
        function u49.MouseEnter() --[[ Line: 274 ]]
            -- upvalues: u29 (ref), u32 (ref), u27 (ref), u49 (copy), u14 (ref), u34 (copy)
            u29.Text = u32;
            u27.Image = u49.Image;
            u27.Target = u49;
            u27.Visible = true;
            u27.PosOffsetX = u49.PosX - u14.PosX + (u49.SizeX - u27.SizeX) / 2;
            u27.PosOffsetY = u49.PosY - u14.PosY + (u49.SizeY - u27.SizeY) / 2;
            u27.Button1Down = u34.Button1Down;
        end;
        u49.DrawBackground = false;
        u49.SizeScaleY = 1;
        function u49.Resize() --[[ Line: 285 ]]
            -- upvalues: u49 (copy)
            u49.SizeOffsetX = u49.SizeY;
        end;
    end;
    return u34;
end;
u11 = function() --[[ Line: 292 ]]
    -- upvalues: l__time__1 (copy), l__AllMaps__14 (copy), u9 (ref), u23 (copy), l__floor__2 (copy)
    local v51 = l__time__1();
    local v52 = 0;
    local v53 = 0;
    for v54 = 1, #l__AllMaps__14 do
        local v55 = l__AllMaps__14[v54];
        local l__Date__27 = v55.Date;
        if not l__Date__27 or v51 - l__Date__27 > 0 then
            v52 = v52 + 1;
            if u9[v55.AssetId] then
                v53 = v53 + 1;
            end;
        end;
    end;
    u23.Text = "Completion (Released maps): " .. l__floor__2(v53 * 1000 / v52) / 10 .. "%";
end;
v6.Ready:Add(function() --[[ Line: 332 ]]
    -- upvalues: l__clone__4 (copy), l__AllMaps__14 (copy), l__sort__3 (copy), l__time__1 (copy), u20 (copy), u50 (copy), u30 (copy), u9 (ref), u11 (ref)
    local v56 = l__clone__4(l__AllMaps__14);
    local v57 = l__sort__3;
    local u58 = l__time__1();
    v57(v56, function(p59, p60) --[[ Line: 309 ]]
        -- upvalues: u58 (copy)
        if p59 and p60 then
            local l__Date__28 = p59.Date;
            local l__Date__29 = p60.Date;
            if not (l__Date__28 and l__Date__29) then
                return p59.DisplayName < p60.DisplayName;
            end;
            local v61 = u58 < l__Date__28 and 3 or (u58 - l__Date__28 < 604800 and 1 or 2);
            local v62 = u58 < l__Date__29 and 3 or (u58 - l__Date__29 < 604800 and 1 or 2);
            if v61 ~= v62 then
                return v61 < v62;
            end;
            if v61 == 1 then
                return l__Date__29 < l__Date__28;
            end;
            if v61 == 2 then
                return p59.DisplayName < p60.DisplayName;
            end;
            if v61 == 3 then
                return l__Date__28 < l__Date__29;
            end;
        end;
    end);
    u20.SizeOffsetY = #v56 * 40;
    for v63 = 1, #v56 do
        local v64 = u50(v56[v63]);
        v64.PosOffsetY = (v63 - 1) * 40;
        u30[v63] = v64;
    end;
    if u9 then
        u11();
    end;
end);
v6.MapAdded:Add(function(p65) --[[ Line: 345 ]]
    -- upvalues: u30 (copy), u50 (copy), l__insert__5 (copy), l__sort__3 (copy), l__time__1 (copy)
    l__insert__5(u30, (u50(p65)));
    local v66 = l__sort__3;
    local v67 = u30;
    local u68 = l__time__1();
    v66(v67, function(p69, p70) --[[ Line: 309 ]]
        -- upvalues: u68 (copy)
        if p69 and p70 then
            local l__Date__30 = p69.Date;
            local l__Date__31 = p70.Date;
            if not (l__Date__30 and l__Date__31) then
                return p69.DisplayName < p70.DisplayName;
            end;
            local v71 = u68 < l__Date__30 and 3 or (u68 - l__Date__30 < 604800 and 1 or 2);
            local v72 = u68 < l__Date__31 and 3 or (u68 - l__Date__31 < 604800 and 1 or 2);
            if v71 ~= v72 then
                return v71 < v72;
            end;
            if v71 == 1 then
                return l__Date__31 < l__Date__30;
            end;
            if v71 == 2 then
                return p69.DisplayName < p70.DisplayName;
            end;
            if v71 == 3 then
                return l__Date__30 < l__Date__31;
            end;
        end;
    end);
    for v73 = 1, #u30 do
        u30[v73].PosOffsetY = (v73 - 1) * 40;
    end;
end);
v6.MapUpdated:Add(function(p74) --[[ Line: 352 ]]
    -- upvalues: u30 (copy), u2 (copy), u50 (copy), l__sort__3 (copy), l__time__1 (copy)
    for v75, v76 in u30 do
        if v76.MapId == p74.AssetId then
            u2.Remove(v76);
            u30[v75] = u50(p74);
        end;
    end;
    local v77 = l__sort__3;
    local v78 = u30;
    local u79 = l__time__1();
    v77(v78, function(p80, p81) --[[ Line: 309 ]]
        -- upvalues: u79 (copy)
        if p80 and p81 then
            local l__Date__32 = p80.Date;
            local l__Date__33 = p81.Date;
            if not (l__Date__32 and l__Date__33) then
                return p80.DisplayName < p81.DisplayName;
            end;
            local v82 = u79 < l__Date__32 and 3 or (u79 - l__Date__32 < 604800 and 1 or 2);
            local v83 = u79 < l__Date__33 and 3 or (u79 - l__Date__33 < 604800 and 1 or 2);
            if v82 ~= v83 then
                return v82 < v83;
            end;
            if v82 == 1 then
                return l__Date__33 < l__Date__32;
            end;
            if v82 == 2 then
                return p80.DisplayName < p81.DisplayName;
            end;
            if v82 == 3 then
                return l__Date__32 < l__Date__33;
            end;
        end;
    end);
    for v84 = 1, #u30 do
        u30[v84].PosOffsetY = (v84 - 1) * 40;
    end;
end);
u10 = function() --[[ Line: 364 ]]
    -- upvalues: u20 (copy)
    local l__Children__34 = u20.Children;
    for v85 = 1, #l__Children__34 do
        local v86 = l__Children__34[v85];
        v86.Fade(v86.FadeTween:Value());
    end;
end;
v6.CompletionUpdated:Add(function() --[[ Line: 371 ]]
    -- upvalues: u9 (ref), u10 (ref), u11 (ref)
    if u9 then
        u10();
        u11();
    end;
end);
local function u87() --[[ Line: 378 ]]
    -- upvalues: u26 (ref), l__FreeMouse__9 (copy), u14 (copy), u17 (copy), u9 (ref), l__GetCompletion__15 (copy), u10 (ref), u11 (ref)
    u26 = true;
    l__FreeMouse__9("Nominate", true);
    u14.Visible = true;
    u17:Target(-u14.Parent.SizeY / 2 - u14.SizeY / 2);
    if not u9 then
        u9 = l__GetCompletion__15();
        u10();
        u11();
    end;
end;
v4.Add("OpenNominate", function() --[[ Line: 390 ]]
    -- upvalues: u26 (ref), u87 (copy)
    if not u26 then
        u87();
    end;
end);
v5.Add("ToggleNominate", function() --[[ Line: 396 ]]
    -- upvalues: u26 (ref), l__FreeMouse__9 (copy), u17 (copy), u14 (copy), u87 (copy)
    if u26 then
        u26 = false;
        l__FreeMouse__9("Nominate", false);
        u17:Target(0, function() --[[ Line: 143 ]]
            -- upvalues: u14 (ref)
            u14.Visible = false;
        end);
    else
        u87();
    end;
end);
return true;
