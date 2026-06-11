-- Decompiled from: StarterPlayer.StarterPlayerScripts.Importantes.BindableLocal
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__LocalPlayer__2 = l__Players__1.LocalPlayer;
local l__Request__3 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage", 300):WaitForChild("Remotes"):WaitForChild("Request");
local v1 = Instance.new("BindableFunction");
v1.Name = "Requirement";
v1.Parent = l__LocalPlayer__2;
local l__CurrentGamemode__4 = game:GetService("Lighting"):WaitForChild("CurrentGamemode", 300);
local l__Value__5 = l__CurrentGamemode__4.Value;
local u2 = workspace:WaitForChild("GameObjects"):FindFirstChild("__Ignorable");
local l__SpectateFolder__6 = workspace:WaitForChild("SpectateFolder");
local u3 = nil;
local u4 = {
    infammo = false
};
l__Request__3.OnClientEvent:connect(function(p5, p6) --[[ Line: 26 ]]
    -- upvalues: u4 (copy)
    if p5 == "infammo" and (p6 ~= nil and (p6 == true or p6 == false)) then
        u4.infammo = p6;
    end;
end);
l__LocalPlayer__2:GetPropertyChangedSignal("Team"):connect(function() --[[ Line: 32 ]]
    -- upvalues: l__LocalPlayer__2 (copy), u3 (ref)
    if l__LocalPlayer__2.Team ~= nil then
        u3 = l__LocalPlayer__2.Team:FindFirstChild("isFFA");
    end;
end);
l__CurrentGamemode__4:GetPropertyChangedSignal("Value"):connect(function() --[[ Line: 37 ]]
    -- upvalues: l__Value__5 (ref), l__CurrentGamemode__4 (copy)
    l__Value__5 = l__CurrentGamemode__4.Value;
end);
function v1.OnInvoke(p7, ...) --[[ Line: 41 ]]
    -- upvalues: l__Players__1 (copy), l__Value__5 (ref), u3 (ref), l__LocalPlayer__2 (copy), u2 (copy), l__SpectateFolder__6 (copy), u4 (copy)
    if p7 == "hitpart_check" then
        local v8 = ({ ... })[1];
        if v8 == nil then
            return;
        end;
        if v8 == nil then
            return;
        end;
        local v9 = l__Players__1:GetPlayerFromCharacter(v8.Parent) or l__Players__1:GetPlayerFromCharacter(v8.Parent.Parent);
        local v10 = v8.Parent:FindFirstChild("Humanoid") or v8.Parent.Parent:FindFirstChild("Humanoid");
        if v9 ~= nil and v10 ~= nil then
            return { v9, v10 };
        end;
    elseif p7 == "damage_check" then
        local v11 = ({ ... })[1];
        if v11 == nil then
            return;
        end;
        if l__Value__5 == "ffa" and u3 ~= nil then
            if l__LocalPlayer__2.TeamColor == v11.TeamColor then
                return true;
            end;
        elseif l__LocalPlayer__2.TeamColor ~= v11.TeamColor then
            return true;
        end;
    else
        if p7 == "get_ignorable" then
            return {
                l__LocalPlayer__2.Character,
                u2,
                workspace:FindFirstChild("FE_Ignorable"),
                l__SpectateFolder__6
            };
        end;
        if p7 == "getsvar" then
            return u4[({ ... })[1]];
        end;
    end;
end;
wait();
l__Request__3:FireServer("getvars");
