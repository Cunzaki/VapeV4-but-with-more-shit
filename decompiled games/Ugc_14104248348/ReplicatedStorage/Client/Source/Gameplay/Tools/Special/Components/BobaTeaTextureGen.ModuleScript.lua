-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Special.Components.BobaTeaTextureGen
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
game:GetService("UserInputService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__AssetService__2 = game:GetService("AssetService");
game:GetService("Players");
game:GetService("Debris");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Signal);
l__Mince__3:Get("ToolHandler");
local u1 = { "BaseColor", "PrimaryColor", "SecondaryColor" };
local v2 = l__Mince__3.Component({
    Tag = "BobaTea"
});
function v2.GenTex(p3) --[[ Line: 18 ]]
    -- upvalues: l__AssetService__2 (copy)
    local l__Instance__4 = p3.Instance;
    local l__Image__5 = p3.Image;
    if not l__Image__5 then
        l__Image__5 = l__AssetService__2:CreateEditableImage({
            Size = Vector2.new(100, 100)
        });
        p3.Image = l__Image__5;
    end;
    local v4 = p3:GetColors();
    if not v4.BaseColor then
        l__Image__5:Destroy();
        p3.Image = nil;
    end;
    local v5 = v4.PrimaryColor or v4.BaseColor;
    local v6 = v4.SecondaryColor or v5;
    for v7 = 0, 99 do
        local v8 = v6:Lerp(v5, v7 / 99);
        l__Image__5:DrawLine(Vector2.new(0, v7), Vector2.new(99, v7), v8, 0, Enum.ImageCombineType.Overwrite);
    end;
    l__Instance__4.TextureContent = Content.fromObject(l__Image__5);
end;
function v2.GetColors(p9) --[[ Line: 50 ]]
    -- upvalues: u1 (copy)
    local v10 = {};
    for _, v11 in u1 do
        v10[v11] = p9.Instance:GetAttribute(v11);
    end;
    return v10;
end;
function v2.Construct(u12) --[[ Line: 60 ]]
    -- upvalues: u1 (copy)
    local l__Instance__6 = u12.Instance;
    if u12:GetColors().BaseColor then
        u12:GenTex();
    end;
    for _, v13 in u1 do
        l__Instance__6:GetAttributeChangedSignal(v13):Connect(function() --[[ Line: 69 ]]
            -- upvalues: u12 (copy)
            u12:GenTex();
        end);
    end;
end;
return v2;
