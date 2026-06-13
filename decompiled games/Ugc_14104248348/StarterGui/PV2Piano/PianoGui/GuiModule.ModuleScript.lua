-- Decompiled from: StarterGui.PV2Piano.PianoGui.GuiModule
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__UserInputService__2 = game:GetService("UserInputService");
local u1 = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local u2 = TweenInfo.new(0.1, Enum.EasingStyle.Quint);
local u3 = {
    Enabled = false,
    Minimized = false,
    Is88 = false,
    ShowContext = false,
    _dragging = false,
    _resizing = false,
    _TRANSPOSITION_INCREMENT = 1,
    _VOLUME_INCREMENT = 0.1,
    _MIN_ANIMATION_DURATION = 0,
    _MAX_ANIMATION_DURATION = 4,
    _BUTTON_EFFECT_DELAY = 0.1,
    _animatedKeys = {},
    _connections = {},
    ColorSettings = {
        IconColor = Color3.fromRGB(255, 255, 255),
        InactiveButtonColor = Color3.fromRGB(255, 255, 255),
        BacklightColor = Color3.fromRGB(20, 20, 20),
        ActiveButtonColor = Color3.fromRGB(170, 170, 170),
        ActiveBacklightColor = Color3.fromRGB(51, 160, 255),
        ActiveWhiteKeyColor = Color3.fromRGB(0, 255, 0),
        ActiveBlackKeyColor = Color3.fromRGB(0, 255, 0),
        WhiteKeyColor = Color3.fromRGB(255, 255, 255),
        BlackKeyColor = Color3.fromRGB(0, 0, 0)
    }
};
local l__Parent__3 = script.Parent;
u3.PianoGui = {
    Gui = l__Parent__3,
    PianoKeys = {},
    VelocityFrame = l__Parent__3.MainFrame.TopFrame.VelocityFrame,
    VelocityBar = l__Parent__3.MainFrame.TopFrame.VelocityFrame.BarFrame.VelocityBar,
    MainFrame = l__Parent__3.MainFrame,
    MainFrameAspectRatio = l__Parent__3.MainFrame.UIAspectRatioConstraint,
    TopFrame = l__Parent__3.MainFrame.TopFrame,
    ShadowFrame = l__Parent__3.MainFrame.ShadowFrame,
    KeyFrame = l__Parent__3.MainFrame.TopFrame.KeyFrame,
    Keys = l__Parent__3.MainFrame.TopFrame.KeyFrame.Keys,
    Border = l__Parent__3.MainFrame.TopFrame.KeyFrame.Border,
    Toggle88Button = l__Parent__3.MainFrame.TopFrame.DisplayFrame.Toggle88,
    LCDFrame = l__Parent__3.MainFrame.TopFrame.DisplayFrame.MonitorFrame.LCDBorderFrame.LCDFrame,
    MonitorInlayFrame = l__Parent__3.MainFrame.TopFrame.DisplayFrame.MonitorFrame.MonitorInlayFrame,
    SheetsButton = l__Parent__3.MainFrame.TopFrame.DisplayFrame.LeftButtonFrame.Sheets.ImageButton,
    SheetsFrame = l__Parent__3.SheetsFrame,
    ResizeButton = l__Parent__3.SheetsFrame.Resize,
    HomeButton = l__Parent__3.SheetsFrame.Home.HomeButton,
    SheetBox = l__Parent__3.SheetsFrame.ScrollingFrame.SheetBox,
    FontPlusButton = l__Parent__3.SheetsFrame.FontPlus,
    FontMinusButton = l__Parent__3.SheetsFrame.FontMinus,
    SoundFontButton = l__Parent__3.MainFrame.TopFrame.DisplayFrame.LeftButtonFrame.SoundFont.ImageButton,
    TranspositionDownButton = l__Parent__3.MainFrame.TopFrame.DisplayFrame.LeftButtonFrame.TranspositionDown.ImageButton,
    TranspositionUpButton = l__Parent__3.MainFrame.TopFrame.DisplayFrame.LeftButtonFrame.TranspositionUp.ImageButton,
    TranspositionLabel = l__Parent__3.MainFrame.TopFrame.DisplayFrame.MonitorFrame.LCDBorderFrame.LCDFrame.TranspositionLabel,
    TranspositionNumber = l__Parent__3.MainFrame.TopFrame.DisplayFrame.MonitorFrame.LCDBorderFrame.LCDFrame.TranspositionLabel.TranspositionNumber,
    TranspositionIcon = l__Parent__3.MainFrame.TopFrame.DisplayFrame.LeftButtonFrame.TranspositionIcon,
    ShiftLockButton = l__Parent__3.MainFrame.TopFrame.DisplayFrame.LeftButtonFrame.TranspositionIcon.ShiftLock,
    VolumeDownButton = l__Parent__3.MainFrame.TopFrame.DisplayFrame.RightButtonFrame.VolumeDown.ImageButton,
    VolumeUpButton = l__Parent__3.MainFrame.TopFrame.DisplayFrame.RightButtonFrame.VolumeUp.ImageButton,
    VolumeLabel = l__Parent__3.MainFrame.TopFrame.DisplayFrame.MonitorFrame.LCDBorderFrame.LCDFrame.VolumeLabel,
    VolumeNumber = l__Parent__3.MainFrame.TopFrame.DisplayFrame.MonitorFrame.LCDBorderFrame.LCDFrame.VolumeLabel.VolumeNumber,
    VolumeIcon = l__Parent__3.MainFrame.TopFrame.DisplayFrame.RightButtonFrame.VolumeIcon,
    SustainButton = l__Parent__3.MainFrame.TopFrame.DisplayFrame.RightButtonFrame.Sustain.ImageButton,
    SustainLight = l__Parent__3.MainFrame.TopFrame.DisplayFrame.RightButtonFrame.Sustain.SustainLight.Lightblur,
    SettingsButton = l__Parent__3.MainFrame.TopFrame.DisplayFrame.RightButtonFrame.Settings.ImageButton,
    ContextButton = l__Parent__3.MainFrame.TopFrame.DisplayFrame.RightButtonFrame.Context.ImageButton,
    ExitButton = l__Parent__3.MainFrame.TopFrame.DisplayFrame.RightButtonFrame.Exit.ImageButton,
    MinimizeButton = l__Parent__3.MainFrame.TopFrame.Minimize,
    _SHEETS_RESIZE_CONSTRAINT = Vector2.new(200, 200),
    _ORIGINAL_SHEETS_POSITION = l__Parent__3.SheetsFrame.Position,
    _ORIGINAL_SHEETS_SIZE = l__Parent__3.SheetsFrame.Size,
    _ORIGINAL_SHEETS_TEXT_SIZE = l__Parent__3.SheetsFrame.ScrollingFrame.SheetBox.TextSize
};
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
for v8 = 1, 88 do
    table.insert(u3.PianoGui.PianoKeys, u3.PianoGui.KeyFrame.Keys:FindFirstChild(v8));
end;
u3._buttons = {
    u3.PianoGui.SheetsButton,
    u3.PianoGui.SoundFontButton,
    u3.PianoGui.TranspositionDownButton,
    u3.PianoGui.TranspositionUpButton,
    u3.PianoGui.VolumeDownButton,
    u3.PianoGui.VolumeUpButton,
    u3.PianoGui.SustainButton,
    u3.PianoGui.SettingsButton,
    u3.PianoGui.ContextButton,
    u3.PianoGui.ExitButton
};
function u3.ToggleEnabled(p9, p10, p11) --[[ Line: 139 ]]
    if p11 or (type(p10) ~= "boolean" or p10 ~= p9.Enabled) then
        if p10 == nil then
            p10 = not p9.Enabled;
        end;
        p9.Enabled = p10;
        p9.PianoGui.Gui.Enabled = p9.Enabled;
    end;
end;
function u3.Toggle88Keys(p12, p13, p14) --[[ Line: 145 ]]
    -- upvalues: u5 (ref), u1 (copy)
    if p14 or (type(p13) ~= "boolean" or p13 ~= p12.Is88) then
        if p13 == nil then
            p13 = not p12.Is88;
        end;
        p12.Is88 = p13;
        u5:Play(p12.PianoGui.MainFrameAspectRatio, u1, {
            AspectRatio = p12.Is88 and 4.3 or 3
        });
        u5:Play(p12.PianoGui.KeyFrame, u1, {
            Size = UDim2.fromScale(p12.Is88 and 0.96 or 0.95, 0.48)
        });
        u5:Play(p12.PianoGui.Keys, u1, {
            Position = UDim2.fromScale(p12.Is88 and 0.518 or 0.5, 1)
        });
        local v15 = p12.PianoGui.PianoKeys[77];
        u5:Play(v15, u1, {
            Transparency = p12.Is88 and 0 or 1
        });
        u5:Play(v15.NoteLabel, u1, {
            TextTransparency = p12.Is88 and 0 or 1
        });
        p12.PianoGui.Toggle88Button.ImageColor3 = p12.Is88 and p12.ColorSettings.ActiveBacklightColor or Color3.fromRGB(128, 128, 128);
        p12:ResetKeys();
    end;
end;
function u3.ToggleMinimized(p16, p17, p18) --[[ Line: 159 ]]
    -- upvalues: u5 (ref), u1 (copy)
    if p18 or (type(p17) ~= "boolean" or p17 ~= p16.Minimized) then
        if p17 == nil then
            p17 = not p16.Minimized;
        end;
        p16.Minimized = p17;
        local l__MainFrame__4 = p16.PianoGui.MainFrame;
        if p16.Enabled then
            local v19 = u5;
            local v20 = u1;
            local v21 = {};
            local v22;
            if p16.Minimized then
                v22 = UDim2.new(0.5, 0, 1, 0);
            else
                v22 = UDim2.new(0.5, 0, 1, -35);
            end;
            v21.Position = v22;
            v21.AnchorPoint = Vector2.new(0.5, p16.Minimized and 0 or 1);
            v19:Play(l__MainFrame__4, v20, v21);
        else
            l__MainFrame__4.Position = p16.Minimized and UDim2.new(0.5, 0, 1, l__MainFrame__4.AbsoluteSize.Y) or UDim2.new(0.5, 0, 1, -35);
            l__MainFrame__4.AnchorPoint = Vector2.new(0.5, p16.Minimized and 0 or 1);
        end;
    end;
end;
function u3.ToggleContext(p23, p24, p25) --[[ Line: 171 ]]
    if p25 or (type(p24) ~= "boolean" or p24 ~= p23.ShowContext) then
        if p24 == nil then
            p24 = not p23.ShowContext;
        end;
        p23.ShowContext = p24;
        for _, v26 in ipairs(p23._buttons) do
            local v27 = v26.Parent:FindFirstChild("ContextLabel");
            if v27 then
                v27.Visible = p23.ShowContext;
            end;
        end;
        p23.PianoGui.Toggle88Button.ContextLabel.Visible = p23.ShowContext;
        p23.PianoGui.MinimizeButton.ContextLabel.Visible = p23.ShowContext;
        p23:AnimateButtonToggle(p23.PianoGui.ContextButton, p23.ShowContext);
    end;
end;
function u3.AnimateVelocityChange(p28, p29, p30) --[[ Line: 184 ]]
    -- upvalues: u5 (ref), u2 (copy)
    if not p28.PianoGui.VelocityFrame.Visible then
        p28.PianoGui.VelocityFrame.Visible = true;
    end;
    u5:Play(p28.PianoGui.VelocityBar, u2, {
        Size = UDim2.new(p29 / p30, 0, 1, 0)
    });
end;
function u3.AnimateButtonPress(u31, u32) --[[ Line: 189 ]]
    local l__Parent__5 = u32.Parent;
    if u32.ImageColor3 ~= u31.ColorSettings.ActiveButtonColor then
        u32.ImageColor3 = u31.ColorSettings.ActiveButtonColor;
        l__Parent__5.ImageColor3 = u31.ColorSettings.ActiveBacklightColor;
        task.delay(u31._BUTTON_EFFECT_DELAY, function() --[[ Line: 195 ]]
            -- upvalues: u32 (copy), u31 (copy), l__Parent__5 (copy)
            u32.ImageColor3 = u31.ColorSettings.InactiveButtonColor;
            l__Parent__5.ImageColor3 = u31.ColorSettings.BacklightColor;
        end);
    end;
end;
function u3.AnimateButtonToggle(p33, p34, p35) --[[ Line: 202 ]]
    local l__Parent__6 = p34.Parent;
    if p35 == true or p35 == nil and p34.ImageColor3 ~= p33.ColorSettings.ActiveButtonColor then
        p34.ImageColor3 = p33.ColorSettings.ActiveButtonColor;
        l__Parent__6.ImageColor3 = p33.ColorSettings.ActiveBacklightColor;
    else
        p34.ImageColor3 = p33.ColorSettings.InactiveButtonColor;
        l__Parent__6.ImageColor3 = p33.ColorSettings.BacklightColor;
    end;
end;
function u3.AnimateSustainToggle(p36, p37) --[[ Line: 213 ]]
    p36.PianoGui.SustainLight.Visible = p37;
end;
function u3.AnimateShiftLockToggle(p38, p39) --[[ Line: 217 ]]
    p38.PianoGui.TranspositionIcon.ImageColor3 = p39 and p38.ColorSettings.ActiveBacklightColor or p38.ColorSettings.IconColor;
    p38.PianoGui.ShiftLockButton.TextColor3 = p39 and p38.ColorSettings.ActiveBacklightColor or Color3.fromRGB(64, 64, 64);
    p38.PianoGui.ShiftLockButton.Visible = p39;
end;
function u3.ChangeSheetsTextSize(p40, p41, p42) --[[ Line: 223 ]]
    p40.PianoGui.SheetBox.TextSize = math.max(1, p41 + p40.PianoGui.SheetBox.TextSize * (p42 and 0 or 1));
end;
function u3.DragFrame(u43, u44, u45) --[[ Line: 227 ]]
    -- upvalues: l__UserInputService__2 (copy)
    u43._dragging = true;
    local u46 = nil;
    local l__Position__7 = u45.Position;
    local l__Position__8 = u44.Position;
    local u49 = l__UserInputService__2.InputChanged:Connect(function(p47) --[[ Line: 233 ]]
        -- upvalues: u43 (copy), l__Position__7 (copy), u44 (copy), l__Position__8 (copy)
        if p47.UserInputType == Enum.UserInputType.MouseMovement and (u43._dragging and not u43._resizing) then
            if p47.Position.X + p47.Position.Y == 0 then
                return;
            end;
            local v48 = p47.Position - l__Position__7;
            u44.Position = UDim2.new(l__Position__8.X.Scale, l__Position__8.X.Offset + v48.X, l__Position__8.Y.Scale, l__Position__8.Y.Offset + v48.Y);
        end;
    end);
    u46 = u45.Changed:Connect(function() --[[ Line: 240 ]]
        -- upvalues: u45 (copy), u43 (copy), u49 (ref), u46 (ref)
        if u45.UserInputState == Enum.UserInputState.End then
            u43._dragging = false;
            u49:Disconnect();
            u46:Disconnect();
        end;
    end);
end;
function u3.ResizeSheetsFrame(u50, u51) --[[ Line: 249 ]]
    -- upvalues: l__UserInputService__2 (copy)
    local l__SheetsFrame__9 = u50.PianoGui.SheetsFrame;
    local l___SHEETS_RESIZE_CONSTRAINT__10 = u50.PianoGui._SHEETS_RESIZE_CONSTRAINT;
    u50._resizing = true;
    local u52 = nil;
    local l__Position__11 = u51.Position;
    local l__Size__12 = l__SheetsFrame__9.Size;
    local l__Position__13 = l__SheetsFrame__9.Position;
    local u55 = l__UserInputService__2.InputChanged:Connect(function(p53) --[[ Line: 258 ]]
        -- upvalues: u50 (copy), l__Position__11 (copy), l__SheetsFrame__9 (copy), l__Size__12 (copy), l___SHEETS_RESIZE_CONSTRAINT__10 (copy), l__Position__13 (copy)
        if p53.UserInputType == Enum.UserInputType.MouseMovement and u50._resizing then
            if p53.Position.X + p53.Position.Y == 0 then
                return;
            end;
            local v54 = p53.Position - l__Position__11;
            l__SheetsFrame__9.Size = UDim2.new(l__Size__12.X.Scale, l__Size__12.X.Offset + v54.X > l___SHEETS_RESIZE_CONSTRAINT__10.X and l__Size__12.X.Offset + v54.X or l___SHEETS_RESIZE_CONSTRAINT__10.X, l__Size__12.Y.Scale, l__Size__12.Y.Offset + v54.Y > l___SHEETS_RESIZE_CONSTRAINT__10.Y and l__Size__12.Y.Offset + v54.Y or l___SHEETS_RESIZE_CONSTRAINT__10.Y);
            l__SheetsFrame__9.Position = UDim2.new(l__Position__13.X.Scale, l__Size__12.X.Offset + v54.X > l___SHEETS_RESIZE_CONSTRAINT__10.X and l__Position__13.X.Offset + v54.X / 2 or l__Position__13.X.Offset + (l___SHEETS_RESIZE_CONSTRAINT__10.X - l__Size__12.X.Offset) / 2, l__Position__13.Y.Scale, l__Size__12.Y.Offset + v54.Y > l___SHEETS_RESIZE_CONSTRAINT__10.Y and l__Position__13.Y.Offset + v54.Y / 2 or l__Position__13.Y.Offset + (l___SHEETS_RESIZE_CONSTRAINT__10.Y - l__Size__12.Y.Offset) / 2);
        end;
    end);
    u52 = u51.Changed:Connect(function() --[[ Line: 268 ]]
        -- upvalues: u51 (copy), u50 (copy), u55 (ref), u52 (ref)
        if u51.UserInputState == Enum.UserInputState.End then
            u50._resizing = false;
            u55:Disconnect();
            u52:Disconnect();
        end;
    end);
end;
function u3.ResetSheetsFrame(p56) --[[ Line: 277 ]]
    p56.PianoGui.SheetsFrame.Position = p56.PianoGui._ORIGINAL_SHEETS_POSITION;
    p56.PianoGui.SheetsFrame.Size = p56.PianoGui._ORIGINAL_SHEETS_SIZE;
    p56:ChangeSheetsTextSize(p56.PianoGui._ORIGINAL_SHEETS_TEXT_SIZE, true);
end;
function u3.AnimateKeyDown(p57, p58, p59) --[[ Line: 283 ]]
    -- upvalues: l__RunService__1 (copy)
    local v60 = math.clamp(p59 + 15, (p57.Is88 and 0 or 15) + 1, 88 - (p57.Is88 and 0 or 12));
    p57._animatedKeys[v60] = p58;
    local v61 = p57.PianoGui.PianoKeys[v60];
    local v62 = (v60 - 1) % 12 + 1;
    local v63;
    if (v62 % 12 == 2 or (v62 % 12 == 5 or (v62 % 12 == 7 or (v62 % 12 == 10 or v62 % 12 == 0)))) and true or nil then
        v63 = p57.ColorSettings.ActiveBlackKeyColor;
    else
        v63 = p57.ColorSettings.ActiveWhiteKeyColor;
    end;
    v61.BackgroundColor3 = v63;
    local v64 = 0;
    while p57._animatedKeys[v60] ~= p58 and v64 < p57._MIN_ANIMATION_DURATION or p57._animatedKeys[v60] == p58 and v64 < p57._MAX_ANIMATION_DURATION do
        v64 = v64 + l__RunService__1.Heartbeat:Wait();
    end;
    local v65 = p57.PianoGui.PianoKeys[v60];
    local v66 = (v60 - 1) % 12 + 1;
    local v67;
    if (v66 % 12 == 2 or (v66 % 12 == 5 or (v66 % 12 == 7 or (v66 % 12 == 10 or v66 % 12 == 0)))) and true or nil then
        v67 = p57.ColorSettings.BlackKeyColor;
    else
        v67 = p57.ColorSettings.WhiteKeyColor;
    end;
    v65.BackgroundColor3 = v67;
end;
function u3.AnimateKeyUp(p68, p69) --[[ Line: 297 ]]
    for v70, v71 in pairs(p68._animatedKeys) do
        if v71 == p69 then
            p68._animatedKeys[v70] = nil;
        end;
    end;
end;
function u3.ResetKeys(p72) --[[ Line: 305 ]]
    table.clear(p72._animatedKeys);
    for v73, v74 in ipairs(p72.PianoGui.PianoKeys) do
        local v75 = (v73 - 1) % 12 + 1;
        v74.BackgroundColor3 = ((v75 % 12 == 2 or (v75 % 12 == 5 or (v75 % 12 == 7 or (v75 % 12 == 10 or v75 % 12 == 0)))) and true or nil) and p72.ColorSettings.BlackKeyColor or p72.ColorSettings.WhiteKeyColor;
    end;
end;
function u3.ResetGui(p76) --[[ Line: 312 ]]
    p76:ToggleEnabled(false, true);
    p76:Toggle88Keys(false, true);
    p76:ToggleMinimized(false, true);
    p76:ToggleContext(false, true);
    p76.PianoGui.SheetsFrame.Visible = false;
    p76:AnimateButtonToggle(p76.PianoGui.SheetsButton, false);
    p76:AnimateButtonToggle(p76.PianoGui.SoundFontButton, false);
    p76:ResetSheetsFrame();
    p76:ResetKeys();
end;
function u3.ConnectPianoController(u77) --[[ Line: 324 ]]
    -- upvalues: u6 (ref), u7 (ref), u4 (ref)
    if #u77._connections > 0 then
        warn("[PianoGui]: Found preexisting PianoController connections, disconnecting");
        u77:DisconnectPianoController();
    end;
    u77._connections = {
        u77.PianoGui.MinimizeButton.Activated:Connect(function() --[[ Line: 331 ]]
            -- upvalues: u77 (copy)
            u77:ToggleMinimized();
        end),
        u77.PianoGui.VelocityFrame.Activated:Connect(function() --[[ Line: 334 ]]
            -- upvalues: u6 (ref), u77 (copy)
            u6:ChangeVelocity(1, true);
            u77.PianoGui.VelocityFrame.Visible = false;
        end),
        u77.PianoGui.Toggle88Button.Activated:Connect(function() --[[ Line: 338 ]]
            -- upvalues: u77 (copy)
            u77:Toggle88Keys();
        end),
        u77.PianoGui.SheetsButton.Activated:Connect(function() --[[ Line: 341 ]]
            -- upvalues: u77 (copy)
            u77.PianoGui.SheetsFrame.Visible = not u77.PianoGui.SheetsFrame.Visible;
            u77:AnimateButtonToggle(u77.PianoGui.SheetsButton, u77.PianoGui.SheetsFrame.Visible);
        end),
        u77.PianoGui.SoundFontButton.Activated:Connect(function() --[[ Line: 345 ]]
            -- upvalues: u7 (ref), u77 (copy)
            u7:ToggleEnabled();
            u77:AnimateButtonPress(u77.PianoGui.SoundFontButton);
        end),
        u77.PianoGui.SheetsFrame.InputBegan:Connect(function(p78) --[[ Line: 349 ]]
            -- upvalues: u77 (copy)
            if p78.UserInputType == Enum.UserInputType.MouseButton1 and u77.PianoGui.SheetsFrame.Visible then
                u77:DragFrame(u77.PianoGui.SheetsFrame, p78);
            end;
        end),
        u77.PianoGui.ResizeButton.InputBegan:Connect(function(p79) --[[ Line: 354 ]]
            -- upvalues: u77 (copy)
            if p79.UserInputType == Enum.UserInputType.MouseButton1 and u77.PianoGui.SheetsFrame.Visible then
                u77:ResizeSheetsFrame(p79);
            end;
        end),
        u77.PianoGui.HomeButton.Activated:Connect(function() --[[ Line: 359 ]]
            -- upvalues: u77 (copy)
            u77:ResetSheetsFrame();
        end),
        u77.PianoGui.FontPlusButton.Activated:Connect(function() --[[ Line: 362 ]]
            -- upvalues: u77 (copy)
            u77:ChangeSheetsTextSize(1);
        end),
        u77.PianoGui.FontMinusButton.Activated:Connect(function() --[[ Line: 365 ]]
            -- upvalues: u77 (copy)
            u77:ChangeSheetsTextSize(-1);
        end),
        u77.PianoGui.TranspositionUpButton.Activated:Connect(function() --[[ Line: 368 ]]
            -- upvalues: u6 (ref), u77 (copy)
            u6:ChangeTransposition(u77._TRANSPOSITION_INCREMENT);
        end),
        u77.PianoGui.TranspositionDownButton.Activated:Connect(function() --[[ Line: 371 ]]
            -- upvalues: u6 (ref), u77 (copy)
            u6:ChangeTransposition(-u77._TRANSPOSITION_INCREMENT);
        end),
        u77.PianoGui.VolumeUpButton.Activated:Connect(function() --[[ Line: 374 ]]
            -- upvalues: u6 (ref), u77 (copy)
            u6:ChangeVolume(u77._VOLUME_INCREMENT);
        end),
        u77.PianoGui.VolumeDownButton.Activated:Connect(function() --[[ Line: 377 ]]
            -- upvalues: u6 (ref), u77 (copy)
            u6:ChangeVolume(-u77._VOLUME_INCREMENT);
        end),
        u77.PianoGui.SustainButton.Activated:Connect(function() --[[ Line: 380 ]]
            -- upvalues: u6 (ref)
            u6:ToggleSustain();
        end),
        u77.PianoGui.TranspositionIcon.Activated:Connect(function() --[[ Line: 383 ]]
            -- upvalues: u6 (ref)
            u6:ToggleShiftLock();
        end),
        u77.PianoGui.ShiftLockButton.Activated:Connect(function() --[[ Line: 386 ]]
            -- upvalues: u6 (ref)
            u6:ToggleShiftLock();
        end),
        u77.PianoGui.SettingsButton.Activated:Connect(function() --[[ Line: 389 ]]
            -- upvalues: u4 (ref), u77 (copy)
            u4:ToggleEnabled();
            u77:AnimateButtonPress(u77.PianoGui.SettingsButton);
        end),
        u77.PianoGui.ContextButton.Activated:Connect(function() --[[ Line: 393 ]]
            -- upvalues: u77 (copy)
            u77:ToggleContext();
        end),
        u77.PianoGui.ExitButton.Activated:Connect(function() --[[ Line: 396 ]]
            -- upvalues: u6 (ref)
            u6:Deactivate();
        end),
        u6.KeyPressed:Connect(function(p80, p81, p82) --[[ Line: 400 ]]
            -- upvalues: u77 (copy)
            u77:AnimateKeyDown(p80, p81 + p82);
        end),
        u6.KeyReleased:Connect(function(p83) --[[ Line: 403 ]]
            -- upvalues: u77 (copy)
            u77:AnimateKeyUp(p83);
        end),
        u6.TranspositionChanged:Connect(function(p84, p85) --[[ Line: 406 ]]
            -- upvalues: u77 (copy)
            if p85 == 0 then
            else
                u77:AnimateButtonPress(p85 < 0 and u77.PianoGui.TranspositionDownButton or u77.PianoGui.TranspositionUpButton);
                u77.PianoGui.TranspositionNumber.Text = p84;
            end;
        end),
        u6.VolumeChanged:Connect(function(p86, p87) --[[ Line: 411 ]]
            -- upvalues: u77 (copy)
            if p87 == 0 then
            else
                u77:AnimateButtonPress(p87 < 0 and u77.PianoGui.VolumeDownButton or u77.PianoGui.VolumeUpButton);
                u77.PianoGui.VolumeNumber.Text = math.floor(p86 * 100 + 0.5) .. "%";
            end;
        end),
        u6.VelocityChanged:Connect(function(p88, _) --[[ Line: 416 ]]
            -- upvalues: u77 (copy)
            u77:AnimateVelocityChange(p88, 2);
        end),
        u6.SustainChanged:Connect(function(p89, _) --[[ Line: 419 ]]
            -- upvalues: u77 (copy)
            u77:AnimateSustainToggle(p89);
        end),
        u6.ShiftLockChanged:Connect(function(p90) --[[ Line: 422 ]]
            -- upvalues: u77 (copy)
            u77:AnimateShiftLockToggle(p90);
        end),
        u6.Activated:Connect(function() --[[ Line: 425 ]]
            -- upvalues: u77 (copy)
            u77:ResetKeys();
            u77:ToggleEnabled(true);
        end),
        u6.Deactivated:Connect(function() --[[ Line: 429 ]]
            -- upvalues: u77 (copy)
            u77:ToggleEnabled(false);
            u77:ResetKeys();
        end)
    };
    for u91, v92 in ipairs(u77.PianoGui.PianoKeys) do
        table.insert(u77._connections, v92.MouseButton1Down:Connect(function() --[[ Line: 436 ]]
            -- upvalues: u6 (ref), u91 (copy)
            if u6.Active then
                u6:PressClientKey(Enum.UserInputType.MouseButton1, u91 - 15, 0);
            end;
        end));
        table.insert(u77._connections, v92.InputEnded:Connect(function(p93, p94) --[[ Line: 442 ]]
            -- upvalues: u6 (ref)
            if p94 or not u6.Active then
            else
                if p93.UserInputType == Enum.UserInputType.MouseButton1 then
                    u6:ReleaseClientKey(Enum.UserInputType.MouseButton1);
                end;
            end;
        end));
    end;
end;
function u3.DisconnectPianoController(p95) --[[ Line: 452 ]]
    for _, v96 in ipairs(p95._connections) do
        v96:Disconnect();
    end;
    table.clear(p95._connections);
end;
function u3.IsConnected(p97) --[[ Line: 459 ]]
    return #p97._connections > 0;
end;
function u3.Init(p98) --[[ Line: 464 ]]
    -- upvalues: u6 (ref), u5 (ref)
    u6 = script.Parent.Parent:WaitForChild("PianoController");
    u5 = require(u6.Tween);
    u6 = require(u6);
    p98:ResetGui();
end;
function u3.Start(u99) --[[ Line: 471 ]]
    -- upvalues: u7 (ref), u4 (ref), u6 (ref), u3 (copy)
    u7 = require(script.Parent.Parent:WaitForChild("SoundFontGui"):WaitForChild("GuiModule"));
    u4 = require(script.Parent.Parent:WaitForChild("SettingsGui"):WaitForChild("GuiModule"));
    u99:ConnectPianoController();
    u6.DeviceChanged:Connect(function(p100) --[[ Line: 475 ]]
        -- upvalues: u3 (ref), u6 (ref), u99 (copy)
        if p100 == "Desktop" then
            if u3:IsConnected() then
                return;
            end;
            u3:ConnectPianoController();
        elseif p100 == "Mobile" then
            if not u3:IsConnected() then
                return;
            end;
            u3:DisconnectPianoController();
        end;
        if u6.Active then
            u99:ToggleEnabled(p100 == "Desktop", true);
        end;
    end);
end;
return u3;
