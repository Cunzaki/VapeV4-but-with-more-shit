-- Decompiled from: Start.Client.ReplicatedEntities._x0254ce18485dd1ac
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

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
local l___x001ddfb7a4bdeb77__6 = require(script.Parent._x001ddfb7a4bdeb77);
local u1 = {};
u1.__index = u1;
setmetatable(u1, l___x001ddfb7a4bdeb77__6);
local l__Classes__7 = require(script.Parent.Parent.ClientRoot).Classes;
local _ = game.Players.LocalPlayer;
function u1._x90d4581ac99dd483(p2, p3) --[[ Line: 26 ]]
    -- upvalues: l__Classes__7 (copy), l___x001ddfb7a4bdeb77__6 (copy), u1 (copy), l__Trove__4 (copy)
    p3.gameplay_cue_data = {
        identity = "Zipline",
        cancellation_dist = p3.interaction_data.radius,
        getText = function() --[[ Name: getText, Line 30 ]]
            -- upvalues: l__Classes__7 (ref)
            local l__KeyCode__8 = l__Classes__7._x3e046bec2684f59c:_xc9966245cd0a44a8("INTERACT").KeyCode;
            return "[" .. l__Classes__7._x3e046bec2684f59c:_xfeef7f7b762e94d9(l__KeyCode__8) .. "] LATCH";
        end
    };
    local v4 = l___x001ddfb7a4bdeb77__6._x90d4581ac99dd483(p2, p3);
    setmetatable(v4, u1);
    v4._xbf7522cc663454b7 = l__Trove__4.new();
    return v4;
end;
function u1._x6ffb8b18ef4549c8(u5) --[[ Line: 46 ]]
    -- upvalues: l__Classes__7 (copy), l__TweenService__1 (copy), l__Easer__5 (copy)
    if u5._x8e883bdb5ce9e898 then
        l__Classes__7._x7058397dabccd000:_xea72e3a14c7359cc(u5._x8e883bdb5ce9e898);
        u5._x8e883bdb5ce9e898 = nil;
    end;
    u5._xbf7522cc663454b7:Clean();
    l__Classes__7._xbe184fb1376a575d:_x7ab8b42cc5920a78("ZIPLINE_END", true);
    local u6 = Instance.new("NumberValue");
    u6.Value = 0;
    l__TweenService__1:Create(u6, TweenInfo.new(1), {
        Value = 1
    }):Play();
    u6.Changed:Connect(function() --[[ Line: 60 ]]
        -- upvalues: u5 (copy), l__Classes__7 (ref), u6 (copy)
        if u5._x235fd0c4433cff17 then
            u5._x235fd0c4433cff17.value = l__Classes__7.Util:numLerp(u5._x235fd0c4433cff17.value, 0, u6.Value);
        end;
    end;
    game.Debris:AddItem(u6, 1);
    task.delay(1, function() --[[ Line: 66 ]]
        -- upvalues: u5 (copy)
        u5._x235fd0c4433cff17 = nil;
        if u5._xa2e22e863fd0ae04 then
            u5._xa2e22e863fd0ae04:cancel();
        end;
    end;
    local v7 = {
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
    l__Classes__7._x32ae459de0772e82:_x89ab120f43b710d2(v7, true, true);
    v7.easer:Run();
    l__Classes__7._x7b50da9f175b537e._x85dec45cd6eafa81.Zipline = nil;
    task.delay(1, function() --[[ Line: 93 ]]
        -- upvalues: u5 (copy)
        u5._x215be72d3f881056 = true;
    end;
end;
function u1._xb0d761c75620d0cb(p8) --[[ Line: 98 ]]
    -- upvalues: l__Classes__7 (copy)
    l__Classes__7._x7058397dabccd000:_x1f99809a04c1b4e4(p8._x8e883bdb5ce9e898);
end;
function u1._x41a643b20ca024fa(u9) --[[ Line: 102 ]]
    -- upvalues: l__Classes__7 (copy), l__Easer__5 (copy), l__Packets__3 (copy)
    if l__Classes__7._x7058397dabccd000._xfaaa497a74e50f3e and (l__Classes__7._x7058397dabccd000._x1cdffaf9f62b92e9 and (l__Classes__7._x7058397dabccd000._x1d287c838240a901 and not l__Classes__7._x7058397dabccd000._xab5fa47aca1475aa._x698d7df6fb2f7f8d)) then
        u9._x215be72d3f881056 = false;
        u9:_xdd7a2ded0e42f152();
        l__Classes__7._x7b50da9f175b537e._x85dec45cd6eafa81.Zipline = true;
        local l___xfaaa497a74e50f3e__9 = l__Classes__7._x7058397dabccd000._xfaaa497a74e50f3e;
        l__Classes__7._xbe184fb1376a575d:_x7ab8b42cc5920a78("ZIPLINE_START", true);
        local u10 = l__Classes__7._xbe184fb1376a575d:_x7ab8b42cc5920a78("ZIPLINE_LOOP", true);
        u9._xbf7522cc663454b7:Add(u10);
        local u11 = {
            angle_type = "roll",
            value = 0
        };
        local v12 = l__Classes__7._xd1706540247308ea:_x372c01be8a28bc70("augment");
        v12:_xcf4dfc356bd5ec17("ZiplineStart");
        if v12._xcaef75cb09b92ea0 then
            v12:_xcaef75cb09b92ea0();
        end;
        u9._x235fd0c4433cff17 = u11;
        u9._xa2e22e863fd0ae04 = l__Classes__7._x32ae459de0772e82:_xcd08cb309b2bdd1e(u11);
        local v13 = {
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
        l__Classes__7._x32ae459de0772e82:_x89ab120f43b710d2(v13, true, true);
        v13.easer:Run();
        u9._x8e883bdb5ce9e898 = l__Classes__7._x7058397dabccd000:_x0380dcddbbaa7a20(u9);
        if u9._x8e883bdb5ce9e898 then
            l__Packets__3._x1b774e73c6cfb3a6:Fire(u9._xe6b273660fc7b65e);
            u9._xbf7522cc663454b7:Add(l___xfaaa497a74e50f3e__9:ConnectSync(function(p14) --[[ Line: 155 ]]
                -- upvalues: l__Classes__7 (ref), u9 (copy), u11 (copy), u10 (copy)
                if not l__Classes__7._x7058397dabccd000:_x7fe15807baa62f65(u9._x8e883bdb5ce9e898, p14, u11, u10) then
                    u9:_x6ffb8b18ef4549c8();
                end;
            end;
            u9._xbf7522cc663454b7:Add(l__Classes__7._x3e046bec2684f59c:_xc9966245cd0a44a8("INTERACT").Pressed:Connect(function() --[[ Line: 162 ]]
                -- upvalues: u9 (copy)
                u9:_x6ffb8b18ef4549c8();
            end;
            u9._xbf7522cc663454b7:Add(l__Classes__7._x3e046bec2684f59c:_xc9966245cd0a44a8("JUMP").Pressed:Connect(function() --[[ Line: 166 ]]
                -- upvalues: u9 (copy)
                u9:_xb0d761c75620d0cb();
                u9:_x6ffb8b18ef4549c8();
            end;
        else
            u9:_x6ffb8b18ef4549c8();
        end;
    end;
end;
function u1._xe53615d96cf36a6b(p15) --[[ Line: 172 ]]
    -- upvalues: l__Classes__7 (copy)
    l__Classes__7._x7b50da9f175b537e:_x5d7b5a6e465d0a0a(p15);
    p15._x215be72d3f881056 = true;
    p15._x9dfab354fc7fd1f6 = "alive";
    local v16 = game:GetService("ReplicatedStorage").Assets.Models.ZiplineShaft:Clone();
    local v17 = l__Classes__7.Util:getLikelyVec3(p15._xe6b273660fc7b65e.First);
    local v18 = l__Classes__7.Util:getLikelyVec3(p15._xe6b273660fc7b65e.Last);
    p15._xbde909b00acf9234 = v17;
    p15._x398ade03a47de919 = v18;
    local v19 = v18 - v17;
    local l__Magnitude__10 = v19.Magnitude;
    local v20 = l__Magnitude__10 < 0.001 and 0.001 or l__Magnitude__10;
    local v21 = (v17 + v18) * 0.5;
    local l__Unit__11 = v19.Unit;
    p15._xb5ebe401e8892d16 = v19.Unit;
    p15._x6e43c0ed485ec258 = v20;
    local v22 = l__Unit__11:Dot(Vector3.new(0, 1, 0));
    local v23 = (math.abs(v22) > 0.999 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0)):Cross(l__Unit__11);
    local l__Unit__12 = (v23.Magnitude == 0 and Vector3.new(1, 0, 0) or v23).Unit;
    local l__Unit__13 = l__Unit__11:Cross(l__Unit__12).Unit;
    local l__X__14 = v16.Size.X;
    local _ = v16.Size.Y;
    v16.Size = Vector3.new(l__X__14, v20, v16.Size.Z);
    v16.CFrame = CFrame.fromMatrix(v21, l__Unit__12, l__Unit__11, l__Unit__13);
    v16.Anchored = true;
    v16.CanCollide = false;
    v16.Parent = p15._xe6b273660fc7b65e;
    p15._x28b7fb1e5e9a9ddb.reference_part = v16;
end;
return u1;
