-- Decompiled with Potassium's decompiler.

task.wait();
local v1 = script;
local v2 = script;
v1.Parent = nil;
v2.Name = "";
for _ = 1, 9 do
    script.Name = script.Name .. string.char(math.random(255));
end;
local function u10(u3, u4, p5, _, _) --[[ Line: 22 ]]
    -- upvalues: u10 (ref)
    local v6, v7 = pcall(function() --[[ Line: 23 ]]
        -- upvalues: u3 (copy), u4 (copy)
        return u3[u4];
    end);
    if v6 then
        return v7;
    end;
    if p5 then
        for _, v8 in u3:GetChildren() do
            local v9 = u10(v8, u4, true);
            if v9 then
                return v9;
            end;
        end;
    end;
    return nil;
end;
local function u14(p11, p12, _) --[[ Line: 39 ]]
    -- upvalues: u10 (ref)
    local v13;
    repeat
        v13 = u10(p11, p12);
        task.wait();
    until v13;
    return v13;
end;
local u15 = {
    Teams = game:GetService("Teams"),
    Debris = game:GetService("Debris"),
    Content = game:GetService("ContentProvider"),
    Market = game:GetService("MarketplaceService"),
    UIS = game:GetService("UserInputService"),
    TP = game:GetService("TeleportService"),
    Collection = game:GetService("CollectionService"),
    Players = game:GetService("Players"),
    Lighting = game:GetService("Lighting"),
    Badge = game:GetService("BadgeService"),
    Run = game:GetService("RunService"),
    RStorage = game:GetService("ReplicatedStorage"),
    Insert = game:GetService("InsertService"),
    SS = game:GetService("SoundService"),
    HTTP = game:GetService("HttpService"),
    StarterGui = game:GetService("StarterGui"),
    StarterPack = game:GetService("StarterPack"),
    StarterPlayer = game:GetService("StarterPlayer")
};
local l__LocalPlayer__1 = game.Players.LocalPlayer;
local _ = {
    ColorTransparency = 0.8,
    AdminCredit = true,
    AutoCleanDelay = 30,
    CommandBar = true,
    FunCommands = true,
    Prefix = ":",
    Color = Color3.new(),
    GroupAdmin = {},
    VIPAdmin = {}
};
local u16 = u10;
local u17 = "ImageTransparency";
local u18 = "TextTransparency";
local u19 = "TextStrokeTransparency";
local u20 = "BackgroundTransparency";
local u21 = "UserInputType";
local u22 = "AbsolutePosition";
local u23 = "AbsoluteSize";
local u24 = {};
local function u28(p25, ...) --[[ Line: 46 ]]
    local v26, v27 = coroutine.resume(coroutine.create(p25), ...);
    if not v26 then
        warn((`Kohl's Admin Infinite Error: {v27} \n {debug.traceback()}`));
    end;
    return v26, v27;
end;
local u29 = {};
local u30 = {};
local u31 = {};
local u32 = {};
local u33 = {};
local u34 = {};
for _, v35 in {
    313101943,
    305266753,
    305291549,
    305807605,
    305807572,
    305807549,
    313321271,
    306774746
} do
    u15.Content:Preload("rbxassetid://" .. v35);
end;
local v36 = script:WaitForChild("Templates"):Clone();
repeat
    task.wait();
until l__LocalPlayer__1:GetMouse() and (workspace.CurrentCamera and (u16(l__LocalPlayer__1, "PlayerGui") and u16(l__LocalPlayer__1, "KDonor")));
local l__CurrentCamera__2 = workspace.CurrentCamera;
local u37 = l__LocalPlayer__1:GetMouse();
local l__Character__3 = l__LocalPlayer__1.Character;
local l__PlayerGui__4 = l__LocalPlayer__1.PlayerGui;
local l__KDonor__5 = l__LocalPlayer__1.KDonor;
local u38 = u14(u15.RStorage, "b\7\n\7\n\7");
local _ = u15.Run.RenderStepped;
local u39 = {
    uID = "",
    s = script,
    template = require(v36)
};
local u40 = u16(u38, "\7dmi\n");
local u41 = u16(u38, "\8\7\n");
local u42 = u16(u38, "log");
local u43 = u16(u38, "clog");
function u39.unMapTab(p44, _) --[[ Line: 123 ]]
    -- upvalues: u39 (copy)
    local v45 = {};
    for v46, v47 in p44 do
        if type(v47) == "table" then
            v45[tostring(v46)] = u39.unMapTab(v47);
        else
            v45[tonumber(v46)] = v47;
        end;
    end;
    return v45;
end;
function u39.AssetInfo(p48) --[[ Line: 134 ]]
    -- upvalues: u15 (copy)
    return u15.Market:GetProductInfo(p48);
end;
function u39.RImage(p49, _, _) --[[ Line: 137 ]]
    -- upvalues: u39 (copy)
    local v50 = u39.AssetInfo(p49);
    if v50.AssetTypeId == 1 then
        return p49;
    end;
    local l__Id__6 = v50.Creator.Id;
    local v51 = p49;
    repeat
        p49 = p49 - 1;
    until u39.AssetInfo(v51).Creator.Id == l__Id__6 or v51 - p49 > 10;
    return p49;
end;
function u39.unCache(p52, _, _, _) --[[ Line: 148 ]]
    local v53 = {};
    for v54 in p52:gmatch("%S+") do
        local v55, v56 = v54:match("(.+):(.+)");
        v53[tonumber(v55)] = tonumber(v56);
    end;
    return v53;
end;
function u39.Merge(p57, p58) --[[ Line: 156 ]]
    for v59, v60 in p58 do
        p57[v59] = v60;
    end;
    return p57;
end;
function u39.UpdateAdmins() --[[ Line: 162 ]]
    -- upvalues: u30 (ref), u39 (copy), u40 (ref)
    u30 = u39.unCache(u40.Value);
end;
function u39.Stroke(p61) --[[ Line: 165 ]]
    return math.max(p61.r, p61.g) > 0.5 and Color3.new() or Color3.new(1, 1, 1);
end;
function u39.Hide(p62, p63, p64, p65) --[[ Line: 168 ]]
    -- upvalues: u17 (ref), u18 (ref), u19 (ref), u20 (ref), u16 (ref)
    local v66 = p64 or 0.2;
    if not p65 then
        local u67 = {};
        local function u72(p68, _) --[[ Line: 173 ]]
            -- upvalues: u17 (ref), u18 (ref), u19 (ref), u20 (ref), u16 (ref), u67 (ref), u72 (ref)
            local v69 = {};
            for _, v70 in {
                u17,
                u18,
                u19,
                u20
            } do
                if u16(p68, v70) and p68[v70] ~= 1 then
                    v69[v70] = { p68[v70], 1 - p68[v70] };
                end;
            end;
            u67[#u67 + 1] = { p68, v69 };
            for _, v71 in p68:GetChildren() do
                u72(v71);
            end;
        end;
        u72(p62);
        p62.Visible = true;
        p65 = u67;
    end;
    if v66 == 0 then
        p62.Visible = false;
        if p63 then
            p62:Destroy();
        else
            for _, v82 in p65 do
                for v83, v84 in v82[2] do
                    v82[1][v83] = v84[1];
                end;
            end;
        end;
    else
        local v76 = tick();
        local v77 = 1 / v66;
        while true do
            local v78 = (tick() - v76) * v77;
            for _, v79 in p65 do
                for v80, v81 in v79[2] do
                    v79[1][v80] = v81[1] + v81[2] * v78;
                end;
            end;
            task.wait();
            if v78 >= 1 then
                p62.Visible = false;
                if p63 then
                    p62:Destroy();
                else
                    for _, v82 in p65 do
                        for v83, v84 in v82[2] do
                            v82[1][v83] = v84[1];
                        end;
                    end;
                end;
                return;
            end;
        end;
    end;
end;
function u39.Show(p85, p86, p87) --[[ Line: 212 ]]
    -- upvalues: u17 (ref), u18 (ref), u19 (ref), u20 (ref), u16 (ref)
    local v88 = p86 or 0.2;
    if not p87 then
        local u89 = {};
        local function u94(p90, _) --[[ Line: 217 ]]
            -- upvalues: u17 (ref), u18 (ref), u19 (ref), u20 (ref), u16 (ref), u89 (ref), u94 (ref)
            local v91 = {};
            for _, v92 in {
                u17,
                u18,
                u19,
                u20
            } do
                if u16(p90, v92) and p90[v92] ~= 1 then
                    v91[v92] = { p90[v92], 1 - p90[v92] };
                    p90[v92] = 1;
                end;
            end;
            u89[#u89 + 1] = { p90, v91 };
            for _, v93 in p90:GetChildren() do
                u94(v93);
            end;
        end;
        u94(p85);
        p85.Visible = true;
        p87 = u89;
    end;
    if v88 == 0 then
        for v105, v106 in p87 do
            for v107, v108 in v106[2] do
                v106[1][v107] = v108[1];
            end;
        end;
    else
        local v99 = tick();
        local v100 = 1 / v88;
        while true do
            local v101 = 1 - (tick() - v99) * v100;
            for _, v102 in p87 do
                for v103, v104 in v102[2] do
                    v102[1][v103] = v104[1] + v104[2] * v101;
                end;
            end;
            task.wait();
            if v101 <= 0 then
                for v105, v106 in p87 do
                    for v107, v108 in v106[2] do
                        v106[1][v107] = v108[1];
                    end;
                end;
                return;
            end;
        end;
    end;
end;
function u39.Drag(u109, u110, u111, u112, _, u113, u114) --[[ Line: 252 ]]
    -- upvalues: u21 (ref), u22 (ref), u37 (ref), u15 (copy), u23 (ref)
    local l__Parent__7 = u109.Parent;
    u109.InputBegan:connect(function(p115) --[[ Line: 254 ]]
        -- upvalues: u21 (ref), u109 (copy), u22 (ref), u37 (ref), u112 (ref), u114 (ref), u15 (ref), l__Parent__7 (ref), u113 (ref), u110 (copy), u111 (copy), u23 (ref)
        if p115[u21] == Enum[u21].MouseButton1 or p115[u21] == Enum[u21].Touch then
            local v116 = Vector2.new(u109[u22].X - u37.X, u109[u22].Y - (u37.Y - 36));
            u112 = v116;
            u114 = u15.UIS.InputEnded:connect(function(p117) --[[ Line: 258 ]]
                -- upvalues: u21 (ref), u112 (ref)
                if p117[u21] == Enum[u21].MouseButton1 or p117[u21] == Enum[u21].Touch then
                    u112 = nil;
                end;
            end);
            while u112 == v116 and (u109 and u109.Parent == l__Parent__7) do
                u113 = u110 and (u111 and Vector2.new(u110, u111)) or Vector2.new(u109[u23].X, u109[u23].Y);
                local v118 = u109;
                local l__new__8 = UDim2.new;
                local v119 = math.min(u37.ViewSizeX - u113.x, u37.X + u112.x);
                local v120 = math.max(0, v119);
                local v121 = math.min(u37.ViewSizeY - u113.y, u37.Y + u112.y);
                v118.Position = l__new__8(0, v120, 0, (math.max(0, v121)));
                task.wait();
            end;
            u114:disconnect();
        end;
    end);
end;
function u39.Resize(u122, u123, u124, _, _, u125, u126) --[[ Line: 277 ]]
    -- upvalues: u39 (copy), u21 (ref), u37 (ref), u15 (copy)
    local l__Parent__9 = u122.Parent;
    local v127 = u39.template.Resize:Clone();
    v127.Parent = u122;
    v127.InputBegan:connect(function(p128) --[[ Line: 281 ]]
        -- upvalues: u21 (ref), u37 (ref), u122 (copy), u126 (ref), u125 (ref), u15 (ref), l__Parent__9 (ref), u123 (copy), u124 (copy)
        if p128[u21] == Enum[u21].MouseButton1 or p128[u21] == Enum[u21].Touch then
            local v129 = {
                x = u37.X,
                y = u37.Y,
                s = u122.AbsoluteSize,
                m = Vector2.new(u37.ViewSizeX - u122.AbsolutePosition.X, u37.ViewSizeY - u122.AbsolutePosition.Y)
            };
            u126 = v129;
            u125 = u15.UIS.InputEnded:connect(function(p130) --[[ Line: 290 ]]
                -- upvalues: u21 (ref), u126 (ref)
                if p130[u21] == Enum[u21].MouseButton1 or p130[u21] == Enum[u21].Touch then
                    u126 = nil;
                end;
            end);
            while u126 == v129 and (u122 and u122.Parent == l__Parent__9) do
                local v131 = u122;
                local l__new__10 = UDim2.new;
                local l__X__11 = u126.m.X;
                local v132 = math.max(u123 or 20, u126.s.X + (u37.X - u126.x));
                local v133 = math.min(l__X__11, v132);
                local l__Y__12 = u126.m.Y;
                local v134 = math.max(u124 or 20, u126.s.Y + (u37.Y - u126.y));
                v131.Size = l__new__10(0, v133, 0, (math.min(l__Y__12, v134)));
                task.wait();
            end;
            u125:disconnect();
        end;
    end);
end;
function u39.UpdateVar() --[[ Line: 308 ]]
    -- upvalues: l__CurrentCamera__2 (ref), l__LocalPlayer__1 (ref), l__Character__3 (ref), l__PlayerGui__4 (ref), u14 (copy), u37 (ref)
    l__CurrentCamera__2 = l__CurrentCamera__2 or workspace.CurrentCamera;
    l__LocalPlayer__1 = l__LocalPlayer__1 or game.Players.LocalPlayer;
    l__Character__3 = l__LocalPlayer__1.Character;
    l__PlayerGui__4 = u14(l__LocalPlayer__1, "PlayerGui");
    u37 = u37 or l__LocalPlayer__1:GetMouse();
end;
function u39.MatchPlr(p135, _, p136) --[[ Line: 315 ]]
    -- upvalues: u15 (copy)
    local v137 = "^" .. (p135 or ""):lower();
    local v138 = "";
    for _, v139 in u15.Players:GetPlayers() do
        local v140 = v139.Name:lower():match(v137);
        if v140 and #v140 > #v138 then
            p136 = v139;
            v138 = v140;
        end;
    end;
    return p136;
end;
function u39.MatchClr(p141, _) --[[ Line: 326 ]]
    local v142 = BrickColor.new(p141:sub(1, 1):upper() .. p141:sub(2));
    if v142 == BrickColor.new("") or not v142 then
        v142 = nil;
    end;
    if not v142 then
        for _, v143 in {
            "New Yeller",
            "Pastel Blue",
            "Dusty Rose",
            "CGA brown"
        } do
            if p141:lower():find("^" .. v143) then
                v142 = BrickColor.new(v143);
            end;
        end;
    end;
    if not v142 and p141:find("^random") then
        v142 = BrickColor.Random();
    end;
    if v142 then
        v142 = v142.Color;
    end;
    return v142;
end;
function u39.Has(p144, p145) --[[ Line: 342 ]]
    -- upvalues: u15 (copy)
    return u15.Market:PlayerOwnsAsset(p144, p145);
end;
function u39.onCam(p146) --[[ Line: 345 ]]
    -- upvalues: l__CurrentCamera__2 (ref)
    return (l__CurrentCamera__2.CFrame:inverse() * p146).z < 0;
end;
function u39.PredictCmds(p147, _) --[[ Line: 348 ]]
    -- upvalues: u24 (ref), u31 (ref), u30 (ref), l__LocalPlayer__1 (ref)
    local v148 = p147:lower():gsub(u24.Prefix, "");
    local v149 = {};
    for _, v150 in u31 do
        for _, v151 in v150[1] do
            if v151:lower():find("^" .. v148) and (u30[l__LocalPlayer__1.userId] or 0) >= (v150[3] or 0) then
                local v152 = v150[2][2] and (v151 .. " " .. (v150[2][2] or "") .. "\t" or "") or "";
                local v153 = #v150[4] > 0 and (" " .. table.concat(v150[4], " ") or "") or "";
                table.insert(v149, v152 .. "[" .. v151 .. v153 .. "]\t" .. v150[2][1]);
            end;
        end;
    end;
    return v149;
end;
function u39.getTime(p154, _) --[[ Line: 367 ]]
    local v155 = p154 % 86400;
    local v156 = { v155 % 60, v155 % 3600 / 60, v155 / 3600 };
    for v157, v158 in v156 do
        local v159 = math.floor(v158);
        if v159 < 10 then
            v159 = "0" .. v159 or v159;
        end;
        v156[v157] = v159;
    end;
    return v156[3] .. ":" .. v156[2] .. ":" .. v156[1];
end;
function u39.getTitle(p160) --[[ Line: 376 ]]
    return p160 == 8 and "Futuretops Staff" or (p160 >= 6 and "Game Creator" or (p160 == 5 and "Owner" or (p160 == 4 and "Super Admin" or (p160 == 3 and "Administrator" or (p160 == 2 and "Moderator" or (p160 == 1 and "VIP" or "Player"))))));
end;
function u39.getNameFromId(u161, _) --[[ Line: 386 ]]
    -- upvalues: u32 (copy), u15 (copy)
    local v162, v163 = pcall(function() --[[ Line: 387 ]]
        -- upvalues: u32 (ref), u161 (ref), u15 (ref)
        return u32[u161] or u15.Players:GetNameFromUserIdAsync(u161);
    end);
    local v164 = v162;
    local v165 = v164 and v163 and v163 or "???";
    if v165 ~= "???" then
        u32[v164] = v165;
    end;
    return v165;
end;
function u39.getWords(p166, _) --[[ Line: 396 ]]
    local v167 = {};
    for v168 in p166:gmatch("%S+") do
        v167[#v167 + 1] = v168;
    end;
    return v167;
end;
function u39.getCmds(p169, _, _) --[[ Line: 403 ]]
    -- upvalues: u39 (copy), u24 (ref), u31 (ref)
    local v170 = p169:lower();
    local v171 = 0;
    local v172 = {};
    for _, v173 in u39.getWords(v170) do
        if v173:find(u24.Prefix, 1, true) == 1 then
            local v174 = v173:sub(#u24.Prefix + 1);
            for _, v175 in u31 do
                for _, v176 in v175[1] do
                    if v174 == v176:lower() then
                        v171 = v171 + v170:sub(v171 + 1, #v170):find(u24.Prefix .. v176:lower());
                        if #v172 > 0 then
                            v172[#v172][3] = v171 - 1;
                        end;
                        v172[#v172 + 1] = { v175, v171 };
                    end;
                end;
            end;
        end;
    end;
    return v172;
end;
local u177 = "ScreenGui";
local u178 = nil;
local u183 = (function(p179) --[[ Line: 8 ]]
    -- upvalues: u177 (copy), u178 (copy)
    local v180 = Instance.new(u177);
    for v181, v182 in p179 do
        if type(v181) == "number" then
            v182.Parent = v180;
        else
            v180[v181] = v182;
        end;
    end;
    v180.Parent = v180.Parent or u178;
    return v180;
end)({
    Name = "KCoreUI",
    IgnoreGuiInset = true,
    ResetOnSpawn = false,
    Parent = l__PlayerGui__4
});
local u184 = "TextBox";
local u185 = nil;
local u190 = (function(p186) --[[ Line: 8 ]]
    -- upvalues: u184 (copy), u185 (copy)
    local v187 = Instance.new(u184);
    for v188, v189 in p186 do
        if type(v188) == "number" then
            v189.Parent = v187;
        else
            v187[v188] = v189;
        end;
    end;
    v187.Parent = v187.Parent or u185;
    return v187;
end)({
    AutoLocalize = false,
    Font = "SourceSans",
    FontSize = "Size14",
    TextColor3 = Color3.new(1, 1, 1),
    BackgroundColor3 = Color3.new(),
    [u19] = 0.75,
    [u20] = 1,
    BorderSizePixel = 0,
    TextXAlignment = "Left",
    Size = UDim2.new(1, -10, 0, 20),
    ClipsDescendants = true,
    Selectable = true,
    TextEditable = false,
    ClearTextOnFocus = false,
    ZIndex = 7
});
local u191 = {
    LastSpace = 0
};
local u192 = nil;
u15.UIS.TextBoxFocused:connect(function() --[[ Line: 444 ]]
    -- upvalues: u192 (ref)
    u192 = true;
end);
u15.UIS.TextBoxFocusReleased:connect(function() --[[ Line: 447 ]]
    -- upvalues: u192 (ref)
    u192 = false;
end);
u40.Changed:connect(u39.UpdateAdmins);
u41.Changed:connect(function() --[[ Line: 451 ]]
    -- upvalues: u33 (ref), u39 (copy), u41 (ref)
    u33 = u39.unCache(u41.Value);
end);
u39.UpdateAdmins();
local v193 = u39.unCache(u41.Value);
l__Character__3 = l__LocalPlayer__1.Character or l__LocalPlayer__1.CharacterAdded:Wait();
local u194 = game:GetService("Chat"):CanUserChatAsync(l__LocalPlayer__1.userId);
local u195 = u39.template.Chat:Clone();
local u196 = {};
local u197 = {};
u195.Parent = u183;
local u198 = 0;
local u199 = 10;
local u200 = false;
local u201 = true;
local u202 = false;
local u203 = nil;
local u204 = nil;
local u205 = "";
local u206 = {};
local u207 = "";
local v208 = u195.Bubble:Clone();
u195.Small:Clone();
v208.Visible = true;
local l__Msg__13 = u195.Msg;
l__Msg__13.Changed:connect(function() --[[ Line: 470 ]]
    -- upvalues: l__Msg__13 (copy), u207 (ref), u23 (ref)
    local l__Text__14 = l__Msg__13.Text;
    local v209;
    if l__Text__14 == "" and #u207 ~= 1 then
        v209 = u207 or l__Text__14;
    else
        v209 = l__Text__14;
    end;
    u207 = v209;
    if u207 ~= "" and l__Text__14 == "" then
        l__Msg__13.Text = u207;
        l__Msg__13:CaptureFocus();
    end;
    l__Msg__13.TextXAlignment = l__Msg__13.TextBounds.X > l__Msg__13[u23].X - 5 and "Right" or "Left";
end);
local u210 = "Sound";
local u211 = nil;
local u216 = (function(p212) --[[ Line: 8 ]]
    -- upvalues: u210 (copy), u211 (copy)
    local v213 = Instance.new(u210);
    for v214, v215 in p212 do
        if type(v214) == "number" then
            v215.Parent = v213;
        else
            v213[v214] = v215;
        end;
    end;
    v213.Parent = v213.Parent or u211;
    return v213;
end)({
    SoundId = "rbxassetid://305977837",
    Volume = 1,
    Pitch = 2,
    Parent = u195
});
local function u220(_) --[[ Line: 482 ]]
    -- upvalues: u197 (ref), u196 (ref)
    local v217 = u197;
    for _, v218 in u196 do
        v218:Destroy();
    end;
    u196 = {};
    u197 = {};
    for _, v219 in v217 do
        Chat(v219[1], v219[2], 0, v219[3], v219[4]);
    end;
end;
local function u221() --[[ Line: 492 ]]
    -- upvalues: u195 (copy), u23 (ref), u196 (ref)
    u195.Logs.CanvasSize = UDim2.new(1, 0, 1, -u195.Logs[u23].Y + #u196 * 20);
    u195.Logs.CanvasPosition = Vector2.new(0, (math.max(0, -u195.Logs[u23].Y + #u196 * 20)));
end;
local function u225() --[[ Line: 496 ]]
    -- upvalues: u200 (ref), l__Msg__13 (copy), u18 (ref), u19 (ref), u195 (copy)
    delay(u200 and 0 or 0.2, function() --[[ Line: 497 ]]
        -- upvalues: l__Msg__13 (ref), u18 (ref), u19 (ref), u200 (ref)
        local v222 = l__Msg__13;
        local v223 = u19;
        local v224 = u200 and 0.75 or 1;
        l__Msg__13[u18] = u200 and 0 or 1;
        v222[v223] = v224;
    end);
    u200 = not u200;
    u195.BG:TweenSize(UDim2.new(1, -5, 1, u200 and 20 or 0), "Out", "Quad", 0.2, true);
end;
local function u228(u226) --[[ Line: 503 ]]
    -- upvalues: u201 (ref), u202 (ref), u28 (copy), l__Msg__13 (copy), u39 (copy), u195 (copy), u228 (copy)
    if u201 == u226 or u202 then
        if u201 ~= u226 then
            u201 = u226;
        end;
    else
        u202 = true;
        u201 = u226;
        u28(function() --[[ Line: 506 ]]
            -- upvalues: u226 (copy), u201 (ref), l__Msg__13 (ref), u202 (ref), u39 (ref), u195 (ref), u228 (ref)
            local v227 = tick();
            if u226 then
                while tick() - v227 < 1 do
                    if u226 ~= u201 or l__Msg__13:IsFocused() then
                        u202 = false;
                        return;
                    end;
                    task.wait();
                end;
            end;
            u39[u226 and "Hide" or "Show"](u195.BG);
            u202 = false;
            if u201 ~= u226 then
                u201 = u226;
                u228(not u226);
            end;
        end);
    end;
end;
local function u229() --[[ Line: 528 ]]
    -- upvalues: u195 (copy)
    if u195.Logs.CanvasSize.Y.Offset > 0 then
        u195.Logs.Size = UDim2.new(1, 0, 1, 0);
        u195.Logs.ScrollBarThickness = 5;
    else
        u195.Logs.Size = UDim2.new(1, -5, 1, 0);
        u195.Logs.ScrollBarThickness = 0;
    end;
end;
local function u231(p230) --[[ Line: 537 ]]
    -- upvalues: u195 (copy), u22 (ref), u23 (ref)
    return p230.X >= u195.Logs[u22].X and (p230.X <= u195.Logs[u22].X + u195.Logs[u23].X and (p230.Y >= u195.Logs[u22].Y and p230.Y <= u195.Logs[u22].Y + u195.Logs[u23].Y));
end;
local u232 = {};
local u233 = {
    red = Color3.new(1, 0, 0),
    orange = Color3.new(1, 0.5, 0),
    yellow = Color3.new(1, 1, 0),
    green = Color3.new(0, 1, 0),
    cyan = Color3.new(0, 1, 1),
    blue = Color3.new(0, 0, 1),
    purple = Color3.new(0.4, 0, 1),
    pink = Color3.new(1, 0, 1),
    black = Color3.new(),
    white = Color3.new(1, 1, 1),
    navy = Color3.new(0, 0, 0.4),
    gray = Color3.new(0.6, 0.6, 0.6),
    grey = Color3.new(0.4, 0.4, 0.4)
};
function Chat(p234, p235, p236, p237, p238)
    -- upvalues: u232 (copy), u16 (ref), u15 (copy), l__LocalPlayer__1 (ref), u216 (copy), u24 (ref), u197 (ref), u20 (ref), u195 (copy), u39 (copy), u19 (ref), u196 (ref), u21 (ref), l__Msg__13 (copy), u28 (copy), u221 (copy)
    if u232[p234] or p235 and not p235:match("[!-~]") then
    else
        local v239 = (p235 or "\t"):gsub("\n", " ");
        local v240 = p236 or 0.2;
        local v241 = p237 or Color3.new(1, 1, 1);
        local v242 = p238 or Color3.new(1, 1, 1);
        local v243 = p234:match("|") and "";
        local u244, _ = u16(u15.Players, p234:match("[%w_]+$"));
        local v245;
        if u16(u244, "KNick") then
            v245 = u244.KNick.Value;
        else
            v245 = p234:sub(1, v243 and -2 or -1);
        end;
        local v246;
        if u244 and (v240 > 0 and not v243) then
            v246 = not u244.Neutral and u244.TeamColor.Color;
            if not v246 then
                local v247 = u16(u244, "KCClr");
                v246 = v247 and v247.Value or nil or v241;
            end;
            if v239:find("^%%") then
                if u244.TeamColor ~= l__LocalPlayer__1.TeamColor then
                    return;
                end;
                v245 = "Team " .. v245;
                v242 = u244.TeamColor.Color;
                v239 = v239:sub(2);
            elseif v239:find("^@") then
                local v248, v249 = v239:match("%s?([%w_]+)%s(.+)");
                v239 = v249 or "";
                if l__LocalPlayer__1 ~= u244 and l__LocalPlayer__1.Name:lower():find(v248:lower()) ~= 1 then
                    return;
                end;
                if l__LocalPlayer__1 == u244 then
                    v245 = "To " .. v248;
                else
                    v245 = "From " .. v245;
                end;
                v246 = Color3.new();
                v242 = Color3.new();
            end;
            if u244 ~= l__LocalPlayer__1 and v239:match(l__LocalPlayer__1.Name) then
                u216:Play();
                v242 = Color3.new();
            end;
            if u24.BubbleChat and (u244 and (u244.Character and u244.Character:FindFirstChild("Head"))) then
                _G.ChatBubble(u244.Character.Head, v239:gsub("^/", ""), v242);
            end;
        else
            v246 = v241;
        end;
        if u24.Chat and not v239:find("^/") then
            if not v243 then
                table.insert(u197, {
                    v245,
                    v239,
                    v246,
                    v242
                });
            end;
            local u250 = "TextLabel";
            local u251 = nil;
            local v256 = (function(p252) --[[ Line: 8 ]]
                -- upvalues: u250 (copy), u251 (copy)
                local v253 = Instance.new(u250);
                for v254, v255 in p252 do
                    if type(v254) == "number" then
                        v255.Parent = v253;
                    else
                        v253[v254] = v255;
                    end;
                end;
                v253.Parent = v253.Parent or u251;
                return v253;
            end)({
                AutoLocalize = false,
                [u20] = 1,
                BackgroundColor3 = Color3.new(),
                BorderColor3 = Color3.new(),
                BorderSizePixel = 0,
                Font = "SourceSansBold",
                FontSize = "Size18",
                Parent = u195.Logs,
                TextColor3 = v246,
                TextStrokeColor3 = u39.Stroke(v246),
                Text = v243 or v245,
                TextXAlignment = "Left",
                Position = UDim2.new(0, -20, 1, 0),
                [u19] = 0.75,
                ZIndex = 9,
                Visible = false
            });
            v256.Size = UDim2.new(0, v256.TextBounds.X, 0, 20);
            local u257 = "TextLabel";
            local u258 = nil;
            local v263 = (function(p259) --[[ Line: 8 ]]
                -- upvalues: u257 (copy), u258 (copy)
                local v260 = Instance.new(u257);
                for v261, v262 in p259 do
                    if type(v261) == "number" then
                        v262.Parent = v260;
                    else
                        v260[v261] = v262;
                    end;
                end;
                v260.Parent = v260.Parent or u258;
                return v260;
            end)({
                AutoLocalize = false,
                [u20] = 1,
                BackgroundColor3 = Color3.new(),
                BorderColor3 = Color3.new(),
                BorderSizePixel = 0,
                Font = "SourceSans" .. (u244 == l__LocalPlayer__1 and "Italic" or ""),
                FontSize = "Size18",
                Parent = v256,
                TextColor3 = v242,
                TextStrokeColor3 = u39.Stroke(v242),
                Text = v239,
                TextXAlignment = "Left",
                Position = UDim2.new(0, v256.TextBounds.X + 8, 0, 10),
                Size = UDim2.new(),
                [u19] = 0.75,
                ZIndex = 9
            });
            table.insert(u196, 1, v256);
            local u264 = nil;
            u264 = v256.InputEnded:connect(function(p265) --[[ Line: 765 ]]
                -- upvalues: u21 (ref), u244 (copy), l__Msg__13 (ref), u264 (ref)
                if p265[u21] == Enum[u21].MouseButton1 and u244 then
                    l__Msg__13.Text = "@" .. u244.Name .. " ";
                    l__Msg__13:CaptureFocus();
                else
                    if not u244 then
                        u264:disconnect();
                    end;
                end;
            end);
            while v263.TextBounds.X + v256.TextBounds.X + 10 > u195.Size.X.Offset do
                v263.Text = v263.Text:sub(1, -2);
            end;
            if #v263.Text ~= #v239 then
                local v266 = v263.Text:find("%s%S+$");
                v263.Text = v263.Text:sub(1, v266 or #v263.Text);
                if v243 then
                    v263.Text = v263.Text:sub(1, -3) .. "...";
                else
                    Chat(v245 .. "|", v239:sub(#v263.Text + 1), v240, v246, v242);
                end;
            end;
            u28(u39.Show, v256, v240);
            for v267, v268 in u196 do
                v268:TweenPosition(UDim2.new(0, 2, 1, -v267 * 20), "Out", "Quad", v240, true);
            end;
            if #u196 > 50 then
                u28(u39.Hide, u196[51], true, 0.2);
                table.remove(u196, 51);
            end;
            u221();
        end;
    end;
end;
local u269 = {
    wave = { 128777973 },
    point = { 128853357 },
    dance = { 182435998, 182491037, 182491065 },
    dance2 = { 182436842, 182491248, 182491277 },
    dance3 = { 182436935, 182491368, 182491423 },
    laugh = { 129423131 },
    cheer = { 129423030 }
};
local u270 = nil;
local function u286(u271, u272, u273, p274, p275, _, _) --[[ Line: 807 ]]
    -- upvalues: u270 (ref), u28 (copy), u286 (copy)
    local l__Position__15 = u272.Position;
    local u276 = p274 or 1;
    local u277 = "Animation";
    local u278 = nil;
    local u283 = u271:LoadAnimation((function(p279) --[[ Line: 8 ]]
        -- upvalues: u277 (copy), u278 (copy)
        local v280 = Instance.new(u277);
        for v281, v282 in p279 do
            if type(v281) == "number" then
                v282.Parent = v280;
            else
                v280[v281] = v282;
            end;
        end;
        v280.Parent = v280.Parent or u278;
        return v280;
    end)({
        Parent = u271,
        AnimationId = "rbxassetid://" .. u273[u276]
    }));
    u283:Play(p275 or 0.1);
    if #u273 > 1 then
        local u284 = false;
        if u270 then
            u270:disconnect();
        end;
        u28(function() --[[ Line: 816 ]]
            -- upvalues: u283 (ref), u272 (copy), l__Position__15 (ref), u284 (ref)
            while u283 and (u272 and (u272.Position - l__Position__15).magnitude < 0.2) do
                task.wait();
            end;
            u284 = true;
            if u283 then
                u283:Stop();
                u283:Destroy();
            end;
        end);
        u270 = u283.KeyframeReached:connect(function(p285) --[[ Line: 826 ]]
            -- upvalues: u270 (ref), u283 (ref), u284 (ref), u286 (ref), u271 (copy), u272 (copy), u273 (copy), u276 (ref)
            if p285 == "End" then
                u270:disconnect();
                u283:Destroy();
                if not u284 then
                    u284 = true;
                    u286(u271, u272, u273, u276 % #u273 + 1, 0);
                end;
            end;
        end);
    end;
end;
local function u293(p287, _) --[[ Line: 838 ]]
    -- upvalues: l__KDonor__5 (copy), l__LocalPlayer__1 (ref), u39 (copy), u38 (copy), u269 (copy), u16 (ref), l__Character__3 (ref), u286 (copy), u232 (copy), u233 (copy), u24 (ref)
    if not p287:match("^/") then
        return false;
    end;
    local v288 = p287:sub(2):lower();
    if v288:find("^?") or v288:find("^help") then
        Chat("/[Message]", "Bubble Chat");
        Chat("%[Message]", "Team Chat");
        Chat("@[Player] [Message]", "Private Chat");
        Chat("/block [Player]", "Blocks incoming chats");
        Chat("/unblock [Player]", "Unblocks incoming chats");
        Chat("/e [Emote]", "Uses emote");
        if l__KDonor__5.Value > 0 and l__LocalPlayer__1.Neutral then
            Chat("/color [Color]", "Changes your chat color");
        end;
    elseif v288:find("^em?o?t?e? ") then
        if #u39.getCmds(v288) > 0 then
            u38:FireServer(u39.uID .. "KCmdBar", v288);
        end;
        if u269[v288:match("(%w+)$")] and (u16(l__Character__3, "Humanoid") and u16(l__Character__3, "HumanoidRootPart")) then
            u286(l__Character__3.Humanoid, l__Character__3.HumanoidRootPart, u269[v288:match("(%w+)$")]);
        end;
    elseif v288:find("^block ") then
        local v289 = u39.MatchPlr(v288:sub(7));
        if v289 then
            local l__Name__16 = v289.Name;
            u232[l__Name__16] = true;
            Chat(l__Name__16 .. " has been blocked!");
        end;
    elseif v288:find("^unblock ") then
        local v290 = u39.MatchPlr(v288:sub(9));
        if v290 then
            local l__Name__17 = v290.Name;
            u232[l__Name__17] = nil;
            Chat(l__Name__17 .. " has been unblocked!");
        end;
    elseif v288:find("^color ") then
        if l__KDonor__5.Value > 0 and l__LocalPlayer__1.Neutral then
            local v291 = v288:sub(7):lower();
            local v292 = u233[v291] or u39.MatchClr(v291);
            if v292 then
                u38:FireServer(u39.uID .. "KCClr", v292);
                Chat("Chat color changed!", nil, nil, v292);
            else
                Chat("Invalid color!");
            end;
        end;
    elseif u24.BubbleChat then
        u38:FireServer(u39.uID .. "KChat", { l__LocalPlayer__1.Name, p287 });
        Chat(l__LocalPlayer__1.Name, p287);
    end;
    return true;
end;
local u294 = {};
local u295 = -1;
local u296 = u39.template.CommandBar:Clone();
local u297 = false;
local l__CmdBar__18 = u296.CmdBar;
u296.Parent = u183;
l__CmdBar__18.FocusLost:connect(function(p298, _) --[[ Line: 899 ]]
    -- upvalues: l__CmdBar__18 (ref), u294 (copy), u295 (ref), u38 (copy), u39 (copy), u24 (ref), u297 (ref), u296 (copy)
    local l__Text__19 = l__CmdBar__18.Text;
    if p298 and l__Text__19:gsub("%s", "") ~= "" then
        local v299 = table.find(u294, l__Text__19);
        if v299 then
            table.remove(u294, v299);
        end;
        if #u294 > 32 then
            table.remove(u294, 1);
        end;
        u295 = -1;
        table.insert(u294, l__Text__19);
        u38:FireServer(u39.uID .. "KCmdBar", (l__Text__19:find(u24.Prefix, 1, true) == 1 and "" or u24.Prefix) .. l__Text__19);
    end;
    if not u297 and u296.Visible then
        u297 = true;
        u39.Hide(u296);
        u297 = false;
    end;
    l__CmdBar__18.Text = "";
end);
l__CmdBar__18.Changed:connect(function(_) --[[ Line: 923 ]]
    -- upvalues: u296 (copy), l__CmdBar__18 (ref), u39 (copy)
    local v300 = u296:FindFirstChild("List");
    if v300 then
        local v301 = l__CmdBar__18.Text:match("%w+") or "";
        local v302 = #v301 > 0 and u39.PredictCmds(v301) or {};
        for v303, v304 in v300:GetChildren() do
            v304.Visible = v302[v303] and true or false;
            v304.Text = v302[v303] or "";
        end;
    end;
end);
l__Msg__13.Focused:connect(function() --[[ Line: 939 ]]
    -- upvalues: u201 (ref), u202 (ref), u28 (copy), l__Msg__13 (copy), u39 (copy), u195 (copy), u228 (copy), u200 (ref), u225 (copy)
    if u201 == false or u202 then
        if u201 ~= false then
            u201 = false;
        end;
    else
        u202 = true;
        u201 = false;
        local u305 = false;
        u28(function() --[[ Line: 506 ]]
            -- upvalues: u305 (copy), u201 (ref), l__Msg__13 (ref), u202 (ref), u39 (ref), u195 (ref), u228 (ref)
            local v306 = tick();
            if u305 then
                while tick() - v306 < 1 do
                    if u305 ~= u201 or l__Msg__13:IsFocused() then
                        u202 = false;
                        return;
                    end;
                    task.wait();
                end;
            end;
            u39[u305 and "Hide" or "Show"](u195.BG);
            u202 = false;
            if u201 ~= u305 then
                u201 = u305;
                u228(not u305);
            end;
        end);
    end;
    if not u200 then
        u225();
    end;
end);
l__Msg__13.FocusLost:connect(function(p307) --[[ Line: 945 ]]
    -- upvalues: l__Msg__13 (copy), u201 (ref), u202 (ref), u28 (copy), u39 (copy), u195 (copy), u228 (copy), u200 (ref), u225 (copy), u293 (copy), u207 (ref), u203 (ref), u204 (ref), u205 (ref), u206 (ref), u198 (ref), u191 (copy), u38 (copy), l__LocalPlayer__1 (ref), u199 (ref)
    local l__Text__20 = l__Msg__13.Text;
    if p307 and (l__Text__20 ~= "" and (l__Text__20:gsub("[%%%s]", "") == "" or l__Text__20:find("^@") and not l__Text__20:match("^@%w+%s+%w+"))) then
        l__Msg__13:CaptureFocus();
        Chat("Invalid message!");
    else
        if u201 == true or u202 then
            if u201 ~= true then
                u201 = true;
            end;
        else
            u202 = true;
            u201 = true;
            local u308 = true;
            u28(function() --[[ Line: 506 ]]
                -- upvalues: u308 (copy), u201 (ref), l__Msg__13 (ref), u202 (ref), u39 (ref), u195 (ref), u228 (ref)
                local v309 = tick();
                if u308 then
                    while tick() - v309 < 1 do
                        if u308 ~= u201 or l__Msg__13:IsFocused() then
                            u202 = false;
                            return;
                        end;
                        task.wait();
                    end;
                end;
                u39[u308 and "Hide" or "Show"](u195.BG);
                u202 = false;
                if u201 ~= u308 then
                    u201 = u308;
                    u228(not u308);
                end;
            end);
        end;
        if u200 then
            u225();
        end;
        if u293(l__Text__20:sub(1, 255):lower()) then
            u207 = "";
            u203 = nil;
            u204 = nil;
            u205 = "";
            u206 = {};
            l__Msg__13.Text = "";
        else
            if p307 and (l__Text__20 ~= "" and (u198 <= 7 and not u191.Muted)) then
                u207 = "";
                u203 = nil;
                u204 = nil;
                u205 = "";
                u206 = {};
                l__Msg__13.Text = "";
                u38:FireServer(u39.uID .. "KChat", { l__LocalPlayer__1.Name, l__Text__20:sub(1, 255) });
                Chat(l__LocalPlayer__1.Name, l__Text__20:sub(1, 255));
                u198 = u198 + 1;
                delay(10, function() --[[ Line: 965 ]]
                    -- upvalues: u198 (ref)
                    u198 = u198 - 1;
                end);
                if u198 > 7 then
                    u198 = 14;
                    l__Msg__13.TextColor3 = Color3.new(1, 0, 0);
                    Chat("You have been muted for " .. u199 .. " seconds!");
                    delay(u199, function() --[[ Line: 972 ]]
                        -- upvalues: l__Msg__13 (ref), u199 (ref), u198 (ref)
                        local v310 = l__Msg__13;
                        local v311 = Color3.new(1, 1, 1);
                        local v312 = math.min(300, u199 + 30);
                        v310.TextColor3 = v311;
                        u199 = v312;
                        u198 = 0;
                        Chat("You have been unmuted!");
                        delay(60, function() --[[ Line: 976 ]]
                            -- upvalues: u199 (ref)
                            u199 = math.max(10, u199 - 30);
                        end);
                    end);
                end;
            end;
        end;
    end;
end);
u195.BG.Resize.MouseButton1Down:connect(function() --[[ Line: 983 ]]
    -- upvalues: u37 (ref), u195 (copy), u28 (copy), u22 (ref), u221 (copy), u229 (copy), u220 (copy)
    isResizing = true;
    local l__X__21 = u37.X;
    local l__Y__22 = u37.Y;
    local l__Offset__23 = u195.Size.X.Offset;
    local l__Offset__24 = u195.Size.Y.Offset;
    u28(function() --[[ Line: 986 ]]
        -- upvalues: u37 (ref), u195 (ref), u22 (ref), l__Offset__23 (copy), l__X__21 (copy), l__Offset__24 (copy), l__Y__22 (copy), u221 (ref), u229 (ref), u220 (ref)
        local v313 = u37.ViewSizeX - u195[u22].X;
        local v314 = u37.ViewSizeY - u195[u22].Y + 15;
        while isResizing do
            task.wait();
            local v315 = u195;
            local l__new__25 = UDim2.new;
            local v316 = math.max(205, l__Offset__23 + (u37.X - l__X__21));
            local v317 = math.min(v313, v316);
            local v318 = math.max(200, l__Offset__24 + (u37.Y - l__Y__22));
            v315.Size = l__new__25(0, v317, 0, (math.min(v314, v318)));
            u221();
            u229();
        end;
        u220();
    end);
end);
u39.Drag(u195);
u195.InputChanged:connect(function() --[[ Line: 998 ]]
    -- upvalues: u201 (ref), u202 (ref), u28 (copy), l__Msg__13 (copy), u39 (copy), u195 (copy), u228 (copy)
    if u201 == false or u202 then
        if u201 ~= false then
            u201 = false;
        end;
    else
        u202 = true;
        u201 = false;
        local u319 = false;
        u28(function() --[[ Line: 506 ]]
            -- upvalues: u319 (copy), u201 (ref), l__Msg__13 (ref), u202 (ref), u39 (ref), u195 (ref), u228 (ref)
            local v320 = tick();
            if u319 then
                while tick() - v320 < 1 do
                    if u319 ~= u201 or l__Msg__13:IsFocused() then
                        u202 = false;
                        return;
                    end;
                    task.wait();
                end;
            end;
            u39[u319 and "Hide" or "Show"](u195.BG);
            u202 = false;
            if u201 ~= u319 then
                u201 = u319;
                u228(not u319);
            end;
        end);
    end;
end);
u195.MouseEnter:connect(u229);
u15.UIS.InputChanged:connect(function(p321) --[[ Line: 1002 ]]
    -- upvalues: u24 (ref), u21 (ref), u231 (copy), u201 (ref), u202 (ref), u28 (copy), l__Msg__13 (copy), u39 (copy), u195 (copy), u228 (copy)
    if u24.Chat then
        if p321[u21] == Enum[u21].MouseMovement and not u231(p321.Position) then
            if u201 == true or u202 then
                if u201 ~= true then
                    u201 = true;
                end;
            else
                u202 = true;
                u201 = true;
                local u322 = true;
                u28(function() --[[ Line: 506 ]]
                    -- upvalues: u322 (copy), u201 (ref), l__Msg__13 (ref), u202 (ref), u39 (ref), u195 (ref), u228 (ref)
                    local v323 = tick();
                    if u322 then
                        while tick() - v323 < 1 do
                            if u322 ~= u201 or l__Msg__13:IsFocused() then
                                u202 = false;
                                return;
                            end;
                            task.wait();
                        end;
                    end;
                    u39[u322 and "Hide" or "Show"](u195.BG);
                    u202 = false;
                    if u201 ~= u322 then
                        u201 = u322;
                        u228(not u322);
                    end;
                end);
            end;
            if u195.Logs.ScrollBarThickness ~= 0 then
                u195.Logs.Size = UDim2.new(1, -5, 1, 0);
                u195.Logs.ScrollBarThickness = 0;
            end;
        end;
    end;
end);
u15.UIS.InputEnded:connect(function(p324) --[[ Line: 1014 ]]
    -- upvalues: u21 (ref)
    if p324[u21] == Enum[u21].MouseButton1 then
        isResizing = false;
    end;
end);
u15.UIS.InputBegan:connect(function(p325, p326) --[[ Line: 1019 ]]
    -- upvalues: u192 (ref), u191 (copy), u24 (ref), l__Msg__13 (copy), u194 (copy), u203 (ref), u204 (ref), u205 (ref), u206 (ref), u15 (copy), u16 (ref), l__LocalPlayer__1 (ref), u297 (ref), l__CmdBar__18 (ref), u296 (copy), u39 (copy), u295 (ref), u294 (copy)
    if u192 or (p326 or p325.KeyCode ~= Enum.KeyCode.Space) then
        if u24.Chat or u24.CommandBar then
            if l__Msg__13:IsFocused() and (p325.KeyCode ~= Enum.KeyCode.Unknown and u194) then
                if p325.KeyCode ~= Enum.KeyCode.Tab and u203 then
                    u203 = nil;
                    u204 = nil;
                    u205 = "";
                    u206 = {};
                    return;
                end;
                if p325.KeyCode == Enum.KeyCode.Tab and #l__Msg__13.Text > 1 then
                    if u203 then
                        u203 = u203 % #u206 + 1;
                        if u206[u203] then
                            l__Msg__13.Text = u204 .. u206[u203];
                        end;
                    else
                        u204 = l__Msg__13.Text:sub(1, -2);
                        u203 = 1;
                        local v327 = u204:find("%w+$");
                        u205 = v327 and (u204:sub(v327) or "") or "";
                        if #u205:gsub("%s", "") < 1 then
                            u206 = {};
                            u203 = nil;
                            return;
                        end;
                        u204 = u204:sub(1, v327 - 1);
                        for _, v328 in u15.Players:GetPlayers() do
                            if v328 and v328.Name:lower():find(u205:lower()) == 1 then
                                table.insert(u206, v328.Name);
                            end;
                        end;
                        if #u206 < 1 then
                            u206 = {};
                            u203 = nil;
                            return;
                        end;
                        if u206[u203] then
                            l__Msg__13.Text = u204 .. u206[u203];
                        end;
                    end;
                    l__Msg__13:CaptureFocus();
                end;
            else
                if u24.Chat and (not u192 and (p325.KeyCode == Enum.KeyCode.Slash or p325.KeyCode == Enum.KeyCode.Seven and u15.UIS:IsKeyDown(Enum.KeyCode.LeftShift))) then
                    task.wait();
                    l__Msg__13:CaptureFocus();
                    return;
                end;
                if (u24.CommandBar or u16(l__LocalPlayer__1, "KCmdBar")) and (not u192 and (not p326 and (p325.KeyCode == Enum.KeyCode.Semicolon and not u297))) then
                    task.wait();
                    l__CmdBar__18:CaptureFocus();
                    if not u296.Visible then
                        u297 = true;
                        u39.Show(u296);
                        u297 = false;
                    end;
                else
                    if p325.KeyCode == Enum.KeyCode.Up and (l__CmdBar__18:IsFocused() and (u24.CommandBar or u16(l__LocalPlayer__1, "KCmdBar"))) then
                        u295 = math.clamp(u295 + 1, -1, #u294 - 1);
                        l__CmdBar__18.Text = u294[#u294 - u295] or l__CmdBar__18.Text;
                        l__CmdBar__18.CursorPosition = #l__CmdBar__18.Text + 1;
                        return;
                    end;
                    if p325.KeyCode == Enum.KeyCode.Down and (l__CmdBar__18:IsFocused() and (u24.CommandBar or u16(l__LocalPlayer__1, "KCmdBar"))) then
                        u295 = math.clamp(u295 - 1, -1, #u294 - 1);
                        l__CmdBar__18.Text = u294[#u294 - u295] or "";
                        l__CmdBar__18.CursorPosition = #l__CmdBar__18.Text + 1;
                    end;
                end;
            end;
        end;
    else
        local v329 = u191.Noclip or u191.Fly;
        if v329 and tick() - u191.LastSpace < 0.3 then
            v329.Value = not v329.Value;
        end;
        u191.LastSpace = tick();
    end;
end);
local u330 = nil;
local u331 = u39.template.Credit:Clone();
local u332 = false;
local l__Main__26 = u331.Main;
u331.Parent = u183;
u39.Drag(l__Main__26, 250, 250);
function ToggleCredit()
    -- upvalues: u332 (ref), u39 (copy), l__Main__26 (ref)
    if not u332 then
        u332 = true;
        u39[l__Main__26.Visible and "Hide" or "Show"](l__Main__26);
        u332 = false;
    end;
end;
u331.Toggle.MouseButton1Click:connect(ToggleCredit);
l__Main__26.Close.MouseButton1Click:connect(ToggleCredit);
local l__Trail__27 = l__Main__26.Trail;
local l__Hat__28 = l__Main__26.Hat;
local l__Shine__29 = l__Main__26.Shine;
local v333 = l__KDonor__5.Value > 0;
local v334 = l__KDonor__5.Value > 2;
local v335 = l__KDonor__5.Value > 3;
l__Trail__27.Visible = v333;
l__Hat__28.Visible = v334;
l__Shine__29.Visible = v335;
l__KDonor__5.Changed:Connect(function() --[[ Line: 1121 ]]
    -- upvalues: l__Main__26 (ref), l__KDonor__5 (copy)
    local l__Trail__30 = l__Main__26.Trail;
    local l__Hat__31 = l__Main__26.Hat;
    local l__Shine__32 = l__Main__26.Shine;
    local v336 = l__KDonor__5.Value > 0;
    local v337 = l__KDonor__5.Value > 2;
    local v338 = l__KDonor__5.Value > 3;
    l__Trail__30.Visible = v336;
    l__Hat__31.Visible = v337;
    l__Shine__32.Visible = v338;
end);
l__Main__26.Get.MouseButton1Click:connect(function() --[[ Line: 1124 ]]
    -- upvalues: u15 (copy), l__LocalPlayer__1 (ref)
    u15.Market:PromptPurchase(l__LocalPlayer__1, 172732271);
end);
local u339 = v193;
local u340 = l__Character__3;
local u341 = u40;
local u342 = u37;
local u343 = l__CurrentCamera__2;
local u344 = u192;
local u345 = u41;
local u346 = l__PlayerGui__4;
local v347 = l__Main__26;
for v348, u349 in {
    { 5391355, 10 },
    { 5391356, 100 },
    { 5391359, 250 },
    { 5391361, 500 },
    { 5411126, 1000 }
} do
    local v350 = v347["D" .. v348];
    local v351, v352 = pcall(u15.Market.GetProductInfo, u15.Market, u349[1], Enum.InfoType.GamePass);
    v350.Text = (v351 and v352.PriceInRobux or u349[2]) .. " R$";
    v350.MouseButton1Click:Connect(function() --[[ Line: 1131 ]]
        -- upvalues: u330 (ref), u349 (copy), u15 (copy), l__LocalPlayer__1 (ref)
        u330 = u349[1];
        u15.Market:PromptGamePassPurchase(l__LocalPlayer__1, u349[1]);
    end);
end;
v347.Hat.MouseButton1Click:connect(function() --[[ Line: 1136 ]]
    -- upvalues: u38 (copy), u39 (copy)
    u38:FireServer(u39.uID .. "KHat");
end);
v347.Trail.MouseButton1Click:connect(function() --[[ Line: 1139 ]]
    -- upvalues: u38 (copy), u39 (copy)
    u38:FireServer(u39.uID .. "KTrail");
end);
v347.Shine.MouseButton1Click:connect(function() --[[ Line: 1142 ]]
    -- upvalues: u38 (copy), u39 (copy)
    u38:FireServer(u39.uID .. "KShine");
end);
u28(function() --[[ Line: 1145 ]]
    -- upvalues: u331 (copy)
    local v353 = false;
    while true do
        task.wait(1);
        local v354 = tick();
        local v355;
        repeat
            task.wait();
            v355 = tick() - v354;
            local v356 = v353 and v355 and v355 or math.max(0, 1 - v355);
            u331.Toggle.ImageColor3 = Color3.new(v356, v356, v356);
        until v355 > 1;
        v353 = not v353;
    end;
end);
local l__LogService__33 = game:GetService("LogService");
local u357 = u39.template.Direct:Clone();
u357.Parent = u183;
u357.Close.MouseButton1Click:Connect(function() --[[ Line: 1165 ]]
    -- upvalues: u357 (copy)
    u357.Visible = false;
end);
l__LogService__33.MessageOut:Connect(function(p358, p359) --[[ Line: 1169 ]]
    -- upvalues: u330 (ref), u357 (copy)
    if p359 == Enum.MessageType.MessageWarning and (string.find(p358, "AllowThirdPartySales") and (string.find(p358, "3403354") and u330)) then
        u357.Link.Text = "roblox.com/game-pass/" .. u330;
        u357.Visible = true;
    end;
end);
local l__PolicyService__34 = game:GetService("PolicyService");
local l__Players__35 = game:GetService("Players");
local l__LocalPlayer__36 = l__Players__35.LocalPlayer;
local v360, v361 = pcall(function() --[[ Line: 1187 ]]
    -- upvalues: l__PolicyService__34 (copy), l__LocalPlayer__36 (copy)
    return l__PolicyService__34:GetPolicyInfoForPlayerAsync(l__LocalPlayer__36);
end);
if v360 and (v361.AllowedExternalLinkReferences and table.find(v361.AllowedExternalLinkReferences, "Discord")) then
    v347.Position = UDim2.new(0.5, -125, 0.5, -144);
    v347.Trail.Position = UDim2.new(0, 0, 1, 268);
    v347.Hat.Position = UDim2.new(0, 83, 1, 268);
    v347.Shine.Position = UDim2.new(1, -82, 1, 268);
    v347.Social.Visible = true;
    v347.Social.Text = "discord.gg/bwCC7gV";
    u39.template.Help.BG.Social.Visible = true;
    u39.template.Help.BG.Social.Text = "discord.gg/bwCC7gV";
end;
game:GetService("TextChatService").SendingMessage:Connect(function(p362) --[[ Line: 1204 ]]
    -- upvalues: u24 (ref), u38 (copy), u39 (copy)
    if string.find(p362.Text, u24.Prefix, 1, true) == 1 then
        u38:FireServer(u39.uID .. "KCmdBar", p362.Text);
    end;
end);
local function u412(p363, p364, p365, _, _) --[[ Line: 1211 ]]
    -- upvalues: u16 (ref), u20 (ref), u39 (copy), u28 (copy)
    local v366 = p364 or Color3.new();
    local u367 = u16(p363, "HumanoidRootPart");
    local u368 = u16(p363, "Humanoid");
    if p363 and (u367 and u368) then
        local u369 = CFrame.new(0, 0.925, 0.5);
        local u370 = -3;
        local u371 = 0;
        local u372 = 0;
        local u373 = "Part";
        local u374 = nil;
        local u379, _ = (function(p375) --[[ Line: 8 ]]
            -- upvalues: u373 (copy), u374 (copy)
            local v376 = Instance.new(u373);
            for v377, v378 in p375 do
                if type(v377) == "number" then
                    v378.Parent = v376;
                else
                    v376[v377] = v378;
                end;
            end;
            v376.Parent = v376.Parent or u374;
            return v376;
        end)({
            Name = "KCape",
            Parent = p363,
            CanCollide = false,
            Transparency = 1,
            FormFactor = 3,
            Size = Vector3.new(1.9, 3.8, 0.2),
            TopSurface = 0,
            BottomSurface = 0
        });
        local u380 = "Weld";
        local u381 = nil;
        local u386 = (function(p382) --[[ Line: 8 ]]
            -- upvalues: u380 (copy), u381 (copy)
            local v383 = Instance.new(u380);
            for v384, v385 in p382 do
                if type(v384) == "number" then
                    v385.Parent = v383;
                else
                    v383[v384] = v385;
                end;
            end;
            v383.Parent = v383.Parent or u381;
            return v383;
        end)({
            Parent = u367,
            Part0 = u367,
            Part1 = u379,
            C0 = u369 * CFrame.Angles(math.rad(u370), 0, 0),
            C1 = CFrame.new(0, 1.9, 0)
        });
        local u387 = "SelectionBox";
        local u388 = nil;
        (function(p389) --[[ Line: 8 ]]
            -- upvalues: u387 (copy), u388 (copy)
            local v390 = Instance.new(u387);
            for v391, v392 in p389 do
                if type(v391) == "number" then
                    v392.Parent = v390;
                else
                    v390[v391] = v392;
                end;
            end;
            v390.Parent = v390.Parent or u388;
            return v390;
        end)({
            Parent = u379,
            Adornee = u379,
            SurfaceColor3 = v366,
            SurfaceTransparency = 0,
            Transparency = 1,
            LineThickness = 0
        });
        if p365 then
            local u393 = "SurfaceGui";
            local u394 = nil;
            local function v399(p395) --[[ Line: 8 ]]
                -- upvalues: u393 (copy), u394 (copy)
                local v396 = Instance.new(u393);
                for v397, v398 in p395 do
                    if type(v397) == "number" then
                        v398.Parent = v396;
                    else
                        v396[v397] = v398;
                    end;
                end;
                v396.Parent = v396.Parent or u394;
                return v396;
            end;
            local v400 = {
                Parent = u379,
                Face = "Back"
            };
            local u401 = "ImageLabel";
            local u402 = nil;
            v400[1] = (function(p403) --[[ Line: 8 ]]
    -- upvalues: u401 (copy), u402 (copy)
    local v404 = Instance.new(u401);
    for v405, v406 in p403 do
        if type(v405) == "number" then
            v406.Parent = v404;
        else
            v404[v405] = v406;
        end;
    end;
    v404.Parent = v404.Parent or u402;
    return v404;
end)({
    Size = UDim2.new(1, 0, 1, 0),
    [u20] = 1,
    Image = p365 and "rbxassetid://" .. u39.RImage(p365) or ""
});
            v399(v400);
        end;
        local function u409(u407) --[[ Line: 1240 ]]
            -- upvalues: u28 (ref), u371 (ref), u367 (ref), u368 (ref), u379 (copy), u39 (ref), u372 (ref), u370 (ref), u386 (ref), u369 (copy), u409 (copy)
            u28(function() --[[ Line: 1241 ]]
                -- upvalues: u407 (ref), u371 (ref), u367 (ref), u368 (ref)
                while not u407 do
                    u371 = (u367.CFrame:inverse() * (u367.CFrame + u368.MoveDirection)).z * u367.Velocity.magnitude;
                    task.wait();
                end;
            end);
            u28(function() --[[ Line: 1247 ]]
                -- upvalues: u379 (ref), u39 (ref), u372 (ref), u367 (ref), u370 (ref), u371 (ref), u386 (ref), u369 (ref), u407 (ref), u409 (ref)
                while u379 and u39.onCam(u379.Position) do
                    task.wait();
                    u372 = u367.Velocity.y;
                    local v408 = math.max(u370 * 0.9 + (u372 + u371) * 0.25, u372 < 0 and -170 or -100);
                    u370 = math.min(-3, v408);
                    u386.C0 = u369 * CFrame.Angles(math.rad(u370), 0, 0);
                end;
                u407 = true;
                if u379 then
                    while u379 and not u39.onCam(u379.Position) do
                        task.wait();
                    end;
                    u409();
                end;
            end);
        end;
        local u410 = nil;
        u28(function() --[[ Line: 1241 ]]
            -- upvalues: u410 (ref), u371 (ref), u367 (ref), u368 (ref)
            while not u410 do
                u371 = (u367.CFrame:inverse() * (u367.CFrame + u368.MoveDirection)).z * u367.Velocity.magnitude;
                task.wait();
            end;
        end);
        u28(function() --[[ Line: 1247 ]]
            -- upvalues: u379 (copy), u39 (ref), u372 (ref), u367 (ref), u370 (ref), u371 (ref), u386 (ref), u369 (copy), u410 (ref), u409 (copy)
            while u379 and u39.onCam(u379.Position) do
                task.wait();
                u372 = u367.Velocity.y;
                local v411 = math.max(u370 * 0.9 + (u372 + u371) * 0.25, u372 < 0 and -170 or -100);
                u370 = math.min(-3, v411);
                u386.C0 = u369 * CFrame.Angles(math.rad(u370), 0, 0);
            end;
            u410 = true;
            if u379 then
                while u379 and not u39.onCam(u379.Position) do
                    task.wait();
                end;
                u409();
            end;
        end);
    end;
end;
local u413 = u15.Collection:GetTagged("KAICrown");
local u414 = u15.Collection:GetTagged("KAIRCrown");
u15.Run.Heartbeat:connect(function() --[[ Line: 1269 ]]
    -- upvalues: u413 (copy), u414 (copy)
    if #u413 > 0 or #u414 > 0 then
        local v415 = time();
        local v416 = v415 % 6.283185307179586;
        local v417 = CFrame.new(0, math.sin(v416) / 8, 0) * CFrame.Angles(0, v416, 0);
        local v418 = Color3.fromHSV(v415 / 10 % 1, 1, 1);
        for v419, v420 in u413 do
            if v420 and v420.Parent then
                if v420.Handle:FindFirstChild("AccessoryWeld") then
                    v420.Handle.AccessoryWeld.C1 = v417;
                end;
            else
                table.remove(u413, v419);
            end;
        end;
        for v421, v422 in u414 do
            if v422 and v422.Parent then
                if v422.Handle:FindFirstChild("AccessoryWeld") then
                    v422.Handle.AccessoryWeld.C1 = v417;
                end;
                local l__Handle__37 = v422.Handle;
                local l__Fire__38 = v422.Handle.Fire;
                l__Handle__37.Color = v418;
                l__Fire__38.SecondaryColor = v418;
            else
                table.remove(u414, v421);
            end;
        end;
    end;
end);
u15.Collection:GetInstanceAddedSignal("KAICrown"):Connect(function(p423) --[[ Line: 1296 ]]
    -- upvalues: u413 (copy)
    table.insert(u413, p423);
end);
u15.Collection:GetInstanceAddedSignal("KAIRCrown"):Connect(function(p424) --[[ Line: 1299 ]]
    -- upvalues: u414 (copy)
    table.insert(u414, p424);
end);
u15.Collection:GetInstanceRemovedSignal("KAICrown"):Connect(function(p425) --[[ Line: 1302 ]]
    -- upvalues: u413 (copy)
    table.remove(u413, table.find(u413, p425));
end);
u15.Collection:GetInstanceRemovedSignal("KAIRCrown"):Connect(function(p426) --[[ Line: 1305 ]]
    -- upvalues: u414 (copy)
    table.remove(u414, table.find(u414, p426));
end);
function u39.HookList(u427, _, u428, _) --[[ Line: 1321 ]]
    -- upvalues: u16 (ref), u28 (copy), u39 (copy)
    local u429 = u16(u427, "List") or u16(u427, "BG");
    local u430 = false;
    local u431 = u427.Hide.MouseButton1Click:connect(function() --[[ Line: 1324 ]]
        -- upvalues: u430 (ref), u429 (ref), u28 (ref), u39 (ref), u427 (copy)
        if not u430 then
            u430 = true;
            if u429.Parent.Name ~= "BG" then
                u28(u39[u427.BG.Visible and "Hide" or "Show"], u429);
            end;
            u39[u427.BG.Visible and "Hide" or "Show"](u427.BG);
            u427.Hide.Text = u427.BG.Visible and "-" or "+";
            u430 = false;
        end;
    end);
    local _ = u427.Close.MouseButton1Click:connect(function() --[[ Line: 1335 ]]
        -- upvalues: u431 (ref), u428 (ref), u39 (ref), u427 (copy)
        u431:disconnect();
        u428:disconnect();
        u39.Hide(u427, true);
    end);
end;
function u39.CreateList(p432, _, _, _) --[[ Line: 1341 ]]
    -- upvalues: u39 (copy), u183 (copy)
    local v433 = u39.template.List:Clone();
    v433.Parent = u183;
    v433.Title.Text = p432;
    v433.Name = p432;
    u39.HookList(v433);
    return v433;
end;
function u39.FixUI(p434) --[[ Line: 1348 ]]
    -- upvalues: u20 (ref), u24 (ref), u39 (copy)
    if p434.Name == "BG" or p434.Name == "Bar" then
        p434[u20] = u24.ColorTransparency;
        p434.BackgroundColor3 = u24.Color;
    end;
    for _, v435 in p434:GetChildren() do
        u39.FixUI(v435);
    end;
end;
function u39.UpdateUI() --[[ Line: 1357 ]]
    -- upvalues: u24 (ref), u16 (ref), l__LocalPlayer__1 (ref), u39 (copy), u183 (copy)
    if not u24.ForcedColor then
        if u16(l__LocalPlayer__1, "KColor") then
            u24.Color = l__LocalPlayer__1.KColor.Value;
        end;
        if u16(l__LocalPlayer__1, "KColorTransparency") then
            u24.ColorTransparency = l__LocalPlayer__1.KColorTransparency.Value;
        end;
    end;
    u39.FixUI(u183);
    for _, v436 in u39.template do
        u39.FixUI(v436);
    end;
end;
function u39.UpdateSet() --[[ Line: 1371 ]]
    -- upvalues: u39 (copy), u331 (copy), u24 (ref), u194 (copy), u195 (copy), u15 (copy), u183 (copy)
    u39.UpdateAdmins();
    u331.Toggle.Visible = u24.AdminCredit;
    local l__Chat__39 = u24.Chat;
    if l__Chat__39 then
        l__Chat__39 = u194;
    end;
    u195.Visible = l__Chat__39;
    u15.StarterGui:SetCoreGuiEnabled("Chat", not u24.Chat);
    if u183.Parent and u183.Parent:FindFirstChild("Chat") then
        u183.Parent.Chat.Enabled = not l__Chat__39;
    end;
    u39.UpdateUI();
end;
function u39.BumpList(p437) --[[ Line: 1382 ]]
    for v438, v439 in p437.List:GetChildren() do
        v439.Position = UDim2.new(0, 5, 0, (v438 - 1) * 20);
    end;
end;
function u39.NoteCheck(p440, p441) --[[ Line: 1387 ]]
    local v442;
    if p440[1] <= p441.X and (p440[2] >= p441.X and p440[3] <= p441.Y) then
        v442 = p440[4] >= p441.Y;
    else
        v442 = false;
    end;
    return v442;
end;
function u39.Note(u443, u444, u445, u446) --[[ Line: 1390 ]]
    -- upvalues: u191 (copy), u39 (copy), u183 (copy), u28 (copy), u22 (ref), u23 (ref), u342 (ref)
    u443.MouseEnter:connect(function() --[[ Line: 1391 ]]
        -- upvalues: u445 (ref), u191 (ref), u39 (ref), u444 (copy), u183 (ref), u28 (ref), u446 (ref), u443 (copy), u22 (ref), u23 (ref), u342 (ref)
        u445 = u191.Note;
        if u445 then
            u445:Destroy();
        end;
        u445 = u39.template.Note:Clone();
        u191.Note = u445;
        local v447 = u445;
        local v448 = u183;
        u445.Text = u444 or "";
        v447.Parent = v448;
        u445.Size = UDim2.new(0, u445.TextBounds.X + 10, 0, 24);
        u445.Visible = true;
        u28(function() --[[ Line: 1401 ]]
            -- upvalues: u446 (ref), u443 (ref), u22 (ref), u23 (ref), u445 (ref), u342 (ref), u39 (ref)
            u446 = {
                u443[u22].X,
                u443[u22].X + u443[u23].X,
                u443[u22].Y,
                u443[u22].Y + u443[u23].Y
            };
            repeat
                u445.Position = UDim2.new(0, u342.X, 0, u342.Y + 36 - 25);
                task.wait();
            until not (u445 and (u342 and u39.NoteCheck(u446, u342)));
            if u445 then
                u445:Destroy();
            end;
        end);
    end);
end;
function u39.Search(p449, p450, p451, _) --[[ Line: 1413 ]]
    local v454 = p451 or function(p452, p453) --[[ Line: 1414 ]]
        return p452 == p453;
    end;
    local v455 = {};
    for v456, v457 in p449 do
        if v454(v457, p450) then
            if type(v456) == "string" then
                v455[v456] = v457;
            else
                v455[#v455 + 1] = v457;
            end;
        end;
    end;
    return v455;
end;
function u39.GetSearch(p458, _) --[[ Line: 1428 ]]
    -- upvalues: u39 (copy)
    local v459 = u39.template.Search:Clone();
    v459.Parent = p458;
    return v459;
end;
function u39.KeyDown(p460) --[[ Line: 1433 ]]
    -- upvalues: u15 (copy)
    return u15.UIS:IsKeyDown(p460);
end;
function u39.HookToggle(u461, u462) --[[ Line: 1436 ]]
    -- upvalues: u38 (copy), u39 (copy), u24 (ref)
    u461.MouseButton1Click:connect(function(_) --[[ Line: 1437 ]]
        -- upvalues: u461 (copy), u462 (copy), u38 (ref), u39 (ref), u24 (ref)
        local v463 = u461.BackgroundColor3 == Color3.new();
        u461.BackgroundColor3 = v463 and Color3.new(1, 1, 1) or Color3.new();
        if u462 then
            u462(u461, v463);
            u38:FireServer(u39.uID .. "KUpdate", u24);
        end;
    end);
end;
function u39.HookInput(u464, u465) --[[ Line: 1446 ]]
    -- upvalues: u38 (copy), u39 (copy), u24 (ref)
    u464.Changed:connect(function(p466) --[[ Line: 1447 ]]
        -- upvalues: u464 (copy), u465 (copy), u38 (ref), u39 (ref), u24 (ref)
        if p466 == "Text" and u464.Text ~= "" then
            u465(u464);
            u38:FireServer(u39.uID .. "KUpdate", u24);
        end;
    end);
end;
local u467 = {
    Flat = "Gives the UI a flat appearance",
    ForcedColor = "Forces everyone to have set color & transparency",
    Color = "Changes the Color of the user interface",
    ColorTransparency = "Changes the Transparency of the user interface",
    Chat = "Enables the custom chat",
    BubbleChat = "Enables the custom bubble chat",
    AdminCredit = "Enables the credit GUI for that appears in the bottom right",
    AutoClean = "Enables automatic cleaning of hats & tools in the Workspace",
    AutoCleanDelay = "The delay between each AutoClean routine",
    CommandBar = "Enables the Command Bar | GLOBAL KEYBIND: ;",
    FunCommands = "Enables fun yet unnecessary commands",
    FreeAdmin = "Set to 1-5.\t1-VIP 2-Mod 3-Admin 4-SuperAdmin 5-Owner",
    PublicLogs = "Allows all users to see the command & chat logs",
    Prefix = "Character to begin a command"
};
local u468 = false;
function ClientEvent(p469, p470)
    -- upvalues: u39 (copy), u30 (ref), u24 (ref), u31 (ref), u29 (ref), u34 (ref), u28 (copy), u343 (ref), l__LocalPlayer__1 (ref), u340 (ref), u342 (ref), u346 (ref), u38 (copy), u42 (ref), u43 (ref), u15 (copy), u16 (ref), u183 (copy), u190 (copy), u467 (copy), u341 (ref), u339 (ref), u345 (ref), l__Players__35 (copy), u191 (copy), l__Msg__13 (copy), u14 (copy), u344 (ref), u412 (copy), u468 (ref)
    if p469 == "KuID" then
        local v471 = u39;
        local v472 = p470[1];
        local v473 = p470[2];
        local v474 = p470[3];
        local v475 = p470[4];
        local v476 = p470[5];
        local v477 = p470[6];
        v471.uID = v472;
        u30 = v473;
        u24 = v474;
        u31 = v475;
        u29 = v476;
        u34 = v477;
        if u24.Chat then
            u28(Chat, "Chat \'/?\' for a list of commands");
        end;
        u39.UpdateSet();
    else
        if not (u343 and (l__LocalPlayer__1 and (u340 and (u342 and u346)))) then
            u39.UpdateVar();
        end;
        if p469 == "KCrash" then
            while true do

            end;
        else
            if p469 == "KPing" then
                u38:FireServer(u39.uID .. "KPing");
            elseif p469 == "KUpdate" and p470 then
                u24 = p470;
                u39.UpdateSet();
            elseif p469 == "KUpdateLog" and p470 then
                if #u29 > 300 then
                    table.remove(u29, #u29);
                end;
                table.insert(u29, 1, p470);
                u42.Value = not u42.Value;
            elseif p469 == "KUpdateCLog" and p470 then
                if #u34 > 300 then
                    table.remove(u34, #u34);
                end;
                table.insert(u34, 1, p470);
                u43.Value = not u43.Value;
            elseif p469 == "KUpdateLogs" and p470 then
                u29 = p470;
                table.sort(u29, function(p478, p479) --[[ Line: 1506 ]]
                    return p478[1] > p479[1];
                end);
                u42.Value = not u42.Value;
            elseif p469 == "KUpdateCLogs" and p470 then
                u34 = p470;
                table.sort(u34, function(p480, p481) --[[ Line: 1512 ]]
                    return p480[1] > p481[1];
                end);
                u43.Value = not u43.Value;
            elseif p469 == "KChat" then
                Chat(p470[1], p470[2]);
            elseif p469 == "KFakeChat" then
                u38:FireServer(u39.uID .. "KChat", { l__LocalPlayer__1.Name, p470 });
                Chat(l__LocalPlayer__1.Name, p470);
            elseif p469 == "KBuy" then
                u15.Market:PromptPurchase(l__LocalPlayer__1, p470);
            elseif p469 == "KBuyBundle" then
                u15.Market:PromptBundlePurchase(l__LocalPlayer__1, p470);
            elseif p469 == "KBuyGamePass" then
                u15.Market:PromptGamePassPurchase(l__LocalPlayer__1, p470);
            elseif p469 == "KBuyProduct" then
                u15.Market:PromptProductPurchase(l__LocalPlayer__1, p470);
            elseif p469 == "KHelp" then
                local v482 = u16(u183, "Help");
                if v482 then
                    u28(u39.Hide, v482, true);
                end;
                local v483 = u39.template.Help:Clone();
                v483.List.Prefix.Text = "The prefix is \"" .. u24.Prefix .. "\"";
                v483.Parent = u183;
                u39.HookList(v483);
                u39.Drag(v483, 300, 300);
                u39.Show(v483);
            elseif p469 == "KTools" then
                if u16(u183, "Tools") then
                    u28(u39.Hide, u183.Tools, true);
                end;
                local v484 = u39.CreateList("Tools");
                table.sort(p470);
                for v485, v486 in p470 do
                    local v487 = u190:Clone();
                    local l__List__40 = v484.List;
                    local v488 = UDim2.new(0, 5, 0, (v485 - 1) * 20);
                    v487.Parent = l__List__40;
                    v487.Text = v486;
                    v487.Position = v488;
                end;
                v484.List.CanvasSize = UDim2.new(1, 0, 0, #v484.List:GetChildren() * 20);
                u39.Drag(v484, 200, 220);
                u39.Show(v484);
            elseif p469 == "KSettings" then
                local v489 = u16(u183, "Settings");
                if v489 then
                    u28(u39.Hide, v489, true);
                end;
                if not p470 then
                    return;
                end;
                u24 = p470;
                local u490 = u39.template.Settings:Clone();
                u490.Parent = u183;
                u39.HookList(u490);
                if u24.IGS then
                    u490.Toggle.BackgroundColor3 = Color3.new(1, 1, 1);
                    u490.List.Visible = true;
                end;
                u39.HookToggle(u490.Toggle, function(p491, p492) --[[ Line: 1569 ]]
                    -- upvalues: u24 (ref), u28 (ref), u39 (ref), u490 (copy)
                    local v493 = u24;
                    local l__List__41 = p491.Parent.List;
                    v493.IGS = p492;
                    l__List__41.Visible = p492;
                    if not p492 then
                        u28(u39.Hide, u490, true);
                    end;
                end);
                for _, u494 in u490.List:GetChildren() do
                    if u494:IsA("GuiObject") then
                        local l__Text__42 = u494.Text;
                        if u24[l__Text__42] ~= nil then
                            u39.Note(u494, u467[l__Text__42]);
                            if l__Text__42 == "Color" then
                                local l__Input1__43 = u494.Input1;
                                local l__Input2__44 = u494.Input2;
                                local l__Input3__45 = u494.Input3;
                                local v495 = u24[l__Text__42].r * 255;
                                local v496 = u24[l__Text__42].g * 255;
                                local v497 = u24[l__Text__42].b * 255;
                                l__Input1__43.Text = v495;
                                l__Input2__44.Text = v496;
                                l__Input3__45.Text = v497;
                                u39.HookInput(u494.Input1, function(p498, _) --[[ Line: 1584 ]]
                                    -- upvalues: u24 (ref), l__Text__42 (ref)
                                    local v499 = tonumber(p498.Text);
                                    if v499 and (v499 <= 255 and v499 >= 0) then
                                        u24[l__Text__42] = Color3.new(v499 / 255, u24[l__Text__42].g, u24[l__Text__42].b);
                                    else
                                        p498.Text = u24[l__Text__42];
                                    end;
                                end);
                                u39.HookInput(u494.Input2, function(p500, _) --[[ Line: 1592 ]]
                                    -- upvalues: u24 (ref), l__Text__42 (ref)
                                    local v501 = tonumber(p500.Text);
                                    if v501 and (v501 <= 255 and v501 >= 0) then
                                        u24[l__Text__42] = Color3.new(u24[l__Text__42].r, v501 / 255, u24[l__Text__42].b);
                                    else
                                        p500.Text = u24[l__Text__42];
                                    end;
                                end);
                                u39.HookInput(u494.Input3, function(p502, _) --[[ Line: 1600 ]]
                                    -- upvalues: u24 (ref), l__Text__42 (ref)
                                    local v503 = tonumber(p502.Text);
                                    if v503 and (v503 <= 255 and v503 >= 0) then
                                        u24[l__Text__42] = Color3.new(u24[l__Text__42].r, u24[l__Text__42].g, v503 / 255);
                                    else
                                        p502.Text = u24[l__Text__42];
                                    end;
                                end);
                            elseif l__Text__42 == "ColorTransparency" then
                                u494.Input.Text = u24[l__Text__42];
                                u39.HookInput(u494.Input, function(p504, _) --[[ Line: 1610 ]]
                                    -- upvalues: u24 (ref), l__Text__42 (ref)
                                    local v505 = tonumber(p504.Text);
                                    if v505 and (v505 <= 1 and v505 >= 0) then
                                        u24[l__Text__42] = v505;
                                    else
                                        if p504.Text ~= "." then
                                            p504.Text = u24[l__Text__42];
                                        end;
                                    end;
                                end);
                            elseif l__Text__42 == "AutoCleanDelay" then
                                u494.Input.Text = u24[l__Text__42];
                                u39.HookInput(u494.Input, function(p506, _) --[[ Line: 1620 ]]
                                    -- upvalues: u24 (ref), l__Text__42 (ref)
                                    local v507 = tonumber(p506.Text);
                                    if v507 and v507 >= 0 then
                                        u24[l__Text__42] = v507;
                                    else
                                        p506.Text = u24[l__Text__42];
                                    end;
                                end);
                            elseif l__Text__42 == "Prefix" then
                                u494.Input.Text = u24[l__Text__42];
                                u39.HookInput(u494.Input, function(p508, _) --[[ Line: 1630 ]]
                                    -- upvalues: u24 (ref), l__Text__42 (ref)
                                    local v509 = p508.Text:gsub("%s", "");
                                    if #v509 == 1 then
                                        u24[l__Text__42] = v509;
                                    else
                                        p508.Text = u24[l__Text__42];
                                    end;
                                end);
                            elseif l__Text__42 == "FreeAdmin" then
                                local l__Input__46 = u494.Input;
                                local l__Input__47 = u494.Input;
                                local l__Toggle__48 = u494.Toggle;
                                local v510 = u24[l__Text__42];
                                local v511 = u24[l__Text__42] or "";
                                local v512 = u24[l__Text__42] and Color3.new(1, 1, 1) or Color3.new();
                                l__Input__46.Visible = v510;
                                l__Input__47.Text = v511;
                                l__Toggle__48.BackgroundColor3 = v512;
                                u39.HookInput(u494.Input, function(p513, _) --[[ Line: 1641 ]]
                                    -- upvalues: u24 (ref), l__Text__42 (ref)
                                    local v514 = tonumber(p513.Text);
                                    if v514 and (v514 < 6 and v514 > 0) then
                                        u24[l__Text__42] = v514;
                                    else
                                        p513.Text = u24[l__Text__42];
                                    end;
                                end);
                                u39.HookToggle(u494.Toggle, function(_, p515) --[[ Line: 1649 ]]
                                    -- upvalues: u494 (copy), u24 (ref), l__Text__42 (ref)
                                    u494.Input.Visible = p515;
                                    if not p515 then
                                        u24[l__Text__42] = p515;
                                    end;
                                end);
                            elseif u16(u494, "Toggle") then
                                u494.Toggle.BackgroundColor3 = u24[l__Text__42] and Color3.new(1, 1, 1) or Color3.new();
                                u39.HookToggle(u494.Toggle, function(_, p516) --[[ Line: 1657 ]]
                                    -- upvalues: u24 (ref), l__Text__42 (ref)
                                    u24[l__Text__42] = p516;
                                end);
                            end;
                        end;
                    end;
                end;
                u39.Drag(u490, 200, 220);
                u39.Show(u490);
            elseif p469 == "KCmds" then
                local v517 = u16(u183, "Commands");
                if v517 then
                    u28(u39.Hide, v517, true);
                end;
                local v518 = u39.CreateList("Commands");
                local v519, _ = u39.template.Blank:Clone();
                local l__List__49 = v518.List;
                v519.Parent = v518;
                v519.Name = "List";
                l__List__49.Parent = v519;
                v518.Size = UDim2.new(0, 300, 0, 20);
                l__List__49.Size = UDim2.new(1, 0, 0, 260);
                v518.BG.Size = UDim2.new(1, 0, 0, 260);
                local u520 = {};
                for _, v521 in p470[1] do
                    if v521[3] <= p470[2] or p470[3][v521[1][1]] then
                        table.insert(u520, v521);
                    end;
                end;
                table.sort(u520, function(p522, p523) --[[ Line: 1682 ]]
                    return p522[1][1] < p523[1][1];
                end);
                local function u532(p524) --[[ Line: 1685 ]]
                    -- upvalues: l__List__49 (ref), u190 (ref), u39 (ref), u24 (ref)
                    for _, v525 in l__List__49:GetChildren() do
                        v525:Destroy();
                    end;
                    for v526, v527 in p524 do
                        local v528 = u190:Clone();
                        local v529 = l__List__49;
                        local v530 = v526 .. "\t" .. v527[1][1] .. " " .. table.concat(v527[4], " ");
                        local v531 = UDim2.new(0, 5, 0, (v526 - 1) * 20);
                        v528.FontSize = "Size18";
                        v528.Parent = v529;
                        v528.Text = v530;
                        v528.Position = v531;
                        u39.Note(v528, u39.getTitle(v527[3]) .. "+\t" .. u24.Prefix .. "[" .. table.concat(v527[1], "/") .. "] " .. (v527[2][2] or ""));
                    end;
                    l__List__49.CanvasSize = UDim2.new(1, 0, 0, #l__List__49:GetChildren() * 20);
                end;
                local l__BG__50 = u39.GetSearch(v519).BG;
                l__BG__50.Parent.Position = UDim2.new(0, 0, 0, 282);
                l__BG__50.Changed:connect(function(p533) --[[ Line: 1702 ]]
                    -- upvalues: u532 (copy), u39 (ref), u520 (ref), l__BG__50 (copy)
                    if p533 == "Text" then
                        u532(u39.Search(u520, l__BG__50.Text, function(p534, p535, p536) --[[ Line: 1704 ]]
                            for _, v537 in p534[1] do
                                if v537:lower():find(p535:lower()) then
                                    p536 = true;
                                end;
                            end;
                            return p536;
                        end));
                    end;
                end);
                u532(u520);
                u39.Drag(v518, 300, 300);
                u39.Show(v518);
            elseif p469 == "KAdmins" then
                local u538 = u16(u183, "Admins");
                if u538 then
                    u28(u39.Hide, u538, true);
                end;
                local u539 = u39.CreateList("Admins");
                local function u557() --[[ Line: 1723 ]]
                    -- upvalues: u538 (ref), u539 (copy), u30 (ref), u15 (ref), u190 (ref), u39 (ref), u28 (ref)
                    u538 = {};
                    for _, v540 in u539.List:GetChildren() do
                        v540:Destroy();
                    end;
                    for v541, v542 in u30 do
                        if math.abs(v542) ~= 1 or u15.Players:GetPlayerByUserId(v541) then
                            table.insert(u538, { v541, v542 });
                        end;
                    end;
                    table.sort(u538, function(p543, p544) --[[ Line: 1733 ]]
                        return math.abs(p543[2]) > math.abs(p544[2]);
                    end);
                    for u545, u546 in u538 do
                        local u547 = u190:Clone();
                        local v548 = u190:Clone();
                        local v549 = (u546[2] < 0 and "P. " or "") .. u39.getTitle((math.abs(u546[2])));
                        local v550 = UDim2.new(0.5, 0, 0, 20);
                        local v551 = UDim2.new(0.5, 0, 0, 0);
                        v548.Text = v549;
                        v548.TextXAlignment = "Right";
                        v548.Parent = u547;
                        v548.Size = v550;
                        v548.Position = v551;
                        u28(function() --[[ Line: 1740 ]]
                            -- upvalues: u547 (copy), u539 (ref), u39 (ref), u546 (copy), u545 (copy)
                            local v552 = u547;
                            local v553 = u547;
                            local v554 = u547;
                            local l__List__51 = u539.List;
                            local v555 = u39.getNameFromId(u546[1]);
                            local v556 = UDim2.new(0, 5, 0, (u545 - 1) * 20);
                            v552.Parent = l__List__51;
                            v553.Text = v555;
                            v554.Position = v556;
                            u539.List.CanvasSize = UDim2.new(1, 0, 0, #u539.List:GetChildren() * 20);
                        end);
                    end;
                end;
                u557();
                local u558 = nil;
                u558 = u341.Changed:connect(function() --[[ Line: 1748 ]]
                    -- upvalues: u539 (copy), u183 (ref), u558 (ref), u557 (copy)
                    if u539 and u539.Parent == u183 then
                        task.wait();
                        u557();
                    else
                        u558:disconnect();
                    end;
                end);
                u39.Drag(u539, 200, 220);
                u39.Show(u539);
            elseif p469 == "KBans" then
                local u559 = u16(u183, "Bans");
                if u559 then
                    u28(u39.Hide, u559, true);
                end;
                local u560 = u39.CreateList("Bans");
                local function u575() --[[ Line: 1764 ]]
                    -- upvalues: u559 (ref), u560 (copy), u339 (ref), u190 (ref), u28 (ref), u39 (ref)
                    u559 = {};
                    for _, v561 in u560.List:GetChildren() do
                        v561:Destroy();
                    end;
                    for v562, v563 in u339 do
                        local v564 = u559;
                        local v565 = { tonumber(v562), v563 };
                        table.insert(v564, v565);
                    end;
                    table.sort(u559, function(p566, p567) --[[ Line: 1772 ]]
                        return p566[2] > p567[2];
                    end);
                    for u568, u569 in u559 do
                        local u570 = u190:Clone();
                        local u571 = u190:Clone();
                        u28(function() --[[ Line: 1777 ]]
                            -- upvalues: u571 (copy), u569 (copy), u570 (copy), u39 (ref), u568 (copy), u560 (ref)
                            u571.TextXAlignment = "Right";
                            u571.Size = UDim2.new(0.5, 0, 0, 20);
                            u571.Position = UDim2.new(0.5, 0, 0, 0);
                            u571.Text = u569[2] < 2 and "Permanently" or "From Server";
                            u571.Parent = u570;
                            u570.Text = u39.getNameFromId(u569[1]);
                            u570.Position = UDim2.new(0, 5, 0, (u568 - 1) * 20);
                            u570.Parent = u560.List;
                            u560.List.CanvasSize = UDim2.new(1, 0, 0, #u560.List:GetChildren() * 20);
                            if u569[2] < -1 then
                                local v572 = -u569[2];
                                local v573;
                                repeat
                                    local v574 = v572 - os.time();
                                    v573 = math.floor(v574);
                                    u571.Text = v573 .. " seconds";
                                    task.wait(1);
                                until not u570 or v573 <= 0;
                                if u570 then
                                    u570:Destroy();
                                    u39.BumpList(u560);
                                end;
                            end;
                        end);
                    end;
                end;
                u575();
                local u576 = nil;
                u576 = u345.Changed:connect(function() --[[ Line: 1804 ]]
                    -- upvalues: u560 (copy), u183 (ref), u576 (ref), u575 (copy)
                    if u560 and u560.Parent == u183 then
                        task.wait();
                        u575();
                    else
                        u576:disconnect();
                    end;
                end);
                u39.Drag(u560, 200, 220);
                u39.Show(u560);
            elseif p469 == "KLogs" then
                local v577 = u16(u183, p470);
                if v577 then
                    u28(u39.Hide, v577, true);
                end;
                local u578, _, _ = u39.CreateList(p470);
                u578.Size = UDim2.new(0, 300, 0, 20);
                u578.BG.Size = UDim2.new(1, 0, 0, 260);
                local l__BG__52 = u578.BG;
                local l__List__53 = u578.List;
                local v579 = UDim2.new();
                local v580 = UDim2.new(1, 0, 1, 0);
                l__List__53.Position = v579;
                l__List__53.Size = v580;
                l__List__53.Parent = l__BG__52;
                local function u589(p581) --[[ Line: 1825 ]]
                    -- upvalues: l__List__53 (ref), u190 (ref), u39 (ref)
                    local v582 = 0;
                    for _, v583 in l__List__53:GetChildren() do
                        v583:Destroy();
                    end;
                    for _, v584 in p581 do
                        if v584[1] and v584[2] then
                            v582 = v582 + 1;
                            local v585 = u190:Clone();
                            local v586 = l__List__53;
                            local v587 = u39.getTime(v584[1]) .. "\t" .. v584[2];
                            local v588 = UDim2.new(0, 5, 0, (v582 - 1) * 20);
                            v585.FontSize = "Size18";
                            v585.Parent = v586;
                            v585.Text = v587;
                            v585.Position = v588;
                            u39.Note(v585, v584[2]:match(":%s(.+)"));
                        end;
                    end;
                    l__List__53.CanvasSize = UDim2.new(1, 0, 0, #l__List__53:GetChildren() * 20);
                end;
                local l__BG__54 = u39.GetSearch(l__BG__52).BG;
                l__BG__54.Parent.Position = UDim2.new(0, 0, 1, 2);
                l__BG__54.Changed:connect(function(p590) --[[ Line: 1843 ]]
                    -- upvalues: u589 (copy), u39 (ref), u29 (ref), l__BG__54 (copy)
                    if p590 == "Text" then
                        u589(u39.Search(u29, l__BG__54.Text, function(p591, p592) --[[ Line: 1845 ]]
                            return p591[2]:lower():find(p592:lower());
                        end));
                    end;
                end);
                u589(u29);
                local u593 = nil;
                u593 = u42.Changed:connect(function() --[[ Line: 1852 ]]
                    -- upvalues: u578 (copy), u183 (ref), u593 (ref), l__BG__54 (copy), u589 (copy), u29 (ref)
                    if u578 and u578.Parent == u183 then
                        if l__BG__54.Text:gsub("%s", "") == "" or l__BG__54.Text == "Type here to search" then
                            u589(u29);
                        end;
                    else
                        u593:disconnect();
                    end;
                end);
                u39.Drag(u578, 300, 300);
                u39.Resize(l__BG__52, 300, 260);
                u39.Show(u578);
            elseif p469 == "KCLogs" then
                local v594 = u16(u183, p470);
                if v594 then
                    u28(u39.Hide, v594, true);
                end;
                local u595, _, _ = u39.CreateList(p470);
                local l__BG__55 = u595.BG;
                local l__List__56 = u595.List;
                l__List__56.Parent = l__BG__55;
                u595.Size = UDim2.new(0, 300, 0, 20);
                local v596 = UDim2.new();
                local v597 = UDim2.new(1, 0, 1, 0);
                l__List__56.Position = v596;
                l__List__56.Size = v597;
                u595.BG.Size = UDim2.new(1, 0, 0, 260);
                local function u606(p598) --[[ Line: 1875 ]]
                    -- upvalues: l__List__56 (ref), u190 (ref), u39 (ref)
                    local v599 = 0;
                    for _, v600 in l__List__56:GetChildren() do
                        v600:Destroy();
                    end;
                    for _, v601 in p598 do
                        if v601[1] and v601[2] then
                            v599 = v599 + 1;
                            local v602 = u190:Clone();
                            local v603 = l__List__56;
                            local v604 = u39.getTime(v601[1]) .. "\t" .. v601[2];
                            local v605 = UDim2.new(0, 5, 0, (v599 - 1) * 20);
                            v602.FontSize = "Size18";
                            v602.Parent = v603;
                            v602.Text = v604;
                            v602.Position = v605;
                            u39.Note(v602, v601[2]:match(":%s(.+)"));
                        end;
                    end;
                    l__List__56.CanvasSize = UDim2.new(1, 0, 0, #l__List__56:GetChildren() * 20);
                end;
                local l__BG__57 = u39.GetSearch(l__BG__55).BG;
                l__BG__57.Parent.Position = UDim2.new(0, 0, 1, 2);
                l__BG__57.Changed:connect(function(p607) --[[ Line: 1893 ]]
                    -- upvalues: u606 (copy), u39 (ref), u34 (ref), l__BG__57 (copy)
                    if p607 == "Text" then
                        u606(u39.Search(u34, l__BG__57.Text, function(p608, p609) --[[ Line: 1895 ]]
                            return p608[2]:lower():find(p609:lower());
                        end));
                    end;
                end);
                u606(u34);
                local u610 = nil;
                u610 = u43.Changed:connect(function() --[[ Line: 1902 ]]
                    -- upvalues: u595 (copy), u183 (ref), u610 (ref), l__BG__57 (copy), u606 (copy), u34 (ref)
                    if u595 and u595.Parent == u183 then
                        if l__BG__57.Text:gsub("%s", "") == "" or l__BG__57.Text == "Type here to search" then
                            u606(u34);
                        end;
                    else
                        u610:disconnect();
                    end;
                end);
                u39.Drag(u595, 300, 300);
                u39.Resize(l__BG__55, 300, 260);
                u39.Show(u595);
            elseif p469 == "KCountDown" then
                local u611, u612 = unpack(p470);
                if u611 and tonumber(u612) then
                    local v613 = u16(u183, "Timer");
                    if v613 then
                        u28(u39.Hide, v613, true);
                        task.delay(2, u15.Run.UnbindFromRenderStep, u15.Run, "kCircleProgress");
                    end;
                    local u614 = u39.template.Timer:Clone();
                    u614.Time.Text = u612;
                    u614.Parent = u183;
                    local u615 = {
                        u614.Circle1,
                        u614.Circle2,
                        u614.Circle3,
                        u614.Circle4
                    };
                    local u616 = tick();
                    local function u625() --[[ Line: 1929 ]]
                        -- upvalues: u616 (copy), u612 (copy), u615 (copy)
                        local v617 = (tick() - u616) / u612;
                        local v618 = math.clamp(v617, 0, 1);
                        for v619, v620 in u615 do
                            local v621 = math.clamp((v618 - (v619 - 1) / 4) * 4, 0, 1);
                            if v621 > 0 then
                                local v622 = math.floor(v621 * 255);
                                local v623 = v622 % 16;
                                local v624 = math.floor(v622 / 16);
                                v620.ImageRectOffset = Vector2.new(v623 * 64, v624 * 64);
                                v620.Visible = true;
                            else
                                v620.Visible = false;
                            end;
                        end;
                    end;
                    task.spawn(function() --[[ Line: 1945 ]]
                        -- upvalues: u15 (ref), u625 (copy), u39 (ref), u614 (copy), u616 (copy), u612 (copy), u611 (copy)
                        u15.Run:BindToRenderStep("kCircleProgress", 1, u625);
                        u39.Show(u614);
                        while tick() - u616 < u612 and (u611 and u611.Parent) do
                            task.wait();
                            local l__Time__58 = u614.Time;
                            local v626 = u612 - (tick() - u616);
                            local v627 = math.floor(v626) + 1;
                            l__Time__58.Text = math.clamp(v627, 0, u612);
                        end;
                        u39.Hide(u614, true);
                        task.delay(2, u15.Run.UnbindFromRenderStep, u15.Run, "kCircleProgress");
                    end);
                end;
            elseif p469 == "KMsg" then
                local v628 = u16(u183, "Msg");
                if v628 then
                    u28(u39.Hide, v628, true);
                end;
                local v629 = u39.template.Msg:Clone();
                local v630 = p470[4];
                if v630 then
                    v630 = l__Players__35:GetUserThumbnailAsync(p470[4], Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100);
                end;
                local l__Owner__59 = v629.Owner;
                local l__Title__60 = v629.Title;
                local l__Msg__61 = v629.Msg;
                local v631 = u183;
                local v632 = p470[1];
                local v633 = p470[2];
                local v634 = p470[3];
                v629.Parent = v631;
                l__Owner__59.Text = v632;
                l__Title__60.Text = v633;
                l__Msg__61.Text = v634;
                local v635 = p470[1] == "Kohl\'s Admin Infinite";
                if v635 or v630 then
                    v629.User.Image = v635 and "rbxassetid://314925538" or v630;
                    v629.User.Position = UDim2.new(0.5, -80 - v629.Owner.TextBounds.X / 2, v629.User.Position.Y.Scale, v629.User.Position.Y.Offset);
                    v629.User.Visible = true;
                end;
                u39.Show(v629);
                local l__wait__62 = task.wait;
                local v636 = #tostring(p470[3]);
                l__wait__62(math.sqrt(v636) + 0.5);
                u39.Hide(v629, true);
            elseif p469 == "KHint" then
                local v637 = u16(u183, "Hint");
                if v637 then
                    u28(u39.Hide, v637, true);
                end;
                local v638 = u39.template.Hint:Clone();
                local l__BG__63 = v638.BG;
                v638.Parent = u183;
                l__BG__63.Text = p470;
                u39.Show(v638);
                task.wait(math.sqrt(#p470) + 0.5);
                u39.Hide(v638, true);
            elseif p469 == "KNotify" then
                local v639 = u16(u183, "Notify");
                if v639 then
                    u28(u39.Hide, v639, true);
                end;
                if p470 then
                    local v640 = u39.template.Hint:Clone();
                    local l__BG__64 = v640.BG;
                    local v641 = u183;
                    v640.Name = "Notify";
                    v640.Parent = v641;
                    l__BG__64.Text = p470;
                    u39.Show(v640);
                end;
            elseif p469 == "KError" then
                local v642 = u16(u183, "Error");
                if v642 then
                    u28(u39.Hide, v642, true);
                end;
                if p470 then
                    local v643 = u39.template.Error:Clone();
                    local v644 = u183;
                    v643.Msg.Text = p470;
                    v643.Parent = v644;
                    u39.Show(v643);
                    local l__wait__65 = task.wait;
                    local v645 = math.sqrt(#p470) / 2 + 1;
                    l__wait__65((math.max(2, v645)));
                    u39.Hide(v643, true);
                end;
            elseif p469 == "KWatch" then
                u343.CameraSubject = p470 or l__LocalPlayer__1.Character;
            elseif p469 == "KBlind" then
                local v646 = u16(u183, "Blind");
                if v646 then
                    u28(u39.Hide, v646, true);
                end;
                if p470 then
                    local v647 = u39.template.Blind:Clone();
                    v647.Parent = u183;
                    u39.Show(v647);
                end;
            elseif p469 == "KLag" then
                while u16(l__LocalPlayer__1, "KLag") do
                    for _ = 1, 999 do
                        print((Vector3.new() - Vector3.new()).magnitude);
                    end;
                    task.wait();
                end;
            elseif p469 == "KMute" then
                local v648 = "You have been " .. (p470 and "" or "un") .. "muted.";
                u191.Muted = p470;
                if u24.Chat then
                    l__Msg__13.TextColor3 = p470 and Color3.new(1, 0, 0) or Color3.new(1, 1, 1);
                    Chat(v648);
                else
                    u15.StarterGui:SetCore("ChatBarDisabled", p470);
                    u15.StarterGui:SetCore("ChatMakeSystemMessage", {
                        Text = v648,
                        Color = Color3.new(1, 0, 0)
                    });
                end;
            elseif p469 == "KRefresh" then
                local u649 = { u343.CFrame, u343.Focus, u340.HumanoidRootPart.CFrame };
                u28(function() --[[ Line: 2036 ]]
                    -- upvalues: l__LocalPlayer__1 (ref), u14 (ref), u649 (ref), u343 (ref)
                    local u650 = nil;
                    u650 = l__LocalPlayer__1.CharacterAdded:connect(function(p651) --[[ Line: 2038 ]]
                        -- upvalues: u14 (ref), u649 (ref), u343 (ref), u650 (ref)
                        local v652 = u14(p651, "HumanoidRootPart");
                        repeat
                            v652.CFrame = u649[3];
                            task.wait();
                        until (v652.Position - u649[3].p).magnitude < 1;
                        local v653 = u343;
                        local v654 = u343;
                        local v655 = u649[1];
                        local v656 = u649[2];
                        v653.CoordinateFrame = v655;
                        v654.Focus = v656;
                        u650:disconnect();
                    end);
                end);
                u38:FireServer(u39.uID .. "KRefresh");
            elseif p469 == "KPhase" then
                u340.Parent = u340.Parent == u343 and workspace or u343;
                u340:MakeJoints();
            elseif p469 == "KFly" then
                local l__Fly__66 = u191.Fly;
                if l__Fly__66 then
                    l__Fly__66.Value = nil;
                    l__Fly__66.Parent.BodyVelocity:Destroy();
                    l__Fly__66.Parent.BodyGyro:Destroy();
                    l__Fly__66:Destroy();
                    u191.Fly = nil;
                end;
                local u657 = u16(u340, "Humanoid");
                local u658 = u16(u340, "HumanoidRootPart");
                if not (u657 and u658) then
                    return;
                end;
                if p470 then
                    local u659, u660, u661 = Vector3.new();
                    local u662 = "BodyGyro";
                    local u663 = nil;
                    local u668 = (function(p664) --[[ Line: 8 ]]
                        -- upvalues: u662 (copy), u663 (copy)
                        local v665 = Instance.new(u662);
                        for v666, v667 in p664 do
                            if type(v666) == "number" then
                                v667.Parent = v665;
                            else
                                v665[v666] = v667;
                            end;
                        end;
                        v665.Parent = v665.Parent or u663;
                        return v665;
                    end)({
                        D = 200,
                        P = 5000,
                        Parent = u658,
                        cframe = u658.CFrame
                    });
                    local u669 = "BodyVelocity";
                    local u670 = nil;
                    local u675 = (function(p671) --[[ Line: 8 ]]
                        -- upvalues: u669 (copy), u670 (copy)
                        local v672 = Instance.new(u669);
                        for v673, v674 in p671 do
                            if type(v673) == "number" then
                                v674.Parent = v672;
                            else
                                v672[v673] = v674;
                            end;
                        end;
                        v672.Parent = v672.Parent or u670;
                        return v672;
                    end)({
                        Parent = u658
                    });
                    local u676 = "BoolValue";
                    local u677 = nil;
                    local u682 = (function(p678) --[[ Line: 8 ]]
                        -- upvalues: u676 (copy), u677 (copy)
                        local v679 = Instance.new(u676);
                        for v680, v681 in p678 do
                            if type(v680) == "number" then
                                v681.Parent = v679;
                            else
                                v679[v680] = v681;
                            end;
                        end;
                        v679.Parent = v679.Parent or u677;
                        return v679;
                    end)({
                        Name = "KFly",
                        Parent = u658
                    });
                    u191.Fly = u682;
                    u682.Changed:connect(function(_) --[[ Line: 2071 ]]
                        -- upvalues: u682 (ref), u191 (ref), u657 (copy), u668 (copy), u675 (copy)
                        if u682 == u191.Fly then
                            local l__Value__67 = u682.Value;
                            local v683 = l__Value__67 and Vector3.new(9000000000, 9000000000, 9000000000) or Vector3.new();
                            local v684 = u668;
                            local v685 = u675;
                            u657.PlatformStand = l__Value__67;
                            v684.MaxTorque = v683;
                            v685.MaxForce = v683;
                        end;
                    end);
                    u682.Value = true;
                    u28(function() --[[ Line: 2079 ]]
                        -- upvalues: u682 (ref), u660 (ref), u661 (ref), u657 (copy), u343 (ref), u659 (ref), u344 (ref), u39 (ref), u668 (copy), u675 (copy), u191 (ref), u658 (copy)
                        while true do
                            if u682.Value then
                                task.wait();
                                local l__MoveDirection__68 = u657.MoveDirection;
                                local l__CFrame__69 = u343.CFrame;
                                u660 = l__MoveDirection__68;
                                u661 = l__CFrame__69;
                                u660 = (u661:inverse() * CFrame.new(u661.p + u660)).p;
                                u659 = u659 * 0.95;
                                local v686 = math.min(100, u659.x + u660.x * 5);
                                local v687 = math.max(-100, v686);
                                local v688 = not u344 and (u39.KeyDown(Enum.KeyCode.Space) and u659.y + 5 or u39.KeyDown(Enum.KeyCode.LeftControl) and u659.y - 5) or u659.y;
                                local v689 = math.min(100, v688);
                                local v690 = math.max(-100, v689);
                                local v691 = math.min(100, u659.z + u660.z * 5);
                                local v692 = math.max(-100, v691);
                                u659 = Vector3.new(v687, v690, v692);
                                local v693 = u668;
                                local v694 = u675;
                                local v695 = u661;
                                local v696 = (u661 * CFrame.new(u659)).p - u661.p;
                                v693.cframe = v695;
                                v694.velocity = v696;
                            else
                                task.wait();
                            end;
                            if not u682 or (u682 ~= u191.Fly or not (u657 and u658)) then
                                return;
                            end;
                        end;
                    end);
                else
                    u657.PlatformStand = false;
                end;
            elseif p469 == "KNoclip" then
                local l__Noclip__70 = u191.Noclip;
                if l__Noclip__70 then
                    l__Noclip__70.Value = nil;
                    l__Noclip__70:Destroy();
                    u191.Noclip = nil;
                end;
                local u697 = u16(u340, "Humanoid");
                local u698 = u16(u340, "HumanoidRootPart");
                if not (u697 and u698) then
                    return;
                end;
                if p470 then
                    local u699 = Vector3.new();
                    local l__magnitude__71 = (u343.CFrame.p - u698.Position).magnitude;
                    local u700 = nil;
                    local u701 = nil;
                    local u702 = u342.WheelBackward:connect(function() --[[ Line: 2124 ]]
                        -- upvalues: l__magnitude__71 (ref)
                        l__magnitude__71 = math.min(l__magnitude__71 + 2.5, 100);
                    end);
                    local u703 = u342.WheelForward:connect(function() --[[ Line: 2127 ]]
                        -- upvalues: l__magnitude__71 (ref)
                        l__magnitude__71 = math.max(l__magnitude__71 - 2.5, 2.5);
                    end);
                    local u704 = "BoolValue";
                    local u705 = nil;
                    local u710 = (function(p706) --[[ Line: 8 ]]
                        -- upvalues: u704 (copy), u705 (copy)
                        local v707 = Instance.new(u704);
                        for v708, v709 in p706 do
                            if type(v708) == "number" then
                                v709.Parent = v707;
                            else
                                v707[v708] = v709;
                            end;
                        end;
                        v707.Parent = v707.Parent or u705;
                        return v707;
                    end)({
                        Name = "KNoclip",
                        Parent = u340
                    });
                    u191.Noclip = u710;
                    u710.Changed:connect(function(_) --[[ Line: 2132 ]]
                        -- upvalues: u710 (ref), u191 (ref), u698 (copy), l__magnitude__71 (ref), u343 (ref), u697 (copy)
                        if u710 == u191.Noclip then
                            local l__Value__72 = u710.Value;
                            if u698 and l__Value__72 then
                                l__magnitude__71 = (u343.CFrame.p - u698.Position).magnitude;
                            end;
                            local v711 = u697;
                            local v712 = u697;
                            local v713 = u698;
                            local v714 = u698;
                            u343.CameraType = l__Value__72 and "Fixed" or "Custom";
                            v711.WalkSpeed = l__Value__72 and 0 or 16;
                            v712.PlatformStand = l__Value__72;
                            v713.Anchored = l__Value__72;
                            v714.Anchored = l__Value__72;
                        end;
                    end);
                    u710.Value = true;
                    u28(function() --[[ Line: 2143 ]]
                        -- upvalues: u710 (ref), u700 (ref), u701 (ref), u343 (ref), u697 (copy), u699 (ref), u344 (ref), u39 (ref), l__magnitude__71 (ref), u698 (copy), u191 (ref), u702 (ref), u703 (ref)
                        while true do
                            if u710.Value then
                                task.wait();
                                local l__CFrame__73 = u343.CFrame;
                                local l__MoveDirection__74 = u697.MoveDirection;
                                u700 = l__CFrame__73;
                                u701 = l__MoveDirection__74;
                                u701 = (u700:inverse() * CFrame.new(u700.p + u701)).p;
                                u699 = u699 * 0.9;
                                local v715 = 0.06 + u699.magnitude * 0.1;
                                local v716 = math.max(-5, u699.x + u701.x * v715);
                                local v717 = math.min(5, v716);
                                local v718 = not u344 and (u39.KeyDown(Enum.KeyCode.Space) and u699.y + v715 or u39.KeyDown(Enum.KeyCode.LeftControl) and u699.y - v715) or u699.y;
                                local v719 = math.max(-5, u699.z + u701.z * v715);
                                local v720 = math.min(5, v719);
                                u699 = Vector3.new(v717, v718, v720);
                                if u699.magnitude > 0.1 then
                                    u343.CFrame = u700 * CFrame.new(u699);
                                    u700 = u343.CFrame;
                                    u343.Focus = u700 * CFrame.new(0, 0, -l__magnitude__71);
                                    u701 = u343.Focus * CFrame.new(0, 0, -1);
                                    u701 = CFrame.new(u343.Focus.p, (Vector3.new(u701.x, u343.Focus.y, u701.z))) - Vector3.new(0, 1.5, 0);
                                    u698.CFrame = u701;
                                end;
                            else
                                task.wait();
                            end;
                            if not u710 or (u710 ~= u191.Noclip or not (u697 and u698)) then
                                u702:disconnect();
                                u703:disconnect();
                                return;
                            end;
                        end;
                    end);
                    u697.Died:connect(function() --[[ Line: 2175 ]]
                        -- upvalues: l__LocalPlayer__1 (ref), u343 (ref), u14 (ref)
                        l__LocalPlayer__1.CharacterAdded:Wait();
                        u343.CameraSubject = u14(l__LocalPlayer__1.Character, "Humanoid");
                    end);
                else
                    u343.CameraType = "Custom";
                    u697.WalkSpeed = 16;
                    u697.PlatformStand = false;
                    u698.Anchored = false;
                    u698.Anchored = false;
                end;
            elseif p469 == "KCape" and p470 then
                if u16(p470[1], "KCape") then
                    p470[1].KCape:Destroy();
                end;
                if p470[4] then
                    u412(p470[1], p470[2], p470[3]);
                end;
            elseif p469 == "KGlitch" then
                local v721 = u16(u340, "KGlitch");
                if v721 then
                    v721:Destroy();
                end;
                if p470 then
                    local u722 = "IntValue";
                    local u723 = nil;
                    local v728 = (function(p724) --[[ Line: 8 ]]
                        -- upvalues: u722 (copy), u723 (copy)
                        local v725 = Instance.new(u722);
                        for v726, v727 in p724 do
                            if type(v726) == "number" then
                                v727.Parent = v725;
                            else
                                v725[v726] = v727;
                            end;
                        end;
                        v725.Parent = v725.Parent or u723;
                        return v725;
                    end)({
                        Name = "KGlitch",
                        Parent = u340
                    });
                    local v729 = u16(u340, "HumanoidRootPart");
                    local v730 = true;
                    while v728 and (v728.Parent == u340 and v729) do
                        v729.CFrame = v729.CFrame + Vector3.new(0, 0, (v730 and 1 or -1) * p470);
                        task.wait();
                        v730 = not v730;
                    end;
                end;
            elseif p469 == "KGlitch2" then
                local v731 = u16(u340, "KGlitch");
                if v731 then
                    v731:Destroy();
                end;
                if p470 then
                    local u732 = "IntValue";
                    local u733 = nil;
                    local v738 = (function(p734) --[[ Line: 8 ]]
                        -- upvalues: u732 (copy), u733 (copy)
                        local v735 = Instance.new(u732);
                        for v736, v737 in p734 do
                            if type(v736) == "number" then
                                v737.Parent = v735;
                            else
                                v735[v736] = v737;
                            end;
                        end;
                        v735.Parent = v735.Parent or u733;
                        return v735;
                    end)({
                        Name = "KGlitch",
                        Parent = u340
                    });
                    local v739 = u16(u340, "HumanoidRootPart");
                    local v740 = true;
                    while v738 and (v738.Parent == u340 and v739) do
                        v739.CFrame = v739.CFrame * CFrame.new(0, 0, (v740 and 1 or -1) * p470);
                        task.wait();
                        v740 = not v740;
                    end;
                end;
            elseif p469 == "KVibrate" then
                local v741 = u16(u340, "KGlitch");
                if v741 then
                    v741:Destroy();
                end;
                if p470 then
                    local u742 = "IntValue";
                    local u743 = nil;
                    local v748 = (function(p744) --[[ Line: 8 ]]
                        -- upvalues: u742 (copy), u743 (copy)
                        local v745 = Instance.new(u742);
                        for v746, v747 in p744 do
                            if type(v746) == "number" then
                                v747.Parent = v745;
                            else
                                v745[v746] = v747;
                            end;
                        end;
                        v745.Parent = v745.Parent or u743;
                        return v745;
                    end)({
                        Name = "KGlitch",
                        Parent = u340
                    });
                    local v749 = u16(u340, "HumanoidRootPart");
                    CFrame.new();
                    local v750 = 0;
                    while v748 and (v748.Parent == u340 and v749) do
                        local v751;
                        if v750 == 0 then
                            v751 = CFrame.new(p470, 0, 0);
                        elseif v750 == 1 then
                            v751 = CFrame.new(-p470, 0, 0);
                        elseif v750 == 2 then
                            v751 = CFrame.new(0, 0, p470);
                        else
                            v751 = CFrame.new(0, 0, -p470);
                        end;
                        v749.CFrame = v749.CFrame * v751;
                        v750 = (v750 + 1) % 4;
                        task.wait();
                    end;
                end;
            elseif p469 == "KFOV" then
                local v752 = u343;
                local v753 = math.max(1, p470);
                v752.FieldOfView = math.min(120, v753);
            elseif p469 == "KVote" then
                local v754 = u16(u183, "Vote");
                if v754 then
                    u28(u39.Hide, v754, true);
                end;
                local u755 = u39.template.Vote:Clone();
                u755.Visible = true;
                u755.Msg.Text = p470;
                u755.Parent = u183;
                local u756 = nil;
                local u757 = nil;
                local function u759(p758) --[[ Line: 2252 ]]
                    -- upvalues: u756 (ref), u757 (ref), u28 (ref), u39 (ref), u755 (copy), u38 (ref)
                    u756:disconnect();
                    u757:disconnect();
                    u756 = nil;
                    u757 = nil;
                    u28(u39.Hide, u755, true);
                    u38:FireServer(u39.uID .. "KVote", p758);
                end;
                u756 = u755.Y.MouseButton1Click:connect(function() --[[ Line: 2259 ]]
                    -- upvalues: u759 (ref)
                    u759(true);
                end);
                u757 = u755.N.MouseButton1Click:connect(function() --[[ Line: 2262 ]]
                    -- upvalues: u759 (ref)
                    u759(false);
                end);
                delay(9, function() --[[ Line: 2265 ]]
                    -- upvalues: u755 (copy), u183 (ref), u756 (ref), u28 (ref), u39 (ref)
                    if u755.Parent == u183 and u756 then
                        u28(u39.Hide, u755, true);
                    end;
                end);
                u39.Show(u755);
            elseif p469 == "KCredit" then
                ToggleCredit();
            elseif p469 == "KCam" then
                u38:FireServer(u39.uID .. "KCam", u343.CFrame);
            elseif p469 == "KPlaySound" then
                if p470 then
                    p470.Volume = u468 and 0 or 1;
                    p470:Play();
                end;
            elseif p469 == "KMuteMusic" then
                u468 = not u468;
                for _, v760 in workspace:GetChildren() do
                    if v760.Name == "KMusic" then
                        v760.Volume = u468 and 0 or 1;
                    end;
                end;
            end;
        end;
    end;
end;
u38.OnClientEvent:connect(ClientEvent);
u38:FireServer("KuID");
if u16(u38, "KNotify") then
    ClientEvent("KNotify", u38.KNotify.Value);
end;
l__LocalPlayer__1.CharacterAdded:connect(function(p761) --[[ Line: 2294 ]]
    -- upvalues: u340 (ref), u343 (ref), u14 (copy)
    local l__CurrentCamera__75 = workspace.CurrentCamera;
    u340 = p761;
    u343 = l__CurrentCamera__75;
    u343.CameraSubject = u14(u340, "Humanoid");
end);