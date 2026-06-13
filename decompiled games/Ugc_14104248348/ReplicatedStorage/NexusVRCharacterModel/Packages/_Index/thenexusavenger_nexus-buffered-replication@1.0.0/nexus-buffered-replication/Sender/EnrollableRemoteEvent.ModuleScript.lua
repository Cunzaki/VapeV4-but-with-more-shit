-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-buffered-replication@1.0.0.nexus-buffered-replication.Sender.EnrollableRemoteEvent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    Players = game:GetService("Players")
};
u1.__index = u1;
function u1.new(p2) --[[ Line: 20 ]]
    -- upvalues: u1 (copy)
    local v3 = {
        RemoteEvent = p2,
        TotalPlayers = #u1.Players:GetPlayers(),
        EnrolledPlayers = {},
        EventConnections = {}
    };
    local u4 = setmetatable(v3, u1);
    table.insert(u4.EventConnections, u1.Players.PlayerAdded:Connect(function() --[[ Line: 30 ]]
        -- upvalues: u4 (copy), u1 (ref)
        u4.TotalPlayers = #u1.Players:GetPlayers();
    end));
    table.insert(u4.EventConnections, u1.Players.PlayerRemoving:Connect(function(p5) --[[ Line: 33 ]]
        -- upvalues: u4 (copy), u1 (ref)
        u4.TotalPlayers = #u1.Players:GetPlayers();
        u4:UnenrollPlayer(p5);
    end));
    return u4;
end;
function u1.EnrollPlayer(p6, p7) --[[ Line: 45 ]]
    if table.find(p6.EnrolledPlayers, p7) then
    else
        table.insert(p6.EnrolledPlayers, p7);
    end;
end;
function u1.UnenrollPlayer(p8, p9) --[[ Line: 53 ]]
    local v10 = table.find(p8.EnrolledPlayers, p9);
    if v10 then
        table.remove(p8.EnrolledPlayers, v10);
    end;
end;
function u1.FireAllClients(p11, ...) --[[ Line: 62 ]]
    local v12 = #p11.EnrolledPlayers;
    if #p11.EnrolledPlayers == 0 then
    else
        local l__RemoteEvent__1 = p11.RemoteEvent;
        if v12 == p11.TotalPlayers then
            l__RemoteEvent__1:FireAllClients(...);
        else
            for _, v13 in p11.EnrolledPlayers do
                l__RemoteEvent__1:FireClient(v13, ...);
            end;
        end;
    end;
end;
function u1.Destroy(p14) --[[ Line: 83 ]]
    for _, v15 in p14.EventConnections do
        v15:Disconnect();
    end;
    p14.EventConnections = {};
end;
return u1;
