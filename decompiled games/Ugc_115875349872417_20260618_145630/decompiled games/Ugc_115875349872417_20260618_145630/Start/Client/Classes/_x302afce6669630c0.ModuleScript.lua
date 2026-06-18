-- Decompiled from: Start.Client.Classes._x302afce6669630c0
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

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
local function u10(p3, p4) --[[ Line: 44 ]]
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
function u1._x90d4581ac99dd483() --[[ Line: 64 ]]
    -- upvalues: u1 (copy), l__Trove__7 (copy)
    local u11 = setmetatable({}, u1);
    local v12 = game:GetService("ReplicatedStorage").Assets.UIAssets.CommandUI:Clone();
    u11._x7eb10a5b6474400e = v12;
    u11._xf180b73116666c39 = false;
    u11._xa754dd566874c880 = "";
    u11._x9f6eedf4001654ab = {};
    u11._xea1ffd3a031219cd = {};
    u11._x213041e4a4d2bd49 = 1;
    u11._x672271a6b8bc53c5 = {};
    u11._x18120945d3b4e795 = {};
    u11._xb3c478bd083d0092 = false;
    local _ = v12.ConsoleFrame.Editor.TextBox;
    for u13 = 1, 12 do
        local v14 = game:GetService("ReplicatedStorage").Assets.UIAssets.AutocompleteEntry:Clone();
        v14.Parent = v12.ConsoleFrame.Autocomplete;
        v14.Visible = false;
        table.insert(u11._xea1ffd3a031219cd, v14);
        local v15 = v14:FindFirstChildWhichIsA("TextButton");
        if v15 then
            v15:SetAttribute("EntryIndex", u13);
            local v16 = l__Trove__7.new();
            v16:Add(v15.MouseEnter:Connect(function() --[[ Line: 99 ]]
                -- upvalues: u11 (copy), u13 (copy)
                u11:_x23191aa23990d2c9(u13);
            end;
            v16:Add(v15.Activated:Connect(function() --[[ Line: 102 ]]
                -- upvalues: u11 (copy), u13 (copy)
                if u11._xb3c478bd083d0092 then
                else
                    u11._xb3c478bd083d0092 = true;
                    u11:_xb48bb406e6595df7(u13);
                end;
            end;
            v16:Add(v15.MouseLeave:Connect(function() --[[ Line: 107 ]]
                -- upvalues: u11 (copy), u13 (copy)
                u11:_xeb2c2e29e11bb2fd(u13);
            end;
            u11._x18120945d3b4e795[u13] = v16;
        end;
    end;
    return u11;
end;
function u1._x23191aa23990d2c9(p17, p18) --[[ Line: 118 ]]
    local v19 = p17._x672271a6b8bc53c5[p18];
    if v19 and v19.is_selectable then
        p17._x213041e4a4d2bd49 = p18;
        p17:_x46de5541788ed596();
    end;
end;
function u1._xeb2c2e29e11bb2fd(_, _) --[[ Line: 126 ]] end;
function u1._xb48bb406e6595df7(p20, p21) --[[ Line: 131 ]]
    local v22 = p20._x672271a6b8bc53c5[p21];
    if v22 and v22.is_selectable then
        p20._x213041e4a4d2bd49 = p21;
        p20:_x48cc343523ef8aeb();
    end;
end;
function u1._xa678d776a823bc57(p23) --[[ Line: 140 ]]
    -- upvalues: l__ContextActionService__1 (copy)
    local l___x7eb10a5b6474400e__11 = p23._x7eb10a5b6474400e;
    local l__TextBox__12 = l___x7eb10a5b6474400e__11.ConsoleFrame.Editor.TextBox;
    l___x7eb10a5b6474400e__11.Enabled = false;
    p23._xf180b73116666c39 = false;
    l__TextBox__12.Text = "";
    p23._x672271a6b8bc53c5 = {};
    p23:_x46de5541788ed596();
    l__TextBox__12:ReleaseFocus();
    l__ContextActionService__1:UnbindAction("DisableTab");
end;
function u1._x585dd74aa0996375(p24) --[[ Line: 154 ]]
    -- upvalues: l__ContextActionService__1 (copy)
    local l___x7eb10a5b6474400e__13 = p24._x7eb10a5b6474400e;
    local l__TextBox__14 = l___x7eb10a5b6474400e__13.ConsoleFrame.Editor.TextBox;
    l___x7eb10a5b6474400e__13.Enabled = true;
    p24._xf180b73116666c39 = true;
    p24._x213041e4a4d2bd49 = 1;
    p24:_x9ddd1ed04f346cf7();
    l__TextBox__14:CaptureFocus();
    l__ContextActionService__1:BindActionAtPriority("DisableTab", function() --[[ Line: 164 ]]
        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Tab);
end;
function u1._x46de5541788ed596(p25) --[[ Line: 169 ]]
    for v26, v27 in ipairs(p25._xea1ffd3a031219cd) do
        local v28 = p25._x672271a6b8bc53c5[v26];
        local v29 = v27:FindFirstChildWhichIsA("TextLabel") or v27:FindFirstChildWhichIsA("TextBox");
        local v30 = v27:FindFirstChildWhichIsA("TextButton");
        if v28 then
            v27.Visible = true;
            if v29 then
                v29.Text = v28.display_text;
                v29.TextTransparency = v28.is_selectable and (v26 == p25._x213041e4a4d2bd49 and 0 or 0.5) or 0.5;
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
local function u34(p31) --[[ Line: 200 ]]
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
function u1._x9ddd1ed04f346cf7(p35) --[[ Line: 219 ]]
    -- upvalues: u34 (copy), l__Command__8 (copy), u10 (copy), l__Players__3 (copy)
    local l__Text__15 = p35._x7eb10a5b6474400e.ConsoleFrame.Editor.TextBox.Text;
    p35._x672271a6b8bc53c5 = {};
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
                            local l___x672271a6b8bc53c5__16 = p35._x672271a6b8bc53c5;
                            local v50 = {
                                is_hint = false,
                                is_selectable = true,
                                display_text = v47.Name .. " (@" .. v47.DisplayName .. ")",
                                autofill_text = tostring(v47.UserId)
                            };
                            table.insert(l___x672271a6b8bc53c5__16, v50);
                        end;
                    end;
                else
                    local v51 = v44.required and "" or "?";
                    local v52 = string.format("%s%s: %s", v44.name, v51, v44.arg_type == "player" and "UserId" or v44.arg_type);
                    if v44.arg_type == "boolean" then
                        v52 = string.format("%s%s: true/false", v44.name, v51);
                    end;
                    table.insert(p35._x672271a6b8bc53c5, {
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
                                table.insert(p35._x672271a6b8bc53c5, {
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
            if u10(p35._x9f6eedf4001654ab, v56.permissions) then
                local v57 = string.lower(v56.command_name);
                local v58 = string.lower(v37 or "");
                if v57:sub(1, #v58) == v58 then
                    table.insert(p35._x672271a6b8bc53c5, {
                        is_hint = false,
                        is_selectable = true,
                        display_text = v56.command_name,
                        autofill_text = v56.command_name
                    });
                end;
            end;
        end;
    end;
    if #p35._x672271a6b8bc53c5 > 1 and (p35._x672271a6b8bc53c5[1].is_selectable == false and p35._x213041e4a4d2bd49 == 1) then
        p35._x213041e4a4d2bd49 = 2;
    end;
    local l___x213041e4a4d2bd49__18 = p35._x213041e4a4d2bd49;
    local v59 = math.max(1, #p35._x672271a6b8bc53c5);
    p35._x213041e4a4d2bd49 = math.clamp(l___x213041e4a4d2bd49__18, 1, v59);
    p35:_x46de5541788ed596();
end;
function u1._x48cc343523ef8aeb(p60) --[[ Line: 345 ]]
    -- upvalues: u34 (copy)
    local v61 = p60._x672271a6b8bc53c5[p60._x213041e4a4d2bd49];
    if v61 and (v61.is_selectable and v61.autofill_text) then
        local l__TextBox__19 = p60._x7eb10a5b6474400e.ConsoleFrame.Editor.TextBox;
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
        p60._x213041e4a4d2bd49 = 1;
        p60:_x9ddd1ed04f346cf7();
    end;
end;
function u1._x4bb0a1c14cbd525c(p65) --[[ Line: 374 ]]
    -- upvalues: l__Packets__5 (copy), l__Promise__6 (copy)
    local l__TextBox__22 = p65._x7eb10a5b6474400e.ConsoleFrame.Editor.TextBox;
    local l__Text__23 = l__TextBox__22.Text;
    p65._xa754dd566874c880 = l__Text__23;
    l__Packets__5._x63a336634450c99d:Fire(l__Text__23);
    l__Promise__6.defer(function() --[[ Line: 380 ]]
        -- upvalues: l__TextBox__22 (copy)
        l__TextBox__22.Text = "";
        l__TextBox__22:CaptureFocus();
    end;
end;
function u1._x3c9e51dbed2a210e(p66) --[[ Line: 386 ]]
    -- upvalues: l__Command__8 (copy), u10 (copy)
    if not p66._x9f6eedf4001654ab or next(p66._x9f6eedf4001654ab) == nil then
        return false;
    end;
    for _, v67 in ipairs(l__Command__8) do
        if u10(p66._x9f6eedf4001654ab, v67.permissions) then
            return true;
        end;
    end;
    return false;
end;
function u1._xd1d505ed70513298(p68) --[[ Line: 402 ]]
    return p68._x9f6eedf4001654ab;
end;
function u1._xa358987510a9c8c9(p69) --[[ Line: 406 ]]
    -- upvalues: l__Packets__5 (copy)
    l__Packets__5._x63a336634450c99d:Fire(p69._xa754dd566874c880);
end;
function u1._xe53615d96cf36a6b(u70) --[[ Line: 410 ]]
    -- upvalues: l__LocalPlayer__10 (copy), l__ContextActionService__1 (copy), l__Packets__5 (copy), l__Promise__6 (copy), l__Classes__9 (copy), l__UserInputService__2 (copy)
    local l___x7eb10a5b6474400e__24 = u70._x7eb10a5b6474400e;
    local l__TextBox__25 = l___x7eb10a5b6474400e__24.ConsoleFrame.Editor.TextBox;
    l___x7eb10a5b6474400e__24.Parent = l__LocalPlayer__10.PlayerGui;
    l__ContextActionService__1:BindActionAtPriority("DisableArrowKeys", function() --[[ Line: 415 ]]
        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Left, Enum.KeyCode.Right);
    l__Packets__5._x63a336634450c99d.OnClientEvent:Connect(function(p71) --[[ Line: 419 ]]
        -- upvalues: l___x7eb10a5b6474400e__24 (copy)
        local v72 = game:GetService("ReplicatedStorage").Assets.UIAssets.OutputText:Clone();
        v72.Text = p71;
        v72.Parent = l___x7eb10a5b6474400e__24.ConsoleFrame.Output;
    end;
    game:GetService("ContextActionService"):UnbindAction("RbxCameraKeypress");
    l__Promise__6.defer(function() --[[ Line: 427 ]]
        -- upvalues: l__Classes__9 (ref), u70 (copy)
        local u73 = l__Classes__9._x7430d6d194f43373:_x57c044514acd3a73("console_roles");
        local function v78() --[[ Line: 430 ]]
            -- upvalues: u73 (copy), u70 (ref)
            u70._x9f6eedf4001654ab = (function(p74) --[[ Name: stringToArray, Line 433 ]]
                local v75 = {};
                for v76 in p74:gmatch("[^,]+") do
                    local v77 = v76:gsub("^%s*(.-)%s*$", "%1");
                    if v77 ~= "" then
                        v75[v77] = true;
                    end;
                end;
                return v75;
            end(u73.Value);
        end;
        u70._x9f6eedf4001654ab = (function(p79) --[[ Name: stringToArray, Line 433 ]]
            local v80 = {};
            for v81 in p79:gmatch("[^,]+") do
                local v82 = v81:gsub("^%s*(.-)%s*$", "%1");
                if v82 ~= "" then
                    v80[v82] = true;
                end;
            end;
            return v80;
        end(u73.Value);
        u73.Changed:Connect(v78);
    end;
    l__TextBox__25:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 455 ]]
        -- upvalues: l__TextBox__25 (copy), u70 (copy)
        if l__TextBox__25.Text:find("\t") then
            l__TextBox__25.Text = l__TextBox__25.Text:gsub("\t", "");
        else
            u70._x213041e4a4d2bd49 = 1;
            if u70._xf180b73116666c39 then
                u70:_x9ddd1ed04f346cf7();
            end;
        end;
    end;
    l__TextBox__25.FocusLost:Connect(function(p83) --[[ Line: 465 ]]
        -- upvalues: u70 (copy), l__Promise__6 (ref), l__TextBox__25 (copy)
        if p83 then
            u70:_x4bb0a1c14cbd525c();
        end;
        if u70._xb3c478bd083d0092 then
            u70._xb3c478bd083d0092 = false;
            l__Promise__6.defer(function() --[[ Line: 471 ]]
                -- upvalues: l__TextBox__25 (ref)
                l__TextBox__25:CaptureFocus();
            end;
        end;
    end;
    l__UserInputService__2.InputBegan:Connect(function(p84, _) --[[ Line: 474 ]]
        -- upvalues: u70 (copy)
        if u70:_x3c9e51dbed2a210e() then
            if p84.KeyCode == Enum.KeyCode.KeypadPlus then
                u70:_xa358987510a9c8c9();
            elseif p84.KeyCode == Enum.KeyCode.Left or p84.KeyCode == Enum.KeyCode.F1 then
                if u70._xf180b73116666c39 then
                    u70:_xa678d776a823bc57();
                else
                    u70:_x585dd74aa0996375();
                end;
            elseif u70._xf180b73116666c39 then
                if #u70._x672271a6b8bc53c5 > 0 then
                    if p84.KeyCode == Enum.KeyCode.Right or p84.KeyCode == Enum.KeyCode.Tab then
                        u70:_x48cc343523ef8aeb();
                        return;
                    end;
                    if p84.KeyCode == Enum.KeyCode.Up then
                        local _ = u70._x672271a6b8bc53c5[1] and u70._x672271a6b8bc53c5[1].is_selectable == false;
                        u70._x213041e4a4d2bd49 = u70._x213041e4a4d2bd49 - 1;
                        if u70._x213041e4a4d2bd49 < (u70._x672271a6b8bc53c5[1].is_selectable and 1 or 2) then
                            u70._x213041e4a4d2bd49 = #u70._x672271a6b8bc53c5;
                        end;
                        u70:_x46de5541788ed596();
                        return;
                    end;
                    if p84.KeyCode == Enum.KeyCode.Down then
                        u70._x213041e4a4d2bd49 = u70._x213041e4a4d2bd49 + 1;
                        if u70._x213041e4a4d2bd49 > #u70._x672271a6b8bc53c5 then
                            u70._x213041e4a4d2bd49 = u70._x672271a6b8bc53c5[1].is_selectable and 1 or 2;
                        end;
                        u70:_x46de5541788ed596();
                    end;
                end;
            end;
        end;
    end;
end;
return u1;
