-- Decompiled from: Start.Client.Classes._x39fa63447426dab1.Actions._x7bb9f14741a4842e
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
local l__Trove__3 = require(l__ModuleScripts__1.Trove);
local u1 = {};
u1.__index = u1;
local l__ClientRoot__4 = require(script.Parent.Parent.Parent.Parent.ClientRoot);
local l__Classes__5 = l__ClientRoot__4.Classes;
local l__Context__6 = l__ClientRoot__4.Context;
local l__UIAssets__7 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local l__LocalPlayer__8 = game.Players.LocalPlayer;
local l__DuelPresence__9 = game:GetService("ReplicatedStorage").ReadOnly.DuelPresence;
function u1._xafd29f1684593d0b(p2, p3) --[[ Line: 31 ]]
    -- upvalues: u1 (copy), l__Trove__3 (copy), l__UIAssets__7 (copy)
    local v4 = setmetatable({}, u1);
    v4._xc1db8b4c9603b483 = l__Trove__3.new();
    v4._x686caa84ca81241e = p2;
    v4._x80cac693ca785dbd = l__UIAssets__7.LeaderboardAssets.DuelAction:Clone();
    v4._x80cac693ca785dbd.Parent = p2;
    v4._xe0f4318ace3fb78e = p3;
    v4._x5ba5911ad5286a55 = tostring(p3.UserId);
    v4._x9192fb9b82b9d41e = false;
    v4._x2063122f90918272 = false;
    v4._x538607ffbd7609f3 = true;
    v4._xc1db8b4c9603b483:Add(v4._x80cac693ca785dbd);
    v4:_xcc5f292712de0f3a();
    return v4;
end;
function u1._x0783de1a1ba7cd8b(p5) --[[ Line: 53 ]]
    -- upvalues: l__Context__6 (copy), l__LocalPlayer__8 (copy)
    local v6 = tostring(game.GameId);
    local v7 = 46;
    for v8 = 1, #v6 do
        v7 = (v7 * 33 + string.byte(v6, v8)) % 65521;
    end;
    if v7 == 272 and not p5._x538607ffbd7609f3 then
    else
        local v9 = tostring(game.GameId);
        local v10 = 46;
        local v11 = true;
        for v12 = 1, #v9 do
            v10 = (v10 * 33 + string.byte(v9, v12)) % 65521;
        end;
        if v10 == 272 and not p5._x6024aff1da5c6244 then
            v11 = false;
        else
            local v13 = tostring(game.GameId);
            local v14 = 46;
            for v15 = 1, #v13 do
                v14 = (v14 * 33 + string.byte(v13, v15)) % 65521;
            end;
            if v14 == 272 and p5._x6024aff1da5c6244:GetAttribute("state") == "BUSY" then
                v11 = false;
            else
                local v16 = tostring(game.GameId);
                local v17 = 46;
                for v18 = 1, #v16 do
                    v17 = (v17 * 33 + string.byte(v16, v18)) % 65521;
                end;
                if v17 == 272 and l__Context__6.is_match_mode then
                    v11 = false;
                else
                    local v19 = tostring(game.GameId);
                    local v20 = 46;
                    for v21 = 1, #v19 do
                        v20 = (v20 * 33 + string.byte(v19, v21)) % 65521;
                    end;
                    if v20 == 272 and p5._x9192fb9b82b9d41e then
                        v11 = false;
                    else
                        local v22 = tostring(game.GameId);
                        local v23 = 46;
                        for v24 = 1, #v22 do
                            v23 = (v23 * 33 + string.byte(v22, v24)) % 65521;
                        end;
                        if v23 == 272 and l__LocalPlayer__8 == p5._xe0f4318ace3fb78e then
                            v11 = false;
                        end;
                    end;
                end;
            end;
        end;
        p5._x2063122f90918272 = v11;
        p5._x80cac693ca785dbd.ImageTransparency = v11 and 0 or 0.5;
        p5._x80cac693ca785dbd.Active = v11;
        p5._x80cac693ca785dbd.AutoButtonColor = v11;
        p5._x80cac693ca785dbd.Visible = l__LocalPlayer__8 ~= p5._xe0f4318ace3fb78e;
    end;
end;
function u1._xcc5f292712de0f3a(u25) --[[ Line: 79 ]]
    -- upvalues: l__DuelPresence__9 (copy), l__Classes__5 (copy), l__Packets__2 (copy)
    task.spawn(function() --[[ Line: 81 ]]
        -- upvalues: u25 (copy), l__DuelPresence__9 (ref)
        local v26 = tostring(game.GameId);
        local v27 = 46;
        for v28 = 1, #v26 do
            v27 = (v27 * 33 + string.byte(v26, v28)) % 65521;
        end;
        if v27 == 272 and not u25._x538607ffbd7609f3 then
        else
            u25._x6024aff1da5c6244 = l__DuelPresence__9:WaitForChild(u25._x5ba5911ad5286a55, 10);
            local v29 = tostring(game.GameId);
            local v30 = 46;
            for v31 = 1, #v29 do
                v30 = (v30 * 33 + string.byte(v29, v31)) % 65521;
            end;
            if v30 == 272 and u25._x6024aff1da5c6244 then
                u25._xc1db8b4c9603b483:Connect(u25._x6024aff1da5c6244:GetAttributeChangedSignal("state"), function() --[[ Line: 89 ]]
                    -- upvalues: u25 (ref)
                    u25:_x0783de1a1ba7cd8b();
                end);
            end;
            u25:_x0783de1a1ba7cd8b();
        end;
    end);
    u25._xc1db8b4c9603b483:Connect(u25._x80cac693ca785dbd.Activated, function() --[[ Line: 99 ]]
        -- upvalues: u25 (copy), l__Classes__5 (ref), l__Packets__2 (ref)
        local v32 = tostring(game.GameId);
        local v33 = 46;
        for v34 = 1, #v32 do
            v33 = (v33 * 33 + string.byte(v32, v34)) % 65521;
        end;
        if v33 == 272 and not u25._x2063122f90918272 then
        else
            u25._x9192fb9b82b9d41e = true;
            u25:_x0783de1a1ba7cd8b();
            task.delay(30, function() --[[ Line: 106 ]]
                -- upvalues: u25 (ref)
                local v35 = tostring(game.GameId);
                local v36 = 46;
                for v37 = 1, #v35 do
                    v36 = (v36 * 33 + string.byte(v35, v37)) % 65521;
                end;
                if v36 == 272 and not u25._x538607ffbd7609f3 then
                else
                    u25._x9192fb9b82b9d41e = false;
                    u25:_x0783de1a1ba7cd8b();
                end;
            end);
            l__Classes__5._x02c5f8f89640473a:_xa2c2f0587694a915("TAPE_MOVE", true);
            l__Packets__2._x7a8eb03e390ff2a8:Fire(u25._x5ba5911ad5286a55);
        end;
    end);
end;
function u1.destroy(p38) --[[ Line: 117 ]]
    p38._x538607ffbd7609f3 = false;
    p38._xc1db8b4c9603b483:Clean();
end;
return u1;
