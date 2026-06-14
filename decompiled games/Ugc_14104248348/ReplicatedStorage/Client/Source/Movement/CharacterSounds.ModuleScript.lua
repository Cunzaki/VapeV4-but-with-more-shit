-- Decompiled from: ReplicatedStorage.Client.Source.Movement.CharacterSounds
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
game:GetService("RunService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Mince__3 = require(l__ReplicatedStorage__2.Modules.Mince);
require(l__ReplicatedStorage__2.Modules.Signal);
require(l__ReplicatedStorage__2.Modules.PlayerConnections);
local u1 = l__Mince__3:Get("Settings");
local u2 = l__Mince__3:Get("SoundHandler");
local u3 = {
    VelocityRequiredToWalk = 3,
    ForcedMovementMode = "Step",
    SoundsPerSecondPerStud = 5.2,
    Enabled = false,
    FootMaterials = {
        Default = "Concrete",
        [Enum.Material.Grass] = "Grass",
        [Enum.Material.Fabric] = "Carpet",
        [Enum.Material.Wood] = "Wood",
        [Enum.Material.WoodPlanks] = "Wood",
        [Enum.Material.DiamondPlate] = "Metal_Walkway",
        [Enum.Material.Metal] = "Metal",
        [Enum.Material.CorrodedMetal] = "Metal",
        [Enum.Material.Ground] = "Gravel",
        [Enum.Material.Rock] = "Gravel",
        [Enum.Material.Mud] = "Gravel",
        [Enum.Material.Pebble] = "Gravel",
        [Enum.Material.Concrete] = "Concrete",
        [Enum.Material.Plastic] = "Concrete",
        [Enum.Material.SmoothPlastic] = "Concrete",
        [Enum.Material.Air] = "Concrete"
    },
    FootVolume = {
        [Enum.Material.Wood] = 1
    },
    CharacterMaps = {}
};
function JoinRoot(p4)
    local v5 = #p4;
    local v6 = "";
    for v7 = 1, v5 do
        v6 = v6 .. p4[v7];
        if v7 ~= v5 then
            v6 = v6 .. ".";
        end;
    end;
    return v6;
end;
function u3.SetupCharacter(u8) --[[ Line: 59 ]]
    -- upvalues: u3 (copy)
    local _ = u8.Character;
    local l__Humanoid__4 = u8.Humanoid;
    function u8.ReigsterFloorMaterial(p9) --[[ Line: 63 ]]
        -- upvalues: u8 (copy)
        if p9 ~= Enum.Material.Air and (p9 ~= nil and u8.LastFloorMaterial ~= p9) then
            u8.LastFloorMaterial = p9;
            local v10 = u8.GetBind("Movement");
            if v10 and v10.Active then
                local v11 = u8.GetMaterialString();
                u8.BindSound("Movement", JoinRoot({ "Foot", v11, u8.MovementMode }), v10.Rate);
            end;
        end;
    end;
    function u8.GetMaterialString() --[[ Line: 78 ]]
        -- upvalues: u3 (ref), u8 (copy)
        return u3.FootMaterials[u8.LastFloorMaterial] or u3.FootMaterials.Default;
    end;
    function u8.GetMaterialSoundMultiplier() --[[ Line: 82 ]]
        -- upvalues: u3 (ref), u8 (copy)
        return u3.FootVolume[u8.LastFloorMaterial];
    end;
    u8.StateTable = {
        [Enum.HumanoidStateType.Running] = function(p12) --[[ Line: 87 ]]
            -- upvalues: u8 (copy), u3 (ref), l__Humanoid__4 (copy)
            if p12 then
                local v13 = u8.GetMaterialString();
                u8.MovementMode = "Step";
                u8.BindSound("Movement", JoinRoot({ "Foot", v13, "Step" }), u3.SoundsPerSecondPerStud / l__Humanoid__4.WalkSpeed);
            else
                u8.StopBind("Movement");
            end;
        end,
        [Enum.HumanoidStateType.Landed] = function(p14) --[[ Line: 96 ]]
            -- upvalues: u8 (copy)
            if p14 then
                local v15 = { "Foot", u8.GetMaterialString(), "Land" };
                u8.PlaySound(JoinRoot(v15), 0.03);
            end;
        end
    };
    l__Humanoid__4.Running:Connect(function(p16) --[[ Line: 105 ]]
        -- upvalues: l__Humanoid__4 (copy), u8 (copy), u3 (ref)
        local _ = l__Humanoid__4.MoveDirection == Vector3.new(0, 0, 0) and u8.WalkSpeed;
        u8.WalkSpeed = l__Humanoid__4.WalkSpeed;
        local v17 = u8.GetBind("Movement");
        if v17 then
            v17.Rate = u3.SoundsPerSecondPerStud / p16;
            local v18 = u8.GetMaterialString();
            u8.MovementMode = "Step";
            u8.BindSound("Movement", JoinRoot({ "Foot", v18, "Step" }), v17.Rate);
        end;
        u8.ReigsterFloorMaterial(l__Humanoid__4.FloorMaterial);
    end);
    u8.Events.FloorMaterialChanged = l__Humanoid__4:GetPropertyChangedSignal("FloorMaterial"):Connect(function() --[[ Line: 122 ]]
        -- upvalues: u8 (copy), l__Humanoid__4 (copy)
        u8.ReigsterFloorMaterial(l__Humanoid__4.FloorMaterial);
    end);
    l__Humanoid__4.StateChanged:Connect(function(p19, p20) --[[ Line: 126 ]]
        -- upvalues: u8 (copy)
        local v21 = u8.StateTable[p19];
        if v21 then
            v21(false);
        end;
        local v22 = u8.StateTable[p20];
        if v22 then
            v22(true);
        end;
    end);
    local v23 = l__Humanoid__4:GetState();
    local v24 = u8.StateTable[v23];
    if v24 then
        v24(false);
        v24(true);
    end;
end;
function u3.CharacterAdded(u25) --[[ Line: 147 ]]
    -- upvalues: u2 (copy), u3 (copy)
    local l__HumanoidRootPart__5 = u25:WaitForChild("HumanoidRootPart");
    local l__Humanoid__6 = u25:WaitForChild("Humanoid");
    local u29 = {
        Alive = true,
        Enabled = true,
        MovementMode = "Step",
        Character = u25,
        HumanoidRootPart = l__HumanoidRootPart__5,
        Humanoid = l__Humanoid__6,
        Events = {},
        SoundMap = {},
        GetSound = function(p26) --[[ Line: 165 ]]
            -- upvalues: u2 (ref), l__HumanoidRootPart__5 (copy)
            local v27 = l__HumanoidRootPart__5:FindFirstChild((u2.SoundNameFor(p26)));
            if v27 then
                return v27;
            end;
            local v28 = u2.CreateWorldSound(p26);
            v28.RollOffMaxDistance = 30;
            v28.Volume = 0.15;
            v28.Parent = l__HumanoidRootPart__5;
            return v28;
        end
    };
    function u29.PlaySound(p30, p31) --[[ Line: 182 ]]
        -- upvalues: u29 (copy), u2 (ref)
        if u29.GetSound(p30) then
            local v32 = u29.GetSound(p30);
            v32.Volume = p31;
            u2.PlaySound(v32);
        end;
    end;
    function u29.UpdateSoundMap(p33) --[[ Line: 191 ]]
        -- upvalues: u29 (copy), l__HumanoidRootPart__5 (copy), u3 (ref), u2 (ref)
        if u29.Enabled then
            if l__HumanoidRootPart__5.AssemblyLinearVelocity.Magnitude < u3.VelocityRequiredToWalk then
                u29.StopBind("Movement");
            end;
            for _, v34 in u29.SoundMap do
                if v34.Active then
                    v34.TimeElapsed = v34.TimeElapsed + p33;
                end;
                if v34.TimeElapsed > v34.Rate then
                    v34.TimeElapsed = 0;
                    u2.PlaySound(v34.Sound);
                end;
            end;
        end;
    end;
    function u29.BindSound(p35, p36, p37, p38) --[[ Line: 209 ]]
        -- upvalues: u29 (copy)
        local v39 = u29.SoundMap[p35];
        if not v39 then
            v39 = {
                Active = true,
                TimeElapsed = (1 / 0)
            };
            u29.SoundMap[p35] = v39;
        end;
        if v39.SoundName ~= p36 then
            v39.Sound = u29.GetSound(p36);
            local l__Sound__7 = v39.Sound;
            l__Sound__7.Volume = l__Sound__7.Volume * ((u29.GetMaterialSoundMultiplier() or 1) * (p38 or 1));
        end;
        v39.Active = true;
        v39.Rate = p37;
        v39.SoundName = p36;
    end;
    function u29.StopBind(p40) --[[ Line: 232 ]]
        -- upvalues: u29 (copy)
        local v41 = u29.SoundMap[p40];
        if v41 and v41.Active then
            v41.Active = false;
        end;
    end;
    function u29.GetBind(p42) --[[ Line: 240 ]]
        -- upvalues: u29 (copy)
        return u29.SoundMap[p42];
    end;
    l__Humanoid__6.Died:Connect(function() --[[ Line: 244 ]]
        -- upvalues: u3 (ref), u25 (copy)
        u3.CharacterRemoving(u25);
    end);
    u25.Destroying:Connect(function() --[[ Line: 248 ]]
        -- upvalues: u3 (ref), u25 (copy)
        u3.CharacterRemoving(u25);
    end);
    u25.AncestryChanged:Connect(function() --[[ Line: 252 ]]
        -- upvalues: u25 (copy), u3 (ref)
        if u25.Parent == nil then
            u3.CharacterRemoving(u25);
        end;
    end);
    u3.SetupCharacter(u29);
    u3.CharacterMaps[u25] = u29;
end;
function u3.GetCharacterMap(p43) --[[ Line: 262 ]]
    -- upvalues: u3 (copy)
    return u3.CharacterMaps[p43];
end;
function u3.CharacterRemoving(p44) --[[ Line: 266 ]]
    -- upvalues: u3 (copy)
    local v45 = u3.CharacterMaps[p44];
    if v45 and v45.Alive ~= false then
        v45.Alive = false;
        for _, v46 in pairs(v45.Events) do
            v46:Disconnect();
        end;
        u3.CharacterMaps[p44] = nil;
    end;
end;
function u3.PlayerAdded(p47) --[[ Line: 279 ]]
    -- upvalues: u3 (copy)
    p47.CharacterAdded:Connect(u3.CharacterAdded);
    if p47.Character then
        u3.CharacterAdded(p47.Character);
    end;
end;
function u3.SetEnabled() --[[ Line: 284 ]]
    -- upvalues: u3 (copy)
    if u3.Enabled then
    end;
end;
function u3.Update(p48) --[[ Line: 292 ]]
    -- upvalues: u3 (copy)
    if u3.Enabled then
        debug.profilebegin("CharacterMap // UpdateSoundMap");
        for _, v49 in u3.CharacterMaps do
            v49.UpdateSoundMap(p48);
        end;
        debug.profileend();
    end;
end;
function u3.Setup() --[[ Line: 302 ]]
    -- upvalues: u2 (copy), l__Players__1 (copy), u1 (copy)
    u2.WaitUntilSoundLoaded();
    for _, _ in l__Players__1:GetPlayers() do

    end;
    u1.SettingChanged("Footsteps"):Connect(function(_) --[[ Line: 309 ]] end);
end;
return u3;
