-- Decompiled with Potassium's decompiler.

local l__GamemodeEvent__1 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage"):WaitForChild("Remotes"):WaitForChild("GamemodeEvent");
local l__Parent__2 = script.Parent;
local l__Blue__3 = l__Parent__2:WaitForChild("Blue");
local l__Kills__4 = l__Blue__3:WaitForChild("Kills");
local l__Accuracy__5 = l__Blue__3:WaitForChild("Accuracy");
local l__Red__6 = l__Parent__2:WaitForChild("Red");
local l__Kills__7 = l__Red__6:WaitForChild("Kills");
local l__Accuracy__8 = l__Red__6:WaitForChild("Accuracy");
local l__Main__9 = l__Parent__2:WaitForChild("Main");
l__Main__9:WaitForChild("Time");
l__Main__9:WaitForChild("Init");
local l__new__10 = BrickColor.new;
local u1 = nil;
local u2 = nil;
l__GamemodeEvent__1.OnClientEvent:connect(function(p3, p4) --[[ Line: 29 ]]
    -- upvalues: u1 (ref), l__Red__6 (copy), l__new__10 (copy), u2 (ref), l__Blue__3 (copy), l__Accuracy__5 (copy), l__Accuracy__8 (copy), l__Kills__7 (copy), l__Kills__4 (copy)
    if p3 == "1v1" then
        if p4 == nil then
        else
            local _ = p4.Init;
            local l__Red_name__11 = p4.Red_name;
            local l__Blue_name__12 = p4.Blue_name;
            if u1 == nil or u1 ~= l__Red_name__11 then
                u1 = l__Red_name__11;
                l__Red__6.BackgroundColor3 = l__new__10(l__Red_name__11).Color;
            end;
            if u2 == nil or u2 ~= l__Blue_name__12 then
                u2 = l__Blue_name__12;
                l__Blue__3.BackgroundColor3 = l__new__10(l__Blue_name__12).Color;
            end;
            l__Accuracy__5.Text = p4.Blue_acc .. "%";
            l__Accuracy__8.Text = p4.Red_acc .. "%";
            l__Kills__7.Text = tostring(p4.Red_kills);
            l__Kills__4.Text = tostring(p4.Blue_kills);
        end;
    end;
end);