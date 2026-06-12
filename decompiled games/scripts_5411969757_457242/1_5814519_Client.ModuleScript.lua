-- Decompiled with Potassium's decompiler.

local v2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 2 ]]
        return game:GetService(p1);
    end
});
local l__LocalPlayer__1 = v2.Players.LocalPlayer;
local _ = v2.ReplicatedFirst;
local l__ToolService__2 = require(l__LocalPlayer__1.PlayerGui:WaitForChild("VAK_UI"):WaitForChild("ToolService"));
local l__VAK_UI__3 = l__LocalPlayer__1.PlayerGui:WaitForChild("VAK_UI");
local _ = l__VAK_UI__3.PlayerVals.Saluting;
local l__Sprinting__4 = l__VAK_UI__3.PlayerVals.Sprinting;
local u3 = setmetatable({}, l__ToolService__2);
u3.Name = "StA-55";
u3.Model = script.Parent;
u3.Handle = u3.Model.Handle;
u3.Origin = { u3.Model:FindFirstChild("Barrel", true) };
u3.AnimationFolder = "StA-55";
u3.Shell = true;
u3.Reloading = false;
u3.IsAuto = true;
u3.InUse = false;
u3.Enabled = true;
u3.Out = false;
u3.Ammo = 50;
u3.MaxAmmo = 50;
u3.BaseDamage = 11;
u3.RoF = 0.1;
u3.Spread = 0.6;
u3.Rays = 1;
u3.ReloadTime = 0.04;
u3.BulletColor = BrickColor.new("Bright red");
u3.ShellColor = BrickColor.new("Navy blue");
u3.Material = Enum.Material.Neon;
u3.Distance = 400;
u3.Animations = {
    Hold = nil,
    Sprint = nil,
    Reload = nil,
    Prone = nil,
    Recoil = nil
};
function u3.BindAnimations(p4) --[[ Line: 35 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u3 (copy)
    for _, v5 in pairs(l__LocalPlayer__1.PlayerGui:WaitForChild("VAK_UI"):WaitForChild("Animations"):GetChildren()) do
        if v5.Name == p4.AnimationFolder then
            local v6 = v5:GetChildren();
            for _, v7 in pairs(v6) do
                if u3.Animations[tostring(v7)] == nil then
                    u3.Animations[tostring(v7)] = l__LocalPlayer__1.Character.Humanoid:LoadAnimation(v7);
                end;
            end;
        end;
    end;
end;
l__LocalPlayer__1:WaitForChild("Requirement");
local l__ServerConnectionFolder__5 = script.Parent:WaitForChild("ServerConnectionFolder");
local v8;
repeat
    v8 = l__ServerConnectionFolder__5:FindFirstChildOfClass("ModuleScript");
    wait();
until v8 ~= nil;
local u9 = require(v8);
function u3.Equip(u10) --[[ Line: 55 ]]
    -- upvalues: l__Sprinting__4 (copy), u9 (ref)
    u10.Out = true;
    u10:BindAnimations();
    if u10.Name ~= "StA-19 [OFF]" and u10.Name ~= "StA-19 [S]" then
        u10:CheckAmmo(true, u10.Ammo, u10.MaxAmmo);
    end;
    if l__Sprinting__4.Value == true then
        u10.Animations.Sprint:Play();
    elseif l__Sprinting__4.Value == false then
        u10.Animations.Hold:Play();
    end;
    u10.ChangeArms = l__Sprinting__4.Changed:connect(function() --[[ Line: 68 ]]
        -- upvalues: l__Sprinting__4 (ref), u10 (copy)
        if l__Sprinting__4.Value == false and u10.Out then
            u10.Animations.Hold:Play();
            u10.Animations.Sprint:Stop();
        else
            if l__Sprinting__4.Value == true and u10.Out then
                u10.Animations.Hold:Stop();
                u10.Animations.Sprint:Play();
            end;
        end;
    end);
    u10:Bind(u9, script.Parent);
end;
return u3;