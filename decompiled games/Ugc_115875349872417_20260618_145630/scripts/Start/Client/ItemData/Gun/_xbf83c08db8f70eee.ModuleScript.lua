-- Decompiled from: Start.Client.ItemData.Gun._xbf83c08db8f70eee
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

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
        model = l__Instances__2.Castigate,
        offsets = {
            base_offset = CFrame.new(0, 0, 0.3)
        },
        params = {
            gunpoint_path = {
                "Gun",
                "Parts",
                "MainBarrel",
                "GunPoint"
            }
        }
    };
end;
function u1._x90d4581ac99dd483(p2) --[[ Line: 31 ]]
    -- upvalues: l__Classes__1 (copy), u1 (copy), l___xd5deee1778c08157__3 (copy)
    local v3 = p2 or l__Classes__1._x51bf23f1b9ed859b:_x5e63d412d07a8493(u1, script, "gun", "Castigate");
    local v4 = l___xd5deee1778c08157__3._x90d4581ac99dd483(v3.model, v3.offsets, v3.params);
    v4._x7b47345bff92786e = v3;
    setmetatable(v4, u1);
    return v4;
end;
return u1;
