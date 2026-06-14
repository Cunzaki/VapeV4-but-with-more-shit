-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Legacy.VeryOld.Notebook
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ContextActionService__1 = game:GetService("ContextActionService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__CollectionService__3 = game:GetService("CollectionService");
local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
local l__Mince__5 = require(l__ReplicatedStorage__2.Modules.Mince);
l__Mince__5:GetEvent("Swing");
local u1 = l__Mince__5:Get("InterfaceHandler");
l__Mince__5:Get("Locomotion");
l__Mince__5:Get("BindManager");
local u2 = l__Mince__5:Get("UserProfile");
local u3 = l__Mince__5:GetEvent("SaveNotebook");
local u4 = {
    TotalLines = 10,
    RecievedUpdate = false,
    CurrentPage = 1,
    ToolActive = false,
    LoadedAnimations = {},
    LineGuis = {},
    Note = {}
};
function u4.StartWriting(p5) --[[ Line: 38 ]]
    -- upvalues: u4 (copy)
    if u4.Humanoid then
        u4.LoadedAnimations = {};
        u4.ToolActive = true;
        u4.CurrentTool = p5;
        for _, v6 in p5:WaitForChild("Animations"):GetChildren() do
            u4.LoadedAnimations[v6.Name] = u4.Humanoid:LoadAnimation(v6);
        end;
        u4.LoadedAnimations.Writing:Play();
        u4.LoadedAnimations.Writing:AdjustSpeed(0);
        u4.Notebook:Open();
    end;
end;
function u4.EndWriting() --[[ Line: 57 ]]
    -- upvalues: u4 (copy), u3 (copy)
    if u4.ToolActive then
        u4.ToolActive = false;
        for _, v7 in u4.LoadedAnimations do
            v7:Stop();
        end;
        u4.LoadedAnimations = {};
        u4.Notebook:Close();
        if u4.RecievedUpdate then
            for v8, v9 in u4.Note do
                u4.Note[v8] = v9:sub(1, 200);
            end;
            u3:Fire(u4.Note);
        end;
    end;
end;
function u4.NewCharacter(p10) --[[ Line: 77 ]]
    -- upvalues: u4 (copy)
    local l__Humanoid__6 = p10:WaitForChild("Humanoid");
    u4.HRP = p10:WaitForChild("HumanoidRootPart");
    u4.Humanoid = l__Humanoid__6;
    l__Humanoid__6.Died:Connect(function() --[[ Line: 85 ]]
        -- upvalues: u4 (ref)
        u4.Humanoid = nil;
        u4.HRP = nil;
        u4.ToolActive = false;
    end);
end;
function u4.SetupConnections() --[[ Line: 93 ]]
    -- upvalues: l__ContextActionService__1 (copy), l__CollectionService__3 (copy), u4 (copy)
    l__ContextActionService__1.LocalToolEquipped:Connect(function(p11) --[[ Line: 94 ]]
        -- upvalues: l__CollectionService__3 (ref), u4 (ref)
        if l__CollectionService__3:HasTag(p11, "Notebook") then
            u4.StartWriting(p11);
        end;
    end);
    l__ContextActionService__1.LocalToolUnequipped:Connect(function(p12) --[[ Line: 101 ]]
        -- upvalues: l__CollectionService__3 (ref), u4 (ref)
        if l__CollectionService__3:HasTag(p12, "Notebook") then
            u4.EndWriting();
        end;
    end);
end;
function u4.JumpWrite() --[[ Line: 108 ]]
    -- upvalues: u4 (copy)
    if u4.ToolActive then
        u4.LoadedAnimations.Writing:AdjustSpeed(1);
        if u4.PreviousRoutine and coroutine.status(u4.PreviousRoutine) == "suspended" then
            coroutine.close(u4.PreviousRoutine);
        end;
        local u13 = os.clock();
        u4.SavedTime = u13;
        u4.PreviousRoutine = task.delay(0.5, function() --[[ Line: 118 ]]
            -- upvalues: u4 (ref), u13 (copy)
            if u4.SavedTime == u13 then
                if not u4.ToolActive then
                    return;
                end;
                u4.LoadedAnimations.Writing:AdjustSpeed(0);
            end;
        end);
    end;
end;
function u4.NavigatePages(p14) --[[ Line: 126 ]]
    -- upvalues: u4 (copy)
    local l__TweenFrame__7 = u4.Notebook.TweenFrame;
    l__TweenFrame__7.RightPage["Page" .. u4.CurrentPage * 2].Visible = false;
    l__TweenFrame__7.LeftPage["Page" .. u4.CurrentPage * 2 - 1].Visible = false;
    if p14 < 0 and u4.CurrentPage == 1 then
        u4.CurrentPage = 5;
    elseif p14 > 0 and u4.CurrentPage == 5 then
        u4.CurrentPage = 1;
    elseif p14 < 0 and u4.CurrentPage == 5 then
        u4.CurrentPage = 4;
    else
        u4.CurrentPage = u4.CurrentPage % 5 + 1 + p14;
    end;
    l__TweenFrame__7.RightPage["Page" .. u4.CurrentPage * 2].Visible = true;
    l__TweenFrame__7.LeftPage["Page" .. u4.CurrentPage * 2 - 1].Visible = true;
    l__TweenFrame__7.PositionIndicator.Text = `{u4.CurrentPage}/5`;
end;
function u4.SetupUI() --[[ Line: 147 ]]
    -- upvalues: u4 (copy), l__ReplicatedStorage__2 (copy), u1 (copy)
    local l__TweenFrame__8 = u4.Notebook.TweenFrame;
    for u15 = 1, u4.TotalLines do
        local u16 = l__ReplicatedStorage__2.Assets.Interface.NotebookText:Clone();
        u16.Parent = u15 % 2 == 0 and l__TweenFrame__8.RightPage or l__TweenFrame__8.LeftPage;
        u16.Visible = u15 == 1 and true or u15 == 2;
        u16.Name = "Page" .. u15;
        u4.LineGuis[u15] = u16;
        u4.Note[u15] = "";
        l__TweenFrame__8.PositionIndicator.Text = `{u4.CurrentPage}/5`;
        u16:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 160 ]]
            -- upvalues: u4 (ref), u15 (copy), u16 (copy)
            u4.Note[u15] = u16.Text;
            u4.JumpWrite();
        end);
    end;
    u1.NewButton(l__TweenFrame__8.Bottom.Left).Activated:Connect(function() --[[ Line: 166 ]]
        -- upvalues: u4 (ref)
        u4.NavigatePages(-2);
    end);
    u1.NewButton(l__TweenFrame__8.Bottom.Right).Activated:Connect(function() --[[ Line: 170 ]]
        -- upvalues: u4 (ref)
        u4.NavigatePages(0);
    end);
end;
function u4.Setup() --[[ Line: 175 ]]
    -- upvalues: u4 (copy), u1 (copy), u2 (copy), l__LocalPlayer__4 (copy)
    u4.Notebook = u1.Get("Notebook");
    u4.SetupConnections();
    u4.SetupUI();
    u2.IndexUpdated("Notebook"):Connect(function(p17) --[[ Line: 181 ]]
        -- upvalues: u4 (ref)
        u4.Note = p17;
        for v18, v19 in p17 do
            u4.LineGuis[tonumber(v18)].Text = v19;
        end;
        task.wait();
        u4.EndWriting();
        task.wait();
        u4.RecievedUpdate = true;
    end);
    l__LocalPlayer__4.CharacterAdded:Connect(u4.NewCharacter);
    if l__LocalPlayer__4.Character then
        u4.NewCharacter(l__LocalPlayer__4.Character);
    end;
end;
return u4;
