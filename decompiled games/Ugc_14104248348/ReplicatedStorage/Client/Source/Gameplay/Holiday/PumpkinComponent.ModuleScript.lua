-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.PumpkinComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__3:Get("InterfaceHandler");
l__Mince__3:Get("Notices");
local v1 = l__Mince__3.Component({
    Tag = "CollectPumpkin"
});
function v1.Construct(u2) --[[ Line: 15 ]]
    -- upvalues: l__TweenService__2 (copy)
    repeat
        task.wait();
    until u2.Instance:GetAttribute("Spawned");
    local l__Position__4 = u2.Instance.Mesh.Position;
    local function v5() --[[ Line: 19 ]]
        -- upvalues: u2 (copy), l__TweenService__2 (ref), l__Position__4 (copy)
        if u2.Instance:IsDescendantOf(game.Workspace) then
            for _, v3 in u2.Instance.Mesh:GetDescendants() do
                if v3:IsA("ParticleEmitter") then
                    v3.Enabled = true;
                elseif v3:IsA("Sound") then
                    v3:Resume();
                end;
            end;
            u2.Instance.Mesh.Position = u2.Instance.Mesh.Position - Vector3.new(0, 1, 0) * u2.Instance.Mesh.Size.Y;
            l__TweenService__2:Create(u2.Instance.Mesh, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                Orientation = u2.Instance.Mesh.Orientation + Vector3.new(0, 360, 0),
                Position = l__Position__4
            }):Play();
            task.wait(1);
            for _, v4 in u2.Instance.Mesh:GetDescendants() do
                if v4:IsA("ParticleEmitter") then
                    v4.Enabled = false;
                elseif v4:IsA("Sound") then
                    v4:Pause();
                end;
            end;
        end;
    end;
    v5();
    u2.Instance:GetPropertyChangedSignal("Parent"):Connect(v5);
end;
return v1;
