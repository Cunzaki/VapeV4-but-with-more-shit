-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-buffered-replication@1.0.0.nexus-buffered-replication
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Receiver = {
        BufferedRemoteEventReceiver = require(script:WaitForChild("Receiver"):WaitForChild("BufferedRemoteEventReceiver")),
        PlayerBufferedRemoteEventReceiver = require(script:WaitForChild("Receiver"):WaitForChild("PlayerBufferedRemoteEventReceiver"))
    },
    Sender = {
        BufferedRemoteEventSender = require(script:WaitForChild("Sender"):WaitForChild("BufferedRemoteEventSender")),
        EnrollableRemoteEvent = require(script:WaitForChild("Sender"):WaitForChild("EnrollableRemoteEvent"))
    }
};
