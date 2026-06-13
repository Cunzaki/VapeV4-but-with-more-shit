-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Tools.PixelCanvas
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__AssetService__2 = game:GetService("AssetService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.BaseX);
local l__Compress__4 = require(l__ReplicatedStorage__1.Modules.Compress);
local v1 = l__Mince__3.Component({
    Tag = "PixelCanvas"
});
function v1.Construct(p2) --[[ Line: 18 ]]
    -- upvalues: l__Compress__4 (copy), l__AssetService__2 (copy)
    if p2.Disabled then
    else
        local v3 = l__Compress__4.decompress(p2.PixelData);
        local v4 = buffer.fromstring(v3);
        local l__SurfaceGui__5 = p2.Instance:WaitForChild("SurfaceGui");
        local v5 = l__AssetService__2:CreateEditableImage({
            Size = p2.PixelResolution
        });
        v5:WritePixelsBuffer(Vector2.zero, p2.PixelResolution, v4);
        l__SurfaceGui__5.Content.ImageContent = Content.fromObject(v5);
    end;
end;
return v1;
