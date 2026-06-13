-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.GarbageCan
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__Players__2 = game:GetService("Players");
game:GetService("Debris");
local l__LocalPlayer__3 = l__Players__2.LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__ModelTweenOG__5 = require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
local u1 = l__Mince__4:Get("BindManager");
l__Mince__4:Get("SoundHandler");
l__Mince__4:Get("InterfaceHandler");
local u2 = l__Mince__4:Get("DrinkHandler");
local u3 = l__Mince__4:Get("SelectInteractor");
local u4 = l__Mince__4:Get("OpeningHandler");
local u5 = l__Mince__4:GetFunction("InteractGarbage");
local u6 = l__Mince__4.Component({
    Tag = "GarbageCan",
    Tween1 = TweenInfo.new(0.4, Enum.EasingStyle.Quint),
    Tween2 = TweenInfo.new(1, Enum.EasingStyle.Bounce)
});
local u7 = {};
local u8 = false;
function QuadBezier(p9, p10, p11, p12)
    return p10:Lerp(p11, p9):Lerp(p11:Lerp(p12, p9), p9);
end;
function u6.Shake(u13, u14) --[[ Line: 39 ]]
    task.defer(function() --[[ Line: 40 ]]
        -- upvalues: u13 (copy), u14 (copy)
        local v15 = u13.Instance:GetPivot();
        local v16 = tick();
        local v17 = os.clock();
        while os.clock() - v17 < u14 do
            local v18 = os.clock() - v17;
            local v19 = v18 / u14;
            local v20 = 1 - (1 - v19) * (1 - v19) * (1 - v19);
            local v21 = math.noise(v16, v18 * 4) * 7 * v20;
            local v22 = math.rad(v21);
            local v23 = Vector3.new(v22, 0, 0);
            u13.Instance:PivotTo(v15 * CFrame.Angles(v23.X, v23.Y, v23.Z));
            task.wait();
        end;
        u13.Instance:PivotTo(v15);
    end);
end;
function u6.JumpIn(p24, p25) --[[ Line: 63 ]]
    -- upvalues: u1 (copy), l__LocalPlayer__3 (copy)
    if u1.CurrentMode ~= "VR" then
        local l__Character__6 = game.Players.LocalPlayer.Character;
        local u26 = Instance.new("Part");
        u26.Transparency = 1;
        u26.CanCollide = false;
        u26.Anchored = true;
        u26.CFrame = l__Character__6:GetPivot();
        p24.Connection = game:GetService("RunService").PostSimulation:Connect(function() --[[ Line: 72 ]]
            -- upvalues: l__LocalPlayer__3 (ref), l__Character__6 (copy), u26 (copy)
            if l__LocalPlayer__3.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead then
            else
                l__Character__6:PivotTo(u26.CFrame);
                l__LocalPlayer__3.Character.PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
                l__LocalPlayer__3.Character.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            end;
        end);
        local l__Rotation__7 = u26.CFrame.Rotation;
        local l__Position__8 = u26.Position;
        local v27 = p25.Position + Vector3.new(0, 1, 0) * (l__Character__6.HumanoidRootPart.Size.Y / 2);
        local v28 = l__Position__8:Lerp(v27, 0.5) * Vector3.new(1, 0, 1) + v27 * Vector3.new(0, 1, 0) + Vector3.new(0, 10, 0);
        local v29 = 0;
        local v30 = 0.5;
        repeat
            v29 = v29 + task.wait();
            local v31 = QuadBezier(v29 / 0.5, l__Position__8, v28, v27);
            u26.CFrame = CFrame.new(v31) * l__Rotation__7;
        until v30 < v29;
        u26.Position = v27;
        p24.Connection:Disconnect();
        u26:Destroy();
    end;
end;
function u6.Construct(u32) --[[ Line: 101 ]]
    -- upvalues: l__ModelTweenOG__5 (copy), u8 (ref), l__LocalPlayer__3 (copy), u7 (copy), u1 (copy), u6 (copy), u2 (copy), u5 (copy), l__Mince__4 (copy), u4 (copy), u3 (copy)
    local l__Lid__9 = u32.Instance:WaitForChild("Lid");
    local l__Dumpster__10 = u32.Instance:WaitForChild("Dumpster");
    local u33 = {
        Closed = l__ModelTweenOG__5.new(l__Lid__9, u32.Tween2, l__Lid__9:GetPivot(), true),
        Opened = l__ModelTweenOG__5.new(l__Lid__9, u32.Tween1, l__Lid__9:GetPivot() * CFrame.fromOrientation(0, 0, 80), true)
    };
    local v34 = {
        MaxDistance = 5,
        HitCollider = l__Dumpster__10,
        Target = u32.Instance,
        HoverName = "Dumpster Dive"
    };
    local l__Instance__11 = u32.Instance;
    local function u35(...) --[[ Line: 123 ]]
        -- upvalues: u32 (copy)
        u32:JumpIn(...);
    end;
    function v34.Interact(_, p36) --[[ Line: 125 ]]
        -- upvalues: u8 (ref), l__Dumpster__10 (copy), l__LocalPlayer__3 (ref), u33 (copy), u7 (ref), u35 (copy), u1 (ref), u6 (ref), l__Instance__11 (copy), u2 (ref), u5 (ref), l__Mince__4 (ref), u4 (ref)
        if u8 then
            return p36();
        end;
        u8 = true;
        l__Dumpster__10.CanCollide = false;
        local l__Character__12 = l__LocalPlayer__3.Character;
        if l__Character__12 then
            l__Character__12 = l__LocalPlayer__3.Character:FindFirstChild("HumanoidRootPart");
        end;
        if not l__Character__12 then
            u8 = false;
            return p36();
        end;
        u33.Opened:Play();
        task.wait(0.1);
        l__LocalPlayer__3.Character.Humanoid.PlatformStand = true;
        l__LocalPlayer__3.Character.Humanoid:UnequipTools();
        local l__CFrame__13 = l__Character__12.CFrame;
        l__Character__12.CFrame = CFrame.lookAt(l__Character__12.Position, l__Dumpster__10.CFrame.Position);
        l__LocalPlayer__3.Character.Humanoid.AutoRotate = false;
        u7.Dive:Play();
        u35(l__Dumpster__10.CFrame);
        if l__LocalPlayer__3.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead then
            u8 = false;
            u33.Closed:Play();
            return p36();
        end;
        l__Character__12.Anchored = true;
        if u1.CurrentMode ~= "VR" then
            u7.HidePlayer:Play(0);
        end;
        u6:Get(l__Instance__11):Shake(4);
        u2.DoProcessingText("Searching...", 4, "search_trash");
        local u37 = u5:Invoke(l__Dumpster__10.Parent, "GetGarbage");
        l__Character__12.CFrame = CFrame.new(l__Character__12.Position) * (CFrame.fromOrientation(math.rad(l__Dumpster__10.Orientation.X), math.rad(l__Dumpster__10.Orientation.Y), (math.rad(l__Dumpster__10.Orientation.Z))) * CFrame.Angles(0, 1.5707963267948966, 0));
        u7.HidePlayer:Stop(0);
        l__LocalPlayer__3.Character.PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
        l__LocalPlayer__3.Character.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
        if u37 then
            local u38 = l__Mince__4.Config.Inventory[string.split(u37.ItemName, ".")[1]][string.split(u37.ItemName, ".")[2]];
            u7.GotItem:Play();
            task.wait(u7.GotItem.Length);
            task.defer(function() --[[ Line: 170 ]]
                -- upvalues: u4 (ref), u38 (copy), u37 (copy)
                u4.DoItemGain({
                    ItemName = u38.Name,
                    IVID = u37.ItemName,
                    Colors = { Color3.new(0.0470588, 0.0980392, 0.027451), Color3.new(0.101961, 0.113725, 0.0941176) }
                });
            end);
        end;
        l__Character__12.Anchored = false;
        if l__LocalPlayer__3.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead then
            u8 = false;
            u33.Closed:Play();
            return p36();
        end;
        l__LocalPlayer__3.Character.Humanoid.PlatformStand = false;
        u35(l__CFrame__13);
        l__LocalPlayer__3.Character.Humanoid.AutoRotate = true;
        l__Dumpster__10.CanCollide = true;
        l__Character__12.Anchored = false;
        u33.Closed:Play();
        u8 = false;
        task.wait(1);
        p36();
    end;
    u3.NewInteractionClass(v34);
end;
function u6.LoadAnims(p39) --[[ Line: 200 ]]
    -- upvalues: u7 (copy)
    for _, v40 in game.ReplicatedStorage.Assets.GarbageCan:GetChildren() do
        u7[v40.Name] = p39:WaitForChild("Humanoid"):LoadAnimation(v40);
    end;
end;
function u6.Setup() --[[ Line: 206 ]]
    -- upvalues: u6 (copy)
    if game.Players.LocalPlayer.Character then
        u6.LoadAnims(game.Players.LocalPlayer.Character);
    end;
    game.Players.LocalPlayer.CharacterAdded:Connect(u6.LoadAnims);
end;
return u6;
