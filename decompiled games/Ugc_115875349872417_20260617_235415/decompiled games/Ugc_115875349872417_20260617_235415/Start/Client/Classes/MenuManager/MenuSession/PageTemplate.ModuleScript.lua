-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.PageTemplate
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
game:GetService("TweenService");
game:GetService("UserInputService");
local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
require(l__ModuleScripts__1.Packets);
require(l__ModuleScripts__1.Signal);
require(l__ModuleScripts__1.Promise);
local l__Trove__2 = require(l__ModuleScripts__1.Trove);
require(l__ModuleScripts__1.Spring);
local _ = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local _ = require(script.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__3 = require(script.Parent.Parent.Parent.Parent.InternalSymbols);
local _ = game.Players.LocalPlayer;
function u1.new(p2, p3) --[[ Line: 25 ]]
    -- upvalues: u1 (copy), l__InternalSymbols__3 (copy), l__Trove__2 (copy)
    local v4 = setmetatable({}, u1);
    v4.menu_session = l__InternalSymbols__3.owner("MenuSession", p3);
    v4.parent_os = p2;
    v4.trove = l__Trove__2.new();
    return v4;
end;
function u1.cleanUp(_) --[[ Line: 35 ]] end;
function u1.close(_) --[[ Line: 38 ]] end;
function u1.start(_) --[[ Line: 41 ]] end;
function u1.Init(_) --[[ Line: 44 ]] end;
return u1;
