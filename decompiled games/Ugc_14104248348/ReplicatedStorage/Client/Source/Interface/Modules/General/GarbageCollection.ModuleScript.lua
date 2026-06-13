-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.GarbageCollection
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__CollectionService__4 = game:GetService("CollectionService");
local l__InstanceTracking__5 = require(l__ReplicatedStorage__3.Modules.InstanceTracking);
local l__Mince__6 = require(l__ReplicatedStorage__3.Modules.Mince);
local u1 = l__Mince__6:GetFunction("GetServerGarbageCollectionSummary");
local u2 = {
    UpdateSummary = function() --[[ Name: UpdateSummary, Line 16 ]]
        -- upvalues: l__CollectionService__4 (copy), l__Players__1 (copy), l__InstanceTracking__5 (copy), l__Mince__6 (copy), u1 (copy)
        if l__CollectionService__4:HasTag(l__Players__1.LocalPlayer, "CanFetchServerGC") then
            l__InstanceTracking__5:StartTracking();
            l__Mince__6.Config.Stats.ClientGC[2] = l__InstanceTracking__5:FormatSummary();
            l__Mince__6.Config.Stats.ServerGC[2] = u1:Invoke();
        end;
    end
};
function u2.Setup() --[[ Line: 24 ]]
    -- upvalues: l__Mince__6 (copy), l__RunService__2 (copy), u2 (copy)
    l__Mince__6.Config.Stats.ClientGC = { 10, "Unavailable" };
    l__Mince__6.Config.Stats.ServerGC = { 11, "Unavailable" };
    if l__RunService__2:IsStudio() then
        task.spawn(function() --[[ Line: 32 ]]
            -- upvalues: u2 (ref)
            while true do
                u2.UpdateSummary();
                task.wait(0.5);
            end;
        end);
    end;
end;
return u2;
