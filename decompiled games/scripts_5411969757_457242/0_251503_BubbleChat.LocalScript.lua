-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Chat__3 = game:GetService("Chat");
local l__TextService__4 = game:GetService("TextService");
local l__Lighting__5 = game:GetService("Lighting");
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
while l__LocalPlayer__6 == nil do
    l__Players__1.ChildAdded:wait();
    l__LocalPlayer__6 = l__Players__1.LocalPlayer;
end;
local l__PlayerGui__7 = l__LocalPlayer__6:WaitForChild("PlayerGui");
local v1, v2 = pcall(function() --[[ Line: 24 ]]
    return UserSettings():IsUserFeatureEnabled("UserShouldLocalizeGameChatBubble");
end);
local u3 = v1 and v2;
local v4, v5 = pcall(function() --[[ Line: 30 ]]
    return UserSettings():IsUserFeatureEnabled("UserFixBubbleChatText");
end);
local u6 = v4 and v5;
local l__SourceSans__8 = Enum.Font.SourceSans;
local l__Size24__9 = Enum.FontSize.Size24;
local u7 = 128 - utf8.len(utf8.nfcnormalize("...")) - 1;
local u8 = {
    WHITE = "dub",
    BLUE = "blu",
    GREEN = "gre",
    RED = "red"
};
local u9 = Instance.new("ScreenGui");
u9.Name = "BubbleChat";
u9.ResetOnSpawn = false;
u9.Parent = l__PlayerGui__7;
local function u14() --[[ Line: 83 ]]
    local u10 = {
        data = {}
    };
    local u11 = Instance.new("BindableEvent");
    u10.Emptied = u11.Event;
    function u10.Size(_) --[[ Line: 90 ]]
        -- upvalues: u10 (copy)
        return #u10.data;
    end;
    function u10.Empty(_) --[[ Line: 94 ]]
        -- upvalues: u10 (copy)
        return u10:Size() <= 0;
    end;
    function u10.PopFront(_) --[[ Line: 98 ]]
        -- upvalues: u10 (copy), u11 (copy)
        table.remove(u10.data, 1);
        if u10:Empty() then
            u11:Fire();
        end;
    end;
    function u10.Front(_) --[[ Line: 103 ]]
        -- upvalues: u10 (copy)
        return u10.data[1];
    end;
    function u10.Get(_, p12) --[[ Line: 107 ]]
        -- upvalues: u10 (copy)
        return u10.data[p12];
    end;
    function u10.PushBack(_, p13) --[[ Line: 111 ]]
        -- upvalues: u10 (copy)
        table.insert(u10.data, p13);
    end;
    function u10.GetData(_) --[[ Line: 115 ]]
        -- upvalues: u10 (copy)
        return u10.data;
    end;
    return u10;
end;
local function u23(p15, p16, p17) --[[ Line: 170 ]]
    local v22 = {
        ComputeBubbleLifetime = function(_, p18, p19) --[[ Name: ComputeBubbleLifetime, Line 173 ]]
            if p19 then
                local v20 = utf8.len(utf8.nfcnormalize(p18)) / 75;
                return 8 + 7 * math.min(v20, 1);
            else
                local v21 = utf8.len(utf8.nfcnormalize(p18)) / 75;
                return 12 + 8 * math.min(v21, 1);
            end;
        end,
        Origin = nil,
        RenderBubble = nil,
        Message = p15
    };
    v22.BubbleDieDelay = v22:ComputeBubbleLifetime(p15, p17);
    v22.BubbleColor = p16;
    v22.IsLocalPlayer = p17;
    return v22;
end;
function createChatBubbleMain(p24, p25)
    local v26 = Instance.new("ImageLabel");
    v26.Name = "ChatBubble";
    v26.ScaleType = Enum.ScaleType.Slice;
    v26.SliceCenter = p25;
    v26.Image = "rbxasset://textures/" .. tostring(p24) .. ".png";
    v26.BackgroundTransparency = 1;
    v26.BorderSizePixel = 0;
    v26.Size = UDim2.new(1, 0, 1, 0);
    v26.Position = UDim2.new(0, 0, 0, 0);
    return v26;
end;
function createChatBubbleTail(p27, p28)
    local v29 = Instance.new("ImageLabel");
    v29.Name = "ChatBubbleTail";
    v29.Image = "rbxasset://textures/ui/dialog_tail.png";
    v29.BackgroundTransparency = 1;
    v29.BorderSizePixel = 0;
    v29.Position = p27;
    v29.Size = p28;
    return v29;
end;
function createChatBubbleWithTail(p30, p31, p32, p33)
    local v34 = createChatBubbleMain(p30, p33);
    createChatBubbleTail(p31, p32).Parent = v34;
    return v34;
end;
function createScaledChatBubbleWithTail(p35, p36, p37, p38)
    local v39 = createChatBubbleMain(p35, p38);
    local v40 = Instance.new("Frame");
    v40.Name = "ChatBubbleTailFrame";
    v40.BackgroundTransparency = 1;
    v40.SizeConstraint = Enum.SizeConstraint.RelativeXX;
    v40.Position = UDim2.new(0.5, 0, 1, 0);
    v40.Size = UDim2.new(p36, 0, p36, 0);
    v40.Parent = v39;
    createChatBubbleTail(p37, UDim2.new(1, 0, 0.5, 0)).Parent = v40;
    return v39;
end;
function createChatImposter(p41, p42, p43)
    local v44 = Instance.new("ImageLabel");
    v44.Name = "DialogPlaceholder";
    v44.Image = "rbxasset://textures/" .. tostring(p41) .. ".png";
    v44.BackgroundTransparency = 1;
    v44.BorderSizePixel = 0;
    v44.Position = UDim2.new(0, 0, -1.25, 0);
    v44.Size = UDim2.new(1, 0, 1, 0);
    local v45 = Instance.new("ImageLabel");
    v45.Name = "DotDotDot";
    v45.Image = "rbxasset://textures/" .. tostring(p42) .. ".png";
    v45.BackgroundTransparency = 1;
    v45.BorderSizePixel = 0;
    v45.Position = UDim2.new(0.001, 0, p43, 0);
    v45.Size = UDim2.new(1, 0, 0.7, 0);
    v45.Parent = v44;
    return v44;
end;
local u53 = {
    ChatBubble = {},
    ChatBubbleWithTail = {},
    ScalingChatBubbleWithTail = {},
    CharacterSortedMsg = (function() --[[ Name: createMap, Line 131 ]]
        -- upvalues: u14 (copy)
        local u46 = {
            data = {}
        };
        local u47 = 0;
        function u46.Size(_) --[[ Line: 136 ]]
            -- upvalues: u47 (ref)
            return u47;
        end;
        function u46.Erase(_, p48) --[[ Line: 140 ]]
            -- upvalues: u46 (copy), u47 (ref)
            if u46.data[p48] then
                u47 = u47 - 1;
            end;
            u46.data[p48] = nil;
        end;
        function u46.Set(_, p49, p50) --[[ Line: 145 ]]
            -- upvalues: u46 (copy), u47 (ref)
            u46.data[p49] = p50;
            if p50 then
                u47 = u47 + 1;
            end;
        end;
        function u46.Get(_, u51) --[[ Line: 150 ]]
            -- upvalues: u46 (copy), u14 (ref)
            if u51 then
                if not u46.data[u51] then
                    u46.data[u51] = {
                        Fifo = u14(),
                        BillboardGui = nil
                    };
                    local u52 = nil;
                    u52 = u46.data[u51].Fifo.Emptied:connect(function() --[[ Line: 155 ]]
                        -- upvalues: u52 (ref), u46 (ref), u51 (copy)
                        u52:disconnect();
                        u46:Erase(u51);
                    end);
                end;
                return u46.data[u51];
            end;
        end;
        function u46.GetData(_) --[[ Line: 163 ]]
            -- upvalues: u46 (copy)
            return u46.data;
        end;
        return u46;
    end)()
};
local function v58(p54, p55, _, p56, p57) --[[ Line: 290 ]]
    -- upvalues: u53 (copy)
    u53.ChatBubble[p54] = createChatBubbleMain(p55, p57);
    u53.ChatBubbleWithTail[p54] = createChatBubbleWithTail(p55, UDim2.new(0.5, -14, 1, p56 and -1 or 0), UDim2.new(0, 30, 0, 14), p57);
    u53.ScalingChatBubbleWithTail[p54] = createScaledChatBubbleWithTail(p55, 0.5, UDim2.new(-0.5, 0, 0, p56 and -1 or 0), p57);
end;
v58("dub", "ui/dialog_white", "ui/chatBubble_white_notify_bkg", false, Rect.new(5, 5, 15, 15));
v58("blu", "ui/dialog_blue", "ui/chatBubble_blue_notify_bkg", true, Rect.new(7, 7, 33, 33));
v58("red", "ui/dialog_red", "ui/chatBubble_red_notify_bkg", true, Rect.new(7, 7, 33, 33));
v58("gre", "ui/dialog_green", "ui/chatBubble_green_notify_bkg", true, Rect.new(7, 7, 33, 33));
function u53.SanitizeChatLine(_, p59) --[[ Line: 301 ]]
    -- upvalues: u7 (copy)
    if u7 >= utf8.len(utf8.nfcnormalize(p59)) then
        return p59;
    end;
    local v60 = utf8.offset(p59, u7 + utf8.len(utf8.nfcnormalize("...")) + 1) - 1;
    return string.sub(p59, 1, v60);
end;
local function u65(p61) --[[ Line: 310 ]]
    -- upvalues: u9 (copy), u53 (copy)
    local u62 = Instance.new("BillboardGui");
    u62.Adornee = p61;
    u62.Size = UDim2.new(0, 400, 0, 250);
    u62.StudsOffset = Vector3.new(0, 1.5, 2);
    u62.Parent = u9;
    local u63 = Instance.new("Frame");
    u63.Name = "BillboardFrame";
    u63.Size = UDim2.new(1, 0, 1, 0);
    u63.Position = UDim2.new(0, 0, -0.5, 0);
    u63.BackgroundTransparency = 1;
    u63.Parent = u62;
    local u64 = nil;
    u64 = u63.ChildRemoved:connect(function() --[[ Line: 325 ]]
        -- upvalues: u63 (copy), u64 (ref), u62 (copy)
        if #u63:GetChildren() <= 1 then
            u64:disconnect();
            u62:Destroy();
        end;
    end);
    u53:CreateSmallTalkBubble("dub").Parent = u63;
    return u62;
end;
function u53.CreateBillboardGuiHelper(_, p66, p67) --[[ Line: 337 ]]
    -- upvalues: u53 (copy), u65 (copy)
    if p66 and not u53.CharacterSortedMsg:Get(p66).BillboardGui then
        if not p67 and p66:IsA("BasePart") then
            local v68 = u65(p66);
            u53.CharacterSortedMsg:Get(p66).BillboardGui = v68;
            return;
        end;
        if p66:IsA("Model") then
            local v69 = p66:FindFirstChild("Head");
            if v69 and v69:IsA("BasePart") then
                local v70 = u65(v69);
                u53.CharacterSortedMsg:Get(p66).BillboardGui = v70;
            end;
        end;
    end;
end;
function u53.SetBillboardLODNear(_, p71) --[[ Line: 371 ]]
    -- upvalues: l__Players__1 (copy)
    local l__Adornee__10 = p71.Adornee;
    local v72;
    if l__Adornee__10 and l__Players__1.LocalPlayer.Character then
        v72 = l__Adornee__10:IsDescendantOf(l__Players__1.LocalPlayer.Character);
    else
        v72 = nil;
    end;
    p71.Size = UDim2.new(0, 400, 0, 250);
    p71.StudsOffset = Vector3.new(0, v72 and 1.5 or 2.5, v72 and 2 or 0.1);
    p71.Enabled = true;
    local v73 = p71.BillboardFrame:GetChildren();
    for v74 = 1, #v73 do
        v73[v74].Visible = true;
    end;
    p71.BillboardFrame.SmallTalkBubble.Visible = false;
end;
function u53.SetBillboardLODDistant(_, p75) --[[ Line: 383 ]]
    -- upvalues: l__Players__1 (copy)
    local l__Adornee__11 = p75.Adornee;
    local v76;
    if l__Adornee__11 and l__Players__1.LocalPlayer.Character then
        v76 = l__Adornee__11:IsDescendantOf(l__Players__1.LocalPlayer.Character);
    else
        v76 = nil;
    end;
    p75.Size = UDim2.new(4, 0, 3, 0);
    p75.StudsOffset = Vector3.new(0, 3, v76 and 2 or 0.1);
    p75.Enabled = true;
    local v77 = p75.BillboardFrame:GetChildren();
    for v78 = 1, #v77 do
        v77[v78].Visible = false;
    end;
    p75.BillboardFrame.SmallTalkBubble.Visible = true;
end;
function u53.SetBillboardLODVeryFar(_, p79) --[[ Line: 395 ]]
    p79.Enabled = false;
end;
function u53.SetBillboardGuiLOD(_, p80, p81) --[[ Line: 399 ]]
    -- upvalues: u53 (copy)
    if p81 then
        if p81:IsA("Model") then
            p81 = p81:FindFirstChild("Head") or p81.PrimaryPart;
        end;
        local v82 = not p81 and 100000 or (p81.Position - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude;
        if v82 < 65 then
            u53:SetBillboardLODNear(p80);
        elseif v82 >= 65 and v82 < 100 then
            u53:SetBillboardLODDistant(p80);
        else
            u53:SetBillboardLODVeryFar(p80);
        end;
    end;
end;
function u53.CameraCFrameChanged(_) --[[ Line: 419 ]]
    -- upvalues: u53 (copy)
    for v83, v84 in pairs(u53.CharacterSortedMsg:GetData()) do
        local l__BillboardGui__12 = v84.BillboardGui;
        if l__BillboardGui__12 then
            u53:SetBillboardGuiLOD(l__BillboardGui__12, v83);
        end;
    end;
end;
function u53.CreateBubbleText(_, p85, p86) --[[ Line: 426 ]]
    -- upvalues: u6 (ref), l__SourceSans__8 (copy), l__Size24__9 (copy)
    local v87 = Instance.new("TextLabel");
    v87.Name = "BubbleText";
    v87.BackgroundTransparency = 1;
    if u6 then
        v87.Size = UDim2.fromScale(1, 1);
    else
        v87.Position = UDim2.new(0, 15, 0, 0);
        v87.Size = UDim2.new(1, -30, 1, 0);
    end;
    v87.Font = l__SourceSans__8;
    v87.ClipsDescendants = true;
    v87.TextWrapped = true;
    v87.FontSize = l__Size24__9;
    v87.Text = p85;
    v87.Visible = false;
    v87.AutoLocalize = p86;
    if u6 then
        local v88 = Instance.new("UIPadding");
        v88.PaddingTop = UDim.new(0, 12);
        v88.PaddingRight = UDim.new(0, 12);
        v88.PaddingBottom = UDim.new(0, 12);
        v88.PaddingLeft = UDim.new(0, 12);
        v88.Parent = v87;
    end;
    return v87;
end;
function u53.CreateSmallTalkBubble(_, p89) --[[ Line: 458 ]]
    -- upvalues: u53 (copy)
    local v90 = u53.ScalingChatBubbleWithTail[p89]:Clone();
    v90.Name = "SmallTalkBubble";
    v90.AnchorPoint = Vector2.new(0, 0.5);
    v90.Position = UDim2.new(0, 0, 0.5, 0);
    v90.Visible = false;
    local v91 = u53:CreateBubbleText("...");
    v91.TextScaled = true;
    v91.TextWrapped = false;
    v91.Visible = true;
    v91.Parent = v90;
    return v90;
end;
function u53.UpdateChatLinesForOrigin(_, p92, p93) --[[ Line: 473 ]]
    -- upvalues: u53 (copy)
    local l__Fifo__13 = u53.CharacterSortedMsg:Get(p92).Fifo;
    local v94 = l__Fifo__13:Size();
    local v95 = l__Fifo__13:GetData();
    if #v95 <= 1 then
    else
        for v96 = #v95 - 1, 1, -1 do
            local l__RenderBubble__14 = v95[v96].RenderBubble;
            if not l__RenderBubble__14 then
                return;
            end;
            if v94 - v96 + 1 > 1 then
                local v97 = l__RenderBubble__14:FindFirstChild("ChatBubbleTail");
                if v97 then
                    v97:Destroy();
                end;
                local v98 = l__RenderBubble__14:FindFirstChild("BubbleText");
                if v98 then
                    v98.TextTransparency = 0.5;
                end;
            end;
            l__RenderBubble__14:TweenPosition(UDim2.new(l__RenderBubble__14.Position.X.Scale, l__RenderBubble__14.Position.X.Offset, 1, p93 - l__RenderBubble__14.Size.Y.Offset - 14), Enum.EasingDirection.Out, Enum.EasingStyle.Bounce, 0.1, true);
            p93 = p93 - l__RenderBubble__14.Size.Y.Offset - 14;
        end;
    end;
end;
function u53.DestroyBubble(_, u99, u100) --[[ Line: 499 ]]
    if u99 then
        if u99:Empty() then
        else
            local l__RenderBubble__15 = u99:Front().RenderBubble;
            if l__RenderBubble__15 then
                spawn(function() --[[ Line: 509 ]]
                    -- upvalues: u99 (copy), u100 (copy), l__RenderBubble__15 (ref)
                    while u99:Front().RenderBubble ~= u100 do
                        wait();
                    end;
                    l__RenderBubble__15 = u99:Front().RenderBubble;
                    local v101 = l__RenderBubble__15:FindFirstChild("BubbleText");
                    local v102 = l__RenderBubble__15:FindFirstChild("ChatBubbleTail");
                    while l__RenderBubble__15 and l__RenderBubble__15.ImageTransparency < 1 do
                        local v103 = wait();
                        if l__RenderBubble__15 then
                            local v104 = v103 * 1.5;
                            l__RenderBubble__15.ImageTransparency = l__RenderBubble__15.ImageTransparency + v104;
                            if v101 then
                                v101.TextTransparency = v101.TextTransparency + v104;
                            end;
                            if v102 then
                                v102.ImageTransparency = v102.ImageTransparency + v104;
                            end;
                        end;
                    end;
                    if l__RenderBubble__15 then
                        l__RenderBubble__15:Destroy();
                        u99:PopFront();
                    end;
                end);
            else
                u99:PopFront();
            end;
        end;
    end;
end;
function u53.CreateChatLineRender(_, p105, p106, p107, u108, p109) --[[ Line: 537 ]]
    -- upvalues: u53 (copy), l__TextService__4 (copy), l__SourceSans__8 (copy), u6 (ref)
    if p105 then
        if not u53.CharacterSortedMsg:Get(p105).BillboardGui then
            u53:CreateBillboardGuiHelper(p105, p107);
        end;
        local l__BillboardGui__16 = u53.CharacterSortedMsg:Get(p105).BillboardGui;
        if l__BillboardGui__16 then
            local u110 = u53.ChatBubbleWithTail[p106.BubbleColor]:Clone();
            u110.Visible = false;
            local u111 = u53:CreateBubbleText(p106.Message, p109);
            u111.Parent = u110;
            u110.Parent = l__BillboardGui__16.BillboardFrame;
            p106.RenderBubble = u110;
            local v112 = l__TextService__4:GetTextSize(u111.Text, 24, l__SourceSans__8, Vector2.new(400, 250));
            local v113 = v112.Y / 24;
            if u6 then
                local v114 = math.ceil(v112.X + 24);
                local v115 = v113 * 34;
                u110.Size = UDim2.fromOffset(0, 0);
                u110.Position = UDim2.fromScale(0.5, 1);
                u110:TweenSizeAndPosition(UDim2.fromOffset(v114, v115), UDim2.new(0.5, -v114 / 2, 1, -v115), Enum.EasingDirection.Out, Enum.EasingStyle.Elastic, 0.1, true, function() --[[ Line: 576 ]]
                    -- upvalues: u111 (copy)
                    u111.Visible = true;
                end);
                u53:SetBillboardGuiLOD(l__BillboardGui__16, p106.Origin);
                u53:UpdateChatLinesForOrigin(p106.Origin, -v115);
            else
                local v116 = math.max((v112.X + 30) / 400, 0.1);
                u110.Size = UDim2.new(0, 0, 0, 0);
                u110.Position = UDim2.new(0.5, 0, 1, 0);
                local v117 = v113 * 34;
                u110:TweenSizeAndPosition(UDim2.new(v116, 0, 0, v117), UDim2.new((1 - v116) / 2, 0, 1, -v117), Enum.EasingDirection.Out, Enum.EasingStyle.Elastic, 0.1, true, function() --[[ Line: 596 ]]
                    -- upvalues: u111 (copy)
                    u111.Visible = true;
                end);
                u53:SetBillboardGuiLOD(l__BillboardGui__16, p106.Origin);
                u53:UpdateChatLinesForOrigin(p106.Origin, -v117);
            end;
            delay(p106.BubbleDieDelay, function() --[[ Line: 603 ]]
                -- upvalues: u53 (ref), u108 (copy), u110 (copy)
                u53:DestroyBubble(u108, u110);
            end);
        end;
    end;
end;
function u53.OnPlayerChatMessage(_, p118, p119, _) --[[ Line: 609 ]]
    -- upvalues: l__Lighting__5 (copy), l__Players__1 (copy), u53 (copy), u23 (copy), u8 (copy)
    if l__Lighting__5:FindFirstChild("BubbleChatIsEnabled") == nil then
        return false;
    end;
    local l__LocalPlayer__17 = l__Players__1.LocalPlayer;
    local v120;
    if l__LocalPlayer__17 == nil then
        v120 = false;
    else
        v120 = p118 ~= l__LocalPlayer__17;
    end;
    local v121 = u23(u53:SanitizeChatLine(p119), u8.WHITE, not v120);
    if p118 then
        v121.User = p118.Name;
        v121.Origin = p118.Character;
    end;
    if p118 and v121.Origin then
        local l__Fifo__18 = u53.CharacterSortedMsg:Get(v121.Origin).Fifo;
        l__Fifo__18:PushBack(v121);
        u53:CreateChatLineRender(p118.Character, v121, true, l__Fifo__18, false);
    end;
end;
function u53.OnGameChatMessage(_, p122, p123, p124) --[[ Line: 638 ]]
    -- upvalues: l__Players__1 (copy), u53 (copy), u23 (copy), u3 (copy)
    local l__LocalPlayer__19 = l__Players__1.LocalPlayer;
    local v125;
    if l__LocalPlayer__19 == nil then
        v125 = false;
    else
        v125 = l__LocalPlayer__19.Character ~= p122;
    end;
    local v126 = p124 == Enum.ChatColor.Blue and "blu" or (p124 == Enum.ChatColor.Green and "gre" or (p124 == Enum.ChatColor.Red and "red" or "dub"));
    local v127 = u23(u53:SanitizeChatLine(p123), v126, not v125);
    v127.Origin = p122;
    u53.CharacterSortedMsg:Get(v127.Origin).Fifo:PushBack(v127);
    if u3 then
        u53:CreateChatLineRender(p122, v127, false, u53.CharacterSortedMsg:Get(v127.Origin).Fifo, true);
    else
        u53:CreateChatLineRender(p122, v127, false, u53.CharacterSortedMsg:Get(v127.Origin).Fifo, false);
    end;
end;
function u53.BubbleChatEnabled(_) --[[ Line: 659 ]]
    -- upvalues: l__Chat__3 (copy), l__Players__1 (copy)
    local v128 = l__Chat__3:FindFirstChild("ClientChatModules");
    local v129 = v128 and v128:FindFirstChild("ChatSettings");
    if v129 then
        local v130 = require(v129);
        if v130.BubbleChatEnabled ~= nil then
            return v130.BubbleChatEnabled;
        end;
    end;
    return l__Players__1.BubbleChat;
end;
function u53.ShowOwnFilteredMessage(_) --[[ Line: 673 ]]
    -- upvalues: l__Chat__3 (copy)
    local v131 = l__Chat__3:FindFirstChild("ClientChatModules");
    local v132 = v131 and v131:FindFirstChild("ChatSettings");
    if v132 then
        return require(v132).ShowUserOwnFilteredMessage;
    else
        return false;
    end;
end;
function findPlayer(p133)
    -- upvalues: l__Players__1 (copy)
    for _, v134 in pairs(l__Players__1:GetPlayers()) do
        if v134.Name == p133 then
            return v134;
        end;
    end;
end;
l__Chat__3.Chatted:connect(function(p135, p136, p137) --[[ Line: 693 ]]
    -- upvalues: u53 (copy)
    u53:OnGameChatMessage(p135, p136, p137);
end);
local u138;
if game.Workspace.CurrentCamera then
    u138 = game.Workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):connect(function(_) --[[ Line: 697 ]]
        -- upvalues: u53 (copy)
        u53:CameraCFrameChanged();
    end);
else
    u138 = nil;
end;
game.Workspace.Changed:connect(function(p139) --[[ Line: 700 ]]
    -- upvalues: u138 (ref), u53 (copy)
    if p139 == "CurrentCamera" then
        if u138 then
            u138:disconnect();
        end;
        if game.Workspace.CurrentCamera then
            u138 = game.Workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):connect(function(_) --[[ Line: 704 ]]
                -- upvalues: u53 (ref)
                u53:CameraCFrameChanged();
            end);
        end;
    end;
end);
local u140 = nil;
function getAllowedMessageTypes()
    -- upvalues: u140 (ref), l__Chat__3 (copy)
    if u140 then
        return u140;
    end;
    local v141 = l__Chat__3:FindFirstChild("ClientChatModules");
    if not v141 then
        return { "Message", "Whisper" };
    end;
    local v142 = v141:FindFirstChild("ChatSettings");
    if v142 then
        local v143 = require(v142);
        if v143.BubbleChatMessageTypes then
            u140 = v143.BubbleChatMessageTypes;
            return u140;
        end;
    end;
    local v144 = v141:FindFirstChild("ChatConstants");
    if v144 then
        local v145 = require(v144);
        u140 = { v145.MessageTypeDefault, v145.MessageTypeWhisper };
    end;
    return u140;
end;
function checkAllowedMessageType(p146)
    local v147 = getAllowedMessageTypes();
    for v148 = 1, #v147 do
        if v147[v148] == p146.MessageType then
            return true;
        end;
    end;
    return false;
end;
local l__DefaultChatSystemChatEvents__20 = l__ReplicatedStorage__2:WaitForChild("DefaultChatSystemChatEvents");
local l__OnMessageDoneFiltering__21 = l__DefaultChatSystemChatEvents__20:WaitForChild("OnMessageDoneFiltering");
l__DefaultChatSystemChatEvents__20:WaitForChild("OnNewMessage").OnClientEvent:connect(function(p149, _) --[[ Line: 750 ]]
    -- upvalues: l__LocalPlayer__6 (ref), u53 (copy)
    if checkAllowedMessageType(p149) then
        local v150 = findPlayer(p149.FromSpeaker);
        if v150 then
            if p149.IsFiltered and p149.FromSpeaker ~= l__LocalPlayer__6.Name or p149.FromSpeaker == l__LocalPlayer__6.Name and not u53:ShowOwnFilteredMessage() then
                u53:OnPlayerChatMessage(v150, p149.Message, nil);
            end;
        end;
    end;
end);
l__OnMessageDoneFiltering__21.OnClientEvent:connect(function(p151, _) --[[ Line: 769 ]]
    -- upvalues: l__LocalPlayer__6 (ref), u53 (copy)
    if checkAllowedMessageType(p151) then
        local v152 = findPlayer(p151.FromSpeaker);
        if v152 then
            if p151.FromSpeaker == l__LocalPlayer__6.Name and not u53:ShowOwnFilteredMessage() then
            else
                u53:OnPlayerChatMessage(v152, p151.Message, nil);
            end;
        end;
    end;
end);