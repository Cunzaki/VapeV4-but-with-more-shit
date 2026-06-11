-- Decompiled from: .FTPStorage.UI.Skys.SkysController
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
local _ = table.insert;
local l__new__9 = Vector2.new;
local u1 = unpack;
local l__Skys__10 = l__GameInfo__7.Sizes.Skys;
local l__FrameBase__11 = script:WaitForChild("FrameBase");
local l__CurrentSearch__12 = script:WaitForChild("CurrentSearch");
local l__Value__13 = l__CurrentSearch__12.Value;
local u2 = nil;
local u3 = false;
while l__ScrollingFrame__8:FindFirstChild("DESTROY_THIS_WEA_OKAY", true) ~= nil do
    l__ScrollingFrame__8:FindFirstChild("DESTROY_THIS_WEA_OKAY", true).Parent:Destroy();
end;
local function u12() --[[ Line: 51 ]]
    -- upvalues: u3 (ref), l__GameInfo__7 (copy), l__FrameBase__11 (copy), l__new__9 (copy), l__Skys__10 (copy), u1 (copy), l__ScrollingFrame__8 (copy), u2 (ref)
    if script:FindFirstChild("FramesCreated") == nil then
        u3 = true;
        local v4 = Instance.new("Folder");
        v4.Name = "FramesCreated";
        v4.Parent = script;
        for v5, v6 in pairs(l__GameInfo__7.Skys_info) do
            local u7 = l__FrameBase__11:clone();
            u7.ObjectImage.Image = v6.Image;
            u7.ObjectName.Text = v5;
            u7.ObjectImage.ImageRectSize = l__new__9(u1(l__Skys__10));
            u7.ObjectImage.ImageRectOffset = l__new__9((v6.Pos[1] - 1) * l__Skys__10[1], (v6.Pos[2] - 1) * l__Skys__10[2]);
            u7.ObjectExtra.Text = v6.Type;
            u7.Visible = true;
            u7.Name = v5;
            u7.Parent = l__ScrollingFrame__8;
            u7.MainButton.MouseButton1Down:connect(function() --[[ Line: 72 ]]
                -- upvalues: u2 (ref), u7 (copy)
                if u2 ~= nil then
                    local v8 = u2:FindFirstChild("Selected");
                    if v8 ~= nil then
                        v8:Destroy();
                    end;
                end;
                u2 = u7;
                script.Selected:clone().Parent = u7;
            end);
        end;
    else
        if u3 == false then
            u3 = true;
            for _, v9 in pairs(l__ScrollingFrame__8:GetChildren()) do
                if v9:IsA("Frame") and v9:FindFirstChild("MainButton") then
                    local u10 = v9:FindFirstChild("MainButton");
                    u10.MouseButton1Down:connect(function() --[[ Line: 92 ]]
                        -- upvalues: u2 (ref), u10 (copy)
                        if u2 ~= nil then
                            local v11 = u2:FindFirstChild("Selected");
                            if v11 ~= nil then
                                v11:Destroy();
                            end;
                        end;
                        u2 = u10.Parent;
                        script.Selected:clone().Parent = u10.Parent;
                    end);
                end;
            end;
        end;
    end;
end;
local function u14() --[[ Line: 129 ]]
    -- upvalues: l__LocalPlayer__1 (copy), l__Buttons__5 (copy), u12 (copy), l__CurrentSearch__12 (copy), l__Value__13 (ref), l__ScrollingFrame__8 (copy)
    if (l__LocalPlayer__1:FindFirstChild("isAdmin") and true or false) == true then
        l__Buttons__5.No_admin.Visible = false;
        l__Buttons__5.End.Visible = true;
        l__Buttons__5.Start.Visible = true;
    else
        l__Buttons__5.No_admin.Visible = true;
        l__Buttons__5.End.Visible = false;
        l__Buttons__5.Start.Visible = false;
    end;
    u12();
    if l__CurrentSearch__12.Value ~= l__Value__13:lower() then
        l__CurrentSearch__12.Value = l__Value__13:lower();
        for _, v13 in pairs(l__ScrollingFrame__8:GetChildren()) do
            if v13:IsA("Frame") then
                if v13.Name:lower():sub(1, l__Value__13:len()) == l__Value__13:lower() then
                    v13.Visible = true;
                else
                    v13.Visible = false;
                end;
            end;
        end;
    end;
end;
l__Buttons__5.Start.MouseButton1Down:connect(function() --[[ Line: 160 ]]
    -- upvalues: u2 (ref), l__Remotes__4 (copy)
    if u2 ~= nil then
        local v15 = u2:FindFirstChild("ObjectName");
        if v15 ~= nil then
            local l__Text__14 = v15.Text;
            l__Remotes__4:WaitForChild("Admin"):FireServer("set_skybox", l__Text__14);
        end;
    end;
end);
l__Buttons__5.End.MouseButton1Down:connect(function() --[[ Line: 170 ]]
    -- upvalues: l__Remotes__4 (copy)
    l__Remotes__4:WaitForChild("Admin"):FireServer("set_skybox", nil);
end);
l__Box__6:GetPropertyChangedSignal("Text"):connect(function() --[[ Line: 174 ]]
    -- upvalues: l__Value__13 (ref), l__Box__6 (copy), u14 (copy)
    l__Value__13 = l__Box__6.Text;
    u14();
end);
u14();
