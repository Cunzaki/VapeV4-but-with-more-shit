-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Client.ModelResolver
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__Warn__2 = require(script.Parent.Parent.Shared.Warn);
require(script.Parent.Parent.Shared.Config);
require(script.Parent.Parent.Shared.Types);
local l__Entity__3 = require(script.Parent.Parent.Shared.Entity);
local l__ModelHelper__4 = require(script.Parent.Parent.Shared.ModelHelper);
local l__TAG__5 = l__ModelHelper__4.TAG;
local l__CHRONO_META_NAME__6 = l__ModelHelper__4.CHRONO_META_NAME;
local u1 = {};
l__CollectionService__1:GetInstanceAddedSignal(l__TAG__5):Connect(function(p2) --[[ Name: OnInstanceAdded, Line 13 ]]
    -- upvalues: l__CHRONO_META_NAME__6 (copy), u1 (copy), l__Warn__2 (copy)
    local v3 = p2:GetAttribute(l__CHRONO_META_NAME__6);
    if v3 then
        u1[v3] = p2;
        l__Warn__2.low((`Model with meta {v3} was added to the game. Entities using this model will now be able to resolve it.`));
    end;
end);
l__CollectionService__1:GetInstanceRemovedSignal(l__TAG__5):Connect(function(p4) --[[ Line: 24 ]]
    -- upvalues: l__CHRONO_META_NAME__6 (copy), u1 (copy), l__Warn__2 (copy)
    local v5 = p4:GetAttribute(l__CHRONO_META_NAME__6);
    if v5 then
        u1[v5] = nil;
        l__Warn__2.low((`Model with meta {v5} was removed from the game. Entities using this model will no longer be able to resolve it.`));
    end;
end);
for _, v6 in l__CollectionService__1:GetTagged(l__TAG__5) do
    local v7 = v6:GetAttribute(l__CHRONO_META_NAME__6);
    if v7 then
        u1[v7] = v6;
        l__Warn__2.low((`Model with meta {v7} was added to the game. Entities using this model will now be able to resolve it.`));
    end;
end;
return function(p8) --[[ Line: 37 ]]
    -- upvalues: u1 (copy), l__Entity__3 (copy), l__Warn__2 (copy)
    local l__model__7 = p8.model;
    if l__model__7 and l__model__7.Parent then
    else
        local l___modelMetaData__8 = p8._modelMetaData;
        if l___modelMetaData__8 then
            local v9 = u1[l___modelMetaData__8];
            if v9 and v9 ~= l__model__7 then
                l__Entity__3.SetModel(p8, v9);
                l__Warn__2.low((`Model with meta {l___modelMetaData__8} was resolved for entity {p8.id}.`));
            end;
        end;
    end;
end;
