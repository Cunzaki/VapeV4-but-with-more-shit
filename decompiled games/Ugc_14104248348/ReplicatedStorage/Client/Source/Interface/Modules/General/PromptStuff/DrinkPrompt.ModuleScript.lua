-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.PromptStuff.DrinkPrompt
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("DrinkHandler");
local u2 = l__Mince__3:Get("InterfaceHandler");
local u3 = l__Mince__3:GetState("DrinkCreatorState");
local u4 = {
    Icons = {
        Robux = "",
        Premium = "",
        Verified = ""
    },
    CurrentConfirmation = {
        Solved = true
    },
    DefaultFunc = function() --[[ Name: DefaultFunc, Line 21 ]] end
};
function u4.GenerateName(p5) --[[ Line: 24 ]]
    -- upvalues: u4 (copy)
    local v6 = "";
    if p5.MembershipType == Enum.MembershipType.Premium then
        v6 = v6 .. u4.Icons.Premium;
    end;
    if p5.HasVerifiedBadge then
        v6 = v6 .. u4.Icons.Verified;
    end;
    return `{p5.Name}{v6}`;
end;
function u4.Display(p7, p8, p9) --[[ Line: 37 ]]
    -- upvalues: u4 (copy), u3 (copy), u1 (copy), l__LocalPlayer__2 (copy)
    repeat
        task.wait();
    until u4.Interface;
    if u4.CurrentConfirmation.Solved then
        local l__Interface__4 = u4.Interface;
        u4.CurrentConfirmation = {
            RejectUponClose = true,
            Solved = false,
            UponAccept = p8 or u4.DefaultFunc,
            UponReject = p9 or u4.DefaultFunc
        };
        if u4.PreviousViewport then
            u4.PreviousViewport:Destroy();
            u4.PreviousViewport = nil;
        end;
        if u3.FREE_MODE then
            p7.Price = "FREE";
        end;
        u4.PreviousViewport = u1.CreateSmallDrinkColorViewport(p7.Color);
        u4.PreviousViewport.Parent = u4.Interface.TweenFrame.View;
        u4.Interface.TweenFrame.Creator.Text = u4.GenerateName(l__LocalPlayer__2);
        u4.Interface.TweenFrame.DrinkName.Text = p7.DrinkName;
        u4.Interface.TweenFrame.TimeLabel.Text = p7.Time;
        u4.Interface.TweenFrame.ConfirmText.Text = `Would you like to create this for {p7.Price}?`;
        l__Interface__4.Stack(true);
        return u4.CurrentConfirmation;
    end;
end;
function u4.__SetupUI() --[[ Line: 70 ]]
    -- upvalues: u2 (copy), u4 (copy)
    local v10 = u2.NewButton(u4.Interface.TweenFrame.YesButton);
    u2.NewButton(u4.Interface.TweenFrame.NoButton).Activated:Connect(function() --[[ Line: 74 ]]
        -- upvalues: u4 (ref), u2 (ref)
        if u4.Interface.IsActive then
            u2.Remove();
            if u4.CurrentConfirmation then
                u4.CurrentConfirmation.UponReject();
                u4.CurrentConfirmation.Solved = true;
            end;
        end;
    end);
    v10.Activated:Connect(function() --[[ Line: 83 ]]
        -- upvalues: u4 (ref), u2 (ref)
        if u4.Interface.IsActive then
            u2.Remove();
            if u4.CurrentConfirmation then
                u4.CurrentConfirmation.UponAccept();
                u4.CurrentConfirmation.Solved = true;
            end;
        end;
    end);
end;
function u4.Setup() --[[ Line: 94 ]]
    -- upvalues: u4 (copy), u2 (copy)
    if not game:IsLoaded() then
        game.Loaded:Wait();
    end;
    u4.Interface = u2.Get("DrinkConfirmation");
    u4.__SetupUI();
end;
return u4;
