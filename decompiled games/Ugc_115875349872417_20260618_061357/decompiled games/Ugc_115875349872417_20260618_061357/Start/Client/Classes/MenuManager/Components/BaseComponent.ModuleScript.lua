-- Decompiled from: Start.Client.Classes.MenuManager.Components.BaseComponent
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
local _ = require(script.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local _ = game.Players.LocalPlayer;
function u1.new(p2) --[[ Line: 20 ]]
    -- upvalues: u1 (copy), l__Trove__2 (copy)
    local u3 = setmetatable({}, u1);
    u3.target = p2;
    u3.trove = l__Trove__2.new();
    u3.dead = false;
    u3.mounted = false;
    u3.owns_target = false;
    u3.destroy_with_target = true;
    if u3.destroy_with_target then
        u3.target.Destroying:Once(function() --[[ Line: 32 ]]
            -- upvalues: u3 (copy)
            u3:Destroy();
        end);
    end;
    return u3;
end;
function u1.Destroy(p4) --[[ Line: 40 ]]
    if p4.dead then
    else
        p4.dead = true;
        p4.mounted = false;
        p4.trove:Clean();
        if p4.owns_target then
            p4.target:Destroy();
            p4.target = nil;
        end;
    end;
end;
return u1;
