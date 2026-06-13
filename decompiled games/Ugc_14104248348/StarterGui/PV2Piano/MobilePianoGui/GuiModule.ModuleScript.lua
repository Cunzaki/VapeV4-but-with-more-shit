-- Decompiled from: StarterGui.PV2Piano.MobilePianoGui.GuiModule
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
local u2 = {
    70,
    315,
    0.55,
    0.6
};
local v3 = {
    50,
    225,
    0.56,
    0.62
};
local u4 = {
    { 0.04, 0.3333333333333333 },
    { 0.1, 1 },
    { 0.25, 0.75 },
    { 0.25, 0.75 }
};
local v5 = game:GetService("GuiService"):GetGuiInset();
local u6 = math.max(workspace.CurrentCamera.ViewportSize.X, workspace.CurrentCamera.ViewportSize.Y);
local u7 = math.min(workspace.CurrentCamera.ViewportSize.X, workspace.CurrentCamera.ViewportSize.Y) - v5.Y;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = {
    Enabled = false,
    Minimized = false,
    DoubleLayout = false,
    _holding = nil,
    _connections = {}
};
local l__Parent__1 = script.Parent;
u13.MobilePianoGui = {
    Gui = l__Parent__1,
    LayoutFrame = l__Parent__1.LayoutFrame,
    MainFrame = l__Parent__1.MainFrame,
    TopbarFrame = l__Parent__1.MainFrame.TopbarFrame,
    SoundFontButton = l__Parent__1.MainFrame.TopbarFrame.LeftBar.SoundFont,
    SustainButton = l__Parent__1.MainFrame.TopbarFrame.LeftBar.Sustain,
    LayoutButton = l__Parent__1.MainFrame.TopbarFrame.LeftBar.Layout,
    LCDFrame = l__Parent__1.MainFrame.TopbarFrame.CenterFrame.LCDFrame,
    SoundFontLabel = l__Parent__1.MainFrame.TopbarFrame.CenterFrame.LCDFrame.InnerFrame.SoundFontLabel,
    VolumeFrame = l__Parent__1.MainFrame.TopbarFrame.CenterFrame.VolumeFrame,
    VolumeHead = l__Parent__1.MainFrame.TopbarFrame.CenterFrame.VolumeFrame.SliderFrame.Head,
    ExitButton = l__Parent__1.MainFrame.TopbarFrame.Exit,
    KeyFrame = l__Parent__1.MainFrame.KeyFrame,
    OctaveFrame = l__Parent__1.MainFrame.OctaveFrame
};
u13.ColorSettings = {
    InactiveButtonColor = Color3.fromRGB(255, 255, 255),
    ActiveButtonColor = Color3.fromRGB(51, 160, 255),
    ActiveWhiteKeyColor = Color3.fromRGB(0, 255, 0),
    ActiveBlackKeyColor = Color3.fromRGB(0, 255, 0),
    WhiteKeyColor = Color3.fromRGB(255, 255, 255),
    BlackKeyColor = Color3.fromRGB(0, 0, 0)
};
if u7 <= 420 then
    u2 = {
        50,
        80,
        0.6,
        0.55
    };
elseif u7 <= 731 then
    u2 = v3;
end;
u13._whiteKeyWidth = u2[1] / u6;
u13._whiteKeyHeight = u2[2] / (u7 - u13.MobilePianoGui.TopbarFrame.AbsoluteSize.Y - u13.MobilePianoGui.OctaveFrame.AbsoluteSize.Y);
u13._blackKeyWidth = u2[3];
u13._blackKeyHeight = u2[4];
function u13.ToggleEnabled(p14, p15, p16) --[[ Line: 116 ]]
    if p16 or (type(p15) ~= "boolean" or p15 ~= p14.Enabled) then
        if p15 == nil then
            p15 = not p14.Enabled;
        end;
        p14.Enabled = p15;
        p14.MobilePianoGui.Gui.Enabled = p14.Enabled;
    end;
end;
function u13.ToggleMinimized(p17, p18, p19) --[[ Line: 122 ]]
    -- upvalues: u12 (ref), u1 (copy)
    if p19 or (type(p18) ~= "boolean" or p18 ~= p17.Minimized) then
        if p18 == nil then
            p18 = not p17.Minimized;
        end;
        p17.Minimized = p18;
        u12:Play(p17.MobilePianoGui.MainFrame, u1, {
            AnchorPoint = Vector2.new(0.5, p17.Minimized and 0 or 1),
            Position = UDim2.new(0.5, 0, 1, not p17.Minimized and 0 or -p17.MobilePianoGui.TopbarFrame.AbsoluteSize.Y)
        });
    end;
end;
function u13.ToggleDoubleLayout(p20, p21, p22) --[[ Line: 128 ]]
    if p22 or (type(p21) ~= "boolean" or p21 ~= p20.DoubleLayout) then
        if p21 == nil then
            p21 = not p20.DoubleLayout;
        end;
        p20.DoubleLayout = p21;
        p20.MobilePianoGui.KeyFrame.BottomKeyFrame.Visible = p20.DoubleLayout;
        p20.MobilePianoGui.OctaveFrame.BottomOctaveFrame.Visible = p20.DoubleLayout;
        local l__Icon__2 = p20.MobilePianoGui.LayoutFrame.LayoutBar.SingleLayoutButton.Icon;
        local v23;
        if p20.DoubleLayout then
            v23 = p20.ColorSettings.InactiveButtonColor;
        else
            v23 = p20.ColorSettings.ActiveButtonColor;
        end;
        l__Icon__2.ImageColor3 = v23;
        for _, v24 in ipairs(p20.MobilePianoGui.LayoutFrame.LayoutBar.DoubleLayoutButton.Icon:GetChildren()) do
            if v24:IsA("ImageLabel") then
                local v25;
                if p20.DoubleLayout then
                    v25 = p20.ColorSettings.ActiveButtonColor;
                else
                    v25 = p20.ColorSettings.InactiveButtonColor;
                end;
                v24.ImageColor3 = v25;
            end;
        end;
        p20:_updateKeys();
    end;
end;
function u13.ToggleLayoutFrame(p26, p27) --[[ Line: 142 ]]
    local l__LayoutFrame__3 = p26.MobilePianoGui.LayoutFrame;
    if p27 == nil then
        p27 = not p26.MobilePianoGui.LayoutFrame.Visible;
    end;
    l__LayoutFrame__3.Visible = p27;
    local l__Icon__4 = p26.MobilePianoGui.LayoutButton.Icon;
    local v28;
    if p26.MobilePianoGui.LayoutFrame.Visible then
        v28 = p26.ColorSettings.ActiveButtonColor;
    else
        v28 = p26.ColorSettings.InactiveButtonColor;
    end;
    l__Icon__4.ImageColor3 = v28;
end;
function u13._initializeLayoutFrame(u29) --[[ Line: 147 ]]
    -- upvalues: u4 (copy)
    local l__LayoutFrame__5 = u29.MobilePianoGui.LayoutFrame;
    local l__LayoutBar__6 = l__LayoutFrame__5.LayoutBar;
    l__LayoutBar__6.SingleLayoutButton.Activated:Connect(function() --[[ Line: 150 ]]
        -- upvalues: u29 (copy)
        u29:ToggleDoubleLayout(false);
    end);
    l__LayoutBar__6.DoubleLayoutButton.Activated:Connect(function() --[[ Line: 153 ]]
        -- upvalues: u29 (copy)
        u29:ToggleDoubleLayout(true);
    end);
    local l__KeySliderFrame__7 = l__LayoutFrame__5.KeySliderFrame;
    l__KeySliderFrame__7.WhiteKeyWidthSlider.TouchPan:Connect(function(p30, _, _, p31) --[[ Line: 157 ]]
        -- upvalues: u29 (copy), l__KeySliderFrame__7 (copy), u4 (ref)
        if p31 == Enum.UserInputState.Begin and not u29._holding then
            u29._holding = l__KeySliderFrame__7.WhiteKeyWidthSlider;
        elseif p31 == Enum.UserInputState.Change and u29._holding == l__KeySliderFrame__7.WhiteKeyWidthSlider then
            u29._whiteKeyWidth = math.clamp(u4[1][1] + (u4[1][2] - u4[1][1]) * ((p30[1].X - l__KeySliderFrame__7.WhiteKeyWidthSlider.AbsolutePosition.X) / l__KeySliderFrame__7.WhiteKeyWidthSlider.AbsoluteSize.X), u4[1][1], u4[1][2]);
            u29:_updateLayoutSliders();
            u29:_updateKeys();
        else
            if p31 == Enum.UserInputState.End then
                u29._holding = nil;
            end;
        end;
    end);
    l__KeySliderFrame__7.WhiteKeyHeightSlider.TouchPan:Connect(function(p32, _, _, p33) --[[ Line: 169 ]]
        -- upvalues: u29 (copy), l__KeySliderFrame__7 (copy), u4 (ref)
        if p33 == Enum.UserInputState.Begin and not u29._holding then
            u29._holding = l__KeySliderFrame__7.WhiteKeyHeightSlider;
        elseif p33 == Enum.UserInputState.Change and u29._holding == l__KeySliderFrame__7.WhiteKeyHeightSlider then
            u29._whiteKeyHeight = math.clamp(u4[2][1] + (u4[2][2] - u4[2][1]) * ((p32[1].X - l__KeySliderFrame__7.WhiteKeyHeightSlider.AbsolutePosition.X) / l__KeySliderFrame__7.WhiteKeyHeightSlider.AbsoluteSize.X), u4[2][1], u4[2][2]);
            u29:_updateLayoutSliders();
            u29:_updateKeys();
        else
            if p33 == Enum.UserInputState.End then
                u29._holding = nil;
            end;
        end;
    end);
    l__KeySliderFrame__7.BlackKeyWidthSlider.TouchPan:Connect(function(p34, _, _, p35) --[[ Line: 181 ]]
        -- upvalues: u29 (copy), l__KeySliderFrame__7 (copy), u4 (ref)
        if p35 == Enum.UserInputState.Begin and not u29._holding then
            u29._holding = l__KeySliderFrame__7.BlackKeyWidthSlider;
        elseif p35 == Enum.UserInputState.Change and u29._holding == l__KeySliderFrame__7.BlackKeyWidthSlider then
            u29._blackKeyWidth = math.clamp(u4[3][1] + (u4[3][2] - u4[3][1]) * ((p34[1].X - l__KeySliderFrame__7.BlackKeyWidthSlider.AbsolutePosition.X) / l__KeySliderFrame__7.BlackKeyWidthSlider.AbsoluteSize.X), u4[3][1], u4[3][2]);
            u29:_updateLayoutSliders();
            u29:_updateKeys();
        else
            if p35 == Enum.UserInputState.End then
                u29._holding = nil;
            end;
        end;
    end);
    l__KeySliderFrame__7.BlackKeyHeightSlider.TouchPan:Connect(function(p36, _, _, p37) --[[ Line: 193 ]]
        -- upvalues: u29 (copy), l__KeySliderFrame__7 (copy), u4 (ref)
        if p37 == Enum.UserInputState.Begin and not u29._holding then
            u29._holding = l__KeySliderFrame__7.BlackKeyHeightSlider;
        elseif p37 == Enum.UserInputState.Change and u29._holding == l__KeySliderFrame__7.BlackKeyHeightSlider then
            u29._blackKeyHeight = math.clamp(u4[4][1] + (u4[4][2] - u4[4][1]) * ((p36[1].X - l__KeySliderFrame__7.BlackKeyHeightSlider.AbsolutePosition.X) / l__KeySliderFrame__7.BlackKeyHeightSlider.AbsoluteSize.X), u4[4][1], u4[4][2]);
            u29:_updateLayoutSliders();
            u29:_updateKeys();
        else
            if p37 == Enum.UserInputState.End then
                u29._holding = nil;
            end;
        end;
    end);
    local l__ButtonBar__8 = l__LayoutFrame__5.ButtonBar;
    l__ButtonBar__8.ResetButton.Activated:Connect(function() --[[ Line: 206 ]]
        -- upvalues: u29 (copy)
        u29:_resetKeys();
    end);
    l__ButtonBar__8.CloseButton.Activated:Connect(function() --[[ Line: 209 ]]
        -- upvalues: u29 (copy)
        u29:ToggleLayoutFrame(false);
    end);
    u29:_updateLayoutSliders();
end;
function u13._updateLayoutSliders(p38) --[[ Line: 215 ]]
    -- upvalues: u4 (copy)
    local l__KeySliderFrame__9 = p38.MobilePianoGui.LayoutFrame.KeySliderFrame;
    l__KeySliderFrame__9.WhiteKeyWidthSlider.SliderFrame.Head.Position = UDim2.fromScale(math.clamp((p38._whiteKeyWidth - u4[1][1]) / (u4[1][2] - u4[1][1]), 0, 1), 0.5);
    l__KeySliderFrame__9.WhiteKeyHeightSlider.SliderFrame.Head.Position = UDim2.fromScale(math.clamp((p38._whiteKeyHeight - u4[2][1]) / (u4[2][2] - u4[2][1]), 0, 1), 0.5);
    l__KeySliderFrame__9.BlackKeyWidthSlider.SliderFrame.Head.Position = UDim2.fromScale(math.clamp((p38._blackKeyWidth - u4[3][1]) / (u4[3][2] - u4[3][1]), 0, 1), 0.5);
    l__KeySliderFrame__9.BlackKeyHeightSlider.SliderFrame.Head.Position = UDim2.fromScale(math.clamp((p38._blackKeyHeight - u4[4][1]) / (u4[4][2] - u4[4][1]), 0, 1), 0.5);
end;
function u13.AnimateKeyDown(p39, p40, p41) --[[ Line: 223 ]]
    local v42 = p40:FindFirstChild(p41);
    if v42 then
        local v43 = (p41 - 1) % 12 + 1;
        local v44;
        if (v43 % 12 == 2 or (v43 % 12 == 5 or (v43 % 12 == 7 or (v43 % 12 == 10 or v43 % 12 == 0)))) and true or nil then
            v44 = p39.ColorSettings.ActiveBlackKeyColor;
        else
            v44 = p39.ColorSettings.ActiveWhiteKeyColor;
        end;
        v42.BackgroundColor3 = v44;
    end;
end;
function u13.AnimateKeyUp(p45, p46, p47) --[[ Line: 229 ]]
    local v48 = p46:FindFirstChild(p47);
    if v48 then
        local v49 = (p47 - 1) % 12 + 1;
        local v50;
        if (v49 % 12 == 2 or (v49 % 12 == 5 or (v49 % 12 == 7 or (v49 % 12 == 10 or v49 % 12 == 0)))) and true or nil then
            v50 = p45.ColorSettings.BlackKeyColor;
        else
            v50 = p45.ColorSettings.WhiteKeyColor;
        end;
        v48.BackgroundColor3 = v50;
    end;
end;
function u13.ResetKeys(p51) --[[ Line: 235 ]]
    for _, v52 in ipairs(p51.MobilePianoGui.KeyFrame:GetChildren()) do
        if v52:IsA("ScrollingFrame") then
            for _, v53 in ipairs(v52:GetChildren()) do
                local v54 = tonumber(v53.Name);
                if v54 then
                    local v55 = (v54 - 1) % 12 + 1;
                    local v56;
                    if (v55 % 12 == 2 or (v55 % 12 == 5 or (v55 % 12 == 7 or (v55 % 12 == 10 or v55 % 12 == 0)))) and true or nil then
                        v56 = p51.ColorSettings.BlackKeyColor;
                    else
                        v56 = p51.ColorSettings.WhiteKeyColor;
                    end;
                    v53.BackgroundColor3 = v56;
                end;
            end;
        end;
    end;
end;
function u13._resetKeys(p57) --[[ Line: 246 ]]
    -- upvalues: u2 (copy), u6 (copy), u7 (copy), u13 (copy)
    p57._whiteKeyWidth = u2[1] / u6;
    p57._whiteKeyHeight = u2[2] / (u7 - u13.MobilePianoGui.TopbarFrame.AbsoluteSize.Y - u13.MobilePianoGui.OctaveFrame.AbsoluteSize.Y);
    p57._blackKeyWidth = u2[3];
    p57._blackKeyHeight = u2[4];
    p57:_updateKeys(true);
end;
function u13._updateKeys(p58, p59) --[[ Line: 254 ]]
    -- upvalues: u6 (copy), u7 (copy), u13 (copy)
    local v60 = p58._whiteKeyWidth * u6;
    local v61 = p58._whiteKeyHeight / (p58.DoubleLayout and 2 or 1) * (u7 - (u13.MobilePianoGui.TopbarFrame.AbsoluteSize.Y + u13.MobilePianoGui.OctaveFrame.AbsoluteSize.Y));
    local v62 = v60 * p58._blackKeyWidth;
    local v63 = v61 * p58._blackKeyHeight;
    for _, v64 in ipairs(p58.MobilePianoGui.KeyFrame:GetChildren()) do
        if v64:IsA("ScrollingFrame") then
            local v65 = 1;
            local v66 = 0;
            for v67 = 1, 88 do
                local v68 = v64:FindFirstChild(v67);
                if v68 then
                    local v69 = (v67 - 1) % 12 + 1;
                    if (v69 % 12 == 2 or (v69 % 12 == 5 or (v69 % 12 == 7 or (v69 % 12 == 10 or v69 % 12 == 0)))) and true or nil then
                        v68.Size = UDim2.new(0, v62, 0, v63);
                        if v65 == 1 or v65 == 3 then
                            v68.Position = UDim2.new(0, v66 * v60 - 0.4 * v62, 0, 0);
                        elseif v65 == 2 or v65 == 4 then
                            v68.Position = UDim2.new(0, v66 * v60 - (v62 + 2) + 0.4 * v62, 0, 0);
                        elseif v65 == 5 then
                            v68.Position = UDim2.new(0, v66 * v60 - (0.5 * v62 + 2), 0, 0);
                        end;
                        v68.Name = v67;
                        v65 = v65 + 1;
                        if v65 == 6 then
                            v65 = 1;
                        end;
                    else
                        v66 = v66 + 1;
                        v68.Size = UDim2.new(0, v60, 0, v61);
                        v68.Position = UDim2.new(0, (v66 - 1) * v60, 0, 0);
                        v68.Name = v67;
                    end;
                end;
            end;
            v64.CanvasSize = UDim2.new(0, v60 * v66, 0, 0);
        end;
    end;
    if p59 then
        local v70 = 22.5 * v60 - u6 / 2;
        p58.MobilePianoGui.KeyFrame.TopKeyFrame.CanvasPosition = Vector2.new(v70, 0);
        p58.MobilePianoGui.KeyFrame.BottomKeyFrame.CanvasPosition = Vector2.new(v70, 0);
    end;
    p58:_updateOctaveFrame(p58.MobilePianoGui.OctaveFrame.TopOctaveFrame, p58.MobilePianoGui.KeyFrame.TopKeyFrame);
    p58:_updateOctaveFrame(p58.MobilePianoGui.OctaveFrame.BottomOctaveFrame, p58.MobilePianoGui.KeyFrame.BottomKeyFrame);
end;
function u13._updateSoundFontLabel(p71) --[[ Line: 298 ]]
    -- upvalues: u11 (ref), u8 (ref)
    p71.MobilePianoGui.SoundFontLabel.Text = u11[u8.SoundFont].Name;
end;
function u13._updateVolumeFrame(p72) --[[ Line: 302 ]]
    -- upvalues: u8 (ref), u10 (ref)
    p72.MobilePianoGui.VolumeHead.Position = UDim2.fromScale(math.clamp((u8.Volume - u10.MIN_VOLUME) / (u10.MAX_VOLUME - u10.MIN_VOLUME), 0, 1), 0.5);
end;
function u13._connectVolumeFrame(u73) --[[ Line: 307 ]]
    -- upvalues: u8 (ref), u10 (ref)
    local l__VolumeFrame__10 = u73.MobilePianoGui.VolumeFrame;
    local _ = u8.Volume;
    return l__VolumeFrame__10.TouchPan:Connect(function(p74, _, _, p75) --[[ Line: 310 ]]
        -- upvalues: u73 (copy), l__VolumeFrame__10 (copy), u8 (ref), u10 (ref)
        if p75 == Enum.UserInputState.Begin and not u73._holding then
            u73._holding = l__VolumeFrame__10;
        elseif p75 == Enum.UserInputState.Change and u73._holding == l__VolumeFrame__10 then
            u8:ChangeVolume(math.clamp(u10.MIN_VOLUME + (u10.MAX_VOLUME - u10.MIN_VOLUME) * ((p74[1].X - l__VolumeFrame__10.AbsolutePosition.X) / l__VolumeFrame__10.AbsoluteSize.X), 0.1, 2), true);
        else
            if p75 == Enum.UserInputState.End then
                u73._holding = nil;
            end;
        end;
    end);
end;
function u13._updateOctaveFrame(p76, p77, p78) --[[ Line: 322 ]]
    local l__Head__11 = p77.Head;
    l__Head__11.Size = UDim2.new(1 / p76._whiteKeyWidth / 52, 0, 1, -2);
    l__Head__11.Position = UDim2.new(math.clamp(p78.CanvasPosition.X / (p78.AbsoluteCanvasSize.X - p78.AbsoluteWindowSize.X) * (1 - l__Head__11.Size.X.Scale), 0, 1 - l__Head__11.Size.X.Scale), 0, 0.5, 0);
end;
function u13._connectOctaveFrame(u79, u80, u81) --[[ Line: 329 ]]
    local l__Head__12 = u80.Head;
    return u80.TouchPan:Connect(function(p82, _, _, p83) --[[ Line: 331 ]]
        -- upvalues: u79 (copy), u80 (copy), u81 (copy), l__Head__12 (copy)
        if p83 == Enum.UserInputState.Begin and not u79._holding then
            u79._holding = u80;
        elseif p83 == Enum.UserInputState.Change and u79._holding == u80 then
            u81.CanvasPosition = Vector2.new((math.clamp(((p82[1].X - u80.AbsolutePosition.X) / u80.AbsoluteSize.X - l__Head__12.Size.X.Scale / 2) * u81.AbsoluteCanvasSize.X, 0, u81.AbsoluteCanvasSize.X - u81.AbsoluteWindowSize.X)));
        else
            if p83 == Enum.UserInputState.End then
                u79._holding = nil;
            end;
        end;
    end);
end;
function u13.ConnectPianoController(u84) --[[ Line: 344 ]]
    -- upvalues: u9 (ref), u8 (ref)
    if u84:IsConnected() then
        warn("[MobilePianoGui]: Found preexisting PianoController connections, disconnecting");
        u84:DisconnectPianoController();
    end;
    u84._connections = {
        u84.MobilePianoGui.SoundFontButton.Activated:Connect(function() --[[ Line: 350 ]]
            -- upvalues: u9 (ref)
            u9:ToggleEnabled();
        end),
        u84:_connectVolumeFrame(),
        u84.MobilePianoGui.SustainButton.Activated:Connect(function() --[[ Line: 354 ]]
            -- upvalues: u8 (ref)
            u8:ToggleSustain();
        end),
        u84.MobilePianoGui.LayoutButton.Activated:Connect(function() --[[ Line: 357 ]]
            -- upvalues: u84 (copy)
            u84:ToggleLayoutFrame();
        end),
        u84.MobilePianoGui.LCDFrame.Activated:Connect(function() --[[ Line: 360 ]]
            -- upvalues: u84 (copy)
            u84:ToggleMinimized();
        end),
        u84.MobilePianoGui.ExitButton.Activated:Connect(function() --[[ Line: 363 ]]
            -- upvalues: u8 (ref)
            u8:Deactivate();
        end),
        u84:_connectOctaveFrame(u84.MobilePianoGui.OctaveFrame.TopOctaveFrame, u84.MobilePianoGui.KeyFrame.TopKeyFrame),
        u84:_connectOctaveFrame(u84.MobilePianoGui.OctaveFrame.BottomOctaveFrame, u84.MobilePianoGui.KeyFrame.BottomKeyFrame),
        u84.MobilePianoGui.KeyFrame.TopKeyFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function() --[[ Line: 368 ]]
            -- upvalues: u84 (copy)
            u84:_updateOctaveFrame(u84.MobilePianoGui.OctaveFrame.TopOctaveFrame, u84.MobilePianoGui.KeyFrame.TopKeyFrame);
        end),
        u84.MobilePianoGui.KeyFrame.BottomKeyFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function() --[[ Line: 371 ]]
            -- upvalues: u84 (copy)
            u84:_updateOctaveFrame(u84.MobilePianoGui.OctaveFrame.BottomOctaveFrame, u84.MobilePianoGui.KeyFrame.BottomKeyFrame);
        end),
        u8.KeyPressed:Connect(function(p85) --[[ Line: 374 ]]
            -- upvalues: u84 (copy)
            if type(p85) == "string" then
                local v86 = string.sub(p85, 1, 1);
                if v86 == "t" or v86 == "b" then
                    local v87 = string.sub(p85, 2);
                    local v88 = tonumber(v87);
                    if v88 then
                        if v86 == "t" then
                            u84:AnimateKeyDown(u84.MobilePianoGui.KeyFrame.TopKeyFrame, v88);
                        else
                            if v86 == "b" then
                                u84:AnimateKeyDown(u84.MobilePianoGui.KeyFrame.BottomKeyFrame, v88);
                            end;
                        end;
                    end;
                end;
            end;
        end),
        u8.KeyReleased:Connect(function(p89) --[[ Line: 386 ]]
            -- upvalues: u84 (copy)
            if type(p89) == "string" then
                local v90 = string.sub(p89, 1, 1);
                if v90 == "t" or v90 == "b" then
                    local v91 = string.sub(p89, 2);
                    local v92 = tonumber(v91);
                    if v92 then
                        if v90 == "t" then
                            u84:AnimateKeyUp(u84.MobilePianoGui.KeyFrame.TopKeyFrame, v92);
                        else
                            if v90 == "b" then
                                u84:AnimateKeyUp(u84.MobilePianoGui.KeyFrame.BottomKeyFrame, v92);
                            end;
                        end;
                    end;
                end;
            end;
        end),
        u8.SustainChanged:Connect(function(p93, _) --[[ Line: 398 ]]
            -- upvalues: u84 (copy)
            local l__Icon__13 = u84.MobilePianoGui.SustainButton.Icon;
            local v94;
            if p93 then
                v94 = u84.ColorSettings.ActiveButtonColor;
            else
                v94 = u84.ColorSettings.InactiveButtonColor;
            end;
            l__Icon__13.ImageColor3 = v94;
        end),
        u8.SoundFontChanged:Connect(function() --[[ Line: 401 ]]
            -- upvalues: u84 (copy)
            u84:_updateSoundFontLabel();
        end),
        u8.VolumeChanged:Connect(function() --[[ Line: 404 ]]
            -- upvalues: u84 (copy)
            u84:_updateVolumeFrame();
        end),
        u8.Activated:Connect(function() --[[ Line: 407 ]]
            -- upvalues: u84 (copy)
            u84:ResetKeys();
            u84:ToggleEnabled(true);
        end),
        u8.Deactivated:Connect(function() --[[ Line: 411 ]]
            -- upvalues: u84 (copy)
            u84:ToggleEnabled(false);
            u84:ResetKeys();
        end),
        game:GetService("UserInputService").TouchEnded:Connect(function(_, p95) --[[ Line: 415 ]]
            -- upvalues: u84 (copy)
            if p95 or (not u84:IsConnected() or u84._holding == nil) then
            else
                u84._holding = nil;
            end;
        end)
    };
    for _, v96 in ipairs(u84.MobilePianoGui.KeyFrame.TopKeyFrame:GetChildren()) do
        local u97 = tonumber(v96.Name);
        if u97 then
            local u98 = false;
            table.insert(u84._connections, v96.MouseButton1Down:Connect(function() --[[ Line: 425 ]]
                -- upvalues: u8 (ref), u98 (ref), u97 (copy)
                if u8.Active and u98 ~= true then
                    u98 = true;
                    u8:PressClientKey("t" .. u97, u97 - 15, 0);
                end;
            end));
            table.insert(u84._connections, v96.MouseButton1Up:Connect(function() --[[ Line: 432 ]]
                -- upvalues: u8 (ref), u98 (ref), u97 (copy)
                if u8.Active and u98 ~= false then
                    u98 = false;
                    u8:ReleaseClientKey("t" .. u97);
                end;
            end));
            table.insert(u84._connections, v96.MouseLeave:Connect(function() --[[ Line: 439 ]]
                -- upvalues: u8 (ref), u98 (ref), u97 (copy)
                if u8.Active and u98 ~= false then
                    u98 = false;
                    u8:ReleaseClientKey("t" .. u97);
                end;
            end));
        else
            warn("[MobilePianoGui]: Could not get note from key: " .. v96.Name);
        end;
    end;
    for _, v99 in ipairs(u84.MobilePianoGui.KeyFrame.BottomKeyFrame:GetChildren()) do
        local u100 = tonumber(v99.Name);
        if u100 then
            local u101 = false;
            table.insert(u84._connections, v99.MouseButton1Down:Connect(function() --[[ Line: 451 ]]
                -- upvalues: u8 (ref), u101 (ref), u100 (copy)
                if u8.Active and u101 ~= true then
                    u101 = true;
                    u8:PressClientKey("b" .. u100, u100 - 15, 0);
                end;
            end));
            table.insert(u84._connections, v99.MouseButton1Up:Connect(function() --[[ Line: 458 ]]
                -- upvalues: u8 (ref), u101 (ref), u100 (copy)
                if u8.Active and u101 ~= false then
                    u101 = false;
                    u8:ReleaseClientKey("b" .. u100);
                end;
            end));
            table.insert(u84._connections, v99.MouseLeave:Connect(function() --[[ Line: 465 ]]
                -- upvalues: u8 (ref), u101 (ref), u100 (copy)
                if u8.Active and u101 ~= false then
                    u101 = false;
                    u8:ReleaseClientKey("b" .. u100);
                end;
            end));
        else
            warn("[MobilePianoGui]: Could not get note from key: " .. v99.Name);
        end;
    end;
    u84:_updateSoundFontLabel();
    u84:_updateVolumeFrame();
end;
function u13.DisconnectPianoController(p102) --[[ Line: 476 ]]
    for _, v103 in ipairs(p102._connections) do
        v103:Disconnect();
    end;
    table.clear(p102._connections);
end;
function u13.IsConnected(p104) --[[ Line: 483 ]]
    return #p104._connections > 0;
end;
function u13.Init(_) --[[ Line: 487 ]]
    -- upvalues: u8 (ref), u10 (ref), u11 (ref), u12 (ref)
    u8 = script.Parent.Parent:WaitForChild("PianoController");
    u10 = require(u8.DefaultSettings);
    u11 = require(u8.SoundFonts);
    u12 = require(u8.Tween);
    u8 = require(u8);
end;
function u13.Start(u105) --[[ Line: 495 ]]
    -- upvalues: u9 (ref), u8 (ref), u13 (copy)
    u9 = require(script.Parent.Parent:WaitForChild("SoundFontGui"):WaitForChild("GuiModule"));
    u105:ToggleEnabled(false, true);
    u105:ToggleMinimized(false, true);
    u105:ToggleDoubleLayout(false, true);
    u105:ToggleLayoutFrame(false);
    u105:_initializeLayoutFrame();
    u105:_updateSoundFontLabel();
    u105:_updateVolumeFrame();
    u105:_updateKeys(true);
    u8.DeviceChanged:Connect(function(p106) --[[ Line: 505 ]]
        -- upvalues: u13 (ref), u8 (ref), u105 (copy)
        if p106 == "Mobile" then
            if u13:IsConnected() then
                return;
            end;
            u13:ConnectPianoController();
        elseif p106 == "Desktop" then
            if not u13:IsConnected() then
                return;
            end;
            u13:DisconnectPianoController();
        end;
        if u8.Active then
            u105:ToggleEnabled(p106 == "Mobile", true);
        end;
    end);
end;
return u13;
