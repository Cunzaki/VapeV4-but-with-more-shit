-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Tools.SparkleSword
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__AssetService__3 = game:GetService("AssetService");
local l__RunService__4 = game:GetService("RunService");
local l__Maid__5 = require(l__ReplicatedStorage__1.Modules.Maid);
local u1 = require(l__ReplicatedStorage__1.Modules.Mince).Component({
    Tag = "SparkleSword",
    CheckAfterRemovedForChangingParent = true,
    Tween = TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
    CreationParents = { game.Workspace }
});
function u1.DoAnimation(u2) --[[ Line: 18 ]]
    -- upvalues: u1 (copy), l__RunService__4 (copy), l__TweenService__2 (copy)
    if u2.__TweenEvent then
        u2.__TweenEvent:Disconnect();
    end;
    u2:SetEffectsEnabled(false);
    local u3 = 0;
    local u4 = 0;
    local l__Time__6 = u1.Tween.Time;
    u2.__TweenEvent = l__RunService__4.Heartbeat:Connect(function(p5) --[[ Line: 28 ]]
        -- upvalues: u3 (ref), u4 (ref), l__Time__6 (copy), u2 (copy), l__TweenService__2 (ref), u1 (ref)
        u3 = u3 + p5;
        if u3 < 0.05 then
        elseif l__Time__6 < u4 then
            u2.EditableImage:DrawImage(Vector2.zero, u2.BaseTexture, Enum.ImageCombineType.Overwrite);
            u2:SetEffectsEnabled(true);
            u2.__TweenEvent:Disconnect();
            u2.Blade.Transparency = 0;
            u2.Sound.Volume = 0.1;
        else
            local v6 = 1 - math.max(u4, 0) / l__Time__6;
            local v7 = l__TweenService__2:GetValue(v6, u1.Tween.EasingStyle, u1.Tween.EasingDirection) * u2.BaseTexture.Size.Y;
            local v8 = math.floor(v7);
            local l__X__7 = u2.BaseTexture.Size.X;
            local v9 = math.max(v8, 0);
            u2.EditableImage:DrawImage(Vector2.zero, u2.BaseTexture, Enum.ImageCombineType.Overwrite);
            if v9 > 0 then
                u2.Blade.Transparency = 0.05;
                u2.EditableImage:DrawRectangle(Vector2.zero, Vector2.new(l__X__7, v9), Color3.new(0, 0, 0), 1, Enum.ImageCombineType.Overwrite);
            end;
            u2.Sound.Volume = v6 * 0.1;
            u4 = u4 + p5;
        end;
    end);
end;
function u1.SetEffectsEnabled(p10, p11) --[[ Line: 64 ]]
    for _, v12 in p10.Instance:GetDescendants() do
        if v12:IsA("Beam") or (v12:IsA("ParticleEmitter") or v12:IsA("Light")) then
            v12.Enabled = p11;
        end;
    end;
end;
function u1.Construct(u13) --[[ Line: 72 ]]
    -- upvalues: l__Maid__5 (copy), l__AssetService__3 (copy)
    u13.Maid = l__Maid__5.new();
    u13:SetEffectsEnabled(false);
    u13.Blade = u13.Instance:WaitForChild("Blade");
    u13.Sound = u13.Blade:WaitForChild("Sound");
    u13.BaseTexture = l__AssetService__3:CreateEditableImageAsync((`rbxthumb://type=Asset&id={string.gsub(u13.Blade.TextureID, "^rbxassetid://", "")}&w=420&h=420`));
    u13.EditableImage = l__AssetService__3:CreateEditableImage({
        Size = u13.BaseTexture.Size
    });
    u13.EditableImage:DrawImage(Vector2.zero, u13.BaseTexture, Enum.ImageCombineType.Overwrite);
    u13.Sound.Playing = false;
    u13.Sound.Volume = 0;
    u13.Blade.Transparency = 1;
    u13.Blade.TextureContent = Content.fromObject(u13.EditableImage);
    u13.Maid:Add(function() --[[ Line: 92 ]]
        -- upvalues: u13 (copy)
        if u13.__TweenEvent then
            u13.__TweenEvent:Disconnect();
        end;
    end);
    u13.Maid:Add(u13.Instance:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 97 ]]
        -- upvalues: u13 (copy)
        u13:DoAnimation();
        u13.Sound.Playing = u13.Instance:IsDescendantOf(game.Workspace);
    end));
    if u13.Instance:IsDescendantOf(game.Workspace) then
        u13:DoAnimation();
    end;
    u13.Sound.Playing = u13.Instance:IsDescendantOf(game.Workspace);
end;
function u1.Removing(p14) --[[ Line: 109 ]]
    p14.Maid:Destroy();
end;
return u1;
