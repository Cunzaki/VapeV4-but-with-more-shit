-- Decompiled from: Replication
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local u1 = l__obtain__1("View");
local u2 = l__obtain__1("RenderManager");
local u3 = l__obtain__1("FixLocalPlayer");
local v4 = l__obtain__1("VisibilityManager");
local l__GetHiding__2 = v4.GetHiding;
local l__UpdateView__3 = v4.UpdateView;
local l__SetCharacterCFrameFromPlayer__4 = l__obtain__1("PositionCharacter").SetCharacterCFrameFromPlayer;
local l__Contexts__5 = l__obtain__1("ContextManager").Contexts;
local l__Flush__6 = l__obtain__1("BulkMove").Flush;
local _ = game:GetService("Players").LocalPlayer;
return function() --[[ Line: 25 ]]
    -- upvalues: u2 (copy), u1 (copy), l__SetCharacterCFrameFromPlayer__4 (copy), l__Flush__6 (copy), l__Contexts__5 (copy), l__GetHiding__2 (copy), l__UpdateView__3 (copy), u3 (copy)
    u2.Bind("PositionCharacters", function() --[[ Line: 26 ]]
        -- upvalues: u1 (ref), l__SetCharacterCFrameFromPlayer__4 (ref), l__Flush__6 (ref)
        local l__PlaybackContext__7 = u1.PlaybackContext;
        if l__PlaybackContext__7 then
            l__PlaybackContext__7:Run();
            local l__Player__8 = u1.Player;
            l__SetCharacterCFrameFromPlayer__4(l__Player__8, l__Player__8);
            if l__Player__8 ~= "Local" then
                l__SetCharacterCFrameFromPlayer__4("Local", l__Player__8);
            end;
            l__Flush__6();
        end;
    end);
    game:GetService("RunService").Heartbeat:connect(function() --[[ Line: 38 ]]
        -- upvalues: l__Contexts__5 (ref), u1 (ref), l__GetHiding__2 (ref), l__SetCharacterCFrameFromPlayer__4 (ref), l__Flush__6 (ref), l__UpdateView__3 (ref), u3 (ref)
        for v5, v6 in l__Contexts__5 do
            if v5 ~= u1.Player then
                v6:Run();
                if not l__GetHiding__2(v5) then
                    l__SetCharacterCFrameFromPlayer__4(v5, v5);
                end;
            end;
        end;
        l__Flush__6();
        l__UpdateView__3(u3(u1.Player), u1.PlaybackContext);
    end);
end;
