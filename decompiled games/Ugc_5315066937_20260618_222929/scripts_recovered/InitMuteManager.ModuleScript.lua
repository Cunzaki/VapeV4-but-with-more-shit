-- Decompiled from: InitMuteManager
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("Remote");
local l__Add__2 = v1.Add;
local l__Call__3 = v1.Call;
local v2 = l__obtain__1("MuteManager");
local l__GetMuted__4 = v2.GetMuted;
local l__SetCache__5 = v2.SetCache;
local l__UpdateCache__6 = v2.UpdateCache;
local l__MuteListChangedSignal__7 = v2.MuteListChangedSignal;
local l__ShowChatModerationSignal__8 = v2.ShowChatModerationSignal;
local l__SetGlobalChatModerationDisabled__9 = v2.SetGlobalChatModerationDisabled;
local l__KEY_MUTED__10 = v2.KEY_MUTED;
local l__KEY_DISABLE_GLOBAL_MUTE__11 = v2.KEY_DISABLE_GLOBAL_MUTE;
local l__Global__12 = l__obtain__1("PersistentData").Global;
local v3 = l__obtain__1("PlayerManager");
local l__Players__13 = v3.Players;
local l__LocalPlayer__14 = v3.LocalPlayer;
l__Global__12:MonitorKey(l__KEY_MUTED__10, v2.LoadIsMutedCache);
l__Global__12:MonitorKey(l__KEY_DISABLE_GLOBAL_MUTE__11, l__SetGlobalChatModerationDisabled__9);
l__SetGlobalChatModerationDisabled__9(l__Global__12:GetKey(l__KEY_DISABLE_GLOBAL_MUTE__11));
l__MuteListChangedSignal__7:Add(function() --[[ Name: SetAllVCMuted, Line 36 ]]
    -- upvalues: l__Players__13 (copy), l__LocalPlayer__14 (copy), l__GetMuted__4 (copy)
    for v4 = 1, #l__Players__13 do
        local v5 = l__Players__13[v4];
        if v5 and v5 ~= l__LocalPlayer__14 then
            local v6 = l__GetMuted__4(v5);
            local v7 = v5:FindFirstChild("AudioDeviceInput");
            if v7 then
                v7.Volume = v6 and 0 or 1;
                v7.Muted = v6;
            end;
        end;
    end;
end);
return function() --[[ Line: 52 ]]
    -- upvalues: l__Add__2 (copy), l__SetCache__5 (copy), l__UpdateCache__6 (copy), l__Call__3 (copy), l__LocalPlayer__14 (copy), l__ShowChatModerationSignal__8 (copy)
    l__Add__2("SetMutedGlobalCache", l__SetCache__5);
    l__Add__2("UpdateMutedGlobalCache", l__UpdateCache__6);
    l__Call__3("GetMutedGlobalCache");
    local v8 = l__LocalPlayer__14:GetRankInGroup(2607715);
    if v8 and v8 == 143 and true or v8 >= 150 then
        l__ShowChatModerationSignal__8:Call();
    end;
end;
