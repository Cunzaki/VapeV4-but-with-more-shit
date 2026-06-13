-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.Packages._Index.thenexusavenger_nexus-vr-core@2.2.2.nexus-vr-core.Container.BaseScreenGui
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__NexusInstance__1 = require(script.Parent.Parent:WaitForChild("Packages"):WaitForChild("NexusInstance"));
local v1 = {
    ClassName = "BaseScreenGui"
};
v1.__index = v1;
function v1.__new(p2, u3) --[[ Line: 27 ]]
    p2.Container = u3;
    local u4 = {};
    p2.NonReplicatedProperties = u4;
    local v5 = getmetatable(p2);
    local l____index__2 = v5.__index;
    function v5.__index(p6, p7) --[[ Line: 35 ]]
        -- upvalues: l____index__2 (copy), u4 (copy), u3 (copy)
        local v8 = l____index__2(p6, p7);
        if v8 == nil and not u4[p7] then
            return u3[p7];
        else
            return v8;
        end;
    end;
    p2:OnAnyPropertyChanged(function(p9, p10) --[[ Line: 47 ]]
        -- upvalues: u4 (copy), u3 (copy)
        if u4[p9] then
        else
            u3[p9] = p10;
        end;
    end);
    p2:DisableChangeReplication("RotationOffset");
    p2.RotationOffset = CFrame.identity;
    p2:DisableChangeReplication("Depth");
    p2.Depth = 5;
    p2:DisableChangeReplication("FieldOfView");
    p2.FieldOfView = 0.8726646259971648;
    if not u3:IsA("SurfaceGui") then
        p2:DisableChangeReplication("CanvasSize");
    end;
    p2.CanvasSize = Vector2.new(1000, 1000);
    p2:DisableChangeReplication("Easing");
    p2.Easing = 0;
    p2:DisableChangeReplication("PointingEnabled");
    p2.PointingEnabled = true;
end;
function v1.IsA(_, p11) --[[ Line: 73 ]]
    warn("BaseScreenGui::IsA is deprecated.");
    return (p11 == "NexusObject" or p11 == "NexusInstance") and true or p11 == "BaseScreenGui";
end;
function v1.DisableChangeReplication(p12, p13) --[[ Line: 81 ]]
    p12.NonReplicatedProperties[p13] = true;
end;
function v1.GetContainer(p14) --[[ Line: 88 ]]
    return p14.Container;
end;
function v1.Destroy(p15) --[[ Line: 95 ]]
    p15.Container:Destroy();
end;
return l__NexusInstance__1.ToInstance(v1);
