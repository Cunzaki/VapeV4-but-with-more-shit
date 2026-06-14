-- Decompiled from: Teams.RegionCulling.Culling.ModelHidingContext
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u10 = {
    {
        Classes = {
            "BasePart",
            "Beam",
            "Decal",
            "Fire",
            "ParticleEmitter",
            "Smoke",
            "Sparkles",
            "Trail"
        },
        SetHidden = function(p1, p2) --[[ Name: SetHidden, Line 19 ]]
            p1.LocalTransparencyModifier = p2 and 1 or 0;
        end
    },
    {
        Classes = { "SurfaceGui", "BillboardGui" },
        SetHidden = function(p3, p4) --[[ Name: SetHidden, Line 28 ]]
            local v5 = p3:GetAttribute("OriginalMaxDistance");
            if p4 then
                if v5 then
                else
                    p3:SetAttribute("OriginalMaxDistance", p3.MaxDistance);
                    p3.MaxDistance = 0.0001;
                end;
            elseif v5 then
                p3:SetAttribute("OriginalMaxDistance", nil);
                p3.MaxDistance = v5;
            end;
        end
    },
    {
        Classes = { "Constraint", "GuiBase3d" },
        SetHidden = function(p6, p7) --[[ Name: SetHidden, Line 46 ]]
            if p7 then
                if p6.Visible then
                    p6:SetAttribute("WasHidden", true);
                    p6.Visible = false;
                end;
            elseif p6:GetAttribute("WasHidden") then
                p6:SetAttribute("WasHidden", nil);
                p6.Visible = true;
            end;
        end
    },
    {
        Classes = { "Dialog" },
        SetHidden = function(p8, p9) --[[ Name: SetHidden, Line 62 ]]
            if p9 then
                if p8.InUse then
                else
                    p8:SetAttribute("WasHidden", true);
                    p8.InUse = true;
                end;
            elseif p8:GetAttribute("WasHidden") then
                p8:SetAttribute("WasHidden", nil);
                p8.InUse = false;
            end;
        end
    }
};
require(script.Parent:WaitForChild("ModelCullingContext"));
local u11 = {
    SetHiddenMethodsByClass = {}
};
u11.__index = u11;
function u11.new(p12) --[[ Line: 102 ]]
    -- upvalues: u11 (copy)
    local u13 = setmetatable({
        ModelHidden = false,
        Model = p12,
        HidableInstances = {},
        HideInstanceMethods = {},
        EventConnections = {}
    }, u11);
    table.insert(u13.EventConnections, p12.DescendantAdded:Connect(function(p14) --[[ Line: 113 ]]
        -- upvalues: u13 (copy)
        u13:AddInstances(p14);
    end));
    table.insert(u13.EventConnections, p12.DescendantRemoving:Connect(function(p15) --[[ Line: 116 ]]
        -- upvalues: u13 (copy)
        local v16 = table.find(u13.HidableInstances, p15);
        if v16 then
            table.remove(u13.HidableInstances, v16);
            u13.HideInstanceMethods[p15] = nil;
            if u13.ModelHidden then
                p15.LocalTransparencyModifier = 0;
            end;
        end;
    end));
    for _, v17 in p12:GetDescendants() do
        u13:AddInstances(v17);
    end;
    return u13;
end;
function u11.AddInstances(p18, p19) --[[ Line: 138 ]]
    -- upvalues: u10 (copy)
    if p18.SetHiddenMethodsByClass[p19.ClassName] == nil then
        local v20 = false;
        for _, v21 in u10 do
            local v22 = false;
            for _, v23 in v21.Classes do
                if p19:IsA(v23) then
                    v22 = true;
                    break;
                end;
            end;
            if v22 then
                p18.SetHiddenMethodsByClass[p19.ClassName] = v21.SetHidden;
                v20 = true;
            end;
        end;
        if not v20 then
            p18.SetHiddenMethodsByClass[p19.ClassName] = false;
        end;
    end;
    local v24 = p18.SetHiddenMethodsByClass[p19.ClassName];
    if v24 then
        table.insert(p18.HidableInstances, p19);
        p18.HideInstanceMethods[p19] = v24;
        if p18.ModelHidden then
            v24(p19, true);
        end;
    end;
end;
function u11.EnableFlattening(p25, _) --[[ Line: 175 ]]
    return p25;
end;
function u11.EnableClustering(p26, _) --[[ Line: 183 ]]
    return p26;
end;
function u11.AddFlatteningFilter(p27, _) --[[ Line: 191 ]]
    return p27;
end;
function u11.FlattenModel(_) --[[ Line: 199 ]] end;
function u11.GetSummary(p28) --[[ Line: 207 ]]
    return {
        FlattenedParts = 0,
        UnflattenedParts = 0,
        Model = p28.Model,
        Issues = {}
    };
end;
function u11.SetVisibility(p29, p30, p31) --[[ Line: 219 ]]
    if p29.ModelHidden ~= p30 or not p29.LastUpdateIndex then
        p29.ModelHidden = p30;
        p29.LastUpdateIndex = 1;
    end;
    local l__LastUpdateIndex__1 = p29.LastUpdateIndex;
    local l__HidableInstances__2 = p29.HidableInstances;
    local l__HideInstanceMethods__3 = p29.HideInstanceMethods;
    local v32 = math.min(l__LastUpdateIndex__1 + p31 - 1, #l__HidableInstances__2);
    for v33 = l__LastUpdateIndex__1, v32 do
        local v34 = l__HidableInstances__2[v33];
        l__HideInstanceMethods__3[v34](v34, p30);
    end;
    p29.LastUpdateIndex = v32 + 1;
    return p31 - math.max(0, v32 - l__LastUpdateIndex__1 + 1);
end;
function u11.HideModel(p35, p36) --[[ Line: 243 ]]
    return p35:SetVisibility(true, p36);
end;
function u11.ShowModel(p37, p38) --[[ Line: 251 ]]
    return p37:SetVisibility(false, p38);
end;
return u11;
