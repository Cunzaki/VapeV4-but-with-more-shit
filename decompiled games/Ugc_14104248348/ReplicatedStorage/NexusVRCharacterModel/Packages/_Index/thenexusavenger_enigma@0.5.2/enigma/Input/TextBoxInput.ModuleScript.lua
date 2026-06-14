-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_enigma@0.5.2.enigma.Input.TextBoxInput
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__UserInputService__3 = game:GetService("UserInputService");
local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 27 ]]
    -- upvalues: u1 (copy), l__Players__1 (copy), l__UserInputService__3 (copy), l__RunService__2 (copy)
    local u3 = setmetatable({
        WindowFocused = true,
        LastHeartbeatTime = 0,
        Events = {},
        TextBoxEvents = {}
    }, u1);
    u3:CreateTextBox(p2 or l__Players__1.LocalPlayer:WaitForChild("PlayerGui"));
    table.insert(u3.Events, l__UserInputService__3.InputBegan:Connect(function(p4) --[[ Line: 38 ]]
        -- upvalues: u3 (copy)
        if p4.KeyCode == Enum.KeyCode.F13 then
            u3.LastHeartbeatTime = tick();
            u3:TryCaptureFocus();
        end;
    end));
    table.insert(u3.Events, l__UserInputService__3.WindowFocused:Connect(function() --[[ Line: 43 ]]
        -- upvalues: u3 (copy)
        u3.WindowFocused = true;
        u3:TryCaptureFocus();
    end));
    table.insert(u3.Events, l__UserInputService__3.WindowFocusReleased:Connect(function() --[[ Line: 47 ]]
        -- upvalues: u3 (copy)
        u3.WindowFocused = false;
        u3:TryReleaseFocus();
    end));
    table.insert(u3.Events, l__RunService__2.Stepped:Connect(function() --[[ Line: 51 ]]
        -- upvalues: u3 (copy)
        u3:TryCaptureFocus();
    end));
    return u3;
end;
function u1.CreateTextBox(u5, u6) --[[ Line: 63 ]]
    for _, v7 in u5.TextBoxEvents do
        v7:Disconnect();
    end;
    u5.TextBoxEvents = {};
    if u5.ScreenGui then
        u5.ScreenGui:Destroy();
    end;
    if u5.TextBox then
        u5.TextBox:Destroy();
    end;
    local u8 = Instance.new("ScreenGui");
    u8.Name = "EnigmaTextBoxInput";
    u8.ResetOnSpawn = false;
    u8.Parent = u6;
    u5.ScreenGui = u8;
    local u9 = Instance.new("TextBox");
    u9.Name = "EnigmaTextBox";
    u9.BackgroundTransparency = 0.99;
    u9.BorderSizePixel = 0;
    u9.Size = UDim2.new(0, 1, 0, 1);
    u9.Selectable = false;
    u9.ClipsDescendants = true;
    u9.ClearTextOnFocus = true;
    u9.TextTransparency = 0.99;
    u9.Parent = u8;
    u5.TextBox = u9;
    table.insert(u5.TextBoxEvents, u9.AncestryChanged:Connect(function() --[[ Line: 96 ]]
        -- upvalues: u5 (copy), u6 (copy)
        u5:CreateTextBox(u6);
    end));
    for _, u10 in { "Enabled" } do
        local u11 = u8[u10];
        local l__TextBoxEvents__4 = u5.TextBoxEvents;
        local v12 = u8:GetPropertyChangedSignal(u10);
        table.insert(l__TextBoxEvents__4, v12:Connect(function() --[[ Line: 101 ]]
            -- upvalues: u8 (copy), u10 (copy), u11 (copy)
            u8[u10] = u11;
        end));
    end;
    for _, u13 in {
        "BackgroundTransparency",
        "Size",
        "ClipsDescendants",
        "Visible",
        "TextTransparency"
    } do
        local u14 = u9[u13];
        local l__TextBoxEvents__5 = u5.TextBoxEvents;
        local v15 = u9:GetPropertyChangedSignal(u13);
        table.insert(l__TextBoxEvents__5, v15:Connect(function() --[[ Line: 107 ]]
            -- upvalues: u9 (copy), u13 (copy), u14 (copy)
            u9[u13] = u14;
        end));
    end;
end;
function u1.GetCurrentText(p16) --[[ Line: 117 ]]
    return not p16.TextBox and "" or p16.TextBox.Text;
end;
function u1.TryCaptureFocus(p17) --[[ Line: 125 ]]
    -- upvalues: l__UserInputService__3 (copy)
    if p17.WindowFocused and tick() - p17.LastHeartbeatTime <= 0.5 then
        if p17.TextBox then
            if l__UserInputService__3:GetFocusedTextBox() == p17.TextBox then
            else
                p17.TextBox:CaptureFocus();
            end;
        end;
    else
        p17:TryReleaseFocus();
    end;
end;
function u1.TryReleaseFocus(p18) --[[ Line: 141 ]]
    -- upvalues: l__UserInputService__3 (copy)
    if p18.TextBox then
        if l__UserInputService__3:GetFocusedTextBox() == p18.TextBox then
            p18.TextBox:ReleaseFocus();
        end;
    end;
end;
function u1.Destroy(p19) --[[ Line: 150 ]]
    for _, v20 in p19.Events do
        v20:Disconnect();
    end;
    p19.Events = {};
    for _, v21 in p19.TextBoxEvents do
        v21:Disconnect();
    end;
    p19.TextBoxEvents = {};
    if p19.ScreenGui then
        p19.ScreenGui:Destroy();
    end;
    p19.ScreenGui = nil;
    if p19.TextBox then
        p19.TextBox:Destroy();
    end;
    p19.TextBox = nil;
end;
return u1;
