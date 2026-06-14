-- Decompiled from: ReplicatedStorage.Assets.Cutscenes.LNY2026Cutscene.Camera Rig.CameraLock
-- Class: LocalScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

wait(2);
local u1 = workspace:FindFirstChild("CamLock", true);
local l__CurrentCamera__1 = workspace.CurrentCamera;
if u1 then
    l__CurrentCamera__1.CameraType = Enum.CameraType.Scriptable;
    game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 8 ]]
        -- upvalues: l__CurrentCamera__1 (copy), u1 (copy)
        l__CurrentCamera__1.CFrame = u1.CFrame;
    end);
end;
