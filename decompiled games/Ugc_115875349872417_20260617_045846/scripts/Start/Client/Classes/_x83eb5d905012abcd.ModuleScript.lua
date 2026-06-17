-- Decompiled from: Start.Client.Classes._x83eb5d905012abcd
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__UIAssets__4 = l__ReplicatedStorage__3.Assets.UIAssets;
local l__ModuleScripts__5 = l__ReplicatedStorage__3.Assets.ModuleScripts;
local l__Trove__6 = require(l__ModuleScripts__5.Trove);
local l__BuildInfo__7 = require(l__ModuleScripts__5.BuildInfo);
local u1 = {};
u1.__index = u1;
local l__Classes__8 = require(script.Parent.Parent.ClientRoot).Classes;
local l__LocalPlayer__9 = game.Players.LocalPlayer;
local l__main_version__10 = l__BuildInfo__7.main_version;
local l__sub_version__11 = l__BuildInfo__7.sub_version;
local l__build_version__12 = l__BuildInfo__7.build_version;
function u1._x83ed94bfb82a8c9f() --[[ Line: 60 ]]
    -- upvalues: u1 (copy), l__Trove__6 (copy)
    local v2 = setmetatable({}, u1);
    v2._xcd2ac73f2abf090f = Instance.new("ScreenGui");
    v2._xcd2ac73f2abf090f.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    v2._xcd2ac73f2abf090f.Name = "InfoDisplay";
    v2._xcd2ac73f2abf090f.ResetOnSpawn = false;
    v2._xcd2ac73f2abf090f.DisplayOrder = 0;
    v2._xcd2ac73f2abf090f.IgnoreGuiInset = true;
    v2._xcd2ac73f2abf090f.Enabled = true;
    v2._xcd2ac73f2abf090f.Parent = game.Players.LocalPlayer.PlayerGui;
    v2._x9fdde71fe1b4639d = l__Trove__6.new();
    v2._xf62c5e3df2bf73f7 = {};
    v2._xbd7f9228ae095405 = {};
    return v2;
end;
function u1._x80649b8dda339865(p3, p4, p5) --[[ Line: 80 ]]
    -- upvalues: l__UIAssets__4 (copy)
    local v6 = l__UIAssets__4.InfoLineLabel:Clone();
    v6.Text = p4;
    v6.LayoutOrder = p5 or 2;
    v6.Parent = p3._xc3fb0d3faa4f89a5.GameInfo;
    print(v6, p4);
    return v6;
end;
function u1._x21c448a0fbae3b71(p7, p8) --[[ Line: 91 ]]
    local v9 = p7._xf62c5e3df2bf73f7[p8];
    if v9 then
        v9:Destroy();
        p7._xf62c5e3df2bf73f7[p8] = nil;
    end;
    local v10 = p7._xbd7f9228ae095405[p8];
    if v10 then
        v10:Destroy();
        p7._xbd7f9228ae095405[p8] = nil;
    end;
end;
function u1._xa86ff06ab0d0395e(p11, p12) --[[ Line: 105 ]]
    local v13 = {};
    for _, v14 in p12:GetChildren() do
        if v14:IsA("NumberValue") and v14.Value > 0 then
            table.insert(v13, v14);
        end;
    end;
    table.sort(v13, function(p15, p16) --[[ Line: 113 ]]
        local v17 = p15:GetAttribute("reason");
        if typeof(v17) ~= "string" or v17 == "" then
            v17 = p15.Name;
        end;
        local v18 = string.upper(v17);
        local v19 = p16:GetAttribute("reason");
        if typeof(v19) ~= "string" or v19 == "" then
            v19 = p16.Name;
        end;
        return v18 < string.upper(v19);
    end);
    local v20 = {};
    for v21, v22 in v13 do
        v20[v22] = true;
        local v23 = p11._xf62c5e3df2bf73f7[v22];
        if not v23 then
            v23 = p11:_x80649b8dda339865("", 3);
            p11._xf62c5e3df2bf73f7[v22] = v23;
        end;
        local v24 = "<b>+";
        local l__Value__13 = v22.Value;
        local v25;
        if l__Value__13 % 1 == 0 then
            v25 = tostring(l__Value__13);
        else
            v25 = string.format("%.1f", l__Value__13):gsub("%.?0+$", "");
        end;
        local v26 = "% YEN FROM ";
        local v27 = v22:GetAttribute("reason");
        if typeof(v27) ~= "string" or v27 == "" then
            v27 = v22.Name;
        end;
        v23.Text = v24 .. v25 .. v26 .. string.upper(v27) .. "!</b>";
        v23.LayoutOrder = 3 + v21;
    end;
    local v28 = {};
    for v29 in p11._xf62c5e3df2bf73f7 do
        if not v20[v29] then
            table.insert(v28, v29);
        end;
    end;
    for _, v30 in v28 do
        p11:_x21c448a0fbae3b71(v30);
    end;
end;
function u1._x4556faa331240a63(u31, u32, p33) --[[ Line: 143 ]]
    -- upvalues: l__Trove__6 (copy)
    if p33:IsA("NumberValue") and not u31._xbd7f9228ae095405[p33] then
        local v34 = l__Trove__6.new();
        u31._xbd7f9228ae095405[p33] = v34;
        v34:Connect(p33.Changed, function() --[[ Line: 150 ]]
            -- upvalues: u31 (copy), u32 (copy)
            u31:_xa86ff06ab0d0395e(u32);
        end);
        v34:Connect(p33:GetAttributeChangedSignal("reason"), function() --[[ Line: 153 ]]
            -- upvalues: u31 (copy), u32 (copy)
            u31:_xa86ff06ab0d0395e(u32);
        end);
    end;
end;
function u1._x356beef63393eac0(u35) --[[ Line: 158 ]]
    -- upvalues: l__ReplicatedStorage__3 (copy), l__LocalPlayer__9 (copy)
    local function u40(u36) --[[ Line: 159 ]]
        -- upvalues: u35 (copy)
        if u35._x38594ab55dddaad8 == u36 then
        else
            u35._x38594ab55dddaad8 = u36;
            for _, v37 in u36:GetChildren() do
                u35:_x4556faa331240a63(u36, v37);
            end;
            u35:_xa86ff06ab0d0395e(u36);
            u35._x9fdde71fe1b4639d:Connect(u36.ChildAdded, function(p38) --[[ Line: 172 ]]
                -- upvalues: u35 (ref), u36 (copy)
                u35:_x4556faa331240a63(u36, p38);
                u35:_xa86ff06ab0d0395e(u36);
            end);
            u35._x9fdde71fe1b4639d:Connect(u36.ChildRemoved, function(p39) --[[ Line: 177 ]]
                -- upvalues: u35 (ref), u36 (copy)
                u35:_x21c448a0fbae3b71(p39);
                u35:_xa86ff06ab0d0395e(u36);
            end);
        end;
    end;
    local l__Players__14 = l__ReplicatedStorage__3.ReadOnly.Players;
    local v41 = l__Players__14:FindFirstChild((tostring(l__LocalPlayer__9.UserId)));
    if v41 then
        local v42 = v41:FindFirstChild("yen_bonuses");
        if v42 then
            u40(v42);
        else
            u35._x9fdde71fe1b4639d:Connect(v41.ChildAdded, function(p43) --[[ Line: 190 ]]
                -- upvalues: u40 (copy)
                if p43.Name == "yen_bonuses" then
                    u40(p43);
                end;
            end);
        end;
    else
        u35._x9fdde71fe1b4639d:Connect(l__Players__14.ChildAdded, function(p44) --[[ Line: 204 ]]
            -- upvalues: l__LocalPlayer__9 (ref), u40 (copy), u35 (copy)
            if p44.Name == tostring(l__LocalPlayer__9.UserId) then
                local v45 = p44:FindFirstChild("yen_bonuses");
                if v45 then
                    u40(v45);
                    return;
                end;
                u35._x9fdde71fe1b4639d:Connect(p44.ChildAdded, function(p46) --[[ Line: 190 ]]
                    -- upvalues: u40 (ref)
                    if p46.Name == "yen_bonuses" then
                        u40(p46);
                    end;
                end);
            end;
        end);
    end;
end;
function u1._x44bcd6af41218f92(u47) --[[ Line: 211 ]]
    -- upvalues: l__UIAssets__4 (copy), l__RunService__1 (copy), l__ReplicatedStorage__3 (copy), l__main_version__10 (copy), l__sub_version__11 (copy), l__build_version__12 (copy), l__LocalPlayer__9 (copy), l__Classes__8 (copy), l__TweenService__2 (copy)
    u47._xc3fb0d3faa4f89a5 = l__UIAssets__4.InfoFrame:Clone();
    u47._xc3fb0d3faa4f89a5.Parent = u47._xcd2ac73f2abf090f;
    u47:_x356beef63393eac0();
    if not l__RunService__1:IsStudio() then
        local l__ServerRegion__15 = l__ReplicatedStorage__3.ReadOnly.ServerRegion;
        l__ServerRegion__15.Changed:Connect(function() --[[ Name: updRegion, Line 219 ]]
            -- upvalues: u47 (copy), l__ServerRegion__15 (copy)
            u47._xc3fb0d3faa4f89a5.GameInfo.Region.Text = "SERVER_REGION : " .. l__ServerRegion__15.Value;
        end);
        u47._xc3fb0d3faa4f89a5.GameInfo.Region.Text = "SERVER_REGION : " .. l__ServerRegion__15.Value;
    end;
    u47._xc3fb0d3faa4f89a5.GameInfo.Game.Text = "REDLINER" .. " " .. "[ALPHA]" .. " v." .. l__main_version__10 .. "." .. l__sub_version__11 .. "." .. l__build_version__12;
    u47._xc3fb0d3faa4f89a5.GameInfo.UUID.Text = "USER : " .. l__LocalPlayer__9.Name .. " (" .. l__LocalPlayer__9.UserId .. ")";
    local l__TotalSeconds__16 = l__ReplicatedStorage__3:WaitForChild("ReadOnly"):WaitForChild("TotalSeconds");
    task.spawn(function() --[[ Line: 232 ]]
        -- upvalues: u47 (copy), l__Classes__8 (ref), l__TotalSeconds__16 (copy)
        while true do
            u47._xc3fb0d3faa4f89a5.GameInfo.Time.Text = "SERVER_UPTIME : " .. l__Classes__8.Util:formatTime(l__TotalSeconds__16.Value, true);
            task.wait(0.1);
        end;
    end);
    l__Classes__8._x8399b2bb73e12808:_x9ccd957f12430c82("pingChanged"):Connect(function(p48) --[[ Line: 239 ]]
        -- upvalues: u47 (copy)
        u47._xc3fb0d3faa4f89a5.GameInfo.Ping.Text = "PING : " .. p48 .. "ms";
        if p48 > 130 then
            u47._xc3fb0d3faa4f89a5.GameInfo.Ping.TextColor3 = Color3.fromRGB(255, 211, 0);
        elseif p48 > 190 then
            u47._xc3fb0d3faa4f89a5.GameInfo.Ping.TextColor3 = Color3.fromRGB(255, 0, 0);
        else
            u47._xc3fb0d3faa4f89a5.GameInfo.Ping.TextColor3 = Color3.fromRGB(255, 255, 255);
        end;
    end);
    local l__MusicTitle__17 = u47._xc3fb0d3faa4f89a5.Music.MusicTitle;
    l__MusicTitle__17.Position = UDim2.fromScale(-1, 0);
    local u49 = nil;
    l__RunService__1.Heartbeat:Connect(function() --[[ Line: 256 ]]
        -- upvalues: l__Classes__8 (ref), l__MusicTitle__17 (copy), u49 (ref), l__TweenService__2 (ref)
        if l__Classes__8._x3019cc5b1f776551 and l__Classes__8._x3019cc5b1f776551._x8f6e292d73153338 then
            l__MusicTitle__17.Text = l__Classes__8._x3019cc5b1f776551._x8f6e292d73153338:GetAttribute("Title");
            if u49 then
            else
                u49 = l__TweenService__2:Create(l__MusicTitle__17, TweenInfo.new(20, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(1, 0.5)
                });
                u49:Play();
                u49.Completed:Once(function() --[[ Line: 271 ]]
                    -- upvalues: l__MusicTitle__17 (ref), u49 (ref)
                    l__MusicTitle__17.Position = UDim2.fromScale(-1, 0.5);
                    u49 = nil;
                end);
            end;
        end;
    end);
end;
return u1;
