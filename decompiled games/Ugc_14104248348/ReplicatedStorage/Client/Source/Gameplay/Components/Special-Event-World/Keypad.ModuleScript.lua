-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.Keypad
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("SelectInteractor");
local u2 = l__Mince__3:GetEvent("InteractKeypad");
local u3 = l__Mince__3.Component({
    Tag = "Keypad",
    PressTween = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true),
    Numbers = {
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "0"
    }
});
function u3.CreatePressableButton(u4, u5) --[[ Line: 21 ]]
    -- upvalues: l__TweenService__2 (copy), u1 (copy)
    local u6 = {
        Press = l__TweenService__2:Create(u5, u4.PressTween, {
            Position = u5.Position + u5.CFrame.LookVector * -0.05
        })
    };
    local u7 = {
        HoverName = u5.Name,
        Target = u5,
        HitCollider = u5
    };
    function u7.Interact(_, p8) --[[ Line: 37 ]]
        -- upvalues: u4 (copy), u7 (copy), u6 (copy), u5 (copy)
        p8();
        if #u4.Code == u4.MaxNumbers then
            u4.Instance.Base.Press.PlaybackSpeed = tonumber(u7.HoverName) * 0.1 + 0.8;
            u4.Instance.Base.Press:Play();
            u4.Instance.Base.Reject:Play();
            u6.Press:Play();
        else
            local v9 = u4;
            v9.Code = v9.Code .. u5.Name;
            u4.TextLabel.Text = u4.Code;
            u4.Instance.Base.Press.PlaybackSpeed = tonumber(u7.HoverName) * 0.1 + 0.8;
            u4.Instance.Base.Press:Play();
            u6.Press:Play();
        end;
    end;
    u1.NewInteractionClass(u7);
end;
function u3.SetupClearButton(u10, p11) --[[ Line: 59 ]]
    -- upvalues: l__TweenService__2 (copy), u1 (copy)
    local u12 = {
        Press = l__TweenService__2:Create(p11, u10.PressTween, {
            Position = p11.Position + p11.CFrame.LookVector * -0.05
        })
    };
    u1.NewInteractionClass({
        HoverName = p11.Name,
        Target = p11,
        HitCollider = p11,
        Interact = function(_, p13) --[[ Name: Interact, Line 75 ]]
            -- upvalues: u10 (copy), u12 (copy)
            p13();
            u10.Code = "";
            u10.TextLabel.Text = u10.Code;
            u10.Instance.Base.Press.PlaybackSpeed = 2;
            u10.Instance.Base.Press:Play();
            u12.Press:Play();
        end
    });
end;
function u3.CreateEnterButton(u14, p15) --[[ Line: 89 ]]
    -- upvalues: l__TweenService__2 (copy), u2 (copy), u1 (copy)
    local u16 = {
        Press = l__TweenService__2:Create(p15, u14.PressTween, {
            Position = p15.Position + p15.CFrame.LookVector * -0.05
        })
    };
    u1.NewInteractionClass({
        HoverName = p15.Name,
        Target = p15,
        HitCollider = p15,
        Interact = function(_, p17) --[[ Name: Interact, Line 106 ]]
            -- upvalues: u14 (copy), u16 (copy), u2 (ref)
            if u14.Code == "" then
                p17();
                u14.Instance.Base.Error:Play();
                u14.Instance.Base.Press.PlaybackSpeed = 2;
                u14.Instance.Base.Press:Play();
                u16.Press:Play();
            elseif u14.Code == u14.RevealCode then
                u14.Code = "";
                u14.TextLabel.Text = u14.Code;
                u14.Instance.Base.Accept:Play();
                u14.Instance.Base.Press.PlaybackSpeed = 2;
                u14.Instance.Base.Press:Play();
                u16.Press:Play();
                u2:Fire(u14.Instance, "OpenKeypadDoor");
                p17();
            else
                u14.Instance.Base.Press.PlaybackSpeed = 2;
                u14.Instance.Base.Press:Play();
                u16.Press:Play();
                for _ = 1, 3 do
                    u14.Instance.Base.Error:Play();
                    u14.TextLabel.TextColor3 = Color3.new(1, 0, 0);
                    task.wait(0.5);
                    u14.TextLabel.TextColor3 = Color3.new(0, 0, 0);
                    task.wait(0.1);
                end;
                u14.TextLabel.TextColor3 = Color3.new(0, 1, 0);
                u14.Code = "";
                u14.TextLabel.Text = u14.Code;
                p17();
            end;
        end
    });
end;
function u3.Construct(p18) --[[ Line: 152 ]]
    -- upvalues: u3 (copy)
    p18.MaxNumbers = 6;
    p18.Code = "";
    p18.RevealCode = "337756";
    p18.TextLabel = p18.Instance.Surface.SurfaceGui.Code;
    p18.TextLabel.Text = p18.Code;
    for _, v19 in u3.Numbers do
        p18:CreatePressableButton((p18.Instance:FindFirstChild(v19)));
    end;
    p18:SetupClearButton(p18.Instance.Cancel);
    p18:CreateEnterButton(p18.Instance.Enter);
end;
return u3;
