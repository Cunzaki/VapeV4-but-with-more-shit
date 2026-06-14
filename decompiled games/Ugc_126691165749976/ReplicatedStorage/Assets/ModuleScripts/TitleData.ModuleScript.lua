-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.TitleData
-- Class: ModuleScript
-- Place: Ugc (126691165749976)

-- Decompiled with Potassium's decompiler.

local l__Assets__1 = game:GetService("ReplicatedStorage").Assets;
local l__CEnum__2 = require(l__Assets__1.ModuleScripts.CEnum);
local l__RunService__3 = game:GetService("RunService");
local u1 = {
    "BackgroundColor3",
    "BackgroundTransparency",
    "BorderColor3",
    "BorderSizePixel",
    "LineHeight",
    "RichText",
    "Text",
    "TextColor3",
    "TextScaled",
    "TextSize",
    "TextStrokeColor3",
    "TextStrokeTransparency",
    "TextTransparency",
    "TextTruncate",
    "TextWrapped",
    "TextXAlignment",
    "TextYAlignment",
    "Font",
    "FontFace"
};
local u2 = {
    "Active",
    "AnchorPoint",
    "AutomaticSize",
    "BackgroundColor3",
    "BackgroundTransparency",
    "BorderColor3",
    "BorderMode",
    "BorderSizePixel",
    "ClipsDescendants",
    "LayoutOrder",
    "LineHeight",
    "MaxVisibleGraphemes",
    "Position",
    "RichText",
    "Rotation",
    "Selectable",
    "Size",
    "SizeConstraint",
    "Text",
    "TextColor3",
    "TextDirection",
    "TextScaled",
    "TextSize",
    "TextStrokeColor3",
    "TextStrokeTransparency",
    "TextTransparency",
    "TextTruncate",
    "TextWrapped",
    "TextXAlignment",
    "TextYAlignment",
    "Visible",
    "ZIndex",
    "Font",
    "FontFace"
};
local u3 = {};
local u4 = setmetatable({}, {
    __mode = "k"
});
local u5 = setmetatable({}, {
    __mode = "k"
});
local u6 = 0;
local function v14(p7) --[[ Line: 76 ]]
    local u8 = {
        text = "N/A",
        text_properties = {
            italic = true,
            color = Color3.fromRGB(200, 200, 200),
            font = Enum.Font.RobotoMono
        },
        show_when_unowned = false,
        hidden = false,
        preRender = function() --[[ Line: 87 ]] end,
        render_template = false,
        trigger_contexts = {},
        unlock_predicate = function() --[[ Line: 90 ]]
            return false;
        end,
        alert_on_unlock = true,
        autoseen = false,
        tooltip = p7.tooltip
    };
    for v9, v10 in p7 do
        u8[v9] = v10;
    end;
    u8.static_text = p7.static_text or (typeof(u8.text) == "string" and (u8.text or "N/A") or "N/A");
    if u8.static_text == "N/A" then
        warn(p7, "HAS NO STATIC TEXT");
    end;
    if typeof(u8.static_text) == "string" then
        u8.alert_text = "You have obtained the <b>" .. u8.static_text .. "</b> title!";
    end;
    function u8.getText() --[[ Line: 110 ]]
        -- upvalues: u8 (copy)
        local v11 = nil;
        if typeof(u8.text) ~= "function" then
            if typeof(u8.text) == "string" then
                v11 = u8.text;
            end;
            return v11 or "N/A";
        end;
        local v12, v13 = pcall(u8.text);
        if v12 then
            return v13;
        end;
        warn("getText FAILED FOR TITLE : ", u8.static_text);
        return u8.static_text;
    end;
    return u8;
end;
local function u17(p15) --[[ Line: 134 ]]
    -- upvalues: u4 (copy)
    local v16 = u4[p15];
    if not v16 then
        v16 = {
            children = {},
            tracked_children = {},
            properties = {},
            tracked_properties = {},
            property_order = {}
        };
        u4[p15] = v16;
    end;
    return v16;
end;
local function u29(u18) --[[ Line: 214 ]]
    -- upvalues: u4 (copy), u5 (copy)
    local v19 = u4[u18];
    if v19 then
        for v20 = #v19.children, 1, -1 do
            local u21 = v19.children[v20];
            pcall(function() --[[ Line: 220 ]]
                -- upvalues: u21 (copy)
                u21:Destroy();
            end);
        end;
    end;
    local v22 = u5[u18];
    if v22 then
        local v23 = {};
        for _, v24 in u18:GetDescendants() do
            if v24:GetAttribute("TitleDataGeneratedChild") == true and v24:GetAttribute("TitleDataOwnerId") == v22 then
                table.insert(v23, v24);
            end;
        end;
        for v25 = #v23, 1, -1 do
            local u26 = v23[v25];
            pcall(function() --[[ Line: 239 ]]
                -- upvalues: u26 (copy)
                u26:Destroy();
            end);
        end;
    end;
    if v19 then
        for _, u27 in v19.property_order do
            local u28 = v19.properties[u27];
            pcall(function() --[[ Line: 248 ]]
                -- upvalues: u18 (copy), u27 (copy), u28 (copy)
                u18[u27] = u28;
            end);
        end;
    end;
    u4[u18] = nil;
end;
local function u34(p30) --[[ Line: 257 ]]
    local v31 = p30:GetChildren();
    for v32 = #v31, 1, -1 do
        local u33 = v31[v32];
        pcall(function() --[[ Line: 261 ]]
            -- upvalues: u33 (copy)
            u33:Destroy();
        end);
    end;
end;
local function u40(p35, p36) --[[ Line: 276 ]]
    -- upvalues: u17 (copy), u5 (copy), u6 (ref)
    for _, u37 in p35:GetDescendants() do
        if not p36[u37] then
            local v38 = u17(p35);
            if not v38.tracked_children[u37] then
                local u39 = u5[p35];
                if not u39 then
                    u6 = u6 + 1;
                    u39 = "TitleData:" .. tostring(u6);
                    u5[p35] = u39;
                end;
                pcall(function() --[[ Line: 163 ]]
                    -- upvalues: u37 (copy), u39 (copy)
                    u37:SetAttribute("TitleDataGeneratedChild", true);
                    u37:SetAttribute("TitleDataOwnerId", u39);
                end);
                v38.tracked_children[u37] = true;
                table.insert(v38.children, u37);
            end;
        end;
    end;
end;
local function u46(u41) --[[ Line: 284 ]]
    -- upvalues: u2 (copy)
    local v42 = {};
    for _, u43 in u2 do
        local v44, v45 = pcall(function() --[[ Line: 287 ]]
            -- upvalues: u41 (copy), u43 (copy)
            return u41[u43];
        end);
        if v44 then
            v42[u43] = v45;
        end;
    end;
    return v42;
end;
local function u54(u47, p48) --[[ Line: 299 ]]
    -- upvalues: u17 (copy)
    for u49, v50 in p48 do
        local v51, v52 = pcall(function() --[[ Line: 301 ]]
            -- upvalues: u47 (copy), u49 (copy)
            return u47[u49];
        end);
        if v51 and v52 ~= v50 then
            local v53 = u17(u47);
            if not v53.tracked_properties[u49] then
                v53.tracked_properties[u49] = true;
                v53.properties[u49] = v50;
                table.insert(v53.property_order, u49);
            end;
        end;
    end;
end;
local function u64(p55, p56, p57) --[[ Line: 311 ]]
    -- upvalues: l__Assets__1 (copy), l__CEnum__2 (copy)
    local v58 = l__Assets__1:FindFirstChild("TitleTemplates");
    if not v58 then
        return nil;
    end;
    local v59 = {};
    if typeof(p57) == "string" and p57 ~= "" then
        table.insert(v59, p57);
    else
        local v60 = l__CEnum__2.reverse(l__CEnum__2.Titles, p55);
        if typeof(v60) == "string" then
            table.insert(v59, v60);
        end;
        if typeof(p56.static_text) == "string" then
            table.insert(v59, p56.static_text);
        end;
        local v61 = tostring(p55);
        table.insert(v59, v61);
    end;
    for _, v62 in v59 do
        local v63 = v58:FindFirstChild(v62);
        if v63 and v63:IsA("TextLabel") then
            return v63;
        end;
    end;
    return nil;
end;
local function u70(p65, p66, p67) --[[ Line: 343 ]]
    -- upvalues: u64 (copy)
    local l__render_template__4 = p65.render_template;
    if typeof(l__render_template__4) == "Instance" then
        if l__render_template__4:IsA("TextLabel") then
            return l__render_template__4;
        end;
    elseif typeof(l__render_template__4) == "function" then
        local v68, v69 = pcall(l__render_template__4, p66, p65, p67);
        if v68 then
            if typeof(v69) == "Instance" and v69:IsA("TextLabel") then
                return v69;
            end;
        else
            warn("TITLE RENDER TEMPLATE FAILED : ", p65.static_text, v69);
        end;
    else
        if l__render_template__4 == true then
            return u64(p67, p65, nil);
        end;
        if typeof(l__render_template__4) == "string" then
            return u64(p67, p65, l__render_template__4);
        end;
    end;
    return nil;
end;
local function u87(u71, u72, u73) --[[ Line: 367 ]]
    -- upvalues: u17 (copy)
    local v74, u75 = pcall(function() --[[ Line: 368 ]]
        -- upvalues: u72 (copy), u73 (copy)
        return u72[u73];
    end);
    if v74 then
        if u73 == "Font" or u73 == "FontFace" then
            local u76 = "Font";
            local v77, v78 = pcall(function() --[[ Line: 200 ]]
                -- upvalues: u71 (copy), u76 (copy)
                return u71[u76];
            end);
            if v77 then
                local v79 = u17(u71);
                if not v79.tracked_properties.Font then
                    v79.tracked_properties.Font = true;
                    v79.properties.Font = v78;
                    table.insert(v79.property_order, "Font");
                end;
            end;
            local u80 = "FontFace";
            local v81, v82 = pcall(function() --[[ Line: 200 ]]
                -- upvalues: u71 (copy), u80 (copy)
                return u71[u80];
            end);
            if v81 then
                local v83 = u17(u71);
                if not v83.tracked_properties.FontFace then
                    v83.tracked_properties.FontFace = true;
                    v83.properties.FontFace = v82;
                    table.insert(v83.property_order, "FontFace");
                end;
            end;
        else
            local v84, v85 = pcall(function() --[[ Line: 200 ]]
                -- upvalues: u71 (copy), u73 (copy)
                return u71[u73];
            end);
            if v84 then
                local v86 = u17(u71);
                if not v86.tracked_properties[u73] then
                    v86.tracked_properties[u73] = true;
                    v86.properties[u73] = v85;
                    table.insert(v86.property_order, u73);
                end;
            end;
        end;
        pcall(function() --[[ Line: 382 ]]
            -- upvalues: u71 (copy), u73 (copy), u75 (copy)
            u71[u73] = u75;
        end);
    end;
end;
local function u98(p88, p89) --[[ Line: 387 ]]
    -- upvalues: u3 (copy), u17 (copy), u5 (copy), u6 (ref)
    for _, u90 in p89:GetChildren() do
        if not u3[u90.ClassName] then
            local v91, u92 = pcall(function() --[[ Line: 393 ]]
                -- upvalues: u90 (copy)
                return u90:Clone();
            end);
            if v91 and u92 then
                u92.Parent = p88;
                local v93 = u17(p88);
                if not v93.tracked_children[u92] then
                    local u94 = u5[p88];
                    if not u94 then
                        u6 = u6 + 1;
                        u94 = "TitleData:" .. tostring(u6);
                        u5[p88] = u94;
                    end;
                    pcall(function() --[[ Line: 163 ]]
                        -- upvalues: u92 (copy), u94 (copy)
                        u92:SetAttribute("TitleDataGeneratedChild", true);
                        u92:SetAttribute("TitleDataOwnerId", u94);
                    end);
                    v93.tracked_children[u92] = true;
                    table.insert(v93.children, u92);
                end;
                for _, u95 in u92:GetDescendants() do
                    local v96 = u17(p88);
                    if not v96.tracked_children[u95] then
                        local u97 = u5[p88];
                        if not u97 then
                            u6 = u6 + 1;
                            u97 = "TitleData:" .. tostring(u6);
                            u5[p88] = u97;
                        end;
                        pcall(function() --[[ Line: 163 ]]
                            -- upvalues: u95 (copy), u97 (copy)
                            u95:SetAttribute("TitleDataGeneratedChild", true);
                            u95:SetAttribute("TitleDataOwnerId", u97);
                        end);
                        v96.tracked_children[u95] = true;
                        table.insert(v96.children, u95);
                    end;
                end;
            end;
        end;
    end;
end;
local function u104(p99, p100, p101) --[[ Line: 404 ]]
    -- upvalues: u70 (copy), u1 (copy), u87 (copy), u98 (copy)
    local v102 = u70(p100, p99, p101);
    if not v102 then
        return false;
    end;
    if v102 == p99 then
        return false;
    end;
    for _, v103 in u1 do
        u87(p99, v102, v103);
    end;
    u98(p99, v102);
    return true;
end;
local u105 = {
    [l__CEnum__2.Titles.Prospect] = v14({
        text = "Prospect",
        tooltip = "Unlocked by reaching LV5."
    }),
    [l__CEnum__2.Titles.Freelancer] = v14({
        text = "Freelancer",
        tooltip = "Unlocked by reaching LV10."
    }),
    [l__CEnum__2.Titles.Professional] = v14({
        text = "Professional",
        tooltip = "Unlocked by reaching LV25.",
        text_properties = {
            italic = true,
            color = Color3.fromRGB(255, 255, 255),
            font = Enum.Font.RobotoMono
        }
    }),
    [l__CEnum__2.Titles.Elite] = v14({
        text = "Elite",
        tooltip = "Unlocked by reaching LV50.",
        text_properties = {
            italic = true,
            color = Color3.fromRGB(255, 50, 50),
            font = Enum.Font.RobotoMono
        }
    }),
    [l__CEnum__2.Titles.Menace] = v14({
        text = "MENACE",
        tooltip = "Unlocked by reaching LV75.",
        text_properties = {
            color = Color3.fromRGB(255, 50, 50),
            font = Enum.Font.Sarpanch
        }
    }),
    [l__CEnum__2.Titles.Eminence] = v14({
        text = "EMINENCE",
        tooltip = "Unlocked by reaching LV90.",
        text_properties = {
            color = Color3.fromRGB(191, 0, 255),
            font = Font.fromId(12187374765)
        }
    }),
    [l__CEnum__2.Titles.FLATLINER] = v14({
        text = "FLATLINER",
        render_template = true,
        tooltip = "Unlocked by reaching LV100."
    }),
    [l__CEnum__2.Titles.Rookie] = v14({
        autoseen = true,
        text = "Rookie",
        tooltip = "Unlocked by joining the game!"
    }),
    [l__CEnum__2.Titles.Owner] = v14({
        text = "Owner",
        render_template = true,
        hidden = true,
        show_when_unowned = false,
        tooltip = ""
    }),
    [l__CEnum__2.Titles.Breakliner] = v14({
        text = "Breakliner",
        render_template = true,
        hidden = true,
        show_when_unowned = false,
        tooltip = ""
    }),
    [l__CEnum__2.Titles.TripleDreamer] = v14({
        text = "TripleDreamer",
        render_template = true,
        hidden = true,
        show_when_unowned = false,
        tooltip = ""
    }),
    [l__CEnum__2.Titles.Primordial] = v14({
        text = "Primordial",
        render_template = true,
        hidden = true,
        show_when_unowned = false,
        tooltip = ""
    }),
    [l__CEnum__2.Titles.Phightliner] = v14({
        text = "Phightliner",
        render_template = true,
        hidden = true,
        show_when_unowned = false,
        tooltip = ""
    }),
    [l__CEnum__2.Titles.Contributor] = v14({
        text = "Contributor",
        render_template = true,
        hidden = true,
        show_when_unowned = false,
        tooltip = ""
    }),
    [l__CEnum__2.Titles.Tester] = v14({
        text = "Tester",
        render_template = true,
        hidden = true,
        show_when_unowned = false,
        tooltip = ""
    }),
    [l__CEnum__2.Titles.ContentCreator] = v14({
        text = "Content Creator",
        render_template = true,
        hidden = true,
        show_when_unowned = false,
        tooltip = ""
    }),
    [l__CEnum__2.Titles.Samovar] = v14({
        text = "Samovar of Youth",
        render_template = true,
        hidden = true,
        show_when_unowned = false,
        tooltip = ""
    }),
    [l__CEnum__2.Titles.Necromancer] = v14({
        text = "Necromancer",
        render_template = true,
        hidden = true,
        show_when_unowned = false,
        tooltip = ""
    }),
    [l__CEnum__2.Titles.Thunder] = v14({
        text = "Thunder",
        render_template = true,
        hidden = true,
        show_when_unowned = false,
        tooltip = ""
    })
};
function u105.getTitleData() --[[ Line: 552 ]]
    -- upvalues: u105 (copy)
    local v106 = {};
    for v107, v108 in u105 do
        if typeof(v107) ~= "string" then
            v106[v107] = v108;
        end;
    end;
    return v106;
end;
function u105.renderFromLabel(u109, p110) --[[ Line: 562 ]]
    -- upvalues: u29 (copy), u34 (copy), u105 (copy), u104 (copy), u46 (copy), u40 (copy), u54 (copy), u17 (copy)
    u29(u109);
    u34(u109);
    local v111 = u105[p110];
    if v111 then
        local v112 = u104(u109, v111, p110);
        local v113 = {};
        for _, v114 in u109:GetDescendants() do
            v113[v114] = true;
        end;
        local v115 = u46(u109);
        local v116, v117 = pcall(v111.preRender, u109);
        u40(u109, v113);
        u54(u109, v115);
        if not v116 then
            warn("TITLE RENDERING FAILED : ", p110, v117);
        end;
        if u109:IsA("TextLabel") then
            if v112 then
            else
                local v118 = typeof(v111.text) == "function" and v111.text() or v111.text or "N/A";
                local v119 = v111.text_properties or {};
                local l__italic__5 = v119.italic;
                local l__bold__6 = v119.bold;
                local v120 = v119.color or Color3.new(1, 1, 1);
                local v121 = v119.font or Enum.Font.Unknown;
                local v122 = math.floor(v120.R * 255);
                local v123 = math.floor(v120.G * 255);
                local v124 = math.floor(v120.B * 255);
                local v125 = "<font color=\"" .. string.format("#%02X%02X%02X", v122, v123, v124) .. "\">";
                local v126 = "</font>";
                if l__italic__5 then
                    v125 = v125 .. "<i>";
                    v126 = "</i>" .. v126;
                end;
                if l__bold__6 then
                    v125 = v125 .. "<b>";
                    v126 = "</b>" .. v126;
                end;
                local u127 = "RichText";
                local v128, v129 = pcall(function() --[[ Line: 200 ]]
                    -- upvalues: u109 (copy), u127 (copy)
                    return u109[u127];
                end);
                if v128 then
                    local v130 = u17(u109);
                    if not v130.tracked_properties.RichText then
                        v130.tracked_properties.RichText = true;
                        v130.properties.RichText = v129;
                        table.insert(v130.property_order, "RichText");
                    end;
                end;
                u109.RichText = true;
                local u131 = "Font";
                local v132, v133 = pcall(function() --[[ Line: 200 ]]
                    -- upvalues: u109 (copy), u131 (copy)
                    return u109[u131];
                end);
                if v132 then
                    local v134 = u17(u109);
                    if not v134.tracked_properties.Font then
                        v134.tracked_properties.Font = true;
                        v134.properties.Font = v133;
                        table.insert(v134.property_order, "Font");
                    end;
                end;
                local u135 = "FontFace";
                local v136, v137 = pcall(function() --[[ Line: 200 ]]
                    -- upvalues: u109 (copy), u135 (copy)
                    return u109[u135];
                end);
                if v136 then
                    local v138 = u17(u109);
                    if not v138.tracked_properties.FontFace then
                        v138.tracked_properties.FontFace = true;
                        v138.properties.FontFace = v137;
                        table.insert(v138.property_order, "FontFace");
                    end;
                end;
                if typeof(v121) == "Font" then
                    u109.FontFace = v121;
                else
                    u109.Font = v121;
                end;
                local u139 = "Text";
                local v140, v141 = pcall(function() --[[ Line: 200 ]]
                    -- upvalues: u109 (copy), u139 (copy)
                    return u109[u139];
                end);
                if v140 then
                    local v142 = u17(u109);
                    if not v142.tracked_properties.Text then
                        v142.tracked_properties.Text = true;
                        v142.properties.Text = v141;
                        table.insert(v142.property_order, "Text");
                    end;
                end;
                u109.Text = v125 .. v118 .. v126;
            end;
        end;
    else
        warn("NO SUCH TITLE ENUM : ", p110, debug.traceback());
    end;
end;
if l__RunService__3:IsServer() then
    require(game:GetService("ServerStorage").Assets.Libraries.TitleSetup).setupServerData(u105);
end;
table.freeze(u105);
return u105;
