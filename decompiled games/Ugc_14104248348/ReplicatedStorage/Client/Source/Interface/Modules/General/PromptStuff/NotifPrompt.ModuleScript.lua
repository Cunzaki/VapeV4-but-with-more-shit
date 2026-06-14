-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.PromptStuff.NotifPrompt
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("InterfaceHandler");
local u2 = l__Mince__2:GetEvent("NotifPromptServer");
local u3 = {
    UponOkay = function() --[[ Name: UponOkay, Line 11 ]] end
};
function u3.Display(p4, p5) --[[ Line: 14 ]]
    -- upvalues: u3 (copy)
    local l__Interface__3 = u3.Interface;
    u3.Interface.TweenFrame.Descriptor.Text = p4;
    if p5 then
        u3.UponOkay = p5;
    end;
    l__Interface__3.Stack();
end;
function u3.__SetupUI() --[[ Line: 25 ]]
    -- upvalues: u1 (copy), u3 (copy)
    u1.NewButton(u3.Interface.TweenFrame.DismissButton).Activated:Connect(function() --[[ Line: 27 ]]
        -- upvalues: u3 (ref), u1 (ref)
        if u3.Interface.IsActive then
            u1.Remove();
            u3.UponOkay();
        end;
    end);
    local function v6() --[[ Line: 34 ]]
        -- upvalues: u3 (ref)
        u3.Interface.TweenFrame.Descriptor.TextSize = u3.Interface.TweenFrame.Descriptor.AbsoluteSize.Y * 0.33;
    end;
    u3.Interface.TweenFrame.Descriptor.TextSize = u3.Interface.TweenFrame.Descriptor.AbsoluteSize.Y * 0.33;
    u3.Interface.TweenFrame.Descriptor:GetPropertyChangedSignal("AbsoluteSize"):Connect(v6);
end;
function u3.Setup() --[[ Line: 42 ]]
    -- upvalues: u3 (copy), u1 (copy), u2 (copy)
    u3.Interface = u1.Get("Notification");
    u3.__SetupUI();
    u2.Event:Connect(u3.Display);
end;
return u3;
