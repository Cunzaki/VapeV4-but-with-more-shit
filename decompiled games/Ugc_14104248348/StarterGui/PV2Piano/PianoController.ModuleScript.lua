-- Decompiled from: StarterGui.PV2Piano.PianoController
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Signal__1 = require(script.Signal);
local u1 = {};
game:GetService("ContentProvider");
local l__Players__2 = game:GetService("Players");
local l__RunService__3 = game:GetService("RunService");
game:GetService("SoundService");
local l__UserInputService__4 = game:GetService("UserInputService");
local l__ReplicatedStorage__5 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__6 = l__Players__2.LocalPlayer;
local l__CurrentCamera__7 = workspace.CurrentCamera;
local u2 = TweenInfo.new(0.5, Enum.EasingStyle.Linear);
local l__Mince__8 = require(l__ReplicatedStorage__5.Modules.Mince);
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = l__Mince__8:Get("Notices");
local u13 = l__Mince__8:Get("Settings");
local u14 = l__Mince__8:Get("UserProfile");
local u15 = l__Mince__8:Get("ConfirmPrompt");
local u16 = l__Mince__8:GetEvent("ExpireIntent");
local u17 = false;
local u18 = false;
u1.Active = false;
u1.Piano = nil;
u1.Transposition = 0;
u1.Volume = 1;
u1.Velocity = 1;
u1.SoundFont = 1;
u1.Sustain = true;
u1.ShiftLock = false;
u1.Device = "Desktop";
u1._LETTER_NOTE_MAP = "1!2@34$5%6^78*9(0qQwWeErtTyYuiIoOpPasSdDfgGhHjJklLzZxcCvVbBnm";
u1._LETTER_88_MAP = "trewq0987654321yuiopasdfghj";
u1._LETTER_VELOCITY_MAP = "1234567890qwertyuiopasdfghjklzxc";
u1._VELOCITY_CURVES = nil;
u1._activeQueue = false;
u1._soundQueue = {};
u1._keyDownLookup = {
    [l__LocalPlayer__6] = {}
};
u1._keyboardPressConnection = nil;
u1._keyboardReleaseConnection = nil;
u1._preloadedSoundFonts = {};
u1.NotePressed = l__Signal__1.new();
u1.NoteReleased = l__Signal__1.new();
u1.SustainToggled = l__Signal__1.new();
u1.KeyPressed = l__Signal__1.new();
u1.KeyReleased = l__Signal__1.new();
u1.SustainChanged = l__Signal__1.new();
u1.ShiftLockChanged = l__Signal__1.new();
u1.TranspositionChanged = l__Signal__1.new();
u1.VolumeChanged = l__Signal__1.new();
u1.VelocityChanged = l__Signal__1.new();
u1.SoundFontChanged = l__Signal__1.new();
u1.CameraChanged = l__Signal__1.new();
u1.Activated = l__Signal__1.new();
u1.Deactivated = l__Signal__1.new();
u1.DeviceChanged = l__Signal__1.new();
function u1._startSoundQueue(u19) --[[ Line: 90 ]]
    -- upvalues: u11 (ref), l__RunService__3 (copy), l__CurrentCamera__7 (copy)
    if u19._activeQueue then
        warn("[PianoController]: Attempted to start queue when already active");
    else
        u19._activeQueue = true;
        task.spawn(function() --[[ Line: 96 ]]
            -- upvalues: u19 (copy), u11 (ref), l__RunService__3 (ref), l__CurrentCamera__7 (ref)
            while true do
                if not u19._activeQueue then
                    return;
                end;
                if #u19._soundQueue == 0 then
                    u19:_stopSoundQueue();
                    return;
                end;
                local v20 = #u19._soundQueue - u11.MaxSounds;
                local v21 = l__RunService__3.Heartbeat:Wait();
                local v22 = 1;
                for v23, v24 in ipairs(u19._soundQueue) do
                    if v20 > 0 then
                        u19._soundQueue[v23] = nil;
                        v24:Destroy();
                        v20 = v20 - 1;
                    elseif v24.State == "Destroying" then
                        u19._soundQueue[v23] = nil;
                    elseif v24.State == "Active" then
                        if u19._keyDownLookup[v24.Source] then
                            if v24.Sustained or u19._keyDownLookup[v24.Source][v24.Index] then
                                v24.Lifetime = v24.Lifetime + v21;
                                if v24.Lifetime >= v24.MaxLifetime then
                                    v24:Fade();
                                end;
                                if u11.PlayServerOrigin and (typeof(v24.Origin) == "Instance" and v24.Origin:IsA("BasePart")) then
                                    v24.Sound.Volume = v24.Volume / ((v24.Origin.Position - l__CurrentCamera__7.CFrame.Position).Magnitude / u11.OriginInverseMultiplier);
                                end;
                            else
                                v24:Fade();
                            end;
                            if v22 ~= v23 then
                                u19._soundQueue[v22] = v24;
                                u19._soundQueue[v23] = nil;
                            end;
                            v22 = v22 + 1;
                        end;
                        v24:Destroy();
                    else
                        if v22 ~= v23 then
                            u19._soundQueue[v22] = v24;
                            u19._soundQueue[v23] = nil;
                        end;
                        v22 = v22 + 1;
                    end;
                end;
            end;
        end);
    end;
end;
function u1._stopSoundQueue(p25) --[[ Line: 142 ]]
    if p25._activeQueue then
        p25._activeQueue = false;
        for _, v26 in ipairs(p25._soundQueue) do
            v26:Destroy();
        end;
        table.clear(p25._soundQueue);
    else
        warn("[PianoController]: Attempted to stop queue when already inactive");
    end;
end;
function u1.PlayNoteSound(p27, p28, p29, p30, p31, p32, p33, p34) --[[ Line: 155 ]]
    -- upvalues: u11 (ref), u5 (ref), u8 (ref), l__CurrentCamera__7 (copy), u17 (ref), u14 (copy), l__Mince__8 (copy), u16 (copy), u13 (ref), u15 (copy), u12 (copy), u18 (ref)
    local v35 = p29 or nil;
    if u11.PlayServerOrigin and (typeof(v35) == "Instance" and v35:IsA("BasePart")) then
        p32 = p32 * u11.OriginSoundMultiplier;
    end;
    if type(p33) ~= "table" then
        p33 = u5[p33];
    end;
    local v36 = u8.new(p28, v35, p30, p31, p32, p33, p34 == nil and true or p34);
    if u11.PlayServerOrigin and (typeof(v36.Origin) == "Instance" and v36.Origin:IsA("BasePart")) then
        v36.Sound.Volume = v36.Volume / ((v36.Origin.Position - l__CurrentCamera__7.CFrame.Position).Magnitude / u11.OriginInverseMultiplier);
        if not u17 and u14:IsLoaded() then
            u17 = true;
            if l__Mince__8.Config.LocalProfile.Intents.PIANO_SOUND_DISABLED then
                u16:Fire("PIANO_SOUND_DISABLED");
                if not u13.GetValue("Piano") then
                    u15.Display("Would you like to enable piano sounds for other players?", function() --[[ Line: 172 ]]
                        -- upvalues: u13 (ref), u12 (ref)
                        u13.ChangeSetting("Piano", true);
                        u12.CreateNotice("You can disable piano sounds anytime in settings.");
                    end);
                end;
            end;
        end;
        if not u18 then
            return;
        end;
    end;
    v36:Play();
    table.insert(p27._soundQueue, v36);
    if not p27._activeQueue then
        p27:_startSoundQueue();
    end;
    return v36;
end;
function u1.PressClientKey(p37, p38, p39, p40, p41, p42, p43, p44) --[[ Line: 193 ]]
    -- upvalues: u4 (ref), l__LocalPlayer__6 (copy), u11 (ref), u1 (copy)
    local v45 = p40 or (p37.Transposition or 0);
    local v46 = p41 or (p37.Volume or 1);
    local v47 = p42 or (p37.Velocity or 1);
    local v48 = p43 or (p37.SoundFont or u4.DEFAULT_SOUNDFONT);
    if p44 == nil then
        p44 = p37.Sustain;
    end;
    p37._keyDownLookup[l__LocalPlayer__6][p38] = true;
    if u11.PlayClientSounds then
        u1:PlayNoteSound(l__LocalPlayer__6, nil, p38, p39 + v45, v46 * v47, v48, p44);
    end;
    p37.KeyPressed:Fire(p38, p39, v45, v46, v47, v48, p44);
    p37.NotePressed:Fire(l__LocalPlayer__6, p37.Piano, p38, p39, v45, v46, v47, v48, p44);
end;
function u1.ReleaseClientKey(p49, p50) --[[ Line: 207 ]]
    -- upvalues: l__LocalPlayer__6 (copy)
    p49._keyDownLookup[l__LocalPlayer__6][p50] = nil;
    p49.KeyReleased:Fire(p50);
    p49.NoteReleased:Fire(l__LocalPlayer__6, p49.Piano, p50);
end;
function u1.ToggleSustain(p51, p52, p53) --[[ Line: 213 ]]
    -- upvalues: l__LocalPlayer__6 (copy)
    if p52 == nil or p51.Sustain ~= p52 then
        if p52 == nil then
            p52 = not p51.Sustain;
        end;
        p51.Sustain = p52;
        for _, v54 in ipairs(p51._soundQueue) do
            if v54.Source == l__LocalPlayer__6 then
                v54.Sustained = p51.Sustain;
            end;
        end;
        p51.SustainToggled:Fire(l__LocalPlayer__6, p51.Piano, p51.Sustain, p53);
        p51.SustainChanged:Fire(p51.Sustain, p53);
    end;
end;
function u1._pressServerKey(p55, p56, p57, p58, p59, p60, p61, p62, p63, p64) --[[ Line: 225 ]]
    -- upvalues: u6 (ref), u11 (ref), u1 (copy)
    local v65 = u6[p57];
    local v66;
    if v65 then
        v66 = v65.Origin;
    else
        v66 = nil;
    end;
    p55._keyDownLookup[p56][p58] = true;
    if u11.PlayServerSounds then
        u1:PlayNoteSound(p56, v66, p58, p59 + p60, p61 * p62, p63, p64);
    end;
    p55.NotePressed:Fire(p56, p57, p58, p59, p60, p61, p62, p63, p64);
end;
function u1._releaseServerKey(p67, p68, p69, p70) --[[ Line: 236 ]]
    p67._keyDownLookup[p68][p70] = nil;
    p67.NoteReleased:Fire(p68, p69, p70);
end;
function u1._toggleServerSustain(p71, p72, p73, p74, p75) --[[ Line: 241 ]]
    for _, v76 in ipairs(p71._soundQueue) do
        if v76.Source == p72 then
            v76.Sustained = p74;
        end;
    end;
    p71.SustainToggled:Fire(p72, p73, p74, p75);
end;
function u1.ChangeTransposition(p77, p78, p79) --[[ Line: 251 ]]
    -- upvalues: u4 (ref)
    local l__Transposition__9 = p77.Transposition;
    p77.Transposition = math.clamp(p78 + p77.Transposition * (p79 and 0 or 1), u4.MIN_TRANSPOSITION, u4.MAX_TRANSPOSITION);
    p77.TranspositionChanged:Fire(p77.Transposition, p77.Transposition - l__Transposition__9);
end;
function u1.ChangeVolume(p80, p81, p82) --[[ Line: 257 ]]
    -- upvalues: u4 (ref)
    local l__Volume__10 = p80.Volume;
    p80.Volume = math.clamp(p81 + p80.Volume * (p82 and 0 or 1), u4.MIN_VOLUME, u4.MAX_VOLUME);
    p80.VolumeChanged:Fire(p80.Volume, p80.Volume - l__Volume__10);
end;
function u1.ChangeVelocity(p83, p84, p85) --[[ Line: 263 ]]
    -- upvalues: u4 (ref)
    local l__Velocity__11 = p83.Velocity;
    p83.Velocity = math.clamp(p84 + p83.Velocity * (p85 and 0 or 1), u4.MIN_VELOCITY, u4.MAX_VELOCITY);
    p83.VelocityChanged:Fire(p83.Velocity, p83.Velocity - l__Velocity__11);
end;
function u1.ChangeSoundFont(p86, p87) --[[ Line: 269 ]]
    -- upvalues: u5 (ref), u4 (ref)
    if p87 == p86.SoundFont then
    else
        if not u5[p87] then
            p87 = u4.DEFAULT_SOUNDFONT;
        end;
        p86.SoundFont = p87;
        p86.SoundFontChanged:Fire(p86.SoundFont);
    end;
end;
function u1.ToggleShiftLock(p88, p89) --[[ Line: 275 ]]
    if p88.ShiftLock == p89 then
    else
        if p89 == nil then
            p89 = not p88.ShiftLock;
        end;
        p88.ShiftLock = p89;
        p88.ShiftLockChanged:Fire(p88.ShiftLock);
    end;
end;
function u1.ChangeCamera(p90, p91, p92) --[[ Line: 281 ]]
    -- upvalues: u6 (ref), u7 (ref), l__CurrentCamera__7 (copy), u2 (copy)
    if p90.Piano then
        local v93 = u6[p90.Piano];
        if v93.Camera then
            local l__Camera__12 = v93.Camera;
            if type(l__Camera__12) == "table" then
                p90.Camera = p92 and math.clamp(p91, 1, #l__Camera__12) or (p90.Camera + p91 - 1) % #l__Camera__12 + 1;
                l__Camera__12 = l__Camera__12[p90.Camera];
            end;
            u7:Play(l__CurrentCamera__7, u2, {
                CFrame = l__Camera__12.CFrame
            });
            p90.CameraChanged:Fire(p90.Camera, l__Camera__12.CFrame);
        end;
    end;
end;
function u1._connectKeyboardInput(u94) --[[ Line: 295 ]]
    -- upvalues: l__UserInputService__4 (copy), u10 (ref), u9 (ref)
    if u94._keyboardPressConnection or u94._keyboardReleaseConnection then
        warn("[PianoController]: Attempted to connect to keyboard twice, disconnecting old connections");
        u94:_disconnectKeyboardInput();
    end;
    u94._keyboardPressConnection = l__UserInputService__4.InputBegan:Connect(function(p95, p96) --[[ Line: 300 ]]
        -- upvalues: u94 (copy), u10 (ref), u9 (ref)
        if p95.UserInputType == Enum.UserInputType.Keyboard and (not p96 and u94.Active) then
            local l__KeyCode__13 = p95.KeyCode;
            local l__Value__14 = p95.KeyCode.Value;
            if l__Value__14 >= 48 and l__Value__14 <= 57 or l__Value__14 >= 97 and l__Value__14 <= 122 then
                if p95:IsModifierKeyDown(2) and u10.MIDIVelocity then
                    local v97 = string.find(u94._LETTER_VELOCITY_MAP, string.char(l__Value__14), 1, true);
                    if v97 then
                        u94:ChangeVelocity(u94._VELOCITY_CURVES[u10.MIDICurve](v97), true);
                    end;
                else
                    local v98;
                    if p95:IsModifierKeyDown(1) and u10.MIDI88 then
                        local v99 = string.find(u94._LETTER_88_MAP, string.char(l__Value__14), 1, true);
                        if not v99 then
                            return;
                        end;
                        v98 = (v99 <= 15 and 1 - v99 or 61 + v99 - 15) + (p95:IsModifierKeyDown(0) and 1 or 0) * (u94.ShiftLock and -1 or 1) + (u94.ShiftLock and 1 or 0);
                    else
                        v98 = string.find(u94._LETTER_NOTE_MAP, string.char(l__Value__14), 1, true) + (p95:IsModifierKeyDown(0) and 1 or 0) * (u94.ShiftLock and -1 or 1) + (u94.ShiftLock and 1 or 0);
                        if not v98 then
                            return;
                        end;
                    end;
                    u94:PressClientKey(l__KeyCode__13, v98, u94.Transposition, u94.Volume, u94.Velocity, u94.SoundFont, u94.Sustain);
                end;
            elseif l__KeyCode__13 == u9.Sustain and u10.EnableSustainHotkey or l__KeyCode__13 == u9.ToggleSustain then
                u94:ToggleSustain(nil, true);
            elseif l__KeyCode__13 == u9.ToggleShiftLock and u10.EnableShiftLockHotkey then
                u94:ToggleShiftLock();
            elseif l__KeyCode__13 == u9.TranspositionUp then
                u94:ChangeTransposition(1);
            elseif l__KeyCode__13 == u9.TranspositionDown then
                u94:ChangeTransposition(-1);
            elseif l__KeyCode__13 == u9.VolumeUp then
                u94:ChangeVolume(0.1);
            elseif l__KeyCode__13 == u9.VolumeDown then
                u94:ChangeVolume(-0.1);
            elseif l__KeyCode__13 == u9.ChangeCamera then
                u94:ChangeCamera(1);
            else
                if l__KeyCode__13 == u9.Exit then
                    u94:Deactivate();
                end;
            end;
        end;
    end);
    u94._keyboardReleaseConnection = l__UserInputService__4.InputEnded:Connect(function(p100, p101) --[[ Line: 340 ]]
        -- upvalues: u94 (copy), u9 (ref), u10 (ref)
        if p100.UserInputType == Enum.UserInputType.Keyboard and (not p101 and u94.Active) then
            local l__KeyCode__15 = p100.KeyCode;
            local l__Value__16 = p100.KeyCode.Value;
            if l__Value__16 >= 48 and l__Value__16 <= 57 or l__Value__16 >= 97 and l__Value__16 <= 122 then
                u94:ReleaseClientKey(l__KeyCode__15);
            else
                if l__KeyCode__15 == u9.Sustain and u10.EnableSustainHotkey then
                    u94:ToggleSustain(nil, false);
                end;
            end;
        end;
    end);
end;
function u1._disconnectKeyboardInput(p102) --[[ Line: 351 ]]
    if p102._keyboardPressConnection then
        p102._keyboardPressConnection:Disconnect();
    end;
    if p102._keyboardReleaseConnection then
        p102._keyboardReleaseConnection:Disconnect();
    end;
    p102._keyboardPressConnection = nil;
    p102._keyboardReleaseConnection = nil;
end;
function u1.AnimateKeyDown(_, p103, p104, ...) --[[ Line: 363 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u11 (ref), u6 (ref)
    if p103 == l__LocalPlayer__6 and not u11.PlayClientEffects or p103 ~= l__LocalPlayer__6 and not u11.PlayServerEffects then
    else
        local v105 = u6[p104];
        if v105 and v105.AnimateKeyDown then
            v105.AnimateKeyDown(p103, ...);
        end;
    end;
end;
function u1.AnimateKeyUp(_, p106, p107, ...) --[[ Line: 370 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u11 (ref), u6 (ref)
    if p106 == l__LocalPlayer__6 and not u11.PlayClientEffects or p106 ~= l__LocalPlayer__6 and not u11.PlayServerEffects then
    else
        local v108 = u6[p107];
        if v108 and v108.AnimateKeyUp then
            v108.AnimateKeyUp(p106, ...);
        end;
    end;
end;
function u1.AnimateSustainDown(_, p109, p110, ...) --[[ Line: 377 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u11 (ref), u6 (ref)
    if p109 == l__LocalPlayer__6 and not u11.PlayClientEffects or p109 ~= l__LocalPlayer__6 and not u11.PlayServerEffects then
    else
        local v111 = u6[p110];
        if v111 and v111.AnimateSustainDown then
            v111.AnimateSustainDown(p109, ...);
        end;
    end;
end;
function u1.AnimateSustainUp(_, p112, p113, ...) --[[ Line: 384 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u11 (ref), u6 (ref)
    if p112 == l__LocalPlayer__6 and not u11.PlayClientEffects or p112 ~= l__LocalPlayer__6 and not u11.PlayServerEffects then
    else
        local v114 = u6[p113];
        if v114 and v114.AnimateSustainUp then
            v114.AnimateSustainUp(p112, ...);
        end;
    end;
end;
function u1.Activate(p115, p116) --[[ Line: 392 ]]
    -- upvalues: u3 (ref), l__CurrentCamera__7 (copy), u6 (ref)
    if p115.Active then
        warn("[PianoController]: Attempted to activate while already active");
    else
        p115.Active = true;
        p115.Piano = p116;
        u3:Disable();
        p115:_connectKeyboardInput();
        if p115.Piano then
            p115:ChangeCamera(1, true);
        end;
        l__CurrentCamera__7.CameraType = Enum.CameraType.Scriptable;
        p115.Activated:Fire(p116);
        if u6[p116].DefaultSoundFont then
            p115:ChangeSoundFont(u6[p116].DefaultSoundFont);
        end;
    end;
end;
function u1.Deactivate(p117) --[[ Line: 411 ]]
    -- upvalues: l__CurrentCamera__7 (copy), u3 (ref), l__LocalPlayer__6 (copy)
    if p117.Active then
        p117.Active = false;
        p117.Piano = nil;
        l__CurrentCamera__7.CameraType = Enum.CameraType.Custom;
        p117:_disconnectKeyboardInput();
        u3:Enable();
        if l__LocalPlayer__6.Character then
            local v118 = l__LocalPlayer__6.Character:FindFirstChild("Humanoid");
            if v118 and v118.Sit then
                v118.Sit = false;
            end;
        end;
        p117.Deactivated:Fire();
    end;
end;
function u1.ChangeDevice(p119, p120) --[[ Line: 430 ]]
    if p120 == "Mobile" or p120 == "Desktop" then
        p119.Device = p120;
        p119.DeviceChanged:Fire(p120);
    end;
end;
function u1.PreloadSoundFont(p121, p122) --[[ Line: 436 ]]
    -- upvalues: u5 (ref)
    if p121._preloadedSoundFonts[p122] then
    else
        p121._preloadedSoundFonts[p122] = true;
        local u123 = u5[p122];
        if u123 then
            task.spawn(function() --[[ Line: 441 ]]
                -- upvalues: u123 (copy)
                local v124 = {};
                for _, v125 in ipairs(u123.AssetIds) do
                    local v126 = Instance.new("Sound");
                    v126.SoundId = "https://roblox.com/asset/?id=" .. v125;
                    v126.Parent = script;
                    table.insert(v124, v126);
                end;
                for _, v127 in ipairs(v124) do
                    v127:Destroy();
                end;
            end);
        end;
    end;
end;
function u1._yield(_, p128, p129) --[[ Line: 456 ]]
    local v130 = p128 + p129 / 1000 - workspace:GetServerTimeNow();
    if v130 > 0 then
        task.wait(v130);
    end;
end;
function u1.Init(u131) --[[ Line: 464 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), l__Players__2 (copy), u13 (ref), l__Mince__8 (copy), u18 (ref), u14 (copy), u9 (ref), u10 (ref), u11 (ref), u1 (copy)
    u3 = require(l__LocalPlayer__6:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
    u4 = require(script.DefaultSettings);
    u5 = require(script.SoundFonts);
    u6 = require(script.PianoModules);
    u7 = require(script.Tween);
    u8 = require(script.Note);
    u131.SoundFont = u4.DEFAULT_SOUNDFONT;
    u131._VELOCITY_CURVES = u4.DEFAULT_VELOCITY_CURVES;
    for _, v132 in ipairs(l__Players__2:GetPlayers()) do
        u131._keyDownLookup[v132] = {};
    end;
    l__Players__2.PlayerAdded:Connect(function(p133) --[[ Line: 477 ]]
        -- upvalues: u131 (copy)
        u131._keyDownLookup[p133] = {};
    end);
    l__Players__2.PlayerRemoving:Connect(function(p134) --[[ Line: 480 ]]
        -- upvalues: u131 (copy)
        u131._keyDownLookup[p134] = nil;
    end);
    u13 = l__Mince__8:Get("Settings");
    u13.SettingChanged("Piano"):Connect(function(p135) --[[ Line: 486 ]]
        -- upvalues: u18 (ref)
        u18 = p135;
    end);
    u14:WaitUntilLoaded();
    u18 = u13.GetValue("Piano");
    u9 = table.clone(u4.DEFAULT_KEYBINDS);
    u10 = table.clone(u4.DEFAULT_PIANO_SETTINGS);
    u11 = table.clone(u4.DEFAULT_GAME_SETTINGS);
    u1.Keybinds = u9;
    u1.PianoSettings = u10;
    u1.GameSettings = u11;
end;
function u1.Start(u136) --[[ Line: 501 ]]
    -- upvalues: u11 (ref), u1 (copy)
    local l__PianoEvent__17 = script.Parent:WaitForChild("PianoEvent");
    l__PianoEvent__17.OnClientEvent:Connect(function(p137, p138, p139, p140, p141, p142) --[[ Line: 503 ]]
        -- upvalues: u136 (copy), u11 (ref)
        if typeof(p137) == "Instance" and p137:IsA("Model") then
            if p138 then
                u136:Activate(p137);
            else
                u136:Deactivate();
            end;
        else
            if u11.DelayNoteEvents then
                u136:_yield(p139, u11.EventDelay);
            end;
            if p140 == true then
                local v143, v144, v145, v146, v147, v148 = string.unpack("bbffBB", p142);
                u136:_pressServerKey(p137, p138, p141, v143, v144, v145, v146, v147, v148 == 1);
            elseif p140 == false then
                u136:_releaseServerKey(p137, p138, p141);
            else
                if p140 == nil then
                    u136:_toggleServerSustain(p137, p138, p141, p142);
                end;
            end;
        end;
    end);
    u136.KeyPressed:Connect(function(p149, p150, p151, p152, p153, p154, p155) --[[ Line: 525 ]]
        -- upvalues: u136 (copy), l__PianoEvent__17 (copy)
        if u136.Active and u136.Piano then
            local v156 = string.pack("bbffBB", p150, p151, p152, p153, p154, p155 and 1 or 0);
            l__PianoEvent__17:FireServer(workspace:GetServerTimeNow(), true, p149, v156);
        end;
    end);
    u136.KeyReleased:Connect(function(p157) --[[ Line: 530 ]]
        -- upvalues: u136 (copy), l__PianoEvent__17 (copy)
        if u136.Active and u136.Piano then
            l__PianoEvent__17:FireServer(workspace:GetServerTimeNow(), false, p157);
        end;
    end);
    u136.SustainChanged:Connect(function(p158, p159) --[[ Line: 534 ]]
        -- upvalues: u136 (copy), l__PianoEvent__17 (copy)
        if u136.Active and u136.Piano then
            l__PianoEvent__17:FireServer(workspace:GetServerTimeNow(), nil, p158, p159);
        end;
    end);
    u1.NotePressed:Connect(function(p160, p161, p162, p163, p164, p165, p166, p167, p168) --[[ Line: 538 ]]
        -- upvalues: u136 (copy)
        if p161 == nil then
        else
            u136:PreloadSoundFont(p167);
            u136:AnimateKeyDown(p160, p161, p162, p163, p164, p165, p166, p167, p168);
        end;
    end);
    u1.NoteReleased:Connect(function(p169, p170, p171) --[[ Line: 543 ]]
        -- upvalues: u136 (copy)
        if p170 == nil then
        else
            u136:AnimateKeyUp(p169, p170, p171);
        end;
    end);
    u1.SustainToggled:Connect(function(p172, p173, p174, p175) --[[ Line: 547 ]]
        -- upvalues: u136 (copy)
        if p173 == nil then
        elseif p175 == false then
            if p175 == false then
                u136:AnimateSustainUp(p172, p173, p174);
            end;
        else
            u136:AnimateSustainDown(p172, p173, p174, p175);
        end;
    end);
    u1.SoundFontChanged:Connect(function(p176) --[[ Line: 555 ]]
        -- upvalues: u136 (copy)
        u136:PreloadSoundFont(p176);
    end);
end;
return u1;
