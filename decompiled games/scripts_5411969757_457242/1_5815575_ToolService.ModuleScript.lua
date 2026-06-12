-- Decompiled with Potassium's decompiler.

local _ = game;
local v2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 3 ]]
        return game:GetService(p1);
    end
});
local l__RunService__1 = v2.RunService;
local l__ContextActionService__2 = v2.ContextActionService;
local l__LocalPlayer__3 = v2.Players.LocalPlayer;
local _ = l__LocalPlayer__3.Character;
local u3 = l__LocalPlayer__3:GetMouse();
local l__VAK_UI__4 = l__LocalPlayer__3.PlayerGui:WaitForChild("VAK_UI");
local _ = l__VAK_UI__4:WaitForChild("MainFrame").WeaponFrames.MediWeapon;
local l__MainWeapon__5 = l__VAK_UI__4:WaitForChild("MainFrame").WeaponFrames.MainWeapon;
local l__Saluting__6 = l__VAK_UI__4.PlayerVals.Saluting;
local l__Sprinting__7 = l__VAK_UI__4.PlayerVals.Sprinting;
local l__Prone__8 = l__VAK_UI__4.PlayerVals.Prone;
local _ = require(l__VAK_UI__4.animModule).AnimTable;
local u4 = {};
u4.__index = u4;
u4.IsActive = false;
u4.Shooting = false;
u4.Enabled = true;
u4.Owned = false;
u4.CanScope = true;
u4.Barrel = 1;
u4.Charge = 0;
u4.Scoped = false;
u4.Gun = require(l__VAK_UI__4.gunModule);
local u5 = nil;
script.Parent:WaitForChild("MainFrame"):WaitForChild("WeaponFrames");
local u6 = 0;
function u4.AntiAutoclicker(_) --[[ Line: 40 ]]
    -- upvalues: l__RunService__1 (copy), u6 (ref)
    local v7 = l__RunService__1.Stepped:wait();
    if v7 - u6 < 0.03 then
        u6 = v7;
        return true;
    else
        u6 = v7;
        return false;
    end;
end;
function u4.CalculateDamage(p8) --[[ Line: 54 ]]
    return p8.BaseDamage + p8.Charge / 4 * 1.6;
end;
function u4.Reload(p9) --[[ Line: 61 ]]
    local _ = p9.Name;
    if p9.Ammo < p9.MaxAmmo and (not p9.Reloading and p9.Out) then
        p9.Reloading = true;
        p9.Enabled = false;
        while true do
            wait(p9.ReloadTime);
            p9.Ammo = p9.Ammo + 1;
            if p9.Out and (p9.Name ~= "StA-19 [OFF]" and p9.Name ~= "StA-19 [S]") then
                p9:CheckAmmo(true, p9.Ammo, p9.MaxAmmo);
                p9.Handle.Buzz:Play();
            end;
            if p9.Ammo == p9.MaxAmmo then
                p9.Reloading = false;
            end;
            if p9.Reloading == false then
                p9.Enabled = true;
                return;
            end;
        end;
    end;
end;
local u10 = l__MainWeapon__5:FindFirstChild("AmmoProgress"):FindFirstChild("Bar");
function u4.CheckAmmo(_, _, p11, p12) --[[ Line: 83 ]]
    -- upvalues: l__MainWeapon__5 (copy), u10 (copy)
    l__MainWeapon__5:WaitForChild("AmmoInfo"):WaitForChild("CurrentClip").Text = p11 == nil and "" or p11;
    l__MainWeapon__5:WaitForChild("AmmoInfo"):WaitForChild("TotalClip").Text = p12 == nil and "" or ("/" .. p12 or "");
    u10:TweenSize(UDim2.new(p11 == nil and 0 or p11 / (p12 == nil and 0 or p12), 0, 1, 0), "Out", "Quad", 0.1, true);
end;
function u4.Firing(u13) --[[ Line: 91 ]]
    -- upvalues: l__Sprinting__7 (copy), l__Prone__8 (copy), u3 (copy), l__LocalPlayer__3 (copy), l__Saluting__6 (copy)
    if l__Sprinting__7.Value == true and (u13.Name ~= "Medi-Gun" or u13.Name ~= "Medi-Gun [MEDIC]") then
        _G.GlobalSprint();
        u13.Animations.Hold:Play();
        u13.Animations.Sprint:Stop();
    end;
    local l__Name__9 = u13.Name;
    if u13.Enabled == false then
    else
        if u13.IsAuto then
            u13.IsActive = true;
            local v14;
            if l__Name__9 == "StA-62" and not u13.Reloading then
                u13.Handle.Buzz:Play();
                v14 = 1;
            else
                v14 = 1;
            end;
            while u13.IsActive do
                u13.InUse = true;
                u13.Shooting = true;
                if l__Prone__8.Value == false then
                    u13.Animations.Recoil:Play();
                end;
                u13.Ammo = u13.Ammo - 1;
                u13:CheckAmmo(true, u13.Ammo, u13.MaxAmmo);
                if #u13.Origin > 1 and (l__Name__9 == "StA-62" and v14 ~= 3) then
                    v14 = v14 + 1;
                end;
                u13.Handle.Fire:Play();
                if u13.Ammo >= 0 then
                    u13.Gun.FireFunction(u3.Hit.p, u13.Origin[v14], l__LocalPlayer__3, nil, u13.Rays, nil, u13.Spread, u13.Distance, { u13.BulletColor, u13.ShellColor }, u13.Shell, u13.BaseDamage, l__Name__9);
                end;
                wait(u13.RoF);
                u13.Shooting = false;
                u13.InUse = false;
                if u13.IsActive == false or (u13.Ammo <= 0 or (u13.Reloading or (l__Sprinting__7.Value == true or (l__Saluting__6.Value == true or (u13.Enabled == false or l__LocalPlayer__3.Character.Humanoid.Health <= 0))))) then
                    break;
                end;
            end;
            u13.InUse = false;
            u13.Animations.Recoil:Stop();
            if u13.Ammo <= 0 then
                u13:Reload();
            end;
        elseif not u13.IsAuto and (l__Name__9 ~= "StA-19 [OFF]" and (l__Name__9 ~= "StA-19 [S]" and (not u13.IsActive and (not u13.Shooting and (not u13.Reloading and (u13.Enabled and u13.InUse == false)))))) then
            u13.InUse = true;
            u13.Shooting = true;
            if u13.Scoped then
                u13.Animations.ZoomFire:Play();
            else
                u13.Animations.Recoil:Play();
            end;
            u13.Ammo = u13.Ammo - 1;
            u13:CheckAmmo(true, u13.Ammo, u13.MaxAmmo);
            u13.Handle.Fire:Play();
            delay(0.2, function() --[[ Line: 168 ]]
                -- upvalues: u13 (copy), l__Name__9 (copy)
                u13.Animations.Recoil:Stop();
                if l__Name__9 == "VC-30" or l__Name__9 == "LS18" then
                    u13.Handle.Pump:Play();
                end;
            end);
            if l__Name__9 == "VC-32" or l__Name__9 == "M42" then
                local v15 = u13:CalculateDamage();
                if u13.Ammo >= 0 then
                    u13.Gun.FireFunction(u3.Hit.p, u13.Origin[math.random(1, #u13.Origin)], l__LocalPlayer__3, v15, u13.Rays, nil, u13.Spread, u13.Distance, { u13.BulletColor, u13.ShellColor }, u13.Shell, u13.BaseDamage, l__Name__9);
                end;
            else
                if u13.Ammo >= 0 then
                    u13.Gun.FireFunction(u3.Hit.p, u13.Origin[math.random(1, #u13.Origin)], l__LocalPlayer__3, nil, u13.Rays, nil, u13.Spread, u13.Distance, { u13.BulletColor, u13.ShellColor }, u13.Shell, u13.BaseDamage, l__Name__9);
                end;
                spawn(function() --[[ Line: 183 ]]
                    -- upvalues: u13 (copy)
                    wait(0.2);
                    if u13.Scoped then
                        u13.Animations.ZoomFire:Stop();
                        u13:Scope();
                    else
                        u13.Animations.Recoil:Stop();
                    end;
                end);
            end;
            wait(u13.RoF);
            u13.Shooting = false;
            u13.InUse = false;
            if u13.Ammo == 0 and l__Name__9 == u13.Name then
                u13:Reload();
            end;
            if not u13.IsAuto and l__Name__9 == "StA-19 [OFF]" or l__Name__9 == "StA-19 [S]" then
                if u13.IsActive and (not u13.IsAuto and (not u13.Shooting and u13.Enabled)) then
                    u13.Shooting = true;
                    u13.Animations.Recoil:Play();
                    u13.Gun.OfficerPistol(u3, u3.Hit, u13.Origin[math.random(1, #u13.Origin)], l__LocalPlayer__3, { u13.BulletColor, u13.ShellColor }, u13.BaseDamage);
                    u13.Handle.Fire:Play();
                    wait(u13.RoF);
                    u13.Shooting = false;
                end;
                u13.Animations.Recoil:Stop();
            end;
        end;
    end;
end;
function u4.Bind(u16, p17, p18) --[[ Line: 213 ]]
    -- upvalues: u5 (ref), u4 (copy), u3 (copy), l__LocalPlayer__3 (copy), l__ContextActionService__2 (copy)
    u5 = p17;
    u4.Gun.SetRemote(p17);
    u4.Gun.SetTool(p18);
    u16.MouseClick = u3.Button1Down:connect(function() --[[ Line: 217 ]]
        -- upvalues: u4 (ref), u16 (copy), l__LocalPlayer__3 (ref)
        if u4:AntiAutoclicker() == true then
            u4.Shooting = false;
            u16.IsActive = false;
            if u16.Name == "StA-62" then
                u16.Handle.Buzz:Stop();
            end;
            l__LocalPlayer__3.Character.Humanoid:UnequipTools();
        else
            if u16.Out == true then
                if u16.Owned == false then
                    u16.Model:FindFirstChild("Value");
                    u16.Owned = true;
                    if u16.Shooting == false then
                        u16:Firing();
                    end;
                elseif u16.Shooting == false then
                    u16:Firing();
                end;
            end;
        end;
    end);
    u16.MouseUp = u3.Button1Up:connect(function() --[[ Line: 252 ]]
        -- upvalues: u16 (copy)
        u16.IsActive = false;
        if u16.Name == "VC-32" or u16.Name == "M42" then
            u16:Unscope();
            u16.Animations.ZoomFire:Stop();
            u16.CanScope = true;
        end;
        if u16.Name == "StA-62" then
            u16.Handle.Buzz:Stop();
        end;
    end);
    u16.Unequipped = u16.Model.Unequipped:connect(function() --[[ Line: 265 ]]
        -- upvalues: u16 (copy), l__ContextActionService__2 (ref)
        for _, v19 in pairs(u16.Animations) do
            if v19 ~= nil then
                v19:Stop();
            end;
        end;
        if u16.Name == "VC-32" or u16.Name == "M42" then
            l__ContextActionService__2:UnbindAction("Zoom");
        elseif u16.Name == "StA-3" or u16.Name == "M224-A1" then
            l__ContextActionService__2:UnbindAction("Deploy");
            if u16.Deployed then
                u16:Bipod();
            end;
        end;
        u16:CheckAmmo(false, nil, nil);
        u16.IsActive = false;
        u16.Out = false;
        u16.Unequipped:disconnect();
        u16.MouseClick:disconnect();
        u16.ChangeArms:disconnect();
        u16.Scoped = false;
        u16.CanScope = false;
        u16:CheckAmmo(false, nil, nil);
    end);
    l__ContextActionService__2:BindAction("Reload", function(_, p20, _) --[[ Line: 293 ]]
        -- upvalues: u16 (copy)
        if p20 == Enum.UserInputState.Begin then
            u16:Reload();
        end;
    end, false, Enum.KeyCode.R);
end;
return u4;