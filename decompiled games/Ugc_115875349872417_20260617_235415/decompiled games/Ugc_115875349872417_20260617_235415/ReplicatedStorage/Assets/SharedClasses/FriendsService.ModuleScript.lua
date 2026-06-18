-- Decompiled from: ReplicatedStorage.Assets.SharedClasses.FriendsService
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 13 ]]
    -- upvalues: u1 (copy), l__Players__1 (copy)
    local u3 = setmetatable({}, u1);
    u3._cache = {};
    u3._pending = {};
    u3._refreshInterval = p2 or 60;
    l__Players__1.PlayerRemoving:Connect(function(p4) --[[ Line: 20 ]]
        -- upvalues: u3 (copy)
        u3:_cleanupPlayer(p4.UserId);
    end);
    return u3;
end;
function u1.isFriendsWith(u5, u6, u7) --[[ Line: 32 ]]
    if not (u6 and u7) then
        warn("MISSING PLAYER FIELDS FOR isFriendsWith:", u6, u7);
        return false;
    end;
    if u6 == u7 then
        return true;
    end;
    local l__UserId__2 = u6.UserId;
    local l__UserId__3 = u7.UserId;
    local v8 = os.clock();
    local v9 = u5._cache[l__UserId__2];
    if v9 then
        v9 = v9[l__UserId__3];
    end;
    if not v9 then
        return u5:_fetchAndCache(u6, u7);
    end;
    if v8 - v9.timestamp > u5._refreshInterval then
        task.spawn(function() --[[ Line: 45 ]]
            -- upvalues: u5 (copy), u6 (copy), u7 (copy)
            u5:_fetchAndCache(u6, u7);
        end);
    end;
    return v9.status;
end;
function u1._fetchAndCache(p10, u11, u12) --[[ Line: 56 ]]
    local l__UserId__4 = u11.UserId;
    local l__UserId__5 = u12.UserId;
    local v13 = l__UserId__4 < l__UserId__5 and l__UserId__4 .. "-" .. l__UserId__5 or l__UserId__5 .. "-" .. l__UserId__4;
    if p10._pending[v13] then
        table.insert(p10._pending[v13], coroutine.running());
        return coroutine.yield();
    end;
    p10._pending[v13] = {};
    local v14, v15 = pcall(function() --[[ Line: 68 ]]
        -- upvalues: u11 (copy), u12 (copy)
        return u11:IsFriendsWithAsync(u12.UserId);
    end);
    local v16 = v14 and v15 and v15 or false;
    local v17 = {
        status = v16,
        timestamp = os.clock()
    };
    p10:_setCache(u11.UserId, u12.UserId, v17);
    p10:_setCache(u12.UserId, u11.UserId, v17);
    local v18 = p10._pending[v13];
    p10._pending[v13] = nil;
    for _, v19 in ipairs(v18) do
        task.spawn(v19, v16);
    end;
    return v16;
end;
function u1._setCache(p20, p21, p22, p23) --[[ Line: 89 ]]
    if not p20._cache[p21] then
        p20._cache[p21] = {};
    end;
    p20._cache[p21][p22] = p23;
end;
function u1._cleanupPlayer(p24, p25) --[[ Line: 94 ]]
    p24._cache[p25] = nil;
end;
return u1;
