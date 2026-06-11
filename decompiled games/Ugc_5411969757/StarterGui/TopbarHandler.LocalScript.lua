-- Decompiled from: StarterGui.TopbarHandler
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__game__2 = game:GetService("ReplicatedStorage"):WaitForChild("game");
local l__Controllers__3 = l__game__2:WaitForChild("Controllers");
local l__Events__4 = l__game__2:WaitForChild("Events");
local l__TopbarController__5 = require(l__Controllers__3:WaitForChild("TopbarController"));
local l__PlayerlistController__6 = require(l__Controllers__3:WaitForChild("PlayerlistController"));
local l__PingTesting__7 = l__Events__4:WaitForChild("PingTesting");
local l__PingAndFPS__8 = l__Events__4:WaitForChild("PingAndFPS");
local u1 = l__TopbarController__5.new();
u1.GUI.Parent = script.Parent;
local l__RunService__9 = game:GetService("RunService");
local v2 = u1:CreateContainer("Left");
local v3 = u1:CreateButton(v2, "");
local v4 = u1:CreateButton(v2, "");
v3.Size = UDim2.fromOffset(60, 36);
v4.Size = UDim2.fromOffset(60, 36);
local v5 = Instance.new("Frame");
v5.Size = UDim2.new(0, 1, 0.85, 0);
v5.AnchorPoint = Vector2.new(0, 0.5);
v5.BackgroundTransparency = 0.6;
v5.Visible = true;
local v6 = Instance.new("UIGradient", v5);
v6.Rotation = 90;
v6.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) });
v3.LayoutOrder = 1;
v5.LayoutOrder = 2;
v4.LayoutOrder = 3;
local v7 = u1:CreateButton(v2, "rbxassetid://128111571133899");
v7.LayoutOrder = 0;
local v8 = v5:Clone();
v8.Parent = v7;
v8.Position = UDim2.new(1, l__TopbarController__5.GetIsMobile() == true and 3 or 4, 0.5, 0);
local l__TopbarActionButtons__10 = script.Parent:WaitForChild("TopbarActionButtons");
local l__Frame__11 = l__TopbarActionButtons__10:WaitForChild("Frame"):WaitForChild("Frame");
v7.MouseButton1Click:Connect(function() --[[ Line: 53 ]]
    -- upvalues: l__TopbarActionButtons__10 (copy)
    local v9 = l__TopbarActionButtons__10:FindFirstChild("Toggle");
    if v9 ~= nil then
        v9:Fire();
    end;
end);
l__Frame__11:WaitForChild("Menu").MouseButton1Click:Connect(function() --[[ Line: 60 ]]
    -- upvalues: l__LocalPlayer__1 (copy)
    l__LocalPlayer__1:FindFirstChild("ToggleMenuEvent"):Fire();
end);
game:GetService("UserInputService").InputBegan:Connect(function(p10, p11) --[[ Line: 65 ]]
    -- upvalues: l__TopbarActionButtons__10 (copy)
    if p10.UserInputType == Enum.UserInputType.MouseButton1 and not p11 then
        local v12 = l__TopbarActionButtons__10:FindFirstChild("Toggle");
        if v12 ~= nil then
            v12:Fire(false);
        end;
    end;
end);
local v13 = v5:Clone();
local v14 = Instance.new("Frame", v3);
v14.Size = UDim2.new(1, 0, 1, 0);
v14.BackgroundTransparency = 1;
local v15 = Instance.new("TextLabel", v14);
v15.BackgroundTransparency = 1;
v15.Position = UDim2.fromScale(0, 0.1);
v15.Size = UDim2.fromScale(1, 0.4);
v15.TextColor3 = Color3.new(1, 1, 1);
v15.FontFace = Font.new("rbxassetid://11598121416", Enum.FontWeight.Bold, Enum.FontStyle.Normal);
v15.TextSize = 16;
v15.TextYAlignment = Enum.TextYAlignment.Top;
local u16 = Instance.new("TextLabel", v14);
u16.BackgroundTransparency = 1;
u16.Position = UDim2.fromScale(0, 0.5);
u16.Size = UDim2.fromScale(1, 0.4);
u16.TextColor3 = Color3.new(1, 1, 1);
u16.FontFace = Font.new("rbxassetid://11598121416", Enum.FontWeight.Regular, Enum.FontStyle.Normal);
u16.TextSize = 15;
v13.Parent = v3;
v13.Position = UDim2.new(1, l__TopbarController__5.GetIsMobile() == true and 3 or 4, 0.5, 0);
local v17 = v5:Clone();
v17.Parent = v3;
v17.Position = UDim2.new(0, l__TopbarController__5.GetIsMobile() == true and -3 or -4, 0.5, 0);
v15.Text = "FPS";
u16.Text = "-";
local u18 = tick();
local v20 = coroutine.create(function() --[[ Name: UpdateFPS, Line 114 ]]
    -- upvalues: l__RunService__9 (copy), u16 (copy), u18 (ref), l__PingAndFPS__8 (copy)
    while l__RunService__9.Heartbeat:Wait() do
        local v19 = math.floor(1 / game.Stats.FrameTime);
        u16.Text = tostring(v19);
        if tick() - u18 >= 1 then
            u18 = tick();
            l__PingAndFPS__8:FireServer("FPS", v19);
        end;
    end;
end);
coroutine.resume(v20);
local v21 = Instance.new("Frame", v4);
v21.Size = UDim2.new(1, 0, 1, 0);
v21.BackgroundTransparency = 1;
local v22 = Instance.new("TextLabel", v21);
v22.BackgroundTransparency = 1;
v22.Position = UDim2.fromScale(0, 0.1);
v22.Size = UDim2.fromScale(1, 0.4);
v22.TextColor3 = Color3.new(1, 1, 1);
v22.FontFace = Font.new("rbxassetid://11598121416", Enum.FontWeight.Bold, Enum.FontStyle.Normal);
v22.TextSize = 14;
v22.TextYAlignment = Enum.TextYAlignment.Top;
local u23 = Instance.new("TextLabel", v21);
u23.BackgroundTransparency = 1;
u23.Position = UDim2.fromScale(0, 0.5);
u23.Size = UDim2.fromScale(1, 0.4);
u23.TextColor3 = Color3.new(1, 1, 1);
u23.FontFace = Font.new("rbxassetid://11598121416", Enum.FontWeight.Regular, Enum.FontStyle.Normal);
u23.TextSize = 15;
v5.Parent = v4;
local l__new__12 = UDim2.new;
local v24 = 0;
local _ = l__TopbarController__5.GetIsMobile() == true;
local v25 = -3;
v5.Position = l__new__12(v24, v25, 0.5, 0);
v22.Text = "PING";
u23.Text = ". . .";
local v29 = coroutine.create(function() --[[ Name: UpdatePing, Line 182 ]]
    -- upvalues: l__PingTesting__7 (copy), u23 (copy), l__PingAndFPS__8 (copy)
    while true do
        local v26 = tick();
        l__PingTesting__7:InvokeServer();
        local v27 = (tick() - v26) * 1000;
        local v28 = math.floor(v27);
        u23.Text = tostring(v28);
        l__PingAndFPS__8:FireServer("PING", v28);
        task.wait(1);
    end;
end);
coroutine.resume(v29);
v2.LayoutOrder = 0;
local l__Estadisticas__13 = l__LocalPlayer__1:WaitForChild("Estadisticas");
local u30 = {};
local u31 = {};
local u32 = Instance.new("Frame");
u32.Size = UDim2.new(0, 1, 0.85, 0);
u32.AnchorPoint = Vector2.new(0, 0.5);
u32.BackgroundTransparency = 0.6;
u32.Visible = true;
local v33 = Instance.new("UIGradient", u32);
v33.Rotation = 90;
v33.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) });
local function u36() --[[ Line: 216 ]]
    -- upvalues: u30 (ref), u31 (ref)
    for _, v34 in pairs(u30) do
        v34:Destroy();
    end;
    for _, v35 in pairs(u31) do
        v35:Disconnect();
    end;
    table.clear(u30);
    table.clear(u31);
    u30 = {};
    u31 = {};
end;
local function v52() --[[ Line: 225 ]]
    -- upvalues: u36 (copy), u1 (copy), u30 (ref), l__Estadisticas__13 (copy), l__PlayerlistController__6 (copy), u31 (ref), l__TopbarController__5 (copy), u32 (copy)
    u36();
    local v37 = u1:CreateContainer("Right");
    v37.LayoutOrder = -2;
    table.insert(u30, v37);
    l__Estadisticas__13:GetChildren();
    local v38 = l__PlayerlistController__6.GetAvailableStats();
    local v39 = {};
    for _, v40 in pairs(v38) do
        local v41 = l__Estadisticas__13:FindFirstChild(v40);
        table.insert(v39, v41);
    end;
    for _, u42 in ipairs(v39) do
        local v43 = u1:CreateButton(v37, "");
        v43.Size = UDim2.fromOffset(66, 36);
        v43.Parent = v37;
        v43.LayoutOrder = l__PlayerlistController__6.GetLayoutOrderFromStatname(u42.Name);
        local _ = u42.Name == "Rank";
        local v44 = Instance.new("Frame", v43);
        v44.Size = UDim2.new(1, 0, 1, 0);
        v44.BackgroundTransparency = 1;
        local u45 = Instance.new("TextLabel", v44);
        u45.BackgroundTransparency = 1;
        u45.Position = UDim2.fromScale(0, 0.1);
        u45.Size = UDim2.fromScale(1, 0.4);
        u45.TextColor3 = Color3.new(1, 1, 1);
        u45.FontFace = Font.new("rbxassetid://11598121416", Enum.FontWeight.Bold, Enum.FontStyle.Normal);
        u45.TextSize = 14;
        u45.TextYAlignment = Enum.TextYAlignment.Top;
        local u46 = Instance.new("TextLabel", v44);
        u46.BackgroundTransparency = 1;
        u46.Position = UDim2.fromScale(0, 0.5);
        u46.Size = UDim2.fromScale(1, 0.4);
        u46.TextColor3 = Color3.new(1, 1, 1);
        u46.FontFace = Font.new("rbxassetid://11598121416", Enum.FontWeight.Regular, Enum.FontStyle.Normal);
        u46.TextSize = 15;
        u46.TextTruncate = Enum.TextTruncate.AtEnd;
        local v47 = u31;
        local v48 = u42:GetPropertyChangedSignal("Value");
        table.insert(v47, v48:Connect(function() --[[ Name: Update, Line 272 ]]
            -- upvalues: u45 (copy), u42 (copy), u46 (copy)
            u45.Text = string.upper(u42.Name);
            u46.Text = u42.Value;
        end));
        u45.Text = string.upper(u42.Name);
        u46.Text = u42.Value;
        local v49 = l__TopbarController__5.GetIsMobile() == true and 3 or 4;
        local v50 = u32:Clone();
        v50.Parent = v43;
        v50.Position = UDim2.new(1, v49, 0.5, 0);
        local v51 = u32:Clone();
        v51.Parent = v43;
        v51.Position = UDim2.new(0, -v49, 0.5, 0);
    end;
end;
l__Estadisticas__13.ChildAdded:Connect(v52);
l__Estadisticas__13.ChildRemoved:Connect(v52);
l__PlayerlistController__6.GetLeaderstatAvailableObject():GetPropertyChangedSignal("Value"):Connect(v52);
v52();
local v53 = u1:CreateButton(u1.Right, "rbxassetid://126658543590767");
v53.LayoutOrder = -3;
v53.MouseButton1Click:Connect(function() --[[ Line: 301 ]]
    -- upvalues: l__PlayerlistController__6 (copy)
    l__PlayerlistController__6.TogglePlayerlistVisibility();
end);
local l__PlayerQnty__14 = script.PlayerQnty;
l__PlayerQnty__14.Parent = v53;
local function v54(_) --[[ Line: 307 ]]
    -- upvalues: l__PlayerQnty__14 (copy)
    l__PlayerQnty__14.Text = #game:GetService("Players"):GetPlayers();
end;
game:GetService("Players").ChildAdded:Connect(v54);
game:GetService("Players").ChildRemoved:Connect(v54);
l__PlayerQnty__14.Text = #game:GetService("Players"):GetPlayers();
