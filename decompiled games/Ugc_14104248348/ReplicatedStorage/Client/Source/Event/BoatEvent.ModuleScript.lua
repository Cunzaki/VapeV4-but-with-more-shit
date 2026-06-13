-- Decompiled from: ReplicatedStorage.Client.Source.Event.BoatEvent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("BadgeService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("TweenService");
game:GetService("MarketplaceService");
game:GetService("CollectionService");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.SevenSegment);
require(l__ReplicatedStorage__1.Modules.Bucket);
l__Mince__2:Get("Voicelines");
l__Mince__2:Get("SoundHandler");
l__Mince__2:Get("CutsceneHandler");
l__Mince__2:Get("SelectInteractor");
l__Mince__2:Get("InterfaceHandler");
l__Mince__2:Get("SoundHandler");
l__Mince__2:Get("SoundArea");
l__Mince__2:GetEvent("DoSpeakLNY");
l__Mince__2:GetEvent("LNY26");
l__Mince__2:GetEvent("ContinueShow");
l__Mince__2:GetEvent("DoCrowdCheer");
return {
    Timeline = {},
    Setup = function() --[[ Name: Setup, Line 32 ]] end
};
