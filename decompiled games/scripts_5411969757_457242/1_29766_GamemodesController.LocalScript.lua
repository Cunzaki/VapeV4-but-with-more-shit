-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__HttpService__3 = game:GetService("HttpService");
local l__FTPStorage__4 = l__ReplicatedStorage__2:WaitForChild("FTPStorage");
local l__Remotes__5 = l__FTPStorage__4:WaitForChild("Remotes");
local l__Buttons__6 = script.Parent:WaitForChild("Buttons");
local l__ExtraFunctions__7 = require(l__FTPStorage__4:WaitForChild("ExtraFunctions"));
local l__GameInfo__8 = require(l__FTPStorage__4:WaitForChild("GameInfo"));
local l__ScrollingFrame__9 = script.Parent:WaitForChild("ScrollingFrame");
local l__insert__10 = table.insert;
local _ = Vector2.new;
local _ = unpack;
local v1 = l__ReplicatedStorage__2:FindFirstChild("GamemodesOrder") or Instance.new("StringValue");
v1.Name = "GamemodesOrder";
local _ = l__GameInfo__8.Sizes.Gamemodes;
local u2 = nil;
local u3;
if v1.Value == "" then
    local v4 = {};
    for v5, _ in pairs(l__GameInfo__8.Gamemodes_info) do
        l__insert__10(v4, #v4 + 1, v5);
    end;
    u3 = l__ExtraFunctions__7:OrdenarAlfabeticamente(v4);
    v1.Value = l__HttpService__3:JSONEncode(u3);
    v1.Parent = l__ReplicatedStorage__2;
else
    u3 = l__HttpService__3:JSONDecode(v1.Value);
end;
local function u7() --[[ Line: 50 ]]
    -- upvalues: l__ScrollingFrame__9 (copy)
    for _, v6 in pairs(l__ScrollingFrame__9:GetChildren()) do
        if v6:IsA("Frame") then
            v6:Destroy();
        end;
    end;
end;
local u8 = "";
local function v17() --[[ Line: 75 ]]
    -- upvalues: u7 (copy), l__LocalPlayer__1 (copy), l__Buttons__6 (copy), u3 (ref), l__GameInfo__8 (copy), l__ScrollingFrame__9 (copy), u8 (ref), u2 (ref)
    u7();
    if (l__LocalPlayer__1:FindFirstChild("isAdmin") and true or false) == true then
        l__Buttons__6.No_admin.Visible = false;
        l__Buttons__6.End.Visible = true;
        l__Buttons__6.Start.Visible = true;
    else
        l__Buttons__6.No_admin.Visible = true;
        l__Buttons__6.End.Visible = false;
        l__Buttons__6.Start.Visible = false;
    end;
    local v9 = 0;
    local v10 = nil;
    local v11 = 0;
    for _, v12 in pairs(u3) do
        local u13 = l__GameInfo__8.Gamemodes_info[v12];
        if u13 ~= nil then
            v9 = v9 + 1;
            if v10 == nil or v9 > 3 then
                v11 = v11 + 1;
                v10 = script:WaitForChild("FrameBase"):clone();
                v10.Parent = l__ScrollingFrame__9;
                v10.LayoutOrder = v11;
                v9 = 1;
            end;
            local u14 = v10:WaitForChild((tostring(v9)));
            u14.Visible = true;
            u14.ObjectName.Text = v12;
            u14.MainButton.MouseButton1Down:connect(function() --[[ Line: 105 ]]
                -- upvalues: u8 (ref), u13 (copy), u2 (ref), u14 (copy)
                u8 = u13[1];
                if u2 ~= nil then
                    local v15 = u2:FindFirstChild("Selected");
                    if v15 ~= nil then
                        v15:Destroy();
                    end;
                end;
                u2 = u14;
                script.Selected:clone().Parent = u14;
            end);
        end;
    end;
    local v16 = l__ScrollingFrame__9:FindFirstChildOfClass("UIListLayout");
    if v16 ~= nil then
        l__ScrollingFrame__9.CanvasSize = UDim2.new(0, 0, 0, v16.AbsoluteContentSize.Y);
    end;
end;
l__Buttons__6.Start.MouseButton1Down:connect(function() --[[ Line: 151 ]]
    -- upvalues: u2 (ref), l__Remotes__5 (copy), u8 (ref)
    if u2 ~= nil then
        local v18 = u2:FindFirstChild("ObjectName");
        if v18 ~= nil then
            local _ = v18.Text;
            l__Remotes__5:WaitForChild("Admin"):FireServer("start_gamemode", u8);
        end;
    end;
end);
l__Buttons__6.End.MouseButton1Down:connect(function() --[[ Line: 161 ]]
    -- upvalues: l__Remotes__5 (copy)
    l__Remotes__5:WaitForChild("Admin"):FireServer("start_gamemode", "none");
end);
v17();