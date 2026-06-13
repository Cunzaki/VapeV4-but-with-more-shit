-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.PlayerCharacterReplication
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__TweenService__2 = game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
local l__Players__4 = game:GetService("Players");
local l__LocalPlayer__5 = l__Players__4.LocalPlayer;
local l__CurrentCamera__6 = workspace.CurrentCamera;
local l__Backpack__7 = require(l__ReplicatedStorage__1.Modules.Backpack);
local l__Mince__8 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Audio);
local l__Signal__9 = require(l__ReplicatedStorage__1.Modules.Signal);
require(l__ReplicatedStorage__1.Modules.microid);
local l__SpringVector3__10 = require(l__ReplicatedStorage__1.Modules.SpringVector3);
local u1 = require(l__ReplicatedStorage__1.Modules.PlayerConnections).Get();
local u2 = l__Mince__8:Get("PlayerCulling");
local u3 = l__Mince__8:Get("VoiceChatHandler");
local u4 = l__Mince__8:Get("SoundHandler");
l__Mince__8:Get("Intoxication");
local u5 = l__Mince__8:Get("PlayerProfile");
local u6 = l__Mince__8:Get("CharacterPickup");
local u7 = l__Mince__8:Get("SelectInteractor");
local u8 = l__Mince__8:Get("Locomotion");
local u9 = l__Mince__8:GetEvent("SyncState");
local u10 = l__Mince__8:GetEvent("RequestPickupCharacter");
l__Mince__8:Get("Settings");
function lerp(p11, p12, p13)
    return p11 * (1 - p13) + p12 * p13;
end;
local u14 = {
    PlayerData = {},
    States = {
        "Handset",
        "Microphone",
        "MiniMic",
        "DemonMic",
        "InvisibleMode",
        "Invisible",
        "EmoteCollabIndex",
        "AnniMask",
        "SnowmanDecoy",
        "SpectralClone",
        "GhostKitty",
        "Intoxication"
    },
    HumanoidStates = { "Scale" },
    CharacterClones = {},
    CharacterProps = {},
    HumanoidStateChangeMethods = {},
    StateChangeMethods = {},
    ReplicateDataAdded = l__Signal__9.new(),
    HighlightTween = TweenInfo.new(0.3)
};
function u14.RenderUpdate(_) --[[ Line: 54 ]]
    -- upvalues: l__CurrentCamera__6 (copy), u14 (copy), u3 (copy)
    debug.profilebegin("OnTap // RenderUpdate");
    local l__CFrame__11 = l__CurrentCamera__6.CFrame;
    for _, v15 in u14.PlayerData do
        u3.CalculateRolloff(v15.Player, v15.HumanoidRootPart, l__CFrame__11);
    end;
    debug.profileend();
end;
function u14.Update(p16) --[[ Line: 65 ]]
    -- upvalues: u14 (copy), u2 (copy), l__LocalPlayer__5 (copy), u7 (copy), u10 (copy), u6 (copy), u1 (copy), l__Backpack__7 (copy), u5 (copy), l__Mince__8 (copy), u8 (copy), u9 (copy)
    debug.profilebegin("OnTap // PlayerUpdate :: Character");
    for _, u17 in u14.PlayerData do
        u17.TimeElapsed = u17.TimeElapsed + p16;
        u17.Intoxication = lerp(u17.Intoxication, u17.IntoxicationTarget, p16 * 10);
        if not u2:IsBeingCulled(u17.Player) then
            local v18 = math.clamp(u17.Intoxication * 1.5, 0, 1);
            if v18 > 0 then
                local v19 = math.noise(u17.TimeElapsed, 1, -u17.TimeElapsed);
                local v20 = math.sin(u17.TimeElapsed) * 0.5 * v18;
                local v21 = math.sin(u17.TimeElapsed * 1.2) * 0.5 * v18;
                u17.Waist.C0 = u17.Waist.C0:Lerp(u17.Origin * CFrame.Angles(0, 0, 0):Lerp(CFrame.Angles(v20 * 0.6981317007977318, v21 * -0.3490658503988659, v21 + v19 * 0.1), v18), p16);
            end;
            local v22 = u17.Character:GetAttribute("Ragdolled");
            local _ = u17.Character:GetAttribute("CharacterPickupMode") or "Nobody";
            local u23, u24;
            if u17.Bubble then
                if u17.Bubble.Parent ~= nil then
                    u17.Bubble.Particle.Rate = u17.Intoxication * 13;
                    if u17.ButtonEyes and u17.HeadAttachment then
                        u17.ButtonEyes.CFrame = u17.HeadAttachment.WorldCFrame;
                    end;
                    if v22 and u17.Player ~= l__LocalPlayer__5 then
                        if u17.ProfileInteractor then
                            u7.CollapseClass(u17.ProfileInteractor);
                            u17.ProfileInteractor = nil;
                        end;
                        if not u17.SelectInteractor then
                            u23 = {
                                HoverName = "Pick up",
                                HitCollider = u17.Character.HumanoidRootPart,
                                Target = u17.Character,
                                Interact = function(_, p30) --[[ Name: Interact, Line 120 ]]
                                    -- upvalues: u10 (ref), u17 (copy)
                                    u10:Fire(u17.Player);
                                    p30();
                                end,
                                OnHover = function(_) --[[ Name: OnHover, Line 125 ]]
                                    -- upvalues: u17 (copy), l__LocalPlayer__5 (ref), u6 (ref)
                                    local v31 = u17.Character:GetAttribute("CharacterPickupMode") or "Nobody";
                                    if v31 == "Nobody" or v31 == "Friends" and not u17.Player:IsFriendsWith(l__LocalPlayer__5.UserId) then
                                        return false;
                                    else
                                        return u6.ValidatePickup() and true or false;
                                    end;
                                end
                            };
                            u17.SelectInteractor = u7.NewInteractionClass(u23);
                            u1:AddCharacterConnection(u17.Player, {
                                Disconnect = function() --[[ Name: Disconnect, Line 142 ]]
                                    -- upvalues: u7 (ref), u23 (copy)
                                    u7.CollapseClass(u23);
                                end
                            });
                            for _, v32 in u17.SelectInteractor.ColliderEvents do
                                u1:AddCharacterConnection(u17.Player, v32);
                            end;
                        end;
                    elseif u17.Player ~= l__LocalPlayer__5 and not u17.ProfileInteractor then
                        if u17.SelectInteractor then
                            u7.CollapseClass(u17.SelectInteractor);
                            u17.SelectInteractor = nil;
                        end;
                        u24 = {
                            HoverName = "Open Profile",
                            HitCollider = u17.Character.HumanoidRootPart,
                            Target = u17.Character,
                            OnHover = function(_) --[[ Name: OnHover, Line 162 ]]
                                -- upvalues: l__Backpack__7 (ref)
                                return l__Backpack__7.GetEquipped() and "Unselect" or true;
                            end,
                            Interact = function(_, p33) --[[ Name: Interact, Line 171 ]]
                                -- upvalues: u5 (ref), u17 (copy)
                                u5.OpenFor(u17.Player);
                                p33();
                            end
                        };
                        u17.ProfileInteractor = u7.NewInteractionClass(u24);
                        u1:AddCharacterConnection(u17.Player, {
                            Disconnect = function() --[[ Name: Disconnect, Line 179 ]]
                                -- upvalues: u7 (ref), u24 (copy)
                                u7.CollapseClass(u24);
                            end
                        });
                        for _, v34 in u17.ProfileInteractor.ColliderEvents do
                            u1:AddCharacterConnection(u17.Player, v34);
                        end;
                    end;
                end;
                u17.Bubble = nil;
            else
                if u17.ButtonEyes and u17.HeadAttachment then
                    u17.ButtonEyes.CFrame = u17.HeadAttachment.WorldCFrame;
                end;
                if v22 and u17.Player ~= l__LocalPlayer__5 then
                    if u17.ProfileInteractor then
                        u7.CollapseClass(u17.ProfileInteractor);
                        u17.ProfileInteractor = nil;
                    end;
                    if not u17.SelectInteractor then
                        u23 = {
                            HoverName = "Pick up",
                            HitCollider = u17.Character.HumanoidRootPart,
                            Target = u17.Character,
                            Interact = function(_, p30) --[[ Name: Interact, Line 120 ]]
                                -- upvalues: u10 (ref), u17 (copy)
                                u10:Fire(u17.Player);
                                p30();
                            end,
                            OnHover = function(_) --[[ Name: OnHover, Line 125 ]]
                                -- upvalues: u17 (copy), l__LocalPlayer__5 (ref), u6 (ref)
                                local v31 = u17.Character:GetAttribute("CharacterPickupMode") or "Nobody";
                                if v31 == "Nobody" or v31 == "Friends" and not u17.Player:IsFriendsWith(l__LocalPlayer__5.UserId) then
                                    return false;
                                else
                                    return u6.ValidatePickup() and true or false;
                                end;
                            end
                        };
                        u17.SelectInteractor = u7.NewInteractionClass(u23);
                        u1:AddCharacterConnection(u17.Player, {
                            Disconnect = function() --[[ Name: Disconnect, Line 142 ]]
                                -- upvalues: u7 (ref), u23 (copy)
                                u7.CollapseClass(u23);
                            end
                        });
                        for _, v32 in u17.SelectInteractor.ColliderEvents do
                            u1:AddCharacterConnection(u17.Player, v32);
                        end;
                    end;
                elseif u17.Player ~= l__LocalPlayer__5 and not u17.ProfileInteractor then
                    if u17.SelectInteractor then
                        u7.CollapseClass(u17.SelectInteractor);
                        u17.SelectInteractor = nil;
                    end;
                    u24 = {
                        HoverName = "Open Profile",
                        HitCollider = u17.Character.HumanoidRootPart,
                        Target = u17.Character,
                        OnHover = function(_) --[[ Name: OnHover, Line 162 ]]
                            -- upvalues: l__Backpack__7 (ref)
                            return l__Backpack__7.GetEquipped() and "Unselect" or true;
                        end,
                        Interact = function(_, p33) --[[ Name: Interact, Line 171 ]]
                            -- upvalues: u5 (ref), u17 (copy)
                            u5.OpenFor(u17.Player);
                            p33();
                        end
                    };
                    u17.ProfileInteractor = u7.NewInteractionClass(u24);
                    u1:AddCharacterConnection(u17.Player, {
                        Disconnect = function() --[[ Name: Disconnect, Line 179 ]]
                            -- upvalues: u7 (ref), u24 (copy)
                            u7.CollapseClass(u24);
                        end
                    });
                    for _, v34 in u17.ProfileInteractor.ColliderEvents do
                        u1:AddCharacterConnection(u17.Player, v34);
                    end;
                end;
            end;
        end;
    end;
    if l__Mince__8.Config.Humanoid then
        if u8.IsMoving() then
            if l__Mince__8.Config.Humanoid.Parent:GetAttribute("Invisible") then
                u9:Fire("Invisible", false);
            end;
        elseif not l__Mince__8.Config.Humanoid.Parent:GetAttribute("Invisible") and l__Mince__8.Config.Humanoid.Parent:GetAttribute("InvisibleMode") then
            u9:Fire("Invisible", true);
        end;
    end;
    debug.profileend();
end;
function u14.GetVCOldRollOff(p35, p36) --[[ Line: 205 ]]
    local l__Magnitude__12 = (p36 - p35).Magnitude;
    if l__Magnitude__12 < 7 then
        return 1;
    end;
    if l__Magnitude__12 > 80 then
        return 0;
    end;
    local v37 = 1 - (l__Magnitude__12 - 7) / 73;
    return v37 * v37;
end;
function u14.GetCharacterData(p38) --[[ Line: 220 ]]
    -- upvalues: u14 (copy), l__LocalPlayer__5 (copy)
    return u14.PlayerData[p38 and p38.Character or l__LocalPlayer__5.Character];
end;
function u14.GetGroundCF(p39) --[[ Line: 224 ]]
    local l__Character__13 = p39.Character;
    if l__Character__13 then
        l__Character__13 = p39.Character:FindFirstChild("Humanoid");
    end;
    local l__Character__14 = p39.Character;
    if l__Character__14 then
        l__Character__14 = p39.Character:FindFirstChild("HumanoidRootPart");
    end;
    if l__Character__13 and l__Character__14 then
        return (l__Character__14.CFrame.Rotation + (l__Character__14.Position - Vector3.new(0, 1, 0) * l__Character__13.HipHeight)) * CFrame.Angles(0, -1.5707963267948966, 0);
    end;
end;
function u14.SetHandset(p40) --[[ Line: 234 ]]
    -- upvalues: l__LocalPlayer__5 (copy), u9 (copy)
    local l__Character__15 = l__LocalPlayer__5.Character;
    if l__Character__15 then
        if l__Character__15:GetAttribute("Handset") ~= p40 then
            l__Character__15:SetAttribute("Handset", p40);
            u9:Fire("Handset", p40);
        end;
    else
        u9:Fire("Handset", p40);
    end;
end;
function u14.RemoveHandset(p41) --[[ Line: 249 ]]
    if p41.HandsetModels then
        for _, v42 in p41.HandsetModels do
            v42:Destroy();
        end;
        p41.HandsetModels = nil;
    end;
end;
function u14.LoadHandset(p43, p44) --[[ Line: 259 ]]
    -- upvalues: u14 (copy), l__ReplicatedStorage__1 (copy)
    u14.RemoveHandset(p43);
    p43.HandsetModels = {};
    local v45 = l__ReplicatedStorage__1.Assets.Handset:FindFirstChild(p44);
    if v45 then
        for _, v46 in v45:GetChildren() do
            local v47 = p43.Character:FindFirstChild(v46.Name);
            if v47 then
                local v48 = v46:Clone();
                v48.Parent = game.Workspace.Handsets;
                for _, v49 in v48:GetChildren() do
                    if v49:IsA("BasePart") then
                        v49.CanCollide = false;
                        v49.CanQuery = false;
                        v49.CanTouch = false;
                    end;
                end;
                v48:WaitForChild("Grip").Part1 = v47;
                p43.HandsetModels[v46.Name] = v48;
            else
                warn((`Could not find body part '{v46.Name}'`));
            end;
        end;
    end;
end;
function u14.StateChangeMethods.Intoxication(p50, p51) --[[ Line: 287 ]]
    p50.ReplicateData.IntoxicationTarget = p51 or 0;
end;
function u14.StateChangeMethods.Handset(p52, p53) --[[ Line: 291 ]]
    -- upvalues: u14 (copy)
    if p53 then
        u14.LoadHandset(p52.ReplicateData, p53);
    else
        u14.RemoveHandset(p52.ReplicateData);
    end;
end;
function u14.StateChangeMethods.SnowmanDecoy(u54, p55) --[[ Line: 299 ]]
    -- upvalues: u14 (copy), l__RunService__3 (copy), l__ReplicatedStorage__1 (copy)
    local l__Character__16 = u54.ReplicateData.Player.Character;
    if l__Character__16 and l__Character__16.Humanoid.Health >= 1 then
        if p55 then
            if u54.ReplicateData.UpdateSpawn then
                task.cancel(u54.ReplicateData.UpdateSpawn);
            end;
            u54.ReplicateData.UpdateSpawn = task.delay(0.5, function() --[[ Line: 307 ]]
                -- upvalues: l__Character__16 (copy), u54 (copy), u14 (ref), l__RunService__3 (ref)
                local v56 = {
                    Parts = {},
                    Accessories = {}
                };
                if l__Character__16.Head:FindFirstChildOfClass("Decal") then
                    l__Character__16.Head:FindFirstChildOfClass("Decal").Transparency = 1;
                end;
                for _, v57 in l__Character__16:GetChildren() do
                    if v57:IsA("BasePart") and v57.Transparency ~= 1 then
                        v57:FindFirstChildOfClass("SurfaceAppearance");
                        table.insert(v56.Parts, { v57, v57.Transparency });
                        v57.Transparency = 1;
                    elseif v57:IsA("Accessory") then
                        v57.Handle:FindFirstChildOfClass("SurfaceAppearance");
                        table.insert(v56.Accessories, { v57, v57.Handle.Transparency });
                        v57.Handle.Transparency = 1;
                    end;
                end;
                local u58 = u54.ReplicateData.Snowman or game.ReplicatedStorage.Assets.Spawnables:WaitForChild("SnowmanPlayer"):Clone();
                u58.Parent = game.Workspace;
                u58:PivotTo(u14.GetGroundCF(u54.ReplicateData.Player) + Vector3.new(0, -0.8, 0));
                local v59 = Instance.new("WeldConstraint", u58);
                v59.Part0 = l__Character__16.HumanoidRootPart;
                v59.Part1 = u58.RootPart;
                v59.Enabled = true;
                local u60 = {};
                local u61 = false;
                for _, v62 in u58.Animations:GetChildren() do
                    u60[v62.Name] = u58.AnimationController.Animator:LoadAnimation(v62);
                end;
                u60.Idle:Play();
                u58.RootPart.Wading:Pause();
                u60.Walk:Stop();
                u54.ReplicateData.Animations = u60;
                u54.ReplicateData.Update = l__RunService__3.Heartbeat:Connect(function() --[[ Line: 346 ]]
                    -- upvalues: u58 (copy), u54 (ref), u61 (ref), u60 (copy)
                    if u58:FindFirstChild("RootPart") then
                        if u58.RootPart.AssemblyLinearVelocity.Magnitude > 0.4 and not u61 then
                            u60.Walk:Play();
                            u58.RootPart.Wading:Resume();
                            u61 = true;
                            u60.Idle:Stop();
                        else
                            if u61 and u58.RootPart.AssemblyLinearVelocity.Magnitude <= 0.4 then
                                u61 = false;
                                u60.Idle:Play();
                                u58.RootPart.Wading:Pause();
                                u60.Walk:Stop();
                            end;
                        end;
                    else
                        u54.ReplicateData.Update:Disconnect();
                    end;
                end);
                u54.ReplicateData.Snowman = u58;
                u54.ReplicateData.CharacterData = v56;
                u54.ReplicateData.UpdateSpawn = nil;
            end);
        else
            if u54.ReplicateData.UpdateSpawn then
                task.cancel(u54.ReplicateData.UpdateSpawn);
            end;
            if u54.ReplicateData.CharacterData then
                if u54.ReplicateData.Update then
                    u54.ReplicateData.Update:Disconnect();
                end;
                if u54.ReplicateData.Snowman then
                    u54.ReplicateData.Snowman.Parent = l__ReplicatedStorage__1;
                    u54.ReplicateData.Snowman.WeldConstraint.Enabled = false;
                    u54.ReplicateData.Snowman.RootPart.Wading:Pause();
                    for _, v63 in u54.ReplicateData.Animations do
                        v63:Stop();
                    end;
                end;
                if l__Character__16.Head:FindFirstChildOfClass("Decal") then
                    l__Character__16.Head:FindFirstChildOfClass("Decal").Transparency = 0;
                end;
                for _, v64 in u54.ReplicateData.CharacterData.Parts do
                    v64[1].Transparency = v64[2];
                end;
                for _, v65 in u54.ReplicateData.CharacterData.Accessories do
                    v65[1].Handle.Transparency = v65[2];
                end;
                u54.ReplicateData.CharacterData = nil;
            end;
        end;
    end;
end;
function u14.StateChangeMethods.GhostKitty(u66, p67) --[[ Line: 402 ]]
    -- upvalues: u14 (copy), l__SpringVector3__10 (copy), l__RunService__3 (copy), l__ReplicatedStorage__1 (copy)
    local l__Character__17 = u66.ReplicateData.Player.Character;
    if l__Character__17 and l__Character__17.Humanoid.Health >= 1 then
        if p67 then
            if u66.ReplicateData.UpdateSpawn2 then
                task.cancel(u66.ReplicateData.UpdateSpawn2);
            end;
            u66.ReplicateData.UpdateSpawn2 = task.delay(0.5, function() --[[ Line: 411 ]]
                -- upvalues: l__Character__17 (copy), u66 (copy), u14 (ref), l__SpringVector3__10 (ref), l__RunService__3 (ref)
                local u68 = os.clock();
                local u69 = l__Character__17.Humanoid.HipHeight + l__Character__17.HumanoidRootPart.Size.Y / 2;
                local v70 = l__Character__17.HumanoidRootPart.CFrame * CFrame.new(2, -u69, 1.5);
                local u71 = CFrame.new(v70.X, v70.Y + 70, v70.Z) * v70.Rotation;
                local u72 = u66.ReplicateData.KittyClone or game.ReplicatedStorage.Assets.Models.cat:Clone();
                u72.Parent = game.Workspace;
                u72:PivotTo(u71);
                table.insert(u14.CharacterProps[u66.ReplicateData.Player], u72);
                task.wait();
                u72.HumanoidRootPart.Anchored = true;
                local u73 = u66.ReplicateData.KittyAnims or {};
                for _, v74 in u72.Animations:GetChildren() do
                    u73[v74.Name] = u73[v74.Name] or u72.Humanoid.Animator:LoadAnimation(v74);
                end;
                local u75 = true;
                local u76 = "StandIdle";
                local l__Position__18 = u72.HumanoidRootPart.Position;
                local u77 = false;
                u73.JumpStart:Play();
                u66.ReplicateData.KittyAnims = u73;
                u66.ReplicateData.KittySpring = l__SpringVector3__10.new(nil, v70.Position, 90, 40);
                u72.Destroying:Connect(function() --[[ Line: 456 ]]
                    -- upvalues: u72 (ref)
                    u72 = nil;
                end);
                u66.ReplicateData.UpdateKitty = l__RunService__3.Heartbeat:Connect(function(p78) --[[ Line: 460 ]]
                    -- upvalues: u72 (ref), u66 (ref), l__Character__17 (ref), u69 (copy), u75 (ref), u68 (copy), u71 (copy), u73 (copy), l__Position__18 (ref), u77 (ref), u76 (ref)
                    if u72 then
                        local l__KittySpring__19 = u66.ReplicateData.KittySpring;
                        local l__HumanoidRootPart__20 = u72.HumanoidRootPart;
                        local l__HumanoidRootPart__21 = l__Character__17.HumanoidRootPart;
                        local v79 = l__HumanoidRootPart__21.CFrame * CFrame.new(2, -u69, 1.5);
                        local l__Rotation__22 = l__HumanoidRootPart__20.CFrame.Rotation;
                        local v80, v81;
                        if u75 then
                            local v82 = (os.clock() - u68) / 1;
                            local v83 = math.min(v82, 1);
                            v80 = u71.Position:Lerp(v79.Position + Vector3.new(0, 0.1, 0), v83);
                            v81 = u71.Rotation;
                            if v83 >= 1 or v80.Y <= v79.Position.Y + 0.1 then
                                u75 = false;
                                u66.ReplicateData.KittySpring = l__KittySpring__19.new(nil, v80, 90, 40);
                                u66.ReplicateData.KittySpring:SetTarget(v79.Position);
                                u73.JumpStart:Stop();
                                u73.JumpLand:Play();
                                u73.StandIdle:Play();
                            end;
                        else
                            l__KittySpring__19:SetTarget(v79.Position);
                            v80 = l__KittySpring__19:Update(p78);
                            local l__Position__23 = l__HumanoidRootPart__20.Position;
                            local l__Magnitude__24 = (Vector3.new(v79.Position.X, 0, v79.Position.Z) - Vector3.new(v80.X, 0, v80.Z)).Magnitude;
                            local _ = l__Position__23 - l__Position__18;
                            l__Position__18 = l__Position__23;
                            local l__Position__25 = l__HumanoidRootPart__20.Position;
                            local v84 = l__Position__25 - Vector3.new(0, l__HumanoidRootPart__20.Size.Y / 2 + 0.4, 0);
                            local v85 = RaycastParams.new();
                            v85.FilterDescendantsInstances = { l__Character__17, u72 };
                            v85.FilterType = Enum.RaycastFilterType.Exclude;
                            if workspace:Raycast(l__Position__25, v84 - l__Position__25, v85) then
                                if u77 then
                                    u73.Float:Stop();
                                    u77 = false;
                                end;
                            elseif not u77 then
                                u73.Float:Play();
                                u77 = true;
                            end;
                            local v86 = l__Magnitude__24 >= 5 and "Run" or (l__Magnitude__24 >= 1 and "Walk" or "StandIdle");
                            if v86 ~= u76 then
                                u73[u76]:Stop();
                                u76 = v86;
                                u73[u76]:Play();
                            end;
                            if u76 == "Walk" and true or u76 == "Run" then
                                local v87 = v79.Position - v80;
                                local l__Unit__26 = Vector3.new(v87.X, 0, v87.Z).Unit;
                                v81 = (CFrame.new(0, 0, 0) * l__Rotation__22):Lerp(CFrame.lookAt(Vector3.new(0, 0, 0), l__Unit__26).Rotation, 0.3).Rotation;
                            else
                                local l__LookVector__27 = l__HumanoidRootPart__21.CFrame.LookVector;
                                local l__Rotation__28 = CFrame.lookAt(Vector3.new(0, 0, 0), (Vector3.new(l__LookVector__27.X, 0, l__LookVector__27.Z))).Rotation;
                                v81 = (CFrame.new(0, 0, 0) * l__Rotation__22):Lerp(l__Rotation__28, 0.15).Rotation;
                            end;
                        end;
                        u72:PivotTo(CFrame.new(v80) * v81);
                    end;
                end);
                u66.ReplicateData.KittyClone = u72;
                u66.ReplicateData.UpdateSpawn2 = nil;
            end);
        else
            if u66.ReplicateData.UpdateSpawn2 then
                task.cancel(u66.ReplicateData.UpdateSpawn2);
            end;
            if u66.ReplicateData.UpdateKitty then
                u66.ReplicateData.UpdateKitty:Disconnect();
            end;
            if u66.ReplicateData.KittyClone then
                u66.ReplicateData.KittyClone.Parent = l__ReplicatedStorage__1;
                for _, v88 in u66.ReplicateData.KittyAnims do
                    v88:Stop();
                end;
            end;
        end;
    end;
end;
function u14.StateChangeMethods.SpectralClone(u89, p90) --[[ Line: 586 ]]
    -- upvalues: u14 (copy), l__SpringVector3__10 (copy), l__RunService__3 (copy), l__ReplicatedStorage__1 (copy)
    local l__Character__29 = u89.ReplicateData.Player.Character;
    if l__Character__29 and l__Character__29.Humanoid.Health >= 1 then
        if p90 then
            if u89.ReplicateData.UpdateSpawn then
                task.cancel(u89.ReplicateData.UpdateSpawn);
            end;
            u89.ReplicateData.UpdateSpawn = task.delay(0.5, function() --[[ Line: 594 ]]
                -- upvalues: l__Character__29 (copy), u89 (copy), u14 (ref), l__SpringVector3__10 (ref), l__RunService__3 (ref)
                local v91 = l__Character__29.HumanoidRootPart.CFrame * CFrame.new(-3, -20, 2);
                local u92 = u89.ReplicateData.CharacterClone or game.Players:CreateHumanoidModelFromUserId(u89.ReplicateData.Player.UserId);
                u92.Parent = game.Workspace;
                u92:PivotTo(v91);
                u92.Destroying:Connect(function() --[[ Line: 602 ]]
                    -- upvalues: u92 (ref)
                    u92 = nil;
                end);
                task.wait();
                if u92.Head:FindFirstChildOfClass("Decal") then
                    u92.Head:FindFirstChildOfClass("Decal").Transparency = 1;
                end;
                local u93 = u92;
                for _, v94 in u92:GetDescendants() do
                    if v94:IsA("BasePart") then
                        local v95 = v94:FindFirstChildOfClass("SurfaceAppearance");
                        if v95 then
                            v95:Destroy();
                        end;
                        v94.Color = Color3.new(0.211765, 0.588235, 0.00784314);
                        v94.Material = Enum.Material.ForceField;
                        v94.Massless = true;
                        v94.CollisionGroup = "NPC";
                        v94.CanCollide = false;
                    elseif v94:IsA("Accessory") then
                        local v96 = v94.Handle:FindFirstChildOfClass("SurfaceAppearance");
                        if v96 then
                            v96:Destroy();
                        end;
                        v94.Handle.Color = Color3.new(0.211765, 0.588235, 0.00784314);
                        v94.Handle.Material = Enum.Material.ForceField;
                        v94.Handle.Massless = true;
                        v94.Handle.CollisionGroup = "NPC";
                        v94.Handle.CanCollide = false;
                    end;
                end;
                table.insert(u14.CharacterProps[u89.ReplicateData.Player], u93);
                u93.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
                u93.HumanoidRootPart.Anchored = true;
                local v97 = u93:FindFirstChildOfClass("Animation") or Instance.new("Animation", u93);
                v97.AnimationId = "rbxassetid://707742142";
                local v98 = u89.ReplicateData.Track or u93.Humanoid.Animator:LoadAnimation(v97);
                v98:Play();
                u89.ReplicateData.Track = v98;
                u89.ReplicateData.Spring = l__SpringVector3__10.new(nil, v91.Position, 90, 40);
                u89.ReplicateData.Update = l__RunService__3.Heartbeat:Connect(function(p99) --[[ Line: 650 ]]
                    -- upvalues: u93 (ref), u89 (ref), l__Character__29 (ref)
                    if u93 then
                        u89.ReplicateData.Spring:SetTarget((l__Character__29.HumanoidRootPart.CFrame * CFrame.new(-3, 3, 2)).Position);
                        local v100 = u89.ReplicateData.Spring:Update(p99);
                        u93:PivotTo(CFrame.new(v100) * l__Character__29.HumanoidRootPart.CFrame.Rotation);
                    end;
                end);
                u89.ReplicateData.CharacterClone = u93;
                u89.ReplicateData.UpdateSpawn = nil;
            end);
        else
            if u89.ReplicateData.UpdateSpawn then
                task.cancel(u89.ReplicateData.UpdateSpawn);
            end;
            if u89.ReplicateData.Update then
                u89.ReplicateData.Update:Disconnect();
            end;
            if u89.ReplicateData.CharacterClone then
                u89.ReplicateData.CharacterClone.Parent = l__ReplicatedStorage__1;
                u89.ReplicateData.Track:Stop();
            end;
        end;
    end;
end;
function u14.StateChangeMethods.Microphone(p101, p102) --[[ Line: 678 ]]
    -- upvalues: u3 (copy)
    local v103 = u3.GetHandlerIfExists(p101.ReplicateData.Player);
    if v103 then
        if p102 then
            local v104 = u3.GetMic(p102);
            if v104 then
                if not v103:GetEffect("MicReverb") then
                    v103:ApplyEffect("MicReverb");
                    for _, v105 in pairs(v104.Emitters) do
                        v103:AddEmitter(v105);
                    end;
                end;
                p101.ReplicateData.Mic = v104;
            end;
        elseif p101.ReplicateData.Mic then
            v103:RemoveEffect("MicReverb");
            for _, v106 in pairs(p101.ReplicateData.Mic.Emitters) do
                v103:RemoveEmitter(v106);
            end;
            p101.ReplicateData.Mic = nil;
        end;
    end;
end;
function u14.StateChangeMethods.InvisibleMode(u107, p108) --[[ Line: 705 ]]
    local l__Character__30 = u107.ReplicateData.Player.Character;
    if l__Character__30 and l__Character__30.Humanoid.Health >= 1 then
        if p108 then
            local v109 = {
                Parts = {},
                Accessories = {},
                GhostHighlight = game.ReplicatedStorage.Assets.GhostHighlight:Clone()
            };
            v109.GhostHighlight.Parent = l__Character__30;
            v109.GhostHighlight.Enabled = true;
            if l__Character__30.Head:FindFirstChildOfClass("Decal") then
                l__Character__30.Head:FindFirstChildOfClass("Decal").Transparency = 1;
            end;
            for _, v110 in l__Character__30:GetChildren() do
                if v110:IsA("BasePart") and v110.Transparency ~= 1 then
                    local v111 = v110:FindFirstChildOfClass("SurfaceAppearance");
                    table.insert(v109.Parts, {
                        v110,
                        v110.Transparency,
                        v110.Color,
                        v111
                    });
                    if v111 then
                        v111.Parent = game.ReplicatedStorage;
                    end;
                    v110.Color = Color3.new(0, 0, 0);
                    v110.Material = Enum.Material.ForceField;
                elseif v110:IsA("Accessory") then
                    local v112 = v110.Handle:FindFirstChildOfClass("SurfaceAppearance");
                    table.insert(v109.Accessories, {
                        v110,
                        v110.Handle.Transparency,
                        v110.Handle.Color,
                        v112
                    });
                    if v112 then
                        v112.Parent = game.ReplicatedStorage;
                    end;
                    v110.Handle.Color = Color3.new(0, 0, 0);
                    v110.Handle.Material = Enum.Material.ForceField;
                end;
            end;
            u107.ReplicateData.CharacterData = v109;
        elseif u107.ReplicateData.CharacterData then
            if l__Character__30.Head:FindFirstChildOfClass("Decal") then
                l__Character__30.Head:FindFirstChildOfClass("Decal").Transparency = 0;
            end;
            for _, v113 in u107.ReplicateData.CharacterData.Parts do
                v113[1].Transparency = v113[2];
                v113[1].Color = v113[3];
                v113[1].Material = Enum.Material.Plastic;
                if v113[4] then
                    v113[4].Parent = v113[1];
                end;
            end;
            if u107.ReplicateData.CharacterData.GhostHighlight then
                u107.ReplicateData.CharacterData.GhostHighlight:Destroy();
            end;
            for _, v114 in u107.ReplicateData.CharacterData.Accessories do
                v114[1].Handle.Transparency = v114[2];
                v114[1].Handle.Color = v114[3];
                v114[1].Handle.Material = Enum.Material.Plastic;
                if v114[4] then
                    v114[4].Parent = v114[1].Handle;
                end;
            end;
            task.delay(2, function() --[[ Line: 765 ]]
                -- upvalues: l__Character__30 (copy), u107 (copy)
                if l__Character__30.Head:FindFirstChildOfClass("Decal") then
                    l__Character__30.Head:FindFirstChildOfClass("Decal").Transparency = 0;
                end;
                for _, v115 in u107.ReplicateData.CharacterData.Parts do
                    v115[1].Transparency = v115[2];
                    v115[1].Color = v115[3];
                    v115[1].Material = Enum.Material.Plastic;
                    if v115[4] then
                        v115[4].Parent = v115[1];
                    end;
                end;
                if u107.ReplicateData.CharacterData.GhostHighlight then
                    u107.ReplicateData.CharacterData.GhostHighlight:Destroy();
                end;
                for _, v116 in u107.ReplicateData.CharacterData.Accessories do
                    v116[1].Handle.Transparency = v116[2];
                    v116[1].Handle.Color = v116[3];
                    v116[1].Handle.Material = Enum.Material.Plastic;
                    if v116[4] then
                        v116[4].Parent = v116[1].Handle;
                    end;
                end;
                u107.ReplicateData.CharacterData = nil;
            end);
        end;
    end;
end;
function u14.StateChangeMethods.Invisible(p117, p118) --[[ Line: 797 ]]
    -- upvalues: l__TweenService__2 (copy)
    local l__Character__31 = p117.ReplicateData.Player.Character;
    if l__Character__31 and (l__Character__31.Humanoid.Health >= 1 and (l__Character__31:GetAttribute("InvisibleMode") and p117.ReplicateData.CharacterData)) then
        if p117.ReplicateData.CharacterData.CharTween then
            p117.ReplicateData.CharacterData.CharTween:Cancel();
        end;
        if p118 then
            if p117.ReplicateData.CharacterData.GhostHighlight then
                p117.ReplicateData.CharacterData.CharTween = l__TweenService__2:Create(p117.ReplicateData.CharacterData.GhostHighlight, TweenInfo.new(2), {
                    FillTransparency = 1
                });
                p117.ReplicateData.CharacterData.CharTween:Play();
            end;
        else
            p117.ReplicateData.CharacterData.CharTween = l__TweenService__2:Create(p117.ReplicateData.CharacterData.GhostHighlight, TweenInfo.new(0.5), {
                FillTransparency = 0.5
            });
            p117.ReplicateData.CharacterData.CharTween:Play();
        end;
        for _, u119 in pairs(p117.ReplicateData.CharacterData.Parts) do
            if p118 then
                p117.ReplicateData.CharacterData.CharTween.Completed:Once(function() --[[ Line: 819 ]]
                    -- upvalues: u119 (copy)
                    u119[1].Transparency = 1;
                end);
            else
                u119[1].Transparency = 0;
            end;
        end;
        for _, u120 in pairs(p117.ReplicateData.CharacterData.Accessories) do
            if p118 then
                p117.ReplicateData.CharacterData.CharTween.Completed:Once(function() --[[ Line: 831 ]]
                    -- upvalues: u120 (copy)
                    u120[1].Handle.Transparency = 1;
                end);
            else
                u120[1].Handle.Transparency = 0;
            end;
        end;
    end;
end;
function u14.StateChangeMethods.EmoteCollabIndex(p121, p122) --[[ Line: 841 ]]
    -- upvalues: l__LocalPlayer__5 (copy)
    warn(p122, "--->");
    if p122 then
        if p121.ReplicateData.Player ~= l__LocalPlayer__5 then
            p121.ReplicateData.EmotePrompt.Enabled = true;
        end;
    else
        p121.ReplicateData.EmotePrompt.Enabled = false;
    end;
end;
function u14.StateChangeMethods.MiniMic(p123, p124) --[[ Line: 853 ]]
    -- upvalues: u3 (copy)
    local v125 = u3.GetHandlerIfExists(p123.ReplicateData.Player);
    if v125 then
        if p124 then
            if not v125:GetEffect("MiniMicReverb") then
                v125:ApplyEffect("MiniMicReverb");
            end;
        elseif v125:GetEffect("MiniMicReverb") then
            v125:RemoveEffect("MiniMicReverb");
        end;
    end;
end;
function u14.StateChangeMethods.DemonMic(p126, p127) --[[ Line: 869 ]]
    -- upvalues: u3 (copy)
    local v128 = u3.GetHandlerIfExists(p126.ReplicateData.Player);
    if v128 then
        if p127 then
            if not v128:GetEffect("CreepyPitchShift") then
                v128:ApplyEffect("CreepyPitchShift");
                v128:ApplyEffect("CreepyChorus");
            end;
        elseif v128:GetEffect("CreepyPitchShift") then
            v128:RemoveEffect("CreepyPitchShift");
            v128:RemoveEffect("CreepyChorus");
        end;
    end;
end;
function u14.HumanoidStateChangeMethods.Scale(p129, p130) --[[ Line: 887 ]]
    -- upvalues: u3 (copy), u4 (copy), l__TweenService__2 (copy), u14 (copy)
    local v131 = u3.GetHandler(p129.ReplicateData.Player);
    local u132 = Instance.new("Highlight", p129.Character);
    u132.OutlineTransparency = 1;
    u132.FillColor = Color3.new(1, 1, 1);
    u132.FillTransparency = 1;
    local v133 = u4.PlaySound("blip", nil, {
        RETURN = true
    });
    v133.PlaybackSpeed = p130;
    v133.Parent = p129.HumanoidRootPart;
    v133:Play();
    u132.Enabled = true;
    u132.FillTransparency = 0.5;
    local v134 = l__TweenService__2:Create(u132, u14.HighlightTween, {
        FillTransparency = 1
    });
    v134.Completed:Connect(function() --[[ Line: 906 ]]
        -- upvalues: u132 (copy)
        u132:Destroy();
    end);
    v134:Play();
    local v135;
    if p130 <= 1 then
        v135 = math.abs(2 - p130);
    else
        v135 = math.abs(p130 - 2);
    end;
    v131:GetEffect("SizePitchShifter", true).Pitch = math.clamp(v135, 0.9, 1.1);
    p129.ReplicateData.LastScale = p130;
end;
function u14.StateChangeMethods.AnniMask(u136, p137) --[[ Line: 923 ]]
    -- upvalues: l__SpringVector3__10 (copy), l__RunService__3 (copy)
    local u138 = u136.ReplicateData.Player.Character:FindFirstChildOfClass("Tool");
    if u138 and p137 ~= CFrame.new(17, 17, 17) then
        u136.ReplicateData.Mask = {};
        local v139;
        if u138 then
            v139 = u138:FindFirstChild("RotationOffset");
        else
            v139 = u138;
        end;
        if v139 then
            u136.ReplicateData.Mask.RotationOffset = v139.Value;
        else
            u136.ReplicateData.Mask.RotationOffset = CFrame.Angles(0, 0, 0);
        end;
        u136.ReplicateData.Mask.Tool = u138;
        u136.ReplicateData.Mask.MaskSpring = l__SpringVector3__10.new(nil, u136.ReplicateData.Player.Character.Head.Position, 230, 10);
        u136.ReplicateData.Mask.Offset = p137;
        u136.ReplicateData.Mask.UpdateConnection = l__RunService__3.RenderStepped:Connect(function(p140) --[[ Line: 940 ]]
            -- upvalues: u138 (copy), u136 (copy)
            local l__Part__32 = u138.Part;
            u136.ReplicateData.Mask.MaskSpring:SetTarget((u136.ReplicateData.Player.Character.Head.CFrame * u136.ReplicateData.Mask.Offset).Position);
            local v141 = u136.ReplicateData.Mask.MaskSpring:Update(p140);
            l__Part__32.CFrame = CFrame.lookAt(v141, u136.ReplicateData.Player.Character.Head.Position) * u136.ReplicateData.Mask.RotationOffset;
        end);
    else
        if u136.ReplicateData.Mask then
            u136.ReplicateData.Mask.MaskSpring:Destroy();
            u136.ReplicateData.Mask.UpdateConnection:Disconnect();
        end;
    end;
end;
function u14.MakeCharacterClone(p142, p143) --[[ Line: 956 ]]
    -- upvalues: u14 (copy)
    if u14.CharacterClones[p142] then
        return u14.CharacterClones[p142];
    else
        local v144 = p143:FindFirstChild("Humanoid");
        if v144 then
            local u145 = script.BlockCharacter:Clone();
            local v146 = u145:FindFirstChild("Humanoid");
            if v146 then
                u145.Parent = game.Workspace;
                task.wait();
                v146:ApplyDescription(v144:GetAppliedDescription());
                task.defer(function() --[[ Line: 970 ]]
                    -- upvalues: u145 (copy)
                    u145.Parent = script;
                end);
                u14.CharacterClones[p142] = u145;
                return u145;
            end;
        end;
    end;
end;
function u14.ClearCharacterClone(p147) --[[ Line: 979 ]]
    -- upvalues: u14 (copy)
    local v148 = u14.CharacterClones[p147];
    if v148 then
        u14.CharacterClones[p147] = nil;
        if v148.Parent == script then
            v148:Destroy();
        end;
    end;
end;
function u14.GetCharacterClone(p149) --[[ Line: 989 ]]
    -- upvalues: u14 (copy)
    if u14.PlayerData[p149] then
        return u14.MakeCharacterClone(u14.PlayerData[p149].Player, p149);
    end;
end;
function u14.NewPlayerCharacter(u150, u151) --[[ Line: 996 ]]
    -- upvalues: u14 (copy), u1 (copy), u3 (copy)
    local l__Humanoid__33 = u151:WaitForChild("Humanoid");
    local l__HumanoidRootPart__34 = u151:WaitForChild("HumanoidRootPart");
    local l__Waist__35 = u151:WaitForChild("UpperTorso"):WaitForChild("Waist");
    task.wait();
    for _, v152 in u14.PlayerData do
        if v152.Player == u150 then
            u14.PlayerData[v152.Character] = nil;
        end;
    end;
    if u14.CharacterProps[u150] then
        for _, v153 in u14.CharacterProps[u150] do
            v153:Destroy();
        end;
    end;
    u14.CharacterProps[u150] = {};
    local u154 = {
        TimeElapsed = 0,
        LastScale = 1,
        Player = u150,
        Origin = l__Waist__35.C0,
        Waist = l__Waist__35,
        Intoxication = u151:GetAttribute("Intoxication") or 0,
        IntoxicationTarget = u151:GetAttribute("Intoxication") or 0,
        Connections = {},
        Character = u151,
        HumanoidRootPart = l__HumanoidRootPart__34
    };
    u14.ReplicateDataAdded:Fire(u154);
    for _, v155 in pairs(u151:GetDescendants()) do
        if v155.Name == "ButtonEyes" then
            u154.ButtonEyes = v155;
        elseif v155.Name == "neck_TopSHJnt" then
            u154.HeadAttachment = v155:FindFirstChild("Attachment");
        end;
    end;
    u14.PlayerData[u151] = u154;
    for _, u156 in u14.States do
        local u157 = u14.StateChangeMethods[u156];
        if u157 then
            u154.Connections.CharacterEvent = u151:GetAttributeChangedSignal(u156):Connect(function() --[[ Line: 1050 ]]
                -- upvalues: u157 (copy), u154 (copy), u151 (copy), u156 (copy)
                u157({
                    ReplicateData = u154
                }, u151:GetAttribute(u156));
            end);
            u1:AddCharacterConnection(u150, u154.Connections.CharacterEvent);
        end;
    end;
    for _, u158 in u14.HumanoidStates do
        local u159 = u14.HumanoidStateChangeMethods[u158];
        if u159 then
            u154.Connections.HumanoidEvent = l__Humanoid__33:GetAttributeChangedSignal(u158):Connect(function() --[[ Line: 1063 ]]
                -- upvalues: u159 (copy), u154 (copy), l__HumanoidRootPart__34 (copy), l__Humanoid__33 (copy), u158 (copy)
                u159({
                    ReplicateData = u154,
                    HumanoidRootPart = l__HumanoidRootPart__34,
                    Humanoid = l__Humanoid__33
                }, l__Humanoid__33:GetAttribute(u158));
            end);
            u1:AddCharacterConnection(u150, u154.Connections.HumanoidEvent);
        end;
    end;
    local u160 = false;
    local function u163() --[[ Line: 1076 ]]
        -- upvalues: u160 (ref), u14 (ref), u150 (copy), u154 (copy), u151 (copy), u3 (ref)
        if u160 then
        else
            u160 = true;
            u14.ClearCharacterClone(u150);
            if u154.CharacterClone then
                u154.CharacterClone:Destroy();
            end;
            u14.PlayerData[u151] = nil;
            local v161 = u3.GetHandlerIfExists(u150);
            if v161 then
                v161:ClearAll();
            end;
            for _, v162 in u154.Connections do
                v162:Disconnect();
            end;
        end;
    end;
    u154.Connections.CharacterListeningEvent = u151:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 1092 ]]
        -- upvalues: u151 (copy), u163 (copy)
        if not u151:IsDescendantOf(game.Workspace) then
            u163();
        end;
    end);
    u154.Connections.DestroyingEvent = u151.Destroying:Connect(u163);
    u154.Connections.DyingEvent = l__Humanoid__33.Died:Connect(u163);
    u1:AddCharacterConnection(u150, u154.Connections.CharacterListeningEvent);
    u1:AddCharacterConnection(u150, u154.Connections.DestroyingEvent);
    u1:AddCharacterConnection(u150, u154.Connections.DyingEvent);
    repeat
        task.wait();
    until u150:HasAppearanceLoaded();
    local l__Head__36 = u151:WaitForChild("Head");
    if u14.PlayerData[u151] then
        u14.PlayerData[u151].Bubble = l__Head__36:WaitForChild("Bubble", 10);
    end;
end;
function u14.PlayerRemoving(p164) --[[ Line: 1118 ]]
    -- upvalues: u14 (copy)
    u14.ClearCharacterClone(p164);
    for _, v165 in u14.CharacterProps[p164] do
        v165:Destroy();
    end;
    u14.CharacterProps[p164] = nil;
    task.wait(10);
    p164:Destroy();
end;
function u14.PlayerAdded(u166) --[[ Line: 1132 ]]
    -- upvalues: u1 (copy), u14 (copy)
    u1:AddPlayerConnection(u166, u166.CharacterAdded:Connect(function(p167) --[[ Line: 1133 ]]
        -- upvalues: u14 (ref), u166 (copy)
        u14.NewPlayerCharacter(u166, p167);
    end));
    if u166.Character then
        u14.NewPlayerCharacter(u166, u166.Character);
    end;
end;
function u14.Setup() --[[ Line: 1140 ]]
    -- upvalues: l__Players__4 (copy), u14 (copy), l__RunService__3 (copy)
    for _, v168 in l__Players__4:GetPlayers() do
        task.defer(u14.PlayerAdded, v168);
    end;
    l__RunService__3.RenderStepped:Connect(u14.RenderUpdate);
    l__RunService__3.Heartbeat:Connect(u14.Update);
    l__Players__4.PlayerAdded:Connect(u14.PlayerAdded);
    l__Players__4.PlayerRemoving:Connect(u14.PlayerRemoving);
end;
return u14;
