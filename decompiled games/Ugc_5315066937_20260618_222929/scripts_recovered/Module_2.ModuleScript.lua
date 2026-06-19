-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local v1 = _G.obtain("CustomEnums");
local l__GAME_DEV__1 = v1.GAME_DEV;
local l__GAME_BHOP__2 = v1.GAME_BHOP;
local l__GAME_SURF__3 = v1.GAME_SURF;
local l__GAME_KREEDZCLIMB__4 = v1.GAME_KREEDZCLIMB;
local l__GAME_DEATHRUN__5 = v1.GAME_DEATHRUN;
local l__GAME_FLYTRIALS__6 = v1.GAME_FLYTRIALS;
local v2 = {
    bhop_main = 5315046213,
    surf_main = 5315066937,
    flytrials_main = 12591611759,
    bhop_maptest = 517201717,
    surf_maptest = 517206177,
    deathrun_maptest = 6870563649,
    flytrials_maptest = 12724901535,
    bhop_maptest_group = 12600642690,
    surf_maptest_group = 12600644884,
    deathrun_maptest_group = 12600647481,
    flytrials_maptest_group = 12591627978,
    staging = 5721760322,
    dev = 14001440964
};
local v3 = {
    [v2.bhop_main] = true,
    [v2.surf_main] = true,
    [v2.flytrials_main] = true
};
local v4 = {
    [v2.bhop_main] = l__GAME_BHOP__2,
    [v2.surf_main] = l__GAME_SURF__3,
    [v2.flytrials_main] = l__GAME_FLYTRIALS__6,
    [v2.bhop_maptest] = l__GAME_BHOP__2,
    [v2.surf_maptest] = l__GAME_SURF__3,
    [v2.deathrun_maptest] = l__GAME_DEATHRUN__5,
    [v2.flytrials_maptest] = l__GAME_FLYTRIALS__6,
    [v2.bhop_maptest_group] = l__GAME_BHOP__2,
    [v2.surf_maptest_group] = l__GAME_SURF__3,
    [v2.deathrun_maptest_group] = l__GAME_DEATHRUN__5,
    [v2.flytrials_maptest_group] = l__GAME_FLYTRIALS__6,
    [v2.dev] = l__GAME_DEV__1,
    [v2.staging] = l__GAME_DEV__1
};
local v5 = {
    [v2.dev] = true,
    [v2.staging] = true,
    [v2.bhop_maptest] = true,
    [v2.surf_maptest] = true,
    [v2.deathrun_maptest] = true,
    [v2.flytrials_maptest] = true,
    [v2.bhop_maptest_group] = true,
    [v2.surf_maptest_group] = true,
    [v2.deathrun_maptest_group] = true,
    [v2.flytrials_maptest_group] = true
};
local v6 = {
    [v2.bhop_main] = true,
    [v2.surf_main] = true,
    [v2.flytrials_main] = true
};
local v7 = {
    [v2.dev] = true,
    [v2.staging] = true
};
local v8 = {
    [v2.dev] = true,
    [v2.staging] = true,
    [v2.bhop_maptest] = true,
    [v2.surf_maptest] = true,
    [v2.deathrun_maptest] = true,
    [v2.flytrials_maptest] = true,
    [v2.bhop_maptest_group] = true,
    [v2.surf_maptest_group] = true,
    [v2.deathrun_maptest_group] = true,
    [v2.flytrials_maptest_group] = true,
    [v2.flytrials_main] = true
};
local v9 = {
    [v2.flytrials_main] = true,
    [v2.flytrials_maptest] = true,
    [v2.flytrials_maptest_group] = true,
    [v2.staging] = true,
    [v2.dev] = true
};
local l__PlaceId__7 = game.PlaceId;
local v10 = {
    [l__GAME_DEV__1] = "Dev",
    [l__GAME_BHOP__2] = "Bhop",
    [l__GAME_SURF__3] = "Surf",
    [l__GAME_DEATHRUN__5] = "Deathrun",
    [l__GAME_FLYTRIALS__6] = "Fly Trials"
};
local v11 = {
    [l__GAME_BHOP__2] = "bhop_",
    [l__GAME_SURF__3] = "surf_",
    [l__GAME_KREEDZCLIMB__4] = "kz_",
    [l__GAME_DEATHRUN__5] = "dr_",
    [l__GAME_FLYTRIALS__6] = "flytrials_"
};
local v12 = false;
local v13 = {};
for _, v14 in v2 do
    if l__PlaceId__7 == v14 then
        v12 = true;
    end;
end;
local v15 = {
    { v2.bhop_main, v2.surf_main, v2.flytrials_main },
    {
        v2.staging,
        v2.bhop_maptest,
        v2.surf_maptest,
        v2.deathrun_maptest,
        v2.flytrials_maptest
    },
    {
        v2.dev,
        v2.bhop_maptest_group,
        v2.surf_maptest_group,
        v2.deathrun_maptest_group,
        v2.flytrials_maptest_group
    }
};
local v16 = nil;
for v17 = 1, #v15 do
    if table.find(v15[v17], l__PlaceId__7) then
        v16 = v15[v17];
    end;
end;
return {
    GameID = v4[l__PlaceId__7] or 0,
    GameNames = v10,
    MapPrefixes = v11,
    IsTestPlace = not v3[l__PlaceId__7],
    IsStagingPlace = v7[l__PlaceId__7],
    IsTimeSavingPlace = v6[l__PlaceId__7],
    Valid = v12,
    PlaceId = l__PlaceId__7,
    PlaceIDs = v2,
    RelatedPlaceIDs = v16 or {},
    AllowMapAdding = v5[l__PlaceId__7],
    OmitGameIDMapListFilter = v8[l__PlaceId__7],
    UseSpoofedGameIDForStyles = v13[l__PlaceId__7],
    UseSpoofedGameIDForDefaultStyleInfo = v9[l__PlaceId__7]
};
