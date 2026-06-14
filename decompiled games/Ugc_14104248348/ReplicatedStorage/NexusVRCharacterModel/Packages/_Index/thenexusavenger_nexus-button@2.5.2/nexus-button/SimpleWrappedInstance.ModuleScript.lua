-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-button@2.5.2.nexus-button.SimpleWrappedInstance
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__NexusInstance__1 = require(script.Parent:WaitForChild("Packages"):WaitForChild("NexusInstance"));
local v1 = {};
v1.__index = v1;
function v1.__new(u2, u3) --[[ Line: 20 ]]
    local u4 = {};
    u2.WrappedInstance = u3;
    u2.DisabledReplicationProperties = u4;
    local v5 = getmetatable(u2);
    local l____index__2 = v5.__index;
    function v5.__index(p6, p7) --[[ Line: 29 ]]
        -- upvalues: l____index__2 (copy), u4 (copy), u3 (copy)
        local v8 = l____index__2(p6, p7);
        if v8 ~= nil then
            return v8;
        end;
        if u4[p7] then
            return nil;
        end;
        local u9 = u3[p7];
        return typeof(u9) == "function" and function(_, ...) --[[ Line: 40 ]]
            -- upvalues: u9 (copy), u3 (ref)
            return u9(u3, ...);
        end or u9;
    end;
    u2:OnAnyPropertyChanged(function(p10, p11) --[[ Line: 48 ]]
        -- upvalues: u4 (copy), u3 (copy)
        if u4[p10] then
        else
            u3[p10] = p11;
        end;
    end);
    if typeof(u3) == "Instance" then
        u3.Changed:Connect(function(p12) --[[ Line: 53 ]]
            -- upvalues: u4 (copy), l____index__2 (copy), u2 (copy), u3 (copy)
            if u4[p12] then
            elseif l____index__2(u2, p12) == nil then
                u2.Changed:Fire(p12);
                local v13 = u2.PropertyChangedEvents[p12];
                if v13 then
                    v13:Fire();
                end;
            else
                u2[p12] = u3[p12];
            end;
        end);
    end;
end;
function v1.DisableChangeReplication(p14, p15) --[[ Line: 77 ]]
    p14.DisabledReplicationProperties[p15] = true;
end;
function v1.GetWrappedInstance(p16) --[[ Line: 84 ]]
    return p16.WrappedInstance;
end;
function v1.Destroy(p17) --[[ Line: 91 ]]
    if typeof(p17.WrappedInstance) == "Instance" then
        p17.WrappedInstance:Destroy();
    end;
end;
return l__NexusInstance__1.ToInstance(v1);
