-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.KBBQOrderInterface
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Module3D__4 = require(l__ReplicatedStorage__1.Modules.Module3D);
l__Mince__3:Get("UserProfile");
l__Mince__3:Get("ConfirmPrompt");
local u1 = l__Mince__3:Get("InterfaceHandler");
local u2 = {
    Items = {},
    Order = {}
};
local u3 = {};
u3.__index = u3;
function u3.new(...) --[[ Line: 21 ]]
    -- upvalues: u3 (copy)
    local v4 = setmetatable({}, u3);
    v4:Init(...);
    return v4;
end;
function u3.Init(u5, p6, u7) --[[ Line: 27 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u1 (copy), u2 (copy), l__Module3D__4 (copy)
    u5.Item = p6;
    if u5.Item:GetAttribute("ShowPlatedFood") then
        u5.Item = u5.Item.Handle:FindFirstChildOfClass("Tool");
    end;
    local _ = u5.Item.Handle.CFrame;
    if u5.Item.Handle:FindFirstChild("Place") then
        u5.Offset = CFrame.new(0, 0, 0);
    end;
    u5.GUI = l__ReplicatedStorage__1.Assets.Interface.KBBQMenuItem:Clone();
    u5.GUI.ItemName.Text = u5.Item:GetAttribute("FoodName") or u5.Item.Name;
    u5.GUI.ItemDesc.Text = u5.Item:GetAttribute("Description") or "";
    u1.NewButton(u5.GUI.UseButton).Activated:Connect(function() --[[ Line: 44 ]]
        -- upvalues: u2 (ref), u5 (copy), u7 (copy)
        if #u2.Order > 3 then
        else
            u5.GUI.RemoveButton.Visible = true;
            table.insert(u2.Order, u7);
            if #u2.Order > 3 then
                for _, v8 in u2.Items do
                    v8:SetOrderable(false);
                end;
            end;
        end;
    end);
    u1.NewButton(u5.GUI.RemoveButton).Activated:Connect(function() --[[ Line: 56 ]]
        -- upvalues: u5 (copy), u2 (ref), u7 (copy)
        u5.GUI.RemoveButton.Visible = false;
        table.remove(u2.Order, table.find(u2.Order, u7));
        for _, v9 in u2.Items do
            v9:SetOrderable(true);
        end;
    end);
    u1.NewButton(u5.GUI.Max).Activated:Connect(function() --[[ Line: 64 ]] end);
    u5.GUI.Container.MouseEnter:Connect(function() --[[ Line: 68 ]]
        -- upvalues: u5 (copy)
        u5:Start();
    end);
    u5.GUI.Container.MouseLeave:Connect(function() --[[ Line: 72 ]]
        -- upvalues: u5 (copy)
        u5:Stop();
    end);
    u5.Model3D = l__Module3D__4:Attach3D(u5.GUI.Container, u5.Item);
    u5.Model3D:SetDepthMultiplier(1.2);
    u5.Model3D.CurrentCamera.FieldOfView = 5;
    u5.Model3D.Visible = true;
    u5.Model3D:SetCFrame(u5.Offset);
    u5.GUI.Parent = u2.Scroll;
end;
function u3.SetOrderable(p10, p11) --[[ Line: 86 ]]
    p10.GUI.Max.Visible = not p11;
end;
function u3.Reset(p12) --[[ Line: 90 ]]
    p12.GUI.RemoveButton.Visible = false;
    p12.GUI.Max.Visible = false;
end;
function u3.Start(u13) --[[ Line: 95 ]]
    -- upvalues: l__RunService__2 (copy)
    u13:Stop();
    u13.TimeElapsed = 0;
    u13.__SpinEvent = l__RunService__2.RenderStepped:Connect(function(p14) --[[ Line: 98 ]]
        -- upvalues: u13 (copy)
        local v15 = u13;
        v15.TimeElapsed = v15.TimeElapsed + p14;
        u13.Model3D:SetCFrame(CFrame.Angles(0, u13.TimeElapsed % 6.283185307179586, 0) * u13.Offset);
    end);
end;
function u3.Stop(p16) --[[ Line: 104 ]]
    if p16.__SpinEvent then
        p16.__SpinEvent:Disconnect();
    end;
    p16.Model3D:SetCFrame(p16.Offset);
end;
function u2.GetOrder() --[[ Line: 111 ]]
    -- upvalues: u2 (copy)
    local u17 = false;
    u2.Interface.Trigger();
    u2.Order = {};
    u2.CloseConnection = u2.CloseButton.Activated:Connect(function() --[[ Line: 117 ]]
        -- upvalues: u2 (ref), u17 (ref)
        u2.Order = {};
        u17 = true;
    end);
    u2.OrderConnection = u2.OrderButton.Activated:Connect(function() --[[ Line: 121 ]]
        -- upvalues: u17 (ref)
        u17 = true;
    end);
    u2.DroppedConnection = u2.Interface.Closed:Connect(function() --[[ Line: 124 ]]
        -- upvalues: u17 (ref), u2 (ref)
        if not u17 then
            u2.Order = {};
            u17 = true;
        end;
    end);
    repeat
        task.wait();
    until u17;
    u2.Interface.Close();
    for _, v18 in u2.Items do
        v18:Reset();
    end;
    u2.OrderConnection:Disconnect();
    u2.CloseConnection:Disconnect();
    u2.DroppedConnection:Disconnect();
    return u2.Order;
end;
function u2.SetupGui() --[[ Line: 146 ]]
    -- upvalues: u1 (copy), u2 (copy), l__ReplicatedStorage__1 (copy), u3 (copy)
    local v19 = u1.NewButton(u2.MainFrame.CloseButton);
    local v20 = u1.NewButton(u2.MainFrame.OkayButton);
    u2.CloseButton = v19;
    u2.OrderButton = v20;
    u1.AutoSizeScrollingFrame(u2.Scroll);
    for _, u21 in l__ReplicatedStorage__1.Assets.KBBQPickableFoods:GetChildren() do
        task.defer(function() --[[ Line: 156 ]]
            -- upvalues: u3 (ref), u21 (copy), u2 (ref)
            local v22 = u3.new(u21:FindFirstChildOfClass("Tool"), u21.Name);
            table.insert(u2.Items, v22);
        end);
    end;
    u3.new(l__ReplicatedStorage__1.Assets.KBBQPickableFoods.BeefBulgogi:FindFirstChildOfClass("Tool"), "a");
end;
function u2.Setup() --[[ Line: 168 ]]
    -- upvalues: u2 (copy), u1 (copy)
    u2.Interface = u1.Get("KBBQMenu");
    u2.MainFrame = u2.Interface.TweenFrame;
    u2.Scroll = u2.MainFrame.Scroll;
    u2.SetupGui();
end;
return u2;
