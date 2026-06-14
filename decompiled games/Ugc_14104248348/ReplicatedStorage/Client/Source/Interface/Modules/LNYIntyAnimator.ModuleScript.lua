-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.LNYIntyAnimator
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__AssetService__1 = game:GetService("AssetService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__EditableSpriteAnimator__3 = require(l__ReplicatedStorage__2.Modules.EditableSpriteAnimator);
local l__Mince__4 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = {
    InUse = 0
};
local u2 = Vector2.new(450, 450);
local u3 = nil;
local _ = Color3.fromRGB(163, 162, 165);
local _ = 0;
local _ = 0;
local _ = true;
local _ = {
    Frame = nil,
    IsStatic = false,
    Position = Vector2.zero
};
function u1.LoadAnimators() --[[ Line: 31 ]]
    -- upvalues: l__Mince__4 (copy), l__EditableSpriteAnimator__3 (copy), l__AssetService__1 (copy), u2 (copy), u3 (ref), u1 (copy)
    local l__IntyLNYSprites__5 = l__Mince__4.Config.IntyLNYSprites;
    local v4 = {
        Empty = l__EditableSpriteAnimator__3.new(l__IntyLNYSprites__5),
        Full = l__EditableSpriteAnimator__3.new(l__IntyLNYSprites__5),
        Finished = l__EditableSpriteAnimator__3.new(l__IntyLNYSprites__5)
    };
    local v5 = l__AssetService__1:CreateEditableImage({
        Size = u2
    });
    u3 = v5.DrawImageTransformed;
    local v6 = {
        Empty = l__AssetService__1:CreateEditableImage({
            Size = u2
        }),
        Full = l__AssetService__1:CreateEditableImage({
            Size = u2
        }),
        Finished = l__AssetService__1:CreateEditableImage({
            Size = u2
        })
    };
    v4.Empty:Play("Walk");
    v4.Full:Play("Swim");
    v4.Finished:Play("Dizzy");
    u1.BackBuffer = v5;
    u1.Animators = v4;
    u1.Canvases = v6;
end;
function u1.Use(_) --[[ Line: 163 ]]
    -- upvalues: u1 (copy)
    local v7 = u1;
    v7.InUse = v7.InUse + 1;
end;
function u1.Discard(_) --[[ Line: 167 ]]
    -- upvalues: u1 (copy)
    local v8 = u1;
    v8.InUse = v8.InUse - 1;
end;
function u1.Setup() --[[ Line: 171 ]] end;
return u1;
