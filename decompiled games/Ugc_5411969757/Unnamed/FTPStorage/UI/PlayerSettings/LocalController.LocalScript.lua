-- Decompiled from: .FTPStorage.UI.PlayerSettings.LocalController
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local u2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 1 ]]
        return game:GetService(p1);
    end
});
local l__TweenService__1 = u2.TweenService;
local l__UserInputService__2 = u2.UserInputService;
local l__PlayerData__3 = u2.Players.LocalPlayer:WaitForChild("PlayerData");
local l__PlayerSettings__4 = u2.ReplicatedStorage:WaitForChild("FTPStorage"):WaitForChild("Remotes"):WaitForChild("PlayerSettings");
local l__ScrollingFrame__5 = script.Parent:WaitForChild("ScrollingFrame");
local l__UIListLayout__6 = l__ScrollingFrame__5:WaitForChild("UIListLayout");
local u3 = {};
local u4 = {
    settings = { l__ScrollingFrame__5:WaitForChild("0_MATERIALS"), l__ScrollingFrame__5:WaitForChild("0_SHADERS") },
    keybinds = { l__ScrollingFrame__5:WaitForChild("1_CHATTOGGLEKEY"), l__ScrollingFrame__5:WaitForChild("1_MENUTOGGLE"), l__ScrollingFrame__5:WaitForChild("1_CURSORTOGGLEKEY") },
    cursores = {
        l__ScrollingFrame__5:WaitForChild("2_CURSORSMAIN"),
        l__ScrollingFrame__5:WaitForChild("2_CURSOREQUIPPED"),
        l__ScrollingFrame__5:WaitForChild("2_CURSORSLOTNAME"),
        l__ScrollingFrame__5:WaitForChild("2_CURSORSLOTID"),
        l__ScrollingFrame__5:WaitForChild("2_CURSORTOGGLE")
    }
};
local l__insert__7 = table.insert;
local u5 = Color3.fromRGB(0, 255, 0);
local u6 = Color3.fromRGB(255, 0, 0);
local u7 = TweenInfo.new(0.5);
local u8 = false;
local u9 = false;
local u10 = nil;
local u11 = 0;
local u12 = {};
local u13 = {
    W = true,
    A = true,
    S = true,
    D = true,
    Q = true,
    E = true,
    F = true,
    C = true,
    R = true
};
local u14 = {};
local function u18(p15) --[[ Line: 88 ]]
    -- upvalues: u14 (ref), u4 (copy), u5 (copy), u6 (copy), l__TweenService__1 (copy), u7 (copy), u3 (copy), l__PlayerSettings__4 (copy), l__insert__7 (copy)
    local l__Materials__8 = u14.Materials;
    local v16 = l__Materials__8 == nil and true or l__Materials__8;
    local l__Shaders__9 = u14.Shaders;
    local v17 = l__Shaders__9 == nil and true or l__Shaders__9;
    l__TweenService__1:Create(u4.settings[1].TEST.TEST, u7, {
        BackgroundColor3 = v16 == true and u5 or u6
    }):Play();
    u4.settings[1].TEST.TextLabel.Text = v16 == true and "ENABLED" or "DISABLED";
    l__TweenService__1:Create(u4.settings[2].TEST.TEST, u7, {
        BackgroundColor3 = v17 == true and u5 or u6
    }):Play();
    u4.settings[2].TEST.TextLabel.Text = v17 == true and "ENABLED" or "DISABLED";
    if p15 == true then
        l__insert__7(u3, #u3 + 1, u4.settings[1]:WaitForChild("MAIN_BOTON").MouseButton1Click:connect(function() --[[ Line: 101 ]]
            -- upvalues: u14 (ref), l__PlayerSettings__4 (ref)
            local l__Materials__10 = u14.Materials;
            l__PlayerSettings__4:FireServer("setmaterials", l__Materials__10 ~= nil and not l__Materials__10 and true or false);
        end));
        l__insert__7(u3, #u3 + 1, u4.settings[2]:WaitForChild("MAIN_BOTON").MouseButton1Click:connect(function() --[[ Line: 106 ]]
            -- upvalues: u14 (ref), l__PlayerSettings__4 (ref)
            local l__Shaders__11 = u14.Shaders;
            l__PlayerSettings__4:FireServer("setshaders", l__Shaders__11 ~= nil and not l__Shaders__11 and true or false);
        end));
    end;
end;
local function v44(p19) --[[ Line: 115 ]]
    -- upvalues: u14 (ref), u4 (copy), u3 (copy), u10 (ref), l__UserInputService__2 (copy), u13 (copy), l__PlayerSettings__4 (copy), l__insert__7 (copy)
    local l__ChatToggleKey__12 = u14.Keybinds.ChatToggleKey;
    local v20 = l__ChatToggleKey__12 == nil and "Z" or tostring(l__ChatToggleKey__12);
    u4.keybinds[1].Options.Center.TextLabel.Text = v20;
    local l__MenuToggleKey__13 = u14.Keybinds.MenuToggleKey;
    local v21 = l__MenuToggleKey__13 == nil and "M" or tostring(l__MenuToggleKey__13);
    u4.keybinds[2].Options.Center.TextLabel.Text = v21;
    local l__CursorToggleKey__14 = u14.Keybinds.CursorToggleKey;
    local v22 = l__CursorToggleKey__14 == nil and "Z" or tostring(l__CursorToggleKey__14);
    u4.keybinds[3].Options.Center.TextLabel.Text = v22;
    if p19 == true then
        l__insert__7(u3, #u3 + 1, u4.keybinds[1]:WaitForChild("Options").Center.MouseButton1Click:connect(function() --[[ Line: 134 ]]
            -- upvalues: u10 (ref), u4 (ref), l__UserInputService__2 (ref), u14 (ref), u13 (ref), l__PlayerSettings__4 (ref)
            if u10 ~= nil then
                u10:disconnect();
                u10 = nil;
            end;
            u4.keybinds[1]:WaitForChild("Options").Center.TextLabel.Text = "Press Any Key";
            u10 = l__UserInputService__2.InputBegan:connect(function(p23, _) --[[ Line: 138 ]]
                -- upvalues: u14 (ref), u13 (ref), u4 (ref), l__PlayerSettings__4 (ref), u10 (ref)
                if p23.UserInputType == Enum.UserInputType.Keyboard then
                    local l__Name__15 = p23.KeyCode.Name;
                    local l__Keybinds__16 = u14.Keybinds;
                    local v24 = tostring(l__Name__15);
                    local v25 = l__Keybinds__16.MenuToggleKey == nil and "M" or l__Keybinds__16.MenuToggleKey;
                    local v26 = l__Keybinds__16.CursorToggleKey == nil and "X" or l__Keybinds__16.CursorToggleKey;
                    local v27 = l__Keybinds__16.ChatToggleKey == nil and "Z" or l__Keybinds__16.ChatToggleKey;
                    local v28;
                    if u13[v24] == nil and (v24 ~= v25 and v24 ~= v26) then
                        v28 = v24 ~= v27 and true or nil;
                    else
                        v28 = nil;
                    end;
                    if v28 == true then
                        u4.keybinds[1]:WaitForChild("Options").Center.TextLabel.Text = l__Name__15;
                        l__PlayerSettings__4:FireServer("setchattogglekey", p23.KeyCode);
                        u10:disconnect();
                        return;
                    end;
                    local l__ChatToggleKey__17 = u14.Keybinds.ChatToggleKey;
                    local v29 = l__ChatToggleKey__17 == nil and "Z" or l__ChatToggleKey__17;
                    u4.keybinds[1]:WaitForChild("Options").Center.TextLabel.Text = v29;
                    u10:disconnect();
                end;
            end);
        end));
        l__insert__7(u3, #u3 + 1, u4.keybinds[2]:WaitForChild("Options").Center.MouseButton1Click:connect(function() --[[ Line: 156 ]]
            -- upvalues: u10 (ref), u4 (ref), l__UserInputService__2 (ref), u14 (ref), u13 (ref), l__PlayerSettings__4 (ref)
            if u10 ~= nil then
                u10:disconnect();
                u10 = nil;
            end;
            u4.keybinds[2]:WaitForChild("Options").Center.TextLabel.Text = "Press Any Key";
            u10 = l__UserInputService__2.InputBegan:connect(function(p30, _) --[[ Line: 160 ]]
                -- upvalues: u14 (ref), u13 (ref), u4 (ref), l__PlayerSettings__4 (ref), u10 (ref)
                if p30.UserInputType == Enum.UserInputType.Keyboard then
                    local l__Name__18 = p30.KeyCode.Name;
                    local l__Keybinds__19 = u14.Keybinds;
                    local v31 = tostring(l__Name__18);
                    local v32 = l__Keybinds__19.MenuToggleKey == nil and "M" or l__Keybinds__19.MenuToggleKey;
                    local v33 = l__Keybinds__19.CursorToggleKey == nil and "X" or l__Keybinds__19.CursorToggleKey;
                    local v34 = l__Keybinds__19.ChatToggleKey == nil and "Z" or l__Keybinds__19.ChatToggleKey;
                    local v35;
                    if u13[v31] == nil and (v31 ~= v32 and v31 ~= v33) then
                        v35 = v31 ~= v34 and true or nil;
                    else
                        v35 = nil;
                    end;
                    if v35 == true then
                        u4.keybinds[2]:WaitForChild("Options").Center.TextLabel.Text = l__Name__18;
                        l__PlayerSettings__4:FireServer("setmenutogglekey", p30.KeyCode);
                        u10:disconnect();
                        return;
                    end;
                    local l__MenuToggleKey__20 = u14.Keybinds.MenuToggleKey;
                    local v36 = l__MenuToggleKey__20 == nil and "M" or l__MenuToggleKey__20;
                    u4.keybinds[2]:WaitForChild("Options").Center.TextLabel.Text = v36;
                    u10:disconnect();
                end;
            end);
        end));
        l__insert__7(u3, #u3 + 1, u4.keybinds[3]:WaitForChild("Options").Center.MouseButton1Click:connect(function() --[[ Line: 178 ]]
            -- upvalues: u10 (ref), u4 (ref), l__UserInputService__2 (ref), u14 (ref), u13 (ref), l__PlayerSettings__4 (ref)
            if u10 ~= nil then
                u10:disconnect();
                u10 = nil;
            end;
            u4.keybinds[3]:WaitForChild("Options").Center.TextLabel.Text = "Press Any Key";
            u10 = l__UserInputService__2.InputBegan:connect(function(p37, _) --[[ Line: 182 ]]
                -- upvalues: u14 (ref), u13 (ref), u4 (ref), l__PlayerSettings__4 (ref), u10 (ref)
                if p37.UserInputType == Enum.UserInputType.Keyboard then
                    local l__Name__21 = p37.KeyCode.Name;
                    local l__Keybinds__22 = u14.Keybinds;
                    local v38 = tostring(l__Name__21);
                    local v39 = l__Keybinds__22.MenuToggleKey == nil and "M" or l__Keybinds__22.MenuToggleKey;
                    local v40 = l__Keybinds__22.CursorToggleKey == nil and "X" or l__Keybinds__22.CursorToggleKey;
                    local v41 = l__Keybinds__22.ChatToggleKey == nil and "Z" or l__Keybinds__22.ChatToggleKey;
                    local v42;
                    if u13[v38] == nil and (v38 ~= v39 and v38 ~= v40) then
                        v42 = v38 ~= v41 and true or nil;
                    else
                        v42 = nil;
                    end;
                    if v42 == true then
                        u4.keybinds[3]:WaitForChild("Options").Center.TextLabel.Text = l__Name__21;
                        l__PlayerSettings__4:FireServer("setcursortogglekey", p37.KeyCode);
                        u10:disconnect();
                        return;
                    end;
                    local l__CursorToggleKey__23 = u14.Keybinds.CursorToggleKey;
                    local v43 = l__CursorToggleKey__23 == nil and "X" or l__CursorToggleKey__23;
                    u4.keybinds[3]:WaitForChild("Options").Center.TextLabel.Text = v43;
                    u10:disconnect();
                end;
            end);
        end));
    end;
end;
local function u53(p45) --[[ Line: 202 ]]
    -- upvalues: u3 (copy), u14 (ref), u11 (ref), u12 (ref), u4 (copy), u8 (ref), l__PlayerSettings__4 (copy), l__insert__7 (copy), u9 (ref), u5 (copy), u6 (copy), l__TweenService__1 (copy), u7 (copy)
    local v46 = u3.cursors or {};
    local _ = u14.Cursores.Default == nil;
    local l__Default__24 = u14.Cursores.Default;
    local v47 = u14.Cursores.Toggle == nil and true or u14.Cursores.Toggle;
    local _ = u14.Cursores.Equipped or 0;
    local _ = u14.Cursores.Stored;
    local l__Equipped__25 = u14.Cursores.Equipped;
    u11 = l__Equipped__25 == nil and 1 or l__Equipped__25;
    u12 = u14.Cursores.Stored[tostring(u11)] or {};
    if p45 == true then
        for _, v48 in pairs(v46.cursors or {}) do
            v48:disconnect();
        end;
        v46.cursors = {};
        local v49 = u4.cursores[1]:WaitForChild("MAIN_BOTON").MouseButton1Click:connect(function() --[[ Line: 218 ]]
            -- upvalues: u8 (ref), l__PlayerSettings__4 (ref)
            warn("omg pressed");
            u8 = not u8;
            l__PlayerSettings__4:FireServer("setlocalcursorbool", u8);
        end);
        l__insert__7(v46.cursors, #v46.cursors + 1, u4.cursores[3].ImageLabel.TextBox.Focused:connect(function() --[[ Line: 224 ]]
            -- upvalues: u4 (ref)
            u4.cursores[3].ImageLabel.Aviso.Visible = true;
        end));
        l__insert__7(v46.cursors, #v46.cursors + 1, u4.cursores[3].ImageLabel.TextBox.FocusLost:connect(function(p50) --[[ Line: 228 ]]
            -- upvalues: u4 (ref), l__PlayerSettings__4 (ref), u11 (ref), u12 (ref)
            u4.cursores[3].ImageLabel.Aviso.Visible = false;
            local l__Text__26 = u4.cursores[3].ImageLabel.TextBox.Text;
            if p50 == true then
                l__PlayerSettings__4:FireServer("setslot", u11, l__Text__26);
            else
                u4.cursores[3].ImageLabel.TextBox.Text = u12.name == nil and "Unnamed" or u12.name;
            end;
        end));
        l__insert__7(v46.cursors, #v46.cursors + 1, u4.cursores[4].ImageLabel.TextBox.Focused:connect(function() --[[ Line: 240 ]]
            -- upvalues: u4 (ref)
            u4.cursores[4].ImageLabel.Aviso.Visible = true;
        end));
        l__insert__7(v46.cursors, #v46.cursors + 1, u4.cursores[4].ImageLabel.TextBox.FocusLost:connect(function(p51) --[[ Line: 244 ]]
            -- upvalues: u4 (ref), l__PlayerSettings__4 (ref), u11 (ref), u12 (ref)
            u4.cursores[4].ImageLabel.Aviso.Visible = false;
            local l__Text__27 = u4.cursores[4].ImageLabel.TextBox.Text;
            if p51 == true then
                l__PlayerSettings__4:FireServer("setslot", u11, nil, l__Text__27);
            else
                u4.cursores[4].ImageLabel.TextBox.Text = u12.id == nil and "" or u12.id;
            end;
        end));
        l__insert__7(v46.cursors, #v46.cursors + 1, u4.cursores[2].Options.Derecha.MouseButton1Click:connect(function(_) --[[ Line: 255 ]]
            -- upvalues: l__PlayerSettings__4 (ref)
            l__PlayerSettings__4:FireServer("setnextcursorequipped");
        end));
        l__insert__7(v46.cursors, #v46.cursors + 1, u4.cursores[2].Options.Izquierda.MouseButton1Click:connect(function(_) --[[ Line: 259 ]]
            -- upvalues: l__PlayerSettings__4 (ref)
            l__PlayerSettings__4:FireServer("setpreviouscursorequipped");
        end));
        local v52 = u4.cursores[5]:WaitForChild("MAIN_BOTON").MouseButton1Click:connect(function() --[[ Line: 264 ]]
            -- upvalues: u9 (ref), l__PlayerSettings__4 (ref)
            u9 = not u9;
            l__PlayerSettings__4:FireServer("setcursortoggle", u9);
        end);
        l__insert__7(v46.cursors, #v46.cursors + 1, v49);
        l__insert__7(v46.cursors, #v46.cursors + 1, v52);
    end;
    local l__TEST__28 = u4.cursores[1]:WaitForChild("TEST");
    local l__TextLabel__29 = l__TEST__28:WaitForChild("TextLabel");
    local l__TEST__30 = l__TEST__28:WaitForChild("TEST");
    u8 = l__Default__24;
    u9 = v47;
    u4.cursores[2].Options.Center.TextLabel.Text = tostring(u11) .. ". " .. (u12.name == nil and "Unnamed" or u12.name);
    u4.cursores[3].ImageLabel.TextBox.Text = u12.name == nil and "Unnamed" or u12.name;
    u4.cursores[4].ImageLabel.TextBox.Text = u12.id == nil and "" or u12.id;
    if l__Default__24 then
        u4.cursores[2].Visible = true;
        u4.cursores[3].Visible = true;
        u4.cursores[4].Visible = true;
        u4.cursores[5].Visible = true;
        l__TweenService__1:Create(u4.cursores[5].TEST.TEST, u7, {
            BackgroundColor3 = v47 == true and u5 or u6
        }):Play();
        u4.cursores[5].TEST.TextLabel.Text = v47 == true and "ENABLED" or "DISABLED";
        l__TextLabel__29.Text = "ENABLED";
        l__TweenService__1:Create(l__TEST__30, u7, {
            BackgroundColor3 = u5
        }):Play();
    else
        u4.cursores[2].Visible = false;
        u4.cursores[3].Visible = false;
        u4.cursores[4].Visible = false;
        u4.cursores[5].Visible = false;
        l__TextLabel__29.Text = "DISABLED";
        l__TweenService__1:Create(l__TEST__30, u7, {
            BackgroundColor3 = u6
        }):Play();
    end;
end;
u14 = u2.HttpService:JSONDecode(l__PlayerData__3.Value);
u53(true);
v44(true);
u18(true);
l__PlayerData__3.Changed:connect(function() --[[ Line: 329 ]]
    -- upvalues: u2 (copy), l__PlayerData__3 (copy), u14 (ref), u53 (copy), u4 (copy), u18 (copy)
    u14 = u2.HttpService:JSONDecode(l__PlayerData__3.Value);
    u53(false);
    local l__ChatToggleKey__31 = u14.Keybinds.ChatToggleKey;
    local v54 = l__ChatToggleKey__31 == nil and "Z" or tostring(l__ChatToggleKey__31);
    u4.keybinds[1].Options.Center.TextLabel.Text = v54;
    local l__MenuToggleKey__32 = u14.Keybinds.MenuToggleKey;
    local v55 = l__MenuToggleKey__32 == nil and "M" or tostring(l__MenuToggleKey__32);
    u4.keybinds[2].Options.Center.TextLabel.Text = v55;
    local l__CursorToggleKey__33 = u14.Keybinds.CursorToggleKey;
    local v56 = l__CursorToggleKey__33 == nil and "Z" or tostring(l__CursorToggleKey__33);
    u4.keybinds[3].Options.Center.TextLabel.Text = v56;
    u18(false);
end);
l__UIListLayout__6:GetPropertyChangedSignal("AbsoluteContentSize"):connect(function() --[[ Line: 350 ]]
    -- upvalues: l__UIListLayout__6 (copy), l__ScrollingFrame__5 (copy)
    l__ScrollingFrame__5.CanvasSize = UDim2.new(0, 0, 0, l__UIListLayout__6.AbsoluteContentSize.Y + 5);
end);
l__ScrollingFrame__5.CanvasSize = UDim2.new(0, 0, 0, l__UIListLayout__6.AbsoluteContentSize.Y + 5);
