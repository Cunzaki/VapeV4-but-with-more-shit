-- Decompiled with Potassium's decompiler.

game:GetService("ContentProvider");
game:GetService("DataStoreService");
game:GetService("Debris");
game:GetService("InsertService");
game:GetService("Lighting");
game:GetService("MarketplaceService");
local l__Players__1 = game:GetService("Players");
game:GetService("ReplicatedFirst");
game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
game:GetService("ServerScriptService");
game:GetService("ServerStorage");
local l__Heartbeat__3 = l__RunService__2.Heartbeat;
game:GetService("Teams");
game:GetService("TeleportService");
game:GetService("UserInputService");
local _ = BrickColor.new;
local l__new__4 = Color3.new;
local _ = CFrame.new;
local _ = CFrame.Angles;
local l__new__5 = UDim2.new;
local l__new__6 = Vector2.new;
local l__new__7 = Vector3.new;
local l__new__8 = Instance.new;
local _ = math.abs;
local _ = math.ceil;
local _ = math.deg;
local _ = math.floor;
local _ = math.max;
local _ = math.min;
local l__cos__9 = math.cos;
local _ = math.rad;
local l__sin__10 = math.sin;
local _ = math.random;
local l__create__11 = coroutine.create;
local l__resume__12 = coroutine.resume;
local u1 = {};
local u42 = {
    Linear = function(p2, p3, p4, p5) --[[ Name: Linear, Line 87 ]]
        return p3 + p4 * (p2 / p5);
    end,
    SineIn = function(p6, p7, p8, p9) --[[ Name: SineIn, Line 88 ]]
        -- upvalues: l__cos__9 (copy)
        return -p8 * l__cos__9(p6 / p9 * 1.5707963267948966) + p8 + p7;
    end,
    SineOut = function(p10, p11, p12, p13) --[[ Name: SineOut, Line 89 ]]
        -- upvalues: l__sin__10 (copy)
        return p12 * l__sin__10(p10 / p13 * 1.5707963267948966) + p11;
    end,
    QuadIn = function(p14, p15, p16, p17) --[[ Name: QuadIn, Line 90 ]]
        local v18 = p14 / p17;
        return p16 * v18 * v18 + p15;
    end,
    QuadOut = function(p19, p20, p21, p22) --[[ Name: QuadOut, Line 91 ]]
        local v23 = p19 / p22;
        return -p21 * v23 * (v23 - 2) + p20;
    end,
    BackIn = function(p24, p25, p26, p27) --[[ Name: BackIn, Line 92 ]]
        local v28 = p24 / p27;
        return p26 * v28 * v28 * (2.70158 * v28 - 1.70158) + p25;
    end,
    BackOut = function(p29, p30, p31, p32) --[[ Name: BackOut, Line 93 ]]
        local v33 = p29 / p32 - 1;
        return p31 * (v33 * v33 * (2.70158 * v33 + 1.70158) + 1) + p30;
    end,
    BounceOut = function(p34, p35, p36, p37) --[[ Name: BounceOut, Line 94 ]]
        local v38 = p34 / p37;
        if v38 < 0.36363636363636365 then
            return p36 * (7.5625 * v38 * v38) + p35;
        elseif v38 < 0.7272727272727273 then
            local v39 = v38 - 0.5454545454545454;
            return p36 * (7.5625 * v39 * v39 + 0.75) + p35;
        elseif v38 < 0.9090909090909091 then
            local v40 = v38 - 0.8181818181818182;
            return p36 * (7.5625 * v40 * v40 + 0.9375) + p35;
        else
            local v41 = v38 - 0.9545454545454546;
            return p36 * (7.5625 * v41 * v41 + 0.984375) + p35;
        end;
    end
};
function u42.BounceIn(p43, p44, p45, p46) --[[ Line: 101 ]]
    -- upvalues: u42 (copy)
    return p45 - u42.BounceOut(p46 - p43, 0, p45, p46) + p44;
end;
local function u61(p47, p48, p49, p50) --[[ Line: 102 ]]
    -- upvalues: u1 (copy), u42 (copy), l__Heartbeat__3 (copy)
    u1[p47] = u1[p47] or {};
    local v51 = u1[p47];
    local v52 = u42[p50] or u42.Linear;
    local v53, _ = tick();
    for v54, v55 in next, p48 do
        p48[v54] = { v55, p47[v54], v55 - p47[v54] };
        v51[v54] = v53;
    end;
    while true do
        l__Heartbeat__3:wait();
        local v56 = tick() - v53;
        for v57, v58 in next, p48 do
            if v51[v57] == v53 then
                p47[v57] = v52(v56, v58[2], v58[3], p49);
            end;
        end;
        if p49 < v56 then
            for v59, v60 in next, p48 do
                if v51[v59] == v53 then
                    p47[v59] = v60[1];
                    v51[v59] = nil;
                end;
            end;
            return;
        end;
    end;
end;
local function u63(p62, ...) --[[ Line: 130 ]]
    -- upvalues: l__resume__12 (copy), l__create__11 (copy)
    return l__resume__12(l__create__11(p62), ...);
end;
local l__TextService__13 = game:GetService("TextService");
local l__LocalPlayer__14 = game.Players.LocalPlayer;
local function u71(p64, p65, p66) --[[ Line: 135 ]]
    -- upvalues: u63 (copy), u61 (copy), u71 (copy)
    if p64:IsA("TextLabel") or p64:IsA("TextButton") then
        u63(u61, p64, {
            BackgroundTransparency = 1,
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }, p65);
    elseif p64:IsA("ImageLabel") or p64:IsA("ImageButton") then
        u63(u61, p64, {
            BackgroundTransparency = 1,
            ImageTransparency = 1
        }, p65);
    elseif p64:IsA("Frame") or p64:IsA("ScrollingFrame") then
        u63(u61, p64, {
            BackgroundTransparency = 1
        }, p65);
    end;
    local v67 = next;
    local v68, v69 = p64:GetChildren();
    for _, v70 in v67, v68, v69 do
        u71(v70, p65);
    end;
    if p66 then
        wait(p65);
        if p64 then
            p64:Destroy();
        end;
    end;
end;
local function u84(p72, p73) --[[ Line: 156 ]]
    -- upvalues: l__LocalPlayer__14 (copy), l__Players__1 (copy), l__new__5 (copy), l__new__7 (copy)
    if p72 and p72.Adornee then
        local l__magnitude__15 = (p73 - p72.Adornee.Position).magnitude;
        if l__magnitude__15 < 65 then
            local v74 = l__LocalPlayer__14 == l__Players__1:GetPlayerFromCharacter(p72.Adornee.Parent);
            p72.Enabled = true;
            p72.Size = l__new__5(0, 300, 0, 600);
            p72.StudsOffset = l__new__7(0, v74 and 1.5 or 2.5, v74 and 2 or 0);
            local v75 = next;
            local v76, v77 = p72:children();
            for _, v78 in v75, v76, v77 do
                v78.Visible = v78.Name ~= "Small";
            end;
            return;
        end;
        if l__magnitude__15 < 100 and #p72:GetChildren() > 1 then
            local v79 = l__LocalPlayer__14 == l__Players__1:GetPlayerFromCharacter(p72.Adornee.Parent);
            p72.Enabled = true;
            p72.Size = l__new__5(4, 0, 3, 0);
            p72.StudsOffset = l__new__7(0, v79 and 2 or 3, v79 and 2 or 0);
            local v80 = next;
            local v81, v82 = p72:children();
            for _, v83 in v80, v81, v82 do
                v83.Visible = v83.Name == "Small";
            end;
            return;
        end;
        p72.Enabled = false;
    end;
end;
local u85 = {};
local u86 = Rect.new(3, 3, 4, 4);
function _G.ChatBubble(p87, p88, p89) --[[ Line: 186 ]]
    -- upvalues: l__Players__1 (copy), l__LocalPlayer__14 (copy), u85 (copy), l__new__8 (copy), l__new__7 (copy), l__new__5 (copy), u86 (copy), u84 (copy), l__new__4 (copy), l__TextService__13 (copy), l__new__6 (copy), u71 (copy)
    if p87 and #p88:gsub("%s", "") > 0 then
        local u90 = l__Players__1:GetPlayerFromCharacter(p87.Parent);
        local v91 = u90 == l__LocalPlayer__14;
        local u92 = u85[u90 or p87.Parent];
        local l__p__16 = workspace.CurrentCamera.CoordinateFrame.p;
        if not u92 then
            local l__CurrentCamera__17 = workspace.CurrentCamera;
            local u93 = "BillboardGui";
            local u94 = "Chat Bubble";
            u92 = (function(p95, _) --[[ Line: 49 ]]
                -- upvalues: l__new__8 (ref), u93 (copy), l__CurrentCamera__17 (copy), u94 (copy)
                local v96 = l__new__8(u93);
                for v97, v98 in next, p95 do
                    if tonumber(v97) then
                        v98.Parent = v96;
                    else
                        v96[v97] = v98;
                    end;
                end;
                local v99 = v96.Parent or l__CurrentCamera__17;
                local v100 = u94 or v96.Name;
                v96.Parent = v99;
                v96.Name = v100;
                return v96;
            end)({
                Adornee = p87,
                StudsOffset = l__new__7(0, v91 and 1.5 or 2.5, v91 and 2 or 0),
                Size = l__new__5(0, 300, 0, 600)
            });
            local u101 = u92;
            local u102 = "ImageLabel";
            local u103 = "Small";
            local function v110(p104, _) --[[ Line: 49 ]]
                -- upvalues: l__new__8 (ref), u102 (copy), u101 (copy), u103 (copy)
                local v105 = l__new__8(u102);
                for v106, v107 in next, p104 do
                    if tonumber(v106) then
                        v107.Parent = v105;
                    else
                        v105[v106] = v107;
                    end;
                end;
                local v108 = v105.Parent or u101;
                local v109 = u103 or v105.Name;
                v105.Parent = v108;
                v105.Name = v109;
                return v105;
            end;
            local v111 = {
                Visible = false,
                BackgroundTransparency = 1,
                Size = l__new__5(1, 0, 1, 0),
                Position = l__new__5(0, 0, 1, -40),
                Image = "rbxassetid://526696244",
                SliceCenter = u86,
                ScaleType = "Slice",
                ImageTransparency = 0.2,
                ZIndex = 9
            };
            local u112 = "TextLabel";
            local u113 = nil;
            local u114 = nil;
            v111[1] = (function(p115, _) --[[ Line: 49 ]]
    -- upvalues: l__new__8 (ref), u112 (copy), u113 (copy), u114 (copy)
    local v116 = l__new__8(u112);
    for v117, v118 in next, p115 do
        if tonumber(v117) then
            v118.Parent = v116;
        else
            v116[v117] = v118;
        end;
    end;
    local v119 = v116.Parent or u113;
    local v120 = u114 or v116.Name;
    v116.Parent = v119;
    v116.Name = v120;
    return v116;
end)({
    BackgroundTransparency = 1,
    Font = "SourceSansBold",
    TextSize = 24,
    TextStrokeTransparency = 0.9,
    ZIndex = 10,
    Text = "...",
    TextScaled = true,
    Size = l__new__5(1, -16, 1, 0),
    Position = l__new__5(0, 8, 0, 0)
});
            v110(v111);
            u85[u90 or p87.Parent] = u92;
            table.insert(u85, u92);
            if u90 then
                u90.Changed:connect(function() --[[ Line: 223 ]]
                    -- upvalues: u90 (copy), l__Players__1 (ref), u92 (ref)
                    if not u90 or u90.Parent ~= l__Players__1 then
                        u92:Destroy();
                    end;
                end);
                u90.CharacterAdded:connect(function(p121) --[[ Line: 228 ]]
                    -- upvalues: u92 (ref)
                    u92.Adornee = p121:FindFirstChild("Head") or p121:WaitForChild("Head");
                end);
            end;
        end;
        u84(u92, l__p__16);
        local v122 = p89 or l__new__4(1, 1, 1);
        local v123 = p88 == p88:upper() and "SourceSansBold" or "SourceSans";
        local v124 = l__new__4(1 - v122.r * 0.875, 1 - v122.g * 0.875, 1 - v122.b * 0.875);
        if #p88 > 125 then
            p88 = p88:sub(1, 125) .. "...";
        end;
        local v125 = l__TextService__13:GetTextSize(p88, 24, v123, l__new__6(292, 120));
        local u126 = "ImageLabel";
        local u127 = "Bubble";
        local function v134(p128, _) --[[ Line: 49 ]]
            -- upvalues: l__new__8 (ref), u126 (copy), u92 (copy), u127 (copy)
            local v129 = l__new__8(u126);
            for v130, v131 in next, p128 do
                if tonumber(v130) then
                    v131.Parent = v129;
                else
                    v129[v130] = v131;
                end;
            end;
            local v132 = v129.Parent or u92;
            local v133 = u127 or v129.Name;
            v129.Parent = v132;
            v129.Name = v133;
            return v129;
        end;
        local v135 = {
            AnchorPoint = l__new__6(0, 1),
            BackgroundTransparency = 1,
            Position = l__new__5(0.5, -(v125.x + 16) / 2, 0.5, 0),
            Size = l__new__5(0, v125.x + 16, 0, v125.y + 8),
            Image = "rbxassetid://526696244",
            SliceCenter = u86,
            ScaleType = "Slice",
            ImageColor3 = v122,
            ImageTransparency = 0.2,
            ZIndex = 9
        };
        local u136 = "TextLabel";
        local u137 = nil;
        local u138 = nil;
        v135[1] = (function(p139, _) --[[ Line: 49 ]]
    -- upvalues: l__new__8 (ref), u136 (copy), u137 (copy), u138 (copy)
    local v140 = l__new__8(u136);
    for v141, v142 in next, p139 do
        if tonumber(v141) then
            v142.Parent = v140;
        else
            v140[v141] = v142;
        end;
    end;
    local v143 = v140.Parent or u137;
    local v144 = u138 or v140.Name;
    v140.Parent = v143;
    v140.Name = v144;
    return v140;
end)({
    BackgroundTransparency = 1,
    TextSize = 24,
    TextStrokeTransparency = 0.9,
    ZIndex = 10,
    TextWrapped = true,
    Font = v123,
    TextColor3 = v124,
    TextStrokeColor3 = v124,
    Size = l__new__5(1, -16, 1, 0),
    Position = l__new__5(0, 8, 0, 0),
    Text = p88
});
        local u145 = v134(v135);
        delay(v91 and 8 or 15, function() --[[ Line: 266 ]]
            -- upvalues: u71 (ref), u145 (copy), u92 (ref)
            u71(u145, 0.5, true);
            if #u92:GetChildren() < 2 then
                u92.Enabled = false;
            end;
        end);
        local v146 = u92:GetChildren();
        local v147 = v125.y + 12;
        for _, v148 in next, v146 do
            if v148.Name ~= "Small" and v148 ~= u145 then
                v148:TweenPosition(v148.Position - l__new__5(0, 0, 0, v147), "Out", "Quad", 0.2, true);
            end;
        end;
        if #v146 > 3 then
            u71(v146[#v146 - 2], 0.5, true);
        end;
    end;
end;
local u149 = nil;
if workspace.CurrentCamera then
    u149 = workspace.CurrentCamera.Changed:connect(function(p150) --[[ Line: 288 ]]
        -- upvalues: u85 (copy), u84 (copy)
        if p150 == "CoordinateFrame" then
            local l__p__18 = workspace.CurrentCamera.CoordinateFrame.p;
            for v151, v152 in next, u85 do
                if v152 and v152.Parent then
                    u84(v152, l__p__18);
                else
                    u85[v151] = nil;
                    if v152 then
                        v152:Destroy();
                    end;
                end;
            end;
        end;
    end);
end;
workspace.Changed:connect(function(p153) --[[ Line: 306 ]]
    -- upvalues: u149 (ref), u85 (copy), u84 (copy)
    if p153 == "CurrentCamera" then
        if u149 then
            u149:disconnect();
        end;
        if workspace.CurrentCamera then
            u149 = workspace.CurrentCamera.Changed:connect(function(p154) --[[ Line: 288 ]]
                -- upvalues: u85 (ref), u84 (ref)
                if p154 == "CoordinateFrame" then
                    local l__p__19 = workspace.CurrentCamera.CoordinateFrame.p;
                    for v155, v156 in next, u85 do
                        if v156 and v156.Parent then
                            u84(v156, l__p__19);
                        else
                            u85[v155] = nil;
                            if v156 then
                                v156:Destroy();
                            end;
                        end;
                    end;
                end;
            end);
        end;
    end;
end);