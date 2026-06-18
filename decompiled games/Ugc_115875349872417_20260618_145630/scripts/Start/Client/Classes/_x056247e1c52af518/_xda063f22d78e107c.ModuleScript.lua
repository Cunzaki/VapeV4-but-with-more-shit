-- Decompiled from: Start.Client.Classes._x056247e1c52af518._xda063f22d78e107c
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

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
local function u8(p2, p3) --[[ Line: 50 ]]
    local v4 = p2:gsub("<.->", "");
    local v5 = 0;
    for v6, v7 in utf8.graphemes(v4) do
        v5 = v5 + 1;
        if v5 == p3 then
            return string.sub(v4, v6, v7);
        end;
    end;
    return nil;
end;
local function u14(p9) --[[ Line: 73 ]]
    -- upvalues: l__Classes__7 (copy)
    if type(p9) == "string" and p9 ~= "" then
        local l___x3e046bec2684f59c__8 = l__Classes__7._x3e046bec2684f59c;
        if l___x3e046bec2684f59c__8 then
            return string.gsub(p9, "{[Aa]ction:([%w_]+)}", function(p10) --[[ Line: 83 ]]
                -- upvalues: l___x3e046bec2684f59c__8 (copy)
                if type(l___x3e046bec2684f59c__8._xc9966245cd0a44a8) ~= "function" then
                    return "[" .. p10 .. "]";
                end;
                local u11 = l___x3e046bec2684f59c__8:_xc9966245cd0a44a8(p10);
                if u11 then
                    u11 = u11.KeyCode;
                end;
                if not u11 then
                    return "[" .. p10 .. "]";
                end;
                if type(l___x3e046bec2684f59c__8._xfeef7f7b762e94d9) == "function" then
                    local v12, v13 = pcall(function() --[[ Line: 95 ]]
                        -- upvalues: l___x3e046bec2684f59c__8 (ref), u11 (copy)
                        return l___x3e046bec2684f59c__8:_xfeef7f7b762e94d9(u11);
                    end;
                    if v12 and (type(v13) == "string" and v13 ~= "") then
                        return "[" .. v13 .. "]";
                    end;
                end;
                return "[" .. tostring(u11.Name or p10) .. "]";
            end;
        else
            return p9;
        end;
    else
        return "";
    end;
end;
function u1._x90d4581ac99dd483(p15, p16, p17) --[[ Line: 108 ]]
    -- upvalues: u1 (copy), l__Trove__4 (copy), l__DialogueNodes__5 (copy), l__UIAssets__6 (copy), l__Signal__3 (copy)
    local v18 = setmetatable({}, u1);
    v18._xf92f2cbfed4bfccd = p16;
    v18._x1b91a9016dfa3cea = p17;
    v18._xbd519c918208ce0e = l__Trove__4.new();
    v18._x938d1a731c8d2a40 = p15;
    v18._xa017aee0b34b6ab8 = l__DialogueNodes__5[p16];
    v18._xbfd94786e9010f5b = 0;
    v18._x7df67e4b8a310f97 = false;
    v18._xd42e4c65a72368f2 = false;
    v18._x7dfddff80bf37147 = 0;
    local v19 = type(v18._xa017aee0b34b6ab8) == "table";
    assert(v19, "DialogueBox.new expected a valid dialogue node");
    v18._x6817ea90b3903981 = v18._xbd519c918208ce0e:Clone(l__UIAssets__6.Guides.DialogueContainer);
    v18._xff9002777171394f = v18._xbd519c918208ce0e:Add(l__Signal__3.new());
    v18:_x8fcdafeb8ad3312d();
    return v18;
end;
function u1._x1643fe8bb74ae299(p20) --[[ Line: 131 ]]
    return p20._xa017aee0b34b6ab8 and p20._xa017aee0b34b6ab8.advance or nil;
end;
function u1._x11bf2de7cd8795c9(p21) --[[ Line: 135 ]]
    -- upvalues: u14 (copy)
    local v22 = p21:_x1643fe8bb74ae299();
    if p21._xd42e4c65a72368f2 then
        if type(v22) == "table" and (type(v22.hint_override) == "string" and v22.hint_override ~= "") then
            return u14(v22.hint_override);
        elseif type(v22) == "table" and v22.kind == "await_event" then
            return u14("Complete the objective to continue.");
        else
            return (type(v22) ~= "table" or v22.kind ~= "continue") and "" or u14("Press {Action:INTERACT} to continue.");
        end;
    else
        return u14("Press {Action:INTERACT} to fast-forward.");
    end;
end;
function u1._x6874c73bb3f658ca(p23) --[[ Line: 157 ]]
    -- upvalues: l__TweenService__1 (copy)
    if p23._xd6eccbce50dfebb7 then
        p23._xd6eccbce50dfebb7.Text = p23:_x11bf2de7cd8795c9();
        p23._xd6eccbce50dfebb7.TextTransparency = 1;
        l__TweenService__1:Create(p23._xd6eccbce50dfebb7, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play();
    end;
end;
function u1._x43ecb9d8d978d3e9(p24) --[[ Line: 170 ]]
    local v25 = p24._xa017aee0b34b6ab8.theme or {};
    if v25.color then
        p24._x3ce58679ac87ef7c.TextColor3 = v25.color;
        p24._x06716ed07db43e06.TextColor3 = v25.color;
    end;
    if v25.max_size then
        p24._x06716ed07db43e06.TextSize = v25.max_size;
        if p24._x37044484ee72a437 then
            p24._x37044484ee72a437.MaxTextSize = v25.max_size;
        end;
    end;
    if v25.font then
        if typeof(v25.font) == "Font" then
            if p24._x06716ed07db43e06.FontFace then
                p24._x06716ed07db43e06.FontFace = v25.font;
            end;
        elseif typeof(v25.font) == "EnumItem" and v25.font.EnumType == Enum.Font then
            p24._x06716ed07db43e06.Font = v25.font;
        end;
    end;
end;
function u1._x16ac2c41c2579a9b(u26) --[[ Line: 197 ]]
    -- upvalues: l__TweenService__1 (copy)
    local l___x3b71b7824b802671__9 = u26._x3b71b7824b802671;
    if l___x3b71b7824b802671__9 then
        l___x3b71b7824b802671__9.Visible = true;
        task.delay(0.06, function() --[[ Line: 205 ]]
            -- upvalues: u26 (copy), l___x3b71b7824b802671__9 (copy)
            if u26._x3b71b7824b802671 == l___x3b71b7824b802671__9 and l___x3b71b7824b802671__9.Parent then
                l___x3b71b7824b802671__9.Visible = false;
            end;
        end;
        u26._x6817ea90b3903981.Main.Size = UDim2.fromScale(0, 1);
        l__TweenService__1:Create(u26._x6817ea90b3903981.Main, TweenInfo.new(0.66, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(1, 1)
        }):Play();
    end;
end;
function u1._x61e9ccaa41879f89(p27, p28) --[[ Line: 220 ]]
    -- upvalues: u8 (copy)
    local v29 = p27._xa017aee0b34b6ab8.theme or {};
    local v30 = tonumber(v29.typewriter_speed) or 0.03;
    local v31 = (p28 % 4 - 1.5) * 0.0035;
    if p28 % 11 == 0 then
        v31 = v31 + 0.01;
    end;
    local v32 = v30 + v31;
    local v33 = u8(p27._x06716ed07db43e06.Text, p28);
    if (v33 == "." or (v33 == "," or (v33 == "!" or (v33 == "?" or v33 == ":")))) and true or v33 == ";" then
        v32 = v30 + (tonumber(v29.punctuation_pause) or 0);
    end;
    return math.max(0.012, v32);
end;
function u1._x85aeaa994d598552(p34, p35) --[[ Line: 239 ]]
    -- upvalues: l__Classes__7 (copy)
    if p35 % 2 == 0 then
        local v36 = p34._xa017aee0b34b6ab8.theme or {};
        if v36.sound and (l__Classes__7._xbe184fb1376a575d and type(l__Classes__7._xbe184fb1376a575d._x7ab8b42cc5920a78) == "function") then
            local v37 = l__Classes__7._xbe184fb1376a575d:_x7ab8b42cc5920a78(v36.sound, true);
            l__Classes__7._xbe184fb1376a575d:_x095692db6a6ea871(v37, v36.min_pitch, v36.max_pitch);
        end;
    end;
end;
function u1._xc51a0962cd9bb3b7(p38) --[[ Line: 252 ]]
    p38._xbfd94786e9010f5b = p38._xbfd94786e9010f5b + 1;
    p38._xd42e4c65a72368f2 = true;
    p38._x06716ed07db43e06.MaxVisibleGraphemes = -1;
    p38:_x6874c73bb3f658ca();
end;
function u1._x83d54c9a2240a555(u39) --[[ Line: 259 ]]
    u39._xbfd94786e9010f5b = u39._xbfd94786e9010f5b + 1;
    u39._xd42e4c65a72368f2 = false;
    local l___xbfd94786e9010f5b__10 = u39._xbfd94786e9010f5b;
    u39._x06716ed07db43e06.MaxVisibleGraphemes = 0;
    u39:_x6874c73bb3f658ca();
    if u39._x7dfddff80bf37147 <= 0 then
        u39:_xc51a0962cd9bb3b7();
    else
        task.spawn(function() --[[ Line: 273 ]]
            -- upvalues: u39 (copy), l___xbfd94786e9010f5b__10 (copy)
            for v40 = 1, u39._x7dfddff80bf37147 do
                if u39._xbfd94786e9010f5b ~= l___xbfd94786e9010f5b__10 or not u39._x6817ea90b3903981.Parent then
                    return;
                end;
                u39._x06716ed07db43e06.MaxVisibleGraphemes = v40;
                u39:_x85aeaa994d598552(v40);
                if v40 < u39._x7dfddff80bf37147 then
                    task.wait(u39:_x61e9ccaa41879f89(v40));
                end;
            end;
            if u39._xbfd94786e9010f5b == l___xbfd94786e9010f5b__10 then
                u39:_xc51a0962cd9bb3b7();
            end;
        end;
    end;
end;
function u1._x7e1396e4ad1052c3(u41) --[[ Line: 293 ]]
    -- upvalues: l__Classes__7 (copy)
    local l___x3e046bec2684f59c__11 = l__Classes__7._x3e046bec2684f59c;
    if l___x3e046bec2684f59c__11 and type(l___x3e046bec2684f59c__11._xc9966245cd0a44a8) == "function" then
        local v42 = l___x3e046bec2684f59c__11:_xc9966245cd0a44a8("INTERACT");
        if v42 and v42.Pressed then
            u41._xbd519c918208ce0e:Add(v42.Pressed:Connect(function() --[[ Line: 304 ]]
                -- upvalues: u41 (copy), l__Classes__7 (ref)
                if u41._x7df67e4b8a310f97 then
                    l__Classes__7._xbe184fb1376a575d:_x7ab8b42cc5920a78("BLIP", true);
                    if u41:_x0ee2e18d848b369c() then
                        u41:_x3379fc9f3d4b1cb2();
                    else
                        if u41:_x38b2f2dbb7e31257() then
                            u41._xff9002777171394f:Fire(u41._xf92f2cbfed4bfccd, u41._x1b91a9016dfa3cea);
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
function u1._x8fcdafeb8ad3312d(p43) --[[ Line: 322 ]]
    -- upvalues: l__Classes__7 (copy)
    p43._x3b71b7824b802671 = p43._x6817ea90b3903981.Flash;
    p43._xd6eccbce50dfebb7 = p43._x6817ea90b3903981.HintLabel;
    p43._x3ce58679ac87ef7c = p43._x6817ea90b3903981.TopFrame.SpeakerLabel;
    p43._x06716ed07db43e06 = p43._x6817ea90b3903981.Main.Box.DialogueLabel;
    p43._x37044484ee72a437 = p43._x06716ed07db43e06:FindFirstChildOfClass("UITextSizeConstraint");
    p43._x3ce58679ac87ef7c.Text = tostring(p43._xa017aee0b34b6ab8.speaker or "");
    local l___x06716ed07db43e06__12 = p43._x06716ed07db43e06;
    local v44 = tostring(p43._xa017aee0b34b6ab8.text_raw or "");
    if type(v44) == "string" and v44 ~= "" then
        local l___x3e046bec2684f59c__13 = l__Classes__7._x3e046bec2684f59c;
        if l___x3e046bec2684f59c__13 then
            v44 = string.gsub(v44, "{[Aa]ction:([%w_]+)}", function(p45) --[[ Line: 83 ]]
                -- upvalues: l___x3e046bec2684f59c__13 (copy)
                if type(l___x3e046bec2684f59c__13._xc9966245cd0a44a8) ~= "function" then
                    return "[" .. p45 .. "]";
                end;
                local u46 = l___x3e046bec2684f59c__13:_xc9966245cd0a44a8(p45);
                if u46 then
                    u46 = u46.KeyCode;
                end;
                if not u46 then
                    return "[" .. p45 .. "]";
                end;
                if type(l___x3e046bec2684f59c__13._xfeef7f7b762e94d9) == "function" then
                    local v47, v48 = pcall(function() --[[ Line: 95 ]]
                        -- upvalues: l___x3e046bec2684f59c__13 (ref), u46 (copy)
                        return l___x3e046bec2684f59c__13:_xfeef7f7b762e94d9(u46);
                    end;
                    if v47 and (type(v48) == "string" and v48 ~= "") then
                        return "[" .. v48 .. "]";
                    end;
                end;
                return "[" .. tostring(u46.Name or p45) .. "]";
            end;
        end;
    else
        v44 = "";
    end;
    l___x06716ed07db43e06__12.Text = v44;
    local v49 = p43._x06716ed07db43e06.Text:gsub("<.->", "");
    local v50 = 0;
    for _ in utf8.graphemes(v49) do
        v50 = v50 + 1;
    end;
    p43._x7dfddff80bf37147 = v50;
    p43:_x43ecb9d8d978d3e9();
    p43:_x6874c73bb3f658ca();
    p43._x6817ea90b3903981.Parent = p43._x938d1a731c8d2a40;
    local l___x938d1a731c8d2a40__14 = p43._x938d1a731c8d2a40;
    if l___x938d1a731c8d2a40__14 then
        if l___x938d1a731c8d2a40__14:IsA("ScreenGui") then
            l___x938d1a731c8d2a40__14.Enabled = true;
        elseif l___x938d1a731c8d2a40__14:IsA("GuiObject") then
            l___x938d1a731c8d2a40__14.Visible = true;
        end;
    end;
    p43._x7df67e4b8a310f97 = true;
    p43:_x16ac2c41c2579a9b();
    p43:_x7e1396e4ad1052c3();
    p43:_x83d54c9a2240a555();
end;
function u1._x8ea6432f4fb0f055(p51) --[[ Line: 346 ]]
    return p51._x7df67e4b8a310f97;
end;
function u1._x0ee2e18d848b369c(p52) --[[ Line: 350 ]]
    local l___x7df67e4b8a310f97__15 = p52._x7df67e4b8a310f97;
    if l___x7df67e4b8a310f97__15 then
        l___x7df67e4b8a310f97__15 = not p52._xd42e4c65a72368f2;
    end;
    return l___x7df67e4b8a310f97__15;
end;
function u1._x38b2f2dbb7e31257(p53) --[[ Line: 354 ]]
    local v54 = p53:_x1643fe8bb74ae299();
    local v55 = p53._x7df67e4b8a310f97 and p53._xd42e4c65a72368f2;
    if v55 then
        if type(v54) == "table" then
            v55 = v54.kind == "continue";
        else
            v55 = false;
        end;
    end;
    return v55;
end;
function u1._x3379fc9f3d4b1cb2(p56) --[[ Line: 363 ]]
    p56:_xc51a0962cd9bb3b7();
end;
function u1.destroy(p57) --[[ Line: 367 ]]
    p57._xbfd94786e9010f5b = p57._xbfd94786e9010f5b + 1;
    p57._x7df67e4b8a310f97 = false;
    if p57._x6817ea90b3903981 then
        p57._x6817ea90b3903981:Destroy();
        p57._x6817ea90b3903981 = nil;
    end;
    p57._xbd519c918208ce0e:Clean();
end;
return u1;
