-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.None
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__CurrentCamera__2 = workspace.CurrentCamera;
l__LocalPlayer__1:GetMouse();
game:GetService("Debris");
local l__TweenService__3 = game:GetService("TweenService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__UserInputService__5 = game:GetService("UserInputService");
local l__ContextActionService__6 = game:GetService("ContextActionService");
local l__RunService__7 = game:GetService("RunService");
local l__HttpService__8 = game:GetService("HttpService");
local l__Mince__9 = require(l__ReplicatedStorage__4.Modules.Mince);
l__Mince__9:Get("BindManager");
local u1 = l__Mince__9:Get("SoundHandler");
local l__Unify__10 = require(l__ReplicatedStorage__4.Modules.Unify);
local u2 = l__Mince__9:Get("InterfaceHandler");
local u3 = l__Mince__9:Get("SelectInteractor");
local u4 = TweenInfo.new(0.5);
local u5 = {
    {
        Rotation = 0,
        Position = UDim2.fromScale(0.5, 1.5)
    },
    {
        Rotation = 270,
        Position = UDim2.fromScale(-1.5, 0)
    },
    {
        Rotation = 180,
        Position = UDim2.fromScale(0.5, -1.5)
    },
    {
        Rotation = 90,
        Position = UDim2.fromScale(1.5, 0)
    }
};
local v6 = {
    ColorSelecting = false,
    LastClick = os.clock(),
    Deck = {},
    Client = {}
};
function lerp(p7, p8, p9)
    return p7 + (p8 - p7) * p9;
end;
function v6.GetCardFromId(p10, p11) --[[ Line: 44 ]]
    for _, v12 in p10.Settings.Cards do
        if v12.Id == p11 then
            return v12;
        end;
    end;
end;
function v6.AddCardToDeck(p13, p14, p15, p16) --[[ Line: 54 ]]
    -- upvalues: u5 (copy), l__TweenService__3 (copy), u4 (copy)
    local l__Container__11 = p13.SurfaceUI.Container;
    local v17 = u5[tonumber(p15)];
    local l__Rotation__12 = v17.Rotation;
    local l__Instance__13 = p13:DrawCard({
        Id = p16[1],
        Color = p16[2]
    }).Instance;
    l__Instance__13.AnchorPoint = Vector2.new(0.5, 0.5);
    l__Instance__13.Size = UDim2.fromScale(0.2, 0.2);
    l__Instance__13.GroupTransparency = 1;
    l__Instance__13.Position = v17.Position;
    l__Instance__13.Parent = l__Container__11;
    l__TweenService__3:Create(l__Instance__13, u4, {
        GroupTransparency = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        Rotation = l__Rotation__12 + math.random(-10, 10)
    }):Play();
    p14:Mark(l__Instance__13);
    table.insert(p13.Deck, l__Instance__13);
    if #p13.Deck >= 25 then
        p13.Deck[1]:Destroy();
        table.remove(p13.Deck, 1);
        for v18, v19 in p13.Deck do
            v19.ZIndex = v18;
        end;
    end;
end;
function v6.IsValidPlay(p20, p21) --[[ Line: 86 ]]
    if p20.CanPlay then
        if p20.Whitelist then
            return table.find(p20.Whitelist, p21[1]) and true or false;
        else
            return (p21[2] == "0" or p20.DeckCard[2] == "0") and true or (p21[1] == p20.DeckCard[1] or tostring(p21[2]) == tostring(p20.DeckCard[2]));
        end;
    else
        return false;
    end;
end;
function v6.RequestColor(u22) --[[ Line: 111 ]]
    -- upvalues: l__TweenService__3 (copy), u4 (copy)
    local v23 = l__TweenService__3:Create(u22.ColorPicker, u4, {
        GroupTransparency = 0
    });
    local v24 = l__TweenService__3:Create(u22.ColorPicker, u4, {
        GroupTransparency = 1
    });
    v23:Play();
    u22.ColorPicker.Visible = true;
    u22.ColorSelecting = true;
    local u25 = {};
    local u26 = nil;
    for _, u27 in u22.ColorPicker:GetChildren() do
        if u27:IsA("TextButton") then
            table.insert(u25, u27.MouseButton1Click:Once(function() --[[ Line: 123 ]]
                -- upvalues: u26 (ref), u27 (copy)
                u26 = u27.Name;
            end));
        end;
    end;
    repeat
        task.wait(0.1);
    until u26;
    v24:Play();
    v24.Completed:Once(function() --[[ Line: 135 ]]
        -- upvalues: u22 (copy), u25 (copy)
        u22.ColorPicker.Visible = false;
        for _, v28 in u25 do
            v28:Disconnect();
        end;
    end);
    return u26;
end;
function v6.Construct(u29) --[[ Line: 145 ]]
    -- upvalues: u2 (copy)
    for _, v30 in u29.Instance.Players:GetChildren() do
        if v30:IsA("Seat") then
            u29:AddSeatJoinSource(v30, (tonumber(v30.Name)));
        else
            u29:AddProximityJoinSource(v30:WaitForChild("Position"), (tonumber(v30.Name)));
        end;
    end;
    local v31 = u2.GetScreenGui("NoneGui");
    local l__MobileControls__14 = v31.MobileControls;
    local l__Buttons__15 = v31.Buttons;
    u2.NewButton(l__Buttons__15.Draw).Activated:Connect(function() --[[ Line: 161 ]]
        -- upvalues: u29 (copy)
        u29.Server:Draw();
    end);
    u2.NewButton(l__Buttons__15.Play).Activated:Connect(function() --[[ Line: 166 ]]
        -- upvalues: u29 (copy)
        u29:Play(nil, Enum.UserInputState.Begin);
    end);
    u2.NewButton(l__MobileControls__14.Next).Activated:Connect(function() --[[ Line: 171 ]]
        -- upvalues: u29 (copy)
        u29:Select("NextInput", Enum.UserInputState.Begin);
    end);
    u2.NewButton(l__MobileControls__14.Previous).Activated:Connect(function() --[[ Line: 176 ]]
        -- upvalues: u29 (copy)
        u29:Select("PreviousInput", Enum.UserInputState.Begin);
    end);
    u29.SurfaceUI = u29.Instance.SurfaceUI.Table;
    u29.ColorPicker = v31.ColorPicker;
    u29.NoneUI = v31;
    u29.Buttons = l__Buttons__15;
end;
function v6.Watch(u32, u33) --[[ Line: 186 ]]
    -- upvalues: u1 (copy), l__HttpService__8 (copy), l__RunService__7 (copy)
    local l__SurfaceUI__16 = u32.SurfaceUI;
    local l__Turn__17 = l__SurfaceUI__16.Turn;
    local l__TextLabel__18 = l__SurfaceUI__16.Container.TextLabel;
    local u34 = u32:GetLocalSlot() or 0;
    local u35 = true;
    local v39 = u32:WatchStateChange("DeckCard", function(p36) --[[ Line: 193 ]]
        -- upvalues: u32 (copy), l__TextLabel__18 (copy), u34 (copy), u33 (copy)
        local v37 = u32.Slots[u32.ReplicatedState.Turn];
        local v38 = string.split(p36, ",");
        l__TextLabel__18.Text = p36;
        u32.DeckCard = v38;
        if v37 then
            if v38[1] == "4P" or v38[1] == "2P" then
                u32:TimedInspect(`{v37.Name} has played a take {string.match(v38[1], "%d")}!`, 3);
            elseif v38[1] == "C" then
                u32:TimedInspect(`{v37.Name} has changed the color!`, 3);
            end;
        end;
        if p36 == "," or u32.Turn == u34 then
        else
            u32:AddCardToDeck(u33, v38[3] or 1, v38);
        end;
    end);
    local v44 = u32:WatchStateChange("Turn", function() --[[ Line: 215 ]]
        -- upvalues: u32 (copy), l__SurfaceUI__16 (copy), u34 (copy), u1 (ref)
        local l__Turn__19 = u32.ReplicatedState.Turn;
        local v40 = u32.Slots[l__Turn__19];
        if v40 then
            task.spawn(function() --[[ Line: 220 ]]
                -- upvalues: l__SurfaceUI__16 (ref), u32 (ref), l__Turn__19 (copy)
                local v41 = l__SurfaceUI__16.Hands:FindFirstChild(u32.Turn or "ooo");
                local v42 = l__SurfaceUI__16.Hands[l__Turn__19];
                for v43 = 0, 1, 0.1 do
                    if v41 then
                        v41.CanPlay.ImageTransparency = lerp(0.8, 1, v43);
                    end;
                    v42.CanPlay.ImageTransparency = lerp(1, 0.8, v43);
                    task.wait();
                end;
            end);
            u32.Turn = l__Turn__19;
            u32.CanPlay = u32.Turn == u34;
            u32.Buttons.Visible = u32.CanPlay;
            u1.PlaySound("Pool.TurnChange");
            u32:TimedInspect(`It's {v40.Name}'s turn!`, 3);
        end;
    end);
    local v48 = u32:WatchStateChange("Hands", function(p45) --[[ Line: 241 ]]
        -- upvalues: l__HttpService__8 (ref), u32 (copy), u33 (copy)
        local v46 = l__HttpService__8:JSONDecode(p45);
        for v47 = 1, 4 do
            u32:DrawImposters(u33, v47, v46[v47] or 0);
        end;
    end);
    local v51 = u32:GetStateChangedSignal("Clockwise"):Connect(function(p49) --[[ Line: 250 ]]
        -- upvalues: u32 (copy), u35 (ref)
        local v50 = u32.Slots[u32.ReplicatedState.Turn];
        u35 = p49;
        if v50 then
            u32:TimedInspect(`{v50.Name} has reversed the table!`, 3);
        end;
    end);
    u33:Mark(l__RunService__7.Heartbeat:Connect(function(p52) --[[ Line: 259 ]]
        -- upvalues: l__Turn__17 (copy), u35 (ref)
        local v53 = l__Turn__17;
        v53.Rotation = v53.Rotation + 1 * p52 * 30 * (u35 and 1 or -1);
    end));
    u33:Mark((u32:WatchStateChange("CurrentState", function() --[[ Line: 263 ]]
        -- upvalues: u32 (copy), l__Turn__17 (copy)
        if u32.ReplicatedState.CurrentState == "Started" then
            l__Turn__17.Visible = true;
        else
            l__Turn__17.Visible = false;
        end;
    end)));
    u33:Mark(v39);
    u33:Mark(v48);
    u33:Mark(v44);
    u33:Mark(v51);
end;
function v6.DrawImposters(p54, p55, p56, p57) --[[ Line: 280 ]]
    -- upvalues: u5 (copy)
    local v58 = p54.SurfaceUI.Hands[p56];
    local l__Path2D__20 = v58.Path2D;
    local v59 = u5[tonumber(p56)];
    for _, v60 in v58:GetChildren() do
        if v60.Name ~= "CanPlay" and (v60:IsA("ImageLabel") and tonumber(v60.Name) > tonumber(p57)) then
            v60:Destroy();
        end;
    end;
    for v61 = 1, p57 do
        local v62 = v61 / (p57 + 1);
        local v63 = l__Path2D__20:GetTangentOnCurveArcLength(v62);
        local v64 = l__Path2D__20:GetPositionOnCurveArcLength(v62);
        local v65 = math.atan2(v63.X, v63.Y);
        local v66 = v58:FindFirstChild(v61);
        if not v66 then
            v66 = v58:FindFirstChild(v61) or Instance.new("ImageLabel");
            v66.Name = v61;
            v66.AnchorPoint = Vector2.new(0.5, 0.5);
            v66.BackgroundTransparency = 1;
            v66.Position = UDim2.fromScale(0.5, 0.5);
            v66.Size = UDim2.fromScale(0.98, 0.95);
            v66.Image = "rbxassetid://139840627481321";
            v66.ScaleType = Enum.ScaleType.Fit;
            v66.ZIndex = 2;
            v66.Parent = v58;
            local v67 = Instance.new("UIAspectRatioConstraint");
            v67.AspectRatio = 0.74;
            v67.Parent = v66;
        end;
        v66.Rotation = v59.Rotation - math.deg(v65);
        v66.Position = v64;
        p55:Mark(v66);
    end;
end;
function v6.DrawCard(p68, p69) --[[ Line: 329 ]]
    local v70 = p69 or {};
    local v71 = p68:GetCardFromId(v70.Id or "B");
    local v72 = tostring(v70.Color or 0);
    local v73 = p68.Settings.Colors[v72];
    local v74 = Instance.new("CanvasGroup");
    v74.AnchorPoint = Vector2.new(0, 0.5);
    v74.Size = UDim2.fromOffset(100, 200);
    v74.BackgroundColor3 = Color3.new(1, 1, 1);
    v74.BackgroundTransparency = 1;
    local v75 = Instance.new("Frame");
    v75.Name = "Blackout";
    v75.AnchorPoint = Vector2.new(0.5, 0.5);
    v75.Size = UDim2.fromScale(1, 1);
    v75.Position = UDim2.fromScale(0.5, 0.5);
    v75.BackgroundColor3 = Color3.new(0, 0, 0);
    v75.BackgroundTransparency = 1;
    v75.ZIndex = 5;
    v75.Parent = v74;
    local v76 = Instance.new("UICorner");
    v76.CornerRadius = UDim.new(0.1, 0);
    v76.Parent = v75;
    local v77 = Instance.new("ImageLabel");
    v77.AnchorPoint = Vector2.new(0.5, 0.5);
    v77.BackgroundTransparency = 1;
    v77.Position = UDim2.fromScale(0.5, 0.5);
    v77.Size = UDim2.fromScale(0.98, 0.95);
    v77.Image = "rbxassetid://77537888111866";
    v77.ImageColor3 = v73;
    v77.ScaleType = Enum.ScaleType.Fit;
    v77.ZIndex = 2;
    v77.Parent = v74;
    local v78 = Instance.new("ImageLabel");
    v78.AnchorPoint = Vector2.new(0.5, 0.5);
    v78.BackgroundTransparency = 1;
    v78.Position = UDim2.fromScale(0.5, 0.5);
    v78.Size = UDim2.fromScale(0.98, 0.95);
    v78.Image = v71.Image;
    v78.ScaleType = Enum.ScaleType.Fit;
    v78.ZIndex = 3;
    v78.Parent = v74;
    local v79 = Instance.new("UIAspectRatioConstraint");
    v79.AspectRatio = 0.74;
    v79.Parent = v74;
    p68.Maid:Mark(v74);
    return {
        Instance = v74,
        Color = v72,
        Colorless = v70.Color == 0,
        Id = v70.Id
    };
end;
function v6.Update(p80, p81) --[[ Line: 392 ]]
    -- upvalues: l__CurrentCamera__2 (copy), l__UserInputService__5 (copy), u1 (copy)
    local l__Hand__21 = p80.NoneUI.Hand;
    local l__Path2D__22 = l__Hand__21.Path2D;
    local _ = l__CurrentCamera__2.ViewportSize;
    local l__AbsolutePosition__23 = l__Hand__21.AbsolutePosition;
    local l__AbsoluteSize__24 = l__Hand__21.AbsoluteSize;
    local v82 = 1 / (#p80.Hand + 1);
    local v83 = nil;
    local v84 = nil;
    local v85 = l__UserInputService__5:GetMouseLocation();
    local v86 = Vector2.new(v85.X - l__AbsolutePosition__23.X, 0) / Vector2.new(l__AbsoluteSize__24.X, 1);
    if p80.ColorSelecting then
    else
        if p80.CanPlay then
            if l__UserInputService__5.TouchEnabled or l__UserInputService__5.VREnabled then
                v84 = p80.TouchSelectedIndex;
                v83 = p80.Hand[v84];
            else
                for v87, v88 in p80.Hand do
                    local v89 = l__Path2D__22:GetPositionOnCurveArcLength(v87 / (#p80.Hand + 1));
                    if v86.X > v89.X.Scale and v86.X < v89.X.Scale + v82 * 2 then
                        v84 = v87;
                        v83 = v88;
                    end;
                end;
            end;
            if v83 ~= p80.SelectedCard then
                u1.PlaySound("TicTacToe.Hover");
            end;
        end;
        for v90, v91 in p80.Hand do
            local l__Instance__25 = v91[3].Instance;
            local v92 = v90 / (#p80.Hand + 1);
            local v93 = l__Path2D__22:GetTangentOnCurveArcLength(v92);
            local v94 = l__Path2D__22:GetPositionOnCurveArcLength(v92);
            local v95 = math.atan2(v93.X, v93.Y);
            local v96 = p80:IsValidPlay(v91);
            local v97 = 0;
            if not v91[4] then
                if v83 and l__Instance__25 == v83[3].Instance then
                    l__Instance__25.Rotation = lerp(l__Instance__25.Rotation, 0, p81 * 5);
                    l__Instance__25.Position = l__Instance__25.Position:Lerp(v94 - UDim2.fromScale(0, 0.5), p81 * 5);
                else
                    if v83 then
                        v97 = math.sign(v90 - v84) * 0.1;
                    end;
                    l__Instance__25.Rotation = lerp(l__Instance__25.Rotation, 90 - math.deg(v95), p81 * 5);
                    l__Instance__25.Position = l__Instance__25.Position:Lerp(v94 + UDim2.fromScale(v97, 0), p81 * 5);
                end;
                l__Instance__25.Blackout.BackgroundTransparency = lerp(l__Instance__25.Blackout.BackgroundTransparency, v96 and 1 or 0.5, p81 * 5);
            end;
        end;
        p80.SelectedCard = v83;
    end;
end;
function v6.Select(p98, p99, p100, _) --[[ Line: 469 ]]
    if p100 == Enum.UserInputState.Begin then
        p98.TouchSelectedIndex = p98.TouchSelectedIndex + (p99 == "NextInput" and 1 or -1);
        if p98.TouchSelectedIndex <= 0 then
            p98.TouchSelectedIndex = #p98.Hand;
        else
            if p98.TouchSelectedIndex > #p98.Hand then
                p98.TouchSelectedIndex = 1;
            end;
        end;
    end;
end;
function v6.Play(p101, _, p102, _) --[[ Line: 485 ]]
    -- upvalues: u1 (copy)
    local v103 = os.clock() - p101.LastClick;
    local l__SelectedCard__26 = p101.SelectedCard;
    if p102 == Enum.UserInputState.Begin and (l__SelectedCard__26 and v103 > 1) then
        p101.LastClick = os.clock();
        if p101:IsValidPlay(l__SelectedCard__26) then
            local v104;
            if l__SelectedCard__26[2] == "0" then
                v104 = p101:RequestColor();
            else
                v104 = nil;
            end;
            local v105 = { l__SelectedCard__26[1], v104 or l__SelectedCard__26[2] };
            p101:AddCardToDeck(p101.Maid, p101.Turn, v105);
            p101.Server:Play(v105);
            u1.PlaySound("Checkers.Select");
            p101:OnCardRemoved(p101.SelectedCard);
            p101.ColorSelecting = false;
            p101.Whitelist = nil;
            return;
        end;
        u1.PlaySound("TicTacToe.Error");
    end;
end;
function v6.Client.OnCardAdded(p106, p107) --[[ Line: 515 ]]
    local l__Hand__27 = p106.NoneUI.Hand;
    local _ = l__Hand__27.Path2D;
    local v108 = p106:DrawCard({
        Id = p107[1],
        Color = p107[2]
    });
    v108.Instance.Parent = l__Hand__27;
    p107[3] = v108;
    table.insert(p106.Hand, p107);
end;
function v6.OnCardRemoved(u109, p110) --[[ Line: 525 ]]
    -- upvalues: l__TweenService__3 (copy), u4 (copy)
    local u111 = table.find(u109.Hand, p110);
    local l__Instance__28 = p110[3].Instance;
    local v112 = l__TweenService__3:Create(l__Instance__28, u4, {
        GroupTransparency = 1,
        Position = l__Instance__28.Position - UDim2.fromScale(0, 1)
    });
    p110[4] = true;
    v112:Play();
    v112.Completed:Connect(function() --[[ Line: 538 ]]
        -- upvalues: l__Instance__28 (copy), u109 (copy), u111 (copy)
        l__Instance__28:Destroy();
        table.remove(u109.Hand, u111);
        u109:Select("PreviousInput", Enum.UserInputState.Begin);
    end);
end;
function v6.Client.OnContest(p113, p114) --[[ Line: 545 ]]
    p113.Whitelist = p114[1] == "2P" and ({ "2P", "4P" } or { "4P" }) or { "4P" };
end;
function v6.Enter(u115) --[[ Line: 549 ]]
    -- upvalues: l__LocalPlayer__1 (copy), l__Unify__10 (copy)
    local l__Animator__29 = l__LocalPlayer__1.Character.Humanoid.Animator;
    u115:StartInspect("Waiting for players..");
    u115:WatchStateChange("IntermissionRequirementsMet", function(p116) --[[ Line: 557 ]]
        -- upvalues: l__Unify__10 (ref), u115 (copy)
        if p116 then
            while true do
                local v117 = l__Unify__10.GetServerTimeUntil(u115.ReplicatedState.IntermissionEndsAt);
                if v117 >= 0.1 then
                    u115:TimedInspect(`The game will start in {math.round(v117)} second(s)!`, 1);
                end;
                task.wait(0.5);
                if not u115.ReplicatedState.IntermissionRequirementsMet or v117 <= 0 then
                    if v117 <= 0 then
                        u115:TimedInspect("The game has started, fair game to everyone!", 3);
                        return;
                    end;
                    u115:StartInspect("Waiting for players..");
                    return;
                end;
            end;
        end;
    end);
    u115.Instances = {};
    u115.Hand = {};
    u115.Deck = {};
    u115.Whitelist = nil;
    u115.Animations = {
        Win = l__Animator__29:LoadAnimation(script.Victory),
        Lose = l__Animator__29:LoadAnimation(script.Defeat)
    };
end;
function v6.Start(u118) --[[ Line: 589 ]]
    -- upvalues: u3 (copy), l__ContextActionService__6 (copy), l__UserInputService__5 (copy), l__RunService__7 (copy)
    u118:StopInspect();
    u3.StartInteractions();
    u118:Watch(u118.Maid);
    l__ContextActionService__6:BindAction("NoneInput", function(...) --[[ Line: 597 ]]
        -- upvalues: u118 (copy)
        u118:Play(...);
    end, false, Enum.UserInputType.MouseButton1, Enum.KeyCode.ButtonA);
    l__ContextActionService__6:BindAction("NextInput", function(...) --[[ Line: 605 ]]
        -- upvalues: u118 (copy)
        u118:Select(...);
    end, false, Enum.KeyCode.DPadRight);
    l__ContextActionService__6:BindAction("PreviousInput", function(...) --[[ Line: 612 ]]
        -- upvalues: u118 (copy)
        u118:Select(...);
    end, false, Enum.KeyCode.DPadLeft);
    local v119 = l__UserInputService__5.TouchEnabled or l__UserInputService__5.VREnabled;
    local l__NoneUI__30 = u118.NoneUI;
    local l__MobileControls__31 = l__NoneUI__30.MobileControls;
    local l__Buttons__32 = l__NoneUI__30.Buttons;
    l__MobileControls__31.Visible = v119;
    l__Buttons__32.Play.Visible = v119;
    l__RunService__7:BindToRenderStep("NoneRenderer", Enum.RenderPriority.Input.Value - 1, function(...) --[[ Line: 624 ]]
        -- upvalues: u118 (copy)
        u118:Update(...);
    end);
    l__NoneUI__30.Enabled = true;
    u118.TouchSelectedIndex = 1;
end;
function v6.Complete(u120, _, p121) --[[ Line: 630 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u1 (copy)
    u120.UpdateOpponent = false;
    u120.CanPlay = false;
    u120.SelectedCard = nil;
    if p121 == "Draw" then
        u120:TimedInspect("It\'s a tie!", 3);
    elseif p121:IsA("Player") then
        u120:TimedInspect(`The winner of this game is {p121.Name}!`, 3);
    end;
    local _ = l__LocalPlayer__1.Character.Humanoid.Animator;
    if p121 == l__LocalPlayer__1 then
        u1.PlaySound("TicTacToe.Win");
        u120.Animations.Win:Play();
    else
        u1.PlaySound("TicTacToe.Lose");
        u120.Animations.Lose:Play();
    end;
    task.wait(1);
    local v122 = u120:GetFirstOpponent();
    if v122 then
        local l__Character__33 = v122.Character;
        if l__Character__33 then
            l__Character__33 = v122.Character:FindFirstChild("HumanoidRootPart");
        end;
        if l__Character__33 then
            local u123 = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, l__Character__33.Position);
            task.spawn(function() --[[ Line: 665 ]]
                -- upvalues: u120 (copy), u123 (copy)
                u120:CameraPan(u123);
            end);
        end;
    end;
end;
function v6.Exit(p124) --[[ Line: 673 ]]
    -- upvalues: l__RunService__7 (copy), l__ContextActionService__6 (copy), u3 (copy)
    p124.NoneUI.Enabled = false;
    l__RunService__7:UnbindFromRenderStep("NoneRenderer");
    l__ContextActionService__6:UnbindAction("NoneInput");
    l__ContextActionService__6:UnbindAction("NextInput");
    l__ContextActionService__6:UnbindAction("PreviousInput");
    for _, v125 in p124.SurfaceUI.Hands:GetChildren() do
        if v125:IsA("Frame") then
            v125.CanPlay.ImageTransparency = 1;
        end;
    end;
    u3.EndInteractions();
    p124:DistanceLinearRevertCamera();
    p124:UnlockPlayerMovement();
end;
function v6.SpectateStart(p126) --[[ Line: 695 ]]
    p126:Watch(p126.SpectateMaid);
end;
function v6.SpectateEnd(p127) --[[ Line: 704 ]]
    for _, v128 in p127.SurfaceUI.Hands:GetChildren() do
        if v128:IsA("Frame") then
            v128.CanPlay.ImageTransparency = 1;
        end;
    end;
end;
return v6;
