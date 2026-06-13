-- Decompiled from: ReplicatedStorage.Client.Source.ProximityManager.Radial
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local u1 = {
    Name = "Radial",
    TweenIn = TweenInfo.new(0.2, Enum.EasingStyle.Bounce),
    TweenOut = TweenInfo.new(0.1),
    Out2 = TweenInfo.new(0.05, Enum.EasingStyle.Sine),
    Popup = TweenInfo.new(0.3, Enum.EasingStyle.Quint)
};
function u1.Appear(u2) --[[ Line: 12 ]]
    -- upvalues: l__TweenService__1 (copy), u1 (copy)
    local v3 = u2.ProximityPrompt:GetAttribute("SizeMultipler") or 1;
    local l__ObjectText__2 = u2.ProximityPrompt.ObjectText;
    u2.Billboard = script.prompt:Clone();
    u2.Billboard.Adornee = u2.ProximityPrompt.Parent;
    u2.Billboard.Parent = u2.ScreenGui;
    u2.Billboard.Size = UDim2.fromScale(u2.Billboard.Size.X.Scale * v3, u2.Billboard.Size.Y.Scale * v3);
    u2.Billboard.Container.Action.Text = l__ObjectText__2;
    u2:Update();
    u2.OrginalButtonSize = u2.Billboard.Container.Button.Button.Size;
    u2.OrginalActionSize = u2.Billboard.Container.Action.Size;
    u2.Billboard.Container.Action.Size = UDim2.fromScale(u2.OrginalActionSize.X.Scale, 0);
    l__TweenService__1:Create(u2.Billboard.Container.Action, u1.Popup, {
        Size = u2.OrginalActionSize
    }):Play();
    u2.Billboard.Container.Button.Button.Size = UDim2.fromScale(0, 0);
    l__TweenService__1:Create(u2.Billboard.Container.Button.Button, u2.TweenIn, {
        Size = u2.OrginalButtonSize
    }):Play();
    u2.InstancingMaid:Add(u2.Billboard.Container.Button.Trigger.MouseButton1Down:Connect(function() --[[ Line: 36 ]]
        -- upvalues: u2 (copy)
        u2.ProximityPrompt:InputHoldBegin();
    end));
    u2.InstancingMaid:Add(u2.Billboard.Container.Button.Trigger.MouseButton1Up:Connect(function() --[[ Line: 40 ]]
        -- upvalues: u2 (copy)
        u2.ProximityPrompt:InputHoldEnd();
    end));
    u2.InstancingMaid:Add(u2.Billboard.Container.Button.Trigger.MouseLeave:Connect(function() --[[ Line: 44 ]]
        -- upvalues: u2 (copy)
        u2:Simulate("TriggerEnded");
    end));
    local l__Size__3 = script.prompt.Container.Button.Size;
    u2.Tweens = {
        Default = l__TweenService__1:Create(u2.Billboard.Container.Button, u2.TweenOut, {
            Size = l__Size__3
        }),
        Pressed = l__TweenService__1:Create(u2.Billboard.Container.Button, u2.TweenIn, {
            Size = UDim2.new(l__Size__3.X.Scale * 0.8, 0, l__Size__3.Y.Scale * 0.8, 0)
        })
    };
end;
function u1.InputsChanged(p4) --[[ Line: 59 ]]
    p4:Update();
end;
function u1.Update(p5) --[[ Line: 63 ]]
    if p5.InputObject.Type == "String" then
        p5.Billboard.Container.Button.Button.Visible = false;
        p5.Billboard.Container.Button.Key.Visible = true;
        p5.Billboard.Container.Button.Key.Text = p5.InputObject.Value;
    else
        if p5.InputObject.Type == "Image" then
            p5.Billboard.Container.Button.Button.Visible = true;
            p5.Billboard.Container.Button.Key.Visible = false;
            p5.Billboard.Container.Button.Button.Image = p5.InputObject.Value;
        end;
    end;
end;
function u1.Triggered(p6) --[[ Line: 75 ]]
    p6.Tweens.Pressed:Play();
end;
function u1.TriggerEnded(p7) --[[ Line: 79 ]]
    p7.Tweens.Default:Play();
end;
function u1.Hidden(p8) --[[ Line: 83 ]]
    -- upvalues: l__TweenService__1 (copy)
    p8.Billboard.Container.Action:Destroy();
    l__TweenService__1:Create(p8.Billboard.Container.Button.Button, p8.Out2, {
        ImageTransparency = 1
    }):Play();
    l__TweenService__1:Create(p8.Billboard.Container.Button.Button, p8.Out2, {
        Size = UDim2.fromScale(0, 0)
    }):Play();
    task.wait(1);
    p8.Billboard:Destroy();
end;
return u1;
