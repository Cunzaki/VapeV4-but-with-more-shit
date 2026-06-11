-- Decompiled from: StarterGui.FTHUD.Gamemodes.GamemodesContainer.KOTH.LOCAL_KOTH_CONTROLLER
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

game:GetService("SoundService");
local l__GamemodeEvent__1 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage"):WaitForChild("Remotes"):WaitForChild("GamemodeEvent");
local l__Parent__2 = script.Parent;
local l__Blue__3 = l__Parent__2:WaitForChild("Blue");
local l__Progress__4 = l__Blue__3:WaitForChild("Progress");
local l__Frame__5 = l__Blue__3:WaitForChild("CaptureProgress"):WaitForChild("Frame");
local l__Red__6 = l__Parent__2:WaitForChild("Red");
local l__Progress__7 = l__Red__6:WaitForChild("Progress");
local l__Frame__8 = l__Red__6:WaitForChild("CaptureProgress"):WaitForChild("Frame");
local l__Main__9 = l__Parent__2:WaitForChild("Main");
local l__Time__10 = l__Main__9:WaitForChild("Time");
l__Main__9:WaitForChild("Contested");
local l__GroupName__11 = l__Red__6:WaitForChild("GroupInfo"):WaitForChild("GroupName");
local l__GroupName__12 = l__Blue__3:WaitForChild("GroupInfo"):WaitForChild("GroupName");
local l__Ended__13 = l__Main__9:WaitForChild("Ended");
local l__new__14 = UDim2.new;
local l__new__15 = BrickColor.new;
l__GamemodeEvent__1.OnClientEvent:connect(function(p1, p2, p3) --[[ Line: 33 ]]
    -- upvalues: l__Time__10 (copy), l__Blue__3 (copy), l__Progress__4 (copy), l__new__14 (copy), l__new__15 (copy), l__Red__6 (copy), l__Progress__7 (copy), l__GroupName__11 (copy), l__GroupName__12 (copy), l__Main__9 (copy), l__Ended__13 (copy), l__Frame__8 (copy), l__Frame__5 (copy)
    if p1 == "koth" then
        if p2 == "inf" then
            l__Time__10.Text = p3.t;
            l__Blue__3:WaitForChild("Timer").Text = p3._b;
            l__Progress__4:TweenSize(l__new__14(p3._b / p3.cmax, 0, 1, 0), "Out", "Quad", 0.25, true);
            l__Progress__4.BackgroundColor3 = l__new__15(p3.btn).Color;
            l__Red__6:WaitForChild("Timer").Text = p3._r;
            l__Progress__7:TweenSize(l__new__14(p3._r / p3.cmax, 0, 1, 0), "Out", "Quad", 0.25, true);
            l__Progress__7.BackgroundColor3 = l__new__15(p3.rtn).Color;
            l__GroupName__11.Text = p3.rName;
            l__GroupName__12.Text = p3.bName;
            l__Main__9:WaitForChild("Contested").Visible = p3.contest;
            l__Main__9:WaitForChild("Extra").Visible = p3.st == 0;
            l__Main__9:WaitForChild("FirstTo").Text = "First to " .. p3.cmax;
            l__Ended__13.Visible = p3.st == 2;
            if p3.ctmax == nil or p3.ctmax == 0 then
                l__Main__9:WaitForChild("MaxTime").Visible = false;
            else
                l__Main__9:WaitForChild("MaxTime").Visible = true;
                l__Main__9:WaitForChild("MaxTime").Text = "or [" .. tostring(p3.ctmax) .. "]";
            end;
            local v4 = p3.ct / 100;
            if v4 < 0 then
                l__Frame__8:TweenSize(l__new__14(-v4, 0, 1, 0), "Out", "Quad", 0.25, true);
                l__Frame__5.Size = l__new__14(0, 0, 1, 0);
                return;
            end;
            if v4 > 0 then
                l__Frame__5:TweenSize(l__new__14(v4, 0, 1, 0), "Out", "Quad", 0.25, true);
                l__Frame__8.Size = l__new__14(0, 0, 1, 0);
                return;
            end;
            l__Frame__8.Size = l__new__14(0, 0, 1, 0);
            l__Frame__5.Size = l__new__14(0, 0, 1, 0);
        end;
    end;
end);
