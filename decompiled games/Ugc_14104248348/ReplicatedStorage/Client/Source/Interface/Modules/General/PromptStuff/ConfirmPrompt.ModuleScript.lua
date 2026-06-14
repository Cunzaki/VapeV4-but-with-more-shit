-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.PromptStuff.ConfirmPrompt
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local u1 = require(l__ReplicatedStorage__1.Modules.Mince):Get("InterfaceHandler");
local u2 = {
    CurrentConfirmation = {
        Solved = true
    },
    DefaultFunc = function() --[[ Name: DefaultFunc, Line 9 ]] end
};
function u2.Display(p3, p4, p5, p6) --[[ Line: 12 ]]
    -- upvalues: u2 (copy)
    repeat
        task.wait();
    until u2.Interface;
    if u2.CurrentConfirmation.Solved then
        local l__Interface__2 = u2.Interface;
        u2.CurrentConfirmation = {
            RejectUponClose = true,
            Solved = false,
            UponAccept = p4 or u2.DefaultFunc,
            UponReject = p5 or u2.DefaultFunc,
            Description = p3
        };
        if p6 then
            u2.CurrentConfirmation.RejectUponClose = false;
            l__Interface__2.TweenFrame.Choice1Button.Visible = true;
            l__Interface__2.TweenFrame.Choice2Button.Visible = true;
            l__Interface__2.TweenFrame.YesButton.Visible = false;
            l__Interface__2.TweenFrame.NoButton.Visible = false;
            l__Interface__2.TweenFrame.Choice1Button.Text = p6[1];
            l__Interface__2.TweenFrame.Choice2Button.Text = p6[2];
            l__Interface__2.TweenFrame.CloseButton.Visible = false;
        else
            l__Interface__2.TweenFrame.Choice1Button.Visible = false;
            l__Interface__2.TweenFrame.Choice2Button.Visible = false;
            l__Interface__2.TweenFrame.YesButton.Visible = true;
            l__Interface__2.TweenFrame.NoButton.Visible = true;
            l__Interface__2.TweenFrame.CloseButton.Visible = true;
        end;
        l__Interface__2.TweenFrame.Descriptor.Text = p3;
        l__Interface__2.Stack(true);
        return u2.CurrentConfirmation;
    end;
end;
function u2.__SetupUI() --[[ Line: 53 ]]
    -- upvalues: u1 (copy), u2 (copy)
    local v7 = u1.NewButton(u2.Interface.TweenFrame.YesButton);
    local v8 = u1.NewButton(u2.Interface.TweenFrame.NoButton);
    local v9 = u1.NewButton(u2.Interface.TweenFrame.CloseButton);
    local v10 = u1.NewButton(u2.Interface.TweenFrame.Choice1Button);
    local v11 = u1.NewButton(u2.Interface.TweenFrame.Choice2Button);
    v9.Activated:Connect(function() --[[ Line: 60 ]]
        -- upvalues: u2 (ref), u1 (ref)
        if u2.Interface.IsActive then
            u1.Remove();
            u2.CurrentConfirmation.Solved = true;
            if u2.CurrentConfirmation and u2.CurrentConfirmation.RejectUponClose then
                u2.CurrentConfirmation.UponReject();
            end;
        end;
    end);
    v10.Activated:Connect(function() --[[ Line: 70 ]]
        -- upvalues: u2 (ref), u1 (ref)
        if u2.Interface.IsActive then
            u1.Remove();
            if u2.CurrentConfirmation then
                u2.CurrentConfirmation.UponAccept();
                u2.CurrentConfirmation.Solved = true;
            end;
        end;
    end);
    v11.Activated:Connect(function() --[[ Line: 80 ]]
        -- upvalues: u2 (ref), u1 (ref)
        if u2.Interface.IsActive then
            u1.Remove();
            if u2.CurrentConfirmation then
                u2.CurrentConfirmation.UponReject();
                u2.CurrentConfirmation.Solved = true;
            end;
        end;
    end);
    v8.Activated:Connect(function() --[[ Line: 90 ]]
        -- upvalues: u2 (ref), u1 (ref)
        if u2.Interface.IsActive then
            u1.Remove();
            if u2.CurrentConfirmation then
                u2.CurrentConfirmation.UponReject();
                u2.CurrentConfirmation.Solved = true;
            end;
        end;
    end);
    v7.Activated:Connect(function() --[[ Line: 100 ]]
        -- upvalues: u2 (ref), u1 (ref)
        if u2.Interface.IsActive then
            u1.Remove();
            if u2.CurrentConfirmation then
                u2.CurrentConfirmation.UponAccept();
                u2.CurrentConfirmation.Solved = true;
            end;
        end;
    end);
    u2.Interface.Closed:Connect(function() --[[ Line: 111 ]]
        -- upvalues: u2 (ref)
        u2.CurrentConfirmation.Solved = true;
    end);
end;
function u2.Setup() --[[ Line: 116 ]]
    -- upvalues: u2 (copy), u1 (copy)
    if not game:IsLoaded() then
        game.Loaded:Wait();
    end;
    u2.Interface = u1.Get("Confirmation");
    u2.__SetupUI();
end;
return u2;
