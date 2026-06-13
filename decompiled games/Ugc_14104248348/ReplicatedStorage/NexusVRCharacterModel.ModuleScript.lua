-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__HttpService__2 = game:GetService("HttpService");
local l__NexusBufferedReplication__3 = require(script:WaitForChild("Packages"):WaitForChild("NexusBufferedReplication"));
local u1 = require(script:WaitForChild("State"):WaitForChild("Settings")).GetInstance();
local l__BufferProtocol__4 = require(script:WaitForChild("Util"):WaitForChild("BufferProtocol"));
local l__BufferedRemoteEventSender__5 = l__NexusBufferedReplication__3.Sender.BufferedRemoteEventSender;
local l__EnrollableRemoteEvent__6 = l__NexusBufferedReplication__3.Sender.EnrollableRemoteEvent;
return {
    SetConfiguration = function(_, p2) --[[ Name: SetConfiguration, Line 28 ]]
        -- upvalues: l__HttpService__2 (copy), u1 (copy)
        local v3 = script:FindFirstChild("Configuration");
        if not v3 then
            v3 = Instance.new("StringValue");
            v3.Name = "Configuration";
            v3.Parent = script;
        end;
        local v4;
        if p2.Extra then
            v4 = p2.Extra.HideVersion == true;
        else
            v4 = false;
        end;
        if not p2.Version then
            p2.Version = {};
        end;
        if not p2.Version.Tag then
            p2.Version.Tag = v4 and "Hidden" or "2.15.1";
        end;
        if not p2.Version.Commit then
            p2.Version.Commit = v4 and "Hidden" or "c6e3ad0";
        end;
        v3.Value = l__HttpService__2:JSONEncode(p2);
        u1:SetDefaults(p2);
    end,
    Load = function(_) --[[ Name: Load, Line 61 ]]
        -- upvalues: l__ReplicatedStorage__1 (copy), l__EnrollableRemoteEvent__6 (copy), l__BufferedRemoteEventSender__5 (copy), l__BufferProtocol__4 (copy), u1 (copy)
        if l__ReplicatedStorage__1:FindFirstChild("NexusVRCharacterModel") then
        else
            script.Name = "NexusVRCharacterModel";
            script.Parent = l__ReplicatedStorage__1;
            local v5 = not l__ReplicatedStorage__1:FindFirstChild("NexusVRCore") and script:FindFirstChild("Packages");
            if v5 then
                local v6 = v5:FindFirstChild("nexus-vr-core", true);
                local v7 = v5:FindFirstChild("nexus-instance", true);
                if v6 and v7 then
                    local v8 = v6:Clone();
                    v8.Name = "NexusVRCore";
                    v8:WaitForChild("Packages"):WaitForChild("NexusInstance"):Destroy();
                    local v9 = v7:Clone();
                    v9.Name = "NexusInstance";
                    v9.Parent = v8:WaitForChild("Packages");
                    v8.Parent = l__ReplicatedStorage__1;
                end;
            end;
            require(l__ReplicatedStorage__1:WaitForChild("NexusVRCharacterModel"):WaitForChild("Util"):WaitForChild("Warnings"))();
            script:WaitForChild("NexusVRCharacterModelClientLoader").Parent = l__ReplicatedStorage__1;
            local v10 = Instance.new("UnreliableRemoteEvent");
            v10.Name = "UpdateInputs";
            v10.Parent = script;
            local v11 = Instance.new("RemoteEvent");
            v11.Name = "ReplicationReady";
            v11.Parent = script;
            local u12 = l__EnrollableRemoteEvent__6.new(v10);
            local u14 = l__BufferedRemoteEventSender__5.WithPlayerKeys(u12, function(p13) --[[ Line: 107 ]]
                -- upvalues: l__BufferProtocol__4 (ref)
                return l__BufferProtocol__4.Serialize(p13);
            end);
            u14:StartDataSendingWithDelay(0.03333333333333333);
            v10.OnServerEvent:Connect(function(p15, p16) --[[ Line: 112 ]]
                -- upvalues: u14 (copy)
                if typeof(p16) == "table" then
                    u14:QueueData(p15, p16);
                end;
            end);
            v11.OnServerEvent:Connect(function(p17) --[[ Line: 117 ]]
                -- upvalues: u12 (copy)
                u12:EnrollPlayer(p17);
            end);
            if u1:GetSetting("Extra.NexusVRBackpackEnabled") ~= false then
                require(10728805649)();
            end;
        end;
    end,
    Api = require(script:WaitForChild("Api"))()
};
