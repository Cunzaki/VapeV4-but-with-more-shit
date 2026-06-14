-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.LanternDecorationStation
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("InterfaceHandler");
local u2 = l__Mince__2:Get("LanternDecorator");
local u3 = l__Mince__2:Get("Notices");
local v4 = l__Mince__2.Component({
    Tag = "LanternDecorationStation"
});
function v4.Construct(u5) --[[ Line: 15 ]]
    -- upvalues: u1 (copy), u3 (copy), u2 (copy)
    u5.DecoratorModal = u1.Get("LanternDecorator", "Main");
    u5.DecoratorUI = u1.GetScreenGui("LanternDecorator");
    u5.SubmitButton = u1.NewButton(u5.DecoratorUI.Main.Form.SubmitButton);
    u5.CloseButton = u1.NewButton(u5.DecoratorUI.Main.CloseButton);
    local l__Instance__3 = u5.Instance;
    local v6 = Instance.new("ProximityPrompt");
    v6:SetAttribute("Type", "Radial");
    v6.ObjectText = "Create Lantern";
    v6.MaxActivationDistance = 5;
    v6.Style = Enum.ProximityPromptStyle.Custom;
    v6.Parent = l__Instance__3;
    v6.RequiresLineOfSight = true;
    v6.Triggered:Connect(function() --[[ Line: 31 ]]
        -- upvalues: u5 (copy), u3 (ref)
        if u5.UIOpen then
        elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Lantern") or game.Players.LocalPlayer.Character:FindFirstChild("Lantern") then
            u3.CreateNotice("You already have a lantern!", nil, 5);
        else
            u5.DecoratorUI.Main.Results.Visible = false;
            u5.DecoratorUI.Main.Form.Visible = true;
            u5.DecoratorModal.Open();
            u5.UIOpen = true;
        end;
    end);
    u5.SubmitButton.Activated:Connect(function() --[[ Line: 45 ]]
        -- upvalues: u2 (ref), u5 (copy)
        local v7, v8 = u2.CreateLantern((tonumber(u5.DecoratorUI.Main.Form.DrinkName.Text)));
        u5.DecoratorUI.Main.Results.ResultLabel.Text = `You picked number <b>{u5.DecoratorUI.Main.Form.DrinkName.Text}</b>`;
        u5.DecoratorUI.Main.Results.ShapeLabel.Text = `Shape: <b>{v8.lantern.shape}</b>`;
        u5.DecoratorUI.Main.Results.ColorLabel.Text = `Color: <b>{v8.lantern.color}</b>`;
        u5.DecoratorUI.Main.Results.Bottom.Descriptor.Text = `{v8.description}<br/><br/>{v8.funFact}`;
        u5.DecoratorUI.Main.Results.View.ViewportFrame:ClearAllChildren();
        local v9 = v7.Handle:Clone();
        v9.Parent = u5.DecoratorUI.Main.Results.View.ViewportFrame;
        v9.CFrame = CFrame.new(0, 20, 20) * CFrame.new(0, 0, -2.3);
        u5.DecoratorUI.Main.Results.Visible = true;
        u5.DecoratorUI.Main.Form.Visible = false;
    end);
    u5.CloseButton.Activated:Connect(function() --[[ Line: 63 ]]
        -- upvalues: u5 (copy)
        u5.DecoratorModal.Close();
        u5.UIOpen = false;
    end);
    u5.DecoratorUI.Main.Form.DrinkName.Changed:Connect(function() --[[ Line: 68 ]]
        -- upvalues: u5 (copy), u2 (ref)
        if u5.DecoratorUI.Main.Form.DrinkName.Text then
            u5.DecoratorUI.Main.Form.DrinkName.Text = u2.FilterText(u5.DecoratorUI.Main.Form.DrinkName.Text) or "";
        end;
    end);
end;
return v4;
