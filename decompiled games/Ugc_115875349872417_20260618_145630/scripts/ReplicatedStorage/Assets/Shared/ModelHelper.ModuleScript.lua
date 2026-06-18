-- Decompiled from: ReplicatedStorage.Assets.Shared.ModelHelper
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent;
local l__Warn__2 = require(script.Parent.Warn);
local l__Holder__3 = require(l__Parent__1.Holder);
require(l__Parent__1.Config);
require(l__Parent__1.Types);
local u1 = 0;
local function u4() --[[ Line: 59 ]]
    local v2 = Instance.new("Model");
    v2.Name = "TempModel";
    local v3 = Instance.new("Part");
    v3.Name = "Failed To Get Model";
    v3.Size = Vector3.new(3, 5, 3);
    v3.Anchored = true;
    v3.Parent = v2;
    v2.PrimaryPart = v3;
    v2.Parent = workspace;
    return v2, "CUSTOM";
end;
return {
    TAG = "CHRONO_MODEL_REPLICATOR",
    CHRONO_META_NAME = "__CHRONO_MODEL_META_ID",
    ReadyModelFromRep = function(p5, p6) --[[ Name: ReadyModelFromRep, Line 11 ]]
        -- upvalues: u1 (ref), l__Warn__2 (copy)
        local l__model__4 = p5.model;
        local l__modelString__5 = p5.modelString;
        local v7 = p5.modelReplicationMode or "NATIVE";
        if v7 ~= "NATIVE" or not l__model__4 then
            if v7 == "CUSTOM" then
                if l__modelString__5 then
                    return l__modelString__5;
                end;
                local l___CUSTOM_MODEL_REP__6 = script.Parent.Parent.Shared._CUSTOM_MODEL_REP;
                if p6 then
                    local l__PlayerGui__7 = p6.PlayerGui;
                    l___CUSTOM_MODEL_REP__6 = l__PlayerGui__7:FindFirstChild("_ChronoClientModels");
                    if not l__PlayerGui__7:FindFirstChild("_ChronoClientModels") then
                        l___CUSTOM_MODEL_REP__6 = Instance.new("ScreenGui");
                        l___CUSTOM_MODEL_REP__6.ResetOnSpawn = false;
                        l___CUSTOM_MODEL_REP__6.Name = "_ChronoClientModels";
                        l___CUSTOM_MODEL_REP__6.Parent = l__PlayerGui__7;
                    end;
                end;
                if l__model__4 then
                    l__model__4.Archivable = true;
                    local u8 = l__model__4:Clone();
                    u8.Parent = l___CUSTOM_MODEL_REP__6;
                    task.delay(2, function() --[[ Line: 48 ]]
                        -- upvalues: u8 (copy)
                        u8:Destroy();
                    end;
                    return u8;
                end;
            elseif l__modelString__5 then
                l__Warn__2.medium((`{l__modelString__5} is not a valid model string for entity {p5.id}`));
            end;
            return nil, nil;
        end;
        local v9 = l__model__4:GetAttribute("__CHRONO_MODEL_META_ID");
        if not v9 then
            v9 = "CHRONO_" .. tostring(u1);
            l__model__4:SetAttribute("__CHRONO_MODEL_META_ID", v9);
            l__model__4:AddTag("CHRONO_MODEL_REPLICATOR");
            u1 = u1 + 1;
        end;
        return l__model__4, v9;
    end,
    CreateModelFromData = function(p10) --[[ Name: CreateModelFromData, Line 75 ]]
        -- upvalues: l__Parent__1 (copy), l__Holder__3 (copy), u4 (copy)
        if p10 then
            if type(p10) == "string" then
                return p10, nil;
            end;
            if p10.Parent ~= l__Parent__1._CUSTOM_MODEL_REP and (not p10.Parent or (p10.Parent.Name ~= "_ChronoClientModels" or not (p10.Parent.Parent and p10.Parent.Parent:IsA("PlayerGui")))) then
                return p10, "NATIVE";
            end;
            local v11 = p10:Clone();
            if not v11 then
                return u4();
            end;
            v11.Parent = l__Holder__3.GetEntityStorageInstance();
            return v11, "CUSTOM";
        end;
    end
};
