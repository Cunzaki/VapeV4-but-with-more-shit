-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.ToolHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ContextActionService__1 = game:GetService("ContextActionService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__CollectionService__3 = game:GetService("CollectionService");
game:GetService("RunService");
local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
local l__Maid__5 = require(l__ReplicatedStorage__2.Modules.Maid);
local l__Mince__6 = require(l__ReplicatedStorage__2.Modules.Mince);
local l__Signal__7 = l__Mince__6.Signal;
local u1 = l__Mince__6:Get("BindManager").Get("UnifiedInteract");
local u2 = l__Mince__6:Get("SelectInteractor");
local u4 = {
    Checkings = {},
    GetEquipEvents = function(p3) --[[ Name: GetEquipEvents, Line 27 ]]
        p3:GetTags(p3);
    end
};
function u4.Component(u5) --[[ Line: 32 ]]
    -- upvalues: u4 (copy), l__Maid__5 (copy), u2 (copy), u1 (copy)
    assert(u5.Tags, "ToolHandler.Component.Tags Required!");
    local u6 = {};
    local v7 = u4.TagEquipped(u5.Tags, u5.AttributeMatches);
    v7.Equipped:Connect(function(p8) --[[ Line: 37 ]]
        -- upvalues: u6 (copy), l__Maid__5 (ref), u5 (copy)
        local v9 = u6[p8];
        if not v9 then
            local v10 = {
                Tool = p8,
                EquipMaid = l__Maid__5.new()
            };
            v9 = setmetatable(v10, {
                __index = u5
            });
        end;
        u6[p8] = v9;
        if u5.Equipped then
            u5.Equipped(v9, p8);
        end;
    end);
    v7.Unequipped:Connect(function(p11) --[[ Line: 47 ]]
        -- upvalues: u6 (copy), u5 (copy)
        local v12 = u6[p11];
        if v12 then
            u6[p11] = nil;
            v12.EquipMaid:Destroy();
            if u5.Unequipped then
                u5.Unequipped(v12, p11);
            end;
        end;
    end);
    function u5.GetActiveTool() --[[ Line: 57 ]]
        -- upvalues: u6 (copy)
        local _, v13 = next(u6);
        return v13;
    end;
    if u5.Activate then
        u2.BindToInteract(u5.InteractBind or 105, function() --[[ Line: 63 ]]
            -- upvalues: u6 (copy), u5 (copy)
            for v14, v15 in u6 do
                if u5.Activate(v15, v14) == "Sink" then
                    return "Sink";
                end;
            end;
            return "Pass";
        end);
    end;
    if u5.Interact then
        u1.OnAction:Connect(function() --[[ Line: 74 ]]
            -- upvalues: u6 (copy), u5 (copy)
            for v16, v17 in u6 do
                u5.Interact(v17, v16);
            end;
        end);
    end;
end;
function u4.TagEquipped(u18, u19) --[[ Line: 82 ]]
    -- upvalues: l__Signal__7 (copy), l__CollectionService__3 (copy), l__LocalPlayer__4 (copy), l__ContextActionService__1 (copy)
    local u20 = {
        Equipped = l__Signal__7.new(),
        Unequipped = l__Signal__7.new(),
        ExistanceEvents = {}
    };
    local function u22(p21) --[[ Line: 89 ]]
        -- upvalues: u20 (copy)
        if u20.ToolEquipped == p21 then
            u20.ToolEquipped = nil;
            u20.Unequipped:Fire(p21);
        end;
    end;
    l__ContextActionService__1.LocalToolEquipped:Connect(function(u23) --[[ Line: 97 ]]
        -- upvalues: u20 (copy), u22 (copy), u18 (copy), l__CollectionService__3 (ref), u19 (copy), l__LocalPlayer__4 (ref)
        if u20.ToolEquipped then
            task.spawn(u22, u20.ToolEquipped);
            task.wait();
        end;
        local v24 = false;
        for _, v25 in u18 do
            v24 = l__CollectionService__3:HasTag(u23, v25) and true or v24;
        end;
        if v24 then
            for _, v26 in u20.ExistanceEvents do
                v26:Disconnect();
            end;
            u20.ExistanceEvents = {};
            u20.ExistanceEvents.ParentChange = u23.AncestryChanged:Connect(function() --[[ Line: 121 ]]
                -- upvalues: l__LocalPlayer__4 (ref), u23 (copy), u20 (ref)
                if l__LocalPlayer__4.Character then
                    if u23.Parent ~= l__LocalPlayer__4.Character then
                        local v27 = u23;
                        if u20.ToolEquipped == v27 then
                            u20.ToolEquipped = nil;
                            u20.Unequipped:Fire(v27);
                        end;
                    end;
                end;
            end);
            u20.ExistanceEvents.Destroying = u23.Destroying:Connect(function() --[[ Line: 128 ]]
                -- upvalues: u23 (copy), u20 (ref)
                local v28 = u23;
                if u20.ToolEquipped == v28 then
                    u20.ToolEquipped = nil;
                    u20.Unequipped:Fire(v28);
                end;
            end);
            u20.ToolEquipped = u23;
            u20.Equipped:Fire(u23);
        end;
    end);
    l__ContextActionService__1.LocalToolUnequipped:Connect(u22);
    return u20;
end;
return u4;
