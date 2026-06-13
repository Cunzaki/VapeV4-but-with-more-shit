-- Decompiled from: ReplicatedStorage.Modules.PlayerConnections
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local u1 = {
    StaticPlayerConnections = nil
};
u1.__index = u1;
function u1.new() --[[ Line: 35 ]]
    -- upvalues: u1 (copy), l__Players__1 (copy)
    local u2 = setmetatable({
        PlayerConnections = {},
        CharacterConnections = {}
    }, u1);
    l__Players__1.PlayerRemoving:Connect(function(p3) --[[ Line: 43 ]]
        -- upvalues: u2 (copy)
        u2:DisconnectPlayerConnections(p3);
    end);
    l__Players__1.PlayerAdded:Connect(function(u4) --[[ Line: 46 ]]
        -- upvalues: u2 (copy)
        u2:AddPlayerConnection(u4, u4.CharacterAdded:Connect(function(_) --[[ Line: 47 ]]
            -- upvalues: u2 (ref), u4 (copy)
            u2:DisconnectCharacterConnections(u4);
        end));
    end);
    for _, u5 in l__Players__1:GetPlayers() do
        u2:AddPlayerConnection(u5, u5.CharacterAdded:Connect(function(_) --[[ Line: 52 ]]
            -- upvalues: u2 (copy), u5 (copy)
            u2:DisconnectCharacterConnections(u5);
        end));
    end;
    return u2;
end;
function u1.Get() --[[ Line: 65 ]]
    -- upvalues: u1 (copy)
    if not u1.StaticPlayerConnections then
        u1.StaticPlayerConnections = u1.new();
    end;
    return u1.StaticPlayerConnections;
end;
function u1.AddCharacterConnection(p6, p7, p8) --[[ Line: 76 ]]
    local l__Character__2 = p7.Character;
    if l__Character__2 then
        if not p6.CharacterConnections[p7] then
            p6.CharacterConnections[p7] = {};
        end;
        if not p6.CharacterConnections[p7][l__Character__2] then
            p6.CharacterConnections[p7][l__Character__2] = {};
        end;
        table.insert(p6.CharacterConnections[p7][l__Character__2], p8);
    else
        warn("Player has no current character. Unable to store an event connection for the character.");
    end;
end;
function u1.AddPlayerConnection(p9, p10, p11) --[[ Line: 97 ]]
    if not p9.PlayerConnections[p10] then
        p9.PlayerConnections[p10] = {};
    end;
    table.insert(p9.PlayerConnections[p10], p11);
end;
function u1.DisconnectCharacterConnections(p12, p13) --[[ Line: 107 ]]
    if p12.CharacterConnections[p13] then
        local v14 = {};
        for v15, _ in p12.CharacterConnections[p13] do
            if v15 ~= p13.Character then
                table.insert(v14, v15);
            end;
        end;
        for _, v16 in v14 do
            for _, v17 in p12.CharacterConnections[p13][v16] do
                v17:Disconnect();
            end;
            p12.CharacterConnections[p13][v16] = nil;
        end;
    end;
end;
function u1.DisconnectPlayerConnections(p18, p19) --[[ Line: 130 ]]
    if p18.CharacterConnections[p19] then
        for _, v20 in p18.CharacterConnections[p19] do
            for _, v21 in v20 do
                v21:Disconnect();
            end;
        end;
        p18.CharacterConnections[p19] = nil;
    end;
    if p18.PlayerConnections[p19] then
        for _, v22 in p18.PlayerConnections[p19] do
            v22:Disconnect();
        end;
        p18.PlayerConnections[p19] = nil;
    end;
end;
return u1;
