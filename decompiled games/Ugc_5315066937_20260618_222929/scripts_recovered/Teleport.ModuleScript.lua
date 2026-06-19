-- Decompiled from: Teleport
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__TeleportService__1 = game:GetService("TeleportService");
local l__obtain__2 = _G.obtain;
local l__Gen__3 = l__obtain__2("QC").Gen;
local u1 = l__obtain__2("QBox");
local l__FreeMouse__4 = u1.FreeMouse;
local u2 = l__obtain__2("Tween");
local v3 = l__obtain__2("Remote");
local l__Call__5 = v3.Call;
v3.Add("Teleport", function(...) --[[ Line: 16 ]]
    -- upvalues: l__TeleportService__1 (copy)
    l__TeleportService__1:Teleport(...);
end);
local function u17(p4, p5) --[[ Line: 20 ]]
    -- upvalues: u1 (copy), u2 (copy), l__Gen__3 (copy), l__FreeMouse__4 (copy)
    local u6 = u1.New();
    u6.SizeOffsetX = 400;
    u6.SizeOffsetY = 250;
    u6.PosScaleX = 0.5;
    u6.PosScaleY = 1;
    local u7 = false;
    local u9 = u2.New(0, function(p8) --[[ Line: 28 ]]
        -- upvalues: u7 (ref), u6 (copy)
        u7 = true;
        u6.PosOffsetY = p8;
        u7 = false;
    end);
    u9.MaxAcceleration = u2.MaxAcceleration(0, u6.SizeY, 0, 0, 0.25);
    u6.Callbacks[{
        PosOffsetY = true
    }] = function() --[[ Line: 34 ]]
        -- upvalues: u7 (ref), u9 (copy), u6 (copy)
        if not u7 then
            u9.x1 = u6.PosOffsetY;
        end;
    end;
    function u6.Resize() --[[ Line: 40 ]]
        -- upvalues: u6 (copy), u9 (copy)
        u6.PosOffsetX = u6.SizeX / -2;
        u6.PosOffsetY = u9:Value();
    end;
    local v10 = u1.TextBox(u6, "Teleport Arrival");
    v10.TextSize = 12 * u1.roblox_messing_with_guis_factor;
    v10.TextAlignment = "Center";
    v10.BackgroundColor = u1.Color2;
    v10.SizeScaleX = 1;
    v10.SizeOffsetX = -40;
    v10.SizeOffsetY = 40;
    u1.DragBar(v10, u6);
    local v11 = u1.TextBox(u6, "x");
    v11.TextSize = 12 * u1.roblox_messing_with_guis_factor;
    v11.TextAlignment = "Center";
    v11.SizeOffsetX = 40;
    v11.SizeOffsetY = 40;
    v11.PosOffsetX = -40;
    v11.PosScaleX = 1;
    local v12 = u1.New(u6);
    v12.SizeScaleX = 1;
    v12.SizeScaleY = 1;
    v12.SizeOffsetY = -80;
    v12.PosOffsetY = 60;
    local v13 = u1.New();
    v13.SizeScaleX = 1;
    local v14;
    if p5 and not p4 then
        v14 = l__Gen__3({ "Text", "You are being teleport forwarded\nto the place you requested to join..." });
    else
        local v15 = {
            "Column",
            {
                "Image",
                305.3333333333333,
                83.33333333333333,
                5706452615,
                true
            },
            { "Space", 0, 20 },
            { "Text", (p4 == 1 and "bhop" or (p4 == 2 and "surf" or "[GAME LOL]")) .. " has moved to this group game" },
            {
                "List",
                { "Text", "Like the game and add it to your  " },
                {
                    "Image",
                    30,
                    30,
                    228648932,
                    true
                },
                { "Text", "Favourites!" }
            }
        };
        if p5 then
            v15[#v15 + 1] = { "Space", 0, 20 };
            v15[#v15 + 1] = { "Text", "Private servers will continue to forward players to the new game." };
            v15[#v15 + 1] = { "Text", "Buy a private server on the new game." };
        end;
        v14 = l__Gen__3(v15);
    end;
    if v14 then
        v14.Parent = v13;
        v14.PosScaleX = 0.5;
        v14.PosScaleY = 0.5;
        v14.PosOffsetX = v14.SizeX / -2;
        v14.PosOffsetY = v14.SizeY / -2;
        v13.SizeOffsetY = v14.SizeY;
    end;
    u1.Scroll(v13, v12);
    local u16 = false;
    function v11.Button1Down() --[[ Line: 108 ]]
        -- upvalues: u16 (ref), l__FreeMouse__4 (ref), u9 (copy), u6 (copy)
        u16 = false;
        l__FreeMouse__4("TeleportArrival", false);
        u9:Target(0, function() --[[ Line: 111 ]]
            -- upvalues: u6 (ref)
            u6:Remove();
        end);
    end;
    u16 = true;
    l__FreeMouse__4("TeleportArrival", true);
    u6.Visible = true;
    u9:Target(-u6.Parent.SizeY / 2 - u6.SizeY / 2);
end;
local u18 = {
    [252877716] = 1,
    [272689493] = 2,
    [262118991] = 1,
    [272689543] = 2
};
local u19 = true;
v3.Add("Forwarding", function() --[[ Line: 135 ]]
    -- upvalues: u19 (ref), u17 (copy)
    if u19 then
        u19 = false;
        u17(nil, true);
    end;
end);
return function() --[[ Line: 142 ]]
    -- upvalues: l__TeleportService__1 (copy), l__Call__5 (copy), u18 (copy), u17 (copy)
    local v20 = l__TeleportService__1:GetLocalPlayerTeleportData();
    l__Call__5("TeleportData", v20);
    if v20 then
        local l__PlaceId__6 = v20.PlaceId;
        if game.PlaceId ~= l__PlaceId__6 and u18[l__PlaceId__6] then
            u17(u18[l__PlaceId__6], v20.IsForwardedPrivateServer);
        end;
    end;
end;
