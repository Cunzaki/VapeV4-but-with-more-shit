-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Gears.Legacy.VeryOld.Notepad
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
local u3 = l__Mince__5:GetEvent("SaveNotes");
local u4 = {
    TotalLines = 23,
    RecievedUpdate = false,
    ToolActive = false,
    LoadedAnimations = {},
    LineGuis = {},
    Note = {}
};
function u4.StartWriting(p5) --[[ Line: 36 ]]
    -- upvalues: u4 (copy)
    if u4.Humanoid then
        u4.LoadedAnimations = {};
        u4.ToolActive = true;
        u4.CurrentTool = p5;
        for _, v6 in p5:WaitForChild("Animations"):GetChildren() do
            u4.LoadedAnimations[v6.Name] = u4.Humanoid:LoadAnimation(v6);
        end;
        u4.LoadedAnimations.Writing:Play();
        u4.Notepad:Open();
    end;
end;
function u4.EndWriting() --[[ Line: 54 ]]
    -- upvalues: u4 (copy), u3 (copy)
    u4.ToolActive = false;
    for _, v7 in u4.LoadedAnimations do
        v7:Stop();
    end;
    u4.LoadedAnimations = {};
    u4.Notepad:Close();
    if u4.RecievedUpdate then
        u3:Fire(u4.Note);
    end;
end;
function u4.NewCharacter(p8) --[[ Line: 69 ]]
    -- upvalues: u4 (copy)
    local l__Humanoid__6 = p8:WaitForChild("Humanoid");
    u4.HRP = p8:WaitForChild("HumanoidRootPart");
    u4.Humanoid = l__Humanoid__6;
    l__Humanoid__6.Died:Connect(function() --[[ Line: 77 ]]
        -- upvalues: u4 (ref)
        u4.Humanoid = nil;
        u4.HRP = nil;
        u4.ToolActive = false;
    end);
end;
function u4.SetupConnections() --[[ Line: 85 ]]
    -- upvalues: l__ContextActionService__1 (copy), l__CollectionService__3 (copy), u4 (copy)
    l__ContextActionService__1.LocalToolEquipped:Connect(function(p9) --[[ Line: 86 ]]
        -- upvalues: l__CollectionService__3 (ref), u4 (ref)
        if l__CollectionService__3:HasTag(p9, "Notepad") then
            u4.StartWriting(p9);
        end;
    end);
    l__ContextActionService__1.LocalToolUnequipped:Connect(function(p10) --[[ Line: 93 ]]
        -- upvalues: l__CollectionService__3 (ref), u4 (ref)
        if l__CollectionService__3:HasTag(p10, "Notepad") then
            u4.EndWriting();
        end;
    end);
end;
function u4.JumpWrite() --[[ Line: 100 ]]
    -- upvalues: u4 (copy)
    if u4.ToolActive then
        u4.LoadedAnimations.Writing:AdjustSpeed(1);
        if u4.PreviousRoutine and coroutine.status(u4.PreviousRoutine) == "suspended" then
            coroutine.close(u4.PreviousRoutine);
        end;
        local u11 = os.clock();
        u4.SavedTime = u11;
        u4.PreviousRoutine = task.delay(0.5, function() --[[ Line: 110 ]]
            -- upvalues: u4 (ref), u11 (copy)
            if u4.SavedTime == u11 then
                if not u4.ToolActive then
                    return;
                end;
                u4.LoadedAnimations.Writing:AdjustSpeed(0);
            end;
        end);
    end;
end;
function u4.SetupUI() --[[ Line: 118 ]]
    -- upvalues: u4 (copy), l__ReplicatedStorage__2 (copy), u1 (copy)
    local l__TweenFrame__7 = u4.Notepad.TweenFrame;
    for u12 = 1, u4.TotalLines do
        local u13 = l__ReplicatedStorage__2.Assets.Interface.Line:Clone();
        u13.Parent = l__TweenFrame__7.Container;
        u13.LayoutOrder = u12;
        u4.LineGuis[u12] = u13;
        u4.Note[u12] = "";
        u13:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 128 ]]
            -- upvalues: u4 (ref), u12 (copy), u13 (copy)
            u4.Note[u12] = u13.Text;
            u4.JumpWrite();
        end);
    end;
    u1.NewButton(l__TweenFrame__7.Bottom.Clear).Activated:Connect(function() --[[ Line: 134 ]]
        -- upvalues: u4 (ref)
        for v14 = 1, u4.TotalLines do
            u4.Note[v14] = "";
            u4.LineGuis[v14].Text = "";
        end;
    end);
end;
function u4.Setup() --[[ Line: 142 ]]
    -- upvalues: u4 (copy), u1 (copy), u2 (copy), l__LocalPlayer__4 (copy)
    u4.Notepad = u1.Get("Notepad");
    u4.SetupConnections();
    u4.SetupUI();
    u2.IndexUpdated("Notepad"):Connect(function(p15) --[[ Line: 148 ]]
        -- upvalues: u4 (ref)
        u4.Note = p15;
        for v16, v17 in p15 do
            u4.LineGuis[tonumber(v16)].Text = v17;
        end;
        u4.RecievedUpdate = true;
    end);
    l__LocalPlayer__4.CharacterAdded:Connect(u4.NewCharacter);
    if l__LocalPlayer__4.Character then
        u4.NewCharacter(l__LocalPlayer__4.Character);
    end;
end;
return u4;
