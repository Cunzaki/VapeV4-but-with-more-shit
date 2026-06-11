-- Decompiled from: .ChillArrow26.PlayerScripts.PlayerModule.ControlModule.TouchJump
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__GuiService__2 = game:GetService("GuiService");
local l__BaseCharacterController__3 = require(script.Parent:WaitForChild("BaseCharacterController"));
local u1 = setmetatable({}, l__BaseCharacterController__3);
u1.__index = u1;
function u1.new() --[[ Line: 19 ]]
    -- upvalues: l__BaseCharacterController__3 (copy), u1 (copy)
    local v2 = l__BaseCharacterController__3.new();
    local v3 = setmetatable(v2, u1);
    v3.parentUIFrame = nil;
    v3.jumpButton = nil;
    v3.characterAddedConn = nil;
    v3.humanoidStateEnabledChangedConn = nil;
    v3.humanoidJumpPowerConn = nil;
    v3.humanoidParentConn = nil;
    v3.externallyEnabled = false;
    v3.jumpPower = 0;
    v3.jumpStateEnabled = true;
    v3.isJumping = false;
    v3.humanoid = nil;
    return v3;
end;
function u1.EnableButton(p4, p5) --[[ Line: 37 ]]
    -- upvalues: l__Players__1 (copy)
    if p5 then
        if not p4.jumpButton then
            p4:Create();
        end;
        local l__Character__4 = l__Players__1.LocalPlayer.Character;
        if l__Character__4 then
            l__Character__4 = l__Players__1.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
        end;
        if l__Character__4 and (p4.externallyEnabled and (p4.externallyEnabled and l__Character__4.JumpPower > 0)) then
            p4.jumpButton.Visible = true;
        end;
    else
        p4.jumpButton.Visible = false;
        p4.isJumping = false;
        p4.jumpButton.ImageRectOffset = Vector2.new(1, 146);
    end;
end;
function u1.UpdateEnabled(p6) --[[ Line: 57 ]]
    if p6.jumpPower > 0 and p6.jumpStateEnabled then
        p6:EnableButton(true);
    else
        p6:EnableButton(false);
    end;
end;
function u1.HumanoidChanged(p7, p8) --[[ Line: 65 ]]
    -- upvalues: l__Players__1 (copy)
    local l__Character__5 = l__Players__1.LocalPlayer.Character;
    if l__Character__5 then
        l__Character__5 = l__Players__1.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
    end;
    if l__Character__5 then
        if p8 == "JumpPower" then
            p7.jumpPower = l__Character__5.JumpPower;
            p7:UpdateEnabled();
            return;
        end;
        if p8 == "Parent" and not l__Character__5.Parent then
            p7.humanoidChangeConn:Disconnect();
        end;
    end;
end;
function u1.HumanoidStateEnabledChanged(p9, p10, p11) --[[ Line: 79 ]]
    if p10 == Enum.HumanoidStateType.Jumping then
        p9.jumpStateEnabled = p11;
        p9:UpdateEnabled();
    end;
end;
function u1.CharacterAdded(u12, p13) --[[ Line: 86 ]]
    if u12.humanoidChangeConn then
        u12.humanoidChangeConn:Disconnect();
        u12.humanoidChangeConn = nil;
    end;
    u12.humanoid = p13:FindFirstChildOfClass("Humanoid");
    while not u12.humanoid do
        p13.ChildAdded:wait();
        u12.humanoid = p13:FindFirstChildOfClass("Humanoid");
    end;
    u12.humanoidJumpPowerConn = u12.humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function() --[[ Line: 98 ]]
        -- upvalues: u12 (copy)
        u12.jumpPower = u12.humanoid.JumpPower;
        u12:UpdateEnabled();
    end);
    u12.humanoidParentConn = u12.humanoid:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 103 ]]
        -- upvalues: u12 (copy)
        if not u12.humanoid.Parent then
            u12.humanoidJumpPowerConn:Disconnect();
            u12.humanoidJumpPowerConn = nil;
            u12.humanoidParentConn:Disconnect();
            u12.humanoidParentConn = nil;
        end;
    end);
    u12.humanoidStateEnabledChangedConn = u12.humanoid.StateEnabledChanged:Connect(function(p14, p15) --[[ Line: 112 ]]
        -- upvalues: u12 (copy)
        u12:HumanoidStateEnabledChanged(p14, p15);
    end);
    u12.jumpPower = u12.humanoid.JumpPower;
    u12.jumpStateEnabled = u12.humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping);
    u12:UpdateEnabled();
end;
function u1.SetupCharacterAddedFunction(u16) --[[ Line: 121 ]]
    -- upvalues: l__Players__1 (copy)
    u16.characterAddedConn = l__Players__1.LocalPlayer.CharacterAdded:Connect(function(p17) --[[ Line: 122 ]]
        -- upvalues: u16 (copy)
        u16:CharacterAdded(p17);
    end);
    if l__Players__1.LocalPlayer.Character then
        u16:CharacterAdded(l__Players__1.LocalPlayer.Character);
    end;
end;
function u1.Enable(p18, p19, p20) --[[ Line: 130 ]]
    if p20 then
        p18.parentUIFrame = p20;
    end;
    p18.externallyEnabled = p19;
    p18:EnableButton(p19);
end;
function u1.Create(u21) --[[ Line: 138 ]]
    -- upvalues: l__GuiService__2 (copy)
    if u21.parentUIFrame then
        if u21.jumpButton then
            u21.jumpButton:Destroy();
            u21.jumpButton = nil;
        end;
        local v22 = math.min(u21.parentUIFrame.AbsoluteSize.x, u21.parentUIFrame.AbsoluteSize.y) <= 500;
        local v23 = v22 and 70 or 120;
        u21.jumpButton = Instance.new("ImageButton");
        u21.jumpButton.Name = "JumpButton";
        u21.jumpButton.Visible = false;
        u21.jumpButton.BackgroundTransparency = 1;
        u21.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
        u21.jumpButton.ImageRectOffset = Vector2.new(1, 146);
        u21.jumpButton.ImageRectSize = Vector2.new(144, 144);
        u21.jumpButton.Size = UDim2.new(0, v23, 0, v23);
        u21.jumpButton.Position = v22 and UDim2.new(1, -(v23 * 1.5 - 10), 1, -v23 - 20) or UDim2.new(1, -(v23 * 1.5 - 10), 1, -v23 * 1.75);
        local u24 = nil;
        u21.jumpButton.InputBegan:connect(function(p25) --[[ Line: 165 ]]
            -- upvalues: u24 (ref), u21 (copy)
            if u24 or (p25.UserInputType ~= Enum.UserInputType.Touch or p25.UserInputState ~= Enum.UserInputState.Begin) then
            else
                u24 = p25;
                u21.jumpButton.ImageRectOffset = Vector2.new(146, 146);
                u21.isJumping = true;
            end;
        end);
        u21.jumpButton.InputEnded:connect(function(p26) --[[ Line: 184 ]]
            -- upvalues: u24 (ref), u21 (copy)
            if p26 == u24 then
                u24 = nil;
                u21.isJumping = false;
                u21.jumpButton.ImageRectOffset = Vector2.new(1, 146);
            end;
        end);
        l__GuiService__2.MenuOpened:connect(function() --[[ Line: 190 ]]
            -- upvalues: u24 (ref), u21 (copy)
            if u24 then
                u24 = nil;
                u21.isJumping = false;
                u21.jumpButton.ImageRectOffset = Vector2.new(1, 146);
            end;
        end);
        if not u21.characterAddedConn then
            u21:SetupCharacterAddedFunction();
        end;
        u21.jumpButton.Parent = u21.parentUIFrame;
    end;
end;
return u1;
