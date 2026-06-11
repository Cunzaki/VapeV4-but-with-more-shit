-- Decompiled from: .FTPStorage.UI.Lobbys.LobbysController
-- Class: LocalScript
-- Place: Ugc (5411969757)

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
local l__new__11 = Vector2.new;
local u1 = unpack;
local v2 = l__ReplicatedStorage__2:FindFirstChild("LobbysOrder") or Instance.new("StringValue");
v2.Name = "LobbysOrder";
local u3 = l__GameInfo__8.Sizes.Lobbys or { 1, 1 };
local u4 = nil;
local u5;
if v2.Value == "" then
    local v6 = {};
    for v7, _ in pairs(l__GameInfo__8.Lobbys_info) do
        l__insert__10(v6, #v6 + 1, v7);
    end;
    u5 = l__ExtraFunctions__7:OrdenarAlfabeticamente(v6);
    v2.Value = l__HttpService__3:JSONEncode(u5);
    v2.Parent = l__ReplicatedStorage__2;
else
    u5 = l__HttpService__3:JSONDecode(v2.Value);
end;
local function u9() --[[ Line: 50 ]]
    -- upvalues: l__ScrollingFrame__9 (copy)
    for _, v8 in pairs(l__ScrollingFrame__9:GetChildren()) do
        if v8:IsA("Frame") then
            v8:Destroy();
        end;
    end;
end;
local function v18() --[[ Line: 73 ]]
    -- upvalues: u9 (copy), l__LocalPlayer__1 (copy), l__Buttons__6 (copy), u5 (ref), l__GameInfo__8 (copy), l__ScrollingFrame__9 (copy), l__new__11 (copy), u3 (copy), u1 (copy), u4 (ref)
    u9();
    if (l__LocalPlayer__1:FindFirstChild("isAdmin") and true or false) == true then
        l__Buttons__6.No_admin.Visible = false;
        l__Buttons__6.End.Visible = true;
        l__Buttons__6.Start.Visible = true;
    else
        l__Buttons__6.No_admin.Visible = true;
        l__Buttons__6.End.Visible = false;
        l__Buttons__6.Start.Visible = false;
    end;
    local v10 = 0;
    local v11 = nil;
    local v12 = 0;
    for _, v13 in pairs(u5) do
        local v14 = l__GameInfo__8.Lobbys_info[v13];
        if v14 ~= nil then
            v10 = v10 + 1;
            if v11 == nil or v10 > 3 then
                v12 = v12 + 1;
                v11 = script:WaitForChild("FrameBase"):clone();
                v11.Parent = l__ScrollingFrame__9;
                v11.LayoutOrder = v12;
                v10 = 1;
            end;
            local u15 = v11:WaitForChild((tostring(v10)));
            u15.ObjectImage.Image = v14.Image;
            u15.ObjectName.Text = v13;
            u15.ObjectImage.ImageRectSize = l__new__11(u1(u3));
            u15.ObjectImage.ImageRectOffset = l__new__11((v14.Pos[1] - 1) * u3[1], (v14.Pos[2] - 1) * u3[2]);
            u15.ObjectExtra.Text = v14.Type;
            u15.Visible = true;
            u15.MainButton.MouseButton1Down:connect(function() --[[ Line: 107 ]]
                -- upvalues: u4 (ref), u15 (copy)
                if u4 ~= nil then
                    local v16 = u4:FindFirstChild("Selected");
                    if v16 ~= nil then
                        v16:Destroy();
                    end;
                end;
                u4 = u15;
                script.Selected:clone().Parent = u15;
            end);
        end;
    end;
    local v17 = l__ScrollingFrame__9:FindFirstChildOfClass("UIListLayout");
    if v17 ~= nil then
        l__ScrollingFrame__9.CanvasSize = UDim2.new(0, 0, 0, v17.AbsoluteContentSize.Y);
    end;
end;
l__Buttons__6.Start.MouseButton1Down:connect(function() --[[ Line: 131 ]]
    -- upvalues: u4 (ref), l__Remotes__5 (copy)
    if u4 ~= nil then
        local v19 = u4:FindFirstChild("ObjectName");
        if v19 ~= nil then
            local l__Text__12 = v19.Text;
            l__Remotes__5:WaitForChild("Admin"):FireServer("start_lobby", l__Text__12);
        end;
    end;
end);
l__Buttons__6.End.MouseButton1Down:connect(function() --[[ Line: 141 ]]
    -- upvalues: l__Remotes__5 (copy)
    l__Remotes__5:WaitForChild("Admin"):FireServer("start_lobby", nil);
end);
v18();
