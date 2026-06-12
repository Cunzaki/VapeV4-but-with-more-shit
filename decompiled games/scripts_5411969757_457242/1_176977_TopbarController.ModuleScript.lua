-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
local u3 = {};
u3.__index = u3;
local l__GuiService__1 = game:GetService("GuiService");
local u4 = 12;
local u5 = 8;
local u6 = Instance.new("NumberValue");
local function u8(p7) --[[ Line: 22 ]]
    -- upvalues: u8 (copy)
    Instance.new("UICorner", p7).CornerRadius = UDim.new(1, 0);
    return u8;
end;
function u3.ClearCache() --[[ Line: 28 ]]
    -- upvalues: u1 (ref), u2 (ref)
    for _, v9 in pairs(u1) do
        v9:Destroy();
    end;
    for _, v10 in pairs(u2) do
        v10:Disconnect();
    end;
    table.clear(u1);
    table.clear(u2);
    u1 = {};
    u2 = {};
end;
function u3.GetIsMobile() --[[ Line: 41 ]]
    -- upvalues: l__GuiService__1 (copy)
    return l__GuiService__1.TopbarInset.Max.Y == 52;
end;
function u3.new() --[[ Line: 46 ]]
    -- upvalues: l__GuiService__1 (copy), u4 (ref), u5 (ref), u3 (copy), u2 (ref)
    repeat
        task.wait();
    until l__GuiService__1.TopbarInset.Max.Y > 0;
    if l__GuiService__1.TopbarInset.Max.Y == 52 == true then
        u4 = 6;
        u5 = 6;
    end;
    local v11 = setmetatable({}, u3);
    local v12 = Instance.new("ScreenGui");
    v12.ClipToDeviceSafeArea = false;
    v12.IgnoreGuiInset = true;
    v12.Name = "TopbarGUI";
    v12.DisplayOrder = 1000;
    local u13 = Instance.new("Frame", v12);
    u13.BackgroundTransparency = 1;
    u13.BorderSizePixel = 0;
    local v14 = Instance.new("Frame", u13);
    v14.BackgroundTransparency = 1;
    v14.Size = UDim2.fromScale(1, 1);
    v14.Name = "Left";
    local v15 = Instance.new("UIListLayout", v14);
    v15.Padding = UDim.new(0, u4);
    v15.FillDirection = Enum.FillDirection.Horizontal;
    v15.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    v15.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    v15.SortOrder = Enum.SortOrder.LayoutOrder;
    local v16 = Instance.new("Frame", u13);
    v16.BackgroundTransparency = 1;
    v16.Size = UDim2.fromScale(1, 1);
    v16.Name = "Right";
    local v17 = Instance.new("UIListLayout", v16);
    v17.Padding = UDim.new(0, u4);
    v17.FillDirection = Enum.FillDirection.Horizontal;
    v17.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    v17.HorizontalAlignment = Enum.HorizontalAlignment.Right;
    v17.SortOrder = Enum.SortOrder.LayoutOrder;
    local function v18() --[[ Line: 89 ]]
        -- upvalues: l__GuiService__1 (ref), u13 (copy), u4 (ref)
        local l__TopbarInset__2 = l__GuiService__1.TopbarInset;
        u13.Size = UDim2.new(0, l__TopbarInset__2.Width - 16 - u4, 0, l__TopbarInset__2.Height);
        u13.Position = UDim2.new(0, l__TopbarInset__2.Min.X + u4, 0, l__TopbarInset__2.Min.Y - 2);
    end;
    local v19 = u2;
    local v20 = l__GuiService__1:GetPropertyChangedSignal("TopbarInset");
    table.insert(v19, v20:Connect(v18));
    local l__TopbarInset__3 = l__GuiService__1.TopbarInset;
    u13.Size = UDim2.new(0, l__TopbarInset__3.Width - 16 - u4, 0, l__TopbarInset__3.Height);
    u13.Position = UDim2.new(0, l__TopbarInset__3.Min.X + u4, 0, l__TopbarInset__3.Min.Y - 2);
    v11.GUI = v12;
    v11.Holder = u13;
    v11.Left = v14;
    v11.Right = v16;
    return v11;
end;
function u3.CreateContainer(p21, p22) --[[ Line: 106 ]]
    -- upvalues: u5 (ref), u6 (copy)
    local u23 = Instance.new("Frame");
    u23.Name = "TOPBAR_FRAME_CONTAINER";
    u23.ClipsDescendants = true;
    local u24 = Instance.new("UIListLayout", u23);
    u24.Padding = UDim.new(0, u5);
    u24.FillDirection = Enum.FillDirection.Horizontal;
    u24.VerticalAlignment = Enum.VerticalAlignment.Center;
    u24.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    u24.SortOrder = Enum.SortOrder.LayoutOrder;
    u23.Size = UDim2.fromOffset(44, 44);
    u23.BackgroundTransparency = 0.08;
    u23.BackgroundColor3 = Color3.fromRGB(18, 18, 20);
    Instance.new("UICorner", u23).CornerRadius = UDim.new(1, 0);
    local v25;
    if p22 == "Left" then
        v25 = p21.Left;
    else
        v25 = p21.Right;
    end;
    u23.Parent = v25;
    local function v26() --[[ Line: 121 ]]
        -- upvalues: u24 (copy), u23 (copy), u5 (ref)
        u23.Size = UDim2.fromOffset(u24.AbsoluteContentSize.X + u5, 44);
    end;
    u24:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v26);
    u23.Size = UDim2.fromOffset(u24.AbsoluteContentSize.X + u5, 44);
    u6:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 127 ]]
        -- upvalues: u23 (copy), u6 (ref)
        u23.Transparency = u6.Value;
    end);
    u23.Transparency = u6.Value;
    return u23;
end;
function u3.CreateButton(_, p27, p28) --[[ Line: 133 ]]
    -- upvalues: u5 (ref)
    local v29 = Instance.new("ImageButton", p27);
    v29.Size = UDim2.fromOffset(44, 44);
    v29.AutoButtonColor = false;
    local v30 = Instance.new("ImageLabel", v29);
    v30.BackgroundTransparency = 1;
    v30.AnchorPoint = Vector2.new(0.5, 0.5);
    v30.Image = p28;
    v30.Position = UDim2.fromScale(0.5, 0.5);
    v30.Size = UDim2.fromScale(1, 1);
    Instance.new("UICorner", v29).CornerRadius = UDim.new(1, 0);
    local u31 = Instance.new("Frame", v29);
    u31.BackgroundTransparency = 1;
    u31.Size = UDim2.fromScale(1, 1);
    u31.BackgroundColor3 = Color3.new(1, 1, 1);
    Instance.new("UICorner", u31).CornerRadius = UDim.new(1, 0);
    v29.MouseEnter:Connect(function() --[[ Line: 162 ]]
        -- upvalues: u31 (copy)
        u31.BackgroundTransparency = 0.85;
    end);
    v29.MouseLeave:Connect(function() --[[ Line: 166 ]]
        -- upvalues: u31 (copy)
        u31.BackgroundTransparency = 1;
    end);
    if p27.Name == "TOPBAR_FRAME_CONTAINER" then
        v29.BackgroundTransparency = 1;
        v29.Size = UDim2.fromOffset(44 - u5, 44 - u5);
        return v29;
    else
        v29.BackgroundTransparency = 0.08;
        v29.BackgroundColor3 = Color3.fromRGB(18, 18, 20);
        return v29;
    end;
end;
l__GuiService__1:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() --[[ Name: SetBackgroundTransparency, Line 18 ]]
    -- upvalues: u6 (copy), l__GuiService__1 (copy)
    u6.Value = 0.08 * l__GuiService__1.PreferredTransparency;
end);
u6.Value = 0.08 * l__GuiService__1.PreferredTransparency;
return u3;