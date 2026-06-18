-- Decompiled from: Start.Client.ReplicatedEntities._xeaa4b98924eebc0a
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
require(l__ModuleScripts__1.Packets);
require(l__ModuleScripts__1.Signal);
require(l__ModuleScripts__1.Promise);
local l__Trove__2 = require(l__ModuleScripts__1.Trove);
require(l__ModuleScripts__1.Spring);
local u1 = {};
u1.__index = u1;
local _ = require(script.Parent.Parent.ClientRoot).Classes;
local _ = game.Players.LocalPlayer;
function u1._x90d4581ac99dd483(p2) --[[ Line: 20 ]]
    -- upvalues: u1 (copy), l__Trove__2 (copy)
    local u3 = setmetatable({}, u1);
    u3._x9dfab354fc7fd1f6 = "inactive";
    u3._xe6b273660fc7b65e = p2;
    u3._x56e388840ebb3dc6 = l__Trove__2.new();
    u3._x56e388840ebb3dc6:Add(u3._xe6b273660fc7b65e);
    u3._xe6b273660fc7b65e.Destroying:Connect(function() --[[ Line: 29 ]]
        -- upvalues: u3 (copy)
        u3:cleanUp();
    end);
    return u3;
end;
function u1.cleanUp(u4) --[[ Line: 36 ]]
    pcall(function() --[[ Line: 37 ]]
        -- upvalues: u4 (copy)
        u4._x9dfab354fc7fd1f6 = "dead";
        u4._x56e388840ebb3dc6:Clean();
    end);
end;
function u1._xe53615d96cf36a6b(_) --[[ Line: 43 ]] end;
return u1;
