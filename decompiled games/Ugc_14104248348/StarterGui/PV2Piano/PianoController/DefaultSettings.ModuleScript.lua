-- Decompiled from: StarterGui.PV2Piano.PianoController.DefaultSettings
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v8 = {
    MIN_TRANSPOSITION = -24,
    MAX_TRANSPOSITION = 24,
    MIN_VOLUME = 0.1,
    MAX_VOLUME = 2,
    MIN_VELOCITY = 0.1,
    MAX_VELOCITY = 2,
    DEFAULT_SOUNDFONT = 1,
    DEFAULT_VELOCITY_CURVES = {
        function(p1) --[[ Line: 24 ]]
            return math.clamp(0.0254 + 0.095 * p1 - 0.00106 * (p1 * p1), 0.1, 2);
        end,
        function(p2) --[[ Line: 27 ]]
            local v3 = math.log(p2) * 0.552 + 0.102;
            return math.clamp(v3, 0.1, 2);
        end,
        function(p4) --[[ Line: 30 ]]
            local v5 = math.exp(0.091 * p4) * 0.111;
            return math.clamp(v5, 0.1, 2);
        end,
        function(p6) --[[ Line: 33 ]]
            local v7 = math.tanh(2 * (p6 / 16) - 2) + 1;
            return math.clamp(v7, 0.1, 2);
        end
    },
    DEFAULT_KEYBINDS = {
        Sustain = Enum.KeyCode.Space,
        ToggleSustain = Enum.KeyCode.Quote,
        ToggleShiftLock = Enum.KeyCode.Return,
        TranspositionUp = Enum.KeyCode.Up,
        TranspositionDown = Enum.KeyCode.Down,
        VolumeUp = Enum.KeyCode.Right,
        VolumeDown = Enum.KeyCode.Left,
        ChangeCamera = Enum.KeyCode.RightBracket,
        Exit = Enum.KeyCode.Backspace
    },
    DEFAULT_PIANO_SETTINGS = {
        MIDI88 = true,
        MIDIVelocity = true,
        MIDICurve = 1,
        EnableSustainHotkey = true,
        EnableShiftLockHotkey = true,
        ShowNoteLabels = true
    },
    DEFAULT_GAME_SETTINGS = {
        MaxSounds = 35,
        DelayNoteEvents = true,
        EventDelay = 500,
        PlayServerOrigin = true,
        OriginInverseMultiplier = 1,
        OriginSoundMultiplier = 8,
        PlayClientSounds = true,
        PlayServerSounds = true,
        PlayClientEffects = true,
        PlayServerEffects = true,
        HidePetsAtPiano = true,
        PreloadSoundFontsOnJoin = false
    },
    DEFAULT_MOBILE_PIANO_SETTINGS = {
        DoubleLayout = false,
        WhiteKeyWidth = false,
        WhiteKeyHeight = false,
        BlackKeyWidth = false,
        BlackKeyHeight = false
    },
    SETTINGS_CLAMP_VALUES = {
        MaxSounds = {
            Min = 1,
            Max = 100
        },
        MIDICurve = {
            Min = 1,
            Max = 4
        },
        EventDelay = {
            Min = 0,
            Max = 5000
        },
        OriginSoundMultiplier = {
            Min = 0.01,
            Max = 25
        },
        OriginInverseMultiplier = {
            Min = 0.01,
            Max = 25
        }
    }
};
for _, v9 in pairs(v8) do
    if type(v9) == "table" then
        table.freeze(v9);
    end;
end;
table.freeze(v8);
return v8;
