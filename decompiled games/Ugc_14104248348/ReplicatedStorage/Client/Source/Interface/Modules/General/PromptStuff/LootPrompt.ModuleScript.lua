-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.PromptStuff.LootPrompt
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
function u2.Display(p3, p4, p5) --[[ Line: 12 ]]
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
        l__Interface__2.TweenFrame.Descriptor.Text = p3;
        l__Interface__2.Stack(true);
        return u2.CurrentConfirmation;
    end;
end;
function u2.__SetupUI() --[[ Line: 33 ]]
    -- upvalues: u1 (copy), u2 (copy)
    local v6 = u1.NewButton(u2.Interface.TweenFrame.Options.BuyOption1);
    local v7 = u1.NewButton(u2.Interface.TweenFrame.Options.BuyOption2);
    u1.NewButton(u2.Interface.TweenFrame.CloseButton).Activated:Connect(function() --[[ Line: 39 ]]
        -- upvalues: u2 (ref), u1 (ref)
        if u2.Interface.IsActive then
            u1.Remove();
            u2.CurrentConfirmation.Solved = true;
        end;
    end);
    v7.Activated:Connect(function() --[[ Line: 46 ]]
        -- upvalues: u2 (ref), u1 (ref)
        if u2.Interface.IsActive then
            u1.Remove();
            if u2.CurrentConfirmation then
                u2.CurrentConfirmation.UponReject();
                u2.CurrentConfirmation.Solved = true;
            end;
        end;
    end);
    v6.Activated:Connect(function() --[[ Line: 55 ]]
        -- upvalues: u2 (ref), u1 (ref)
        if u2.Interface.IsActive then
            u1.Remove();
            if u2.CurrentConfirmation then
                u2.CurrentConfirmation.UponAccept();
                u2.CurrentConfirmation.Solved = true;
            end;
        end;
    end);
end;
function u2.Setup() --[[ Line: 66 ]]
    -- upvalues: u2 (copy), u1 (copy)
    if not game:IsLoaded() then
        game.Loaded:Wait();
    end;
    u2.Interface = u1.Get("LootConfirm");
    u2.__SetupUI();
end;
return u2;
