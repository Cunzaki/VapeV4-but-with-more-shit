-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Legacy.ToolEquippedDeprecated.Camera
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__AssetService__2 = game:GetService("AssetService");
local l__CaptureService__3 = game:GetService("CaptureService");
local l__StarterGui__4 = game:GetService("StarterGui");
game:GetService("ContentProvider");
local l__ScreenshotHud__5 = game:GetService("GuiService").ScreenshotHud;
l__ScreenshotHud__5.HideCoreGuiForCaptures = true;
l__ScreenshotHud__5.HidePlayerGuiForCaptures = true;
l__ScreenshotHud__5.OverlayFont = Enum.Font.Gotham;
l__ScreenshotHud__5.ExperienceNameOverlayEnabled = true;
l__ScreenshotHud__5.UsernameOverlayEnabled = true;
local l__Mince__6 = require(l__ReplicatedStorage__1.Modules.Mince);
require(game.ReplicatedStorage.Modules.EditableImageFilters);
l__Mince__6:Get("UserProfile");
local u1 = l__Mince__6:Get("IKManager");
local u2 = l__Mince__6:Get("SelectInteractor");
local u3 = l__Mince__6:Get("ToolHandler");
l__Mince__6:Get("NotifPrompt");
local u4 = l__Mince__6:Get("Bobbing");
local u5 = l__Mince__6:Get("Notices");
local u6 = l__Mince__6:Get("InterfaceHandler");
local u7 = l__Mince__6:Get("BindManager");
local u13 = {
    CurrentFrame = 0,
    Positions = {},
    ReadCapturedScreenshot = function(u8) --[[ Name: ReadCapturedScreenshot, Line 40 ]]
        -- upvalues: l__CaptureService__3 (copy), l__AssetService__2 (copy)
        l__CaptureService__3:CaptureScreenshot(function(p9) --[[ Line: 41 ]]
            -- upvalues: l__AssetService__2 (ref), u8 (copy)
            local v10 = l__AssetService__2:CreateEditableImageAsync(p9);
            if v10.Size.X > 1024 then
                v10:Resize(Vector2.new(1024, 1024 * (v10.Size.Y / v10.Size.X)));
            end;
            if v10.Size.Y > 1024 then
                v10:Resize(Vector2.new(1024 * (v10.Size.X / v10.Size.Y), 1024));
            end;
            u8(v10);
        end);
    end,
    CreateCapturedScreenshot = function(u11) --[[ Name: CreateCapturedScreenshot, Line 54 ]]
        -- upvalues: l__CaptureService__3 (copy)
        l__CaptureService__3:CaptureScreenshot(function(p12) --[[ Line: 55 ]]
            -- upvalues: u11 (copy)
            u11(p12);
        end);
    end
};
function u13.ActivateTool() --[[ Line: 60 ]]
    -- upvalues: u13 (copy)
    return u13.ToolActive and "Pass" or "Pass";
end;
function u13.Update(_) --[[ Line: 66 ]]
    -- upvalues: u13 (copy), l__Mince__6 (copy)
    if u13.ToolActive and (l__Mince__6.Config.Humanoid and l__Mince__6.Config.Humanoid.Parent.LeftHand) then
        if u13.Positions[u13.CurrentAtt] then
            local v14;
            if u13.ShouldFlip then
                local l__WorldPosition__7 = u13.Positions[u13.CurrentAtt].WorldPosition;
                local _ = (l__Mince__6.Config.Humanoid.Parent.HumanoidRootPart.Position - l__WorldPosition__7).Unit;
                v14 = CFrame.lookAt(l__WorldPosition__7, l__WorldPosition__7 + l__Mince__6.Config.Humanoid.Parent.HumanoidRootPart.CFrame.LookVector);
            else
                v14 = CFrame.lookAt(u13.Positions[u13.CurrentAtt].WorldPosition, l__Mince__6.Config.Humanoid.Parent.Head.Position);
            end;
            game.Workspace.CurrentCamera.CFrame = v14;
        end;
    end;
end;
function u13.StartTool(p15) --[[ Line: 84 ]]
    -- upvalues: l__Mince__6 (copy), u13 (copy), u4 (copy), u1 (copy)
    if l__Mince__6.Config.Humanoid then
        u13.ToolActive = true;
        u13.LoadedAnimations = {};
        u4.SetFOVMult(1.2);
        l__Mince__6.Config.Humanoid.AutoRotate = false;
        u13.CurrentTool = p15;
        u13.SetIndex(1);
        u1.LockPlayer();
        u13.MainUI.Enabled = true;
    end;
end;
function u13.EndTool() --[[ Line: 99 ]]
    -- upvalues: u13 (copy), u4 (copy), u1 (copy), l__Mince__6 (copy)
    u13.ToolActive = false;
    u13.MainUI.Enabled = false;
    u4.SetFOVMult(1);
    u1.UnlockPlayer();
    l__Mince__6.Config.Humanoid.AutoRotate = true;
    u1.SetIKTween(u13.IKTarget, 0);
end;
function u13.SetupAttachments(p16) --[[ Line: 108 ]]
    -- upvalues: u13 (copy)
    task.wait(1);
    local l__HumanoidRootPart__8 = p16:WaitForChild("HumanoidRootPart");
    local v17 = Instance.new("Attachment", l__HumanoidRootPart__8);
    local v18 = Instance.new("Attachment", l__HumanoidRootPart__8.Parent.RightHand);
    v18.Name = "HandView";
    v18.Position = Vector3.new(0.8, -0.3, -0.5);
    local v19 = Instance.new("Attachment", l__HumanoidRootPart__8);
    v19.Position = Vector3.new(0, 1, -15);
    local v20 = Instance.new("Attachment", l__HumanoidRootPart__8);
    v20.Position = Vector3.new(0, 1, -6);
    local v21 = Instance.new("Attachment", l__HumanoidRootPart__8);
    v21.Position = Vector3.new(4, 3, -2);
    local v22 = Instance.new("Attachment", l__HumanoidRootPart__8);
    v22.Position = Vector3.new(-4, 3, -2);
    local v23 = Instance.new("Attachment", l__HumanoidRootPart__8);
    v23.Position = Vector3.new(0, 0, 6);
    local v24 = Instance.new("Attachment", l__HumanoidRootPart__8);
    v24.Position = Vector3.new(0, 0, 15);
    u13.Positions = {
        v18,
        v19,
        v20,
        v21,
        v22,
        v23,
        v24
    };
    u13.CharacterHeight = p16.Head.Size.Y + p16.HumanoidRootPart.Size.Y + (p16.Humanoid.HipHeight - p16.HumanoidRootPart.Size.Y / 2);
    v17.Position = Vector3.new(1.5, 1.5, -2);
    u13.IKTarget = v17;
end;
function u13.TakeSnapshot() --[[ Line: 142 ]]
    -- upvalues: u13 (copy)
    u13.ToggleAllUI(false);
    u13.CreateCapturedScreenshot(function(p25) --[[ Line: 145 ]]
        -- upvalues: u13 (ref)
        u13.ToggleAllUI(true);
        u13.MainUI.Enabled = false;
        u13.PolaroidUI.TweenFrame.ImageLabel.Image = p25;
        u13.PolaroidUI.Open();
    end);
end;
function u13.SaveScreenshot() --[[ Line: 153 ]]
    -- upvalues: u13 (copy), l__CaptureService__3 (copy), u5 (copy)
    u13.ToggleAllUI(false);
    u13.PolaroidUI.TweenFrame.Parent.Enabled = true;
    u13.PolaroidUI.TweenFrame.Parent.Corkboard.Visible = true;
    u13.PolaroidUI.TweenFrame.Polaroid.Frame.Visible = false;
    u13.PolaroidUI.TweenFrame.Polaroid.Bar.Visible = false;
    u13.PolaroidUI.TweenFrame.Position = UDim2.fromScale(0.5, 0.45);
    u13.PolaroidUI.TweenFrame.Rotation = math.random(1, 2) == 1 and math.random(-20, -5) or math.random(5, 20);
    task.wait(0.2);
    u13.CreateCapturedScreenshot(function(p26) --[[ Line: 163 ]]
        -- upvalues: u13 (ref), l__CaptureService__3 (ref), u5 (ref)
        u13.ToggleAllUI(true);
        if u13.ToolActive then
            u13.MainUI.Enabled = true;
        end;
        u13.PolaroidUI.TweenFrame.Rotation = 0;
        u13.PolaroidUI.TweenFrame.Parent.Corkboard.Visible = false;
        u13.PolaroidUI.TweenFrame.Polaroid.Frame.Visible = true;
        u13.PolaroidUI.TweenFrame.Polaroid.Bar.Visible = true;
        u13.PolaroidUI.TweenFrame.Position = UDim2.fromScale(0.5, 0.5);
        l__CaptureService__3:PromptSaveCapturesToGallery({ p26 }, function(_) --[[ Line: 175 ]]
            -- upvalues: u5 (ref)
            u5.CreateNotice("Screenshot saved!");
        end);
        u13.PolaroidUI.Close();
    end);
end;
function u13.ToggleAllUI(p27) --[[ Line: 182 ]]
    -- upvalues: u13 (copy), l__StarterGui__4 (copy)
    if u13.UIHidden and not p27 then
    else
        l__StarterGui__4:SetCoreGuiEnabled(Enum.CoreGuiType.All, p27);
        if p27 then
            if u13.UIHidden then
                u13.UIHidden = false;
                for _, v28 in pairs(u13.VisibleElements) do
                    v28.Enabled = true;
                end;
            end;
        else
            u13.VisibleElements = {};
            for _, v29 in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
                if v29:IsA("ScreenGui") and v29.Enabled then
                    table.insert(u13.VisibleElements, v29);
                    v29.Enabled = false;
                end;
            end;
            u13.UIHidden = true;
        end;
    end;
end;
function u13.SetupUI() --[[ Line: 203 ]]
    -- upvalues: u7 (copy), u13 (copy), u6 (copy), l__Mince__6 (copy)
    u7.GetMode();
    u13.MainUI = u6.GetScreenGui("CameraUI");
    u13.PolaroidUI = u6.Get("Polaroid", "Main");
    u6.NewSlider(u13.MainUI.Frame.Slider).Changed:Connect(function(p30) --[[ Line: 210 ]]
        -- upvalues: u13 (ref)
        local l__IKTarget__9 = u13.IKTarget;
        local v31 = 2 + -2 * p30;
        local v32 = u13.CharacterHeight / 2;
        l__IKTarget__9.Position = Vector3.new(v31, v32 + (u13.CharacterHeight / 5 - v32) * p30, -2);
    end);
    local v33 = u6.NewButton(u13.PolaroidUI.TweenFrame.Polaroid.Frame.A);
    local v34 = u6.NewButton(u13.PolaroidUI.TweenFrame.Polaroid.Frame.Close);
    v33.Activated:Connect(u13.SaveScreenshot);
    v34.Activated:Connect(function() --[[ Line: 218 ]]
        -- upvalues: u13 (ref)
        u13.PolaroidUI.Close();
        if u13.ToolActive then
            u13.MainUI.Enabled = true;
        end;
    end);
    local v35 = u6.NewButton(u13.MainUI.Frame.Bar.RightArrowButton);
    local v36 = u6.NewButton(u13.MainUI.Frame.Bar.LeftArrowButton);
    local v37 = u6.NewButton(u13.MainUI.Frame.Buttons.A);
    local v38 = u6.NewButton(u13.MainUI.Frame.Buttons.Flip);
    v37.Activated:Connect(u13.TakeSnapshot);
    v38.Activated:Connect(function() --[[ Line: 231 ]]
        -- upvalues: u13 (ref)
        u13.ShouldFlip = not u13.ShouldFlip;
    end);
    v35.Activated:Connect(function() --[[ Line: 235 ]]
        -- upvalues: u13 (ref)
        local l__CurrentAtt__10 = u13.CurrentAtt;
        u13.SetIndex(l__CurrentAtt__10 == #u13.Positions and 1 or l__CurrentAtt__10 + 1);
    end);
    v36.Activated:Connect(function() --[[ Line: 245 ]]
        -- upvalues: u13 (ref)
        local l__CurrentAtt__11 = u13.CurrentAtt;
        local v39;
        if l__CurrentAtt__11 == 1 then
            v39 = #u13.Positions;
        else
            v39 = l__CurrentAtt__11 - 1;
        end;
        u13.SetIndex(v39);
    end);
    local v40 = u6.NewButton(u13.PolaroidUI.TweenFrame.Polaroid.Bar.RightArrowButton);
    local v41 = u6.NewButton(u13.PolaroidUI.TweenFrame.Polaroid.Bar.LeftArrowButton);
    v40.Activated:Connect(function() --[[ Line: 258 ]]
        -- upvalues: l__Mince__6 (ref), u13 (ref)
        local v42 = table.find(l__Mince__6.Config.PhotoFrames, u13.CurrentFrame) or 0;
        u13.SetPhotoFrame(v42 == #l__Mince__6.Config.PhotoFrames and 0 or v42 + 1);
    end);
    v41.Activated:Connect(function() --[[ Line: 270 ]]
        -- upvalues: l__Mince__6 (ref), u13 (ref)
        local v43 = table.find(l__Mince__6.Config.PhotoFrames, u13.CurrentFrame) or 0;
        local v44;
        if v43 == 0 then
            v44 = #l__Mince__6.Config.PhotoFrames;
        else
            v44 = v43 - 1;
        end;
        u13.SetPhotoFrame(v44);
    end);
end;
function u13.SetIndex(p45) --[[ Line: 283 ]]
    -- upvalues: u13 (copy), u1 (copy)
    if p45 == 1 then
        u13.MainUI.Frame.Buttons.Flip.Visible = true;
        u13.MainUI.Frame.Slider.Visible = true;
        u1.SetIKTween(u13.IKTarget, 1);
    else
        u13.MainUI.Frame.Slider.Visible = false;
        u13.MainUI.Frame.Buttons.Flip.Visible = false;
        u13.ShouldFlip = false;
        u1.SetIKTween(u13.IKTarget, 0);
    end;
    u13.MainUI.Frame.Bar.ShowingAmount.Text = `Position {p45}`;
    u13.CurrentAtt = p45;
end;
function u13.SetPhotoFrame(p46) --[[ Line: 298 ]]
    -- upvalues: u13 (copy), l__Mince__6 (copy)
    u13.CurrentFrame = l__Mince__6.Config.PhotoFrames[p46];
    if p46 == 0 then
        u13.PolaroidUI.TweenFrame.Polaroid.PhotoFrame.Visible = false;
    else
        u13.PolaroidUI.TweenFrame.Polaroid.PhotoFrame.Visible = true;
        u13.PolaroidUI.TweenFrame.Polaroid.PhotoFrame.Image = l__Mince__6.Config.PhotoFrames[p46];
    end;
end;
function u13.SetupAsync() --[[ Line: 308 ]] end;
function u13.Setup() --[[ Line: 312 ]]
    -- upvalues: u3 (copy), u13 (copy), u2 (copy)
    local v47 = u3.TagEquipped({ "PolaroidCamera" });
    v47.Equipped:Connect(u13.StartTool);
    v47.Unequipped:Connect(u13.EndTool);
    game.Players.LocalPlayer.CharacterAdded:Connect(u13.SetupAttachments);
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer:HasAppearanceLoaded() then
        task.defer(u13.SetupAttachments, game.Players.LocalPlayer.Character);
    end;
    u13.SetupUI();
    u2.BindToInteract(100, u13.ActivateTool);
    game:GetService("RunService").RenderStepped:Connect(u13.Update);
end;
return u13;
