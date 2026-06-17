-- Decompiled from: Start.Client.Classes._x5e4b900ba734c53c
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__ContextActionService__1 = game:GetService("ContextActionService");
game:GetService("RunService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__Players__3 = game:GetService("Players");
local l__ModuleScripts__4 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__5 = require(l__ModuleScripts__4.Packets);
require(l__ModuleScripts__4.Signal);
local l__Promise__6 = require(l__ModuleScripts__4.Promise);
local l__Trove__7 = require(l__ModuleScripts__4.Trove);
require(l__ModuleScripts__4.Spring);
local l__Command__8 = require(l__ModuleScripts__4.Command);
local u1 = {};
u1.__index = u1;
local l__Classes__9 = require(script.Parent.Parent.ClientRoot).Classes;
local l__LocalPlayer__10 = game.Players.LocalPlayer;
local u2 = {
    moderator = 1,
    high_moderator = 2,
    admin = 3,
    owner = 4
};
local function u10(p3, p4) --[[ Line: 53 ]]
    -- upvalues: u2 (copy)
    local v5;
    if type(p3) == "table" then
        v5 = 0;
        for v6, v7 in u2 do
            if p3[v6] == true then
                v5 = math.max(v5, v7);
            end;
        end;
    else
        v5 = 0;
    end;
    if #p4 == 0 then
        return u2.owner <= v5;
    end;
    for _, v8 in ipairs(p4) do
        local v9 = u2[v8];
        if v9 then
            if v9 <= v5 then
                return true;
            end;
        elseif p3[v8] == true then
            return true;
        end;
    end;
    return false;
end;
function u1._x83ed94bfb82a8c9f() --[[ Line: 73 ]]
    -- upvalues: u1 (copy), l__Trove__7 (copy)
    local u11 = setmetatable({}, u1);
    local v12 = game:GetService("ReplicatedStorage").Assets.UIAssets.CommandUI:Clone();
    u11._x268f020dcf94ec17 = v12;
    u11._x68be8a7a00400919 = false;
    u11._x137bf1302ffb8489 = "";
    u11._x2bc931a08ba7b119 = {};
    u11._x882e9ef3206b5406 = {};
    u11._x50c1e4f618b39597 = 1;
    u11._x7c009ad2e5b1cdfe = {};
    u11._xa302d143e255f3ad = {};
    u11._x5b721f5535f8763e = false;
    local _ = v12.ConsoleFrame.Editor.TextBox;
    for u13 = 1, 12 do
        local v14 = game:GetService("ReplicatedStorage").Assets.UIAssets.AutocompleteEntry:Clone();
        v14.Parent = v12.ConsoleFrame.Autocomplete;
        v14.Visible = false;
        table.insert(u11._x882e9ef3206b5406, v14);
        local v15 = v14:FindFirstChildWhichIsA("TextButton");
        if v15 then
            v15:SetAttribute("EntryIndex", u13);
            local v16 = l__Trove__7.new();
            v16:Add(v15.MouseEnter:Connect(function() --[[ Line: 108 ]]
                -- upvalues: u11 (copy), u13 (copy)
                u11:_x0d5dddddb1ffc20d(u13);
            end));
            v16:Add(v15.Activated:Connect(function() --[[ Line: 111 ]]
                -- upvalues: u11 (copy), u13 (copy)
                if u11._x5b721f5535f8763e then
                else
                    u11._x5b721f5535f8763e = true;
                    u11:_xbe147c1af11e1d2f(u13);
                end;
            end));
            v16:Add(v15.MouseLeave:Connect(function() --[[ Line: 116 ]]
                -- upvalues: u11 (copy), u13 (copy)
                u11:_xc163a211432e026d(u13);
            end));
            u11._xa302d143e255f3ad[u13] = v16;
        end;
    end;
    return u11;
end;
function u1._x0d5dddddb1ffc20d(p17, p18) --[[ Line: 127 ]]
    local v19 = p17._x7c009ad2e5b1cdfe[p18];
    if v19 and v19.is_selectable then
        p17._x50c1e4f618b39597 = p18;
        p17:_xee53a53c02025967();
    end;
end;
function u1._xc163a211432e026d(_, _) --[[ Line: 135 ]] end;
function u1._xbe147c1af11e1d2f(p20, p21) --[[ Line: 140 ]]
    local v22 = p20._x7c009ad2e5b1cdfe[p21];
    if v22 and v22.is_selectable then
        p20._x50c1e4f618b39597 = p21;
        p20:_x9d2789f6430dfa76();
    end;
end;
function u1._x0f970ec3cb4e3419(p23) --[[ Line: 149 ]]
    -- upvalues: l__ContextActionService__1 (copy)
    local l___x268f020dcf94ec17__11 = p23._x268f020dcf94ec17;
    local l__TextBox__12 = l___x268f020dcf94ec17__11.ConsoleFrame.Editor.TextBox;
    l___x268f020dcf94ec17__11.Enabled = false;
    p23._x68be8a7a00400919 = false;
    l__TextBox__12.Text = "";
    p23._x7c009ad2e5b1cdfe = {};
    p23:_xee53a53c02025967();
    l__TextBox__12:ReleaseFocus();
    l__ContextActionService__1:UnbindAction("DisableTab");
end;
function u1._x960c2ca9dccf107c(p24) --[[ Line: 163 ]]
    -- upvalues: l__ContextActionService__1 (copy)
    local l___x268f020dcf94ec17__13 = p24._x268f020dcf94ec17;
    local l__TextBox__14 = l___x268f020dcf94ec17__13.ConsoleFrame.Editor.TextBox;
    l___x268f020dcf94ec17__13.Enabled = true;
    p24._x68be8a7a00400919 = true;
    p24._x50c1e4f618b39597 = 1;
    p24:_x8c214b06e15bb61c();
    l__TextBox__14:CaptureFocus();
    l__ContextActionService__1:BindActionAtPriority("DisableTab", function() --[[ Line: 173 ]]
        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Tab);
end;
function u1._xee53a53c02025967(p25) --[[ Line: 178 ]]
    for v26, v27 in ipairs(p25._x882e9ef3206b5406) do
        local v28 = p25._x7c009ad2e5b1cdfe[v26];
        local v29 = v27:FindFirstChildWhichIsA("TextLabel") or v27:FindFirstChildWhichIsA("TextBox");
        local v30 = v27:FindFirstChildWhichIsA("TextButton");
        if v28 then
            v27.Visible = true;
            if v29 then
                v29.Text = v28.display_text;
                v29.TextTransparency = v28.is_selectable and (v26 == p25._x50c1e4f618b39597 and 0 or 0.5) or 0.5;
            end;
            if v30 then
                v30.Visible = true;
                v30.Selectable = v28.is_selectable;
                v30.Active = v28.is_selectable;
            end;
        else
            v27.Visible = false;
            if v30 then
                v30.Visible = false;
                v30.Selectable = false;
                v30.Active = false;
            end;
        end;
    end;
end;
local function u34(p31) --[[ Line: 209 ]]
    local v32 = p31:gsub("^%s+", "");
    if p31:match("%s$") then
        return v32:gsub("%s+$", "") .. " ", "";
    else
        local v33 = v32:match(".*%s()");
        if v33 then
            return v32:sub(1, v33 - 1), v32:sub(v33);
        else
            return "", v32;
        end;
    end;
end;
function u1._x8c214b06e15bb61c(p35) --[[ Line: 228 ]]
    -- upvalues: u34 (copy), l__Command__8 (copy), u10 (copy), l__Players__3 (copy)
    local l__Text__15 = p35._x268f020dcf94ec17.ConsoleFrame.Editor.TextBox.Text;
    p35._x7c009ad2e5b1cdfe = {};
    local v36, v37 = u34(l__Text__15);
    if l__Text__15:match("%s") then
        local v38 = v36:match("^%s*(%S+)") or "";
        local v39 = nil;
        for _, v40 in ipairs(l__Command__8) do
            if string.lower(v40.command_name) == string.lower(v38) then
                v39 = v40;
                break;
            end;
        end;
        if v39 and v39.args then
            local v41 = {};
            local v42 = #v38 + 1;
            if v42 <= #v36 then
                for v43 in v36:sub(v42):gmatch("%S+") do
                    table.insert(v41, v43);
                end;
            end;
            local v44 = v39.args[#v41 + 1];
            if v44 then
                local v45 = #v37;
                local v46 = string.lower(v37 or "");
                if v44.arg_type == "player" then
                    for _, v47 in ipairs(l__Players__3:GetPlayers()) do
                        local v48 = string.lower(v47.Name);
                        local v49 = string.lower(v47.DisplayName);
                        if v48:sub(1, v45) == v46 or v49:sub(1, v45) == v46 then
                            local l___x7c009ad2e5b1cdfe__16 = p35._x7c009ad2e5b1cdfe;
                            local v50 = {
                                is_hint = false,
                                is_selectable = true,
                                display_text = v47.Name .. " (@" .. v47.DisplayName .. ")",
                                autofill_text = tostring(v47.UserId)
                            };
                            table.insert(l___x7c009ad2e5b1cdfe__16, v50);
                        end;
                    end;
                else
                    local v51 = v44.required and "" or "?";
                    local v52 = string.format("%s%s: %s", v44.name, v51, v44.arg_type == "player" and "UserId" or v44.arg_type);
                    if v44.arg_type == "boolean" then
                        v52 = string.format("%s%s: true/false", v44.name, v51);
                    end;
                    table.insert(p35._x7c009ad2e5b1cdfe, {
                        autofill_text = nil,
                        is_hint = true,
                        is_selectable = false,
                        display_text = v52
                    });
                    local l__autocomplete__17 = v44.autocomplete;
                    local v53 = v44.arg_type == "boolean" and not l__autocomplete__17 and { "true", "false" } or l__autocomplete__17;
                    if v53 then
                        for _, v54 in ipairs(v53) do
                            local v55 = tostring(v54);
                            if string.lower(v55):sub(1, v45) == v46 then
                                table.insert(p35._x7c009ad2e5b1cdfe, {
                                    is_hint = false,
                                    is_selectable = true,
                                    display_text = v55,
                                    autofill_text = v55
                                });
                            end;
                        end;
                    end;
                end;
            end;
        end;
    else
        for _, v56 in ipairs(l__Command__8) do
            if u10(p35._x2bc931a08ba7b119, v56.permissions) then
                local v57 = string.lower(v56.command_name);
                local v58 = string.lower(v37 or "");
                if v57:sub(1, #v58) == v58 then
                    table.insert(p35._x7c009ad2e5b1cdfe, {
                        is_hint = false,
                        is_selectable = true,
                        display_text = v56.command_name,
                        autofill_text = v56.command_name
                    });
                end;
            end;
        end;
    end;
    if #p35._x7c009ad2e5b1cdfe > 1 and (p35._x7c009ad2e5b1cdfe[1].is_selectable == false and p35._x50c1e4f618b39597 == 1) then
        p35._x50c1e4f618b39597 = 2;
    end;
    local l___x50c1e4f618b39597__18 = p35._x50c1e4f618b39597;
    local v59 = math.max(1, #p35._x7c009ad2e5b1cdfe);
    p35._x50c1e4f618b39597 = math.clamp(l___x50c1e4f618b39597__18, 1, v59);
    p35:_xee53a53c02025967();
end;
function u1._x9d2789f6430dfa76(p60) --[[ Line: 354 ]]
    -- upvalues: u34 (copy)
    local v61 = p60._x7c009ad2e5b1cdfe[p60._x50c1e4f618b39597];
    if v61 and (v61.is_selectable and v61.autofill_text) then
        local l__TextBox__19 = p60._x268f020dcf94ec17.ConsoleFrame.Editor.TextBox;
        local l__Text__20 = l__TextBox__19.Text;
        local l__autofill_text__21 = v61.autofill_text;
        local v62, _ = u34(l__Text__20);
        local v63;
        if v62:match("^%s*$") and l__Text__20:match("^%S*[^%s]*$") then
            v63 = l__autofill_text__21 .. " ";
        else
            v63 = v62 .. l__autofill_text__21 .. " ";
        end;
        local v64 = v63:gsub("%s+", " "):gsub("%s$", "") .. " ";
        l__TextBox__19.Text = v64;
        l__TextBox__19.CursorPosition = #v64 + 1;
        p60._x50c1e4f618b39597 = 1;
        p60:_x8c214b06e15bb61c();
    end;
end;
function u1._x4787a38a572fbe42(p65) --[[ Line: 383 ]]
    -- upvalues: l__Packets__5 (copy), l__Promise__6 (copy)
    local l__TextBox__22 = p65._x268f020dcf94ec17.ConsoleFrame.Editor.TextBox;
    local l__Text__23 = l__TextBox__22.Text;
    p65._x137bf1302ffb8489 = l__Text__23;
    l__Packets__5._x4f650e8e91652cc9:Fire(l__Text__23);
    l__Promise__6.defer(function() --[[ Line: 389 ]]
        -- upvalues: l__TextBox__22 (copy)
        l__TextBox__22.Text = "";
        l__TextBox__22:CaptureFocus();
    end);
end;
function u1._x82e6cf60d86f60e9(p66) --[[ Line: 395 ]]
    -- upvalues: l__Command__8 (copy), u10 (copy)
    if not p66._x2bc931a08ba7b119 or next(p66._x2bc931a08ba7b119) == nil then
        return false;
    end;
    for _, v67 in ipairs(l__Command__8) do
        if u10(p66._x2bc931a08ba7b119, v67.permissions) then
            return true;
        end;
    end;
    return false;
end;
function u1._xcc9aff3daa62d46b(p68) --[[ Line: 411 ]]
    return p68._x2bc931a08ba7b119;
end;
function u1._x950658eff2fdb066(p69) --[[ Line: 415 ]]
    -- upvalues: l__Packets__5 (copy)
    print("REPEATED : ", p69._x137bf1302ffb8489);
    l__Packets__5._x4f650e8e91652cc9:Fire(p69._x137bf1302ffb8489);
end;
function u1._x44bcd6af41218f92(u70) --[[ Line: 420 ]]
    -- upvalues: l__LocalPlayer__10 (copy), l__ContextActionService__1 (copy), l__Packets__5 (copy), l__Promise__6 (copy), l__Classes__9 (copy), l__UserInputService__2 (copy)
    local l___x268f020dcf94ec17__24 = u70._x268f020dcf94ec17;
    local l__TextBox__25 = l___x268f020dcf94ec17__24.ConsoleFrame.Editor.TextBox;
    l___x268f020dcf94ec17__24.Parent = l__LocalPlayer__10.PlayerGui;
    l__ContextActionService__1:BindActionAtPriority("DisableArrowKeys", function() --[[ Line: 425 ]]
        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Left, Enum.KeyCode.Right);
    l__Packets__5._x4f650e8e91652cc9.OnClientEvent:Connect(function(p71) --[[ Line: 429 ]]
        -- upvalues: l___x268f020dcf94ec17__24 (copy)
        local v72 = game:GetService("ReplicatedStorage").Assets.UIAssets.OutputText:Clone();
        v72.Text = p71;
        v72.Parent = l___x268f020dcf94ec17__24.ConsoleFrame.Output;
    end);
    game:GetService("ContextActionService"):UnbindAction("RbxCameraKeypress");
    l__Promise__6.defer(function() --[[ Line: 437 ]]
        -- upvalues: l__Classes__9 (ref), u70 (copy)
        local u73 = l__Classes__9._x8399b2bb73e12808:_xe7f02e22353709c3("console_roles");
        local function v78() --[[ Line: 440 ]]
            -- upvalues: u73 (copy), u70 (ref)
            u70._x2bc931a08ba7b119 = (function(p74) --[[ Name: stringToArray, Line 443 ]]
                local v75 = {};
                for v76 in p74:gmatch("[^,]+") do
                    local v77 = v76:gsub("^%s*(.-)%s*$", "%1");
                    if v77 ~= "" then
                        v75[v77] = true;
                    end;
                end;
                return v75;
            end)(u73.Value);
        end;
        u70._x2bc931a08ba7b119 = (function(p79) --[[ Name: stringToArray, Line 443 ]]
            local v80 = {};
            for v81 in p79:gmatch("[^,]+") do
                local v82 = v81:gsub("^%s*(.-)%s*$", "%1");
                if v82 ~= "" then
                    v80[v82] = true;
                end;
            end;
            return v80;
        end)(u73.Value);
        u73.Changed:Connect(v78);
    end);
    l__TextBox__25:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 465 ]]
        -- upvalues: l__TextBox__25 (copy), u70 (copy)
        if l__TextBox__25.Text:find("\t") then
            l__TextBox__25.Text = l__TextBox__25.Text:gsub("\t", "");
        else
            u70._x50c1e4f618b39597 = 1;
            if u70._x68be8a7a00400919 then
                u70:_x8c214b06e15bb61c();
            end;
        end;
    end);
    l__TextBox__25.FocusLost:Connect(function(p83) --[[ Line: 475 ]]
        -- upvalues: u70 (copy), l__Promise__6 (ref), l__TextBox__25 (copy)
        if p83 then
            u70:_x4787a38a572fbe42();
        end;
        if u70._x5b721f5535f8763e then
            u70._x5b721f5535f8763e = false;
            l__Promise__6.defer(function() --[[ Line: 481 ]]
                -- upvalues: l__TextBox__25 (ref)
                l__TextBox__25:CaptureFocus();
            end);
        end;
    end);
    l__UserInputService__2.InputBegan:Connect(function(p84, _) --[[ Line: 484 ]]
        -- upvalues: u70 (copy)
        if u70:_x82e6cf60d86f60e9() then
            if p84.KeyCode == Enum.KeyCode.KeypadPlus then
                u70:_x950658eff2fdb066();
            elseif p84.KeyCode == Enum.KeyCode.Left or p84.KeyCode == Enum.KeyCode.F1 then
                if u70._x68be8a7a00400919 then
                    u70:_x0f970ec3cb4e3419();
                else
                    u70:_x960c2ca9dccf107c();
                end;
            elseif u70._x68be8a7a00400919 then
                if #u70._x7c009ad2e5b1cdfe > 0 then
                    if p84.KeyCode == Enum.KeyCode.Right or p84.KeyCode == Enum.KeyCode.Tab then
                        u70:_x9d2789f6430dfa76();
                        return;
                    end;
                    if p84.KeyCode == Enum.KeyCode.Up then
                        local _ = u70._x7c009ad2e5b1cdfe[1] and u70._x7c009ad2e5b1cdfe[1].is_selectable == false;
                        u70._x50c1e4f618b39597 = u70._x50c1e4f618b39597 - 1;
                        if u70._x50c1e4f618b39597 < (u70._x7c009ad2e5b1cdfe[1].is_selectable and 1 or 2) then
                            u70._x50c1e4f618b39597 = #u70._x7c009ad2e5b1cdfe;
                        end;
                        u70:_xee53a53c02025967();
                        return;
                    end;
                    if p84.KeyCode == Enum.KeyCode.Down then
                        u70._x50c1e4f618b39597 = u70._x50c1e4f618b39597 + 1;
                        if u70._x50c1e4f618b39597 > #u70._x7c009ad2e5b1cdfe then
                            u70._x50c1e4f618b39597 = u70._x7c009ad2e5b1cdfe[1].is_selectable and 1 or 2;
                        end;
                        u70:_xee53a53c02025967();
                    end;
                end;
            end;
        end;
    end);
end;
return u1;
