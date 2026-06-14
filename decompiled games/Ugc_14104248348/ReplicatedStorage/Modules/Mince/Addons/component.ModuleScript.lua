-- Decompiled from: ReplicatedStorage.Modules.Mince.Addons.component
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Workspace__1 = game:GetService("Workspace");
local l__CollectionService__2 = game:GetService("CollectionService");
local u1 = nil;
local l__MinceRef__3 = _G.MinceRef;
local u2 = {
    ComponentReigstry = {}
};
u2.__index = u2;
function u2.newComponent(u3) --[[ Line: 16 ]]
    -- upvalues: u2 (copy), l__MinceRef__3 (copy)
    local u4 = setmetatable(u3, u2);
    local function v7() --[[ Line: 18 ]]
        -- upvalues: u2 (ref), u4 (copy), u3 (copy)
        local v5 = not u2.ComponentReigstry[u4.Tag];
        local v6 = `There is already a component by the name of '{u4.Tag}'`;
        assert(v5, v6);
        u2.ComponentReigstry[u4.Tag] = u4;
        assert(u3.Construct, "Construct Method is needed for an component.");
        u4:__Create(u3);
    end;
    u4.Registry = {};
    u4.Added = l__MinceRef__3.Signal.new();
    l__MinceRef__3:WhenStart(v7);
    return u4;
end;
function u2.CallTable(_, u8) --[[ Line: 34 ]]
    return setmetatable({}, {
        __index = function(p9, u10) --[[ Name: __index, Line 39 ]]
            -- upvalues: u8 (copy)
            local v13 = setmetatable({}, {
                __call = function(_, _, ...) --[[ Name: __call, Line 42 ]]
                    -- upvalues: u8 (ref), u10 (copy)
                    u8(u10, ...);
                end,
                __index = function(p11, u12) --[[ Name: __index, Line 45 ]]
                    -- upvalues: u10 (copy), u8 (ref)
                    rawset(p11, u10, function(_, ...) --[[ Line: 46 ]]
                        -- upvalues: u8 (ref), u10 (ref), u12 (copy)
                        u8({ u10, u12 }, ...);
                    end);
                    return rawget(p11, u10);
                end
            });
            rawset(p9, u10, v13);
            return rawget(p9, u10);
        end
    });
end;
function u2.__ConnectCommunicationMethods(u14, u15) --[[ Line: 59 ]]
    -- upvalues: u1 (ref)
    if u1 == "Server" then
        u15.Client = u14:CallTable(function(p16, ...) --[[ Line: 62 ]]
            -- upvalues: u14 (copy), u15 (copy)
            if typeof(p16) == "table" then
                if p16[2] == "Fire" then
                    u14.CommunicationEvent[p16[2]](u14.CommunicationEvent, ..., p16[1], u15.Instance, select(2, ...));
                else
                    u14.CommunicationEvent[p16[2]](u14.CommunicationEvent, p16[1], u15.Instance, ...);
                end;
            else
                u14.CommunicationEvent:FireAll(p16, u15.Instance, ...);
            end;
        end);
    elseif u1 == "Client" then
        u15.Server = u14:CallTable(function(p17, _, ...) --[[ Line: 78 ]]
            -- upvalues: u14 (copy), u15 (copy)
            if typeof(p17) == "table" then
                if not u14.WhitelistedMethods[p17[1]] then
                    error((`The '{p17[1]}' is not whitelisted from the server!`));
                end;
                u14.CommunicationEvent[p17[2]](u14.CommunicationEvent, p17[1], u15.Instance, ...);
            else
                if not u14.WhitelistedMethods[p17] then
                    error((`The Method '{p17}' is not whitelisted from the server!`));
                end;
                u14.CommunicationEvent:Fire(p17, u15.Instance, ...);
            end;
        end);
    end;
    u15.__IsCommunicationReady = true;
end;
function u2.__CreateCommunicationMethods(u18) --[[ Line: 98 ]]
    -- upvalues: l__MinceRef__3 (copy), u1 (ref), l__Workspace__1 (copy)
    u18.CommunicationEvent = l__MinceRef__3:GetEvent(u18.Tag);
    u18[u1] = u18:CallTable(function(_) --[[ Line: 101 ]]
        -- upvalues: u1 (ref)
        error((`You cannot use '{u1}'! Please use the opposite identity!`));
    end);
    if u1 == "Server" then
        u18.CommunicationEvent.Event:Connect(function(p19, p20, p21, ...) --[[ Line: 106 ]]
            -- upvalues: u18 (copy)
            local v22 = typeof(p20) == "string";
            assert(v22, "Invalid communication method through communication event!");
            local v23 = typeof(p21) == "Instance";
            assert(v23, "Invalid communication method through communication event!");
            u18:CallExisting(p20, p21, p19, ...);
        end);
    elseif u1 == "Client" then
        local u24 = u18.CommunicationConfiguration:GetAttributes();
        u18.CommunicationConfiguration.AttributeChanged:Connect(function(p25) --[[ Line: 114 ]]
            -- upvalues: u24 (copy), u18 (copy)
            u24[p25] = u18.CommunicationConfiguration:GetAttribute(p25);
        end);
        u18.CommunicationEvent.Event:Connect(function(p26, p27, ...) --[[ Line: 118 ]]
            -- upvalues: l__Workspace__1 (ref), u18 (copy)
            if l__Workspace__1.StreamingEnabled and not p27 then
            else
                local v28 = typeof(p26) == "string";
                assert(v28, "Invalid communication method through communication event!");
                local v29 = typeof(p27) == "Instance";
                assert(v29, "Invalid communication method through communication event!");
                u18:CallExisting(p26, p27, ...);
            end;
        end);
        u18.WhitelistedMethods = u24;
    end;
    for _, v30 in u18:GetAll() do
        if not v30.__IsCommunicationReady then
            u18:__ConnectCommunicationMethods(v30);
        end;
    end;
    u18.CommunicationReady = true;
end;
function u2.__Create(u31, p32) --[[ Line: 138 ]]
    -- upvalues: u1 (ref), l__CollectionService__2 (copy)
    u31.ModuleContainer = p32;
    u31.ExistanceEvents = {};
    u31.InstanceEvents = {};
    u31.Connected = true;
    if u31.CommunicationMethods and u1 == "Server" then
        u31.CommunicationConfiguration = Instance.new("Configuration");
        u31.CommunicationConfiguration.Name = u31.Tag;
        u31.CommunicationConfiguration.Parent = script;
        for _, v33 in u31.CommunicationMethods do
            u31.CommunicationConfiguration:SetAttribute(v33, true);
        end;
        u31:__CreateCommunicationMethods();
    elseif u1 == "Client" then
        u31.CommunicationConfiguration = script:FindFirstChild(u31.Tag);
        if u31.CommunicationConfiguration then
            u31:__CreateCommunicationMethods();
        else
            u31.ExistanceEvents.CommAdded = script.ChildAdded:Connect(function(p34) --[[ Line: 165 ]]
                -- upvalues: u31 (copy)
                if p34.Name == u31.Tag then
                    u31.CommunicationConfiguration = p34;
                    u31.ExistanceEvents.CommAdded:Disconnect();
                    u31:__CreateCommunicationMethods();
                end;
            end);
        end;
    end;
    u31.ExistanceEvents.Removed = l__CollectionService__2:GetInstanceRemovedSignal(u31.Tag):Connect(function(p35) --[[ Line: 175 ]]
        -- upvalues: u31 (copy)
        u31:InstanceRemoved(p35);
    end);
    u31.ExistanceEvents.Added = l__CollectionService__2:GetInstanceAddedSignal(u31.Tag):Connect(function(p36) --[[ Line: 179 ]]
        -- upvalues: u31 (copy)
        u31:InstanceAddedOrExisted(p36);
    end);
    for _, u37 in l__CollectionService__2:GetTagged(u31.Tag) do
        task.defer(function() --[[ Line: 185 ]]
            -- upvalues: u31 (copy), u37 (copy)
            u31:InstanceAddedOrExisted(u37, true);
        end);
    end;
end;
function u2.CallExisting(p38, p39, p40, ...) --[[ Line: 191 ]]
    if p38[p39] then
        local v41 = p38:Get(p40);
        if v41 then
            p38[p39](v41, ...);
        end;
    end;
end;
function u2.NewSubComponent(u42, u43) --[[ Line: 199 ]]
    local u44 = u43:GetAttributes();
    u43.AttributeChanged:Connect(function(p45) --[[ Line: 201 ]]
        -- upvalues: u44 (copy), u43 (copy)
        u44[p45] = u43:GetAttribute(p45);
    end);
    u44.Instance = u43;
    setmetatable(u44, {
        __index = u42.ModuleContainer
    });
    if u42.AttributeDefaults then
        for v46, v47 in u42.AttributeDefaults do
            u44.Instance:SetAttribute(v46, v47);
        end;
    end;
    local v48, v49 = pcall(function() --[[ Line: 215 ]]
        -- upvalues: u42 (copy), u44 (copy)
        return u42.ModuleContainer.Construct(u44);
    end);
    if not v48 then
        warn((`Failure when contstructing component<{u42.Tag}>.`));
        warn(v49);
    end;
    if u42.CommunicationReady then
        u42:__ConnectCommunicationMethods(u44);
    end;
    u42.Added:Fire(u44);
    u42.Registry[u44.Instance] = u44;
end;
function u2.InstanceRemoved(p50, p51) --[[ Line: 233 ]]
    p50:RemoveFromRegistry(p51);
end;
function u2.CheckIfHasValidParentsToInsert(p52, p53) --[[ Line: 237 ]]
    if not (p52.CreationParents and next(p52.CreationParents)) then
        return true;
    end;
    for _, v54 in p52.CreationParents or {} do
        if p53:IsDescendantOf(v54) then
            return true;
        end;
    end;
    return false;
end;
function u2.InstanceAddedOrExisted(u55, u56, _) --[[ Line: 248 ]]
    u55.InstanceEvents[u56] = u55.InstanceEvents[u56] or {};
    local u57 = u55.InstanceEvents[u56];
    local u58 = u55:CheckIfHasValidParentsToInsert(u56);
    if u58 then
        u57.InstanceDestroying = u56.Destroying:Once(function() --[[ Line: 268 ]]
            -- upvalues: u55 (copy), u56 (copy)
            if u55.Connected then
                if u55.Registry[u56] then
                    u55:CallExisting("Destroying", u56);
                    u55:RemoveFromRegistry(u56);
                end;
            end;
        end);
        u55:NewSubComponent(u56);
    elseif u57.ParentChanging then
    else
        u57.ParentChanging = u56.AncestryChanged:Connect(function() --[[ Line: 256 ]]
            -- upvalues: u56 (copy), u58 (ref), u55 (copy), u57 (copy)
            if u56.Parent == nil then
            else
                u58 = u55:CheckIfHasValidParentsToInsert(u56);
                if u58 then
                    u57.ParentChanging:Disconnect();
                    u55:InstanceAddedOrExisted(u56, true);
                end;
            end;
        end);
    end;
end;
function u2.RemoveFromRegistry(p59, p60) --[[ Line: 279 ]]
    if p59.Registry[p60] then
        for _, v61 in p59.InstanceEvents[p60] or {} do
            v61:Disconnect();
        end;
        p59:CallExisting("Removing", p60);
        p59.Registry[p60] = nil;
    end;
end;
function u2.Get(p62, p63) --[[ Line: 291 ]]
    return p62.Registry[p63];
end;
function u2.GetAll(p64) --[[ Line: 295 ]]
    local v65 = {};
    for _, v66 in p64.Registry do
        table.insert(v65, v66);
    end;
    return v65;
end;
function u2.GetComponentAddedSignal(p67) --[[ Line: 303 ]]
    return p67.Added;
end;
local v76 = {
    Component = function(p68) --[[ Name: Component, Line 310 ]]
        -- upvalues: u2 (copy)
        return u2.newComponent(p68);
    end,
    SetupComponent = function(p69, u70) --[[ Name: SetupComponent, Line 314 ]]
        -- upvalues: l__CollectionService__2 (copy)
        local function v74(u71) --[[ Line: 315 ]]
            -- upvalues: u70 (copy)
            local u72 = u71:GetAttributes();
            u71.AttributeChanged:Connect(function(p73) --[[ Line: 317 ]]
                -- upvalues: u72 (copy), u71 (copy)
                u72[p73] = u71:GetAttribute(p73);
            end);
            u72.Instance = u71;
            task.spawn(u70, u72);
        end;
        for _, v75 in l__CollectionService__2:GetTagged(p69) do
            task.spawn(v74, v75);
        end;
        l__CollectionService__2:GetInstanceAddedSignal(p69):Connect(v74);
    end
};
return {
    Server = v76,
    Client = v76,
    Identity = function(p77) --[[ Name: Identity, Line 336 ]]
        -- upvalues: u1 (ref)
        u1 = p77;
    end
};
