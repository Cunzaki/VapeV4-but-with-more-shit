-- Decompiled from: Players.9qje7.PlayerScripts.SmartBone-Actors.Handle - 8B1D5F6A-0B5A-4D5F-83E6-087F51B5D78A.Runtime
-- Class: LocalScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = false;
local u6 = {};
local u7 = nil;
u7 = l__Parent__1:BindToMessage("Setup", function(p8, p9, p10) --[[ Line: 22 ]]
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u7 (ref)
    u1 = p8;
    u2 = p9;
    u3 = p10;
    u4 = require(p10);
    u5 = true;
    u7:Disconnect();
end);
local u11 = u1;
local v12 = u2;
local v13 = u3;
local v14 = u4;
repeat
    task.wait();
until u5;
local l__CollectionService__2 = game:GetService("CollectionService");
local l__RunService__3 = game:GetService("RunService");
local u15 = v14.new();
local l__Dependencies__4 = v13.Dependencies;
local l__DebugUi__5 = require(l__Dependencies__4.DebugUi);
local l__Config__6 = require(l__Dependencies__4.Config);
local l__Utilities__7 = require(l__Dependencies__4.Utilities);
local u16 = l__RunService__3:IsStudio() or l__Config__6.ALLOW_LIVE_GAME_DEBUG;
local l__OverlayEvent__8 = v13:WaitForChild("OverlayEvent");
local u17 = false;
local u18 = {
    Begin = function(...) --[[ Name: Begin, Line 52 ]]
        -- upvalues: l__OverlayEvent__8 (copy)
        l__OverlayEvent__8:Fire("Begin", ...);
    end,
    End = function(...) --[[ Name: End, Line 55 ]]
        -- upvalues: l__OverlayEvent__8 (copy)
        l__OverlayEvent__8:Fire("End", ...);
    end,
    Text = function(...) --[[ Name: Text, Line 58 ]]
        -- upvalues: l__OverlayEvent__8 (copy)
        l__OverlayEvent__8:Fire("Text", ...);
    end
};
shared.FrameCounter = 0;
local u19;
if u16 then
    u19 = require(l__Dependencies__4.Iris);
    if not u19.HasInit() then
        u19 = u19.Init();
    end;
else
    u19 = nil;
end;
l__Parent__1.Name = `{u11.Name} - {u15.ID}`;
u15:LoadObject(u11);
for _, v20 in v12 do
    u15:LoadRawCollider(v20[1], v20[2]);
end;
local u21 = u16 and {
    DRAW_BONE = u19.State(false),
    DRAW_PHYSICAL_BONE = u19.State(false),
    DRAW_ROOT_PART = u19.State(false),
    DRAW_BOUNDING_BOX = u19.State(false),
    DRAW_AXIS_LIMITS = u19.State(false),
    DRAW_COLLIDERS = u19.State(false),
    DRAW_COLLIDER_INFLUENCE = u19.State(false),
    DRAW_COLLIDER_AWAKE = u19.State(false),
    DRAW_COLLIDER_BROADPHASE = u19.State(false),
    DRAW_FILL_COLLIDERS = u19.State(false),
    DRAW_CONTACTS = u19.State(false),
    DRAW_ROTATION_LIMITS = u19.State(false),
    DRAW_ACCELERATION_INFO = u19.State(false)
} or nil;
if u16 then
    u19:Connect(function() --[[ Line: 104 ]]
        -- upvalues: u11 (ref), l__DebugUi__5 (copy), u19 (ref), u15 (copy), u21 (ref)
        if u11:GetAttribute("Debug") ~= nil then
            l__DebugUi__5(u19, u15, u21);
        end;
    end);
end;
local v25 = l__CollectionService__2:GetInstanceAddedSignal("SmartCollider"):Connect(function(p22) --[[ Line: 111 ]]
    -- upvalues: u11 (ref), l__Utilities__7 (copy), u15 (copy)
    if p22:IsA("BasePart") then
        local v23 = p22:GetAttribute("ColliderKey");
        local v24 = u11:GetAttribute("ColliderKey");
        if tostring(v23) == tostring(v24) then
            u15:LoadRawCollider(l__Utilities__7.GetCollider(p22), p22);
        end;
    end;
end);
table.insert(u6, v25);
local v26 = l__Parent__1:BindToMessage("Destroy", function() --[[ Line: 128 ]]
    -- upvalues: u17 (ref)
    u17 = true;
end);
table.insert(u6, v26);
local v30 = l__RunService__3.Heartbeat:ConnectParallel(function(p27) --[[ Line: 132 ]]
    -- upvalues: u15 (copy), u17 (ref), u6 (copy), l__Parent__1 (copy), u16 (copy), u11 (ref), u21 (ref), u18 (copy)
    local v28 = shared;
    v28.FrameCounter = v28.FrameCounter + 1;
    if shared.FrameCounter > 131072 then
        shared.FrameCounter = 0;
    end;
    u15:StepBoneTrees(p27);
    if u15.ShouldDestroy or u17 then
        u15:Destroy();
        task.synchronize();
        for _, v29 in u6 do
            v29:Disconnect();
        end;
        l__Parent__1:Destroy();
    else
        if u16 and u11:GetAttribute("Debug") ~= nil then
            task.synchronize();
            u15:DrawDebug(u21.DRAW_COLLIDERS:get(), u21.DRAW_CONTACTS:get(), u21.DRAW_PHYSICAL_BONE:get(), u21.DRAW_BONE:get(), u21.DRAW_AXIS_LIMITS:get(), u21.DRAW_ROOT_PART:get(), u21.DRAW_FILL_COLLIDERS:get(), u21.DRAW_COLLIDER_INFLUENCE:get(), u21.DRAW_COLLIDER_AWAKE:get(), u21.DRAW_COLLIDER_BROADPHASE:get(), u21.DRAW_BOUNDING_BOX:get(), u21.DRAW_ROTATION_LIMITS:get(), u21.DRAW_ACCELERATION_INFO:get());
            u15:DrawOverlay(u18);
        end;
    end;
end);
table.insert(u6, v30);
