-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.PlayerSpawningHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Players__2 = game:GetService("Players");
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Config.Regions);
local u1 = require(l__ReplicatedStorage__1.Modules.PlayerConnections).Get();
local l__LocalPlayer__4 = l__Players__2.LocalPlayer;
local u2 = l__Mince__3:Get("ConfigHandler");
local u3 = {
    Disabled = false,
    AltSpawn = nil
};
function u3.ApplySpawn(_, p4) --[[ Line: 17 ]]
    -- upvalues: u3 (copy)
    task.wait();
    p4:WaitForChild("HumanoidRootPart").CFrame = u3.AltSpawn.CFrame * CFrame.new(0, 2, 0);
end;
function u3.TrackPlayer(_) --[[ Line: 24 ]]
    -- upvalues: u3 (copy), l__LocalPlayer__4 (copy), u1 (copy)
    if u3.SpawnAtDefault then
    else
        local function v6(p5) --[[ Line: 29 ]]
            -- upvalues: u3 (ref)
            u3:ApplySpawn(p5);
        end;
        l__LocalPlayer__4.RespawnLocation = u3.AltSpawn;
        u1:AddPlayerConnection(l__LocalPlayer__4, l__LocalPlayer__4.CharacterAdded:Connect(v6));
        if l__LocalPlayer__4.Character then
            task.spawn(v6, l__LocalPlayer__4.Character);
        end;
    end;
end;
function u3.SetupAsync(_) --[[ Line: 41 ]]
    -- upvalues: u3 (copy), u2 (copy), l__LocalPlayer__4 (copy)
    u3.SpawnAtDefault = u2.WaitUntilConfigValue("spawn_set_to_default");
    u3.AltSpawn = workspace:WaitForChild("ABSpawnLocations"):WaitForChild("SpawnCourtyard");
    u3:TrackPlayer(l__LocalPlayer__4);
end;
function u3.Setup(_) --[[ Line: 48 ]]
    -- upvalues: u3 (copy)
    if u3.Disabled then
    else
        task.spawn(function() --[[ Line: 51 ]]
            -- upvalues: u3 (ref)
            u3:SetupAsync();
        end);
    end;
end;
return u3;
