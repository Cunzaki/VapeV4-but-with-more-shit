-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local u2 = setmetatable;
local l__min__1 = math.min;
local l__max__2 = math.max;
local _ = math.ceil;
local l__floor__3 = math.floor;
local l__sub__4 = string.sub;
local l__remove__5 = table.remove;
local l__new__6 = Color3.new;
local l__new__7 = Vector2.new;
local l__new__8 = Rect.new;
local l__KeyCode__9 = Enum.KeyCode;
local u7 = {
    roblox_messing_with_guis_factor = 1,
    Color = function(p3, p4, p5, p6) --[[ Name: Color, Line 14 ]]
        return {
            r = p3,
            g = p4,
            b = p5,
            a = p6 or 255
        };
    end,
    TextColor1 = {
        r = 255,
        g = 255,
        b = 255,
        a = 255
    },
    Color0 = {
        r = 90,
        g = 90,
        b = 90,
        a = 255
    },
    Color1 = {
        r = 60,
        g = 60,
        b = 60,
        a = 255
    },
    Color2 = {
        r = 45,
        g = 45,
        b = 45,
        a = 255
    },
    Color3 = {
        r = 30,
        g = 30,
        b = 30,
        a = 255
    },
    LowerMap = {
        [l__KeyCode__9.Backquote] = "`",
        [l__KeyCode__9.One] = "1",
        [l__KeyCode__9.Two] = "2",
        [l__KeyCode__9.Three] = "3",
        [l__KeyCode__9.Four] = "4",
        [l__KeyCode__9.Five] = "5",
        [l__KeyCode__9.Six] = "6",
        [l__KeyCode__9.Seven] = "7",
        [l__KeyCode__9.Eight] = "8",
        [l__KeyCode__9.Nine] = "9",
        [l__KeyCode__9.Zero] = "0",
        [l__KeyCode__9.Minus] = "-",
        [l__KeyCode__9.Equals] = "=",
        [l__KeyCode__9.Q] = "q",
        [l__KeyCode__9.W] = "w",
        [l__KeyCode__9.E] = "e",
        [l__KeyCode__9.R] = "r",
        [l__KeyCode__9.T] = "t",
        [l__KeyCode__9.Y] = "y",
        [l__KeyCode__9.U] = "u",
        [l__KeyCode__9.I] = "i",
        [l__KeyCode__9.O] = "o",
        [l__KeyCode__9.P] = "p",
        [l__KeyCode__9.LeftBracket] = "[",
        [l__KeyCode__9.RightBracket] = "]",
        [l__KeyCode__9.BackSlash] = "\\",
        [l__KeyCode__9.A] = "a",
        [l__KeyCode__9.S] = "s",
        [l__KeyCode__9.D] = "d",
        [l__KeyCode__9.F] = "f",
        [l__KeyCode__9.G] = "g",
        [l__KeyCode__9.H] = "h",
        [l__KeyCode__9.J] = "j",
        [l__KeyCode__9.K] = "k",
        [l__KeyCode__9.L] = "l",
        [l__KeyCode__9.Semicolon] = ";",
        [l__KeyCode__9.Quote] = "\'",
        [l__KeyCode__9.Return] = "\n",
        [l__KeyCode__9.Z] = "z",
        [l__KeyCode__9.X] = "x",
        [l__KeyCode__9.C] = "c",
        [l__KeyCode__9.V] = "v",
        [l__KeyCode__9.B] = "b",
        [l__KeyCode__9.N] = "n",
        [l__KeyCode__9.M] = "m",
        [l__KeyCode__9.Comma] = ",",
        [l__KeyCode__9.Period] = ".",
        [l__KeyCode__9.Slash] = "/",
        [l__KeyCode__9.Space] = " "
    },
    UpperMap = {
        [l__KeyCode__9.Backquote] = "~",
        [l__KeyCode__9.One] = "!",
        [l__KeyCode__9.Two] = "@",
        [l__KeyCode__9.Three] = "#",
        [l__KeyCode__9.Four] = "$",
        [l__KeyCode__9.Five] = "%",
        [l__KeyCode__9.Six] = "^",
        [l__KeyCode__9.Seven] = "&",
        [l__KeyCode__9.Eight] = "*",
        [l__KeyCode__9.Nine] = "(",
        [l__KeyCode__9.Zero] = ")",
        [l__KeyCode__9.Minus] = "_",
        [l__KeyCode__9.Equals] = "+",
        [l__KeyCode__9.Tilde] = "~",
        [l__KeyCode__9.Unknown] = "!",
        [l__KeyCode__9.At] = "@",
        [l__KeyCode__9.Hash] = "#",
        [l__KeyCode__9.Dollar] = "$",
        [l__KeyCode__9.Percent] = "%",
        [l__KeyCode__9.Caret] = "^",
        [l__KeyCode__9.Ampersand] = "&",
        [l__KeyCode__9.Asterisk] = "*",
        [l__KeyCode__9.LeftBracket] = "(",
        [l__KeyCode__9.RightBracket] = ")",
        [l__KeyCode__9.Underscore] = "_",
        [l__KeyCode__9.Plus] = "+",
        [l__KeyCode__9.Q] = "Q",
        [l__KeyCode__9.W] = "W",
        [l__KeyCode__9.E] = "E",
        [l__KeyCode__9.R] = "R",
        [l__KeyCode__9.T] = "T",
        [l__KeyCode__9.Y] = "Y",
        [l__KeyCode__9.U] = "U",
        [l__KeyCode__9.I] = "I",
        [l__KeyCode__9.O] = "O",
        [l__KeyCode__9.P] = "P",
        [l__KeyCode__9.LeftBracket] = "{",
        [l__KeyCode__9.RightBracket] = "}",
        [l__KeyCode__9.BackSlash] = "|",
        [l__KeyCode__9.LeftCurly] = "{",
        [l__KeyCode__9.RightCurly] = "}",
        [l__KeyCode__9.Pipe] = "|",
        [l__KeyCode__9.A] = "A",
        [l__KeyCode__9.S] = "S",
        [l__KeyCode__9.D] = "D",
        [l__KeyCode__9.F] = "F",
        [l__KeyCode__9.G] = "G",
        [l__KeyCode__9.H] = "H",
        [l__KeyCode__9.J] = "J",
        [l__KeyCode__9.K] = "K",
        [l__KeyCode__9.L] = "L",
        [l__KeyCode__9.Semicolon] = ":",
        [l__KeyCode__9.Quote] = "\"",
        [l__KeyCode__9.Return] = "\n",
        [l__KeyCode__9.Colon] = ":",
        [l__KeyCode__9.QuotedDouble] = "\"",
        [l__KeyCode__9.Z] = "Z",
        [l__KeyCode__9.X] = "X",
        [l__KeyCode__9.C] = "C",
        [l__KeyCode__9.V] = "V",
        [l__KeyCode__9.B] = "B",
        [l__KeyCode__9.N] = "N",
        [l__KeyCode__9.M] = "M",
        [l__KeyCode__9.Comma] = "<",
        [l__KeyCode__9.Period] = ">",
        [l__KeyCode__9.Slash] = "?",
        [l__KeyCode__9.LessThan] = "<",
        [l__KeyCode__9.GreaterThan] = ">",
        [l__KeyCode__9.Question] = "?",
        [l__KeyCode__9.Space] = " "
    }
};
local l__UserInputService__10 = game:GetService("UserInputService");
local l__StarterGui__11 = game:GetService("StarterGui");
l__StarterGui__11:SetCoreGuiEnabled(4, false);
coroutine.resume(coroutine.create(function() --[[ Line: 57 ]]
    -- upvalues: l__StarterGui__11 (copy)
    local v8 = pcall;
    local l__SetCore__12 = l__StarterGui__11.SetCore;
    local v9 = 1;
    while true do
        local v10, _ = v8(l__SetCore__12, l__StarterGui__11, "TopbarEnabled", false);
        if v10 then
            break;
        end;
        v9 = v9 + 1;
        wait();
        if v10 then
            return;
        end;
    end;
    print("[QBox] SetCore TopbarEnabled Succeeded on try=", v9);
end));
l__StarterGui__11.ResetPlayerGuiOnSpawn = false;
local l__obtain__13 = _G.obtain;
local u11 = l__obtain__13("CurTime");
local v12 = l__obtain__13("Tween");
local l__New__14 = v12.New;
local l__Update__15 = v12.Update;
local l__MaxAcceleration__16 = v12.MaxAcceleration;
local l__Enumify__17 = l__obtain__13("Enums").Enumify;
local v13 = l__obtain__13("TextInfo");
local l__CharSize__18 = v13.CharSize;
local l__TextSize__19 = v13.TextSize;
local l__GetHeight__20 = v13.GetHeight;
local l__new__21 = Instance.new;
local l__new__22 = UDim2.new;
local l__IsA__23 = game.IsA;
local l__Gui__24 = l__obtain__13("InputBinds").Gui;
local v14 = l__obtain__13("PauseMulticall");
local u15 = "rbxassetid://57571495";
l__UserInputService__10.MouseIcon = u15;
local u16 = 1;
local u17 = 0;
local u18 = true;
local u19 = {
    Center = 2,
    Top = 2,
    Left = 0,
    Right = 1,
    Bottom = 2,
    TopLeft = 0,
    TopRight = 1,
    BottomLeft = 0,
    BottomRight = 1
};
local u20 = {
    Center = 1,
    Top = 0,
    Left = 1,
    Right = 1,
    Bottom = 2,
    TopLeft = 0,
    TopRight = 0,
    BottomLeft = 2,
    BottomRight = 2
};
local u21 = {
    Center = 0.5,
    Top = 0.5,
    Left = 0,
    Right = 1,
    Bottom = 0.5,
    TopLeft = 0,
    TopRight = 1,
    BottomLeft = 0,
    BottomRight = 1
};
local u22 = {
    Center = 0.5,
    Top = 0,
    Left = 0.5,
    Right = 0.5,
    Bottom = 1,
    TopLeft = 0,
    TopRight = 0,
    BottomLeft = 1,
    BottomRight = 1
};
function u7.ColourLerp(p23, p24, p25) --[[ Line: 163 ]]
    local v26 = 1 - p25;
    return {
        r = p23.r * v26 + p24.r * p25,
        g = p23.g * v26 + p24.g * p25,
        b = p23.b * v26 + p24.b * p25,
        a = p23.a * v26 + p24.a * p25 or 255
    };
end;
function u7.RawFreeMouse(p27) --[[ Line: 169 ]]
    -- upvalues: l__UserInputService__10 (copy), u15 (ref)
    l__UserInputService__10.MouseBehavior = p27 and 0 or 1;
    if p27 then
        l__UserInputService__10.MouseIcon = "";
    else
        l__UserInputService__10.MouseIcon = u15;
    end;
end;
local u28 = {};
function u7.FreeMouse(p29, p30) --[[ Line: 185 ]]
    -- upvalues: u28 (copy), l__UserInputService__10 (copy), u1 (copy), u15 (ref)
    u28[p29] = p30;
    if p30 then
        l__UserInputService__10.MouseBehavior = 0;
        l__UserInputService__10.MouseIcon = "";
    else
        local v31 = true;
        for _, v32 in u1, u28 do
            if v32 then
                v31 = false;
            end;
        end;
        if v31 then
            l__UserInputService__10.MouseBehavior = 1;
            l__UserInputService__10.MouseIcon = u15;
        end;
    end;
end;
v14:Register("FreeMouse", u7.FreeMouse);
function u7.IsMouseFree() --[[ Line: 203 ]]
    -- upvalues: u1 (copy), u28 (copy)
    for _, v33 in u1, u28 do
        if v33 then
            return true;
        end;
    end;
    return false;
end;
function u7.IsFreeingMouse(p34) --[[ Line: 212 ]]
    -- upvalues: u28 (copy)
    return u28[p34];
end;
function u7.WhatIsFreeingMouse() --[[ Line: 215 ]]
    -- upvalues: u1 (copy), u28 (copy)
    local v35 = {};
    for v36, v37 in u1, u28 do
        if v37 then
            v35[#v35 + 1] = v36;
        end;
        print(table.concat(v35, ", "));
    end;
end;
function u7.SetScale(p38) --[[ Line: 225 ]]
    -- upvalues: u16 (ref), u7 (copy)
    print("[QBox] SetScale", p38);
    if p38 then
        u16 = p38;
    else
        u16 = u7.SizeX / 1920;
        if u16 < 1 then
            u16 = u16 ^ 0.5;
        end;
        if u16 < 0.7 then
            u16 = 0.7;
        end;
    end;
    u7.Scale = u16;
end;
function u7.SetFocus(p39, p40) --[[ Line: 241 ]]
    -- upvalues: u7 (copy)
    local l__Focus__25 = u7.Focus;
    if p39 ~= l__Focus__25 then
        u7.Focus = p39;
        local v41 = l__Focus__25 and l__Focus__25.FocusLost;
        if v41 then
            v41(l__Focus__25, p40);
        end;
        local v42 = p39 and p39.Focused;
        if v42 then
            v42(p39);
        end;
    end;
end;
function u7.EnableMouseIcon(p43) --[[ Line: 261 ]]
    -- upvalues: u7 (copy), l__UserInputService__10 (copy), u15 (ref)
    if not u7.IsMouseFree() then
        l__UserInputService__10.MouseIconEnabled = p43;
        if p43 then
            l__UserInputService__10.MouseIcon = u15;
            return;
        end;
        l__UserInputService__10.MouseIcon = "";
    end;
end;
function u7.SetIcon(p44) --[[ Line: 271 ]]
    -- upvalues: u15 (ref), u7 (copy), l__UserInputService__10 (copy)
    u15 = p44;
    if not u7.IsMouseFree() then
        l__UserInputService__10.MouseIcon = u15;
    end;
end;
local u63 = {
    Frame = function(_, _, _) --[[ Name: Frame, Line 279 ]] end,
    ImageLabel = function(p45, p46, _) --[[ Name: ImageLabel, Line 281 ]]
        -- upvalues: l__new__8 (copy), l__new__6 (copy)
        p46.Image = p45.Image;
        p46.ScaleType = p45.ScaleType;
        local l__SliceCenter__26 = p45.SliceCenter;
        if l__SliceCenter__26 then
            p46.SliceCenter = l__new__8(l__SliceCenter__26, l__SliceCenter__26, l__SliceCenter__26, l__SliceCenter__26);
        else
            p46.SliceCenter = l__new__8(0, 0, 0, 0);
        end;
        local l__ImageColor__27 = p45.ImageColor;
        p46.ImageColor3 = l__new__6(l__ImageColor__27.r / 255, l__ImageColor__27.g / 255, l__ImageColor__27.b / 255);
        p46.ImageTransparency = 1 - l__ImageColor__27.a / 255;
    end,
    TextLabel = function(p47, p48, _) --[[ Name: TextLabel, Line 294 ]]
        -- upvalues: u19 (copy), u20 (copy), u16 (ref), l__new__6 (copy)
        if p47.PerCharacter then
            p48.Text = "";
        else
            p48.Text = p47.Text or "TextBox";
        end;
        p48.AutoLocalize = p47.AutoLocalize;
        local l__TextAlignment__28 = p47.TextAlignment;
        p48.TextWrapped = p47.TextWraps;
        p48.TextXAlignment = u19[l__TextAlignment__28];
        p48.TextYAlignment = u20[l__TextAlignment__28];
        p48.Font = p47.TextFont;
        p48.TextSize = u16 * p47.TextSize;
        local v49 = p48.TextBounds / u16;
        if p47.TextSizeX ~= v49.x or p47.TextSizeY ~= v49.y then
            local l__x__29 = v49.x;
            local l__y__30 = v49.y;
            p47.TextSizeX = l__x__29;
            p47.TextSizeY = l__y__30;
            local l__TextResize__31 = p47.TextResize;
            if l__TextResize__31 then
                l__TextResize__31(p47);
            end;
        end;
        local l__TextColor__32 = p47.TextColor;
        p48.TextColor3 = l__new__6(l__TextColor__32.r / 255, l__TextColor__32.g / 255, l__TextColor__32.b / 255);
        p48.TextTransparency = 1 - l__TextColor__32.a / 255;
        local l__TextStrokeColor__33 = p47.TextStrokeColor;
        p48.TextStrokeColor3 = l__new__6(l__TextStrokeColor__33.r / 255, l__TextStrokeColor__33.g / 255, l__TextStrokeColor__33.b / 255);
        p48.TextStrokeTransparency = 1 - l__TextStrokeColor__33.a / 255;
    end,
    TextBox = function(u50, u51, p52) --[[ Name: TextBox, Line 322 ]]
        -- upvalues: u19 (copy), u20 (copy), u16 (ref), l__new__6 (copy), u7 (copy)
        u51.Text = u50.Text or "TextBox";
        u51.AutoLocalize = u50.AutoLocalize;
        local l__TextAlignment__34 = u50.TextAlignment;
        u51.TextWrapped = u50.TextWraps;
        u51.TextXAlignment = u19[l__TextAlignment__34];
        u51.TextYAlignment = u20[l__TextAlignment__34];
        u51.Font = u50.TextFont;
        u51.TextSize = u16 * u50.TextSize;
        local v53 = u51.TextBounds / u16;
        if u50.TextSizeX ~= v53.x or u50.TextSizeY ~= v53.y then
            local l__x__35 = v53.x;
            local l__y__36 = v53.y;
            u50.TextSizeX = l__x__35;
            u50.TextSizeY = l__y__36;
            local l__TextResize__37 = u50.TextResize;
            if l__TextResize__37 then
                l__TextResize__37(u50);
            end;
        end;
        if p52 then
            u51.ClearTextOnFocus = false;
        end;
        local l__TextColor__38 = u50.TextColor;
        u51.TextColor3 = l__new__6(l__TextColor__38.r / 255, l__TextColor__38.g / 255, l__TextColor__38.b / 255);
        u51.TextTransparency = 1 - l__TextColor__38.a / 255;
        local l__TextStrokeColor__39 = u50.TextStrokeColor;
        u51.TextStrokeColor3 = l__new__6(l__TextStrokeColor__39.r / 255, l__TextStrokeColor__39.g / 255, l__TextStrokeColor__39.b / 255);
        u51.TextStrokeTransparency = 1 - l__TextStrokeColor__39.a / 255;
        u50.EventFocused = u51.Focused:connect(function() --[[ Line: 348 ]]
            -- upvalues: u50 (copy), u7 (ref)
            local v54 = u50;
            local l__Focus__40 = u7.Focus;
            if v54 ~= l__Focus__40 then
                u7.Focus = v54;
                local v55 = l__Focus__40 and l__Focus__40.FocusLost;
                if v55 then
                    v55(l__Focus__40, nil);
                end;
                local v56 = v54 and v54.Focused;
                if v56 then
                    v56(v54);
                end;
            end;
        end);
        u50.EventFocusLost = u51.FocusLost:connect(function(p57) --[[ Line: 357 ]]
            -- upvalues: u7 (ref), u50 (copy)
            if u7.Focus == u50 then
                local l__Focus__41 = u7.Focus;
                if l__Focus__41 ~= nil then
                    u7.Focus = nil;
                    local v58 = l__Focus__41 and l__Focus__41.FocusLost;
                    if v58 then
                        v58(l__Focus__41, p57);
                    end;
                end;
            end;
        end);
        local u59 = true;
        u50.EventChanged = u51.Changed:connect(function(p60) --[[ Line: 375 ]]
            -- upvalues: u59 (ref), u50 (copy), u51 (copy)
            if u59 and p60 == "Text" then
                u59 = false;
                u50.FakeBox.Text = u51.Text;
                u59 = true;
            end;
        end);
    end,
    ViewportFrame = function(p61, p62, _) --[[ Name: ViewportFrame, Line 385 ]]
        local l__Camera__42 = p61.Camera;
        p62.CurrentCamera = l__Camera__42;
        p61.Content.Parent = p62;
        l__Camera__42.Parent = p62;
    end
};
local u67 = {
    TextBox = function(p64, _) --[[ Name: TextBox, Line 394 ]]
        local l__EventFocused__43 = p64.EventFocused;
        if l__EventFocused__43 then
            p64.EventFocused = nil;
            l__EventFocused__43:disconnect();
        end;
        local l__EventFocusLost__44 = p64.EventFocusLost;
        if l__EventFocusLost__44 then
            p64.EventFocusLost = nil;
            l__EventFocusLost__44:disconnect();
        end;
        local l__EventChanged__45 = p64.EventChanged;
        if l__EventChanged__45 then
            p64.EventChanged = nil;
            l__EventChanged__45:disconnect();
        end;
    end,
    ViewportFrame = function(p65, p66) --[[ Name: ViewportFrame, Line 411 ]]
        p66.CurrentCamera = nil;
        p65.Content.Parent = nil;
        p65.Camera.Parent = nil;
    end
};
local u68 = {};
local function u75(p69) --[[ Line: 420 ]]
    -- upvalues: u68 (copy), l__remove__5 (copy), l__new__21 (copy), l__new__22 (copy), u16 (ref), u7 (copy), l__new__6 (copy), u63 (copy)
    if p69.RobloxBox then
        return p69.RobloxBox;
    else
        local l__RobloxClass__46 = p69.RobloxClass;
        local v70 = u68[l__RobloxClass__46];
        local v71 = false;
        local v72;
        if v70 then
            v72 = l__remove__5(v70);
        else
            v72 = nil;
        end;
        if not v72 then
            v72 = l__new__21(l__RobloxClass__46);
            v71 = true;
        end;
        p69.RobloxBox = v72;
        v72.Parent = p69.Parent.RobloxBox;
        v72.Visible = p69.Visible;
        v72.Position = l__new__22(p69.PosScaleX, u16 * p69.PosOffsetX, p69.PosScaleY, u16 * p69.PosOffsetY);
        v72.Size = l__new__22(p69.SizeScaleX, u16 * p69.SizeOffsetX, p69.SizeScaleY, u16 * p69.SizeOffsetY);
        v72.BorderSizePixel = 0;
        v72.ZIndex = p69.ZIndex or 5;
        v72.ClipsDescendants = p69.ClipsDescendants;
        v72.Rotation = 57.29577951308232 * (p69.Rotation or 0) % 360;
        local v73 = p69.BackgroundColor or u7.Color1;
        v72.BackgroundColor3 = l__new__6(v73.r / 255, v73.g / 255, v73.b / 255);
        if p69.DrawBackground then
            v72.BackgroundTransparency = 1 - v73.a / 255;
        else
            v72.BackgroundTransparency = 1;
        end;
        local v74 = u63[l__RobloxClass__46];
        if v74 then
            v74(p69, v72, v71);
            return v72;
        else
            print("[QBox] WARNING:No setup function for RobloxBox classname " .. v72.ClassName);
            return v72;
        end;
    end;
end;
local function u82(p76, p77, _) --[[ Line: 460 ]]
    -- upvalues: u82 (copy), u68 (copy), u67 (copy)
    local l__Children__47 = p76.Children;
    if l__Children__47 then
        for v78 = 1, #l__Children__47 do
            u82(l__Children__47[v78], p77);
        end;
    end;
    local v79 = (p77 or not p76.HoldRobloxBox) and p76.RobloxBox;
    if v79 then
        p76.RobloxBox = nil;
        v79.Parent = nil;
        local l__RobloxClass__48 = p76.RobloxClass;
        local v80 = u68[l__RobloxClass__48];
        if v80 then
            v80[#v80 + 1] = v79;
        else
            u68[p76.RobloxClass] = { v79 };
        end;
        local v81 = u67[l__RobloxClass__48];
        if v81 then
            v81(p76, v79);
        end;
    end;
end;
local function u85(p83) --[[ Line: 488 ]]
    -- upvalues: l__IsA__23 (copy), l__new__22 (copy), u16 (ref), u85 (copy)
    local l__Parent__49 = p83.Parent;
    if l__Parent__49 then
        local l__ActualBox__50 = l__Parent__49.ActualBox;
        p83.PosX = l__ActualBox__50.PosX + l__ActualBox__50.SizeX * p83.PosScaleX + p83.PosOffsetX;
        p83.PosY = l__ActualBox__50.PosY + l__ActualBox__50.SizeY * p83.PosScaleY + p83.PosOffsetY;
    end;
    local l__RobloxBox__51 = p83.RobloxBox;
    if l__RobloxBox__51 and l__IsA__23(l__RobloxBox__51, "GuiObject") then
        l__RobloxBox__51.Position = l__new__22(p83.PosScaleX, u16 * p83.PosOffsetX, p83.PosScaleY, u16 * p83.PosOffsetY);
    end;
    local l__Children__52 = p83.Children;
    if l__Children__52 then
        for v84 = 1, #l__Children__52 do
            local l__ActualBox__53 = l__Children__52[v84].ActualBox;
            if l__ActualBox__53 then
                if l__ActualBox__53.IsVisible then
                    u85(l__ActualBox__53);
                else
                    l__ActualBox__53.InternalMovedFlag = true;
                end;
            end;
        end;
    end;
    local l__Moved__54 = p83.Moved;
    if l__Moved__54 then
        l__Moved__54(p83);
    end;
end;
local function u91(p86, p87, p88, p89) --[[ Line: 517 ]]
    -- upvalues: l__IsA__23 (copy), l__new__22 (copy), u16 (ref), u91 (copy), u85 (copy)
    local l__Parent__55 = p86.Parent;
    if l__Parent__55 then
        local l__ActualBox__56 = l__Parent__55.ActualBox;
        p86.SizeX = l__ActualBox__56.SizeX * p86.SizeScaleX + p86.SizeOffsetX;
        p86.SizeY = l__ActualBox__56.SizeY * p86.SizeScaleY + p86.SizeOffsetY;
        local l__RobloxBox__57 = p86.RobloxBox;
        if l__RobloxBox__57 and l__IsA__23(l__RobloxBox__57, "GuiObject") then
            l__RobloxBox__57.Size = l__new__22(p86.SizeScaleX, u16 * p86.SizeOffsetX, p86.SizeScaleY, u16 * p86.SizeOffsetY);
            if p86.TextSize then
                l__RobloxBox__57.TextSize = u16 * p86.TextSize;
            end;
        end;
    end;
    local l__Children__58 = p86.Children;
    if l__Children__58 then
        for v90 = 1, #l__Children__58 do
            local l__ActualBox__59 = l__Children__58[v90].ActualBox;
            if l__ActualBox__59 then
                if l__ActualBox__59.IsVisible then
                    u91(l__ActualBox__59, p87, p88, true);
                    if not p89 then
                        u85(l__ActualBox__59);
                    end;
                else
                    l__ActualBox__59.InternalResizeFlag = true;
                    if not p89 then
                        l__ActualBox__59.InternalMovedFlag = true;
                    end;
                end;
            end;
        end;
    end;
    local l__Resize__60 = p86.Resize;
    if l__Resize__60 then
        l__Resize__60(p86);
    end;
end;
u7.InternalResize = u91;
local function u95(p92, p93) --[[ Line: 558 ]]
    -- upvalues: u95 (copy)
    p93(p92);
    local l__Children__61 = p92.Children;
    if l__Children__61 then
        for v94 = 1, #l__Children__61 do
            u95(l__Children__61[v94], p93);
        end;
    end;
end;
u7.Recurse = u95;
local u124 = {
    [{
        PosScaleX = true,
        PosScaleY = true,
        PosOffsetX = true,
        PosOffsetY = true
    }] = u85,
    [{
        SizeScaleX = true,
        SizeScaleY = true,
        SizeOffsetX = true,
        SizeOffsetY = true
    }] = u91,
    [{
        Rotation = true
    }] = function(p96) --[[ Line: 572 ]]
        local l__RobloxBox__62 = p96.RobloxBox;
        if l__RobloxBox__62 then
            l__RobloxBox__62.Rotation = 57.29577951308232 * p96.Rotation % 360;
        end;
    end,
    [{
        Fade = true
    }] = function(p97) --[[ Line: 578 ]]
        -- upvalues: l__New__14 (copy), l__MaxAcceleration__16 (copy)
        local l__Fade__63 = p97.Fade;
        if l__Fade__63 then
            if p97.FadeTween then
                p97.FadeTween.Update = l__Fade__63;
            else
                l__Fade__63(0);
                local v98 = l__New__14(0, l__Fade__63);
                v98.MaxAcceleration = l__MaxAcceleration__16(0, 1, 0, 0, p97.FadeDuration);
                v98:Remove();
                p97.FadeTween = v98;
            end;
        else
            if p97.FadeTween then
                p97.FadeTween = nil;
            end;
        end;
    end,
    [{
        Moved = true
    }] = function(p99) --[[ Line: 594 ]]
        local l__Moved__64 = p99.Moved;
        if l__Moved__64 then
            l__Moved__64(p99);
        end;
    end,
    [{
        Resize = true
    }] = function(p100) --[[ Line: 600 ]]
        local l__Resize__65 = p100.Resize;
        if l__Resize__65 then
            l__Resize__65(p100);
        end;
    end,
    [{
        Visible = true
    }] = function(p101) --[[ Line: 606 ]]
        -- upvalues: u95 (copy)
        if not p101.Visible then
            local function v103(p102) --[[ Line: 608 ]]
                p102.IsVisible = false;
            end;
            p101.IsVisible = false;
            local l__Children__66 = p101.Children;
            if l__Children__66 then
                for v104 = 1, #l__Children__66 do
                    u95(l__Children__66[v104], v103);
                end;
            end;
        end;
    end,
    [{
        FadeDuration = true
    }] = function(p105) --[[ Line: 611 ]]
        -- upvalues: l__MaxAcceleration__16 (copy)
        local l__FadeTween__67 = p105.FadeTween;
        if l__FadeTween__67 then
            l__FadeTween__67.MaxAcceleration = l__MaxAcceleration__16(0, 1, 0, 0, p105.FadeDuration);
        end;
    end,
    [{
        Parent = true
    }] = function(p106, p107, p108) --[[ Line: 617 ]]
        -- upvalues: l__remove__5 (copy), u91 (copy), u85 (copy), u82 (copy)
        if p107 == "Parent" then
            local l__RobloxBox__68 = p106.RobloxBox;
            local l__FakeBox__69 = p106.FakeBox;
            if p108 then
                local l__Children__70 = p108.Children;
                if l__Children__70 then
                    for v109 = #l__Children__70, 1, -1 do
                        if l__Children__70[v109] == l__FakeBox__69 then
                            l__remove__5(l__Children__70, v109);
                        end;
                    end;
                end;
            end;
            local l__Parent__71 = p106.Parent;
            if l__Parent__71 then
                local l__RobloxBox__72 = l__Parent__71.RobloxBox;
                if l__RobloxBox__68 and l__RobloxBox__72 then
                    l__RobloxBox__68.Parent = l__RobloxBox__72;
                end;
                local l__Children__73 = l__Parent__71.Children;
                if l__Children__73 then
                    l__Children__73[#l__Children__73 + 1] = l__FakeBox__69;
                else
                    l__Parent__71.Children = { l__FakeBox__69 };
                end;
                u91(p106);
                u85(p106);
                return;
            end;
            local l__Removed__74 = p106.Removed;
            if l__Removed__74 then
                l__Removed__74(p106);
            end;
            u82(p106, true);
        end;
    end,
    [{
        Visible = true
    }] = function(p110) --[[ Line: 654 ]]
        local l__RobloxBox__75 = p110.RobloxBox;
        if l__RobloxBox__75 then
            l__RobloxBox__75.Visible = p110.Visible;
        end;
    end,
    [{
        DrawBackground = true
    }] = function(p111) --[[ Line: 660 ]]
        local l__RobloxBox__76 = p111.RobloxBox;
        if l__RobloxBox__76 then
            if p111.DrawBackground then
                l__RobloxBox__76.BackgroundTransparency = 1 - p111.BackgroundColor.a / 255;
                return;
            end;
            l__RobloxBox__76.BackgroundTransparency = 1;
        end;
    end,
    [{
        BackgroundColor = true
    }] = function(p112) --[[ Line: 670 ]]
        -- upvalues: l__new__6 (copy)
        local l__RobloxBox__77 = p112.RobloxBox;
        if l__RobloxBox__77 then
            local l__BackgroundColor__78 = p112.BackgroundColor;
            l__RobloxBox__77.BackgroundColor3 = l__new__6(l__BackgroundColor__78.r / 255, l__BackgroundColor__78.g / 255, l__BackgroundColor__78.b / 255);
            if p112.DrawBackground then
                l__RobloxBox__77.BackgroundTransparency = 1 - l__BackgroundColor__78.a / 255;
                return;
            end;
            l__RobloxBox__77.BackgroundTransparency = 1;
        end;
    end,
    [{
        ClipsDescendants = true
    }] = function(p113) --[[ Line: 682 ]]
        local l__RobloxBox__79 = p113.RobloxBox;
        if l__RobloxBox__79 then
            l__RobloxBox__79.ClipsDescendants = p113.ClipsDescendants;
        end;
    end,
    [{
        Text = true
    }] = function(p114) --[[ Line: 688 ]]
        local l__RobloxBox__80 = p114.RobloxBox;
        if l__RobloxBox__80 then
            if p114.PerCharacter then
                p114:RefreshText();
                return;
            end;
            l__RobloxBox__80.Text = p114.Text;
        end;
    end,
    [{
        TextFont = true
    }] = function(p115) --[[ Line: 698 ]]
        local l__RobloxBox__81 = p115.RobloxBox;
        if l__RobloxBox__81 then
            l__RobloxBox__81.Font = p115.TextFont;
            if p115.PerCharacter then
                p115:RefreshText();
            end;
        end;
    end,
    [{
        TextSize = true
    }] = function(p116) --[[ Line: 707 ]]
        -- upvalues: u16 (ref)
        local l__RobloxBox__82 = p116.RobloxBox;
        if l__RobloxBox__82 then
            l__RobloxBox__82.TextSize = u16 * p116.TextSize;
            if p116.PerCharacter then
                p116:RefreshText();
            end;
        end;
    end,
    [{
        TextColor = true
    }] = function(p117) --[[ Line: 717 ]]
        -- upvalues: l__new__6 (copy)
        local l__RobloxBox__83 = p117.RobloxBox;
        if l__RobloxBox__83 then
            local l__TextColor__84 = p117.TextColor;
            l__RobloxBox__83.TextColor3 = l__new__6(l__TextColor__84.r / 255, l__TextColor__84.g / 255, l__TextColor__84.b / 255);
            l__RobloxBox__83.TextTransparency = 1 - l__TextColor__84.a / 255;
            if p117.PerCharacter then
                p117:RefreshText();
            end;
        end;
    end,
    [{
        TextStrokeColor = true
    }] = function(p118) --[[ Line: 734 ]]
        -- upvalues: l__new__6 (copy)
        local l__RobloxBox__85 = p118.RobloxBox;
        if l__RobloxBox__85 then
            local l__TextStrokeColor__86 = p118.TextStrokeColor;
            l__RobloxBox__85.TextStrokeColor3 = l__new__6(l__TextStrokeColor__86.r / 255, l__TextStrokeColor__86.g / 255, l__TextStrokeColor__86.b / 255);
            l__RobloxBox__85.TextStrokeTransparency = 1 - l__TextStrokeColor__86.a / 255;
            if p118.PerCharacter then
                p118:RefreshText();
            end;
        end;
    end,
    [{
        ImageColor = true
    }] = function(p119) --[[ Line: 745 ]]
        -- upvalues: l__new__6 (copy)
        local l__RobloxBox__87 = p119.RobloxBox;
        if l__RobloxBox__87 then
            local l__ImageColor__88 = p119.ImageColor;
            l__RobloxBox__87.ImageColor3 = l__new__6(l__ImageColor__88.r / 255, l__ImageColor__88.g / 255, l__ImageColor__88.b / 255);
            l__RobloxBox__87.ImageTransparency = 1 - l__ImageColor__88.a / 255;
        end;
    end,
    [{
        ScaleType = true
    }] = function(p120) --[[ Line: 753 ]]
        local l__RobloxBox__89 = p120.RobloxBox;
        if l__RobloxBox__89 then
            l__RobloxBox__89.ScaleType = p120.ScaleType;
        end;
    end,
    [{
        SliceCenter = true
    }] = function(p121) --[[ Line: 759 ]]
        -- upvalues: l__new__8 (copy)
        local l__RobloxBox__90 = p121.RobloxBox;
        if l__RobloxBox__90 then
            local l__SliceCenter__91 = p121.SliceCenter;
            if l__SliceCenter__91 then
                l__RobloxBox__90.SliceCenter = l__new__8(l__SliceCenter__91, l__SliceCenter__91, l__SliceCenter__91, l__SliceCenter__91);
                return;
            end;
            l__RobloxBox__90.SliceCenter = l__new__8(0, 0, 0, 0);
        end;
    end,
    [{
        ZIndex = true
    }] = function(p122) --[[ Line: 770 ]]
        local l__RobloxBox__92 = p122.RobloxBox;
        if l__RobloxBox__92 then
            l__RobloxBox__92.ZIndex = p122.ZIndex;
        end;
    end,
    [{
        AutoLocalize = true
    }] = function(p123) --[[ Line: 776 ]]
        local l__RobloxBox__93 = p123.RobloxBox;
        if l__RobloxBox__93 then
            l__RobloxBox__93.AutoLocalize = p123.AutoLocalize;
        end;
    end
};
local u125 = {};
local function u134(p126) --[[ Line: 807 ]]
    -- upvalues: l__max__2 (copy), l__min__1 (copy), u75 (copy), u82 (copy), u91 (copy), u85 (copy), u134 (copy)
    if p126.Visible then
        local l__PreDraw__94 = p126.PreDraw;
        if l__PreDraw__94 then
            l__PreDraw__94(p126);
        end;
        local l__Parent__95 = p126.Parent;
        local v127 = l__Parent__95 and l__Parent__95.ClippingBounds;
        if v127 then
            local v128 = l__max__2(v127.x0, p126.PosX);
            local v129 = l__max__2(v127.y0, p126.PosY);
            local v130 = l__min__1(v127.x1, p126.PosX + p126.SizeX);
            local v131 = l__min__1(v127.y1, p126.PosY + p126.SizeY);
            local v132;
            if v128 < v130 then
                v132 = v129 < v131;
            else
                v132 = false;
            end;
            p126.IsVisible = v132;
            if (v132 or p126.HoldRobloxBox) and not p126.RobloxBox then
                u75(p126);
            elseif not v132 and p126.RobloxBox then
                u82(p126);
            end;
            if p126.ClipsDescendants then
                p126.ClippingBounds = {
                    x0 = v128,
                    y0 = v129,
                    x1 = v130,
                    y1 = v131
                };
            else
                p126.ClippingBounds = v127;
            end;
        end;
        if p126.IsVisible then
            local _ = p126.DrawBackground;
            local l__Draw__96 = p126.Draw;
            if l__Draw__96 then
                l__Draw__96(p126);
            end;
            local l__Children__97 = p126.Children;
            if l__Children__97 then
                for v133 = 1, #l__Children__97 do
                    local l__ActualBox__98 = l__Children__97[v133].ActualBox;
                    if l__ActualBox__98 then
                        if l__ActualBox__98.InternalResizeFlag then
                            u91(l__ActualBox__98);
                            l__ActualBox__98.InternalResizeFlag = false;
                        end;
                        if l__ActualBox__98.InternalMovedFlag then
                            u85(l__ActualBox__98);
                            l__ActualBox__98.InternalMovedFlag = false;
                        end;
                        u134(l__ActualBox__98);
                    end;
                end;
            end;
        end;
        local l__PostDraw__99 = p126.PostDraw;
        if l__PostDraw__99 then
            l__PostDraw__99(p126);
        end;
    end;
end;
u7.InternalDraw = u134;
local u135 = false;
local u136 = false;
local function u151(p137, p138, p139) --[[ Line: 875 ]]
    -- upvalues: u18 (ref), u151 (copy), l__max__2 (copy), l__min__1 (copy), u135 (ref), u136 (ref), u17 (ref), l__Update__15 (copy), u11 (copy)
    local v140 = u18;
    local l__Children__100 = p137.Children;
    if l__Children__100 then
        for v141 = #l__Children__100, 1, -1 do
            local v142 = l__Children__100[v141];
            if v142 then
                local l__ActualBox__101 = v142.ActualBox;
                if l__ActualBox__101 and l__ActualBox__101.IsVisible then
                    u151(l__ActualBox__101, p138, p139);
                end;
            end;
        end;
    end;
    local v143 = p138 - p137.PosX;
    local v144 = p139 - p137.PosY;
    local l__ClippingBounds__102 = p137.ClippingBounds;
    local l__CustomHover__103 = p137.CustomHover;
    local v145;
    if l__CustomHover__103 then
        v145 = l__CustomHover__103(p137, p138, p139);
    elseif l__ClippingBounds__102 then
        if l__max__2(l__ClippingBounds__102.x0, p137.PosX) <= p138 and (p138 <= l__min__1(l__ClippingBounds__102.x1, p137.PosX + p137.SizeX) and l__max__2(l__ClippingBounds__102.y0, p137.PosY) <= p139) then
            v145 = p139 <= l__min__1(l__ClippingBounds__102.y1, p137.PosY + p137.SizeY);
        else
            v145 = false;
        end;
    elseif p137.PosX <= p138 and (p138 <= p137.PosX + p137.SizeX and p137.PosY <= p139) then
        v145 = p139 <= p137.PosY + p137.SizeY;
    else
        v145 = false;
    end;
    local v146 = v145 and p137.Visible and p137.IsVisible or (p137.Button1 or p137.Button2);
    if v146 then
        if u18 then
            u18 = false;
        elseif p137.CanBeBlocked and not (v140 and p137.IgnoreChildrenBlocking) then
            v146 = false;
        end;
    end;
    local v147 = v146 and p137.Visible and p137.IsVisible or (p137.Button1 or p137.Button2);
    local v148 = (v140 or not p137.CanBeForceBlocked) and v147 and v147 or p137.ForceHovering;
    p137.Hovering = v147;
    if v147 and (v143 ~= p137.MouseX or v144 ~= p137.MouseY) then
        p137.MouseX = v143;
        p137.MouseY = v144;
        local l__MouseMoved__104 = p137.MouseMoved;
        if l__MouseMoved__104 then
            l__MouseMoved__104(p138, p139);
        end;
    end;
    if v147 then
        if u135 and not p137.LastButton1 then
            p137.Button1 = u135;
            local l__Button1Down__105 = p137.Button1Down;
            if l__Button1Down__105 then
                l__Button1Down__105(v143, v144);
            end;
        end;
        if not u135 and p137.Button1 then
            p137.Button1 = u135;
            local l__Button1Up__106 = p137.Button1Up;
            if l__Button1Up__106 then
                l__Button1Up__106(v143, v144);
            end;
        end;
        if u136 and not p137.LastButton2 then
            p137.Button2 = u136;
            local l__Button2Down__107 = p137.Button2Down;
            if l__Button2Down__107 then
                l__Button2Down__107(v143, v144);
            end;
        end;
        if not u136 and p137.Button2 then
            p137.Button2 = u136;
            local l__Button2Up__108 = p137.Button2Up;
            if l__Button2Up__108 then
                l__Button2Up__108(v143, v144);
            end;
        end;
        local v149 = u17 ~= 0 and p137.MouseWheeled;
        if v149 then
            v149(u17);
        end;
    end;
    local v150 = u136;
    p137.LastButton1 = u135;
    p137.LastButton2 = v150;
    if v147 ~= p137.WasHovering then
        if v147 then
            local l__MouseEnter__109 = p137.MouseEnter;
            if l__MouseEnter__109 then
                l__MouseEnter__109();
            end;
        else
            local l__MouseLeave__110 = p137.MouseLeave;
            if l__MouseLeave__110 then
                l__MouseLeave__110();
            end;
        end;
    end;
    local l__Fade__111 = p137.Fade;
    local l__FadeTween__112 = p137.FadeTween;
    if l__Fade__111 and l__FadeTween__112 then
        if v148 ~= p137.WasForceHovering then
            l__FadeTween__112:Target(v148 and 1 or 0);
        end;
        l__Update__15(l__FadeTween__112, u11());
    end;
    local l__Think__113 = p137.Think;
    if l__Think__113 then
        l__Think__113(p137.FakeBox);
    end;
    p137.WasHovering = v147;
    p137.WasForceHovering = v148;
end;
u7.InternalThink = u151;
local function u155(p152) --[[ Line: 1015 ]]
    -- upvalues: u82 (copy), u155 (copy), l__remove__5 (copy)
    if p152 then
        local l__ActualBox__114 = p152.ActualBox;
        local l__Removed__115 = l__ActualBox__114.Removed;
        if l__Removed__115 then
            l__Removed__115(l__ActualBox__114);
        end;
        u82(l__ActualBox__114, true);
        local l__Children__116 = l__ActualBox__114.Children;
        if l__Children__116 then
            for v153 = #l__Children__116, 1, -1 do
                u155(l__Children__116[v153]);
            end;
        end;
        l__ActualBox__114.Children = nil;
        local l__Parent__117 = l__ActualBox__114.Parent;
        if l__Parent__117 then
            local l__Children__118 = l__Parent__117.Children;
            if l__Children__118 then
                for v154 = #l__Children__118, 1, -1 do
                    if l__Children__118[v154] == p152 then
                        l__remove__5(l__Children__118, v154);
                    end;
                end;
            end;
        end;
        l__ActualBox__114.Parent = nil;
    else
        print("FakeBox nil", debug.traceback());
    end;
end;
u7.Remove = u155;
local u156 = nil;
local function u171(p157) --[[ Line: 1049 ]]
    -- upvalues: u156 (ref), u7 (copy), u155 (copy), u2 (copy), u125 (copy), u1 (copy), u124 (copy), u91 (copy), u85 (copy)
    if p157 ~= false then
        p157 = p157 or u156;
    end;
    local u158 = {
        Children = {},
        PosX = 0,
        PosY = 0,
        SizeX = 0,
        SizeY = 0,
        Keys = {},
        IsVisible = true,
        Hovering = false
    };
    local v159;
    if p157 then
        v159 = p157.ClippingBounds or nil;
    else
        v159 = nil;
    end;
    u158.ClippingBounds = v159;
    u158.WasHovering = false;
    u158.WasForceHovering = false;
    u158.Button1 = false;
    u158.Button2 = false;
    u158.LastButton1 = false;
    u158.LastButton2 = false;
    u158.trace = debug.traceback();
    u158.Parent = p157;
    u158.Callbacks = {};
    u158.PosScaleX = 0;
    u158.PosScaleY = 0;
    u158.PosOffsetX = 0;
    u158.PosOffsetY = 0;
    u158.SizeScaleX = 0;
    u158.SizeScaleY = 0;
    u158.SizeOffsetX = 0;
    u158.SizeOffsetY = 0;
    u158.Rotation = 0;
    u158.Visible = true;
    u158.DrawBackground = true;
    u158.BackgroundColor = u7.Color1;
    u158.AutoLocalize = true;
    u158.ForceHovering = false;
    u158.FadeDuration = 0.2;
    u158.ZIndex = p157 and (p157.ZIndex or 0) or 0;
    u158.CanBeBlocked = true;
    u158.IgnoreChildrenBlocking = true;
    u158.Remove = u155;
    if p157 then
        local l__Visible__119 = p157.Visible;
        if l__Visible__119 then
            l__Visible__119 = p157.IsVisible;
        end;
        u158.IsVisible = l__Visible__119;
    end;
    local v160 = {};
    local u161 = u2({
        ActualBox = u158
    }, v160);
    function v160.__index(_, p162) --[[ Line: 1112 ]]
        -- upvalues: u125 (ref), u158 (copy)
        local v163 = u125[p162];
        if v163 then
            return v163(u158);
        else
            return u158[p162];
        end;
    end;
    function v160.__newindex(_, p164, p165) --[[ Line: 1120 ]]
        -- upvalues: u158 (copy), u1 (ref), u124 (ref), u161 (copy)
        local v166 = u158[p164];
        if v166 ~= p165 then
            u158[p164] = p165;
            for v167, v168 in u1, u124 do
                if v167[p164] then
                    v168(u161, p164, v166);
                end;
            end;
            for v169, v170 in u1, u158.Callbacks do
                if v169[p164] then
                    v170(u161, p164, v166);
                end;
            end;
        end;
    end;
    u158.FakeBox = u161;
    if p157 then
        local l__Children__120 = p157.Children;
        if l__Children__120 then
            l__Children__120[#l__Children__120 + 1] = u161;
        else
            p157.Children = { u161 };
        end;
    end;
    u91(u158);
    u85(u158);
    return u161;
end;
u7.Base = u171;
u156 = u171();
u156.Visible = true;
u156.IsVisible = true;
local l__ActualBox__121 = u156.ActualBox;
l__ActualBox__121.Remove = nil;
l__ActualBox__121.CanBeBlocked = true;
l__ActualBox__121.IgnoreChildrenBlocking = false;
l__ActualBox__121.DrawBackground = false;
l__ActualBox__121.BackgroundColor = {
    r = 0,
    g = 0,
    b = 0,
    a = 0
};
l__ActualBox__121.PosOffsetY = -36;
l__ActualBox__121.SizeScaleX = 1;
l__ActualBox__121.SizeScaleY = 1;
l__ActualBox__121.SizeOffsetY = 36;
local u172 = 0;
local u173 = 0;
local u174 = 0;
local u175 = l__new__21("ScreenGui");
u175.Name = "QBox";
u7.RobloxBase = u175;
local v176 = l__new__21("Frame", u175);
v176.Transparency = 1;
v176.Position = l__new__22(0, 0, 0, -36);
v176.Size = l__new__22(1, 0, 1, 36);
u156.RobloxBox = v176;
u175.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local u177 = 0;
local u178 = 0;
l__Gui__24:RegisterBindable("MoveMouse", function(p179, p180) --[[ Line: 1219 ]]
    -- upvalues: u177 (ref), u178 (ref), u1 (copy), u28 (copy)
    u177 = p179;
    u178 = p180;
    for _, v181 in u1, u28 do
        if v181 then
            return true;
        end;
    end;
    return false;
end, "MouseMovement");
l__Gui__24:RegisterBindable("Scroll", function(p182) --[[ Line: 1223 ]]
    -- upvalues: u17 (ref), u1 (copy), u28 (copy)
    u17 = u17 + p182;
    for _, v183 in u1, u28 do
        if v183 then
            return true;
        end;
    end;
    return false;
end, "MouseWheel");
l__Gui__24:RegisterBindable("Button1", function(p184) --[[ Line: 1227 ]]
    -- upvalues: u135 (ref), u1 (copy), u28 (copy)
    u135 = p184;
    for _, v185 in u1, u28 do
        if v185 then
            return true;
        end;
    end;
    return false;
end, "MouseButton1");
l__Gui__24:RegisterBindable("Button2", function(p186) --[[ Line: 1231 ]]
    -- upvalues: u136 (ref), u1 (copy), u28 (copy)
    u136 = p186;
    for _, v187 in u1, u28 do
        if v187 then
            return true;
        end;
    end;
    return false;
end, "MouseButton2");
l__Gui__24:RegisterBindable("StealKeyboard", function(_, _) --[[ Line: 1235 ]]
    -- upvalues: u7 (copy)
    return u7.Focus ~= nil;
end, "Keyboard");
local u188 = 0;
local u189 = 0;
game:GetService("RunService").Heartbeat:connect(function() --[[ Line: 1239 ]]
    -- upvalues: u175 (copy), u188 (ref), u189 (ref), u177 (ref), u16 (ref), u178 (ref), u134 (copy), u156 (ref), u7 (copy), u173 (ref), u172 (ref), u174 (ref), l__ActualBox__121 (copy), u91 (copy), u18 (ref), u151 (copy), u17 (ref)
    debug.profilebegin("QBox");
    if u175.Enabled then
        local v190 = u177 / u16;
        local v191 = (u178 + 36) / u16;
        u188 = v190;
        u189 = v191;
        u134(u156);
        local v192 = u7;
        local v193 = u189;
        u7.MouseX = u188;
        v192.MouseY = v193;
        local l__AbsoluteSize__122 = u175.AbsoluteSize;
        local l__x__123 = l__AbsoluteSize__122.x;
        local v194 = l__AbsoluteSize__122.y + 36;
        if u173 == 0 then
            u16 = l__x__123 / 1920;
            if u16 < 1 then
                u16 = u16 ^ 0.5;
            end;
            if u16 < 0.7 then
                u16 = 0.7;
            end;
        end;
        if l__x__123 ~= u172 or (v194 ~= u173 or u16 ~= u174) then
            u7.Scale = u16;
            local v195 = u16;
            u172 = l__x__123;
            u173 = v194;
            u174 = v195;
            local v196 = u7;
            u7.SizeX = l__x__123;
            v196.SizeY = v194;
            local v197 = l__x__123 / u16;
            local v198 = v194 / u16;
            local v199 = l__ActualBox__121;
            l__ActualBox__121.SizeX = v197;
            v199.SizeY = v198;
            u91(l__ActualBox__121);
            l__ActualBox__121.ClippingBounds = {
                x0 = 0,
                y0 = 0,
                x1 = v197,
                y1 = v198
            };
        end;
        u18 = true;
        u151(l__ActualBox__121, u188, u189);
        u7.Hovering = not l__ActualBox__121.Hovering;
        u17 = 0;
    end;
    debug.profileend();
end);
u7.ROOT = u156;
function u7.New(p200) --[[ Line: 1279 ]]
    -- upvalues: u171 (copy)
    local v201 = u171(p200);
    local l__ActualBox__124 = v201.ActualBox;
    local _ = p200 or l__ActualBox__124.Parent;
    l__ActualBox__124.RobloxClass = "Frame";
    return v201;
end;
local function u203(p202) --[[ Line: 1294 ]]
    local l__RobloxBox__125 = p202.RobloxBox;
    if l__RobloxBox__125 then
        l__RobloxBox__125.Image = p202.Image;
    end;
end;
local function u205(p204) --[[ Line: 1301 ]]
    p204.ImageColor = p204.FGColor;
end;
local function u209(p206, p207) --[[ Line: 1305 ]]
    -- upvalues: u171 (copy), u203 (copy), u205 (copy)
    local v208 = u171(p206);
    local l__ActualBox__126 = v208.ActualBox;
    local _ = p206 or l__ActualBox__126.Parent;
    l__ActualBox__126.RobloxClass = "ImageLabel";
    l__ActualBox__126.Image = p207;
    l__ActualBox__126.ImageColor = {
        r = 255,
        g = 255,
        b = 255,
        a = 255
    };
    l__ActualBox__126.ScaleType = 0;
    local l__Callbacks__127 = l__ActualBox__126.Callbacks;
    l__Callbacks__127[{
        Image = true
    }] = u203;
    l__Callbacks__127[{
        FGColor = true
    }] = u205;
    return v208;
end;
u7.Image = u209;
local function u212(p210) --[[ Line: 1397 ]]
    if p210.User then
        local v211 = tonumber(p210.User);
        p210.Image = "http://www.roblox.com/Thumbs/Avatar.ashx?x=100&y=100&format=png&" .. (v211 and "userid=" .. v211 or "username=" .. p210.User);
    end;
end;
function u7.Avatar(p213, p214) --[[ Line: 1404 ]]
    -- upvalues: u209 (copy), u212 (copy)
    local v215 = tonumber(p214);
    local v216 = u209;
    local v217;
    if p214 then
        v217 = "http://www.roblox.com/Thumbs/Avatar.ashx?x=100&y=100&format=png&" .. (v215 and "userid=" .. v215 or "username=" .. p214);
    else
        v217 = p214;
    end;
    local v218 = v216(p213, v217);
    local l__ActualBox__128 = v218.ActualBox;
    l__ActualBox__128.User = p214;
    l__ActualBox__128.Callbacks[{
        User = true
    }] = u212;
    return v218;
end;
function u7.Viewport(p219) --[[ Line: 1415 ]]
    -- upvalues: u171 (copy), l__new__21 (copy)
    local v220 = u171(p219);
    local l__ActualBox__129 = v220.ActualBox;
    local _ = p219 or l__ActualBox__129.Parent;
    l__ActualBox__129.RobloxClass = "ViewportFrame";
    l__ActualBox__129.Camera = l__new__21("Camera");
    local v221 = l__new__21("WorldModel");
    v221.Name = "Content";
    l__ActualBox__129.Content = v221;
    return v220;
end;
local function u228(p222, p223) --[[ Line: 1428 ]]
    local v224 = #p222;
    local v225 = {};
    for v226 = 1, v224 do
        local v227 = p223(v226, p222[v226]);
        v227.SizeScaleX = 1;
        v227.SizeScaleY = 1 / v224;
        v227.PosScaleX = 0;
        v227.PosScaleY = (v226 - 1) / v224;
        v225[v226] = v227;
    end;
    return v225;
end;
u7.FromList = u228;
local u229 = nil;
local function u231(p230) --[[ Line: 1445 ]]
    -- upvalues: u19 (copy), u20 (copy)
    local l__TextAlignment__130 = p230.TextAlignment;
    local l__RobloxBox__131 = p230.RobloxBox;
    if l__RobloxBox__131 then
        l__RobloxBox__131.TextXAlignment = u19[l__TextAlignment__130];
        l__RobloxBox__131.TextYAlignment = u20[l__TextAlignment__130];
    end;
end;
u7.UpdateTextAlignment = u231;
local u232 = l__Enumify__17(Enum.Font);
function u7.ResizeToText(p233, p234, p235, p236) --[[ Line: 1457 ]]
    -- upvalues: u16 (ref), l__floor__3 (copy), l__TextSize__19 (copy), u232 (copy), l__new__7 (copy)
    local v237 = l__floor__3(p233.TextSize * u16 + 0.5);
    local v238 = v237 > 100 and 100 or v237;
    local v239 = v238 < 1 and 1 or v238;
    local v240 = l__TextSize__19;
    local v241 = u232[p233.TextFont];
    local l__Text__132 = p233.Text;
    local v242 = not (p234 and p234 * u16) and p233.TextWraps;
    if v242 then
        v242 = u16 * l__new__7(p233.SizeX, p233.SizeY);
    end;
    local v243, v244 = v240(v241, v239, l__Text__132, v242);
    if not p235 then
        p233.SizeOffsetX = v243 / u16;
    end;
    if not p236 then
        p233.SizeOffsetY = v244 / u16;
    end;
end;
local function u253(p245) --[[ Line: 1475 ]]
    -- upvalues: u16 (ref), l__floor__3 (copy), l__TextSize__19 (copy), u232 (copy)
    if p245.DontCheckBounds then
    else
        local l__RobloxBox__133 = p245.RobloxBox;
        if l__RobloxBox__133 then
            local v246 = l__RobloxBox__133.TextBounds / u16;
            local l__x__134 = v246.x;
            local l__y__135 = v246.y;
            p245.TextSizeX = l__x__134;
            p245.TextSizeY = l__y__135;
            local l__TextResize__136 = p245.TextResize;
            if l__TextResize__136 then
                l__TextResize__136(p245);
            end;
        else
            local v247 = l__floor__3(p245.TextSize * u16 + 0.5);
            local v248 = v247 > 100 and 100 or v247;
            local v249, v250 = l__TextSize__19(u232[p245.TextFont], v248 < 1 and 1 or v248, p245.Text);
            local v251 = v249 / u16;
            local v252 = v250 / u16;
            p245.TextSizeX = v251;
            p245.TextSizeY = v252;
        end;
    end;
end;
u7.UpdateTextSize = u253;
local function u255(p254) --[[ Line: 1502 ]]
    local l__TextResize__137 = p254.TextResize;
    if l__TextResize__137 then
        l__TextResize__137(p254);
    end;
end;
local function u257(p256) --[[ Line: 1509 ]]
    p256.TextColor = p256.FGColor;
end;
local function u274(p258) --[[ Line: 1519 ]]
    -- upvalues: u16 (ref), l__floor__3 (copy), l__GetHeight__20 (copy), l__TextSize__19 (copy), u21 (copy), u22 (copy), l__sub__4 (copy), u229 (ref), l__CharSize__18 (copy), u155 (copy), l__remove__5 (copy)
    local l__CharacterList__138 = p258.CharacterList;
    if not l__CharacterList__138 then
        l__CharacterList__138 = {};
        p258.CharacterList = l__CharacterList__138;
    end;
    local l__Text__139 = p258.Text;
    local l__TextFont__140 = p258.TextFont;
    local l__TextSize__141 = p258.TextSize;
    local l__TextColor__142 = p258.TextColor;
    local l__TextStrokeColor__143 = p258.TextStrokeColor;
    local v259 = l__floor__3(l__TextSize__141 * u16 + 0.5);
    local v260 = v259 > 100 and 100 or v259;
    local v261 = v260 < 1 and 1 or v260;
    local v262 = l__GetHeight__20(l__TextFont__140, v261) / u16;
    if type(l__Text__139) == "string" then
        local v263, v264 = l__TextSize__19(l__TextFont__140, v261, l__Text__139);
        local v265 = (p258.SizeX - v263 / u16) * u21[p258.TextAlignment];
        local v266 = (p258.SizeY - v264 / u16) * u22[p258.TextAlignment];
        for v267 = 1, #l__Text__139 do
            local v268 = l__sub__4(l__Text__139, v267, v267);
            local v269 = l__CharacterList__138[v267];
            if not v269 then
                v269 = u229(p258, v268);
                v269.BackgroundColor = {
                    r = 0,
                    g = 0,
                    b = 0,
                    a = 0
                };
                l__CharacterList__138[v267] = v269;
            end;
            v269.TextFont = l__TextFont__140;
            v269.TextSize = l__TextSize__141;
            v269.TextColor = l__TextColor__142;
            v269.TextStrokeColor = l__TextStrokeColor__143;
            v269.Text = v268;
            v269.PosOffsetX = v265;
            v269.PosOffsetY = v266;
            local v270, v271 = l__CharSize__18(l__TextFont__140, v261, v268);
            local v272 = v270 / u16;
            local v273 = v271 / u16;
            v269.SizeOffsetX = v272;
            v269.SizeOffsetY = v273;
            v265 = v265 + v272;
            if v268 == "\n" then
                v266 = v266 + v262;
                v265 = 0;
            end;
        end;
        while #l__CharacterList__138 > #l__Text__139 do
            u155(l__remove__5(l__CharacterList__138));
        end;
    end;
end;
local function u276(p275) --[[ Line: 1773 ]]
    -- upvalues: u82 (copy)
    u82(p275, true);
    p275.RobloxClass = p275.Editable and "TextBox" or "TextLabel";
end;
local function u279(p277) --[[ Line: 1818 ]]
    local v278 = p277.RobloxClass == "TextBox" and p277.RobloxBox;
    if v278 then
        v278:CaptureFocus();
    end;
end;
local function u282(p280, p281) --[[ Line: 1845 ]]
    if p280.RobloxClass == "TextBox" then
        local l__RobloxBox__144 = p280.RobloxBox;
        if l__RobloxBox__144 and l__RobloxBox__144:IsFocused() then
            l__RobloxBox__144:ReleaseFocus(p281);
        end;
    end;
end;
u229 = function(p283, p284) --[[ Line: 1863 ]]
    -- upvalues: u171 (copy), u7 (copy), u274 (copy), u279 (copy), u282 (copy), u253 (copy), u231 (copy), u255 (copy), u257 (copy), u276 (copy)
    local v285 = u171(p283);
    local l__ActualBox__145 = v285.ActualBox;
    local _ = p283 or l__ActualBox__145.Parent;
    l__ActualBox__145.RobloxClass = "TextLabel";
    l__ActualBox__145.Text = p284 or "";
    l__ActualBox__145.TextFont = Enum.Font.Legacy;
    l__ActualBox__145.TextSize = 14 * u7.roblox_messing_with_guis_factor;
    l__ActualBox__145.TextColor = u7.TextColor1;
    l__ActualBox__145.TextStrokeColor = {
        r = 0,
        g = 0,
        b = 0,
        a = 0
    };
    l__ActualBox__145.TextAlignment = "Center";
    l__ActualBox__145.Editable = false;
    l__ActualBox__145.RefreshText = u274;
    l__ActualBox__145.Focus = u279;
    l__ActualBox__145.Unfocus = u282;
    local l__Callbacks__146 = l__ActualBox__145.Callbacks;
    l__Callbacks__146[{
        Text = true,
        TextFont = true,
        TextSize = true
    }] = u253;
    l__Callbacks__146[{
        TextAlignment = true
    }] = u231;
    l__Callbacks__146[{
        TextResize = true
    }] = u255;
    l__Callbacks__146[{
        FGColor = true
    }] = u257;
    u253(l__ActualBox__145);
    l__Callbacks__146[{
        Editable = true
    }] = u276;
    return v285;
end;
u7.TextBox = u229;
function u7.DragBar(u286, u287) --[[ Line: 1900 ]]
    -- upvalues: u7 (copy)
    local u288 = nil;
    local u289 = nil;
    function u286.Button1Down(p290, p291) --[[ Line: 1902 ]]
        -- upvalues: u288 (ref), u289 (ref), u286 (copy), u287 (copy)
        local v292 = u286.PosX + p290 - u287.PosX;
        local v293 = u286.PosY + p291 - u287.PosY;
        u288 = v292;
        u289 = v293;
    end;
    function u286.Button1Up(p294, p295) --[[ Line: 1905 ]]
        -- upvalues: u288 (ref), u289 (ref), u287 (copy), u286 (copy)
        if u288 and u289 then
            local v296 = u287;
            local v297 = u286.PosX + p294 - u288;
            local v298 = u286.PosY + p295 - u289;
            local l__Parent__147 = v296.Parent;
            if l__Parent__147 then
                local l__ActualBox__148 = l__Parent__147.ActualBox;
                local v299 = v297 - (l__ActualBox__148.PosX + l__ActualBox__148.SizeX * v296.PosScaleX);
                local v300 = v298 - (l__ActualBox__148.PosY + l__ActualBox__148.SizeY * v296.PosScaleY);
                v296.PosOffsetX = v299;
                v296.PosOffsetY = v300;
            end;
            u288 = nil;
            u289 = nil;
        end;
    end;
    function u286.Think() --[[ Line: 1911 ]]
        -- upvalues: u288 (ref), u289 (ref), u7 (ref), u287 (copy)
        if u288 and u289 then
            local l__MouseX__149 = u7.MouseX;
            local l__MouseY__150 = u7.MouseY;
            local v301 = u287;
            local v302 = l__MouseX__149 - u288;
            local v303 = l__MouseY__150 - u289;
            local l__Parent__151 = v301.Parent;
            if l__Parent__151 then
                local l__ActualBox__152 = l__Parent__151.ActualBox;
                local v304 = v302 - (l__ActualBox__152.PosX + l__ActualBox__152.SizeX * v301.PosScaleX);
                local v305 = v303 - (l__ActualBox__152.PosY + l__ActualBox__152.SizeY * v301.PosScaleY);
                v301.PosOffsetX = v304;
                v301.PosOffsetY = v305;
            end;
        end;
    end;
end;
local function u341(u306, p307) --[[ Line: 1920 ]]
    -- upvalues: u171 (copy), u7 (copy), u209 (copy), l__New__14 (copy), l__MaxAcceleration__16 (copy), l__max__2 (copy), l__min__1 (copy)
    p307.ClipsDescendants = true;
    local u308 = u171(p307);
    local l__ActualBox__153 = u308.ActualBox;
    local _ = p307 or l__ActualBox__153.Parent;
    l__ActualBox__153.RobloxClass = "Frame";
    u308.DrawBackground = false;
    u308.SizeScaleX = 1;
    u308.SizeScaleY = 1;
    u308.ClipsDescendants = true;
    u308.HorizontalScroll = true;
    u308.VerticalScroll = true;
    u306.PosScaleX = 0;
    u306.PosScaleY = 0;
    u306.Parent = u308;
    local u309 = u171(p307);
    local l__ActualBox__154 = u309.ActualBox;
    local _ = p307 or l__ActualBox__154.Parent;
    l__ActualBox__154.RobloxClass = "Frame";
    u309.PosScaleY = 1;
    u309.SizeScaleX = 1;
    u309.SizeOffsetY = 20;
    u309.BackgroundColor = u7.Color2;
    u308.ScrollXFrame = u309;
    local u310 = u209(u309, "rbxassetid://402406026");
    u310.DrawBackground = false;
    u310.SizeScaleY = 1;
    u310.ImageColor = u7.Color3;
    u310.ScaleType = 1;
    u310.SliceCenter = 10;
    u310.SizeScaleX = u308.SizeX / u306.SizeX;
    u308.ScrollXBar = u310;
    local u311 = u171(p307);
    local l__ActualBox__155 = u311.ActualBox;
    local _ = p307 or l__ActualBox__155.Parent;
    l__ActualBox__155.RobloxClass = "Frame";
    u311.PosScaleX = 1;
    u311.SizeScaleY = 1;
    u311.SizeOffsetX = 20;
    u311.ImageColor = u7.Color2;
    u308.ScrollYFrame = u311;
    local u312 = u209(u311, "rbxassetid://402406026");
    u312.DrawBackground = false;
    u312.SizeScaleX = 1;
    u312.ImageColor = u7.Color3;
    u312.ScaleType = 1;
    u312.SliceCenter = 10;
    u312.SizeScaleY = u308.SizeY / u306.SizeY;
    u308.ScrollYBar = u312;
    u308.Callbacks[{
        HorizontalScroll = true
    }] = function(p313) --[[ Line: 1967 ]]
        -- upvalues: u309 (copy)
        u309.Visible = p313.HorizontalScroll;
    end;
    u308.Callbacks[{
        VerticalScroll = true
    }] = function(p314) --[[ Line: 1970 ]]
        -- upvalues: u311 (copy)
        u311.Visible = p314.VerticalScroll;
    end;
    local u316 = l__New__14(u308.SizeX < u306.SizeX and (-u311.SizeX or 0) or 0, function(p315) --[[ Line: 1974 ]]
        -- upvalues: u309 (copy), u311 (copy), u308 (copy)
        u309.PosOffsetY = p315;
        u311.SizeOffsetY = p315;
        u308.SizeOffsetY = p315;
    end);
    u316.MaxAcceleration = l__MaxAcceleration__16(0, u311.SizeX, 0, 0, 0.5);
    local u318 = l__New__14(u308.SizeY < u306.SizeY and (-u309.SizeY or 0) or 0, function(p317) --[[ Line: 1981 ]]
        -- upvalues: u311 (copy), u309 (copy), u308 (copy)
        u311.PosOffsetX = p317;
        u309.SizeOffsetX = p317;
        u308.SizeOffsetX = p317;
    end);
    u318.MaxAcceleration = l__MaxAcceleration__16(0, u309.SizeY, 0, 0, 0.5);
    local u319 = true;
    local u320 = true;
    function u306.Resize() --[[ Line: 1989 ]]
        -- upvalues: u308 (copy), u306 (copy), l__max__2 (ref), l__min__1 (ref), u319 (ref), u320 (ref), u310 (copy), u309 (copy), u312 (copy), u311 (copy), u316 (copy), u318 (copy)
        local v321 = l__min__1(0, (l__max__2(u308.SizeX - u306.SizeX, u306.PosOffsetX)));
        local v322 = l__min__1(0, (l__max__2(u308.SizeY - u306.SizeY, u306.PosOffsetY)));
        if u308.AutoScrollX and u319 then
            v321 = u308.SizeX - u306.SizeX;
        end;
        if u308.AutoScrollY and u320 then
            v322 = u308.SizeY - u306.SizeY;
        end;
        local v323 = u306;
        u306.PosOffsetX = v321;
        v323.PosOffsetY = v322;
        local v324 = u308.SizeX / u306.SizeX;
        local v325 = u308.SizeY / u306.SizeY;
        u310.SizeScaleX = l__max__2(20 / u309.SizeX, (l__min__1(1, v324)));
        u312.SizeScaleY = l__max__2(20 / u311.SizeY, (l__min__1(1, v325)));
        u310.PosOffsetX = v321 / (u308.SizeX - u306.SizeX) * (u309.SizeX - u310.SizeX);
        u312.PosOffsetY = v322 / (u308.SizeY - u306.SizeY) * (u311.SizeY - u312.SizeY);
        local v326;
        if v324 < 1 then
            v326 = u308.HorizontalScroll;
        else
            v326 = false;
        end;
        local v327;
        if v325 < 1 then
            v327 = u308.VerticalScroll;
        else
            v327 = false;
        end;
        if v326 and v327 then
            u309.Visible = true;
            u311.Visible = true;
            u316:Target(-u311.SizeX);
            u318:Target(-u309.SizeY);
        elseif v327 then
            u311.Visible = true;
            u316:Target(0, function() --[[ Line: 2011 ]]
                -- upvalues: u309 (ref)
                u309.Visible = false;
            end);
            u318:Target(-u309.SizeY);
        elseif v326 then
            u309.Visible = true;
            u316:Target(-u311.SizeX);
            u318:Target(0, function() --[[ Line: 2016 ]]
                -- upvalues: u311 (ref)
                u311.Visible = false;
            end);
        else
            u316:Target(0, function() --[[ Line: 2018 ]]
                -- upvalues: u309 (ref)
                u309.Visible = false;
            end);
            u318:Target(0, function() --[[ Line: 2019 ]]
                -- upvalues: u311 (ref)
                u311.Visible = false;
            end);
        end;
    end;
    local u328 = nil;
    local u329 = nil;
    function p307.MouseWheeled(p330) --[[ Line: 2025 ]]
        -- upvalues: u308 (copy), u306 (copy), u329 (ref), l__min__1 (ref), l__max__2 (ref), u320 (ref), u312 (copy), u311 (copy), u328 (ref), u319 (ref), u310 (copy), u309 (copy)
        local v331;
        if u308.SizeX < u306.SizeX then
            v331 = u308.HorizontalScroll;
        else
            v331 = false;
        end;
        local v332;
        if u308.SizeY < u306.SizeY then
            v332 = u308.VerticalScroll;
        else
            v332 = false;
        end;
        if v332 and not u329 then
            local v333 = l__max__2(u308.SizeY - u306.SizeY, (l__min__1(0, u306.PosOffsetY + 0.2 * u308.SizeY * p330)));
            if v333 == u308.SizeY - u306.SizeY then
                u320 = true;
            else
                u320 = false;
            end;
            u306.PosOffsetY = v333;
            u312.PosOffsetY = v333 / (u308.SizeY - u306.SizeY) * (u311.SizeY - u312.SizeY);
        else
            if v331 and not u328 then
                local v334 = l__max__2(u308.SizeX - u306.SizeX, (l__min__1(0, u306.PosOffsetX + 0.2 * u308.SizeX * p330)));
                if v334 == u308.SizeX - u306.SizeX then
                    u319 = true;
                else
                    u319 = false;
                end;
                u306.PosOffsetX = v334;
                u310.PosOffsetX = v334 / (u308.SizeX - u306.SizeX) * (u309.SizeX - u310.SizeX);
            end;
        end;
    end;
    function u310.Button1Down(p335, _) --[[ Line: 2048 ]]
        -- upvalues: u328 (ref)
        u328 = p335;
    end;
    function u310.MouseMoved(p336, _) --[[ Line: 2051 ]]
        -- upvalues: u328 (ref), u309 (copy), u310 (copy), l__min__1 (ref), l__max__2 (ref), u319 (ref), u306 (copy), u308 (copy)
        if u328 then
            local v337 = l__max__2(0, (l__min__1(1, (p336 - u328 - u309.PosX) / (u309.SizeX - u310.SizeX))));
            if v337 == 1 then
                u319 = true;
            else
                u319 = false;
            end;
            u310.PosOffsetX = v337 * (u309.SizeX - u310.SizeX);
            u306.PosOffsetX = -v337 * (u306.SizeX - u308.SizeX);
        end;
    end;
    function u310.Button1Up(_, _) --[[ Line: 2063 ]]
        -- upvalues: u328 (ref)
        u328 = nil;
    end;
    function u312.Button1Down(_, p338) --[[ Line: 2067 ]]
        -- upvalues: u329 (ref)
        u329 = p338;
    end;
    function u312.MouseMoved(_, p339) --[[ Line: 2070 ]]
        -- upvalues: u329 (ref), u311 (copy), u312 (copy), l__min__1 (ref), l__max__2 (ref), u320 (ref), u306 (copy), u308 (copy)
        if u329 then
            local v340 = l__max__2(0, (l__min__1(1, (p339 - u329 - u311.PosY) / (u311.SizeY - u312.SizeY))));
            if v340 == 1 then
                u320 = true;
            else
                u320 = false;
            end;
            u312.PosOffsetY = v340 * (u311.SizeY - u312.SizeY);
            u306.PosOffsetY = -v340 * (u306.SizeY - u308.SizeY);
        end;
    end;
    function u312.Button1Up(_, _) --[[ Line: 2082 ]]
        -- upvalues: u329 (ref)
        u329 = nil;
    end;
    return u308;
end;
u7.Scroll = u341;
function u7.Resizable(u342) --[[ Line: 2090 ]]
    -- upvalues: u171 (copy), l__max__2 (copy), u7 (copy), l__min__1 (copy)
    local l__Parent__156 = u342.Parent;
    if not l__Parent__156 then
        error("Parent object required for QBox.Resizable");
    end;
    local v343 = u342;
    local v344 = u171(v343);
    local l__ActualBox__157 = v344.ActualBox;
    local _ = v343 or l__ActualBox__157.Parent;
    l__ActualBox__157.RobloxClass = "Frame";
    local u345 = v344;
    u345.DrawBackground = false;
    u345.SizeScaleX = 1;
    u345.SizeScaleY = 1;
    u345.ResizeTop = true;
    u345.ResizeBottom = true;
    u345.ResizeRight = true;
    u345.ResizeLeft = true;
    local u346 = nil;
    local u347 = nil;
    local u348 = nil;
    local u349 = nil;
    local u350 = u171(u342);
    local l__ActualBox__158 = u350.ActualBox;
    local _ = u342 or l__ActualBox__158.Parent;
    l__ActualBox__158.RobloxClass = "Frame";
    u350.Visible = false;
    local u351 = u171(u342);
    local l__ActualBox__159 = u351.ActualBox;
    local _ = u342 or l__ActualBox__159.Parent;
    l__ActualBox__159.RobloxClass = "Frame";
    u351.Visible = false;
    local function u359(p352, p353) --[[ Line: 2118 ]]
        -- upvalues: u342 (copy), u348 (ref), u346 (ref), u350 (copy), u345 (copy), l__max__2 (ref), l__Parent__156 (copy), u349 (ref), u347 (ref), u351 (copy)
        local l__PosX__160 = u342.PosX;
        local l__PosY__161 = u342.PosY;
        if u348 and u346 then
            local l__PosScaleX__162 = u350.PosScaleX;
            local v354 = l__max__2(u345.MinX, (p352 - u348 - u346) / (2 * l__PosScaleX__162 - 1));
            u342.SizeOffsetX = v354 - l__Parent__156.SizeX * u342.SizeScaleX;
            l__PosX__160 = v354 * (l__PosScaleX__162 - 1) + u346;
        end;
        if u349 and u347 then
            local l__PosScaleY__163 = u351.PosScaleY;
            local v355 = l__max__2(u345.MinY, (p353 - u349 - u347) / (2 * l__PosScaleY__163 - 1));
            u342.SizeOffsetY = v355 - l__Parent__156.SizeY * u342.SizeScaleY;
            l__PosY__161 = v355 * (l__PosScaleY__163 - 1) + u347;
        end;
        if u348 or u349 then
            local v356 = u342;
            local l__Parent__164 = v356.Parent;
            if l__Parent__164 then
                local l__ActualBox__165 = l__Parent__164.ActualBox;
                local v357 = l__PosX__160 - (l__ActualBox__165.PosX + l__ActualBox__165.SizeX * v356.PosScaleX);
                local v358 = l__PosY__161 - (l__ActualBox__165.PosY + l__ActualBox__165.SizeY * v356.PosScaleY);
                v356.PosOffsetX = v357;
                v356.PosOffsetY = v358;
            end;
        end;
    end;
    function u350.Button1Down(p360, p361) --[[ Line: 2141 ]]
        -- upvalues: u350 (copy), u342 (copy), u346 (ref), u348 (ref), u351 (copy), u347 (ref), u349 (ref)
        local v362 = u350.PosX + p360;
        local v363 = u350.PosY + p361;
        if u350.Visible then
            local l__PosX__166 = u342.PosX;
            local l__SizeX__167 = u342.SizeX;
            local l__PosScaleX__168 = u350.PosScaleX;
            u346 = l__PosX__166 + l__SizeX__167 * (1 - l__PosScaleX__168);
            u348 = v362 - (l__PosX__166 + l__SizeX__167 * l__PosScaleX__168);
        end;
        if u351.Visible then
            local l__PosY__169 = u342.PosY;
            local l__SizeY__170 = u342.SizeY;
            local l__PosScaleY__171 = u351.PosScaleY;
            u347 = l__PosY__169 + l__SizeY__170 * (1 - l__PosScaleY__171);
            u349 = v363 - (l__PosY__169 + l__SizeY__170 * l__PosScaleY__171);
        end;
    end;
    function u350.Button1Up(p364, p365) --[[ Line: 2144 ]]
        -- upvalues: u350 (copy), u359 (copy), u346 (ref), u347 (ref), u348 (ref), u349 (ref)
        u359(u350.PosX + p364, u350.PosY + p365);
        u346 = nil;
        u347 = nil;
        u348 = nil;
        u349 = nil;
    end;
    function u351.Button1Down(p366, p367) --[[ Line: 2147 ]]
        -- upvalues: u351 (copy), u350 (copy), u342 (copy), u346 (ref), u348 (ref), u347 (ref), u349 (ref)
        local v368 = u351.PosX + p366;
        local v369 = u351.PosY + p367;
        if u350.Visible then
            local l__PosX__172 = u342.PosX;
            local l__SizeX__173 = u342.SizeX;
            local l__PosScaleX__174 = u350.PosScaleX;
            u346 = l__PosX__172 + l__SizeX__173 * (1 - l__PosScaleX__174);
            u348 = v368 - (l__PosX__172 + l__SizeX__173 * l__PosScaleX__174);
        end;
        if u351.Visible then
            local l__PosY__175 = u342.PosY;
            local l__SizeY__176 = u342.SizeY;
            local l__PosScaleY__177 = u351.PosScaleY;
            u347 = l__PosY__175 + l__SizeY__176 * (1 - l__PosScaleY__177);
            u349 = v369 - (l__PosY__175 + l__SizeY__176 * l__PosScaleY__177);
        end;
    end;
    function u351.Button1Up(p370, p371) --[[ Line: 2150 ]]
        -- upvalues: u351 (copy), u359 (copy), u346 (ref), u347 (ref), u348 (ref), u349 (ref)
        u359(u351.PosX + p370, u351.PosY + p371);
        u346 = nil;
        u347 = nil;
        u348 = nil;
        u349 = nil;
    end;
    local l__Callbacks__178 = u345.Callbacks;
    l__Callbacks__178[{
        ResizeBorder = true
    }] = function() --[[ Line: 2154 ]]
        -- upvalues: u350 (copy), u345 (copy), u351 (copy)
        u350.SizeOffsetX = u345.ResizeBorder;
        u351.SizeOffsetY = u345.ResizeBorder;
    end;
    l__Callbacks__178[{
        MinX = true
    }] = function() --[[ Line: 2158 ]]
        -- upvalues: u351 (copy), u345 (copy)
        u351.SizeOffsetX = u345.MinX / 2;
    end;
    l__Callbacks__178[{
        MinY = true
    }] = function() --[[ Line: 2161 ]]
        -- upvalues: u350 (copy), u345 (copy)
        u350.SizeOffsetY = u345.MinY / 2;
    end;
    local l__Callbacks__179 = u345.Callbacks;
    l__Callbacks__179[{
        MinX = true
    }] = function() --[[ Line: 2165 ]]
        -- upvalues: u345 (copy), u342 (copy), l__Parent__156 (copy)
        if u345.SizeX < u345.MinX then
            u342.SizeOffsetX = u345.MinX - l__Parent__156.SizeX * u342.SizeScaleX;
        end;
    end;
    l__Callbacks__179[{
        MinY = true
    }] = function() --[[ Line: 2170 ]]
        -- upvalues: u345 (copy), u342 (copy), l__Parent__156 (copy)
        if u345.SizeY < u345.MinY then
            u342.SizeOffsetY = u345.MinY - l__Parent__156.SizeY * u342.SizeScaleY;
        end;
    end;
    u345.MinX = 192;
    u345.MinY = 108;
    u345.ResizeBorder = 3;
    function u345.Think() --[[ Line: 2178 ]]
        -- upvalues: u345 (copy), u7 (ref), u359 (copy), u342 (copy), u348 (ref), u350 (copy), u349 (ref), u351 (copy), l__max__2 (ref), l__min__1 (ref)
        local l__ResizeBorder__180 = u345.ResizeBorder;
        local l__MouseX__181 = u7.MouseX;
        local l__MouseY__182 = u7.MouseY;
        u359(l__MouseX__181, l__MouseY__182);
        local v372 = l__MouseX__181 - u342.PosX;
        local v373 = l__MouseY__182 - u342.PosY;
        local l__SizeX__183 = u342.SizeX;
        local l__SizeY__184 = u342.SizeY;
        if not u348 then
            local v374;
            if u345.ResizeLeft then
                v374 = v372 / l__ResizeBorder__180;
                if v374 * v374 <= 1 then
                    u350.PosScaleX = 0;
                else
                    v374 = nil;
                end;
            else
                v374 = nil;
            end;
            local v375;
            if u345.ResizeRight then
                v375 = (v372 - l__SizeX__183) / l__ResizeBorder__180;
                if v375 * v375 <= 1 and (not v374 or v375 * v375 < v374 * v374) then
                    u350.PosScaleX = 1;
                else
                    v375 = v374;
                end;
            else
                v375 = v374;
            end;
            if v375 and (-l__ResizeBorder__180 <= v373 and v373 <= l__SizeY__184 + l__ResizeBorder__180) then
                u350.Visible = true;
                u350.PosOffsetX = (v375 - 1) / 2 * l__ResizeBorder__180;
            else
                u350.Visible = false;
            end;
        end;
        if not u349 then
            local v376;
            if u345.ResizeTop then
                v376 = v373 / l__ResizeBorder__180;
                if v376 * v376 <= 1 then
                    u351.PosScaleY = 0;
                else
                    v376 = nil;
                end;
            else
                v376 = nil;
            end;
            local v377;
            if u345.ResizeBottom then
                v377 = (v373 - l__SizeY__184) / l__ResizeBorder__180;
                if v377 * v377 <= 1 and (not v376 or v377 * v377 < v376 * v376) then
                    u351.PosScaleY = 1;
                else
                    v377 = v376;
                end;
            else
                v377 = v376;
            end;
            if v377 and (-l__ResizeBorder__180 <= v372 and v372 <= l__SizeX__183 + l__ResizeBorder__180) then
                u351.Visible = true;
                u351.PosOffsetY = (v377 - 1) / 2 * l__ResizeBorder__180;
            else
                u351.Visible = false;
            end;
        end;
        if u350.Visible then
            local v378 = u350.SizeY / 2;
            if v373 < l__ResizeBorder__180 then
                u350.PosOffsetY = (l__max__2(-1, v373 / l__ResizeBorder__180) - 1) / 2 * l__ResizeBorder__180;
            elseif v373 < v378 then
                u350.PosOffsetY = 0;
            elseif l__SizeY__184 - l__ResizeBorder__180 < v373 then
                u350.PosOffsetY = l__SizeY__184 - 2 * v378 + (l__min__1((v373 - l__SizeY__184) / l__ResizeBorder__180, 1) + 1) / 2 * l__ResizeBorder__180;
            elseif l__SizeY__184 - v378 < v373 then
                u350.PosOffsetY = l__SizeY__184 - 2 * v378;
            else
                u350.PosOffsetY = v373 - v378;
            end;
        end;
        if u351.Visible then
            local v379 = u351.SizeX / 2;
            if v372 < l__ResizeBorder__180 then
                u351.PosOffsetX = (l__max__2(-1, v372 / l__ResizeBorder__180) - 1) / 2 * l__ResizeBorder__180;
                return;
            end;
            if v372 < v379 then
                u351.PosOffsetX = 0;
                return;
            end;
            if l__SizeX__183 - l__ResizeBorder__180 < v372 then
                u351.PosOffsetX = l__SizeX__183 - 2 * v379 + (l__min__1((v372 - l__SizeX__183) / l__ResizeBorder__180, 1) + 1) / 2 * l__ResizeBorder__180;
                return;
            end;
            if l__SizeX__183 - v379 < v372 then
                u351.PosOffsetX = l__SizeX__183 - 2 * v379;
                return;
            end;
            u351.PosOffsetX = v372 - v379;
        end;
    end;
    return u345;
end;
function u7.Dropdown(p380, u381, p382, p383) --[[ Line: 2265 ]]
    -- upvalues: u171 (copy), u229 (ref), u7 (copy), u209 (copy), l__min__1 (copy), u341 (copy), u228 (copy), u16 (ref), l__floor__3 (copy), l__TextSize__19 (copy), l__max__2 (copy)
    local u384 = u171(p380);
    local l__ActualBox__185 = u384.ActualBox;
    local _ = p380 or l__ActualBox__185.Parent;
    l__ActualBox__185.RobloxClass = "Frame";
    u384.ItemChosen = p382;
    local u385 = u229(u384, p383 or "(None)");
    u385.TextAlignment = "Center";
    u385.SizeScaleX = 1;
    u385.SizeScaleY = 1;
    u385.BackgroundColor = u7.Color0;
    function u385.Fade(p386) --[[ Line: 2274 ]]
        -- upvalues: u385 (copy), u7 (ref)
        local v387 = u385;
        local l__Color0__186 = u7.Color0;
        local l__Color1__187 = u7.Color1;
        local v388 = 1 - p386;
        v387.BackgroundColor = {
            r = l__Color0__186.r * v388 + l__Color1__187.r * p386,
            g = l__Color0__186.g * v388 + l__Color1__187.g * p386,
            b = l__Color0__186.b * v388 + l__Color1__187.b * p386,
            a = l__Color0__186.a * v388 + l__Color1__187.a * p386 or 255
        };
    end;
    local u389 = u209(u384);
    u389.PosScaleX = 1;
    u389.SizeScaleY = 1;
    u389.Image = "rbxassetid://13890074";
    local u390 = u171(u384);
    local l__ActualBox__188 = u390.ActualBox;
    local _ = u384 or l__ActualBox__188.Parent;
    l__ActualBox__188.RobloxClass = "Frame";
    u390.DrawBackground = false;
    u390.Visible = false;
    u390.SizeScaleX = 1;
    u390.PosScaleY = 1;
    u390.SizeScaleY = l__min__1(10, #u381);
    function u390.MouseLeave() --[[ Line: 2288 ]]
        -- upvalues: u390 (copy)
        u390.Visible = false;
    end;
    function u384.Button1Down() --[[ Line: 2291 ]]
        -- upvalues: u390 (copy)
        u390.Visible = not u390.Visible;
    end;
    u390.Callbacks[{
        Visible = true
    }] = function() --[[ Line: 2294 ]]
        -- upvalues: u390 (copy), u389 (copy)
        if u390.Visible then
            u389.Image = "rbxassetid://13890047";
        else
            u389.Image = "rbxassetid://13890074";
        end;
    end;
    local v391 = nil;
    local u392 = u171(v391);
    local l__ActualBox__189 = u392.ActualBox;
    local _ = v391 or l__ActualBox__189.Parent;
    l__ActualBox__189.RobloxClass = "Frame";
    u392.BackgroundColor = u7.Color0;
    u392.SizeScaleX = 1;
    u341(u392, u390);
    local u393 = {};
    function u384.ChooseItem(p394) --[[ Line: 2318 ]]
        -- upvalues: u384 (copy), u385 (copy), u381 (copy)
        if p394 ~= u384.CurrentItem then
            u385.Text = u381[p394] or "Index out of Bounds";
            local l__ItemChosen__190 = u384.ItemChosen;
            if l__ItemChosen__190 then
                l__ItemChosen__190(p394);
            end;
            u384.CurrentItem = p394;
        end;
    end;
    u228(u381, function(u395, p396) --[[ Line: 2329 ]]
        -- upvalues: u229 (ref), u392 (copy), u7 (ref), u393 (copy), u384 (copy), u390 (copy)
        local u397 = u229(u392, p396);
        u397.TextAlignment = "Center";
        u397.TextSize = 12 * u7.roblox_messing_with_guis_factor;
        u393[u395] = u397;
        function u397.Fade(p398) --[[ Line: 2336 ]]
            -- upvalues: u397 (copy), u7 (ref)
            local v399 = u397;
            local l__Color0__191 = u7.Color0;
            local l__Color1__192 = u7.Color1;
            local v400 = 1 - p398;
            v399.BackgroundColor = {
                r = l__Color0__191.r * v400 + l__Color1__192.r * p398,
                g = l__Color0__191.g * v400 + l__Color1__192.g * p398,
                b = l__Color0__191.b * v400 + l__Color1__192.b * p398,
                a = l__Color0__191.a * v400 + l__Color1__192.a * p398 or 255
            };
        end;
        function u397.Button1Down() --[[ Line: 2339 ]]
            -- upvalues: u384 (ref), u395 (copy), u390 (ref)
            local l__ChooseItem__193 = u384.ChooseItem;
            if l__ChooseItem__193 then
                l__ChooseItem__193(u395);
            end;
            u390.Visible = false;
        end;
        return u397;
    end);
    function u384.Resize() --[[ Line: 2348 ]]
        -- upvalues: u384 (copy), u385 (copy), u389 (copy), u392 (copy), u381 (copy)
        local l__SizeY__194 = u384.SizeY;
        u385.SizeOffsetX = -l__SizeY__194;
        u389.SizeOffsetX = l__SizeY__194;
        u389.PosOffsetX = -l__SizeY__194;
        u392.SizeOffsetY = l__SizeY__194 * #u381;
    end;
    function u384.GetWidth() --[[ Line: 2355 ]]
        -- upvalues: u393 (copy), u16 (ref), l__floor__3 (ref), l__TextSize__19 (ref), l__max__2 (ref), u389 (copy)
        local v401 = 0;
        for v402 = 1, #u393 do
            local v403 = u393[v402];
            local v404 = l__floor__3(v403.TextSize * u16 + 0.5);
            local v405 = v404 > 100 and 100 or v404;
            v401 = l__max__2(v401, l__TextSize__19(v403.TextFont, v405 < 1 and 1 or v405, v403.Text) / u16);
        end;
        return v401 + u389.SizeX;
    end;
    return u384;
end;
function u7.FadeReveal(p406, p407) --[[ Line: 2374 ]]
    -- upvalues: u7 (copy)
    local u408 = u7.New(p406);
    u408.SizeScaleX = 1;
    u408.SizeScaleY = 1;
    u408.BackgroundColor = {
        r = 0,
        g = 0,
        b = 0,
        a = 0
    };
    u408.Visible = false;
    if p407 then
        p407.Parent = u408;
        p407.PosScaleX = 0.5;
        p407.PosScaleY = 0.5;
        p407.PosOffsetX = p407.SizeX / -2;
        p407.PosOffsetY = p407.SizeY / -2;
    end;
    function p406.Fade(p409) --[[ Line: 2387 ]]
        -- upvalues: u408 (copy)
        u408.Visible = p409 > 0;
        u408.BackgroundColor = {
            r = 0,
            g = 0,
            b = 0,
            a = 96 * p409 or 255
        };
    end;
    return p406;
end;
function u7.Rating(p410, p411) --[[ Line: 2395 ]]
    -- upvalues: u171 (copy), u209 (copy), l__floor__3 (copy)
    local v412 = p411 or 0;
    local u413 = u171(p410);
    local l__ActualBox__195 = u413.ActualBox;
    local _ = p410 or l__ActualBox__195.Parent;
    l__ActualBox__195.RobloxClass = "Frame";
    u413.DrawBackground = false;
    u413.Rating = v412;
    u413.DisplayRating = v412;
    u413.AllowRating = true;
    for v414 = 0, 4 do
        local v415 = u209(u413);
        v415.DrawBackground = false;
        v415.SizeScaleX = 0.2;
        v415.SizeScaleY = 1;
        v415.PosScaleX = v414 / 5;
        if v412 <= v414 * 2 then
            v415.Image = "rbxassetid://36997775";
        elseif v412 <= v414 * 2 + 1 then
            v415.Image = "rbxassetid://36997768";
        else
            v415.Image = "rbxassetid://36997759";
        end;
        u413[v414] = v415;
    end;
    local l__Callbacks__196 = u413.Callbacks;
    l__Callbacks__196[{
        DisplayRating = true
    }] = function() --[[ Line: 2418 ]]
        -- upvalues: u413 (copy)
        local l__DisplayRating__197 = u413.DisplayRating;
        for v416 = 0, 4 do
            local v417 = u413[v416];
            if v417 then
                if l__DisplayRating__197 <= v416 * 2 then
                    v417.Image = "rbxassetid://36997775";
                elseif l__DisplayRating__197 <= v416 * 2 + 1 then
                    v417.Image = "rbxassetid://36997768";
                else
                    v417.Image = "rbxassetid://36997759";
                end;
            end;
        end;
    end;
    l__Callbacks__196[{
        Rating = true
    }] = function() --[[ Line: 2433 ]]
        -- upvalues: u413 (copy)
        u413.DisplayRating = u413.Rating;
    end;
    l__Callbacks__196[{
        AllowRating = true
    }] = function() --[[ Line: 2436 ]]
        -- upvalues: u413 (copy), l__floor__3 (ref)
        if u413.AllowRating and u413.Hovering then
            u413.DisplayRating = l__floor__3(10 * u413.MouseX / u413.SizeX + 0.5);
        else
            u413.DisplayRating = u413.Rating;
        end;
    end;
    function u413.Button1Down(p418) --[[ Line: 2443 ]]
        -- upvalues: u413 (copy), l__floor__3 (ref)
        if u413.AllowRating then
            local v419 = l__floor__3(10 * p418 / u413.SizeX + 0.5);
            u413.Rating = v419;
            local l__Rated__198 = u413.Rated;
            if l__Rated__198 then
                l__Rated__198(v419);
            end;
        end;
    end;
    function u413.MouseLeave() --[[ Line: 2453 ]]
        -- upvalues: u413 (copy)
        u413.DisplayRating = u413.Rating;
    end;
    function u413.MouseMoved() --[[ Line: 2456 ]]
        -- upvalues: u413 (copy), l__floor__3 (ref)
        if u413.AllowRating then
            u413.DisplayRating = l__floor__3(10 * u413.MouseX / u413.SizeX + 0.5);
        end;
    end;
    return u413;
end;
return u7;
