-- Decompiled from: .ChillArrow26.PlayerScripts.PlayerModule.ControlModule.TouchThumbstick
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local l__GuiService__1 = game:GetService("GuiService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__BaseCharacterController__3 = require(script.Parent:WaitForChild("BaseCharacterController"));
local u1 = setmetatable({}, l__BaseCharacterController__3);
u1.__index = u1;
function u1.new() --[[ Line: 16 ]]
    -- upvalues: l__BaseCharacterController__3 (copy), u1 (copy)
    local v2 = l__BaseCharacterController__3.new();
    local v3 = setmetatable(v2, u1);
    v3.isFollowStick = false;
    v3.thumbstickFrame = nil;
    v3.moveTouchObject = nil;
    v3.onTouchMovedConn = nil;
    v3.onTouchEndedConn = nil;
    v3.screenPos = nil;
    v3.stickImage = nil;
    v3.thumbstickSize = nil;
    return v3;
end;
function u1.Enable(p4, p5, p6) --[[ Line: 31 ]]
    if p5 == nil then
        return false;
    end;
    local v7 = p5 and true or false;
    if p4.enabled == v7 then
        return true;
    end;
    p4.moveVector = Vector3.new(0, 0, 0);
    p4.isJumping = false;
    if v7 then
        if not p4.thumbstickFrame then
            p4:Create(p6);
        end;
        p4.thumbstickFrame.Visible = true;
    else
        p4.thumbstickFrame.Visible = false;
        p4:OnInputEnded();
    end;
    p4.enabled = v7;
end;
function u1.OnInputEnded(p8) --[[ Line: 52 ]]
    p8.thumbstickFrame.Position = p8.screenPos;
    p8.stickImage.Position = UDim2.new(0, p8.thumbstickFrame.Size.X.Offset / 2 - p8.thumbstickSize / 4, 0, p8.thumbstickFrame.Size.Y.Offset / 2 - p8.thumbstickSize / 4);
    p8.moveVector = Vector3.new(0, 0, 0);
    p8.isJumping = false;
    p8.thumbstickFrame.Position = p8.screenPos;
    p8.moveTouchObject = nil;
end;
function u1.Create(u9, p10) --[[ Line: 61 ]]
    -- upvalues: l__UserInputService__2 (copy), l__GuiService__1 (copy)
    if u9.thumbstickFrame then
        u9.thumbstickFrame:Destroy();
        u9.thumbstickFrame = nil;
        if u9.onTouchMovedConn then
            u9.onTouchMovedConn:Disconnect();
            u9.onTouchMovedConn = nil;
        end;
        if u9.onTouchEndedConn then
            u9.onTouchEndedConn:Disconnect();
            u9.onTouchEndedConn = nil;
        end;
    end;
    local v11 = math.min(p10.AbsoluteSize.x, p10.AbsoluteSize.y) <= 500;
    u9.thumbstickSize = v11 and 70 or 120;
    u9.screenPos = v11 and UDim2.new(0, u9.thumbstickSize / 2 - 10, 1, -u9.thumbstickSize - 20) or UDim2.new(0, u9.thumbstickSize / 2, 1, -u9.thumbstickSize * 1.75);
    u9.thumbstickFrame = Instance.new("Frame");
    u9.thumbstickFrame.Name = "ThumbstickFrame";
    u9.thumbstickFrame.Active = true;
    u9.thumbstickFrame.Visible = false;
    u9.thumbstickFrame.Size = UDim2.new(0, u9.thumbstickSize, 0, u9.thumbstickSize);
    u9.thumbstickFrame.Position = u9.screenPos;
    u9.thumbstickFrame.BackgroundTransparency = 1;
    local v12 = Instance.new("ImageLabel");
    v12.Name = "OuterImage";
    v12.Image = "rbxasset://textures/ui/TouchControlsSheet.png";
    v12.ImageRectOffset = Vector2.new();
    v12.ImageRectSize = Vector2.new(220, 220);
    v12.BackgroundTransparency = 1;
    v12.Size = UDim2.new(0, u9.thumbstickSize, 0, u9.thumbstickSize);
    v12.Position = UDim2.new(0, 0, 0, 0);
    v12.Parent = u9.thumbstickFrame;
    u9.stickImage = Instance.new("ImageLabel");
    u9.stickImage.Name = "StickImage";
    u9.stickImage.Image = "rbxasset://textures/ui/TouchControlsSheet.png";
    u9.stickImage.ImageRectOffset = Vector2.new(220, 0);
    u9.stickImage.ImageRectSize = Vector2.new(111, 111);
    u9.stickImage.BackgroundTransparency = 1;
    u9.stickImage.Size = UDim2.new(0, u9.thumbstickSize / 2, 0, u9.thumbstickSize / 2);
    u9.stickImage.Position = UDim2.new(0, u9.thumbstickSize / 2 - u9.thumbstickSize / 4, 0, u9.thumbstickSize / 2 - u9.thumbstickSize / 4);
    u9.stickImage.ZIndex = 2;
    u9.stickImage.Parent = u9.thumbstickFrame;
    local u13 = nil;
    local function u19(p14) --[[ Line: 132 ]]
        -- upvalues: u13 (ref), u9 (copy)
        local v15 = Vector2.new(p14.x - u13.x, p14.y - u13.y);
        local l__magnitude__4 = v15.magnitude;
        local v16 = u9.thumbstickFrame.AbsoluteSize.x / 2;
        if u9.isFollowStick and v16 < l__magnitude__4 then
            local v17 = v15.unit * v16;
            u9.thumbstickFrame.Position = UDim2.new(0, p14.x - u9.thumbstickFrame.AbsoluteSize.x / 2 - v17.x, 0, p14.y - u9.thumbstickFrame.AbsoluteSize.y / 2 - v17.y);
        else
            local v18 = math.min(l__magnitude__4, v16);
            v15 = v15.unit * v18;
        end;
        u9.stickImage.Position = UDim2.new(0, v15.x + u9.stickImage.AbsoluteSize.x / 2, 0, v15.y + u9.stickImage.AbsoluteSize.y / 2);
    end;
    u9.thumbstickFrame.InputBegan:Connect(function(p20) --[[ Line: 149 ]]
        -- upvalues: u9 (copy), u13 (ref)
        if u9.moveTouchObject or (p20.UserInputType ~= Enum.UserInputType.Touch or p20.UserInputState ~= Enum.UserInputState.Begin) then
        else
            u9.moveTouchObject = p20;
            u9.thumbstickFrame.Position = UDim2.new(0, p20.Position.x - u9.thumbstickFrame.Size.X.Offset / 2, 0, p20.Position.y - u9.thumbstickFrame.Size.Y.Offset / 2);
            u13 = Vector2.new(u9.thumbstickFrame.AbsolutePosition.x + u9.thumbstickFrame.AbsoluteSize.x / 2, u9.thumbstickFrame.AbsolutePosition.y + u9.thumbstickFrame.AbsoluteSize.y / 2);
            Vector2.new(p20.Position.x - u13.x, p20.Position.y - u13.y);
        end;
    end);
    u9.onTouchMovedConn = l__UserInputService__2.TouchMoved:Connect(function(p21, _) --[[ Line: 164 ]]
        -- upvalues: u9 (copy), u13 (ref), u19 (copy)
        if p21 == u9.moveTouchObject then
            u13 = Vector2.new(u9.thumbstickFrame.AbsolutePosition.x + u9.thumbstickFrame.AbsoluteSize.x / 2, u9.thumbstickFrame.AbsolutePosition.y + u9.thumbstickFrame.AbsoluteSize.y / 2);
            local v22 = Vector2.new(p21.Position.x - u13.x, p21.Position.y - u13.y) / (u9.thumbstickSize / 2);
            local l__magnitude__5 = v22.magnitude;
            local v23;
            if l__magnitude__5 < 0.05 then
                v23 = Vector3.new();
            else
                local v24 = v22.unit * ((l__magnitude__5 - 0.05) / 0.95);
                v23 = Vector3.new(v24.x, 0, v24.y);
            end;
            u9.moveVector = v23;
            u19(p21.Position);
        end;
    end);
    u9.onTouchEndedConn = l__UserInputService__2.TouchEnded:Connect(function(p25, _) --[[ Line: 174 ]]
        -- upvalues: u9 (copy)
        if p25 == u9.moveTouchObject then
            u9:OnInputEnded();
        end;
    end);
    l__GuiService__1.MenuOpened:Connect(function() --[[ Line: 180 ]]
        -- upvalues: u9 (copy)
        if u9.moveTouchObject then
            u9:OnInputEnded();
        end;
    end);
    u9.thumbstickFrame.Parent = p10;
end;
return u1;
