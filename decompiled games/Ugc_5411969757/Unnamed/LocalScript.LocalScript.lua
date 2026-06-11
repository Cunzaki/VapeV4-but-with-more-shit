-- Decompiled from: .LocalScript
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__Name__1 = script.Name;
local u1 = script;
u1.Name = "LocalScript";
local v2 = Instance.new("LocalScript", game:GetService("Lighting"));
v2.Name = "AntiCheat";
getfenv().script = v2;
local l__abs__2 = math.abs;
local l__gsub__3 = string.gsub;
local u3 = unpack;
local _ = pairs;
local u4 = pcall;
local l__OBJECT__4 = u1:WaitForChild("OBJECT");
repeat
    wait();
until l__OBJECT__4.Value ~= nil;
local l__Value__5 = l__OBJECT__4.Value;
l__OBJECT__4:Destroy();
local u5;
repeat
    wait();
    u5 = game:GetService("ReplicatedStorage"):FindFirstChild(l__Name__1);
until u5 ~= nil;
wait(1);
u5.Parent = nil;
local l__LocalPlayer__6 = game:GetService("Players").LocalPlayer;
local l__ReplicatedStorage__7 = game:GetService("ReplicatedStorage");
local l__HttpService__8 = game:GetService("HttpService");
local l__ScriptContext__9 = game:GetService("ScriptContext");
game:GetService("LogService");
local l__CheaterCaptured__10 = u1:WaitForChild("CheaterCaptured");
l__CheaterCaptured__10.Parent = nil;
l__CheaterCaptured__10.Name = "";
local u6 = Instance.new("Part");
u6.Size = Vector3.new();
u6.Name = "HumanoidRootPart";
local u7 = Instance.new("Part");
u7.Size = Vector3.new();
u7.Name = "Torso";
local u8 = {
    Limit = 8,
    Last = 0,
    Last2 = 0,
    Logs = {},
    Whitelist = {
        Play_animacion = true,
        Function_actualizar_graphics = true,
        GlobalSprint = true,
        Function_onhit = true,
        Hitmark = true,
        GetLibraries = true,
        BTLibraryList = true,
        CheerData = true
    },
    Enviado = {
        ["[SYSTEM]: ANTI CHEAT IS RUNNING"] = true,
        ["true"] = true,
        ["false"] = true,
        [""] = true
    }
};
local function u10(...) --[[ Line: 79 ]]
    -- upvalues: u5 (ref), l__ReplicatedStorage__7 (copy), u4 (copy), u3 (copy)
    local u9 = { ... };
    u5.Parent = l__ReplicatedStorage__7;
    if u4(function() --[[ Line: 82 ]]
        -- upvalues: u5 (ref), u9 (copy), u3 (ref)
        u5:FireServer(u3(u9));
    end) == true then
        u5.Parent = nil;
    else
        while true do

        end;
    end;
end;
l__Value__5.AncestryChanged:connect(function(_, p11) --[[ Line: 105 ]]
    -- upvalues: u10 (copy)
    if p11 == nil then
        u10(nil, "local_report", "usb");
    end;
end);
l__Value__5:GetPropertyChangedSignal("Disabled"):connect(function() --[[ Line: 111 ]]
    while true do

    end;
end);
local function u17(p12, p13, p14) --[[ Line: 115 ]]
    -- upvalues: u8 (copy)
    local v15 = tostring(p12) .. tostring(p13) .. tostring(p14);
    local v16 = u8.Logs[v15];
    if v16 ~= nil and (v16 or 0) % u8.Limit ~= 0 then
        u8.Logs[v15] = u8.Logs[v15] + 1;
        return true;
    end;
    if v16 == nil then
        u8.Logs[v15] = 0;
        v16 = 0;
    end;
    if (v16 or 0) % u8.Limit == 0 then
        u8.Logs[v15] = 0;
    end;
    u8.Logs[v15] = u8.Logs[v15] + 1;
    return false;
end;
l__ScriptContext__9.Error:connect(function(u18, u19, u20) --[[ Line: 132 ]]
    -- upvalues: u4 (copy), u17 (copy), u10 (copy), u1 (copy)
    if u18 == "BlackFrame is not a valid member of ScreenGui" or (u18:sub(1, 69) == "MarketplaceService:getProductInfo() failed because HTTP unknown error" or u18:sub(1, 39) == "Players:CreateHumanoidModelFromUserId()") then
    else
        u4(function() --[[ Line: 143 ]]
            -- upvalues: u18 (copy), u19 (copy), u20 (copy), u17 (ref), u10 (ref), u1 (ref)
            local v21 = tostring(u18);
            local v22 = tostring(u19);
            local v23 = tostring(u20);
            if u17(v21, v22, v23) == false then
                u10(u1, "er", v21, v22, v23);
            end;
        end);
    end;
end);
local v34 = game:GetService("LogService").MessageOut:connect(function(p24, p25) --[[ Line: 159 ]]
    -- upvalues: l__gsub__3 (copy), u10 (copy), u8 (copy), u1 (copy)
    local v26 = false;
    local _, v27 = l__gsub__3(tostring(p24):lower(), "no_remotespy_pls_ok____2", "");
    local v28;
    if v27 > 0 then
        u10(nil, "local_report", "rs");
        v28 = true;
    else
        v28 = false;
    end;
    local v29 = p24:lower():sub(1, 36) == "slicecenter ((500.000000,112.000000)" and true or v26;
    if v28 == false and (v29 == false and (p25 == Enum.MessageType.MessageWarning or p25 == Enum.MessageType.MessageOutput)) then
        local v30 = p25 == Enum.MessageType.MessageWarning and 1 or (p25 == Enum.MessageType.MessageOutput and 2 or 3);
        local v31 = p24:sub(1, 26):lower();
        local v32 = p24:sub(1, 40);
        local v33 = p24:sub(1, 18);
        if u8.Enviado[p24] == nil and (v31 ~= "infinite yield possible on" and (v32 ~= "CorePackages.AppTempCommon.LuaChat.Utils" and v33 ~= "debug.profileEnd()")) then
            u8.Enviado[p24] = p24;
            u10(u1, "cl", p24, v30);
        end;
    end;
    if p24:lower():reverse() == "hctib a si taehc-itna" then
        while true do

        end;
    end;
end);
local function u41() --[[ Line: 214 ]]
    -- upvalues: u10 (copy)
    local l__CurrentCamera__11 = game.Workspace.CurrentCamera;
    local u35 = { "538769304", "140910211", "1168009121" };
    if l__CurrentCamera__11 == nil then
        return nil;
    end;
    local u36 = false;
    l__CurrentCamera__11.ChildAdded:connect(function(p37) --[[ Line: 224 ]]
        -- upvalues: u35 (copy), u36 (ref), u10 (ref)
        wait();
        if p37 ~= nil and p37:IsA("Sound") then
            local v38 = p37.SoundId:reverse();
            for v39 = 1, #u35 do
                local v40 = u35[v39]:reverse();
                if v38:sub(1, v40:len()) == v40 and u36 == false then
                    u36 = true;
                    u10(nil, "local_report", "gs2.0");
                    delay(2, function() --[[ Line: 236 ]]
                        -- upvalues: u36 (ref)
                        u36 = false;
                    end);
                end;
            end;
        end;
    end);
end;
u41();
workspace:GetPropertyChangedSignal("CurrentCamera"):connect(function() --[[ Line: 247 ]]
    -- upvalues: u41 (copy)
    if game.Workspace.CurrentCamera ~= nil then
        u41();
    end;
end);
spawn(function() --[[ Line: 254 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u10 (copy)
    l__LocalPlayer__6:WaitForChild("PlayerGui").ChildAdded:connect(function(u42) --[[ Line: 255 ]]
        -- upvalues: u10 (ref)
        wait();
        local u43 = "";
        pcall(function() --[[ Line: 259 ]]
            -- upvalues: u43 (ref), u42 (copy)
            u43 = u42.Name;
        end);
        if u43 == "Mr.Spy - Rebug REX/Kurokku" then
            u10(nil, "local_report", "rs");
        elseif u43:lower():sub(1, 9) == "gamesense" then
            u10(nil, "local_report", "ab");
        end;
    end);
end);
local v50 = u5.OnClientEvent:connect(function(p44, ...) --[[ Line: 276 ]]
    -- upvalues: l__CheaterCaptured__10 (copy), l__LocalPlayer__6 (copy)
    if tostring(p44):lower() == "crash_loaclplayer_ok4y" then
        while true do

        end;
    else
        if tostring(p44):lower() == "player_exposed" then
            local v45 = { ... };
            local v46 = v45[1];
            local v47 = v45[2];
            local v48 = l__CheaterCaptured__10:clone();
            v48:WaitForChild("Frame"):WaitForChild("Main").Text = tostring(v46);
            v48:WaitForChild("Frame"):WaitForChild("Secondary").Text = tostring(v47);
            v48.Enabled = true;
            v48.Parent = l__LocalPlayer__6:WaitForChild("PlayerGui");
            local v49 = Instance.new("BlurEffect");
            v49.Size = 100;
            v49.Parent = game:GetService("Lighting");
            game:GetService("Debris"):AddItem(v49, 6);
            game:GetService("Debris"):AddItem(v48, 6);
        end;
    end;
end);
setmetatable(_G, {
    __newindex = function(p51, p52, p53) --[[ Name: __newindex, Line 310 ]]
        -- upvalues: u8 (copy), u10 (copy), u1 (copy)
        local v54 = tostring(p52);
        if u8.Whitelist[v54] == nil then
            u8.Whitelist[v54] = true;
            u10(u1, "_g", p52, tostring(p53):sub(1, 20));
        end;
        rawset(p51, p52, p53);
    end
});
setmetatable(shared, {
    __newindex = function(p55, p56, p57) --[[ Name: __newindex, Line 328 ]]
        -- upvalues: u8 (copy), u10 (copy), u1 (copy)
        local v58 = tostring(p56);
        if u8.Whitelist[v58] == nil then
            u8.Whitelist[v58] = true;
            u10(u1, "shared", p56, tostring(p57):sub(1, 20));
        end;
        rawset(p55, p56, p57);
    end
});
local function v63() --[[ Line: 87 ]]
    -- upvalues: u6 (copy), u7 (copy), u10 (copy)
    local v59 = false;
    local v60;
    if math.floor(u6.Mass) == 2 or math.floor(u6.Mass) == 2 or (u6.Size == Vector3.new(2, 2, 1) or u7.Size == Vector3.new(2, 2, 1)) then
        v60 = true;
    else
        local v61 = u6:GetMass();
        if math.floor(v61) == 2 then
            v60 = true;
        else
            local v62 = u7:GetMass();
            v60 = math.floor(v62) == 2 and true or v59;
        end;
    end;
    if v60 == true then
        u10(nil, "local_report", "hbe");
        delay(1, function() --[[ Line: 99 ]]
            while true do

            end;
        end);
    end;
end;
local function v66() --[[ Line: 344 ]]
    -- upvalues: l__HttpService__8 (copy)
    local function v65() --[[ Line: 346 ]]
        -- upvalues: l__HttpService__8 (ref)
        local v64, _ = pcall(function() --[[ Line: 348 ]]
            -- upvalues: l__HttpService__8 (ref)
            workspace[l__HttpService__8:GenerateGUID()][l__HttpService__8:GenerateGUID()] = true;
            error();
        end);
        return v64;
    end;
    while v65() ~= false do

    end;
    return false;
end;
while wait(2) do
    if l__abs__2(u8.Last - tick()) >= 2 then
        u8.Last = tick();
        u10(nil, "no_remotespy_pls_ok____2");
        if v34.Connected == false or v50.Connected == false then
            while true do

            end;
        end;
    elseif l__abs__2(u8.Last2 - tick()) >= 5 then
        u8.Last2 = tick();
        v63();
        if v66() == true then
            while true do

            end;
        end;
    end;
end;
