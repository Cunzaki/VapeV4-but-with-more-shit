-- Decompiled from: MapRating
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local u1 = next;
local l__obtain__1 = _G.obtain;
local v2 = l__obtain__1("QBox");
local l__FreeMouse__2 = v2.FreeMouse;
local v3 = l__obtain__1("Tween");
local u4 = l__obtain__1("Remote");
local v5 = l__obtain__1("Command");
local u6 = l__obtain__1("MapManager");
local u7 = v2.New();
u7.Visible = false;
u7.DrawBackground = false;
u7.SizeOffsetX = 400;
u7.SizeOffsetY = 610;
u7.PosScaleX = 0.5;
u7.PosScaleY = 1;
local u8 = false;
local u10 = v3.New(0, function(p9) --[[ Line: 23 ]]
    -- upvalues: u8 (ref), u7 (copy)
    u8 = true;
    u7.PosOffsetY = p9;
    u8 = false;
end);
u10.MaxAcceleration = v3.MaxAcceleration(0, u7.SizeY, 0, 0, 1);
u7.Callbacks[{
    PosOffsetY = true
}] = function() --[[ Line: 29 ]]
    -- upvalues: u8 (ref), u10 (copy), u7 (copy)
    if not u8 then
        u10.x1 = u7.PosOffsetY;
    end;
end;
function u7.Resize() --[[ Line: 35 ]]
    -- upvalues: u7 (copy), u10 (copy)
    u7.PosOffsetX = u7.SizeX / -2;
    u7.PosOffsetY = u10:Value();
end;
local v11 = v2.TextBox(u7, "RATING NOT WORKING");
v11.TextSize = 12 * v2.roblox_messing_with_guis_factor;
v11.TextAlignment = "Center";
v11.BackgroundColor = v2.Color2;
v11.SizeScaleX = 1;
v11.SizeOffsetX = -40;
v11.SizeOffsetY = 40;
v2.DragBar(v11, u7);
local v12 = v2.TextBox(u7, "x");
v12.TextSize = 12 * v2.roblox_messing_with_guis_factor;
v12.TextAlignment = "Center";
v12.SizeOffsetX = 40;
v12.SizeOffsetY = 40;
v12.PosOffsetX = -40;
v12.PosScaleX = 1;
local v13 = v2.New(u7);
v13.SizeScaleX = 1;
v13.SizeScaleY = 1;
v13.SizeOffsetY = -40;
v13.PosOffsetY = 40;
local v14 = 15;
local v15 = v2.TextBox(v13);
v15.DrawBackground = false;
v15.PosOffsetY = v14;
v15.SizeScaleX = 1;
v15.SizeOffsetY = 30;
v15.Text = "Fun";
local v16 = v14 + v15.SizeY + 15;
local u17 = v2.Rating(v13);
u17.AllowRating = false;
u17.PosScaleX = 0.5;
u17.PosOffsetY = v16;
u17.SizeOffsetX = 350;
u17.SizeOffsetY = 70;
u17.PosOffsetX = u17.SizeX / -2;
local v18 = v2.TextBox(v13);
v18.DrawBackground = false;
v18.PosOffsetX = -22.5;
v18.PosOffsetY = v16 + u17.SizeY / 2;
v18.SizeOffsetX = 70;
v18.SizeOffsetY = 25;
v18.Rotation = 1.5707963267948966;
v18.Text = "Boring";
local v19 = v2.TextBox(v13);
v19.DrawBackground = false;
v19.PosScaleX = 1;
v19.PosOffsetX = -47.5;
v19.PosOffsetY = v16 + u17.SizeY / 2;
v19.SizeOffsetX = 70;
v19.SizeOffsetY = 25;
v19.Rotation = -1.5707963267948966;
v19.Text = "Fun";
local v20 = v16 + u17.SizeY + 30;
local v21 = v2.TextBox(v13);
v21.DrawBackground = false;
v21.PosOffsetY = v20;
v21.SizeScaleX = 1;
v21.SizeOffsetY = 30;
v21.Text = "Quality";
local v22 = v20 + v21.SizeY + 15;
local u23 = v2.Rating(v13);
u23.AllowRating = false;
u23.PosScaleX = 0.5;
u23.PosOffsetY = v22;
u23.SizeOffsetX = 350;
u23.SizeOffsetY = 70;
u23.PosOffsetX = u23.SizeX / -2;
local v24 = v2.TextBox(v13);
v24.DrawBackground = false;
v24.PosOffsetX = -22.5;
v24.PosOffsetY = v22 + u23.SizeY / 2;
v24.SizeOffsetX = 70;
v24.SizeOffsetY = 25;
v24.Rotation = 1.5707963267948966;
v24.Text = "Poor";
local v25 = v2.TextBox(v13);
v25.DrawBackground = false;
v25.PosScaleX = 1;
v25.PosOffsetX = -47.5;
v25.PosOffsetY = v22 + u23.SizeY / 2;
v25.SizeOffsetX = 70;
v25.SizeOffsetY = 25;
v25.Rotation = -1.5707963267948966;
v25.Text = "Good";
local v26 = v22 + u23.SizeY + 30;
local v27 = v2.TextBox(v13);
v27.DrawBackground = false;
v27.PosOffsetY = v26;
v27.SizeScaleX = 1;
v27.SizeOffsetY = 30;
v27.Text = "Difficulty";
local v28 = v26 + v27.SizeY + 15;
local u29 = v2.Rating(v13);
u29.AllowRating = false;
u29.PosScaleX = 0.5;
u29.PosOffsetY = v28;
u29.SizeOffsetX = 350;
u29.SizeOffsetY = 70;
u29.PosOffsetX = u29.SizeX / -2;
local v30 = v2.TextBox(v13);
v30.DrawBackground = false;
v30.PosOffsetX = -22.5;
v30.PosOffsetY = v28 + u29.SizeY / 2;
v30.SizeOffsetX = 70;
v30.SizeOffsetY = 25;
v30.Rotation = 1.5707963267948966;
v30.Text = "Easy";
local v31 = v2.TextBox(v13);
v31.DrawBackground = false;
v31.PosScaleX = 1;
v31.PosOffsetX = -47.5;
v31.PosOffsetY = v28 + u29.SizeY / 2;
v31.SizeOffsetX = 70;
v31.SizeOffsetY = 25;
v31.Rotation = -1.5707963267948966;
v31.Text = "Hard";
local v32 = v28 + u29.SizeY + 30;
local v33 = v2.TextBox(v13);
v33.DrawBackground = false;
v33.PosOffsetY = v32;
v33.SizeScaleX = 1;
v33.SizeOffsetY = 30;
v33.Text = "Length";
local v34 = v32 + v33.SizeY + 15;
local u35 = v2.Rating(v13);
u35.AllowRating = false;
u35.PosScaleX = 0.5;
u35.PosOffsetY = v34;
u35.SizeOffsetX = 350;
u35.SizeOffsetY = 70;
u35.PosOffsetX = u35.SizeX / -2;
local v36 = v2.TextBox(v13);
v36.DrawBackground = false;
v36.PosOffsetX = -22.5;
v36.PosOffsetY = v34 + u35.SizeY / 2;
v36.SizeOffsetX = 70;
v36.SizeOffsetY = 25;
v36.Rotation = 1.5707963267948966;
v36.Text = "Short";
local v37 = v2.TextBox(v13);
v37.DrawBackground = false;
v37.PosScaleX = 1;
v37.PosOffsetX = -47.5;
v37.PosOffsetY = v34 + u35.SizeY / 2;
v37.SizeOffsetX = 70;
v37.SizeOffsetY = 25;
v37.Rotation = -1.5707963267948966;
v37.Text = "Long";
local _ = v34 + u35.SizeY + 15;
local u38 = nil;
local u39 = nil;
local u40 = nil;
local u41 = nil;
function u17.Rated(p42) --[[ Line: 217 ]]
    -- upvalues: u38 (ref)
    u38 = p42;
end;
function u23.Rated(p43) --[[ Line: 221 ]]
    -- upvalues: u39 (ref)
    u39 = p43;
end;
function u29.Rated(p44) --[[ Line: 225 ]]
    -- upvalues: u40 (ref)
    u40 = p44;
end;
function u35.Rated(p45) --[[ Line: 229 ]]
    -- upvalues: u41 (ref)
    u41 = p45;
end;
u4.Add("AllowRating", function(p46) --[[ Line: 233 ]]
    -- upvalues: u17 (copy), u23 (copy), u29 (copy), u35 (copy)
    u17.AllowRating = p46;
    u23.AllowRating = p46;
    u29.AllowRating = p46;
    u35.AllowRating = p46;
end);
u4.Add("SetPlayerRatings", function(p47) --[[ Line: 240 ]]
    -- upvalues: u17 (copy), u23 (copy), u29 (copy), u35 (copy)
    if p47 then
        u17.Rating = p47.Fun or 0;
        u23.Rating = p47.Quality or 0;
        u29.Rating = p47.Difficulty or 0;
        u35.Rating = p47.Length or 0;
    end;
end);
local u48 = nil;
local u49 = false;
local function u51() --[[ Line: 253 ]]
    -- upvalues: u49 (ref), l__FreeMouse__2 (copy), u10 (copy), u7 (copy), u48 (ref), u38 (ref), u39 (ref), u40 (ref), u41 (ref), u1 (copy), u4 (copy)
    u49 = false;
    l__FreeMouse__2("Rating", false);
    u10:Target(0, function() --[[ Line: 256 ]]
        -- upvalues: u7 (ref)
        u7.Visible = false;
    end);
    if u48 then
        local v50 = {};
        if u38 then
            v50.Fun = u38;
        end;
        if u39 then
            v50.Quality = u39;
        end;
        if u40 then
            v50.Difficulty = u40;
        end;
        if u41 then
            v50.Length = u41;
        end;
        u38 = nil;
        u39 = nil;
        u40 = nil;
        u41 = nil;
        if u1(v50) then
            u4.Call("SendRatings", u48, v50);
        end;
        u48 = nil;
    end;
end;
v12.Button1Down = u51;
u4.Add("OpenRating", function() --[[ Name: Open, Line 283 ]]
    -- upvalues: u49 (ref), l__FreeMouse__2 (copy), u7 (copy), u10 (copy), u48 (ref), u6 (copy)
    u49 = true;
    l__FreeMouse__2("Rating", true);
    u7.Visible = true;
    u10:Target(-u7.Parent.SizeY / 2 - u7.SizeY / 2);
    u48 = u6.MapInfo.Id;
end);
v5.Add("rate", {}, function() --[[ Line: 293 ]]
    -- upvalues: u49 (ref), u51 (copy), l__FreeMouse__2 (copy), u7 (copy), u10 (copy), u48 (ref), u6 (copy)
    if u49 then
        u51();
    else
        u49 = true;
        l__FreeMouse__2("Rating", true);
        u7.Visible = true;
        u10:Target(-u7.Parent.SizeY / 2 - u7.SizeY / 2);
        u48 = u6.MapInfo.Id;
    end;
end);
return true;
