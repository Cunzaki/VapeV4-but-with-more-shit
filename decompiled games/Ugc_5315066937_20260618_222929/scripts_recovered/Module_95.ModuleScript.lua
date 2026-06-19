-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("QBox");
local l__FreeMouse__2 = u1.FreeMouse;
local l__ColourLerp__3 = u1.ColourLerp;
local l__ResizeToText__4 = u1.ResizeToText;
local u2 = l__obtain__1("Tween");
local u3 = l__obtain__1("Remote");
local l__MapFromId__5 = l__obtain__1("MapLists").MapFromId;
local l__new__6 = Vector2.new;
local u4 = false;
local l__Color1__7 = u1.Color1;
local l__Color2__8 = u1.Color2;
local u5 = u1.New();
u5.DrawBackground = false;
u5.Visible = false;
u5.SizeOffsetX = 350;
u5.SizeOffsetY = 250;
u5.PosScaleX = 0.5;
u5.PosOffsetX = u5.SizeX / -2;
u5.PosOffsetY = -u5.SizeY;
local u6 = nil;
local u7 = false;
local u9 = u2.New(u5.PosY, function(p8) --[[ Line: 37 ]]
    -- upvalues: u7 (ref), u5 (copy)
    u7 = true;
    u5.PosOffsetY = p8;
    u7 = false;
end);
spawn(function() --[[ Line: 42 ]]
    -- upvalues: u1 (copy), u9 (copy), u2 (copy)
    while not u1.SizeY do
        wait();
    end;
    u9.MaxAcceleration = u2.MaxAcceleration(0, u1.SizeY, 0, 0, 0.5);
end);
function u5.Moved() --[[ Line: 47 ]]
    -- upvalues: u9 (copy), u5 (copy)
    if not u9.Tweening then
        u9.x1 = u5.PosOffsetY;
    end;
end;
local function v10() --[[ Line: 53 ]]
    -- upvalues: u4 (ref), l__FreeMouse__2 (copy), u9 (copy), u5 (copy)
    u4 = false;
    l__FreeMouse__2("ConfirmDeletion", false);
    u9:Target(-u5.SizeY / 2, function() --[[ Line: 56 ]]
        -- upvalues: u5 (ref)
        u5.Visible = false;
    end);
end;
local v11 = u1.TextBox(u5, "Confirm Time Deletion");
v11.SizeScaleX = 1;
v11.SizeOffsetX = -30;
v11.SizeOffsetY = 30;
u1.DragBar(v11, u5);
local u12 = u1.TextBox(u5, "x");
u12.PosOffsetX = -30;
u12.PosScaleX = 1;
u12.SizeOffsetX = 30;
u12.SizeOffsetY = 30;
u12.Button1Down = v10;
function u12.Fade(p13) --[[ Line: 83 ]]
    -- upvalues: u12 (copy), l__ColourLerp__3 (copy), l__Color1__7 (copy), l__Color2__8 (copy)
    u12.BackgroundColor = l__ColourLerp__3(l__Color1__7, l__Color2__8, p13);
end;
local v14 = u1.New(u5);
v14.BackgroundColor = u1.Color0;
v14.PosOffsetY = 30;
v14.SizeScaleX = 1;
v14.SizeScaleY = 1;
v14.SizeOffsetY = -60;
local u15 = u1.TextBox(nil, "I\'d be asking you to confirm a deletion right about now");
u15.BackgroundColor = u1.Color0;
u15.SizeScaleX = 1;
u15.SizeOffsetY = 140;
u15.TextWraps = true;
u15.TextAlignment = "TopLeft";
function u15.TextResize() --[[ Line: 102 ]]
    -- upvalues: l__ResizeToText__4 (copy), u15 (copy), l__new__6 (copy)
    l__ResizeToText__4(u15, l__new__6(u15.SizeX, (1 / 0)), true);
end;
u1.Scroll(u15, v14);
local u16 = u1.TextBox(u5, "No");
u16.PosScaleY = 1;
u16.PosOffsetY = -30;
u16.SizeScaleX = 0.5;
u16.SizeOffsetY = 30;
u16.Button1Down = v10;
function u16.Fade(p17) --[[ Line: 115 ]]
    -- upvalues: u16 (copy), l__ColourLerp__3 (copy), l__Color1__7 (copy), l__Color2__8 (copy)
    u16.BackgroundColor = l__ColourLerp__3(l__Color1__7, l__Color2__8, p17);
end;
local u18 = u1.TextBox(u5, "Yes");
u18.PosScaleX = 0.5;
u18.PosScaleY = 1;
u18.PosOffsetY = -30;
u18.SizeScaleX = 0.5;
u18.SizeOffsetY = 30;
function u18.Button1Down() --[[ Line: 126 ]]
    -- upvalues: u6 (ref), u3 (copy), u4 (ref), l__FreeMouse__2 (copy), u9 (copy), u5 (copy)
    if u6 then
        u3.Call("DeleteTime", u6);
        u6 = nil;
        u4 = false;
        l__FreeMouse__2("ConfirmDeletion", false);
        u9:Target(-u5.SizeY / 2, function() --[[ Line: 56 ]]
            -- upvalues: u5 (ref)
            u5.Visible = false;
        end);
    end;
end;
function u18.Fade(p19) --[[ Line: 133 ]]
    -- upvalues: u18 (copy), l__ColourLerp__3 (copy), l__Color1__7 (copy), l__Color2__8 (copy)
    u18.BackgroundColor = l__ColourLerp__3(l__Color1__7, l__Color2__8, p19);
end;
return function(p20) --[[ Line: 137 ]]
    -- upvalues: l__MapFromId__5 (copy), u15 (copy), u6 (ref), u4 (ref), l__FreeMouse__2 (copy), u5 (copy), u9 (copy), u1 (copy)
    if p20 and p20.ID then
        local v21 = l__MapFromId__5[p20.Map];
        u15.Text = "Are you sure you want to delete " .. p20.Name .. "\'s time on " .. (p20.DisplayName or (v21 and v21.DisplayName or "<Map " .. p20.Map .. ">")) .. "? (ID: " .. p20.ID .. ")";
        u6 = p20.ID;
        u4 = true;
        l__FreeMouse__2("ConfirmDeletion", true);
        u5.Visible = true;
        u9:Target(u1.SizeY / 2 - u5.SizeY / 2);
    end;
end;
