-- Decompiled from: ReplicatedStorage.Client.Class.BindManager.EnumTo
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local u1 = {
    TapIcon = "",
    TargetColor = "Dark",
    KeyImages = {
        Dark = {
            ButtonLB = "rbxassetid://18699998291",
            ButtonLT = "rbxassetid://18700061090",
            ButtonL1 = "rbxassetid://18700011427",
            ButtonL2 = "rbxassetid://18700045932",
            ButtonB = "rbxassetid://18704065214",
            ButtonCircle = "rbxassetid://18704067500",
            [Enum.KeyCode.Z] = "rbxassetid://134128767173155",
            [Enum.KeyCode.Y] = "rbxassetid://72223659187044",
            [Enum.KeyCode.X] = "rbxassetid://129774672459569",
            [Enum.KeyCode.W] = "rbxassetid://113554140363770",
            [Enum.KeyCode.V] = "rbxassetid://96834367525159",
            [Enum.KeyCode.U] = "rbxassetid://76173375899363",
            [Enum.KeyCode.T] = "rbxassetid://86363470671759",
            [Enum.KeyCode.S] = "rbxassetid://71368529711910",
            [Enum.KeyCode.R] = "rbxassetid://18704034585",
            [Enum.KeyCode.Q] = "rbxassetid://123281161319886",
            [Enum.KeyCode.P] = "rbxassetid://76896816117711",
            [Enum.KeyCode.O] = "rbxassetid://103710125753498",
            [Enum.KeyCode.N] = "rbxassetid://123183929820945",
            [Enum.KeyCode.M] = "rbxassetid://78421973541072",
            [Enum.KeyCode.L] = "rbxassetid://92092204655763",
            [Enum.KeyCode.K] = "rbxassetid://85145185295802",
            [Enum.KeyCode.J] = "rbxassetid://111431111362547",
            [Enum.KeyCode.I] = "rbxassetid://132851268174281",
            [Enum.KeyCode.H] = "rbxassetid://85920441251414",
            [Enum.KeyCode.G] = "rbxassetid://129850881888004",
            [Enum.KeyCode.F] = "rbxassetid://89492504482989",
            [Enum.KeyCode.E] = "rbxassetid://80045865592298",
            [Enum.KeyCode.D] = "rbxassetid://85684894314727",
            [Enum.KeyCode.C] = "rbxassetid://76393222881040",
            [Enum.KeyCode.B] = "rbxassetid://107582281513388",
            [Enum.KeyCode.A] = "rbxassetid://86964982210426",
            [Enum.KeyCode.One] = "rbxassetid://118856873620730",
            [Enum.KeyCode.Two] = "rbxassetid://131105360437919",
            [Enum.KeyCode.Three] = "rbxassetid://85030044929231",
            [Enum.KeyCode.Four] = "rbxassetid://80157143607173",
            [Enum.KeyCode.Five] = "rbxassetid://80706919413108",
            [Enum.KeyCode.Six] = "rbxassetid://120061104162794",
            [Enum.KeyCode.Seven] = "rbxassetid://75028221352900",
            [Enum.KeyCode.Eight] = "rbxassetid://77065502029770",
            [Enum.KeyCode.Nine] = "rbxassetid://130451367156984",
            [Enum.KeyCode.Zero] = "rbxassetid://110556738094423",
            [Enum.KeyCode.Up] = "rbxassetid://15127452481",
            [Enum.KeyCode.Down] = "rbxassetid://15127452938",
            [Enum.KeyCode.Left] = "rbxassetid://15127452756",
            [Enum.KeyCode.Right] = "rbxassetid://15127452626",
            [Enum.KeyCode.Space] = "rbxassetid://15434562337",
            [Enum.KeyCode.LeftShift] = "rbxassetid://18704030409",
            [Enum.KeyCode.RightShift] = "rbxassetid://15434925385",
            [Enum.KeyCode.Tab] = "rbxassetid://126014026061046",
            [Enum.UserInputType.Touch] = "rbxassetid://124284788826567"
        },
        Light = {
            [Enum.KeyCode.Up] = "rbxassetid://15127478131",
            [Enum.KeyCode.Down] = "rbxassetid://15127478524",
            [Enum.KeyCode.R] = "rbxassetid://18675283111",
            [Enum.KeyCode.Left] = "rbxassetid://15127478370",
            [Enum.KeyCode.Right] = "rbxassetid://15127478260",
            [Enum.KeyCode.Space] = "rbxassetid://15434564201",
            [Enum.KeyCode.LeftShift] = "rbxassetid://15434925385",
            [Enum.KeyCode.RightShift] = "rbxassetid://15434925385",
            [Enum.UserInputType.Touch] = "rbxassetid://124284788826567"
        }
    },
    KeyCodeToTextMapping = {
        [Enum.KeyCode.LeftControl] = "Ctrl",
        [Enum.KeyCode.RightControl] = "Ctrl",
        [Enum.KeyCode.LeftAlt] = "Alt",
        [Enum.KeyCode.RightAlt] = "Alt",
        [Enum.KeyCode.F1] = "F1",
        [Enum.KeyCode.F2] = "F2",
        [Enum.KeyCode.F3] = "F3",
        [Enum.KeyCode.F4] = "F4",
        [Enum.KeyCode.F5] = "F5",
        [Enum.KeyCode.F6] = "F6",
        [Enum.KeyCode.F7] = "F7",
        [Enum.KeyCode.F8] = "F8",
        [Enum.KeyCode.F9] = "F9",
        [Enum.KeyCode.F10] = "F10",
        [Enum.KeyCode.F11] = "F11",
        [Enum.KeyCode.F12] = "F12",
        [Enum.UserInputType.Touch] = "Touch",
        [Enum.UserInputType.MouseButton1] = "LMB",
        [Enum.UserInputType.MouseButton2] = "RMB",
        [Enum.KeyCode.LeftShift] = "L-Shift",
        [Enum.KeyCode.RightShift] = "R-Shift",
        [Enum.UserInputType.MouseMovement] = "MouseMovement"
    }
};
function u1.SortProximityInputType(p2, p3, p4) --[[ Line: 99 ]]
    -- upvalues: u1 (copy)
    if p2 == Enum.ProximityPromptInputType.Touch then
        return {
            Type = "Image",
            Value = u1.TapIcon
        };
    end;
    if p2 == Enum.ProximityPromptInputType.Gamepad then
        return u1.GetObject(p3);
    end;
    if p2 == Enum.ProximityPromptInputType.Keyboard then
        return u1.GetObject(p4);
    end;
    warn("[EnumTo]: Unable to sort the ProximityPromptInputType into a inputobject.");
end;
function u1.GetObject(p5, p6) --[[ Line: 115 ]]
    -- upvalues: u1 (copy), l__UserInputService__1 (copy)
    local v7 = p6 or u1.TargetColor;
    local v8 = u1.KeyCodeToTextMapping[p5] or l__UserInputService__1:GetStringForKeyCode(p5);
    local v9 = u1.KeyImages[v7][p5] or u1.KeyImages[v7][v8];
    return v9 and {
        Type = "Image",
        Value = v9
    } or {
        Type = "String",
        Value = v8
    };
end;
return u1;
