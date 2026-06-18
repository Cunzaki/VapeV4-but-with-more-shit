-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.DialogueNodes
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local v1 = {
    DefaultSeer = {
        max_size = 28,
        typewriter_speed = 0.025,
        punctuation_pause = 0.3,
        sound = "BLIP",
        min_pitch = 3,
        max_pitch = 3.1,
        font = Font.fromEnum(Enum.Font.RobotoMono),
        color = Color3.fromRGB(255, 255, 255)
    }
};
return {
    TUT_Intro = {
        id = "TUT_Intro",
        speaker = "SEER",
        text_raw = "This is where it all begins. Proceed, and learn the essentials.",
        theme = v1.DefaultSeer,
        advance = {
            kind = "await_event",
            event = "globalOnObjectiveComplete",
            hint_override = "Proceed to the next checkpoint.",
            after = "TUT_Dash",
            predicate = function(p2) --[[ Name: predicate, Line 48 ]]
                return p2 == "OBJ_IntroGoal";
            end
        }
    },
    TUT_Dash = {
        id = "TUT_Dash",
        speaker = "SEER",
        text_raw = "Press <b>{action:DASH}</b> to <b>DASH</b>. Use it for a boost of speed, and cross the gap.",
        theme = v1.DefaultSeer,
        advance = {
            kind = "await_event",
            event = "globalOnObjectiveComplete",
            hint_override = "Dash across the gap to continue.",
            after = "TUT_Wallrun",
            predicate = function(p3) --[[ Name: predicate, Line 64 ]]
                return p3 == "OBJ_DashGoal";
            end
        }
    },
    TUT_Wallrun = {
        id = "TUT_Wallrun",
        speaker = "SEER",
        text_raw = "Press <b>{Action:JUMP}</b> parallel to a wall to <b>WALLRUN</b>, press it again to jump off in the direction you face.",
        theme = v1.DefaultSeer,
        advance = {
            kind = "await_event",
            event = "globalOnObjectiveComplete",
            hint_override = "Wallrun across the gap to continue.",
            after = "TUT_Slide",
            predicate = function(p4) --[[ Name: predicate, Line 80 ]]
                return p4 == "OBJ_WallrunGoal";
            end
        }
    },
    TUT_Slide = {
        id = "TUT_Slide",
        speaker = "SEER",
        text_raw = "Hold <b>{Action:SLIDE}</b> to <b>SLIDE</b>. You can use it to conserve momentum, and gain speed down ramps.",
        theme = v1.DefaultSeer,
        advance = {
            kind = "await_event",
            event = "globalOnObjectiveComplete",
            hint_override = "Slide down the ramp to continue.",
            after = "TUT_Grapple",
            predicate = function(p5) --[[ Name: predicate, Line 96 ]]
                return p5 == "OBJ_SlideGoal";
            end
        }
    },
    TUT_Grapple = {
        id = "TUT_Grapple",
        speaker = "SEER",
        text_raw = "Hold <b>{Action:AUGMENT}</b> to <b>GRAPPLE</b>. It pulls you and redirects your speed to where you grapple.",
        theme = v1.DefaultSeer,
        advance = {
            kind = "await_event",
            event = "globalOnObjectiveComplete",
            hint_override = "Grapple up the ledge.",
            after = "TUT_Playground",
            predicate = function(p6) --[[ Name: predicate, Line 112 ]]
                return p6 == "OBJ_GrappleGoal";
            end
        }
    },
    TUT_Playground = {
        id = "TUT_Playground",
        speaker = "SEER",
        text_raw = "Hold <b>{Action:JUMP}</b> to Bunny Hop. This is very important to retaining speed. Proceed to the combat section when ready.",
        theme = v1.DefaultSeer,
        advance = {
            kind = "await_event",
            event = "globalOnObjectiveComplete",
            hint_override = "Proceed to the next checkpoint when ready.",
            after = "TUT_Slashes",
            predicate = function(p7) --[[ Name: predicate, Line 128 ]]
                return p7 == "OBJ_PlaygroundGoal";
            end
        }
    },
    TUT_Slashes = {
        id = "TUT_Slashes",
        speaker = "SEER",
        text_raw = "Your melee is your <b>main weapon</b>. Press <b>{Action:MELEE}</b> to slash. Attack the dummy 3 times. Each time you <b>land a hit, you build up a BULLET</b>.",
        theme = v1.DefaultSeer,
        advance = {
            kind = "await_event",
            event = "globalOnObjectiveComplete",
            hint_override = "Attack the dummy 3 times.",
            after = "TUT_Gun",
            predicate = function(p8) --[[ Name: predicate, Line 144 ]]
                return p8 == "OBJ_Slashes";
            end
        }
    },
    TUT_Gun = {
        id = "TUT_Gun",
        speaker = "SEER",
        text_raw = "By landing attacks, you earned a BULLET. Press <b>{Action:GUN}</b> to draw your gun. It\'ll fire after a <b>fixed timing</b>, be prepared to fire.",
        theme = v1.DefaultSeer,
        advance = {
            kind = "await_event",
            event = "globalOnObjectiveComplete",
            hint_override = "Draw your gun and fire.",
            after = "TUT_Clash1",
            predicate = function(p9) --[[ Name: predicate, Line 160 ]]
                return p9 == "OBJ_Gun";
            end
        }
    },
    TUT_Clash1 = {
        id = "TUT_Clash1",
        speaker = "SEER",
        text_raw = "In combat, opponents slash back. Inevitably, your <b>slashes will collide and cause a CLASH</b>, indicated by yellow sparks. ({Action:INTERACT} to continue)",
        theme = v1.DefaultSeer,
        advance = {
            kind = "continue",
            hint_override = nil,
            after = "TUT_Clash2"
        }
    },
    TUT_Clash2 = {
        id = "TUT_Clash2",
        speaker = "SEER",
        text_raw = "When a CLASH happens, both people are dealt <b>INSTABILITY</b>, which is basically <b>Posture damage</b>. ({Action:INTERACT} to continue)",
        theme = v1.DefaultSeer,
        advance = {
            kind = "continue",
            hint_override = nil,
            after = "TUT_Clash3"
        }
    },
    TUT_Clash3 = {
        id = "TUT_Clash3",
        speaker = "SEER",
        text_raw = "The faster one in a CLASH deals more INSTABILITY. You always want to be <b>faster</b>. ({Action:INTERACT} to continue)",
        theme = v1.DefaultSeer,
        advance = {
            kind = "continue",
            hint_override = nil,
            after = "TUT_Clash4"
        }
    },
    TUT_Clash4 = {
        id = "TUT_Clash4",
        speaker = "SEER",
        text_raw = "This dummy is moving at 50 u/s and clashes when you attack it. Slash while <b>moving faster</b> than that to win the CLASH.",
        theme = v1.DefaultSeer,
        advance = {
            kind = "await_event",
            event = "globalOnObjectiveComplete",
            hint_override = "HINT: Try dashing just before you attack.",
            after = "TUT_Clash5",
            predicate = function(p10) --[[ Name: predicate, Line 210 ]]
                return p10 == "OBJ_Clash";
            end
        }
    },
    TUT_Clash5 = {
        id = "TUT_Clash5",
        speaker = "SEER",
        text_raw = "<b>Finish it off</b>. That red state is called <b>DESTABILIZED</b>, they can\'t attack or parry during it, so they\'re highly vulnerable.",
        theme = v1.DefaultSeer,
        advance = {
            kind = "await_event",
            event = "globalOnObjectiveComplete",
            hint_override = "Win clashes, then kill the dummy.",
            after = "TUT_Parry",
            predicate = function(p11) --[[ Name: predicate, Line 225 ]]
                return p11 == "OBJ_KillClasher";
            end
        }
    },
    TUT_Parry = {
        id = "TUT_Parry",
        speaker = "SEER",
        text_raw = "Press <b>{Action:PARRY}</b> to <b>PARRY</b>. Whenever a person draws their gun, a <b>glint</b> appears on them. <b>Look at the glint</b> and parry their bullets.",
        theme = v1.DefaultSeer,
        advance = {
            kind = "await_event",
            event = "globalOnObjectiveComplete",
            hint_override = "Attack the button, then parry 3 bullets in a row.",
            after = "TUT_Outro1",
            predicate = function(p12) --[[ Name: predicate, Line 241 ]]
                return p12 == "OBJ_Parry";
            end
        }
    },
    TUT_Outro1 = {
        id = "TUT_Outro1",
        speaker = "SEER",
        text_raw = "You\'ve learnt the fundamentals. Remember, you can parry both slashes and bullets alike. ({Action:INTERACT} to continue)",
        theme = v1.DefaultSeer,
        advance = {
            kind = "continue",
            hint_override = nil,
            after = "TUT_Outro2"
        }
    },
    TUT_Outro2 = {
        id = "TUT_Outro2",
        speaker = "SEER",
        text_raw = "Feel free to try the Training Mode! In queue, you\'ll be matched with similar leveled players. The best way to learn is to play.",
        theme = v1.DefaultSeer,
        advance = {
            kind = "await_event",
            event = "globalOnObjectiveComplete",
            hint_override = "Finish the tutorial.",
            after = nil,
            predicate = function(p13) --[[ Name: predicate, Line 268 ]]
                return p13 == "OBJ_Outro";
            end
        }
    }
};
