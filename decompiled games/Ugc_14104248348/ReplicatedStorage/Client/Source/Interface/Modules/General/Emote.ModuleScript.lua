-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.Emote
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__Players__3 = game:GetService("Players");
local l__LocalPlayer__4 = l__Players__3.LocalPlayer;
local l__Case__5 = require(l__ReplicatedStorage__1.Modules.Case);
local l__Mince__6 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = require(l__ReplicatedStorage__1.Modules.PlayerConnections).Get();
local u2 = l__Mince__6:Get("Notices");
local u3 = l__Mince__6:Get("Locomotion");
local u4 = l__Mince__6:Get("Inventory");
local u5 = l__Mince__6:Get("SelectInteractor");
local u6 = l__Mince__6:Get("InterfaceHandler");
local u7 = l__Mince__6:Get("PlayerCharacterReplication");
local u8 = l__Mince__6:GetEvent("EmoteCollabSync");
local u9 = l__Mince__6:GetEvent("LockUpEmoteCollab");
local u10 = l__Mince__6:GetEvent("FinishEmoteCollab");
local u11 = {
    EmoteActive = false,
    Animations = {},
    UnlockKeyLookup = {},
    EmoteCase = l__Case__5.new()
};
function u11.IsActive() --[[ Line: 31 ]]
    -- upvalues: u11 (copy)
    return u11.EmoteActive;
end;
function u11.FindEmote(p12) --[[ Line: 35 ]]
    -- upvalues: l__Mince__6 (copy)
    for _, v13 in l__Mince__6.Config.Emotes do
        if v13.Animation == p12 then
            return v13;
        end;
    end;
end;
function u11.PlayEmote(u14) --[[ Line: 43 ]]
    -- upvalues: u11 (copy), u5 (copy), u2 (copy), u7 (copy), u3 (copy), l__ReplicatedStorage__1 (copy), l__LocalPlayer__4 (copy), u8 (copy)
    local l__CurrentCamera__7 = game.Workspace.CurrentCamera;
    u11.UpdateReferences();
    if u11.Humanoid and u11.Head then
        if u11.EmoteActive then
            u11.StopEmote();
            task.wait();
        end;
        if u11.Humanoid.Sit or (not u11.EmoteCase:GetValue() or u5.IsInteractionActive()) then
            u2.Error("You cannot emote right now!");
        else
            if u14.UnequipTools and u11.Humanoid then
                u11.Humanoid:UnequipTools();
            end;
            if u14.Handset then
                u7.SetHandset(u14.Handset);
            end;
            u3.PopCaptures();
            u11.ThisEmote = u14;
            u11.EmoteActive = true;
            u11.Animations = {};
            local v15 = l__ReplicatedStorage__1.Assets.Emotes:FindFirstChild(u14.Animation or "Default");
            if v15 then
                local v16 = u14.Speed or (v15:GetAttribute("Speed") or 1);
                u11.SpeedMultiplier = v16;
                if v15 then
                    for _, v17 in v15:GetChildren() do
                        if v17:IsA("Animation") then
                            local v18 = u11.Humanoid:LoadAnimation(v17);
                            u11.Animations[v17.Name] = v18;
                        end;
                    end;
                else
                    warn((`No animations could be loaded for '{u14.Name}'.`));
                end;
                local l__Character__8 = l__LocalPlayer__4.Character;
                if l__Character__8 then
                    l__Character__8 = l__LocalPlayer__4.Character:FindFirstChild("Head");
                end;
                if l__LocalPlayer__4.Character then
                    l__LocalPlayer__4.Character:FindFirstChild("Humanoid");
                end;
                l__CurrentCamera__7.CameraSubject = l__Character__8 or u11.Head;
                u5.StartInteractions();
                u3.SetEnabled(false);
                if u14.PlayThenStop and u11.Animations.Start then
                    u11.Animations.Start:Play(u14.FadeTime);
                    u11.Animations.Start:AdjustSpeed(v16);
                    u11.Animations.Start.Stopped:Wait();
                    u3.SetEnabled(true);
                    u11.StopEmote();
                else
                    if u11.Animations.Start and u11.Animations.Idle then
                        u11.Animations.Start.Ended:Connect(function() --[[ Line: 112 ]]
                            -- upvalues: u14 (copy), u8 (ref), u3 (ref), u11 (ref)
                            if u14.CollabAction then
                                warn("sync up!");
                                u8:Fire(u14.Animation);
                            end;
                            u3.SetEnabled(true);
                            u3.Capture():Connect(function() --[[ Line: 119 ]]
                                -- upvalues: u11 (ref), u3 (ref)
                                if u11.IsLocked then
                                    u3.SetEnabled(false);
                                else
                                    u3.SetEnabled(false);
                                    u11.StopEmote();
                                end;
                            end);
                        end);
                        u11.Animations.Start:Play();
                        u11.Animations.Start:AdjustSpeed(v16);
                        task.wait(0.1);
                        if u11.ThisEmote == u14 then
                            u11.Animations.Idle:Play();
                        end;
                    else
                        warn((`Lacking enough animations/settings to play '{u14.Name}'.`));
                        warn(u11.Animations, u14);
                        u3.SetEnabled(true);
                    end;
                end;
            else
                warn((`Animation forced to stop because '{u14.Animation}' is not a valid animation folder!`));
                u11.StopEmote();
            end;
        end;
    end;
end;
function u11.StopEmote() --[[ Line: 142 ]]
    -- upvalues: u11 (copy), u8 (copy), u7 (copy), u3 (copy), u5 (copy)
    local l__CurrentCamera__9 = game.Workspace.CurrentCamera;
    if u11.EmoteActive then
        u11.EmoteActive = false;
        if u11.ThisEmote.CollabAction then
            u8:Fire();
        end;
        if u11.ThisEmote.Handset then
            u7.SetHandset(nil);
        end;
        u3.PopCaptures();
        u5.EndInteractions();
        if u11.Animations.End or not u11.Animations.Idle then
            if u11.Animations.End and u11.Animations.Idle then
                u11.Animations.End:Play();
                u11.Animations.Idle:Stop();
                u11.Animations.End.Ended:Wait();
            end;
        else
            u11.Animations.Idle:Stop(0.2);
            task.wait(0.2);
        end;
        l__CurrentCamera__9.CameraSubject = FoundHumanoid or u11.Humanoid;
        u3.SetEnabled(true);
    end;
end;
function u11.SetupEmotes() --[[ Line: 171 ]]
    -- upvalues: l__Mince__6 (copy), l__ReplicatedStorage__1 (copy), u6 (copy), u11 (copy), u4 (copy)
    for v19, u20 in l__Mince__6.Config.Emotes do
        u20.Order = v19;
        u20.UI = l__ReplicatedStorage__1.Assets.Interface.EmoteItem:Clone();
        u20.UI.EmoteName.Text = u20.Name;
        u20.UI.EmoteDesc.Text = u20.Description;
        if u20.Category == "Emote" then
            u20.UI.TypeImage.Image = "rbxassetid://16022402961";
        else
            local _ = u20.Category == "Dance";
        end;
        u6.NewButton(u20.UI, {
            Mult = 0.025
        }).Activated:Connect(function() --[[ Line: 185 ]]
            -- upvalues: u11 (ref), u20 (copy)
            u11.Interface.Close();
            task.delay(0.3, function() --[[ Line: 187 ]]
                -- upvalues: u11 (ref), u20 (ref)
                u11.PlayEmote(u20);
            end);
        end);
        if u20.UnlockKey then
            u20.UI.Visible = u4.EmoteUnlockKeys[u20.UnlockKey];
            u11.UnlockKeyLookup[u20.UnlockKey] = u20;
        end;
        u20.UI.Parent = u11.Interface.TweenFrame.Scroll;
    end;
end;
function u11.FaceMeToThat(p21) --[[ Line: 202 ]]
    -- upvalues: u11 (copy), l__TweenService__2 (copy)
    local l__Rotation__10 = (CFrame.new(u11.HumaonidRootPart.Position, p21.Position) * CFrame.fromOrientation(0, 90, 0)).Rotation;
    local l__Rotation__11 = u11.HumanoidRootPart.CFrame.Rotation;
    local v22 = 0;
    local v23 = 0.5;
    repeat
        v22 = v22 + task.wait();
        u11.HumaonidRootPart.CFrame = CFrame.new(u11.HumaonidRootPart.Position) * l__Rotation__11:Lerp(l__Rotation__10, l__TweenService__2:GetValue(v22 / 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In));
    until v23 < v22;
end;
function u11.WalkToPositionThenWait(p24, p25) --[[ Line: 217 ]]
    -- upvalues: l__Mince__6 (copy), u3 (copy), l__TweenService__2 (copy)
    if l__Mince__6.Config.Humanoid then
        if l__Mince__6.Config.HumanoidRootPart then
            local u26 = coroutine.running();
            local u27 = false;
            local l__Humanoid__12 = u3.Humanoid;
            local l__HumanoidRootPart__13 = l__Mince__6.Config.HumanoidRootPart;
            local v28 = p25.Rotation * CFrame.Angles(0, -1.5707963267948966, 0);
            u3.SetEnabled(false);
            u3.SetUpdating(false);
            l__Humanoid__12.WalkSpeed = 16;
            local function v29() --[[ Line: 230 ]]
                -- upvalues: u27 (ref), u26 (copy)
                if u27 then
                else
                    u27 = true;
                    task.spawn(u26);
                end;
            end;
            l__Humanoid__12.MoveToFinished:Once(v29);
            l__Humanoid__12:MoveTo(p24);
            task.delay(5, v29);
            coroutine.yield();
            local l__Rotation__14 = l__HumanoidRootPart__13.CFrame.Rotation;
            local v30 = 0;
            local v31 = 0.5;
            repeat
                v30 = v30 + task.wait();
                l__HumanoidRootPart__13.CFrame = CFrame.new(l__HumanoidRootPart__13.Position) * l__Rotation__14:Lerp(v28, l__TweenService__2:GetValue(v30 / 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In));
            until v31 < v30;
            u3.SetEnabled(true);
            u3.SetUpdating(true);
            task.wait(0.1);
        end;
    end;
end;
function u11.SetupEmoteReplicateData(u32) --[[ Line: 257 ]]
    -- upvalues: u1 (copy), u11 (copy), u9 (copy), u10 (copy), l__ReplicatedStorage__1 (copy), u3 (copy)
    local u33 = Instance.new("ProximityPrompt");
    u33:SetAttribute("Type", "Radial");
    u33:SetAttribute("SizeMultipler", 0.8);
    u33.ObjectText = "Emote Together";
    u33.MaxActivationDistance = 6;
    u33.Style = Enum.ProximityPromptStyle.Custom;
    u33.Parent = u32.HumanoidRootPart;
    u33.RequiresLineOfSight = false;
    u33.Enabled = false;
    u1:AddCharacterConnection(u32.Player, u33.Triggered:Connect(function() --[[ Line: 268 ]]
        -- upvalues: u32 (copy), u11 (ref), u33 (copy), u9 (ref), u10 (ref), l__ReplicatedStorage__1 (ref), u3 (ref)
        if u32.Character:GetAttribute("EmoteCollabIndex") then
            if u32.Character:GetAttribute("EmoteLocked") then
            elseif u11.EmoteActive then
            elseif u11.CollabEmoteActive then
            else
                u11.CollabEmoteActive = true;
                local u34 = u11.FindEmote(u32.Character:GetAttribute("EmoteCollabIndex"));
                local v35 = u32.HumanoidRootPart.CFrame.Position + u32.HumanoidRootPart.CFrame.LookVector * (u34.StudsDistance or 4);
                local l__Rotation__15 = (CFrame.new(v35, u32.HumanoidRootPart.CFrame.Position) * CFrame.fromOrientation(0, 90, 0)).Rotation;
                u33.Enabled = false;
                u9:Fire(u32.Player);
                u11.WalkToPositionThenWait(v35, l__Rotation__15);
                u10:Fire();
                local u36 = {};
                pcall(function() --[[ Line: 289 ]]
                    -- upvalues: l__ReplicatedStorage__1 (ref), u34 (copy), u11 (ref), u36 (copy)
                    local v37 = l__ReplicatedStorage__1.Assets.Emotes:FindFirstChild(u34.Animation or "Default");
                    if v37 then
                        local _ = u34.Speed or v37:GetAttribute("Speed");
                        for _, v38 in v37:GetChildren() do
                            if v38:IsA("Animation") then
                                local v39 = u11.Humanoid:LoadAnimation(v38);
                                u36[v38.Name] = v39;
                            end;
                        end;
                    else
                        warn("Failed to load animations!");
                    end;
                end);
                if u36 then
                    local v40 = u36.Action2 or u36.Action;
                    u3.SetEnabled(false);
                    v40:Play();
                    v40.Stopped:Wait();
                    u3.SetEnabled(true);
                    u11.CollabEmoteActive = false;
                else
                    u11.CollabEmoteActive = false;
                end;
            end;
        end;
    end));
    u32.EmotePrompt = u33;
end;
function u11.UpdateReferences() --[[ Line: 327 ]]
    -- upvalues: l__LocalPlayer__4 (copy), u11 (copy)
    local l__Character__16 = l__LocalPlayer__4.Character;
    if l__Character__16 then
        l__Character__16 = l__LocalPlayer__4.Character:FindFirstChild("Head");
    end;
    local l__Character__17 = l__LocalPlayer__4.Character;
    if l__Character__17 then
        l__Character__17 = l__LocalPlayer__4.Character:FindFirstChild("Humanoid");
    end;
    local l__Character__18 = l__LocalPlayer__4.Character;
    if l__Character__18 then
        l__Character__18 = l__LocalPlayer__4.Character:FindFirstChild("HumanoidRootPart");
    end;
    if l__Character__17 and (l__Character__18 and l__Character__16) then
        u11.Head = l__Character__16;
        u11.Humanoid = l__Character__17;
        u11.HumaonidRootPart = l__Character__18;
    end;
end;
function u11.NewCharacter(u41) --[[ Line: 338 ]]
    -- upvalues: l__Players__3 (copy), u11 (copy), l__LocalPlayer__4 (copy)
    u41:GetAttributeChangedSignal("EmoteLocked"):Connect(function() --[[ Line: 339 ]]
        -- upvalues: l__Players__3 (ref), u41 (copy), u11 (ref)
        local v42 = l__Players__3:GetPlayerByUserId(u41:GetAttribute("EmoteWith"));
        if u41:GetAttribute("EmoteLocked") then
            local l__ThisEmote__19 = u11.ThisEmote;
            u11.IsLocked = true;
            task.delay(5, function() --[[ Line: 347 ]]
                -- upvalues: u11 (ref), l__ThisEmote__19 (copy)
                u11.IsLocked = false;
                if l__ThisEmote__19 == u11.ThisEmote then
                    u11.StopEmote();
                end;
            end);
            local v43 = v42 and v42.Character;
            if v43 then
                v43 = v42.Character:FindFirstChild("HumanoidRootPart");
            end;
            if v43 then
                u11.FaceMeToThat(v43);
            end;
        elseif u11.ThisEmote.CollabAction then
            u11.Animations.Action:Play();
            u11.Animations.Action.Stopped:Wait();
            u11.StopEmote();
        end;
    end);
    local l__HumanoidRootPart__20 = u41:WaitForChild("HumanoidRootPart");
    local l__Humanoid__21 = u41:WaitForChild("Humanoid");
    u11.Humanoid = l__Humanoid__21;
    u11.HumaonidRootPart = l__HumanoidRootPart__20;
    u11.EmoteActive = false;
    l__Humanoid__21.Died:Connect(u11.StopEmote);
    if not l__LocalPlayer__4:HasAppearanceLoaded() then
        l__LocalPlayer__4.CharacterAppearanceLoaded:Wait();
    end;
    u11.Head = u41:WaitForChild("Head");
end;
function u11.SyncUnlockKeys() --[[ Line: 388 ]]
    -- upvalues: u11 (copy), u4 (copy)
    for v44, v45 in u11.UnlockKeyLookup do
        v45.UI.Visible = u4.EmoteUnlockKeys[v44];
    end;
end;
function u11.SetupUI() --[[ Line: 394 ]]
    -- upvalues: u6 (copy), u11 (copy)
    u6.NewButton(u11.Interface.TweenFrame.CloseButton).Activated:Connect(u11.Interface.Close);
end;
function u11.Trigger() --[[ Line: 401 ]]
    -- upvalues: u11 (copy)
    u11.Interface.Trigger();
end;
function u11.Setup() --[[ Line: 407 ]]
    -- upvalues: u11 (copy), u6 (copy), u4 (copy), u7 (copy), l__LocalPlayer__4 (copy)
    u11.Interface = u6.Get("Emotes");
    u11.SetupUI();
    u11.SetupEmotes();
    u11.SyncUnlockKeys();
    u4.EmoteUnlockKeysChanged:Connect(u11.SyncUnlockKeys);
    u7.ReplicateDataAdded:Connect(u11.SetupEmoteReplicateData);
    l__LocalPlayer__4.CharacterAdded:Connect(u11.NewCharacter);
    if l__LocalPlayer__4.Character then
        u11.NewCharacter(l__LocalPlayer__4.Character);
    end;
end;
return u11;
