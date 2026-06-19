-- Decompiled from: ShowKeys
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local l__band__2 = bit32.band;
local v1 = l__obtain__1("QBox");
local l__Color__3 = v1.Color;
local v2 = l__obtain__1("Command");
local u3 = l__obtain__1("View");
local l__TICKINFO_BIT_STRAFE__4 = l__obtain__1("CustomEnums").TICKINFO_BIT_STRAFE;
local l__GetControlState__5 = l__obtain__1("GameControl").GetControlState;
local l__Color2__6 = v1.Color2;
local u4 = l__Color__3(90, 200, 95, 255);
local u5 = l__Color__3(210, 95, 95, 255);
local u6 = l__Color__3(255, 255, 255, 255);
local u7 = 0;
local v8 = Instance.new("Model", workspace);
v8.Name = "ShowKeySounds";
local u9 = Instance.new("Sound", v8);
u9.SoundId = "rbxassetid://6207754327";
u9.Looped = true;
local u10 = Instance.new("Sound", v8);
u10.SoundId = "rbxassetid://6207754886";
u10.Looped = true;
local u11 = Instance.new("Sound", v8);
u11.SoundId = "rbxassetid://6207755570";
u11.Looped = true;
local u12 = Instance.new("Sound", v8);
u12.SoundId = "rbxassetid://6207758299";
u12.Looped = true;
local u13 = v1.New();
u13.Visible = false;
u13.PosScaleX = 1;
u13.PosScaleY = 1;
u13.SizeOffsetX = 370;
u13.SizeOffsetY = 190;
u13.DrawBackground = false;
function u13.Resize() --[[ Line: 48 ]]
    -- upvalues: u13 (copy)
    u13.PosOffsetY = -u13.SizeY - 10;
    u13.PosOffsetX = -u13.SizeX - 10;
end;
v1.DragBar(u13, u13);
local u14 = v1.TextBox(u13, "⬆️");
u14.TextAlignment = "Center";
u14.BackgroundColor = l__Color2__6;
u14.TextColor = u6;
u14.PosOffsetX = 70;
u14.PosOffsetY = 10;
u14.SizeOffsetX = 50;
u14.SizeOffsetY = 50;
local u15 = v1.TextBox(u13, "⬅️");
u15.TextAlignment = "Center";
u15.BackgroundColor = l__Color2__6;
u15.TextColor = u6;
u15.PosOffsetX = 10;
u15.PosOffsetY = 70;
u15.SizeOffsetX = 50;
u15.SizeOffsetY = 50;
local u16 = v1.TextBox(u13, "⬇️");
u16.TextAlignment = "Center";
u16.BackgroundColor = l__Color2__6;
u16.TextColor = u6;
u16.PosOffsetX = 70;
u16.PosOffsetY = 70;
u16.SizeOffsetX = 50;
u16.SizeOffsetY = 50;
local u17 = v1.TextBox(u13, "➡️");
u17.TextAlignment = "Center";
u17.BackgroundColor = l__Color2__6;
u17.TextColor = u6;
u17.PosOffsetX = 130;
u17.PosOffsetY = 70;
u17.SizeOffsetX = 50;
u17.SizeOffsetY = 50;
local u18 = v1.TextBox(u13, "DOWN");
u18.TextAlignment = "Center";
u18.BackgroundColor = l__Color2__6;
u18.TextColor = u6;
u18.PosOffsetX = 10;
u18.PosOffsetY = 10;
u18.SizeOffsetX = 50;
u18.SizeOffsetY = 50;
local u19 = v1.TextBox(u13, "UP");
u19.TextAlignment = "Center";
u19.BackgroundColor = l__Color2__6;
u19.TextColor = u6;
u19.PosOffsetX = 130;
u19.PosOffsetY = 10;
u19.SizeOffsetX = 50;
u19.SizeOffsetY = 50;
local u20 = v1.Image(u13, "rbxassetid://5109003044");
u20.DrawBackground = false;
u20.PosOffsetX = 190;
u20.PosOffsetY = 10;
u20.SizeOffsetX = 170;
u20.SizeOffsetY = 170;
local u21 = v1.Image(u13, "rbxassetid://409518502");
u21.DrawBackground = false;
u21.PosOffsetX = 190;
u21.PosOffsetY = 70;
u21.SizeOffsetX = 50;
u21.SizeOffsetY = 50;
local u22 = v1.Image(u13, "rbxassetid://409518552");
u22.DrawBackground = false;
u22.PosOffsetX = 310;
u22.PosOffsetY = 70;
u22.SizeOffsetX = 50;
u22.SizeOffsetY = 50;
local u23 = v1.TextBox(u13, "JUMP");
u23.TextAlignment = "Center";
u23.BackgroundColor = l__Color2__6;
u23.TextColor = u6;
u23.PosOffsetX = 10;
u23.PosOffsetY = 130;
u23.SizeOffsetX = 170;
u23.SizeOffsetY = 50;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local u27 = nil;
local u28 = nil;
local u29 = nil;
local u30 = nil;
local u31 = false;
local u32 = 0;
v2.Add({ "showkeysmode", "skm" }, { "Integer" }, function(p33) --[[ Line: 163 ]]
    -- upvalues: u32 (ref)
    u32 = p33;
end);
game:GetService("RunService").Heartbeat:connect(function() --[[ Line: 167 ]]
    -- upvalues: u31 (ref), u13 (copy), u3 (copy), u32 (ref), l__TICKINFO_BIT_STRAFE__4 (copy), l__band__2 (copy), u14 (copy), u15 (copy), u16 (copy), u17 (copy), u18 (copy), u19 (copy), u23 (copy), u26 (ref), u7 (ref), l__GetControlState__5 (copy), l__Color2__6 (copy), u25 (ref), u29 (ref), u9 (copy), u30 (ref), u10 (copy), u24 (ref), u11 (copy), u12 (copy), u27 (ref), u28 (ref), u4 (copy), u5 (copy), u21 (copy), u22 (copy), u6 (copy)
    local v34 = (u31 or u13.Visible) and u3.PlaybackContext;
    if v34 then
        local l__Context__7 = v34.Context;
        local l__StyleInfo__8 = v34.StyleInfo;
        if l__StyleInfo__8 then
            local _, v35, _, _, _, _ = l__Context__7:GetOutput();
            if v35 then
                local v36 = u32 == 1 and true or l__band__2(v35, l__TICKINFO_BIT_STRAFE__4) ~= l__TICKINFO_BIT_STRAFE__4;
                local l__keys__9 = l__StyleInfo__8.keys;
                local v37 = u14;
                local v38 = not v36 and l__keys__9.w;
                if v38 then
                    v38 = l__keys__9.w ~= 0;
                end;
                v37.Visible = v38;
                local v39 = u15;
                local v40 = not v36 and l__keys__9.a;
                if v40 then
                    v40 = l__keys__9.a ~= 0;
                end;
                v39.Visible = v40;
                local v41 = u16;
                local v42 = not v36 and l__keys__9.s;
                if v42 then
                    v42 = l__keys__9.s ~= 0;
                end;
                v41.Visible = v42;
                local v43 = u17;
                local v44 = not v36 and l__keys__9.d;
                if v44 then
                    v44 = l__keys__9.d ~= 0;
                end;
                v43.Visible = v44;
                local v45 = u18;
                local v46 = not v36 and l__keys__9.q;
                if v46 then
                    v46 = l__keys__9.q ~= 0;
                end;
                v45.Visible = v46;
                local v47 = u19;
                local v48 = not v36 and l__keys__9.e;
                if v48 then
                    v48 = l__keys__9.e ~= 0;
                end;
                v47.Visible = v48;
                u23.Visible = l__StyleInfo__8.allow_jump;
            end;
        end;
        local v49, v50, v51, _ = l__Context__7:GetInput();
        if v49 and (v50 and (v51 and v49 ~= u26)) then
            local l__x__10 = v51.x;
            local v52 = nil;
            if l__x__10 < u7 then
                v52 = true;
            elseif u7 < l__x__10 then
                v52 = false;
            end;
            local v53 = l__GetControlState__5(v50, "MoveForward");
            local v54 = l__GetControlState__5(v50, "MoveLeft");
            local v55 = l__GetControlState__5(v50, "MoveBack");
            local v56 = l__GetControlState__5(v50, "MoveRight");
            local v57 = nil;
            local v58 = nil;
            if v54 and not v56 then
                v57 = true;
            elseif v56 and not v54 then
                v57 = false;
            elseif u13.Visible then
                u15.BackgroundColor = l__Color2__6;
                u17.BackgroundColor = l__Color2__6;
            end;
            if v57 ~= u25 then
                u25 = v57;
                v58 = v57 ~= nil and true or v58;
            end;
            if u31 then
                if v54 ~= u29 then
                    if v54 then
                        u9.TimePosition = 1;
                        u9:Play();
                    end;
                    if u29 == true then
                        u9:Stop();
                    end;
                    u29 = v54;
                end;
                if v56 ~= u30 then
                    if v56 then
                        u10.TimePosition = 1;
                        u10:Play();
                    end;
                    if u30 == true then
                        u10:Stop();
                    end;
                    u30 = v56;
                end;
            end;
            local v59 = nil;
            if v52 ~= u24 then
                if u31 then
                    if u24 == true then
                        u11:Stop();
                    elseif u24 == false then
                        u12:Stop();
                    end;
                    if v52 == true then
                        u11.TimePosition = 1;
                        u11:Play();
                    elseif v52 == false then
                        u12.TimePosition = 1;
                        u12:Play();
                    end;
                end;
                u24 = v52;
                v59 = v52 ~= nil and true or v59;
            end;
            if v59 and v52 ~= u25 then
                if v52 then
                    u27 = true;
                else
                    u28 = true;
                end;
            end;
            if v58 and v57 ~= u24 then
                if v57 then
                    u27 = false;
                else
                    u28 = false;
                end;
            end;
            if u13.Visible then
                u14.BackgroundColor = v53 and u4 or l__Color2__6;
                u16.BackgroundColor = v55 and u4 or l__Color2__6;
                u18.BackgroundColor = l__GetControlState__5(v50, "MoveDown") and u4 or l__Color2__6;
                u19.BackgroundColor = l__GetControlState__5(v50, "MoveUp") and u4 or l__Color2__6;
                u23.BackgroundColor = l__GetControlState__5(v50, "Jump") and u4 or l__Color2__6;
                if v59 or v58 then
                    if u25 == true then
                        u15.BackgroundColor = u27 and u5 or u4;
                        u17.BackgroundColor = l__Color2__6;
                    elseif u25 == false then
                        u17.BackgroundColor = u28 and u5 or u4;
                        u15.BackgroundColor = l__Color2__6;
                    end;
                    if u24 == true then
                        u21.ImageColor = u27 and u4 or u5;
                        u22.ImageColor = u6;
                    elseif u24 == false then
                        u22.ImageColor = u28 and u4 or u5;
                        u21.ImageColor = u6;
                    end;
                elseif v57 == nil and v52 == nil then
                    u21.ImageColor = u6;
                    u22.ImageColor = u6;
                end;
                if v54 == v56 then
                    u15.BackgroundColor = v54 and u4 or l__Color2__6;
                    u17.BackgroundColor = v56 and u4 or l__Color2__6;
                end;
            end;
            u7 = l__x__10;
            u26 = v49;
        end;
    end;
end);
v2.Add({ "showkeys", "sk", "showkeis" }, { "Boolean" }, function(p60) --[[ Line: 319 ]]
    -- upvalues: u13 (copy)
    u13.Visible = p60;
end);
v2.Add({ "showkeys", "sk", "showkeis" }, {}, function() --[[ Line: 322 ]]
    -- upvalues: u13 (copy)
    u13.Visible = not u13.Visible;
end);
v2.Add({ "keysounds", "ks" }, { "Boolean" }, function(p61) --[[ Line: 334 ]]
    -- upvalues: u31 (ref), u29 (ref), u30 (ref), u9 (copy), u10 (copy), u11 (copy), u12 (copy)
    u31 = p61;
    if not u31 then
        u29 = nil;
        u30 = nil;
        u9:Stop();
        u10:Stop();
        u11:Stop();
        u12:Stop();
    end;
end);
v2.Add({ "keysounds", "ks" }, {}, function() --[[ Line: 340 ]]
    -- upvalues: u31 (ref), u29 (ref), u30 (ref), u9 (copy), u10 (copy), u11 (copy), u12 (copy)
    u31 = not u31;
    if not u31 then
        u29 = nil;
        u30 = nil;
        u9:Stop();
        u10:Stop();
        u11:Stop();
        u12:Stop();
    end;
end);
v2.Add("setmouseimage", { "Integer" }, function(p62) --[[ Line: 347 ]]
    -- upvalues: u20 (copy)
    u20.Image = "rbxassetid://" .. p62;
end);
return true;
