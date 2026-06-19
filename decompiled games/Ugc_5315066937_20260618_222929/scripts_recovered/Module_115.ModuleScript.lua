-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("CustomEnums");
local l__SOUND_TRACK_GROUND__2 = v1.SOUND_TRACK_GROUND;
local l__SOUND_TRACK_LADDER__3 = v1.SOUND_TRACK_LADDER;
local l__SOUND_JUMP_GROUND__4 = v1.SOUND_JUMP_GROUND;
local l__SOUND_JUMP_LADDER__5 = v1.SOUND_JUMP_LADDER;
local l__SOUND_SMASH_GROUND__6 = v1.SOUND_SMASH_GROUND;
local l__SOUND_SMASH_WALL__7 = v1.SOUND_SMASH_WALL;
local v2 = l__obtain__1("SoundObject");
local v3 = v2.NewSoundPack({
    268933841,
    268933900,
    268933974,
    268934012
});
local v4 = v2.NewSound(267883037);
local v5 = v2.NewSound(267882803);
local v6 = v2.NewSound(267454275);
local v7 = v2.NewSound(267454199);
local v8 = v2.NewSound(267882971);
local v9 = v2.NewSound(267882776);
local v10 = v2.NewSound(267882764);
local v11 = v2.NewSound(267882850);
local v12 = v2.NewSound(267454225);
local v13 = v2.NewSound(267882824);
local v14 = v2.NewSound(5634710863);
local v15 = v2.NewSound(5645905885);
local l__Material__8 = Enum.Material;
local v16 = v2.NewSoundMap("Material", {
    [l__Material__8.Air.Value] = v12,
    [l__Material__8.Asphalt.Value] = nil,
    [l__Material__8.Basalt.Value] = v12,
    [l__Material__8.Brick.Value] = v13,
    [l__Material__8.Cobblestone.Value] = v12,
    [l__Material__8.Concrete.Value] = v7,
    [l__Material__8.CorrodedMetal.Value] = v9,
    [l__Material__8.CrackedLava.Value] = v11,
    [l__Material__8.DiamondPlate.Value] = v9,
    [l__Material__8.Fabric.Value] = v10,
    [l__Material__8.Foil.Value] = v9,
    [l__Material__8.ForceField.Value] = nil,
    [l__Material__8.Glacier.Value] = v7,
    [l__Material__8.Glass.Value] = nil,
    [l__Material__8.Granite.Value] = v7,
    [l__Material__8.Grass.Value] = v10,
    [l__Material__8.Ground.Value] = v12,
    [l__Material__8.Ice.Value] = v7,
    [l__Material__8.LeafyGrass.Value] = nil,
    [l__Material__8.Limestone.Value] = nil,
    [l__Material__8.Marble.Value] = v7,
    [l__Material__8.Metal.Value] = v9,
    [l__Material__8.Mud.Value] = v12,
    [l__Material__8.Neon.Value] = v13,
    [l__Material__8.Pavement.Value] = nil,
    [l__Material__8.Pebble.Value] = v8,
    [l__Material__8.Plastic.Value] = v12,
    [l__Material__8.Rock.Value] = v8,
    [l__Material__8.Salt.Value] = nil,
    [l__Material__8.Sand.Value] = v11,
    [l__Material__8.Sandstone.Value] = v8,
    [l__Material__8.Slate.Value] = v7,
    [l__Material__8.SmoothPlastic.Value] = v13,
    [l__Material__8.Snow.Value] = v10,
    [l__Material__8.Water.Value] = v11,
    [l__Material__8.Wood.Value] = v5,
    [l__Material__8.WoodPlanks.Value] = v6
}, v12);
local v17 = v2.NewMultiSound({ v3, v16 });
local v18 = v2.NewMultiSound({ v3, v4 });
local v19 = v2.NewMultiSound({ v15, v16 });
local v20 = v2.NewMultiSound({ v14, v16 });
return {
    MainSound = v2.NewSoundMap("Sound", {
        [l__SOUND_TRACK_GROUND__2] = v16,
        [l__SOUND_TRACK_LADDER__3] = v4,
        [l__SOUND_JUMP_GROUND__4] = v17,
        [l__SOUND_JUMP_LADDER__5] = v18,
        [l__SOUND_SMASH_GROUND__6] = v20,
        [l__SOUND_SMASH_WALL__7] = v19
    })
};
