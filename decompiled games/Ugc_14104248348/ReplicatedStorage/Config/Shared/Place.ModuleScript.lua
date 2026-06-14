-- Decompiled from: ReplicatedStorage.Config.Shared.Place
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local v1 = require("./Teleports");
local v2 = v1[game.GameId];
local v3 = {};
if v2 then
    for v4, v5 in v2 do
        v3[v5] = v4;
    end;
end;
return {
    IsMainGame = game.GameId == 14104248348,
    Teleports = v1,
    ThisTeleports = v2,
    TeleportString = v3 and v3[game.PlaceId] or "Main"
};
