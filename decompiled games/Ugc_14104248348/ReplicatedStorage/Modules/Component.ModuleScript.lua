-- Decompiled from: ReplicatedStorage.Modules.Component
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__RunService__2 = game:GetService("RunService");
local l__Signal__3 = require(script.Parent.Signal);
local l__Symbol__4 = require(script.Symbol);
local l__Trove__5 = require(script.Trove);
local l__Promise__6 = require(script.Parent.Promise);
local u1 = l__RunService__2:IsServer();
local u2 = { workspace, game:GetService("Players") };
local u3 = l__Symbol__4("Ancestors");
local u4 = l__Symbol__4("InstancesToComponents");
local u5 = l__Symbol__4("LockConstruct");
local u6 = l__Symbol__4("Components");
local u7 = l__Symbol__4("Trove");
local u8 = l__Symbol__4("Extensions");
local u9 = l__Symbol__4("ActiveExtensions");
local u10 = l__Symbol__4("Started");
local u11 = 0;
local function u16(p12, p13) --[[ Line: 197 ]]
    -- upvalues: u9 (copy)
    for _, v14 in ipairs(p12[u9]) do
        local v15 = v14[p13];
        if type(v15) == "function" then
            v15(p12);
        end;
    end;
end;
local function u19(p17) --[[ Line: 206 ]]
    -- upvalues: u9 (copy)
    for _, v18 in ipairs(p17[u9]) do
        local l__ShouldConstruct__7 = v18.ShouldConstruct;
        if type(l__ShouldConstruct__7) == "function" and not l__ShouldConstruct__7(p17) then
            return false;
        end;
    end;
    return true;
end;
local function u25(p20, p21) --[[ Line: 219 ]]
    local v22 = table.create(#p21);
    local v23 = true;
    for _, v24 in ipairs(p21) do
        local l__ShouldExtend__8 = v24.ShouldExtend;
        if type(l__ShouldExtend__8) ~= "function" and true or (l__ShouldExtend__8(p20) and true or false) then
            table.insert(v22, v24);
        else
            v23 = false;
        end;
    end;
    if v23 then
        return p21;
    else
        return v22;
    end;
end;
local u26 = {};
u26.__index = u26;
function u26.new(u27) --[[ Line: 298 ]]
    -- upvalues: u3 (copy), u2 (copy), u4 (copy), u6 (copy), u5 (copy), u7 (copy), l__Trove__5 (copy), u8 (copy), u10 (copy), l__Signal__3 (copy), u26 (copy)
    local v28 = {};
    v28.__index = v28;
    function v28.__tostring() --[[ Line: 301 ]]
        -- upvalues: u27 (copy)
        return "Component<" .. u27.Tag .. ">";
    end;
    v28[u3] = u27.Ancestors or u2;
    v28[u4] = {};
    v28[u6] = {};
    v28[u5] = {};
    v28[u7] = l__Trove__5.new();
    v28[u8] = u27.Extensions or {};
    v28[u10] = false;
    v28.Tag = u27.Tag;
    v28.Started = v28[u7]:Construct(l__Signal__3);
    v28.Stopped = v28[u7]:Construct(l__Signal__3);
    setmetatable(v28, u26);
    v28:_setup();
    return v28;
end;
function u26._instantiate(p29, p30) --[[ Line: 319 ]]
    -- upvalues: u9 (copy), u25 (copy), u8 (copy), u19 (copy), u16 (copy)
    local v31 = setmetatable({}, p29);
    v31.Instance = p30;
    v31[u9] = u25(v31, p29[u8]);
    if not u19(v31) then
        return nil;
    end;
    u16(v31, "Constructing");
    if type(v31.Construct) == "function" then
        v31:Construct();
    end;
    u16(v31, "Constructed");
    return v31;
end;
function u26._setup(u32) --[[ Line: 334 ]]
    -- upvalues: u16 (copy), l__RunService__2 (copy), u1 (copy), u11 (ref), u10 (copy), u5 (copy), u4 (copy), u6 (copy), u3 (copy), u7 (copy), l__CollectionService__1 (copy)
    local u33 = {};
    local function u42(u34) --[[ Line: 337 ]]
        -- upvalues: u16 (ref), l__RunService__2 (ref), u1 (ref), u11 (ref), u10 (ref), u32 (copy)
        u16(u34, "Starting");
        u34:Start();
        u16(u34, "Started");
        local v35 = typeof(u34.HeartbeatUpdate) == "function";
        local v36 = typeof(u34.SteppedUpdate) == "function";
        local v37 = typeof(u34.RenderSteppedUpdate) == "function";
        if v35 then
            u34._heartbeatUpdate = l__RunService__2.Heartbeat:Connect(function(p38) --[[ Line: 345 ]]
                -- upvalues: u34 (copy)
                u34:HeartbeatUpdate(p38);
            end);
        end;
        if v36 then
            u34._steppedUpdate = l__RunService__2.Stepped:Connect(function(_, p39) --[[ Line: 350 ]]
                -- upvalues: u34 (copy)
                u34:SteppedUpdate(p39);
            end);
        end;
        if v37 and not u1 then
            if u34.RenderPriority then
                u11 = u11 + 1;
                u34._renderName = "ComponentRender" .. tostring(u11);
                l__RunService__2:BindToRenderStep(u34._renderName, u34.RenderPriority, function(p40) --[[ Line: 357 ]]
                    -- upvalues: u34 (copy)
                    u34:RenderSteppedUpdate(p40);
                end);
            else
                u34._renderSteppedUpdate = l__RunService__2.RenderStepped:Connect(function(p41) --[[ Line: 361 ]]
                    -- upvalues: u34 (copy)
                    u34:RenderSteppedUpdate(p41);
                end);
            end;
        end;
        u34[u10] = true;
        u32.Started:Fire(u34);
    end;
    local function u44(p43) --[[ Line: 370 ]]
        -- upvalues: l__RunService__2 (ref), u16 (ref), u32 (copy)
        if p43._heartbeatUpdate then
            p43._heartbeatUpdate:Disconnect();
        end;
        if p43._steppedUpdate then
            p43._steppedUpdate:Disconnect();
        end;
        if p43._renderSteppedUpdate then
            p43._renderSteppedUpdate:Disconnect();
        elseif p43._renderName then
            l__RunService__2:UnbindFromRenderStep(p43._renderName);
        end;
        u16(p43, "Stopping");
        p43:Stop();
        u16(p43, "Stopped");
        u32.Stopped:Fire(p43);
    end;
    local function u50(p45) --[[ Line: 421 ]]
        -- upvalues: u32 (copy), u4 (ref), u5 (ref), u6 (ref), u10 (ref), u44 (copy)
        local v46 = u32[u4][p45];
        if v46 then
            u32[u4][p45] = nil;
            u32[u5][p45] = nil;
            local v47 = u32[u6];
            local v48 = table.find(v47, v46);
            if v48 then
                local v49 = #v47;
                v47[v48] = v47[v49];
                v47[v49] = nil;
            end;
            if v46[u10] then
                task.spawn(u44, v46);
            end;
        end;
    end;
    local function u72(u51) --[[ Line: 440 ]]
        -- upvalues: u33 (copy), u32 (copy), u3 (ref), u7 (ref), u4 (ref), u5 (ref), u6 (ref), u42 (copy), u50 (copy)
        if u33[u51] then
            return;
        end;
        u33[u51] = u32[u7]:Connect(u51.AncestryChanged, function(_, p52) --[[ Line: 452 ]]
            -- upvalues: u32 (ref), u3 (ref), u51 (copy), u4 (ref), u5 (ref), u6 (ref), u42 (ref), u50 (ref)
            if not p52 then
                u50(u51);
                return;
            end;
            local v53, u54, u55;
            for _, v56 in ipairs(u32[u3]) do
                if u51:IsDescendantOf(v56) then
                    v53 = true;
                    if v53 then
                        u54 = u51;
                        if u32[u4][u54] then
                            return;
                        else
                            u55 = (u32[u5][u54] or 0) + 1;
                            u32[u5][u54] = u55;
                            task.defer(function() --[[ Line: 406 ]]
                                -- upvalues: u54 (copy), u55 (ref), u32 (ref), u5 (ref), u4 (ref), u6 (ref), u42 (ref)
                                local v60 = u54;
                                local v61 = u55;
                                local u62;
                                if u32[u5][v60] == v61 then
                                    u62 = u32:_instantiate(v60);
                                    if u32[u5][v60] ~= v61 then
                                        u62 = nil;
                                    end;
                                else
                                    u62 = nil;
                                end;
                                if u62 then
                                    u32[u4][u54] = u62;
                                    table.insert(u32[u6], u62);
                                    task.defer(function() --[[ Line: 413 ]]
                                        -- upvalues: u32 (ref), u4 (ref), u54 (ref), u62 (copy), u42 (ref)
                                        if u32[u4][u54] == u62 then
                                            u42(u62);
                                        end;
                                    end);
                                end;
                            end);
                            return;
                        end;
                    end;
                    u50(u51);
                    return;
                end;
            end;
            v53 = false;
            if v53 then
                u54 = u51;
                if u32[u4][u54] then
                    return;
                else
                    u55 = (u32[u5][u54] or 0) + 1;
                    u32[u5][u54] = u55;
                    task.defer(function() --[[ Line: 406 ]]
                        -- upvalues: u54 (copy), u55 (ref), u32 (ref), u5 (ref), u4 (ref), u6 (ref), u42 (ref)
                        local v60 = u54;
                        local v61 = u55;
                        local u62;
                        if u32[u5][v60] == v61 then
                            u62 = u32:_instantiate(v60);
                            if u32[u5][v60] ~= v61 then
                                u62 = nil;
                            end;
                        else
                            u62 = nil;
                        end;
                        if u62 then
                            u32[u4][u54] = u62;
                            table.insert(u32[u6], u62);
                            task.defer(function() --[[ Line: 413 ]]
                                -- upvalues: u32 (ref), u4 (ref), u54 (ref), u62 (copy), u42 (ref)
                                if u32[u4][u54] == u62 then
                                    u42(u62);
                                end;
                            end);
                        end;
                    end);
                    return;
                end;
            end;
            u50(u51);
        end);
        local v63, u64;
        for _, v65 in ipairs(u32[u3]) do
            if u51:IsDescendantOf(v65) then
                v63 = true;
                if v63 then
                    if u32[u4][u51] then
                        return;
                    end;
                    u64 = (u32[u5][u51] or 0) + 1;
                    u32[u5][u51] = u64;
                    task.defer(function() --[[ Line: 406 ]]
                        -- upvalues: u51 (copy), u64 (ref), u32 (ref), u5 (ref), u4 (ref), u6 (ref), u42 (ref)
                        local v69 = u51;
                        local v70 = u64;
                        local u71;
                        if u32[u5][v69] == v70 then
                            u71 = u32:_instantiate(v69);
                            if u32[u5][v69] ~= v70 then
                                u71 = nil;
                            end;
                        else
                            u71 = nil;
                        end;
                        if u71 then
                            u32[u4][u51] = u71;
                            table.insert(u32[u6], u71);
                            task.defer(function() --[[ Line: 413 ]]
                                -- upvalues: u32 (ref), u4 (ref), u51 (ref), u71 (copy), u42 (ref)
                                if u32[u4][u51] == u71 then
                                    u42(u71);
                                end;
                            end);
                        end;
                    end);
                end;
                return;
            end;
        end;
        v63 = false;
        if v63 then
            if u32[u4][u51] then
                return;
            end;
            u64 = (u32[u5][u51] or 0) + 1;
            u32[u5][u51] = u64;
            task.defer(function() --[[ Line: 406 ]]
                -- upvalues: u51 (copy), u64 (ref), u32 (ref), u5 (ref), u4 (ref), u6 (ref), u42 (ref)
                local v69 = u51;
                local v70 = u64;
                local u71;
                if u32[u5][v69] == v70 then
                    u71 = u32:_instantiate(v69);
                    if u32[u5][v69] ~= v70 then
                        u71 = nil;
                    end;
                else
                    u71 = nil;
                end;
                if u71 then
                    u32[u4][u51] = u71;
                    table.insert(u32[u6], u71);
                    task.defer(function() --[[ Line: 413 ]]
                        -- upvalues: u32 (ref), u4 (ref), u51 (ref), u71 (copy), u42 (ref)
                        if u32[u4][u51] == u71 then
                            u42(u71);
                        end;
                    end);
                end;
            end);
        end;
    end;
    local function v74(p73) --[[ Line: 465 ]]
        -- upvalues: u72 (copy)
        u72(p73);
    end;
    u32[u7]:Connect(l__CollectionService__1:GetInstanceAddedSignal(u32.Tag), v74);
    u32[u7]:Connect(l__CollectionService__1:GetInstanceRemovedSignal(u32.Tag), function(p75) --[[ Name: InstanceUntagged, Line 469 ]]
        -- upvalues: u33 (copy), u50 (copy)
        local v76 = u33[p75];
        if v76 then
            v76:Disconnect();
            u33[p75] = nil;
        end;
        u50(p75);
    end);
    local v77 = l__CollectionService__1:GetTagged(u32.Tag);
    for _, v78 in ipairs(v77) do
        task.defer(v74, v78);
    end;
end;
function u26.GetAll(p79) --[[ Line: 506 ]]
    -- upvalues: u6 (copy)
    return p79[u6];
end;
function u26.FromInstance(p80, p81) --[[ Line: 523 ]]
    -- upvalues: u4 (copy)
    return p80[u4][p81];
end;
function u26.WaitForInstance(p82, u83, p84) --[[ Line: 546 ]]
    -- upvalues: l__Promise__6 (copy)
    local u85 = p82:FromInstance(u83);
    if u85 then
        return l__Promise__6.resolve(u85);
    else
        return l__Promise__6.fromEvent(p82.Started, function(p86) --[[ Line: 551 ]]
            -- upvalues: u83 (copy), u85 (ref)
            local v87 = p86.Instance == u83;
            if v87 then
                u85 = p86;
            end;
            return v87;
        end):andThen(function() --[[ Line: 558 ]]
            -- upvalues: u85 (ref)
            return u85;
        end):timeout(type(p84) ~= "number" and 60 or p84);
    end;
end;
function u26.Construct(_) --[[ Line: 578 ]] end;
function u26.Start(_) --[[ Line: 595 ]] end;
function u26.Stop(_) --[[ Line: 615 ]] end;
function u26.GetComponent(p88, p89) --[[ Line: 634 ]]
    -- upvalues: u4 (copy)
    return p89[u4][p88.Instance];
end;
function u26.Destroy(p90) --[[ Line: 719 ]]
    -- upvalues: u7 (copy)
    p90[u7]:Destroy();
end;
return u26;
