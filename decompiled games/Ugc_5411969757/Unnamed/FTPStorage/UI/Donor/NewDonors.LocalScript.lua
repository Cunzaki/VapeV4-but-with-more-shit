-- Decompiled from: .FTPStorage.UI.Donor.NewDonors
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local _ = game:GetService("Players").LocalPlayer;
local l__HttpService__1 = game:GetService("HttpService");
local l__Donors__2 = game:GetService("ReplicatedStorage"):WaitForChild("Donors");
local l__Donor__3 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage"):WaitForChild("Remotes"):WaitForChild("Donor");
local l__ScrollingFrame__4 = script.Parent:WaitForChild("ScrollingFrame");
local l__Buttons1__5 = l__ScrollingFrame__4:WaitForChild("Buttons1");
local l__Buttons2__6 = l__ScrollingFrame__4:WaitForChild("Buttons2");
local l__Raised__7 = l__ScrollingFrame__4:WaitForChild("Raised");
l__ScrollingFrame__4:WaitForChild("TopDonors");
l__ScrollingFrame__4:WaitForChild("LastdonorFrame");
local l__All__8 = l__ScrollingFrame__4:WaitForChild("TopDonors"):WaitForChild("All");
local l__Month__9 = l__ScrollingFrame__4:WaitForChild("TopDonors"):WaitForChild("Month");
local l__DonorLabel__10 = script:WaitForChild("DonorLabel");
local function u3(p1) --[[ Line: 34 ]]
    if p1 == nil then
    else
        for _, v2 in pairs(p1:GetChildren()) do
            if v2:IsA("TextLabel") and v2.Name == "Top" then
                v2:Destroy();
            end;
        end;
    end;
end;
(function() --[[ Name: Actualizar, Line 43 ]]
    -- upvalues: l__Donors__2 (copy), l__HttpService__1 (copy), u3 (copy), l__All__8 (copy), l__Month__9 (copy), l__Raised__7 (copy), l__DonorLabel__10 (copy)
    local v4 = l__HttpService__1:JSONDecode(l__Donors__2:WaitForChild("TopDonors").Value);
    local v5 = l__HttpService__1:JSONDecode(l__Donors__2:WaitForChild("MonthDonors").Value);
    u3(l__All__8);
    u3(l__Month__9);
    l__Raised__7:WaitForChild("TotalRaised").Text = "All time raised: " .. l__Donors__2:WaitForChild("TopValue").Value .. " R$";
    l__Raised__7:WaitForChild("TotalRaised"):GetChildren()[1].Text = l__Raised__7:WaitForChild("TotalRaised").Text;
    l__Raised__7:WaitForChild("MonthRaised").Text = "Raised this month: " .. l__Donors__2:WaitForChild("MonthValue").Value .. " R$";
    l__Raised__7:WaitForChild("MonthRaised"):GetChildren()[1].Text = l__Raised__7:WaitForChild("MonthRaised").Text;
    local v6 = 0;
    local v7 = 0;
    for _, v8 in pairs(v4) do
        local v9 = l__DonorLabel__10:clone();
        v9.Text = v8[1] .. " - " .. v8[2] .. " (" .. v8[3] .. " R$)";
        v9:GetChildren()[1].Text = v9.Text;
        v9.LayoutOrder = 1 + v8[1];
        v9.Name = "Top";
        v9.Parent = l__All__8;
        if v8[1] == 1 then
            v9.TextColor3 = Color3.fromRGB(255, 209, 99);
        end;
        if v8[1] > 10 then
            v9.Font = Enum.Font.SourceSans;
            v9:GetChildren()[1].Font = v9.Font;
        end;
        v6 = v6 + 1;
    end;
    for _, v10 in pairs(v5) do
        local v11 = l__DonorLabel__10:clone();
        v11.Text = v10[1] .. " - " .. v10[2] .. " (" .. v10[3] .. " R$)";
        v11:GetChildren()[1].Text = v11.Text;
        v11.LayoutOrder = 1 + v10[1];
        v11.Name = "Top";
        v11.Parent = l__Month__9;
        if v10[1] == 1 then
            v11.TextColor3 = Color3.fromRGB(255, 209, 99);
        end;
        if v10[1] > 10 then
            v11.Font = Enum.Font.SourceSans;
            v11:GetChildren()[1].Font = v11.Font;
        end;
        v7 = v7 + 1;
    end;
    if v6 == 0 then
        local v12 = l__DonorLabel__10:clone();
        v12.Name = "Top";
        v12.Parent = l__All__8;
        v12.Text = ":(";
        v12:GetChildren()[1].Text = v12.Text;
        v12.LayoutOrder = 10;
    end;
    if v7 == 0 then
        local v13 = l__DonorLabel__10:clone();
        v13.Name = "Top";
        v13.Parent = l__Month__9;
        v13.Text = ":(";
        v13:GetChildren()[1].Text = v13.Text;
        v13.LayoutOrder = 10;
    end;
end)();
local function v16(p14) --[[ Line: 24 ]]
    -- upvalues: l__Donor__3 (copy)
    if p14 == nil then
    else
        if p14:IsA("ImageButton") and tonumber(p14.Name) ~= nil then
            local u15 = tonumber(p14.Name);
            p14.MouseButton1Down:connect(function() --[[ Line: 28 ]]
                -- upvalues: l__Donor__3 (ref), u15 (copy)
                l__Donor__3:FireServer(u15);
            end);
        end;
    end;
end;
for _, v17 in pairs(l__Buttons1__5:GetChildren()) do
    v16(v17);
end;
for _, v18 in pairs(l__Buttons2__6:GetChildren()) do
    v16(v18);
end;
