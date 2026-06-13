-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.BPong
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__CurrentCamera__2 = workspace.CurrentCamera;
l__LocalPlayer__1:GetMouse();
local l__Debris__3 = game:GetService("Debris");
game:GetService("Chat");
game:GetService("TweenService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__UserInputService__5 = game:GetService("UserInputService");
local l__RunService__6 = game:GetService("RunService");
local l__BPong__7 = l__ReplicatedStorage__4.Assets.Minigame.BPong;
local l__Mince__8 = require(l__ReplicatedStorage__4.Modules.Mince);
local u1 = l__Mince__8:Get("BindManager");
local u2 = l__Mince__8:Get("SoundHandler");
l__Mince__8:Get("InterfaceHandler");
local u3 = l__Mince__8:Get("SelectInteractor");
local v4 = {
    Mode = 1,
    Speed = 0.25,
    Clicked = false,
    Client = {}
};
local u5 = Vector3.new(0, -workspace.Gravity, 0);
local u6 = { Instance.new("Attachment", workspace.Terrain), Instance.new("Attachment", workspace.Terrain) };
local u7 = Instance.new("Beam");
u7.Color = ColorSequence.new(Color3.new(0, 1, 0));
u7.Width0 = 0.2;
u7.Width1 = 0.2;
u7.TextureSpeed = -0.5;
u7.TextureMode = Enum.TextureMode.Static;
u7.TextureLength = 0.3;
u7.Texture = "rbxassetid://3371283711";
u7.Attachment0 = u6[2];
u7.Attachment1 = u6[1];
u7.Parent = l__CurrentCamera__2;
function v4.BeamProjectile(_, p8, p9, p10, p11) --[[ Line: 52 ]]
    local v12 = 0.5 * p8 * p11 * p11 + p9 * p11 + p10;
    local v13 = v12 - (p8 * p11 * p11 + p9 * p11) / 3;
    local v14 = (0.125 * p8 * p11 * p11 + 0.5 * p9 * p11 + p10 - 0.125 * (p10 + v12)) / 0.375 - v13;
    local l__Magnitude__9 = (v14 - p10).Magnitude;
    local l__Magnitude__10 = (v13 - v12).Magnitude;
    local l__Unit__11 = (p10 - v12).Unit;
    local l__Unit__12 = (v14 - p10).Unit;
    local l__Unit__13 = l__Unit__12:Cross(l__Unit__11).Unit;
    local l__Unit__14 = (v13 - v12).Unit;
    local l__Unit__15 = l__Unit__14:Cross(l__Unit__11).Unit;
    local l__Unit__16 = l__Unit__13:Cross(l__Unit__12).Unit;
    local v15 = CFrame.new(p10.x, p10.y, p10.z, l__Unit__12.x, l__Unit__13.x, l__Unit__16.x, l__Unit__12.y, l__Unit__13.y, l__Unit__16.y, l__Unit__12.z, l__Unit__13.z, l__Unit__16.z);
    local v16 = CFrame.new(v12.x, v12.y, v12.z, l__Unit__14.x, l__Unit__15.x, l__Unit__16.x, l__Unit__14.y, l__Unit__15.y, l__Unit__16.y, l__Unit__14.z, l__Unit__15.z, l__Unit__16.z);
    return l__Magnitude__9, -l__Magnitude__10, v15, v16;
end;
function v4.SimulateProjectile(_, p17, p18, p19, p20) --[[ Line: 85 ]]
    -- upvalues: u5 (copy), l__CurrentCamera__2 (copy), l__RunService__6 (copy), l__Debris__3 (copy)
    local v21 = (p18 - p17 - u5 * 0.5 * p20 * p20) / p20;
    local v22 = p19:Clone();
    v22.CanCollide = true;
    v22.Anchored = true;
    v22.Parent = l__CurrentCamera__2;
    local v23 = 0;
    while v23 < p20 do
        v22.CFrame = CFrame.new(u5 * 0.5 * v23 * v23 + v21 * v23 + p17);
        v23 = v23 + l__RunService__6.RenderStepped:Wait();
    end;
    l__Debris__3:AddItem(v22, 1);
    return v22;
end;
function v4.ListenToProjectile(u24, p25) --[[ Line: 104 ]]
    -- upvalues: l__BPong__7 (copy)
    local u26 = u24:GetLocalSlot();
    p25:Mark((u24:GetStateChangedSignal("Position"):Connect(function() --[[ Line: 108 ]]
        -- upvalues: u24 (copy), u26 (copy), l__BPong__7 (ref)
        local l__Turn__17 = u24.ReplicatedState.Turn;
        if u26 and u26 == l__Turn__17 then
        else
            local l__Position__18 = u24.ReplicatedState.Position;
            local l__Bounds__19 = u24.Instance.Cups[l__Turn__17].Bounds;
            local v27 = l__Position__18.Y <= u24.CupDetectionBound;
            local v28 = u24:SimulateProjectile(l__Bounds__19.PositionMin.WorldPosition, l__Position__18, l__BPong__7.Ball, 0.25);
            if not v27 then
                v28.Anchored = false;
            end;
        end;
    end)));
end;
function v4.Client.TakeOutCup(p29, p30, p31) --[[ Line: 138 ]]
    local v32 = p29.Instance.Cups[p30][p31];
    for v33 = 0, 1, 0.1 do
        for _, v34 in v32:GetDescendants() do
            if v34:IsA("BasePart") then
                v34.LocalTransparencyModifier = v33;
            end;
        end;
        task.wait();
    end;
end;
function v4.Shoot(p35) --[[ Line: 154 ]]
    -- upvalues: u7 (copy), u5 (copy), u6 (copy), l__BPong__7 (copy)
    local v36 = p35:GetLocalSlot();
    local l__Cups__20 = p35.Instance.Cups;
    local v37 = p35.Bounds.RotationMin.WorldPosition - p35.Bounds.RotationMax.WorldPosition;
    local v38 = {
        Min = -v37 / 2,
        Max = v37 / 2
    };
    p35.Mode = 1;
    u7.Enabled = true;
    local v39 = 0;
    local v40 = false;
    local v41 = nil;
    local v42 = nil;
    while p35.Mode < 3 do
        if v39 > 1 or v39 < 0 then
            v40 = not v40;
        end;
        local l__PositionMin__21 = p35.Bounds.PositionMin;
        local l__PositionMax__22 = p35.Bounds.PositionMax;
        local v43 = nil;
        if p35.Clicked then
            p35.Clicked = false;
            v39 = 0.5;
        end;
        if p35.Mode == 1 then
            p35.Speed = v39 * 0.25;
            v43 = l__PositionMin__21.WorldCFrame:Lerp(l__PositionMax__22.WorldCFrame, v39);
            v41 = v43;
        elseif p35.Mode == 2 then
            v42 = v38.Min:Lerp(v38.Max, v39);
            v43 = v41 + v42;
        end;
        local v44, v45, v46, v47 = p35:BeamProjectile(u5, (v43.Position - l__PositionMin__21.WorldPosition - u5 * 0.5 * p35.Speed * p35.Speed) / p35.Speed, l__PositionMin__21.WorldPosition, p35.Speed);
        u7.CurveSize0 = v44;
        u7.CurveSize1 = v45;
        u6[1].CFrame = u6[1].Parent.CFrame:Inverse() * v46;
        u6[2].CFrame = u6[2].Parent.CFrame:Inverse() * v47;
        v39 = v39 + (v40 and -0.01 or 0.01);
        if not p35.Playing then
            return;
        end;
        task.wait(0.01);
    end;
    u7.Enabled = false;
    local l__Position__23 = (v41 + v42).Position;
    local u48 = workspace:Raycast(l__Position__23, Vector3.new(-0, -10, -0), p35.RaycastWhitelist);
    if u48 and (u48.Instance.LocalTransparencyModifier ~= 1 and not u48.Instance:IsDescendantOf(l__Cups__20[v36])) then
        l__Position__23 = u48.Instance.BallFloatPosition.WorldPosition;
    else
        u48 = nil;
    end;
    local l__Server__24 = p35.Server;
    local v49;
    if u48 then
        v49 = u48.Instance.Parent.Name or l__Position__23;
    else
        v49 = l__Position__23;
    end;
    l__Server__24:Throw(v49, p35.Speed);
    local v50 = p35:SimulateProjectile(p35.Bounds.PositionMin.WorldPosition, l__Position__23, l__BPong__7.Ball, p35.Speed);
    if u48 then
        v50.Anchored = true;
        task.delay(1, function() --[[ Line: 245 ]]
            -- upvalues: u48 (ref)
            for v51 = 0, 1, 0.1 do
                for _, v52 in u48.Instance.Parent:GetDescendants() do
                    if v52:IsA("BasePart") then
                        v52.LocalTransparencyModifier = v51;
                    end;
                end;
                task.wait();
            end;
        end);
    else
        v50.Anchored = false;
    end;
end;
function v4.Construct(p53) --[[ Line: 262 ]]
    for _, v54 in p53.Instance.Players:GetChildren() do
        p53:AddProximityJoinSource(v54:WaitForChild("Position"), (tonumber(v54.Name)));
    end;
    local v55 = {};
    local v56 = 0;
    for _, v57 in p53.Instance.Cups:GetDescendants() do
        if v57.Name == "BallFloatPosition" then
            v56 = v57.WorldPosition.Y + 0.5;
            table.insert(v55, v57.Parent);
        end;
    end;
    p53.CupDetectionBound = v56;
    p53.RaycastWhitelist = RaycastParams.new();
    p53.RaycastWhitelist.FilterDescendantsInstances = v55;
    p53.RaycastWhitelist.FilterType = Enum.RaycastFilterType.Include;
end;
function v4.Start(u58) --[[ Line: 283 ]]
    -- upvalues: u1 (copy), l__UserInputService__5 (copy)
    u58:StopInspect();
    local u59 = u58:GetLocalSlot();
    local v60 = u58.Instance.Cups[u59];
    if not u59 then
        error("Could not retrieve your slot!");
    end;
    u58:DistanceRoundedCameraPan(u58.Instance.Players[u59].Camera.WorldCFrame);
    u58.Bounds = v60.Bounds;
    local v62 = u58:WatchStateChange("Turn", function() --[[ Line: 295 ]]
        -- upvalues: u58 (copy), u59 (copy)
        local l__Turn__25 = u58.ReplicatedState.Turn;
        local v61 = u58.Slots[l__Turn__25];
        if v61 then
            u58.Turn = l__Turn__25;
            u58:TimedInspect(`It's {v61.Name}'s turn!`, 3);
            if u58.Turn == u59 then
                u58:Shoot();
            end;
        end;
    end);
    local v65 = u1.Get("Interact").OnAction:Connect(function(p63) --[[ Line: 311 ]]
        -- upvalues: u58 (copy)
        if p63 == Enum.UserInputState.Begin then
            u58.Clicked = true;
            local v64 = u58;
            v64.Mode = v64.Mode + 1;
        end;
    end);
    local v67 = l__UserInputService__5.TouchTapInWorld:Connect(function() --[[ Line: 318 ]]
        -- upvalues: u58 (copy)
        u58.Clicked = true;
        local v66 = u58;
        v66.Mode = v66.Mode + 1;
    end);
    u58.Playing = true;
    u58:ListenToProjectile(u58.Maid);
    u58.Maid:Mark(v65);
    u58.Maid:Mark(v67);
    u58.Maid:Mark(v62);
end;
function v4.SpectateStart(p68) --[[ Line: 330 ]]
    p68:ListenToProjectile(p68.SpectateMaid);
end;
function v4.Enter(p69) --[[ Line: 336 ]]
    -- upvalues: u3 (copy), l__Mince__8 (copy)
    p69:StartInspect("Waiting for players..");
    u3.StartInteractions();
    if l__Mince__8.Config.Humanoid then
        l__Mince__8.Config.Humanoid:UnequipTools();
    end;
end;
function v4.Complete(u70, p71) --[[ Line: 345 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u2 (copy)
    if p71 == "Draw" then
        u70:TimedInspect("It\'s a tie!", 3);
    elseif p71:IsA("Player") then
        u70:TimedInspect(`The winner of this game is {p71.Name}!`, 3);
    end;
    local l__Animator__26 = l__LocalPlayer__1.Character.Humanoid.Animator;
    local v72 = {
        Win = l__Animator__26:LoadAnimation(script.Victory),
        Lose = l__Animator__26:LoadAnimation(script.Defeat)
    };
    if p71 == l__LocalPlayer__1 then
        u2.PlaySound("TicTacToe.Win");
        v72.Win:Play();
    else
        u2.PlaySound("TicTacToe.Lose");
        v72.Lose:Play();
    end;
    task.wait(1);
    local v73 = u70:GetFirstOpponent();
    if v73 then
        local l__Character__27 = v73.Character;
        if l__Character__27 then
            l__Character__27 = v73.Character:FindFirstChild("HumanoidRootPart");
        end;
        if l__Character__27 then
            local u74 = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, l__Character__27.Position);
            task.spawn(function() --[[ Line: 381 ]]
                -- upvalues: u70 (copy), u74 (copy)
                u70:CameraPan(u74);
            end);
        end;
    end;
end;
function v4.Exit(p75) --[[ Line: 389 ]]
    -- upvalues: u7 (copy), u3 (copy)
    p75.Playing = false;
    u7.Enabled = false;
    for _, v76 in p75.Instance.Cups:GetDescendants() do
        if v76:IsA("BasePart") then
            v76.LocalTransparencyModifier = 0;
        end;
    end;
    u3.EndInteractions();
    p75:DistanceLinearRevertCamera();
    p75:UnlockPlayerMovement();
end;
return v4;
