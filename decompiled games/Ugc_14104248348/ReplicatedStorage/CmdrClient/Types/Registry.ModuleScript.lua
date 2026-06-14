-- Decompiled from: ReplicatedStorage.CmdrClient.Types.Registry
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__ServerStorage__2 = game:GetService("ServerStorage");
local l__RunService__3 = game:GetService("RunService");
if l__RunService__3:IsClient() then
    return function() --[[ Line: 6 ]] end;
end;
local l__OnTapMainWrapper__4 = require(l__ServerStorage__2.Modules.OnTapMainWrapper);
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
l__Mince__5:WaitUntilSetup("Server");
local u1 = l__Mince__5:Get("RobloxAPIHandler");
local u6 = {
    BeforeRun = function(u2) --[[ Name: BeforeRun, Line 17 ]]
        -- upvalues: l__Mince__5 (copy), l__RunService__3 (copy), u1 (copy), l__OnTapMainWrapper__4 (copy)
        if u2.Group == "IgnoreAnyGroup" then
        else
            local v3 = u2.Executor:GetRoleInGroup(game.CreatorId);
            if v3 then
                local v4 = false;
                for _, v5 in ipairs(l__Mince__5.Config.CommandPermissions[v3] or {}) do
                    if v5 == u2.Group then
                        v4 = true;
                    end;
                end;
                if v4 or l__RunService__3:IsStudio() then
                    task.defer(function() --[[ Line: 34 ]]
                        -- upvalues: u1 (ref), l__OnTapMainWrapper__4 (ref), u2 (copy)
                        u1.HTTPQueue:PushAndWait();
                        l__OnTapMainWrapper__4:LogAction(u2.Executor, "cmdr", u2.RawText);
                    end);
                    return;
                end;
            end;
            if u2.Executor.UserId >= 0 then
                return "You don\'t have permission to run this command";
            end;
        end;
    end
};
function u6.UponRegistery(p7) --[[ Line: 49 ]]
    -- upvalues: u6 (copy)
    p7:RegisterHook("BeforeRun", u6.BeforeRun);
end;
return u6.UponRegistery;
