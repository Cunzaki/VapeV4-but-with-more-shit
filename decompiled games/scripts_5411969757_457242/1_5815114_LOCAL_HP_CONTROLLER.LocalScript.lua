-- Decompiled with Potassium's decompiler.

local l__SoundService__1 = game:GetService("SoundService");
local l__GamemodeEvent__2 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage"):WaitForChild("Remotes"):WaitForChild("GamemodeEvent");
local l__Parent__3 = script.Parent;
local l__Blue__4 = l__Parent__3:WaitForChild("Blue");
local l__Progress__5 = l__Blue__4:WaitForChild("Progress");
local l__Frame__6 = l__Blue__4:WaitForChild("CaptureProgress"):WaitForChild("Frame");
local l__Red__7 = l__Parent__3:WaitForChild("Red");
local l__Progress__8 = l__Red__7:WaitForChild("Progress");
local l__Frame__9 = l__Red__7:WaitForChild("CaptureProgress"):WaitForChild("Frame");
local l__Main__10 = l__Parent__3:WaitForChild("Main");
local l__Time__11 = l__Main__10:WaitForChild("Time");
l__Main__10:WaitForChild("Contested");
local l__GroupName__12 = l__Red__7:WaitForChild("GroupInfo"):WaitForChild("GroupName");
local l__GroupName__13 = l__Blue__4:WaitForChild("GroupInfo"):WaitForChild("GroupName");
local l__Ended__14 = l__Main__10:WaitForChild("Ended");
local l__new__15 = UDim2.new;
local l__new__16 = BrickColor.new;
local l__TiempoSound__17 = script:WaitForChild("TiempoSound");
local l__MovedSound__18 = script:WaitForChild("MovedSound");
l__GamemodeEvent__2.OnClientEvent:connect(function(p1, p2, p3) --[[ Line: 33 ]]
    -- upvalues: l__Time__11 (copy), l__Blue__4 (copy), l__Progress__5 (copy), l__new__15 (copy), l__new__16 (copy), l__Red__7 (copy), l__Progress__8 (copy), l__GroupName__12 (copy), l__GroupName__13 (copy), l__Main__10 (copy), l__Ended__14 (copy), l__Frame__9 (copy), l__Frame__6 (copy), l__SoundService__1 (copy), l__TiempoSound__17 (copy), l__MovedSound__18 (copy)
    if p1 == "hp" then
        if p2 == "inf" then
            l__Time__11.Text = p3.t;
            l__Blue__4:WaitForChild("Timer").Text = p3._b;
            l__Progress__5:TweenSize(l__new__15(p3._b / p3.cmax, 0, 1, 0), "Out", "Quad", 0.25, true);
            l__Progress__5.BackgroundColor3 = l__new__16(p3.btn).Color;
            l__Red__7:WaitForChild("Timer").Text = p3._r;
            l__Progress__8:TweenSize(l__new__15(p3._r / p3.cmax, 0, 1, 0), "Out", "Quad", 0.25, true);
            l__Progress__8.BackgroundColor3 = l__new__16(p3.rtn).Color;
            l__GroupName__12.Text = p3.rName;
            l__GroupName__13.Text = p3.bName;
            l__Main__10:WaitForChild("Contested").Visible = p3.contest;
            l__Main__10:WaitForChild("Extra").Visible = p3.st == 0;
            l__Main__10:WaitForChild("FirstTo").Text = "First to " .. p3.cmax;
            l__Ended__14.Visible = p3.st == 2;
            if p3.ctmax == nil or p3.ctmax == 0 then
                l__Main__10:WaitForChild("MaxTime").Visible = false;
            else
                l__Main__10:WaitForChild("MaxTime").Visible = true;
                l__Main__10:WaitForChild("MaxTime").Text = "or [" .. tostring(p3.ctmax) .. "]";
            end;
            local v4 = p3.ct / 100;
            if v4 < 0 then
                l__Frame__9:TweenSize(l__new__15(-v4, 0, 1, 0), "Out", "Quad", 0.25, true);
                l__Frame__6.Size = l__new__15(0, 0, 1, 0);
            elseif v4 > 0 then
                l__Frame__6:TweenSize(l__new__15(v4, 0, 1, 0), "Out", "Quad", 0.25, true);
                l__Frame__9.Size = l__new__15(0, 0, 1, 0);
            else
                l__Frame__9.Size = l__new__15(0, 0, 1, 0);
                l__Frame__6.Size = l__new__15(0, 0, 1, 0);
            end;
        else
            if p2 == "sound" then
                if p3 == "cd" then
                    l__SoundService__1:PlayLocalSound(l__TiempoSound__17);
                    return;
                end;
                if p3 == "hm" then
                    l__SoundService__1:PlayLocalSound(l__MovedSound__18);
                end;
            end;
        end;
    end;
end);