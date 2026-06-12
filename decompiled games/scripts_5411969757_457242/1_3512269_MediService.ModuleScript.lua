-- Decompiled with Potassium's decompiler.

local v1 = game;
local v3 = setmetatable({}, {
    __index = function(_, p2) --[[ Name: __index, Line 3 ]]
        return game:GetService(p2);
    end
});
v1:GetService("RunService");
v1:GetService("ContextActionService");
v1:GetService("RunService");
local l__LocalPlayer__1 = v3.Players.LocalPlayer;
local _ = l__LocalPlayer__1.Character;
local u4 = l__LocalPlayer__1:GetMouse();
local l__VAK_UI__2 = l__LocalPlayer__1.PlayerGui:WaitForChild("VAK_UI");
local l__MediWeapon__3 = l__VAK_UI__2:WaitForChild("MainFrame").WeaponFrames.MediWeapon;
local _ = l__VAK_UI__2:WaitForChild("MainFrame").WeaponFrames.MainWeapon;
local l__Saluting__4 = l__VAK_UI__2.PlayerVals.Saluting;
local _ = l__VAK_UI__2.PlayerVals.Sprinting;
local _ = l__VAK_UI__2.PlayerVals.Prone;
local u5 = {};
u5.__index = u5;
u5.CanChat = true;
u5.Gun = require(l__VAK_UI__2.gunModule);
local u6 = nil;
local u7 = nil;
function update(p8)
    -- upvalues: l__MediWeapon__3 (copy)
    if p8 == -99 then
        l__MediWeapon__3.ChargeProgress.Bar:TweenSize(UDim2.new(0, 0, 1, 0), "In", "Quad", 0.05, true);
    else
        l__MediWeapon__3:WaitForChild("AmmoInfo").CurrentClip.Text = p8 .. "%";
        l__MediWeapon__3.ChargeProgress.Bar:TweenSize(UDim2.new(p8 / 100, 0, 1, 0), "In", "Quad", 0.05, true);
    end;
end;
function u5.MediRecharge(p9) --[[ Line: 34 ]]
    -- upvalues: l__LocalPlayer__1 (copy)
    while true do
        wait(p9.Recharge);
        if not p9.IsActive and p9.Charge < p9.MaxCharge then
            p9.Charge = p9.Charge + 1;
            update(p9.Charge);
        end;
        if l__LocalPlayer__1.Character.Humanoid.Health == 0 then
            return;
        end;
    end;
end;
function u5.MediFire(u10) --[[ Line: 45 ]]
    -- upvalues: l__LocalPlayer__1 (copy), l__Saluting__4 (copy), u4 (copy), u7 (ref), u6 (ref)
    u10.IsActive = true;
    while true do
        wait();
        if l__LocalPlayer__1.Character.Humanoid.Health > 0 and (not u10.Shooting and (l__Saluting__4.Value == false and (u10.IsActive and u10.Charge > 0))) then
            if u10.Shooting == false then
                u10.Shooting = true;
                if u10.Gun.HealFunction(u4.Hit.p, u10.Origin[1], l__LocalPlayer__1, u10.Handle.Heal, u10.BaseHeal, u10.BeamColor) == true then
                    u10.Charge = u10.Charge - 1;
                    update(u10.Charge);
                end;
                wait(u10.Rate);
                u10.Shooting = false;
            else
                wait(u10.Rate);
            end;
        end;
        if u10.IsActive == false or u10.Charge == 0 then
            if u10.Charge == 0 and u10.CanChat then
                u10.CanChat = false;
                spawn(function() --[[ Line: 70 ]]
                    -- upvalues: u10 (copy)
                    wait(3);
                    u10.CanChat = true;
                end);
            end;
            local v11 = { "vakheal", u10.Origin[1].Beam, nil };
            u7:FireServer(u6, 1, v11);
            u7:Raycast(v11);
            u10.Handle.Heal:Stop();
            return;
        end;
    end;
end;
function u5.Bind(u12, p13, p14) --[[ Line: 81 ]]
    -- upvalues: u5 (copy), u7 (ref), u6 (ref), u4 (copy)
    u5.Gun.SetRemote(p13);
    u5.Gun.SetTool(p14);
    u7 = p13;
    u6 = p14;
    u12.MouseClick = u4.Button1Down:connect(function() --[[ Line: 86 ]]
        -- upvalues: u12 (copy)
        u12:MediFire(u12);
    end);
    u12.MouseClickUp = u4.Button1Up:connect(function() --[[ Line: 89 ]]
        -- upvalues: u12 (copy)
        u12.IsActive = false;
    end);
    u12.Unequipped = u12.Model.Unequipped:connect(function() --[[ Line: 92 ]]
        -- upvalues: u12 (copy)
        u12.Animations.Hold:Stop();
        if u12.Animations.Recoil then
            u12.Animations.Recoil:Stop();
        end;
        update(-99);
        u12.Animations.Sprint:Stop();
        u12.IsActive = false;
        u12.Out = false;
        u12.Unequipped:disconnect();
        u12.MouseClick:disconnect();
        u12.ChangeArms:disconnect();
    end);
    update(u12.Charge);
end;
return u5;