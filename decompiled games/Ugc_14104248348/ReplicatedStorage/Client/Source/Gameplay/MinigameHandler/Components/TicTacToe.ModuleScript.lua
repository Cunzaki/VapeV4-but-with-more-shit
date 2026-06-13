-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.TicTacToe
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
local l__TicTacToe__7 = l__ReplicatedStorage__5.Assets.Minigame.TicTacToe;
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
local u8 = TweenInfo.new(0.1);
local u9 = { l__TicTacToe__7.X, l__TicTacToe__7.O };
function v5.Construct(p10) --[[ Line: 49 ]]
    for _, v11 in p10.Instance.Players:GetChildren() do
        if v11:IsA("Seat") then
            p10:AddSeatJoinSource(v11, (tonumber(v11.Name)));
        else
            p10:AddProximityJoinSource(v11:WaitForChild("Position"), (tonumber(v11.Name)));
        end;
    end;
    local l__Spots__10 = p10.Instance.Spots;
    p10.RaycastWhitelist = RaycastParams.new();
    p10.RaycastWhitelist.FilterDescendantsInstances = l__Spots__10:GetChildren();
    p10.RaycastWhitelist.FilterType = Enum.RaycastFilterType.Include;
end;
function v5.Place(p12) --[[ Line: 67 ]]
    -- upvalues: l__CurrentCamera__2 (copy), l__TweenService__4 (copy), u8 (copy), l__Debris__3 (copy), u3 (copy)
    local l__SelectedSpot__11 = p12.SelectedSpot;
    if l__SelectedSpot__11 and p12.CanPlay then
        local v13 = p12.Chip:Clone();
        v13.Parent = l__CurrentCamera__2;
        l__TweenService__4:Create(v13, u8, {
            CFrame = l__SelectedSpot__11.CFrame
        }):Play();
        p12.CanPlay = false;
        p12.Server:PlacePiece(p12.SelectedSpot);
        l__Debris__3:AddItem(v13, 0.1);
    else
        u3.PlaySound("TicTacToe.Error");
    end;
end;
function v5.Hook(u14) --[[ Line: 89 ]]
    -- upvalues: l__RunService__8 (copy), l__CurrentCamera__2 (copy), u1 (copy), u7 (copy), u6 (copy), u3 (copy)
    local v21 = l__RunService__8.Heartbeat:Connect(function(p15) --[[ Line: 92 ]]
        -- upvalues: u14 (copy), l__CurrentCamera__2 (ref), u1 (ref), u7 (ref), u6 (ref), u3 (ref)
        local l__Chip__12 = u14.Chip;
        local l__OpponentChip__13 = u14.OpponentChip;
        if u14.CanPlay then
            local v16 = l__CurrentCamera__2:ScreenPointToRay(u1.X, u1.Y);
            local v17 = workspace:Raycast(v16.Origin, v16.Direction * 30, u14.RaycastWhitelist);
            l__OpponentChip__13.Transparency = 1;
            if v17 then
                local l__Instance__14 = v17.Instance;
                local v18 = l__Instance__14:GetAttribute("Taken");
                l__Chip__12.Position = l__Chip__12.Position:Lerp(l__Instance__14.Position + Vector3.new(0, 0.5, 0), p15 * 20);
                l__Chip__12.Color = l__Chip__12.Color:Lerp(v18 and u7 or u6, p15 * 20);
                local l__Transparency__15 = l__Chip__12.Transparency;
                l__Chip__12.Transparency = l__Transparency__15 + (0.5 - l__Transparency__15) * (p15 * 20);
                if u14.LastSelectedSpot and u14.LastSelectedSpot ~= l__Instance__14 then
                    u3.PlaySound("TicTacToe.Hover");
                    u14.Server:SetHighlightedPiece(l__Instance__14);
                end;
                local v19 = u14;
                local v20;
                if v18 or not l__Instance__14 then
                    v20 = nil;
                else
                    v20 = l__Instance__14;
                end;
                v19.SelectedSpot = v20;
                u14.LastSelectedSpot = l__Instance__14;
            else
                u14.SelectedSpot = nil;
            end;
        else
            local l__OpponentSpot__16 = u14.OpponentSpot;
            if l__OpponentSpot__16 and u14.UpdateOpponent then
                l__OpponentChip__13.Position = l__OpponentChip__13.Position:Lerp(l__OpponentSpot__16.Position + Vector3.new(0, 0.5, 0), p15 * 20);
                local l__Transparency__17 = l__OpponentChip__13.Transparency;
                l__OpponentChip__13.Transparency = l__Transparency__17 + (0.5 - l__Transparency__17) * (p15 * 20);
            else
                l__OpponentChip__13.Transparency = 1;
            end;
            local l__Transparency__18 = l__Chip__12.Transparency;
            l__Chip__12.Transparency = l__Transparency__18 + (1 - l__Transparency__18) * (p15 * 20);
        end;
    end);
    u14.Maid:Mark(v21);
end;
function v5.Client.SetHighlightedPiece(p22, p23) --[[ Line: 152 ]]
    p22.OpponentSpot = p22.Instance.Spots[p23];
end;
function v5.SpectateStart(u24) --[[ Line: 158 ]]
    -- upvalues: u3 (copy)
    local v26 = u24:WatchStateChange("Turn", function() --[[ Line: 161 ]]
        -- upvalues: u24 (copy), u3 (ref)
        local v25 = u24.Slots[u24.ReplicatedState.Turn];
        if v25 then
            u24:TimedInspect(`It's {v25.Name}'s turn!`, 3);
            u3.PlaySound("TicTacToe.Place");
        end;
    end);
    u24.SpectateMaid:Mark(v26);
end;
function v5.Enter(p27) --[[ Line: 173 ]]
    -- upvalues: u4 (copy), l__Mince__9 (copy)
    p27:StartInspect("Waiting for players..");
    u4.StartInteractions();
    if l__Mince__9.Config.Humanoid then
        l__Mince__9.Config.Humanoid:UnequipTools();
    end;
end;
function v5.Start(u28) --[[ Line: 182 ]]
    -- upvalues: u9 (copy), l__CurrentCamera__2 (copy), u3 (copy), u2 (copy), l__UserInputService__6 (copy)
    u28:StopInspect();
    local u29 = u28:GetLocalSlot();
    local l__Spots__19 = u28.Instance.Spots;
    local u30 = true;
    if not u29 then
        error("Could not retrieve your slot!");
    end;
    u28:DistanceRoundedCameraPan(u28.Instance.Players[u29].Camera.WorldCFrame);
    u28.Chip = u9[u29]:Clone();
    u28.Chip.Position = l__Spots__19["5"].Position + Vector3.new(0, 0.5, 0);
    u28.Chip.Parent = l__CurrentCamera__2;
    u28.OpponentChip = u9[u29 % 2 + 1]:Clone();
    u28.OpponentChip.Position = l__Spots__19["5"].Position + Vector3.new(0, 0.5, 0);
    u28.OpponentChip.Parent = l__CurrentCamera__2;
    local v32 = u28:WatchStateChange("Turn", function() --[[ Line: 203 ]]
        -- upvalues: u28 (copy), u29 (copy), u30 (ref), u3 (ref)
        local l__Turn__20 = u28.ReplicatedState.Turn;
        local v31 = u28.Slots[l__Turn__20];
        if v31 then
            u28.Turn = l__Turn__20;
            u28.CanPlay = u28.Turn == u29;
            if not u30 then
                u3.PlaySound("TicTacToe.Place");
            end;
            u28:TimedInspect(`It's {v31.Name}'s turn!`, 3);
            u30 = false;
        end;
    end);
    u28:Hook();
    local v33 = u2.Get("Interact").OnAction:Connect(function(_) --[[ Line: 224 ]]
        -- upvalues: u28 (copy)
        u28:Place();
    end);
    local v34 = l__UserInputService__6.TouchTapInWorld:Connect(function() --[[ Line: 227 ]]
        -- upvalues: u28 (copy)
        u28:Place();
    end);
    u28.UpdateOpponent = true;
    u28.Maid:Mark(v34);
    u28.Maid:Mark(v32);
    u28.Maid:Mark(v33);
    u28.Maid:Mark(u28.Chip);
    u28.Maid:Mark(u28.OpponentChip);
end;
function v5.Complete(u35, p36, p37) --[[ Line: 240 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u3 (copy)
    warn("Completion!", p36, p37);
    u35.UpdateOpponent = false;
    u35.CanPlay = false;
    if p37 == "Draw" then
        u35:TimedInspect("It\'s a tie!", 3);
    elseif p37:IsA("Player") then
        u35:TimedInspect(`The winner of this game is {p37.Name}!`, 3);
    end;
    local l__Animator__21 = l__LocalPlayer__1.Character.Humanoid.Animator;
    local v38 = {
        Win = l__Animator__21:LoadAnimation(script.Victory),
        Lose = l__Animator__21:LoadAnimation(script.Defeat)
    };
    if p37 == l__LocalPlayer__1 then
        u3.PlaySound("TicTacToe.Win");
        v38.Win:Play();
    else
        u3.PlaySound("TicTacToe.Lose");
        v38.Lose:Play();
    end;
    task.wait(1);
    local v39 = u35:GetFirstOpponent();
    if v39 then
        local l__Character__22 = v39.Character;
        if l__Character__22 then
            l__Character__22 = v39.Character:FindFirstChild("HumanoidRootPart");
        end;
        if l__Character__22 then
            local u40 = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, l__Character__22.Position);
            task.spawn(function() --[[ Line: 280 ]]
                -- upvalues: u35 (copy), u40 (copy)
                u35:CameraPan(u40);
            end);
        end;
    end;
end;
function v5.Exit(p41) --[[ Line: 289 ]]
    -- upvalues: u4 (copy)
    u4.EndInteractions();
    p41:DistanceLinearRevertCamera();
    p41:UnlockPlayerMovement();
end;
return v5;
