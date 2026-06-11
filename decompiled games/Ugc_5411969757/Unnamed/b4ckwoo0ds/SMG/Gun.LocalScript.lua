-- Decompiled from: .b4ckwoo0ds.SMG.Gun
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local v1 = game;
local v3 = setmetatable({}, {
    __index = function(_, p2) --[[ Name: __index, Line 3 ]]
        return game:GetService(p2);
    end
});
local l__Requirement__1 = v3.Players.LocalPlayer:WaitForChild("Requirement");
local l__Parent__2 = script.Parent;
local l__ServerConnectionFolder__3 = l__Parent__2:WaitForChild("ServerConnectionFolder");
local v4;
repeat
    v4 = l__ServerConnectionFolder__3:FindFirstChildOfClass("ModuleScript");
    wait();
until v4 ~= nil;
local u5 = require(v4);
local l__LocalPlayer__4 = v3.Players.LocalPlayer;
l__LocalPlayer__4:WaitForChild("Backpack");
local l__PlayerGui__5 = l__LocalPlayer__4:WaitForChild("PlayerGui");
local u6 = false;
repeat
    wait(0.1);
until l__LocalPlayer__4.Character;
local l__Character__6 = l__LocalPlayer__4.Character;
local _ = workspace.CurrentCamera;
local l__Parent__7 = script.Parent;
local l__Handle__8 = l__Parent__7:WaitForChild("Handle");
local l__Barrel__9 = l__Parent__7:WaitForChild("Barrel");
local l__GunGUI__10 = l__Parent__7:WaitForChild("GunGUI");
v1:GetService("ReplicatedStorage");
v1:GetService("Debris");
local u7 = {};
local l__new__11 = CFrame.new;
local l__fromEulerAnglesXYZ__12 = CFrame.fromEulerAnglesXYZ;
local l__new__13 = Vector3.new;
local _, u8, u9, u10, u11 = u5:QueueAnimations(5188562396, 5188564518, 5188561174, 5188563640);
local _ = {
    Left = l__new__11(0.9, 0.8, 0.5) * l__fromEulerAnglesXYZ__12(4.886921905584122, 0.6981317007977318, -0.03490658503988659),
    Right = l__new__11(-1, 0.1, 0.35) * l__fromEulerAnglesXYZ__12(-1.5707963267948966, -0.2617993877991494, 0)
};
local u12 = l__Character__6:FindFirstChild("armToggle") and l__Character__6.armToggle or Instance.new("BoolValue");
u12.Name = "armToggle";
local u13 = 35;
local u14 = false;
local u15 = false;
local u16 = false;
local u17 = true;
local u18 = false;
local u19 = nil;
if l__Parent__7:FindFirstChild("used") then
    u13 = 0;
else
    local v20 = Instance.new("ObjectValue");
    v20.Parent = l__Parent__7;
    v20.Name = "Used";
end;
local u22 = {
    Default = function(...) --[[ Name: Default, Line 87 ]]
        -- upvalues: l__Character__6 (copy), u9 (copy), u8 (copy)
        if l__Character__6 and l__Character__6:FindFirstChild("Torso") then
            u9:Stop();
            u8:Play();
            l__Character__6.Humanoid.WalkSpeed = 16;
        end;
    end,
    Holster = function(...) --[[ Name: Holster, Line 95 ]]
        -- upvalues: l__Character__6 (copy), u8 (copy), u9 (copy)
        l__Character__6.Torso:FindFirstChild("Weld1");
        l__Character__6.Torso:FindFirstChild("Weld2");
        u8:Stop();
        u9:Play();
    end,
    Crouch = function(p21) --[[ Name: Crouch, Line 103 ]]
        -- upvalues: l__Character__6 (copy), u10 (copy)
        if l__Character__6:FindFirstChild("HumanoidRootPart") == nil then
            return nil;
        end;
        if l__Character__6.HumanoidRootPart:FindFirstChild("RootJoint") == nil then
            return nil;
        end;
        if p21 then
            if l__Character__6:FindFirstChild("Left Leg") and (l__Character__6:findFirstChild("Right Leg") and (l__Character__6:findFirstChild("HumanoidRootPart") and (l__Character__6.HumanoidRootPart:findFirstChild("RootJoint") and (l__Character__6.Torso and (l__Character__6.Torso:findFirstChild("Left Hip") and l__Character__6.Torso:findFirstChild("Right Hip")))))) then
                u10:Play();
            end;
        else
            l__Character__6:FindFirstChild("HumanoidRootPart");
            u10:stop();
        end;
    end
};
function u22.Animations(...) --[[ Line: 122 ]]
    -- upvalues: l__Character__6 (copy), u8 (copy), u9 (copy), u11 (copy), u22 (copy)
    if l__Character__6 and l__Character__6:FindFirstChild("Torso") then
        u8:Stop();
        u9:Stop();
        u11:Play();
        wait(0.09);
        wait(0.18);
        wait(0.09);
        wait(0.18);
        wait(0.09);
        wait(0.18);
        wait(0.09);
        wait();
        wait();
        wait();
        wait(0.09);
        wait(0.09);
        wait(0.09);
        wait(0.13);
        wait(0.09);
        wait(0.09);
        u22.Default();
    end;
end;
local u24 = {
    UpdateGui = function(...) --[[ Name: UpdateGui, Line 167 ]]
        -- upvalues: u19 (ref), u6 (ref), u13 (ref)
        if u19 ~= nil then
            u19.Main.Ammo.Text = u6 == true and "INF" or tostring(u13);
            u19.Main.GunMain.AmmoBar2.Size = UDim2.new(u6 == true and 1 or u13 / 35, 0, 1, 0);
        end;
    end,
    GetPlayer = function(p23) --[[ Name: GetPlayer, Line 174 ]]
        if p23 and p23.Parent then
            if p23.Parent:FindFirstChild("Humanoid") then
                return p23.Parent.Humanoid;
            end;
            if p23.Parent.Parent:FindFirstChild("Humanoid") then
                return p23.Parent.Parent.Humanoid;
            end;
        end;
    end
};
local u25 = {};
function u25.Raycast(p26, p27, p28) --[[ Line: 186 ]]
    -- upvalues: u5 (ref), u25 (copy)
    local l__unit__14 = (p27 - p26).unit;
    local v29 = Ray.new(p26, l__unit__14 * 999);
    local v30, v31 = workspace:FindPartOnRayWithIgnoreList(v29, u5:GetIgnore());
    if v30 and (v31 and v30.Name == "Ray") then
        v30, v31 = u25.Raycast(v31, l__unit__14 * 999, p28);
    end;
    return v30, v31;
end;
local u32 = nil;
function u25.Fire(p33, _) --[[ Line: 211 ]]
    -- upvalues: u32 (ref), l__Barrel__9 (copy), l__new__13 (copy), u25 (copy), l__Character__6 (copy), l__new__11 (copy), u5 (ref), l__Parent__7 (copy), l__Requirement__1 (copy), u19 (ref), l__Parent__2 (copy)
    u32 = nil;
    local l__magnitude__15 = (l__Barrel__9.Position - p33).magnitude;
    local v34 = -0.002 * l__magnitude__15;
    local v35 = 0.002 * l__magnitude__15;
    local v36 = l__new__13(p33.x + math.random(v34, v35), p33.y + math.random(v34, v35), p33.z + math.random(v34, v35));
    local v37, v38 = u25.Raycast(l__Character__6.Head.Position, v36, { l__Character__6 });
    local _ = (l__Barrel__9.Position - v38).magnitude;
    l__new__11(l__Barrel__9.Position, v38);
    local v39 = { "smg", l__Barrel__9, v38 };
    u5:FireServer(l__Parent__7, 1, v39);
    u5:Raycast(v39);
    local v40 = l__Requirement__1:Invoke("hitpart_check", v37);
    if v40 ~= nil and (v40[1] ~= nil and v40[2] ~= nil) then
        local v41 = v40[1];
        local v42 = v40[2];
        if v42.Health > 0 and l__Requirement__1:Invoke("damage_check", v41) == true then
            if u19 ~= nil then
                u19.Hit.Rotation = math.random(1, 360);
                u19.Hit.Visible = true;
                delay(0.1, function() --[[ Line: 253 ]]
                    -- upvalues: u19 (ref)
                    u19.Hit.Visible = false;
                end);
            end;
            local v43 = v37:GetMass() * 10;
            local v44 = math.floor(v43);
            u5:FireServer(l__Parent__7, 2, {
                l__Parent__2.Name,
                v42,
                v37,
                v44
            });
        end;
    end;
end;
function u25.Reload(_) --[[ Line: 306 ]]
    -- upvalues: u6 (ref), l__Barrel__9 (copy), u24 (copy), u16 (ref), u13 (ref), u14 (ref), l__Character__6 (copy), u19 (ref), l__Handle__8 (copy), u22 (copy)
    if u6 == true then
    else
        l__Barrel__9.Light.Enabled = false;
        u24.UpdateGui();
        if not u16 and (u13 < 35 and u14) then
            u16 = true;
            l__Character__6.Humanoid.WalkSpeed = 16;
            spawn(function() --[[ Line: 316 ]]
                -- upvalues: u19 (ref), u16 (ref), u14 (ref)
                for v45 = 1, 3 do
                    if u19 == nil or not (u16 and u14) then
                        break;
                    end;
                    u19.Main.Ammo.Text = "REL" .. string.rep(".", v45);
                    wait(0.4);
                end;
            end);
            l__Handle__8.Reload:Play();
            u22.Animations();
            if not (u16 and u14) then
                return;
            end;
            u13 = 35;
            u16 = false;
            u24.UpdateGui();
        end;
    end;
end;
local u50 = {
    KeyPressed = function(p46, p47) --[[ Name: KeyPressed, Line 338 ]]
        -- upvalues: u16 (ref), u15 (ref), u25 (copy), u32 (ref), u12 (copy), l__Character__6 (copy), u22 (copy), u18 (ref)
        local v48 = p46:lower();
        if v48 == "r" and not (u16 or u15) then
            u25.Reload(p47);
            u32 = nil;
        elseif v48 == "f" and not (u16 or u15) then
            if u12.Value then
                u12.Value = false;
                l__Character__6.Humanoid.WalkSpeed = 16;
                u22.Default();
            else
                u12.Value = true;
                l__Character__6.Humanoid.WalkSpeed = 22;
                u22.Holster();
            end;
        elseif v48 == "c" and not u12.Value then
            if u18 then
                u18 = false;
                l__Character__6.Humanoid.WalkSpeed = 16;
                u22.Crouch(false);
            else
                u18 = true;
                l__Character__6.Humanoid.WalkSpeed = 14;
                u22.Crouch(true);
            end;
        end;
        local _ = v48 == "k";
    end,
    MouseClick = function(p49) --[[ Name: MouseClick, Line 369 ]]
        -- upvalues: u14 (ref), u15 (ref), u16 (ref), u17 (ref), l__Character__6 (copy), u24 (copy), u22 (copy), u12 (copy), l__Barrel__9 (copy), u13 (ref), u6 (ref), u25 (copy), l__Handle__8 (copy)
        if u14 and (not u15 and (not u16 and (u17 and l__Character__6.Humanoid.Health > 0))) then
            u15 = true;
            u24.UpdateGui();
            u22.Default();
            u12.Value = false;
            l__Barrel__9.Light.Enabled = true;
            while u15 and (l__Character__6.Humanoid.Health > 0 and (u17 and (u13 > 0 and u14))) do
                u24.UpdateGui();
                l__Barrel__9.Light.Angle = math.random(90, 180);
                if u6 == false then
                    u13 = u13 - 1;
                end;
                u25.Fire(p49.hit.p, p49);
                l__Handle__8.Fire:Play();
                l__Handle__8.Parent.Barrel.Flash.Enabled = true;
                u17 = false;
                wait(0.09);
                u17 = true;
            end;
            if u13 <= 0 then
                u25.Reload(p49);
            end;
            u24.UpdateGui();
            l__Barrel__9.Light.Enabled = false;
            l__Handle__8.Parent.Barrel.Flash.Enabled = false;
        end;
    end,
    MouseRelease = function(_) --[[ Name: MouseRelease, Line 407 ]]
        -- upvalues: u15 (ref), l__Barrel__9 (copy), l__Handle__8 (copy)
        u15 = false;
        l__Barrel__9.Light.Enabled = false;
        l__Handle__8.Parent.Barrel.Flash.Enabled = false;
    end
};
l__Character__6.Humanoid.Changed:connect(function(p51) --[[ Line: 413 ]]
    -- upvalues: l__Character__6 (copy), l__Parent__7 (copy)
    if p51 == "Health" and l__Character__6.Humanoid.Health <= 0 then
        l__Parent__7:Destroy();
    end;
end);
l__Parent__7.Equipped:connect(function(u52) --[[ Line: 419 ]]
    -- upvalues: u5 (ref), u14 (ref), u7 (ref), u8 (copy), l__GunGUI__10 (copy), u19 (ref), l__PlayerGui__5 (copy), u24 (copy), u50 (copy)
    u52.TargetFilter = u5:GetTargetFilter();
    u14 = true;
    for _, v53 in pairs(u7) do
        v53:Destroy();
    end;
    u8:Play();
    u7 = {};
    local v54 = l__GunGUI__10:Clone();
    u19 = v54;
    table.insert(u7, #u7 + 1, v54);
    v54.Parent = l__PlayerGui__5;
    u24.UpdateGui();
    u52.Button1Down:connect(function() --[[ Line: 434 ]]
        -- upvalues: u50 (ref), u52 (copy)
        u50.MouseClick(u52);
    end);
    u52.Button1Up:connect(function() --[[ Line: 435 ]]
        -- upvalues: u50 (ref), u52 (copy)
        u50.MouseRelease(u52);
    end);
    u52.KeyDown:connect(function(p55) --[[ Line: 436 ]]
        -- upvalues: u50 (ref), u52 (copy)
        u50.KeyPressed(p55, u52);
    end);
    u52.Move:connect(function() --[[ Line: 437 ]]
        -- upvalues: u14 (ref), u19 (ref), u52 (copy)
        if u14 and u19 ~= nil then
            u19.Hit.Position = UDim2.new(0, u52.X - 22.5, 0, u52.Y - 22.5);
        end;
    end);
end);
l__Parent__7.Unequipped:connect(function(_) --[[ Line: 444 ]]
    -- upvalues: u7 (ref), u19 (ref), u10 (copy), u8 (copy), u9 (copy), u11 (copy), u14 (ref), u15 (ref), u18 (ref), u22 (copy), u16 (ref), l__Barrel__9 (copy), l__Parent__7 (copy)
    for _, v56 in pairs(u7) do
        v56:Destroy();
    end;
    u19 = nil;
    u10:Stop();
    u8:Stop();
    u9:Stop();
    u11:Stop();
    u14 = false;
    u15 = false;
    u18 = false;
    u22.Crouch(false);
    u16 = false;
    l__Barrel__9.Light.Enabled = false;
    if l__Parent__7:FindFirstChild("FakeLeftArm") then
        l__Parent__7.FakeLeftArm:Destroy();
    else
        if l__Parent__7:FindFirstChild("FakeRightArm") then
            l__Parent__7.FakeRightArm:Destroy();
        end;
    end;
end);
local v57 = l__Requirement__1:Invoke("getsvar", "infammo");
if v57 == true then
    Mag = 999999;
    HealMag = 999999;
end;
