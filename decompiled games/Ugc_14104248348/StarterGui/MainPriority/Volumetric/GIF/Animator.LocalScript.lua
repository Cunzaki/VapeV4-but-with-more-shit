-- Decompiled from: StarterGui.MainPriority.Volumetric.GIF.Animator
-- Class: LocalScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent;
local l__FrameDelay__2 = script.FrameDelay;
local u1 = {
    tile = {
        x = script.TileWidth.Value,
        y = script.TileHeight.Value
    },
    position = {
        iterate = -1,
        x = 1,
        y = 1
    }
};
local l__position__3 = u1.position;
local l__position__4 = u1.position;
local v2 = u1.position.iterate % u1.tile.x;
local v3 = math.floor(u1.position.iterate / u1.tile.x);
l__position__3.x = v2;
l__position__4.y = v3;
local v6 = coroutine.create(function() --[[ Line: 27 ]]
    -- upvalues: l__FrameDelay__2 (copy), u1 (copy), l__Parent__1 (copy)
    while wait(l__FrameDelay__2) do
        debug.profilebegin("IMGGIF :: Update");
        u1.position.iterate = u1.position.iterate + 1 > u1.tile.x * u1.tile.y - 1 and 1 or u1.position.iterate + 1;
        local l__position__5 = u1.position;
        local l__position__6 = u1.position;
        local v4 = u1.position.iterate % u1.tile.x;
        local v5 = math.floor(u1.position.iterate / u1.tile.x);
        l__position__5.x = v4;
        l__position__6.y = v5;
        l__Parent__1.ImageRectOffset = Vector2.new(u1.position.x * l__Parent__1.imageRectSize.X, u1.position.y * l__Parent__1.imageRectSize.Y);
        debug.profileend();
    end;
end);
coroutine.resume(v6);
