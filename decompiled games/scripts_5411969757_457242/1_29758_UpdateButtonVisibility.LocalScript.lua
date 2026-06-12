-- Decompiled with Potassium's decompiler.

local _ = game:GetService("Players").LocalPlayer;
local l__game__1 = game:GetService("ReplicatedStorage"):WaitForChild("game");
l__game__1:WaitForChild("Controllers");
l__game__1:WaitForChild("Events");
local l__TemporalSettings__2 = l__game__1:WaitForChild("TemporalSettings");
local l__Frame__3 = script.Parent:WaitForChild("Frame"):WaitForChild("Frame");
local u1 = {
    Menu = l__Frame__3:WaitForChild("Menu"),
    PendingHub = l__Frame__3:WaitForChild("PendingHub"),
    Skins = l__Frame__3:WaitForChild("Skins"),
    Gamemode = l__Frame__3:WaitForChild("Gamemode")
};
local function u7(p2, p3) --[[ Line: 18 ]]
    local v4 = p2:FindFirstChild("TextLabel");
    local v5 = p2:FindFirstChild("ImageLabel");
    local v6 = p2:FindFirstChild("Extra");
    if v4 ~= nil then
        v4.TextTransparency = p3 == true and 0 or 0.7;
    end;
    if v5 ~= nil then
        v5.ImageTransparency = p3 == true and 0 or 0.7;
    end;
    if v6 ~= nil then
        v6.TextTransparency = p3 == true and 0 or 0.7;
    end;
end;
local function v10() --[[ Line: 27 ]]
    -- upvalues: l__TemporalSettings__2 (copy), u7 (copy), u1 (copy)
    local v8 = l__TemporalSettings__2:FindFirstChild("CurrentGamemode");
    local v9 = l__TemporalSettings__2:FindFirstChild("PendingHubEnabled");
    u7(u1.Gamemode, v8 ~= nil);
    u7(u1.PendingHub, v9 ~= nil);
end;
l__TemporalSettings__2.ChildAdded:Connect(v10);
l__TemporalSettings__2.ChildRemoved:Connect(v10);
local v11 = l__TemporalSettings__2:FindFirstChild("CurrentGamemode");
local v12 = l__TemporalSettings__2:FindFirstChild("PendingHubEnabled");
u7(u1.Gamemode, v11 ~= nil);
u7(u1.PendingHub, v12 ~= nil);