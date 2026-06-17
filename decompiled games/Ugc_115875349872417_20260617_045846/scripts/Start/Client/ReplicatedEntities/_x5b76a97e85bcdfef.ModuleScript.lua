-- Decompiled from: Start.Client.ReplicatedEntities._x5b76a97e85bcdfef
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

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
local l___x74b71dc9fd65af04__6 = require(script.Parent._x74b71dc9fd65af04);
local u1 = {};
u1.__index = u1;
setmetatable(u1, l___x74b71dc9fd65af04__6);
local l__Classes__7 = require(script.Parent.Parent.ClientRoot).Classes;
local _ = game.Players.LocalPlayer;
function u1._x83ed94bfb82a8c9f(p2, p3) --[[ Line: 35 ]]
    -- upvalues: l__Classes__7 (copy), l___x74b71dc9fd65af04__6 (copy), u1 (copy), l__Trove__4 (copy)
    p3.gameplay_cue_data = {
        identity = "Zipline",
        cancellation_dist = p3.interaction_data.radius,
        getText = function() --[[ Name: getText, Line 39 ]]
            -- upvalues: l__Classes__7 (ref)
            local l__KeyCode__8 = l__Classes__7._xf1ad98d2d70b7408:_x93fd21adac562b5e("INTERACT").KeyCode;
            return "[" .. l__Classes__7._xf1ad98d2d70b7408:_x9afb0bbcc2b58dcd(l__KeyCode__8) .. "] LATCH";
        end
    };
    local v4 = l___x74b71dc9fd65af04__6._x83ed94bfb82a8c9f(p2, p3);
    setmetatable(v4, u1);
    v4._xee2fd739e090a57a = l__Trove__4.new();
    return v4;
end;
function u1._x91f1a55d9b284c4f(u5) --[[ Line: 55 ]]
    -- upvalues: l__Classes__7 (copy), l__TweenService__1 (copy), l__Easer__5 (copy)
    if u5._x15a275aca50e147b then
        l__Classes__7._x1a4ce4062771e36e:_x0eb5ccec0b5644bf(u5._x15a275aca50e147b);
        u5._x15a275aca50e147b = nil;
    end;
    u5._xee2fd739e090a57a:Clean();
    l__Classes__7._x6dbba03a0636f7d8:_x282746dbf42c87cb("ZIPLINE_END", true);
    local u6 = Instance.new("NumberValue");
    u6.Value = 0;
    l__TweenService__1:Create(u6, TweenInfo.new(1), {
        Value = 1
    }):Play();
    u6.Changed:Connect(function() --[[ Line: 69 ]]
        -- upvalues: u5 (copy), l__Classes__7 (ref), u6 (copy)
        if u5._x37f124fa3f1a4c5a then
            u5._x37f124fa3f1a4c5a.value = l__Classes__7.Util:numLerp(u5._x37f124fa3f1a4c5a.value, 0, u6.Value);
        end;
    end);
    game.Debris:AddItem(u6, 1);
    task.delay(1, function() --[[ Line: 75 ]]
        -- upvalues: u5 (copy)
        u5._x37f124fa3f1a4c5a = nil;
        if u5._x790689d0144583ea then
            u5._x790689d0144583ea:cancel();
        end;
    end);
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
    l__Classes__7._xdca80115d2839102:_x67da5f869bceed5d(v7, true, true);
    v7.easer:Run();
    l__Classes__7._x001619ec42f5322c._xec932354ef7d6d02.Zipline = nil;
    task.delay(1, function() --[[ Line: 102 ]]
        -- upvalues: u5 (copy)
        u5._x0b7325c049f4fdb4 = true;
    end);
end;
function u1._xd9380eabc863be04(p8) --[[ Line: 107 ]]
    -- upvalues: l__Classes__7 (copy)
    l__Classes__7._x1a4ce4062771e36e:_x5ff9d4092ba07ec7(p8._x15a275aca50e147b);
end;
function u1._x35224e4a48526095(u9) --[[ Line: 111 ]]
    -- upvalues: l__Classes__7 (copy), l__Easer__5 (copy), l__Packets__3 (copy)
    if l__Classes__7._x1a4ce4062771e36e._x10680b70730eb5bf and (l__Classes__7._x1a4ce4062771e36e._xde8b8f659627fa3f and (l__Classes__7._x1a4ce4062771e36e._xfd7cc994ccc60ad7 and not l__Classes__7._x1a4ce4062771e36e._x951b8a58c97ff8ca._xeee95dd21a2f10e9)) then
        u9._x0b7325c049f4fdb4 = false;
        u9:_x83d349acda1b2624();
        l__Classes__7._x001619ec42f5322c._xec932354ef7d6d02.Zipline = true;
        local l___x10680b70730eb5bf__9 = l__Classes__7._x1a4ce4062771e36e._x10680b70730eb5bf;
        l__Classes__7._x6dbba03a0636f7d8:_x282746dbf42c87cb("ZIPLINE_START", true);
        local u10 = l__Classes__7._x6dbba03a0636f7d8:_x282746dbf42c87cb("ZIPLINE_LOOP", true);
        u9._xee2fd739e090a57a:Add(u10);
        local u11 = {
            angle_type = "roll",
            value = 0
        };
        local v12 = l__Classes__7._x8613500a592ecb35:_x743a226b34a5008a("augment");
        v12:_x7e23f95dc7e22970("ZiplineStart");
        if v12._x533b8ba3e275f336 then
            v12:_x533b8ba3e275f336();
        end;
        u9._x37f124fa3f1a4c5a = u11;
        u9._x790689d0144583ea = l__Classes__7._xdca80115d2839102:_xefd1283dc89f1857(u11);
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
        l__Classes__7._xdca80115d2839102:_x67da5f869bceed5d(v13, true, true);
        v13.easer:Run();
        u9._x15a275aca50e147b = l__Classes__7._x1a4ce4062771e36e:_xea8f67a4edb09c3d(u9);
        if u9._x15a275aca50e147b then
            l__Packets__3._xdce6104c079e4c66:Fire(u9._x2401f1dccc8d59b5);
            u9._xee2fd739e090a57a:Add(l___x10680b70730eb5bf__9:ConnectSync(function(p14) --[[ Line: 164 ]]
                -- upvalues: l__Classes__7 (ref), u9 (copy), u11 (copy), u10 (copy)
                if not l__Classes__7._x1a4ce4062771e36e:_xd7caf71075488924(u9._x15a275aca50e147b, p14, u11, u10) then
                    u9:_x91f1a55d9b284c4f();
                end;
            end));
            u9._xee2fd739e090a57a:Add(l__Classes__7._xf1ad98d2d70b7408:_x93fd21adac562b5e("INTERACT").Pressed:Connect(function() --[[ Line: 171 ]]
                -- upvalues: u9 (copy)
                u9:_x91f1a55d9b284c4f();
            end));
            u9._xee2fd739e090a57a:Add(l__Classes__7._xf1ad98d2d70b7408:_x93fd21adac562b5e("JUMP").Pressed:Connect(function() --[[ Line: 175 ]]
                -- upvalues: u9 (copy)
                u9:_xd9380eabc863be04();
                u9:_x91f1a55d9b284c4f();
            end));
        else
            u9:_x91f1a55d9b284c4f();
        end;
    end;
end;
function u1._x44bcd6af41218f92(p15) --[[ Line: 181 ]]
    -- upvalues: l__Classes__7 (copy)
    l__Classes__7._x001619ec42f5322c:_x9329d49f87bd9806(p15);
    p15._x0b7325c049f4fdb4 = true;
    p15._xc5ae78e6b69f5669 = "alive";
    local v16 = game:GetService("ReplicatedStorage").Assets.Models.ZiplineShaft:Clone();
    local v17 = l__Classes__7.Util:getLikelyVec3(p15._x2401f1dccc8d59b5.First);
    local v18 = l__Classes__7.Util:getLikelyVec3(p15._x2401f1dccc8d59b5.Last);
    p15._x397e55a21e7938f4 = v17;
    p15._x9d35f066711a8328 = v18;
    local v19 = v18 - v17;
    local l__Magnitude__10 = v19.Magnitude;
    local v20 = l__Magnitude__10 < 0.001 and 0.001 or l__Magnitude__10;
    local v21 = (v17 + v18) * 0.5;
    local l__Unit__11 = v19.Unit;
    p15._x4dc0be43b3286156 = v19.Unit;
    p15._x0b6e393506de65f9 = v20;
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
    v16.Parent = p15._x2401f1dccc8d59b5;
    p15._x22924a5c5b7265a0.reference_part = v16;
end;
return u1;
