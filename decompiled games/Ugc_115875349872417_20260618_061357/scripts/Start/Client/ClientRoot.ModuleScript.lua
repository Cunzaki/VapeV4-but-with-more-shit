-- Decompiled from: Start.Client.ClientRoot
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

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
local function u2() --[[ Line: 13 ]]
    return false;
end;
local u3 = {
    {
        _x32ae459de0772e82 = {
            module = script.Parent.Classes._x32ae459de0772e82
        }
    },
    {
        _x1ab1568e6fe5e07f = {
            gameplay_only = true,
            module = script.Parent.Classes._x1ab1568e6fe5e07f
        }
    },
    {
        _x4ecd5695de656d39 = {
            module = script.Parent.Classes._x4ecd5695de656d39
        }
    },
    {
        _x7430d6d194f43373 = {
            module = script.Parent.Classes._x7430d6d194f43373
        }
    },
    {
        Config = {
            gameplay_only = true,
            module = script.Parent.Classes.Config
        }
    },
    {
        _x302afce6669630c0 = {
            module = script.Parent.Classes._x302afce6669630c0
        }
    },
    {
        _x8c96abfd9981a439 = {
            module = script.Parent.Classes._x8c96abfd9981a439
        }
    },
    {
        _x7058397dabccd000 = {
            gameplay_only = true,
            module = script.Parent.Classes._x7058397dabccd000
        }
    },
    {
        _x056247e1c52af518 = {
            gameplay_only = true,
            module = script.Parent.Classes._x056247e1c52af518
        }
    },
    {
        _xccee945e7b75b021 = {
            module = script.Parent.Classes._xccee945e7b75b021
        }
    },
    {
        _xa582dff88acd1962 = {
            gameplay_only = true,
            module = script.Parent.Classes._xa582dff88acd1962
        }
    },
    {
        _xafc4950d7b094088 = {
            gameplay_only = true,
            module = script.Parent.Classes._xafc4950d7b094088
        }
    },
    {
        _x18cb1d13e08978ef = {
            gameplay_only = true,
            module = script.Parent.Classes._x18cb1d13e08978ef
        }
    },
    {
        _xf3501bc2d127ce8b = {
            module = script.Parent.Classes._xf3501bc2d127ce8b
        }
    },
    {
        _xc2aea7afbdbc2790 = {
            gameplay_only = true,
            module = script.Parent.Classes._xc2aea7afbdbc2790
        }
    },
    {
        _x7b50da9f175b537e = {
            gameplay_only = true,
            module = script.Parent.Classes._x7b50da9f175b537e
        }
    },
    {
        _xfe3e43ee4a76bab0 = {
            gameplay_only = true,
            module = script.Parent.Classes._xfe3e43ee4a76bab0
        }
    },
    {
        _x3e046bec2684f59c = {
            module = script.Parent.Classes._x3e046bec2684f59c
        }
    },
    {
        _x63a91bc763599cf8 = {
            module = script.Parent.Classes._x63a91bc763599cf8
        }
    },
    {
        _xd1706540247308ea = {
            gameplay_only = true,
            module = script.Parent.Classes._xd1706540247308ea
        }
    },
    {
        _xbac686a6906b7ca0 = {
            module = script.Parent.Classes._xbac686a6906b7ca0
        }
    },
    {
        _x545ff694ddcc66c8 = {
            module = script.Parent.Classes._x545ff694ddcc66c8
        }
    },
    {
        MenuManager = {
            module = script.Parent.Classes.MenuManager
        }
    },
    {
        _xfaee1d1d64cdfe93 = {
            module = script.Parent.Classes._xfaee1d1d64cdfe93
        }
    },
    {
        _xd0d75b75975ea69f = {
            module = script.Parent.Classes._xd0d75b75975ea69f
        }
    },
    {
        _x79fd9ea2402ae279 = {
            module = script.Parent.Classes._x79fd9ea2402ae279
        }
    },
    {
        _x2a30c58d6ab7ad14 = {
            module = script.Parent.Classes._x2a30c58d6ab7ad14
        }
    },
    {
        _xb880259db2a1f0f1 = {
            module = script.Parent.Classes._xb880259db2a1f0f1
        }
    },
    {
        _xd00ac57201023755 = {
            module = script.Parent.Classes._xd00ac57201023755
        }
    },
    {
        _x0a1db40feef2a32b = {
            module = script.Parent.Classes._x0a1db40feef2a32b
        }
    },
    {
        _x51bf23f1b9ed859b = {
            module = script.Parent.Classes._x51bf23f1b9ed859b
        }
    },
    {
        _xbe184fb1376a575d = {
            module = script.Parent.Classes._xbe184fb1376a575d
        }
    },
    {
        _x199aee2e6ba696d1 = {
            module = script.Parent.Classes._x199aee2e6ba696d1
        }
    },
    {
        _x64f8d2b27adbc0f7 = {
            gameplay_only = true,
            module = script.Parent.Classes._x64f8d2b27adbc0f7
        }
    },
    {
        _x910f31e87b3c7281 = {
            gameplay_only = true,
            module = script.Parent.Classes._x910f31e87b3c7281
        }
    },
    {
        _x255cd8d76027f039 = {
            module = script.Parent.Classes._x255cd8d76027f039
        }
    }
};
local function u7() --[[ Line: 70 ]]
    -- upvalues: u1 (copy), l__Assets__2 (copy), l__Players__1 (copy)
    if u1.Context.should_install_player_module_override then
        local v4 = l__Assets__2:FindFirstChild("Models") or l__Assets__2:WaitForChild("Models", 5);
        if v4 then
            v4 = v4:FindFirstChild("PlayerModule") or v4:WaitForChild("PlayerModule", 5);
        end;
        if v4 then
            local l__PlayerScripts__5 = l__Players__1.LocalPlayer:WaitForChild("PlayerScripts");
            local v5 = l__PlayerScripts__5:FindFirstChild("PlayerModule");
            if v5 then
                v5:Destroy();
            end;
            local v6 = v4:Clone();
            v6.Name = "PlayerModule";
            v6:SetAttribute("InstalledFromSharedOverride", true);
            v6.Parent = l__PlayerScripts__5;
        end;
    end;
end;
local function u13(u8, p9) --[[ Line: 94 ]]
    for u10, u11 in pairs(p9) do
        if typeof(u11) == "function" then
            p9[u10] = function(...) --[[ Line: 97 ]]
                -- upvalues: u8 (copy), u10 (copy), u11 (copy)
                debug.profilebegin(u8 .. ":" .. u10);
                local v12 = { u11(...) };
                debug.profileend();
                return unpack(v12);
            end;
        end;
    end;
    return p9;
end;
function u1.Init(p14) --[[ Line: 121 ]]
    -- upvalues: u2 (ref), l__PlaceContext__3 (copy), u1 (copy), u7 (copy), u3 (copy), l__InternalSymbols__4 (copy), u13 (copy)
    if typeof(p14) == "function" then
        u2 = p14;
    end;
    if u2() then
    else
        l__PlaceContext__3.waitUntilReady(5);
        u1.Context = l__PlaceContext__3.get(true);
        u7();
        local v15 = {};
        local v16 = {};
        for _, v17 in u3 do
            for v18, v19 in v17 do
                if not (u1.Context.is_public_lobby and v19.gameplay_only) then
                    local u20 = l__InternalSymbols__4.owner("", require(v19.module))._x90d4581ac99dd483();
                    local function v21() --[[ Line: 111 ]]
                        -- upvalues: u2 (ref), u20 (copy)
                        if u2() then
                        else
                            u20:_xe53615d96cf36a6b();
                        end;
                    end;
                    u1.Classes[v18] = u13(v18, u20);
                    v15[v18] = true;
                    table.insert(v16, v21);
                end;
            end;
        end;
        for _, v22 in game:GetService("ReplicatedStorage").Assets.SharedClasses:GetChildren() do
            if v22.Name ~= "ItemRegistry" then
                local v23 = require(v22).new();
                u1.Classes[v22.Name] = u13(v22.Name, v23);
            end;
        end;
        for _, v24 in v16 do
            task.defer(v24);
        end;
        for v25, u26 in u1.Classes do
            if not v15[v25] and (typeof(u26) == "table" and typeof(u26.Init) == "function") then
                task.defer(function() --[[ Line: 169 ]]
                    -- upvalues: u2 (ref), u26 (copy)
                    if u2() then
                    else
                        u26:Init();
                    end;
                end);
            end;
        end;
        task.defer(function() --[[ Line: 179 ]]
            -- upvalues: u2 (ref), u1 (ref)
            if u2() then
            else
                require(game:GetService("ReplicatedStorage").Assets.ModuleScripts.Packets)._x000cd2957912ab21:Fire();
                u1.loaded = true;
            end;
        end);
    end;
end;
return u1;
