-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__move__1 = table.move;
local l__clear__2 = table.clear;
local l__insert__3 = table.insert;
local l__yield__4 = coroutine.yield;
local l__resume__5 = coroutine.resume;
local l__running__6 = coroutine.running;
local l__obtain__7 = _G.obtain;
local v1 = l__obtain__7("Remote");
local l__Call__8 = v1.Call;
local v2 = l__obtain__7("Signal");
local v3 = l__obtain__7("TimeManager");
local l__userId__9 = game:GetService("Players").LocalPlayer.userId;
local u4 = {};
local u5 = nil;
local v6 = {};
local u7 = {};
local u8 = {};
v6.AllMaps = u7;
v6.MapFromId = u8;
local u9 = v2();
v6.Ready = u9;
local u10 = v2();
v6.MapAdded = u10;
local u11 = v2();
v6.MapUpdated = u11;
local u12 = {};
local u13 = {};
local u14 = v2();
v6.CompletionUpdated = u14;
local u15 = true;
v1.Add("SetMaps", function(p16) --[[ Line: 46 ]]
    -- upvalues: u15 (ref), l__clear__2 (copy), u7 (copy), u8 (copy), l__move__1 (copy), u9 (copy)
    if u15 then
        u15 = false;
        l__clear__2(u7);
        l__clear__2(u8);
        l__move__1(p16, 1, #p16, 1, u7);
        for v17 = 1, #p16 do
            u8[p16[v17].AssetId] = p16[v17];
        end;
        u9:Call();
    end;
end);
function v6.Init() --[[ Line: 59 ]]
    -- upvalues: l__Call__8 (copy)
    l__Call__8("GetMaps");
end;
v1.Add("NewMap", function(p18) --[[ Line: 63 ]]
    -- upvalues: u7 (copy), u8 (copy), u10 (copy)
    u7[#u7 + 1] = p18;
    u8[p18.AssetId] = p18;
    u10:Call(p18);
end);
v1.Add("UpdateMap", function(p19) --[[ Line: 69 ]]
    -- upvalues: u7 (copy), u8 (copy), u11 (copy)
    local v20 = nil;
    for v21, v22 in u7 do
        if v22.AssetId == p19.AssetId then
            v20 = v21;
        end;
    end;
    u7[v20] = p19;
    u8[p19.AssetId] = p19;
    u11:Call(p19);
end);
v3.NewTimeHook:Add(function(p23) --[[ Line: 81 ]]
    -- upvalues: l__userId__9 (copy), u13 (copy), u12 (copy), u14 (copy)
    if p23.User == l__userId__9 then
        local l__Map__10 = p23.Map;
        local v24 = u13[p23.Style];
        if not v24 then
            v24 = {};
            u13[p23.Style] = v24;
        end;
        if not (u12[l__Map__10] and v24[l__Map__10]) then
            u12[l__Map__10] = true;
            v24[l__Map__10] = true;
            u14:Call();
        end;
    end;
end);
v1.Add("SetCompletion", function(p25, p26) --[[ Line: 97 ]]
    -- upvalues: u13 (copy), u12 (copy), u5 (ref), l__resume__5 (copy), u14 (copy)
    local v27;
    if p26 then
        v27 = u13[p26];
        if not v27 then
            v27 = {};
            u13[p26] = v27;
        end;
    else
        v27 = u12;
    end;
    for v28 = 1, #p25 do
        v27[p25[v28]] = true;
    end;
    if u5 then
        local v29 = u5;
        u5 = nil;
        for v30 = 1, #v29 do
            local v31, v32 = l__resume__5(v29[v30]);
            if not v31 then
                print("resume error:", v32);
            end;
        end;
    end;
    u14:Call();
end);
v1.Add("ResetCompletionFetchOnce", function(p33) --[[ Line: 123 ]]
    -- upvalues: u4 (copy)
    u4[p33] = false;
end);
function v6.GetCompletion(p34) --[[ Line: 127 ]]
    -- upvalues: u4 (copy), u5 (ref), l__running__6 (copy), l__insert__3 (copy), l__Call__8 (copy), l__yield__4 (copy), u13 (copy), u12 (copy)
    local v35 = p34 or "all";
    local v36;
    if u4[v35] then
        v36 = false;
    else
        v36 = true;
        u4[v35] = true;
        if not u5 then
            u5 = {};
        end;
    end;
    if u5 then
        l__insert__3(u5, (l__running__6()));
        if v36 then
            l__Call__8("GetCompletion", p34);
        end;
        l__yield__4();
    end;
    return p34 and u13[p34] or u12;
end;
return v6;
