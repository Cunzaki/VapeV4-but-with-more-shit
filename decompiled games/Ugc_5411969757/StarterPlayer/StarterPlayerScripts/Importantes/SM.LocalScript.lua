-- Decompiled from: StarterPlayer.StarterPlayerScripts.Importantes.SM
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__Settings__1 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage"):WaitForChild("Remotes"):WaitForChild("Settings");
local u1 = {
    Lighting = game:GetService("Lighting"),
    Workspace = game:GetService("Workspace"),
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    ReplicatedFirst = game:GetService("ReplicatedFirst")
};
local u2 = false;
local u3 = {};
local function u5() --[[ Line: 14 ]]
    -- upvalues: u3 (ref)
    for _, v4 in pairs(u3) do
        v4:disconnect();
    end;
    u3 = {};
end;
local function u11() --[[ Line: 21 ]]
    -- upvalues: u2 (ref), u5 (copy), u1 (copy), u3 (ref)
    if u2 == true then
        u5();
        for _, u6 in pairs(u1) do
            u6.Name = "";
            local v7 = u3;
            local v8 = u6:GetPropertyChangedSignal("Name");
            table.insert(v7, v8:connect(function() --[[ Line: 26 ]]
                -- upvalues: u6 (copy)
                if u6.Name == "" then
                else
                    u6.Name = "";
                    while true do

                    end;
                end;
            end));
        end;
    else
        u5();
        for v9, v10 in pairs(u1) do
            v10.Name = v9;
        end;
    end;
end;
l__Settings__1.OnClientEvent:connect(function(p12) --[[ Line: 41 ]]
    -- upvalues: u2 (ref), u11 (copy)
    u2 = p12;
    u11();
end);
l__Settings__1:FireServer();
