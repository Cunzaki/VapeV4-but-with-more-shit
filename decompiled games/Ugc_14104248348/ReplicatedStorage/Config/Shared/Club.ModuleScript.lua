-- Decompiled from: ReplicatedStorage.Config.Shared.Club
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    LightModes = {
        {
            Name = "White flahser",
            Colors = {
                Low = { Color3.fromRGB(255, 255, 255) },
                Mid = { Color3.fromRGB(255, 255, 255) },
                High = { Color3.fromRGB(255, 255, 255) }
            },
            Beat = {
                DanceFloorSubBeat = 1,
                LightSubBeat = 1,
                SongSubBeat = 0.5
            },
            Flash = {
                Mode = "Constant",
                Bias = 0
            },
            LightTargets = {
                "Target1",
                "Target2",
                "Target3",
                "Target4",
                "Target5",
                "Target6",
                "Target7",
                "Target8",
                "Target9"
            },
            FloorColors = { Color3.fromRGB(255, 255, 255), Color3.fromRGB(226, 226, 226) }
        },
        {
            Name = "Club Adri Simple",
            Colors = {
                Low = { Color3.fromRGB(255, 0, 191), Color3.fromRGB(9, 137, 207) },
                Mid = { Color3.fromRGB(255, 0, 191), Color3.fromRGB(9, 137, 207) },
                High = { Color3.fromRGB(255, 0, 191), Color3.fromRGB(9, 137, 207) }
            },
            Beat = {
                DanceFloorSubBeat = 1,
                LightSubBeat = 1,
                SongSubBeat = 0.5
            },
            Flash = {
                Mode = "Volume",
                Bias = 0
            },
            LightTargets = {
                "Target1",
                "Target2",
                "Target3",
                "Target4",
                "Target5",
                "Target6",
                "Target7",
                "Target8",
                "Target9"
            },
            FloorColors = { Color3.fromRGB(255, 0, 191), Color3.fromRGB(9, 137, 207) }
        },
        {
            Name = "Red/Yellow/Orange Simple",
            Colors = {
                Low = { Color3.fromRGB(255, 0, 4) },
                Mid = { Color3.fromRGB(255, 183, 0) },
                High = { Color3.fromRGB(242, 255, 0) }
            },
            Beat = {
                DanceFloorSubBeat = 1,
                LightSubBeat = 1,
                SongSubBeat = 0.5
            },
            Flash = {
                Mode = "Constant",
                Bias = 4
            },
            LightTargets = {
                "Target1",
                "Target3",
                "Target5",
                "Target6",
                "Target8",
                "Target9"
            },
            FloorColors = { Color3.fromRGB(255, 0, 0), Color3.fromRGB(207, 104, 0) }
        },
        {
            Name = "Pink/Purple Simple",
            Colors = {
                Low = { Color3.fromRGB(247, 0, 255) },
                Mid = { Color3.fromRGB(99, 0, 165) },
                High = { Color3.fromRGB(8, 0, 255) }
            },
            Beat = {
                DanceFloorSubBeat = 1,
                LightSubBeat = 1,
                SongSubBeat = 0.5
            },
            Flash = {
                Mode = "Constant",
                Bias = 0
            },
            LightTargets = {
                "Target2",
                "Target3",
                "Target6",
                "Target7",
                "Target9"
            },
            FloorColors = { Color3.fromRGB(247, 0, 255), Color3.fromRGB(113, 0, 212) }
        },
        {
            Name = "Green/Yellow Simple",
            Colors = {
                Low = { Color3.fromRGB(4, 255, 0) },
                Mid = { Color3.fromRGB(255, 204, 0) },
                High = { Color3.fromRGB(255, 0, 0) }
            },
            Beat = {
                DanceFloorSubBeat = 1,
                LightSubBeat = 1,
                SongSubBeat = 0.5
            },
            Flash = {
                Mode = "Volume",
                Bias = 0
            },
            LightTargets = {
                "Target1",
                "Target3",
                "Target4",
                "Target6",
                "Target7"
            },
            FloorColors = { Color3.fromRGB(4, 255, 0), Color3.fromRGB(255, 204, 0) }
        },
        {
            Name = "Red/Blue Simple",
            Colors = {
                Low = { Color3.fromRGB(255, 0, 4) },
                Mid = { Color3.fromRGB(8, 0, 255) },
                High = { Color3.fromRGB(0, 251, 255) }
            },
            Beat = {
                DanceFloorSubBeat = 1,
                LightSubBeat = 1,
                SongSubBeat = 0.5
            },
            Flash = {
                Mode = "Constant",
                Bias = 2
            },
            LightTargets = {
                "Target1",
                "Target3",
                "Target5",
                "Target6",
                "Target8",
                "Target9"
            },
            FloorColors = { Color3.fromRGB(255, 0, 4), Color3.fromRGB(8, 0, 255) }
        },
        {
            Name = "Candy Mix 1",
            Colors = {
                Low = { Color3.fromRGB(255, 0, 166), Color3.fromRGB(0, 213, 255) },
                Mid = { Color3.fromRGB(47, 255, 0), Color3.fromRGB(255, 204, 0) },
                High = { Color3.fromRGB(255, 64, 0), Color3.fromRGB(157, 0, 255) }
            },
            Beat = {
                DanceFloorSubBeat = 1,
                LightSubBeat = 1,
                SongSubBeat = 0.5
            },
            Flash = {
                Mode = "Volume",
                Bias = 0
            },
            LightTargets = {
                "Target1",
                "Target3",
                "Target6",
                "Target8",
                "Target9"
            },
            FloorColors = {
                Color3.fromRGB(255, 0, 166),
                Color3.fromRGB(0, 213, 255),
                Color3.fromRGB(47, 255, 0),
                Color3.fromRGB(255, 204, 0)
            }
        }
    },
    MusicModes = {
        {
            Name = "High Energy",
            ID = "rbxassetid://1837535253",
            BPM = 132
        },
        {
            Name = "Cheeky Break",
            ID = "rbxassetid://1836728800",
            BPM = 146
        },
        {
            Name = "DJ Breaks",
            ID = "rbxassetid://1836681160",
            BPM = 96
        },
        {
            Name = "Quin\'s Beat",
            ID = "rbxassetid://16161822967",
            Base = 300,
            BPM = 190
        },
        {
            Name = "Euphoric Anthem",
            ID = "rbxassetid://1845554017",
            BPM = 146
        },
        {
            Name = "Botique Chic",
            ID = "rbxassetid://1837701616",
            BPM = 146
        },
        {
            Name = "Disco",
            ID = "rbxassetid://1835908376",
            BPM = 146
        },
        {
            Name = "Disco House",
            ID = "rbxassetid://1839115942",
            BPM = 160
        }
    }
};
