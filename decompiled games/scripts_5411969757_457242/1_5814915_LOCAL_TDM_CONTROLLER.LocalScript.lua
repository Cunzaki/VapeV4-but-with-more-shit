-- Decompiled with Potassium's decompiler.

local l__GamemodeEvent__1 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage"):WaitForChild("Remotes"):WaitForChild("GamemodeEvent");
local l__Parent__2 = script.Parent;
local l__Blue__3 = l__Parent__2:WaitForChild("Blue");
local l__Kills__4 = l__Blue__3:WaitForChild("Kills");
local l__Red__5 = l__Parent__2:WaitForChild("Red");
local l__Kills__6 = l__Red__5:WaitForChild("Kills");
local l__Main__7 = l__Parent__2:WaitForChild("Main");
l__Main__7:WaitForChild("Time");
local l__FirstTo__8 = l__Main__7:WaitForChild("FirstTo");
local l__Init__9 = l__Main__7:WaitForChild("Init");
local l__Ended__10 = l__Main__7:WaitForChild("Ended");
local l__MaxTime__11 = l__Main__7:WaitForChild("MaxTime");
local l__Time__12 = l__Main__7:WaitForChild("Time");
local _ = UDim2.new;
local l__new__13 = BrickColor.new;
local u1 = nil;
local u2 = nil;
l__GamemodeEvent__1.OnClientEvent:connect(function(p3, p4) --[[ Line: 28 ]]
    -- upvalues: u1 (ref), l__Red__5 (copy), l__new__13 (copy), u2 (ref), l__Blue__3 (copy), l__Kills__6 (copy), l__Kills__4 (copy), l__Init__9 (copy), l__Ended__10 (copy), l__FirstTo__8 (copy), l__MaxTime__11 (copy), l__Time__12 (copy)
    if p3 == "tdm" then
        if p4 == nil then
        else
            local l__Started__14 = p4.Started;
            local l__Time__15 = p4.Time;
            local l__MaxTime__16 = p4.MaxTime;
            local l__Blue_score__17 = p4.Scores.Blue_score;
            local l__Red_score__18 = p4.Scores.Red_score;
            local l__Red__19 = p4.Teams.Red;
            local l__Blue__20 = p4.Teams.Blue;
            local l__Kills__21 = p4.Settings.Kills;
            local l__Ended__22 = p4.Ended;
            if u1 == nil or u1 ~= l__Red__19 then
                u1 = l__Red__19;
                l__Red__5.BackgroundColor3 = l__new__13(l__Red__19).Color;
            end;
            if u2 == nil or u2 ~= l__Blue__20 then
                u2 = l__Blue__20;
                l__Blue__3.BackgroundColor3 = l__new__13(l__Blue__20).Color;
            end;
            l__Kills__6.Text = tostring(l__Red_score__18);
            l__Kills__4.Text = tostring(l__Blue_score__17);
            l__Init__9.Visible = not l__Started__14;
            l__Ended__10.Visible = l__Ended__22;
            if l__Kills__21 == 0 then
                l__FirstTo__8.Visible = false;
            else
                l__FirstTo__8.Visible = true;
                l__FirstTo__8.Text = "First to " .. tostring(l__Kills__21);
            end;
            l__MaxTime__11.Visible = l__MaxTime__16 ~= "00:00";
            if l__Kills__21 == 0 then
                l__MaxTime__11.Text = "First to [" .. l__MaxTime__16 .. "]";
            else
                l__MaxTime__11.Text = "or [" .. l__MaxTime__16 .. "]";
            end;
            l__Time__12.Text = "[ " .. l__Time__15 .. " ]";
        end;
    end;
end);