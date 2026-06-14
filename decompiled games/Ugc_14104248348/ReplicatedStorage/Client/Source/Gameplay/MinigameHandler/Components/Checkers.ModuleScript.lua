-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.Checkers
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__CurrentCamera__2 = workspace.CurrentCamera;
local u1 = l__LocalPlayer__1:GetMouse();
game:GetService("Debris");
local l__TweenService__3 = game:GetService("TweenService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__UserInputService__5 = game:GetService("UserInputService");
local l__Checkers__6 = l__ReplicatedStorage__4.Assets.Minigame.Checkers;
local l__RunService__7 = game:GetService("RunService");
local l__Mince__8 = require(l__ReplicatedStorage__4.Modules.Mince);
local u2 = l__Mince__8:Get("BindManager");
local u3 = l__Mince__8:Get("SoundHandler");
local u4 = l__Mince__8:Get("SelectInteractor");
local v5 = {
    CanPlay = false,
    Client = {}
};
local u6 = Color3.fromRGB(85, 255, 0);
local u7 = Color3.fromRGB(255, 0, 0);
local u8 = TweenInfo.new(0.1);
local u9 = { l__Checkers__6.White, l__Checkers__6.Black };
local u10 = {
    Default = {
        { -1, -1 },
        { -1, 1 }
    },
    King = {
        { 1, 1 },
        { -1, 1 },
        { 1, -1 },
        { -1, -1 }
    }
};
function v5.FindChipFromLocation(p11, p12, p13) --[[ Line: 53 ]]
    for _, v14 in p11.Instance.Chips:GetChildren() do
        if v14:GetAttribute("Location") == `{p12},{p13}` then
            return v14;
        end;
    end;
end;
function v5.GetChipFromName(p15, p16) --[[ Line: 63 ]]
    return p15.Instance.Chips:FindFirstChild(p16);
end;
function v5.Construct(p17) --[[ Line: 67 ]]
    for _, v18 in p17.Instance.Players:GetChildren() do
        if v18:IsA("Seat") then
            p17:AddSeatJoinSource(v18, (tonumber(v18.Name)));
        else
            p17:AddProximityJoinSource(v18:WaitForChild("Position"), (tonumber(v18.Name)));
        end;
    end;
    local l__Spots__9 = p17.Instance.Board.Spots;
    local _ = p17.Instance.Chips;
    local v19 = l__Spots__9["1"]["1"];
    p17.RaycastWhitelist = RaycastParams.new();
    p17.RaycastWhitelist.FilterDescendantsInstances = l__Spots__9:GetChildren();
    p17.RaycastWhitelist.FilterType = Enum.RaycastFilterType.Include;
    p17.Highlight = script.Highlight;
    p17.DefaultHeight = v19.Position.Y;
    p17.Spots = l__Spots__9;
end;
function v5.GetSpotFromLocation(p20, p21, p22) --[[ Line: 92 ]]
    local v23 = p20.Spots:FindFirstChild(p21);
    if v23 then
        return v23:FindFirstChild(p22);
    end;
end;
function v5.GetMoveDirection(p24, p25) --[[ Line: 100 ]]
    -- upvalues: u9 (copy), u10 (copy)
    local v26 = p25:GetAttribute("King");
    local v27 = p24:GetLocalSlot();
    local v28 = u9[v27];
    local v29 = v27 == 1;
    local v30 = v26 and u10.King or u10.Default;
    local v31 = string.split(p25:GetAttribute("Location"), ",");
    local v32 = v31[1];
    local v33 = v31[2];
    local v34 = {};
    local v35 = {};
    local v36 = false;
    local v37 = false;
    for _, v38 in v30 do
        local v39 = v29 and { -v38[1], -v38[2] } or v38;
        local v40 = p24:GetSpotFromLocation(v32 + v39[1], v33 + v39[2]);
        if v40 then
            local v41 = v40:GetAttribute("OccupiedBy");
            if v41 then
                if not p24:GetChipFromName(v41).Name:match(v28.Name) then
                    local v42 = p24:GetSpotFromLocation(v32 + v39[1] * 2, v33 + v39[2] * 2);
                    if v42 and not v42:GetAttribute("OccupiedBy") then
                        v34[v42] = true;
                        v35[v42] = v40;
                        v34[v40] = true;
                        v36 = true;
                        v37 = true;
                    end;
                end;
            else
                v34[v40] = true;
                v37 = true;
            end;
        end;
    end;
    return v36 and v35, v34, v37;
end;
function v5.SpectateStart(u43) --[[ Line: 160 ]]
    local v45 = u43:WatchStateChange("Turn", function() --[[ Line: 164 ]]
        -- upvalues: u43 (copy)
        local v44 = u43.Slots[u43.ReplicatedState.Turn];
        if v44 then
            u43:TimedInspect(`It's {v44.Name}'s turn!`, 3);
        end;
    end);
    u43.SpectateMaid:Mark(v45);
end;
function v5.Client.SimulateMove(_, p46, p47) --[[ Line: 176 ]]
    -- upvalues: l__TweenService__3 (copy), u8 (copy), u3 (copy)
    local v48 = l__TweenService__3:Create(p46, u8, {
        Position = p47
    });
    u3.PlaySound("Checkers.Move");
    v48:Play();
end;
function v5.HandleInput(p49) --[[ Line: 188 ]]
    -- upvalues: u9 (copy), l__TweenService__3 (copy), u8 (copy), u6 (copy), u7 (copy), u3 (copy)
    local l__SelectedChip__10 = p49.SelectedChip;
    local v50 = u9[p49:GetLocalSlot()];
    if p49.CanPlay and (l__SelectedChip__10 and l__SelectedChip__10.Name:match(v50.Name)) then
        local v51 = p49.FocusedChip == l__SelectedChip__10;
        local l__Position__11 = l__SelectedChip__10.Position;
        if v51 then
            if p49.MoveableSpots then
                for v52, _ in p49.MoveableSpots do
                    l__TweenService__3:Create(v52, u8, {
                        Transparency = 1
                    }):Play();
                end;
            end;
            if p49.TargetSpot then
                l__Position__11 = p49.TargetSpot.Position;
                p49.CanPlay = false;
                p49.Server:Move(l__SelectedChip__10, p49.TargetSpot);
            end;
            p49.MoveableSpots = nil;
        else
            local _, v53 = p49:GetMoveDirection(l__SelectedChip__10);
            for v54, _ in v53 do
                local v55 = l__TweenService__3:Create(v54, u8, {
                    Transparency = 0.5
                });
                v54.Color = u6;
                if v54:GetAttribute("OccupiedBy") then
                    v54.Color = u7;
                end;
                v55:Play();
            end;
            p49.MoveableSpots = v53;
        end;
        l__TweenService__3:Create(l__SelectedChip__10, u8, {
            Position = Vector3.new(l__Position__11.X, p49.DefaultHeight + (v51 and 0 or 0.1), l__Position__11.Z)
        }):Play();
        u3.PlaySound("Checkers.Select");
        if v51 or not l__SelectedChip__10 then
            l__SelectedChip__10 = nil;
        end;
        p49.FocusedChip = l__SelectedChip__10;
        p49.Highlight.OutlineTransparency = 0;
    else
        u3.PlaySound("TicTacToe.Error");
    end;
end;
function v5.Hook(u56) --[[ Line: 259 ]]
    -- upvalues: u9 (copy), l__RunService__7 (copy), l__CurrentCamera__2 (copy), u1 (copy), u6 (copy), u7 (copy)
    local u57 = u9[u56:GetLocalSlot()];
    local v63 = l__RunService__7.Heartbeat:Connect(function(p58) --[[ Line: 263 ]]
        -- upvalues: l__CurrentCamera__2 (ref), u1 (ref), u56 (copy), u57 (copy), u6 (ref), u7 (ref)
        local v59 = l__CurrentCamera__2:ScreenPointToRay(u1.X, u1.Y);
        local v60 = workspace:Raycast(v59.Origin, v59.Direction * 30, u56.RaycastWhitelist);
        if u56.FocusedChip then
            if v60 then
                v60 = v60.Instance;
            end;
            if v60 then
                local v61 = u56;
                if not u56.MoveableSpots[v60] or (v60:GetAttribute("OccupiedBy") or not v60) then
                    v60 = nil;
                end;
                v61.TargetSpot = v60;
            else
                u56.TargetSpot = nil;
            end;
        else
            if v60 then
                v60 = v60.Instance:GetAttribute("OccupiedBy");
            end;
            if v60 then
                local v62 = u56:GetChipFromName(v60);
                local l__CanPlay__12 = u56.CanPlay;
                if l__CanPlay__12 then
                    l__CanPlay__12 = v62.Name:match(u57.Name);
                end;
                u56.Highlight.OutlineColor = u56.Highlight.OutlineColor:Lerp(l__CanPlay__12 and u6 or u7, p58 * 10);
                if v62 ~= u56.SelectedChip then
                    u56.Highlight.OutlineTransparency = 1;
                    u56.Highlight.Adornee = v62;
                    u56.SelectedChip = v62;
                end;
            else
                u56.SelectedChip = nil;
            end;
            local l__Highlight__13 = u56.Highlight;
            local l__OutlineTransparency__14 = u56.Highlight.OutlineTransparency;
            l__Highlight__13.OutlineTransparency = l__OutlineTransparency__14 + ((v60 and 0 or 1) - l__OutlineTransparency__14) * (p58 * 10);
        end;
    end);
    u56.Maid:Mark(v63);
end;
function v5.Enter(p64) --[[ Line: 316 ]]
    -- upvalues: u4 (copy), l__Mince__8 (copy)
    p64:StartInspect("Waiting for players..");
    u4.StartInteractions();
    if l__Mince__8.Config.Humanoid then
        l__Mince__8.Config.Humanoid:UnequipTools();
    end;
end;
function v5.Start(u65) --[[ Line: 325 ]]
    -- upvalues: u3 (copy), u2 (copy), l__UserInputService__5 (copy)
    u65:StopInspect();
    local u66 = u65:GetLocalSlot();
    local u67 = true;
    if not u66 then
        error("Could not retrieve your slot!");
    end;
    u65:DistanceRoundedCameraPan(u65.Instance.Players[u66].Camera.WorldCFrame);
    u65:Hook();
    local v69 = u65:WatchStateChange("Turn", function() --[[ Line: 337 ]]
        -- upvalues: u65 (copy), u66 (copy), u67 (ref), u3 (ref)
        local l__Turn__15 = u65.ReplicatedState.Turn;
        local v68 = u65.Slots[l__Turn__15];
        if v68 then
            u65.Turn = l__Turn__15;
            u65.CanPlay = u65.Turn == u66;
            if not u67 then
                u3.PlaySound("Checkers.Move");
            end;
            u65:TimedInspect(`It's {v68.Name}'s turn!`, 3);
            u67 = false;
        end;
    end);
    local v70 = u65:GetStateChangedSignal("DoubleTake"):Connect(function() --[[ Line: 355 ]]
        -- upvalues: u65 (copy), u66 (copy)
        if u65.Turn == u66 then
            u65:StartInspect("It\'s a double take, you can go again..");
            u65.CanPlay = true;
        end;
    end);
    local v72 = u2.Get("Interact").OnAction:Connect(function(p71) --[[ Line: 363 ]]
        -- upvalues: u65 (copy)
        if p71 == Enum.UserInputState.Begin then
            u65:HandleInput();
        end;
    end);
    local v73 = l__UserInputService__5.TouchTapInWorld:Connect(function() --[[ Line: 370 ]]
        -- upvalues: u65 (copy)
        u65:HandleInput();
    end);
    u65.Maid:Mark(v72);
    u65.Maid:Mark(v73);
    u65.Maid:Mark(v69);
    u65.Maid:Mark(v70);
end;
function v5.Complete(u74, p75, p76) --[[ Line: 381 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u3 (copy)
    warn("Completion!", p75, p76);
    if p76 == "Draw" then
        u74:TimedInspect("It\'s a tie!", 3);
    elseif p76:IsA("Player") then
        u74:TimedInspect(`The winner of this game is {p76.Name}!`, 3);
    end;
    local l__Animator__16 = l__LocalPlayer__1.Character.Humanoid.Animator;
    local v77 = {
        Win = l__Animator__16:LoadAnimation(script.Victory),
        Lose = l__Animator__16:LoadAnimation(script.Defeat)
    };
    if p76 == l__LocalPlayer__1 then
        u3.PlaySound("TicTacToe.Win");
        v77.Win:Play();
    else
        u3.PlaySound("TicTacToe.Lose");
        v77.Lose:Play();
    end;
    task.wait(1);
    local v78 = u74:GetFirstOpponent();
    if v78 then
        local l__Character__17 = v78.Character;
        if l__Character__17 then
            l__Character__17 = v78.Character:FindFirstChild("HumanoidRootPart");
        end;
        if l__Character__17 then
            local u79 = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, l__Character__17.Position);
            task.spawn(function() --[[ Line: 419 ]]
                -- upvalues: u74 (copy), u79 (copy)
                u74:CameraPan(u79);
            end);
        end;
    end;
end;
function v5.Exit(p80) --[[ Line: 428 ]]
    -- upvalues: u4 (copy)
    u4.EndInteractions();
    p80:DistanceLinearRevertCamera();
    p80:UnlockPlayerMovement();
end;
return v5;
