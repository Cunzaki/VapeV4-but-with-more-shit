-- Decompiled from: Start.Client.Classes._xd1706540247308ea
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__Packets__1 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Packets);
local l__Promise__2 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Promise);
require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Signal);
local l__Trove__3 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Trove);
local l__InternalSymbols__4 = require(script.Parent.Parent.InternalSymbols);
local u1 = {};
u1.__index = u1;
local l__Classes__5 = require(script.Parent.Parent.ClientRoot).Classes;
local u2 = nil;
function u1._x90d4581ac99dd483() --[[ Line: 17 ]]
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3._xcfefdf98297dd62e = {
        melee = nil,
        gun = nil,
        augment = nil
    };
    v3._xd40723a7437f8f9b = {};
    v3._x6d87aed2c44a568b = nil;
    v3._x9a2cccdf85bd7596 = {
        timestamp = 0,
        window = 0,
        direction_faced = Vector3.new(0, 0, 0),
        cam_location = Vector3.new(0, 0, 0)
    };
    return v3;
end;
local function u9(p4) --[[ Line: 36 ]]
    -- upvalues: l__Trove__3 (copy), l__Classes__5 (copy)
    local l__skin_def__6 = p4.skin_def;
    if l__skin_def__6 then
        l__skin_def__6 = l__skin_def__6.skinInitializer;
    end;
    if typeof(l__skin_def__6) ~= "function" then
        return nil;
    end;
    local v5 = l__Trove__3.new();
    local u6 = v5:Extend();
    v5:Connect(l__Classes__5._x7430d6d194f43373:_x685b03ceb3f7e330("onDeath"), function() --[[ Line: 46 ]]
        -- upvalues: u6 (copy)
        u6:Clean();
    end);
    local v7, v8 = pcall(l__skin_def__6, {
        equipped_trove = v5,
        life_trove = u6,
        asset = p4.model
    });
    if v7 then
        return v5;
    end;
    v5:Destroy();
    warn("SKIN INITIALIZER FAILED : ", p4.item_id, p4.skin_id, v8);
    return nil;
end;
local function u16(p10, p11, p12, p13) --[[ Line: 72 ]]
    -- upvalues: l__InternalSymbols__4 (copy)
    local v14 = l__InternalSymbols__4.owner("", p12);
    if p10._xcfefdf98297dd62e[p11] then
        local v15 = l__InternalSymbols__4.owner("", p10._xcfefdf98297dd62e[p11]);
        v15:_x5de5406ab187a367();
        v15:cleanUp();
    end;
    p10._xcfefdf98297dd62e[p11] = v14;
    p10._xd40723a7437f8f9b[p11] = p13;
    v14:_xe53615d96cf36a6b();
end;
function u1._xc7194a90fb0dcb84(p17, p18, p19, p20) --[[ Line: 86 ]]
    -- upvalues: l__Classes__5 (copy), l__InternalSymbols__4 (copy), u9 (copy), u16 (copy), l__Packets__1 (copy), u2 (ref)
    local v21 = l__Classes__5._xfe3e43ee4a76bab0:_xb533be8f3bc27052(p18, p19);
    if v21 then
        local v22 = l__InternalSymbols__4.owner("", require(v21));
        local v23 = l__Classes__5._x51bf23f1b9ed859b:_x5e63d412d07a8493(v22, v21, p18, p19, p20);
        local v24 = p17._xd40723a7437f8f9b[p18];
        if v24 then
            v24:Destroy();
            p17._xd40723a7437f8f9b[p18] = nil;
        end;
        local v25 = u9(v23);
        local v26 = v22._x90d4581ac99dd483(v23);
        v26._x850fb72bedc0eacc = p19;
        v26._x25bfa07653bc685f = v23.skin_id;
        v26._x7b47345bff92786e = v26._x7b47345bff92786e or v23;
        u16(p17, p18, v26, v25);
        if p18 == "melee" then
            p17:_xabcc58e6f4374b9e("melee");
        end;
        l__Packets__1._x990948d8235bab65:Fire(u2, p19);
    else
        warn("getItem FOR ITEM DOES NOT EXIST IN REGISTRY : " .. p18 .. " ID : " .. p19);
    end;
end;
function u1._xabcc58e6f4374b9e(p27, p28) --[[ Line: 110 ]]
    -- upvalues: l__InternalSymbols__4 (copy)
    local v29 = l__InternalSymbols__4.owner("", p27._xcfefdf98297dd62e[p27._x6d87aed2c44a568b]);
    if v29 then
        v29:_x5de5406ab187a367();
    end;
    local v30 = l__InternalSymbols__4.owner("", p27._xcfefdf98297dd62e[p28]);
    if v30 then
        v30:_xe4e131028b00eb5a();
        p27._x6d87aed2c44a568b = p28;
    end;
end;
function u1._x372c01be8a28bc70(u31, u32, u33) --[[ Line: 124 ]]
    -- upvalues: l__Promise__2 (copy)
    local v34 = u31._xcfefdf98297dd62e[u32];
    if v34 then
        return v34;
    elseif u33 and u33 > 0 then
        local u35 = os.clock();
        local v38, v39 = l__Promise__2.new(function(p36, p37) --[[ Line: 134 ]]
            -- upvalues: u35 (copy), u33 (copy), u31 (copy), u32 (copy)
            while os.clock() - u35 < u33 do
                if u31._xcfefdf98297dd62e[u32] then
                    p36(u31._xcfefdf98297dd62e[u32]);
                    return;
                end;
                task.wait(0.05);
            end;
            p37("timeout");
        end):await();
        if v38 then
            return v39;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function u1._xe53615d96cf36a6b(u40) --[[ Line: 154 ]]
    -- upvalues: u2 (ref), l__Packets__1 (copy), l__Classes__5 (copy)
    u2 = l__Packets__1._xbfaa5820a4100b86:Fire("LoadoutHandler");
    l__Packets__1._x62a9dc84762d3b26.OnClientEvent:Connect(function(...) --[[ Line: 157 ]]
        -- upvalues: u40 (copy), l__Classes__5 (ref)
        u40:_xc7194a90fb0dcb84(...);
        if l__Classes__5._xafc4950d7b094088 and l__Classes__5._x7430d6d194f43373._x3668b6edfe3dbbd4 == "alive" then
            l__Classes__5._xafc4950d7b094088:_x2d147abfc340ba12();
            l__Classes__5._xafc4950d7b094088:_xcb7fcd214aed2202();
            local v41 = l__Classes__5._xd1706540247308ea:_x372c01be8a28bc70("gun");
            if v41 and v41._xcd31646afa821cd4 then
                l__Classes__5._xafc4950d7b094088:_x19a8c13b7d43296b(v41._xcd31646afa821cd4);
            end;
        end;
    end);
end;
return u1;
