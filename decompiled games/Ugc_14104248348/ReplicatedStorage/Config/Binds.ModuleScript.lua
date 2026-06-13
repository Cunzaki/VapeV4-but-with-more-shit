-- Decompiled from: ReplicatedStorage.Config.Binds
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Interact = {
        Binds = {
            Computer = Enum.UserInputType.MouseButton1,
            Console = Enum.KeyCode.ButtonL1
        }
    },
    Sprint = {
        HideButtons = true,
        Binds = {
            Computer = Enum.KeyCode.LeftShift,
            Console = Enum.KeyCode.ButtonL2
        },
        Buttons = {
            {
                Icon = "rbxassetid://12091309352",
                Name = "Sprint",
                Align = "BottomRight",
                Position = Vector2.new(100, 55)
            }
        }
    },
    DrawWrite = {
        Binds = { Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch }
    },
    WhiteboardWrite = {
        Binds = {
            Touch = Enum.UserInputType.Touch,
            Computer = Enum.UserInputType.MouseButton1
        }
    },
    WhiteboardUpdate = {
        Binds = {
            Computer = Enum.UserInputType.MouseMovement,
            Touch = Enum.UserInputType.Touch
        }
    },
    UnifiedInteract = {
        Binds = {
            Touch = Enum.UserInputType.Touch,
            Computer = Enum.UserInputType.MouseButton1,
            Console = Enum.KeyCode.ButtonL1
        }
    },
    VRLeftHandInteract = {
        Binds = {
            VR = Enum.KeyCode.ButtonL1
        }
    },
    VRRightHandInteract = {
        Binds = {
            VR = Enum.KeyCode.ButtonR1
        }
    },
    Rotate = {
        HideButtons = true,
        Binds = {
            VR = Enum.KeyCode.ButtonR1,
            Computer = Enum.KeyCode.R,
            Console = Enum.KeyCode.ButtonY
        },
        Buttons = {
            {
                Icon = "rbxassetid://8848554011",
                Name = "Rotate",
                Align = "BottomRight",
                Position = Vector2.new(100, 55)
            }
        }
    },
    ShowDebug = {
        Binds = {
            Computer = Enum.KeyCode.F4
        }
    },
    CmdrBind = {
        Binds = {
            Computer = Enum.KeyCode.F3
        }
    },
    CatPounce = {
        Binds = {
            Computer = Enum.KeyCode.R,
            Console = Enum.KeyCode.ButtonB
        }
    }
};
