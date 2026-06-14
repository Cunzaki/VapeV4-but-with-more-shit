-- Decompiled from: StarterGui.PV2Piano.SettingsGui.GuiModule
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

Color3.fromRGB(255, 255, 255);
Color3.fromRGB(84, 84, 84);
Color3.fromRGB(255, 192, 64);
local l__UserInputService__1 = game:GetService("UserInputService");
local u1 = nil;
local u2 = nil;
local v3 = {
    Enabled = false
};
local u4 = TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local l__Parent__2 = script.Parent;
v3.SettingsGui = {
    Gui = l__Parent__2,
    MainFrame = l__Parent__2.MainFrame,
    TitleLabel = l__Parent__2.MainFrame.TitleLabel,
    CloseButton = l__Parent__2.MainFrame.CloseButton,
    BodyFrame = l__Parent__2.MainFrame.BodyFrame,
    ListFrame = l__Parent__2.MainFrame.BodyFrame.ListFrame,
    SettingTemplate = l__Parent__2.MainFrame.BodyFrame.ListFrame.SettingTemplate
};
function v3.ToggleEnabled(p5, p6, p7) --[[ Line: 30 ]]
    if p7 or (type(p6) ~= "boolean" or p6 ~= p5.Enabled) then
        if p6 == nil then
            p6 = not p5.Enabled;
        end;
        p5.Enabled = p6;
        p5.SettingsGui.Gui.Enabled = p5.Enabled;
    end;
end;
function v3.DragFrame(u8, u9, u10) --[[ Line: 36 ]]
    -- upvalues: l__UserInputService__1 (copy)
    u8._dragging = true;
    local u11 = nil;
    local l__Position__3 = u10.Position;
    local l__Position__4 = u9.Position;
    local u14 = l__UserInputService__1.InputChanged:Connect(function(p12) --[[ Line: 42 ]]
        -- upvalues: u8 (copy), l__Position__3 (copy), u9 (copy), l__Position__4 (copy)
        if p12.UserInputType == Enum.UserInputType.MouseMovement and u8._dragging then
            if p12.Position.X + p12.Position.Y == 0 then
                return;
            end;
            local v13 = p12.Position - l__Position__3;
            u9.Position = UDim2.new(l__Position__4.X.Scale, l__Position__4.X.Offset + v13.X, l__Position__4.Y.Scale, l__Position__4.Y.Offset + v13.Y);
        end;
    end);
    u11 = u10.Changed:Connect(function() --[[ Line: 49 ]]
        -- upvalues: u10 (copy), u8 (copy), u14 (ref), u11 (ref)
        if u10.UserInputState == Enum.UserInputState.End then
            u8._dragging = false;
            u14:Disconnect();
            u11:Disconnect();
        end;
    end);
end;
function v3._createSettingButton(p15, u16, u17, p18) --[[ Line: 58 ]]
    -- upvalues: u1 (ref), u2 (ref), u4 (copy)
    local v19 = p15.SettingsGui.SettingTemplate:Clone();
    v19:WaitForChild("TextLabel").Text = p18 or u17;
    local l__ToggleButton__5 = v19:WaitForChild("ToggleButton");
    local l__ButtonHead__6 = l__ToggleButton__5:WaitForChild("ButtonHead");
    l__ToggleButton__5.Activated:Connect(function() --[[ Line: 63 ]]
        -- upvalues: u1 (ref), u16 (copy), u17 (copy), u2 (ref), l__ToggleButton__5 (copy), u4 (ref), l__ButtonHead__6 (copy)
        u1[u16][u17] = not u1[u16][u17];
        local v20 = u1[u16][u17];
        local v21 = u2;
        local v22 = l__ToggleButton__5;
        local v23 = u4;
        local v24 = {};
        local v25;
        if v20 then
            v25 = Color3.fromRGB(51, 160, 255);
        else
            v25 = Color3.fromRGB(128, 128, 128);
        end;
        v24.BackgroundColor3 = v25;
        v21:Play(v22, v23, v24);
        u2:Play(l__ButtonHead__6, u4, {
            AnchorPoint = Vector2.new(v20 and 1 or 0, 0.5),
            Position = UDim2.fromScale(v20 and 1 or 0, 0.5)
        });
    end);
    local v26 = u1[u16][u17];
    local v27;
    if v26 then
        v27 = Color3.fromRGB(51, 160, 255);
    else
        v27 = Color3.fromRGB(128, 128, 128);
    end;
    l__ToggleButton__5.BackgroundColor3 = v27;
    l__ButtonHead__6.AnchorPoint = Vector2.new(v26 and 1 or 0, 0.5);
    l__ButtonHead__6.Position = UDim2.fromScale(v26 and 1 or 0, 0.5);
    v19.Visible = true;
    v19.Parent = p15.SettingsGui.ListFrame;
end;
function v3.Init(p28) --[[ Line: 77 ]]
    -- upvalues: u1 (ref), u2 (ref)
    u1 = script.Parent.Parent:WaitForChild("PianoController");
    u2 = require(u1.Tween);
    u1 = require(u1);
    p28:ToggleEnabled(false, true);
end;
function v3.Start(u29) --[[ Line: 84 ]]
    -- upvalues: u1 (ref)
    u29.SettingsGui.MainFrame.InputBegan:Connect(function(p30) --[[ Line: 85 ]]
        -- upvalues: u29 (copy)
        if p30.UserInputType == Enum.UserInputType.MouseButton1 and u29.Enabled then
            u29:DragFrame(u29.SettingsGui.MainFrame, p30);
        end;
    end);
    u29.SettingsGui.CloseButton.Activated:Connect(function() --[[ Line: 90 ]]
        -- upvalues: u29 (copy)
        u29:ToggleEnabled(false, true);
    end);
    u1.Deactivated:Connect(function() --[[ Line: 93 ]]
        -- upvalues: u29 (copy)
        u29:ToggleEnabled(false, true);
    end);
    u29:_createSettingButton("PianoSettings", "MIDI88", "ctrl key");
    u29:_createSettingButton("PianoSettings", "MIDIVelocity", "alt key");
    u29:_createSettingButton("PianoSettings", "EnableSustainHotkey", "spacebar");
    u29:_createSettingButton("PianoSettings", "EnableShiftLockHotkey", "enter key");
end;
return v3;
