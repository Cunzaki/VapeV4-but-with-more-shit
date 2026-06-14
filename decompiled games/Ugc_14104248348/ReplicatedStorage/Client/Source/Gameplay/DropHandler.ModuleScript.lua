-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.DropHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__CollectionService__2 = game:GetService("CollectionService");
game:GetService("PhysicsService");
local l__Players__3 = game:GetService("Players");
local l__Debris__4 = game:GetService("Debris");
local l__LocalPlayer__5 = l__Players__3.LocalPlayer;
local _ = script.Parent;
local l__Mince__6 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Utility);
local l__SpatialHash__7 = require(l__ReplicatedStorage__1.Modules.SpatialHash);
local u1 = l__Mince__6:Get("SoundHandler");
local u2 = l__Mince__6:GetEvent("ClaimDrop");
local v3 = l__Mince__6:GetEvent("SpawnDrop");
local u4 = v3:Extend("Position");
local u5 = v3:Extend("PartDrop");
function RandomPosition(p6, p7)
    local v8 = p6 * 0.5;
    local v9 = math.random(-v8.X, v8.X);
    local v10 = math.random(-v8.Z, v8.Z);
    return p7:PointToWorldSpace((Vector3.new(v9, 0, v10)));
end;
l__Mince__6.Component({
    Tag = "CoinSpawn",
    SpatialHash = l__SpatialHash__7.NewMap(10)
}).Construct = function(p11) --[[ Name: Construct, Line 33 ]]
    p11.SpatialHash.Add(p11.Instance);
end;
local u12 = {
    MaxDrops = 35,
    MagnetZone = 35,
    MagnetForce = 500,
    UncollectableTime = 1,
    Strength = 1.5,
    CurrentPitch = 1,
    DefaultPitch = 1,
    PitchInterval = 0.1,
    LastSoundPlayed = 0,
    SoundComboTime = 1,
    UpwardForce = { 50, 50 },
    DirectionalForce = { -20, 20 },
    Drops = {},
    Notifers = {}
};
function GenerateFloat(p13, p14)
    return math.random(p13 * 10000, p14 * 10000) / 10000;
end;
function u12.GenerateValue(p15) --[[ Line: 66 ]]
    return GenerateFloat(table.unpack(p15));
end;
function u12.UseNotifer(u16, p17, p18) --[[ Line: 72 ]]
    -- upvalues: u12 (copy), l__ReplicatedStorage__1 (copy)
    local v19 = u12.Notifers[u16];
    if v19 then
        v19.Part.Position = p18;
        v19.Age = 0;
        v19.FadeDelta(0);
        for v20, v21 in p17 do
            local v22 = v19.Part.BillboardGui.Container:FindFirstChild(v20);
            if v22 then
                if not v19.Values[v20] then
                    v19.Values[v20] = 0;
                end;
                local l__Values__8 = v19.Values;
                l__Values__8[v20] = l__Values__8[v20] + v21;
                v22.Visible = true;
                v22.Price.Text = v19.Values[v20];
            end;
        end;
    else
        local u23 = l__ReplicatedStorage__1.Assets.Misc.Notifier:Clone();
        local v24 = {
            Age = 0,
            LifeTime = 1.5,
            FadeTime = 0.5,
            Part = u23,
            Values = {}
        };
        u23.Position = p18;
        u23.Parent = game.Workspace.Drops;
        function v24.Destroy() --[[ Line: 108 ]]
            -- upvalues: u12 (ref), u16 (copy), u23 (copy)
            u12.Notifers[u16] = nil;
            u23:Destroy();
        end;
        function v24.FadeDelta(p25) --[[ Line: 114 ]]
            -- upvalues: u23 (copy)
            for _, v26 in u23.BillboardGui.Container:GetChildren() do
                if v26:IsA("Frame") and v26.Visible then
                    v26.Price.TextTransparency = p25;
                    v26.Price.UIStroke.Transparency = p25;
                    v26.Icon.ImageTransparency = p25;
                end;
            end;
        end;
        for v27, v28 in p17 do
            local v29 = u23.BillboardGui.Container:FindFirstChild(v27);
            if v29 then
                if not v24.Values[v27] then
                    v24.Values[v27] = 0;
                end;
                local l__Values__9 = v24.Values;
                l__Values__9[v27] = l__Values__9[v27] + v28;
                v29.Visible = true;
                v29.Price.Text = v24.Values[v27];
            end;
        end;
        u12.Notifers[u16] = v24;
    end;
end;
function u12.NewDrop(p30, p31, p32) --[[ Line: 141 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u12 (copy), l__LocalPlayer__5 (copy), l__Debris__4 (copy)
    local v33 = l__ReplicatedStorage__1.Assets.Misc.Drop:Clone();
    local u34 = {
        HasLanded = false,
        Drop = v33,
        Instant = p32.Instant,
        LandOn = os.time() + u12.UncollectableTime,
        ID = p31
    };
    local _ = p32.Type == "Holiday";
    local v35 = u12.GenerateValue(u12.UpwardForce) * (1 + u12.Strength * 0.05);
    local v36 = u12.GenerateValue(u12.DirectionalForce) * u12.Strength;
    local v37 = Vector3.new(v36, v35, u12.GenerateValue(u12.DirectionalForce));
    local l__HumanoidRootPart__10 = u12.Character:WaitForChild("HumanoidRootPart");
    if not l__HumanoidRootPart__10:FindFirstChild("GHAttachment") then
        Instance.new("Attachment", l__HumanoidRootPart__10).Name = "GHAttachment";
    end;
    local l__GHAttachment__11 = l__HumanoidRootPart__10:WaitForChild("GHAttachment");
    v33.Touched:Connect(function(p38) --[[ Line: 165 ]]
        -- upvalues: l__LocalPlayer__5 (ref), u12 (ref), u34 (copy)
        if p38.Parent and (p38.Parent:IsA("Model") and p38.Parent == l__LocalPlayer__5.Character) then
            u12.Collect(u34);
        end;
    end);
    v33.Position = p30;
    v33.Anchored = false;
    v33.AlignPosition.MaxForce = 0;
    v33.AlignPosition.Attachment1 = l__GHAttachment__11;
    u34.Drop.Parent = game.Workspace;
    v33.AssemblyLinearVelocity = v37;
    u34.Drop.Destroying:Connect(function() --[[ Line: 184 ]]
        -- upvalues: u12 (ref), u34 (copy)
        for v39, v40 in ipairs(u12.Drops) do
            if v40 == u34 then
                table.remove(u12.Drops, v39);
            end;
        end;
    end);
    l__Debris__4:AddItem(u34.Drop, 60);
    pcall(function() --[[ Line: 194 ]]
        -- upvalues: u12 (ref)
        if #u12.Drops > u12.MaxDrops then
            u12.Destroy(u12.Drops[1]);
        end;
    end);
    table.insert(u12.Drops, u34);
end;
function u12.Destroy(p41) --[[ Line: 206 ]]
    -- upvalues: u12 (copy)
    p41.Drop:Destroy();
    u12.HasLanded = false;
    for v42, v43 in ipairs(u12.Drops) do
        if v43 == p41 then
            table.remove(u12.Drops, v42);
        end;
    end;
    p41.Destroyed = true;
end;
function u12.Collect(p44) --[[ Line: 219 ]]
    -- upvalues: u12 (copy), u1 (copy), u2 (copy)
    if p44.HasLanded then
        if p44.Destroyed then
        else
            if os.time() - u12.LastSoundPlayed > u12.SoundComboTime then
                u12.CurrentPitch = u12.DefaultPitch;
            end;
            u12.LastSoundPlayed = os.time();
            u1.PlaySound("collect_coin").PlaybackSpeed = u12.CurrentPitch;
            local v45 = u12;
            v45.CurrentPitch = v45.CurrentPitch + u12.PitchInterval;
            p44.Drop:Destroy();
            u2:Fire(p44.ID);
            for v46, v47 in ipairs(u12.Drops) do
                if v47 == p44 then
                    table.remove(u12.Drops, v46);
                end;
            end;
        end;
    end;
end;
function u12.UpdateNotifiers(p48) --[[ Line: 252 ]]
    -- upvalues: u12 (copy)
    for _, v49 in u12.Notifers do
        v49.Age = v49.Age + p48;
        if v49.Age > v49.LifeTime then
            v49.FadeDelta((v49.Age - v49.LifeTime) / v49.FadeTime);
            if v49.Age > v49.LifeTime + v49.FadeTime then
                v49.Destroy();
                return;
            end;
        end;
    end;
end;
function u12.Update(p50) --[[ Line: 270 ]]
    -- upvalues: u12 (copy)
    u12.UpdateNotifiers(p50);
    local l__Character__12 = u12.Character;
    if l__Character__12 then
        l__Character__12 = u12.Character:FindFirstChild("HumanoidRootPart");
    end;
    if l__Character__12 then
        for _, v51 in ipairs(u12.Drops) do
            local v52 = os.time();
            if v51.HasLanded then
                local v53 = 1 - math.min(u12.MagnetZone, (l__Character__12.Position - v51.Drop.Position).Magnitude) / u12.MagnetZone;
                v51.Drop.AlignPosition.MaxForce = u12.MagnetForce * v53;
            elseif v51.LandOn < v52 then
                v51.HasLanded = true;
            end;
        end;
    end;
end;
function u12.CharacterAdded(p54) --[[ Line: 295 ]]
    -- upvalues: u12 (copy)
    u12.Character = p54;
    local l__HumanoidRootPart__13 = u12.Character:WaitForChild("HumanoidRootPart");
    if not l__HumanoidRootPart__13:FindFirstChild("GHAttachment") then
        Instance.new("Attachment", l__HumanoidRootPart__13).Name = "GHAttachment";
    end;
    u12.HumanoidRootPart = l__HumanoidRootPart__13;
    local l__GHAttachment__14 = l__HumanoidRootPart__13:WaitForChild("GHAttachment");
    for _, v55 in ipairs(u12.Drops) do
        v55.Drop.AlignPosition.Attachment1 = l__GHAttachment__14;
    end;
end;
function u12.SpawnServerPartDrop(p56) --[[ Line: 312 ]]
    -- upvalues: l__CollectionService__2 (copy), u12 (copy)
    local v57 = l__CollectionService__2:GetTagged("CoinSpawn");
    table.sort(v57, function(p58, p59) --[[ Line: 315 ]]
        -- upvalues: u12 (ref)
        return (Vector3.new(1, 0, 1) * (p58.Position - u12.HumanoidRootPart.Position)).Magnitude < (Vector3.new(1, 0, 1) * (p59.Position - u12.HumanoidRootPart.Position)).Magnitude;
    end);
    local v60 = 0;
    for _, v61 in ipairs(p56._) do
        local v62 = v57[math.random(1, (math.min(#v57, 4)))];
        u12.NewDrop(RandomPosition(v62.Size, v62.CFrame), v61, p56);
        v60 = v60 + 1;
        if v60 > 1 then
            task.wait(0.1);
            v60 = 0;
        end;
    end;
end;
function u12.SpawnServerPositionDrop(p63) --[[ Line: 334 ]]
    -- upvalues: u12 (copy)
    local l__Position__15 = p63.Position;
    for _, v64 in ipairs(p63._) do
        u12.NewDrop(l__Position__15, v64, p63);
        task.wait(0.2);
    end;
end;
function u12.Setup() --[[ Line: 344 ]]
    -- upvalues: l__LocalPlayer__5 (copy), u12 (copy), u4 (copy), u5 (copy)
    if l__LocalPlayer__5.Character then
        u12.CharacterAdded(l__LocalPlayer__5.Character);
    end;
    l__LocalPlayer__5.CharacterAdded:Connect(u12.CharacterAdded);
    u4.Event:Connect(u12.SpawnServerPositionDrop);
    u5.Event:Connect(u12.SpawnServerPartDrop);
    game:GetService("RunService").Heartbeat:Connect(u12.Update);
end;
return u12;
