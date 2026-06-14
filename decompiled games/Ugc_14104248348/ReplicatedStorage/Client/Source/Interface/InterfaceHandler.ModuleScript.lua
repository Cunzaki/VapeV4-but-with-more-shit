-- Decompiled from: ReplicatedStorage.Client.Source.Interface.InterfaceHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__UserInputService__2 = game:GetService("UserInputService");
game:GetService("RunService");
local l__Players__3 = game:GetService("Players");
game:GetService("StarterGui");
local l__TweenService__4 = game:GetService("TweenService");
local l__PlayerGui__5 = l__Players__3.LocalPlayer:WaitForChild("PlayerGui");
local l__Signal__6 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__Mince__7 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Utility__8 = require(l__ReplicatedStorage__1.Modules.Utility);
local u1 = l__Mince__7:Get("SoundHandler");
local u2 = l__Mince__7:Get("BindManager");
local u3 = {
    ScalingSampleMode = "Y",
    UseUIScalingForButtons = true,
    TweenLast = true,
    TweenAway = true,
    WaitForAnimation = true,
    AboveTweenSwitch = false,
    TweenAboveOnHide = true,
    TweenAboveIfLast = true,
    IsFinished = true,
    VerticalOffset = 0.1,
    TargetScreenSize = Vector2.new(1689, 992),
    UIObjectQueue = {},
    GuiObjects = {},
    ObjectButtons = {},
    ObjectHovers = {},
    ScreenGuiConfigurations = {},
    Slider = {
        Sliders = {},
        Slidepads = {},
        Inputs = {
            PressEnum = l__Utility__8.CreateFuzzyFinder({ Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch }),
            ChangeEnum = l__Utility__8.CreateFuzzyFinder({ Enum.UserInputType.MouseMovement, Enum.UserInputType.Touch })
        }
    },
    ScreenShown = l__Signal__6.new(),
    Throw = error,
    Warn = warn,
    Print = print
};
function u3.GetScreenGui(p4) --[[ Line: 58 ]]
    -- upvalues: l__PlayerGui__5 (copy), u3 (copy)
    local v5 = l__PlayerGui__5:WaitForChild(p4);
    if v5 then
        return v5;
    end;
    u3.Throw("There is no UI by the name of \'" .. p4 .. "\'. ");
end;
function u3.GetTopUI() --[[ Line: 66 ]]
    -- upvalues: u3 (copy)
    local v6 = #u3.UIObjectQueue;
    return u3.UIObjectQueue[v6], v6;
end;
function u3.WaitUntilFinished() --[[ Line: 71 ]]
    -- upvalues: u3 (copy)
    repeat
        task.wait();
    until u3.IsFinished;
end;
function u3.EvaluateTweenMethod(p7) --[[ Line: 75 ]]
    -- upvalues: u3 (copy)
    local v8 = ((u3.TweenAboveIfLast ~= false or not u3.TweenAboveOnHide) and true or false) and (u3.TweenAboveIfLast and u3.TweenAboveOnHide);
    if v8 then
        v8 = #u3.UIObjectQueue > 0 and true or p7;
    end;
    return v8;
end;
function u3.Remove(p9) --[[ Line: 81 ]]
    -- upvalues: u3 (copy)
    local v10 = p9 or {};
    if #u3.UIObjectQueue > 0 then
        if not u3.IsFinished then
            return warn("Wasnt finished");
        end;
        u3.IsFinished = false;
        local u11, v12 = u3.GetTopUI();
        table.remove(u3.UIObjectQueue, v12);
        u11.Position = u11.Positions.Start;
        u11.IsActive = false;
        u11.Closed:Fire();
        if u3.TweenAway then
            local u13 = u3.EvaluateTweenMethod(v10.InsertingNext) and u11.Tweens.Above or u11.Tweens.Hidden;
            u13:Play();
            task.spawn(function() --[[ Line: 98 ]]
                -- upvalues: u13 (copy), u11 (copy), u3 (ref)
                u13.Completed:Wait();
                if not u11.IsActive then
                    u11.TweenFrame.Visible = false;
                end;
                u3.IsFinished = true;
            end);
        else
            u11.ScreenGui.Enabled = false;
            u3.IsFinished = true;
        end;
        if #u3.UIObjectQueue > 0 then
            if u3.WaitForAnimation then
                u3.WaitUntilFinished();
            end;
            local v14 = u3.GetTopUI();
            v14.TweenFrame.Position = v14.Positions.Below;
            v14.TweenFrame.Visible = true;
            v14.IsActive = true;
            v14.Opened:Fire();
            v14.Tweens.Default:Play();
        end;
    end;
end;
function u3.GetTopMost() --[[ Line: 125 ]]
    -- upvalues: u3 (copy)
    if #u3.UIObjectQueue > 0 then
        return u3.GetTopUI();
    end;
end;
function u3.SwitchLastUI(p15) --[[ Line: 132 ]]
    -- upvalues: u3 (copy)
    local v16 = #u3.UIObjectQueue;
    if v16 <= 1 then
        local v17 = v16 > 0;
        u3.Remove({
            InsertingNext = true
        });
        if u3.WaitForAnimation then
            u3.WaitUntilFinished();
        end;
        u3.AddUI(p15, {
            ManualRemoval = v17
        });
    else
        u3.Print("There are too many items within the stack to SwitchLast.", u3.UIObjectQueue);
    end;
end;
function u3.AddUI(p18, p19) --[[ Line: 146 ]]
    -- upvalues: u3 (copy)
    local v20 = p19 or {};
    if not u3.IsFinished then
        return warn("Wasnt finished");
    end;
    u3.IsFinished = false;
    local v21 = #u3.UIObjectQueue > 0;
    if v21 then
        local v22 = u3.GetTopUI();
        table.insert(u3.UIObjectQueue, p18);
        if u3.TweenLast then
            v22.IsActive = false;
            v22.Closed:Fire();
            v22.Position = v22.Positions.Start;
            if u3.TweenAway then
                local v23 = u3.EvaluateTweenMethod(v20.ManualRemoval) and v22.Tweens.Above or v22.Tweens.Hidden;
                v23:Play();
                if u3.WaitForAnimation then
                    v23.Completed:Wait();
                end;
                if not v22.IsActive then
                    v22.TweenFrame.Visible = false;
                end;
            elseif not v22.IsActive then
                v22.TweenFrame.Visible = false;
            end;
        end;
    else
        table.insert(u3.UIObjectQueue, p18);
    end;
    p18.IsActive = true;
    p18.Opened:Fire();
    p18.TweenFrame.Visible = true;
    p18.TweenFrame.Position = p18.Positions.Below;
    if u3.AboveTweenSwitch and (v21 or v20.ManualRemoval) then
        p18.TweenFrame.Position = p18.Positions.Above;
    end;
    p18.Tweens.Default:Play();
    u3.IsFinished = true;
end;
function u3.DoAnimation(u24) --[[ Line: 197 ]]
    -- upvalues: u3 (copy)
    if u3.AnimationThread then
        coroutine.close(u3.AnimationThread);
    end;
    u3.AnimationThread = coroutine.create(function() --[[ Line: 201 ]]
        -- upvalues: u24 (copy)
        if typeof(u24) == "function" then
            u24();
        end;
    end);
    coroutine.resume(u3.AnimationThread);
end;
function u3.PlaceBeyond(p25, p26, p27) --[[ Line: 210 ]]
    local v28 = p26 or 0.1;
    local v29 = p27 or p25.AnchorPoint;
    local v30 = 2 * (v29.X - 0.5);
    local v31 = 2 * (v29.Y - 0.5);
    local l__fromScale__9 = UDim2.fromScale;
    local l__Scale__10 = p25.Position.X.Scale;
    local v32 = l__Scale__10 + (v29.X - l__Scale__10) * v30 + v30 * (p25.Size.X.Scale + v28);
    local l__Scale__11 = p25.Position.Y.Scale;
    return l__fromScale__9(v32, l__Scale__11 + (v29.Y - l__Scale__11) * v31 + v31 * (p25.Size.Y.Scale + v28));
end;
function u3.Get(p33, p34) --[[ Line: 230 ]]
    -- upvalues: u3 (copy), l__Signal__6 (copy), l__TweenService__4 (copy)
    local v35 = typeof(p33);
    local v36 = nil;
    local v37 = nil;
    if v35 == "string" then
        local v38 = u3.GetScreenGui(p33);
        v36 = v38:FindFirstChild(p34 or "MainFrame") or (v38:FindFirstChild("Main") or v38:FindFirstChildWhichIsA("Frame") or (v38:FindFirstChildWhichIsA("ImageLabel") or v38:FindFirstChildWhichIsA("UIBase")));
        if p34 then
            p33 = p34 .. ":" .. p33;
        end;
    elseif v35 == "Instance" then
        if not p33:IsA("UIBase") then
            u3.Throw((`Instance type '{p33.ClassName}' is not allowed! It must be a 'UIBase'.`));
        end;
        local l__Name__12 = p33.Name;
        v36 = p33;
        p33 = l__Name__12;
    else
        u3.Throw("Interface");
        p33 = v37;
    end;
    local v39 = u3.GuiObjects[p33];
    if v39 then
        return v39;
    end;
    if not v36 then
        u3.Throw("There is no UI by the name of \'" .. p33 .. "\'. ");
        return nil;
    end;
    local u40 = {
        IsActive = false,
        PositionAfter = false,
        IsManuallyStacked = false,
        Name = p33,
        ScreenGui = v36:FindFirstAncestorWhichIsA("ScreenGui"),
        InTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        OutTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        TweenFrame = v36,
        Opened = l__Signal__6.new(),
        Closed = l__Signal__6.new(),
        Positions = {
            Start = v36.Position,
            Below = UDim2.new(v36.Position.X.Scale, 0, v36.Position.Y.Scale + u3.VerticalOffset, 0),
            Above = UDim2.new(v36.Position.X.Scale, 0, v36.Position.Y.Scale - u3.VerticalOffset, 0)
        }
    };
    local u41 = `{u40.ScreenGui.Name}[{u40.TweenFrame.Name}]`;
    u40.Opened:Connect(function() --[[ Line: 284 ]]
        -- upvalues: u3 (ref), u41 (copy)
        u3.ScreenShown:Fire(u41, true);
    end);
    u40.Closed:Connect(function() --[[ Line: 288 ]]
        -- upvalues: u3 (ref), u41 (copy)
        u3.ScreenShown:Fire(u41, false);
    end);
    function u40.CreateTweens() --[[ Line: 292 ]]
        -- upvalues: u40 (copy), l__TweenService__4 (ref)
        u40.Tweens = {
            Default = l__TweenService__4:Create(u40.TweenFrame, u40.InTweenInfo, {
                Position = u40.Positions.Start
            }),
            Hidden = l__TweenService__4:Create(u40.TweenFrame, u40.OutTweenInfo, {
                Position = u40.Positions.Below
            }),
            Above = l__TweenService__4:Create(u40.TweenFrame, u40.OutTweenInfo, {
                Position = u40.Positions.Above
            })
        };
    end;
    function u40.Stack(p42) --[[ Line: 306 ]]
        -- upvalues: u40 (copy), u3 (ref)
        if u40.IsManuallyStacked then
            return warn("You\'ve used Show() on this, it\'s not in the stack so you cannot use Close(),Trigger(),Stack() or Switch().");
        end;
        u40.Priority = p42;
        if u3.WaitForAnimation then
            u3.WaitUntilFinished();
        end;
        u3.AddUI(u40);
    end;
    function u40.Switch() --[[ Line: 317 ]]
        -- upvalues: u40 (copy), u3 (ref)
        if u40.IsManuallyStacked then
            return warn("You\'ve used Show() on this, it\'s not in the stack so you cannot use Close(),Trigger(),Stack() or Switch().");
        else
            local v43 = u3.GetTopMost();
            if v43 and v43.Priority then
                u3.Warn(("Cannot switch to %s because %s has priority"):format(v43.Name, v43.Name));
            elseif v43 == u40 then
                u3.Print("Preventing double stacking... Cannot switch when the topGuiObject is already shown.");
            else
                u3.SwitchLastUI(u40);
            end;
        end;
    end;
    function u40.Trigger() --[[ Line: 336 ]]
        -- upvalues: u40 (copy), u3 (ref)
        if u40.IsManuallyStacked then
            return warn("You\'ve used Show() on this, it\'s not in the stack so you cannot use Close(),Trigger(),Stack() or Switch().");
        elseif u40.IsActive then
            u3.Remove();
        else
            u40.Switch();
        end;
    end;
    u40.Open = u40.Switch;
    function u40.Close() --[[ Line: 349 ]]
        -- upvalues: u40 (copy), u3 (ref)
        if u40.IsManuallyStacked then
            warn("You\'ve used Show() on this, it\'s not in the stack so you cannot use Close(),Trigger(),Stack() or Switch().");
        else
            if u40.IsActive then
                u3.Remove();
            end;
        end;
    end;
    function u40.Show() --[[ Line: 359 ]]
        -- upvalues: u40 (copy)
        u40.IsManuallyStacked = true;
        u40.TweenFrame.Visible = true;
        if u40.PositionAfter then
            u40.TweenFrame.Position = u40.Positions.Start;
        end;
        u40.IsActive = true;
        u40.Opened:Fire();
    end;
    function u40.Hide() --[[ Line: 370 ]]
        -- upvalues: u40 (copy)
        u40.IsManuallyStacked = false;
        u40.TweenFrame.Visible = false;
        if u40.PositionAfter then
            u40.TweenFrame.Position = u40.Positions.Below;
        end;
        u40.IsActive = false;
        u40.Closed:Fire();
    end;
    function u40.SetEnabled(p44) --[[ Line: 381 ]]
        -- upvalues: u40 (copy)
        if p44 then
            u40.Show();
        else
            u40.Hide();
        end;
    end;
    u40.CreateTweens();
    if u40.TweenFrame.Visible then
        u40.Switch();
    end;
    u3.GuiObjects[p33] = u40;
    return u40;
end;
function u3.Push() --[[ Line: 397 ]]
    -- upvalues: u3 (copy), l__PlayerGui__5 (copy)
    u3.Pop();
    if not u3.PushObject then
        local v45 = Instance.new("ScreenGui", l__PlayerGui__5);
        v45.ResetOnSpawn = false;
        v45.Name = "__Push";
        local v46 = Instance.new("Frame", v45);
        v46.Name = "MainFrame";
        v46.Visible = false;
        u3.PushObject = u3.Get("__Push");
    end;
    u3.GetTopMost();
    if u3.GetTopMost() ~= u3.PushObject then
        u3.PushObject.Stack(true);
    end;
end;
function u3.Pop() --[[ Line: 415 ]]
    -- upvalues: u3 (copy)
    if u3.PushObject then
        u3.PushObject.Close();
    end;
end;
function u3.NewButton(p47, u48) --[[ Line: 423 ]]
    -- upvalues: u3 (copy), l__Signal__6 (copy), u1 (copy), l__TweenService__4 (copy), l__UserInputService__2 (copy)
    local u49 = not p47 and u48;
    if u49 then
        u49 = u48.Button;
    end;
    assert(u49 ~= nil, "[1], or [2]ButtonParams.Button is required.");
    local v50 = u3.ObjectButtons[u49];
    if v50 then
        return v50;
    end;
    if p47:IsA("Frame") then
        u48 = u48 or {};
        if u48.TweenFrame == nil then
            u48.TweenFrame = p47:FindFirstChild("Button") or p47:FindFirstChildWhichIsA("GuiButton");
            u49 = u48.TweenFrame;
        end;
    end;
    local u51 = l__Signal__6.new();
    local u52 = l__Signal__6.new();
    local u53 = {
        Tween = true
    };
    local v54;
    if u48 then
        v54 = u48.Frame or u49;
    else
        v54 = u49;
    end;
    u53.TweenFrame = v54;
    u53.TweenInfo = u48 and u48.TweenInfo or TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u53.AutoAdjustOffset = u48 and (u48.AutoAdjustOffset or true) or true;
    u53.Offset = u48 and u48.Offset or UDim2.new(0.1, 0, 0.1, 0);
    u53.Button = u49;
    u53.Activated = u51;
    u53.Triggered = u52;
    u53.On = {
        Enter = u49.MouseEnter,
        Leave = u49.MouseLeave,
        Down = u49.MouseButton1Down,
        Up = u49.MouseButton1Up
    };
    u53.StateColors = {
        Disabled = {
            Color = Color3.new(0.619608, 0.619608, 0.619608),
            Stroke = Color3.new(0.329412, 0.329412, 0.329412)
        }
    };
    local u55 = u53.TweenFrame:FindFirstChild("UIStroke");
    function u53.SetState(p56) --[[ Line: 466 ]]
        -- upvalues: u53 (ref), u55 (copy)
        if u53.State == nil and not u53.StateColors.Default then
            local l__StateColors__13 = u53.StateColors;
            local v57 = {
                Color = u53.TweenFrame.BackgroundColor3
            };
            local v58 = u55;
            if v58 then
                v58 = u55.Color;
            end;
            v57.Stroke = v58;
            l__StateColors__13.Default = v57;
        end;
        local v59 = u53.StateColors[p56];
        if v59 then
            u53.TweenFrame.BackgroundColor3 = v59.Color;
            if u55 then
                u55.Color = v59.Stroke;
            end;
        end;
        u53.Button.AutoButtonColor = p56 == "Default";
        u53.Tween = p56 == "Default";
    end;
    function u53.ConnectButton(p60) --[[ Line: 486 ]]
        -- upvalues: u53 (ref), u1 (ref), u51 (copy)
        p60.MouseButton1Down:Connect(function() --[[ Line: 487 ]]
            -- upvalues: u53 (ref), u1 (ref)
            if u53.Tween then
                u1.PlaySound("uiclickdown");
                u53.Tweens.Press:Play();
            end;
        end);
        p60.MouseButton1Up:Connect(function(p61, p62) --[[ Line: 493 ]]
            -- upvalues: u53 (ref), u1 (ref), u51 (ref)
            if u53.Tween then
                u53.Tweens.Default:Play();
                u1.PlaySound("uiclickup");
                u51:Fire(Vector2.new(p61, p62));
            end;
        end);
    end;
    function u53.Destroy() --[[ Line: 504 ]]
        -- upvalues: u51 (copy), u3 (ref), u49 (ref), u53 (ref)
        u51:Destroy();
        u3.ObjectButtons[u49] = nil;
        u53 = nil;
    end;
    if u53.AutoAdjustOffset then
        local v63 = u48 and (u48.Mult or 0.07142857142857142) or 0.07142857142857142;
        u53.Offset = UDim2.new(u53.TweenFrame.Size.X.Scale * v63, u53.TweenFrame.Size.X.Offset * v63, u53.TweenFrame.Size.Y.Scale * v63, u53.TweenFrame.Size.Y.Offset * v63);
    end;
    (function() --[[ Line: 521 ]]
        -- upvalues: u3 (ref), u48 (ref), u53 (ref), l__TweenService__4 (ref)
        if u3.UseUIScalingForButtons then
            local v64 = u48 and u48.Multiplier or (u48 and u48.Mult or 0.07142857142857142) / 0.07142857142857142 * 1 / 14;
            local v65 = Instance.new("UIScale", u53.TweenFrame);
            u53.Tweens = {
                Hover = l__TweenService__4:Create(v65, u53.TweenInfo, {
                    Scale = 1 + v64
                }),
                Press = l__TweenService__4:Create(v65, u53.TweenInfo, {
                    Scale = 1 - v64
                }),
                Default = l__TweenService__4:Create(v65, u53.TweenInfo, {
                    Scale = 1
                })
            };
        else
            u53.Tweens = {
                Hover = l__TweenService__4:Create(u53.TweenFrame, u53.TweenInfo, {
                    Size = u53.TweenFrame.Size + u53.Offset
                }),
                Press = l__TweenService__4:Create(u53.TweenFrame, u53.TweenInfo, {
                    Size = u53.TweenFrame.Size - u53.Offset
                }),
                Default = l__TweenService__4:Create(u53.TweenFrame, u53.TweenInfo, {
                    Size = u53.TweenFrame.Size
                })
            };
        end;
    end)();
    u53.Button.MouseEnter:Connect(function() --[[ Line: 555 ]]
        -- upvalues: u53 (ref), u1 (ref)
        if u53.Tween then
            u53.Tweens.Hover:Play();
            u1.PlaySound("uibuttonhover");
        end;
    end);
    u53.Button.MouseLeave:Connect(function() --[[ Line: 562 ]]
        -- upvalues: u53 (ref)
        if u53.Tween then
            u53.Tweens.Default:Play();
        end;
    end);
    u53.Button.MouseButton1Down:Connect(function() --[[ Line: 567 ]]
        -- upvalues: u53 (ref), u1 (ref)
        if u53.Tween then
            u1.PlaySound("uiclickdown");
            u53.Tweens.Press:Play();
        end;
    end);
    u53.Button.MouseButton1Up:Connect(function(p66, p67) --[[ Line: 573 ]]
        -- upvalues: u53 (ref), u1 (ref), u52 (copy), u51 (copy)
        if u53.Tween then
            u53.Tweens.Default:Play();
            u1.PlaySound("uiclickup");
            u52:Fire(Vector2.new(p66, p67));
            u51:Fire(Vector2.new(p66, p67));
        end;
    end);
    u53.Button.Activated:Connect(function(p68, p69) --[[ Line: 584 ]]
        -- upvalues: l__UserInputService__2 (ref), u52 (copy)
        if l__UserInputService__2.TouchEnabled then
            u52:Fire(Vector2.new(p68, p69));
        end;
    end);
    u3.ObjectButtons[u49] = u53;
    u49.Destroying:Connect(function() --[[ Line: 592 ]]
        -- upvalues: u53 (ref)
        u53:Destroy();
    end);
    return u53;
end;
function DomAxis(p70, p71, p72)
    if p70 == "X" then
        return UDim2.fromScale(p71, p72);
    end;
    if p70 == "Y" then
        return UDim2.fromScale(p72, p71);
    end;
    error((`Invalid Axis '{p70}'! DomAxis() `));
end;
function u3.NewSlider(u73, p74) --[[ Line: 613 ]]
    -- upvalues: u3 (copy), l__Signal__6 (copy)
    local u75 = p74 or "X";
    local v76 = u3.Slider.Sliders[u73];
    if v76 then
        return v76;
    end;
    local u77 = {
        Targeted = false,
        Step = 0.01,
        Padding = 0,
        Changed = l__Signal__6.new(),
        Axis = u75
    };
    local _ = u73.Slide;
    local l__Button__14 = u73.Button;
    function u77.SetPosition(p78) --[[ Line: 634 ]]
        -- upvalues: u77 (copy), u73 (copy), u75 (copy)
        local v79 = math.clamp(p78, 0, 1);
        local _ = 1 - u77.Padding;
        u73.Button.Position = DomAxis(u75, v79, 0.5);
        u73.Slide.Size = DomAxis(u75, v79, 1);
        u77.Changed:Fire(v79);
    end;
    l__Button__14.MouseButton1Down:Connect(function(_, _) --[[ Line: 630 ]]
        -- upvalues: u77 (copy)
        u77.Targeted = true;
    end);
    u3.Slider.Sliders[u73] = u77;
    return u77;
end;
function u3.NewSlidepad(u80, _) --[[ Line: 654 ]]
    -- upvalues: u3 (copy), l__Signal__6 (copy)
    local v81 = u3.Slider.Slidepads[u80];
    if v81 then
        return v81;
    end;
    local u83 = {
        Targeted = false,
        Changed = l__Signal__6.new(),
        SetPosition = function(p82) --[[ Line: 665 ]]
            -- upvalues: u80 (copy)
            u80.Point.Position = UDim2.fromScale(p82.X, p82.Y);
        end
    };
    local _ = u80.Point;
    u80.MouseButton1Down:Connect(function(p84, p85) --[[ Line: 673 ]]
        -- upvalues: u80 (copy), u3 (ref), u83 (copy)
        local v86 = Vector2.new(p84, p85);
        u80.Point.Position = UDim2.fromScale(math.clamp((v86.X - u80.AbsolutePosition.X) / u80.AbsoluteSize.X, 0, 1), (math.clamp((v86.Y - u80.AbsolutePosition.Y) / u80.AbsoluteSize.Y, 0, 1))) - UDim2.fromOffset(0, u3.GuiInsetSize);
        u83.Targeted = true;
        u83.Changed:Fire(Vector2.new(u80.Point.Position.X.Scale, u80.Point.Position.Y.Scale));
    end);
    u3.Slider.Slidepads[u80] = u83;
    return u83;
end;
function u3.InputEnded(p87) --[[ Line: 696 ]]
    -- upvalues: u3 (copy)
    if u3.Slider.Inputs.PressEnum[p87.UserInputType] then
        local _ = p87.Position;
        for _, v88 in pairs(u3.Slider.Sliders) do
            if v88.Targeted then
                v88.Targeted = false;
            end;
        end;
        for _, v89 in u3.Slider.Slidepads do
            if v89.Targeted then
                v89.Targeted = false;
            end;
        end;
    end;
end;
function u3.InputChanged(p90) --[[ Line: 713 ]]
    -- upvalues: u3 (copy)
    if u3.Slider.Inputs.ChangeEnum[p90.UserInputType] then
        local l__Position__15 = p90.Position;
        for v91, v92 in pairs(u3.Slider.Sliders) do
            if v92.Targeted then
                local v93 = l__Position__15[v92.Axis] or 0;
                local v94 = 1 / v92.Step;
                local v95;
                if v92.step == 0 then
                    v95 = math.clamp((v93 - v91.AbsolutePosition[v92.Axis]) / v91.AbsoluteSize[v92.Axis], 0, 1);
                else
                    local v96 = math.clamp((v93 - v91.AbsolutePosition[v92.Axis]) / v91.AbsoluteSize[v92.Axis], 0, 1) * v94;
                    v95 = math.round(v96) / v94;
                end;
                local _ = 1 - v92.Padding;
                v91.Button.Position = DomAxis(v92.Axis, v95, 0.5);
                v91.Slide.Size = DomAxis(v92.Axis, v95, 1);
                v92.Changed:Fire(v95);
            end;
        end;
        for v97, v98 in u3.Slider.Slidepads do
            if v98.Targeted then
                v97.Point.Position = UDim2.fromScale(math.clamp((p90.Position.X - v97.AbsolutePosition.X) / v97.AbsoluteSize.X, 0, 1), (math.clamp((p90.Position.Y - v97.AbsolutePosition.Y) / v97.AbsoluteSize.Y, 0, 1)));
                v98.Changed:Fire(Vector2.new(v97.Point.Position.X.Scale, v97.Point.Position.Y.Scale));
            end;
        end;
    end;
end;
function u3.GetScreenGuiConfiguration(p99) --[[ Line: 754 ]]
    -- upvalues: u3 (copy)
    local v100 = u3.ScreenGuiConfigurations[p99];
    if not v100 then
        local u101 = {
            StrokeUpdateStack = {},
            OrginalsMemory = {}
        };
        p99:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 762 ]]
            -- upvalues: u101 (ref)
            for _, v102 in u101.StrokeUpdateStack do
                v102();
            end;
        end);
        v100 = u101;
    end;
    return v100;
end;
function u3.SizeScrollingFrame(u103, p104, p105) --[[ Line: 773 ]]
    local v106 = p104 or { "Y" };
    local v107 = {
        X = 0,
        Y = 0
    };
    local v108 = u103:FindFirstChildWhichIsA("UIListLayout");
    if v108 and not p105 then
        for _, v109 in v106 do
            v107[v109] = v108.AbsoluteContentSize[v109];
        end;
        u103.CanvasSize = UDim2.fromOffset(v107.X, v107.Y);
    else
        local function v114(p110) --[[ Line: 786 ]]
            -- upvalues: u103 (copy)
            local v111 = -1;
            for _, v112 in u103:GetChildren() do
                if v112:IsA("GuiObject") and v111 < v112.AbsolutePosition[p110] then
                    v111 = v112.AbsolutePosition[p110] + v112.AbsoluteSize[p110] * v112.AnchorPoint[p110];
                end;
            end;
            local v113 = math.max(v111 / u103.AbsoluteSize[p110], 0);
            return v113 < 1 and 0 or v113;
        end;
        local v115 = {
            X = 0,
            Y = 0
        };
        for _, v116 in v106 do
            v115[v116] = v114(v116);
        end;
        u103.CanvasSize = UDim2.fromScale(v115.X, v115.Y);
    end;
end;
function u3.AutoSizeScrollingFrame(u117, u118, u119) --[[ Line: 808 ]]
    -- upvalues: u3 (copy)
    local function v120() --[[ Line: 809 ]]
        -- upvalues: u3 (ref), u117 (copy), u118 (copy), u119 (copy)
        u3.SizeScrollingFrame(u117, u118, u119);
    end;
    task.defer(v120);
    return v120, {
        ChildAdded = u117.ChildAdded:Connect(v120),
        SizeChanged = u117:GetPropertyChangedSignal("AbsoluteSize"):Connect(v120)
    };
end;
function u3.ScaleTextPercentageTextScaled(u121, u122) --[[ Line: 820 ]]
    u121.TextScaled = true;
    local u123 = Instance.new("UITextSizeConstraint");
    u123.MinTextSize = 0;
    u123.MaxTextSize = 100;
    u123.Parent = u121;
    local v124 = u121:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 828 ]]
        -- upvalues: u123 (copy), u121 (copy), u122 (copy)
        u123.MaxTextSize = u121.AbsoluteSize.X * (u122 or 0.05);
    end);
    u123.MaxTextSize = u121.AbsoluteSize.X * (u122 or 0.05);
    return v124;
end;
function u3.ScaleTextPercentage(u125, u126) --[[ Line: 837 ]]
    u125.TextScaled = false;
    u125:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 840 ]]
        -- upvalues: u125 (copy), u126 (copy)
        u125.TextSize = u125.AbsoluteSize.X * (u126 or 0.05);
    end);
    u125.TextSize = u125.AbsoluteSize.X * (u126 or 0.05);
end;
function u3.ColorButton(p127, p128) --[[ Line: 847 ]]
    p127.BackgroundColor3 = p128;
    local v129, v130, v131 = p128:ToHSV();
    p127.UIStroke.Color = Color3.fromHSV(v129, v130, v131 * 0.8);
end;
function u3.CreateUpdatorForStroke(u132, u133) --[[ Line: 854 ]]
    -- upvalues: u3 (copy)
    if not u132:GetAttribute("OrginalThickness") then
        u132:SetAttribute("OrginalThickness", u132.Thickness);
    end;
    local u134 = u132:GetAttribute("OrginalThickness");
    local function v139() --[[ Line: 860 ]]
        -- upvalues: u133 (copy), u3 (ref), u132 (copy), u134 (copy)
        local l__AbsoluteSize__16 = u133.AbsoluteSize;
        local v135 = 0;
        local v136 = 0;
        for v137 = 1, #u3.ScalingSampleMode do
            local v138 = u3.ScalingSampleMode:sub(v137, v137);
            v135 = v135 + l__AbsoluteSize__16[v138] / u3.TargetScreenSize[v138];
            v136 = v136 + 1;
        end;
        u132.Thickness = u134 * (v135 / v136);
    end;
    task.defer(v139);
    return v139;
end;
function u3.ScaleDescedantsStrokes(p140, p141) --[[ Line: 876 ]]
    -- upvalues: u3 (copy)
    local u142 = u3.GetScreenGuiConfiguration(p141 or p140:FindFirstAncestorWhichIsA("ScreenGui"));
    for _, u143 in p140:GetDescendants() do
        if u143:IsA("UIStroke") then
            table.insert(u142.StrokeUpdateStack, u3.CreateUpdatorForStroke(u143, p141));
            u143.Destroying:Connect(function() --[[ Line: 885 ]]
                -- upvalues: u142 (copy), u143 (copy)
                local v144 = table.find(u142.StrokeUpdateStack, u143);
                if v144 then
                    table.remove(u142.StrokeUpdateStack, v144);
                end;
            end);
        end;
    end;
end;
function u3.HandleNewPlayerScreenGui(p145) --[[ Line: 893 ]]
    -- upvalues: u3 (copy), u2 (copy)
    local u146 = p145:GetAttributes();
    u146.StrokeUpdateStack = {};
    u146.OrginalsMemory = {};
    if u146.AutoScaleStrokes then
        for _, v147 in p145:GetDescendants() do
            if v147:IsA("UIStroke") then
                table.insert(u146.StrokeUpdateStack, u3.CreateUpdatorForStroke(v147, p145));
            end;
        end;
    end;
    if u146.DisableOnRuntime then
        p145.Enabled = false;
    end;
    if u146.ChangeUponResizing then
        p145:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 913 ]]
            -- upvalues: u146 (copy)
            for _, v148 in u146.StrokeUpdateStack do
                v148();
            end;
        end);
    end;
    if u146.RescaleForMobile then
        local v149 = u146.MobileScaling or 1.5;
        for _, u150 in p145:GetChildren() do
            if u150:IsA("GuiObject") and not u150:GetAttribute("IgnoreScaling") then
                local u151 = UDim2.new(u150.Size.X.Scale * v149, u150.Size.X.Offset * v149, u150.Size.Y.Scale * v149, u150.Size.Y.Offset * v149);
                local l__Size__17 = u150.Size;
                local function v153(p152) --[[ Line: 934 ]]
                    -- upvalues: u150 (copy), u151 (copy), l__Size__17 (copy)
                    if p152 == "Mobile" then
                        u150.Size = u151;
                    else
                        u150.Size = l__Size__17;
                    end;
                end;
                if u2.CurrentMode == "Mobile" then
                    u150.Size = u151;
                else
                    u150.Size = l__Size__17;
                end;
                u2.ModeChanged:Connect(v153);
            end;
        end;
    end;
    u146.AutoScaleRatios = {};
    for _, u154 in p145:GetDescendants() do
        if u154:GetAttribute("AutoScaleLayout") and u154:IsA("UIListLayout") then
            local l__Parent__18 = u154.Parent;
            local _ = l__Parent__18.CanvasSize;
            local l__Scale__19 = l__Parent__18.CanvasSize.Y.Scale;
            local l__Scale__20 = u154.Padding.Scale;
            local function v159() --[[ Line: 960 ]]
                -- upvalues: l__Parent__18 (copy), l__Scale__19 (copy), u154 (copy), l__Scale__20 (copy)
                local v155 = 0;
                for _, v156 in l__Parent__18:GetChildren() do
                    if v156:IsA("GuiObject") and v156.Visible then
                        local v157 = v156.AbsolutePosition.Y + v156.AbsoluteSize.Y * v156.AnchorPoint.Y;
                        if v155 < v157 then
                            v155 = v157;
                        end;
                    end;
                end;
                local v158 = v155 / l__Parent__18.AbsoluteSize.Y;
                if v158 == v158 and (v158 ~= math.inf and l__Scale__19 < v158) then
                    l__Parent__18.CanvasSize = UDim2.fromScale(0, v158);
                    u154.Padding = UDim.new(l__Scale__20 * (1 / v158), 0);
                else
                    l__Parent__18.CanvasSize = UDim2.fromScale(0, l__Scale__19);
                    u154.Padding = UDim.new(l__Scale__20, 0);
                end;
            end;
            v159();
            l__Parent__18:SetAttribute("Update", 0.1);
            l__Parent__18:GetAttributeChangedSignal("Update"):Connect(v159);
        end;
        if u154:GetAttribute("ScaleToOffsetPadding") then
            local l__Parent__21 = u154.Parent;
            local l__Padding__22 = u154.Padding;
            local function v160() --[[ Line: 991 ]]
                -- upvalues: u154 (copy), l__Padding__22 (copy), l__Parent__21 (copy)
                u154.Padding = UDim.new(0, l__Padding__22.Scale * l__Parent__21.AbsoluteSize.X);
            end;
            task.defer(v160);
            l__Parent__21:GetPropertyChangedSignal("AbsoluteSize"):Connect(v160);
        end;
        if u154:GetAttribute("AutoScaleGrid") and u154:IsA("UIGridLayout") then
            local l__Parent__23 = u154.Parent;
            local u161 = u154.Parent:FindFirstChild("UIPadding");
            if u154 and (u161 and l__Parent__23) then
                local u162 = 0;
                for _, v163 in l__Parent__23:GetChildren() do
                    if v163:IsA("GuiObject") == false then
                        u162 = u162 + 1;
                    end;
                end;
                local l__CanvasSize__24 = l__Parent__23.CanvasSize;
                local l__PaddingTop__25 = u161.PaddingTop;
                local l__CellPadding__26 = u154.CellPadding;
                u161:SetAttribute("OrginalTop", l__PaddingTop__25.Scale);
                local function v168() --[[ Line: 1020 ]]
                    -- upvalues: l__Parent__23 (copy), u162 (ref), u154 (copy), u161 (copy), l__CanvasSize__24 (copy), l__CellPadding__26 (copy), l__PaddingTop__25 (copy)
                    local v164 = (#l__Parent__23:GetChildren() - u162) / u154.FillDirectionMaxCells;
                    local v165 = math.ceil(v164);
                    local v166 = math.max(l__Parent__23.AbsoluteCanvasSize.X * (1 - (u161.PaddingLeft.Scale + u161.PaddingRight.Scale)) * u154.CellSize.X.Scale * 1.1 * v165 / l__Parent__23.AbsoluteSize.Y, l__CanvasSize__24.Y.Scale);
                    l__Parent__23.CanvasSize = UDim2.fromScale(l__CanvasSize__24.X.Scale, v166);
                    local v167 = l__CanvasSize__24.Y.Scale / l__Parent__23.CanvasSize.Y.Scale;
                    local _ = l__Parent__23.CanvasSize.Y.Scale / l__CanvasSize__24.Y.Scale;
                    u154.CellPadding = UDim2.fromScale(l__CellPadding__26.X.Scale, l__CellPadding__26.Y.Scale * v167);
                    u161.PaddingTop = UDim.new(l__PaddingTop__25.Scale * v167);
                end;
                l__Parent__23.ChildAdded:Connect(v168);
                l__Parent__23.ChildRemoved:Connect(v168);
                l__Parent__23:GetPropertyChangedSignal("AbsoluteSize"):Connect(v168);
            end;
        end;
    end;
end;
function u3.Init() --[[ Line: 1048 ]]
    -- upvalues: l__PlayerGui__5 (copy), u3 (copy)
    task.wait();
    for _, v169 in l__PlayerGui__5:GetChildren() do
        if v169:IsA("ScreenGui") then
            u3.HandleNewPlayerScreenGui(v169);
        end;
    end;
    l__PlayerGui__5.ChildAdded:Connect(function(p170) --[[ Line: 1055 ]]
        -- upvalues: u3 (ref)
        if p170:IsA("ScreenGui") then
            u3.HandleNewPlayerScreenGui(p170);
        end;
    end);
    u3.GuiInsetSize = game:GetService("GuiService"):GetGuiInset().Y;
end;
u3.Init();
l__UserInputService__2.InputEnded:Connect(u3.InputEnded);
l__UserInputService__2.InputChanged:Connect(u3.InputChanged);
return u3;
