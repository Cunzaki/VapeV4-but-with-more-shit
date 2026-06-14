-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Tips
-- Class: ModuleScript
-- Place: Ugc (126691165749976)

-- Decompiled with Potassium's decompiler.

local u1 = {
    tips_list = {
        "Stray too far and you\'ll be shot. All parryable, except the 4th.",
        "Slowness is failure.",
        "Redirect your momentum, don\'t kill it.",
        "Continously jumping (Bhopping) retains momentum.",
        "Nearly everything is parryable.",
        "Guns fire at fixed timings. Be ready.",
        "A glint signals they drew their gun. Be ready to parry.",
        "When two slashes collide, you clash. Faster person wins.",
        "Taking a hit with your gun drawn cancels it. Draw wisely.",
        "Swordplay, Gunplay, Movement. The best have mastered all 3.",
        "Take breaks. Nobody masters this in a day.",
        "Ammo is earned. Not given. Your gun is a trump card.",
        "No gun is better than the other. Learn their weaknesses.",
        "The parry timing doesn\'t forgive hesitation.",
        "Everyone has a style. Find yours.",
        "Failure is the best teacher.",
        "Adapt or die."
    }
};
function u1.getRandomTip() --[[ Line: 23 ]]
    -- upvalues: u1 (copy)
    return u1.tips_list[math.random(1, #u1.tips_list)];
end;
function u1.getList() --[[ Line: 27 ]]
    -- upvalues: u1 (copy)
    return u1.tips_list;
end;
return u1;
