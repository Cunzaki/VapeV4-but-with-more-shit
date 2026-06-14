-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.OAnQuan
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local _ = workspace.CurrentCamera;
local u1 = l__LocalPlayer__1:GetMouse();
game:GetService("Debris");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__UserInputService__4 = game:GetService("UserInputService");
game:GetService("ContextActionService");
local l__RunService__5 = game:GetService("RunService");
local l__HttpService__6 = game:GetService("HttpService");
local l__Mince__7 = require(l__ReplicatedStorage__3.Modules.Mince);
local l__ModelTweenOG__8 = require(game.ReplicatedStorage.Modules.ModelTweenOG);
local l__Bucket__9 = require(l__ReplicatedStorage__3.Modules.Bucket);
local u2 = l__Mince__7:Get("BindManager");
local u3 = l__Mince__7:Get("SoundHandler");
l__Mince__7:Get("ScreenEffects");
local u4 = l__Mince__7:Get("SelectInteractor");
local u5 = l__Mince__7:Get("NotifPrompt");
local u6 = l__Mince__7:Get("Voicelines");
local u7 = l__Mince__7:Get("GameRewards");
local u8 = l__Mince__7:GetEvent("ExpireIntent");
local v9 = {
    Direction = nil,
    SelectedSpot = nil,
    RaycastWhitelist = nil,
    UpdateOpponent = true,
    CanPlay = true,
    Client = {},
    Spots = {}
};
local u10 = {
    Score = l__Bucket__9.new({ "Score2", "Score3", "Score4" }),
    TurnStart = l__Bucket__9.new({ "TurnStart1", "TurnStart2" }),
    TurnEnd = l__Bucket__9.new({ "TurnEnd1", "TurnEnd2" }),
    OpponentWin = l__Bucket__9.new({ "OpponentWin1", "OpponentWin2" }),
    PlayerWin = l__Bucket__9.new({ "PlayerWin1", "PlayerWin2" })
};
local u11 = Vector2.new(2, 6);
local u12 = Vector2.new(8, 12);
local u13 = Vector2.new(1, 7);
local u14 = {};
u14.__index = u14;
function u14.New(p15, p16, p17) --[[ Line: 57 ]]
    -- upvalues: u14 (copy), l__TweenService__2 (copy)
    local v18 = setmetatable({}, u14);
    v18.SpotIndex = p15;
    v18.SpotData = p16;
    v18.SpotPart = p17;
    v18.Score = 0;
    v18.SpotPart.Transparency = 0.7;
    v18.Tween = l__TweenService__2:Create(p17, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
        Transparency = 0.3
    });
    v18.SpotPart.Transparency = 1;
    v18:ConstructAppearance();
    return v18;
end;
function u14.ConstructAppearance(p19) --[[ Line: 73 ]]
    local v20 = {};
    local v21 = 0;
    for v22, v23 in ipairs(p19.SpotData) do
        local v24 = p19:GetPiecePart(v22, v23);
        if v22 < 8 then
            v24:PivotTo(p19.SpotPart[`{v22}`].WorldCFrame * CFrame.Angles(0, 0, 1.5707963267948966));
        else
            v24:PivotTo(p19.SpotPart[`{1}`].WorldCFrame * CFrame.Angles(0, 0, 1.5707963267948966));
        end;
        v20[v24] = true;
        v21 = v21 + (v23.Type == "Small" and 1 or 10);
    end;
    for _, v25 in p19.SpotPart.Pieces:GetChildren() do
        if not v20[v25] then
            v25:Destroy();
        end;
    end;
    p19.Score = v21;
    p19.SpotPart.Interface.Amount.Text = p19.Score;
end;
function u14.GetPiecePart(p26, p27, p28) --[[ Line: 101 ]]
    local v29 = `{p27}{p28.Type}`;
    local v30 = p26.SpotPart.Parent:FindFirstChild("Pieces") or p26.SpotPart.Parent.Parent.Pieces;
    local v31 = p26.SpotPart.Pieces:FindFirstChild(v29);
    if not v31 then
        v31 = v30[p28.Type]:Clone();
        v31.Parent = p26.SpotPart.Pieces;
        v31.Name = `{p27}{p28.Type}`;
    end;
    return v31;
end;
function u14.SyncToData(p32, p33) --[[ Line: 116 ]]
    p32.SpotData = p33;
    p32:ConstructAppearance();
end;
function u14.SetAnimationPlaying(p34, p35) --[[ Line: 121 ]]
    if p35 then
        p34.SpotPart.Transparency = 0.7;
        p34.Tween:Play();
    else
        p34.Tween:Pause();
        p34.SpotPart.Transparency = 1;
    end;
end;
function u14.Flash(p36, p37) --[[ Line: 131 ]]
    -- upvalues: l__TweenService__2 (copy)
    p36.SpotPart.Transparency = 0.5;
    l__TweenService__2:Create(p36.SpotPart, TweenInfo.new(p37 or 0.2), {
        Transparency = 1
    }):Play();
    task.wait(p37 or 0.2);
end;
function v9.PlayTutorialLine(p38, p39) --[[ Line: 137 ]]
    -- upvalues: l__Mince__7 (copy), u8 (copy), u6 (copy)
    local v40 = `OQUAN{p38.Instance:GetAttribute("Voice") or "Female"}`;
    if not l__Mince__7.Config.LocalProfile.Intents[`OAQMINIGAME{p39}`] then
        return false;
    end;
    u8:Fire((`OAQMINIGAME{p39}`));
    local v41 = `{v40}{p39}`;
    local v42 = u6.GetVoicelineSettings(v41);
    v42.Sound:Play();
    v42.Sound.Ended:Wait();
    return true;
end;
function v9.PlayLine(p43, p44) --[[ Line: 152 ]]
    -- upvalues: u10 (copy), u6 (copy)
    local v45 = `OQUAN{p43.Instance:GetAttribute("Voice") or "Female"}`;
    local v46 = u10[p44]:Next();
    u6.PlayLine((`{v45}{v46}`));
end;
function v9.UnpackSpotData(p47) --[[ Line: 159 ]]
    -- upvalues: l__HttpService__6 (copy)
    for v48, v49 in l__HttpService__6:JSONDecode(p47.ReplicatedState.SpotData) do
        p47.Spots[v48]:SyncToData(v49);
    end;
end;
function v9.CreateIKControlAndMapTo(p50, p51, p52) --[[ Line: 168 ]]
    -- upvalues: l__LocalPlayer__1 (copy)
    local l__Character__10 = l__LocalPlayer__1.Character;
    local _ = l__Character__10.HumanoidRootPart;
    local v53 = l__Character__10:WaitForChild((`{p51}UpperArm`));
    local v54 = l__Character__10:WaitForChild((`{p51}Hand`));
    local v55 = Instance.new("IKControl");
    v55.Type = Enum.IKControlType.Position;
    v55.ChainRoot = v53;
    v55.EndEffector = v54;
    v55.Enabled = false;
    v55.Target = p52;
    v55.Parent = v53;
    v55.SmoothTime = 0.15;
    p50.Maid:Mark(v55);
    return v55;
end;
function v9.Construct(p56) --[[ Line: 187 ]]
    -- upvalues: l__Mince__7 (copy), u14 (copy)
    if not p56.Instance:FindFirstChild("Players") then
        repeat
            task.wait(1);
        until p56.Instance:FindFirstChild("Players");
    end;
    local v57 = p56.Instance.Players:WaitForChild("1");
    p56:AddSeatJoinSource(v57, (tonumber(v57.Name)));
    p56.Instance.Players["1"]:WaitForChild("ProximityPrompt").ObjectText = `Play (90 {l__Mince__7.Config.HolidayConfigure.EVENT_CURRENCY_NAME})`;
    local l__NPC__11 = p56.Instance.NPC;
    l__NPC__11.Humanoid.Animator:LoadAnimation(l__NPC__11.Animation):Play();
    p56.RaycastWhitelist = RaycastParams.new();
    p56.RaycastWhitelist.FilterType = Enum.RaycastFilterType.Include;
    p56.GamePieceTemplates = p56.Instance.Pieces;
    for _, v58 in p56.Instance.Spots:GetChildren() do
        local v59 = tonumber(v58.Name);
        p56.Spots[v59] = u14.New(v59, {}, v58);
    end;
    p56.PlayerSpot1 = u14.New(13, {}, p56.Instance.Player1Spot);
    p56.PlayerSpot2 = u14.New(14, {}, p56.Instance.Player2Spot);
end;
function v9.ValidateClientEntry(_) --[[ Line: 217 ]]
    -- upvalues: l__Mince__7 (copy), u5 (copy)
    if l__Mince__7.Config.LocalProfile.Holiday >= 90 then
        return true;
    end;
    u5.Display("You don\'t have enough to use this!");
    return false;
end;
function v9.Enter(p60) --[[ Line: 226 ]]
    -- upvalues: u4 (copy), l__Mince__7 (copy), u5 (copy)
    u4.StartInteractions();
    if l__Mince__7.Config.LocalProfile.Holiday < 90 then
        u5.Display("You don\'t have enough to use this!");
    else
        p60.CanPlay = true;
    end;
    if l__Mince__7.Config.Humanoid then
        l__Mince__7.Config.Humanoid:UnequipTools();
    end;
end;
function v9.Start(p61) --[[ Line: 240 ]]
    if not p61.CanPlay then
        return;
    end;
    local v62 = p61:GetLocalSlot();
    if not v62 then
        error("Could not retrieve your slot!");
    end;
    local l__Spots__12 = p61.Instance.Spots;
    p61:DistanceRoundedCameraPan(p61.Instance.Players[v62].Camera.WorldCFrame);
    local v63 = l__Spots__12:GetDescendants();
    p61.Board = l__Spots__12;
    p61.UpdateOpponent = true;
    p61.RaycastWhitelist.FilterDescendantsInstances = v63;
    for _, v64 in p61.Spots do
        v64.SpotPart.Interface.Enabled = true;
    end;
    p61.PlayerSpot1.SpotPart.Interface.Enabled = true;
    p61.PlayerSpot2.SpotPart.Interface.Enabled = true;
    p61.PlayerSpot1.SpotData = {};
    p61.PlayerSpot2.SpotData = {};
    p61.PlayerSpot1:ConstructAppearance();
    p61.PlayerSpot2:ConstructAppearance();
    p61:UnpackSpotData();
    while p61.CanPlay do
        p61:TimedInspect("It\'s your turn!", 3);
        if not p61:PlayTutorialLine("Welcome") and math.random(1, 4) == 1 then
            p61:PlayLine("TurnStart");
        end;
        if not p61.CanPlay then
            break;
        end;
        local v65, v66 = p61:InputSpotAndDirection();
        p61:MoveFromSpotInDirection(1, v65, v66);
        if not p61.CanPlay then
            break;
        end;
        if p61:CheckEndGame() then
            p61.Server:EndGame(p61.PlayerSpot1.Score, p61.PlayerSpot2.Score);
            return;
        end;
        p61:SanityCheck();
        if not p61:PlayTutorialLine("MyTurn") and math.random(1, 3) == 1 then
            p61:PlayLine("TurnEnd");
        end;
        if not p61.CanPlay then
            break;
        end;
        local v67 = math.random(5, 20) / 10;
        p61:TimedInspect("Opponent is thinking...", v67);
        if not p61.CanPlay then
            break;
        end;
        task.wait(v67);
        local v68, v69 = p61:GetBotPlay();
        p61:MoveFromSpotInDirection(2, v68, v69);
        if not p61.CanPlay then
            break;
        end;
        if p61:CheckEndGame() then
            p61.Server:EndGame(p61.PlayerSpot1.Score, p61.PlayerSpot2.Score);
            return;
        end;
        p61:SanityCheck();
    end;
end;
function v9.CheckEndGame(u70) --[[ Line: 318 ]]
    -- upvalues: u13 (copy), u11 (copy), l__TweenService__2 (copy), u12 (copy), u3 (copy)
    local v71 = u70.Spots[u13.X].Score <= 0;
    if u70.Spots[u13.Y].Score > 0 then
        v71 = false;
    end;
    if not u70.CanPlay then
        return true;
    end;
    task.wait(0.5);
    if v71 then
        task.defer(function() --[[ Line: 329 ]]
            -- upvalues: u70 (copy), u13 (ref)
            u70.Spots[u13.X]:Flash(0.7);
        end);
        u70.Spots[u13.Y]:Flash(0.7);
        u70:PlayTutorialLine("GameHasEnded");
        for v72 = u11.X, u11.Y do
            local u73 = u70.Spots[v72];
            for _, u74 in u73.SpotPart.Pieces:GetChildren() do
                l__TweenService__2:Create(u74, TweenInfo.new(0.3), {
                    Position = u70.PlayerSpot1.SpotPart.Position
                }):Play();
                task.delay(0.2, function() --[[ Line: 340 ]]
                    -- upvalues: u74 (copy), u73 (copy), u70 (copy)
                    u74:Destroy();
                    u73.SpotData = {};
                    u73:ConstructAppearance();
                    table.insert(u70.PlayerSpot1.SpotData, {
                        Type = "Small"
                    });
                end);
            end;
        end;
        for v75 = u12.X, u12.Y do
            local u76 = u70.Spots[v75];
            for _, u77 in u76.SpotPart.Pieces:GetChildren() do
                l__TweenService__2:Create(u77, TweenInfo.new(0.3), {
                    Position = u70.PlayerSpot2.SpotPart.Position
                }):Play();
                task.delay(0.2, function() --[[ Line: 353 ]]
                    -- upvalues: u77 (copy), u76 (copy), u70 (copy)
                    u77:Destroy();
                    u76.SpotData = {};
                    u76:ConstructAppearance();
                    table.insert(u70.PlayerSpot2.SpotData, {
                        Type = "Small"
                    });
                end);
            end;
        end;
        u3.PlaySound("OAQMINIGAMEuan.BulkMove");
        u3.PlaySound("OAQMINIGAMEuan.BulkMove");
        task.wait(0.23);
        u70.PlayerSpot2:ConstructAppearance();
        u70.PlayerSpot1:ConstructAppearance();
        u3.PlaySound("OAQMINIGAMEuan.Drop");
        u3.PlaySound("OAQMINIGAMEuan.Drop");
        u3.PlaySound("OAQMINIGAMEuan.Drop");
        task.wait(1);
    end;
    return v71;
end;
function v9.MoveFromSpotInDirection(u78, u79, p80, p81) --[[ Line: 380 ]]
    -- upvalues: l__ModelTweenOG__8 (copy), u3 (copy), l__TweenService__2 (copy), u13 (copy)
    local v82 = u78.Instance.BoardInterface[u79].WorldCFrame * CFrame.Angles(0, 0, 1.5707963267948966);
    local v83 = u78.Spots[p80];
    local l__Pieces__13 = v83.SpotPart.Pieces;
    local v84 = Instance.new("Model");
    v84.Parent = game.Workspace;
    u78.Maid:Mark(v84);
    if u78.CanPlay then
        local u85 = p81 == "Right" and 1 or -1;
        for _, v86 in l__Pieces__13:GetChildren() do
            v86.Parent = v84;
        end;
        l__ModelTweenOG__8.new(v84, TweenInfo.new(0.5), v82).Play();
        u3.PlaySound("OAQMINIGAMEuan.BulkMove");
        v83.SpotData = {};
        v83:ConstructAppearance();
        v83:Flash();
        task.wait(0.3);
        if u78.CanPlay then
            for _, v87 in v84:GetChildren() do
                p80 = (p80 + u85 - 1) % #u78.Spots + 1;
                local v88 = u78.Spots[p80];
                l__TweenService__2:Create(v87, TweenInfo.new(0.3), {
                    Position = v88.SpotPart.Position
                }):Play();
                u3.PlaySound("OAQMINIGAMEuan.Slide");
                task.wait(0.2);
                if not u78.CanPlay then
                    return;
                end;
                local l__SpotData__14 = v88.SpotData;
                local v89 = {
                    Type = string.find(v87.Name, "Large") and "Large" or "Small"
                };
                table.insert(l__SpotData__14, v89);
                v88:ConstructAppearance();
                v87:Destroy();
                u3.PlaySound("OAQMINIGAMEuan.Drop");
                v88:Flash();
            end;
            local v90 = (p80 + u85 - 1) % #u78.Spots + 1;
            if #u78.Spots[v90].SpotData > 0 then
                local v91 = u78.Spots[v90];
                if v91.SpotIndex == u13.X or v91.SpotIndex == u13.Y then
                    v91.SpotPart.Color = Color3.new(1, 0.2, 0.2);
                    u3.PlaySound("OAQMINIGAMEuan.Incorrect");
                    v91:Flash(0.7);
                    v91.SpotPart.Color = Color3.fromRGB(245, 205, 48);
                    u78:PlayTutorialLine("SemicircleEncounter");
                    if u78.CanPlay then
                    end;
                else
                    u78:PlayTutorialLine("ContinueScatter");
                    u78:MoveFromSpotInDirection(u79, v90, p81);
                end;
            else
                local function u101(p92, p93) --[[ Line: 450 ]]
                    -- upvalues: u78 (copy), u85 (copy), u3 (ref), u79 (copy), l__TweenService__2 (ref), u101 (copy)
                    local v94 = u78.Spots[p92];
                    local v95 = (p92 + u85 - 1) % #u78.Spots + 1;
                    local v96 = u78.Spots[v95];
                    if u78.CanPlay then
                        if #v96.SpotData < 1 then
                        else
                            if p93 then
                                u78:PlayTutorialLine("ClaimMultiple");
                            end;
                            v94.SpotPart.Color = Color3.new(0.0666667, 1, 0);
                            u3.PlaySound("OAQMINIGAMEuan.Correct");
                            v94:Flash(0.7);
                            v94.SpotPart.Color = Color3.fromRGB(245, 205, 48);
                            if u78.CanPlay then
                                if v96.Score > 6 and u79 == 1 then
                                    u78:PlayLine("Score");
                                end;
                                for _, v97 in v96.SpotPart.Pieces:GetChildren() do
                                    local v98 = u78[`PlayerSpot{u79}`];
                                    local v99 = {
                                        Type = string.find(v97.Name, "Large") and "Large" or "Small"
                                    };
                                    l__TweenService__2:Create(v97, TweenInfo.new(0.3), {
                                        Position = v98.SpotPart.Position
                                    }):Play();
                                    u3.PlaySound("OAQMINIGAMEuan.Slide");
                                    task.wait(0.2);
                                    if not u78.CanPlay then
                                        return;
                                    end;
                                    table.insert(v98.SpotData, v99);
                                    v96.SpotPart.Interface.Amount.Text = tonumber(v96.SpotPart.Interface.Amount.Text) - (string.find(v97.Name, "Large") and 10 or 1);
                                    v98:ConstructAppearance();
                                    v97:Destroy();
                                    u3.PlaySound("OAQMINIGAMEuan.Drop");
                                    task.defer(v98.Flash, v98);
                                end;
                                v96.SpotData = {};
                                v96:ConstructAppearance();
                                if u78.CanPlay then
                                    local v100 = (v95 + u85 - 1) % #u78.Spots + 1;
                                    if #u78.Spots[v100].SpotData < 1 then
                                        u101(v100, true);
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                u78:PlayTutorialLine("ClaimStones");
                u101(v90);
            end;
        end;
    end;
end;
function v9.ReplenishSide(u102, p103) --[[ Line: 509 ]]
    -- upvalues: u11 (copy), u12 (copy), l__TweenService__2 (copy), u3 (copy)
    local u104 = u102[`PlayerSpot{p103}`];
    local u105 = u102[`PlayerSpot{p103 == 1 and 2 or 1}`];
    local v106 = #u104.SpotData;
    local _ = #u105.SpotData;
    task.wait(0.2);
    if u102.CanPlay then
        for v107, u108 in ipairs(u104.SpotData) do
            table.remove(u104.SpotData, v107);
            local u109 = u104.SpotPart.Pieces[`{v107}{u108.Type}`];
            local u110 = u102.Spots[v107 + ((p103 == 1 and u11 or u12).X - 1)];
            l__TweenService__2:Create(u109, TweenInfo.new(0.3), {
                Position = u110.SpotPart.Position
            }):Play();
            u3.PlaySound("OAQMINIGAMEuan.Slide");
            task.delay(0.2, function() --[[ Line: 533 ]]
                -- upvalues: u102 (copy), u109 (copy), u110 (copy), u108 (copy), u104 (copy), u3 (ref)
                if u102.CanPlay then
                    u109:Destroy();
                    u110.SpotData = {
                        {
                            Type = u108.Type
                        }
                    };
                    u110:ConstructAppearance();
                    u104:ConstructAppearance();
                    u3.PlaySound("OAQMINIGAMEuan.Drop");
                end;
            end);
            task.wait(0.1);
            if not u102.CanPlay then
                return;
            end;
            if v107 == 5 then
                return;
            end;
        end;
        if v106 < 5 then
            for v111, u112 in ipairs(u105.SpotData) do
                table.remove(u105.SpotData, v111);
                local u113 = u105.SpotPart.Pieces[`{v111}{u112.Type}`];
                local u114 = u102.Spots[v111 + ((p103 == 1 and u11 or u12).X - 1)];
                l__TweenService__2:Create(u113, TweenInfo.new(0.3), {
                    Position = u114.SpotPart.Position
                }):Play();
                u3.PlaySound("OAQMINIGAMEuan.Slide");
                task.delay(0.2, function() --[[ Line: 556 ]]
                    -- upvalues: u102 (copy), u113 (copy), u114 (copy), u112 (copy), u105 (copy), u3 (ref)
                    if u102.CanPlay then
                        u113:Destroy();
                        u114.SpotData = {
                            {
                                Type = u112.Type
                            }
                        };
                        u114:ConstructAppearance();
                        u105:ConstructAppearance();
                        u3.PlaySound("OAQMINIGAMEuan.Drop");
                    end;
                end);
                task.wait(0.1);
                if not u102.CanPlay then
                    return;
                end;
                if v111 == 5 - v106 then
                    return;
                end;
            end;
        end;
        if u102.CanPlay then
            task.wait(0.3);
        end;
    end;
end;
function v9.SanityCheck(p115) --[[ Line: 575 ]]
    -- upvalues: u11 (copy), u12 (copy)
    local v116 = true;
    local v117 = true;
    if not p115.CanPlay then
        return;
    end;
    for v118 = u11.X, u11.Y do
        if #p115.Spots[v118].SpotData > 0 then
            v116 = false;
            break;
        end;
    end;
    for v119 = u12.X, u12.Y do
        if #p115.Spots[v119].SpotData > 0 then
            v117 = false;
            break;
        end;
    end;
    if v116 then
        p115:PlayTutorialLine("BoardFlush");
        p115:ReplenishSide(1);
    end;
    if v117 then
        p115:PlayTutorialLine("BoardFlush");
        p115:ReplenishSide(2);
    end;
end;
function v9.GetBotPlay(p120) --[[ Line: 607 ]]
    -- upvalues: u12 (copy)
    local v121 = (1 / 0);
    local v122 = 8;
    for v123 = u12.X, u12.Y do
        if p120.Spots[v123].Score < v121 and p120.Spots[v123].Score > 0 then
            v121 = p120.Spots[v123].Score;
            v122 = v123;
        end;
    end;
    if math.random(1, 2) == 1 then
        return v122, "Left";
    else
        return v122, "Right";
    end;
end;
function v9.InputSpotAndDirection(u124) --[[ Line: 620 ]]
    -- upvalues: u11 (copy), u1 (copy), u3 (copy), l__TweenService__2 (copy), u2 (copy), l__UserInputService__4 (copy), l__RunService__5 (copy)
    local u125 = Instance.new("Attachment", u124.Instance.Board);
    local u126 = u124:CreateIKControlAndMapTo("Right", u125);
    u126.Weight = 0;
    u126.Enabled = true;
    local l__Container__15 = u124.Instance.BoardInterface.DirectionPick.Container;
    local l__Left__16 = l__Container__15.Left;
    local l__Right__17 = l__Container__15.Right;
    l__Left__16:SetAttribute("IsHover", false);
    l__Right__17:SetAttribute("IsHover", false);
    local u127 = nil;
    local u128 = nil;
    local u129 = nil;
    local u130 = nil;
    for v131 = u11.X, u11.Y do
        if #u124.Spots[v131].SpotData >= 1 then
            u124.Spots[v131]:SetAnimationPlaying(true);
        end;
    end;
    local function v136() --[[ Line: 643 ]]
        -- upvalues: u1 (ref), u124 (copy), u11 (ref), u130 (ref), u128 (ref), u129 (ref), u3 (ref), l__Container__15 (copy), l__TweenService__2 (ref)
        local v132 = workspace.CurrentCamera:ScreenPointToRay(u1.X, u1.Y);
        local v133 = workspace:Raycast(v132.Origin, v132.Direction * 500, u124.RaycastWhitelist);
        if v133 and (v133.Instance and v133.Instance.Transparency ~= 1) then
            local v134 = tonumber(v133.Instance.Name);
            if v134 and (v134 >= u11.X and (u11.Y >= v134 and #u124.Spots[v134].SpotData >= 1)) then
                u130 = v134;
                for v135 = u11.X, u11.Y do
                    u124.Spots[v135]:SetAnimationPlaying(false);
                end;
                if u128 then
                    u128:Disconnect();
                    u129:Disconnect();
                    u128 = nil;
                    u129 = nil;
                end;
                u3.PlaySound("OAQMINIGAMEuan.Select");
                task.wait(0.1);
                u124:PlayTutorialLine("DirectionSelect");
                l__Container__15.Parent.Enabled = true;
                l__Container__15.GroupTransparency = 1;
                l__TweenService__2:Create(l__Container__15, TweenInfo.new(0.5), {
                    GroupTransparency = 0.36
                }):Play();
            end;
        end;
    end;
    local function v139() --[[ Line: 678 ]]
        -- upvalues: u128 (ref), l__Left__16 (copy), u126 (copy), u125 (copy), u124 (copy), l__Right__17 (copy), u1 (ref)
        if u128 then
            local v137 = workspace.CurrentCamera:ScreenPointToRay(u1.X, u1.Y);
            local v138 = workspace:Raycast(v137.Origin, v137.Direction * 500, u124.RaycastWhitelist);
            if v138 and (v138.Instance and v138.Instance.Transparency ~= 1) then
                u126.Weight = 1;
                u125.WorldPosition = v138.Instance.Position;
            else
                u126.Weight = 0;
            end;
        elseif l__Left__16:GetAttribute("IsHover") then
            u126.Weight = 1;
            u125.WorldPosition = u124.Instance.BoardInterface.Left.WorldPosition;
        elseif l__Right__17:GetAttribute("IsHover") then
            u126.Weight = 1;
            u125.WorldPosition = u124.Instance.BoardInterface.Right.WorldPosition;
        else
            u126.Weight = 0;
        end;
    end;
    local function v144(u140) --[[ Line: 705 ]]
        -- upvalues: u127 (ref), u3 (ref), u124 (copy)
        local v141 = u140.MouseEnter:Connect(function() --[[ Line: 706 ]]
            -- upvalues: u140 (copy)
            u140:SetAttribute("IsHover", true);
        end);
        local v142 = u140.MouseLeave:Connect(function() --[[ Line: 709 ]]
            -- upvalues: u140 (copy)
            u140:SetAttribute("IsHover", false);
        end);
        local v143 = u140.MouseButton1Down:Connect(function() --[[ Line: 713 ]]
            -- upvalues: u127 (ref), u140 (copy), u3 (ref)
            u127 = u140.Name;
            u3.PlaySound("OAQMINIGAMEuan.Select");
        end);
        u124.Maid:Mark(v141);
        u124.Maid:Mark(v142);
        u124.Maid:Mark(v143);
        return { v141, v142, v143 };
    end;
    local v145 = u2.Get("Interact").OnAction:Connect(v136);
    local v146 = l__UserInputService__4.TouchTapInWorld:Connect(v136);
    local v147 = l__RunService__5.RenderStepped:Connect(v139);
    local v148 = v144(l__Left__16);
    local v149 = v144(l__Right__17);
    u124.Maid:Mark(v147);
    u124.Maid:Mark(v145);
    u124.Maid:Mark(v146);
    repeat
        task.wait();
    until u127 and u130;
    v147:Disconnect();
    for _, v150 in v148 do
        v150:Disconnect();
    end;
    for _, v151 in v149 do
        v151:Disconnect();
    end;
    u126.Weight = 0;
    l__Container__15.Parent.Enabled = false;
    u126:Destroy();
    u125:Destroy();
    return u130, u127;
end;
function v9.Complete(p152, _, p153) --[[ Line: 756 ]]
    -- upvalues: l__TweenService__2 (copy), l__LocalPlayer__1 (copy), u3 (copy), u7 (copy)
    p152.UpdateOpponent = false;
    p152.CanPlay = false;
    p152.Maid:Sweep();
    l__TweenService__2:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.3), {
        CFrame = CFrame.new(p152.Instance.BoardInterface.EndCamera.WorldPosition, game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
    }):Play();
    task.wait(0.3);
    local l__Animator__18 = l__LocalPlayer__1.Character.Humanoid.Animator;
    local v154 = {
        Win = l__Animator__18:LoadAnimation(script.Victory),
        Lose = l__Animator__18:LoadAnimation(script.Defeat)
    };
    if p153 == l__LocalPlayer__1 then
        u3.PlaySound("TicTacToe.Win");
        v154.Win:Play();
        p152:TimedInspect("You win!", 3);
        task.wait(1);
        p152:PlayLine("PlayerWin");
        task.delay(5, function() --[[ Line: 779 ]]
            -- upvalues: u7 (ref)
            u7.ShowRewardsFor("OQuan");
        end);
    else
        u3.PlaySound("TicTacToe.Lose");
        v154.Lose:Play();
        p152:TimedInspect("You lose!", 3);
        task.wait(1);
        p152:PlayLine("OpponentWin");
    end;
end;
function v9.Exit(p155) --[[ Line: 791 ]]
    -- upvalues: u4 (copy)
    p155.CanPlay = false;
    p155.Maid:Sweep();
    for _, v156 in p155.Spots do
        v156.SpotPart.Interface.Enabled = false;
        v156:SetAnimationPlaying(false);
    end;
    u4.EndInteractions();
    p155:DistanceLinearRevertCamera();
    p155:UnlockPlayerMovement();
    p155.PlayerSpot1.SpotPart.Interface.Enabled = false;
    p155.PlayerSpot2.SpotPart.Interface.Enabled = false;
    p155.PlayerSpot1.SpotData = {};
    p155.PlayerSpot2.SpotData = {};
    p155.PlayerSpot1:ConstructAppearance();
    p155.PlayerSpot2:ConstructAppearance();
    p155.Instance.BoardInterface.DirectionPick.Container.Parent.Enabled = false;
end;
return v9;
