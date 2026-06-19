-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__clone__1 = table.clone;
local l__obtain__2 = _G.obtain;
local v1 = l__obtain__2("MapManager");
local u2 = l__obtain__2("GameControls");
local l__RootTimer__3 = l__obtain__2("RealtimeTimerSystem").RootTimer;
local v3 = l__obtain__2("RenderManager");
local u4 = l__obtain__2("Simulation")(l__RootTimer__3);
u4.MovingPartsEnabled = false;
v1.MapInfoChanged:Add(function(p5) --[[ Line: 19 ]]
    -- upvalues: u4 (copy)
    u4.GameMechanics:SetMapInfo(p5);
    u4:LoadWorld(p5);
end);
local u6 = nil;
local function v8(p7) --[[ Line: 25 ]]
    -- upvalues: u6 (ref)
    u6 = p7;
end;
v3.Bind("SmoothingSimulation", function() --[[ Line: 29 ]]
    -- upvalues: u6 (ref), u4 (copy), l__clone__1 (copy), u2 (copy)
    if u6 and (u6.Ready and u4.Ready) then
        u4:CopyState(u6);
        local v9 = l__clone__1(u2);
        v9.Time = u4.Timer:Time(u2.Time);
        u4:Tick(v9);
    end;
end);
return {
    Simulation = u4,
    SetReferenceSimulation = v8
};
