-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__random__1 = math.random;
local l__new__2 = Instance.new;
local v1 = _G.obtain("Class");
local v2 = v1();
function v2.Play(p3, p4) --[[ Line: 9 ]]
    local v5 = p3.SoundMap[p4[p3.Index]];
    if v5 then
        v5:Play(p4);
    end;
end;
function v2.Constructor(p6, p7, p8, p9) --[[ Line: 15 ]]
    p6.Index = p7;
    p6.SoundMap = p8;
    p6.Default = p9;
end;
local v10 = v1();
function v10.Play(p11, p12) --[[ Line: 23 ]]
    local l__SoundList__3 = p11.SoundList;
    for v13 = 1, p11.N do
        l__SoundList__3[v13]:Play(p12);
    end;
end;
function v10.Constructor(p14, p15) --[[ Line: 29 ]]
    p14.N = #p15;
    p14.SoundList = p15;
end;
local u16 = v1();
function u16.Play(p17, p18) --[[ Line: 36 ]]
    -- upvalues: l__new__2 (copy)
    local l__Part__4 = p18.Part;
    if l__Part__4 then
        local u19 = l__new__2("Sound", l__Part__4);
        u19.Volume = p18.Volume or 1;
        u19.PlaybackSpeed = p18.Scale or 1;
        u19.SoundId = "rbxassetid://" .. p17.ID;
        u19.Ended:connect(function() --[[ Line: 43 ]]
            -- upvalues: u19 (copy)
            u19:Destroy();
        end);
        u19:Play();
    end;
end;
function u16.Constructor(p20, p21) --[[ Line: 49 ]]
    p20.ID = p21;
end;
local v22 = v1();
function v22.Play(p23, p24) --[[ Line: 55 ]]
    -- upvalues: l__random__1 (copy)
    p23.SoundList[l__random__1(p23.N)]:Play(p24);
end;
function v22.Constructor(p25, p26) --[[ Line: 58 ]]
    -- upvalues: u16 (copy)
    local v27 = #p26;
    for v28 = 1, v27 do
        p26[v28] = u16(p26[v28]);
    end;
    p25.N = v27;
    p25.SoundList = p26;
end;
return {
    NewSound = u16,
    NewSoundPack = v22,
    NewMultiSound = v10,
    NewSoundMap = v2
};
