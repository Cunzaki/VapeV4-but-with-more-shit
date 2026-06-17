-- Decompiled from: Start.Client.Classes._x8613500a592ecb35
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__Packets__1 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Packets);
local l__Promise__2 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Promise);
require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Signal);
local l__Trove__3 = require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Trove);
local l___x7749231778538ccb__4 = require(script.Parent.Parent._x7749231778538ccb);
local u1 = {};
u1.__index = u1;
local l__Classes__5 = require(script.Parent.Parent.ClientRoot).Classes;
local u2 = nil;
function u1._x83ed94bfb82a8c9f() --[[ Line: 26 ]]
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3._xbd97a009261cb4a7 = {
        melee = nil,
        gun = nil,
        augment = nil
    };
    v3._x039db8dbfebc8c38 = {};
    v3._xbb004c18cb48ff88 = nil;
    v3._xee041878c4b8cec9 = {
        timestamp = 0,
        window = 0,
        direction_faced = Vector3.new(0, 0, 0),
        cam_location = Vector3.new(0, 0, 0)
    };
    return v3;
end;
local function u9(p4) --[[ Line: 45 ]]
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
    v5:Connect(l__Classes__5._x8399b2bb73e12808:_x9ccd957f12430c82("onDeath"), function() --[[ Line: 55 ]]
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
local function u16(p10, p11, p12, p13) --[[ Line: 81 ]]
    -- upvalues: l___x7749231778538ccb__4 (copy)
    local v14 = l___x7749231778538ccb__4._xd644d9e3ba63f27f("", p12);
    if p10._xbd97a009261cb4a7[p11] then
        local v15 = l___x7749231778538ccb__4._xd644d9e3ba63f27f("", p10._xbd97a009261cb4a7[p11]);
        v15:_x0199ad3eebf54ceb();
        v15:cleanUp();
    end;
    p10._xbd97a009261cb4a7[p11] = v14;
    p10._x039db8dbfebc8c38[p11] = p13;
    v14:_x44bcd6af41218f92();
end;
function u1._x60f7cfe778c89dde(p17, p18, p19, p20) --[[ Line: 95 ]]
    -- upvalues: l__Classes__5 (copy), l___x7749231778538ccb__4 (copy), u9 (copy), u16 (copy), l__Packets__1 (copy), u2 (ref)
    local v21 = l__Classes__5._xec256c494e1cbffa:_xf8b880f970bb89d8(p18, p19);
    if v21 then
        local v22 = l___x7749231778538ccb__4._xd644d9e3ba63f27f("", require(v21));
        local v23 = l__Classes__5._x21d532a942394db8:_x456600da66f7bf55(v22, v21, p18, p19, p20);
        local v24 = p17._x039db8dbfebc8c38[p18];
        if v24 then
            v24:Destroy();
            p17._x039db8dbfebc8c38[p18] = nil;
        end;
        local v25 = u9(v23);
        local v26 = v22._x83ed94bfb82a8c9f(v23);
        v26._x54a15972d659cdb0 = p19;
        v26._x0720680f2afad101 = v23.skin_id;
        v26._xcb0c9fdbaf1f513a = v26._xcb0c9fdbaf1f513a or v23;
        u16(p17, p18, v26, v25);
        if p18 == "melee" then
            p17:_x6581ac8b859aac7a("melee");
        end;
        l__Packets__1._x1d57a7bcf03e08b2:Fire(u2, p19);
    else
        warn("getItem FOR ITEM DOES NOT EXIST IN REGISTRY : " .. p18 .. " ID : " .. p19);
    end;
end;
function u1._x6581ac8b859aac7a(p27, p28) --[[ Line: 119 ]]
    -- upvalues: l___x7749231778538ccb__4 (copy)
    local v29 = l___x7749231778538ccb__4._xd644d9e3ba63f27f("", p27._xbd97a009261cb4a7[p27._xbb004c18cb48ff88]);
    if v29 then
        v29:_x0199ad3eebf54ceb();
    end;
    local v30 = l___x7749231778538ccb__4._xd644d9e3ba63f27f("", p27._xbd97a009261cb4a7[p28]);
    if v30 then
        v30:_x84eaa236b2e02493();
        p27._xbb004c18cb48ff88 = p28;
    else
        print("NO NEW ITEM", p28);
    end;
end;
function u1._x743a226b34a5008a(u31, u32, u33) --[[ Line: 135 ]]
    -- upvalues: l__Promise__2 (copy)
    local v34 = u31._xbd97a009261cb4a7[u32];
    if v34 then
        return v34;
    elseif u33 and u33 > 0 then
        local u35 = os.clock();
        local v38, v39 = l__Promise__2.new(function(p36, p37) --[[ Line: 145 ]]
            -- upvalues: u35 (copy), u33 (copy), u31 (copy), u32 (copy)
            while os.clock() - u35 < u33 do
                if u31._xbd97a009261cb4a7[u32] then
                    p36(u31._xbd97a009261cb4a7[u32]);
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
function u1._x44bcd6af41218f92(u40) --[[ Line: 165 ]]
    -- upvalues: u2 (ref), l__Packets__1 (copy), l__Classes__5 (copy)
    u2 = l__Packets__1._x8af24abb93051b81:Fire("LoadoutHandler");
    l__Packets__1._x0f49793f47f60a2c.OnClientEvent:Connect(function(...) --[[ Line: 168 ]]
        -- upvalues: u40 (copy), l__Classes__5 (ref)
        u40:_x60f7cfe778c89dde(...);
        if l__Classes__5._x6a15bbeeb97caae0 and l__Classes__5._x8399b2bb73e12808._x69155c6c2c2143d0 == "alive" then
            l__Classes__5._x6a15bbeeb97caae0:_xf98f587c3f464384();
            l__Classes__5._x6a15bbeeb97caae0:_x2c8149245b825cb9();
            local v41 = l__Classes__5._x8613500a592ecb35:_x743a226b34a5008a("gun");
            if v41 and v41._x6ae550825323339e then
                l__Classes__5._x6a15bbeeb97caae0:_xa2afd2b77542b209(v41._x6ae550825323339e);
            end;
        end;
    end);
end;
return u1;
