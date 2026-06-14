-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.CarMovement
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Workspace__1 = game:GetService("Workspace");
local l__Players__2 = game:GetService("Players");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__CollectionService__4 = game:GetService("CollectionService");
local l__RunService__5 = game:GetService("RunService");
local l__LocalPlayer__6 = l__Players__2.LocalPlayer;
local u1 = require(l__ReplicatedStorage__3.Modules.Mince):GetEvent("RequestReset");
local u2 = {
    PathCenterZ = 65.228,
    StudsToUseRenderStepped = 40,
    StudsPerUpdateThrottle = 60,
    MaxUpdateThorttle = 3,
    PlayerHitTime = 0,
    PlayerHitDeadRequirement = 0.4,
    Cars = {}
};
function u2.GetCameraDistanceToRoadLine() --[[ Line: 29 ]]
    -- upvalues: l__Workspace__1 (copy), u2 (copy)
    local v3 = l__Workspace__1.CurrentCamera:GetRenderCFrame().Z - u2.PathCenterZ;
    return math.abs(v3);
end;
function u2.AddCar(u4) --[[ Line: 33 ]]
    -- upvalues: u2 (copy), l__LocalPlayer__6 (copy), l__RunService__5 (copy), u1 (copy)
    table.insert(u2.Cars, u4);
    local v5 = script.Default:Clone();
    v5.Parent = u4;
    if u4:GetAttribute("Sound") then
        v5.SoundId = `rbxassetid://{u4:GetAttribute("Sound")}`;
    end;
    v5:Play();
    local u6 = script.Alarm:Clone();
    u6.Looped = true;
    u6.Parent = u4;
    local u7 = script.Impact:Clone();
    u7.Parent = u4;
    u4.CanTouch = true;
    u4.Touched:Connect(function(p8) --[[ Line: 55 ]]
        -- upvalues: l__LocalPlayer__6 (ref), u4 (copy), u2 (ref), l__RunService__5 (ref), u1 (ref), u7 (copy), u6 (copy)
        local v9 = p8.Parent and (p8.Parent == l__LocalPlayer__6.Character and l__LocalPlayer__6.Character:FindFirstChild("HumanoidRootPart"));
        if v9 then
            local v10 = RaycastParams.new();
            v10.FilterType = Enum.RaycastFilterType.Exclude;
            v10.FilterDescendantsInstances = { l__LocalPlayer__6.Character };
            local v11 = game.Workspace:Raycast(v9.Position, Vector3.new(-0, -10, -0), v10);
            if v11 and v11.Instance ~= u4 then
                local v12 = u2;
                v12.PlayerHitTime = v12.PlayerHitTime + l__RunService__5.Heartbeat:Wait();
                u2.WasJustHit = true;
                if u2.PlayerHitTime > u2.PlayerHitDeadRequirement and not l__LocalPlayer__6.Character:GetAttribute("HitByCar") then
                    u2.PlayerHitTime = 0;
                    l__LocalPlayer__6.Character:SetAttribute("HitByCar", true);
                    u1:Fire();
                    u7:Play();
                    u6:Play();
                    task.defer(function() --[[ Line: 77 ]]
                        -- upvalues: u6 (ref)
                        task.wait(0.3);
                        u6:Stop();
                    end);
                end;
            end;
        end;
    end);
end;
function u2.RemoveCar(p13) --[[ Line: 88 ]]
    -- upvalues: u2 (copy)
    for v14 = #u2.Cars, 1, -1 do
        if u2.Cars[v14] == p13 then
            table.remove(u2.Cars, v14);
        end;
    end;
end;
function u2.Update() --[[ Line: 95 ]]
    -- upvalues: u2 (copy), l__Workspace__1 (copy)
    local v15 = {};
    for _, v16 in u2.Cars do
        local v17 = v16:GetAttribute("StartPosition");
        local v18 = v16:GetAttribute("EndPosition");
        local v19 = v16:GetAttribute("CarSpeed");
        local v20 = v19 * (l__Workspace__1:GetServerTimeNow() - v16:GetAttribute("StartTime"));
        local v21 = CFrame.new(v17, v18) * CFrame.new(0, 0, -v20);
        v16.AssemblyLinearVelocity = v16.CFrame.LookVector * v19;
        table.insert(v15, v21);
    end;
    l__Workspace__1:BulkMoveTo(u2.Cars, v15);
end;
function u2.Setup() --[[ Line: 114 ]]
    -- upvalues: l__CollectionService__4 (copy), u2 (copy), l__RunService__5 (copy)
    l__CollectionService__4:GetInstanceAddedSignal("AnimatedCar"):Connect(u2.AddCar);
    for _, v22 in l__CollectionService__4:GetTagged("AnimatedCar") do
        u2.AddCar(v22);
    end;
    l__CollectionService__4:GetInstanceRemovedSignal("AnimatedCar"):Connect(u2.RemoveCar);
    l__RunService__5.RenderStepped:Connect(function() --[[ Line: 126 ]]
        -- upvalues: u2 (ref)
        if u2.GetCameraDistanceToRoadLine() > u2.StudsToUseRenderStepped then
        else
            u2.Update();
        end;
    end);
    local u23 = 0;
    l__RunService__5.Stepped:Connect(function() --[[ Line: 134 ]]
        -- upvalues: u2 (ref), u23 (ref)
        local v24 = u2.GetCameraDistanceToRoadLine();
        if v24 <= u2.StudsToUseRenderStepped then
        elseif u23 <= 0 then
            u2.Update();
            local v25 = math.floor(v24 / u2.StudsPerUpdateThrottle);
            u23 = math.min(v25, u2.MaxUpdateThorttle);
        else
            u23 = u23 + -1;
        end;
    end);
end;
return u2;
