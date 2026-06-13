-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.ArmWrestling
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__LocalPlayer__2 = l__Players__1.LocalPlayer;
local _ = workspace.CurrentCamera;
l__LocalPlayer__2:GetMouse();
game:GetService("Debris");
game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__ContextActionService__4 = game:GetService("ContextActionService");
local l__UserInputService__5 = game:GetService("UserInputService");
local _ = l__ReplicatedStorage__3.Assets.Minigame.TicTacToe;
game:GetService("RunService");
local l__Mince__6 = require(l__ReplicatedStorage__3.Modules.Mince);
local u1 = l__Mince__6:Get("BindManager");
local u2 = l__Mince__6:Get("SoundHandler");
local u3 = l__Mince__6:Get("SelectInteractor");
local u4 = l__Mince__6:Get("InterfaceHandler");
local u5 = l__Mince__6:Get("Locomotion");
local v6 = {
    Streak = 0,
    Progress = 1,
    Locked = false,
    Combo = {},
    Client = {}
};
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = {
    Win = nil,
    Lose = nil,
    Idle = nil
};
local l__HeadShot__7 = Enum.ThumbnailType.HeadShot;
local l__Size150x150__8 = Enum.ThumbnailSize.Size150x150;
local u12 = {
    [0] = 4,
    [3] = 6,
    [7] = 8
};
local u13 = {
    UP = { Enum.KeyCode.W, Enum.KeyCode.Up, Enum.KeyCode.DPadUp },
    LEFT = { Enum.KeyCode.A, Enum.KeyCode.Left, Enum.KeyCode.DPadLeft },
    DOWN = { Enum.KeyCode.S, Enum.KeyCode.Down, Enum.KeyCode.DPadDown },
    RIGHT = { Enum.KeyCode.D, Enum.KeyCode.Right, Enum.KeyCode.DPadRight }
};
local u14 = {
    UP = -90,
    DOWN = 90,
    RIGHT = 0,
    LEFT = 180
};
local u15 = {
    "UP",
    "DOWN",
    "RIGHT",
    "LEFT"
};
function v6.UpdateMeterImage(p16, p17) --[[ Line: 112 ]]
    -- upvalues: l__Players__1 (copy), l__HeadShot__7 (copy), l__Size150x150__8 (copy), u10 (ref)
    local v18 = l__Players__1:GetUserThumbnailAsync(p16.Slots[1].UserId, l__HeadShot__7, l__Size150x150__8);
    local v19 = l__Players__1:GetUserThumbnailAsync(p16.Slots[2].UserId, l__HeadShot__7, l__Size150x150__8);
    u10.Player.Image = p17 and v19 and v19 or v18;
    local l__Opponent__9 = u10.Opponent;
    if p17 then
        v19 = v18 or v19;
    end;
    l__Opponent__9.Image = v19;
end;
function v6.UpdateMeter(p20, p21, p22) --[[ Line: 129 ]]
    -- upvalues: u10 (ref)
    if (p22 or p20:GetLocalSlot()) == 2 then
        p21 = -p21;
    end;
    u10.Container.Arrow:TweenPosition(UDim2.fromScale(0.5, (p21 + 10) / 20), "Out", "Linear", 0.5, true);
end;
function v6.Generate(p23) --[[ Line: 147 ]]
    -- upvalues: u9 (ref), u12 (copy), u15 (copy), u14 (copy)
    u9.Visible = true;
    p23.Combo = {};
    p23.Progress = 1;
    for _, v24 in u9:GetChildren() do
        if v24:IsA("ImageLabel") then
            v24:Destroy();
        end;
    end;
    local v25 = u12;
    local l__Streak__10 = p23.Streak;
    local v26 = 0;
    for v27, v28 in v25 do
        if v27 <= l__Streak__10 and v26 < v28 then
            v26 = v28;
        end;
    end;
    for v29 = 1, v26 do
        local v30 = u15[math.random(1, #u15)];
        local v31 = u14[v30];
        local v32 = u9.Layout.Template:Clone();
        v32.Name = v29;
        v32.ImageLabel.Rotation = v31;
        v32.Parent = u9;
        table.insert(p23.Combo, v30);
    end;
end;
function v6.HandleInput(p33, p34) --[[ Line: 175 ]]
    -- upvalues: u2 (copy), u9 (ref)
    if p33.Locked then
        if p33.Streak == 0 then
            u2.PlaySound("TicTacToe.Error");
        end;
    elseif p33.Combo[p33.Progress] == p34 then
        local v35 = u9:FindFirstChild(p33.Progress);
        v35.ImageLabel.ImageTransparency = 0;
        v35.ImageLabel.ImageColor3 = Color3.new(1, 1, 1);
        if #p33.Combo == p33.Progress then
            p33.Locked = true;
            p33.Server:Attack(p33.Streak);
            u2.PlaySound("important");
            task.wait(0.1);
            p33:Generate();
            p33.Streak = p33.Streak + 1;
            p33.Locked = false;
        else
            u2.PlaySound("TicTacToe.Hover");
            p33.Progress = p33.Progress + 1;
        end;
    else
        local v36 = os.clock();
        for _, v37 in u9:GetChildren() do
            if v37:IsA("ImageLabel") then
                v37.ImageLabel.ImageTransparency = 0;
                v37.ImageLabel.ImageColor3 = Color3.new(1, 0, 0);
            end;
        end;
        p33.Locked = true;
        p33.Streak = 0;
        u2.PlaySound("TicTacToe.Error");
        repeat
            u9.Visible = not u9.Visible;
            u2.PlaySound("TicTacToe.Error");
            task.wait(0.3);
        until os.clock() - v36 > 3;
        p33:Generate();
        p33.Locked = false;
    end;
end;
function v6.Hook(u38) --[[ Line: 227 ]]
    -- upvalues: u5 (copy), u8 (ref), l__UserInputService__5 (copy), u13 (copy)
    u5.SetEnabled(false);
    u5.SetUpdating(false);
    u5.Locked = true;
    for _, u39 in u8:GetChildren() do
        if u39:IsA("ImageButton") then
            local v40 = u39.MouseButton1Down:Connect(function() --[[ Line: 235 ]]
                -- upvalues: u38 (copy), u39 (copy)
                u38:HandleInput(u39.Name);
            end);
            u38.Maid:Mark(v40);
        end;
    end;
    local v44 = l__UserInputService__5.InputBegan:Connect(function(p41, _) --[[ Line: 243 ]]
        -- upvalues: u13 (ref), u38 (copy)
        for v42, v43 in u13 do
            if table.find(v43, p41.KeyCode) then
                u38:HandleInput(v42);
            end;
        end;
    end);
    u38.Maid:Mark(v44);
end;
function v6.Construct(p45) --[[ Line: 255 ]]
    -- upvalues: u7 (ref), u4 (copy), u8 (ref), u10 (ref), u9 (ref)
    for _, v46 in p45.Instance.Players:GetChildren() do
        p45:AddProximityJoinSource(v46:WaitForChild("Position"), (tonumber(v46.Name)));
    end;
    u7 = u4.GetScreenGui("ArmWrestling");
    u8 = u7.Controls;
    u10 = u7.Meter;
    u9 = u7.Combination;
end;
function v6.SpectateStart(u47) --[[ Line: 269 ]]
    -- upvalues: u7 (ref)
    local v48 = u47:WatchStateChange("Score", function() --[[ Line: 273 ]]
        -- upvalues: u47 (copy)
        u47:UpdateMeter(u47.ReplicatedState.Score, 1);
    end);
    local v49 = u47:WatchStateChange("CurrentState", function() --[[ Line: 278 ]]
        -- upvalues: u47 (copy), u7 (ref)
        if u47.ReplicatedState.CurrentState == "Started" then
            u7.Enabled = true;
            u47:UpdateMeterImage(false);
        else
            u7.Enabled = false;
        end;
    end);
    u47.SpectateMaid:Mark(v49);
    u47.SpectateMaid:Mark(v48);
end;
function v6.SpectateEnd(_) --[[ Line: 293 ]]
    -- upvalues: u7 (ref)
    u7.Enabled = false;
end;
function v6.Enter(p50) --[[ Line: 298 ]]
    -- upvalues: u3 (copy), u11 (ref), l__LocalPlayer__2 (copy), l__Mince__6 (copy)
    p50:StartInspect("Waiting for players..");
    u3.StartInteractions();
    if not u11.Idle then
        local l__Humanoid__11 = l__LocalPlayer__2.Character.Humanoid;
        local l__Animator__12 = l__Humanoid__11.Animator;
        for _, v51 in script:GetChildren() do
            if v51:IsA("Animation") then
                u11[v51.Name] = l__Animator__12:LoadAnimation(v51);
            end;
        end;
        local v52 = l__Humanoid__11.Died:Connect(function() --[[ Line: 313 ]]
            -- upvalues: u11 (ref)
            u11 = {};
        end);
        p50.Maid:Mark(v52);
    end;
    if l__Mince__6.Config.Humanoid then
        l__Mince__6.Config.Humanoid:UnequipTools();
    end;
end;
function v6.Start(u53) --[[ Line: 325 ]]
    -- upvalues: u1 (copy), u8 (ref), l__ContextActionService__4 (copy), u7 (ref), u11 (ref)
    u53:StopInspect();
    u53:GetSlot();
    local v54 = u1.GetMode();
    if v54 == "VR" or v54 == "Mobile" then
        u8.Visible = true;
    else
        u8.Visible = false;
    end;
    local v55 = u53:WatchStateChange("Score", function() --[[ Line: 337 ]]
        -- upvalues: u53 (copy)
        u53:UpdateMeter(u53.ReplicatedState.Score);
    end);
    l__ContextActionService__4:BindActionAtPriority("DisableArrowKeys", function() --[[ Line: 341 ]]
        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Left, Enum.KeyCode.Right);
    u53:UpdateMeterImage(false);
    u53:Hook();
    u53:Generate();
    u7.Enabled = true;
    u11.Idle:Play();
    u53.Maid:Mark(v55);
end;
function v6.Complete(u56, p57, p58) --[[ Line: 354 ]]
    -- upvalues: l__LocalPlayer__2 (copy), u2 (copy), u11 (ref)
    warn("Completion!", p57, p58);
    if p58 == "Draw" then
        u56:TimedInspect("It\'s a tie!", 3);
    elseif p58:IsA("Player") then
        u56:TimedInspect(`The winner of this game is {p58.Name}!`, 3);
    end;
    local _ = l__LocalPlayer__2.Character.Humanoid.Animator;
    if p58 == l__LocalPlayer__2 then
        u2.PlaySound("TicTacToe.Win");
        u11.Win:Play();
    else
        u2.PlaySound("TicTacToe.Lose");
        u11.Lose:Play();
    end;
    task.wait(1);
    local v59 = u56:GetFirstOpponent();
    if v59 then
        local l__Character__13 = v59.Character;
        if l__Character__13 then
            l__Character__13 = v59.Character:FindFirstChild("HumanoidRootPart");
        end;
        if l__Character__13 then
            local u60 = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, l__Character__13.Position);
            task.spawn(function() --[[ Line: 388 ]]
                -- upvalues: u56 (copy), u60 (copy)
                u56:CameraPan(u60);
            end);
        end;
    end;
end;
function v6.Exit(p61) --[[ Line: 397 ]]
    -- upvalues: u3 (copy), l__ContextActionService__4 (copy), u7 (ref), u11 (ref), u9 (ref), u5 (copy)
    u3.EndInteractions();
    l__ContextActionService__4:UnbindAction("DisableArrowKeys");
    u7.Enabled = false;
    u11.Idle:Stop();
    for _, v62 in u9:GetChildren() do
        if v62:IsA("ImageLabel") then
            v62:Destroy();
        end;
    end;
    u5.SetEnabled(true);
    u5.SetUpdating(true);
    u5.Locked = false;
    p61.Streak = 0;
    p61:DistanceLinearRevertCamera();
    p61:UnlockPlayerMovement();
end;
return v6;
