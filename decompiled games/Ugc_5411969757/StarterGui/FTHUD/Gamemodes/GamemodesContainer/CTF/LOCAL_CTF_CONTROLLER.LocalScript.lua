-- Decompiled from: StarterGui.FTHUD.Gamemodes.GamemodesContainer.CTF.LOCAL_CTF_CONTROLLER
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
local l__FirstTo__9 = l__Main__7:WaitForChild("FirstTo");
local l__MaxTime__10 = l__Main__7:WaitForChild("MaxTime");
local l__Init__11 = l__Main__7:WaitForChild("Init");
local l__Ended__12 = l__Main__7:WaitForChild("Ended");
l__GamemodeEvent__2.OnClientEvent:connect(function(p1, p2, p3) --[[ Line: 55 ]]
    -- upvalues: l__FirstTo__9 (copy), l__MaxTime__10 (copy), l__Time__8 (copy), l__Red__5 (copy), l__Blue__6 (copy), l__Init__11 (copy), l__Ended__12 (copy), l__InitSound__3 (copy), l__TiempoSound__4 (copy)
    if p1 == "ctf" then
        if p2 == "inf" then
            local v4 = l__FirstTo__9;
            local _ = p3.lf == 0;
            v4.Visible = true;
            l__FirstTo__9.Text = p3.lf == 0 and "" or (p3.lf == 1 and "First to 1 flag" or "First to " .. tostring(p3.lf) .. " flags");
            local v5 = l__MaxTime__10;
            local _ = p3.lt == 0;
            v5.Visible = true;
            l__Time__8.Text = p3.t;
            if p3.lf == 0 then
                l__MaxTime__10.Text = "Limit Time " .. p3.lts;
            else
                l__MaxTime__10.Text = "or " .. p3.lts;
            end;
            l__Red__5.BackgroundTransparency = p3.rib == true and 0.125 or 1;
            l__Blue__6.BackgroundTransparency = p3.bib == true and 0.125 or 1;
            l__Red__5:WaitForChild("Flags").Text = p3._r;
            l__Blue__6:WaitForChild("Flags").Text = p3._b;
            l__Init__11.Visible = p3.st == 0;
            l__Ended__12.Visible = p3.st == 2;
        elseif p2 == "init" then
            l__InitSound__3:Play();
        else
            if p2 == "t" then
                l__TiempoSound__4:Play();
            end;
        end;
    end;
end);
