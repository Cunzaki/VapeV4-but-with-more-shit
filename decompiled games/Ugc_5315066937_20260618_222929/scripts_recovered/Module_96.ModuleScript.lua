-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("Signal");
local v2 = l__obtain__1("CustomEnums");
local l__VIEW_FIRST_PERSON__2 = v2.VIEW_FIRST_PERSON;
local l__VIEW_THIRD_PERSON__3 = v2.VIEW_THIRD_PERSON;
local v3 = l__obtain__1("ContextManager");
local l__GetContext__4 = v3.GetContext;
local u4 = l__obtain__1("GameControls");
local u5 = l__obtain__1("CustomCamera")();
local v6 = l__obtain__1("RenderManager");
local u7 = l__obtain__1("FixLocalPlayer");
local l__UpdateViewPlayer__5 = l__obtain__1("VisibilityManager").UpdateViewPlayer;
local u8 = l__obtain__1("RobloxCamera");
local u9 = Instance.new("ColorCorrectionEffect", u8);
local v10 = v1();
local u11 = v1();
local u12 = v1();
local u13 = {
    ModeCount = 2,
    Player = "Local",
    CameraPunch = true,
    JumpSounds = true,
    Mode = l__VIEW_FIRST_PERSON__2,
    Camera = u5,
    OutputSignal = v10,
    ModeChanged = u11,
    PlayerChanged = u12
};
function u13.SetMode(p14) --[[ Line: 42 ]]
    -- upvalues: u13 (copy), u11 (copy)
    u13.Mode = p14;
    u11:Call(p14);
end;
function u13.SetPlayer(p15) --[[ Line: 46 ]]
    -- upvalues: u13 (copy), u12 (copy)
    u13.Player = p15;
    u12:Call(p15);
end;
u11:Add(function(p16) --[[ Line: 50 ]]
    -- upvalues: l__VIEW_THIRD_PERSON__3 (copy), u5 (copy)
    if p16 == l__VIEW_THIRD_PERSON__3 then
        u5:NoBlunder();
    end;
end);
u12:Add(function(p17) --[[ Line: 55 ]]
    -- upvalues: l__GetContext__4 (copy), u13 (copy), l__UpdateViewPlayer__5 (copy), u7 (copy)
    local v18 = l__GetContext__4(p17);
    u13.PlaybackContext = v18;
    l__UpdateViewPlayer__5(u7(p17), v18);
end);
v3.ContextChanged:Add(function(p19) --[[ Line: 60 ]]
    -- upvalues: u13 (copy)
    if u13.Player == p19.Player then
        u13.PlaybackContext = p19;
    end;
end);
v6.Bind("View", function() --[[ Line: 66 ]]
    -- upvalues: u13 (copy), l__VIEW_FIRST_PERSON__2 (copy), u5 (copy), l__VIEW_THIRD_PERSON__3 (copy), u4 (copy), u8 (copy), u9 (copy)
    local l__PlaybackContext__6 = u13.PlaybackContext;
    if l__PlaybackContext__6 then
        local v20 = l__PlaybackContext__6.Timer:Time();
        l__PlaybackContext__6:FixWorld();
        l__PlaybackContext__6.World:UpdateStaticVisible();
        l__PlaybackContext__6.World:UpdateDynamicVisible(v20, l__PlaybackContext__6.Camera);
        local l__Context__7 = l__PlaybackContext__6.Context;
        if u13.Mode == l__VIEW_FIRST_PERSON__2 then
            u5:CopyState(l__PlaybackContext__6.Camera);
            if u13.CameraPunch == false then
                u5:NoBlunder();
            end;
            u5:SetZooming(l__Context__7:GetControlState("Zoom"));
            local v21 = l__Context__7:GetAngles();
            if v21 then
                u5:SetAngles(v21);
            end;
        elseif u13.Mode == l__VIEW_THIRD_PERSON__3 then
            u5:SetFOV(90);
            u5:SetZooming(false);
            u5:MoveTo(u4.MousePos);
        end;
        u5:SetTime(v20);
        u8.FieldOfView = u5:GetFOV();
        local v22, _, v23 = l__Context__7:GetPV();
        if v22 then
            u8.CFrame = u5:ModeCFrame(u13.Mode, v22 + l__PlaybackContext__6.MapOffset);
        end;
        if v23 then
            u9.Enabled = true;
            u9.Saturation = -math.min(1, v23);
            return;
        end;
        u9.Enabled = false;
    end;
end);
return u13;
