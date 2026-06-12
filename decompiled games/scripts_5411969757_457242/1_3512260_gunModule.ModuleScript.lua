-- Decompiled with Potassium's decompiler.

local u2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 2 ]]
        return game:GetService(p1);
    end
});
local u3 = {};
local l__LocalPlayer__1 = u2.Players.LocalPlayer;
local l__Requirement__2 = l__LocalPlayer__1:WaitForChild("Requirement", 300);
local _ = u2.ReplicatedStorage;
local l__TweenService__3 = u2.TweenService;
Instance.new("BlockMesh");
local _ = UserSettings().GameSettings;
local u4 = { l__LocalPlayer__1.Character, workspace:FindFirstChild("FE_Ignorable") };
u3.Scoped = false;
u3.Chatting = false;
u3.Zoom = nil;
local v5 = Instance.new("Part");
v5.Anchored = true;
v5.CanCollide = false;
v5.Locked = true;
v5.FormFactor = Enum.FormFactor.Custom;
v5.Material = Enum.Material.Neon;
v5.Size = Vector3.new(0.2, 0.2, 0.2);
u3.WeaponInfo = {
    ["Medi-Gun"] = {
        Recharging = false,
        Given = false,
        Working = false,
        Charge = 100,
        MaxCharge = 100,
        BaseHeal = 2,
        Recharge = 3,
        Rate = 0.1,
        BeamColor = BrickColor.new("Lime green")
    },
    ["Medi-Gun [MEDIC]"] = {
        Recharging = false,
        Given = false,
        Working = false,
        Charge = 100,
        MaxCharge = 100,
        BaseHeal = 5,
        Recharge = 2,
        Rate = 0.1,
        BeamColor = BrickColor.new("Maroon")
    },
    Dropship = {
        Shell = true,
        Reloading = false,
        IsAuto = true,
        Ammo = 400,
        MaxAmmo = 400,
        BaseDamage = 18,
        RoF = 0.02,
        Spread = 0,
        Rays = 1,
        ReloadTime = 0.005,
        Distance = 800,
        BulletColor = BrickColor.new("Bright red"),
        ShellColor = BrickColor.new("Cocoa"),
        Material = Enum.Material.Neon
    }
};
local u6 = nil;
local u7 = nil;
function HitMark(u8)
    -- upvalues: u2 (copy)
    spawn(function() --[[ Line: 36 ]]
        -- upvalues: u2 (ref), u8 (copy)
        local v9 = Instance.new("Part", workspace:FindFirstChild("FE_Ignorable") or u2.Workspace);
        v9.Anchored = true;
        v9.CanCollide = false;
        v9.FormFactor = "Custom";
        v9.Size = Vector3.new(0.2, 0.2, 0.2);
        v9.Transparency = 1;
        v9.CFrame = u8;
        local v10 = Instance.new("ParticleEmitter", v9);
        v10.Color = ColorSequence.new(Color3.fromRGB(255, 43, 43));
        v10.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0) });
        v10.Texture = "rbxassetid://117166077";
        v10.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.8, 0.8), NumberSequenceKeypoint.new(1, 0) });
        v10.Acceleration = Vector3.new(0, -5, 0);
        v10.EmissionDirection = "Back";
        v10.Lifetime = NumberRange.new(0.5);
        v10.Rate = 100;
        v10.Rotation = NumberRange.new(0, 360);
        v10.Speed = NumberRange.new(2);
        v10.VelocitySpread = 360;
        u2.Debris:AddItem(v9, 0.5);
        wait(0.15);
        v10.Rate = 0;
    end);
end;
function u3.SetRemote(p11) --[[ Line: 69 ]]
    -- upvalues: u6 (ref)
    u6 = p11;
end;
function u3.SetTool(p12) --[[ Line: 73 ]]
    -- upvalues: u7 (ref)
    u7 = p12;
end;
function u3.DrawRay(_, _, _, _, _) --[[ Line: 77 ]] end;
function u3.MedigunRay(_, _, _, _) --[[ Line: 160 ]] end;
local _ = table.insert;
local l__Indicator__4 = script:WaitForChild("Indicator");
local function u34(p13, p14, p15) --[[ Line: 217 ]]
    -- upvalues: l__Indicator__4 (copy), l__TweenService__3 (copy), u2 (copy)
    local v16 = Random.new();
    local v17 = TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v18 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v19 = v16:NextInteger(0, 1) == 1 and -1 or 1;
    local l__unit__5 = Vector2.new(v19, v16:NextNumber(-0.3, 0.3)).unit;
    local v20 = l__unit__5 * 120;
    local v21 = l__unit__5 * 50;
    local u22 = l__Indicator__4:Clone();
    u22.BillboardGui.Number.TextColor3 = p15;
    u22.BillboardGui.Number.TextStrokeColor3 = p15;
    u22.BillboardGui.Number.Position = UDim2.new(0.5, v21.X, 0.5, v21.Y);
    local u23 = next;
    local v24, v25 = u22.BillboardGui:GetDescendants();
    while true do
        local v26;
        v25, v26 = u23(v24, v25);
        if not v25 then
            break;
        end;
        local v27 = math.floor(p14 + 0.5);
        v26.Text = tostring(v27);
    end;
    u22.CFrame = CFrame.new(p13);
    u22.Parent = workspace:FindFirstChild("FE_Ignorable");
    u22.BillboardGui.Enabled = true;
    local v28 = l__TweenService__3:Create(u22.BillboardGui.Number, v17, {
        Position = UDim2.new(0.5, v20.X, 0.5, v20.Y)
    });
    local u29 = l__TweenService__3:Create(u22.BillboardGui.Number, v18, {
        TextSize = 0
    });
    u22.BillboardGui.Number:GetPropertyChangedSignal("TextSize"):Connect(function() --[[ Line: 245 ]]
        -- upvalues: u23 (copy), u22 (copy)
        local v30 = u23;
        local v31, v32 = u22.BillboardGui.Number:GetChildren();
        while true do
            local v33;
            v32, v33 = v30(v31, v32);
            if not v32 then
                break;
            end;
            v33.TextSize = 0.75 * u22.BillboardGui.Number.TextSize;
        end;
    end);
    v28.Completed:Connect(function() --[[ Line: 255 ]]
        -- upvalues: u29 (copy)
        u29:Play();
    end);
    u29.Completed:Connect(function() --[[ Line: 258 ]]
        -- upvalues: u22 (copy)
        u22:Destroy();
    end);
    v28:Play();
    u2.Debris:AddItem(u22, 1);
end;
function u3.HealFunction(p35, p36, p37, p38, _, _) --[[ Line: 265 ]]
    -- upvalues: u6 (ref), u2 (copy), u7 (ref)
    local v39 = false;
    local _, v40 = workspace:FindPartOnRayWithIgnoreList(Ray.new(p36.Position, (p35 - p36.Position).Unit * 20), u6:GetIgnore());
    local v41 = workspace:FindPartsInRegion3WithIgnoreList(Region3.new(v40 - Vector3.new(10, 10, 10), v40 + Vector3.new(10, 10, 10)), u6:GetIgnore(), 100);
    local v42 = {};
    local v43 = {};
    local v44 = {};
    if #v41 > 0 then
        for _, v45 in pairs(v41) do
            if v45 and (v45.Parent and (v45.Name == "Torso" and (v45.Parent:FindFirstChild("Humanoid") and (v45.Parent.Humanoid.Health > 0 and (v45.Parent.Humanoid.Health < v45.Parent.Humanoid.MaxHealth and not workspace:FindPartOnRayWithIgnoreList(Ray.new(p36.Position, (v45.CFrame * Vector3.new(0, 0, 0) - p36.Position).Unit * (p36.Position - v45.CFrame * Vector3.new(0, 0, 0)).magnitude), { p37.Character, v45.Parent, workspace:FindFirstChild("FE_Ignorable") })))))) then
                if u2.Players:FindFirstChild(v45.Parent.Name).TeamColor ~= p37.TeamColor then
                    return;
                end;
                table.insert(v42, (p36.Position - v45.Position).magnitude);
                table.insert(v43, { v45, v45.Parent.Humanoid, (p36.Position - v45.Position).magnitude });
                v44[tostring((p36.Position - v45.Position).magnitude)] = v45.Parent;
            end;
        end;
        if #v43 > 0 then
            if not p38.Playing then
                p38:Play();
            end;
            local v46 = math.min(unpack(v42));
            local v47 = v44[tostring(v46)];
            if v47 ~= nil and v47:FindFirstChild("HumanoidRootPart") then
                local v48 = v47:FindFirstChild("HumanoidRootPart");
                local v49 = v48:GetMass() * 10;
                local v50 = math.floor(v49);
                u6:FireServer(u7, 3, {
                    u7.Name,
                    v47:FindFirstChild("Humanoid"),
                    v48,
                    v50
                });
                local v51 = { "vakheal", p36.Beam, v48 };
                u6:FireServer(u7, 1, v51);
                u6:Raycast(v51);
                return true;
            end;
        else
            p38:Stop();
            local v52 = { "vakheal", p36.Beam, nil };
            u6:FireServer(u7, 1, v52);
            u6:Raycast(v52);
        end;
    end;
    return v39;
end;
function findHumanoid(p53)
    if p53.Parent:FindFirstChildOfClass("Humanoid") then
        return p53.Parent:FindFirstChildOfClass("Humanoid");
    end;
    if p53.Parent:IsA("Accessory") or (p53.Parent:IsA("Tool") or p53.Parent:IsA("Hat")) then
        return p53.Parent.Parent:FindFirstChildOfClass("Humanoid");
    end;
    if p53.Name == "Mid" or (p53.Name == "Blade" or p53.Name == "Watch") then
        return p53.Parent.Parent:FindFirstChildOfClass("Humanoid");
    end;
    if p53.Name == "Right Leg" or (p53.Name == "Left Leg" or p53.Name == "FakeHat") then
        return p53.Parent.Parent:FindFirstChildOfClass("Humanoid");
    end;
end;
function GetTeam(p54, p55)
    if p55.TeamColor ~= BrickColor.new("Brown") then
        return (p54.TeamColor == BrickColor.new("Brown") or p54.TeamColor == BrickColor.new("White")) and "ENEMY" or "FRIEND";
    end;
    if p55.TeamColor == BrickColor.new("Brown") then
        return p54.TeamColor == BrickColor.new("Brown") and "FRIEND" or "ENEMY";
    end;
end;
function DamageReturn(p56, p57)
    if p56 == nil then
    elseif p56.Name == "Head" or p56.Parent.ClassName == "Accessory" then
        return p57 * 1.5;
    elseif p56.Name == "Torso" or (p56.Name == "HumanoidRootPart" or (p56.Parent.ClassName == "Tool" or p56.Name == "Mid")) then
        return p57 * 1.25;
    elseif p56.Name == "Left Arm" or (p56.Name == "Right Arm" or (p56.Name == "Left Leg" or (p56.Name == "Right Leg" or (p56.Name == "Mid" or (p56.Name == "Blade" or p56.Name == "Watch"))))) then
        return p57;
    else
        return p56.Name ~= "BDR" and p56.Name ~= "BDL" and 0 or p57 * 1.15;
    end;
end;
function FindHitPart(p58)
    return (p58.Name == "BDL" or p58.Name == "BDR") and "Blast_Door" or nil;
end;
function u3.FireFunction(p59, u60, p61, _, p62, p63, p64, _, p65, p66, p67, _) --[[ Line: 429 ]]
    -- upvalues: u2 (copy), u4 (copy), u6 (ref), u3 (copy), u7 (ref), l__Requirement__2 (copy), u34 (copy)
    local v68 = workspace;
    local v69 = Ray.new(p61.Character.Head.Position, (u60.CFrame * Vector3.new(0, 0, 0) - p61.Character.Head.Position).Unit * (p61.Character.Head.Position - u60.CFrame * Vector3.new(0, 0, 0)).magnitude);
    local v70 = { p61.Character, workspace:FindFirstChild("FE_Ignorable") };
    for _, v71 in pairs(u2.Players:GetPlayers()) do
        if v71.Character then
            table.insert(v70, v71.Character);
        end;
    end;
    if v68:FindPartOnRayWithIgnoreList(v69, v70) then
    else
        if p61.Character.Humanoid.Health > 0 then
            if p63 then
                table.insert(u4, p63);
            elseif not p63 then
                table.remove(u4, 3);
            end;
            local v72 = p61.Character.Head.CFrame * Vector3.new(0, 0, 0);
            for _ = 1, p62 do
                local _, v73 = workspace:FindPartOnRayWithIgnoreList(Ray.new(v72, CFrame.new(v72, p59).lookVector * 999), u6:GetIgnore(unpack(u4)));
                local l__magnitude__6 = (v73 - v72).magnitude;
                local v74 = math.random(-(p64 / 100) * l__magnitude__6, p64 / 200 * l__magnitude__6);
                local v75 = math.random(-(p64 / 100) * l__magnitude__6, p64 / 100 * l__magnitude__6);
                local v76 = v73 + Vector3.new(v74, v75, math.random(-(p64 / 100) * l__magnitude__6, p64 / 100 * l__magnitude__6));
                local v77;
                if p63 then
                    v77 = workspace:FindPartOnRayWithIgnoreList(Ray.new(v72, CFrame.new(v72, v76).lookVector * 999), u6:GetIgnore(unpack(u4)));
                else
                    v77 = workspace:FindPartOnRayWithIgnoreList(Ray.new(p61.Character.Head.CFrame.p, CFrame.new(p61.Character.Head.CFrame.p, v76).lookVector * 999), u6:GetIgnore(unpack(u4)));
                end;
                u3.DrawRay(l__magnitude__6, u60, v76, p65, p66);
                coroutine.resume(coroutine.create(function() --[[ Line: 456 ]]
                    -- upvalues: u60 (copy)
                    if u60.Flash.Enabled then
                        u60.Flash.Enabled = true;
                        wait(0.15);
                        u60.Flash.Enabled = false;
                    end;
                end));
                local v78 = { "vak", u60, v76 };
                u6:FireServer(u7, 1, v78);
                u6:Raycast(v78);
                spawn(function() --[[ Line: 467 ]]
                    -- upvalues: u60 (copy)
                    if not u60.Flash.Enabled then
                        u60.Flash.Enabled = true;
                        wait(0.15);
                        u60.Flash.Enabled = false;
                    end;
                end);
                local v79 = l__Requirement__2:Invoke("hitpart_check", v77);
                if v79 ~= nil and (v79[1] ~= nil and v79[2] ~= nil) then
                    local v80 = v79[1];
                    local v81 = v79[2];
                    if v81.Health > 0 and l__Requirement__2:Invoke("damage_check", v80) == true then
                        local v82 = DamageReturn(v77, p67) or 0;
                        if v77.Name == "Head" then
                            u34(v76, v82, Color3.fromRGB(255, 130, 41));
                        else
                            u34(v76, v82, Color3.fromRGB(255, 255, 255));
                        end;
                        p61.PlayerGui.VAK_UI.Sonidos.HitSound:Play();
                        local u83 = Instance.new("SelectionBox", u2.Workspace:FindFirstChild("FE_Ignorable") or workspace);
                        u83.Adornee = v77;
                        u83.Color3 = Color3.new(253, 255, 116);
                        u83.LineThickness = 0.025;
                        spawn(function() --[[ Line: 495 ]]
                            -- upvalues: u2 (ref), u83 (copy)
                            u2.Debris:AddItem(u83, 0.15);
                        end);
                        local v84 = v77:GetMass() * 10;
                        local v85 = math.floor(v84);
                        u6:FireServer(u7, 2, {
                            u7.Name,
                            v81,
                            v77,
                            v85
                        });
                    end;
                end;
            end;
        end;
    end;
end;
function u3.OfficerPistol(p86, p87, u88, p89, p90, _, _) --[[ Line: 508 ]]
    -- upvalues: u3 (copy)
    local l__Target__7 = p86.Target;
    local l__magnitude__8 = (u88.Position - p87).magnitude;
    local l__Humanoid__9 = p89.Character.Humanoid;
    u3.DrawRay(l__magnitude__8, u88, p87, p90);
    spawn(function() --[[ Line: 513 ]]
        -- upvalues: u88 (copy)
        if not u88.Flash.Enabled then
            u88.Flash.Enabled = true;
            wait(0.1);
            u88.Flash.Enabled = false;
        end;
    end);
    local v91 = l__Target__7 and findHumanoid(l__Target__7);
    if v91 then
        p89.PlayerGui.MainUI.LocalSounds.HitSound:Play();
        if v91.Health <= 100 and v91.Name == "Humanoid" then
            v91.Parent:findFirstChild("ForceField");
        end;
        if v91 == l__Humanoid__9 then
        end;
    end;
end;
function u3.Scope(p92, p93, p94, p95, p96, _) --[[ Line: 537 ]]
    -- upvalues: u3 (copy)
    local l__VCFrame__10 = p93:WaitForChild("VCFrame");
    if p94 == true then
        u3.Scoped = true;
        p93.LocalSounds.ScopeSound:Play();
        p92.FieldOfView = 30;
        p95:Play();
        p96.GripForward = Vector3.new(1, -0, -0);
        p96.GripPos = Vector3.new(0.5, 0.1, -0);
        p96.GripRight = Vector3.new(0, 0, 1);
        p96.GripUp = Vector3.new(0, 1, -0);
        l__VCFrame__10.Background.Visible = true;
        for _ = 1, 14 do
            l__VCFrame__10.ScopeImage.ImageTransparency = l__VCFrame__10.ScopeImage.ImageTransparency - 0.05;
            wait();
        end;
        p93.LocalSounds.Heartbeat:Play();
    else
        if p94 == false then
            u3.Scoped = false;
            p92.FieldOfView = 70;
            p95:Stop();
            p96.GripForward = Vector3.new(0.965, 0, -0.261);
            p96.GripPos = Vector3.new(0.5, 0.1, 0);
            p96.GripRight = Vector3.new(0.261, 0, 0.965);
            p96.GripUp = Vector3.new(0, 1, 0);
            l__VCFrame__10.Background.Visible = false;
            l__VCFrame__10.Background.Percentage.Text = "0%";
            l__VCFrame__10.Background.Bar.Scroller:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Quad", 0.1, true);
            for _ = 1, 14 do
                p93.VCFrame.ScopeImage.ImageTransparency = l__VCFrame__10.ScopeImage.ImageTransparency + 0.05;
                wait();
            end;
            p93.LocalSounds.ScopeSound:Stop();
            p93.LocalSounds.Heartbeat:Stop();
        end;
    end;
end;
function u3.GetRankInVAK(p97, p98) --[[ Line: 578 ]]
    return p98:GetRankInGroup(p97) >= 10;
end;
function u3.ZoomIn(p99, p100) --[[ Line: 585 ]]
    -- upvalues: u3 (copy)
    if p99 then
        if not u3.Zoom then
            u3.Zoom = Instance.new("Part", workspace.IgnoredItems);
            u3.Zoom.Transparency = 1;
            u3.Zoom.Anchored = true;
            u3.Zoom.CanCollide = false;
            u3.Zoom.FormFactor = "Custom";
            u3.Zoom.Size = Vector3.new(0.2, 0.2, 0.2);
            workspace.CurrentCamera.CameraSubject = u3.Zoom;
            workspace.CurrentCamera.CameraType = "Follow";
        end;
        u3.Zoom.CFrame = CFrame.new(p99);
    else
        u3.Zoom:Destroy();
        u3.Zoom = nil;
        workspace.CurrentCamera.CameraSubject = p100;
        workspace.CurrentCamera.CameraType = "Custom";
    end;
end;
return u3;