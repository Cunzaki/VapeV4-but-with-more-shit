-- Decompiled from: Workspace.Map.Areas.Aquarium.Nodes.Blacksmith.Actor.Handler
-- Class: Script
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local u1 = {};
u1.__index = u1;
u1.Node = script.Parent.Parent;
u1.Controller = require(l__ReplicatedStorage__2.Client.Source.Gameplay.Lifeforms.FishController);
u1.Object = u1.Controller.new(u1.Node);
local function v5(_) --[[ Line: 12 ]]
    -- upvalues: u1 (copy), l__RunService__1 (copy)
    if u1.Update then
        u1.Update:Disconnect();
        u1.Update = nil;
    end;
    if u1.Object.Node:GetAttribute("Active") then
        u1.Update = l__RunService__1.Heartbeat:ConnectParallel(function(p2) --[[ Line: 19 ]]
            -- upvalues: u1 (ref)
            if u1.Object and u1.Object.Node:GetAttribute("Active") then
                u1.Object.Group:Update(p2);
            end;
        end);
        for _, v3 in u1.Object.Animations do
            v3:Play();
        end;
    else
        for _, v4 in u1.Object.Animations do
            v4:Stop();
        end;
    end;
end;
if u1.Object and u1.Object.Node then
    v5(u1.Object.Node:GetAttribute("Active"));
    u1.Object.Node:GetAttributeChangedSignal("Active"):Connect(v5);
    return u1;
end;
warn("Actor Creation has failed due to unknown problems! Stopping now to stop the thread from being taken up.");
