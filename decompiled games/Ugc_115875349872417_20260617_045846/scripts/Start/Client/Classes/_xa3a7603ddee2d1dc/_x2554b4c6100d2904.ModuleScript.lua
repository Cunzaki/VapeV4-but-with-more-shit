-- Decompiled from: Start.Client.Classes._xa3a7603ddee2d1dc._x2554b4c6100d2904
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

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
local function u8(p2, p3) --[[ Line: 59 ]]
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
local function u14(p9) --[[ Line: 82 ]]
    -- upvalues: l__Classes__7 (copy)
    if type(p9) == "string" and p9 ~= "" then
        local l___xf1ad98d2d70b7408__8 = l__Classes__7._xf1ad98d2d70b7408;
        if l___xf1ad98d2d70b7408__8 then
            return string.gsub(p9, "{[Aa]ction:([%w_]+)}", function(p10) --[[ Line: 92 ]]
                -- upvalues: l___xf1ad98d2d70b7408__8 (copy)
                if type(l___xf1ad98d2d70b7408__8._x93fd21adac562b5e) ~= "function" then
                    return "[" .. p10 .. "]";
                end;
                local u11 = l___xf1ad98d2d70b7408__8:_x93fd21adac562b5e(p10);
                if u11 then
                    u11 = u11.KeyCode;
                end;
                if not u11 then
                    return "[" .. p10 .. "]";
                end;
                if type(l___xf1ad98d2d70b7408__8._x9afb0bbcc2b58dcd) == "function" then
                    local v12, v13 = pcall(function() --[[ Line: 104 ]]
                        -- upvalues: l___xf1ad98d2d70b7408__8 (ref), u11 (copy)
                        return l___xf1ad98d2d70b7408__8:_x9afb0bbcc2b58dcd(u11);
                    end);
                    if v12 and (type(v13) == "string" and v13 ~= "") then
                        return "[" .. v13 .. "]";
                    end;
                end;
                return "[" .. tostring(u11.Name or p10) .. "]";
            end);
        else
            return p9;
        end;
    else
        return "";
    end;
end;
function u1._x83ed94bfb82a8c9f(p15, p16, p17) --[[ Line: 117 ]]
    -- upvalues: u1 (copy), l__Trove__4 (copy), l__DialogueNodes__5 (copy), l__UIAssets__6 (copy), l__Signal__3 (copy)
    local v18 = setmetatable({}, u1);
    v18._x9ef9da83507556fe = p16;
    v18._x0779b4a5b2a61bac = p17;
    v18._xc74e01ec7295b965 = l__Trove__4.new();
    v18._xe4138871180d5ded = p15;
    v18._x4563d7e6bb0bc282 = l__DialogueNodes__5[p16];
    v18._x3ca10a568cc63fe2 = 0;
    v18._x910329e09d05e05c = false;
    v18._xcdc4a79d7b7a62b4 = false;
    v18._x55f0c90e6a8904e5 = 0;
    local v19 = type(v18._x4563d7e6bb0bc282) == "table";
    assert(v19, "DialogueBox.new expected a valid dialogue node");
    v18._x07779d2bc1981406 = v18._xc74e01ec7295b965:Clone(l__UIAssets__6.Guides.DialogueContainer);
    v18._xd71422846bfec0a3 = v18._xc74e01ec7295b965:Add(l__Signal__3.new());
    v18:_xba28441e0836bc41();
    return v18;
end;
function u1._x6a01d4c8c7067470(p20) --[[ Line: 140 ]]
    return p20._x4563d7e6bb0bc282 and p20._x4563d7e6bb0bc282.advance or nil;
end;
function u1._x2595696cf2d3e229(p21) --[[ Line: 144 ]]
    -- upvalues: u14 (copy)
    local v22 = p21:_x6a01d4c8c7067470();
    if p21._xcdc4a79d7b7a62b4 then
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
function u1._x68093c4d1ff38ac4(p23) --[[ Line: 166 ]]
    -- upvalues: l__TweenService__1 (copy)
    if p23._xb0b708706e633fc9 then
        p23._xb0b708706e633fc9.Text = p23:_x2595696cf2d3e229();
        p23._xb0b708706e633fc9.TextTransparency = 1;
        l__TweenService__1:Create(p23._xb0b708706e633fc9, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            TextTransparency = 0
        }):Play();
    end;
end;
function u1._x2c831cb87d587e54(p24) --[[ Line: 179 ]]
    local v25 = p24._x4563d7e6bb0bc282.theme or {};
    if v25.color then
        p24._xb3602ac483b015b2.TextColor3 = v25.color;
        p24._x476672505952b8ba.TextColor3 = v25.color;
    end;
    if v25.max_size then
        p24._x476672505952b8ba.TextSize = v25.max_size;
        if p24._xc3dc3ef5090585e7 then
            p24._xc3dc3ef5090585e7.MaxTextSize = v25.max_size;
        end;
    end;
    if v25.font then
        if typeof(v25.font) == "Font" then
            if p24._x476672505952b8ba.FontFace then
                p24._x476672505952b8ba.FontFace = v25.font;
            end;
        elseif typeof(v25.font) == "EnumItem" and v25.font.EnumType == Enum.Font then
            p24._x476672505952b8ba.Font = v25.font;
        end;
    end;
end;
function u1._x10222306c9fcf8ce(u26) --[[ Line: 206 ]]
    -- upvalues: l__TweenService__1 (copy)
    local l___x2cce878fc4f23378__9 = u26._x2cce878fc4f23378;
    if l___x2cce878fc4f23378__9 then
        l___x2cce878fc4f23378__9.Visible = true;
        task.delay(0.06, function() --[[ Line: 214 ]]
            -- upvalues: u26 (copy), l___x2cce878fc4f23378__9 (copy)
            if u26._x2cce878fc4f23378 == l___x2cce878fc4f23378__9 and l___x2cce878fc4f23378__9.Parent then
                l___x2cce878fc4f23378__9.Visible = false;
            end;
        end);
        u26._x07779d2bc1981406.Main.Size = UDim2.fromScale(0, 1);
        l__TweenService__1:Create(u26._x07779d2bc1981406.Main, TweenInfo.new(0.66, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(1, 1)
        }):Play();
    end;
end;
function u1._xe0a59e8b46959f6d(p27, p28) --[[ Line: 229 ]]
    -- upvalues: u8 (copy)
    local v29 = p27._x4563d7e6bb0bc282.theme or {};
    local v30 = tonumber(v29.typewriter_speed) or 0.03;
    local v31 = (p28 % 4 - 1.5) * 0.0035;
    if p28 % 11 == 0 then
        v31 = v31 + 0.01;
    end;
    local v32 = v30 + v31;
    local v33 = u8(p27._x476672505952b8ba.Text, p28);
    if (v33 == "." or (v33 == "," or (v33 == "!" or (v33 == "?" or v33 == ":")))) and true or v33 == ";" then
        v32 = v30 + (tonumber(v29.punctuation_pause) or 0);
    end;
    return math.max(0.012, v32);
end;
function u1._x7e5a15c0b6c3d6f2(p34, p35) --[[ Line: 248 ]]
    -- upvalues: l__Classes__7 (copy)
    if p35 % 2 == 0 then
        local v36 = p34._x4563d7e6bb0bc282.theme or {};
        if v36.sound and (l__Classes__7._x6dbba03a0636f7d8 and type(l__Classes__7._x6dbba03a0636f7d8._x282746dbf42c87cb) == "function") then
            local v37 = l__Classes__7._x6dbba03a0636f7d8:_x282746dbf42c87cb(v36.sound, true);
            l__Classes__7._x6dbba03a0636f7d8:_xa14b624022539602(v37, v36.min_pitch, v36.max_pitch);
        end;
    end;
end;
function u1._x38921fac8b98d6a2(p38) --[[ Line: 261 ]]
    p38._x3ca10a568cc63fe2 = p38._x3ca10a568cc63fe2 + 1;
    p38._xcdc4a79d7b7a62b4 = true;
    p38._x476672505952b8ba.MaxVisibleGraphemes = -1;
    p38:_x68093c4d1ff38ac4();
end;
function u1._x8cbd54fb1f9f7221(u39) --[[ Line: 268 ]]
    u39._x3ca10a568cc63fe2 = u39._x3ca10a568cc63fe2 + 1;
    u39._xcdc4a79d7b7a62b4 = false;
    local l___x3ca10a568cc63fe2__10 = u39._x3ca10a568cc63fe2;
    u39._x476672505952b8ba.MaxVisibleGraphemes = 0;
    u39:_x68093c4d1ff38ac4();
    if u39._x55f0c90e6a8904e5 <= 0 then
        u39:_x38921fac8b98d6a2();
    else
        task.spawn(function() --[[ Line: 282 ]]
            -- upvalues: u39 (copy), l___x3ca10a568cc63fe2__10 (copy)
            for v40 = 1, u39._x55f0c90e6a8904e5 do
                if u39._x3ca10a568cc63fe2 ~= l___x3ca10a568cc63fe2__10 or not u39._x07779d2bc1981406.Parent then
                    return;
                end;
                u39._x476672505952b8ba.MaxVisibleGraphemes = v40;
                u39:_x7e5a15c0b6c3d6f2(v40);
                if v40 < u39._x55f0c90e6a8904e5 then
                    task.wait(u39:_xe0a59e8b46959f6d(v40));
                end;
            end;
            if u39._x3ca10a568cc63fe2 == l___x3ca10a568cc63fe2__10 then
                u39:_x38921fac8b98d6a2();
            end;
        end);
    end;
end;
function u1._x4663a2bdf0c55b6f(u41) --[[ Line: 302 ]]
    -- upvalues: l__Classes__7 (copy)
    local l___xf1ad98d2d70b7408__11 = l__Classes__7._xf1ad98d2d70b7408;
    if l___xf1ad98d2d70b7408__11 and type(l___xf1ad98d2d70b7408__11._x93fd21adac562b5e) == "function" then
        local v42 = l___xf1ad98d2d70b7408__11:_x93fd21adac562b5e("INTERACT");
        if v42 and v42.Pressed then
            u41._xc74e01ec7295b965:Add(v42.Pressed:Connect(function() --[[ Line: 313 ]]
                -- upvalues: u41 (copy), l__Classes__7 (ref)
                if u41._x910329e09d05e05c then
                    l__Classes__7._x6dbba03a0636f7d8:_x282746dbf42c87cb("BLIP", true);
                    if u41:_x4b8662150fb83ed4() then
                        u41:_x3e382ecdbc4cc78a();
                    else
                        if u41:_x12007e79259d8326() then
                            u41._xd71422846bfec0a3:Fire(u41._x9ef9da83507556fe, u41._x0779b4a5b2a61bac);
                        end;
                    end;
                end;
            end));
        end;
    end;
end;
function u1._xba28441e0836bc41(p43) --[[ Line: 331 ]]
    -- upvalues: l__Classes__7 (copy)
    p43._x2cce878fc4f23378 = p43._x07779d2bc1981406.Flash;
    p43._xb0b708706e633fc9 = p43._x07779d2bc1981406.HintLabel;
    p43._xb3602ac483b015b2 = p43._x07779d2bc1981406.TopFrame.SpeakerLabel;
    p43._x476672505952b8ba = p43._x07779d2bc1981406.Main.Box.DialogueLabel;
    p43._xc3dc3ef5090585e7 = p43._x476672505952b8ba:FindFirstChildOfClass("UITextSizeConstraint");
    p43._xb3602ac483b015b2.Text = tostring(p43._x4563d7e6bb0bc282.speaker or "");
    local l___x476672505952b8ba__12 = p43._x476672505952b8ba;
    local v44 = tostring(p43._x4563d7e6bb0bc282.text_raw or "");
    if type(v44) == "string" and v44 ~= "" then
        local l___xf1ad98d2d70b7408__13 = l__Classes__7._xf1ad98d2d70b7408;
        if l___xf1ad98d2d70b7408__13 then
            v44 = string.gsub(v44, "{[Aa]ction:([%w_]+)}", function(p45) --[[ Line: 92 ]]
                -- upvalues: l___xf1ad98d2d70b7408__13 (copy)
                if type(l___xf1ad98d2d70b7408__13._x93fd21adac562b5e) ~= "function" then
                    return "[" .. p45 .. "]";
                end;
                local u46 = l___xf1ad98d2d70b7408__13:_x93fd21adac562b5e(p45);
                if u46 then
                    u46 = u46.KeyCode;
                end;
                if not u46 then
                    return "[" .. p45 .. "]";
                end;
                if type(l___xf1ad98d2d70b7408__13._x9afb0bbcc2b58dcd) == "function" then
                    local v47, v48 = pcall(function() --[[ Line: 104 ]]
                        -- upvalues: l___xf1ad98d2d70b7408__13 (ref), u46 (copy)
                        return l___xf1ad98d2d70b7408__13:_x9afb0bbcc2b58dcd(u46);
                    end);
                    if v47 and (type(v48) == "string" and v48 ~= "") then
                        return "[" .. v48 .. "]";
                    end;
                end;
                return "[" .. tostring(u46.Name or p45) .. "]";
            end);
        end;
    else
        v44 = "";
    end;
    l___x476672505952b8ba__12.Text = v44;
    local v49 = p43._x476672505952b8ba.Text:gsub("<.->", "");
    local v50 = 0;
    for _ in utf8.graphemes(v49) do
        v50 = v50 + 1;
    end;
    p43._x55f0c90e6a8904e5 = v50;
    p43:_x2c831cb87d587e54();
    p43:_x68093c4d1ff38ac4();
    p43._x07779d2bc1981406.Parent = p43._xe4138871180d5ded;
    local l___xe4138871180d5ded__14 = p43._xe4138871180d5ded;
    if l___xe4138871180d5ded__14 then
        if l___xe4138871180d5ded__14:IsA("ScreenGui") then
            l___xe4138871180d5ded__14.Enabled = true;
        elseif l___xe4138871180d5ded__14:IsA("GuiObject") then
            l___xe4138871180d5ded__14.Visible = true;
        end;
    end;
    p43._x910329e09d05e05c = true;
    p43:_x10222306c9fcf8ce();
    p43:_x4663a2bdf0c55b6f();
    p43:_x8cbd54fb1f9f7221();
end;
function u1._xa66ddece0fb229dd(p51) --[[ Line: 355 ]]
    return p51._x910329e09d05e05c;
end;
function u1._x4b8662150fb83ed4(p52) --[[ Line: 359 ]]
    local l___x910329e09d05e05c__15 = p52._x910329e09d05e05c;
    if l___x910329e09d05e05c__15 then
        l___x910329e09d05e05c__15 = not p52._xcdc4a79d7b7a62b4;
    end;
    return l___x910329e09d05e05c__15;
end;
function u1._x12007e79259d8326(p53) --[[ Line: 363 ]]
    local v54 = p53:_x6a01d4c8c7067470();
    local v55 = p53._x910329e09d05e05c and p53._xcdc4a79d7b7a62b4;
    if v55 then
        if type(v54) == "table" then
            v55 = v54.kind == "continue";
        else
            v55 = false;
        end;
    end;
    return v55;
end;
function u1._x3e382ecdbc4cc78a(p56) --[[ Line: 372 ]]
    p56:_x38921fac8b98d6a2();
end;
function u1.destroy(p57) --[[ Line: 376 ]]
    p57._x3ca10a568cc63fe2 = p57._x3ca10a568cc63fe2 + 1;
    p57._x910329e09d05e05c = false;
    if p57._x07779d2bc1981406 then
        p57._x07779d2bc1981406:Destroy();
        p57._x07779d2bc1981406 = nil;
    end;
    p57._xc74e01ec7295b965:Clean();
end;
return u1;
