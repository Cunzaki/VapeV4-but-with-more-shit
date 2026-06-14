-- Decompiled from: Players.9qje7.PlayerGui.PV2Piano.SoundFontGui.GuiModule
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = Color3.fromRGB(255, 255, 255);
local u2 = Color3.fromRGB(84, 84, 84);
local u3 = Color3.fromRGB(255, 192, 64);
local l__UserInputService__1 = game:GetService("UserInputService");
local u4 = nil;
local u5 = nil;
local v6 = {
    Enabled = false,
    _activeSoundFontButton = nil,
    _soundFontButtons = nil
};
local l__Parent__2 = script.Parent;
v6.SoundFontGui = {
    Gui = l__Parent__2,
    MainFrame = l__Parent__2.MainFrame,
    TitleLabel = l__Parent__2.MainFrame.TitleLabel,
    CloseButton = l__Parent__2.MainFrame.CloseButton,
    BodyFrame = l__Parent__2.MainFrame.BodyFrame,
    SoundFontFrame = l__Parent__2.MainFrame.BodyFrame.SoundFontFrame,
    ListFrame = l__Parent__2.MainFrame.BodyFrame.SoundFontFrame.ListFrame,
    ListLayout = l__Parent__2.MainFrame.BodyFrame.SoundFontFrame.ListFrame.UIListLayout,
    ListPadding = l__Parent__2.MainFrame.BodyFrame.SoundFontFrame.ListFrame.UIPadding,
    SoundFontTemplate = l__Parent__2.MainFrame.BodyFrame.SoundFontFrame.ListFrame.SoundFontTemplate
};
function v6.ToggleEnabled(p7, p8, p9) --[[ Line: 34 ]]
    if p9 or (type(p8) ~= "boolean" or p8 ~= p7.Enabled) then
        if p8 == nil then
            p8 = not p7.Enabled;
        end;
        p7.Enabled = p8;
        p7.SoundFontGui.Gui.Enabled = p7.Enabled;
    end;
end;
function v6._initializeGuiButtons(p10) --[[ Line: 41 ]]
    -- upvalues: u5 (ref), u4 (ref), u3 (copy)
    local v11 = {};
    for u12, v13 in ipairs(u5) do
        if v13 ~= false then
            local l__Name__3 = v13.Name;
            local _ = v13.Category;
            local _ = v13.Uploader or "???";
            local v14 = p10.SoundFontGui.SoundFontTemplate:Clone();
            local l__NameLabel__4 = v14:WaitForChild("NameLabel");
            l__NameLabel__4.Text = l__Name__3;
            v14.Name = l__Name__3;
            v14.Activated:Connect(function() --[[ Line: 50 ]]
                -- upvalues: u4 (ref), u12 (copy)
                u4:ChangeSoundFont(u12);
            end);
            p10.SoundFontGui.SoundFontTemplate.Visible = false;
            v14.Visible = true;
            v14.Parent = p10.SoundFontGui.ListFrame;
            v11[u12] = v14;
            if v13.Highlight then
                local v15;
                if typeof(v13.Highlight) == "Color3" then
                    v15 = v13.Highlight;
                else
                    v15 = u3;
                end;
                l__NameLabel__4.TextColor3 = v15;
            end;
        end;
    end;
    p10._soundFontButtons = v11;
end;
function v6._updateSoundFontCanvasSize(p16) --[[ Line: 64 ]]
    local l__ListFrame__5 = p16.SoundFontGui.ListFrame;
    l__ListFrame__5.CanvasSize = UDim2.fromOffset(0, p16.SoundFontGui.ListLayout.AbsoluteContentSize.Y);
    p16.SoundFontGui.ListPadding.PaddingRight = UDim.new(0, l__ListFrame__5.AbsoluteCanvasSize.Y > l__ListFrame__5.AbsoluteSize.Y and 7 or 0);
end;
function v6._setActiveSoundFontButton(p17, p18) --[[ Line: 70 ]]
    -- upvalues: u2 (copy), u1 (copy)
    if p17._activeSoundFontButton then
        p17._activeSoundFontButton.BorderColor3 = u2;
    end;
    p17._activeSoundFontButton = p17._soundFontButtons[p18];
    p17._activeSoundFontButton.BorderColor3 = u1;
end;
function v6.DragFrame(u19, u20, u21) --[[ Line: 78 ]]
    -- upvalues: l__UserInputService__1 (copy)
    u19._dragging = true;
    local u22 = nil;
    local l__Position__6 = u21.Position;
    local l__Position__7 = u20.Position;
    local u25 = l__UserInputService__1.InputChanged:Connect(function(p23) --[[ Line: 84 ]]
        -- upvalues: u19 (copy), l__Position__6 (copy), u20 (copy), l__Position__7 (copy)
        if p23.UserInputType == Enum.UserInputType.MouseMovement and u19._dragging then
            if p23.Position.X + p23.Position.Y == 0 then
                return;
            end;
            local v24 = p23.Position - l__Position__6;
            u20.Position = UDim2.new(l__Position__7.X.Scale, l__Position__7.X.Offset + v24.X, l__Position__7.Y.Scale, l__Position__7.Y.Offset + v24.Y);
        end;
    end);
    u22 = u21.Changed:Connect(function() --[[ Line: 91 ]]
        -- upvalues: u21 (copy), u19 (copy), u25 (ref), u22 (ref)
        if u21.UserInputState == Enum.UserInputState.End then
            u19._dragging = false;
            u25:Disconnect();
            u22:Disconnect();
        end;
    end);
end;
function v6.Init(p26) --[[ Line: 100 ]]
    -- upvalues: u4 (ref), u5 (ref)
    u4 = script.Parent.Parent:WaitForChild("PianoController");
    u5 = require(u4.SoundFonts);
    u4 = require(u4);
    p26:ToggleEnabled(false, true);
end;
function v6.Start(u27) --[[ Line: 107 ]]
    -- upvalues: u4 (ref)
    u27.SoundFontGui.MainFrame.InputBegan:Connect(function(p28) --[[ Line: 108 ]]
        -- upvalues: u27 (copy)
        if p28.UserInputType == Enum.UserInputType.MouseButton1 and u27.Enabled then
            u27:DragFrame(u27.SoundFontGui.MainFrame, p28);
        end;
    end);
    u27.SoundFontGui.CloseButton.Activated:Connect(function() --[[ Line: 113 ]]
        -- upvalues: u27 (copy)
        u27:ToggleEnabled(false, true);
    end);
    u27:_initializeGuiButtons();
    u4.SoundFontChanged:Connect(function(p29) --[[ Line: 117 ]]
        -- upvalues: u27 (copy)
        u27:_setActiveSoundFontButton(p29);
    end);
    u4.Deactivated:Connect(function() --[[ Line: 120 ]]
        -- upvalues: u27 (copy)
        u27:ToggleEnabled(false, true);
    end);
    u27:_setActiveSoundFontButton(u4.SoundFont);
    u27.SoundFontGui.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() --[[ Line: 124 ]]
        -- upvalues: u27 (copy)
        u27:_updateSoundFontCanvasSize();
    end);
end;
return v6;
