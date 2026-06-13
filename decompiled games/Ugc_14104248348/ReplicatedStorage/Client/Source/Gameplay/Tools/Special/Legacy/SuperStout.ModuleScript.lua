-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Special.Legacy.SuperStout
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ContextActionService__1 = game:GetService("ContextActionService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local l__CollectionService__3 = game:GetService("CollectionService");
game:GetService("StarterGui");
local l__RunService__4 = game:GetService("RunService");
local l__Players__5 = game:GetService("Players");
local l__LocalPlayer__6 = l__Players__5.LocalPlayer;
local l__Unify__7 = require(l__ReplicatedStorage__2.Modules.Unify);
local l__Mince__8 = require(l__ReplicatedStorage__2.Modules.Mince);
l__Mince__8:GetEvent("Swing");
local u1 = l__Mince__8:Get("Locomotion");
l__Mince__8:Get("BindManager");
local u2 = l__Mince__8:Get("SoundHandler");
local u3 = l__Mince__8:GetEvent("EventInteract");
local u4 = l__Mince__8:Get("SelectInteractor");
local u10 = {
    ToolActive = false,
    LoadedAnimations = {},
    LastSwing = os.clock() - 1,
    Construct = function(u5) --[[ Name: Construct, Line 36 ]]
        -- upvalues: u2 (copy), l__RunService__4 (copy), l__Unify__7 (copy)
        local l__Instance__9 = u5.Instance;
        local l__Handle__10 = l__Instance__9:WaitForChild("Handle");
        local u6 = u2.GetSound("fizz_loop");
        u6.Looped = true;
        u6.Parent = l__Handle__10;
        u6:Play();
        local u7 = u2.GetSound("beep_loop");
        u7.Looped = true;
        u7.Parent = l__Handle__10;
        u7:Play();
        u7.Volume = 2;
        local u9 = l__RunService__4.Heartbeat:Connect(function() --[[ Line: 52 ]]
            -- upvalues: l__Unify__7 (ref), u5 (copy), u6 (copy), u7 (copy)
            local v8 = 1 - l__Unify__7.GetServerTimeUntil(u5.ExplodeOn) / u5.Time;
            u6.PlaybackSpeed = 1 + v8;
            u6.Volume = 1 + v8 * 2;
            u7.PlaybackSpeed = 3 * v8;
        end);
        l__Instance__9.Destroying:Connect(function() --[[ Line: 62 ]]
            -- upvalues: u9 (copy)
            u9:Disconnect();
        end);
    end
};
function u10.StartGame(p11) --[[ Line: 67 ]]
    -- upvalues: u10 (copy), u4 (copy), l__Players__5 (copy), l__LocalPlayer__6 (copy), u3 (copy)
    if u10.Humanoid then
        u4.LockInteractions();
        u10.LoadedAnimations = {};
        u10.ToolActive = true;
        u10.CurrentTool = p11;
        for _, v12 in p11:WaitForChild("Animations"):GetChildren() do
            u10.LoadedAnimations[v12.Name] = u10.Humanoid:LoadAnimation(v12);
        end;
        u10.LoadedAnimations.Idle:Play();
        local v13 = Instance.new("Part");
        v13.CanTouch = true;
        v13.Transparency = 1;
        v13.CanCollide = false;
        v13.CanQuery = false;
        v13.Size = Vector3.new(4, 4, 4);
        u10.TouchBox = v13;
        local u14 = Instance.new("Motor6D");
        u14.Part0 = v13;
        u14.Part1 = u10.HRP;
        u14.Parent = u10.HRP;
        v13.Parent = u10.HRP;
        local u15 = false;
        v13.Touched:Connect(function(p16) --[[ Line: 102 ]]
            -- upvalues: u15 (ref), l__Players__5 (ref), l__LocalPlayer__6 (ref), u3 (ref), u14 (copy)
            if u15 then
            else
                if p16 and (p16.Parent and p16.Parent:IsA("Model")) then
                    local v17 = l__Players__5:GetPlayerFromCharacter(p16.Parent);
                    if not v17 or v17 == l__LocalPlayer__6 then
                        return;
                    end;
                    u3:Fire(v17);
                    u15 = true;
                    u14.C0 = CFrame.new(Vector3.new(0, 10000, 0));
                    task.wait();
                    u14.C0 = CFrame.new();
                    u15 = false;
                end;
            end;
        end);
    end;
end;
function u10.EndGame() --[[ Line: 122 ]]
    -- upvalues: u4 (copy), u10 (copy)
    u4.UnlockInteractions();
    if u10.TouchBox then
        u10.TouchBox:Destroy();
    end;
    u10.ToolActive = false;
    u10.TouchBox = nil;
    for _, v18 in u10.LoadedAnimations do
        v18:Stop();
    end;
    u10.LoadedAnimations = {};
end;
function u10.NewCharacter(p19) --[[ Line: 139 ]]
    -- upvalues: u10 (copy), u1 (copy)
    local l__Humanoid__11 = p19:WaitForChild("Humanoid");
    u10.HRP = p19:WaitForChild("HumanoidRootPart");
    u10.Humanoid = l__Humanoid__11;
    l__Humanoid__11.Died:Connect(function() --[[ Line: 147 ]]
        -- upvalues: u10 (ref)
        u10.Humanoid = nil;
        u10.HRP = nil;
        u10.ToolActive = false;
    end);
    u1.SetWalkDecimal(1);
end;
function u10.SetupConnections() --[[ Line: 157 ]]
    -- upvalues: l__ContextActionService__1 (copy), l__CollectionService__3 (copy), u10 (copy)
    l__ContextActionService__1.LocalToolEquipped:Connect(function(p20) --[[ Line: 158 ]]
        -- upvalues: l__CollectionService__3 (ref), u10 (ref)
        if l__CollectionService__3:HasTag(p20, "SuperStout") then
            u10.StartGame(p20);
        end;
    end);
    l__ContextActionService__1.LocalToolUnequipped:Connect(function(p21) --[[ Line: 165 ]]
        -- upvalues: l__CollectionService__3 (ref), u10 (ref)
        if l__CollectionService__3:HasTag(p21, "SuperStout") then
            u10.EndGame();
        end;
    end);
end;
function u10.Setup() --[[ Line: 174 ]]
    -- upvalues: u10 (copy), l__LocalPlayer__6 (copy), l__Mince__8 (copy)
    u10.SetupConnections();
    l__LocalPlayer__6.CharacterAdded:Connect(u10.NewCharacter);
    if l__LocalPlayer__6.Character then
        u10.NewCharacter(l__LocalPlayer__6.Character);
    end;
    l__Mince__8.SetupComponent("SuperStout", u10.Construct);
end;
return u10;
