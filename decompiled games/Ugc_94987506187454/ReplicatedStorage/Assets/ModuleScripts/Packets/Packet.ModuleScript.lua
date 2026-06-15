-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Packets.Packet
-- Class: ModuleScript
-- Place: Ugc (94987506187454)

-- Decompiled with Potassium's decompiler.

local l__Signal__1 = require(script.Signal);
local l__Task__2 = require(script.Task);
local l__Types__3 = require(script.Types);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local l__RunService__4 = game:GetService("RunService");
local l__Players__5 = game:GetService("Players");
local l__Reads__6 = l__Types__3.Reads;
local l__Writes__7 = l__Types__3.Writes;
local l__Import__8 = l__Types__3.Import;
local l__Export__9 = l__Types__3.Export;
local l__Truncate__10 = l__Types__3.Truncate;
local l__Ended__11 = l__Types__3.Ended;
local l__NumberU8__12 = l__Reads__6.NumberU8;
local l__NumberU8__13 = l__Writes__7.NumberU8;
local l__NumberU16__14 = l__Reads__6.NumberU16;
local l__NumberU16__15 = l__Writes__7.NumberU16;
local u6 = {};
local u7 = {};
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = {};
local u13 = {};
local u14 = {};
local u15 = {};
local u16 = false;
local u17 = {};
local u18 = {};
local u19 = nil;
local u20 = nil;
local u21 = {
    BufferLength = 128,
    BufferOffset = 0,
    InstancesOffset = 0,
    Buffer = buffer.create(128),
    Instances = {}
};
local function v27(_, p22, ...) --[[ Line: 91 ]]
    -- upvalues: u7 (copy), u6 (copy), l__RunService__4 (copy), u11 (ref), l__Signal__1 (copy), u12 (copy), u14 (copy), u20 (ref), u1 (ref)
    local v23 = u7[p22];
    if v23 then
        return v23;
    end;
    local v24 = setmetatable({}, u6);
    v24.Name = p22;
    if l__RunService__4:IsServer() then
        v24.Id = u11;
        v24.OnServerEvent = l__Signal__1();
        u12[p22] = u11;
        u14[p22] = u11;
        u7[u11] = v24;
        u11 = u11 + 1;
    else
        v24.Id = u12[p22];
        v24.OnClientEvent = l__Signal__1();
        if v24.Id then
            u7[v24.Id] = v24;
        end;
        if u20 then
            task.defer(u20);
        end;
    end;
    local v25, v26 = u1(table.pack(...));
    v24.Reads = v25;
    v24.Writes = v26;
    u7[v24.Name] = v24;
    return v24;
end;
u6.__index = u6;
u6.Type = "Packet";
function u6.Response(p28, ...) --[[ Line: 121 ]]
    -- upvalues: u1 (ref)
    p28.ResponseTimeout = p28.ResponseTimeout or 10;
    local v29, v30 = u1(table.pack(...));
    p28.ResponseReads = v29;
    p28.ResponseWrites = v30;
    return p28;
end;
function u6.Fire(p31, ...) --[[ Line: 127 ]]
    -- upvalues: l__RunService__4 (copy), u15 (copy), l__Import__8 (copy), u21 (ref), l__NumberU8__13 (copy), u10 (ref), l__Task__2 (copy), u5 (ref), u4 (ref), l__Export__9 (copy)
    if not p31.Id then
        if l__RunService__4:IsServer() then
            warn("Packet ID missing on server!");
            return;
        end;
        if not u15[p31.Name] then
            u15[p31.Name] = {};
        end;
        table.insert(u15[p31.Name], coroutine.running());
        coroutine.yield();
    end;
    l__Import__8(u21);
    l__NumberU8__13(p31.Id);
    if p31.ResponseReads then
        l__NumberU8__13(u10.Index);
        u10[u10.Index] = {
            Yielded = coroutine.running(),
            Timeout = l__Task__2:Delay(p31.ResponseTimeout, u5, coroutine.running(), p31.ResponseTimeoutValue)
        };
        u10.Index = (u10.Index + 1) % 128;
        u4(p31.Writes, { ... });
        u21 = l__Export__9();
        return coroutine.yield();
    end;
    u4(p31.Writes, { ... });
    u21 = l__Export__9();
end;
function u6.FireClient(p32, p33, ...) --[[ Line: 153 ]]
    -- upvalues: l__Import__8 (copy), u8 (ref), l__NumberU8__13 (copy), u9 (ref), l__Task__2 (copy), u5 (ref), u4 (ref), l__Export__9 (copy)
    if p33 and p33.Parent ~= nil then
        if p32.Id then
            l__Import__8(u8[p33] or {
                BufferLength = 128,
                BufferOffset = 0,
                InstancesOffset = 0,
                Buffer = buffer.create(128),
                Instances = {}
            });
            l__NumberU8__13(p32.Id);
            if p32.ResponseReads then
                local v34 = u9[p33];
                if v34 == nil then
                    v34 = {
                        Index = 0
                    };
                    u9[p33] = v34;
                end;
                l__NumberU8__13(v34.Index);
                v34[v34.Index] = {
                    Yielded = coroutine.running(),
                    Timeout = l__Task__2:Delay(p32.ResponseTimeout, u5, coroutine.running(), p32.ResponseTimeoutValue)
                };
                v34.Index = (v34.Index + 1) % 128;
                u4(p32.Writes, { ... });
                u8[p33] = l__Export__9();
                return coroutine.yield();
            end;
            u4(p32.Writes, { ... });
            u8[p33] = l__Export__9();
        else
            warn("Packet ID missing on server!");
        end;
    end;
end;
function u6.Serialize(p35, ...) --[[ Line: 173 ]]
    -- upvalues: l__Import__8 (copy), u4 (ref), l__Truncate__10 (copy)
    l__Import__8({
        BufferLength = 128,
        BufferOffset = 0,
        InstancesOffset = 0,
        Buffer = buffer.create(128),
        Instances = {}
    });
    u4(p35.Writes, { ... });
    return l__Truncate__10();
end;
function u6.Deserialize(p36, p37, p38) --[[ Line: 179 ]]
    -- upvalues: l__Import__8 (copy), u3 (ref)
    l__Import__8({
        BufferOffset = 0,
        InstancesOffset = 0,
        Buffer = p37,
        BufferLength = buffer.len(p37),
        Instances = p38 or {}
    });
    return u3(p36.Reads);
end;
u1 = function(p39) --[[ Name: ParametersToFunctions, Line 186 ]]
    -- upvalues: u2 (ref), l__Reads__6 (copy), l__Writes__7 (copy)
    local v40 = table.create(#p39);
    local v41 = table.create(#p39);
    for v42, v43 in ipairs(p39) do
        if type(v43) == "table" then
            local v44, v45 = u2(v43);
            v40[v42] = v44;
            v41[v42] = v45;
        else
            local v46 = l__Reads__6[v43];
            local v47 = l__Writes__7[v43];
            v40[v42] = v46;
            v41[v42] = v47;
        end;
    end;
    return v40, v41;
end;
u2 = function(p48) --[[ Name: TableToFunctions, Line 198 ]]
    -- upvalues: u2 (ref), l__Reads__6 (copy), l__Writes__7 (copy), l__NumberU16__14 (copy), l__NumberU16__15 (copy)
    if #p48 == 1 then
        local v49 = p48[1];
        local u50, u51;
        if type(v49) == "table" then
            u50, u51 = u2(v49);
        else
            u50 = l__Reads__6[v49];
            u51 = l__Writes__7[v49];
        end;
        return function() --[[ Line: 207 ]]
            -- upvalues: l__NumberU16__14 (ref), u50 (ref)
            local v52 = l__NumberU16__14();
            local v53 = table.create(v52);
            for v54 = 1, v52 do
                v53[v54] = u50();
            end;
            return v53;
        end, function(p55) --[[ Line: 213 ]]
            -- upvalues: l__NumberU16__15 (ref), u51 (ref)
            l__NumberU16__15(#p55);
            for _, v56 in p55 do
                u51(v56);
            end;
        end;
    end;
    local u57 = {};
    for v58, _ in p48 do
        table.insert(u57, v58);
    end;
    table.sort(u57);
    local u59 = table.create(#u57);
    local u60 = table.create(#u57);
    for v61, v62 in u57 do
        local v63 = p48[v62];
        if type(v63) == "table" then
            local v64, v65 = u2(v63);
            u59[v61] = v64;
            u60[v61] = v65;
        else
            local v66 = l__Reads__6[v63];
            local v67 = l__Writes__7[v63];
            u59[v61] = v66;
            u60[v61] = v67;
        end;
    end;
    return function() --[[ Line: 229 ]]
        -- upvalues: u59 (copy), u57 (copy)
        local v68 = {};
        for v69, v70 in u59 do
            v68[u57[v69]] = v70();
        end;
        return v68;
    end, function(p71) --[[ Line: 234 ]]
        -- upvalues: u60 (copy), u57 (copy)
        for v72, v73 in u60 do
            v73(p71[u57[v72]]);
        end;
    end;
end;
u3 = function(p74) --[[ Name: ReadParameters, Line 241 ]]
    local v75 = table.create(#p74);
    for v76, v77 in p74 do
        v75[v76] = v77();
    end;
    return table.unpack(v75);
end;
u4 = function(p78, p79) --[[ Name: WriteParameters, Line 247 ]]
    for v80, v81 in p78 do
        v81(p79[v80]);
    end;
end;
u5 = function(p82, p83) --[[ Name: Timeout, Line 251 ]]
    task.defer(p82, p83);
end;
local function u92(p84, p85, p86, p87, p88, p89) --[[ Line: 255 ]]
    -- upvalues: l__RunService__4 (copy), u19 (ref)
    if not l__RunService__4:IsServer() or u19 == nil then
        return true;
    end;
    local v90, v91 = pcall(u19, {
        Player = p84,
        Packet = p85,
        Name = p85.Name,
        Id = p85.Id,
        Direction = p86,
        Reliable = p87,
        Arguments = p88,
        ThreadIndex = p89
    });
    if v90 then
        return v91 == true;
    end;
    warn("Packet server predicate failed:", v91);
    return true;
end;
function l__Types__3.Types.CheckServerPredicate(p93, p94, p95, p96, p97, p98) --[[ Line: 289 ]]
    -- upvalues: u92 (ref)
    return u92(p93, p94, p95, p96, p97, p98);
end;
if l__RunService__4:IsServer() then
    local l__PacketPredicate__16 = game:GetService("ServerStorage").Assets.Libraries.PacketPredicate;
    local v99, v100 = pcall(require, l__PacketPredicate__16);
    if v99 and type(v100) == "function" then
        u19 = v100;
    elseif l__RunService__4:IsStudio() then
        warn("PacketPredicate must return a function:", v100);
    end;
    u8 = {};
    u9 = {};
    u11 = 1;
    local u101 = Instance.new("RemoteEvent", script);
    u101.Name = "PacketEvent";
    local v102 = Instance.new("RemoteFunction", script);
    v102.Name = "PacketHandshake";
    function v102.OnServerInvoke() --[[ Line: 319 ]]
        -- upvalues: u12 (copy)
        return u12;
    end;
    local u103 = {};
    local u104 = {};
    local u111 = task.spawn(function() --[[ Line: 326 ]]
        -- upvalues: u14 (copy), u21 (ref), u101 (ref), u8 (ref), u103 (copy)
        while true do
            coroutine.yield();
            local v105 = next(u14) ~= nil;
            local v106 = v105 and u14 or nil;
            if u21.BufferOffset > 0 or v105 then
                local v107;
                if u21.BufferOffset > 0 then
                    v107 = buffer.create(u21.BufferOffset);
                    buffer.copy(v107, 0, u21.Buffer, 0, u21.BufferOffset);
                else
                    v107 = nil;
                end;
                if u21.InstancesOffset == 0 then
                    u101:FireAllClients(v106, v107);
                else
                    u101:FireAllClients(v106, v107, u21.Instances);
                    u21.InstancesOffset = 0;
                    table.clear(u21.Instances);
                end;
                if u21.BufferOffset > 0 then
                    u21.BufferOffset = 0;
                end;
            end;
            for v108, v109 in u8 do
                local v110 = buffer.create(v109.BufferOffset);
                buffer.copy(v110, 0, v109.Buffer, 0, v109.BufferOffset);
                if v109.InstancesOffset == 0 then
                    u101:FireClient(v108, v106, v110);
                else
                    u101:FireClient(v108, v106, v110, v109.Instances);
                end;
            end;
            table.clear(u8);
            table.clear(u103);
            if v105 then
                table.clear(u14);
            end;
        end;
    end);
    local function u116(p112, p113, p114, ...) --[[ Line: 368 ]]
        -- upvalues: l__RunService__4 (copy), l__Import__8 (copy), u8 (ref), l__NumberU8__13 (copy), u4 (ref), l__Export__9 (copy)
        if p112.OnServerInvoke == nil then
            if l__RunService__4:IsStudio() then
                warn("OnServerInvoke not found for packet:", p112.Name, "discarding event:", ...);
            end;
        else
            local v115 = { p112.OnServerInvoke(p113, ...) };
            if p113.Parent == nil then
            else
                l__Import__8(u8[p113] or {
                    BufferLength = 128,
                    BufferOffset = 0,
                    InstancesOffset = 0,
                    Buffer = buffer.create(128),
                    Instances = {}
                });
                l__NumberU8__13(p112.Id);
                l__NumberU8__13(p114 + 128);
                u4(p112.ResponseWrites, v115);
                u8[p113] = l__Export__9();
            end;
        end;
    end;
    local function u132(p117, p118, p119) --[[ Line: 379 ]]
        -- upvalues: u103 (copy), l__RunService__4 (copy), l__Import__8 (copy), l__Ended__11 (copy), l__NumberU8__12 (copy), u7 (copy), u104 (copy), u3 (ref), u92 (ref), l__Task__2 (copy), u116 (copy), u9 (ref)
        local v120 = u103[p117] or 0;
        local v121 = buffer.len(p118);
        local v122 = v120 + math.max(v121, 800);
        if v122 > 8000 then
            if l__RunService__4:IsStudio() then
                warn(p117.Name, "is exceeding the data/rate limit; some events may be dropped");
            end;
        else
            u103[p117] = v122;
            l__Import__8({
                BufferOffset = 0,
                InstancesOffset = 0,
                Buffer = p118,
                BufferLength = buffer.len(p118),
                Instances = p119 or {}
            });
            while l__Ended__11() == false do
                local v123 = l__NumberU8__12();
                local v124 = u7[v123];
                if not v124 then
                    if l__RunService__4:IsStudio() and not u104[v123] then
                        u104[v123] = true;
                        warn("Packet ID not found on server:", v123, "from", p117.Name);
                    end;
                    return;
                end;
                if v124.ResponseReads then
                    local v125 = l__NumberU8__12();
                    if v125 < 128 then
                        local v126 = table.pack(u3(v124.Reads));
                        if u92(p117, v124, "Invoke", true, v126, v125) then
                            l__Task__2:Defer(u116, v124, p117, v125, table.unpack(v126, 1, v126.n));
                        end;
                    else
                        local v127 = v125 - 128;
                        local v128 = table.pack(u3(v124.ResponseReads));
                        local v129 = u9[p117];
                        local v130;
                        if v129 then
                            v130 = v129[v127];
                        else
                            v130 = v129;
                        end;
                        if v130 then
                            if u92(p117, v124, "Response", true, v128, v127) then
                                task.cancel(v130.Timeout);
                                task.defer(v130.Yielded, table.unpack(v128, 1, v128.n));
                                v129[v127] = nil;
                            end;
                        elseif l__RunService__4:IsStudio() then
                            warn("Response thread not found for packet:", v124.Name, "discarding response:", table.unpack(v128, 1, v128.n));
                        end;
                    end;
                else
                    local v131 = table.pack(u3(v124.Reads));
                    if u92(p117, v124, "Event", true, v131) then
                        v124.OnServerEvent:Fire(p117, table.unpack(v131, 1, v131.n));
                    end;
                end;
            end;
        end;
    end;
    u101.OnServerEvent:Connect(function(p133, ...) --[[ Line: 426 ]]
        -- upvalues: u132 (copy), l__RunService__4 (copy)
        local _, v134 = pcall(u132, p133, ...);
        if v134 and l__RunService__4:IsStudio() then
            warn(p133.Name, v134);
        end;
    end);
    l__Players__5.PlayerRemoving:Connect(function(p135) --[[ Line: 431 ]]
        -- upvalues: u8 (ref), u9 (ref), u103 (copy)
        u8[p135] = nil;
        u9[p135] = nil;
        u103[p135] = nil;
    end);
    l__RunService__4.Heartbeat:Connect(function(_) --[[ Line: 437 ]]
        -- upvalues: u111 (copy)
        task.defer(u111);
    end);
else
    u10 = {
        Index = 0
    };
    local l__PacketEvent__17 = script:WaitForChild("PacketEvent");
    local l__PacketHandshake__18 = script:WaitForChild("PacketHandshake");
    local u136 = 0;
    local u137 = false;
    local function u142(p138, p139) --[[ Line: 455 ]]
        -- upvalues: u12 (copy), u13 (copy), u7 (copy), u15 (copy), u20 (ref)
        u12[p138] = p139;
        u13[p139] = p138;
        local v140 = u7[p138];
        if v140 then
            if v140.Id then
                u7[v140.Id] = nil;
            end;
            v140.Id = p139;
            u7[p139] = v140;
        end;
        if u15[p138] then
            for _, v141 in ipairs(u15[p138]) do
                task.spawn(v141);
            end;
            u15[p138] = nil;
        end;
        if u20 then
            task.defer(u20);
        end;
    end;
    local function u147() --[[ Line: 475 ]]
        -- upvalues: u137 (ref), l__PacketHandshake__18 (ref), u142 (copy), l__RunService__4 (copy), u20 (ref)
        if u137 then
        else
            u137 = true;
            task.defer(function() --[[ Line: 481 ]]
                -- upvalues: l__PacketHandshake__18 (ref), u142 (ref), l__RunService__4 (ref), u137 (ref), u20 (ref)
                local v143, v144 = pcall(function() --[[ Line: 482 ]]
                    -- upvalues: l__PacketHandshake__18 (ref)
                    return l__PacketHandshake__18:InvokeServer();
                end);
                if v143 and v144 then
                    for v145, v146 in pairs(v144) do
                        u142(v145, v146);
                    end;
                elseif l__RunService__4:IsStudio() then
                    warn("Failed to refresh packet manifest from server");
                end;
                u137 = false;
                if u20 then
                    task.defer(u20);
                end;
            end);
        end;
    end;
    local u149 = task.spawn(function() --[[ Line: 501 ]]
        -- upvalues: u21 (ref), l__PacketEvent__17 (ref)
        while true do
            repeat
                coroutine.yield();
            until u21.BufferOffset > 0;
            local v148 = buffer.create(u21.BufferOffset);
            buffer.copy(v148, 0, u21.Buffer, 0, u21.BufferOffset);
            if u21.InstancesOffset == 0 then
                l__PacketEvent__17:FireServer(v148);
            else
                l__PacketEvent__17:FireServer(v148, u21.Instances);
                u21.InstancesOffset = 0;
                table.clear(u21.Instances);
            end;
            u21.BufferOffset = 0;
        end;
    end);
    local function u153(p150, p151, ...) --[[ Line: 519 ]]
        -- upvalues: l__Import__8 (copy), u21 (ref), l__NumberU8__13 (copy), u4 (ref), l__Export__9 (copy)
        if p150.OnClientInvoke == nil then
            warn("OnClientInvoke not found for packet:", p150.Name, "discarding event:", ...);
        else
            local v152 = { p150.OnClientInvoke(...) };
            l__Import__8(u21);
            l__NumberU8__13(p150.Id);
            l__NumberU8__13(p151 + 128);
            u4(p150.ResponseWrites, v152);
            u21 = l__Export__9();
        end;
    end;
    local function u179(p154, p155, p156, p157) --[[ Line: 529 ]]
        -- upvalues: u142 (copy), l__Import__8 (copy), l__Ended__11 (copy), l__NumberU8__12 (copy), u7 (copy), u13 (copy), u147 (ref), l__Task__2 (copy), u153 (copy), u3 (ref), u10 (ref)
        if p154 then
            for v158, v159 in pairs(p154) do
                u142(v158, v159);
            end;
        end;
        if not p155 then
            return true;
        end;
        l__Import__8({
            BufferOffset = 0,
            InstancesOffset = 0,
            Buffer = p155,
            BufferLength = buffer.len(p155),
            Instances = p156 or {}
        });
        local v160 = false;
        while l__Ended__11() == false do
            local v161 = l__NumberU8__12();
            local v162 = u7[v161];
            if not v162 then
                if u13[v161] == nil and u147 then
                    u147();
                end;
                if p157 and not v160 then
                    return nil, v161;
                end;
                local v163 = u13[v161];
                local v164;
                if v163 then
                    v164 = u7[v163] or nil;
                else
                    v164 = nil;
                end;
                local v165 = u7[v161];
                local v166 = warn;
                local v167 = "Packet ID not found:";
                local v168 = v163 or "<unknown packet name>";
                local v169 = "packetByNameExists=";
                local v170 = v164 ~= nil;
                local v171 = "packetByIdExists=";
                local v172 = v165 ~= nil;
                local v173 = "onClientEventExists=";
                local v174;
                if v164 == nil then
                    v174 = false;
                else
                    v174 = v164.OnClientEvent ~= nil;
                end;
                v166(v167, v161, v168, v169, v170, v171, v172, v173, v174);
                return false, v161;
            end;
            if v162.ResponseReads then
                local v175 = l__NumberU8__12();
                if v175 < 128 then
                    l__Task__2:Defer(u153, v162, v175, u3(v162.Reads));
                    v160 = true;
                else
                    local v176 = v175 - 128;
                    local v177 = u10[v176];
                    if v177 then
                        task.cancel(v177.Timeout);
                        local v178 = { u3(v162.ResponseReads) };
                        if coroutine.status(v177.Yielded) == "suspended" then
                            task.defer(v177.Yielded, table.unpack(v178));
                        end;
                        u10[v176] = nil;
                        v160 = true;
                    else
                        warn("Response thread not found for packet:", v162.Name, "discarding response:", u3(v162.ResponseReads));
                        v160 = true;
                    end;
                end;
            else
                v162.OnClientEvent:Fire(u3(v162.Reads));
                v160 = true;
            end;
        end;
        return true;
    end;
    u20 = function() --[[ Name: flushPendingClientPayloads, Line 580 ]]
        -- upvalues: u18 (ref), u179 (ref), u13 (copy), u7 (copy)
        if #u18 == 0 then
        else
            local v180 = {};
            for _, v181 in ipairs(u18) do
                v181.Attempts = v181.Attempts + 1;
                local v182, v183 = u179(nil, v181.Buffer, v181.Instances, true);
                if v182 == nil then
                    if v181.Attempts < 100 then
                        table.insert(v180, v181);
                    else
                        local v184 = v183 or v181.PacketId;
                        local v185 = u13[v184];
                        local v186;
                        if v185 then
                            v186 = u7[v185] or nil;
                        else
                            v186 = nil;
                        end;
                        local v187 = u7[v184];
                        local v188 = warn;
                        local v189 = "Packet ID not found:";
                        local v190 = v185 or "<unknown packet name>";
                        local v191 = "packetByNameExists=";
                        local v192 = v186 ~= nil;
                        local v193 = "packetByIdExists=";
                        local v194 = v187 ~= nil;
                        local v195 = "onClientEventExists=";
                        local v196;
                        if v186 == nil then
                            v196 = false;
                        else
                            v196 = v186.OnClientEvent ~= nil;
                        end;
                        v188(v189, v184, v190, v191, v192, v193, v194, v195, v196);
                    end;
                end;
            end;
            u18 = v180;
        end;
    end;
    l__PacketEvent__17.OnClientEvent:Connect(function(p197, p198, p199) --[[ Line: 600 ]]
        -- upvalues: u16 (ref), u17 (ref), u179 (ref), u18 (ref)
        if u16 then
            local v200, v201 = u179(p197, p198, p199, true);
            if v200 == nil and p198 then
                table.insert(u18, {
                    Attempts = 0,
                    Buffer = p198,
                    Instances = p199,
                    PacketId = v201
                });
            end;
        else
            table.insert(u17, { p197, p198, p199 });
        end;
    end);
    task.defer(function() --[[ Line: 611 ]]
        -- upvalues: l__PacketHandshake__18 (ref), u142 (copy), u16 (ref), u17 (ref), u179 (ref), u18 (ref)
        local v202 = l__PacketHandshake__18:InvokeServer();
        for v203, v204 in pairs(v202) do
            u142(v203, v204);
        end;
        u16 = true;
        for _, v205 in ipairs(u17) do
            local v206, v207 = u179(v205[1], v205[2], v205[3], true);
            if v206 == nil and v205[2] then
                table.insert(u18, {
                    Attempts = 0,
                    Buffer = v205[2],
                    Instances = v205[3],
                    PacketId = v207
                });
            end;
        end;
        u17 = {};
    end);
    l__RunService__4.Heartbeat:Connect(function(p208) --[[ Line: 626 ]]
        -- upvalues: u136 (ref), u149 (copy), u20 (ref)
        u136 = u136 + p208;
        if u136 > 0.016666666666666666 then
            u136 = u136 % 0.016666666666666666;
            task.defer(u149);
            task.defer(u20);
        end;
    end);
end;
return setmetatable(l__Types__3.Types, {
    __call = v27
});
