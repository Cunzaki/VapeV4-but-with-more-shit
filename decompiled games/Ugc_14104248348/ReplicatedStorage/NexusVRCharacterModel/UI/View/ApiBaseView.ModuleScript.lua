-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.UI.View.ApiBaseView
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__GuiService__1 = game:GetService("GuiService");
local l__NexusInstance__2 = require(script.Parent.Parent.Parent:WaitForChild("Packages"):WaitForChild("NexusInstance"));
local v1 = {};
v1.__index = v1;
function v1.__new(u2, p3) --[[ Line: 25 ]]
    u2.Name = p3;
    u2.Destroyed = u2:CreateEvent();
    u2.Frame = Instance.new("Frame");
    u2.Frame.Name = tostring(u2.Name);
    u2.Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    u2.Frame.BackgroundTransparency = 1;
    u2.Frame.Size = UDim2.new(1, 0, 1, 0);
    u2.Frame.Visible = false;
    u2.Frame.SizeConstraint = Enum.SizeConstraint.RelativeXX;
    u2:GetPropertyChangedSignal("Name"):Connect(function() --[[ Line: 36 ]]
        -- upvalues: u2 (copy)
        u2.Frame.Name = tostring(u2.Name);
    end);
    u2:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 39 ]]
        -- upvalues: u2 (copy)
        u2.Frame.Visible = u2.Visible;
    end);
end;
function v1.GetContainer(p4) --[[ Line: 47 ]]
    return p4.Frame;
end;
function v1.AddBackground(u5) --[[ Line: 54 ]]
    -- upvalues: l__GuiService__1 (copy)
    local v6 = Instance.new("UICorner");
    v6.CornerRadius = UDim.new(0.05, 0);
    v6.Parent = u5.Frame;
    u5.Frame.BackgroundTransparency = 0.6 * l__GuiService__1.PreferredTransparency;
    l__GuiService__1:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() --[[ Line: 62 ]]
        -- upvalues: u5 (copy), l__GuiService__1 (ref)
        u5.Frame.BackgroundTransparency = 0.6 * l__GuiService__1.PreferredTransparency;
    end);
end;
function v1.Destroy(p7) --[[ Line: 70 ]]
    p7.Destroyed:Fire();
    p7.Frame:Destroy();
end;
return l__NexusInstance__2.ToInstance(v1);
