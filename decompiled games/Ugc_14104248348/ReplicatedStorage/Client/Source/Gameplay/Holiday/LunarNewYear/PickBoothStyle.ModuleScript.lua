-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.LunarNewYear.PickBoothStyle
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("Players");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:GetEvent("PickBoothStyle");
local u2 = l__Mince__2:Get("SelectInteractor");
local u3 = l__Mince__2:Get("InterfaceHandler");
local u4 = {
    Construct = function(_) --[[ Name: Construct, Line 16 ]] end
};
function u4.Setup(_) --[[ Line: 19 ]]
    -- upvalues: u4 (copy), u3 (copy), u1 (copy), u2 (copy)
    u4.Interface = u3.Get("PickBoothStyle");
    u4.MainPriority = u3.GetScreenGui("MainPriority");
    for _, u5 in u4.Interface.TweenFrame.Container:GetChildren() do
        if u5:IsA("GuiButton") then
            u3.NewButton(u5).Activated:Connect(function() --[[ Line: 25 ]]
                -- upvalues: u4 (ref), u1 (ref), u5 (copy)
                u4.Interface:Close();
                u1:Fire(u5.Name);
            end);
        end;
    end;
    u1.Event:Connect(function() --[[ Line: 31 ]]
        -- upvalues: u4 (ref)
        u4.Interface:Open();
    end);
    u3.NewButton(u4.Interface.TweenFrame.CloseButton).Activated:Connect(function() --[[ Line: 35 ]]
        -- upvalues: u4 (ref)
        u4.Interface:Close();
    end);
    u4.Interface.Opened:Connect(function() --[[ Line: 39 ]]
        -- upvalues: u2 (ref), u4 (ref)
        u2.StartInteractions();
        u4.MainPriority.Enabled = false;
    end);
    u4.Interface.Closed:Connect(function() --[[ Line: 44 ]]
        -- upvalues: u2 (ref), u4 (ref)
        u2.EndInteractions();
        u4.MainPriority.Enabled = true;
    end);
end;
return u4;
