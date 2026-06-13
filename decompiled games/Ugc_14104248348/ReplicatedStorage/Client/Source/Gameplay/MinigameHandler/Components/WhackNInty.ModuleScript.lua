-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.WhackNInty
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
local l__WhackNInty__7 = l__ReplicatedStorage__5.Assets.Minigame.WhackNInty;
local l__RunService__8 = game:GetService("RunService");
local l__Mince__9 = require(l__ReplicatedStorage__5.Modules.Mince);
local u2 = l__Mince__9:Get("InterfaceHandler");
local u3 = l__Mince__9:Get("NotifPrompt");
local u4 = l__Mince__9:Get("BindManager");
l__Mince__9:Get("OpeningHandler");
local u5 = l__Mince__9:Get("SoundHandler");
local u6 = l__Mince__9:Get("SelectInteractor");
local v7 = {
    ActiveWhacks = 0,
    RaycastWhitelist = nil,
    Client = {}
};
Color3.fromRGB(85, 255, 0);
Color3.fromRGB(255, 0, 0);
TweenInfo.new(0.1);
local u8 = {
    Inty = l__WhackNInty__7.Inty,
    GoldInty = l__WhackNInty__7.GoldInty,
    Noob = l__WhackNInty__7.Noob
};
local u9 = {};
local u10 = {};
function v7.Construct(p11) --[[ Line: 47 ]]
    -- upvalues: l__Mince__9 (copy), u2 (copy)
    for _, v12 in p11.Instance.Players:GetChildren() do
        if v12:IsA("Seat") then
            p11:AddSeatJoinSource(v12, (tonumber(v12.Name)));
        else
            p11:AddProximityJoinSource(v12:WaitForChild("Position"), (tonumber(v12.Name)));
        end;
    end;
    local l__ProximityPrompt__10 = p11.Instance.Players["1"]:FindFirstChild("Position").ProximityPrompt;
    l__ProximityPrompt__10:SetAttribute("SizeMultiplier", 1.5);
    l__ProximityPrompt__10.ObjectText = `Play (300 {l__Mince__9.Config.Strings.EVENT_CURRENCY_NAME})`;
    p11.Hammer = p11.Instance.Hammer;
    p11.HammerAnim = p11.Hammer.AnimationController.Animator:LoadAnimation(p11.Hammer.Animation);
    p11.Interface = u2.GetScreenGui("MainPriorityInset"):WaitForChild("WhackIntyScore");
    local l__Spots__11 = p11.Instance.Spots;
    p11.RaycastWhitelist = RaycastParams.new();
    p11.RaycastWhitelist.FilterDescendantsInstances = l__Spots__11:GetChildren();
    p11.RaycastWhitelist.FilterType = Enum.RaycastFilterType.Include;
end;
function v7.WatchGame(u13, p14) --[[ Line: 73 ]]
    local v15 = {};
    for _, u16 in u13.Instance.Spots:GetChildren() do
        local v18 = u13:WatchStateChange(u16.Name, function() --[[ Line: 77 ]]
            -- upvalues: u13 (copy), u16 (copy)
            local v17 = u13.ReplicatedState[u16.Name];
            if v17 == 0 then
            else
                u13:PlaceDoll(v17);
            end;
        end);
        table.insert(v15, v18);
    end;
    if not p14 then
        return v15;
    end;
    local v19 = u13:WatchStateChange("Whack", function() --[[ Line: 91 ]]
        -- upvalues: u13 (copy)
        local l__Whack__12 = u13.ReplicatedState.Whack;
        if l__Whack__12 == 0 then
        else
            u13:WhackPuppet(l__Whack__12);
        end;
    end);
    table.insert(v15, v19);
    return v15;
end;
function v7.SpectateStart(p20) --[[ Line: 104 ]]
    for _, v21 in p20:WatchGame(true) do
        p20.SpectateMaid:Mark(v21);
    end;
end;
function v7.PlaceDoll(p22, p23) --[[ Line: 112 ]]
    -- upvalues: u8 (copy), l__Debris__3 (copy), u10 (copy), u9 (copy)
    local v24 = p23:split("||");
    local u25 = tonumber(v24[1]);
    local u26 = tonumber(v24[2]);
    local v27 = v24[3];
    local u28 = v24[4];
    local u29 = u8[v27]:Clone();
    u29.Parent = workspace;
    l__Debris__3:AddItem(u29, 8);
    local u30 = {};
    for _, v31 in u29.Animations:GetChildren() do
        u30[v31.Name] = u29.AnimationController.Animator:LoadAnimation(v31);
    end;
    u10[u28] = { u30, u26 };
    u9[u28] = u29;
    while true do
        task.wait();
        local v32 = true;
        for _, v33 in u30 do
            if v33.Length == 0 then
                print("Still not loaded");
                v32 = false;
            end;
        end;
        if v32 == true then
            u29:PivotTo(p22.Instance.Spots[`Spot{u28}`].Spawnpoint.WorldCFrame);
            u30.Out:Play(0, 1, u26);
            u29.RootPart.PopUp:Play();
            task.delay(u30.Out.Length / u26, function() --[[ Line: 151 ]]
                -- upvalues: u9 (ref), u28 (copy), u29 (copy), u30 (copy), u25 (copy), u26 (copy), u10 (ref), l__Debris__3 (ref)
                if u9[u28] == u29 then
                    u30.Idle:Play();
                    task.delay(u25, function() --[[ Line: 156 ]]
                        -- upvalues: u9 (ref), u28 (ref), u29 (ref), u30 (ref), u26 (ref), u10 (ref), l__Debris__3 (ref)
                        if u9[u28] == u29 then
                            u30.Idle:Stop();
                            u30.In:Play(0, 1, u26);
                            if u29.RootPart:FindFirstChild("Laugh") then
                                u29.RootPart.Laugh:Play();
                            end;
                            u9[u28] = nil;
                            u10[u28] = nil;
                            u29.RootPart.PopDown:Play();
                            l__Debris__3:AddItem(u29, u30.In.Length / u26);
                        end;
                    end);
                end;
            end);
            return;
        end;
    end;
end;
function v7.WhackPuppet(p34, p35) --[[ Line: 175 ]]
    -- upvalues: u9 (copy), u10 (copy), l__TweenService__4 (copy), l__Debris__3 (copy)
    p34.ActiveWhacks = p34.ActiveWhacks + 1;
    local v36 = u9[p35];
    local v37 = u10[p35];
    if v37 then
        v37 = u10[p35][1];
    end;
    local v38 = u10[p35];
    if v38 then
        v38 = u10[p35][2];
    end;
    local v39 = p34.Instance.Spots[`Spot{p35}`];
    p34.Hammer.PrimaryPart.CFrame = v39.Spawnpoint.WorldCFrame * CFrame.new(Vector3.new(0, 0.5, 0));
    l__TweenService__4:Create(p34.Hammer.Hammer, TweenInfo.new(0.15), {
        Transparency = 0
    }):Play();
    u9[p35] = nil;
    u10[p35] = nil;
    task.wait(0.05);
    p34.HammerAnim:Play();
    task.wait(0.07);
    if v36 then
        v37.Idle:Stop();
        v37.Out:Stop();
        v37.Hit:Play(0, 1, v38);
        if p34.IsPlaying then
            p34.Server:RecordScoreFor(v36.Name);
        end;
        if v36.RootPart:FindFirstChild("Ow") then
            v36.RootPart.Ow:Play();
        end;
        if v36.RootPart:FindFirstChild("Bell") then
            v36.RootPart.Bell:Play();
        end;
        v36.RootPart.PopDown:Play();
        l__Debris__3:AddItem(v36, v37.Hit.Length / v38);
    end;
    task.wait(0.16);
    p34.ActiveWhacks = p34.ActiveWhacks - 1;
    if p34.ActiveWhacks == 0 then
        l__TweenService__4:Create(p34.Hammer.Hammer, TweenInfo.new(0.15), {
            Transparency = 1
        }):Play();
    end;
end;
function v7.Update(p40, p41) --[[ Line: 225 ]]
    -- upvalues: l__CurrentCamera__2 (copy), u1 (copy), u5 (copy)
    local v42 = l__CurrentCamera__2:ScreenPointToRay(u1.X, u1.Y);
    local v43 = workspace:Raycast(v42.Origin, v42.Direction * 5, p40.RaycastWhitelist);
    if v43 then
        local l__Instance__13 = v43.Instance;
        local l__Transparency__14 = l__Instance__13.Transparency;
        l__Instance__13.Transparency = l__Transparency__14 + (0.5 - l__Transparency__14) * (p41 * 20);
        if p40.LastSelectedSpot and p40.LastSelectedSpot ~= l__Instance__13 then
            u5.PlaySound("TicTacToe.Hover");
            p40.LastSelectedSpot.Transparency = 1;
        end;
        p40.SelectedSpot = l__Instance__13;
        p40.LastSelectedSpot = l__Instance__13;
    else
        p40.SelectedSpot = nil;
    end;
end;
function v7.ValidateClientEntry(_) --[[ Line: 250 ]]
    -- upvalues: l__Mince__9 (copy), u3 (copy)
    if l__Mince__9.Config.LocalProfile.Holiday >= 300 then
        return true;
    end;
    u3.Display("You don\'t have enough to use this!");
    return false;
end;
function v7.Enter(_) --[[ Line: 259 ]]
    -- upvalues: l__Mince__9 (copy), u3 (copy), u6 (copy)
    if l__Mince__9.Config.LocalProfile.Holiday < 300 then
        u3.Display("You don\'t have enough to use this!");
    else
        u6.StartInteractions();
        if l__Mince__9.Config.Humanoid then
            l__Mince__9.Config.Humanoid:UnequipTools();
        end;
    end;
end;
function v7.Start(u44) --[[ Line: 272 ]]
    -- upvalues: u5 (copy), u4 (copy), l__UserInputService__6 (copy), l__RunService__8 (copy)
    local v45 = u44:GetLocalSlot();
    local _ = u44.Instance.Spots;
    u44.IsPlaying = true;
    if not v45 then
        error("Could not retrieve your slot!");
    end;
    u5.PlayTrack("Inty_Minigame");
    u44.LastSelectedSpot = nil;
    u44.Interface.Score.Text = "0";
    u44.Interface.Visible = true;
    local v46 = u44:WatchStateChange("Score", function() --[[ Line: 287 ]]
        -- upvalues: u44 (copy)
        u44.Interface.Score.Text = `{u44.ReplicatedState.Score}`;
    end);
    u44:DistanceRoundedCameraPan(u44.Instance.Players[v45].Camera.WorldCFrame);
    local v48 = u4.Get("Interact").OnAction:Connect(function(p47) --[[ Line: 294 ]]
        -- upvalues: u44 (copy)
        if p47 == Enum.UserInputState.Begin then
            if u44.SelectedSpot then
                task.spawn(function() --[[ Line: 298 ]]
                    -- upvalues: u44 (ref)
                    u44:WhackPuppet(string.gsub(u44.SelectedSpot.Name, "%D", ""));
                end);
                u44.Server:Whack(u44.SelectedSpot);
            end;
        end;
    end);
    local v49 = l__UserInputService__6.TouchTapInWorld:Connect(function() --[[ Line: 304 ]]
        -- upvalues: u44 (copy)
        if u44.SelectedSpot then
            task.spawn(function() --[[ Line: 307 ]]
                -- upvalues: u44 (ref)
                u44:WhackPuppet(string.gsub(u44.SelectedSpot.Name, "%D", ""));
            end);
            u44.Server:Whack(u44.SelectedSpot);
        end;
    end);
    local v51 = l__RunService__8.Heartbeat:Connect(function(p50) --[[ Line: 314 ]]
        -- upvalues: u44 (copy)
        u44:Update(p50);
    end);
    for _, v52 in u44:WatchGame() do
        u44.Maid:Mark(v52);
    end;
    u44.Maid:Mark(v46);
    u44.Maid:Mark(v49);
    u44.Maid:Mark(v51);
    u44.Maid:Mark(v48);
end;
function v7.Complete(p53, p54, p55) --[[ Line: 331 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u5 (copy)
    if p55 then
        warn("Completion!", p54, p55);
        p53.CanPlay = false;
        if p55:IsA("Player") then
            p53:TimedInspect("You win!", 3);
        else
            p53:TimedInspect("You lose!", 3);
        end;
        local l__Animator__15 = l__LocalPlayer__1.Character.Humanoid.Animator;
        local v56 = {
            Win = l__Animator__15:LoadAnimation(script.Victory),
            Lose = l__Animator__15:LoadAnimation(script.Defeat)
        };
        if p55 == l__LocalPlayer__1 then
            u5.PlaySound("TicTacToe.Win");
            v56.Win:Play();
        else
            u5.PlaySound("TicTacToe.Lose");
            v56.Lose:Play();
        end;
        task.wait(1);
    end;
end;
function v7.Exit(p57) --[[ Line: 362 ]]
    -- upvalues: u5 (copy), u6 (copy)
    for _, v58 in p57.Instance.Spots:GetChildren() do
        v58.Transparency = 1;
    end;
    p57.IsPlaying = false;
    u5.StopTrack("Inty_Minigame");
    p57.Interface.Visible = false;
    u6.EndInteractions();
    p57:DistanceLinearRevertCamera();
    p57:UnlockPlayerMovement();
end;
return v7;
