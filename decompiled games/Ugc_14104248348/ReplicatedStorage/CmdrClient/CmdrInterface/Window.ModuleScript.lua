-- Decompiled from: ReplicatedStorage.CmdrClient.CmdrInterface.Window
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__GuiService__1 = game:GetService("GuiService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__TextService__3 = game:GetService("TextService");
local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
local u1 = { Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.Touch };
local u2 = {
    Valid = true,
    AutoComplete = nil,
    ProcessEntry = nil,
    OnTextChanged = nil,
    Cmdr = nil,
    HistoryState = nil
};
local l__Frame__5 = l__LocalPlayer__4:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Frame");
local l__Line__6 = l__Frame__5:WaitForChild("Line");
local l__Entry__7 = l__Frame__5:WaitForChild("Entry");
l__Line__6.Parent = nil;
function u2.UpdateLabel(p3) --[[ Line: 30 ]]
    -- upvalues: l__Entry__7 (copy), l__LocalPlayer__4 (copy)
    l__Entry__7.TextLabel.Text = l__LocalPlayer__4.Name .. "@" .. p3.Cmdr.PlaceName .. "$";
    l__Entry__7.TextLabel.Size = UDim2.new(0, l__Entry__7.TextLabel.TextBounds.X, 0, 20);
    l__Entry__7.TextBox.Position = UDim2.new(0, l__Entry__7.TextLabel.Size.X.Offset + 7, 0, 0);
end;
function u2.GetLabel(_) --[[ Line: 37 ]]
    -- upvalues: l__Entry__7 (copy)
    return l__Entry__7.TextLabel.Text;
end;
function u2.UpdateWindowHeight(_) --[[ Line: 42 ]]
    -- upvalues: l__Frame__5 (copy)
    local v4 = 20;
    for _, v5 in pairs(l__Frame__5:GetChildren()) do
        if v5:IsA("GuiObject") then
            v4 = v4 + v5.Size.Y.Offset;
        end;
    end;
    l__Frame__5.CanvasSize = UDim2.new(l__Frame__5.CanvasSize.X.Scale, l__Frame__5.CanvasSize.X.Offset, 0, v4);
    l__Frame__5.Size = UDim2.new(l__Frame__5.Size.X.Scale, l__Frame__5.Size.X.Offset, 0, v4 > 300 and 300 or v4);
    l__Frame__5.CanvasPosition = Vector2.new(0, (math.clamp(v4 - 300, 0, (1 / 0))));
end;
function u2.AddLine(p6, p7, p8) --[[ Line: 64 ]]
    -- upvalues: u2 (copy), l__Line__6 (copy), l__TextService__3 (copy), l__Frame__5 (copy)
    local v9 = tostring(p7);
    if #v9 == 0 then
        u2:UpdateWindowHeight();
    else
        local v10 = p6.Cmdr.Util.EmulateTabstops(v9 or "nil", 8);
        local v11 = l__Line__6:Clone();
        v11.Size = UDim2.new(v11.Size.X.Scale, v11.Size.X.Offset, 0, l__TextService__3:GetTextSize(v10, v11.TextSize, v11.Font, Vector2.new(l__Frame__5.UIListLayout.AbsoluteContentSize.X, (1 / 0))).Y + (20 - v11.TextSize));
        v11.Text = v10;
        v11.TextColor3 = p8 or v11.TextColor3;
        v11.Parent = l__Frame__5;
    end;
end;
function u2.IsVisible(_) --[[ Line: 92 ]]
    -- upvalues: l__Frame__5 (copy)
    return l__Frame__5.Visible;
end;
function u2.SetVisible(p12, p13) --[[ Line: 97 ]]
    -- upvalues: l__Frame__5 (copy), l__Entry__7 (copy), l__UserInputService__2 (copy)
    l__Frame__5.Visible = p13;
    if p13 then
        l__Entry__7.TextBox:CaptureFocus();
        p12:SetEntryText("");
        if p12.Cmdr.ActivationUnlocksMouse then
            p12.PreviousMouseBehavior = l__UserInputService__2.MouseBehavior;
            l__UserInputService__2.MouseBehavior = Enum.MouseBehavior.Default;
        end;
    else
        l__Entry__7.TextBox:ReleaseFocus();
        p12.AutoComplete:Hide();
        if p12.PreviousMouseBehavior then
            l__UserInputService__2.MouseBehavior = p12.PreviousMouseBehavior;
            p12.PreviousMouseBehavior = nil;
        end;
    end;
end;
function u2.Hide(p14) --[[ Line: 120 ]]
    return p14:SetVisible(false);
end;
function u2.Show(p15) --[[ Line: 125 ]]
    return p15:SetVisible(true);
end;
function u2.SetEntryText(p16, p17) --[[ Line: 130 ]]
    -- upvalues: l__Entry__7 (copy)
    l__Entry__7.TextBox.Text = p17;
    if p16:IsVisible() then
        l__Entry__7.TextBox:CaptureFocus();
        l__Entry__7.TextBox.CursorPosition = #p17 + 1;
    end;
end;
function u2.GetEntryText(_) --[[ Line: 140 ]]
    -- upvalues: l__Entry__7 (copy)
    return l__Entry__7.TextBox.Text:gsub("\t", "");
end;
function u2.SetIsValidInput(p18, p19, p20) --[[ Line: 146 ]]
    -- upvalues: l__Entry__7 (copy)
    l__Entry__7.TextBox.TextColor3 = p19 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 73, 73);
    p18.Valid = p19;
    p18._errorText = p20;
end;
function u2.HideInvalidState(_) --[[ Line: 152 ]]
    -- upvalues: l__Entry__7 (copy)
    l__Entry__7.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255);
end;
function u2.LoseFocus(p21, p22) --[[ Line: 157 ]]
    -- upvalues: l__Entry__7 (copy), l__Frame__5 (copy), l__GuiService__1 (copy)
    local l__Text__8 = l__Entry__7.TextBox.Text;
    p21:ClearHistoryState();
    if l__Frame__5.Visible and not l__GuiService__1.MenuIsOpen then
        l__Entry__7.TextBox:CaptureFocus();
    elseif l__GuiService__1.MenuIsOpen and l__Frame__5.Visible then
        p21:Hide();
    end;
    if p22 and p21.Valid then
        wait();
        p21:SetEntryText("");
        p21.ProcessEntry(l__Text__8);
    else
        if p22 then
            p21:AddLine(p21._errorText, Color3.fromRGB(255, 153, 153));
        end;
    end;
end;
function u2.TraverseHistory(p23, p24) --[[ Line: 178 ]]
    local v25 = p23.Cmdr.Dispatcher:GetHistory();
    if p23.HistoryState == nil then
        p23.HistoryState = {
            Position = #v25 + 1,
            InitialText = p23:GetEntryText()
        };
    end;
    p23.HistoryState.Position = math.clamp(p23.HistoryState.Position + p24, 1, #v25 + 1);
    p23:SetEntryText(p23.HistoryState.Position == #v25 + 1 and p23.HistoryState.InitialText or v25[p23.HistoryState.Position]);
end;
function u2.ClearHistoryState(p26) --[[ Line: 197 ]]
    p26.HistoryState = nil;
end;
function u2.SelectVertical(p27, p28) --[[ Line: 201 ]]
    if p27.AutoComplete:IsVisible() and not p27.HistoryState then
        p27.AutoComplete:Select(p28);
    else
        p27:TraverseHistory(p28);
    end;
end;
local u29 = 0;
local u30 = 0;
function u2.BeginInput(p31, p32, p33) --[[ Line: 212 ]]
    -- upvalues: l__GuiService__1 (copy), u29 (ref), u30 (ref), u1 (copy), l__Frame__5 (copy)
    if l__GuiService__1.MenuIsOpen then
        p31:Hide();
    end;
    if p33 and p31:IsVisible() == false then
    elseif p31.Cmdr.ActivationKeys[p32.KeyCode] then
        if p31.Cmdr.MashToEnable and not p31.Cmdr.Enabled then
            if tick() - u29 < 1 then
                if u30 >= 5 then
                    return p31.Cmdr:SetEnabled(true);
                end;
                u30 = u30 + 1;
            else
                u30 = 1;
            end;
            u29 = tick();
        else
            if p31.Cmdr.Enabled then
                p31:SetVisible(not p31:IsVisible());
                wait();
                p31:SetEntryText("");
                if l__GuiService__1.MenuIsOpen then
                    p31:Hide();
                end;
            end;
        end;
    elseif p31.Cmdr.Enabled == false or not p31:IsVisible() then
        if p31:IsVisible() then
            p31:Hide();
        end;
    else
        if p31.Cmdr.HideOnLostFocus and table.find(u1, p32.UserInputType) then
            local l__Position__9 = p32.Position;
            local l__AbsolutePosition__10 = l__Frame__5.AbsolutePosition;
            local l__AbsoluteSize__11 = l__Frame__5.AbsoluteSize;
            if l__Position__9.X < l__AbsolutePosition__10.X or (l__Position__9.X > l__AbsolutePosition__10.X + l__AbsoluteSize__11.X or (l__Position__9.Y < l__AbsolutePosition__10.Y or l__Position__9.Y > l__AbsolutePosition__10.Y + l__AbsoluteSize__11.Y)) then
                p31:Hide();
            end;
        else
            if p32.KeyCode == Enum.KeyCode.Down then
                p31:SelectVertical(1);
                return;
            end;
            if p32.KeyCode == Enum.KeyCode.Up then
                p31:SelectVertical(-1);
                return;
            end;
            if p32.KeyCode == Enum.KeyCode.Return then
                wait();
                p31:SetEntryText(p31:GetEntryText():gsub("\n", ""):gsub("\r", ""));
                return;
            end;
            if p32.KeyCode == Enum.KeyCode.Tab then
                local v34 = p31.AutoComplete:GetSelectedItem();
                local v35 = p31:GetEntryText();
                if v34 and not (v35:sub(#v35, #v35):match("%s") and p31.AutoComplete.LastItem) then
                    local v36 = v34[2];
                    local l__Command__12 = p31.AutoComplete.Command;
                    local v37, v38;
                    if l__Command__12 then
                        local l__Arg__13 = p31.AutoComplete.Arg;
                        v37 = l__Command__12.Alias;
                        if p31.AutoComplete.NumArgs == #l__Command__12.ArgumentDefinitions then
                            v38 = false;
                        else
                            v38 = p31.AutoComplete.IsPartial == false;
                        end;
                        local l__Arguments__14 = l__Command__12.Arguments;
                        for v39 = 1, #l__Arguments__14 do
                            local v40 = l__Arguments__14[v39];
                            local l__RawSegments__15 = v40.RawSegments;
                            if v40 == l__Arg__13 then
                                l__RawSegments__15[#l__RawSegments__15] = v36;
                            end;
                            local v41 = v40.Prefix .. table.concat(l__RawSegments__15, ",");
                            if v41:find(" ") or v41 == "" then
                                v41 = ("%q"):format(v41);
                            end;
                            v37 = ("%s %s"):format(v37, v41);
                            if v40 == l__Arg__13 then
                                break;
                            end;
                        end;
                    else
                        v37 = v36;
                        v38 = true;
                    end;
                    wait();
                    p31:SetEntryText(v37 .. (v38 and " " or ""));
                    return;
                else
                    wait();
                    p31:SetEntryText(p31:GetEntryText());
                    return;
                end;
            end;
            p31:ClearHistoryState();
        end;
    end;
end;
l__Entry__7.TextBox.FocusLost:Connect(function(p42) --[[ Line: 323 ]]
    -- upvalues: u2 (copy)
    return u2:LoseFocus(p42);
end);
l__UserInputService__2.InputBegan:Connect(function(p43, p44) --[[ Line: 329 ]]
    -- upvalues: u2 (copy)
    return u2:BeginInput(p43, p44);
end);
l__Entry__7.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 335 ]]
    -- upvalues: l__Entry__7 (copy), u2 (copy)
    if l__Entry__7.TextBox.Text:match("\t") then
        l__Entry__7.TextBox.Text = l__Entry__7.TextBox.Text:gsub("\t", "");
    else
        if u2.OnTextChanged then
            return u2.OnTextChanged(l__Entry__7.TextBox.Text);
        end;
    end;
end);
l__Frame__5.ChildAdded:Connect(u2.UpdateWindowHeight);
return u2;
