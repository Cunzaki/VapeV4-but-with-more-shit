-- Decompiled from: .ChillArrow26.PlayerScripts.Importantes.GameRaycast
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__Raycast__2 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage", 300):WaitForChild("Remotes"):WaitForChild("Raycast");
local u1 = require(script:FindFirstChildOfClass("ModuleScript"));
local v2 = Instance.new("BindableEvent");
v2.Name = "RaycastEvent";
v2.Parent = l__LocalPlayer__1;
local u3 = unpack;
v2.Event:connect(function(p4, p5) --[[ Line: 16 ]]
    -- upvalues: u1 (copy), l__LocalPlayer__1 (copy), u3 (copy)
    if p4 == "ray" then
        local v6 = u1[tostring(p5[1]):lower()];
        if v6 == nil then
            return;
        end;
        v6(l__LocalPlayer__1, u3(p5, 2));
    end;
end);
l__Raycast__2.OnClientEvent:connect(function(p7, p8) --[[ Line: 28 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u1 (copy), u3 (copy)
    if p7 == l__LocalPlayer__1 then
    elseif p7 == nil then
    elseif p8 == nil then
    else
        local v9 = u1[tostring(p8[1]):lower()];
        if v9 == nil then
        else
            v9(p7, u3(p8, 2));
        end;
    end;
end);
