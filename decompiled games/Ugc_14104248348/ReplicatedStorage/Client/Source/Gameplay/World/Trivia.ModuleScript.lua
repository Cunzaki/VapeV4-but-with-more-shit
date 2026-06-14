-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.Trivia
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__TweenService__2 = game:GetService("TweenService");
local l__Mince__3 = require(game.ReplicatedStorage.Modules.Mince);
require(game.ReplicatedStorage.Modules.Deepcopy);
local u1 = l__Mince__3:Get("InterfaceHandler");
local u2 = l__Mince__3:Get("TriggerHandler");
local u3 = l__Mince__3:Get("SelectInteractor");
local u4 = l__Mince__3:GetEvent("JoinTrivia");
local u5 = l__Mince__3:GetEvent("LeaveTrivia");
local u6 = l__Mince__3:GetEvent("AnswerTrivia");
local u7 = nil;
local u8 = false;
local u9 = nil;
local u10 = Color3.fromRGB(0, 68, 214);
local u11 = {
    Color3.fromRGB(150, 123, 91),
    Color3.fromRGB(143, 0, 214),
    Color3.fromRGB(140, 31, 51),
    Color3.fromRGB(11, 152, 82),
    Color3.fromRGB(0, 150, 214),
    Color3.fromRGB(165, 102, 39),
    Color3.fromRGB(79, 108, 115)
};
local u12 = {};
local u13 = {
    __IsAsyncSetup = true
};
local u14 = ":";
local function u21(p15) --[[ Line: 43 ]]
    local v16 = Random.new();
    for v17 = #p15, 2, -1 do
        local v18 = v16:NextInteger(1, v17);
        local v19 = p15[v18];
        local v20 = p15[v17];
        p15[v17] = v19;
        p15[v18] = v20;
    end;
    return p15;
end;
function u13.SwitchScreens(p22) --[[ Line: 53 ]]
    -- upvalues: u7 (ref), u10 (ref), l__TweenService__2 (copy), u11 (copy)
    local l__UIGradient__4 = u7.Main.Transition.UIGradient;
    l__UIGradient__4.Color = ColorSequence.new(u10);
    l__UIGradient__4.Offset = Vector2.new(-1, 0);
    l__UIGradient__4.Transparency = NumberSequence.new(0, 1);
    l__TweenService__2:Create(l__UIGradient__4, TweenInfo.new(0.25), {
        Offset = Vector2.new(1, 0)
    }):Play();
    task.wait(0.25);
    u10 = u11[math.random(1, #u11)];
    u7.Main.BackgroundColor3 = u10;
    for _, v23 in pairs(u7.Main:GetChildren()) do
        if v23.Name ~= "Transition" and (v23.Name ~= "Timer" and v23:IsA("Frame")) then
            v23.Visible = false;
        end;
    end;
    u7.Main[p22].Visible = true;
    l__UIGradient__4.Offset = Vector2.new(-1, 0);
    l__UIGradient__4.Transparency = NumberSequence.new(1, 0);
    l__TweenService__2:Create(l__UIGradient__4, TweenInfo.new(0.25), {
        Offset = Vector2.new(1, 0)
    }):Play();
    task.wait(0.25);
end;
function u13.HydrateLeaderboard(p24) --[[ Line: 76 ]]
    -- upvalues: u7 (ref), u13 (copy), u9 (ref), u14 (ref)
    for _, v25 in pairs(u7.Main.Leaderboard.List:GetChildren()) do
        if v25.Name ~= "Template" and v25:IsA("Frame") then
            v25:Destroy();
        end;
    end;
    if u13.inTrivia then
        u9.Screen.Loop:Stop();
        if u9:GetAttribute("CorrectAnswer") == u14 then
            u9.Screen.Confirm:GetChildren()[math.random(1, 3)]:Play();
        else
            u9.Screen.Reject:GetChildren()[math.random(1, 3)]:Play();
        end;
    end;
    u7.Main.Leaderboard.Title.TextLabel.Text = `Correct Answer: <b>{u9:GetAttribute("CorrectAnswer")}</b>`;
    local v26 = {};
    for v27, v28 in pairs(p24) do
        v26[#v26 + 1] = {
            key = v27,
            value = v28
        };
    end;
    table.sort(v26, function(p29, p30) --[[ Line: 98 ]]
        return p29.value > p30.value;
    end);
    for _, v31 in ipairs(v26) do
        local v32 = u7.Main.Leaderboard.List.Template:Clone();
        v32.Name = "A";
        v32.Parent = u7.Main.Leaderboard.List;
        v32.Username.Text = v31.key;
        v32.Score.Text = v31.value;
        local v33, _ = game.Players:GetUserThumbnailAsync(game.Players[v31.key].UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100);
        v32.Label.Image = v33;
        v32.Visible = true;
    end;
end;
function u13.JoinTrivia() --[[ Line: 115 ]]
    -- upvalues: u13 (copy), u9 (ref), u4 (copy)
    u13.inTrivia = true;
    if u9:GetAttribute("CurrentScreen") == "Question" then
        u9.Screen.Loop:Play();
    end;
    u4:Fire();
end;
function u13.LeaveTrivia() --[[ Line: 123 ]]
    -- upvalues: u13 (copy), u9 (ref), u5 (copy)
    u13.inTrivia = false;
    u9.Screen.Loop:Pause();
    u5:Fire();
end;
function u13.TimerUpdated() --[[ Line: 129 ]]
    -- upvalues: u9 (ref), u7 (ref), l__TweenService__2 (copy)
    local v34 = u9:GetAttribute("Timer");
    u7.Main.Timer.Progress.Size = UDim2.fromScale(0, 1);
    l__TweenService__2:Create(u7.Main.Timer.Progress, TweenInfo.new(v34), {
        Size = UDim2.fromScale(1, 1)
    }):Play();
end;
function u13.ScreenUpdated() --[[ Line: 136 ]]
    -- upvalues: u9 (ref), u13 (copy), u7 (ref)
    local v35 = u9:GetAttribute("CurrentScreen");
    u13.SwitchScreens(v35);
    if v35 == "Category" then
        u7.Main.Category.Title.TextLabel.Text = `New Category:<br/><b>{u9:GetAttribute("Category")}</b>`;
        if u13.inTrivia then
            u9.Screen.Cat:Play();
        end;
    end;
end;
function u13.QuestionUpdated() --[[ Line: 148 ]]
    -- upvalues: u9 (ref), u7 (ref), u21 (copy), u12 (copy), u13 (copy), u8 (ref)
    local v36 = u9:GetAttribute("Question");
    u7.Main.Question.Title.TextLabel.Text = v36;
    local v37 = u21({
        1,
        2,
        3,
        4
    });
    for _, v38 in pairs(v37) do
        u7.Main.Question.Answers[`Answer{v38}`].Answer.Text = u9:GetAttribute((`Answer{v38}`));
        u12[`Button{v38}`] = u9:GetAttribute((`Answer{v38}`));
    end;
    if u13.inTrivia then
        u9.Screen.Loop:Play();
    end;
    u8 = true;
end;
function u13.SetupButton(u39) --[[ Line: 165 ]]
    -- upvalues: u9 (ref), u8 (ref), l__TweenService__2 (copy), u6 (copy), u12 (copy), u14 (ref), u3 (copy)
    u3.NewInteractionClass({
        HoverName = "Select Answer",
        Name = "Select Answer",
        Model = u39,
        HitCollider = u39.PrimaryPart,
        OnHover = function() --[[ Line: 172 ]]
            -- upvalues: u9 (ref), u8 (ref)
            local v40;
            if u9:GetAttribute("CurrentScreen") == "Question" then
                v40 = u8;
            else
                v40 = false;
            end;
            return v40;
        end,
        Interact = function(_, p41) --[[ Name: Interact, Line 176 ]]
            -- upvalues: u39 (copy), l__TweenService__2 (ref), u6 (ref), u12 (ref), u14 (ref), u8 (ref)
            local v42 = u39:GetAttribute("WallMounted") and Vector3.new(0, 0, -0.3) or Vector3.new(0, -0.15, 0);
            l__TweenService__2:Create(u39.PrimaryPart, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, true), {
                CFrame = CFrame.new(v42):ToWorldSpace(u39.PrimaryPart.CFrame)
            }):Play();
            l__TweenService__2:Create(u39.Text, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, true), {
                CFrame = CFrame.new(v42):ToWorldSpace(u39.Text.CFrame)
            }):Play();
            u39.Press:Play();
            u6:Fire(u12[u39.Name]);
            u14 = u12[u39.Name];
            u8 = false;
            p41();
        end
    });
end;
function u13.Setup() --[[ Line: 190 ]]
    -- upvalues: u13 (copy)
    task.spawn(u13.SetupAsync);
end;
function u13.SetupAsync() --[[ Line: 194 ]]
    -- upvalues: l__CollectionService__1 (copy), u9 (ref), u7 (ref), u1 (copy), u2 (copy), u13 (copy), u6 (copy)
    task.wait(1);
    repeat
        task.wait(0.1);
    until #l__CollectionService__1:GetTagged("Trivia") > 0;
    u9 = l__CollectionService__1:GetTagged("Trivia")[1];
    u7 = u1.GetScreenGui("TriviaScreen");
    local v43 = u2.GetTrigger("Trivia");
    for _, v44 in pairs(l__CollectionService__1:GetTagged("TriviaButton")) do
        u13.SetupButton(v44);
    end;
    v43.Entered:Connect(u13.JoinTrivia);
    v43.Leaved:Connect(u13.LeaveTrivia);
    u9:GetAttributeChangedSignal("Timer"):Connect(u13.TimerUpdated);
    u9:GetAttributeChangedSignal("Question"):Connect(u13.QuestionUpdated);
    u9:GetAttributeChangedSignal("CurrentScreen"):Connect(u13.ScreenUpdated);
    u6.Event:Connect(u13.HydrateLeaderboard);
end;
return u13;
