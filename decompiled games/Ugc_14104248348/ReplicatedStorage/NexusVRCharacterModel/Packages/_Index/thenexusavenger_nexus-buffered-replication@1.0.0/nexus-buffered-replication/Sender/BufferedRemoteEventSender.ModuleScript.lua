-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-buffered-replication@1.0.0.nexus-buffered-replication.Sender.BufferedRemoteEventSender
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new(p2, p3) --[[ Line: 26 ]]
    -- upvalues: u1 (copy)
    return setmetatable({
        MaxRequestSize = 900,
        SendingActive = true,
        QueuedData = {},
        RemoteEvent = p2,
        SerializeMessage = p3
    }, u1);
end;
function u1.WithPlayerKeys(p4, u5) --[[ Line: 39 ]]
    -- upvalues: u1 (copy)
    return u1.new(p4, function(p6, p7) --[[ Line: 40 ]]
        -- upvalues: u5 (copy)
        local v8 = u5(p7);
        local v9 = buffer.create(8 + buffer.len(v8));
        buffer.writef64(v9, 0, p6.UserId);
        buffer.copy(v9, 8, v8);
        return v9;
    end);
end;
function u1.QueueData(p10, p11, p12) --[[ Line: 53 ]]
    p10.QueuedData[p11] = p12;
end;
function u1.SendQueuedData(p13) --[[ Line: 60 ]]
    local l__QueuedData__1 = p13.QueuedData;
    p13.QueuedData = {};
    local l__MaxRequestSize__2 = p13.MaxRequestSize;
    local v14 = {
        {
            CurrentLength = 0,
            Buffers = {}
        }
    };
    for v15, v16 in l__QueuedData__1 do
        local v17 = p13.SerializeMessage(v15, v16);
        local v18 = buffer.len(v17);
        if p13.MaxRequestSize < v18 then
            warn((`Data was serialzied for key {v15} and was too long ({v18} > {l__MaxRequestSize__2}). The data will be dropped.`));
        else
            local v19 = v14[#v14];
            local v20 = v19.CurrentLength + v18;
            if l__MaxRequestSize__2 < v20 then
                table.insert(v14, {
                    Buffers = { v17 },
                    CurrentLength = v18
                });
            else
                table.insert(v19.Buffers, v17);
                v19.CurrentLength = v20;
            end;
        end;
    end;
    for _, v21 in v14 do
        if v21.CurrentLength == 0 then
            return;
        end;
        local v22 = buffer.create(v21.CurrentLength);
        local v23 = 0;
        for _, v24 in v21.Buffers do
            buffer.copy(v22, v23, v24);
            v23 = v23 + buffer.len(v24);
        end;
        p13.RemoteEvent:FireAllClients(v22);
    end;
end;
function u1.StartDataSending(u25, u26) --[[ Line: 113 ]]
    task.spawn(function() --[[ Line: 114 ]]
        -- upvalues: u25 (copy), u26 (copy)
        while u25.SendingActive do
            u25:SendQueuedData();
            u26();
        end;
    end);
end;
function u1.StartDataSendingWithDelay(p27, u28) --[[ Line: 125 ]]
    p27:StartDataSending(function() --[[ Line: 126 ]]
        -- upvalues: u28 (copy)
        task.wait(u28);
    end);
end;
function u1.StartDataSendingWithEvent(p29, u30) --[[ Line: 134 ]]
    p29:StartDataSending(function() --[[ Line: 135 ]]
        -- upvalues: u30 (copy)
        u30:Wait();
    end);
end;
function u1.Destroy(p31) --[[ Line: 143 ]]
    p31.SendingActive = false;
end;
return u1;
