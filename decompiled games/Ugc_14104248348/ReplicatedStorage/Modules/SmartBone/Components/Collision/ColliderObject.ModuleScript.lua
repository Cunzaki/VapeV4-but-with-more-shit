-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Components.Collision.ColliderObject
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Collider__1 = require(script.Parent:WaitForChild("Collider"));
local l__SB_VERBOSE_LOG__2 = require(script.Parent.Parent.Parent:WaitForChild("Dependencies"):WaitForChild("Utilities")).SB_VERBOSE_LOG;
local u1 = {};
u1.__index = u1;
function u1.new(p2, u3) --[[ Line: 57 ]]
    -- upvalues: u1 (copy)
    local u4 = setmetatable({
        m_Awake = true,
        m_LastSleepCycle = 0,
        Destroyed = false,
        m_Object = u3,
        Colliders = {}
    }, u1);
    u4:m_LoadColliderTable(p2);
    u4.DestroyConnection = u3:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 68 ]]
        -- upvalues: u3 (copy), u4 (copy)
        if u3.Parent == nil then
            u4.Destroyed = true;
        end;
    end);
    return u4;
end;
function u1.m_LoadCollider(p5, p6) --[[ Line: 80 ]]
    -- upvalues: l__Collider__1 (copy)
    local v7 = Vector3.new(p6.ScaleX, p6.ScaleY, p6.ScaleZ);
    local v8 = Vector3.new(p6.OffsetX, p6.OffsetY, p6.OffsetZ);
    local v9 = Vector3.new(p6.RotationX, p6.RotationY, p6.RotationZ);
    local v10 = l__Collider__1.new();
    v10.Scale = v7;
    v10.Offset = v8;
    v10.Rotation = v9;
    v10.Type = p6.Type;
    v10:SetObject(p5.m_Object);
    table.insert(p5.Colliders, v10);
end;
function u1.m_LoadColliderTable(p11, p12) --[[ Line: 98 ]]
    for _, v13 in p12 do
        p11:m_LoadCollider(v13);
    end;
end;
function u1.GetObject(p14) --[[ Line: 108 ]]
    return p14.m_Object;
end;
function u1.GetCollisions(p15, p16, p17) --[[ Line: 116 ]]
    if not p15.m_Object then
        return {};
    end;
    if #p15.Colliders == 0 then
        return {};
    end;
    if os.clock() - p15.m_LastSleepCycle >= 0.2 then
        p15.m_LastSleepCycle = os.clock();
        if p15.m_Object:IsDescendantOf(workspace) then
            p15.m_Awake = true;
        else
            p15.m_Awake = false;
        end;
    end;
    if not p15.m_Awake then
        return {};
    end;
    local v18 = {};
    for _, v19 in p15.Colliders do
        local v20, v21, v22 = v19:GetClosestPoint(p16, p17);
        if v20 then
            table.insert(v18, {
                ClosestPoint = v21,
                Normal = v22
            });
        end;
    end;
    return v18;
end;
function u1.Step(p23) --[[ Line: 164 ]]
    for _, v24 in p23.Colliders do
        v24:Step();
    end;
end;
function u1.DrawDebug(p25, p26, p27, p28, p29) --[[ Line: 177 ]]
    for _, v30 in p25.Colliders do
        v30:DrawDebug(p25, p26, p27, p28, p29);
        v30.InNarrowphase = false;
    end;
end;
function u1.Destroy(p31) --[[ Line: 185 ]]
    -- upvalues: l__SB_VERBOSE_LOG__2 (copy)
    task.synchronize();
    l__SB_VERBOSE_LOG__2((`Collider object destroying, object: {p31.m_Object}`));
    p31.DestroyConnection:Disconnect();
    if #p31.Colliders ~= 0 then
        for _, v32 in p31.Colliders do
            v32:Destroy();
        end;
    end;
    setmetatable(p31, nil);
    task.desynchronize();
end;
return u1;
