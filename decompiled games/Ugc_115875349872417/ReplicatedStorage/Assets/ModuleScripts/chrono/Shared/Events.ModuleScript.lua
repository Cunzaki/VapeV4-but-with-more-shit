-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Shared.Events
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
local l__Signal__1 = require(script.Parent.Signal);
local v1 = {};
local v2 = {};
v1.EntityAdded = l__Signal__1.new();
v2.EntityAdded = v1.EntityAdded.Event;
v1.EntityRemoved = l__Signal__1.new();
v2.EntityRemoved = v1.EntityRemoved.Event;
v1.PlayerCharacterRegistered = l__Signal__1.new();
v2.PlayerCharacterRegistered = v1.PlayerCharacterRegistered.Event;
v1.PlayerCharacterUnregistered = l__Signal__1.new();
v2.PlayerCharacterUnregistered = v1.PlayerCharacterUnregistered.Event;
v1.PlayerOwnedAdded = l__Signal__1.new();
v2.PlayerOwnedAdded = v1.PlayerOwnedAdded.Event;
v1.PlayerOwnedRemoved = l__Signal__1.new();
v2.PlayerOwnedRemoved = v1.PlayerOwnedRemoved.Event;
v1["请不要使用_内部_设置值_拜托谢谢_嗨_这个名字有点长_好吧_再见_算了_这个确实被用了_因为递归错误_而我懒得去解决_所以这是一个能用的_创可贴式修复_好吧"] = l__Signal__1.new();
v2._Signals = v1;
return v2;
