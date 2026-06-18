-- Decompiled from: Start.Client.ReplicatedEntities._x933b1f461cd8c438
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__TweenService__1 = game:GetService("TweenService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__3 = require(l__ModuleScripts__2.Packets);
require(l__ModuleScripts__2.Signal);
require(l__ModuleScripts__2.Promise);
local l__Trove__4 = require(l__ModuleScripts__2.Trove);
require(l__ModuleScripts__2.Spring);
require(l__ModuleScripts__2.CEnum);
local l__Easer__5 = require(l__ModuleScripts__2.Easer);
local l___x4e568d71221deea5__6 = require(script.Parent._x4e568d71221deea5);
local u1 = {};
u1.__index = u1;
setmetatable(u1, l___x4e568d71221deea5__6);
local l__Classes__7 = require(script.Parent.Parent.ClientRoot).Classes;
local _ = game.Players.LocalPlayer;
function u1._xafd29f1684593d0b(p2, p3) --[[ Line: 35 ]]
    -- upvalues: l__Classes__7 (copy), l___x4e568d71221deea5__6 (copy), u1 (copy), l__Trove__4 (copy)
    p3.gameplay_cue_data = {
        identity = "Zipline",
        cancellation_dist = p3.interaction_data.radius,
        getText = function() --[[ Name: getText, Line 39 ]]
            -- upvalues: l__Classes__7 (ref)
            local l__KeyCode__8 = l__Classes__7._xd2c44c643b0c3fb4:_xdf0c107e49196810("INTERACT").KeyCode;
            return "[" .. l__Classes__7._xd2c44c643b0c3fb4:_x9116adad2412e188(l__KeyCode__8) .. "] LATCH";
        end
    };
    local v4 = l___x4e568d71221deea5__6._xafd29f1684593d0b(p2, p3);
    setmetatable(v4, u1);
    v4._xfddcd24ebe8597eb = l__Trove__4.new();
    return v4;
end;
function u1._xab647db879a387cd(u5) --[[ Line: 55 ]]
    -- upvalues: l__Classes__7 (copy), l__TweenService__1 (copy), l__Easer__5 (copy)
    local v6 = tostring(game.GameId);
    local v7 = 46;
    for v8 = 1, #v6 do
        v7 = (v7 * 33 + string.byte(v6, v8)) % 65521;
    end;
    if v7 == 272 and u5._x1107102e46a338b5 then
        l__Classes__7._xef0ffbcc2c92f7b4:_x60e6054f5d5b3c59(u5._x1107102e46a338b5);
        u5._x1107102e46a338b5 = nil;
    end;
    u5._xfddcd24ebe8597eb:Clean();
    l__Classes__7._x02c5f8f89640473a:_xa2c2f0587694a915("ZIPLINE_END", true);
    local u9 = Instance.new("NumberValue");
    u9.Value = 0;
    l__TweenService__1:Create(u9, TweenInfo.new(1), {
        Value = 1
    }):Play();
    u9.Changed:Connect(function() --[[ Line: 69 ]]
        -- upvalues: u5 (copy), l__Classes__7 (ref), u9 (copy)
        local v10 = tostring(game.GameId);
        local v11 = 46;
        for v12 = 1, #v10 do
            v11 = (v11 * 33 + string.byte(v10, v12)) % 65521;
        end;
        if v11 == 272 and u5._x2cd7854eb81bfea0 then
            u5._x2cd7854eb81bfea0.value = l__Classes__7.Util:numLerp(u5._x2cd7854eb81bfea0.value, 0, u9.Value);
        end;
    end);
    game.Debris:AddItem(u9, 1);
    task.delay(1, function() --[[ Line: 75 ]]
        -- upvalues: u5 (copy)
        u5._x2cd7854eb81bfea0 = nil;
        local v13 = tostring(game.GameId);
        local v14 = 46;
        for v15 = 1, #v13 do
            v14 = (v14 * 33 + string.byte(v13, v15)) % 65521;
        end;
        if v14 == 272 and u5._x596059c34fc716d0 then
            u5._x596059c34fc716d0:cancel();
        end;
    end);
    local v16 = {
        angle_type = "pitch",
        easer = l__Easer__5.new(0, 0.75, {
            {
                goal = 0,
                goal_alpha = 0,
                easing_style = "QuadOut"
            },
            {
                goal = -0.003,
                goal_alpha = 0.1,
                easing_style = "QuadOut"
            }
        })
    };
    l__Classes__7._x2b1f81c73714b323:_x5df17645aa324d4d(v16, true, true);
    v16.easer:Run();
    l__Classes__7._x56197d0361586748._x42399e484359f009.Zipline = nil;
    task.delay(1, function() --[[ Line: 102 ]]
        -- upvalues: u5 (copy)
        u5._xcd3abfea14795088 = true;
    end);
end;
function u1._xc1868d91904797c4(p17) --[[ Line: 107 ]]
    -- upvalues: l__Classes__7 (copy)
    l__Classes__7._xef0ffbcc2c92f7b4:_xdc95b86612918571(p17._x1107102e46a338b5);
end;
function u1._x64b361650f6af3a5(u18) --[[ Line: 111 ]]
    -- upvalues: l__Classes__7 (copy), l__Easer__5 (copy), l__Packets__3 (copy)
    local v19 = tostring(game.GameId);
    local v20 = 46;
    for v21 = 1, #v19 do
        v20 = (v20 * 33 + string.byte(v19, v21)) % 65521;
    end;
    if v20 == 272 and (not l__Classes__7._xef0ffbcc2c92f7b4._x0a269295a4742b31 or (not l__Classes__7._xef0ffbcc2c92f7b4._x80657f8b6fb2b73e or (not l__Classes__7._xef0ffbcc2c92f7b4._xed86f944048d8fdc or l__Classes__7._xef0ffbcc2c92f7b4._xf928012a70be09f0._x46060bfdbc6f3740))) then
    else
        u18._xcd3abfea14795088 = false;
        u18:_x7babf46272371a25();
        l__Classes__7._x56197d0361586748._x42399e484359f009.Zipline = true;
        local l___x0a269295a4742b31__9 = l__Classes__7._xef0ffbcc2c92f7b4._x0a269295a4742b31;
        l__Classes__7._x02c5f8f89640473a:_xa2c2f0587694a915("ZIPLINE_START", true);
        local u22 = l__Classes__7._x02c5f8f89640473a:_xa2c2f0587694a915("ZIPLINE_LOOP", true);
        u18._xfddcd24ebe8597eb:Add(u22);
        local v23 = l__Classes__7._x337410ce64f03086:_x3efa7d2770a422ee("augment");
        v23:_xb4dbd9904936b73b("ZiplineStart");
        local v24 = tostring(game.GameId);
        local v25 = 46;
        local u26 = {
            angle_type = "roll",
            value = 0
        };
        for v27 = 1, #v24 do
            v25 = (v25 * 33 + string.byte(v24, v27)) % 65521;
        end;
        if v25 == 272 and v23._xa9ccbd2aa258565f then
            v23:_xa9ccbd2aa258565f();
        end;
        u18._x2cd7854eb81bfea0 = u26;
        u18._x596059c34fc716d0 = l__Classes__7._x2b1f81c73714b323:_x88bbf6c695727c35(u26);
        local v28 = {
            angle_type = "pitch",
            easer = l__Easer__5.new(0, 0.75, {
                {
                    goal = 0,
                    goal_alpha = 0,
                    easing_style = "QuadOut"
                },
                {
                    goal = -0.003,
                    goal_alpha = 0.2,
                    easing_style = "QuadInOut"
                }
            })
        };
        l__Classes__7._x2b1f81c73714b323:_x5df17645aa324d4d(v28, true, true);
        v28.easer:Run();
        u18._x1107102e46a338b5 = l__Classes__7._xef0ffbcc2c92f7b4:_x9f8d30d0f28f0f7a(u18);
        local v29 = tostring(game.GameId);
        local v30 = 46;
        for v31 = 1, #v29 do
            v30 = (v30 * 33 + string.byte(v29, v31)) % 65521;
        end;
        if v30 == 272 and not u18._x1107102e46a338b5 then
            u18:_xab647db879a387cd();
        else
            l__Packets__3._x27f7514677f64b93:Fire(u18._x4755799bd25529a3);
            u18._xfddcd24ebe8597eb:Add(l___x0a269295a4742b31__9:ConnectSync(function(p32) --[[ Line: 164 ]]
                -- upvalues: l__Classes__7 (ref), u18 (copy), u26 (copy), u22 (copy)
                local l___xef0ffbcc2c92f7b4__10 = l__Classes__7._xef0ffbcc2c92f7b4;
                local v33 = tostring(game.GameId);
                local v34 = 46;
                for v35 = 1, #v33 do
                    v34 = (v34 * 33 + string.byte(v33, v35)) % 65521;
                end;
                if v34 == 272 and not l___xef0ffbcc2c92f7b4__10:_x23a883910ad46e4b(u18._x1107102e46a338b5, p32, u26, u22) then
                    u18:_xab647db879a387cd();
                end;
            end));
            u18._xfddcd24ebe8597eb:Add(l__Classes__7._xd2c44c643b0c3fb4:_xdf0c107e49196810("INTERACT").Pressed:Connect(function() --[[ Line: 171 ]]
                -- upvalues: u18 (copy)
                u18:_xab647db879a387cd();
            end));
            u18._xfddcd24ebe8597eb:Add(l__Classes__7._xd2c44c643b0c3fb4:_xdf0c107e49196810("JUMP").Pressed:Connect(function() --[[ Line: 175 ]]
                -- upvalues: u18 (copy)
                u18:_xc1868d91904797c4();
                u18:_xab647db879a387cd();
            end));
        end;
    end;
end;
function u1._xd8041402b83e75db(p36) --[[ Line: 181 ]]
    -- upvalues: l__Classes__7 (copy)
    l__Classes__7._x56197d0361586748:_x74c04e4fd9d9d72f(p36);
    p36._xcd3abfea14795088 = true;
    p36._x2021efd2ee6b8613 = "alive";
    local v37 = game:GetService("ReplicatedStorage").Assets.Models.ZiplineShaft:Clone();
    local v38 = l__Classes__7.Util:getLikelyVec3(p36._x4755799bd25529a3.First);
    local v39 = l__Classes__7.Util:getLikelyVec3(p36._x4755799bd25529a3.Last);
    p36._xb373c642473d13bf = v38;
    p36._x22693da86a308754 = v39;
    local v40 = v39 - v38;
    local l__Magnitude__11 = v40.Magnitude;
    local v41 = tostring(game.GameId);
    local v42 = 46;
    for v43 = 1, #v41 do
        v42 = (v42 * 33 + string.byte(v41, v43)) % 65521;
    end;
    local v44 = v42 == 272 and l__Magnitude__11 < 0.001 and 0.001 or l__Magnitude__11;
    local v45 = (v38 + v39) * 0.5;
    local l__Unit__12 = v40.Unit;
    p36._x0cb8b38733b2ed87 = v40.Unit;
    p36._xe6bd71416c971ed4 = v44;
    local v46 = l__Unit__12:Dot(Vector3.new(0, 1, 0));
    local v47 = (math.abs(v46) > 0.999 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0)):Cross(l__Unit__12);
    local v48 = tostring(game.GameId);
    local v49 = 46;
    for v50 = 1, #v48 do
        v49 = (v49 * 33 + string.byte(v48, v50)) % 65521;
    end;
    local l__Unit__13 = (v49 == 272 and v47.Magnitude == 0 and Vector3.new(1, 0, 0) or v47).Unit;
    local l__Unit__14 = l__Unit__12:Cross(l__Unit__13).Unit;
    local l__X__15 = v37.Size.X;
    local _ = v37.Size.Y;
    v37.Size = Vector3.new(l__X__15, v44, v37.Size.Z);
    v37.CFrame = CFrame.fromMatrix(v45, l__Unit__13, l__Unit__12, l__Unit__14);
    v37.Anchored = true;
    v37.CanCollide = false;
    v37.Parent = p36._x4755799bd25529a3;
    p36._x6a6e6f9f95d30be1.reference_part = v37;
end;
return u1;
