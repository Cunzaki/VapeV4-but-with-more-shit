-- Decompiled from: .FTPStorage.UI.ServerSettings.MainController
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local u2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 1 ]]
        return game:GetService(p1);
    end
});
local l__TweenService__1 = u2.TweenService;
local l__LocalPlayer__2 = u2.Players.LocalPlayer;
l__LocalPlayer__2:WaitForChild("PlayerData");
local l__FTPStorage__3 = u2.ReplicatedStorage:WaitForChild("FTPStorage");
local l__Remotes__4 = l__FTPStorage__3:WaitForChild("Remotes");
local l__Numbers__5 = require(l__FTPStorage__3:WaitForChild("Numbers"));
local l__Admin__6 = l__Remotes__4:WaitForChild("Admin");
script.Parent:WaitForChild("ScrollingFrame"):WaitForChild("UIListLayout");
local u3 = {};
local l__ScrollingFrame__7 = script.Parent:WaitForChild("ScrollingFrame");
local l__UIListLayout__8 = l__ScrollingFrame__7:WaitForChild("UIListLayout");
local l__floor__9 = math.floor;
local l__insert__10 = table.insert;
local l__ServerData__11 = u2.ReplicatedStorage:WaitForChild("ServerData");
local l__ServerVisits__12 = u2.ReplicatedStorage:WaitForChild("ServerVisits");
local l__TotalTime__13 = u2.ReplicatedStorage:WaitForChild("TotalTime");
local l__ServerOwner__14 = u2.ReplicatedStorage:WaitForChild("ServerOwner");
local l__ServernameValue__15 = u2.ReplicatedStorage:WaitForChild("ServernameValue");
local l__ServericonValue__16 = u2.ReplicatedStorage:WaitForChild("ServericonValue");
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {
    ["0"] = { l__ScrollingFrame__7:WaitForChild("0_Title") },
    ["1"] = {
        l__ScrollingFrame__7:WaitForChild("1_Title"),
        l__ScrollingFrame__7:WaitForChild("1_OWNER"),
        l__ScrollingFrame__7:WaitForChild("1_VISITS"),
        l__ScrollingFrame__7:WaitForChild("1_TIME")
    },
    ["2"] = {
        l__ScrollingFrame__7:WaitForChild("2_Title"),
        l__ScrollingFrame__7:WaitForChild("2_SERVERNAME"),
        l__ScrollingFrame__7:WaitForChild("2_SERVERICON"),
        l__ScrollingFrame__7:WaitForChild("2_SERVERPRIVACY"),
        l__ScrollingFrame__7:WaitForChild("2_PUBLICPROFILEFOLLOW")
    },
    ["3"] = {
        l__ScrollingFrame__7:WaitForChild("3_Title"),
        l__ScrollingFrame__7:WaitForChild("3_OUTSCORE"),
        l__ScrollingFrame__7:WaitForChild("3_RESPAWNTIME"),
        l__ScrollingFrame__7:WaitForChild("3_FORCEFIELDTIME"),
        l__ScrollingFrame__7:WaitForChild("3_ESPTYPE"),
        l__ScrollingFrame__7:WaitForChild("3_KILLFEEDTYPE"),
        l__ScrollingFrame__7:WaitForChild("3_ADMINTYPE"),
        l__ScrollingFrame__7:WaitForChild("3_BUBBLECHAT"),
        l__ScrollingFrame__7:WaitForChild("3_AFTERLIFE"),
        l__ScrollingFrame__7:WaitForChild("3_CUSTOMCURSORS"),
        l__ScrollingFrame__7:WaitForChild("3_SECUREMODE"),
        l__ScrollingFrame__7:WaitForChild("3_LOBBYTOOLS"),
        l__ScrollingFrame__7:WaitForChild("3_HEALTHREGEN"),
        l__ScrollingFrame__7:WaitForChild("3_HATHITBOX"),
        l__ScrollingFrame__7:WaitForChild("3_BUBBLETHEME"),
        l__ScrollingFrame__7:WaitForChild("3_MEDIGUNS"),
        l__ScrollingFrame__7:WaitForChild("3_DISPLAYNAMES"),
        l__ScrollingFrame__7:WaitForChild("3_CUSTOMCHAT")
    },
    ["4"] = {
        l__ScrollingFrame__7:WaitForChild("4_Title"),
        l__ScrollingFrame__7:WaitForChild("5_SWORDFLOAT"),
        l__ScrollingFrame__7:WaitForChild("5_SWORDHEAL"),
        l__ScrollingFrame__7:WaitForChild("5_SWORDANTITIE"),
        l__ScrollingFrame__7:WaitForChild("5_SWORDMODEL")
    },
    ["6"] = { l__ScrollingFrame__7:WaitForChild("6_Title"), l__ScrollingFrame__7:WaitForChild("6_INFINITEAMMO"), l__ScrollingFrame__7:WaitForChild("6_AUTOTEAM") }
};
local u8 = Color3.fromRGB(0, 255, 0);
local u9 = Color3.fromRGB(255, 0, 0);
local u10 = TweenInfo.new(0.5);
local function u16(p11) --[[ Line: 104 ]]
    -- upvalues: l__floor__9 (copy)
    if typeof(p11) ~= "number" then
        return p11;
    end;
    local v12 = p11 % 60;
    local v13 = l__floor__9(p11 / 60);
    if v13 < 60 then
        if v12 < 10 then
            v12 = "0" .. tostring(v12);
        end;
        if v13 < 10 then
            v13 = "0" .. tostring(v13);
        end;
        return "00h " .. v13 .. "m" .. v12 .. "s";
    end;
    local v14 = l__floor__9(v13 / 60);
    local v15 = v13 % 60;
    if v12 < 10 then
        v12 = "0" .. tostring(v12);
    end;
    if v15 < 10 then
        v15 = "0" .. tostring(v15);
    end;
    if v14 < 10 then
        v14 = "0" .. tostring(v14);
    end;
    return v14 .. "h " .. v15 .. "m" .. v12 .. "s";
end;
local function u21(p17, p18) --[[ Line: 132 ]]
    -- upvalues: u7 (copy), l__ServerOwner__14 (copy), l__ServerVisits__12 (copy), u16 (copy), l__TotalTime__13 (copy)
    local v19 = p17 == nil and true or p17;
    local v20 = p18 == nil and true or p18;
    u7["0"][1].Visible = not v19;
    if v20 == true then
        u7["1"][2].Value.Text = l__ServerOwner__14.Value;
        u7["1"][3].Value.Text = l__ServerVisits__12.Value;
        u7["1"][4].Value.Text = u16(l__TotalTime__13.Value);
    end;
    u7["1"][2].Visible = v20;
    u7["1"][3].Visible = v20;
    u7["1"][4].Visible = v20;
end;
local function u27(p22, p23) --[[ Line: 150 ]]
    -- upvalues: u7 (copy), u6 (ref), l__ServernameValue__15 (copy), l__ServericonValue__16 (copy), l__Numbers__5 (copy), u5 (copy), u8 (copy), l__TweenService__1 (copy), u10 (copy), u9 (copy)
    local v24 = p22 == nil and true or p22;
    local v25 = p23 == nil and true or p23;
    u7["2"][2].Visible = v25;
    u7["2"][3].Visible = v25;
    u7["2"][4].Visible = v25;
    u7["2"][5].Visible = v25;
    if v25 == true then
        local v26 = u6.Settings.Privacy or 0;
        if v24 == true then
            u7["2"][2].ImageLabel.TextBox.TextEditable = true;
            u7["2"][3].ImageLabel.TextBox.TextEditable = true;
        end;
        u7["2"][2].ImageLabel.TextBox.Text = l__ServernameValue__15.Value;
        u7["2"][3].ImageLabel.TextBox.Text = l__ServericonValue__16.Value;
        u7["2"][4].Options.Center.TextLabel.Text = tostring(v26) .. ". " .. l__Numbers__5.privacy[tostring(v26)]:upper();
        u5.privacy = v26;
        u7["2"][4].Options.Derecha.Visible = v24;
        u7["2"][4].Options.Izquierda.Visible = v24;
        u7["2"][4].Options.Save.Visible = v24;
        local l__FollowJoin__17 = u6.Settings.FollowJoin;
        if l__FollowJoin__17 == true or l__FollowJoin__17 == nil then
            l__TweenService__1:Create(u7["2"][5].TEST.TEST, u10, {
                BackgroundColor3 = u8
            }):Play();
        else
            l__TweenService__1:Create(u7["2"][5].TEST.TEST, u10, {
                BackgroundColor3 = u9
            }):Play();
        end;
        u7["2"][5].TEST.TextLabel.Text = l__FollowJoin__17 == true and "ENABLED" or "DISABLED";
    end;
end;
local function u46(p28, p29) --[[ Line: 193 ]]
    -- upvalues: u7 (copy), u6 (ref), l__Numbers__5 (copy), u5 (copy), u8 (copy), l__TweenService__1 (copy), u10 (copy), u9 (copy)
    local v30 = p28 == nil and true or p28;
    local v31 = p29 == nil and true or p29;
    u7["3"][2].Visible = v31;
    u7["3"][3].Visible = v31;
    u7["3"][4].Visible = v31;
    u7["3"][5].Visible = v31;
    u7["3"][6].Visible = v31;
    u7["3"][7].Visible = v31;
    local v32 = u6.Outscore or 0;
    local v33 = u6.Respawn or 5;
    local v34 = u6.Forcefield or 5;
    u7["3"][2].ImageLabel.TextBox.Text = tostring(v32);
    u7["3"][3].ImageLabel.TextBox.Text = tostring(v33);
    u7["3"][4].ImageLabel.TextBox.Text = tostring(v34);
    u7["3"][2].ImageLabel.TextBox.TextEditable = v30;
    u7["3"][3].ImageLabel.TextBox.TextEditable = v30;
    u7["3"][4].ImageLabel.TextBox.TextEditable = v30;
    u7["3"][15].Options.Derecha.Visible = v30;
    u7["3"][15].Options.Izquierda.Visible = v30;
    u7["3"][15].Options.Save.Visible = v30;
    u7["3"][5].Options.Derecha.Visible = v30;
    u7["3"][5].Options.Izquierda.Visible = v30;
    u7["3"][5].Options.Save.Visible = v30;
    u7["3"][6].Options.Derecha.Visible = v30;
    u7["3"][6].Options.Izquierda.Visible = v30;
    u7["3"][6].Options.Save.Visible = v30;
    local v35 = u6.Settings.TeamEspType or 0;
    local v36 = u6.Settings.KillfeedType or 0;
    local v37 = u6.Settings.BubbleStyle or 0;
    u7["3"][5].Options.Center.TextLabel.Text = tostring(v35) .. ". " .. l__Numbers__5.esp[tostring(v35)];
    u7["3"][6].Options.Center.TextLabel.Text = tostring(v36) .. ". " .. l__Numbers__5.killfeed[tostring(v36)];
    u7["3"][15].Options.Center.TextLabel.Text = tostring(v37) .. ". " .. l__Numbers__5.theme[tostring(v37)];
    u5.esp = v35;
    u5.killfeed = v36;
    u5.theme = v37;
    local l__BubbleChat__18 = u6.Settings.BubbleChat;
    local v38 = l__BubbleChat__18 == nil and true or l__BubbleChat__18;
    local l__Afterlife__19 = u6.Settings.Afterlife;
    local v39 = l__Afterlife__19 == nil and true or l__Afterlife__19;
    local l__CustomCursors__20 = u6.Settings.CustomCursors;
    local v40 = l__CustomCursors__20 == nil and true or l__CustomCursors__20;
    local l__Securemode__21 = u6.Settings.Securemode;
    local _ = l__Securemode__21 == nil;
    local l__LobbyTools__22 = u6.Settings.LobbyTools;
    local v41 = l__LobbyTools__22 == nil and true or l__LobbyTools__22;
    local l__HealthRegen__23 = u6.Settings.HealthRegen;
    local v42 = l__HealthRegen__23 == nil and true or l__HealthRegen__23;
    local l__HatHitbox__24 = u6.Settings.HatHitbox;
    local _ = l__HatHitbox__24 == nil;
    local l__Mediguns__25 = u6.Settings.Mediguns;
    local v43 = l__Mediguns__25 == nil and true or l__Mediguns__25;
    local l__DisplayNames__26 = u6.Settings.DisplayNames;
    local v44 = l__DisplayNames__26 == nil and true or l__DisplayNames__26;
    local l__CustomChat__27 = u6.Settings.CustomChat;
    local v45 = l__CustomChat__27 == nil and true or l__CustomChat__27;
    u5.bubblechat = v38;
    u5.afterlife = v39;
    u5.customcursors = v40;
    u5.securemode = l__Securemode__21;
    u5.lobbytools = v41;
    u5.healthregen = v42;
    u5.hathitbox = l__HatHitbox__24;
    u5.mediguns = v43;
    u5.displaynames = v44;
    u5.customchat = v45;
    if v38 == true then
        l__TweenService__1:Create(u7["3"][8].TEST.TEST, u10, {
            BackgroundColor3 = u8
        }):Play();
    else
        l__TweenService__1:Create(u7["3"][8].TEST.TEST, u10, {
            BackgroundColor3 = u9
        }):Play();
    end;
    if v39 == true then
        l__TweenService__1:Create(u7["3"][9].TEST.TEST, u10, {
            BackgroundColor3 = u8
        }):Play();
    else
        l__TweenService__1:Create(u7["3"][9].TEST.TEST, u10, {
            BackgroundColor3 = u9
        }):Play();
    end;
    if v40 == true then
        l__TweenService__1:Create(u7["3"][10].TEST.TEST, u10, {
            BackgroundColor3 = u8
        }):Play();
    else
        l__TweenService__1:Create(u7["3"][10].TEST.TEST, u10, {
            BackgroundColor3 = u9
        }):Play();
    end;
    if l__Securemode__21 == true then
        l__TweenService__1:Create(u7["3"][11].TEST.TEST, u10, {
            BackgroundColor3 = u8
        }):Play();
    else
        l__TweenService__1:Create(u7["3"][11].TEST.TEST, u10, {
            BackgroundColor3 = u9
        }):Play();
    end;
    if v41 == true then
        l__TweenService__1:Create(u7["3"][12].TEST.TEST, u10, {
            BackgroundColor3 = u8
        }):Play();
    else
        l__TweenService__1:Create(u7["3"][12].TEST.TEST, u10, {
            BackgroundColor3 = u9
        }):Play();
    end;
    if v42 == true then
        l__TweenService__1:Create(u7["3"][13].TEST.TEST, u10, {
            BackgroundColor3 = u8
        }):Play();
    else
        l__TweenService__1:Create(u7["3"][13].TEST.TEST, u10, {
            BackgroundColor3 = u9
        }):Play();
    end;
    if l__HatHitbox__24 == true then
        l__TweenService__1:Create(u7["3"][14].TEST.TEST, u10, {
            BackgroundColor3 = u8
        }):Play();
    else
        l__TweenService__1:Create(u7["3"][14].TEST.TEST, u10, {
            BackgroundColor3 = u9
        }):Play();
    end;
    if v43 == true then
        l__TweenService__1:Create(u7["3"][16].TEST.TEST, u10, {
            BackgroundColor3 = u8
        }):Play();
    else
        l__TweenService__1:Create(u7["3"][16].TEST.TEST, u10, {
            BackgroundColor3 = u9
        }):Play();
    end;
    if v44 == true then
        l__TweenService__1:Create(u7["3"][17].TEST.TEST, u10, {
            BackgroundColor3 = u8
        }):Play();
    else
        l__TweenService__1:Create(u7["3"][17].TEST.TEST, u10, {
            BackgroundColor3 = u9
        }):Play();
    end;
    if v45 == true then
        l__TweenService__1:Create(u7["3"][18].TEST.TEST, u10, {
            BackgroundColor3 = u8
        }):Play();
    else
        l__TweenService__1:Create(u7["3"][18].TEST.TEST, u10, {
            BackgroundColor3 = u9
        }):Play();
    end;
    u7["3"][8].TEST.TextLabel.Text = v38 == true and "ENABLED" or "DISABLED";
    u7["3"][9].TEST.TextLabel.Text = v39 == true and "ENABLED" or "DISABLED";
    u7["3"][10].TEST.TextLabel.Text = v40 == true and "ENABLED" or "DISABLED";
    u7["3"][11].TEST.TextLabel.Text = l__Securemode__21 == true and "ENABLED" or "DISABLED";
    u7["3"][12].TEST.TextLabel.Text = v41 == true and "ENABLED" or "DISABLED";
    u7["3"][13].TEST.TextLabel.Text = v42 == true and "ENABLED" or "DISABLED";
    u7["3"][14].TEST.TextLabel.Text = l__HatHitbox__24 == true and "ENABLED" or "DISABLED";
    u7["3"][16].TEST.TextLabel.Text = v43 == true and "ENABLED" or "DISABLED";
    u7["3"][17].TEST.TextLabel.Text = v44 == true and "ENABLED" or "DISABLED";
    u7["3"][18].TEST.TextLabel.Text = v45 == true and "ENABLED" or "DISABLED";
end;
local function u49(p47, p48) --[[ Line: 350 ]]
    -- upvalues: u6 (ref), u7 (copy), u8 (copy), l__TweenService__1 (copy), u10 (copy), u9 (copy), u5 (copy)
    local _ = p47 == nil and true or p47;
    local _ = p48 == nil and true or p48;
    local l__SwordFloat__28 = u6.Settings.SwordFloat;
    local _ = l__SwordFloat__28 == nil;
    local l__SwordHeal__29 = u6.Settings.SwordHeal;
    local _ = l__SwordHeal__29 == nil;
    local l__SwordAntiTie__30 = u6.Settings.SwordAntiTie;
    local _ = l__SwordAntiTie__30 == nil;
    if l__SwordFloat__28 == true then
        l__TweenService__1:Create(u7["4"][2].TEST.TEST, u10, {
            BackgroundColor3 = u8
        }):Play();
    else
        l__TweenService__1:Create(u7["4"][2].TEST.TEST, u10, {
            BackgroundColor3 = u9
        }):Play();
    end;
    if l__SwordHeal__29 == true then
        l__TweenService__1:Create(u7["4"][3].TEST.TEST, u10, {
            BackgroundColor3 = u8
        }):Play();
    else
        l__TweenService__1:Create(u7["4"][3].TEST.TEST, u10, {
            BackgroundColor3 = u9
        }):Play();
    end;
    if l__SwordAntiTie__30 == true then
        l__TweenService__1:Create(u7["4"][4].TEST.TEST, u10, {
            BackgroundColor3 = u8
        }):Play();
    else
        l__TweenService__1:Create(u7["4"][4].TEST.TEST, u10, {
            BackgroundColor3 = u9
        }):Play();
    end;
    u5.swordfloat = l__SwordFloat__28;
    u5.swordheal = l__SwordHeal__29;
    u5.swordtie = l__SwordAntiTie__30;
    u7["4"][2].TEST.TextLabel.Text = l__SwordFloat__28 == true and "ENABLED" or "DISABLED";
    u7["4"][3].TEST.TextLabel.Text = l__SwordHeal__29 == true and "ENABLED" or "DISABLED";
    u7["4"][4].TEST.TextLabel.Text = l__SwordAntiTie__30 == true and "ENABLED" or "DISABLED";
end;
local function u53(p50, p51) --[[ Line: 385 ]]
    -- upvalues: u6 (ref), u7 (copy), u8 (copy), l__TweenService__1 (copy), u10 (copy), u9 (copy), u5 (copy)
    local _ = p50 == nil and true or p50;
    local _ = p51 == nil and true or p51;
    local v52 = u6.TemporalSettings or {};
    local l__InfAmmo__31 = v52.InfAmmo;
    local _ = l__InfAmmo__31 == nil;
    local l__AutomateTeams__32 = v52.AutomateTeams;
    local _ = l__AutomateTeams__32 == nil;
    if l__InfAmmo__31 == true then
        l__TweenService__1:Create(u7["6"][2].TEST.TEST, u10, {
            BackgroundColor3 = u8
        }):Play();
    else
        l__TweenService__1:Create(u7["6"][2].TEST.TEST, u10, {
            BackgroundColor3 = u9
        }):Play();
    end;
    if l__AutomateTeams__32 == true then
        l__TweenService__1:Create(u7["6"][3].TEST.TEST, u10, {
            BackgroundColor3 = u8
        }):Play();
    else
        l__TweenService__1:Create(u7["6"][3].TEST.TEST, u10, {
            BackgroundColor3 = u9
        }):Play();
    end;
    u5.infammo = l__InfAmmo__31;
    u7["6"][2].TEST.TextLabel.Text = l__InfAmmo__31 == true and "ENABLED" or "DISABLED";
    u7["6"][3].TEST.TextLabel.Text = l__AutomateTeams__32 == true and "ENABLED" or "DISABLED";
end;
local function u78(p54) --[[ Line: 412 ]]
    -- upvalues: u6 (ref), l__ServerData__11 (copy), u2 (copy), l__LocalPlayer__2 (copy), u21 (copy), u4 (copy), u27 (copy), u46 (copy), u49 (copy), u53 (copy), u3 (ref), u7 (copy), l__insert__10 (copy), l__Admin__6 (copy), u5 (copy), l__Numbers__5 (copy)
    u6 = l__ServerData__11.Value:len() <= 2 and {} or u2.HttpService:JSONDecode(l__ServerData__11.Value);
    local u55 = l__LocalPlayer__2:FindFirstChild("isAdmin") and true or false;
    u21(u55, u4[1]);
    u27(u55, u4[2]);
    u46(u55, u4[3]);
    u49(u55, u4[3]);
    u53(u55, u4[6]);
    if (p54 or false) == true and u55 == true then
        for _, v56 in pairs(u3) do
            v56:disconnect();
        end;
        u3 = {};
        l__insert__10(u3, #u3 + 1, u7["1"][1]:FindFirstChildOfClass("TextButton").MouseButton1Click:connect(function() --[[ Line: 432 ]]
            -- upvalues: u4 (ref), u21 (ref), u55 (copy)
            if u4[1] == nil then
                u4[1] = true;
            end;
            local v57 = not u4[1];
            u4[1] = v57;
            u21(u55, v57);
        end));
        l__insert__10(u3, #u3 + 1, u7["2"][1]:FindFirstChildOfClass("TextButton").MouseButton1Click:connect(function() --[[ Line: 439 ]]
            -- upvalues: u4 (ref), u27 (ref), u55 (copy)
            if u4[2] == nil then
                u4[2] = true;
            end;
            local v58 = not u4[2];
            u4[2] = v58;
            u27(u55, v58);
        end));
        l__insert__10(u3, #u3 + 1, u7["2"][2].ImageLabel:FindFirstChildOfClass("TextBox").Focused:connect(function() --[[ Line: 449 ]]
            -- upvalues: u7 (ref)
            u7["2"][2].ImageLabel.Aviso.Visible = true;
        end));
        l__insert__10(u3, #u3 + 1, u7["2"][2].ImageLabel:FindFirstChildOfClass("TextBox").FocusLost:connect(function(p59) --[[ Line: 453 ]]
            -- upvalues: u7 (ref), l__Admin__6 (ref)
            u7["2"][2].ImageLabel.Aviso.Visible = false;
            if p59 == true then
                l__Admin__6:FireServer("setting", "change_servername", u7["2"][2].ImageLabel:FindFirstChildOfClass("TextBox").Text);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["2"][3].ImageLabel:FindFirstChildOfClass("TextBox").Focused:connect(function() --[[ Line: 465 ]]
            -- upvalues: u7 (ref)
            u7["2"][3].ImageLabel.Aviso.Visible = true;
        end));
        l__insert__10(u3, #u3 + 1, u7["2"][3].ImageLabel:FindFirstChildOfClass("TextBox").FocusLost:connect(function(_) --[[ Line: 469 ]]
            -- upvalues: u7 (ref)
            u7["2"][3].ImageLabel.Aviso.Visible = false;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][2].ImageLabel:FindFirstChildOfClass("TextBox").Focused:connect(function() --[[ Line: 487 ]]
            -- upvalues: u7 (ref)
            u7["3"][2].ImageLabel.Aviso.Visible = true;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][2].ImageLabel:FindFirstChildOfClass("TextBox").FocusLost:connect(function(p60) --[[ Line: 491 ]]
            -- upvalues: u7 (ref), l__Admin__6 (ref), u6 (ref)
            u7["3"][2].ImageLabel.Aviso.Visible = false;
            local l__Text__33 = u7["3"][2].ImageLabel:FindFirstChildOfClass("TextBox").Text;
            local v61 = tonumber(l__Text__33);
            if p60 == true and v61 ~= nil then
                l__Admin__6:FireServer("setting", "change_outscore", l__Text__33);
            else
                u7["3"][2].ImageLabel.TextBox.Text = tostring(u6.Outscore);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][3].ImageLabel:FindFirstChildOfClass("TextBox").Focused:connect(function() --[[ Line: 507 ]]
            -- upvalues: u7 (ref)
            u7["3"][3].ImageLabel.Aviso.Visible = true;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][3].ImageLabel:FindFirstChildOfClass("TextBox").FocusLost:connect(function(p62) --[[ Line: 511 ]]
            -- upvalues: u7 (ref), l__Admin__6 (ref), u6 (ref)
            u7["3"][3].ImageLabel.Aviso.Visible = false;
            local l__Text__34 = u7["3"][3].ImageLabel:FindFirstChildOfClass("TextBox").Text;
            local v63 = tonumber(l__Text__34);
            if p62 == true and v63 ~= nil then
                l__Admin__6:FireServer("setting", "change_respawntime", l__Text__34);
            else
                u7["3"][3].ImageLabel.TextBox.Text = tostring(u6.Respawn);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][4].ImageLabel:FindFirstChildOfClass("TextBox").Focused:connect(function() --[[ Line: 527 ]]
            -- upvalues: u7 (ref)
            u7["3"][4].ImageLabel.Aviso.Visible = true;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][4].ImageLabel:FindFirstChildOfClass("TextBox").FocusLost:connect(function(p64) --[[ Line: 531 ]]
            -- upvalues: u7 (ref), l__Admin__6 (ref), u6 (ref)
            u7["3"][4].ImageLabel.Aviso.Visible = false;
            local l__Text__35 = u7["3"][4].ImageLabel:FindFirstChildOfClass("TextBox").Text;
            local v65 = tonumber(l__Text__35);
            if p64 == true and v65 ~= nil then
                l__Admin__6:FireServer("setting", "change_forcefield", l__Text__35);
            else
                u7["3"][4].ImageLabel.TextBox.Text = tostring(u6.Respawn);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["2"][4].Options.Derecha.MouseButton1Click:connect(function() --[[ Line: 547 ]]
            -- upvalues: u5 (ref), l__Numbers__5 (ref), u7 (ref)
            local v66 = (u5.privacy or 0) + 1;
            local v67 = l__Numbers__5.privacy.max - 1 < v66 and 0 or v66;
            u7["2"][4].Options.Center.TextLabel.Text = tostring(v67) .. ". " .. l__Numbers__5.privacy[tostring(v67)]:upper();
            u5.privacy = v67;
        end));
        l__insert__10(u3, #u3 + 1, u7["2"][4].Options.Izquierda.MouseButton1Click:connect(function() --[[ Line: 558 ]]
            -- upvalues: u5 (ref), l__Numbers__5 (ref), u7 (ref)
            local v68 = (u5.privacy or 0) - 1;
            if v68 < 0 then
                v68 = l__Numbers__5.privacy.max - 1;
            end;
            u7["2"][4].Options.Center.TextLabel.Text = tostring(v68) .. ". " .. l__Numbers__5.privacy[tostring(v68)]:upper();
            u5.privacy = v68;
        end));
        l__insert__10(u3, #u3 + 1, u7["2"][4].Options.Save.MouseButton1Click:connect(function() --[[ Line: 572 ]]
            -- upvalues: u5 (ref), l__Admin__6 (ref)
            local l__privacy__36 = u5.privacy;
            if l__privacy__36 ~= nil then
                l__Admin__6:FireServer("setting", "change_serverprivacy", l__privacy__36);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][6].Options.Derecha.MouseButton1Click:connect(function() --[[ Line: 586 ]]
            -- upvalues: u5 (ref), l__Numbers__5 (ref), u7 (ref)
            local v69 = (u5.killfeed or 0) + 1;
            local v70 = l__Numbers__5.killfeed.max - 1 < v69 and 0 or v69;
            u7["3"][6].Options.Center.TextLabel.Text = tostring(v70) .. ". " .. l__Numbers__5.killfeed[tostring(v70)];
            u5.killfeed = v70;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][6].Options.Izquierda.MouseButton1Click:connect(function() --[[ Line: 597 ]]
            -- upvalues: u5 (ref), l__Numbers__5 (ref), u7 (ref)
            local v71 = (u5.killfeed or 0) - 1;
            if v71 < 0 then
                v71 = l__Numbers__5.killfeed.max - 1;
            end;
            u7["3"][6].Options.Center.TextLabel.Text = tostring(v71) .. ". " .. l__Numbers__5.killfeed[tostring(v71)];
            u5.killfeed = v71;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][6].Options.Save.MouseButton1Click:connect(function() --[[ Line: 611 ]]
            -- upvalues: u5 (ref), l__Admin__6 (ref)
            local l__killfeed__37 = u5.killfeed;
            if l__killfeed__37 ~= nil then
                l__Admin__6:FireServer("setting", "change_killfeed", l__killfeed__37);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][8].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 622 ]]
            -- upvalues: u5 (ref), l__Admin__6 (ref)
            local l__bubblechat__38 = u5.bubblechat;
            if l__bubblechat__38 ~= nil then
                l__Admin__6:FireServer("setting", "change_bubblechat", l__bubblechat__38);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][9].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 630 ]]
            -- upvalues: u5 (ref), l__Admin__6 (ref)
            local l__afterlife__39 = u5.afterlife;
            if l__afterlife__39 ~= nil then
                l__Admin__6:FireServer("setting", "change_afterlife", l__afterlife__39);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][10].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 638 ]]
            -- upvalues: u5 (ref), l__Admin__6 (ref)
            local l__customcursors__40 = u5.customcursors;
            if l__customcursors__40 ~= nil then
                l__Admin__6:FireServer("setting", "change_customcursors", l__customcursors__40);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][11].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 646 ]]
            -- upvalues: u5 (ref), l__Admin__6 (ref)
            local l__securemode__41 = u5.securemode;
            if l__securemode__41 ~= nil then
                l__Admin__6:FireServer("setting", "change_securemode", l__securemode__41);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][12].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 654 ]]
            -- upvalues: u5 (ref), l__Admin__6 (ref)
            local l__lobbytools__42 = u5.lobbytools;
            if l__lobbytools__42 ~= nil then
                l__Admin__6:FireServer("setting", "change_lobbytools", l__lobbytools__42);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][13].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 662 ]]
            -- upvalues: u5 (ref), l__Admin__6 (ref)
            local l__healthregen__43 = u5.healthregen;
            if l__healthregen__43 ~= nil then
                l__Admin__6:FireServer("setting", "change_healthregen", l__healthregen__43);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][14].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 670 ]]
            -- upvalues: u5 (ref), l__Admin__6 (ref)
            local l__hathitbox__44 = u5.hathitbox;
            if l__hathitbox__44 ~= nil then
                l__Admin__6:FireServer("setting", "change_hitbox", l__hathitbox__44);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][16].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 678 ]]
            -- upvalues: u5 (ref), l__Admin__6 (ref)
            local l__mediguns__45 = u5.mediguns;
            if l__mediguns__45 ~= nil then
                l__Admin__6:FireServer("setting", "change_mediguns", l__mediguns__45);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][17].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 686 ]]
            -- upvalues: u5 (ref), l__Admin__6 (ref)
            local l__displaynames__46 = u5.displaynames;
            if l__displaynames__46 ~= nil then
                l__Admin__6:FireServer("setting", "change_displayname", l__displaynames__46);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][18].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 694 ]]
            -- upvalues: u5 (ref), l__Admin__6 (ref)
            local l__customchat__47 = u5.customchat;
            if l__customchat__47 ~= nil then
                l__Admin__6:FireServer("setting", "change_customchat", l__customchat__47);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][5].Options.Derecha.MouseButton1Click:connect(function() --[[ Line: 706 ]]
            -- upvalues: u5 (ref), l__Numbers__5 (ref), u7 (ref)
            local v72 = (u5.esp or 0) + 1;
            local v73 = l__Numbers__5.esp.max - 1 < v72 and 0 or v72;
            u7["3"][5].Options.Center.TextLabel.Text = tostring(v73) .. ". " .. l__Numbers__5.esp[tostring(v73)];
            u5.esp = v73;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][5].Options.Izquierda.MouseButton1Click:connect(function() --[[ Line: 717 ]]
            -- upvalues: u5 (ref), l__Numbers__5 (ref), u7 (ref)
            local v74 = (u5.esp or 0) - 1;
            if v74 < 0 then
                v74 = l__Numbers__5.esp.max - 1;
            end;
            u7["3"][5].Options.Center.TextLabel.Text = tostring(v74) .. ". " .. l__Numbers__5.esp[tostring(v74)];
            u5.esp = v74;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][5].Options.Save.MouseButton1Click:connect(function() --[[ Line: 731 ]]
            -- upvalues: u5 (ref), l__Admin__6 (ref)
            local l__esp__48 = u5.esp;
            if l__esp__48 ~= nil then
                l__Admin__6:FireServer("setting", "change_esptype", l__esp__48);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][15].Options.Derecha.MouseButton1Click:connect(function() --[[ Line: 748 ]]
            -- upvalues: u5 (ref), l__Numbers__5 (ref), u7 (ref)
            local v75 = (u5.theme or 0) + 1;
            local v76 = l__Numbers__5.theme.max - 1 < v75 and 0 or v75;
            u7["3"][15].Options.Center.TextLabel.Text = tostring(v76) .. ". " .. l__Numbers__5.theme[tostring(v76)];
            u5.theme = v76;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][15].Options.Izquierda.MouseButton1Click:connect(function() --[[ Line: 759 ]]
            -- upvalues: u5 (ref), l__Numbers__5 (ref), u7 (ref)
            local v77 = (u5.theme or 0) - 1;
            if v77 < 0 then
                v77 = l__Numbers__5.theme.max - 1;
            end;
            u7["3"][15].Options.Center.TextLabel.Text = tostring(v77) .. ". " .. l__Numbers__5.theme[tostring(v77)];
            u5.theme = v77;
        end));
        l__insert__10(u3, #u3 + 1, u7["3"][15].Options.Save.MouseButton1Click:connect(function() --[[ Line: 773 ]]
            -- upvalues: u5 (ref), l__Admin__6 (ref)
            local l__theme__49 = u5.theme;
            if l__theme__49 ~= nil then
                l__Admin__6:FireServer("setting", "change_bubbletheme", l__theme__49);
            end;
        end));
        l__insert__10(u3, #u3 + 1, u7["2"][5].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 793 ]]
            -- upvalues: l__Admin__6 (ref)
            l__Admin__6:FireServer("setting", "toggle_followjoin");
        end));
        l__insert__10(u3, #u3 + 1, u7["4"][2].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 798 ]]
            -- upvalues: l__Admin__6 (ref)
            l__Admin__6:FireServer("setting", "toggle_swordfloat");
        end));
        l__insert__10(u3, #u3 + 1, u7["4"][3].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 802 ]]
            -- upvalues: l__Admin__6 (ref)
            l__Admin__6:FireServer("setting", "toggle_swordheal");
        end));
        l__insert__10(u3, #u3 + 1, u7["4"][4].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 806 ]]
            -- upvalues: l__Admin__6 (ref)
            l__Admin__6:FireServer("setting", "toggle_swordtie");
        end));
        l__insert__10(u3, #u3 + 1, u7["6"][2].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 816 ]]
            -- upvalues: l__Admin__6 (ref)
            l__Admin__6:FireServer("setting", "toggle_infammo");
        end));
        l__insert__10(u3, #u3 + 1, u7["6"][3].MAIN_BOTON.MouseButton1Click:connect(function() --[[ Line: 821 ]]
            -- upvalues: l__Admin__6 (ref)
            l__Admin__6:FireServer("setting", "toggle_autoteams");
        end));
    end;
end;
l__LocalPlayer__2.ChildAdded:connect(function(p79) --[[ Line: 828 ]]
    -- upvalues: u78 (copy)
    if p79:IsA("Folder") and p79.Name == "isAdmin" then
        p79.AnscestryChanged:connect(function(p80) --[[ Line: 830 ]]
            -- upvalues: u78 (ref)
            if p80 == nil then
                u78(false);
            end;
        end);
        u78(false);
    end;
end);
l__ServerData__11.Changed:connect(function() --[[ Line: 839 ]]
    -- upvalues: u78 (copy)
    u78(false);
end);
l__UIListLayout__8:GetPropertyChangedSignal("AbsoluteContentSize"):connect(function() --[[ Line: 848 ]]
    -- upvalues: l__UIListLayout__8 (copy), l__ScrollingFrame__7 (copy)
    l__ScrollingFrame__7.CanvasSize = UDim2.new(0, 0, 0, l__UIListLayout__8.AbsoluteContentSize.Y + 15);
end);
l__ScrollingFrame__7.CanvasSize = UDim2.new(0, 0, 0, l__UIListLayout__8.AbsoluteContentSize.Y + 15);
u78(true);
