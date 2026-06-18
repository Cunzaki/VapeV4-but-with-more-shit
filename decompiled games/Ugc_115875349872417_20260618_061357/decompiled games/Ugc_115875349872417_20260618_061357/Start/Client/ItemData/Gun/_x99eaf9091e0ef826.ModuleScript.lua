-- Decompiled from: Start.Client.ItemData.Gun._x99eaf9091e0ef826
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Promise);
require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Easer);
local l__Classes__1 = require(script.Parent.Parent.Parent.ClientRoot).Classes;
game:GetService("RunService");
local l__Instances__2 = script:FindFirstAncestor("Client"):WaitForChild("Instances");
local l___xd5deee1778c08157__3 = require(script.Parent._xd5deee1778c08157);
local u1 = {};
u1.__index = u1;
setmetatable(u1, l___xd5deee1778c08157__3);
function u1._xc091da12abbfb546(_) --[[ Line: 19 ]]
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
function u1._x90d4581ac99dd483(p2) --[[ Line: 38 ]]
    -- upvalues: l__Classes__1 (copy), u1 (copy), l___xd5deee1778c08157__3 (copy)
    local v3 = p2 or l__Classes__1._x51bf23f1b9ed859b:_x5e63d412d07a8493(u1, script, "gun", "Siege");
    local v4 = l___xd5deee1778c08157__3._x90d4581ac99dd483(v3.model, v3.offsets, v3.params);
    v4._x7b47345bff92786e = v3;
    setmetatable(v4, u1);
    return v4;
end;
return u1;
