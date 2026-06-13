-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Special.Legacy.Fight
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ContextActionService__1 = game:GetService("ContextActionService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__CollectionService__4 = game:GetService("CollectionService");
local l__LocalPlayer__5 = game:GetService("Players").LocalPlayer;
local l__Mince__6 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__6:GetEvent("Swing");
local u2 = l__Mince__6:GetEvent("FightRingEvent");
local u3 = l__Mince__6:Get("Locomotion");
local u4 = l__Mince__6:Get("BindManager");
local u5 = l__Mince__6:Get("TriggerHandler");
local u6 = l__Mince__6:Get("PlayerCharacterReplication");
local u7 = {
    ToolActive = false,
    LoadedAnimations = {},
    LastSwing = os.clock() - 1
};
function u7.ActivateTool() --[[ Line: 30 ]]
    -- upvalues: u7 (copy), u1 (copy), u3 (copy)
    if u7.ToolActive then
        if os.clock() - u7.LastSwing > 1.5 then
            u7.LastSwing = os.clock();
            u7.Swinging = true;
            local v8 = u7;
            v8.CurrentSwing = v8.CurrentSwing + 1;
            if u7.CurrentSwing > 2 then
                u7.CurrentSwing = 1;
            end;
            u7.SwingAnimations[u7.CurrentSwing]:Play(u7.AnimationFades[u7.CurrentSwing]);
            task.delay(0.18, function() --[[ Line: 41 ]]
                -- upvalues: u1 (ref), u3 (ref), u7 (ref)
                u1:Fire();
                u3.SetWalkDecimal(1, 0.8);
                u7.Swinging = false;
            end);
            u3.SetWalkDecimal(0.6, 0.05);
            task.wait(0.2);
            if u7.ToolActive and u7.Swinging then
                u3.SetWalkDecimal(1, 0.2);
            end;
        end;
    end;
end;
function u7.StartFight(p9) --[[ Line: 56 ]]
    -- upvalues: u7 (copy), u6 (copy), u1 (copy), u3 (copy)
    if u7.Humanoid then
        u7.AnimationFades = {};
        u7.LoadedAnimations = {};
        u7.ToolActive = true;
        u7.CurrentTool = p9;
        local v10 = p9:GetAttribute("Handset");
        if v10 then
            u6.SetHandset(v10);
        end;
        for _, v11 in p9:WaitForChild("Animations"):GetChildren() do
            u7.LoadedAnimations[v11.Name] = u7.Humanoid:LoadAnimation(v11);
            u7.AnimationFades[v11.Name] = v11:GetAttribute("Fade");
        end;
        u7.LoadedAnimations.Idle:Play();
        u7.CurrentSwing = 1;
        u7.SwingAnimations = { u7.LoadedAnimations.Swing1, u7.LoadedAnimations.Swing2 };
    end;
end;
function u7.EndFight(p12) --[[ Line: 92 ]]
    -- upvalues: u6 (copy), u7 (copy), u3 (copy)
    if p12:GetAttribute("Handset") then
        u6.SetHandset(nil);
    end;
    u7.ToolActive = false;
    for _, v13 in u7.LoadedAnimations do
        v13:Stop();
    end;
    u7.LoadedAnimations = {};
    u3.SetWalkDecimal(1);
    task.delay(1.2, function() --[[ Line: 111 ]]
        -- upvalues: u3 (ref)
        u3.SetWalkDecimal(1);
    end);
    u3.BaseSpeed = u3.TargetWalkingSpeed;
end;
function u7.NewCharacter(p14) --[[ Line: 118 ]]
    -- upvalues: u7 (copy), u3 (copy)
    local l__Humanoid__7 = p14:WaitForChild("Humanoid");
    u7.HRP = p14:WaitForChild("HumanoidRootPart");
    u7.Humanoid = l__Humanoid__7;
    l__Humanoid__7.Died:Connect(function() --[[ Line: 126 ]]
        -- upvalues: u7 (ref)
        u7.Humanoid = nil;
        u7.HRP = nil;
        u7.ToolActive = false;
    end);
    u3.SetWalkDecimal(1);
end;
function u7.SetupConnections() --[[ Line: 136 ]]
    -- upvalues: l__ContextActionService__1 (copy), l__CollectionService__4 (copy), u7 (copy)
    l__ContextActionService__1.LocalToolEquipped:Connect(function(p15) --[[ Line: 137 ]]
        -- upvalues: l__CollectionService__4 (ref), u7 (ref)
        if l__CollectionService__4:HasTag(p15, "Fight") then
            u7.StartFight(p15);
        end;
    end);
    l__ContextActionService__1.LocalToolUnequipped:Connect(function(p16) --[[ Line: 144 ]]
        -- upvalues: l__CollectionService__4 (ref), u7 (ref)
        if l__CollectionService__4:HasTag(p16, "Fight") then
            u7.EndFight(p16);
        end;
    end);
end;
function u7.Setup() --[[ Line: 152 ]]
    -- upvalues: u7 (copy), l__LocalPlayer__5 (copy), u4 (copy), u5 (copy), u2 (copy), l__UserInputService__3 (copy)
    u7.SetupConnections();
    l__LocalPlayer__5.CharacterAdded:Connect(u7.NewCharacter);
    if l__LocalPlayer__5.Character then
        u7.NewCharacter(l__LocalPlayer__5.Character);
    end;
    u4.Get("Interact").OnAction:Connect(function(p17) --[[ Line: 159 ]]
        -- upvalues: u7 (ref)
        if p17 == Enum.UserInputState.Begin then
            u7.ActivateTool();
        end;
    end);
    local u18 = nil;
    local v19 = u5.GetTrigger("FightRing");
    v19.Entered:Connect(function() --[[ Line: 167 ]]
        -- upvalues: u18 (ref), u2 (ref)
        u18 = true;
        task.wait(0.5);
        if u18 then
            u2:Fire("Enter");
        end;
    end);
    v19.Leaved:Connect(function() --[[ Line: 174 ]]
        -- upvalues: u18 (ref), u2 (ref)
        u18 = false;
        u2:Fire("Leave");
    end);
    l__UserInputService__3.TouchTapInWorld:Connect(function(_, p20) --[[ Line: 179 ]]
        -- upvalues: u7 (ref)
        if p20 then
        else
            u7.ActivateTool();
        end;
    end);
end;
return u7;
