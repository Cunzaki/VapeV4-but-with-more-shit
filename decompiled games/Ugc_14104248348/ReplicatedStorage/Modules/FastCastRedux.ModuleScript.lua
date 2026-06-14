-- Decompiled from: ReplicatedStorage.Modules.FastCastRedux
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    DebugLogging = false,
    VisualizeCasts = false
};
u1.__index = u1;
u1.__type = "FastCast";
u1.HighFidelityBehavior = {
    Default = 1,
    Always = 3
};
local l__ActiveCast__1 = require(script.ActiveCast);
local l__Signal__2 = require(script.Signal);
require(script.Table);
require(script.TypeDefinitions);
l__ActiveCast__1.SetStaticFastCastReference(u1);
function u1.new() --[[ Line: 107 ]]
    -- upvalues: l__Signal__2 (copy), u1 (copy)
    local v2 = {
        LengthChanged = l__Signal__2.new("LengthChanged"),
        RayHit = l__Signal__2.new("RayHit"),
        RayPierced = l__Signal__2.new("RayPierced"),
        CastTerminating = l__Signal__2.new("CastTerminating"),
        WorldRoot = workspace
    };
    return setmetatable(v2, u1);
end;
function u1.newBehavior() --[[ Line: 119 ]]
    -- upvalues: u1 (copy)
    return {
        RaycastParams = nil,
        MaxDistance = 1000,
        CanPierceFunction = nil,
        HighFidelitySegmentSize = 0.5,
        CosmeticBulletTemplate = nil,
        CosmeticBulletProvider = nil,
        CosmeticBulletContainer = nil,
        AutoIgnoreContainer = true,
        Acceleration = Vector3.new(),
        HighFidelityBehavior = u1.HighFidelityBehavior.Default
    };
end;
local u3 = u1.newBehavior();
function u1.Fire(p4, p5, p6, p7, p8) --[[ Line: 136 ]]
    -- upvalues: u3 (copy), l__ActiveCast__1 (copy)
    if p8 == nil then
        p8 = u3;
    end;
    local v9 = l__ActiveCast__1.new(p4, p5, p6, p7, p8);
    v9.RayInfo.WorldRoot = p4.WorldRoot;
    return v9;
end;
return u1;
