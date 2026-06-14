-- Decompiled from: ReplicatedStorage.Assets.Shared.Holder
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
local l__Warn__1 = require(script.Parent.Warn);
local l___Signals__2 = require(script.Parent.Events)._Signals;
local u1 = game:GetService("RunService"):IsServer();
local u2 = 0;
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = Random.new();
local function u10(p7, p8) --[[ Line: 58 ]]
    -- upvalues: u5 (copy), u4 (copy), l___Signals__2 (copy)
    if not u5[p8.id] or p8.id < 1 then
        error("Entity must be registered before being set as a player character");
    end;
    local v9 = u4[p7];
    if v9 then
        local l___player__3 = v9._player;
        v9._player = nil;
        if l___player__3 and u4[l___player__3] == v9 then
            u4[l___player__3] = nil;
            l___Signals__2["请不要使用_内部_设置值_拜托谢谢_嗨_这个名字有点长_好吧_再见_算了_这个确实被用了_因为递归错误_而我懒得去解决_所以这是一个能用的_创可贴式修复_好吧"]:Fire(v9, "_player", nil);
            l___Signals__2.PlayerCharacterUnregistered:Fire(l___player__3, v9);
        end;
    end;
    u4[p7] = p8;
    l___Signals__2["请不要使用_内部_设置值_拜托谢谢_嗨_这个名字有点长_好吧_再见_算了_这个确实被用了_因为递归错误_而我懒得去解决_所以这是一个能用的_创可贴式修复_好吧"]:Fire(p8, "_player", p7);
    l___Signals__2.PlayerCharacterRegistered:Fire(p7, p8);
end;
return {
    idMap = u5,
    _clientOwned = {},
    _playerChars = u4,
    RegisterEntity = function(p11) --[[ Name: RegisterEntity, Line 81 ]]
        -- upvalues: u5 (copy), l__Warn__1 (copy), u1 (copy), u3 (copy), u2 (ref), u4 (copy), u10 (copy), l___Signals__2 (copy)
        if p11.destroyed then
            error("Cannot register a destroyed entity");
        end;
        if u5[p11.id] then
            l__Warn__1.medium("Entity is already registered", p11);
        else
            if u1 then
                local v12 = table.remove(u3);
                if not v12 then
                    if u2 >= 65535 then
                        error("Max ID reached, please investigate.");
                    end;
                    u2 = u2 + 1;
                    v12 = u2;
                end;
                if u5[v12] then
                    error((`Entity Collision {v12}`));
                end;
                p11.id = v12;
                u5[v12] = p11;
            else
                local l__id__4 = p11.id;
                if u5[l__id__4] then
                    l__Warn__1.high("Entity ID collision detected for ID:", l__id__4);
                end;
                u5[l__id__4] = p11;
            end;
            p11.registered = true;
            if p11._player then
                if u4[p11._player] then
                    l__Warn__1.medium("Player already has an entity registered", p11, "overwriting");
                end;
                u10(p11._player, p11);
            end;
            l___Signals__2.EntityAdded:Fire(p11);
        end;
    end,
    UnregisterEntity = function(p13) --[[ Name: UnregisterEntity, Line 119 ]]
        -- upvalues: u5 (copy), l___Signals__2 (copy), u4 (copy), l__Warn__1 (copy), u1 (copy), u6 (copy), u3 (copy)
        if u5[p13.id] then
            l___Signals__2.EntityRemoved:Fire(p13);
            local l___player__5 = p13._player;
            if l___player__5 then
                if u4[l___player__5] == p13 then
                    local l___player__6 = p13._player;
                    p13._player = nil;
                    if l___player__6 and u4[l___player__6] == p13 then
                        u4[l___player__6] = nil;
                        l___Signals__2["请不要使用_内部_设置值_拜托谢谢_嗨_这个名字有点长_好吧_再见_算了_这个确实被用了_因为递归错误_而我懒得去解决_所以这是一个能用的_创可贴式修复_好吧"]:Fire(p13, "_player", nil);
                        l___Signals__2.PlayerCharacterUnregistered:Fire(l___player__6, p13);
                    end;
                else
                    l__Warn__1.medium("Entity being unregistered does not match player mapping", p13, "ignoring");
                end;
            end;
            local l__id__7 = p13.id;
            if u1 then
                u5[l__id__7] = nil;
                task.delay(u6:NextNumber(5, 10), table.insert, u3, l__id__7);
                p13.id = -1;
            else
                u5[l__id__7] = nil;
            end;
            p13._lastId = l__id__7;
            p13.registered = false;
        end;
    end,
    GetEntityStorageInstance = function() --[[ Name: getEntityStorageInstance, Line 186 ]]
        if workspace:FindFirstChild("Chrono_EntityStorage") then
            return workspace:FindFirstChild("Chrono_EntityStorage");
        end;
        local v14 = Instance.new("Camera");
        v14.Name = "Chrono_EntityStorage";
        v14.Parent = workspace;
        return v14;
    end,
    SetAsCharacter = u10,
    RemovePlayerCharacter = function(p15) --[[ Name: RemovePlayerCharacter, Line 38 ]]
        -- upvalues: u4 (copy), l___Signals__2 (copy)
        local l___player__8 = p15._player;
        p15._player = nil;
        if l___player__8 and u4[l___player__8] == p15 then
            u4[l___player__8] = nil;
            l___Signals__2["请不要使用_内部_设置值_拜托谢谢_嗨_这个名字有点长_好吧_再见_算了_这个确实被用了_因为递归错误_而我懒得去解决_所以这是一个能用的_创可贴式修复_好吧"]:Fire(p15, "_player", nil);
            l___Signals__2.PlayerCharacterUnregistered:Fire(l___player__8, p15);
        end;
    end,
    GetEntityFromPlayer = function(p16) --[[ Name: GetEntityFromPlayer, Line 165 ]]
        -- upvalues: u4 (copy)
        return u4[p16];
    end,
    GetEntityFromId = function(p17) --[[ Name: GetEntityFromId, Line 177 ]]
        -- upvalues: u5 (copy)
        return u5[p17];
    end,
    GetEntityFromModel = function(p18) --[[ Name: GetEntityFromModel, Line 151 ]]
        -- upvalues: u5 (copy)
        for _, v19 in u5 do
            if v19.model == p18 then
                return v19;
            end;
        end;
        return nil;
    end
};
