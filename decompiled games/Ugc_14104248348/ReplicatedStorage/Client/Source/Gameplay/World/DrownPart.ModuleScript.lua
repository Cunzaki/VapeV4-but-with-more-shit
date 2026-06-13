-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.DrownPart
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__3:Get("Bobbing");
local u2 = l__Mince__3:Get("Effects");
local u3 = l__Mince__3:Get("Locomotion");
local u4 = l__Mince__3:Get("SoundHandler");
local u5 = l__Mince__3:Get("TriggerHandler");
local u6 = l__Mince__3:GetEvent("RequestReset");
local u7 = {
    __IsAsyncSetup = true
};
function u7.Setup() --[[ Line: 21 ]]
    -- upvalues: u7 (copy), u5 (copy), l__LocalPlayer__2 (copy), u3 (copy), u4 (copy), u2 (copy), u1 (copy), u6 (copy)
    u7.Trigger = u5.GetTrigger("Drown");
    u7.Trigger.Entered:Connect(function() --[[ Line: 23 ]]
        -- upvalues: l__LocalPlayer__2 (ref), u3 (ref), u4 (ref), u2 (ref), u1 (ref), u6 (ref)
        local l__Character__4 = l__LocalPlayer__2.Character;
        if l__Character__4 then
            l__Character__4 = l__LocalPlayer__2.Character:FindFirstChild("Humanoid");
        end;
        local l__Character__5 = l__LocalPlayer__2.Character;
        if l__Character__5 then
            l__Character__5 = l__LocalPlayer__2.Character:FindFirstChild("HumanoidRootPart");
        end;
        if l__Character__5 and l__Character__4 then
            if l__Character__5:GetAttribute("Drowned") then
            else
                l__Character__5:SetAttribute("Drowned", true);
                u3.SetEnabled(false);
                l__Character__4:LoadAnimation(script.Drown):Play();
                u4.PlaySound("DrownWater");
                task.defer(function() --[[ Line: 36 ]]
                    -- upvalues: u2 (ref), l__LocalPlayer__2 (ref)
                    task.wait(1);
                    u2.CorrectionSharpEffect({
                        Contrast = 1,
                        Saturation = -1,
                        TintColor = Color3.new(0.1, 0, 0)
                    }, 0.8, 2, function() --[[ Line: 42 ]]
                        -- upvalues: l__LocalPlayer__2 (ref)
                        if not l__LocalPlayer__2.Character then
                            l__LocalPlayer__2.CharacterAdded:Wait();
                        end;
                    end);
                end);
                task.defer(function() --[[ Line: 51 ]]
                    -- upvalues: u1 (ref)
                    local v8 = 0;
                    local v9 = 2;
                    repeat
                        local v10 = v8 / 2;
                        v8 = v8 + task.wait();
                        u1.SetFOVMult(1 + -0.5 * v10);
                    until v9 < v8;
                end);
                task.delay(2, function() --[[ Line: 64 ]]
                    -- upvalues: u6 (ref)
                    u6:Fire(true);
                end);
            end;
        end;
    end);
end;
return u7;
