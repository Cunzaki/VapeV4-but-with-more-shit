-- Decompiled from: Start.Client.Classes._x056247e1c52af518
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__ModuleScripts__1 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__2 = require(l__ModuleScripts__1.Packets);
local l__Signal__3 = require(l__ModuleScripts__1.Signal);
local l__Trove__4 = require(l__ModuleScripts__1.Trove);
local u1 = {};
u1.__index = u1;
local l___xda063f22d78e107c__5 = require(script._xda063f22d78e107c);
local l__LocalPlayer__6 = game.Players.LocalPlayer;
function u1._x90d4581ac99dd483() --[[ Line: 27 ]]
    -- upvalues: u1 (copy), l__Trove__4 (copy), l__Signal__3 (copy)
    local v2 = setmetatable({}, u1);
    v2._x077d5790aa811112 = game:GetService("ReplicatedStorage").Assets.UIAssets.GuideScreen:Clone();
    v2._xbd519c918208ce0e = l__Trove__4.new();
    v2._x8e94c4511b15c408 = nil;
    v2._x6a5705bbb699ffec = nil;
    v2._xe96bee6d6f012fba = nil;
    v2._x92bef2730e767781 = nil;
    v2._x1ae80ca655e46207 = false;
    v2._xfc16ccde4c68bae2 = v2._xbd519c918208ce0e:Add(l__Signal__3.new());
    v2._x4945d774c820f528 = v2._xbd519c918208ce0e:Add(l__Signal__3.new());
    return v2;
end;
function u1._xc09d06934c0c6052(u3, p4, p5) --[[ Line: 44 ]]
    -- upvalues: l___xda063f22d78e107c__5 (copy), l__Packets__2 (copy)
    u3:_xd59f681bae654118();
    u3._x8e94c4511b15c408 = l___xda063f22d78e107c__5._x90d4581ac99dd483(u3._x077d5790aa811112, p4, p5);
    u3._x92bef2730e767781 = p4;
    u3._xe96bee6d6f012fba = p5;
    u3._x1ae80ca655e46207 = false;
    u3._x6a5705bbb699ffec = u3._x8e94c4511b15c408._xff9002777171394f:Connect(function(p6, p7) --[[ Line: 51 ]]
        -- upvalues: u3 (copy), l__Packets__2 (ref)
        if u3._x8e94c4511b15c408 == nil or u3._x1ae80ca655e46207 then
        else
            u3._x1ae80ca655e46207 = true;
            l__Packets__2._xeb5f1417d5dd7629:Fire({
                op = "continue",
                node_id = p6,
                token = p7
            });
        end;
    end);
    u3._xfc16ccde4c68bae2:Fire(p4, p5);
    return u3._x8e94c4511b15c408;
end;
function u1._xe53615d96cf36a6b(u8) --[[ Line: 70 ]]
    -- upvalues: l__LocalPlayer__6 (copy), l__Packets__2 (copy)
    u8._x077d5790aa811112.Parent = l__LocalPlayer__6.PlayerGui;
    local l___x077d5790aa811112__7 = u8._x077d5790aa811112;
    if l___x077d5790aa811112__7 then
        if l___x077d5790aa811112__7:IsA("ScreenGui") then
            l___x077d5790aa811112__7.Enabled = false;
        elseif l___x077d5790aa811112__7:IsA("GuiObject") then
            l___x077d5790aa811112__7.Visible = false;
        end;
    end;
    u8._xbd519c918208ce0e:Connect(l__Packets__2._xeb5f1417d5dd7629.OnClientEvent, function(p9) --[[ Line: 74 ]]
        -- upvalues: u8 (copy)
        u8:_x1972deab395cea88(p9);
    end);
end;
function u1._x1972deab395cea88(p10, p11) --[[ Line: 79 ]]
    if typeof(p11) == "table" and typeof(p11.op) == "string" then
        local l__op__8 = p11.op;
        if l__op__8 == "show" then
            p10:_xc09d06934c0c6052(p11.node_id, p11.token);
        else
            if l__op__8 == "end" then
                p10:_xd57a100c690e0a99(p11.reason);
            end;
        end;
    end;
end;
function u1._xd57a100c690e0a99(p12, p13) --[[ Line: 93 ]]
    p12:_xd59f681bae654118();
    local l___x077d5790aa811112__9 = p12._x077d5790aa811112;
    if l___x077d5790aa811112__9 then
        if l___x077d5790aa811112__9:IsA("ScreenGui") then
            l___x077d5790aa811112__9.Enabled = false;
        elseif l___x077d5790aa811112__9:IsA("GuiObject") then
            l___x077d5790aa811112__9.Visible = false;
        end;
    end;
    p12._x92bef2730e767781 = nil;
    p12._xe96bee6d6f012fba = nil;
    p12._x1ae80ca655e46207 = false;
    p12._x4945d774c820f528:Fire(p13);
end;
function u1._xd59f681bae654118(p14) --[[ Line: 103 ]]
    if p14._x6a5705bbb699ffec then
        p14._x6a5705bbb699ffec:Disconnect();
        p14._x6a5705bbb699ffec = nil;
    end;
    if p14._x8e94c4511b15c408 then
        p14._x8e94c4511b15c408:destroy();
        p14._x8e94c4511b15c408 = nil;
    end;
end;
function u1.destroy(p15) --[[ Line: 115 ]]
    p15:_xd59f681bae654118();
    p15._xbd519c918208ce0e:Destroy();
end;
return u1;
