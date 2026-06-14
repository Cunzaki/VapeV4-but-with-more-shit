-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.Rythm
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local _ = workspace.CurrentCamera;
l__LocalPlayer__1:GetMouse();
game:GetService("Debris");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local _ = l__ReplicatedStorage__3.Assets.Minigame.Rythm;
local l__RunService__4 = game:GetService("RunService");
local l__ContextActionService__5 = game:GetService("ContextActionService");
local l__Mince__6 = require(l__ReplicatedStorage__3.Modules.Mince);
local u1 = l__Mince__6:Get("BindManager");
local u2 = l__Mince__6:Get("SoundHandler");
local u3 = l__Mince__6:Get("SelectInteractor");
local l__rbxbpm__7 = require(l__ReplicatedStorage__3.Modules.rbxbpm);
local v4 = {
    NoteSpeed = 1500,
    Client = {}
};
Color3.fromRGB(85, 255, 0);
Color3.fromRGB(255, 0, 0);
TweenInfo.new(0.1);
local u5 = TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1);
local u6 = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In);
local u7 = {
    ["0"] = 1,
    ["128"] = 2,
    ["256"] = 3,
    ["384"] = 4,
    Left = 1,
    Down = 2,
    Up = 3,
    Right = 4
};
local u8 = {
    [Enum.KeyCode.Up] = "Up",
    [Enum.KeyCode.Down] = "Down",
    [Enum.KeyCode.Left] = "Left",
    [Enum.KeyCode.Right] = "Right",
    [Enum.KeyCode.DPadLeft] = "Left",
    [Enum.KeyCode.DPadRight] = "Right",
    [Enum.KeyCode.DPadUp] = "Up",
    [Enum.KeyCode.DPadDown] = "Down",
    [Enum.KeyCode.D] = "Left",
    [Enum.KeyCode.F] = "Down",
    [Enum.KeyCode.J] = "Up",
    [Enum.KeyCode.K] = "Right"
};
local u9 = {
    0.05,
    0.1,
    0.2,
    0.25,
    0.3
};
local u10 = {
    [0.05] = 500,
    [0.1] = 350,
    [0.2] = 100,
    [0.25] = 20,
    [0.3] = -20
};
local u11 = {
    [500] = { "GREAT!", Color3.fromRGB(255, 247, 0) },
    [350] = { "Good!", Color3.fromRGB(0, 199, 46) },
    [100] = { "Okay", Color3.fromRGB(0, 129, 199) },
    [20] = { "Bad", Color3.fromRGB(199, 0, 60) },
    [-20] = { "Miss", Color3.fromRGB(255, 0, 0) }
};
function v4.Construct(p12) --[[ Line: 86 ]]
    -- upvalues: l__TweenService__2 (copy), u5 (copy)
    p12.Instance.Screen.Song.Volume = 0;
    l__TweenService__2:Create(p12.Instance.Screen.BackgroundGui.Main.Body.Pattern, u5, {
        Position = UDim2.fromScale(-1, -1)
    }):Play();
    l__TweenService__2:Create(p12.Instance.Screen.MenuGui.Body.Pattern, u5, {
        Position = UDim2.fromScale(-1, -1)
    }):Play();
    for _, v13 in p12.Instance.Players:GetChildren() do
        p12:AddProximityJoinSource(v13:WaitForChild("Position"), (tonumber(v13.Name)));
    end;
    if not p12.Setup then
        p12.Setup = true;
        p12:PopulateSongMenu();
    end;
end;
function v4.Move(u14, p15) --[[ Line: 107 ]]
    -- upvalues: u7 (copy)
    if u14.MenuEnabled then
        if p15 == "Up" or p15 == "Down" then
            u14:SetMenuSelection(u14.CurrentSelection + (p15 == "Up" and -1 or 1));
        end;
    else
        u14.LastDirection = p15;
        local u16 = u14.Animations[p15];
        u14.Instance.Screen.DetailsGui.Main.Body.Top[`{u7[p15]}`].ImageLabel.Image = "rbxassetid://17689178290";
        u14:CheckForHitObjects(p15);
        u16.Ended:Once(function() --[[ Line: 125 ]]
            -- upvalues: u14 (copy), u16 (copy)
            u14:UpdateWeightsForAllAnimation(u16);
        end);
        u16:Play(0.04, u14:GetAnimationWeight(u16));
        u14:UpdateWeightsForAllAnimation(u16);
        u14.Server:SetDirection(p15, true);
    end;
end;
function v4.GetAnimationWeight(p17, p18) --[[ Line: 134 ]]
    local v19 = {};
    local v20 = 0;
    for _, v21 in p17.MovementAnimations do
        if not v19[v21] then
            v19[v21] = true;
            if v21.IsPlaying or v21 == p18 then
                v20 = v20 + (v21.Name == p17.LastDirection and 2 or 1);
            end;
        end;
    end;
    return v20 == 0 and 1 or (p18.Name == p17.LastDirection and 2 or 1) / v20;
end;
function v4.UpdateWeightsForAllAnimation(p22, p23) --[[ Line: 154 ]]
    local v24 = {};
    local v25 = 0;
    local v26 = {};
    for _, v27 in p22.MovementAnimations do
        if not v24[v27] then
            v24[v27] = true;
            if v27.IsPlaying then
                local v28 = v27.Name == p22.LastDirection and 2 or 1;
                v25 = v25 + v28;
                v26[v28] = v27;
            end;
        end;
    end;
    for v29, v30 in pairs(v26) do
        if v30 ~= p23 then
            v30:AdjustWeight(v29 / v25, 0.05);
        end;
    end;
end;
function v4.AnimatePoint(p31, p32) --[[ Line: 178 ]]
    -- upvalues: u11 (copy), l__TweenService__2 (copy), u6 (copy)
    if p31.PointWait then
        p31.PointTween:Cancel();
        task.cancel(p31.PointWait);
    end;
    local l__TextLabel__8 = p31.Instance.Screen.DetailsGui.Main.Body.TextLabel;
    l__TextLabel__8.Size = UDim2.fromScale(0.5, 0.2);
    l__TextLabel__8.Text = u11[p32][1];
    l__TextLabel__8.TextColor3 = u11[p32][2];
    p31.PointTween = l__TweenService__2:Create(l__TextLabel__8, u6, {
        Size = UDim2.fromScale(0.5, 0.15)
    });
    p31.PointTween:Play();
    p31.PointWait = task.delay(3, function() --[[ Line: 193 ]]
        -- upvalues: l__TextLabel__8 (copy)
        l__TextLabel__8.Text = "";
    end);
end;
function v4.CheckForHitObjects(p33, p34) --[[ Line: 198 ]]
    -- upvalues: u7 (copy), u9 (copy), u2 (copy), u10 (copy)
    for _, v35 in p33.HitObjects do
        if v35.Lane == u7[p34] then
            local v36 = math.abs(p33.Instance.Screen.Song.TimePosition - v35.TimePosition);
            if v36 <= 0.4 then
                for _, v37 in ipairs(u9) do
                    if v36 <= v37 then
                        u2.PlaySound("NoteHit");
                        p33:AnimatePoint(u10[v37]);
                        p33.Server:HitObject(u10[v37]);
                        p33:ReplaceHitObjectWithNext(v35);
                        return;
                    end;
                end;
                return;
            end;
        end;
    end;
end;
function v4.ClearNoteHighlight(p38) --[[ Line: 217 ]]
    -- upvalues: u7 (copy)
    for _, v39 in u7 do
        p38.Instance.Screen.DetailsGui.Main.Body.Top[`{v39}`].ImageLabel.Image = "rbxassetid://17560865555";
    end;
end;
function v4.SubscribeToScreen(u40, u41) --[[ Line: 223 ]]
    -- upvalues: l__RunService__4 (copy)
    u40.NoteInstances = {};
    local v43 = l__RunService__4.RenderStepped:Connect(function(_) --[[ Line: 226 ]]
        -- upvalues: u40 (copy), u41 (copy)
        local l__Song__9 = u40.Instance.Screen.Song;
        if u40.HitObjects then
            for _, v42 in u40.HitObjects do
                v42.UIInstance.Position = UDim2.fromOffset(0, (u40.Instance.Screen.Song.TimePosition - v42.TimePosition) * -u40.NoteSpeed);
                if l__Song__9.TimePosition - v42.TimePosition >= 1.25 then
                    u40:ReplaceHitObjectWithNext(v42);
                    if not u41 then
                        u40.Server:HitObject(-20);
                    end;
                end;
            end;
        end;
    end);
    if u41 then
        u40.SpectateMaid:Mark(v43);
        u40.SpectateMaid:Mark(function() --[[ Line: 249 ]]
            -- upvalues: u40 (copy)
            u40:UnsubscribeFromScreen();
            u40:ClearNoteHighlight();
        end);
    else
        u40.Maid:Mark(v43);
        u40.Maid:Mark(function() --[[ Line: 243 ]]
            -- upvalues: u40 (copy)
            u40:UnsubscribeFromScreen();
            u40:ClearNoteHighlight();
        end);
    end;
end;
function v4.UnsubscribeFromScreen(p44) --[[ Line: 256 ]]
    if p44.HitObjects then
        for _, v45 in p44.HitObjects do
            local _ = v45.HitObjectIndex;
            v45.UIInstance:Destroy();
            table.remove(p44.HitObjects, table.find(p44.HitObjects, v45));
        end;
    end;
    if p44.NoteInstances then
        for _, v46 in p44.NoteInstances do
            v46:Destroy();
        end;
    end;
    p44.Instance.Screen.DetailsGui.Enabled = false;
    p44.Instance.Screen.BackgroundGui.Enabled = false;
    p44.Instance.Screen.MenuGui.Enabled = false;
    p44.Instance.Screen.SplashGui.Enabled = true;
    p44.Instance.Screen.SplashGui.SongList.Hint.Title.Text = "Waiting for players...";
end;
function v4.ProcessInput(p47, _, p48, p49) --[[ Line: 278 ]]
    -- upvalues: u8 (copy), u7 (copy)
    local v50 = u8[p49.KeyCode];
    if v50 then
        if p48 == Enum.UserInputState.Begin then
            p47:Move(v50);
        else
            p47.Server:SetDirection(v50, false);
            p47.Instance.Screen.DetailsGui.Main.Body.Top[`{u7[v50]}`].ImageLabel.Image = "rbxassetid://17560865555";
        end;
    end;
end;
function v4.Hook(u51) --[[ Line: 290 ]]
    -- upvalues: l__ContextActionService__5 (copy)
    l__ContextActionService__5:BindAction("Rythm", function(...) --[[ Line: 292 ]]
        -- upvalues: u51 (copy)
        u51:ProcessInput(...);
    end, false, Enum.KeyCode.Up, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.Down, Enum.KeyCode.DPadLeft, Enum.KeyCode.DPadUp, Enum.KeyCode.DPadRight, Enum.KeyCode.DPadDown, Enum.KeyCode.D, Enum.KeyCode.F, Enum.KeyCode.J, Enum.KeyCode.K);
    l__ContextActionService__5:BindAction("Select", function(_, p52, _) --[[ Line: 296 ]]
        -- upvalues: u51 (copy)
        if p52 == Enum.UserInputState.Begin then
            u51:SelectMenuItem();
        end;
    end, false, Enum.KeyCode.Return, Enum.KeyCode.ButtonA);
    u51:SubscribeToScreen();
    u51.Instance.Screen.Song.Volume = 0.5;
    u51.Maid:Mark(function() --[[ Line: 305 ]]
        -- upvalues: l__ContextActionService__5 (ref)
        l__ContextActionService__5:UnbindAction("Rythm");
        l__ContextActionService__5:UnbindAction("Select");
    end);
end;
function v4.CreateObject(p53, p54, p55) --[[ Line: 311 ]]
    -- upvalues: u7 (copy)
    local v56 = u7[p55.x];
    local v57 = game.ReplicatedStorage.Assets.Interface.Rhythm[`Lane{v56}`]:Clone();
    v57.Parent = p53.Instance.Screen.DetailsGui.Main.Body[`Track{v56}`];
    table.insert(p53.NoteInstances, v57);
    return {
        Lane = v56,
        UIInstance = v57,
        TimePosition = p55.time / 1000,
        HitObjectIndex = p54
    };
end;
function v4.ReplaceHitObjectWithNext(p58, p59) --[[ Line: 327 ]]
    local _ = p59.HitObjectIndex;
    p59.UIInstance:Destroy();
    table.remove(p58.HitObjects, table.find(p58.HitObjects, p59));
    if p58.HitObjects[39] then
        local v60 = p58.HitObjects[39].HitObjectIndex + 1;
        local v61 = p58.SongData.HitObjects[v60];
        if v61 then
            table.insert(p58.HitObjects, p58:CreateObject(v60, v61));
        end;
    end;
end;
function v4.Client.LoadSong(u62) --[[ Line: 339 ]]
    -- upvalues: l__Mince__6 (copy)
    if u62.Connection then
        u62.Connection:Disconnect();
    end;
    local l__Song__10 = u62.Instance.Screen.Song;
    u62.SongData = l__Mince__6.Config.RythmSongMaps[u62.ReplicatedState.Song];
    l__Song__10.Volume = 0.5;
    repeat
        wait();
    until l__Song__10.IsLoaded == true;
    u62.Connection = l__Song__10.Played:Once(function() --[[ Line: 349 ]]
        -- upvalues: u62 (copy)
        u62.HitObjects = {};
        for v63 = 1, 40 do
            u62.HitObjects[v63] = u62:CreateObject(v63, u62.SongData.HitObjects[v63]);
        end;
    end);
    u62.Server:SetLoaded();
end;
function v4.SpectateStart(u64) --[[ Line: 360 ]]
    -- upvalues: l__Mince__6 (copy), l__TweenService__2 (copy)
    u64.SongData = l__Mince__6.Config.RythmSongMaps[u64.ReplicatedState.Song];
    if u64.ReplicatedState.CurrentState == "Started" then
        u64.Instance.Screen.SplashGui.Enabled = false;
        u64.Instance.Screen.DetailsGui.Enabled = true;
        u64.Instance.Screen.BackgroundGui.Enabled = true;
        l__TweenService__2:Create(u64.Instance.Screen.Song, TweenInfo.new(1), {
            Volume = 0.5
        }):Play();
        u64:UpdateMeterImage(false);
    end;
    local v65 = u64:WatchStateChange("CurrentState", function() --[[ Line: 372 ]]
        -- upvalues: u64 (copy), l__TweenService__2 (ref)
        if u64.ReplicatedState.CurrentState == "Started" then
            u64.Instance.Screen.SplashGui.Enabled = false;
            u64.Instance.Screen.DetailsGui.Enabled = true;
            u64.Instance.Screen.BackgroundGui.Enabled = true;
            l__TweenService__2:Create(u64.Instance.Screen.Song, TweenInfo.new(1), {
                Volume = 0.5
            }):Play();
            u64:UpdateMeterImage(false);
        else
            u64.Instance.Screen.SplashGui.Enabled = true;
            u64.Instance.Screen.DetailsGui.Enabled = false;
            u64.Instance.Screen.BackgroundGui.Enabled = false;
        end;
    end);
    u64.SpectateMaid:Mark(v65);
end;
function v4.SpectateEnd(p66) --[[ Line: 404 ]]
    -- upvalues: l__TweenService__2 (copy)
    p66.Instance.Screen.SplashGui.Enabled = true;
    p66.Instance.Screen.DetailsGui.Enabled = false;
    p66.Instance.Screen.BackgroundGui.Enabled = false;
    l__TweenService__2:Create(p66.Instance.Screen.Song, TweenInfo.new(1), {
        Volume = 0
    }):Play();
end;
function v4.Enter(p67) --[[ Line: 416 ]]
    -- upvalues: u3 (copy), l__LocalPlayer__1 (copy), l__TweenService__2 (copy), l__Mince__6 (copy), u1 (copy)
    p67:StartInspect("Waiting for players..");
    u3.StartInteractions();
    p67.MobileUi = l__LocalPlayer__1.PlayerGui:WaitForChild("Rythm");
    p67.MobileUi.SelectMenu.Visible = false;
    p67.MobileUi.Controls.Visible = false;
    p67.Instance.Screen.Song.Volume = 0.5;
    l__TweenService__2:Create(p67.Instance.Screen.Song, TweenInfo.new(1), {
        Volume = 0.5
    }):Play();
    if l__Mince__6.Config.Humanoid then
        l__Mince__6.Config.Humanoid:UnequipTools();
    end;
    local l__Animator__11 = l__LocalPlayer__1.Character.Humanoid.Animator;
    p67.Animations = {
        Win = l__Animator__11:LoadAnimation(script.Victory),
        Lose = l__Animator__11:LoadAnimation(script.Defeat),
        Up = l__Animator__11:LoadAnimation(script.Up),
        Down = l__Animator__11:LoadAnimation(script.Down),
        Left = l__Animator__11:LoadAnimation(script.Left),
        Right = l__Animator__11:LoadAnimation(script.Right),
        Idle = l__Animator__11:LoadAnimation(script.Idle)
    };
    p67.NoteInstances = {};
    p67.MovementAnimations = {};
    for _, v68 in {
        "Up",
        "Down",
        "Left",
        "Right"
    } do
        p67.Animations[v68]:AdjustSpeed(2);
        table.insert(p67.MovementAnimations, p67.Animations[v68]);
    end;
    local v69 = u1.GetMode();
    if v69 == "VR" or v69 == "Mobile" then
        p67:ConnectMobileControls();
    else
        p67:DisconnectMobileControls();
    end;
end;
function v4.Start(p70) --[[ Line: 464 ]]
    p70:StopInspect();
    local v71 = p70:GetLocalSlot();
    if not v71 then
        error("Could not retrieve your slot!");
    end;
    p70:DistanceRoundedCameraPan(p70.Instance.Players[v71].Camera.WorldCFrame);
    p70.Instance.Screen.DetailsGui.AlwaysOnTop = true;
    game.Players.LocalPlayer.Character:PivotTo(p70.Instance.Players[v71]:FindFirstChild("Position").WorldCFrame * CFrame.Angles(0, -1.5707963267948966, 0));
    p70.Animations.Idle:Play();
    if p70.Connection then
        p70.Connection:Disconnect();
    end;
    p70:Hook();
    p70:HandleMenu();
end;
function v4.Complete(u72, p73, p74) --[[ Line: 489 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u2 (copy)
    warn("Completion!", p73, p74);
    u72.UpdateOpponent = false;
    u72.CanPlay = false;
    if p74 then
        if p74 == "Draw" then
            u72:TimedInspect("It\'s a tie!", 3);
        elseif p74:IsA("Player") then
            u72:TimedInspect(`The winner of this game is {p74.Name}!`, 3);
        end;
    end;
    if p74 == l__LocalPlayer__1 then
        u2.PlaySound("Rythm.Win");
        u72.Animations.Win:Play();
    else
        u2.PlaySound("Rythm.Lose");
        u72.Animations.Lose:Play();
    end;
    task.wait(1);
    local v75 = u72:GetFirstOpponent();
    if v75 then
        local l__Character__12 = v75.Character;
        if l__Character__12 then
            l__Character__12 = v75.Character:FindFirstChild("HumanoidRootPart");
        end;
        if l__Character__12 then
            local u76 = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, l__Character__12.Position);
            task.spawn(function() --[[ Line: 523 ]]
                -- upvalues: u72 (copy), u76 (copy)
                u72:CameraPan(u76);
            end);
        end;
    end;
end;
function v4.ProcessInterfaceItem(u77, u78) --[[ Line: 531 ]]
    -- upvalues: u7 (copy)
    if u7[u78.Name] then
        local v79 = u78.MouseButton1Down:Connect(function() --[[ Line: 533 ]]
            -- upvalues: u77 (copy), u78 (copy)
            u77:ProcessInput(false, Enum.UserInputState.Begin, {
                KeyCode = Enum.KeyCode[u78.Name]
            });
        end);
        local v80 = u78.MouseButton1Up:Connect(function() --[[ Line: 537 ]]
            -- upvalues: u77 (copy), u78 (copy)
            u77:ProcessInput(false, Enum.UserInputState.End, {
                KeyCode = Enum.KeyCode[u78.Name]
            });
        end);
        table.insert(u77.MobileConnections, v79);
        table.insert(u77.MobileConnections, v80);
    else
        if u78.Name == "Select" then
            local v81 = u78.MouseButton1Down:Connect(function() --[[ Line: 544 ]]
                -- upvalues: u77 (copy)
                u77:SelectMenuItem();
            end);
            table.insert(u77.MobileConnections, v81);
        end;
    end;
end;
function v4.ConnectMobileControls(p82) --[[ Line: 552 ]]
    p82.MobileConnections = {};
    for _, v83 in p82.MobileUi.SelectMenu:GetChildren() do
        p82:ProcessInterfaceItem(v83);
    end;
    for _, v84 in p82.MobileUi.Controls:GetChildren() do
        p82:ProcessInterfaceItem(v84);
    end;
    p82.MobileUi.Enabled = true;
end;
function v4.DisconnectMobileControls(p85) --[[ Line: 566 ]]
    if p85.MobileConnections then
        for _, v86 in p85.MobileConnections do
            v86:Disconnect();
        end;
        p85.MobileUi.Enabled = false;
    end;
end;
function v4.Exit(p87) --[[ Line: 576 ]]
    -- upvalues: u3 (copy)
    p87.Instance.Screen.Song.Volume = 0;
    p87.Instance.Screen.Song:Stop();
    p87:DisconnectMobileControls();
    p87.MobileUi.SelectMenu.Visible = false;
    p87.MobileUi.Controls.Visible = false;
    u3.EndInteractions();
    p87:DistanceLinearRevertCamera();
    p87:UnlockPlayerMovement();
    for _, v88 in p87.Animations do
        v88:AdjustWeight(1);
        task.wait(1);
        v88:Stop();
    end;
    p87.Instance.Screen.DetailsGui.AlwaysOnTop = false;
end;
function v4.HandleMenu(p89) --[[ Line: 598 ]]
    -- upvalues: l__TweenService__2 (copy)
    local l__SongList__13 = p89.Instance.Screen.MenuGui.SongList;
    p89.Instance.Screen.SplashGui.Enabled = false;
    l__SongList__13.Parent.Enabled = true;
    l__SongList__13.Hint.Visible = true;
    l__SongList__13.Hint.GroupTransparency = 0;
    if p89.ReplicatedState.SelectingPlayer == p89:GetSlot(game.Players.LocalPlayer) then
        p89.MobileUi.SelectMenu.Visible = true;
        p89.MobileUi.Controls.Visible = false;
        l__SongList__13.Hint.Subtitle.Visible = true;
        l__SongList__13.Hint.ImageLabel.Visible = true;
        l__SongList__13.Hint.Title.Text = "use ( arrow keys )";
        task.wait(1);
        p89.Instance.Screen.SplashGui.SongList.Hint.Title.Text = "Waiting for players...";
        l__TweenService__2:Create(l__SongList__13.Hint, TweenInfo.new(1), {
            GroupTransparency = 1
        }):Play();
        p89.MenuEnabled = true;
        p89.CurrentMenu = l__SongList__13.SongMenu.Sublist;
        p89:SetMenuSelection(1);
    else
        l__SongList__13.Hint.Subtitle.Visible = false;
        l__SongList__13.Hint.ImageLabel.Visible = false;
        l__SongList__13.Hint.Title.Text = "Your opponent is picking a song...";
    end;
end;
function v4.PopulateSongMenu(p90) --[[ Line: 627 ]]
    -- upvalues: l__Mince__6 (copy), l__TweenService__2 (copy), u6 (copy)
    local v91 = 1;
    for v92, v93 in l__Mince__6.Config.RythmSongMaps do
        local v94 = p90.Instance.Screen.MenuGui.SongList.SongMenu.Sublist.Template:Clone();
        v94.Visible = true;
        v94.Name = `MenuItem{v91}`;
        v94.NameTitle.Text = v93.Name;
        v94.Score.Text = v93.Artist;
        v94.Parent = p90.Instance.Screen.MenuGui.SongList.SongMenu.Sublist;
        v94:SetAttribute("SongName", v92);
        v91 = v91 + 1;
    end;
    p90.BeatTween = l__TweenService__2:Create(p90.Instance.Screen.MenuGui.SongList, u6, {
        Size = UDim2.fromScale(1, 1)
    });
end;
function v4.SetMenuSelection(u95, p96) --[[ Line: 644 ]]
    -- upvalues: u2 (copy), l__Mince__6 (copy)
    if u95.CurrentMenu:FindFirstChild((`MenuItem{p96}`)) then
        if u95.CurrentSelection then
            u95.SelectedInstance.Selected.Visible = false;
        end;
        u2.PlaySound("Rythm.Select");
        u95.CurrentSelection = p96;
        u95.SelectedInstance = u95.CurrentMenu[`MenuItem{u95.CurrentSelection}`];
        u95.SelectedInstance.Selected.Visible = true;
        if u95.CurrentMenu == u95.Instance.Screen.MenuGui.SongList.SongMenu.Sublist then
            local v97 = l__Mince__6.Config.RythmSongMaps[u95.SelectedInstance:GetAttribute("SongName")];
            u95.Instance.Screen.Song.SoundId = v97.ID;
            u95.Instance.Screen.Song:Play();
            u95.Instance.Screen.Song.Loaded:Once(function() --[[ Line: 663 ]]
                -- upvalues: u95 (copy)
                local l__TimeLength__14 = u95.Instance.Screen.Song.TimeLength;
                u95.CurrentMenu.Parent.Parent.Details.TimeLength.Text = string.format("%02d:%02d", math.floor(l__TimeLength__14 / 60), l__TimeLength__14 % 60);
            end);
            u95.CurrentMenu.Parent.Parent.Details.Length.Text = `{v97.Difficulty}`;
            u95.CurrentMenu.Parent.Parent.Details.Difficulty.Text = v97.Bpm;
            u95:ChangeSongBeatSync(v97.Bpm);
        end;
    end;
end;
function v4.MoveToDifficultyMenu(u98) --[[ Line: 674 ]]
    -- upvalues: l__TweenService__2 (copy), u2 (copy)
    u98.SelectedSong = u98.SelectedInstance:GetAttribute("SongName");
    local l__DifficultyMenu__15 = u98.Instance.Screen.MenuGui.SongList.DifficultyMenu;
    u98.CurrentMenu = l__DifficultyMenu__15.Sublist;
    u98:SetMenuSelection(1);
    local v99 = l__TweenService__2:Create(l__DifficultyMenu__15, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0.2, 0.5),
        GroupColor3 = Color3.new(1, 1, 1)
    });
    v99:Play();
    v99.Completed:Wait();
    u2.PlaySound("Rythm.Submit1");
    l__DifficultyMenu__15.ZIndex = 3;
    u98.CurrentMenu.Parent.GroupColor3 = Color3.fromRGB(30, 30, 30);
    l__TweenService__2:Create(l__DifficultyMenu__15, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Position = UDim2.fromScale(0.1, 0.5),
        GroupColor3 = Color3.new(1, 1, 1)
    }):Play();
    u98.Maid:Mark(function() --[[ Line: 705 ]]
        -- upvalues: u98 (copy), l__DifficultyMenu__15 (copy)
        local l__SongMenu__16 = u98.Instance.Screen.MenuGui.SongList.SongMenu;
        l__DifficultyMenu__15.ZIndex = 0;
        l__DifficultyMenu__15.GroupColor3 = Color3.fromRGB(30, 30, 30);
        l__SongMenu__16.GroupColor3 = Color3.fromRGB(255, 255, 255);
        u98.CurrentMenu = nil;
        u98.MenuEnabled = false;
    end);
end;
function v4.ChangeSongBeatSync(u100, p101) --[[ Line: 715 ]]
    -- upvalues: l__rbxbpm__7 (copy)
    if not u100.Bpm then
        u100.Bpm = l__rbxbpm__7.new(u100.Instance.Screen.Song);
        u100.Bpm.OnBeat:Connect(function() --[[ Line: 718 ]]
            -- upvalues: u100 (copy)
            u100.Instance.Screen.MenuGui.SongList.Size = UDim2.fromScale(1.03, 1.03);
            u100.BeatTween:Play();
        end);
    end;
    u100.Bpm:SetBpm(p101);
end;
function v4.SubmitOptions(p102) --[[ Line: 727 ]]
    -- upvalues: u2 (copy), l__ContextActionService__5 (copy)
    u2.PlaySound("Rythm.Submit2");
    local l__DifficultyMenu__17 = p102.Instance.Screen.MenuGui.SongList.DifficultyMenu;
    local l__SongMenu__18 = p102.Instance.Screen.MenuGui.SongList.SongMenu;
    l__DifficultyMenu__17.ZIndex = 0;
    l__DifficultyMenu__17.GroupColor3 = Color3.fromRGB(30, 30, 30);
    l__SongMenu__18.GroupColor3 = Color3.fromRGB(255, 255, 255);
    p102.CurrentMenu = nil;
    p102.MenuEnabled = false;
    p102.Instance.Screen.Song:Stop();
    p102.Instance.Screen.SplashGui.Enabled = true;
    p102.Instance.Screen.MenuGui.Enabled = false;
    p102.SelectedDifficulty = p102.SelectedInstance:GetAttribute("Option");
    p102.Server:SetSongData(p102.SelectedSong, p102.SelectedDifficulty);
    l__ContextActionService__5:UnbindAction("Select");
    p102.MobileUi.SelectMenu.Visible = false;
end;
function v4.Client.Countdown(p103) --[[ Line: 751 ]]
    -- upvalues: u2 (copy), l__TweenService__2 (copy)
    local l__BackgroundGui__19 = p103.Instance.Screen.BackgroundGui;
    local l__DetailsGui__20 = p103.Instance.Screen.DetailsGui;
    local v104 = TweenInfo.new(1, Enum.EasingStyle.Quad);
    u2.PlaySound("Rythm.Countdown");
    p103.Instance.Screen.SplashGui.Enabled = false;
    p103.Instance.Screen.MenuGui.Enabled = false;
    l__DetailsGui__20.Enabled = true;
    l__BackgroundGui__19.Enabled = true;
    for v105 = 1, 2 do
        l__BackgroundGui__19.Main[`Player{v105}`].AnchorPoint = Vector2.new(2 - v105, 0);
        l__TweenService__2:Create(l__BackgroundGui__19.Main[`Player{v105}`], v104, {
            AnchorPoint = Vector2.new(v105 == 2 and 1 or 0, 0)
        }):Play();
    end;
    l__DetailsGui__20.Main.Body.Top.Position = UDim2.fromScale(0.5, -0.2);
    l__TweenService__2:Create(l__DetailsGui__20.Main.Body.Top, v104, {
        Position = UDim2.fromScale(0.5, 0.05)
    }):Play();
    l__BackgroundGui__19.Hint.Title.Text = `{1}`;
    task.wait(1);
    l__BackgroundGui__19.Hint.Title.Text = `{2}`;
    task.wait(1);
    l__BackgroundGui__19.Hint.Title.Text = "Go!";
    task.wait(1);
    p103.MobileUi.SelectMenu.Visible = false;
    p103.MobileUi.Controls.Visible = true;
    l__BackgroundGui__19.Hint.Title.Text = "";
    p103.NoteSpeed = 1500 * p103.ReplicatedState.NoteSpeedMult;
end;
function v4.SelectMenuItem(p106) --[[ Line: 786 ]]
    if p106.ReplicatedState.SelectingPlayer == p106:GetSlot(game.Players.LocalPlayer) then
        if p106.CurrentMenu == p106.Instance.Screen.MenuGui.SongList.SongMenu.Sublist then
            p106:MoveToDifficultyMenu();
        else
            p106:SubmitOptions();
        end;
    end;
end;
return v4;
