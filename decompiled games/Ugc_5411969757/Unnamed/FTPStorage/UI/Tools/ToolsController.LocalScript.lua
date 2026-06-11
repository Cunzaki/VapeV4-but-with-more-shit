-- Decompiled from: .FTPStorage.UI.Tools.ToolsController
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("HttpService");
local l__FTPStorage__3 = l__ReplicatedStorage__2:WaitForChild("FTPStorage");
local l__Remotes__4 = l__FTPStorage__3:WaitForChild("Remotes");
local l__Buttons__5 = script.Parent:WaitForChild("Buttons");
local l__Box__6 = l__Buttons__5:WaitForChild("Search"):WaitForChild("Box");
require(l__FTPStorage__3:WaitForChild("ExtraFunctions"));
local l__GameInfo__7 = require(l__FTPStorage__3:WaitForChild("GameInfo"));
local l__ScrollingFrame__8 = script.Parent:WaitForChild("ScrollingFrame");
local l__insert__9 = table.insert;
local l__new__10 = Vector2.new;
local u1 = unpack;
local l__Tools__11 = l__GameInfo__7.Sizes.Tools;
local l__FrameBase__12 = script:WaitForChild("FrameBase");
local l__CurrentSearch__13 = script:WaitForChild("CurrentSearch");
local l__Value__14 = l__CurrentSearch__13.Value;
local l__MouseoverEffect__15 = l__ReplicatedStorage__2:WaitForChild("MouseoverEffect");
local u2 = {};
local u3 = nil;
local u4 = false;
while l__ScrollingFrame__8:FindFirstChild("DESTROY_THIS_WEA_OKAY", true) ~= nil do
    l__ScrollingFrame__8:FindFirstChild("DESTROY_THIS_WEA_OKAY", true).Parent:Destroy();
end;
local function u14() --[[ Line: 52 ]]
    -- upvalues: u4 (ref), l__GameInfo__7 (copy), l__FrameBase__12 (copy), l__new__10 (copy), l__Tools__11 (copy), u1 (copy), l__ScrollingFrame__8 (copy), l__MouseoverEffect__15 (copy), u2 (copy), u3 (ref), l__insert__9 (copy)
    if script:FindFirstChild("FramesCreated") == nil then
        u4 = true;
        local v5 = Instance.new("Folder");
        v5.Name = "FramesCreated";
        v5.Parent = script;
        for v6, v7 in pairs(l__GameInfo__7.Tools_info) do
            local u8 = l__FrameBase__12:clone();
            u8.ObjectImage.Image = v7.Image;
            u8.ObjectName.Text = v6;
            u8.ObjectImage.ImageRectSize = l__new__10(u1(l__Tools__11));
            u8.ObjectImage.ImageRectOffset = l__new__10((v7.Pos[1] - 1) * l__Tools__11[1], (v7.Pos[2] - 1) * l__Tools__11[2]);
            u8.ObjectExtra.Text = v7.Type;
            u8.Visible = true;
            u8.Name = v6;
            u8.Parent = l__ScrollingFrame__8;
            local v9 = l__GameInfo__7.ExtraText["Tools" .. "_" .. v6];
            if v9 ~= nil then
                l__MouseoverEffect__15:Fire("connect", u8, 1, v9);
            end;
            l__insert__9(u2, u8.MainButton.MouseButton1Down:connect(function() --[[ Line: 79 ]]
                -- upvalues: u3 (ref), u8 (copy)
                if u3 ~= nil then
                    local v10 = u3:FindFirstChild("Selected");
                    if v10 ~= nil then
                        v10:Destroy();
                    end;
                end;
                u3 = u8;
                script.Selected:clone().Parent = u8;
            end));
        end;
    else
        if u4 == false then
            u4 = true;
            for _, v11 in pairs(l__ScrollingFrame__8:GetChildren()) do
                if v11:IsA("Frame") and v11:FindFirstChild("MainButton") then
                    local u12 = v11:FindFirstChild("MainButton");
                    l__insert__9(u2, u12.MouseButton1Down:connect(function() --[[ Line: 98 ]]
                        -- upvalues: u3 (ref), u12 (copy)
                        if u3 ~= nil then
                            local v13 = u3:FindFirstChild("Selected");
                            if v13 ~= nil then
                                v13:Destroy();
                            end;
                        end;
                        u3 = u12.Parent;
                        script.Selected:clone().Parent = u12.Parent;
                    end));
                end;
            end;
        end;
    end;
end;
local function u17() --[[ Line: 135 ]]
    -- upvalues: l__LocalPlayer__1 (copy), l__Buttons__5 (copy), u14 (copy), l__CurrentSearch__13 (copy), l__Value__14 (ref), l__ScrollingFrame__8 (copy)
    if (l__LocalPlayer__1:FindFirstChild("isAdmin") and true or false) == true then
        l__Buttons__5.No_admin.Visible = false;
        l__Buttons__5.End.Visible = true;
        l__Buttons__5.Start.Visible = true;
    else
        l__Buttons__5.No_admin.Visible = true;
        l__Buttons__5.End.Visible = false;
        l__Buttons__5.Start.Visible = false;
    end;
    u14();
    if l__CurrentSearch__13.Value ~= l__Value__14:lower() then
        l__CurrentSearch__13.Value = l__Value__14:lower();
        if l__Value__14 == "" then
            for _, v15 in pairs(l__ScrollingFrame__8:GetChildren()) do
                if v15:IsA("Frame") then
                    v15.Visible = true;
                end;
            end;
            return;
        end;
        for _, v16 in pairs(l__ScrollingFrame__8:GetChildren()) do
            if v16:IsA("Frame") then
                if v16.Name:lower():sub(1, l__Value__14:len()) == l__Value__14:lower() then
                    v16.Visible = true;
                else
                    v16.Visible = false;
                end;
            end;
        end;
    end;
end;
l__Buttons__5.Start.MouseButton1Down:connect(function() --[[ Line: 166 ]]
    -- upvalues: u3 (ref), l__Remotes__4 (copy)
    if u3 ~= nil then
        local v18 = u3:FindFirstChild("ObjectName");
        if v18 ~= nil then
            local l__Text__16 = v18.Text;
            l__Remotes__4:WaitForChild("Admin"):FireServer("start_tool", l__Text__16);
        end;
    end;
end);
l__Buttons__5.End.MouseButton1Down:connect(function() --[[ Line: 176 ]]
    -- upvalues: l__Remotes__4 (copy)
    l__Remotes__4:WaitForChild("Admin"):FireServer("start_tool", nil);
end);
l__Box__6:GetPropertyChangedSignal("Text"):connect(function() --[[ Line: 180 ]]
    -- upvalues: l__Value__14 (ref), l__Box__6 (copy), u17 (copy)
    l__Value__14 = l__Box__6.Text;
    u17();
end);
u17();
