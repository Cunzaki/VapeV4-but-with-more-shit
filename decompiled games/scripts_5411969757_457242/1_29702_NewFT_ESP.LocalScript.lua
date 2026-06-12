-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__ESP__2 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage"):WaitForChild("Remotes"):WaitForChild("ESP");
local l__CurrentGamemode__3 = game:GetService("Lighting"):WaitForChild("CurrentGamemode", 300);
local l__Value__4 = l__CurrentGamemode__3.Value;
local u1 = nil;
local u2 = nil;
l__CurrentGamemode__3:GetPropertyChangedSignal("Value"):connect(function() --[[ Line: 12 ]]
    -- upvalues: l__Value__4 (ref), l__CurrentGamemode__3 (copy)
    l__Value__4 = l__CurrentGamemode__3.Value;
end);
l__LocalPlayer__1:GetPropertyChangedSignal("Team"):connect(function() --[[ Line: 16 ]]
    -- upvalues: u1 (ref), l__LocalPlayer__1 (copy), u2 (ref)
    u1 = l__LocalPlayer__1.Team:FindFirstChild("isFFA");
    u2 = l__LocalPlayer__1.Team:FindFirstChild("isLobby");
end);
l__ESP__2.OnClientEvent:connect(function(p3, p4) --[[ Line: 21 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u2 (ref), u1 (ref)
    if p3 ~= nil and (p4 ~= nil and p3 ~= l__LocalPlayer__1) then
        local v5 = p4:FindFirstChild("FT_TeamESP");
        local v6 = false;
        local v7;
        if u2 == nil then
            if u1 == nil then
                v7 = u1 == nil and (u2 == nil and p3.Team == l__LocalPlayer__1.Team) and true or v6;
            else
                v7 = false;
            end;
        else
            v7 = true;
        end;
        if v5 ~= nil then
            v5.Enabled = v7;
        end;
    end;
end);
repeat
    wait();
until l__LocalPlayer__1.Team ~= nil;
u1 = l__LocalPlayer__1.Team:FindFirstChild("isFFA");
u2 = l__LocalPlayer__1.Team:FindFirstChild("isLobby");
l__ESP__2:FireServer();