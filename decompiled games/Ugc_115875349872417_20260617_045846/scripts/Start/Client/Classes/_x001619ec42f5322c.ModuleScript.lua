-- Decompiled from: Start.Client.Classes._x001619ec42f5322c
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

if not LPH_OBFUSCATED then
    function LPH_JIT_MAX(p1)
        return p1;
    end;
end;
local l__RunService__1 = game:GetService("RunService");
local u2 = {};
u2.__index = u2;
local l__Classes__2 = require(script.Parent.Parent.ClientRoot).Classes;
local l___x7749231778538ccb__3 = require(script.Parent.Parent._x7749231778538ccb);
function u2._x83ed94bfb82a8c9f() --[[ Line: 28 ]]
    -- upvalues: u2 (copy)
    local v3 = setmetatable({}, u2);
    v3._x1006d11c8c1c16b4 = {};
    v3._xcfa90845877ed73a = {};
    v3._xaf547586f5e40349 = {};
    v3._xec932354ef7d6d02 = {};
    return v3;
end;
function u2._x11bec02e46b4aa4f(p4, p5) --[[ Line: 40 ]]
    local v6 = table.find(p4._xcfa90845877ed73a, p5);
    if v6 then
        table.remove(p4._xcfa90845877ed73a, v6);
    end;
    p4._x1006d11c8c1c16b4[p5] = nil;
end;
function u2._x9329d49f87bd9806(p7, p8) --[[ Line: 48 ]]
    -- upvalues: l___x7749231778538ccb__3 (copy)
    local v9 = l___x7749231778538ccb__3._xd644d9e3ba63f27f("", p8);
    if v9._x22924a5c5b7265a0 then
        table.insert(p7._xcfa90845877ed73a, v9);
    else
        warn("ENTITY IS NOT A VALID INTERACTIVE ENTITY, MISSING INTERACTION DATA : ", v9._x2401f1dccc8d59b5);
    end;
end;
function u2._x44bcd6af41218f92(u10) --[[ Line: 58 ]]
    -- upvalues: l__RunService__1 (copy), l__Classes__2 (copy), l___x7749231778538ccb__3 (copy)
    l__RunService__1.Heartbeat:Connect(LPH_JIT_MAX(function() --[[ Line: 59 ]]
        -- upvalues: u10 (copy), l__Classes__2 (ref), l___x7749231778538ccb__3 (ref)
        local l___x1006d11c8c1c16b4__4 = u10._x1006d11c8c1c16b4;
        local l___xaf547586f5e40349__5 = u10._xaf547586f5e40349;
        local l___xec932354ef7d6d02__6 = u10._xec932354ef7d6d02;
        local v11 = l__Classes__2.Util:getDictionarySize(l___x1006d11c8c1c16b4__4) > 0;
        local v12 = (1 / 0);
        local v13 = nil;
        for _, v14 in u10._xcfa90845877ed73a do
            local v15 = l___x7749231778538ccb__3._xd644d9e3ba63f27f("", v14);
            if not (v15._x47c5564e0ebc7c70 and v11) then
                local v16, v17 = v15:_x78f77529732387bb();
                local l___x8cb7029b34876a56__7 = v15._x8cb7029b34876a56;
                if v16 == true then
                    if v17 < v12 then
                        v13 = v15;
                        v12 = v17;
                    end;
                elseif l___x8cb7029b34876a56__7 then
                    local l__identity__8 = l___x8cb7029b34876a56__7.identity;
                    if not l___xaf547586f5e40349__5[l__identity__8] and (not l___xec932354ef7d6d02__6[l__identity__8] and v15:_xc7b7bda776917e24()) then
                        l___xaf547586f5e40349__5[l__identity__8] = {
                            entity = v15,
                            cue_cancellation = v15:_xf03135bf52337eb1()
                        };
                    end;
                end;
            end;
        end;
        for v18, v19 in l___xaf547586f5e40349__5 do
            local v20 = l___x7749231778538ccb__3._xd644d9e3ba63f27f("", v19.entity);
            if not v20:_xc7b7bda776917e24() then
                v20:_x83d349acda1b2624();
                l___xaf547586f5e40349__5[v18] = nil;
            end;
        end;
        if v13 then
            l___x7749231778538ccb__3._xd644d9e3ba63f27f("", v13):_x35224e4a48526095();
        end;
    end));
    l__Classes__2._x8399b2bb73e12808:_x9ccd957f12430c82("onDeath"):Connect(function() --[[ Line: 113 ]]
        -- upvalues: u10 (copy), l___x7749231778538ccb__3 (ref)
        for _, v21 in u10._x1006d11c8c1c16b4 do
            local v22 = l___x7749231778538ccb__3._xd644d9e3ba63f27f("", v21);
            pcall(v22._x91f1a55d9b284c4f, v22);
        end;
        u10._x1006d11c8c1c16b4 = {};
    end);
end;
return u2;
