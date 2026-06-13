-- Decompiled from: ReplicatedStorage.Assets.Polaroid.Screenshot
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__AssetService__1 = game:GetService("AssetService");
local l__CaptureService__2 = game:GetService("CaptureService");
game:GetService("StarterGui");
game:GetService("ContentProvider");
local l__ScreenshotHud__3 = game:GetService("GuiService").ScreenshotHud;
l__ScreenshotHud__3.HideCoreGuiForCaptures = true;
l__ScreenshotHud__3.HidePlayerGuiForCaptures = true;
l__ScreenshotHud__3.OverlayFont = Enum.Font.BuilderSans;
l__ScreenshotHud__3.ExperienceNameOverlayEnabled = true;
l__ScreenshotHud__3.UsernameOverlayEnabled = true;
return {
    ReadCapturedScreenshot = function(u1) --[[ Name: ReadCapturedScreenshot, Line 18 ]]
        -- upvalues: l__CaptureService__2 (copy), l__AssetService__1 (copy)
        l__CaptureService__2:CaptureScreenshot(function(p2) --[[ Line: 19 ]]
            -- upvalues: l__AssetService__1 (ref), u1 (copy)
            local v3 = l__AssetService__1:CreateEditableImageAsync(p2);
            if v3.Size.X > 1024 then
                v3:Resize(Vector2.new(1024, 1024 * (v3.Size.Y / v3.Size.X)));
            end;
            if v3.Size.Y > 1024 then
                v3:Resize(Vector2.new(1024 * (v3.Size.X / v3.Size.Y), 1024));
            end;
            u1(v3);
        end);
    end,
    CreateCapturedScreenshot = function(u4) --[[ Name: CreateCapturedScreenshot, Line 32 ]]
        -- upvalues: l__CaptureService__2 (copy)
        l__CaptureService__2:CaptureScreenshot(function(p5) --[[ Line: 33 ]]
            -- upvalues: u4 (copy)
            u4(p5);
        end);
    end
};
