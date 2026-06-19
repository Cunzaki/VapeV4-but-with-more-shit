-- Decompiled from: OldShowKeys
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("QBox");
local l__Color__2 = v1.Color;
local v2 = l__obtain__1("Command");
local u3 = l__obtain__1("View");
local l__GetControlState__3 = l__obtain__1("GameControl").GetControlState;
local l__Color2__4 = v1.Color2;
local u4 = l__Color__2(90, 200, 95, 255);
local u5 = l__Color__2(210, 95, 95, 255);
local u6 = 0;
local u7 = v1.New();
u7.Visible = false;
u7.PosScaleX = 1;
u7.PosScaleY = 1;
u7.SizeScaleX = 0.2;
u7.SizeScaleY = 0.2;
u7.BackgroundColor = v1.Color1;
function u7.Resize() --[[ Line: 26 ]]
    -- upvalues: u7 (copy)
    u7.PosOffsetY = -u7.SizeY - 10;
    u7.PosOffsetX = -u7.SizeX - 10;
end;
local u8 = v1.TextBox(u7, "A");
u8.TextAlignment = "Center";
u8.BackgroundColor = l__Color2__4;
u8.TextColor = l__Color__2(255, 255, 255, 255);
u8.PosScaleX = 0;
u8.PosScaleY = 0;
u8.SizeScaleX = 0.5;
u8.SizeScaleY = 0.5;
local u9 = v1.TextBox(u7, "D");
u9.TextAlignment = "Center";
u9.BackgroundColor = l__Color2__4;
u9.TextColor = l__Color__2(255, 255, 255, 255);
u9.PosScaleX = 0.5;
u9.PosScaleY = 0;
u9.SizeScaleX = 0.5;
u9.SizeScaleY = 0.5;
local u10 = v1.TextBox(u7, "LEFT");
u10.TextAlignment = "Center";
u10.BackgroundColor = l__Color2__4;
u10.TextColor = l__Color__2(255, 255, 255, 255);
u10.PosScaleX = 0;
u10.PosScaleY = 0.5;
u10.SizeScaleX = 0.5;
u10.SizeScaleY = 0.5;
local u11 = v1.TextBox(u7, "RIGHT");
u11.TextAlignment = "Center";
u11.BackgroundColor = l__Color2__4;
u11.TextColor = l__Color__2(255, 255, 255, 255);
u11.PosScaleX = 0.5;
u11.PosScaleY = 0.5;
u11.SizeScaleX = 0.5;
u11.SizeScaleY = 0.5;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
u3.OutputSignal:Add(function(_, _, p16, _, _, _) --[[ Line: 76 ]]
    -- upvalues: u3 (copy), l__GetControlState__3 (copy), u6 (ref), u8 (copy), l__Color2__4 (copy), u9 (copy), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u5 (copy), u4 (copy), u10 (copy), u11 (copy)
    local l__PlaybackContext__5 = u3.PlaybackContext;
    if l__PlaybackContext__5 then
        local _, v17, _, _ = l__PlaybackContext__5.Context:GetInput();
        if v17 then
            local l__y__6 = p16.y;
            local v18 = l__GetControlState__3(v17, "MoveLeft");
            local v19 = l__GetControlState__3(v17, "MoveRight");
            local v20 = nil;
            if u6 < l__y__6 then
                v20 = true;
            elseif l__y__6 < u6 then
                v20 = false;
            end;
            local v21 = nil;
            if v18 and not v19 then
                v21 = true;
            elseif v19 and not v18 then
                v21 = false;
            else
                u8.BackgroundColor = l__Color2__4;
                u9.BackgroundColor = l__Color2__4;
            end;
            local v22 = nil;
            local v23 = nil;
            if v20 ~= u12 then
                u12 = v20;
                v22 = v20 ~= nil and true or v22;
            end;
            if v21 ~= u13 then
                u13 = v21;
                v23 = v21 ~= nil and true or v23;
            end;
            if v22 and v20 ~= u13 then
                if v20 then
                    u14 = true;
                else
                    u15 = true;
                end;
            end;
            if v23 and v21 ~= u12 then
                if v21 then
                    u14 = false;
                else
                    u15 = false;
                end;
            end;
            if v22 or v23 then
                if u13 == true then
                    u8.BackgroundColor = u14 and u5 or u4;
                    u9.BackgroundColor = l__Color2__4;
                elseif u13 == false then
                    u9.BackgroundColor = u15 and u5 or u4;
                    u8.BackgroundColor = l__Color2__4;
                end;
                if u12 == true then
                    u10.BackgroundColor = u14 and u4 or u5;
                    u11.BackgroundColor = l__Color2__4;
                elseif u12 == false then
                    u11.BackgroundColor = u15 and u4 or u5;
                    u10.BackgroundColor = l__Color2__4;
                end;
            elseif v21 == nil and v20 == nil then
                u10.BackgroundColor = l__Color2__4;
                u11.BackgroundColor = l__Color2__4;
            end;
            u6 = l__y__6;
        end;
    end;
end);
v2.Add({ "oldshowkeys", "osk" }, { "Boolean" }, function(p24) --[[ Name: SetVisible, Line 154 ]]
    -- upvalues: u7 (copy)
    u7.Visible = p24;
end);
v2.Add({ "oldshowkeys", "osk" }, {}, function() --[[ Line: 159 ]]
    -- upvalues: u7 (copy)
    u7.Visible = not u7.Visible;
end);
return true;
