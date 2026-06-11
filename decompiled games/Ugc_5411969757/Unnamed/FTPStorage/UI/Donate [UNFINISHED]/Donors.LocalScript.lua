-- Decompiled from: .FTPStorage.UI.Donate [UNFINISHED].Donors
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local l__MarketplaceService__2 = game:GetService("MarketplaceService");
local l__Frame__3 = script.Parent:WaitForChild("MainFrame"):WaitForChild("ScrollFalso"):WaitForChild("Frame");
local l__Line1__4 = l__Frame__3:WaitForChild("Line1");
local l__Line2__5 = l__Frame__3:WaitForChild("Line2");
local v1 = {
    ["10"] = 1002893083,
    ["50"] = 1002893043,
    ["100"] = 1002892970,
    ["200"] = 1002892908,
    ["500"] = 1002892849,
    ["1000"] = 1002892813
};
for _, v2 in pairs(l__Line1__4:GetChildren()) do
    if v2:IsA("ImageButton") then
        local u3 = v1[v2.Name];
        if u3 ~= nil then
            v2.MouseButton1Down:connect(function() --[[ Line: 26 ]]
                -- upvalues: l__MarketplaceService__2 (copy), l__LocalPlayer__1 (copy), u3 (copy)
                l__MarketplaceService__2:PromptProductPurchase(l__LocalPlayer__1, u3);
            end);
        end;
    end;
end;
for _, v4 in pairs(l__Line2__5:GetChildren()) do
    if v4:IsA("ImageButton") then
        local u5 = v1[v4.Name];
        if u5 ~= nil then
            v4.MouseButton1Down:connect(function() --[[ Line: 37 ]]
                -- upvalues: l__MarketplaceService__2 (copy), l__LocalPlayer__1 (copy), u5 (copy)
                l__MarketplaceService__2:PromptProductPurchase(l__LocalPlayer__1, u5);
            end);
        end;
    end;
end;
local l____TopDonors__6 = game.Lighting:WaitForChild("__TopDonors");
local l__Toplabel__7 = script:WaitForChild("Toplabel");
local u6 = {};
local function u8() --[[ Line: 50 ]]
    -- upvalues: u6 (ref)
    for _, v7 in pairs(u6) do
        v7:Destroy();
    end;
    u6 = {};
end;
local function v14() --[[ Line: 57 ]]
    -- upvalues: l____TopDonors__6 (copy), u8 (copy), l__Toplabel__7 (copy), l__Frame__3 (copy), u6 (ref)
    local v9 = game.HttpService:JSONDecode(l____TopDonors__6.Value);
    u8();
    local v10 = 0;
    for _, v11 in pairs(v9) do
        v10 = v10 + 1;
        local v12 = l__Toplabel__7:clone();
        v12.LayoutOrder = 7 + v11[1];
        v12.Text = v11[1] .. " - " .. v11[2] .. " (Robux: " .. v11[3] .. ")";
        v12.Parent = l__Frame__3;
        table.insert(u6, #u6 + 1, v12);
    end;
    if v10 == 0 then
        local v13 = l__Toplabel__7:clone();
        v13.Parent = l__Frame__3;
        v13.LayoutOrder = 8;
        table.insert(u6, #u6 + 1, v13);
    end;
end;
v14();
while wait(5) do
    v14();
end;
