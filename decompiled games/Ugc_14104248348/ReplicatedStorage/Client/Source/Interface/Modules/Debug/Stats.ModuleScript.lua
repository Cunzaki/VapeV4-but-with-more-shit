-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.Debug.Stats
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local _ = game:GetService("Players").LocalPlayer;
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("BindManager");
local u2 = l__Mince__2:Get("InterfaceHandler");
local u3 = {
    IsVisible = false,
    TextStats = {}
};
function u3.Update(_) --[[ Line: 17 ]]
    -- upvalues: u3 (copy), l__Mince__2 (copy)
    if u3.IsVisible then
        for v4, v5 in l__Mince__2.Config.Stats do
            local v6 = u3.TextStats[v5[1]];
            if not v6 then
                v6 = script.StatText:Clone();
                v6.Parent = u3.MainFrame;
                v6.LayoutOrder = v5[1];
                u3.TextStats[v5[1]] = v6;
            end;
            v6.Text = `[{v4}][{v5[1]}]:{v5[2]}`;
        end;
    end;
end;
function u3.Setup() --[[ Line: 33 ]]
    -- upvalues: u2 (copy), u3 (copy), u1 (copy)
    local v7 = u2.GetScreenGui("MainPriority");
    u3.MainFrame = v7.Stats;
    u3.ABTest = v7.ABTest;
    u1.Get("ShowDebug").OnAction:Connect(function(p8) --[[ Line: 37 ]]
        -- upvalues: u3 (ref)
        if p8 == Enum.UserInputState.Begin then
            u3.IsVisible = not u3.IsVisible;
            u3.MainFrame.Visible = u3.IsVisible;
            u3.ABTest.Visible = u3.IsVisible;
        end;
    end);
    u3.MainFrame.Visible = u3.IsVisible;
    u3.ABTest.Visible = u3.IsVisible;
    task.spawn(function() --[[ Line: 48 ]]
        -- upvalues: u3 (ref)
        while true do
            local v9 = task.wait();
            u3.Update(v9);
        end;
    end);
end;
return u3;
