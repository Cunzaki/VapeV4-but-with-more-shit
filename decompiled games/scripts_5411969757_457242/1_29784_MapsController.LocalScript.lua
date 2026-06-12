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
local _ = table.insert;
local l__new__9 = Vector2.new;
local u1 = unpack;
local l__Maps__10 = l__GameInfo__7.Sizes.Maps;
local l__FrameBase__11 = script:WaitForChild("FrameBase");
local l__CurrentSearch__12 = script:WaitForChild("CurrentSearch");
local l__Value__13 = l__CurrentSearch__12.Value;
local l__MouseoverEffect__14 = l__ReplicatedStorage__2:WaitForChild("MouseoverEffect");
local u2 = false;
local u3 = nil;
while l__ScrollingFrame__8:FindFirstChild("DESTROY_THIS_WEA_OKAY", true) ~= nil do
    l__ScrollingFrame__8:FindFirstChild("DESTROY_THIS_WEA_OKAY", true).Parent:Destroy();
end;
local function u13() --[[ Line: 53 ]]
    -- upvalues: u2 (ref), l__GameInfo__7 (copy), l__FrameBase__11 (copy), l__new__9 (copy), l__Maps__10 (copy), u1 (copy), l__ScrollingFrame__8 (copy), l__MouseoverEffect__14 (copy), u3 (ref)
    if script:FindFirstChild("FramesCreated") == nil then
        u2 = true;
        local v4 = Instance.new("Folder");
        v4.Name = "FramesCreated";
        v4.Parent = script;
        for v5, v6 in pairs(l__GameInfo__7.Maps_info) do
            local u7 = l__FrameBase__11:clone();
            u7.ObjectImage.Image = v6.Image;
            u7.ObjectName.Text = v5;
            u7.ObjectImage.ImageRectSize = l__new__9(u1(l__Maps__10));
            u7.ObjectImage.ImageRectOffset = l__new__9((v6.Pos[1] - 1) * l__Maps__10[1], (v6.Pos[2] - 1) * l__Maps__10[2]);
            u7.ObjectExtra.Text = v6.Type;
            u7.Visible = true;
            u7.Name = v5;
            u7.Parent = l__ScrollingFrame__8;
            local v8 = l__GameInfo__7.ExtraText["Maps" .. "_" .. v5];
            if v8 ~= nil then
                l__MouseoverEffect__14:Fire("connect", u7, 1, v8);
            end;
            u7.MainButton.MouseButton1Down:connect(function() --[[ Line: 80 ]]
                -- upvalues: u3 (ref), u7 (copy)
                if u3 ~= nil then
                    local v9 = u3:FindFirstChild("Selected");
                    if v9 ~= nil then
                        v9:Destroy();
                    end;
                end;
                u3 = u7;
                script.Selected:clone().Parent = u7;
            end);
        end;
    else
        if u2 == false then
            u2 = true;
            for _, v10 in pairs(l__ScrollingFrame__8:GetChildren()) do
                if v10:IsA("Frame") and v10:FindFirstChild("MainButton") then
                    local u11 = v10:FindFirstChild("MainButton");
                    u11.MouseButton1Down:connect(function() --[[ Line: 102 ]]
                        -- upvalues: u3 (ref), u11 (copy)
                        if u3 ~= nil then
                            local v12 = u3:FindFirstChild("Selected");
                            if v12 ~= nil then
                                v12:Destroy();
                            end;
                        end;
                        u3 = u11.Parent;
                        script.Selected:clone().Parent = u11.Parent;
                    end);
                end;
            end;
        end;
    end;
end;
local function u15() --[[ Line: 141 ]]
    -- upvalues: l__LocalPlayer__1 (copy), l__Buttons__5 (copy), u13 (copy), l__CurrentSearch__12 (copy), l__Value__13 (ref), l__ScrollingFrame__8 (copy)
    if (l__LocalPlayer__1:FindFirstChild("isAdmin") and true or false) == true then
        l__Buttons__5.No_admin.Visible = false;
        l__Buttons__5.End.Visible = true;
        l__Buttons__5.Start.Visible = true;
    else
        l__Buttons__5.No_admin.Visible = true;
        l__Buttons__5.End.Visible = false;
        l__Buttons__5.Start.Visible = false;
    end;
    u13();
    if l__CurrentSearch__12.Value ~= l__Value__13:lower() then
        l__CurrentSearch__12.Value = l__Value__13:lower();
        for _, v14 in pairs(l__ScrollingFrame__8:GetChildren()) do
            if v14:IsA("Frame") then
                if v14.Name:lower():sub(1, l__Value__13:len()) == l__Value__13:lower() then
                    v14.Visible = true;
                else
                    v14.Visible = false;
                end;
            end;
        end;
    end;
end;
l__Buttons__5.Start.MouseButton1Down:connect(function() --[[ Line: 172 ]]
    -- upvalues: u3 (ref), l__Remotes__4 (copy)
    if u3 ~= nil then
        local v16 = u3:FindFirstChild("ObjectName");
        if v16 ~= nil then
            local l__Text__15 = v16.Text;
            l__Remotes__4:WaitForChild("Admin"):FireServer("start_map", l__Text__15);
        end;
    end;
end);
l__Buttons__5.End.MouseButton1Down:connect(function() --[[ Line: 182 ]]
    -- upvalues: l__Remotes__4 (copy)
    l__Remotes__4:WaitForChild("Admin"):FireServer("start_map", nil);
end);
l__Box__6:GetPropertyChangedSignal("Text"):connect(function() --[[ Line: 186 ]]
    -- upvalues: l__Value__13 (ref), l__Box__6 (copy), u15 (copy)
    l__Value__13 = l__Box__6.Text;
    u15();
end);
u15();