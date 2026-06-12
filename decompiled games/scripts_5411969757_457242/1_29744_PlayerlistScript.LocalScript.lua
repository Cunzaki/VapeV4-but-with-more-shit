-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__Teams__3 = game:GetService("Teams");
local l__HttpService__4 = game:GetService("HttpService");
local l__StarterGui__5 = game:GetService("StarterGui");
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local l__game__7 = game:GetService("ReplicatedStorage"):WaitForChild("game");
local l__Controllers__8 = l__game__7:WaitForChild("Controllers");
l__game__7:WaitForChild("Events");
local l__PlayerlistController__9 = require(l__Controllers__8:WaitForChild("PlayerlistController"));
local l__PlayerlistContainer__10 = script.Parent:WaitForChild("PlayerlistContainer");
local l__ScrollingFrame__11 = l__PlayerlistContainer__10:WaitForChild("ScrollingFrame");
local u1 = Instance.new("StringValue");
local l__OverUI__12 = script.Parent:WaitForChild("OverUI");
local l__UIListLayout__13 = l__ScrollingFrame__11:WaitForChild("UIListLayout");
repeat
    l__StarterGui__5:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
until l__StarterGui__5:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) == false;
local function v7() --[[ Line: 37 ]]
    -- upvalues: l__ScrollingFrame__11 (copy), l__Teams__3 (copy), l__PlayerlistController__9 (copy), u1 (copy), l__HttpService__4 (copy)
    for _, v2 in pairs(l__ScrollingFrame__11:GetChildren()) do
        if v2:IsA("Frame") or v2:IsA("TextButton") then
            v2:Destroy();
        end;
    end;
    local v3 = l__Teams__3:GetTeams();
    for v4, v5 in ipairs(v3) do
        local v6, _ = l__PlayerlistController__9.CreateTeamFrame(v5, v4);
        v6.Parent = l__ScrollingFrame__11;
        u1.Value = l__HttpService__4:GenerateGUID();
    end;
end;
local function v24(u8) --[[ Line: 53 ]]
    -- upvalues: l__ScrollingFrame__11 (copy), l__PlayerlistController__9 (copy), l__OverUI__12 (copy), l__PlayerlistContainer__10 (copy), l__LocalPlayer__6 (copy), u1 (copy), l__UIListLayout__13 (copy)
    local u9 = nil;
    local u10 = false;
    local u11 = {};
    local u12 = {};
    local function v13() --[[ Line: 59 ]]
        -- upvalues: l__ScrollingFrame__11 (ref), u8 (copy), u9 (ref)
        u9.Parent = l__ScrollingFrame__11:FindFirstChild(u8.TeamColor.Name) or l__ScrollingFrame__11;
    end;
    local function u18() --[[ Line: 64 ]]
        -- upvalues: u10 (ref), u12 (copy), u9 (ref), l__PlayerlistController__9 (ref), u8 (copy), l__OverUI__12 (ref), l__PlayerlistContainer__10 (ref), l__LocalPlayer__6 (ref), l__ScrollingFrame__11 (ref), u18 (copy)
        if u10 == true then
        else
            for _, v14 in pairs(u12) do
                v14:Disconnect();
            end;
            u9 = l__PlayerlistController__9.CreatePlayerFrame(u8, l__OverUI__12, l__PlayerlistContainer__10);
            if u8 == l__LocalPlayer__6 then
                local l__UIListLayout__14 = u9:WaitForChild("StatsFrame"):WaitForChild("UIListLayout");
                local function v15() --[[ Line: 72 ]]
                    -- upvalues: l__UIListLayout__14 (copy), l__ScrollingFrame__11 (ref)
                    l__ScrollingFrame__11.Size = UDim2.new(0, l__UIListLayout__14.AbsoluteContentSize.X + 190 + 20, 1, 0);
                end;
                local v16 = u12;
                local v17 = l__UIListLayout__14:GetPropertyChangedSignal("AbsoluteContentSize");
                table.insert(v16, v17:Connect(v15));
                l__ScrollingFrame__11.Size = UDim2.new(0, l__UIListLayout__14.AbsoluteContentSize.X + 190 + 20, 1, 0);
            end;
            table.insert(u12, u9.Destroying:Connect(u18));
            u9.Parent = l__ScrollingFrame__11:FindFirstChild(u8.TeamColor.Name) or l__ScrollingFrame__11;
        end;
    end;
    u18();
    local v19 = u1:GetPropertyChangedSignal("Value");
    table.insert(u11, v19:Connect(v13));
    local v20 = u8:GetPropertyChangedSignal("TeamColor");
    table.insert(u11, v20:Connect(v13));
    table.insert(u11, u8.AncestryChanged:Connect(function() --[[ Line: 89 ]]
        -- upvalues: u8 (copy), u10 (ref), u11 (copy), u12 (copy), u9 (ref)
        if not u8:IsDescendantOf(game) and u10 == false then
            for _, v21 in pairs(u11) do
                v21:Disconnect();
            end;
            for _, v22 in pairs(u12) do
                v22:Disconnect();
            end;
            u10 = true;
            u9:Destroy();
        end;
    end));
    local l__AbsoluteContentSize__15 = l__UIListLayout__13.AbsoluteContentSize;
    local v23 = l__AbsoluteContentSize__15.Y >= l__ScrollingFrame__11.AbsoluteSize.Y;
    l__ScrollingFrame__11.CanvasSize = UDim2.fromOffset(0, l__AbsoluteContentSize__15.Y);
    l__ScrollingFrame__11.ScrollingEnabled = v23;
    u9.Parent = l__ScrollingFrame__11:FindFirstChild(u8.TeamColor.Name) or l__ScrollingFrame__11;
end;
l__PlayerlistController__9.GetVisibilityObject():GetPropertyChangedSignal("Value"):Connect(function() --[[ Name: OnVisibilityUpdate, Line 102 ]]
    -- upvalues: l__PlayerlistController__9 (copy), l__PlayerlistContainer__10 (copy)
    l__PlayerlistContainer__10.Visible = l__PlayerlistController__9.GetPlayerlistVisibility();
end);
l__PlayerlistContainer__10.Visible = l__PlayerlistController__9.GetPlayerlistVisibility();
l__UserInputService__2.InputBegan:Connect(function(p25, p26) --[[ Line: 112 ]]
    -- upvalues: l__PlayerlistController__9 (copy), l__UIListLayout__13 (copy), l__ScrollingFrame__11 (copy)
    if p26 == false and (p25.UserInputType == Enum.UserInputType.Keyboard and p25.KeyCode == Enum.KeyCode.Tab) then
        l__PlayerlistController__9.TogglePlayerlistVisibility();
        local l__AbsoluteContentSize__16 = l__UIListLayout__13.AbsoluteContentSize;
        local v27 = l__AbsoluteContentSize__16.Y >= l__ScrollingFrame__11.AbsoluteSize.Y;
        l__ScrollingFrame__11.CanvasSize = UDim2.fromOffset(0, l__AbsoluteContentSize__16.Y);
        l__ScrollingFrame__11.ScrollingEnabled = v27;
    end;
end);
v7();
l__Players__1.PlayerAdded:Connect(v24);
local function v29() --[[ Line: 30 ]]
    -- upvalues: l__UIListLayout__13 (copy), l__ScrollingFrame__11 (copy)
    local l__AbsoluteContentSize__17 = l__UIListLayout__13.AbsoluteContentSize;
    local v28 = l__AbsoluteContentSize__17.Y >= l__ScrollingFrame__11.AbsoluteSize.Y;
    l__ScrollingFrame__11.CanvasSize = UDim2.fromOffset(0, l__AbsoluteContentSize__17.Y);
    l__ScrollingFrame__11.ScrollingEnabled = v28;
end;
for _, v30 in pairs(l__Players__1:GetPlayers()) do
    v24(v30);
end;
l__Teams__3.ChildAdded:Connect(v7);
l__Teams__3.ChildRemoved:Connect(v7);
l__PlayerlistController__9.GetLeaderstatAvailableObject():GetPropertyChangedSignal("Value"):Connect(v7);
l__UIListLayout__13:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v29);
script.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(v29);
local l__AbsoluteContentSize__18 = l__UIListLayout__13.AbsoluteContentSize;
local v31 = l__AbsoluteContentSize__18.Y >= l__ScrollingFrame__11.AbsoluteSize.Y;
l__ScrollingFrame__11.CanvasSize = UDim2.fromOffset(0, l__AbsoluteContentSize__18.Y);
l__ScrollingFrame__11.ScrollingEnabled = v31;