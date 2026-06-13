-- Decompiled from: StarterGui.PV2Piano.PianoController.Note.SoundCache
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v5 = {
    _sounds = {},
    CreateSound = function(_) --[[ Name: CreateSound, Line 9 ]]
        return Instance.new("Sound");
    end,
    GetSound = function(p1) --[[ Name: GetSound, Line 14 ]]
        if #p1._sounds == 0 then
            for _ = 1, 5 do
                table.insert(p1._sounds, p1:CreateSound());
            end;
        end;
        local v2 = p1._sounds[#p1._sounds];
        p1._sounds[#p1._sounds] = nil;
        return v2;
    end,
    ReturnSound = function(u3, u4) --[[ Name: ReturnSound, Line 25 ]]
        if u4.Playing then
            u4:Stop();
        end;
        u4.SoundGroup = nil;
        u4.Parent = nil;
        task.delay(0.03333333333333333, function() --[[ Line: 32 ]]
            -- upvalues: u3 (copy), u4 (copy)
            table.insert(u3._sounds, u4);
        end);
    end
};
for _ = 1, 50 do
    table.insert(v5._sounds, v5:CreateSound());
end;
return v5;
