-- Decompiled from: StarterGui.FTHUD.Gamemodes.GamemodesContainer.OLD V2 KOTH.LOCAL_KOTH_CONTROLLER
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__GamemodeEvent__1 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage"):WaitForChild("Remotes"):WaitForChild("GamemodeEvent");
local l__Parent__2 = script.Parent;
local l__Blue__3 = l__Parent__2:WaitForChild("Blue");
local l__TweenFrame__4 = l__Blue__3:WaitForChild("TweenContainer"):WaitForChild("TweenFrame");
local l__TweenFrame__5 = l__Blue__3:WaitForChild("CaptureTime"):WaitForChild("TweenFrame");
local l__Red__6 = l__Parent__2:WaitForChild("Red");
local l__TweenFrame__7 = l__Red__6:WaitForChild("TweenContainer"):WaitForChild("TweenFrame");
local l__TweenFrame__8 = l__Red__6:WaitForChild("CaptureTime"):WaitForChild("TweenFrame");
local l__Main__9 = l__Parent__2:WaitForChild("Main");
local l__Time__10 = l__Main__9:WaitForChild("Time");
l__Main__9:WaitForChild("Contested");
local l__new__11 = UDim2.new;
local l__new__12 = BrickColor.new;
l__GamemodeEvent__1.OnClientEvent:connect(function(p1, p2, p3) --[[ Line: 23 ]]
    -- upvalues: l__Time__10 (copy), l__Blue__3 (copy), l__TweenFrame__4 (copy), l__new__11 (copy), l__new__12 (copy), l__Red__6 (copy), l__TweenFrame__7 (copy), l__Main__9 (copy), l__TweenFrame__8 (copy), l__TweenFrame__5 (copy)
    if p1 == "koth" then
        if p2 == "inf" then
            l__Time__10.Text = p3.t;
            l__Blue__3:WaitForChild("CurrentGoal").Text = p3._b;
            l__TweenFrame__4:TweenSize(l__new__11(p3._b / p3.cmax, 0, 1, 0), "Out", "Quad", 0.1, true);
            l__TweenFrame__4.BackgroundColor3 = l__new__12(p3.btn).Color;
            l__Red__6:WaitForChild("CurrentGoal").Text = p3._r;
            l__TweenFrame__7:TweenSize(l__new__11(p3._r / p3.cmax, 0, 1, 0), "Out", "Quad", 0.1, true);
            l__TweenFrame__7.BackgroundColor3 = l__new__12(p3.rtn).Color;
            l__Main__9:WaitForChild("Contested").Visible = p3.contest;
            l__Main__9:WaitForChild("Extra").Visible = p3.st == 0;
            l__Main__9:WaitForChild("FirstTo").Text = "First to " .. p3.cmax_;
            if p3.ctmax == nil then
                l__Main__9:WaitForChild("MaxTime").Visible = false;
            else
                l__Main__9:WaitForChild("MaxTime").Visible = true;
                l__Main__9:WaitForChild("MaxTime").Text = tostring(p3.ctmax);
            end;
            local v4 = p3.ct / 100;
            if v4 < 0 then
                l__TweenFrame__8:TweenSize(l__new__11(-v4, 0, 1, 0), "Out", "Quad", 0.1, true);
                l__TweenFrame__5.Size = l__new__11(0, 0, 1, 0);
                return;
            end;
            if v4 > 0 then
                l__TweenFrame__5:TweenSize(l__new__11(v4, 0, 1, 0), "Out", "Quad", 0.1, true);
                l__TweenFrame__8.Size = l__new__11(0, 0, 1, 0);
                return;
            end;
            l__TweenFrame__8.Size = l__new__11(0, 0, 1, 0);
            l__TweenFrame__5.Size = l__new__11(0, 0, 1, 0);
        end;
    end;
end);
