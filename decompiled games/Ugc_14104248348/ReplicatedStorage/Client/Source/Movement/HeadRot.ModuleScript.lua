-- Decompiled from: ReplicatedStorage.Client.Source.Movement.HeadRot
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local l__TweenService__1 = game:GetService("TweenService");
game:GetService("RunService");
local _ = game:GetService("Players").LocalPlayer;
local u1 = {
    Tween = TweenInfo.new(0.3, Enum.EasingStyle.Sine)
};
function u1.NewCharacter(p2) --[[ Line: 12 ]]
    -- upvalues: u1 (copy)
    local l__HumanoidRootPart__2 = p2:WaitForChild("HumanoidRootPart");
    local l__Neck__3 = p2:WaitForChild("Head"):WaitForChild("Neck");
    u1.Character = p2;
    u1.HumanoidRootPart = l__HumanoidRootPart__2;
    u1.Neck = l__Neck__3;
end;
function u1.Update(_) --[[ Line: 21 ]]
    -- upvalues: u1 (copy), l__TweenService__1 (copy)
    local l__CurrentCamera__4 = workspace.CurrentCamera;
    if u1.HumanoidRootPart and u1.Neck then
        if l__CurrentCamera__4.CameraSubject and (l__CurrentCamera__4.CameraSubject:IsA("Humanoid") and l__CurrentCamera__4.CameraSubject.Parent == u1.Character) then
            local l__unit__5 = u1.HumanoidRootPart.CFrame:toObjectSpace(l__CurrentCamera__4.CFrame).LookVector.unit;
            u1.ActualC0 = CFrame.new(u1.Neck.C0.p) * CFrame.Angles(math.asin(l__unit__5.y), -math.asin(l__unit__5.x), 0);
            l__TweenService__1:Create(u1.Neck, u1.Tween, {
                C0 = u1.ActualC0
            }):Play();
        end;
    end;
end;
function u1.Setup() --[[ Line: 38 ]] end;
return u1;
