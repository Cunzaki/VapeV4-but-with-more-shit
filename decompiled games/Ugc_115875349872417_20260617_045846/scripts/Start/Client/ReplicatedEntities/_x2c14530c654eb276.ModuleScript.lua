-- Decompiled from: Start.Client.ReplicatedEntities._x2c14530c654eb276
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

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
function u1._x83ed94bfb82a8c9f(p2) --[[ Line: 29 ]]
    -- upvalues: u1 (copy), l__Trove__2 (copy)
    local u3 = setmetatable({}, u1);
    u3._xc5ae78e6b69f5669 = "inactive";
    u3._x2401f1dccc8d59b5 = p2;
    u3._x5e23eb3dedcea17d = l__Trove__2.new();
    u3._x5e23eb3dedcea17d:Add(u3._x2401f1dccc8d59b5);
    u3._x2401f1dccc8d59b5.Destroying:Connect(function() --[[ Line: 38 ]]
        -- upvalues: u3 (copy)
        u3:cleanUp();
    end);
    return u3;
end;
function u1.cleanUp(u4) --[[ Line: 45 ]]
    pcall(function() --[[ Line: 46 ]]
        -- upvalues: u4 (copy)
        u4._xc5ae78e6b69f5669 = "dead";
        u4._x5e23eb3dedcea17d:Clean();
    end);
end;
function u1._x44bcd6af41218f92(_) --[[ Line: 52 ]] end;
return u1;
