-- Decompiled from: .ChillArrow26.PlayerScripts.PlayerModule.ControlModule.DynamicThumbstick
-- Class: ModuleScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__Value__1 = Enum.ContextActionPriority.High.Value;
local u1 = {
    0.10999999999999999,
    0.30000000000000004,
    0.4,
    0.5,
    0.6,
    0.7,
    0.75
};
local u2 = #u1;
local u3 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local l__Players__2 = game:GetService("Players");
local l__GuiService__3 = game:GetService("GuiService");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__ContextActionService__5 = game:GetService("ContextActionService");
local l__RunService__6 = game:GetService("RunService");
local l__TweenService__7 = game:GetService("TweenService");
local l__LocalPlayer__8 = l__Players__2.LocalPlayer;
if not l__LocalPlayer__8 then
    l__Players__2:GetPropertyChangedSignal("LocalPlayer"):Wait();
    l__LocalPlayer__8 = l__Players__2.LocalPlayer;
end;
local l__BaseCharacterController__9 = require(script.Parent:WaitForChild("BaseCharacterController"));
local u4 = setmetatable({}, l__BaseCharacterController__9);
u4.__index = u4;
function u4.new() --[[ Line: 44 ]]
    -- upvalues: l__BaseCharacterController__9 (copy), u4 (copy)
    local v5 = l__BaseCharacterController__9.new();
    local v6 = setmetatable(v5, u4);
    v6.moveTouchObject = nil;
    v6.moveTouchLockedIn = false;
    v6.moveTouchFirstChanged = false;
    v6.moveTouchStartPosition = nil;
    v6.startImage = nil;
    v6.endImage = nil;
    v6.middleImages = {};
    v6.startImageFadeTween = nil;
    v6.endImageFadeTween = nil;
    v6.middleImageFadeTweens = {};
    v6.isFirstTouch = true;
    v6.thumbstickFrame = nil;
    v6.onRenderSteppedConn = nil;
    v6.fadeInAndOutBalance = 0.5;
    v6.fadeInAndOutHalfDuration = 0.3;
    v6.hasFadedBackgroundInPortrait = false;
    v6.hasFadedBackgroundInLandscape = false;
    v6.tweenInAlphaStart = nil;
    v6.tweenOutAlphaStart = nil;
    return v6;
end;
function u4.GetIsJumping(p7) --[[ Line: 79 ]]
    local l__isJumping__10 = p7.isJumping;
    p7.isJumping = false;
    return l__isJumping__10;
end;
function u4.Enable(p8, p9, p10) --[[ Line: 85 ]]
    -- upvalues: l__ContextActionService__5 (copy)
    if p9 == nil then
        return false;
    end;
    local v11 = p9 and true or false;
    if p8.enabled == v11 then
        return true;
    end;
    if v11 then
        if not p8.thumbstickFrame then
            p8:Create(p10);
        end;
        p8:BindContextActions();
    else
        l__ContextActionService__5:UnbindAction("DynamicThumbstickAction");
        p8:OnInputEnded();
    end;
    p8.enabled = v11;
    p8.thumbstickFrame.Visible = v11;
end;
function u4.OnInputEnded(p12) --[[ Line: 108 ]]
    p12.moveTouchObject = nil;
    p12.moveVector = Vector3.new(0, 0, 0);
    p12:FadeThumbstick(false);
end;
function u4.FadeThumbstick(p13, p14) --[[ Line: 114 ]]
    -- upvalues: l__TweenService__7 (copy), u3 (copy), u1 (copy)
    if p14 or not p13.moveTouchObject then
        if p13.isFirstTouch then
        else
            if p13.startImageFadeTween then
                p13.startImageFadeTween:Cancel();
            end;
            if p13.endImageFadeTween then
                p13.endImageFadeTween:Cancel();
            end;
            for v15 = 1, #p13.middleImages do
                if p13.middleImageFadeTweens[v15] then
                    p13.middleImageFadeTweens[v15]:Cancel();
                end;
            end;
            if p14 then
                p13.startImageFadeTween = l__TweenService__7:Create(p13.startImage, u3, {
                    ImageTransparency = 0
                });
                p13.startImageFadeTween:Play();
                p13.endImageFadeTween = l__TweenService__7:Create(p13.endImage, u3, {
                    ImageTransparency = 0.2
                });
                p13.endImageFadeTween:Play();
                for v16 = 1, #p13.middleImages do
                    p13.middleImageFadeTweens[v16] = l__TweenService__7:Create(p13.middleImages[v16], u3, {
                        ImageTransparency = u1[v16]
                    });
                    p13.middleImageFadeTweens[v16]:Play();
                end;
            else
                p13.startImageFadeTween = l__TweenService__7:Create(p13.startImage, u3, {
                    ImageTransparency = 1
                });
                p13.startImageFadeTween:Play();
                p13.endImageFadeTween = l__TweenService__7:Create(p13.endImage, u3, {
                    ImageTransparency = 1
                });
                p13.endImageFadeTween:Play();
                for v17 = 1, #p13.middleImages do
                    p13.middleImageFadeTweens[v17] = l__TweenService__7:Create(p13.middleImages[v17], u3, {
                        ImageTransparency = 1
                    });
                    p13.middleImageFadeTweens[v17]:Play();
                end;
            end;
        end;
    end;
end;
function u4.FadeThumbstickFrame(p18, p19, p20) --[[ Line: 157 ]]
    p18.fadeInAndOutHalfDuration = p19 * 0.5;
    p18.fadeInAndOutBalance = p20;
    p18.tweenInAlphaStart = tick();
end;
function u4.InputInFrame(p21, p22) --[[ Line: 163 ]]
    local l__AbsolutePosition__11 = p21.thumbstickFrame.AbsolutePosition;
    local v23 = l__AbsolutePosition__11 + p21.thumbstickFrame.AbsoluteSize;
    local l__Position__12 = p22.Position;
    return l__Position__12.X >= l__AbsolutePosition__11.X and (l__Position__12.Y >= l__AbsolutePosition__11.Y and (l__Position__12.X <= v23.X and l__Position__12.Y <= v23.Y));
end;
function u4.DoFadeInBackground(p24) --[[ Line: 175 ]]
    -- upvalues: l__LocalPlayer__8 (ref)
    local v25 = l__LocalPlayer__8:FindFirstChildOfClass("PlayerGui");
    local v26 = false;
    if v25 then
        if v25.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or v25.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
            v26 = p24.hasFadedBackgroundInLandscape;
            p24.hasFadedBackgroundInLandscape = true;
        elseif v25.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
            v26 = p24.hasFadedBackgroundInPortrait;
            p24.hasFadedBackgroundInPortrait = true;
        end;
    end;
    if not v26 then
        p24.fadeInAndOutHalfDuration = 0.3;
        p24.fadeInAndOutBalance = 0.5;
        p24.tweenInAlphaStart = tick();
    end;
end;
function u4.DoMove(p27, p28) --[[ Line: 198 ]]
    local v29;
    if p28.magnitude < p27.radiusOfDeadZone then
        v29 = Vector3.new(0, 0, 0);
    else
        local v30 = p28.unit * (1 - math.max(0, (p27.radiusOfMaxSpeed - p28.magnitude) / p27.radiusOfMaxSpeed));
        v29 = Vector3.new(v30.x, 0, v30.y);
    end;
    p27.moveVector = v29;
end;
function u4.LayoutMiddleImages(p31, p32, p33) --[[ Line: 216 ]]
    -- upvalues: u2 (copy)
    local v34 = p31.thumbstickSize / 2 + p31.middleSize;
    local v35 = p33 - p32;
    local v36 = v35.magnitude - p31.thumbstickRingSize / 2 - p31.middleSize;
    local l__unit__13 = v35.unit;
    local v37 = p31.middleSpacing * u2;
    local l__middleSpacing__14 = p31.middleSpacing;
    if v37 < v36 then
        l__middleSpacing__14 = v36 / u2;
    end;
    for v38 = 1, u2 do
        local v39 = p31.middleImages[v38];
        local v40 = v34 + l__middleSpacing__14 * (v38 - 2);
        local v41 = v34 + l__middleSpacing__14 * (v38 - 1);
        if v40 < v36 then
            local v42 = p33 - l__unit__13 * v41;
            local v43 = math.clamp(1 - (v41 - v36) / l__middleSpacing__14, 0, 1);
            v39.Visible = true;
            v39.Position = UDim2.new(0, v42.X, 0, v42.Y);
            v39.Size = UDim2.new(0, p31.middleSize * v43, 0, p31.middleSize * v43);
        else
            v39.Visible = false;
        end;
    end;
end;
function u4.MoveStick(p44, p45) --[[ Line: 247 ]]
    local v46 = Vector2.new(p44.moveTouchStartPosition.X, p44.moveTouchStartPosition.Y) - p44.thumbstickFrame.AbsolutePosition;
    local v47 = Vector2.new(p45.X, p45.Y) - p44.thumbstickFrame.AbsolutePosition;
    p44.endImage.Position = UDim2.new(0, v47.X, 0, v47.Y);
    p44:LayoutMiddleImages(v46, v47);
end;
function u4.BindContextActions(u48) --[[ Line: 255 ]]
    -- upvalues: l__TweenService__7 (copy), l__ContextActionService__5 (copy), l__Value__1 (copy)
    local function u51(p49) --[[ Line: 256 ]]
        -- upvalues: u48 (copy), l__TweenService__7 (ref)
        if u48.moveTouchObject then
            return Enum.ContextActionResult.Pass;
        end;
        if not u48:InputInFrame(p49) then
            return Enum.ContextActionResult.Pass;
        end;
        if u48.isFirstTouch then
            u48.isFirstTouch = false;
            local v50 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
            l__TweenService__7:Create(u48.startImage, v50, {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play();
            l__TweenService__7:Create(u48.endImage, v50, {
                Size = UDim2.new(0, u48.thumbstickSize, 0, u48.thumbstickSize),
                ImageColor3 = Color3.new(0, 0, 0)
            }):Play();
        end;
        u48.moveTouchLockedIn = false;
        u48.moveTouchObject = p49;
        u48.moveTouchStartPosition = p49.Position;
        u48.moveTouchFirstChanged = true;
        u48:DoFadeInBackground();
        return Enum.ContextActionResult.Pass;
    end;
    local function u55(p52) --[[ Line: 288 ]]
        -- upvalues: u48 (copy)
        if p52 ~= u48.moveTouchObject then
            return Enum.ContextActionResult.Pass;
        end;
        if u48.moveTouchFirstChanged then
            u48.moveTouchFirstChanged = false;
            local v53 = Vector2.new(p52.Position.X - u48.thumbstickFrame.AbsolutePosition.X, p52.Position.Y - u48.thumbstickFrame.AbsolutePosition.Y);
            u48.startImage.Visible = true;
            u48.startImage.Position = UDim2.new(0, v53.X, 0, v53.Y);
            u48.endImage.Visible = true;
            u48.endImage.Position = u48.startImage.Position;
            u48:FadeThumbstick(true);
            u48:MoveStick(p52.Position);
        end;
        u48.moveTouchLockedIn = true;
        local v54 = Vector2.new(p52.Position.x - u48.moveTouchStartPosition.x, p52.Position.y - u48.moveTouchStartPosition.y);
        if math.abs(v54.x) > 0 or math.abs(v54.y) > 0 then
            u48:DoMove(v54);
            u48:MoveStick(p52.Position);
        end;
        return Enum.ContextActionResult.Sink;
    end;
    l__ContextActionService__5:BindActionAtPriority("DynamicThumbstickAction", function(_, p56, p57) --[[ Name: handleInput, Line 331 ]]
        -- upvalues: u51 (copy), u55 (copy), u48 (copy)
        if p56 == Enum.UserInputState.Begin then
            return u51(p57);
        end;
        if p56 == Enum.UserInputState.Change then
            return u55(p57);
        end;
        if p56 == Enum.UserInputState.End then
            if p57 == u48.moveTouchObject then
                u48:OnInputEnded();
                if u48.moveTouchLockedIn then
                    return Enum.ContextActionResult.Sink;
                end;
            end;
            return Enum.ContextActionResult.Pass;
        end;
        if p56 == Enum.UserInputState.Cancel then
            u48:OnInputEnded();
        end;
    end, false, l__Value__1, Enum.UserInputType.Touch);
end;
function u4.Create(u58, p59) --[[ Line: 351 ]]
    -- upvalues: u2 (copy), u1 (copy), l__RunService__6 (copy), l__UserInputService__4 (copy), l__GuiService__3 (copy), l__LocalPlayer__8 (ref)
    if u58.thumbstickFrame then
        u58.thumbstickFrame:Destroy();
        u58.thumbstickFrame = nil;
        if u58.onRenderSteppedConn then
            u58.onRenderSteppedConn:Disconnect();
            u58.onRenderSteppedConn = nil;
        end;
    end;
    u58.thumbstickSize = 45;
    u58.thumbstickRingSize = 20;
    u58.middleSize = 10;
    u58.middleSpacing = u58.middleSize + 4;
    u58.radiusOfDeadZone = 2;
    u58.radiusOfMaxSpeed = 20;
    local l__AbsoluteSize__15 = p59.AbsoluteSize;
    if math.min(l__AbsoluteSize__15.x, l__AbsoluteSize__15.y) > 500 then
        u58.thumbstickSize = u58.thumbstickSize * 2;
        u58.thumbstickRingSize = u58.thumbstickRingSize * 2;
        u58.middleSize = u58.middleSize * 2;
        u58.middleSpacing = u58.middleSpacing * 2;
        u58.radiusOfDeadZone = u58.radiusOfDeadZone * 2;
        u58.radiusOfMaxSpeed = u58.radiusOfMaxSpeed * 2;
    end;
    u58.thumbstickFrame = Instance.new("Frame");
    u58.thumbstickFrame.BorderSizePixel = 0;
    u58.thumbstickFrame.Name = "DynamicThumbstickFrame";
    u58.thumbstickFrame.Visible = false;
    u58.thumbstickFrame.BackgroundTransparency = 1;
    u58.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    u58.thumbstickFrame.Active = false;
    u58.thumbstickFrame.Size = UDim2.new(0.4, 0, 0.6666666666666666, 0);
    u58.thumbstickFrame.Position = UDim2.new(0, 0, 0.3333333333333333, 0);
    u58.startImage = Instance.new("ImageLabel");
    u58.startImage.Name = "ThumbstickStart";
    u58.startImage.Visible = true;
    u58.startImage.BackgroundTransparency = 1;
    u58.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
    u58.startImage.ImageRectOffset = Vector2.new(1, 1);
    u58.startImage.ImageRectSize = Vector2.new(144, 144);
    u58.startImage.ImageColor3 = Color3.new(0, 0, 0);
    u58.startImage.AnchorPoint = Vector2.new(0.5, 0.5);
    u58.startImage.Position = UDim2.new(0, u58.thumbstickRingSize * 3.3, 1, -u58.thumbstickRingSize * 2.8);
    u58.startImage.Size = UDim2.new(0, u58.thumbstickRingSize * 3.7, 0, u58.thumbstickRingSize * 3.7);
    u58.startImage.ZIndex = 10;
    u58.startImage.Parent = u58.thumbstickFrame;
    u58.endImage = Instance.new("ImageLabel");
    u58.endImage.Name = "ThumbstickEnd";
    u58.endImage.Visible = true;
    u58.endImage.BackgroundTransparency = 1;
    u58.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
    u58.endImage.ImageRectOffset = Vector2.new(1, 1);
    u58.endImage.ImageRectSize = Vector2.new(144, 144);
    u58.endImage.AnchorPoint = Vector2.new(0.5, 0.5);
    u58.endImage.Position = u58.startImage.Position;
    u58.endImage.Size = UDim2.new(0, u58.thumbstickSize * 0.8, 0, u58.thumbstickSize * 0.8);
    u58.endImage.ZIndex = 10;
    u58.endImage.Parent = u58.thumbstickFrame;
    local function u61(p60) --[[ Line: 379 ]]
        -- upvalues: u58 (copy)
        if p60 then
            u58.thumbstickFrame.Size = UDim2.new(1, 0, 0.4, 0);
            u58.thumbstickFrame.Position = UDim2.new(0, 0, 0.6, 0);
        else
            u58.thumbstickFrame.Size = UDim2.new(0.4, 0, 0.6666666666666666, 0);
            u58.thumbstickFrame.Position = UDim2.new(0, 0, 0.3333333333333333, 0);
        end;
    end;
    for v62 = 1, u2 do
        u58.middleImages[v62] = Instance.new("ImageLabel");
        u58.middleImages[v62].Name = "ThumbstickMiddle";
        u58.middleImages[v62].Visible = false;
        u58.middleImages[v62].BackgroundTransparency = 1;
        u58.middleImages[v62].Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
        u58.middleImages[v62].ImageRectOffset = Vector2.new(1, 1);
        u58.middleImages[v62].ImageRectSize = Vector2.new(144, 144);
        u58.middleImages[v62].ImageTransparency = u1[v62];
        u58.middleImages[v62].AnchorPoint = Vector2.new(0.5, 0.5);
        u58.middleImages[v62].ZIndex = 9;
        u58.middleImages[v62].Parent = u58.thumbstickFrame;
    end;
    local u63 = nil;
    local function v65() --[[ Line: 440 ]]
        -- upvalues: u63 (ref), u61 (copy)
        if u63 then
            u63:Disconnect();
            u63 = nil;
        end;
        local l__CurrentCamera__16 = workspace.CurrentCamera;
        if l__CurrentCamera__16 then
            local function v64() --[[ Line: 447 ]]
                -- upvalues: l__CurrentCamera__16 (copy), u61 (ref)
                local l__ViewportSize__17 = l__CurrentCamera__16.ViewportSize;
                u61(l__ViewportSize__17.X < l__ViewportSize__17.Y);
            end;
            u63 = l__CurrentCamera__16:GetPropertyChangedSignal("ViewportSize"):Connect(v64);
            local l__ViewportSize__18 = l__CurrentCamera__16.ViewportSize;
            u61(l__ViewportSize__18.X < l__ViewportSize__18.Y);
        end;
    end;
    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(v65);
    if workspace.CurrentCamera then
        v65();
    end;
    u58.moveTouchStartPosition = nil;
    u58.startImageFadeTween = nil;
    u58.endImageFadeTween = nil;
    u58.middleImageFadeTweens = {};
    u58.onRenderSteppedConn = l__RunService__6.RenderStepped:Connect(function() --[[ Line: 467 ]]
        -- upvalues: u58 (copy)
        if u58.tweenInAlphaStart == nil then
            if u58.tweenOutAlphaStart ~= nil then
                local v66 = tick() - u58.tweenOutAlphaStart;
                local v67 = u58.fadeInAndOutHalfDuration * 2 - u58.fadeInAndOutHalfDuration * 2 * u58.fadeInAndOutBalance;
                u58.thumbstickFrame.BackgroundTransparency = math.min(v66 / v67, 1) * 0.35 + 0.65;
                if v67 < v66 then
                    u58.tweenOutAlphaStart = nil;
                end;
            end;
        else
            local v68 = tick() - u58.tweenInAlphaStart;
            local v69 = u58.fadeInAndOutHalfDuration * 2 * u58.fadeInAndOutBalance;
            u58.thumbstickFrame.BackgroundTransparency = 1 - math.min(v68 / v69, 1) * 0.35;
            if v69 < v68 then
                u58.tweenOutAlphaStart = tick();
                u58.tweenInAlphaStart = nil;
            end;
        end;
    end);
    u58.onTouchEndedConn = l__UserInputService__4.TouchEnded:connect(function(p70) --[[ Line: 486 ]]
        -- upvalues: u58 (copy)
        if p70 == u58.moveTouchObject then
            u58:OnInputEnded();
        end;
    end);
    l__GuiService__3.MenuOpened:connect(function() --[[ Line: 492 ]]
        -- upvalues: u58 (copy)
        if u58.moveTouchObject then
            u58:OnInputEnded();
        end;
    end);
    local u71 = l__LocalPlayer__8:FindFirstChildOfClass("PlayerGui");
    while not u71 do
        l__LocalPlayer__8.ChildAdded:wait();
        u71 = l__LocalPlayer__8:FindFirstChildOfClass("PlayerGui");
    end;
    local u72 = nil;
    local u73 = u71.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft and true or u71.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight;
    local _ = u71:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(function() --[[ Line: 514 ]]
        -- upvalues: u73 (copy), u71 (ref), u72 (ref), u58 (copy)
        if u73 and u71.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait or not u73 and u71.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait then
            u72:disconnect();
            u58.fadeInAndOutHalfDuration = 2.5;
            u58.fadeInAndOutBalance = 0.05;
            u58.tweenInAlphaStart = tick();
            if u73 then
                u58.hasFadedBackgroundInPortrait = true;
                return;
            end;
            u58.hasFadedBackgroundInLandscape = true;
        end;
    end);
    u58.thumbstickFrame.Parent = p59;
    if game:IsLoaded() then
        u58.fadeInAndOutHalfDuration = 2.5;
        u58.fadeInAndOutBalance = 0.05;
        u58.tweenInAlphaStart = tick();
    else
        coroutine.wrap(function() --[[ Line: 534 ]]
            -- upvalues: u58 (copy)
            game.Loaded:Wait();
            u58.fadeInAndOutHalfDuration = 2.5;
            u58.fadeInAndOutBalance = 0.05;
            u58.tweenInAlphaStart = tick();
        end)();
    end;
end;
return u4;
