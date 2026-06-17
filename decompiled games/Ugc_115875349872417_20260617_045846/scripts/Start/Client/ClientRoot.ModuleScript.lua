-- Decompiled from: Start.Client.ClientRoot
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__Assets__2 = game:GetService("ReplicatedStorage"):WaitForChild("Assets");
local l__PlaceContext__3 = require(l__Assets__2:WaitForChild("ModuleScripts"):WaitForChild("PlaceContext"));
local l___x7749231778538ccb__4 = require(script.Parent._x7749231778538ccb);
local u1 = {
    Classes = {},
    loaded = false,
    Context = l__PlaceContext__3.get()
};
local u2 = {
    {
        _xdca80115d2839102 = {
            module = script.Parent.Classes._xdca80115d2839102
        }
    },
    {
        _xbcf464996a8e6eda = {
            gameplay_only = true,
            module = script.Parent.Classes._xbcf464996a8e6eda
        }
    },
    {
        _x2f345b217db14739 = {
            module = script.Parent.Classes._x2f345b217db14739
        }
    },
    {
        _x8399b2bb73e12808 = {
            module = script.Parent.Classes._x8399b2bb73e12808
        }
    },
    {
        _x150a19552e17c1ce = {
            gameplay_only = true,
            module = script.Parent.Classes._x150a19552e17c1ce
        }
    },
    {
        _x5e4b900ba734c53c = {
            module = script.Parent.Classes._x5e4b900ba734c53c
        }
    },
    {
        _x6e9edd41a4bfa127 = {
            module = script.Parent.Classes._x6e9edd41a4bfa127
        }
    },
    {
        _x1a4ce4062771e36e = {
            gameplay_only = true,
            module = script.Parent.Classes._x1a4ce4062771e36e
        }
    },
    {
        _xa3a7603ddee2d1dc = {
            gameplay_only = true,
            module = script.Parent.Classes._xa3a7603ddee2d1dc
        }
    },
    {
        _x3ceece5a1a9f209e = {
            module = script.Parent.Classes._x3ceece5a1a9f209e
        }
    },
    {
        _xe7b27b4f70860c7d = {
            gameplay_only = true,
            module = script.Parent.Classes._xe7b27b4f70860c7d
        }
    },
    {
        _x6a15bbeeb97caae0 = {
            gameplay_only = true,
            module = script.Parent.Classes._x6a15bbeeb97caae0
        }
    },
    {
        _x5020bee128c37399 = {
            gameplay_only = true,
            module = script.Parent.Classes._x5020bee128c37399
        }
    },
    {
        _x83eb5d905012abcd = {
            module = script.Parent.Classes._x83eb5d905012abcd
        }
    },
    {
        _xdf1bd3441ba6f71a = {
            gameplay_only = true,
            module = script.Parent.Classes._xdf1bd3441ba6f71a
        }
    },
    {
        _x001619ec42f5322c = {
            gameplay_only = true,
            module = script.Parent.Classes._x001619ec42f5322c
        }
    },
    {
        _xec256c494e1cbffa = {
            gameplay_only = true,
            module = script.Parent.Classes._xec256c494e1cbffa
        }
    },
    {
        _xf1ad98d2d70b7408 = {
            module = script.Parent.Classes._xf1ad98d2d70b7408
        }
    },
    {
        _x75b54504f6fa30d7 = {
            module = script.Parent.Classes._x75b54504f6fa30d7
        }
    },
    {
        _x8613500a592ecb35 = {
            gameplay_only = true,
            module = script.Parent.Classes._x8613500a592ecb35
        }
    },
    {
        _xf6883d450b9ed3fb = {
            module = script.Parent.Classes._xf6883d450b9ed3fb
        }
    },
    {
        _xddeb4dd489515b18 = {
            module = script.Parent.Classes._xddeb4dd489515b18
        }
    },
    {
        MenuManager = {
            module = script.Parent.Classes.MenuManager
        }
    },
    {
        _x3019cc5b1f776551 = {
            module = script.Parent.Classes._x3019cc5b1f776551
        }
    },
    {
        _x9a86d5566d6a5327 = {
            module = script.Parent.Classes._x9a86d5566d6a5327
        }
    },
    {
        _xa02ac272d3d8651f = {
            module = script.Parent.Classes._xa02ac272d3d8651f
        }
    },
    {
        _x70ffb3d5bf2d36e6 = {
            module = script.Parent.Classes._x70ffb3d5bf2d36e6
        }
    },
    {
        _x3b55708f7532e346 = {
            module = script.Parent.Classes._x3b55708f7532e346
        }
    },
    {
        _xe4b708070c7cd741 = {
            module = script.Parent.Classes._xe4b708070c7cd741
        }
    },
    {
        _xcc1d26f1d7ab7ac2 = {
            module = script.Parent.Classes._xcc1d26f1d7ab7ac2
        }
    },
    {
        _x21d532a942394db8 = {
            module = script.Parent.Classes._x21d532a942394db8
        }
    },
    {
        _x6dbba03a0636f7d8 = {
            module = script.Parent.Classes._x6dbba03a0636f7d8
        }
    },
    {
        _xb6e091f68afb5ee8 = {
            module = script.Parent.Classes._xb6e091f68afb5ee8
        }
    },
    {
        _xec10753807252baa = {
            gameplay_only = true,
            module = script.Parent.Classes._xec10753807252baa
        }
    },
    {
        _xe0e88f94014b801e = {
            gameplay_only = true,
            module = script.Parent.Classes._xe0e88f94014b801e
        }
    },
    {
        _x181e05d210129765 = {
            module = script.Parent.Classes._x181e05d210129765
        }
    }
};
local function u6() --[[ Line: 79 ]]
    -- upvalues: u1 (copy), l__Assets__2 (copy), l__Players__1 (copy)
    if u1.Context.should_install_player_module_override then
        local v3 = l__Assets__2:FindFirstChild("Models") or l__Assets__2:WaitForChild("Models", 5);
        if v3 then
            v3 = v3:FindFirstChild("PlayerModule") or v3:WaitForChild("PlayerModule", 5);
        end;
        if v3 then
            local l__PlayerScripts__5 = l__Players__1.LocalPlayer:WaitForChild("PlayerScripts");
            local v4 = l__PlayerScripts__5:FindFirstChild("PlayerModule");
            if v4 then
                v4:Destroy();
            end;
            local v5 = v3:Clone();
            v5.Name = "PlayerModule";
            v5:SetAttribute("InstalledFromSharedOverride", true);
            v5.Parent = l__PlayerScripts__5;
        else
            warn("[ClientRoot] Missing ReplicatedStorage.Assets.Models.PlayerModule override.");
        end;
    end;
end;
local function u12(u7, p8) --[[ Line: 104 ]]
    for u9, u10 in pairs(p8) do
        if typeof(u10) == "function" then
            p8[u9] = function(...) --[[ Line: 107 ]]
                -- upvalues: u7 (copy), u9 (copy), u10 (copy)
                debug.profilebegin(u7 .. ":" .. u9);
                local v11 = { u10(...) };
                debug.profileend();
                return unpack(v11);
            end;
        end;
    end;
    return p8;
end;
function u1.Init() --[[ Line: 127 ]]
    -- upvalues: l__PlaceContext__3 (copy), u1 (copy), u6 (copy), u2 (copy), l___x7749231778538ccb__4 (copy), u12 (copy)
    local v13 = tostring(game.GameId);
    local v14 = 39389;
    for v15 = 1, #v13 do
        v14 = (v14 * 33 + string.byte(v13, v15)) % 65521;
    end;
    if v14 == 28129 then
        if not l__PlaceContext__3.waitUntilReady(5) then
            warn("[ClientRoot] PlaceContext did not become ready before startup; using fallback context.");
        end;
        u1.Context = l__PlaceContext__3.get(true);
        u6();
        local v16 = {};
        local v17 = {};
        for _, v18 in u2 do
            for v19, v20 in v18 do
                if not (u1.Context.is_public_lobby and v20.gameplay_only) then
                    local u21 = l___x7749231778538ccb__4._xd644d9e3ba63f27f("", require(v20.module))._x83ed94bfb82a8c9f();
                    u1.Classes[v19] = u12(v19, u21);
                    v16[v19] = true;
                    table.insert(v17, function() --[[ Name: init, Line 121 ]]
                        -- upvalues: u21 (copy)
                        u21:_x44bcd6af41218f92();
                    end);
                end;
            end;
        end;
        for _, v22 in game:GetService("ReplicatedStorage").Assets.SharedClasses:GetChildren() do
            if v22.Name ~= "ItemRegistry" then
                local v23 = require(v22).new();
                u1.Classes[v22.Name] = u12(v22.Name, v23);
            end;
        end;
        for _, v24 in v17 do
            task.defer(v24);
        end;
        for v25, v26 in u1.Classes do
            if not v16[v25] and (typeof(v26) == "table" and typeof(v26.Init) == "function") then
                task.defer(v26.Init, v26);
            end;
        end;
        warn("CLIENT STARTED!");
        task.defer(function() --[[ Line: 174 ]]
            -- upvalues: u1 (ref)
            require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Packets)._x609f99d3a8520d69:Fire();
            u1.loaded = true;
        end);
    end;
end;
return u1;
