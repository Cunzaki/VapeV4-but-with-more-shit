-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Tools.Magic8Ball
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local l__Players__2 = game:GetService("Players");
game:GetService("Debris");
local l__TweenService__3 = game:GetService("TweenService");
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__4:Get("ToolHandler");
local u2 = l__Mince__4:GetEvent("ChangeMagic8Ball");
l__Players__2.LocalPlayer:GetMouse();
local v3 = l__Mince__4.Component({
    Tag = "8ballHandle"
});
local u4 = {
    Cooldown = false,
    Tags = { "Magic8Ball" },
    Animations = {}
};
function u4.Setup() --[[ Line: 26 ]]
    -- upvalues: u1 (copy), u4 (copy)
    u1.Component(u4);
end;
function u4.Activate(_) --[[ Line: 30 ]]
    -- upvalues: u4 (copy), u2 (copy)
    if u4.Cooldown then
    else
        u4.Cooldown = true;
        u2:Fire();
        task.delay(8, function() --[[ Line: 37 ]]
            -- upvalues: u4 (ref)
            u4.Cooldown = false;
        end);
    end;
end;
function v3.DoAnimation(p5) --[[ Line: 42 ]]
    -- upvalues: l__TweenService__3 (copy)
    local l__Instance__5 = p5.Instance;
    if l__Instance__5:GetAttribute("IsDoingAnim") then
    else
        local l__BillboardGui__6 = l__Instance__5.BillboardGui;
        local u6 = true;
        l__Instance__5:SetAttribute("IsDoingAnim", true);
        task.defer(function() --[[ Line: 53 ]]
            -- upvalues: u6 (ref), l__BillboardGui__6 (copy)
            while u6 do
                l__BillboardGui__6.CanvasGroup["2"]:TweenPosition(UDim2.fromScale(math.random(-50, 50) / 3000 + 0.5, math.random(-50, 50) / 3000 + 0.5), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 0.3);
                task.wait(0.3);
            end;
        end);
        l__BillboardGui__6.TextLabel.Text = l__Instance__5:GetAttribute("Text");
        l__BillboardGui__6.TextLabel.UIGradient.Offset = Vector2.new(0, -1);
        l__BillboardGui__6.CanvasGroup.GroupTransparency = 1;
        l__TweenService__3:Create(l__BillboardGui__6.CanvasGroup, TweenInfo.new(1), {
            GroupTransparency = 0.2
        }):Play();
        task.wait(1);
        l__TweenService__3:Create(l__BillboardGui__6.TextLabel.UIGradient, TweenInfo.new(1), {
            Offset = Vector2.new(0, 1)
        }):Play();
        task.wait(5);
        l__TweenService__3:Create(l__BillboardGui__6.CanvasGroup, TweenInfo.new(1), {
            GroupTransparency = 1
        }):Play();
        l__TweenService__3:Create(l__BillboardGui__6.TextLabel.UIGradient, TweenInfo.new(1), {
            Offset = Vector2.new(0, -1)
        }):Play();
        task.wait(1);
        u6 = false;
        l__Instance__5:SetAttribute("IsDoingAnim", false);
    end;
end;
function v3.Construct(u7) --[[ Line: 78 ]]
    local u8 = u7.Instance:GetAttributeChangedSignal("Text"):Connect(function() --[[ Line: 80 ]]
        -- upvalues: u7 (copy)
        u7:DoAnimation();
    end);
    u7.Instance.Destroying:Connect(function() --[[ Line: 84 ]]
        -- upvalues: u8 (copy)
        u8:Disconnect();
    end);
end;
return u4;
