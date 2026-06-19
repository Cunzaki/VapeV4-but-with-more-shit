-- Decompiled from: Chat
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local u2 = tick;
local l__create__1 = coroutine.create;
local l__resume__2 = coroutine.resume;
local l__running__3 = coroutine.running;
local l__yield__4 = coroutine.yield;
local l__status__5 = coroutine.status;
local l__delay__6 = task.delay;
local l__obtain__7 = _G.obtain;
local u3 = l__obtain__7("LabelPrint");
local u4 = l__obtain__7("serialize");
local u5 = l__obtain__7("QBox");
local l__New__8 = u5.New;
local l__TextBox__9 = u5.TextBox;
local v6 = l__obtain__7("Tween");
local l__Gui__10 = l__obtain__7("InputBinds").Gui;
local l__KEY_DISABLE_GLOBAL_MUTE__11 = l__obtain__7("MuteManager").KEY_DISABLE_GLOBAL_MUTE;
local u7 = l__obtain__7("Remote");
local l__Call__12 = u7.Call;
local u8 = l__obtain__7("PauseMulticall");
local v9 = l__obtain__7("PersistentData");
local l__Global__13 = v9.Global;
local l__Profile__14 = v9.Profile;
local u10 = l__obtain__7("GetNameColour");
local v11 = l__obtain__7("QCML");
local l__Parse__15 = v11.Parse;
local l__SearchStructure__16 = v11.SearchStructure;
local l__Gen__17 = l__obtain__7("QC").Gen;
local v12 = l__obtain__7("Command");
local l__RunService__18 = game:GetService("RunService");
local l__TextChatService__19 = game:GetService("TextChatService");
local l__LocalPlayer__20 = game:GetService("Players").LocalPlayer;
local u13 = 0;
local u14 = "";
local function v19(p15) --[[ Line: 59 ]]
    -- upvalues: l__SearchStructure__16 (copy), u14 (ref)
    if p15 then
        local v16 = {};
        l__SearchStructure__16(p15, "Text", v16);
        local v17 = "";
        for _, v18 in v16 do
            if type(v18[2]) == "string" then
                v17 = v17 .. v18[2];
            end;
        end;
        u14 = v17;
    else
        u14 = "";
    end;
end;
l__Profile__14:MonitorKey("CustomName", v19);
v19(l__Profile__14:GetKey("CustomName"));
local u20 = {
    r = 255,
    g = 255,
    b = 255,
    a = 64
};
local u21 = {
    r = 34,
    g = 34,
    b = 34,
    a = 16
};
local u22 = {
    r = 34,
    g = 34,
    b = 34,
    a = 32
};
local u23 = {
    r = 255,
    g = 255,
    b = 255,
    a = 128
};
local u24 = {
    r = 34,
    g = 34,
    b = 34,
    a = 32
};
local u25 = {
    r = 60,
    g = 120,
    b = 50,
    a = 0
};
local u26 = {
    r = 200,
    g = 30,
    b = 30,
    a = 0
};
local u27 = u25;
local u28 = l__New__8();
u28.DrawBackground = false;
u28.PosOffsetX = 5;
u28.PosOffsetY = 3;
u28.SizeOffsetX = 650;
u28.SizeOffsetY = 270;
local u29 = u5.Resizable(u28);
u29.DrawBackground = true;
u29.IgnoreChildrenBlocking = true;
u29.PosOffsetY = 30;
u29.SizeOffsetY = -30;
u29.ClipsDescendants = true;
u29.MinX = 200;
u29.MinY = 160;
local u30 = l__TextBox__9(u28, "Chat");
u30.SizeScaleX = 1;
u30.SizeOffsetX = -30;
u30.SizeOffsetY = 30;
u30.BackgroundColor = {
    r = 60,
    g = 60,
    b = 60,
    a = 0
};
u30.TextColor = {
    r = 255,
    g = 255,
    b = 255,
    a = 0
};
local u31 = l__TextBox__9(u28, "X");
u31.PosScaleX = 1;
u31.PosOffsetX = -30;
u31.SizeOffsetX = 30;
u31.SizeOffsetY = 30;
u31.BackgroundColor = {
    r = 60,
    g = 60,
    b = 60,
    a = 0
};
u31.TextColor = {
    r = 255,
    g = 255,
    b = 255,
    a = 0
};
local u32 = l__TextBox__9(u28, "M");
u32.PosScaleX = 1;
u32.PosOffsetX = -60;
u32.SizeOffsetX = 30;
u32.SizeOffsetY = 30;
u32.BackgroundColor = {
    r = 60,
    g = 60,
    b = 60,
    a = 0
};
u32.TextColor = u27;
l__Global__13:MonitorKey(l__KEY_DISABLE_GLOBAL_MUTE__11, function(p33) --[[ Line: 142 ]]
    -- upvalues: u27 (ref), u26 (copy), u25 (copy), u32 (copy)
    u27 = p33 == true and u26 or u25;
    u32.TextColor = {
        r = u27.r,
        g = u27.g,
        b = u27.b,
        a = u32.TextColor.a or 255
    };
end);
function u30.Fade(p34) --[[ Line: 147 ]]
    -- upvalues: u30 (copy), u31 (copy), u32 (copy), u27 (ref)
    u30.BackgroundColor = {
        r = 60,
        g = 60,
        b = 60,
        a = 128 * p34 or 255
    };
    u31.BackgroundColor = {
        r = 60,
        g = 60,
        b = 60,
        a = 128 * p34 or 255
    };
    u30.TextColor = {
        r = 255,
        g = 255,
        b = 255,
        a = 255 * p34 or 255
    };
    u31.TextColor = {
        r = 255,
        g = 255,
        b = 255,
        a = 255 * p34 or 255
    };
    u32.TextColor = {
        r = u27.r,
        g = u27.g,
        b = u27.b,
        a = 255 * p34 or 255
    };
end;
u5.DragBar(u30, u28);
local u35 = l__New__8();
u35.DrawBackground = false;
u35.SizeScaleX = 1;
local v36 = u5.Scroll(u35, u29);
v36.AutoScrollY = true;
v36.ScrollXFrame.DrawBackground = false;
v36.ScrollYFrame.DrawBackground = false;
local l__ScrollXBar__21 = v36.ScrollXBar;
local l__ScrollYBar__22 = v36.ScrollYBar;
function u29.Fade(p37) --[[ Line: 168 ]]
    -- upvalues: u29 (copy), l__ScrollXBar__21 (copy), l__ScrollYBar__22 (copy)
    u29.BackgroundColor = {
        r = 128,
        g = 128,
        b = 128,
        a = 64 * p37 or 255
    };
    l__ScrollXBar__21.ImageColor = {
        r = 30,
        g = 30,
        b = 30,
        a = 128 * p37 or 255
    };
    l__ScrollYBar__22.ImageColor = {
        r = 30,
        g = 30,
        b = 30,
        a = 128 * p37 or 255
    };
end;
local u38 = l__New__8(u28);
u38.DrawBackground = false;
u38.SizeScaleX = 1;
u38.SizeOffsetY = 5;
u38.PosScaleY = 1;
u38.BackgroundColor = {
    r = 128,
    g = 128,
    b = 128,
    a = 64
};
local u39 = l__TextBox__9(u28, "");
u39.Editable = true;
u39.HoldRobloxBox = true;
u39.BackgroundColor = {
    r = 255,
    g = 255,
    b = 255,
    a = 0
};
u39.TextColor = {
    r = 112,
    g = 110,
    b = 106,
    a = 0
};
u39.TextFont = Enum.Font.SourceSansBold;
u39.TextSize = 18;
u39.TextAlignment = "Left";
u39.PosScaleY = 1;
u39.PosOffsetY = -u39.SizeY;
u39.SizeScaleX = 1;
function u39.Fade(p40) --[[ Line: 197 ]]
    -- upvalues: u39 (copy)
    u39.BackgroundColor = {
        r = 255,
        g = 255,
        b = 255,
        a = 255 * p40 or 255
    };
    u39.TextColor = {
        r = 112,
        g = 110,
        b = 106,
        a = 255 * p40 or 255
    };
end;
function u39.MouseEnter() --[[ Line: 202 ]]
    -- upvalues: u30 (copy)
    u30.ForceHovering = true;
end;
function u39.MouseLeave() --[[ Line: 205 ]]
    -- upvalues: u29 (copy), u39 (copy), u30 (copy)
    if not (u29.Hovering or u39.ForceHovering) then
        u30.ForceHovering = false;
    end;
end;
function u31.MouseEnter() --[[ Line: 211 ]]
    -- upvalues: u30 (copy)
    u30.ForceHovering = true;
end;
function u31.MouseLeave() --[[ Line: 214 ]]
    -- upvalues: u32 (copy), u29 (copy), u39 (copy), u30 (copy)
    if not (u32.Hovering or (u29.Hovering or (u39.Hovering or u39.ForceHovering))) then
        u30.ForceHovering = false;
    end;
end;
function u32.MouseEnter() --[[ Line: 220 ]]
    -- upvalues: u30 (copy)
    u30.ForceHovering = true;
end;
function u32.MouseLeave() --[[ Line: 223 ]]
    -- upvalues: u31 (copy), u29 (copy), u39 (copy), u30 (copy)
    if not (u31.Hovering or (u29.Hovering or (u39.Hovering or u39.ForceHovering))) then
        u30.ForceHovering = false;
    end;
end;
function u29.MouseEnter() --[[ Line: 229 ]]
    -- upvalues: u30 (copy)
    u30.ForceHovering = true;
end;
function u29.MouseLeave() --[[ Line: 232 ]]
    -- upvalues: u32 (copy), u31 (copy), u39 (copy), u30 (copy)
    if not (u32.Hovering or (u31.Hovering or (u39.Hovering or u39.ForceHovering))) then
        u30.ForceHovering = false;
    end;
end;
local u41 = false;
local u43 = v6.New(270, function(p42) --[[ Line: 239 ]]
    -- upvalues: u41 (ref), u28 (copy), u39 (copy), u38 (copy)
    u41 = true;
    u28.SizeOffsetY = p42 + u39.SizeY + u38.SizeY + 30;
    u41 = false;
end);
u43.MaxAcceleration = v6.MaxAcceleration(0, 270, 0, 0, 0.5);
local u44 = nil;
local function u47(p45) --[[ Line: 247 ]]
    -- upvalues: u44 (ref), u38 (copy), u39 (copy), u29 (copy), u41 (ref), u28 (copy), u43 (copy), l__Gen__17 (copy)
    if u44 then
        if u44.Remove then
            u44:Remove();
        end;
        u44 = nil;
        u38.DrawBackground = false;
        u38.SizeOffsetY = 5;
        u38.PosOffsetY = -u39.SizeY - u38.SizeY;
        u29.SizeOffsetY = -u39.SizeY - u38.SizeY - 30;
        u41 = true;
        u28.SizeOffsetY = u43:Value() + u39.SizeY + u38.SizeY + 30;
        u41 = false;
    end;
    local v46 = p45 and l__Gen__17(p45);
    if v46 then
        v46.Parent = u38;
        v46.PosOffsetY = 5;
        u44 = v46;
        u38.DrawBackground = true;
        u38.SizeOffsetY = v46.SizeY + 10;
        u38.PosOffsetY = -u39.SizeY - u38.SizeY;
        u29.SizeOffsetY = -u39.SizeY - u38.SizeY - 30;
        u41 = true;
        u28.SizeOffsetY = u43:Value() + u39.SizeY + u38.SizeY + 30;
        u41 = false;
    end;
end;
function u28.Resize() --[[ Line: 279 ]]
    -- upvalues: u41 (ref), u43 (copy), u28 (copy), u39 (copy), u38 (copy)
    if not u41 then
        u43.x1 = u28.SizeY - u39.SizeY - u38.SizeY - 30;
    end;
end;
function u39.TextResize() --[[ Line: 284 ]]
    -- upvalues: u39 (copy), u38 (copy), u29 (copy), u41 (ref), u28 (copy), u43 (copy), l__Parse__15 (copy), l__LocalPlayer__20 (copy), u47 (copy)
    u39.SizeOffsetY = 10 + u39.TextSizeY;
    u39.PosOffsetY = -u39.SizeY;
    u38.PosOffsetY = -u39.SizeY - u38.SizeY;
    u29.SizeOffsetY = -u39.SizeY - u38.SizeY - 30;
    u41 = true;
    u28.SizeOffsetY = u43:Value() + u39.SizeY + u38.SizeY + 30;
    u41 = false;
    local v48, v49 = l__Parse__15(l__LocalPlayer__20, u39.Text, 13);
    if v49 then
        u47(v48);
    else
        u47();
    end;
end;
function u39.Focused() --[[ Line: 300 ]]
    -- upvalues: u8 (copy), u39 (copy), u30 (copy)
    u8:Call("Chat", true);
    u39.ForceHovering = true;
    u30.ForceHovering = true;
end;
function u39.FocusLost(_, _) --[[ Line: 305 ]]
    -- upvalues: u39 (copy), u32 (copy), u31 (copy), u29 (copy), u30 (copy), u8 (copy)
    u39.ForceHovering = false;
    if not (u32.Hovering or (u31.Hovering or (u29.Hovering or u39.Hovering))) then
        u30.ForceHovering = false;
    end;
    u8:Call("Chat", false);
end;
local u50 = true;
function u31.Button1Down() --[[ Line: 315 ]]
    -- upvalues: u50 (ref), u29 (copy), u43 (copy), u31 (copy)
    u50 = not u50;
    if u50 then
        u29.Visible = true;
        u43:Target(270);
        u31.Text = "X";
    else
        u43:Target(0, function() --[[ Line: 322 ]]
            -- upvalues: u29 (ref)
            u29.Visible = false;
        end);
        u31.Text = "+";
    end;
end;
function u32.Button1Down() --[[ Line: 329 ]]
    -- upvalues: l__Call__12 (copy)
    l__Call__12("ToggleGlobalChatModeration");
end;
local u51 = false;
local u52 = false;
l__Gui__10:RegisterBindable("Control", function(p53) --[[ Line: 334 ]]
    -- upvalues: u51 (ref)
    u51 = p53;
end, "LeftControl");
l__Gui__10:RegisterBindable("Shift", function(p54) --[[ Line: 337 ]]
    -- upvalues: u52 (ref)
    u52 = p54;
end, "LeftShift");
l__Gui__10:RegisterBindable("OpenChat", function(p55) --[[ Line: 340 ]]
    -- upvalues: u51 (ref), u52 (ref), u5 (copy), l__Call__12 (copy), u39 (copy)
    if u51 and u52 or (u5.Scale < 0.4 or u5.SizeX / 1920 * 3 < u5.Scale) then
        print("resetguiscale");
        l__Call__12("resetguiscale");
        return true;
    end;
    if p55 == false then
        u39:Focus();
        return true;
    end;
end, "Slash");
l__Gui__10:RegisterBindable("ClearChat", function(p56) --[[ Line: 351 ]]
    -- upvalues: u5 (copy), u39 (copy)
    if p56 and u5.Focus == u39 then
        u39:Unfocus();
        u39.Text = "";
        return true;
    end;
end, "Backquote");
l__Gui__10:RegisterBindable("ChatPageUp", function(p57) --[[ Line: 358 ]]
    -- upvalues: u29 (copy)
    if p57 then
        u29.MouseWheeled(4);
        return true;
    end;
end, "PageUp");
l__Gui__10:RegisterBindable("ChatPageDown", function(p58) --[[ Line: 364 ]]
    -- upvalues: u29 (copy)
    if p58 then
        u29.MouseWheeled(-4);
        return true;
    end;
end, "PageDown");
local u59 = 0;
local u60 = 0;
local u61 = 1;
local u62 = 0;
local u63 = {};
local u64 = {};
local u65 = {};
local u66 = {};
local u67 = 1;
local u68 = nil;
local u69 = nil;
local u70 = nil;
local u71 = {};
local u72 = {};
local u73 = {};
local u74 = {};
local function u88(p75, p76, p77) --[[ Line: 404 ]]
    -- upvalues: u65 (copy), l__Gen__17 (copy), u66 (copy), u63 (copy), u64 (copy), u62 (ref), u59 (ref), u61 (ref), u60 (ref), u35 (copy), u68 (ref), u69 (ref), u70 (ref), u4 (copy)
    local v78 = u65[p76];
    if v78 then
        if v78.Gui and v78.Gui.Remove then
            local l__SizeY__23 = v78.Gui.SizeY;
            v78.Gui:Remove();
            v78.Gui = nil;
            local v79 = l__Gen__17(p75);
            if v79 and v79.SizeY then
                v78.SizeOffsetY = v79.SizeY;
                v79.Parent = v78;
                v78.Gui = v79;
                if v79.SizeY ~= l__SizeY__23 then
                    local v80 = u66[p76];
                    local v81 = u63[v80];
                    local v82 = u64[v80];
                    local v83 = 0;
                    for v84 = 1, #v82 do
                        local v85 = v82[v84];
                        v85.PosOffsetY = v83;
                        v83 = v83 + v85.SizeY;
                    end;
                    if v80 == u62 then
                        u59 = v83;
                    end;
                    v81.SizeOffsetY = v83;
                    local v86 = 0;
                    for v87 = u61, u62 do
                        v86 = v86 + u63[v87].SizeY;
                    end;
                    u60 = v86;
                    u35.SizeOffsetY = u59;
                end;
            end;
        else
            u65[p76] = nil;
        end;
    end;
    if not p77 and p76 == u68 then
        u69 = p75;
        u70 = u4(p75);
    end;
end;
local function u107(p89, p90) --[[ Line: 450 ]]
    -- upvalues: u4 (copy), u70 (ref), u67 (ref), u88 (copy), u69 (ref), u68 (ref), u2 (copy), u72 (copy), u73 (copy), u74 (copy), u71 (copy), u1 (copy), l__Gen__17 (copy), u63 (copy), u62 (ref), u64 (copy), l__New__8 (copy), u35 (copy), u60 (ref), u59 (ref), u65 (copy), u66 (copy), u61 (ref)
    local v91 = u4(p89);
    if v91 == u70 then
        u67 = u67 + 1;
        u88({
            "List",
            { "Text", "(x" .. u67 .. ")" },
            u69
        }, u68, true);
        return;
    end;
    local v92 = u2();
    local v93 = u72[v91];
    if v93 and v92 < v93 + 0.5 then
        local v94 = u73[v91] + 1;
        u73[v91] = v94;
        u72[v91] = v92;
        u88({
            "List",
            { "Text", "(x" .. v94 .. ")" },
            u74[v91]
        }, u71[v91], true);
        return;
    end;
    u67 = 1;
    u68 = p90;
    u69 = p89;
    u70 = v91;
    u71[v91] = p90;
    u72[v91] = v92;
    u73[v91] = 1;
    u74[v91] = p89;
    local v95 = 0;
    for v96, v97 in u1, u72 do
        v95 = v95 + 1;
        if v95 >= 100 then
            break;
        end;
        if v97 and v97 + 0.5 < v92 then
            u71[v96] = nil;
            u72[v96] = nil;
            u73[v96] = nil;
            u74[v96] = nil;
        end;
    end;
    local v98 = l__Gen__17(p89);
    if v98 and v98.SizeY then
        local v99 = u63[u62];
        local v100 = u64[u62];
        if not v99 or (not v100 or #v100 >= 25) then
            v99 = l__New__8(u35);
            v99.SizeScaleX = 1;
            v99.DrawBackground = false;
            v99.PosOffsetY = u60;
            u62 = u62 + 1;
            u63[u62] = v99;
            v100 = {};
            u64[u62] = v100;
            u59 = 0;
        end;
        local v101 = l__New__8(v99);
        v101.DrawBackground = false;
        v101.SizeScaleX = 1;
        v101.SizeOffsetY = v98.SizeY;
        v100[#v100 + 1] = v101;
        if p90 then
            u65[p90] = v101;
            u66[p90] = u62;
        end;
        v98.Parent = v101;
        v101.Gui = v98;
        v101.PosOffsetY = u59;
        u59 = u59 + v98.SizeY;
        u60 = u60 + v98.SizeY;
        v99.SizeOffsetY = u59;
        u35.SizeOffsetY = u60;
        local v102 = u60;
        while u60 > 10000 and u61 ~= u62 do
            local v103 = u63[u61];
            u60 = u60 - v103.SizeY;
            v103:Remove();
            v103.Gui = nil;
            u61 = u61 + 1;
        end;
        if u60 ~= v102 then
            local v104 = 0;
            for v105 = u61, u62 do
                local v106 = u63[v105];
                v106.PosOffsetY = v104;
                v104 = v104 + v106.SizeY;
            end;
            u35.SizeOffsetY = v104;
            u60 = v104;
        end;
    else
        if v98 and v98.Remove then
            v98:Remove();
        end;
        print("Structure was dumb or something");
        print(u4(p89));
    end;
end;
local function u111(p108) --[[ Line: 576 ]]
    -- upvalues: l__LocalPlayer__20 (copy), u10 (copy), u20 (copy), u21 (copy), u22 (copy), u23 (copy), u24 (copy)
    local l__Name__24 = l__LocalPlayer__20.Name;
    local v109 = u10(l__Name__24);
    local v110 = {
        r = v109.r,
        g = v109.g,
        b = v109.b,
        a = v109.a * 0.5
    };
    return {
        "List",
        { "PushFont", Enum.Font.SourceSansLight.Value },
        { "PushFontSize", 12 },
        { "PushFGColor", u20 },
        { "PushTextStroke", u21 },
        {
            "TextNoCensor",
            {
                "Concat",
                "[",
                {
                    "TimeStamp",
                    { "Tick" }
                },
                "]"
            }
        },
        { "PopTextStroke" },
        { "PopFGColor" },
        { "PopFont" },
        { "PopFontSize" },
        { "Space", 3, 0 },
        {
            "List",
            { "PushFGColor", v110 },
            { "TextNoCensor", l__Name__24 },
            { "PopFGColor" }
        },
        { "PushFont", "Default" },
        { "PushFontSize", "Default" },
        { "PushTextStroke", u22 },
        { "PushFGColor", v110 },
        { "PushBGColor", "Default" },
        { "PushThinkFunc", "Default" },
        { "PushFontThinkFunc", "Default" },
        { "PushFontSizeThinkFunc", "Default" },
        { "PushTextStrokeThinkFunc", "Default" },
        { "PushFGColorThinkFunc", "Default" },
        { "PushBGColorThinkFunc", "Default" },
        { "TextNoCensor", ": " },
        { "PopFont" },
        { "PopFontSize" },
        { "PopTextStroke" },
        { "PopFGColor" },
        { "PopBGColor" },
        { "PopThinkFunc" },
        { "PopFontThinkFunc" },
        { "PopFontSizeThinkFunc" },
        { "PopTextStrokeThinkFunc" },
        { "PopFGColorThinkFunc" },
        { "PopBGColorThinkFunc" },
        { "PushFGColor", u23 },
        { "PushTextStroke", u24 },
        p108,
        { "PopTextStroke" },
        { "PopFGColor" }
    };
end;
u7.Add("NewChatMessage", u107);
u7.Add("EditChatMessage", u88);
u7.Add("SetChatPermissionFlags", function(p112) --[[ Line: 626 ]]
    -- upvalues: u13 (ref)
    u13 = p112;
end);
local u113 = {};
local u114 = {};
u7.Add("SetWhisperChannel", function(p115, p116) --[[ Line: 631 ]]
    -- upvalues: u113 (copy), u114 (copy), l__resume__2 (copy)
    u113[p115] = p116;
    local v117 = u114[p115];
    if v117 then
        u114[p115] = nil;
        for _, v118 in v117 do
            l__resume__2(v118, p116);
        end;
    end;
end);
local function u123(p119) --[[ Line: 642 ]]
    -- upvalues: u113 (copy), l__running__3 (copy), u114 (copy), l__Call__12 (copy), l__delay__6 (copy), l__status__5 (copy), l__resume__2 (copy), l__yield__4 (copy)
    local v120 = u113[p119];
    if v120 then
        return v120;
    end;
    local u121 = l__running__3();
    local v122 = u114[p119];
    if not v122 then
        v122 = {};
        u114[p119] = v122;
    end;
    v122[#v122 + 1] = u121;
    l__Call__12("RequestWhisperChannel", p119);
    l__delay__6(5, function() --[[ Line: 653 ]]
        -- upvalues: l__status__5 (ref), u121 (copy), l__resume__2 (ref)
        if l__status__5(u121) == "suspended" then
            l__resume__2(u121, nil);
        end;
    end);
    return l__yield__4();
end;
v12.Add({ "whisper", "w" }, { "Player", "Source" }, function(u124, u125) --[[ Line: 661 ]]
    -- upvalues: u123 (copy), l__Parse__15 (copy), l__LocalPlayer__20 (copy), u13 (ref), l__SearchStructure__16 (copy), l__Call__12 (copy), l__resume__2 (copy), l__create__1 (copy), u3 (copy)
    if u124 then
        local v132, v133 = l__resume__2(l__create__1(function() --[[ Line: 663 ]]
            -- upvalues: u123 (ref), u124 (copy), l__Parse__15 (ref), l__LocalPlayer__20 (ref), u125 (copy), u13 (ref), l__SearchStructure__16 (ref), l__Call__12 (ref)
            local v126 = u123(u124.UserId);
            if v126 then
                local v127 = {};
                l__SearchStructure__16(l__Parse__15(l__LocalPlayer__20, u125, u13), "Text", v127);
                local v128 = "";
                for _, v129 in v127 do
                    if type(v129[2]) == "string" then
                        v128 = v128 .. v129[2];
                    end;
                end;
                local v130, v131 = pcall(v126.SendAsync, v126, v128);
                if v130 then
                    l__Call__12("Chatted", v131.MessageId, u125, u124.UserId);
                end;
            end;
        end));
        if not v132 then
            u3("error in function:", v133);
        end;
    end;
end);
return function() --[[ Line: 681 ]]
    -- upvalues: l__SearchStructure__16 (copy), u65 (copy), u88 (copy), u107 (copy), u2 (copy), l__TextChatService__19 (copy), u7 (copy), u39 (copy), l__Call__12 (copy), l__Parse__15 (copy), l__LocalPlayer__20 (copy), u13 (ref), u14 (ref), u111 (copy), l__resume__2 (copy), l__create__1 (copy), u3 (copy), u32 (copy), u31 (copy), u29 (copy), u30 (copy), u8 (copy), l__RunService__18 (copy)
    local function u141(p134, p135, p136) --[[ Line: 684 ]]
        -- upvalues: l__SearchStructure__16 (ref), u65 (ref), u88 (ref), u107 (ref)
        local v137 = {};
        l__SearchStructure__16(p135, "Text", v137);
        local v138 = 1;
        for _, v139 in v137 do
            local v140 = #v139[2];
            v139[2] = p136:sub(v138, v138 + v140 - 1);
            v138 = v138 + v140;
        end;
        if u65[p134] then
            u88(p135, p134);
        else
            u107(p135, p134);
        end;
    end;
    local u142 = {};
    local u143 = {};
    local function u149(p144) --[[ Line: 719 ]]
        -- upvalues: u142 (copy), u143 (copy)
        for v145, v146 in u142 do
            if v146.Timeout < p144 then
                u142[v145] = nil;
            end;
        end;
        for v147, v148 in u143 do
            if v148.Timeout < p144 then
                u143[v147] = nil;
            end;
        end;
    end;
    local u150 = {
        lt = "<",
        gt = ">",
        amp = "&"
    };
    l__TextChatService__19.MessageReceived:Connect(function(p151) --[[ Line: 734 ]]
        -- upvalues: u150 (copy), u142 (copy), u141 (copy), u143 (copy), u2 (ref)
        local v152 = p151.Text:gsub("&([a-z]+);", u150);
        local l__MessageId__25 = p151.MessageId;
        local v153 = u142[l__MessageId__25];
        if v153 then
            u142[l__MessageId__25] = nil;
            u141(l__MessageId__25, v153.Structure, v152);
        else
            u143[l__MessageId__25] = {
                Timeout = u2() + 5,
                Text = v152
            };
        end;
    end);
    u7.Add("CombineChatMessage", function(p154, p155) --[[ Line: 739 ]]
        -- upvalues: u143 (copy), u141 (copy), u142 (copy), u2 (ref)
        local v156 = u143[p154];
        if v156 then
            u143[p154] = nil;
            u141(p154, p155, v156.Text);
        else
            u142[p154] = {
                Timeout = u2() + 5,
                Structure = p155
            };
        end;
    end);
    local l__Chat__26 = l__TextChatService__19:WaitForChild("Chat");
    local function u166(p157) --[[ Line: 744 ]]
        -- upvalues: u39 (ref), l__Call__12 (ref), l__Parse__15 (ref), l__LocalPlayer__20 (ref), u13 (ref), l__SearchStructure__16 (ref), u14 (ref), l__Chat__26 (copy), u107 (ref), u111 (ref), l__resume__2 (ref), l__create__1 (ref), u3 (ref)
        local u158 = u39.Text:match("^(.-)\r?$");
        if p157 and u158 ~= "" then
            u39.Text = "";
            if u158:find("^[/!]") then
                l__Call__12("Command", u158);
                return;
            end;
            local v164, v165 = l__resume__2(l__create__1(function() --[[ Line: 752 ]]
                -- upvalues: l__Parse__15 (ref), l__LocalPlayer__20 (ref), u158 (copy), u13 (ref), l__SearchStructure__16 (ref), u14 (ref), l__Chat__26 (ref), u107 (ref), u111 (ref), l__Call__12 (ref)
                local v159 = l__Parse__15(l__LocalPlayer__20, u158, u13);
                local v160 = {};
                l__SearchStructure__16(v159, "Text", v160);
                local v161 = u14;
                for _, v162 in v160 do
                    v161 = v161 .. v162[2];
                end;
                local v163 = l__Chat__26:SendAsync(v161);
                u107(u111(v159), v163.MessageId);
                l__Call__12("Chatted", v163.MessageId, u158);
            end));
            if not v164 then
                u3("error in function:", v165);
            end;
        end;
    end;
    function u39.FocusLost(_, p167) --[[ Line: 769 ]]
        -- upvalues: u166 (copy), u39 (ref), u32 (ref), u31 (ref), u29 (ref), u30 (ref), u8 (ref)
        u166(p167);
        u39.ForceHovering = false;
        if not (u32.Hovering or (u31.Hovering or (u29.Hovering or u39.Hovering))) then
            u30.ForceHovering = false;
        end;
        u8:Call("Chat", false);
    end;
    l__RunService__18.Heartbeat:Connect(function() --[[ Line: 774 ]]
        -- upvalues: u149 (copy), u2 (ref)
        u149(u2());
    end);
end;
