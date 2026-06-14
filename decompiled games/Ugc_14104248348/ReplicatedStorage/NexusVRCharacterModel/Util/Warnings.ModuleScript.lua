-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Util.Warnings
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__HttpService__1 = game:GetService("HttpService");
return function() --[[ Line: 8 ]]
    -- upvalues: l__HttpService__1 (copy)
    local u1 = l__HttpService__1:JSONDecode(script.Parent.Parent:WaitForChild("Configuration").Value);
    local v2 = {};
    if u1.Output and u1.Output.SuppressWarnings then
        for _, v3 in u1.Output.SuppressWarnings do
            v2[string.lower(v3)] = true;
        end;
    end;
    if v2.all then
    else
        for _, v4 in {
            {
                Key = "MissingNexusVRBackpackEnabled",
                Message = "The configuration entry Extra.NexusVRBackpackEnabled is missing (defaults to true).",
                Condition = function() --[[ Name: Condition, Line 27 ]]
                    -- upvalues: u1 (copy)
                    return u1.Extra == nil and true or u1.Extra.NexusVRBackpackEnabled == nil;
                end
            },
            {
                Key = "MissingAllowClientToOutputLoadedMessage",
                Message = "The configuration entry Extra.AllowClientToOutputLoadedMessage is missing (defaults to true).",
                Condition = function() --[[ Name: Condition, Line 34 ]]
                    -- upvalues: u1 (copy)
                    return u1.Output == nil and true or u1.Output.AllowClientToOutputLoadedMessage == nil;
                end
            },
            {
                Key = "MissingDisableHeadLocked",
                Message = "The configuration entry Camera.DisableHeadLocked is missing (defaults to true).",
                Condition = function() --[[ Name: Condition, Line 41 ]]
                    -- upvalues: u1 (copy)
                    return u1.Camera == nil and true or u1.Camera.DisableHeadLocked == nil;
                end
            }
        } do
            if not v2[string.lower(v4.Key)] and v4.Condition() then
                warn(v4.Message);
                warn((`\tThis warning can be disabled by adding "{v4.Key}" or "All" to Output.SuppressWarnings in the configuration of Nexus VR Character Model.`));
            end;
        end;
    end;
end;
