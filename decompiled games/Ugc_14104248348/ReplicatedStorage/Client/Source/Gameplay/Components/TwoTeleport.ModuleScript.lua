-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.TwoTeleport
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("Effects");
local u2 = l__Mince__3:Get("WorldCulling");
local v3 = l__Mince__3.Component({
    Tag = "TwoTeleport"
});
function v3.Teleport(_, p4) --[[ Line: 17 ]]
    -- upvalues: l__LocalPlayer__2 (copy), u2 (copy), u1 (copy)
    local l__Character__4 = l__LocalPlayer__2.Character;
    local l__Character__5 = l__LocalPlayer__2.Character;
    if l__Character__5 then
        l__Character__5 = l__LocalPlayer__2.Character:FindFirstChild("Humanoid");
    end;
    if l__Character__5 then
        u2.SetRenderFocus(p4);
        task.spawn(u1.PlayBlackout, 0.6);
        task.wait(0.5);
        if l__Character__5.SeatPart then
            l__Character__5.Sit = false;
            local v5 = l__Character__5.SeatPart:FindFirstChild("SeatWeld");
            if v5 then
                v5:Destroy();
            end;
        end;
        l__Character__4:PivotTo(CFrame.new(p4 + Vector3.new(0, 1, 0) * l__Character__5.HipHeight));
        u2.SetRenderFocus(nil);
    end;
end;
function v3.CreateProximityPrompt(_, p6, p7) --[[ Line: 36 ]]
    local v8 = Instance.new("ProximityPrompt");
    v8:SetAttribute("Type", "Radial");
    v8:SetAttribute("SizeMultipler", 2);
    v8.ObjectText = p6;
    v8.MaxActivationDistance = 8;
    v8.Style = Enum.ProximityPromptStyle.Custom;
    v8.Parent = p7;
    v8.RequiresLineOfSight = false;
    return v8;
end;
function v3.Construct(u9) --[[ Line: 49 ]]
    u9.Side1 = u9.Instance:WaitForChild("1");
    u9.Side2 = u9.Instance:WaitForChild("2");
    u9.Prox1 = u9:CreateProximityPrompt("Teleport", u9.Side1:WaitForChild("Prompt"));
    u9.Prox2 = u9:CreateProximityPrompt("Teleport", u9.Side2:WaitForChild("Prompt"));
    u9.Prox1.TriggerEnded:Connect(function() --[[ Line: 56 ]]
        -- upvalues: u9 (copy)
        u9:Teleport(u9.Side2:WaitForChild("Ground").Position);
    end);
    u9.Prox2.TriggerEnded:Connect(function() --[[ Line: 60 ]]
        -- upvalues: u9 (copy)
        u9:Teleport(u9.Side1:WaitForChild("Ground").Position);
    end);
end;
return v3;
