-- Decompiled from: ReplicatedStorage.Assets.Polaroid
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("AssetService");
local l__CaptureService__2 = game:GetService("CaptureService");
game:GetService("StarterGui");
game:GetService("ContentProvider");
local l__Players__3 = game:GetService("Players");
require(l__ReplicatedStorage__1.Modules.Mince);
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
require(game.ReplicatedStorage.Modules.EditableImageFilters);
l__Mince__4:Get("UserProfile");
l__Mince__4:Get("IKManager");
l__Mince__4:Get("SelectInteractor");
local u1 = l__Mince__4:Get("ToolHandler");
l__Mince__4:Get("NotifPrompt");
l__Mince__4:Get("Bobbing");
local u2 = l__Mince__4:Get("Notices");
l__Mince__4:Get("InterfaceHandler");
l__Mince__4:Get("BindManager");
local u3 = {
    Tags = { "PolaroidCamera" },
    Modules = {},
    Update = function(_) --[[ Name: Update, Line 36 ]]
        -- upvalues: l__Mince__4 (copy)
        if l__Mince__4.Config.Humanoid and l__Mince__4.Config.Humanoid.Parent.LeftHand then
        end;
    end
};
function u3.Equipped(p4) --[[ Line: 41 ]]
    -- upvalues: l__Mince__4 (copy), u3 (copy)
    if l__Mince__4.Config.Humanoid then
        if p4.Tool:FindFirstChild("Handle") then
            p4.Tool.Handle:Destroy();
        end;
        u3.Modules.Interface.ControlsFrame.Visible = true;
    end;
end;
function u3.Unequipped(_) --[[ Line: 51 ]]
    -- upvalues: u3 (copy)
    u3.Modules.Interface.ControlsFrame.Visible = false;
end;
function u3.TakeSnapshot() --[[ Line: 55 ]]
    -- upvalues: u3 (copy)
    u3.ToggleAllUI(false);
    u3.CreateCapturedScreenshot(function(_) --[[ Line: 58 ]] end);
end;
function u3.SaveScreenshot() --[[ Line: 63 ]]
    -- upvalues: u3 (copy), l__CaptureService__2 (copy), u2 (copy)
    u3.ToggleAllUI(false);
    u3.PolaroidUI.TweenFrame.Parent.Enabled = true;
    u3.PolaroidUI.TweenFrame.Parent.Corkboard.Visible = true;
    u3.PolaroidUI.TweenFrame.Polaroid.Frame.Visible = false;
    u3.PolaroidUI.TweenFrame.Polaroid.Bar.Visible = false;
    u3.PolaroidUI.TweenFrame.Position = UDim2.fromScale(0.5, 0.45);
    u3.PolaroidUI.TweenFrame.Rotation = math.random(1, 2) == 1 and math.random(-20, -5) or math.random(5, 20);
    task.wait(0.2);
    u3.CreateCapturedScreenshot(function(p5) --[[ Line: 73 ]]
        -- upvalues: u3 (ref), l__CaptureService__2 (ref), u2 (ref)
        u3.ToggleAllUI(true);
        if u3.ToolActive then
            u3.MainUI.Enabled = true;
        end;
        u3.PolaroidUI.TweenFrame.Rotation = 0;
        u3.PolaroidUI.TweenFrame.Parent.Corkboard.Visible = false;
        u3.PolaroidUI.TweenFrame.Polaroid.Frame.Visible = true;
        u3.PolaroidUI.TweenFrame.Polaroid.Bar.Visible = true;
        u3.PolaroidUI.TweenFrame.Position = UDim2.fromScale(0.5, 0.5);
        l__CaptureService__2:PromptSaveCapturesToGallery({ p5 }, function(_) --[[ Line: 85 ]]
            -- upvalues: u2 (ref)
            u2.CreateNotice("Screenshot saved!");
        end);
    end);
end;
function u3.SetupButton(p6, p7) --[[ Line: 91 ]]
    -- upvalues: u3 (copy)
    if p6.IsMenu then
        u3.Modules.Interface:MakeMenuButton(p7, p6.MenuType, p6.MenuTitle, p6.MenuOptions).ValueChanged:Connect(p6.MenuValueChanged);
    else
        if p6.IsToggle then
            u3.Modules.Interface:MakeToggleButton(p7).Activated:Connect(p6.Toggled);
        end;
    end;
end;
function u3.SetupUI() --[[ Line: 101 ]]
    -- upvalues: u3 (copy)
    for _, v8 in u3.Modules.Interface.ControlsFrame.Buttons:GetChildren() do
        if v8:IsA("GuiButton") then
            for _, v9 in u3.Modules do
                if v9.ButtonFunctions and v9.ButtonFunctions[v8.Name] then
                    u3.SetupButton(v9.ButtonFunctions[v8.Name], v8);
                end;
            end;
        end;
    end;
end;
function u3.Setup() --[[ Line: 115 ]]
    -- upvalues: u3 (copy), l__Players__3 (copy), u1 (copy)
    for _, v10 in script:GetChildren() do
        if v10:IsA("ModuleScript") then
            local v11 = require(v10);
            if v11.Init then
                v11.Init(v11);
            end;
            u3.Modules[v10.Name] = v11;
        end;
    end;
    l__Players__3.LocalPlayer.CharacterAdded:Connect(u3.Modules.Character.New);
    if l__Players__3.LocalPlayer.Character then
        u3.Modules.Character.New(l__Players__3.LocalPlayer.Character);
    end;
    u1.Component(u3);
    u3.SetupUI();
end;
return u3;
