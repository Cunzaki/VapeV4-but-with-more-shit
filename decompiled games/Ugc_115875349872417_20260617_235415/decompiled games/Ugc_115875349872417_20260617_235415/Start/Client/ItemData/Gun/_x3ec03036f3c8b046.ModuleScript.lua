-- Decompiled from: Start.Client.ItemData.Gun._x3ec03036f3c8b046
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Promise);
require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Easer);
local l__Classes__1 = require(script.Parent.Parent.Parent.ClientRoot).Classes;
game:GetService("RunService");
local l__Instances__2 = script:FindFirstAncestor("Client"):WaitForChild("Instances");
local l___xfa1dcdd390325501__3 = require(script.Parent._xfa1dcdd390325501);
local u1 = {};
u1.__index = u1;
setmetatable(u1, l___xfa1dcdd390325501__3);
function u1._x47262089ae496a5d(_) --[[ Line: 28 ]]
    -- upvalues: l__Instances__2 (copy)
    return {
        model = l__Instances__2.Siege,
        offsets = {
            base_offset = CFrame.new(0, 0.15, 0),
            slide_offset = CFrame.new(-0.25, 0, 0),
            slide_rot = CFrame.Angles(0, 0, 0.2792526803190927)
        },
        params = {
            gunpoint_path = "GunPoint",
            equip_sound = "SIEGE_DRAW",
            shot_sound = "SIEGE_SHOT",
            bonus_shot_sound = "SIEGE_BONUS_SHOT",
            shot_effect = "siegeFlash",
            recoil_args = {
                18,
                18,
                6,
                { "pitch" },
                3,
                true,
                false,
                true,
                true
            }
        }
    };
end;
function u1._xafd29f1684593d0b(p2) --[[ Line: 47 ]]
    -- upvalues: l__Classes__1 (copy), u1 (copy), l___xfa1dcdd390325501__3 (copy)
    local v3 = p2 or l__Classes__1._x48271d11a14d156e:_xfa248435cddccd62(u1, script, "gun", "Siege");
    local v4 = l___xfa1dcdd390325501__3._xafd29f1684593d0b(v3.model, v3.offsets, v3.params);
    v4._xe9709f830ad162b1 = v3;
    setmetatable(v4, u1);
    return v4;
end;
return u1;
