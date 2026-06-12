-- Decompiled with Potassium's decompiler.

local v2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 2 ]]
        return game:GetService(p1);
    end
});
local l__LocalPlayer__1 = v2.Players.LocalPlayer;
repeat
    wait();
until l__LocalPlayer__1 ~= nil and l__LocalPlayer__1.Character ~= nil;
local _ = v2.RunService;
local _ = v2.ContextActionService;
local l__Character__2 = l__LocalPlayer__1.Character;
l__LocalPlayer__1:GetMouse();
local l__VAK_UI__3 = l__LocalPlayer__1.PlayerGui:WaitForChild("VAK_UI");
local _ = l__VAK_UI__3:WaitForChild("MainFrame").WeaponFrames.MainWeapon;
local _ = l__VAK_UI__3.PlayerVals.Saluting;
local _ = l__VAK_UI__3.PlayerVals.Sprinting;
local u3 = nil;
l__Character__2.ChildAdded:connect(function(p4) --[[ Line: 19 ]]
    -- upvalues: u3 (ref)
    if p4:IsA("Tool") and (p4:findFirstChild("Client") and p4:FindFirstChild("isMediGun") == nil) then
        local v5 = require(p4:findFirstChild("Client"));
        if v5 then
            u3 = v5;
            u3:Equip();
        else
            error("No Client script detected!");
        end;
    else
        if p4:IsA("Tool") and (p4:findFirstChild("Client") and p4:FindFirstChild("isMediGun")) then
            local v6 = require(p4:findFirstChild("Client"));
            if v6 then
                u3 = v6;
                u3:Equip();
                return;
            end;
            error("No Client script detected!");
        end;
    end;
end);
l__Character__2.ChildRemoved:connect(function(p7) --[[ Line: 38 ]]
    -- upvalues: u3 (ref)
    if p7:findFirstChild("Gun") or p7:FindFirstChild("Medi") and p7:IsA("Tool") then
        u3 = nil;
    end;
end);