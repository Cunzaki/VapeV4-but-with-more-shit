-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.UI.MainMenu
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Workspace__1 = game:GetService("Workspace");
local l__Players__2 = game:GetService("Players");
local l__GuiService__3 = game:GetService("GuiService");
local l__RunService__4 = game:GetService("RunService");
local l__TweenService__5 = game:GetService("TweenService");
local l__Parent__6 = script.Parent.Parent;
local l__NexusButton__7 = require(l__Parent__6:WaitForChild("Packages"):WaitForChild("NexusButton"));
local l__NexusVRCore__8 = require(l__Parent__6:WaitForChild("Packages"):WaitForChild("NexusVRCore"));
local u1 = require(l__Parent__6:WaitForChild("State"):WaitForChild("Settings")).GetInstance();
local u2 = require(l__Parent__6:WaitForChild("State"):WaitForChild("VRInputService")).GetInstance();
local l__ApiBaseView__9 = require(l__Parent__6:WaitForChild("UI"):WaitForChild("View"):WaitForChild("ApiBaseView"));
local l__EnigmaView__10 = require(l__Parent__6:WaitForChild("UI"):WaitForChild("View"):WaitForChild("EnigmaView"));
local l__SettingsView__11 = require(l__Parent__6:WaitForChild("UI"):WaitForChild("View"):WaitForChild("SettingsView"));
local u3 = l__NexusButton__7.TextButtonFactory.CreateDefault(Color3.fromRGB(0, 170, 255));
u3:SetDefault("Theme", "RoundedCorners");
local l__ScreenGui3D__12 = l__NexusVRCore__8.ScreenGui3D;
local u4 = {};
u4.__index = u4;
local u5 = nil;
function u4.new() --[[ Line: 49 ]]
    -- upvalues: u4 (copy), l__ScreenGui3D__12 (copy), l__GuiService__3 (copy), u3 (copy), l__SettingsView__11 (copy), l__EnigmaView__10 (copy), l__Players__2 (copy)
    local u6 = setmetatable({}, u4);
    local v7 = l__ScreenGui3D__12.new();
    v7.ResetOnSpawn = false;
    v7.Enabled = false;
    v7.CanvasSize = Vector2.new(500, 605);
    v7.FieldOfView = 0;
    v7.Easing = 0.25;
    u6.ScreenGui = v7;
    local v8 = Instance.new("Frame");
    v8.BackgroundTransparency = 1;
    v8.Size = UDim2.new(0, 500, 0, 500);
    v8.Parent = v7:GetContainer();
    u6.ViewAdornFrame = v8;
    local u9 = Instance.new("Frame");
    u9.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    u9.BackgroundTransparency = 0.6 * l__GuiService__3.PreferredTransparency;
    u9.Position = UDim2.new(0, 0, 0, 505);
    u9.Size = UDim2.new(1, 0, 0, 100);
    u9.Parent = v8;
    l__GuiService__3:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() --[[ Line: 74 ]]
        -- upvalues: u9 (copy), l__GuiService__3 (ref)
        u9.BackgroundTransparency = 0.6 * l__GuiService__3.PreferredTransparency;
    end);
    local v10 = Instance.new("UICorner");
    v10.CornerRadius = UDim.new(0.25, 0);
    v10.Parent = u9;
    local v11, v12 = u3:Create();
    v11.BorderSize = UDim.new(0.075, 0);
    v11.Size = UDim2.new(0, 80, 0, 80);
    v11.Position = UDim2.new(0, 10, 0, 10);
    v11.Parent = u9;
    v12.Text = "<";
    u6.LeftButton = v11;
    local v13, v14 = u3:Create();
    v13.BorderSize = UDim.new(0.075, 0);
    v13.Size = UDim2.new(0, 80, 0, 80);
    v13.Position = UDim2.new(0, 410, 0, 10);
    v13.Parent = u9;
    v14.Text = ">";
    u6.RightButton = v13;
    local v15 = Instance.new("TextLabel");
    v15.BackgroundTransparency = 1;
    v15.Size = UDim2.new(0, 300, 0, 60);
    v15.Position = UDim2.new(0, 100, 0, 20);
    v15.Font = Enum.Font.SourceSansBold;
    v15.TextScaled = true;
    v15.TextColor3 = Color3.fromRGB(255, 255, 255);
    v15.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
    v15.TextStrokeTransparency = 0;
    v15.Parent = u9;
    u6.ViewTextLabel = v15;
    u6.CurrentView = 1;
    u6.Views = {};
    l__SettingsView__11.new(u6:CreateView("Settings"));
    l__EnigmaView__10.new(u6:CreateView("Enigma"), u6);
    u6:UpdateVisibleView();
    local u16 = true;
    v11.MouseButton1Down:Connect(function() --[[ Line: 119 ]]
        -- upvalues: u16 (ref), u6 (copy)
        if u16 then
            u16 = false;
            u6.CurrentView = u6.CurrentView - 1;
            if u6.CurrentView == 0 then
                u6.CurrentView = #u6.Views;
            end;
            u6:UpdateVisibleView();
            task.wait();
            u16 = true;
        end;
    end);
    v13.MouseButton1Down:Connect(function() --[[ Line: 134 ]]
        -- upvalues: u16 (ref), u6 (copy)
        if u16 then
            u16 = false;
            u6.CurrentView = u6.CurrentView + 1;
            if u6.CurrentView > #u6.Views then
                u6.CurrentView = 1;
            end;
            u6:UpdateVisibleView();
            task.wait();
            u16 = true;
        end;
    end);
    v7.Parent = l__Players__2.LocalPlayer:WaitForChild("PlayerGui");
    return u6;
end;
function u4.GetInstance() --[[ Line: 158 ]]
    -- upvalues: u5 (ref), u4 (copy)
    if not u5 then
        u5 = u4.new();
    end;
    return u5;
end;
function u4.SetUpOpening(u17) --[[ Line: 169 ]]
    -- upvalues: u1 (copy), l__Workspace__1 (copy), u2 (copy), l__TweenService__5 (copy), l__RunService__4 (copy)
    local v18 = u1:GetSetting("Menu.MenuToggleGestureActive");
    local v19 = v18 == nil and true or v18;
    local u20 = Instance.new("Part");
    u20.Transparency = 1;
    u20.Size = Vector3.new();
    u20.Anchored = true;
    u20.CanCollide = false;
    u20.CanQuery = false;
    u20.Parent = l__Workspace__1.CurrentCamera;
    local u21 = Instance.new("BoxHandleAdornment");
    u21.Color3 = Color3.fromRGB(0, 170, 255);
    u21.AlwaysOnTop = true;
    u21.ZIndex = 0;
    u21.Adornee = u20;
    u21.Parent = u20;
    local u22 = Instance.new("Part");
    u22.Transparency = 1;
    u22.Size = Vector3.new();
    u22.Anchored = true;
    u22.CanCollide = false;
    u22.CanQuery = false;
    u22.Parent = l__Workspace__1.CurrentCamera;
    local u23 = Instance.new("BoxHandleAdornment");
    u23.Color3 = Color3.fromRGB(0, 170, 255);
    u23.AlwaysOnTop = true;
    u23.ZIndex = 0;
    u23.Adornee = u22;
    u23.Parent = u22;
    local u24 = Instance.new("Part");
    u24.Transparency = 1;
    u24.Size = Vector3.new(1, 1, 0);
    u24.Anchored = true;
    u24.CanCollide = false;
    u24.CanQuery = false;
    u24.Parent = l__Workspace__1.CurrentCamera;
    local u25 = Instance.new("Part");
    u25.Transparency = 1;
    u25.Size = Vector3.new(1, 1, 0);
    u25.Anchored = true;
    u25.CanCollide = false;
    u25.CanQuery = false;
    u25.Parent = l__Workspace__1.CurrentCamera;
    local u26 = Instance.new("SurfaceGui");
    u26.Active = false;
    u26.Face = Enum.NormalId.Front;
    u26.CanvasSize = Vector2.new(500, 500);
    u26.LightInfluence = 0;
    u26.Enabled = v19;
    u26.AlwaysOnTop = true;
    u26.Adornee = u24;
    u26.Parent = u24;
    local u27 = Instance.new("ImageLabel");
    u27.ImageTransparency = 1;
    u27.BackgroundTransparency = 1;
    u27.Rotation = 180;
    u27.Size = UDim2.new(1, 0, 1, 0);
    u27.Image = "rbxassetid://6537091378";
    u27.ImageRectSize = Vector2.new(512, 512);
    u27.ImageRectOffset = Vector2.new(0, 0);
    u27.Parent = u26;
    local u28 = Instance.new("ImageLabel");
    u28.ImageTransparency = 1;
    u28.BackgroundTransparency = 1;
    u28.Size = UDim2.new(1, 0, 1, 0);
    u28.ZIndex = 2;
    u28.Image = "rbxassetid://6537091378";
    u28.ImageRectSize = Vector2.new(512, 512);
    u28.ImageRectOffset = Vector2.new(0, 512);
    u28.Parent = u26;
    local u29 = Instance.new("SurfaceGui");
    u29.Active = false;
    u29.Face = Enum.NormalId.Back;
    u29.CanvasSize = Vector2.new(500, 500);
    u29.LightInfluence = 0;
    u29.Enabled = v19;
    u29.AlwaysOnTop = true;
    u29.Adornee = u24;
    u29.Parent = u24;
    local u30 = Instance.new("ImageLabel");
    u30.ImageTransparency = 1;
    u30.BackgroundTransparency = 1;
    u30.Size = UDim2.new(1, 0, 1, 0);
    u30.Image = "rbxassetid://6537091378";
    u30.ImageRectSize = Vector2.new(512, 512);
    u30.ImageRectOffset = Vector2.new(512, 0);
    u30.Parent = u29;
    local u31 = Instance.new("ImageLabel");
    u31.ImageTransparency = 1;
    u31.BackgroundTransparency = 1;
    u31.Size = UDim2.new(1, 0, 1, 0);
    u31.ZIndex = 2;
    u31.Image = "rbxassetid://6537091378";
    u31.ImageRectSize = Vector2.new(512, 512);
    u31.ImageRectOffset = Vector2.new(0, 512);
    u31.Parent = u29;
    local u32 = Instance.new("SurfaceGui");
    u32.Active = false;
    u32.Face = Enum.NormalId.Front;
    u32.CanvasSize = Vector2.new(500, 500);
    u32.LightInfluence = 0;
    u32.Enabled = v19;
    u32.AlwaysOnTop = true;
    u32.Adornee = u25;
    u32.Parent = u25;
    local u33 = Instance.new("ImageLabel");
    u33.ImageTransparency = 1;
    u33.BackgroundTransparency = 1;
    u33.Size = UDim2.new(1, 0, 1, 0);
    u33.Image = "rbxassetid://6537091378";
    u33.ImageRectSize = Vector2.new(512, 512);
    u33.ImageRectOffset = Vector2.new(512, 0);
    u33.Parent = u32;
    local u34 = Instance.new("ImageLabel");
    u34.ImageTransparency = 1;
    u34.BackgroundTransparency = 1;
    u34.Size = UDim2.new(1, 0, 1, 0);
    u34.ZIndex = 2;
    u34.Image = "rbxassetid://6537091378";
    u34.ImageRectSize = Vector2.new(512, 512);
    u34.ImageRectOffset = Vector2.new(0, 512);
    u34.Parent = u32;
    local u35 = Instance.new("SurfaceGui");
    u35.Active = false;
    u35.Face = Enum.NormalId.Back;
    u35.CanvasSize = Vector2.new(500, 500);
    u35.LightInfluence = 0;
    u35.Enabled = v19;
    u35.AlwaysOnTop = true;
    u35.Adornee = u25;
    u35.Parent = u25;
    local u36 = Instance.new("ImageLabel");
    u36.ImageTransparency = 1;
    u36.BackgroundTransparency = 1;
    u36.Size = UDim2.new(1, 0, 1, 0);
    u36.Image = "rbxassetid://6537091378";
    u36.ImageRectSize = Vector2.new(512, 512);
    u36.ImageRectOffset = Vector2.new(0, 0);
    u36.Parent = u35;
    local u37 = Instance.new("ImageLabel");
    u37.BackgroundTransparency = 1;
    u37.Rotation = 180;
    u37.ImageTransparency = 1;
    u37.Size = UDim2.new(1, 0, 1, 0);
    u37.ZIndex = 2;
    u37.Image = "rbxassetid://6537091378";
    u37.ImageRectSize = Vector2.new(512, 512);
    u37.ImageRectOffset = Vector2.new(0, 512);
    u37.Parent = u35;
    u1:GetSettingsChangedSignal("Menu.MenuToggleGestureActive"):Connect(function() --[[ Line: 341 ]]
        -- upvalues: u1 (ref), u26 (copy), u29 (copy), u32 (copy), u35 (copy)
        local v38 = u1:GetSetting("Menu.MenuToggleGestureActive");
        local v39 = v38 == nil and true or v38;
        u26.Enabled = v39;
        u29.Enabled = v39;
        u32.Enabled = v39;
        u35.Enabled = v39;
    end);
    local u40 = nil;
    local u41 = false;
    task.spawn(function() --[[ Line: 360 ]]
        -- upvalues: u1 (ref), u2 (ref), u40 (ref), u41 (ref), l__Workspace__1 (ref), u20 (copy), u22 (copy), u24 (copy), u25 (copy), u21 (copy), u23 (copy), u17 (copy), l__TweenService__5 (ref), u27 (copy), u30 (copy), u28 (copy), u31 (copy), u33 (copy), u36 (copy), u34 (copy), u37 (copy), l__RunService__4 (ref)
        while true do
            local v42 = u1:GetSetting("Menu.MenuToggleGestureActive");
            local v43 = v42 == nil and true or v42;
            local v44 = u2:GetVRInputs();
            local v45 = v44[Enum.UserCFrame.Head]:Inverse() * v44[Enum.UserCFrame.LeftHand];
            local v46 = v44[Enum.UserCFrame.Head]:Inverse() * v44[Enum.UserCFrame.RightHand];
            local v47 = v45.UpVector.Y < 0;
            local v48 = v46.UpVector.Y < 0;
            local v49 = v47 and v45.LookVector.Z < 0;
            local v50 = v48 and v46.LookVector.Z < 0;
            if v43 then
                if v49 then
                    v43 = v50;
                else
                    v43 = v49;
                end;
            end;
            if v43 then
                u40 = u40 or tick();
            else
                u40 = nil;
                u41 = false;
            end;
            local v51 = l__Workspace__1.CurrentCamera:GetRenderCFrame() * v44[Enum.UserCFrame.Head]:Inverse();
            u20.CFrame = v51 * v44[Enum.UserCFrame.LeftHand] * CFrame.new(0, -0.25, 0.25);
            u22.CFrame = v51 * v44[Enum.UserCFrame.RightHand] * CFrame.new(0, -0.25, 0.25);
            u24.CFrame = v51 * v44[Enum.UserCFrame.LeftHand];
            u25.CFrame = v51 * v44[Enum.UserCFrame.RightHand];
            if u40 and not u41 then
                local v52 = (tick() - u40) / 1;
                u21.Size = Vector3.new(0.1, 0, 0.25 * v52);
                u23.Size = Vector3.new(0.1, 0, 0.25 * v52);
                u21.Visible = true;
                u23.Visible = true;
                if v52 >= 1 then
                    u41 = true;
                    task.spawn(function() --[[ Line: 400 ]]
                        -- upvalues: u17 (ref)
                        u17:Toggle();
                    end);
                end;
            else
                u21.Visible = false;
                u23.Visible = false;
            end;
            local function v60(p53, p54, p55, p56, p57, p58) --[[ Line: 412 ]]
                -- upvalues: l__TweenService__5 (ref)
                local v59 = TweenInfo.new(0.25);
                l__TweenService__5:Create(p54, v59, {
                    Size = p53 and Vector3.new(1, 1, 0) or Vector3.new(1.5, 1.5, 0)
                }):Play();
                l__TweenService__5:Create(p55, v59, {
                    ImageTransparency = p53 and 0 or 1
                }):Play();
                l__TweenService__5:Create(p56, v59, {
                    ImageTransparency = p53 and 0 or 1
                }):Play();
                l__TweenService__5:Create(p57, v59, {
                    ImageTransparency = p53 and 0 or 1
                }):Play();
                l__TweenService__5:Create(p58, v59, {
                    ImageTransparency = p53 and 0 or 1
                }):Play();
            end;
            local l__Enabled__13 = u17.ScreenGui.Enabled;
            if l__Enabled__13 then
                l__Enabled__13 = not v49;
            end;
            local l__Enabled__14 = u17.ScreenGui.Enabled;
            if l__Enabled__14 then
                l__Enabled__14 = not v50;
            end;
            if u17.LeftHandHintVisible ~= l__Enabled__13 then
                u17.LeftHandHintVisible = l__Enabled__13;
                v60(l__Enabled__13, u24, u27, u30, u28, u31);
            end;
            if u17.RightHandHintVisible ~= l__Enabled__14 then
                u17.RightHandHintVisible = l__Enabled__14;
                v60(l__Enabled__14, u25, u33, u36, u34, u37);
            end;
            local v61 = tick() * 10 % 360;
            u27.Rotation = v61;
            u30.Rotation = -v61;
            u33.Rotation = -v61;
            u36.Rotation = v61;
            l__RunService__4.RenderStepped:Wait();
        end;
    end);
end;
function u4.Toggle(p62, p63) --[[ Line: 456 ]]
    -- upvalues: l__RunService__4 (copy)
    if p62.ScreenGui.Enabled == p63 then
    else
        local v64 = p62.ScreenGui.Enabled and 0.6981317007977318 or 0;
        local v65 = p62.ScreenGui.Enabled and 0 or 0.6981317007977318;
        if not p62.ScreenGui.Enabled then
            p62.ScreenGui.Enabled = true;
        end;
        local v66 = tick();
        while tick() - v66 < 0.25 do
            local v67 = ((tick() - v66) / 0.25 - 0.5) * 3.141592653589793;
            local v68 = math.sin(v67) / 2 + 0.5;
            p62.ScreenGui.FieldOfView = v64 + (v65 - v64) * v68;
            l__RunService__4.RenderStepped:Wait();
        end;
        if v65 == 0 then
            p62.ScreenGui.Enabled = false;
        end;
    end;
end;
function u4.RegisterView(p69, p70, p71) --[[ Line: 485 ]]
    warn("MainMenu::RegisterView is deprecated and may be removed in the future. Use MainMenu::CreateView instead.");
    p71.Visible = false;
    p71.Name = p70;
    p71.Parent = p69.ViewAdornFrame;
    table.insert(p69.Views, p71);
end;
function u4.CreateView(u72, p73) --[[ Line: 500 ]]
    -- upvalues: l__ApiBaseView__9 (copy)
    local u74 = l__ApiBaseView__9.new(p73);
    u74.Frame.Parent = u72.ViewAdornFrame;
    table.insert(u72.Views, u74);
    u74:GetPropertyChangedSignal("Name"):Connect(function() --[[ Line: 507 ]]
        -- upvalues: u72 (copy)
        u72:UpdateVisibleView();
    end);
    u74.Destroyed:Connect(function() --[[ Line: 510 ]]
        -- upvalues: u72 (copy), u74 (copy)
        for v75 = 1, #u72.Views do
            if u72.Views[v75] == u74 then
                table.remove(u72.Views, v75);
                if v75 < u72.CurrentView then
                    local v76 = u72;
                    v76.CurrentView = v76.CurrentView + -1;
                end;
                break;
            end;
        end;
        u72:UpdateVisibleView();
    end);
    return u74;
end;
function u4.UpdateVisibleView(p77, p78) --[[ Line: 528 ]]
    p77.LeftButton.Visible = #p77.Views > 1;
    p77.RightButton.Visible = #p77.Views > 1;
    if p78 then
        for v79, v80 in p77.Views do
            if v80.Name == p78 then
                p77.CurrentView = v79;
                break;
            end;
        end;
    end;
    p77.ViewTextLabel.Text = p77.Views[p77.CurrentView].Name;
    for v81, v82 in p77.Views do
        v82.Visible = v81 == p77.CurrentView;
    end;
end;
return u4;
