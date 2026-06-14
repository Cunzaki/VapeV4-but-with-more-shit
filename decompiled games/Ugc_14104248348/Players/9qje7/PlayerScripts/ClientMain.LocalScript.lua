-- Decompiled from: Players.9qje7.PlayerScripts.ClientMain
-- Class: LocalScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__Mince__2 = require(game.ReplicatedStorage.Modules.Mince);
l__Mince__2:WaitUntilSetup("Server");
l__Mince__2:LoadConfig(l__ReplicatedStorage__1.Config);
l__Mince__2:LoadModules(l__ReplicatedStorage__1.Client.Class);
l__Mince__2:LoadModules(l__ReplicatedStorage__1.Client.Source);
l__Mince__2:Start();
