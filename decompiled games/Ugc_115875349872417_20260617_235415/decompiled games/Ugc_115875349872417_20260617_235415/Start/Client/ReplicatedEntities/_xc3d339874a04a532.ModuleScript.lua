-- Decompiled from: Start.Client.ReplicatedEntities._xc3d339874a04a532
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

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
function u1._xafd29f1684593d0b(p2) --[[ Line: 29 ]]
    -- upvalues: u1 (copy), l__Trove__2 (copy)
    local u3 = setmetatable({}, u1);
    u3._x2021efd2ee6b8613 = "inactive";
    u3._x4755799bd25529a3 = p2;
    u3._x8c9d61d42d259b94 = l__Trove__2.new();
    u3._x8c9d61d42d259b94:Add(u3._x4755799bd25529a3);
    u3._x4755799bd25529a3.Destroying:Connect(function() --[[ Line: 38 ]]
        -- upvalues: u3 (copy)
        u3:cleanUp();
    end);
    return u3;
end;
function u1.cleanUp(u4) --[[ Line: 45 ]]
    pcall(function() --[[ Line: 46 ]]
        -- upvalues: u4 (copy)
        u4._x2021efd2ee6b8613 = "dead";
        u4._x8c9d61d42d259b94:Clean();
    end);
end;
function u1._xd8041402b83e75db(_) --[[ Line: 52 ]] end;
return u1;
