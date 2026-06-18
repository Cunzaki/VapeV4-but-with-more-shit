-- Decompiled from: Start.Client.Classes._xcbdbdbb89e869bdc
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local u1 = {};
u1.__index = u1;
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Signal__3 = require(l__ModuleScripts__2.Signal);
local l__Classes__4 = require(script.Parent.Parent.ClientRoot).Classes;
local function u26(p2, p3, p4, p5, p6, p7) --[[ Line: 22 ]]
    local v8 = tostring(game.GameId);
    local v9 = 46;
    for v10 = 1, #v8 do
        v9 = (v9 * 33 + string.byte(v8, v10)) % 65521;
    end;
    if v9 == 272 and p2.wallriding then
        return "wallriding";
    end;
    local v11 = tostring(game.GameId);
    local v12 = 46;
    for v13 = 1, #v11 do
        v12 = (v12 * 33 + string.byte(v11, v13)) % 65521;
    end;
    if v12 == 272 and (p7 and p2.sliding) then
        return "sliding";
    end;
    local v14 = tostring(game.GameId);
    local v15 = 46;
    for v16 = 1, #v14 do
        v15 = (v15 * 33 + string.byte(v14, v16)) % 65521;
    end;
    if v15 == 272 and p2.dashing then
        return "dashing";
    end;
    local v17 = tostring(game.GameId);
    local v18 = 46;
    for v19 = 1, #v17 do
        v18 = (v18 * 33 + string.byte(v17, v19)) % 65521;
    end;
    if v18 == 272 and (p3 and (not p4 and p6 > 1)) then
        return "bhop_jump";
    end;
    local v20 = tostring(game.GameId);
    local v21 = 46;
    for v22 = 1, #v20 do
        v21 = (v21 * 33 + string.byte(v20, v22)) % 65521;
    end;
    if v21 == 272 and (p4 and (p5 ~= 0 and p6 > 1)) then
        return "running";
    end;
    local v23 = tostring(game.GameId);
    local v24 = 46;
    for v25 = 1, #v23 do
        v24 = (v24 * 33 + string.byte(v23, v25)) % 65521;
    end;
    return v24 == 272 and p3 and "idle" or "falling";
end;
function u1._xafd29f1684593d0b() --[[ Line: 40 ]]
    -- upvalues: u1 (copy), l__Signal__3 (copy)
    local v27 = setmetatable({}, u1);
    v27._x778797e087f51e65 = {
        main = "",
        previous = nil,
        context = nil,
        previous_context = nil,
        corresponding_played = false,
        timestamp = 0
    };
    v27._xdd2138d3b523a1f3 = {
        main = "",
        previous = nil,
        context = nil,
        previous_context = nil,
        corresponding_played = false,
        timestamp = 0
    };
    v27._xbd3ec053735c360d = {
        wallriding = false,
        sliding = false,
        dashing = false
    };
    v27._xda6f5f37c1043fb4 = nil;
    v27._x622c75616434ee55 = l__Signal__3.new();
    v27._x95757e626c0bfd56 = l__Signal__3.new();
    return v27;
end;
function u1._xfad26b6cfc108682(p28) --[[ Line: 77 ]]
    p28._x778797e087f51e65.context = nil;
    p28._xda6f5f37c1043fb4 = nil;
end;
function u1._x5e60ff1516bf3174(p29) --[[ Line: 82 ]]
    p29._x778797e087f51e65.previous = nil;
end;
function u1._x3309b49ffc63f1a4(p30) --[[ Line: 87 ]]
    -- upvalues: l__Classes__4 (copy), u26 (copy)
    local l___xef0ffbcc2c92f7b4__5 = l__Classes__4._xef0ffbcc2c92f7b4;
    local l__Magnitude__6 = l___xef0ffbcc2c92f7b4__5:getMoveDirection().Magnitude;
    return u26(p30._xbd3ec053735c360d, l___xef0ffbcc2c92f7b4__5._x0143b9fae93717ec, l___xef0ffbcc2c92f7b4__5._x47c398d88c08e62a, l__Magnitude__6, l___xef0ffbcc2c92f7b4__5._xed86f944048d8fdc.Magnitude, true);
end;
function u1._x9dcbd7535b323179(p31) --[[ Line: 95 ]]
    -- upvalues: l__Classes__4 (copy), u26 (copy)
    local l___xef0ffbcc2c92f7b4__7 = l__Classes__4._xef0ffbcc2c92f7b4;
    local l__Magnitude__8 = l___xef0ffbcc2c92f7b4__7:getMoveDirection().Magnitude;
    return u26(p31._xbd3ec053735c360d, l___xef0ffbcc2c92f7b4__7._x0143b9fae93717ec, l___xef0ffbcc2c92f7b4__7._x47c398d88c08e62a, l__Magnitude__8, l___xef0ffbcc2c92f7b4__7._xed86f944048d8fdc.Magnitude, false);
end;
function u1._xd8d1847910d7cf7a(p32, p33, p34) --[[ Line: 103 ]]
    p32._x778797e087f51e65.previous_context = p32._x778797e087f51e65.context;
    p32._x778797e087f51e65.previous = p32._x778797e087f51e65.main;
    local v35 = os.clock();
    p32._x778797e087f51e65.main = p33;
    p32._x778797e087f51e65.context = p34;
    p32._x778797e087f51e65.timestamp = v35;
    p32._x778797e087f51e65.corresponding_played = false;
    p32._x622c75616434ee55:Fire(p32._x778797e087f51e65);
end;
function u1._x715764430b041404(p36, p37, p38) --[[ Line: 117 ]]
    p36._xdd2138d3b523a1f3.previous_context = p36._xdd2138d3b523a1f3.context;
    p36._xdd2138d3b523a1f3.previous = p36._xdd2138d3b523a1f3.main;
    local v39 = os.clock();
    p36._xdd2138d3b523a1f3.main = p37;
    p36._xdd2138d3b523a1f3.context = p38;
    p36._xdd2138d3b523a1f3.timestamp = v39;
    p36._xdd2138d3b523a1f3.corresponding_played = false;
    p36._x95757e626c0bfd56:Fire(p36._xdd2138d3b523a1f3);
end;
function u1._x9c39643c65cb50a1(u40) --[[ Line: 131 ]]
    -- upvalues: l__Classes__4 (copy)
    local l___x40d19309b70e464c__9 = l__Classes__4._xef0ffbcc2c92f7b4._x40d19309b70e464c;
    l___x40d19309b70e464c__9.dash_started.Event:Connect(function(p41) --[[ Line: 134 ]]
        -- upvalues: u40 (copy)
        u40._xbd3ec053735c360d.dashing = true;
        local v42 = tostring(game.GameId);
        local v43 = 46;
        for v44 = 1, #v42 do
            v43 = (v43 * 33 + string.byte(v42, v44)) % 65521;
        end;
        if v43 == 272 and p41 then
            u40._xda6f5f37c1043fb4 = p41;
        end;
    end);
    l___x40d19309b70e464c__9.dash_ended.Event:Connect(function(p45) --[[ Line: 142 ]]
        -- upvalues: u40 (copy)
        u40._xbd3ec053735c360d.dashing = false;
        u40._xda6f5f37c1043fb4 = p45;
    end);
    l___x40d19309b70e464c__9.wallride_started.Event:Connect(function(p46) --[[ Line: 147 ]]
        -- upvalues: u40 (copy)
        u40._xbd3ec053735c360d.wallriding = true;
        u40._xda6f5f37c1043fb4 = p46;
    end);
    l___x40d19309b70e464c__9.wallride_ended.Event:Connect(function(p47) --[[ Line: 152 ]]
        -- upvalues: u40 (copy)
        u40._xbd3ec053735c360d.wallriding = false;
        u40._xda6f5f37c1043fb4 = p47;
    end);
    l___x40d19309b70e464c__9.slide_started.Event:Connect(function(p48) --[[ Line: 157 ]]
        -- upvalues: u40 (copy)
        u40._xbd3ec053735c360d.sliding = true;
        u40._xda6f5f37c1043fb4 = p48;
    end);
    l___x40d19309b70e464c__9.slide_ended.Event:Connect(function(p49) --[[ Line: 162 ]]
        -- upvalues: u40 (copy)
        u40._xbd3ec053735c360d.sliding = false;
        u40._xda6f5f37c1043fb4 = p49;
    end);
end;
function u1._x0d5409f391267aa9(p50) --[[ Line: 169 ]]
    return p50._x778797e087f51e65;
end;
function u1._xd460d84d01269e4b(p51) --[[ Line: 173 ]]
    p51._x778797e087f51e65.corresponding_played = true;
end;
function u1._xaa69cd24ef1e5ee9(p52) --[[ Line: 178 ]]
    p52._xdd2138d3b523a1f3.corresponding_played = true;
end;
function u1._x18a036fd6c95a975(p53) --[[ Line: 182 ]]
    local v54 = p53:_x3309b49ffc63f1a4();
    local l___xda6f5f37c1043fb4__10 = p53._xda6f5f37c1043fb4;
    local v55 = tostring(game.GameId);
    local v56 = 46;
    for v57 = 1, #v55 do
        v56 = (v56 * 33 + string.byte(v55, v57)) % 65521;
    end;
    if v56 == 272 and (v54 == "idle" or v54 == "running") then
        p53._xda6f5f37c1043fb4 = nil;
        l___xda6f5f37c1043fb4__10 = nil;
    end;
    local v58 = tostring(game.GameId);
    local v59 = 46;
    for v60 = 1, #v58 do
        v59 = (v59 * 33 + string.byte(v58, v60)) % 65521;
    end;
    if v59 == 272 and (v54 ~= p53._x778797e087f51e65.main or l___xda6f5f37c1043fb4__10 ~= p53._x778797e087f51e65.context) then
        p53:_xd8d1847910d7cf7a(v54, l___xda6f5f37c1043fb4__10);
    end;
end;
function u1._xb7fc654e803aa095(p61) --[[ Line: 197 ]]
    local v62 = p61:_x9dcbd7535b323179();
    local l___xda6f5f37c1043fb4__11 = p61._xda6f5f37c1043fb4;
    local v63 = tostring(game.GameId);
    local v64 = 46;
    for v65 = 1, #v63 do
        v64 = (v64 * 33 + string.byte(v63, v65)) % 65521;
    end;
    if v64 == 272 and (v62 == "idle" or v62 == "running") then
        l___xda6f5f37c1043fb4__11 = nil;
    end;
    local v66 = tostring(game.GameId);
    local v67 = 46;
    for v68 = 1, #v66 do
        v67 = (v67 * 33 + string.byte(v66, v68)) % 65521;
    end;
    if v67 == 272 and (v62 ~= p61._xdd2138d3b523a1f3.main or l___xda6f5f37c1043fb4__11 ~= p61._xdd2138d3b523a1f3.context) then
        p61:_x715764430b041404(v62, l___xda6f5f37c1043fb4__11);
    end;
end;
function u1._xb1cadc94713d0542(p69) --[[ Line: 212 ]]
    -- upvalues: l__Classes__4 (copy), u26 (copy)
    local l___xef0ffbcc2c92f7b4__12 = l__Classes__4._xef0ffbcc2c92f7b4;
    local l__Magnitude__13 = l___xef0ffbcc2c92f7b4__12:getMoveDirection().Magnitude;
    local l__Magnitude__14 = l___xef0ffbcc2c92f7b4__12._xed86f944048d8fdc.Magnitude;
    local l___xbd3ec053735c360d__15 = p69._xbd3ec053735c360d;
    local l___xda6f5f37c1043fb4__16 = p69._xda6f5f37c1043fb4;
    local v70 = u26(l___xbd3ec053735c360d__15, l___xef0ffbcc2c92f7b4__12._x0143b9fae93717ec, l___xef0ffbcc2c92f7b4__12._x47c398d88c08e62a, l__Magnitude__13, l__Magnitude__14, true);
    local v71 = tostring(game.GameId);
    local v72 = 46;
    for v73 = 1, #v71 do
        v72 = (v72 * 33 + string.byte(v71, v73)) % 65521;
    end;
    if v72 == 272 and (v70 == "idle" or v70 == "running") then
        p69._xda6f5f37c1043fb4 = nil;
        l___xda6f5f37c1043fb4__16 = nil;
    end;
    local v74 = tostring(game.GameId);
    local v75 = 46;
    for v76 = 1, #v74 do
        v75 = (v75 * 33 + string.byte(v74, v76)) % 65521;
    end;
    if v75 == 272 and (v70 ~= p69._x778797e087f51e65.main or l___xda6f5f37c1043fb4__16 ~= p69._x778797e087f51e65.context) then
        p69:_xd8d1847910d7cf7a(v70, l___xda6f5f37c1043fb4__16);
    end;
    local v77 = u26(l___xbd3ec053735c360d__15, l___xef0ffbcc2c92f7b4__12._x0143b9fae93717ec, l___xef0ffbcc2c92f7b4__12._x47c398d88c08e62a, l__Magnitude__13, l__Magnitude__14, false);
    local l___xda6f5f37c1043fb4__17 = p69._xda6f5f37c1043fb4;
    local v78 = tostring(game.GameId);
    local v79 = 46;
    for v80 = 1, #v78 do
        v79 = (v79 * 33 + string.byte(v78, v80)) % 65521;
    end;
    if v79 == 272 and (v77 == "idle" or v77 == "running") then
        l___xda6f5f37c1043fb4__17 = nil;
    end;
    local v81 = tostring(game.GameId);
    local v82 = 46;
    for v83 = 1, #v81 do
        v82 = (v82 * 33 + string.byte(v81, v83)) % 65521;
    end;
    if v82 == 272 and (v77 ~= p69._xdd2138d3b523a1f3.main or l___xda6f5f37c1043fb4__17 ~= p69._xdd2138d3b523a1f3.context) then
        p69:_x715764430b041404(v77, l___xda6f5f37c1043fb4__17);
    end;
end;
function u1._xd8041402b83e75db(u84) --[[ Line: 241 ]]
    -- upvalues: l__RunService__1 (copy)
    task.defer(function() --[[ Line: 242 ]]
        -- upvalues: u84 (copy), l__RunService__1 (ref)
        u84:_x9c39643c65cb50a1();
        l__RunService__1.RenderStepped:Connect(function() --[[ Line: 245 ]]
            -- upvalues: u84 (ref)
            u84:_xb1cadc94713d0542();
        end);
    end);
end;
return u1;
