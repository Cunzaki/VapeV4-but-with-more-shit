-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.CollectableEggCapsule
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__2:Get("InterfaceHandler");
l__Mince__2:Get("Notices");
local u1 = l__Mince__2:Get("UserProfile");
local u2 = l__Mince__2:GetEvent("ClaimEggCapsule");
local u3 = l__Mince__2.Component({
    Tag = "FindableCapsule",
    Disabled = true
});
function u3.Construct(p4) --[[ Line: 19 ]]
    -- upvalues: u2 (copy)
    if p4.Disabled then
    else
        local l__Instance__3 = p4.Instance;
        local v5 = Instance.new("ProximityPrompt");
        v5:SetAttribute("Type", "Radial");
        v5.ObjectText = "Collect Egg";
        v5.Style = Enum.ProximityPromptStyle.Custom;
        v5.Parent = l__Instance__3.Top;
        v5.Triggered:Connect(function() --[[ Line: 30 ]]
            -- upvalues: u2 (ref), l__Instance__3 (copy)
            u2:Fire(l__Instance__3.Name);
            l__Instance__3:Destroy();
        end);
    end;
end;
function u3.Setup() --[[ Line: 36 ]]
    -- upvalues: u3 (copy), u1 (copy), l__ReplicatedStorage__1 (copy)
    if u3.Disabled then
    else
        local u6 = nil;
        u1.Upon("EggCapsulesFound", function(p7) --[[ Line: 42 ]]
            -- upvalues: u6 (ref)
            if not u6 then
                repeat
                    task.wait();
                until u6;
            end;
            for v8, v9 in p7 do
                if v9 and u6:FindFirstChild(v8) then
                    u6[v8]:Destroy();
                end;
            end;
            u6.Parent = workspace;
        end);
        u6 = l__ReplicatedStorage__1.Assets:WaitForChild("FindableCapsules");
    end;
end;
return u3;
