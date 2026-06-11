-- Decompiled from: .ChillArrow26.PlayerGui.FTHUD.Gamemodes.GamemodesContainer.GHOSTCTF.LOCAL_CTF_CONTROLLER
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local _ = game:GetService("Players").LocalPlayer;
local l__Parent__1 = script.Parent;
local l__GamemodeEvent__2 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage"):WaitForChild("Remotes"):WaitForChild("GamemodeEvent");
local l__InitSound__3 = script:WaitForChild("InitSound");
local l__TiempoSound__4 = script:WaitForChild("TiempoSound");
local l__Red__5 = l__Parent__1:WaitForChild("Red");
local l__Blue__6 = l__Parent__1:WaitForChild("Blue");
local l__Main__7 = l__Parent__1:WaitForChild("Main");
local l__Time__8 = l__Main__7:WaitForChild("Time");
local l__RoundEnd__9 = l__Main__7:WaitForChild("RoundEnd");
local l__Round__10 = l__Main__7:WaitForChild("Round");
local l__Init__11 = l__Main__7:WaitForChild("Init");
local l__Ended__12 = l__Main__7:WaitForChild("Ended");
local l__IntermissionEnd__13 = l__Main__7:WaitForChild("IntermissionEnd");
l__GamemodeEvent__2.OnClientEvent:connect(function(p1, p2, p3) --[[ Line: 56 ]]
    -- upvalues: l__Time__8 (copy), l__Red__5 (copy), l__Blue__6 (copy), l__Init__11 (copy), l__Ended__12 (copy), l__RoundEnd__9 (copy), l__IntermissionEnd__13 (copy), l__Round__10 (copy), l__InitSound__3 (copy), l__TiempoSound__4 (copy)
    if p1 == "gctf" then
        if p2 == "inf" then
            l__Time__8.Text = p3.t;
            l__Red__5.BackgroundTransparency = p3.rib == true and 0.125 or 1;
            l__Blue__6.BackgroundTransparency = p3.bib == true and 0.125 or 1;
            l__Red__5:WaitForChild("Flags").Text = p3._r;
            l__Blue__6:WaitForChild("Flags").Text = p3._b;
            l__Init__11.Visible = p3.st == 0;
            l__Ended__12.Visible = p3.st == 2;
            l__RoundEnd__9.Visible = p3.enb;
            l__IntermissionEnd__13.Visible = p3.enb2;
            l__RoundEnd__9.Text = "CURRENT ROUND ENDS IN " .. p3.rt;
            l__Round__10.Text = "[ ROUND " .. p3.cr .. " ]";
            l__IntermissionEnd__13.Text = "STARTING IN " .. p3.it;
        elseif p2 == "init" then
            l__InitSound__3:Play();
        else
            if p2 == "t" then
                l__TiempoSound__4:Play();
            end;
        end;
    end;
end);
