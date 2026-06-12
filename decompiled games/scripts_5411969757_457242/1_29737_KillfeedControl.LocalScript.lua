-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__Debris__2 = game:GetService("Debris");
local l__FTPStorage__3 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage");
local l__KillfeedContainer__4 = script.Parent:WaitForChild("KillfeedContainer");
local l__Killfeed__5 = l__FTPStorage__3:WaitForChild("Remotes"):WaitForChild("Killfeed");
local u1 = Instance.new("IntValue", script);
u1.Name = "CurrentKillfeed";
u1.Value = 0;
local l__TextService__6 = game:GetService("TextService");
local l__Kill__7 = script:WaitForChild("Kill");
local u2 = {
    ["1"] = l__KillfeedContainer__4:WaitForChild("1"):WaitForChild("Container"),
    ["2"] = l__KillfeedContainer__4:WaitForChild("2"):WaitForChild("Container")
};
local u15 = {
    ["1"] = function(p3) --[[ Line: 26 ]]
        -- upvalues: l__Kill__7 (copy), u2 (copy), l__Debris__2 (copy)
        local v4 = p3[1];
        local v5 = p3[2];
        local _ = p3[3];
        if v4 == nil then
        elseif v5 == nil then
        else
            local v6 = script:WaitForChild("1_Killfeed_example"):clone();
            if v4 == 1 then
                l__Kill__7:Play();
                v6:WaitForChild("Label").Text = "Enemy Killed: " .. v5;
                v6.Font = Enum.Font.Gotham;
            elseif v4 == 2 then
                v6:WaitForChild("Label").Text = "Killed by: " .. v5;
                v6.Font = Enum.Font.GothamBlack;
            end;
            v6.Parent = u2["1"];
            l__Debris__2:AddItem(v6, 5);
        end;
    end,
    ["2"] = function(p7) --[[ Line: 53 ]]
        -- upvalues: l__TextService__6 (copy), l__LocalPlayer__1 (copy), l__Kill__7 (copy), u2 (copy), l__Debris__2 (copy)
        local v8 = p7[1];
        local v9 = p7[2];
        local v10 = p7[3];
        local v11 = p7[4] == nil and " [DEAD] " or " [ " .. p7[4] .. " ] ";
        local v12 = l__TextService__6:GetTextSize(v11, 16, Enum.Font.SourceSansBold, Vector2.new(100, 24));
        local v13 = v9 == nil and "" or " [" .. tostring(v9) .. "%]";
        if v8 == nil then
        elseif v10 == nil then
        else
            local v14 = script:WaitForChild("2_Killfeed_example"):clone();
            if v8 == l__LocalPlayer__1 then
                l__Kill__7:Play();
                v14:WaitForChild("Killer").TextColor3 = Color3.fromRGB(255, 255, 127);
                v14:WaitForChild("RIP").TextColor3 = v10.TeamColor.Color;
            elseif v10 == l__LocalPlayer__1 then
                v14:WaitForChild("Killer").TextColor3 = v8.TeamColor.Color;
                v14:WaitForChild("RIP").TextColor3 = Color3.fromRGB(255, 255, 127);
            else
                v14:WaitForChild("Killer").TextColor3 = v8.TeamColor.Color;
                v14:WaitForChild("RIP").TextColor3 = v10.TeamColor.Color;
            end;
            v14:WaitForChild("Killer").Text = v8.Name .. v13;
            v14:WaitForChild("RIP").Text = v10.Name;
            v14:WaitForChild("Mid").Text = v11;
            v14:WaitForChild("Mid").Size = UDim2.new(0, v12.X + 6, 1, 0);
            v14.Parent = u2["2"];
            l__Debris__2:AddItem(v14, 5);
        end;
    end
};
local function u17() --[[ Line: 90 ]]
    -- upvalues: u1 (copy), l__KillfeedContainer__4 (copy)
    local l__Value__8 = u1.Value;
    for _, v16 in pairs(l__KillfeedContainer__4:GetChildren()) do
        v16.Visible = false;
        if v16.Name == tostring(l__Value__8) then
            v16.Visible = true;
        end;
    end;
end;
l__Killfeed__5.OnClientEvent:connect(function(p18, ...) --[[ Line: 101 ]]
    -- upvalues: u1 (copy), u15 (copy)
    local v19 = { ... };
    u1.Value = p18 or 0;
    local v20 = u15[tostring(p18)];
    if v20 == nil then
    else
        v20(v19);
    end;
end);
u1.Changed:connect(function() --[[ Line: 114 ]]
    -- upvalues: u17 (copy)
    u17();
end);