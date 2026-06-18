-- Decompiled from: Start.Client.Classes._xafc4950d7b094088._x7bf32b206fec7a03
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__Classes__1 = require(script.Parent.Parent.Parent.ClientRoot).Classes;
local u1 = {};
u1.__index = u1;
local u2 = false;
function u1._x90d4581ac99dd483(p3) --[[ Line: 9 ]]
    -- upvalues: u1 (copy)
    local v4 = setmetatable({}, u1);
    v4._x9f381b99fa9097bd = p3.name;
    v4._xa421b937c4699429 = p3.priority;
    v4._x7a433e88d76bfbbf = p3.screenspace;
    v4._x031a6113d489e09a = Instance.new("BindableEvent");
    v4._x67de9152dd429711 = nil;
    return v4;
end;
function u1._x0c12c35991a1957b(p5) --[[ Line: 21 ]]
    local v6 = game:GetService("ReplicatedStorage").Assets.UIAssets:FindFirstChild(p5._x9f381b99fa9097bd);
    if v6 then
        return v6;
    end;
    warn("findAsset FAILED FOR CROSSHAIR :" .. p5._x9f381b99fa9097bd);
end;
function u1._x1914f3f7de719d0f(p7, p8) --[[ Line: 30 ]]
    p7._x6679dae12d5569bf = p8;
end;
function u1._x21ecfce33c4250b9(p9, p10) --[[ Line: 34 ]]
    p9._x9d0c0a6d51e5104c = p10;
end;
function u1._xd00fdb58a7e8416d(p11) --[[ Line: 38 ]]
    -- upvalues: l__Classes__1 (copy)
    if p11._x67de9152dd429711 then
        p11._x67de9152dd429711:Destroy();
    end;
    l__Classes__1._xafc4950d7b094088:_xdc0a0193deec55d1(p11);
end;
function u1._xe86d94ba29814c9e(_) --[[ Line: 46 ]]
    -- upvalues: l__Classes__1 (copy)
    return l__Classes__1._xafc4950d7b094088._xb2e12cde47dd8c35;
end;
function u1._x85d5c9858f06ea97(_) --[[ Line: 50 ]]
    return game.Players.LocalPlayer.PlayerGui;
end;
function u1._xc2323225d7a5fb12(_) --[[ Line: 54 ]]
    -- upvalues: l__Classes__1 (copy)
    return l__Classes__1._x32ae459de0772e82._xba86765c885864a8;
end;
function u1._x5cf0752c71677516(_) --[[ Line: 58 ]]
    -- upvalues: l__Classes__1 (copy)
    return l__Classes__1._x32ae459de0772e82._x3ec9227a0d89a9b3;
end;
function u1._x8b1e37aadfd94696(_) --[[ Line: 62 ]]
    -- upvalues: l__Classes__1 (copy)
    return l__Classes__1._xafc4950d7b094088._xef1fb561476b0a5b;
end;
function u1._x449065fc95251217(p12) --[[ Line: 66 ]]
    -- upvalues: u2 (ref)
    if not u2 then
        u2 = true;
        warn("CROSSHAIR UPDATE NOT SET FOR CROSSHAIR : " .. p12._x9f381b99fa9097bd);
    end;
end;
function u1._x8fcdafeb8ad3312d(p13) --[[ Line: 73 ]]
    warn("CROSSHAIR INIT NOT SET FOR CROSSHAIR : " .. p13._x9f381b99fa9097bd);
end;
function u1._x4209447529b7cd98(p14) --[[ Line: 77 ]]
    warn("CROSSHAIR CLEANUP NOT SET FOR CROSSHAIR :" .. p14._x9f381b99fa9097bd);
end;
function u1.cleanUp(p15) --[[ Line: 81 ]]
    if p15._x031a6113d489e09a then
        p15._x031a6113d489e09a:Destroy();
    end;
    warn("CROSSHAIR CLEANUP NOT SET FOR CROSSHAIR :" .. p15._x9f381b99fa9097bd);
end;
return u1;
