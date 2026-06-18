-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.RicherText
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__TextService__1 = game:GetService("TextService");
local l__EmojiData__2 = require(script:WaitForChild("EmojiData"));
local u1 = {};
u1.__index = u1;
local function u4(u2, u3) --[[ Line: 99 ]]
    u2.BackgroundTransparency = 1;
    u2.BorderSizePixel = 0;
    u2.Text = "";
    u2.TextColor3 = u3.TextColor3;
    u2.TextStrokeColor3 = u3.TextStrokeColor3;
    u2.TextStrokeTransparency = u3.TextStrokeTransparency;
    u2.TextTransparency = u3.TextTransparency;
    u2.TextXAlignment = u3.TextXAlignment;
    u2.TextYAlignment = u3.TextYAlignment;
    u2.TextScaled = u3.TextScaled;
    u2.TextWrapped = u3.TextWrapped;
    u2.TextSize = u3.TextSize;
    local l__Font__3 = u3.Font;
    if l__Font__3 == Enum.Font.Unknown then
        l__Font__3 = Enum.Font.SourceSans;
    end;
    u2.Font = l__Font__3;
    pcall(function() --[[ Line: 113 ]]
        -- upvalues: u2 (copy), u3 (copy)
        u2.FontFace = u3.FontFace;
    end);
end;
local function u14(p5, p6) --[[ Line: 127 ]]
    -- upvalues: l__TextService__1 (copy)
    if not p5.TextScaled then
        return p5.TextSize;
    end;
    local l__AbsoluteSize__4 = p5.AbsoluteSize;
    if l__AbsoluteSize__4.X <= 0 or l__AbsoluteSize__4.Y <= 0 then
        return math.max(1, p5.TextSize);
    end;
    local v7 = math.max(1, p5.TextSize);
    local v8 = 1;
    local v9 = 500;
    for _ = 1, 18 do
        local v10 = (v8 + v9) * 0.5;
        local l__X__5 = l__AbsoluteSize__4.X;
        local v11 = l__TextService__1;
        local l__Font__6 = p5.Font;
        if l__Font__6 == Enum.Font.Unknown then
            l__Font__6 = Enum.Font.SourceSans;
        end;
        local v12 = v11:GetTextSize(p6, v10, l__Font__6, Vector2.new(l__X__5 or (1 / 0), (1 / 0)));
        if v12.X <= l__AbsoluteSize__4.X and v12.Y <= l__AbsoluteSize__4.Y then
            v7 = v10;
            v8 = v7;
            local v13 = v7;
            v7 = v8;
            v13 = v8;
        else
            v9 = v10;
        end;
    end;
    return math.max(1, v7);
end;
local function u23(p15) --[[ Line: 171 ]]
    -- upvalues: l__EmojiData__2 (copy)
    local v16 = false;
    local v17 = "";
    local v18 = "";
    local v19 = {};
    for v20 = 1, #p15 do
        local v21 = p15:sub(v20, v20);
        if v21 == ":" then
            if v16 then
                local v22 = l__EmojiData__2.Emojis[v17];
                if v22 then
                    if v18 ~= "" then
                        table.insert(v19, v18);
                        v18 = "";
                    end;
                    table.insert(v19, {
                        [v17] = v22
                    });
                else
                    v18 = v18 .. ":" .. v17 .. ":";
                end;
                v16 = false;
                v17 = "";
            else
                v16 = true;
            end;
        elseif v16 then
            if v21 == " " then
                v18 = v18 .. ":" .. v17 .. v21;
                v16 = false;
                v17 = "";
            else
                v17 = v17 .. v21;
            end;
        elseif v21 == " " then
            if v18 ~= "" then
                table.insert(v19, v18);
                v18 = "";
            end;
        else
            v18 = v18 .. v21;
        end;
    end;
    if v16 then
        v18 = v18 .. ":" .. v17;
    end;
    if v18 ~= "" then
        table.insert(v19, v18);
    end;
    return v19;
end;
local function u44(p24, p25) --[[ Line: 241 ]]
    -- upvalues: u23 (copy), u14 (copy), l__TextService__1 (copy)
    if p24._mounted then
        p25 = p25:gsub("<.->", "") or p25;
    end;
    local v26 = u23(p25);
    local l__AbsoluteSize__7 = p24._textContainerObject.AbsoluteSize;
    local v27 = u14(p24._textContainerObject, p25);
    local v28 = {};
    local v29 = 0;
    local v30 = p24._textContainerObject.LineHeight - 0.5;
    local v31 = math.floor(l__AbsoluteSize__7.Y / ((1 + v30) * v27) - v30 / (1 + v30));
    local v32 = math.max(1, v31);
    local v33 = l__TextService__1;
    local v34 = " ";
    local l__Font__8 = p24._textContainerObject.Font;
    if l__Font__8 == Enum.Font.Unknown then
        l__Font__8 = Enum.Font.SourceSans;
    end;
    local l__X__9 = v33:GetTextSize(v34, v27, l__Font__8, Vector2.new((1 / 0), (1 / 0))).X;
    for _ = 1, v32 do
        local v35 = {
            LineLength = 0,
            Words = {}
        };
        local v36 = 0;
        for v37 = v29 + 1, #v26 do
            local v38 = v26[v37];
            if type(v38) == "string" then
                local v39 = " " .. v38;
                local v40 = l__TextService__1;
                local l__Font__10 = p24._textContainerObject.Font;
                if l__Font__10 == Enum.Font.Unknown then
                    l__Font__10 = Enum.Font.SourceSans;
                end;
                v36 = v36 + v40:GetTextSize(v39, v27, l__Font__10, Vector2.new((1 / 0), (1 / 0))).X;
            elseif type(v38) == "table" then
                local v41 = v38[next(v38)];
                if type(v41) == "table" then
                    v36 = v36 + (l__AbsoluteSize__7.Y / v32 * v41.AspectRatio + l__X__9);
                elseif type(v41) == "string" then
                    local v42 = " " .. v41;
                    local v43 = l__TextService__1;
                    local l__Font__11 = p24._textContainerObject.Font;
                    if l__Font__11 == Enum.Font.Unknown then
                        l__Font__11 = Enum.Font.SourceSans;
                    end;
                    v36 = v36 + v43:GetTextSize(v42, v27, l__Font__11, Vector2.new((1 / 0), (1 / 0))).X;
                end;
            end;
            if l__AbsoluteSize__7.X <= v36 then
                break;
            end;
            table.insert(v35.Words, v38);
            v29 = v29 + 1;
            v35.LineLength = v36;
        end;
        if #v35.Words == 0 then
            break;
        end;
        table.insert(v28, v35);
    end;
    return v28, v32, v29 == #v26, v27;
end;
local function u48(p45) --[[ Line: 322 ]]
    if p45._renderLayer and p45._renderLayer.Parent == p45._textContainerObject then
        return p45._renderLayer;
    end;
    local v46 = p45._textContainerObject:FindFirstChild("__CustomEmojiTextLayer");
    if v46 and v46:IsA("Frame") then
        p45._renderLayer = v46;
        return v46;
    end;
    local v47 = Instance.new("Frame");
    v47.Name = "__CustomEmojiTextLayer";
    v47.BackgroundTransparency = 1;
    v47.BorderSizePixel = 0;
    v47.ClipsDescendants = false;
    v47.Size = UDim2.fromScale(1, 1);
    v47.Position = UDim2.fromScale(0, 0);
    v47.AnchorPoint = Vector2.new(0, 0);
    v47.ZIndex = p45._textContainerObject.ZIndex + 1;
    v47.Parent = p45._textContainerObject;
    p45._renderLayer = v47;
    return v47;
end;
local function u51(p49) --[[ Line: 348 ]]
    if p49._renderedObjects then
        for _, v50 in ipairs(p49._renderedObjects) do
            if v50 and v50.Parent then
                v50:Destroy();
            end;
        end;
    end;
    p49._renderedObjects = {};
end;
local function u77(u52, p53) --[[ Line: 359 ]]
    -- upvalues: l__EmojiData__2 (copy), u48 (copy), u51 (copy), u44 (copy), l__TextService__1 (copy), u4 (copy)
    if l__EmojiData__2.Settings.MAX_SYMBOLS and string.len(p53) > l__EmojiData__2.Settings.MAX_SYMBOLS then
    else
        u48(u52);
        u51(u52);
        local v54, u55, _, u56 = u44(u52, p53);
        local v57 = l__TextService__1;
        local v58 = " ";
        local l__Font__12 = u52._textContainerObject.Font;
        if l__Font__12 == Enum.Font.Unknown then
            l__Font__12 = Enum.Font.SourceSans;
        end;
        local l__X__13 = v57:GetTextSize(v58, u56, l__Font__12, Vector2.new((1 / 0), (1 / 0))).X;
        local l__AbsoluteSize__14 = u52._textContainerObject.AbsoluteSize;
        local v59;
        if u52._textContainerObject.TextYAlignment == Enum.TextYAlignment.Top then
            v59 = 0;
        else
            v59 = l__AbsoluteSize__14.Y - #v54 * l__AbsoluteSize__14.Y / u55;
            if u52._textContainerObject.TextYAlignment == Enum.TextYAlignment.Center then
                v59 = v59 / 2 or v59;
            end;
        end;
        for v60, v61 in ipairs(v54) do
            local l__fromOffset__15 = UDim2.fromOffset;
            local v62;
            if u52._textContainerObject.TextXAlignment == Enum.TextXAlignment.Left then
                v62 = 0;
            else
                v62 = l__AbsoluteSize__14.X - v61.LineLength;
                if u52._textContainerObject.TextXAlignment == Enum.TextXAlignment.Center then
                    v62 = v62 / 2 or v62;
                end;
            end;
            local u63 = l__fromOffset__15(v62, v59 + l__AbsoluteSize__14.Y / u55 * (v60 - 1));
            for _, v64 in ipairs(v61.Words) do
                local function v71(p65) --[[ Line: 406 ]]
                    -- upvalues: u52 (copy), u56 (copy), l__TextService__1 (ref), u4 (ref), l__AbsoluteSize__14 (copy), u55 (copy), u63 (ref), l__X__13 (copy)
                    local v66 = u56;
                    local v67 = l__TextService__1;
                    local l__Font__16 = u52._textContainerObject.Font;
                    if l__Font__16 == Enum.Font.Unknown then
                        l__Font__16 = Enum.Font.SourceSans;
                    end;
                    local v68 = v67:GetTextSize(p65, v66, l__Font__16, Vector2.new((1 / 0), (1 / 0)));
                    if not u52._mounted then
                        local v69 = u52;
                        local v70 = Instance.new("TextLabel");
                        u4(v70, v69._textContainerObject);
                        v70.Size = UDim2.fromOffset(v68.X, l__AbsoluteSize__14.Y / u55);
                        v70.Position = u63;
                        v70.Text = p65;
                        v70.ZIndex = u52._renderLayer.ZIndex + 1;
                        v70.Parent = u52._renderLayer;
                        table.insert(u52._renderedObjects, v70);
                    end;
                    u63 = u63 + UDim2.fromOffset(v68.X + l__X__13, 0);
                end;
                local function v75(p72) --[[ Line: 424 ]]
                    -- upvalues: l__AbsoluteSize__14 (copy), u55 (copy), u63 (ref), u52 (copy), l__X__13 (copy)
                    local l__Id__17 = p72.Id;
                    local l__AspectRatio__18 = p72.AspectRatio;
                    local v73 = Instance.new("ImageLabel");
                    v73.BackgroundTransparency = 1;
                    v73.BorderSizePixel = 0;
                    v73.ScaleType = Enum.ScaleType.Fit;
                    v73.Image = string.format("rbxassetid://%i", l__Id__17);
                    local v74 = l__AbsoluteSize__14.Y / u55;
                    v73.Size = UDim2.fromOffset(v74 * l__AspectRatio__18, v74);
                    v73.Position = u63;
                    v73.ZIndex = u52._renderLayer.ZIndex + 1;
                    v73.Parent = u52._renderLayer;
                    table.insert(u52._renderedObjects, v73);
                    u63 = u63 + UDim2.fromOffset(v73.Size.X.Offset + l__X__13, 0);
                end;
                if type(v64) == "string" then
                    v71(v64);
                elseif type(v64) == "table" then
                    local v76 = v64[next(v64)];
                    if type(v76) == "string" then
                        v71(v76);
                    elseif type(v76) == "table" then
                        v75(v76);
                    end;
                end;
            end;
        end;
    end;
end;
local function u82(u78, p79, p80) --[[ Line: 461 ]]
    -- upvalues: u77 (copy)
    u78._textContainerObject = p79;
    u78._ownsContainer = p80;
    u78._connections = {};
    u78._renderedObjects = {};
    u78._renderLayer = nil;
    u78._mounted = not p80;
    u78._originalText = p79.Text;
    u78._textShowing = p79.Text;
    if p80 then
        u78._textContainerObject.Text = "";
    end;
    u78._sizeChangedConn = u78._textContainerObject:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 476 ]]
        -- upvalues: u77 (ref), u78 (copy)
        u77(u78, u78._textShowing);
    end);
    u78._zIndexConn = u78._textContainerObject:GetPropertyChangedSignal("ZIndex"):Connect(function() --[[ Line: 480 ]]
        -- upvalues: u78 (copy)
        if u78._renderLayer then
            u78._renderLayer.ZIndex = u78._textContainerObject.ZIndex + 1;
        end;
    end);
    u78._ancestryConn = u78._textContainerObject.AncestryChanged:Connect(function(_, p81) --[[ Line: 486 ]]
        -- upvalues: u78 (copy)
        if p81 == nil then
            u78._renderLayer = nil;
            u78._renderedObjects = {};
        end;
    end);
end;
function u1.New(p83) --[[ Line: 498 ]]
    -- upvalues: u1 (copy), u82 (copy), u77 (copy)
    if p83 ~= "TextLabel" and p83 ~= "TextButton" then
        error("Invalid guiType: " .. tostring(p83) .. ", Must be \'TextLabel\' or \'TextButton\'.");
    end;
    local u84 = setmetatable({}, u1);
    local v85 = u82;
    local v86 = Instance.new(p83);
    v86.BackgroundTransparency = 1;
    v86.BorderSizePixel = 0;
    v86.Text = "";
    v86.LineHeight = 0.5;
    v86.Position = UDim2.fromScale(0, 0);
    v86.Size = UDim2.fromOffset(200, 50);
    v85(u84, v86, true);
    return setmetatable({}, {
        __index = function(_, u87) --[[ Name: __index, Line 507 ]]
            -- upvalues: u84 (copy), u1 (ref)
            if u87 == "Text" then
                return u84._textShowing;
            else
                return u1[u87] and function(_, ...) --[[ Line: 512 ]]
                    -- upvalues: u1 (ref), u87 (copy), u84 (ref)
                    return u1[u87](u84, ...);
                end or u84._textContainerObject[u87];
            end;
        end,
        __newindex = function(_, p88, p89) --[[ Name: __newindex, Line 517 ]]
            -- upvalues: u84 (copy), u77 (ref)
            if p88 == "RichText" or (p88 == "TextScaled" or p88 == "TextWrapped") then
                warn(p88 .. " is not supported!");
            else
                if p88 == "Text" then
                    u84._textShowing = p89;
                    u84._textContainerObject.Text = "";
                else
                    u84._textContainerObject[p88] = p89;
                end;
                u77(u84, u84._textShowing);
            end;
        end
    });
end;
function u1.Mount(p90) --[[ Line: 535 ]]
    -- upvalues: u1 (copy), u82 (copy), u77 (copy)
    if not (p90:IsA("TextLabel") or p90:IsA("TextButton")) then
        error("Invalid guiObject: " .. p90.ClassName .. ", Must be a TextLabel or TextButton.");
    end;
    local u91 = setmetatable({}, u1);
    u82(u91, p90, false);
    return setmetatable({}, {
        __index = function(_, u92) --[[ Name: __index, Line 544 ]]
            -- upvalues: u91 (copy), u1 (ref)
            if u92 == "Text" then
                return u91._textShowing;
            else
                return u1[u92] and function(_, ...) --[[ Line: 549 ]]
                    -- upvalues: u1 (ref), u92 (copy), u91 (ref)
                    return u1[u92](u91, ...);
                end or u91._textContainerObject[u92];
            end;
        end,
        __newindex = function(_, p93, p94) --[[ Name: __newindex, Line 554 ]]
            -- upvalues: u91 (copy), u77 (ref)
            if p93 == "Text" then
                u91._textShowing = p94;
                u91._textContainerObject.Text = p94;
            else
                u91._textContainerObject[p93] = p94;
            end;
            u77(u91, u91._textShowing);
        end
    });
end;
function u1.SetTextZIndex(p95, p96) --[[ Line: 572 ]]
    if p95._renderLayer then
        p95._renderLayer.ZIndex = p96;
    end;
    for _, v97 in ipairs(p95._renderedObjects or {}) do
        if v97:IsA("TextLabel") or v97:IsA("ImageLabel") then
            v97.ZIndex = p96 + 1;
        end;
    end;
end;
function u1.WillTextFit(p98, p99) --[[ Line: 584 ]]
    -- upvalues: u44 (copy)
    local _, _, v100 = u44(p98, p99);
    return v100;
end;
function u1.Connect(p101, p102, p103) --[[ Line: 589 ]]
    local v104 = p101._textContainerObject[p102];
    if typeof(v104) ~= "RBXScriptSignal" then
        warn("Invalid connection type: " .. p102);
        return nil;
    end;
    local v105 = v104:Connect(p103);
    table.insert(p101._connections, v105);
    return v105;
end;
function u1.Destroy(p106) --[[ Line: 601 ]]
    -- upvalues: u51 (copy)
    if p106._textContainerObject then
        for _, v107 in ipairs(p106._connections) do
            v107:Disconnect();
        end;
        if p106._sizeChangedConn then
            p106._sizeChangedConn:Disconnect();
        end;
        if p106._zIndexConn then
            p106._zIndexConn:Disconnect();
        end;
        if p106._ancestryConn then
            p106._ancestryConn:Disconnect();
        end;
        u51(p106);
        if p106._renderLayer and p106._renderLayer.Parent then
            p106._renderLayer:Destroy();
        end;
        if p106._ownsContainer or not p106._textContainerObject.Parent then
            if p106._ownsContainer then
                p106._textContainerObject:Destroy();
            end;
        else
            p106._textContainerObject.Text = p106._originalText;
        end;
    end;
    setmetatable(p106, nil);
end;
return u1;
