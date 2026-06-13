-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.Battleship
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__CurrentCamera__2 = workspace.CurrentCamera;
local u1 = l__LocalPlayer__1:GetMouse();
game:GetService("Debris");
game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__UserInputService__4 = game:GetService("UserInputService");
game:GetService("ContextActionService");
local l__Battleship__5 = l__ReplicatedStorage__3.Assets.Minigame.Battleship;
local l__RunService__6 = game:GetService("RunService");
local l__Mince__7 = require(l__ReplicatedStorage__3.Modules.Mince);
local u2 = l__Mince__7:Get("BindManager");
local u3 = l__Mince__7:Get("SoundHandler");
local u4 = l__Mince__7:Get("ScreenEffects");
local u5 = l__Mince__7:Get("SelectInteractor");
local v6 = {
    Mode = 1,
    Rotated = false,
    CurrentShip = 0,
    Ship = nil,
    PlacedAll = false,
    Debounce = 0,
    LastSelectedSpot = nil,
    SelectedSpot = nil,
    RaycastWhitelist = nil,
    UpdateOpponent = true,
    CanPlay = true,
    Client = {}
};
Color3.fromRGB(85, 255, 0);
Color3.fromRGB(255, 0, 0);
TweenInfo.new(0.1);
local u7 = #l__Battleship__5.Roster:GetChildren();
function v6.Construct(p8) --[[ Line: 55 ]]
    for _, v9 in p8.Instance.Players:GetChildren() do
        if v9:IsA("Seat") then
            p8:AddSeatJoinSource(v9, (tonumber(v9.Name)));
        else
            p8:AddProximityJoinSource(v9:WaitForChild("Position"), (tonumber(v9.Name)));
        end;
    end;
    p8.RaycastWhitelist = RaycastParams.new();
    p8.RaycastWhitelist.FilterType = Enum.RaycastFilterType.Include;
end;
function v6.GetShip(p10) --[[ Line: 68 ]]
    -- upvalues: u7 (copy), u2 (copy), l__Battleship__5 (copy), l__CurrentCamera__2 (copy)
    if u7 <= p10.CurrentShip then
        if #p10.Instance.Ships:GetChildren() < u7 * 2 then
            p10:StartInspect("Waiting for your opponent to place their ships!");
        end;
        u2.SetMobileBindButtonsEnabled("Rotate", false);
        p10.Mode = 2;
    else
        p10.CurrentShip = p10.CurrentShip + 1;
        local v11 = l__Battleship__5.Roster:GetChildren()[p10.CurrentShip]:Clone();
        v11.Parent = l__CurrentCamera__2;
        p10.Ship = v11;
    end;
end;
function v6.Client.OnPlaced(p12) --[[ Line: 88 ]]
    p12.Ship:Destroy();
    p12.Ship = nil;
    p12:GetShip();
    p12.CanPlay = true;
end;
function v6.Validate(p13, p14, p15, p16) --[[ Line: 97 ]]
    local v17 = {};
    local v18 = true;
    for _, v19 in p15:GetChildren() do
        if v19.Name ~= "Model" then
            local v20 = tonumber(p14.Name);
            local v21 = tonumber(p14.Parent.Name);
            local v22 = tonumber(p15.PrimaryPart.Name);
            local v23 = tonumber(v19.Name) - v22;
            if p16 then
                v21 = v21 + v23;
            else
                v20 = v20 + v23;
            end;
            local v24 = p13.Board.Home:FindFirstChild(v21);
            if not v24 then
                return false, v17;
            end;
            local v25 = v24:FindFirstChild(v20);
            if not v25 or v25:GetAttribute("Occupied") then
                return false, v17;
            end;
            table.insert(v17, v25);
        end;
    end;
    return v18, v17;
end;
function v6.Place(p26) --[[ Line: 135 ]]
    -- upvalues: u3 (copy)
    if p26.CanPlay and p26.SelectedSpot then
        if os.clock() - p26.Debounce < 1 then
        else
            if p26.Mode == 1 then
                local v27, _ = p26:Validate(p26.SelectedSpot, p26.Ship, p26.Rotated);
                if v27 then
                    p26.Ship.Model.Transparency = 0.5;
                    p26.Server:Place(p26.SelectedSpot, p26.Ship.Name, p26.Rotated);
                    u3.PlaySound("TicTacToe.Place");
                    p26.CanPlay = false;
                end;
            elseif p26.Mode == 2 then
                if p26.SelectedSpot:IsDescendantOf(p26.Board.Home) then
                    return;
                end;
                p26.Server:Attack(p26.SelectedSpot);
            end;
            p26.Debounce = os.clock();
        end;
    else
        if not p26.CanPlay then
            u3.PlaySound("TicTacToe.Error");
        end;
    end;
end;
function v6.Hook(u28) --[[ Line: 180 ]]
    -- upvalues: l__RunService__6 (copy), l__CurrentCamera__2 (copy), u1 (copy), u3 (copy)
    local v35 = l__RunService__6.Heartbeat:Connect(function(_) --[[ Line: 181 ]]
        -- upvalues: l__CurrentCamera__2 (ref), u1 (ref), u28 (copy), u3 (ref)
        local v29 = l__CurrentCamera__2:ScreenPointToRay(u1.X, u1.Y);
        local v30 = workspace:Raycast(v29.Origin, v29.Direction * 30, u28.RaycastWhitelist);
        if v30 then
            local l__Instance__8 = v30.Instance;
            if u28.Mode == 1 and (l__Instance__8.Parent.Parent.Name == "Home" and u28.Ship) then
                local v31 = u28:Validate(l__Instance__8, u28.Ship, u28.Rotated);
                u28.Ship:PivotTo(l__Instance__8.CFrame * CFrame.Angles(0, u28.Rotated and 1.5707963267948966 or 0, 0));
                u28.Ship.Model.Transparency = v31 and 0 or 0.5;
                u28.SelectedSpot = v31 and l__Instance__8 and l__Instance__8 or nil;
                if u28.LastSelectedSpot and u28.LastSelectedSpot ~= l__Instance__8 then
                    u3.PlaySound("TicTacToe.Hover");
                end;
            elseif u28.Mode == 2 and l__Instance__8.Parent.Parent.Name == "Enemy" then
                if u28.CanPlay then
                    local v32 = l__Instance__8:GetAttribute("Attacked");
                    u28.Pin.Model.Transparency = v32 and 1 or 0;
                    local v33 = u28;
                    local v34;
                    if v32 or not l__Instance__8 then
                        v34 = nil;
                    else
                        v34 = l__Instance__8;
                    end;
                    v33.SelectedSpot = v34;
                    if not v32 and (u28.LastSelectedSpot and u28.LastSelectedSpot ~= l__Instance__8) then
                        u3.PlaySound("TicTacToe.Hover");
                    end;
                else
                    u28.Pin.Model.Transparency = 0.5;
                end;
                u28.Pin:PivotTo(l__Instance__8.CFrame);
            end;
            u28.LastSelectedSpot = l__Instance__8;
        else
            u28.SelectedSpot = nil;
        end;
    end);
    u28.Maid:Mark(v35);
end;
function v6.Client.SetHighlightedPiece(p36, p37) --[[ Line: 241 ]]
    p36.OpponentSpot = p36.Instance.Spots[p37];
end;
function v6.SpectateStart(u38) --[[ Line: 247 ]]
    -- upvalues: u3 (copy)
    local v40 = u38:WatchStateChange("Turn", function() --[[ Line: 250 ]]
        -- upvalues: u38 (copy), u3 (ref)
        local v39 = u38.Slots[u38.ReplicatedState.Turn];
        if v39 then
            u38:TimedInspect(`It's {v39.Name}'s turn!`, 3);
            u3.PlaySound("TicTacToe.Place");
        end;
    end);
    local v42 = u38:WatchStateChange("Status", function() --[[ Line: 259 ]]
        -- upvalues: u38 (copy), u3 (ref)
        local l__Status__9 = u38.ReplicatedState.Status;
        local v41 = u38.Slots[u38.ReplicatedState.Turn];
        if v41 and l__Status__9 ~= "" then
            u38:TimedInspect(`{v41.Name}'s shot is a {l__Status__9}!`, 3);
            u3.PlaySound("TicTacToe.Place");
        end;
    end);
    u38.SpectateMaid:Mark(v42);
    u38.SpectateMaid:Mark(v40);
end;
function v6.Enter(p43) --[[ Line: 276 ]]
    -- upvalues: u5 (copy), l__Mince__7 (copy)
    p43:StartInspect("Waiting for players..");
    u5.StartInteractions();
    if l__Mince__7.Config.Humanoid then
        l__Mince__7.Config.Humanoid:UnequipTools();
    end;
end;
function v6.Start(u44) --[[ Line: 285 ]]
    -- upvalues: u7 (copy), l__Battleship__5 (copy), l__CurrentCamera__2 (copy), u3 (copy), u4 (copy), u2 (copy), l__UserInputService__4 (copy)
    u44:StartInspect((`Place {u7} ships!`));
    local u45 = u44:GetLocalSlot();
    local u46 = true;
    if not u45 then
        error("Could not retrieve your slot!");
    end;
    local v47 = u44.Instance.Board[u45];
    u44:DistanceRoundedCameraPan(u44.Instance.Players[u45].Camera.WorldCFrame);
    local v48 = v47.Home:GetDescendants();
    for _, v49 in v47.Enemy:GetDescendants() do
        table.insert(v48, v49);
    end;
    local v50 = l__Battleship__5.Pin:Clone();
    v50.Model.Transparency = 1;
    v50.Parent = l__CurrentCamera__2;
    local v52 = u44:GetStateChangedSignal("Turn"):Connect(function() --[[ Line: 306 ]]
        -- upvalues: u44 (copy), u45 (copy), u46 (ref)
        local l__Turn__10 = u44.ReplicatedState.Turn;
        local v51 = u44.Slots[l__Turn__10];
        if v51 then
            u44.Turn = l__Turn__10;
            u44.CanPlay = u44.Turn == u45;
            u44:TimedInspect(`It's {v51.Name}'s turn!`, 3);
            u46 = false;
        end;
    end);
    local v55 = u44:WatchStateChange("Status", function() --[[ Line: 321 ]]
        -- upvalues: u44 (copy), u3 (ref), l__CurrentCamera__2 (ref), u4 (ref)
        local l__Status__11 = u44.ReplicatedState.Status;
        local v53 = u44.Slots[u44.ReplicatedState.Turn];
        if v53 and l__Status__11 ~= "" then
            if l__Status__11 == "Hit" or l__Status__11 == "Sink" then
                u3.PlaySound((`Battleship.{l__Status__11}`)).PlaybackSpeed = 0.8 + math.random() * 0.4;
                if l__Status__11 == "Sink" then
                    local l__CFrame__12 = l__CurrentCamera__2.CFrame;
                    u4.PlayAndApplyManualForce("BattleshipHit", function(p54) --[[ Line: 339 ]]
                        -- upvalues: l__CurrentCamera__2 (ref), l__CFrame__12 (copy)
                        l__CurrentCamera__2.CFrame = l__CFrame__12 * p54;
                    end);
                end;
            else
                u3.PlaySound("Battleship.Miss");
            end;
            u44:TimedInspect(`{v53.Name}'s shot is a {l__Status__11}!`, 3);
        end;
    end);
    local v57 = u2.Get("Rotate").OnAction:Connect(function(p56) --[[ Line: 352 ]]
        -- upvalues: u44 (copy)
        if p56 == Enum.UserInputState.Begin then
            u44.Rotated = not u44.Rotated;
        end;
    end);
    local v59 = u2.Get("Interact").OnAction:Connect(function(p58) --[[ Line: 360 ]]
        -- upvalues: u44 (copy)
        if p58 == Enum.UserInputState.Begin then
            u44:Place();
        end;
    end);
    local v60 = l__UserInputService__4.TouchTapInWorld:Connect(function() --[[ Line: 367 ]]
        -- upvalues: u44 (copy)
        u44:Place();
    end);
    u44.Pin = v50;
    u44.Mode = 1;
    u44.CurrentShip = 0;
    u44.CanPlay = true;
    u2.SetMobileBindButtonsEnabled("Rotate", true);
    u44:GetShip();
    u44:Hook();
    u44.Board = v47;
    u44.UpdateOpponent = true;
    u44.RaycastWhitelist.FilterDescendantsInstances = v48;
    u44.Maid:Mark(v55);
    u44.Maid:Mark(v60);
    u44.Maid:Mark(v52);
    u44.Maid:Mark(v59);
    u44.Maid:Mark(v57);
    u44.Maid:Mark(v50);
end;
function v6.Complete(u61, p62, p63) --[[ Line: 393 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u3 (copy)
    warn("Completion!", p62, p63);
    u61.UpdateOpponent = false;
    u61.CanPlay = false;
    u61.Maid:Sweep();
    u61:TimedInspect(`The winner of this game is {p63.Name}!`, 3);
    local l__Animator__13 = l__LocalPlayer__1.Character.Humanoid.Animator;
    local v64 = {
        Win = l__Animator__13:LoadAnimation(script.Victory),
        Lose = l__Animator__13:LoadAnimation(script.Defeat)
    };
    if p63 == l__LocalPlayer__1 then
        u3.PlaySound("TicTacToe.Win");
        v64.Win:Play();
    else
        u3.PlaySound("TicTacToe.Lose");
        v64.Lose:Play();
    end;
    task.wait(1);
    local v65 = u61:GetFirstOpponent();
    if v65 then
        local l__Character__14 = v65.Character;
        if l__Character__14 then
            l__Character__14 = v65.Character:FindFirstChild("HumanoidRootPart");
        end;
        if l__Character__14 then
            local u66 = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, l__Character__14.Position);
            task.spawn(function() --[[ Line: 428 ]]
                -- upvalues: u61 (copy), u66 (copy)
                u61:CameraPan(u66);
            end);
        end;
    end;
end;
function v6.Exit(p67) --[[ Line: 437 ]]
    -- upvalues: u2 (copy), u5 (copy)
    if p67.Ship then
        p67.Ship:Destroy();
        p67.Ship = nil;
    end;
    u2.SetMobileBindButtonsEnabled("Rotate", false);
    u5.EndInteractions();
    p67:DistanceLinearRevertCamera();
    p67:UnlockPlayerMovement();
end;
return v6;
