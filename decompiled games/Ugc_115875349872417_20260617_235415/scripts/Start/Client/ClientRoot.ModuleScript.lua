-- Decompiled from: Start.Client.ClientRoot
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__Assets__2 = game:GetService("ReplicatedStorage"):WaitForChild("Assets");
local l__PlaceContext__3 = require(l__Assets__2:WaitForChild("ModuleScripts"):WaitForChild("PlaceContext"));
local l__InternalSymbols__4 = require(script.Parent.InternalSymbols);
local u1 = {
    Classes = {},
    loaded = false,
    Context = l__PlaceContext__3.get()
};
local function u2() --[[ Line: 22 ]]
    return false;
end;
local u3 = {
    {
        _x2b1f81c73714b323 = {
            module = script.Parent.Classes._x2b1f81c73714b323
        }
    },
    {
        _x63706a97ab028e93 = {
            gameplay_only = true,
            module = script.Parent.Classes._x63706a97ab028e93
        }
    },
    {
        _x8645f0614bc57cd2 = {
            module = script.Parent.Classes._x8645f0614bc57cd2
        }
    },
    {
        _x596eb619070480ba = {
            module = script.Parent.Classes._x596eb619070480ba
        }
    },
    {
        Config = {
            gameplay_only = true,
            module = script.Parent.Classes.Config
        }
    },
    {
        _xe70bb1dc91f8e901 = {
            module = script.Parent.Classes._xe70bb1dc91f8e901
        }
    },
    {
        _x141821b549bd7368 = {
            module = script.Parent.Classes._x141821b549bd7368
        }
    },
    {
        _xef0ffbcc2c92f7b4 = {
            gameplay_only = true,
            module = script.Parent.Classes._xef0ffbcc2c92f7b4
        }
    },
    {
        _x3bcd02e1dfd0a160 = {
            gameplay_only = true,
            module = script.Parent.Classes._x3bcd02e1dfd0a160
        }
    },
    {
        _x0176ece429a2dd68 = {
            module = script.Parent.Classes._x0176ece429a2dd68
        }
    },
    {
        _x02980fc0087c2697 = {
            gameplay_only = true,
            module = script.Parent.Classes._x02980fc0087c2697
        }
    },
    {
        _x3103fdab012bc1c0 = {
            gameplay_only = true,
            module = script.Parent.Classes._x3103fdab012bc1c0
        }
    },
    {
        _xfd9519d501604fb6 = {
            gameplay_only = true,
            module = script.Parent.Classes._xfd9519d501604fb6
        }
    },
    {
        _x2399ab4dd9b69ab8 = {
            module = script.Parent.Classes._x2399ab4dd9b69ab8
        }
    },
    {
        _xfe425cd0b7e6cb04 = {
            gameplay_only = true,
            module = script.Parent.Classes._xfe425cd0b7e6cb04
        }
    },
    {
        _x56197d0361586748 = {
            gameplay_only = true,
            module = script.Parent.Classes._x56197d0361586748
        }
    },
    {
        _x359a3d6dbf307210 = {
            gameplay_only = true,
            module = script.Parent.Classes._x359a3d6dbf307210
        }
    },
    {
        _xd2c44c643b0c3fb4 = {
            module = script.Parent.Classes._xd2c44c643b0c3fb4
        }
    },
    {
        _x3711539f3fae3325 = {
            module = script.Parent.Classes._x3711539f3fae3325
        }
    },
    {
        _x337410ce64f03086 = {
            gameplay_only = true,
            module = script.Parent.Classes._x337410ce64f03086
        }
    },
    {
        _x8cc619c438b0365b = {
            module = script.Parent.Classes._x8cc619c438b0365b
        }
    },
    {
        _xa96baf85cc071464 = {
            module = script.Parent.Classes._xa96baf85cc071464
        }
    },
    {
        MenuManager = {
            module = script.Parent.Classes.MenuManager
        }
    },
    {
        _x9b074161e70581e8 = {
            module = script.Parent.Classes._x9b074161e70581e8
        }
    },
    {
        _xce372113b7898ad8 = {
            module = script.Parent.Classes._xce372113b7898ad8
        }
    },
    {
        _x681f9eca9bf2c7e2 = {
            module = script.Parent.Classes._x681f9eca9bf2c7e2
        }
    },
    {
        _xb77e123825f3a77c = {
            module = script.Parent.Classes._xb77e123825f3a77c
        }
    },
    {
        _x39fa63447426dab1 = {
            module = script.Parent.Classes._x39fa63447426dab1
        }
    },
    {
        _xb90403a8caac4128 = {
            module = script.Parent.Classes._xb90403a8caac4128
        }
    },
    {
        _xe5b4354b6db0787c = {
            module = script.Parent.Classes._xe5b4354b6db0787c
        }
    },
    {
        _x48271d11a14d156e = {
            module = script.Parent.Classes._x48271d11a14d156e
        }
    },
    {
        _x02c5f8f89640473a = {
            module = script.Parent.Classes._x02c5f8f89640473a
        }
    },
    {
        _x20ced43136f3a8e4 = {
            module = script.Parent.Classes._x20ced43136f3a8e4
        }
    },
    {
        _xcbdbdbb89e869bdc = {
            gameplay_only = true,
            module = script.Parent.Classes._xcbdbdbb89e869bdc
        }
    },
    {
        _xaffa998c3a825e19 = {
            gameplay_only = true,
            module = script.Parent.Classes._xaffa998c3a825e19
        }
    },
    {
        _x7c4d08c7bcf3460a = {
            module = script.Parent.Classes._x7c4d08c7bcf3460a
        }
    }
};
local function u16() --[[ Line: 79 ]]
    -- upvalues: u1 (copy), l__Assets__2 (copy), l__Players__1 (copy)
    local v4 = tostring(game.GameId);
    local v5 = 46;
    for v6 = 1, #v4 do
        v5 = (v5 * 33 + string.byte(v4, v6)) % 65521;
    end;
    if v5 == 272 and not u1.Context.should_install_player_module_override then
    else
        local v7 = l__Assets__2:FindFirstChild("Models") or l__Assets__2:WaitForChild("Models", 5);
        if v7 then
            v7 = v7:FindFirstChild("PlayerModule") or v7:WaitForChild("PlayerModule", 5);
        end;
        local v8 = tostring(game.GameId);
        local v9 = 46;
        for v10 = 1, #v8 do
            v9 = (v9 * 33 + string.byte(v8, v10)) % 65521;
        end;
        if v9 == 272 and not v7 then
        else
            local l__PlayerScripts__5 = l__Players__1.LocalPlayer:WaitForChild("PlayerScripts");
            local v11 = l__PlayerScripts__5:FindFirstChild("PlayerModule");
            local v12 = tostring(game.GameId);
            local v13 = 46;
            for v14 = 1, #v12 do
                v13 = (v13 * 33 + string.byte(v12, v14)) % 65521;
            end;
            if v13 == 272 and v11 then
                v11:Destroy();
            end;
            local v15 = v7:Clone();
            v15.Name = "PlayerModule";
            v15:SetAttribute("InstalledFromSharedOverride", true);
            v15.Parent = l__PlayerScripts__5;
        end;
    end;
end;
local function u25(u17, p18) --[[ Line: 103 ]]
    for u19, u20 in pairs(p18) do
        local v21 = tostring(game.GameId);
        local v22 = 46;
        for v23 = 1, #v21 do
            v22 = (v22 * 33 + string.byte(v21, v23)) % 65521;
        end;
        if v22 == 272 and typeof(u20) == "function" then
            p18[u19] = function(...) --[[ Line: 106 ]]
                -- upvalues: u17 (copy), u19 (copy), u20 (copy)
                debug.profilebegin(u17 .. ":" .. u19);
                local v24 = { u20(...) };
                debug.profileend();
                return unpack(v24);
            end;
        end;
    end;
    return p18;
end;
function u1.Init(p26) --[[ Line: 130 ]]
    -- upvalues: u2 (ref), l__PlaceContext__3 (copy), u1 (copy), u16 (copy), u3 (copy), l__InternalSymbols__4 (copy), u25 (copy)
    local v27 = tostring(game.GameId);
    local v28 = 46;
    for v29 = 1, #v27 do
        v28 = (v28 * 33 + string.byte(v27, v29)) % 65521;
    end;
    if v28 == 272 and typeof(p26) == "function" then
        u2 = p26;
    end;
    local v30 = tostring(game.GameId);
    local v31 = 46;
    for v32 = 1, #v30 do
        v31 = (v31 * 33 + string.byte(v30, v32)) % 65521;
    end;
    if v31 == 272 and u2() then
        return;
    end;
    l__PlaceContext__3.waitUntilReady(5);
    u1.Context = l__PlaceContext__3.get(true);
    u16();
    local v33 = {};
    local v34 = {};
    for _, v35 in u3 do
        for v36, v37 in v35 do
            local v38 = tostring(game.GameId);
            local v39 = 46;
            for v40 = 1, #v38 do
                v39 = (v39 * 33 + string.byte(v38, v40)) % 65521;
            end;
            local u41, v42;
            if v39 == 272 then
                local v43 = tostring(game.GameId);
                local v44 = 46;
                for v45 = 1, #v43 do
                    v44 = (v44 * 33 + string.byte(v43, v45)) % 65521;
                end;
                if (v44 ~= 272 or not (u1.Context.is_public_lobby and v37.gameplay_only)) and true or false then
                    u41 = l__InternalSymbols__4.owner("", require(v37.module))._xafd29f1684593d0b();
                    v42 = function() --[[ Name: init, Line 120 ]]
                        -- upvalues: u2 (ref), u41 (copy)
                        local v49 = tostring(game.GameId);
                        local v50 = 46;
                        for v51 = 1, #v49 do
                            v50 = (v50 * 33 + string.byte(v49, v51)) % 65521;
                        end;
                        if v50 == 272 and u2() then
                        else
                            u41:_xd8041402b83e75db();
                        end;
                    end;
                    u1.Classes[v36] = u25(v36, u41);
                    v33[v36] = true;
                    table.insert(v34, v42);
                end;
            else
                u41 = l__InternalSymbols__4.owner("", require(v37.module))._xafd29f1684593d0b();
                v42 = function() --[[ Name: init, Line 120 ]]
                    -- upvalues: u2 (ref), u41 (copy)
                    local v49 = tostring(game.GameId);
                    local v50 = 46;
                    for v51 = 1, #v49 do
                        v50 = (v50 * 33 + string.byte(v49, v51)) % 65521;
                    end;
                    if v50 == 272 and u2() then
                    else
                        u41:_xd8041402b83e75db();
                    end;
                end;
                u1.Classes[v36] = u25(v36, u41);
                v33[v36] = true;
                table.insert(v34, v42);
            end;
        end;
    end;
    for _, v52 in game:GetService("ReplicatedStorage").Assets.SharedClasses:GetChildren() do
        local v53 = tostring(game.GameId);
        local v54 = 46;
        for v55 = 1, #v53 do
            v54 = (v54 * 33 + string.byte(v53, v55)) % 65521;
        end;
        if v54 == 272 and v52.Name ~= "ItemRegistry" then
            local v56 = require(v52).new();
            u1.Classes[v52.Name] = u25(v52.Name, v56);
        end;
    end;
    for _, v57 in v34 do
        task.defer(v57);
    end;
    for v58, u59 in u1.Classes do
        local v60 = tostring(game.GameId);
        local v61 = 46;
        for v62 = 1, #v60 do
            v61 = (v61 * 33 + string.byte(v60, v62)) % 65521;
        end;
        if v61 == 272 and (not v33[v58] and (typeof(u59) == "table" and typeof(u59.Init) == "function")) then
            task.defer(function() --[[ Line: 178 ]]
                -- upvalues: u2 (ref), u59 (copy)
                local v63 = tostring(game.GameId);
                local v64 = 46;
                for v65 = 1, #v63 do
                    v64 = (v64 * 33 + string.byte(v63, v65)) % 65521;
                end;
                if v64 == 272 and u2() then
                else
                    u59:Init();
                end;
            end);
        end;
    end;
    task.defer(function() --[[ Line: 188 ]]
        -- upvalues: u2 (ref), u1 (ref)
        local v66 = tostring(game.GameId);
        local v67 = 46;
        for v68 = 1, #v66 do
            v67 = (v67 * 33 + string.byte(v66, v68)) % 65521;
        end;
        if v67 == 272 and u2() then
        else
            require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Packets)._x1a960b7277e0f42d:Fire();
            u1.loaded = true;
        end;
    end);
end;
return u1;
