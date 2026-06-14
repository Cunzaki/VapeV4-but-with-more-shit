-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Interaction.Interactors.Door_1
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local l__LocalPlayer__2 = game:GetService("Players").LocalPlayer;
local l__Mince__3 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Queue).new().Step = 0.1;
local l__ModelTween__4 = require(game.ReplicatedStorage.Modules.ModelTween);
l__Mince__3:Get("SoundHandler");
local u1 = {
    DirectionCancel = Vector3.new(0, 0, 1),
    HitSpeed = 20,
    Angle = 90,
    DoorTweens = {
        Default = {
            [1] = TweenInfo.new(1, Enum.EasingStyle.Bounce),
            [2] = TweenInfo.new(0.8, Enum.EasingStyle.Bounce),
            [3] = TweenInfo.new(0.5, Enum.EasingStyle.Bounce),
            [4] = TweenInfo.new(0.2, Enum.EasingStyle.Bounce),
            Close = TweenInfo.new(1, Enum.EasingStyle.Bounce)
        },
        Heavy = {
            [1] = TweenInfo.new(0.7, Enum.EasingStyle.Sine),
            [2] = TweenInfo.new(0.5, Enum.EasingStyle.Sine),
            [3] = TweenInfo.new(0.3, Enum.EasingStyle.Sine),
            [4] = TweenInfo.new(0.1, Enum.EasingStyle.Sine),
            Close = TweenInfo.new(1, Enum.EasingStyle.Sine)
        },
        Swing = {
            [1] = TweenInfo.new(0.8, Enum.EasingStyle.Circular),
            [2] = TweenInfo.new(0.8, Enum.EasingStyle.Circular),
            [3] = TweenInfo.new(0.8, Enum.EasingStyle.Circular),
            [4] = TweenInfo.new(0.8, Enum.EasingStyle.Circular),
            Close = TweenInfo.new(3, Enum.EasingStyle.Elastic)
        }
    }
};
function u1.CloseDoor(u2, _) --[[ Line: 46 ]]
    -- upvalues: l__ModelTween__4 (copy), u1 (copy)
    u2.CanGrip.Value = false;
    for _, v3 in u2.Door:GetDescendants() do
        if v3:IsA("BasePart") then
            v3.CanCollide = false;
        end;
    end;
    task.wait();
    local v4 = l__ModelTween__4.new(u2.Door, u1.DoorTweens[u2.Config.Type or "Default"].Close, u2.ClosedDoorPivot);
    v4:Play();
    v4.Finished:Connect(function() --[[ Line: 65 ]]
        -- upvalues: u2 (copy)
        for _, v5 in u2.Door:GetDescendants() do
            if v5:IsA("BasePart") then
                v5.CanCollide = true;
            end;
        end;
        u2.CanGrip.Value = true;
    end);
    local u6 = false;
    v4.Tick:Connect(function(_, p7) --[[ Line: 76 ]]
        -- upvalues: u6 (ref)
        if not u6 and p7 >= 0.85 then
            u6 = true;
        end;
    end);
    u2.LastTween = v4;
    u2.DoorState = "Closed";
end;
function u1.OpenDoor(u8, _) --[[ Line: 86 ]]
    -- upvalues: u1 (copy), l__ModelTween__4 (copy)
    local l__Direction__5 = u8.Config.Direction;
    if u8.DoorState == "Closed" then
        u8.DoorState = l__Direction__5;
        u8.CanGrip.Value = true;
        for _, v9 in u8.Door:GetDescendants() do
            if v9:IsA("BasePart") then
                v9.CanCollide = false;
            end;
        end;
        local v10 = u1.DoorTweens[u8.Config.Type or "Default"][u8.Config.Speed or 1];
        if l__Direction__5 == "Front" then
            local v11, v12, v13 = u8.ClosedDoorPivot:ToOrientation();
            local v14 = (math.deg(v12) + u8.Angle) % 360;
            local v15 = CFrame.new(u8.ClosedDoorPivot.Position) * CFrame.fromOrientation(v11, math.rad(v14), v13);
            u8.LastTween = l__ModelTween__4.new(u8.Door, v10, v15);
            u8.LastTween:Play();
        elseif l__Direction__5 == "Back" then
            local v16, v17, v18 = u8.ClosedDoorPivot:ToOrientation();
            local v19 = (math.deg(v17) - u8.Angle) % 360;
            local v20 = CFrame.new(u8.ClosedDoorPivot.Position) * CFrame.fromOrientation(v16, math.rad(v19), v18);
            u8.LastTween = l__ModelTween__4.new(u8.Door, v10, v20);
            u8.LastTween:Play();
        end;
        if u8.LastTween then
            local u21 = false;
            u8.LastTween.Tick:Connect(function(_, p22) --[[ Line: 130 ]]
                -- upvalues: u21 (ref)
                if not u21 and p22 >= 0.85 then
                    u21 = true;
                end;
            end);
            u8.LastTween.Finished:Connect(function() --[[ Line: 136 ]]
                -- upvalues: u8 (copy)
                u8.LastTween = nil;
                for _, v23 in u8.Door:GetDescendants() do
                    if v23:IsA("BasePart") then
                        v23.CanCollide = true;
                    end;
                end;
                u8.CanGrip.Value = false;
                u8:ManuallyDetectTouching();
            end);
        else
            warn();
        end;
    end;
end;
function u1.ConfigChanged(p24, p25) --[[ Line: 152 ]]
    if p25 == "DoorOpen" then
        if p24.Config.DoorOpen then
            p24:OpenDoor(p24.Config.Direction);
        else
            p24.Debounce = true;
            p24:CloseDoor(p24.Config.Direction);
        end;
    end;
    if p25 == "DoorCanOpen" and p24.Config.DoorCanOpen then
        p24:ManuallyDetectTouching();
    end;
end;
function u1.ManuallyDetectTouching(p26) --[[ Line: 170 ]]
    for _, v27 in game.Workspace:GetPartsInPart(p26.Hitbox) do
        p26.HandleTouch(v27);
    end;
end;
function u1.Created(u28) --[[ Line: 178 ]]
    -- upvalues: u1 (copy), l__LocalPlayer__2 (copy)
    local l__Door__6 = u28.Item:WaitForChild("Door");
    local l__Hitbox__7 = u28.Item:WaitForChild("Hitbox");
    local v29 = l__Door__6:FindFirstChild("GripSurface");
    if not v29 then
        Instance.new("BoolValue", l__Door__6).Name = "GripSurface";
        v29 = l__Door__6:WaitForChild("GripSurface");
    end;
    u28.Door = l__Door__6;
    u28.CanGrip = v29;
    u28.Hitbox = l__Hitbox__7;
    u28.Sounds = {};
    u28.Hitbox.CanCollide = false;
    u28.Hitbox.CanQuery = true;
    u28.Hitbox.CanTouch = true;
    u28.Angle = u1.Angle;
    if u28.Config.ReverseAngle then
        u28.Angle = u28.Angle * -1;
    end;
    u28.Config.DoorCanOpen = true;
    u28.ClosedDoorPivot = l__Door__6:GetPivot();
    u28.DoorState = "Closed";
    u28.OpenDoor = u1.OpenDoor;
    u28.CloseDoor = u1.CloseDoor;
    u28.ManuallyDetectTouching = u1.ManuallyDetectTouching;
    for _, v30 in u28.Door:GetDescendants() do
        if v30:IsA("BasePart") then
            v30.CanCollide = true;
        end;
    end;
    u28.Debounce = true;
    function u28.HandleTouch(p31) --[[ Line: 220 ]]
        -- upvalues: l__LocalPlayer__2 (ref), u28 (copy), l__Hitbox__7 (copy), u1 (ref)
        if p31.Parent and (p31.Parent == l__LocalPlayer__2.Character and u28.Debounce) then
            u28.Debounce = false;
            if not u28.Config.DoorCanOpen then
                u28.Debounce = true;
                return;
            end;
            local l__Magnitude__8 = p31.AssemblyLinearVelocity.Magnitude;
            local v32 = nil;
            for v33, v34 in {
                0,
                20,
                25.5,
                30
            } do
                if v34 < l__Magnitude__8 then
                    v32 = v33;
                end;
            end;
            local v35 = (l__Hitbox__7.CFrame:ToObjectSpace(p31.CFrame).Position * u1.DirectionCancel).Unit.Z < 0 and "Back" or "Front";
            u28.Request("OpenDoor", v35, v32);
            u28.Config.DoorOpen = true;
            u28.Config.Direction = v35;
            u28.Config.Speed = v32;
            u28:OpenDoor();
            task.wait(0.5);
            u28.Debounce = true;
        end;
    end;
    u28.Events.HitboxHit = l__Hitbox__7.Touched:Connect(u28.HandleTouch);
end;
return u1;
