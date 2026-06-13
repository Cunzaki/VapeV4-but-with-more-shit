-- Decompiled from: Players.9qje7.PlayerGui.Polaroid.Main.ImageLabel.LocalScript
-- Class: LocalScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__AssetService__1 = game:GetService("AssetService");
local l__CaptureService__2 = game:GetService("CaptureService");
local l__ScreenshotHud__3 = game:GetService("GuiService").ScreenshotHud;
local l__EditableImageFilters__4 = require(game.ReplicatedStorage.EditableImageFilters);
l__ScreenshotHud__3.HideCoreGuiForCaptures = true;
l__ScreenshotHud__3.HidePlayerGuiForCaptures = false;
l__ScreenshotHud__3.OverlayFont = Enum.Font.RobotoCondensed;
l__ScreenshotHud__3.ExperienceNameOverlayEnabled = true;
l__ScreenshotHud__3.UsernameOverlayEnabled = true;
task.wait(6);
local u1 = nil;
local u2 = nil;
l__CaptureService__2.CaptureBegan:Connect(function() --[[ Line: 33 ]]
    -- upvalues: u1 (ref), u2 (ref)
    u1 = game.Workspace.CurrentCamera.CFrame;
    u2 = game.Workspace.CurrentCamera.CameraType;
    game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    script.Parent.Parent.Parent.TextLabel.Visible = false;
    game.Workspace.CurrentCamera.CFrame = game.Workspace.CaptureSpot.CFrame;
    script.Parent.Parent.Rotation = math.random(0, 1) == 1 and math.random(10, 30) or math.random(-30, -10);
end);
l__CaptureService__2.CaptureEnded:Connect(function() --[[ Line: 43 ]]
    -- upvalues: u1 (ref), u2 (ref)
    game.Workspace.CurrentCamera.CFrame = u1;
    game.Workspace.CurrentCamera.CameraType = u2;
    script.Parent.Parent.Parent.TextLabel.Visible = true;
    script.Parent.Parent.Rotation = 0;
end);
game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 50 ]]
    -- upvalues: l__EditableImageFilters__4 (copy)
    local v3 = math.floor(l__EditableImageFilters__4.PercentComplete * 100);
    script.Parent.Parent.Parent.TextLabel.Text = `{v3}%`;
end);
local function u9(p4) --[[ Line: 55 ]]
    -- upvalues: l__EditableImageFilters__4 (copy)
    local v5, v6, v7, v8 = l__EditableImageFilters__4.findVerticalAverageColors(p4);
    script.Parent.Parent.Polaroid.UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, v5),
        ColorSequenceKeypoint.new(0.37, v6),
        ColorSequenceKeypoint.new(0.65, v7),
        ColorSequenceKeypoint.new(1, v8)
    });
    l__EditableImageFilters__4.applyInvertFilter(p4, 30);
end;
script.Parent.Parent.Parent.Enabled = false;
l__CaptureService__2:CaptureScreenshot(function(p10) --[[ Line: 15 ]]
    -- upvalues: l__AssetService__1 (copy), u9 (copy)
    script.Parent.Parent.Parent.Enabled = true;
    local v11 = l__AssetService__1:CreateEditableImageAsync(p10);
    v11.Parent = script.Parent;
    if v11.Size.X > 1024 then
        v11:Resize(Vector2.new(1024, 1024 * (v11.Size.Y / v11.Size.X)));
    end;
    if v11.Size.Y > 1024 then
        v11:Resize(Vector2.new(1024 * (v11.Size.X / v11.Size.Y), 1024));
    end;
    task.wait(1);
    u9(v11);
end);
