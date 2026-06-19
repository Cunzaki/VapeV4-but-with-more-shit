-- Decompiled from: Load
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local v1 = _G;
local v2 = game;
local v3 = next;
local u4 = tick;
local u5 = type;
local v6 = wait;
local u7 = error;
local u8 = print;
local v9 = script;
local u10 = pcall;
local u11 = require;
local l__clear__1 = table.clear;
local l__create__2 = coroutine.create;
local l__resume__3 = coroutine.resume;
local l__IsA__4 = v2.IsA;
local l__GetChildren__5 = v2.GetChildren;
local l__ReplicatedStorage__6 = v2:GetService("ReplicatedStorage");
local v12 = l__GetChildren__5(l__ReplicatedStorage__6.Client);
local u13 = {};
for v14 = 1, #v12 do
    local v15 = v12[v14];
    if l__IsA__4(v15, "ModuleScript") then
        u13[v15.Name] = v15;
    end;
end;
local v16 = l__GetChildren__5(l__ReplicatedStorage__6.Shared);
local u17 = {};
for v18 = 1, #v16 do
    local v19 = v16[v18];
    if l__IsA__4(v19, "ModuleScript") then
        u17[v19.Name] = v19;
    end;
end;
l__clear__1(v16);
local u20 = {};
local u21 = {};
local u22 = {};
function v1.obtain(p23) --[[ Line: 52 ]]
    -- upvalues: u13 (ref), u17 (ref), u22 (ref), u4 (copy), u10 (copy), u11 (copy), u8 (copy), u5 (copy), u20 (ref), u21 (ref), u7 (copy)
    local v24 = u13[p23] or u17[p23];
    if v24 then
        if not u22[v24] then
            u22[v24] = true;
        end;
        local v25 = u4();
        local v26, v27 = u10(u11, v24);
        local v28 = u4() - v25;
        if v28 > 0.01 then
            u8("[Load] Slow Load:", v24, v28);
        end;
        if v26 then
            if u5(v27) == "table" then
                u20[v24] = v27.Init;
                u21[v24] = v27.InitLast;
            end;
            return v27;
        end;
        u7("[Load] " .. v24.Name .. " failed to load: " .. v27);
    else
        u7("Could not find module named " .. p23);
    end;
end;
local v29 = v9:GetChildren();
local v30 = u22;
local v31 = u21;
local v32 = u20;
local v33 = {};
for v34 = 1, #v29 do
    local v35 = v29[v34];
    local v36 = u4();
    local v37, v38 = u10(u11, v35);
    local v39 = u4() - v36;
    if v39 > 0.01 then
        u8("[Load] Slow Load:", v35, v39);
    end;
    if v37 then
        if u5(v38) == "function" then
            v33[v34] = v38;
        end;
    else
        u8("[Load] Error in module " .. v29[v34].Name .. ": ", v38);
    end;
end;
for v40, v41 in v3, v32 do
    local v42, v43 = l__resume__3(l__create__2(v41));
    if not v42 then
        u8("[Load] ERROR:", v40.Name, v43);
    end;
end;
l__clear__1(v32);
u20 = nil;
for v44 = 1, #v29 do
    if v33[v44] then
        local v45, v46 = l__resume__3(l__create__2(v33[v44]));
        if not v45 then
            u8("[Load] ERROR in main function (good luck finding it idiot):", v46);
        end;
    end;
end;
l__clear__1(v33);
for v47, v48 in v3, v31 do
    local v49, v50 = l__resume__3(l__create__2(v48));
    if not v49 then
        u8("[Load] ERROR in ModuleFunctionLast:", v47.Name, v50);
    end;
end;
l__clear__1(v31);
u21 = nil;
for v51, v52 in v3, u13 do
    if not v30[v52] then
        u8("Unused Client Module:", v51);
    end;
    v52.Name = "";
end;
l__clear__1(u13);
local _ = nil;
for v53, v54 in v3, u17 do
    if not v30[v54] then
        u8("Unused Shared Module:", v53);
    end;
    v54.Name = "";
end;
l__clear__1(u17);
local _ = nil;
l__clear__1(v30);
u22 = nil;
v1.obtain = nil;
v6();
for v55 = 1, #v29 do
    v29[v55]:Destroy();
end;
l__ReplicatedStorage__6.Shared:Destroy();
l__ReplicatedStorage__6.Client:Destroy();
local v56 = v2:GetService("StarterPlayer"):FindFirstChild("StarterPlayerScripts");
if v56 then
    local v57 = l__GetChildren__5(v56);
    for v58 = 1, #v57 do
        v57[v58]:Destroy();
    end;
end;
v9:Destroy();
return true;
