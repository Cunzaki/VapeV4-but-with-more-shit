-- Decompiled from: ReplicatedFirst.Runtime.Script
-- Class: Script
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent;
local l__Signal__2 = require(l__Parent__1.Signal);
local l__LightRunner__3 = require(l__Parent__1.LightRunner);
_G.LightRunner = l__LightRunner__3;
l__LightRunner__3.Signal = l__Signal__2;
l__LightRunner__3.Settings = l__Parent__1.Settings:GetAttributes();
l__LightRunner__3:Load(l__Parent__1.Source);
