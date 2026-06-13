-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-button@2.5.2.nexus-button.Button
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = Color3.fromRGB(50, 50, 50);
local l__GuiService__1 = game:GetService("GuiService");
local l__TweenService__2 = game:GetService("TweenService");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__NexusInstance__4 = require(script.Parent:WaitForChild("Packages"):WaitForChild("NexusInstance"));
local l__ControllerIcon__5 = require(script.Parent:WaitForChild("ControllerIcon"));
local l__SimpleWrappedInstance__6 = require(script.Parent:WaitForChild("SimpleWrappedInstance"));
local l__ThemedFrame__7 = require(script.Parent:WaitForChild("ThemedFrame"));
local v2 = {
    Themes = l__ThemedFrame__7.Themes
};
v2.__index = v2;
setmetatable(v2, l__SimpleWrappedInstance__6);
function v2.__new(u3) --[[ Line: 59 ]]
    -- upvalues: l__SimpleWrappedInstance__6 (copy), l__ThemedFrame__7 (copy), l__ControllerIcon__5 (copy), u1 (copy), l__GuiService__1 (copy), l__UserInputService__3 (copy)
    l__SimpleWrappedInstance__6.__new(u3, Instance.new("TextButton"));
    local v4 = u3:GetWrappedInstance();
    v4.BackgroundTransparency = 1;
    v4.Text = "";
    local u5 = l__ThemedFrame__7.new();
    u5.Parent = v4;
    u3:DisableChangeReplication("BorderFrame");
    u3.BorderFrame = u5;
    local u6 = l__ThemedFrame__7.new();
    u6.Size = UDim2.new(1, 0, 1, 0);
    u6.ZIndex = 2;
    u6.Parent = v4;
    u3:DisableChangeReplication("BackgroundFrame");
    u3.BackgroundFrame = u6;
    u6:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 79 ]]
        -- upvalues: u3 (copy)
        u3:UpdateBorder(false);
    end);
    local v7 = Instance.new("Frame");
    v7.BackgroundTransparency = 1;
    v7.Size = UDim2.new(1, 0, 1, 0);
    v7.ZIndex = 3;
    v7.Parent = v4;
    u3:DisableChangeReplication("ContentsAdorn");
    u3.ContentsAdorn = v7;
    local u8 = l__ControllerIcon__5.new();
    u8.BackgroundColor3 = u1;
    u8.Size = UDim2.new(1, 0, 1, 0);
    u8.Position = UDim2.new(1, 0, 0, 0);
    u8.SizeConstraint = Enum.SizeConstraint.RelativeYY;
    u8.AnchorPoint = Vector2.new(1, 0);
    u8.ZIndex = 4;
    u8.Parent = v4;
    u3:DisableChangeReplication("GamepadIcon");
    u3.GamepadIcon = u8;
    u3:DisableChangeReplication("MouseButton1Down");
    u3.MouseButton1Down = u3:CreateEvent();
    u3:GetWrappedInstance().MouseButton1Down:Connect(function(...) --[[ Line: 105 ]]
        -- upvalues: u3 (copy)
        u3.MouseButton1Down:Fire(...);
    end);
    u3:DisableChangeReplication("MouseButton1Up");
    u3.MouseButton1Up = u3:CreateEvent();
    u3:GetWrappedInstance().MouseButton1Up:Connect(function(...) --[[ Line: 110 ]]
        -- upvalues: u3 (copy)
        u3.MouseButton1Up:Fire(...);
    end);
    u3:DisableChangeReplication("MouseButton1Click");
    u3.MouseButton1Click = u3:CreateEvent();
    u3:GetWrappedInstance().MouseButton1Click:Connect(function() --[[ Line: 115 ]]
        -- upvalues: u3 (copy)
        u3.MouseButton1Click:Fire();
    end);
    u3:DisableChangeReplication("MouseButton2Down");
    u3.MouseButton2Down = u3:CreateEvent();
    u3:GetWrappedInstance().MouseButton2Down:Connect(function(...) --[[ Line: 120 ]]
        -- upvalues: u3 (copy)
        u3.MouseButton2Down:Fire(...);
    end);
    u3:DisableChangeReplication("MouseButton2Up");
    u3.MouseButton2Up = u3:CreateEvent();
    u3:GetWrappedInstance().MouseButton2Up:Connect(function(...) --[[ Line: 125 ]]
        -- upvalues: u3 (copy)
        u3.MouseButton2Up:Fire(...);
    end);
    u3:DisableChangeReplication("MouseButton2Click");
    u3.MouseButton2Click = u3:CreateEvent();
    u3:GetWrappedInstance().MouseButton2Click:Connect(function() --[[ Line: 130 ]]
        -- upvalues: u3 (copy)
        u3.MouseButton2Click:Fire();
    end);
    u3:DisableChangeReplication("TweenDuration");
    u3:DisableChangeReplication("BackgroundColor3");
    u3:OnPropertyChanged("BackgroundColor3", function() --[[ Line: 137 ]]
        -- upvalues: u3 (copy)
        u3:UpdateBorder(false);
    end);
    u3:DisableChangeReplication("BackgroundTransparency");
    u3:OnPropertyChanged("BackgroundTransparency", function(p9) --[[ Line: 141 ]]
        -- upvalues: u6 (copy)
        u6.BackgroundTransparency = p9;
    end);
    u3:DisableChangeReplication("BorderSize");
    u3:OnPropertyChanged("BorderSize", function() --[[ Line: 145 ]]
        -- upvalues: u3 (copy)
        u3:UpdateBorder(false);
    end);
    u3:DisableChangeReplication("BorderSizePixel");
    u3:OnPropertyChanged("BorderSizePixel", function(p10) --[[ Line: 149 ]]
        -- upvalues: u3 (copy)
        u3.BorderSize = UDim.new(0, p10);
    end);
    u3:DisableChangeReplication("BorderSizeScale");
    u3:OnPropertyChanged("BorderSizeScale", function(p11) --[[ Line: 153 ]]
        -- upvalues: u3 (copy)
        u3.BorderSize = UDim.new(p11, 0);
    end);
    u3:DisableChangeReplication("BorderColor3");
    u3:OnPropertyChanged("BorderColor3", function() --[[ Line: 157 ]]
        -- upvalues: u3 (copy)
        u3:UpdateBorder(false);
    end);
    u3:DisableChangeReplication("BorderColor3");
    u3:OnPropertyChanged("AutoButtonColor", function() --[[ Line: 161 ]]
        -- upvalues: u3 (copy)
        u3:UpdateBorder(false);
    end);
    u3:DisableChangeReplication("BorderTransparency");
    u3:OnPropertyChanged("BorderTransparency", function(p12) --[[ Line: 165 ]]
        -- upvalues: u5 (copy)
        u5.BackgroundTransparency = p12;
    end);
    u3:DisableChangeReplication("Hovering");
    u3:OnPropertyChanged("Hovering", function() --[[ Line: 169 ]]
        -- upvalues: u3 (copy)
        u3:UpdateBorder(true);
    end);
    u3:DisableChangeReplication("Pressed");
    u3:OnPropertyChanged("Pressed", function() --[[ Line: 173 ]]
        -- upvalues: u3 (copy)
        u3:UpdateBorder(true);
    end);
    u3:DisableChangeReplication("Theme");
    u3:OnPropertyChanged("Theme", function(_) --[[ Line: 177 ]]
        -- upvalues: u6 (copy), u3 (copy), u5 (copy), u8 (copy)
        u6.Theme = u3.Theme;
        u5.Theme = u3.Theme;
        u8.Theme = u3.Theme;
    end);
    u3:DisableChangeReplication("MappedInputs");
    u3.MappedInputs = {};
    u3:DisableChangeReplication("EventConnections");
    u3.EventConnections = {};
    u3.MouseEnter:Connect(function() --[[ Line: 188 ]]
        -- upvalues: u3 (copy)
        u3.Hovering = true;
    end);
    u3.MouseLeave:Connect(function() --[[ Line: 191 ]]
        -- upvalues: u3 (copy)
        u3.Hovering = false;
    end);
    u3.MouseButton1Down:Connect(function() --[[ Line: 194 ]]
        -- upvalues: u3 (copy)
        u3.Pressed = true;
    end);
    u3.MouseButton1Up:Connect(function() --[[ Line: 197 ]]
        -- upvalues: u3 (copy)
        u3.Pressed = false;
    end);
    local l__EventConnections__8 = u3.EventConnections;
    local v13 = l__GuiService__1:GetPropertyChangedSignal("SelectedObject");
    table.insert(l__EventConnections__8, v13:Connect(function() --[[ Line: 200 ]]
        -- upvalues: u3 (copy)
        u3:UpdateBorder(true);
    end));
    table.insert(u3.EventConnections, l__UserInputService__3.InputBegan:Connect(function(p14, p15) --[[ Line: 203 ]]
        -- upvalues: l__GuiService__1 (ref), u3 (copy)
        if p15 and (l__GuiService__1.SelectedObject ~= u3:GetWrappedInstance() or p14.KeyCode == Enum.KeyCode.ButtonA) then
        elseif u3.Pressed then
        elseif u3.MappedInputs[p14.KeyCode] then
            local v16 = u3.MappedInputs[p14.KeyCode];
            local v17 = u3.AbsolutePosition + u3.AbsoluteSize / 2;
            if v16 == Enum.UserInputType.MouseButton1 then
                u3.MouseButton1Down:Fire(v17.X, v17.Y);
            else
                if v16 == Enum.UserInputType.MouseButton2 then
                    u3.MouseButton2Down:Fire(v17.X, v17.Y);
                end;
            end;
        end;
    end));
    table.insert(u3.EventConnections, l__UserInputService__3.InputEnded:Connect(function(p18) --[[ Line: 216 ]]
        -- upvalues: u3 (copy)
        if u3.Pressed then
            if u3.MappedInputs[p18.KeyCode] then
                local v19 = u3.MappedInputs[p18.KeyCode];
                local v20 = u3.AbsolutePosition + u3.AbsoluteSize / 2;
                if v19 == Enum.UserInputType.MouseButton1 then
                    u3.MouseButton1Up:Fire(v20.X, v20.Y);
                    u3.MouseButton1Click:Fire();
                else
                    if v19 == Enum.UserInputType.MouseButton2 then
                        u3.MouseButton2Up:Fire(v20.X, v20.Y);
                        u3.MouseButton2Click:Fire();
                    end;
                end;
            end;
        end;
    end));
    table.insert(u3.EventConnections, l__UserInputService__3.InputEnded:Connect(function(p21) --[[ Line: 230 ]]
        -- upvalues: u3 (copy)
        if u3.Pressed then
            if p21.UserInputType == Enum.UserInputType.MouseButton1 then
                u3.Pressed = false;
            end;
        end;
    end));
    u3.Size = UDim2.new(0, 200, 0, 50);
    u3.BackgroundColor3 = Color3.fromRGB(204, 204, 204);
    u3.BackgroundTransparency = 0;
    u3.BorderSize = UDim.new(0.15, 0);
    u3.BorderColor3 = Color3.fromRGB(0, 0, 0);
    u3.BorderTransparency = 0;
    u3.AutoButtonColor = true;
    u3.Hovering = false;
    u3.Pressed = false;
    u3.TweenDuration = 0.1;
    u3.Theme = "CutCorners";
end;
function v2.UpdateBorder(p22, p23) --[[ Line: 253 ]]
    -- upvalues: l__GuiService__1 (copy), l__TweenService__2 (copy)
    if p22.BorderSize then
        if p22.Theme then
            local l__AbsoluteSize__9 = p22.BackgroundFrame.AbsoluteSize;
            local v24 = l__AbsoluteSize__9.Y * p22.BorderSize.Scale + p22.BorderSize.Offset;
            local l__BackgroundColor3__10 = p22.BackgroundColor3;
            local l__BorderColor3__11 = p22.BorderColor3;
            if p22.AutoButtonColor ~= false then
                if p22.Pressed then
                    l__BackgroundColor3__10 = Color3.new(math.clamp(l__BackgroundColor3__10.R * 1.4285714285714286, 0, 1), math.clamp(l__BackgroundColor3__10.G * 1.4285714285714286, 0, 1), (math.clamp(l__BackgroundColor3__10.B * 1.4285714285714286, 0, 1)));
                    l__BorderColor3__11 = Color3.new(math.clamp(l__BorderColor3__11.R * 1.4285714285714286, 0, 1), math.clamp(l__BorderColor3__11.G * 1.4285714285714286, 0, 1), (math.clamp(l__BorderColor3__11.B * 1.4285714285714286, 0, 1)));
                    v24 = v24 * 0.25;
                elseif p22.Hovering or l__GuiService__1.SelectedObject == p22:GetWrappedInstance() then
                    l__BackgroundColor3__10 = Color3.new(math.clamp(l__BackgroundColor3__10.R * 0.7, 0, 1), math.clamp(l__BackgroundColor3__10.G * 0.7, 0, 1), (math.clamp(l__BackgroundColor3__10.B * 0.7, 0, 1)));
                    l__BorderColor3__11 = Color3.new(math.clamp(l__BorderColor3__11.R * 0.7, 0, 1), math.clamp(l__BorderColor3__11.G * 0.7, 0, 1), (math.clamp(l__BorderColor3__11.B * 0.7, 0, 1)));
                    v24 = v24 * 0.75;
                end;
            end;
            if p23 and (p22.TweenDuration and p22.TweenDuration > 0) then
                l__TweenService__2:Create(p22.BackgroundFrame:GetWrappedInstance(), TweenInfo.new(p22.TweenDuration), {
                    ImageColor3 = l__BackgroundColor3__10
                }):Play();
                l__TweenService__2:Create(p22.BorderFrame:GetWrappedInstance(), TweenInfo.new(p22.TweenDuration), {
                    ImageColor3 = l__BorderColor3__11,
                    Size = UDim2.new(1, 0, 1, v24)
                }):Play();
            else
                p22.BackgroundFrame.ImageColor3 = l__BackgroundColor3__10;
                p22.BorderFrame.ImageColor3 = l__BorderColor3__11;
                p22.BorderFrame.Size = UDim2.new(1, 0, 1, v24);
            end;
            p22.GamepadIcon.SubTheme = l__AbsoluteSize__9.X / l__AbsoluteSize__9.Y < 1.2 and "MainButton" or "GamepadIconBackground";
        end;
    end;
end;
function v2.GetAdornFrame(p25) --[[ Line: 296 ]]
    return p25.ContentsAdorn;
end;
function v2.SetControllerIcon(p26, p27) --[[ Line: 303 ]]
    p26.GamepadIcon:SetIcon(p27);
end;
function v2.MapKey(p28, p29, p30) --[[ Line: 310 ]]
    if typeof(p29) == "string" then
        p29 = Enum.KeyCode[p29];
    end;
    if typeof(p30) == "string" then
        p30 = Enum.UserInputType[p30];
    end;
    if p30 ~= Enum.UserInputType.MouseButton1 and p30 ~= Enum.UserInputType.MouseButton2 then
        error("Mouse input must be either MouseButton1 or MouseButton2.");
    end;
    p28.MappedInputs[p29] = p30;
end;
function v2.UnmapKey(p31, p32) --[[ Line: 331 ]]
    if typeof(p32) == "string" then
        p32 = Enum.KeyCode[p32];
    end;
    p31.MappedInputs[p32] = nil;
end;
function v2.Destroy(p33) --[[ Line: 344 ]]
    -- upvalues: l__SimpleWrappedInstance__6 (copy)
    l__SimpleWrappedInstance__6.Destroy(p33);
    p33.GamepadIcon:Destroy();
    for _, v34 in p33.EventConnections do
        v34:Disconnect();
    end;
    p33.EventConnections = {};
end;
return l__NexusInstance__4.ToInstance(v2);
