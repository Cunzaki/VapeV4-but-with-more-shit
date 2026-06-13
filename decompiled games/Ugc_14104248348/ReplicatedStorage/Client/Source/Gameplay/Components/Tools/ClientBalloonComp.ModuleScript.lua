-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Tools.ClientBalloonComp
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__Workspace__3 = game:GetService("Workspace");
local l__Players__4 = game:GetService("Players");
local l__Maid__5 = require(l__ReplicatedStorage__1.Modules.Maid);
local v1 = require(l__ReplicatedStorage__1.Modules.Mince).Component({
    Tag = "ClientBalloon"
});
function v1.WhenParentChanging(u2) --[[ Line: 19 ]]
    -- upvalues: l__Players__4 (copy), l__ReplicatedStorage__1 (copy), l__Workspace__3 (copy), l__RunService__2 (copy)
    if u2.Handle:IsDescendantOf(game.Workspace) then
        if l__Players__4:GetPlayerFromCharacter(u2.Instance.Parent) then
            local v3 = u2.Instance.Parent:FindFirstChild("Humanoid");
            if v3 then
                local u4 = l__ReplicatedStorage__1.Assets.Balloons:WaitForChild(u2.Name):Clone();
                local u5 = Instance.new("Attachment");
                u5.Parent = l__Workspace__3.Terrain;
                local v6 = Instance.new("RopeConstraint");
                v6.Length = 5;
                v6.Restitution = 0;
                v6.WinchEnabled = false;
                v6.Enabled = false;
                v6.Visible = true;
                v6.Parent = u4;
                u2.ParentMaid:Add(u5);
                u2.ParentMaid:Add(u4);
                u2.ParentMaid:Add(v6);
                u2.ParentMaid:Add(v3.StateChanged:Connect(function(_, p7) --[[ Line: 49 ]]
                    -- upvalues: u4 (copy)
                    if p7 == Enum.HumanoidStateType.Freefall or p7 == Enum.HumanoidStateType.Jumping then
                        u4.LinearVelocity.VectorVelocity = Vector3.new(0, 100, 0);
                    else
                        u4.LinearVelocity.VectorVelocity = Vector3.new(0, 10, 0);
                    end;
                end));
                u2.ParentMaid:Add(l__RunService__2.Heartbeat:Connect(function() --[[ Line: 57 ]]
                    -- upvalues: u5 (copy), u2 (copy)
                    u5.Position = u2.Handle.Attachment.WorldPosition;
                end));
                u4.Position = v3.RootPart.Position;
                u4.Anchored = false;
                u4.Parent = game.Workspace;
                u4.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
                u4.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
                u4.LinearVelocity.Enabled = true;
                u4.AlignOrientation.Enabled = true;
                v6.Attachment0 = u5;
                v6.Attachment1 = u4.RopeTie;
                v6.Enabled = true;
            else
                warn("failure to find humanoid");
            end;
        else
            warn("failrure to find character");
        end;
    else
        u2.ParentMaid:Clean();
    end;
end;
function v1.Construct(u8) --[[ Line: 78 ]]
    -- upvalues: l__Maid__5 (copy)
    u8.ParentMaid = l__Maid__5.new();
    u8.BallonMaid = l__Maid__5.new();
    u8.Handle = u8.Instance:WaitForChild("Handle");
    u8.BallonMaid:Add(u8.ParentMaid);
    u8.BallonMaid:Add(u8.Instance.AncestryChanged:Connect(function() --[[ Line: 86 ]]
        -- upvalues: u8 (copy)
        u8:WhenParentChanging();
    end));
    u8:WhenParentChanging();
end;
function v1.Removing(p9) --[[ Line: 93 ]]
    p9.BallonMaid:Clean();
end;
return v1;
