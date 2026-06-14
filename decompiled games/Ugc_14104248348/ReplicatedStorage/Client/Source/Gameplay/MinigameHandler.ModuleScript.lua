-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__TweenService__3 = game:GetService("TweenService");
local l__RunService__4 = game:GetService("RunService");
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Unify__6 = require(l__ReplicatedStorage__1.Modules.Unify);
local l__MinigameClient__7 = require(script.Classes.MinigameClient);
local l__DefaultSettings__8 = require(script.DefaultSettings);
local l__Signal__9 = require(l__ReplicatedStorage__1.Modules.Signal);
local l__Utility__10 = require(l__ReplicatedStorage__1.Modules.Utility);
local v1 = l__Mince__5:GetEvent("NewMinigameMain");
v1:Extend("Join");
v1:Extend("Leave");
local u2 = v1:Extend("Client");
local u3 = v1:Extend("SetMeta");
local u4 = v1:Extend("Completed");
local u5 = l__Mince__5:Get("Settings");
local u6 = l__Mince__5:Get("InterfaceHandler");
local u7 = {
    WelcomePanel = nil,
    InspectActive = true,
    MinigameReigstry = {},
    MinigameComponents = {},
    MinigameEntered = l__Signal__9.new(),
    MinigameExited = l__Signal__9.new(),
    InspectTween = TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
};
function u7.StartInspectText(p8) --[[ Line: 36 ]]
    -- upvalues: u7 (copy), l__TweenService__3 (copy)
    if u7.NextPendingClosure and coroutine.status(u7.NextPendingClosure) == "suspended" then
        task.cancel(u7.NextPendingClosure);
    end;
    u7.MainPriority.MinigameNotice.Descriptor.Text = p8;
    if not u7.InspectActive then
        u7.InspectActive = true;
        l__TweenService__3:Create(u7.MainPriority.MinigameNotice, u7.InspectTween, {
            GroupTransparency = 0
        }):Play();
    end;
end;
function u7.StopInspectText() --[[ Line: 52 ]]
    -- upvalues: u7 (copy), l__TweenService__3 (copy)
    if u7.InspectActive then
        u7.InspectActive = false;
        l__TweenService__3:Create(u7.MainPriority.MinigameNotice, u7.InspectTween, {
            GroupTransparency = 1
        }):Play();
    end;
end;
function u7.TimedInspectText(p9, p10) --[[ Line: 62 ]]
    -- upvalues: u7 (copy)
    u7.StartInspectText(p9);
    u7.NextPendingClosure = task.delay(p10, u7.StopInspectText);
end;
function u7.StopPresent() --[[ Line: 67 ]]
    -- upvalues: u7 (copy)
    if u7.__LastPresentEvent then
        u7.__LastPresentEvent:Disconnect();
    end;
    u7.MinigameGui:Close();
end;
function u7.TutorialIsVisible() --[[ Line: 75 ]]
    -- upvalues: u7 (copy)
    return u7.MinigameGui.IsActive;
end;
function u7.HasPlayerSeenTutorial(p11) --[[ Line: 79 ]]
    -- upvalues: l__Mince__5 (copy)
    if p11 then
        p11 = l__Mince__5.Config.LocalProfile.MinigameMetas[p11.Name];
    end;
    return p11;
end;
function u7.Present(p12) --[[ Line: 83 ]]
    -- upvalues: u5 (copy), l__Mince__5 (copy), u3 (copy), u7 (copy), l__RunService__4 (copy), l__Unify__6 (copy)
    if p12 and u5.GetValue("MinigameTutorials") or not l__Mince__5.Config.LocalProfile.MinigameMetas[p12.Name] then
        u3:Fire(p12.Name);
        local l__Settings__11 = p12.Settings;
        local l__Welcome__12 = l__Settings__11.Welcome;
        local v13 = l__Mince__5.Config.Minigame.DIFFCULITY_ORDER[l__Welcome__12.Difficulty];
        local l__TweenFrame__13 = u7.MinigameGui.TweenFrame;
        local l__Viewer__14 = l__TweenFrame__13.Viewer;
        local l__Stats__15 = l__Viewer__14.Stats;
        l__TweenFrame__13.Title.Label.Text = l__Welcome__12.Name or p12.Name;
        l__Viewer__14.Header.Video = l__Welcome__12.Video;
        l__Viewer__14.Scroll.CanvasPosition = Vector2.zero;
        l__Viewer__14.Scroll.Description.Text = l__Welcome__12.Description;
        l__Stats__15.Difficulty.Label.Text = v13.Text;
        l__Stats__15.Difficulty.Label.TextColor3 = v13.Color;
        l__Stats__15.Timeout.Label.Text = `{l__Settings__11.Cooldown} minute(s)`;
        l__Viewer__14.Dismiss.Visible = true;
        l__Viewer__14.OkayButton.Visible = false;
        u7.MinigameGui:Switch();
        task.defer(function() --[[ Line: 107 ]]
            -- upvalues: l__Viewer__14 (copy)
            while not l__Viewer__14.Header.IsLoaded do
                task.wait();
            end;
            l__Viewer__14.Header:Play();
        end);
        local u14 = os.clock();
        u7.__LastPresentEvent = l__RunService__4.Stepped:Connect(function() --[[ Line: 116 ]]
            -- upvalues: u14 (copy), l__Mince__5 (ref), l__Viewer__14 (copy), l__Unify__6 (ref), u7 (ref)
            local v15 = os.clock() - u14;
            local v16 = math.ceil(l__Mince__5.Config.Minigame.DISMISS_TIME - v15);
            l__Viewer__14.Dismiss.Label.Text = `Okay ({l__Unify__6.AbbreviatedTime(v16)})`;
            if l__Mince__5.Config.Minigame.DISMISS_TIME <= v15 then
                l__Viewer__14.Dismiss.Visible = false;
                l__Viewer__14.OkayButton.Visible = true;
                u7.__LastPresentEvent:Disconnect();
            end;
        end);
    end;
end;
function u7.GetMinigame(_, p17) --[[ Line: 131 ]]
    -- upvalues: u7 (copy), l__MinigameClient__7 (copy), l__Utility__10 (copy)
    local v18 = u7.MinigameReigstry[p17];
    if v18 then
        return v18;
    end;
    local v19 = p17:GetAttribute("Name");
    local v20 = u7.MinigameComponents[v19];
    assert(v20, "Failure to find a minigame componet with an instance!");
    local v21 = l__MinigameClient__7.new(l__Utility__10.Deepcopy(v20), p17);
    v21:Construct();
    u7.MinigameReigstry[p17] = v21;
end;
function u7.Watch(_, p22, p23) --[[ Line: 145 ]]
    -- upvalues: l__CollectionService__2 (copy)
    local v24 = l__CollectionService__2:GetTagged(p22);
    local v25 = l__CollectionService__2:GetInstanceAddedSignal(p22);
    for _, v26 in v24 do
        p23(v26);
    end;
    v25:Connect(p23);
end;
function u7.SetupMinigames() --[[ Line: 156 ]]
    -- upvalues: u7 (copy), l__Utility__10 (copy), l__DefaultSettings__8 (copy)
    local function v32(p27) --[[ Line: 157 ]]
        -- upvalues: u7 (ref), l__Utility__10 (ref), l__DefaultSettings__8 (ref)
        local v28 = require(p27);
        local l__Settings__16 = p27:WaitForChild("Settings");
        v28.Name = p27.Name;
        v28.Settings = require(l__Settings__16);
        local l__Settings__17 = v28.Settings;
        local v29 = `{v28.Name} has no settings!`;
        assert(l__Settings__17, v29);
        local v30 = u7.MinigameComponents[v28.Name] == nil;
        local v31 = `A minigame handler with the name {v28.Name} already exists!`;
        assert(v30, v31);
        l__Utility__10.ReconcileTable(v28.Settings, l__DefaultSettings__8);
        u7.MinigameComponents[v28.Name] = v28;
    end;
    for _, v33 in script.Components:GetChildren() do
        v32(v33);
    end;
    u7:Watch("MinigameBase", function(p34) --[[ Line: 174 ]]
        -- upvalues: u7 (ref)
        u7:GetMinigame(p34);
    end);
    u7.MinigameEntered:Connect(function(p35) --[[ Line: 178 ]]
        -- upvalues: u7 (ref)
        u7.PlayerIsLocallyInMinigame = true;
        u7.Present(p35);
    end);
    u7.MinigameExited:Connect(function(_) --[[ Line: 183 ]]
        -- upvalues: u7 (ref)
        u7.PlayerIsLocallyInMinigame = false;
        u7.StopPresent();
    end);
end;
function u7.SetupGui() --[[ Line: 190 ]]
    -- upvalues: u6 (copy), u7 (copy)
    u6.NewButton(u7.MinigameGui.TweenFrame.Viewer.OkayButton).Activated:Connect(function() --[[ Line: 192 ]]
        -- upvalues: u7 (ref)
        u7.StopPresent();
    end);
    local l__Viewer__18 = u7.MinigameGui.TweenFrame.Viewer;
    local _ = l__Viewer__18.Stats;
    local function v36() --[[ Line: 200 ]]
        -- upvalues: l__Viewer__18 (copy)
        l__Viewer__18.Scroll.Description.TextScaled = false;
        l__Viewer__18.Scroll.Description.TextSize = math.round(l__Viewer__18.Scroll.AbsoluteSize.X * 0.05);
    end;
    task.defer(v36);
    l__Viewer__18.Scroll:GetPropertyChangedSignal("AbsoluteSize"):Connect(v36);
    l__Viewer__18.Scroll.Description:GetPropertyChangedSignal("TextBounds"):Connect(function() --[[ Line: 206 ]]
        -- upvalues: l__Viewer__18 (copy)
        l__Viewer__18.Scroll.Description.Size = UDim2.new(1, 0, 0, l__Viewer__18.Scroll.Description.TextBounds.Y);
    end);
end;
function u7.Setup() --[[ Line: 211 ]]
    -- upvalues: u7 (copy), u6 (copy), l__MinigameClient__7 (copy), u2 (copy), u4 (copy)
    u7.MinigameGui = u6.Get("GameTutorial");
    u7.MainPriority = u6.GetScreenGui("MainPriority");
    l__MinigameClient__7.Handler = u7;
    u7.SetupGui();
    u7.SetupMinigames();
    u2.Event:Connect(function(p37, p38, ...) --[[ Line: 220 ]]
        -- upvalues: u7 (ref)
        local v39 = u7:GetMinigame(p37);
        if v39 and v39.Client then
            local v40 = v39.Client[p38];
            if v40 then
                v40(v39, ...);
            end;
        end;
    end);
    u4.Event:Connect(function(p41, ...) --[[ Line: 230 ]]
        -- upvalues: u7 (ref)
        local v42 = u7:GetMinigame(p41);
        if v42.Complete then
            v42:Complete(...);
        end;
    end);
end;
return u7;
