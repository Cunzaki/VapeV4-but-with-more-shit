-- Decompiled with Potassium's decompiler.

local v2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 2 ]]
        return game:GetService(p1);
    end
});
local l__LocalPlayer__1 = v2.Players.LocalPlayer;
local _ = v2.ReplicatedFirst;
local l__MediService__2 = require(l__LocalPlayer__1.PlayerGui:WaitForChild("VAK_UI"):WaitForChild("MediService"));
local l__VAK_UI__3 = l__LocalPlayer__1.PlayerGui:WaitForChild("VAK_UI");
local _ = l__VAK_UI__3.PlayerVals.Saluting;
local l__Sprinting__4 = l__VAK_UI__3.PlayerVals.Sprinting;
local u3 = setmetatable({}, l__MediService__2);
u3.Name = "Medi-Gun";
u3.Model = script.Parent;
u3.Handle = u3.Model.Handle;
u3.Origin = { u3.Model.Handle };
u3.AnimationFolder = "Medi";
u3.Working = false;
u3.Recharging = false;
u3.IsActive = false;
u3.Shooting = false;
u3.Enabled = true;
u3.Charge = 100;
u3.MaxCharge = 100;
u3.BaseHeal = 2;
u3.Recharge = 3;
u3.Rate = 0.1;
u3.BeamColor = BrickColor.new("Lime green");
u3.Out = false;
u3.Animations = {
    Hold = nil,
    Sprint = nil,
    Reload = nil,
    Prone = nil,
    Recoil = nil
};
function u3.BindAnimations(p4) --[[ Line: 30 ]]
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
function u3.Equip(u10) --[[ Line: 50 ]]
    -- upvalues: l__Sprinting__4 (copy), u9 (ref)
    u10.Out = true;
    u10:BindAnimations();
    if l__Sprinting__4.Value == true then
        u10.Animations.Sprint:Play();
    elseif l__Sprinting__4.Value == false then
        u10.Animations.Hold:Play();
    end;
    u10.ChangeArms = l__Sprinting__4.Changed:connect(function() --[[ Line: 60 ]]
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
    spawn(function() --[[ Line: 72 ]]
        -- upvalues: u10 (copy)
        if not u10.Recharging then
            u10.Recharging = true;
            u10:MediRecharge();
        end;
    end);
end;
function u3.Reload(p11) --[[ Line: 80 ]]
    local _ = p11.Name;
    if p11.Ammo < p11.MaxAmmo and not p11.Reloading then
        p11.Reloading = true;
        while true do
            wait(p11.ReloadTime);
            p11.Ammo = p11.Ammo + 1;
            if p11.Out and (p11.Name ~= "StA-19 [OFF]" and p11.Name ~= "StA-19 [S]") then
                p11:CheckAmmo(true, p11.Ammo, p11.MaxAmmo);
                p11.Handle.Buzz:Play();
            end;
            if p11.Ammo == p11.MaxAmmo then
                p11.Reloading = false;
            end;
            if p11.Reloading == false then
                return;
            end;
        end;
    end;
end;
return u3;