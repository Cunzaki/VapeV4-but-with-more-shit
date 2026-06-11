-- Decompiled from: StarterGui.FTHUD.Gamemodes.GamemodesContainer.GHOSTCTF.LOCAL_CTF_CONTROLLER.LOCAL_CTF_CONTROLLER
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local _ = game.Players.LocalPlayer;
local l__Parent__1 = script.Parent;
local l__GamemodeEvent__2 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage"):WaitForChild("Remotes"):WaitForChild("GamemodeEvent");
local u1 = {
    Red = { "Bright red", "Red" },
    Blue = { "Bright blue", "Blue" },
    None = { "Institutional white", "None" }
};
local function u10(p2) --[[ Line: 15 ]]
    if p2 == nil then
        return nil;
    end;
    local v3 = math.floor(p2 / 60);
    local v4;
    if v3 < 10 then
        local v5 = "0" .. tostring(v3);
        v4 = tostring(v5);
        if v4 then
            local v6 = 0;
            while true do
                if v6 == 0 then
                    v6 = -1;
                    local v7 = p2 % 60;
                    local v8;
                    if v7 < 10 then
                        local v9 = "0" .. tostring(v7);
                        v8 = tostring(v9);
                        if v8 then
                            return tostring(v4) .. ":" .. tostring(v8);
                        end;
                    end;
                    v8 = tostring(v7);
                    goto l0;
                else
                    break;
                end;
            end;
        end;
    end;
    v4 = tostring(v3);
    goto l1;
end;
local l__Red__3 = l__Parent__1:WaitForChild("Red");
local l__Blue__4 = l__Parent__1:WaitForChild("Blue");
l__Parent__1:WaitForChild("Main");
l__GamemodeEvent__2.OnClientEvent:connect(function(p11, p12, p13) --[[ Line: 65 ]]
    -- upvalues: l__Parent__1 (copy), u1 (copy), u10 (copy), l__Red__3 (copy), l__Blue__4 (copy)
    if p11 == "ctf" then
        if p12 == "inf" then
            if tostring(p12):lower() == "msg" then
                warn(p13);
                if tostring(p13):lower() == "redflag_stolen" then
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").Text = tostring(" lost his flag");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").LayoutOrder = 2;
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").Text = tostring("");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").LayoutOrder = 3;
                    script:WaitForChild("Value").Value = game.HttpService:GenerateGUID();
                    return;
                end;
                if tostring(p13):lower() == "blueflag_stolen" then
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").Text = tostring(" lost his flag");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").LayoutOrder = 2;
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").Text = tostring("");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").LayoutOrder = 3;
                    script:WaitForChild("Value").Value = game.HttpService:GenerateGUID();
                    return;
                end;
                if tostring(p13):lower() == "blueflag_captured" then
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").Text = tostring(" has captured the enemy flag");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").LayoutOrder = 2;
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").Text = tostring("");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").LayoutOrder = 3;
                    script:WaitForChild("Value").Value = game.HttpService:GenerateGUID();
                    return;
                end;
                if tostring(p13):lower() == "redflag_captured" then
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").Text = tostring(" has captured the enemy flag");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").LayoutOrder = 2;
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").Text = tostring("");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").LayoutOrder = 3;
                    script:WaitForChild("Value").Value = game.HttpService:GenerateGUID();
                    return;
                end;
                if tostring(p13):lower() == "blueflag_died" then
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").Text = tostring("The ");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").LayoutOrder = 1;
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").Text = tostring(" carrier has lost the FLAG");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").LayoutOrder = 3;
                    script:WaitForChild("Value").Value = game.HttpService:GenerateGUID();
                    return;
                end;
                if tostring(p13):lower() == "redflag_died" then
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").Text = tostring("The ");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").LayoutOrder = 1;
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").Text = tostring(" carrier has lost the FLAG");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").LayoutOrder = 3;
                    script:WaitForChild("Value").Value = game.HttpService:GenerateGUID();
                    return;
                end;
                if tostring(p13):lower() == "redflag_respawn" then
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").Text = tostring("The ");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").LayoutOrder = 1;
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").Text = tostring(" flag has returned to base");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").LayoutOrder = 3;
                    script:WaitForChild("Value").Value = game.HttpService:GenerateGUID();
                    return;
                end;
                if tostring(p13):lower() == "blueflag_respawn" then
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").Text = tostring("The ");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Primary").LayoutOrder = 1;
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").Text = tostring(" flag has returned to base");
                    l__Parent__1:WaitForChild("Frame"):WaitForChild("Secondary").LayoutOrder = 3;
                    script:WaitForChild("Value").Value = game.HttpService:GenerateGUID();
                end;
            elseif tostring(p12):lower() == "info" then
                local l__Red__5 = p13.Red;
                local l__Blue__6 = p13.Blue;
                u1.Red = l__Red__5;
                u1.Blue = l__Blue__6;
                local v14 = l__Red__5[3];
                local v15 = l__Blue__6[3];
                local v16 = u10(p13.Time);
                l__Red__3.BackgroundColor3 = BrickColor.new(l__Red__5[1]).Color;
                l__Blue__4.BackgroundColor3 = BrickColor.new(l__Blue__6[1]).Color;
                l__Red__3:WaitForChild("Flags").Text = tostring(v14);
                l__Blue__4:WaitForChild("Flags").Text = tostring(v15);
                l__Parent__1:WaitForChild("Main"):WaitForChild("Time").Text = "[ " .. tostring(v16) .. " ]";
                l__Red__3:WaitForChild("Flag").Visible = p13.Red_flag == true;
                l__Red__3:WaitForChild("Missing").Visible = p13.Red_flag == false;
                l__Blue__4:WaitForChild("Flag").Visible = p13.Blue_flag == true;
                l__Blue__4:WaitForChild("Missing").Visible = p13.Blue_flag == false;
            end;
        end;
    end;
end);
script:WaitForChild("Value").Changed:connect(function() --[[ Line: 198 ]]
    -- upvalues: l__Parent__1 (copy)
    local l__Value__7 = script:WaitForChild("Value").Value;
    if l__Value__7 ~= "" then
        delay(6, function() --[[ Line: 204 ]]
            -- upvalues: l__Value__7 (copy), l__Parent__1 (ref)
            if script:WaitForChild("Value").Value == l__Value__7 then
                script:WaitForChild("Value").Value = "";
                for _, v17 in pairs(l__Parent__1:WaitForChild("Frame"):GetChildren()) do
                    if v17:IsA("TextLabel") then
                        v17.Text = "";
                    end;
                end;
            end;
        end);
    end;
end);
