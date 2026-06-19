-- Decompiled from: Tag
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 12a7ca22-cd63-42d4-a557-a631ea165de3

-- Decompiled with Potassium's decompiler.

local _ = string.byte;
local l__obtain__1 = _G.obtain;
local l__Gen__2 = l__obtain__1("QC").Gen;
l__obtain__1("GetNameColour");
local u1 = l__obtain__1("QBox");
local l__Color__3 = u1.Color;
local l__FreeMouse__4 = u1.FreeMouse;
local l__New__5 = u1.New;
local l__TextBox__6 = u1.TextBox;
local l__FromList__7 = u1.FromList;
local v2 = l__obtain__1("Tween");
local v3 = l__obtain__1("Local");
local v4 = l__obtain__1("Remote");
local l__Call__8 = v4.Call;
local v5 = l__obtain__1("Command");
local u6 = l__New__5();
u6.Visible = false;
u6.DrawBackground = false;
u6.SizeOffsetX = 400;
u6.SizeOffsetY = 600;
u6.PosScaleX = 0.5;
u6.PosScaleY = 1;
local u7 = false;
local u9 = v2.New(0, function(p8) --[[ Line: 40 ]]
    -- upvalues: u7 (ref), u6 (copy)
    u7 = true;
    u6.PosOffsetY = p8;
    u7 = false;
end);
u9.MaxAcceleration = v2.MaxAcceleration(0, u6.SizeY, 0, 0, 1);
u6.Callbacks[{
    PosOffsetY = true
}] = function() --[[ Line: 46 ]]
    -- upvalues: u7 (ref), u9 (copy), u6 (copy)
    if not u7 then
        u9.x1 = u6.PosOffsetY;
    end;
end;
function u6.Resize() --[[ Line: 52 ]]
    -- upvalues: u6 (copy), u9 (copy)
    u6.PosOffsetX = u6.SizeX / -2;
    u6.PosOffsetY = u9:Value();
end;
local v10 = u1.TextBox(u6, "Choose a Tag");
v10.TextSize = 12 * u1.roblox_messing_with_guis_factor;
v10.TextAlignment = "Center";
v10.BackgroundColor = u1.Color2;
v10.SizeScaleX = 1;
v10.SizeOffsetX = -40;
v10.SizeOffsetY = 40;
u1.DragBar(v10, u6);
local v11 = u1.TextBox(u6, "x");
v11.TextSize = 12 * u1.roblox_messing_with_guis_factor;
v11.TextAlignment = "Center";
v11.SizeOffsetX = 40;
v11.SizeOffsetY = 40;
v11.PosOffsetX = -40;
v11.PosScaleX = 1;
local u12 = l__New__5();
u12.DrawBackground = false;
u12.SizeScaleX = 1;
local v13 = l__New__5(u6);
v13.PosOffsetY = 40;
v13.SizeScaleX = 1;
v13.SizeScaleY = 1;
v13.SizeOffsetY = -40;
u1.Scroll(u12, v13);
local u14 = false;
function v11.Button1Down() --[[ Line: 91 ]]
    -- upvalues: u14 (ref), l__FreeMouse__4 (copy), u9 (copy), u6 (copy)
    u14 = false;
    l__FreeMouse__4("Tag", false);
    u9:Target(0, function() --[[ Line: 94 ]]
        -- upvalues: u6 (ref)
        u6.Visible = false;
    end);
end;
v4.Add("SetTags", function(p15) --[[ Name: AddTags, Line 101 ]]
    -- upvalues: u12 (copy), l__FromList__7 (copy), l__TextBox__6 (copy), u1 (copy), l__Color__3 (copy), u14 (ref), l__Call__8 (copy), l__FreeMouse__4 (copy), u9 (copy), u6 (copy), l__New__5 (copy), l__Gen__2 (copy)
    local u16 = #p15 + 1;
    p15[u16] = "None";
    local l__Children__9 = u12.Children;
    for v17 = #l__Children__9, 1, -1 do
        l__Children__9[v17]:Remove();
    end;
    u12.SizeOffsetY = #p15 * 40;
    l__FromList__7(p15, function(u18, p19) --[[ Line: 109 ]]
        -- upvalues: l__TextBox__6 (ref), u12 (ref), u1 (ref), l__Color__3 (ref), u14 (ref), l__Call__8 (ref), u16 (copy), l__FreeMouse__4 (ref), u9 (ref), u6 (ref), l__New__5 (ref), l__Gen__2 (ref)
        if type(p19) == "string" then
            local u20 = l__TextBox__6(u12, p19);
            u20.TextAlignment = "Center";
            function u20.Fade(p21) --[[ Line: 113 ]]
                -- upvalues: u20 (copy), u1 (ref), l__Color__3 (ref)
                local v22 = u20;
                local l__Color1__10 = u1.Color1;
                local l__Color2__11 = u1.Color2;
                local v23 = 1 - p21;
                v22.BackgroundColor = l__Color__3(l__Color1__10.r * v23 + l__Color2__11.r * p21, l__Color1__10.g * v23 + l__Color2__11.g * p21, l__Color1__10.b * v23 + l__Color2__11.b * p21, l__Color1__10.a * v23 + l__Color2__11.a * p21);
            end;
            u20.FadeDuration = 0.15;
            function u20.Button1Down() --[[ Line: 117 ]]
                -- upvalues: u14 (ref), l__Call__8 (ref), u18 (copy), u16 (ref), l__FreeMouse__4 (ref), u9 (ref), u6 (ref)
                if u14 then
                    local v24 = l__Call__8;
                    local v25 = "SetTag";
                    local v26;
                    if u18 == u16 then
                        v26 = nil;
                    else
                        v26 = u18 or nil;
                    end;
                    v24(v25, v26);
                    u14 = false;
                    l__FreeMouse__4("Tag", false);
                    u9:Target(0, function() --[[ Line: 94 ]]
                        -- upvalues: u6 (ref)
                        u6.Visible = false;
                    end);
                end;
            end;
            return u20;
        end;
        local u27 = l__New__5(u12);
        local v28 = l__Gen__2(p19);
        if v28 then
            v28.PosScaleX = 0.5;
            v28.PosScaleY = 0.5;
            v28.PosOffsetX = v28.SizeX / -2;
            v28.PosOffsetY = v28.SizeY / -2;
            v28.Parent = u27;
        end;
        function u27.Fade(p29) --[[ Line: 134 ]]
            -- upvalues: u27 (copy), u1 (ref), l__Color__3 (ref)
            local v30 = u27;
            local l__Color1__12 = u1.Color1;
            local l__Color2__13 = u1.Color2;
            local v31 = 1 - p29;
            v30.BackgroundColor = l__Color__3(l__Color1__12.r * v31 + l__Color2__13.r * p29, l__Color1__12.g * v31 + l__Color2__13.g * p29, l__Color1__12.b * v31 + l__Color2__13.b * p29, l__Color1__12.a * v31 + l__Color2__13.a * p29);
        end;
        u27.FadeDuration = 0.15;
        function u27.Button1Down() --[[ Line: 138 ]]
            -- upvalues: u14 (ref), l__Call__8 (ref), u18 (copy), l__FreeMouse__4 (ref), u9 (ref), u6 (ref)
            if u14 then
                l__Call__8("SetTag", u18);
                u14 = false;
                l__FreeMouse__4("Tag", false);
                u9:Target(0, function() --[[ Line: 94 ]]
                    -- upvalues: u6 (ref)
                    u6.Visible = false;
                end);
            end;
        end;
        return u27;
    end);
end);
v3.Add("GutenTag", function() --[[ Line: 162 ]]
    -- upvalues: u14 (ref), l__Call__8 (copy), l__FreeMouse__4 (copy), u6 (copy), u9 (copy)
    if not u14 then
        u14 = true;
        l__Call__8("GetTags");
        l__FreeMouse__4("Tag", true);
        u6.Visible = true;
        u9:Target(-u6.Parent.SizeY / 2 - u6.SizeY / 2);
    end;
end);
v5.Add({ "tags", "tag" }, {}, function() --[[ Line: 168 ]]
    -- upvalues: u14 (ref), l__FreeMouse__4 (copy), u9 (copy), u6 (copy), l__Call__8 (copy)
    if u14 then
        u14 = false;
        l__FreeMouse__4("Tag", false);
        u9:Target(0, function() --[[ Line: 94 ]]
            -- upvalues: u6 (ref)
            u6.Visible = false;
        end);
    else
        u14 = true;
        l__Call__8("GetTags");
        l__FreeMouse__4("Tag", true);
        u6.Visible = true;
        u9:Target(-u6.Parent.SizeY / 2 - u6.SizeY / 2);
    end;
end);
return true;
