-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.KBBQTable
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("ContextActionService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__TweenService__2 = game:GetService("TweenService");
local l__Players__3 = game:GetService("Players");
local l__MarketplaceService__4 = game:GetService("MarketplaceService");
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__5:Get("SelectInteractor");
l__Mince__5:Get("InterfaceHandler");
local u2 = l__Mince__5:Get("ConfirmPrompt");
local u3 = l__Mince__5:Get("Locomotion");
local u4 = l__Mince__5:Get("Notices");
local u5 = l__Mince__5:Get("KBBQOrderInterface");
local u6 = l__Mince__5:Get("Voicelines");
local u7 = l__Mince__5:GetEvent("RequestKBBQFood");
local u8 = l__Mince__5:GetEvent("KBBQRobotVoiceline");
local u9 = l__Mince__5.Component({
    Tag = "KBBQTable"
});
function u9.Construct(u10) --[[ Line: 26 ]]
    -- upvalues: u9 (copy), u2 (copy), u7 (copy), u1 (copy)
    local v11 = {};
    local v12 = u10.Instance:FindFirstChild("Button");
    v11.HoverName = "Order";
    v11.Name = "Order";
    v11.Model = v12;
    v11.HitCollider = v12.PrimaryPart;
    function v11.Interact(_, p13) --[[ Line: 37 ]]
        -- upvalues: u9 (ref), u2 (ref), u7 (ref), u10 (copy)
        if u9.OrderUnfulfilled then
            u2.Display("Are you sure you\'d like to cancel your order?", function() --[[ Line: 39 ]]
                -- upvalues: u7 (ref), u9 (ref)
                u7:Fire();
                u9.EndOrder();
            end);
            p13();
        else
            u10:DoOrder();
            p13();
        end;
    end;
    u1.NewInteractionClass(v11);
end;
function u9.DoOrder(p14) --[[ Line: 55 ]]
    -- upvalues: u4 (copy), u3 (copy), l__Mince__5 (copy), u5 (copy), u7 (copy), u9 (copy), u2 (copy)
    local v15 = p14:CanOrderFromTable();
    if type(v15) == "string" then
        u4.Error(v15);
    else
        u3.SetEnabled(false);
        l__Mince__5.Config.Humanoid.JumpHeight = 0;
        local v16 = u5.GetOrder();
        if #v16 < 1 then
            u4.CreateNotice("Order cancelled");
            u3.SetEnabled(true);
            l__Mince__5.Config.Humanoid.JumpHeight = 3;
        else
            u7:Fire(v16, v15.Parent.Parent.RobotWalkSpot);
            u4.CreateNotice("Order placed!");
            u9.OrderUnfulfilled = true;
            local function u17() --[[ Line: 81 ]]
                -- upvalues: u3 (ref), l__Mince__5 (ref), u2 (ref), u7 (ref), u9 (ref), u17 (copy)
                u3.SetEnabled(false);
                l__Mince__5.Config.Humanoid.JumpHeight = 0;
                u2.Display("Are you sure you\'d like to cancel your order?", function() --[[ Line: 85 ]]
                    -- upvalues: u3 (ref), l__Mince__5 (ref), u7 (ref), u9 (ref)
                    u3.SetEnabled(true);
                    l__Mince__5.Config.Humanoid.JumpHeight = 3;
                    u7:Fire();
                    l__Mince__5.Config.Humanoid.Jump = true;
                    u9.EndOrder();
                end, function() --[[ Line: 91 ]]
                    -- upvalues: u9 (ref), u3 (ref), u17 (ref)
                    u9.MovementLock = u3.Capture(0, true):Connect(u17);
                end);
            end;
            u9.MovementLock = u3.Capture(0, true):Connect(u17);
        end;
    end;
end;
function u9.CanOrderFromTable(p18) --[[ Line: 97 ]]
    -- upvalues: l__Players__3 (copy), l__MarketplaceService__4 (copy), l__Mince__5 (copy)
    local l__LocalPlayer__6 = l__Players__3.LocalPlayer;
    local l__Instance__7 = p18.Instance;
    if not (l__LocalPlayer__6.Character and l__LocalPlayer__6.Character:FindFirstChild("Humanoid")) then
        return "You don\'t exist!";
    end;
    if not l__LocalPlayer__6.Character:FindFirstChild("Humanoid").Sit then
        return "You must be sitting at the table to order!";
    end;
    local v19 = nil;
    for _, v20 in l__Instance__7:GetDescendants() do
        if v20:IsA("Weld") and (v20.Name == "SeatWeld" and v20.Part1:IsDescendantOf(l__LocalPlayer__6.Character)) then
            v19 = v20;
        end;
    end;
    if not v19 then
        return "You aren\'t sitting at this table!";
    end;
    local v21, v22 = pcall(function() --[[ Line: 126 ]]
        -- upvalues: l__MarketplaceService__4 (ref), l__LocalPlayer__6 (copy), l__Mince__5 (ref)
        return l__MarketplaceService__4:UserOwnsGamePassAsync(l__LocalPlayer__6.UserId, l__Mince__5.Config.Products.Passes.FoodMaster);
    end);
    if not v21 then
        return "Error, please try again.";
    end;
    if v22 then
        return v19;
    end;
    l__MarketplaceService__4:PromptGamePassPurchase(l__LocalPlayer__6, l__Mince__5.Config.Products.Passes.FoodMaster);
    return "You must own FoodMaster for this!";
end;
function u9.AcceptOrder(p23) --[[ Line: 142 ]]
    -- upvalues: l__Mince__5 (copy), l__TweenService__2 (copy), u9 (copy)
    local l__PrimaryPart__8 = p23.PrimaryPart;
    local l__HumanoidRootPart__9 = l__Mince__5.Config.HumanoidRootPart;
    local v24 = CFrame.new(l__PrimaryPart__8.Position, (Vector3.new(l__HumanoidRootPart__9.Position.X, l__PrimaryPart__8.Position.Y, l__HumanoidRootPart__9.Position.Z)));
    l__TweenService__2:Create(l__PrimaryPart__8, TweenInfo.new(0.5), {
        CFrame = v24
    }):Play();
    task.delay(2, function() --[[ Line: 149 ]]
        -- upvalues: l__PrimaryPart__8 (copy), l__TweenService__2 (ref)
        local v25 = CFrame.new(l__PrimaryPart__8.Position, l__PrimaryPart__8.Position - l__PrimaryPart__8.CFrame.LookVector * Vector3.new(1, 0, 1));
        l__TweenService__2:Create(l__PrimaryPart__8, TweenInfo.new(0.5), {
            CFrame = v25
        }):Play();
    end);
    u9.EndOrder();
end;
function u9.EndOrder() --[[ Line: 157 ]]
    -- upvalues: u9 (copy), l__Mince__5 (copy), u3 (copy)
    if u9.OrderUnfulfilled then
        if u9.MovementLock then
            u9.MovementLock:Disconnect();
            u9.MovementLock = nil;
            l__Mince__5.Config.Humanoid.JumpHeight = 3;
            u3.SetEnabled(true);
        end;
        u9.OrderUnfulfilled = false;
    end;
end;
function u9.DoRobotLine(p26, p27) --[[ Line: 170 ]]
    -- upvalues: u6 (copy)
    u6.PlayLine(p26, p27);
end;
function u9.CharacterAdded() --[[ Line: 174 ]]
    -- upvalues: u9 (copy), u7 (copy)
    if u9.OrderUnfulfilled then
        u9.EndOrder();
        u7:Fire();
    end;
end;
function u9.Setup() --[[ Line: 181 ]]
    -- upvalues: l__Players__3 (copy), u9 (copy), u7 (copy), u8 (copy)
    l__Players__3.LocalPlayer.CharacterAdded:Connect(u9.CharacterAdded);
    u7.Event:Connect(u9.AcceptOrder);
    u8.Event:Connect(u9.DoRobotLine);
end;
return u9;
