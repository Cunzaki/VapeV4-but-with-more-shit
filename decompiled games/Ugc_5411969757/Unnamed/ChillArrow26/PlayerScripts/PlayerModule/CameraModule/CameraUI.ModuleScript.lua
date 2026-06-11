-- Decompiled from: .ChillArrow26.PlayerScripts.PlayerModule.CameraModule.CameraUI
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__TweenService__2 = game:GetService("TweenService");
local l__LocalPlayer__3 = l__Players__1.LocalPlayer;
if not l__LocalPlayer__3 then
    l__Players__1:GetPropertyChangedSignal("LocalPlayer"):Wait();
    l__LocalPlayer__3 = l__Players__1.LocalPlayer;
end;
local u4 = (function(p1, p2) --[[ Name: waitForChildOfClass, Line 10 ]]
    local v3 = p1:FindFirstChildOfClass(p2);
    while not v3 or v3.ClassName ~= p2 do
        v3 = p1.ChildAdded:Wait();
    end;
    return v3;
end)(l__LocalPlayer__3, "PlayerGui");
local u5 = UDim2.new(0, 326, 0, 58);
local u6 = UDim2.new(0, 80, 0, 58);
local u7 = Color3.fromRGB(32, 32, 32);
local u8 = Color3.fromRGB(200, 200, 200);
local u9 = false;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local function u59() --[[ Line: 54 ]]
    -- upvalues: u9 (ref), u10 (ref), u6 (copy), u7 (copy), u8 (copy), u4 (copy), u11 (ref), u12 (ref), u13 (ref), u14 (ref)
    assert(not u9);
    local u15 = "ScreenGui";
    local function v20(p16) --[[ Line: 29 ]]
        -- upvalues: u15 (copy)
        local v17 = Instance.new(u15);
        local l__Parent__4 = p16.Parent;
        p16.Parent = nil;
        for v18, v19 in pairs(p16) do
            if type(v18) == "string" then
                v17[v18] = v19;
            else
                v19.Parent = v17;
            end;
        end;
        v17.Parent = l__Parent__4;
        return v17;
    end;
    local v21 = {
        Name = "RbxCameraUI",
        AutoLocalize = false,
        Enabled = true,
        DisplayOrder = -1,
        IgnoreGuiInset = false,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    };
    local u22 = "ImageLabel";
    local function v27(p23) --[[ Line: 29 ]]
        -- upvalues: u22 (copy)
        local v24 = Instance.new(u22);
        local l__Parent__5 = p23.Parent;
        p23.Parent = nil;
        for v25, v26 in pairs(p23) do
            if type(v25) == "string" then
                v24[v25] = v26;
            else
                v26.Parent = v24;
            end;
        end;
        v24.Parent = l__Parent__5;
        return v24;
    end;
    local v28 = {
        Name = "Toast",
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0, 8),
        Size = u6,
        Image = "rbxasset://textures/ui/Camera/CameraToast9Slice.png",
        ImageColor3 = u7,
        ImageRectSize = Vector2.new(6, 6),
        ImageTransparency = 1,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(3, 3, 3, 3),
        ClipsDescendants = true
    };
    local u29 = "Frame";
    local function v34(p30) --[[ Line: 29 ]]
        -- upvalues: u29 (copy)
        local v31 = Instance.new(u29);
        local l__Parent__6 = p30.Parent;
        p30.Parent = nil;
        for v32, v33 in pairs(p30) do
            if type(v32) == "string" then
                v31[v32] = v33;
            else
                v33.Parent = v31;
            end;
        end;
        v31.Parent = l__Parent__6;
        return v31;
    end;
    local v35 = {
        Name = "IconBuffer",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 80, 1, 0)
    };
    local u36 = "ImageLabel";
    v35[1] = (function(p37) --[[ Line: 29 ]]
    -- upvalues: u36 (copy)
    local v38 = Instance.new(u36);
    local l__Parent__7 = p37.Parent;
    p37.Parent = nil;
    for v39, v40 in pairs(p37) do
        if type(v39) == "string" then
            v38[v39] = v40;
        else
            v40.Parent = v38;
        end;
    end;
    v38.Parent = l__Parent__7;
    return v38;
end)({
    Name = "Icon",
    BackgroundTransparency = 1,
    ZIndex = 2,
    Image = "rbxasset://textures/ui/Camera/CameraToastIcon.png",
    ImageTransparency = 1,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 48, 0, 48),
    ImageColor3 = u8
});
    local v41 = v34(v35);
    local u42 = "Frame";
    local function v47(p43) --[[ Line: 29 ]]
        -- upvalues: u42 (copy)
        local v44 = Instance.new(u42);
        local l__Parent__8 = p43.Parent;
        p43.Parent = nil;
        for v45, v46 in pairs(p43) do
            if type(v45) == "string" then
                v44[v45] = v46;
            else
                v46.Parent = v44;
            end;
        end;
        v44.Parent = l__Parent__8;
        return v44;
    end;
    local v48 = {
        Name = "TextBuffer",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 80, 0, 0),
        Size = UDim2.new(1, -80, 1, 0),
        ClipsDescendants = true
    };
    local u49 = "TextLabel";
    local u50 = "TextLabel";
    v48[1], v48[2] = (function(p51) --[[ Line: 29 ]]
    -- upvalues: u49 (copy)
    local v52 = Instance.new(u49);
    local l__Parent__9 = p51.Parent;
    p51.Parent = nil;
    for v53, v54 in pairs(p51) do
        if type(v53) == "string" then
            v52[v53] = v54;
        else
            v54.Parent = v52;
        end;
    end;
    v52.Parent = l__Parent__9;
    return v52;
end)({
    Name = "Upper",
    BackgroundTransparency = 1,
    Text = "Camera control enabled",
    TextTransparency = 1,
    TextSize = 19,
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 0, 0.5, 0),
    Size = UDim2.new(1, 0, 0, 19),
    Font = Enum.Font.GothamSemibold,
    TextColor3 = u8,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center
}), (function(p55) --[[ Line: 29 ]]
    -- upvalues: u50 (copy)
    local v56 = Instance.new(u50);
    local l__Parent__10 = p55.Parent;
    p55.Parent = nil;
    for v57, v58 in pairs(p55) do
        if type(v57) == "string" then
            v56[v57] = v58;
        else
            v58.Parent = v56;
        end;
    end;
    v56.Parent = l__Parent__10;
    return v56;
end)({
    Name = "Lower",
    BackgroundTransparency = 1,
    Text = "Right mouse button to toggle",
    TextTransparency = 1,
    TextSize = 15,
    AnchorPoint = Vector2.new(0, 0),
    Position = UDim2.new(0, 0, 0.5, 3),
    Size = UDim2.new(1, 0, 0, 15),
    Font = Enum.Font.Gotham,
    TextColor3 = u8,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center
});
    v28[1], v28[2] = v41, v47(v48);
    v21[1] = v27(v28);
    v21.Parent = u4;
    u10 = v20(v21);
    u11 = u10.Toast;
    u12 = u11.IconBuffer.Icon;
    u13 = u11.TextBuffer.Upper;
    u14 = u11.TextBuffer.Lower;
    u9 = true;
end;
local u60 = {};
function u60.setCameraModeToastEnabled(p61) --[[ Line: 157 ]]
    -- upvalues: u9 (ref), u59 (copy), u11 (ref), u60 (copy)
    if p61 or u9 then
        if not u9 then
            u59();
        end;
        u11.Visible = p61;
        if not p61 then
            u60.setCameraModeToastOpen(false);
        end;
    end;
end;
local u62 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
function u60.setCameraModeToastOpen(p63) --[[ Line: 175 ]]
    -- upvalues: u9 (ref), l__TweenService__2 (copy), u11 (ref), u62 (copy), u5 (copy), u6 (copy), u12 (ref), u13 (ref), u14 (ref)
    assert(u9);
    l__TweenService__2:Create(u11, u62, {
        Size = p63 and u5 or u6,
        ImageTransparency = p63 and 0.4 or 1
    }):Play();
    l__TweenService__2:Create(u12, u62, {
        ImageTransparency = p63 and 0 or 1
    }):Play();
    l__TweenService__2:Create(u13, u62, {
        TextTransparency = p63 and 0 or 1
    }):Play();
    l__TweenService__2:Create(u14, u62, {
        TextTransparency = p63 and 0 or 1
    }):Play();
end;
return u60;
