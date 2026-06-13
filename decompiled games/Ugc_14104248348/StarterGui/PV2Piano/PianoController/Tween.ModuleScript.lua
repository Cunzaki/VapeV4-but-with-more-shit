-- Decompiled from: StarterGui.PV2Piano.PianoController.Tween
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
return {
    new = function(p1, p2, p3) --[[ Name: new, Line 5 ]]
        -- upvalues: l__TweenService__1 (copy)
        return l__TweenService__1:Create(p1, p2, p3);
    end,
    Play = function(_, p4, p5, p6, p7) --[[ Name: Play, Line 9 ]]
        -- upvalues: l__TweenService__1 (copy)
        local v8 = l__TweenService__1:Create(p4, p5, p6);
        v8:Play();
        if p7 then
            v8.Completed:Wait();
        end;
    end,
    PlayTween = function(_, p9, p10) --[[ Name: PlayTween, Line 17 ]]
        p9:Play();
        if p10 then
            p9.Completed:Wait();
        end;
    end
};
