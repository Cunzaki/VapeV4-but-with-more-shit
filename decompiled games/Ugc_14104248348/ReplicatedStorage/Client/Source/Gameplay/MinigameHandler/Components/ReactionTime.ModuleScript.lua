-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.ReactionTime
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__TweenService__3 = game:GetService("TweenService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
local l__Mince__6 = require(l__ReplicatedStorage__4.Modules.Mince);
local l__Unify__7 = require(l__ReplicatedStorage__4.Modules.Unify);
local u1 = l__Mince__6:Get("Bobbing");
l__Mince__6:Get("Locomotion");
local u2 = l__Mince__6:Get("BindManager");
local u3 = l__Mince__6:Get("SoundHandler");
local u4 = l__Mince__6:Get("SelectInteractor");
local u5 = l__Mince__6:Get("InterfaceHandler");
local u6 = nil;
local u9 = {
    ButtonPressTween = nil,
    Client = {},
    Colors = { Color3.new(1, 0, 0), Color3.new(0, 1, 0), Color3.new(0.129412, 0.129412, 0.129412) },
    ButtonTween = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true),
    ZoomInTween = TweenInfo.new(10, Enum.EasingStyle.Linear),
    SpeedTween = TweenInfo.new(0.25),
    ClickButton = function(p7) --[[ Name: ClickButton, Line 35 ]]
        -- upvalues: l__Unify__7 (copy), u1 (copy), l__TweenService__3 (copy)
        l__Unify__7.GetServerTimeUntil(p7.ReplicatedState.HitAt);
        p7.InteractionClass.Disabled = true;
        u1.FadeFOVMult(p7.FieldOfView, 1, 0.1);
        p7.FieldOfView = 1;
        p7.FieldOfView = 1;
        p7.ZoomOut = false;
        local v8 = l__Unify__7.GetServerTimeUntil(p7.ReplicatedState.HitAt);
        if v8 > 0 then
            p7.Button.PrimaryPart.Wrong:Play();
        else
            p7.Button.PrimaryPart.Correct:Play();
        end;
        l__TweenService__3:Create(p7.Button.PrimaryPart.Loop, p7.SpeedTween, {
            PlaybackSpeed = 0
        }):Play();
        p7.ButtonPressTween:Play();
        p7.Server:Hit(v8);
        p7.LastClick = os.clock();
    end
};
function u9.Construct(u10) --[[ Line: 62 ]]
    -- upvalues: u6 (ref), u5 (copy), l__TweenService__3 (copy), u9 (copy), u4 (copy)
    for _, v11 in u10.Instance.Players:GetChildren() do
        u10:AddProximityJoinSource(v11:WaitForChild("Position"), (tonumber(v11.Name)));
    end;
    u6 = u5.GetScreenGui("ReactionTime");
    u10.Button = u10.Instance:WaitForChild("Button");
    u10.Button.PrimaryPart.Color = u10.Colors[3];
    u10.LastClick = os.clock();
    u10.ButtonPressTween = l__TweenService__3:Create(u10.Button.PrimaryPart, u9.ButtonTween, {
        Position = u10.Button.PrimaryPart.Position - Vector3.new(0, 0.065, 0)
    });
    local v13 = {
        HoverName = "Press Button",
        Target = u10.Button.PrimaryPart,
        HitCollider = u10.Button.PrimaryPart,
        Disabled = true,
        Interact = function(_, p12) --[[ Name: Interact, Line 85 ]]
            -- upvalues: u10 (copy)
            if u10.ReplicatedState.HitAt then
                u10:ClickButton();
                p12();
            else
                warn("tried to press the button but there was no replicate hit time!");
            end;
        end,
        OnHover = function() --[[ Line: 94 ]]
            -- upvalues: u10 (copy)
            return os.clock() - u10.LastClick > 1;
        end
    };
    u4.NewInteractionClass(v13);
    u10.InteractionClass = v13;
end;
function u9.Start(u14) --[[ Line: 103 ]]
    -- upvalues: u6 (ref), u1 (copy), l__TweenService__3 (copy), l__Players__1 (copy), l__Unify__7 (copy), u2 (copy), l__RunService__2 (copy)
    local v15 = u14:GetLocalSlot();
    if not v15 then
        error("Could not retrieve your slot!");
    end;
    local l__WorldCFrame__8 = u14.Instance.Players[v15].Camera.WorldCFrame;
    task.spawn(function() --[[ Line: 110 ]]
        -- upvalues: u14 (copy), l__WorldCFrame__8 (copy)
        u14:HideLocalPlayer();
        u14:DistanceRoundedCameraPan(l__WorldCFrame__8);
    end);
    local _ = game.Workspace.CurrentCamera;
    u14.ZoomOut = false;
    u14.FieldOfView = 1;
    u14.Button.PrimaryPart.Color = u14.Colors[1];
    u14.InteractionClass.Disabled = true;
    u6.Enabled = true;
    local u16 = nil;
    u14:GetStateChangedSignal("Round"):Connect(function() --[[ Line: 126 ]]
        -- upvalues: u16 (ref), u14 (copy), u1 (ref), l__TweenService__3 (ref), l__Players__1 (ref)
        if u16 and coroutine.status(u16) == "suspended" then
            task.cancel(u16);
        end;
        u14.FieldOfView = 1;
        u14.ZoomOut = false;
        u1.FadeFOVMult(u14.FieldOfView, 1, 0.1);
        l__TweenService__3:Create(u14.Button.PrimaryPart.Loop, u14.SpeedTween, {
            PlaybackSpeed = 0
        }):Play();
        if u14.ReplicatedState.RoundWinner and u14.ReplicatedState.RoundWinner ~= 0 then
            if u14.ReplicatedState.RoundWinner and u14.ReplicatedState.Loser then
                u14:TimedInspect(`{l__Players__1:GetPlayerByUserId((math.round(u14.ReplicatedState.RoundWinner))).Name} pressed the button early!`, 2);
            else
                u14:TimedInspect(`{l__Players__1:GetPlayerByUserId(u14.ReplicatedState.RoundWinner).Name} wins this round!`, 2);
            end;
        else
            u14:TimedInspect("Nobody wins this round!", 2);
        end;
    end);
    local v18 = u14:WatchStateChange("HitAt", function() --[[ Line: 151 ]]
        -- upvalues: l__Unify__7 (ref), u14 (copy), u16 (ref), l__TweenService__3 (ref)
        local v17 = l__Unify__7.GetServerTimeUntil(u14.ReplicatedState.HitAt);
        if u16 and coroutine.status(u16) == "suspended" then
            task.cancel(u16);
        end;
        u14.FieldOfView = 1;
        u14.ZoomOut = true;
        u14.InteractionClass.Disabled = false;
        u14.Button.PrimaryPart.Color = u14.Colors[1];
        u14.Button.PrimaryPart.Loop.PlaybackSpeed = 1;
        u14.Button.PrimaryPart.Loop:Play();
        u16 = task.delay(v17, function() --[[ Line: 168 ]]
            -- upvalues: l__TweenService__3 (ref), u14 (ref)
            l__TweenService__3:Create(u14.Button.PrimaryPart.Loop, u14.SpeedTween, {
                PlaybackSpeed = 1.2
            }):Play();
            u14.Button.PrimaryPart.Color = u14.Colors[2];
        end);
    end);
    for v19, u20 in u14.Queue do
        local u21 = u6.Container:WaitForChild((`Player{u20}`));
        u21.Score.Text = 0;
        u21.ProfileItem.Image = l__Players__1:GetUserThumbnailAsync(v19.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100);
        u14.Maid:Mark(u14:WatchStateChange(`Score_{u20}`, function() --[[ Line: 186 ]]
            -- upvalues: u21 (copy), u14 (copy), u20 (copy)
            u21.Score.Text = u14.ReplicatedState[`Score_{u20}`];
        end));
    end;
    u14.Maid:Mark(u2.Get("UnifiedInteract").OnAction:Connect(function(p22) --[[ Line: 192 ]]
        -- upvalues: u14 (copy)
        if p22 == Enum.UserInputState.Begin then
            if os.clock() - u14.LastClick > 1 and (u14.ReplicatedState.HitAt and not u14.InteractionClass.Disabled) then
                u14:ClickButton();
            end;
        end;
    end));
    u14.Maid:Mark(l__RunService__2.Heartbeat:Connect(function(p23) --[[ Line: 199 ]]
        -- upvalues: u14 (copy), u1 (ref)
        if u14.ZoomOut then
            local v24 = u14;
            v24.FieldOfView = v24.FieldOfView + p23 * 0.01;
            u1.SetFOVMult(u14.FieldOfView);
        end;
    end));
    u14.Maid:Mark(v18);
    u14.Maid:Mark(function() --[[ Line: 208 ]]
        -- upvalues: u14 (copy)
        u14.Button.PrimaryPart.Color = u14.Colors[1];
    end);
end;
function u9.Complete(u25, p26, p27) --[[ Line: 213 ]]
    -- upvalues: l__LocalPlayer__5 (copy), u3 (copy)
    warn("Completion!", p26, p27);
    u25.UpdateOpponent = false;
    u25.CanPlay = false;
    if p27 == "Draw" then
        u25:TimedInspect("It\'s a tie!", 3);
    elseif p27:IsA("Player") then
        u25:TimedInspect(`The winner of this game is {p27.Name}!`, 3);
    end;
    local l__Animator__9 = l__LocalPlayer__5.Character.Humanoid.Animator;
    local v28 = {
        Win = l__Animator__9:LoadAnimation(script.Victory),
        Lose = l__Animator__9:LoadAnimation(script.Defeat)
    };
    if p27 == l__LocalPlayer__5 then
        u3.PlaySound("TicTacToe.Win");
        v28.Win:Play();
    else
        u3.PlaySound("TicTacToe.Lose");
        v28.Lose:Play();
    end;
    task.wait(1);
    local v29 = u25:GetFirstOpponent();
    if v29 then
        local l__Character__10 = v29.Character;
        if l__Character__10 then
            l__Character__10 = v29.Character:FindFirstChild("HumanoidRootPart");
        end;
        if l__Character__10 then
            local u30 = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, l__Character__10.Position);
            task.spawn(function() --[[ Line: 252 ]]
                -- upvalues: u25 (copy), u30 (copy)
                u25:CameraPan(u30);
            end);
        end;
    end;
end;
function u9.Exit(p31) --[[ Line: 260 ]]
    -- upvalues: u1 (copy), u6 (ref)
    u1.SetFOVMult(1);
    u6.Enabled = false;
    p31.InteractionClass.Disabled = true;
    p31.Button.PrimaryPart.Color = p31.Colors[3];
    p31.Button.PrimaryPart.Loop.PlaybackSpeed = 1;
    p31.Button.PrimaryPart.Loop:Stop();
    p31:UnhideLocalPlayer();
    p31:DistanceLinearRevertCamera();
    p31:UnlockPlayerMovement();
end;
function u9.SpectateStart(u32) --[[ Line: 273 ]]
    -- upvalues: l__Players__1 (copy), l__Unify__7 (copy), u6 (ref)
    local v33 = u32:GetStateChangedSignal("Round"):Connect(function() --[[ Line: 278 ]]
        -- upvalues: u32 (copy), l__Players__1 (ref)
        if u32.ReplicatedState.RoundWinner and u32.ReplicatedState.RoundWinner ~= 0 then
            if u32.ReplicatedState.RoundWinner and u32.ReplicatedState.Loser then
                u32:TimedInspect(`{l__Players__1:GetPlayerByUserId((math.round(u32.ReplicatedState.RoundWinner))).Name} pressed the button early!`, 2);
                u32.Button.PrimaryPart.Wrong:Play();
            else
                u32:TimedInspect(`{l__Players__1:GetPlayerByUserId(u32.ReplicatedState.RoundWinner).Name} wins this round!`, 2);
                u32.Button.PrimaryPart.Correct:Play();
            end;
        else
            u32:TimedInspect("Nobody wins this round!", 2);
        end;
    end);
    local u34 = nil;
    local v36 = u32:WatchStateChange("HitAt", function() --[[ Line: 295 ]]
        -- upvalues: l__Unify__7 (ref), u32 (copy), u34 (ref)
        local v35 = l__Unify__7.GetServerTimeUntil(u32.ReplicatedState.HitAt);
        if v35 <= 0 or u32.ReplicatedState.CurrentState ~= "Started" then
            u32.Button.PrimaryPart.Color = u32.Colors[3];
        else
            if u34 and coroutine.status(u34) == "suspended" then
                task.cancel(u34);
            end;
            u32.Button.PrimaryPart.Color = u32.Colors[1];
            u34 = task.delay(v35, function() --[[ Line: 310 ]]
                -- upvalues: u32 (ref)
                u32.Button.PrimaryPart.Color = u32.Colors[2];
            end);
        end;
    end);
    local v40 = u32:WatchStateChange("CurrentState", function() --[[ Line: 315 ]]
        -- upvalues: u32 (copy), u6 (ref), l__Players__1 (ref), u34 (ref)
        if u32.ReplicatedState.CurrentState == "Started" then
            u6.Enabled = true;
            for v37, u38 in u32.Queue do
                local u39 = u6.Container:WaitForChild((`Player{u38}`));
                u39.Score.Text = 0;
                u39.ProfileItem.Image = l__Players__1:GetUserThumbnailAsync(v37.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100);
                u32.SpectateMaid:Mark(u32:WatchStateChange(`Score_{u38}`, function() --[[ Line: 331 ]]
                    -- upvalues: u39 (copy), u32 (ref), u38 (copy)
                    u39.Score.Text = u32.ReplicatedState[`Score_{u38}`];
                end));
            end;
        else
            if u34 and coroutine.status(u34) == "suspended" then
                task.cancel(u34);
            end;
            u32.Button.PrimaryPart.Color = u32.Colors[3];
            u6.Enabled = false;
        end;
    end);
    u32.SpectateMaid:Mark(v36);
    u32.SpectateMaid:Mark(v33);
    u32.SpectateMaid:Mark(v40);
    u32.SpectateMaid:Mark(function() --[[ Line: 350 ]]
        -- upvalues: u6 (ref), u32 (copy), u34 (ref)
        u6.Enabled = false;
        u32.Button.PrimaryPart.Color = u32.Colors[3];
        if u34 and coroutine.status(u34) == "suspended" then
            task.cancel(u34);
        end;
    end);
    u32.InteractionClass.Disabled = true;
end;
return u9;
