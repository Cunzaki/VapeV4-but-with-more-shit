-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.FourRow
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__CurrentCamera__2 = workspace.CurrentCamera;
local u1 = l__LocalPlayer__1:GetMouse();
local l__Debris__3 = game:GetService("Debris");
local l__TweenService__4 = game:GetService("TweenService");
local l__ReplicatedStorage__5 = game:GetService("ReplicatedStorage");
local l__UserInputService__6 = game:GetService("UserInputService");
local l__FourRow__7 = l__ReplicatedStorage__5.Assets.Minigame.FourRow;
local l__RunService__8 = game:GetService("RunService");
local l__Mince__9 = require(l__ReplicatedStorage__5.Modules.Mince);
local u2 = l__Mince__9:Get("BindManager");
local u3 = l__Mince__9:Get("SoundHandler");
local u4 = l__Mince__9:Get("SelectInteractor");
local v5 = {
    LastSelectedSpot = nil,
    SelectedSpot = nil,
    OpponentSpot = nil,
    Chip = nil,
    OpponentChip = nil,
    RaycastWhitelist = nil,
    UpdateOpponent = true,
    CanPlay = false,
    Client = {}
};
local u6 = Color3.fromRGB(85, 255, 0);
local u7 = Color3.fromRGB(255, 0, 0);
local u8 = { Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 255, 0) };
function v5.Construct(p9) --[[ Line: 48 ]]
    for _, v10 in p9.Instance.Players:GetChildren() do
        if v10:IsA("Seat") then
            p9:AddSeatJoinSource(v10, (tonumber(v10.Name)));
        else
            p9:AddProximityJoinSource(v10:WaitForChild("Position"), (tonumber(v10.Name)));
        end;
    end;
    local l__Columns__10 = p9.Instance.Board.Columns;
    p9.RaycastWhitelist = RaycastParams.new();
    p9.RaycastWhitelist.FilterDescendantsInstances = l__Columns__10:GetChildren();
    p9.RaycastWhitelist.FilterType = Enum.RaycastFilterType.Include;
end;
function v5.FindEmptySpot(p11, p12) --[[ Line: 66 ]]
    for v13 = 6, 1, -1 do
        local v14 = p11.Locations[p12 .. v13];
        if not v14:GetAttribute("Taken") then
            return v14;
        end;
    end;
end;
function v5.ApplyFallEffect(u15, p16, p17, u18) --[[ Line: 77 ]]
    -- upvalues: l__CurrentCamera__2 (copy), l__TweenService__4 (copy), l__Debris__3 (copy)
    local v19 = 0.4 * (p16.Position - p17.Position).Magnitude;
    local v20 = TweenInfo.new(v19, Enum.EasingStyle.Exponential, Enum.EasingDirection.In);
    local v21 = p16:Clone();
    v21.Parent = l__CurrentCamera__2;
    l__TweenService__4:Create(v21, v20, {
        CFrame = p17
    }):Play();
    task.delay(v19, function() --[[ Line: 93 ]]
        -- upvalues: u15 (copy), u18 (copy)
        u15.Instance.Chips:WaitForChild(u18).Transparency = 0;
    end);
    l__Debris__3:AddItem(v21, v19);
end;
function v5.Place(p22) --[[ Line: 100 ]]
    -- upvalues: u3 (copy)
    local l__SelectedSpot__11 = p22.SelectedSpot;
    if l__SelectedSpot__11 and p22.CanPlay then
        p22:ApplyFallEffect(p22.Chip, l__SelectedSpot__11.WorldCFrame, l__SelectedSpot__11.Name);
        p22.CanPlay = false;
        p22.Server:PlacePiece(p22.SelectedSpot);
    else
        u3.PlaySound("TicTacToe.Error");
    end;
end;
function v5.Hook(u23) --[[ Line: 113 ]]
    -- upvalues: l__RunService__8 (copy), l__CurrentCamera__2 (copy), u1 (copy), u6 (copy), u7 (copy), u3 (copy)
    local v29 = l__RunService__8.Heartbeat:Connect(function(p24) --[[ Line: 114 ]]
        -- upvalues: u23 (copy), l__CurrentCamera__2 (ref), u1 (ref), u6 (ref), u7 (ref), u3 (ref)
        local l__Chip__12 = u23.Chip;
        local l__OpponentChip__13 = u23.OpponentChip;
        if u23.CanPlay then
            local v25 = l__CurrentCamera__2:ScreenPointToRay(u1.X, u1.Y);
            local v26 = workspace:Raycast(v25.Origin, v25.Direction * 30, u23.RaycastWhitelist);
            l__OpponentChip__13.Transparency = 1;
            if v26 then
                local v27 = u23:FindEmptySpot((v26.Instance.Name:match("%d+")));
                local v28 = v26.Instance:FindFirstChild("Position");
                l__Chip__12.CFrame = l__Chip__12.CFrame:Lerp(v28.WorldCFrame, p24 * 20);
                l__Chip__12.Color = l__Chip__12.Color:Lerp(v27 and u6 or u7, p24 * 20);
                local l__Transparency__14 = l__Chip__12.Transparency;
                l__Chip__12.Transparency = l__Transparency__14 + (0.5 - l__Transparency__14) * (p24 * 20);
                if u23.LastSelectedSpot and u23.LastSelectedSpot ~= v28 then
                    u3.PlaySound("TicTacToe.Hover");
                    u23.Server:SetHighlightedColumn(v26.Instance);
                end;
                u23.SelectedSpot = v27;
                u23.LastSelectedSpot = v28;
            else
                u23.SelectedSpot = nil;
            end;
        else
            local l__OpponentSpot__15 = u23.OpponentSpot;
            if l__OpponentSpot__15 then
                l__OpponentSpot__15 = l__OpponentSpot__15:FindFirstChild("Position");
            end;
            if l__OpponentSpot__15 and u23.UpdateOpponent then
                l__OpponentChip__13.CFrame = l__OpponentChip__13.CFrame:Lerp(l__OpponentSpot__15.WorldCFrame, p24 * 20);
                local l__Transparency__16 = l__OpponentChip__13.Transparency;
                l__OpponentChip__13.Transparency = l__Transparency__16 + (0.5 - l__Transparency__16) * (p24 * 20);
            else
                l__OpponentChip__13.Transparency = 1;
            end;
            local l__Transparency__17 = l__Chip__12.Transparency;
            l__Chip__12.Transparency = l__Transparency__17 + (1 - l__Transparency__17) * (p24 * 20);
        end;
    end);
    u23.Maid:Mark(v29);
end;
function v5.Client.SetHighlightedColumn(p30, p31) --[[ Line: 176 ]]
    p30.OpponentSpot = p30.Columns[p31];
end;
function v5.Client.SimulateOpponentEffect(p32, p33) --[[ Line: 180 ]]
    p32:ApplyFallEffect(p32.OpponentChip, p32.Locations[p33].WorldCFrame, p33);
end;
function v5.SpectateStart(u34) --[[ Line: 191 ]]
    -- upvalues: u3 (copy)
    local v36 = u34:WatchStateChange("Turn", function() --[[ Line: 194 ]]
        -- upvalues: u34 (copy), u3 (ref)
        local v35 = u34.Slots[u34.ReplicatedState.Turn];
        if v35 then
            u34:TimedInspect(`It's {v35.Name}'s turn!`, 3);
            u3.PlaySound("TicTacToe.Place");
        end;
    end);
    u34.SpectateMaid:Mark(v36);
end;
function v5.Enter(p37) --[[ Line: 206 ]]
    -- upvalues: u4 (copy), l__Mince__9 (copy)
    p37:StartInspect("Waiting for players..");
    u4.StartInteractions();
    if l__Mince__9.Config.Humanoid then
        l__Mince__9.Config.Humanoid:UnequipTools();
    end;
end;
function v5.Start(u38) --[[ Line: 215 ]]
    -- upvalues: l__FourRow__7 (copy), u8 (copy), l__CurrentCamera__2 (copy), u3 (copy), u2 (copy), l__UserInputService__6 (copy)
    u38:StopInspect();
    local u39 = u38:GetLocalSlot();
    local l__Board__18 = u38.Instance.Board;
    local l__Columns__19 = l__Board__18.Columns;
    local v40 = l__Columns__19.Column4:FindFirstChild("Position");
    local l__Chip__20 = l__FourRow__7.Chip;
    local l__Locations__21 = l__Board__18.Locations;
    local u41 = true;
    if not u39 then
        error("Could not retrieve your slot!");
    end;
    u38:DistanceRoundedCameraPan(u38.Instance.Players[u39].Camera.WorldCFrame);
    u38.Chip = l__Chip__20:Clone();
    u38.Chip.Color = u8[u39];
    u38.Chip.Position = v40.WorldPosition;
    u38.Chip.Parent = l__CurrentCamera__2;
    u38.OpponentChip = l__Chip__20:Clone();
    u38.OpponentChip.Color = u8[u39 % 2 + 1];
    u38.OpponentChip.Position = v40.WorldPosition;
    u38.OpponentChip.Parent = l__CurrentCamera__2;
    u38.Columns = l__Columns__19;
    u38.Locations = l__Locations__21;
    local v43 = u38:WatchStateChange("Turn", function() --[[ Line: 248 ]]
        -- upvalues: u38 (copy), u39 (copy), u41 (ref), u3 (ref)
        local l__Turn__22 = u38.ReplicatedState.Turn;
        local v42 = u38.Slots[l__Turn__22];
        if v42 then
            u38.Turn = l__Turn__22;
            u38.CanPlay = u38.Turn == u39;
            if not u41 then
                u3.PlaySound("TicTacToe.Place");
            end;
            u38:TimedInspect(`It's {v42.Name}'s turn!`, 3);
            u41 = false;
        end;
    end);
    u38.Instance.Chips.ChildAdded:Connect(function(p44) --[[ Line: 266 ]]
        p44.Transparency = 1;
    end);
    u38:Hook();
    local v45 = u2.Get("Interact").OnAction:Connect(function(_) --[[ Line: 273 ]]
        -- upvalues: u38 (copy)
        u38:Place();
    end);
    local v46 = l__UserInputService__6.TouchTapInWorld:Connect(function() --[[ Line: 277 ]]
        -- upvalues: u38 (copy)
        u38:Place();
    end);
    u38.UpdateOpponent = true;
    u38.Maid:Mark(v46);
    u38.Maid:Mark(v43);
    u38.Maid:Mark(v45);
    u38.Maid:Mark(u38.Chip);
    u38.Maid:Mark(u38.OpponentChip);
end;
function v5.Complete(u47, p48, p49) --[[ Line: 290 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u3 (copy)
    warn("Completion!", p48, p49);
    u47.UpdateOpponent = false;
    u47.CanPlay = false;
    if p49 == "Draw" then
        u47:TimedInspect("It\'s a tie!", 3);
    elseif p49:IsA("Player") then
        u47:TimedInspect(`The winner of this game is {p49.Name}!`, 3);
    end;
    local l__Animator__23 = l__LocalPlayer__1.Character.Humanoid.Animator;
    local v50 = {
        Win = l__Animator__23:LoadAnimation(script.Victory),
        Lose = l__Animator__23:LoadAnimation(script.Defeat)
    };
    if p49 == l__LocalPlayer__1 then
        u3.PlaySound("TicTacToe.Win");
        v50.Win:Play();
    else
        u3.PlaySound("TicTacToe.Lose");
        v50.Lose:Play();
    end;
    task.wait(1);
    local v51 = u47:GetFirstOpponent();
    if v51 then
        local l__Character__24 = v51.Character;
        if l__Character__24 then
            l__Character__24 = v51.Character:FindFirstChild("HumanoidRootPart");
        end;
        if l__Character__24 then
            local u52 = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, l__Character__24.Position);
            task.spawn(function() --[[ Line: 330 ]]
                -- upvalues: u47 (copy), u52 (copy)
                u47:CameraPan(u52);
            end);
        end;
    end;
end;
function v5.Exit(p53) --[[ Line: 339 ]]
    -- upvalues: u4 (copy)
    u4.EndInteractions();
    p53:DistanceLinearRevertCamera();
    p53:UnlockPlayerMovement();
end;
return v5;
