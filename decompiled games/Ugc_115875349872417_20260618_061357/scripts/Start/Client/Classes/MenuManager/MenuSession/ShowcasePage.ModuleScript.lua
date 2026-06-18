-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.ShowcasePage
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__Lighting__4 = game:GetService("Lighting");
local l__RunService__5 = game:GetService("RunService");
local l__ModuleScripts__6 = l__ReplicatedStorage__3.Assets.ModuleScripts;
local l__ItemDef__7 = require(l__ModuleScripts__6.ItemDef);
local l__Packets__8 = require(l__ModuleScripts__6.Packets);
local l__SkinDefs__9 = require(l__ModuleScripts__6.SkinDefs);
local l__Trove__10 = require(l__ModuleScripts__6.Trove);
local l__ViewportModel__11 = require(l__ModuleScripts__6.ViewportModel);
local l__UIAssets__12 = l__ReplicatedStorage__3.Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__Classes__13 = require(script.Parent.Parent.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__14 = require(script.Parent.Parent.Parent.Parent.InternalSymbols);
local u2 = UDim2.fromScale(0.5, 1);
local u3 = UDim2.fromScale(0.5, 0.65);
local u4 = UDim2.fromScale(0.5, 1.1);
local u5 = {
    equip = Color3.fromRGB(255, 255, 255),
    equipped = Color3.fromRGB(0, 150, 0),
    disabled = Color3.fromRGB(95, 95, 95)
};
local u24 = {
    start_down = {
        begin = function(p6) --[[ Name: begin, Line 78 ]]
            -- upvalues: l__InternalSymbols__14 (copy), l__Classes__13 (copy)
            l__InternalSymbols__14.owner("ShowcasePage", p6).camera_intro_elapsed = 0;
            l__Classes__13._x255cd8d76027f039:_x52122b574720a201();
        end,
        update = function(p7, p8, p9) --[[ Name: update, Line 84 ]]
            -- upvalues: l__InternalSymbols__14 (copy)
            local v10 = l__InternalSymbols__14.owner("ShowcasePage", p7);
            v10.camera_intro_elapsed = v10.camera_intro_elapsed + p9;
            local v11 = math.clamp(v10.camera_intro_elapsed / 2.25, 0, 1);
            local v12 = 1 - (1 - v11) * (1 - v11) * (1 - v11);
            local v13 = CFrame.lookAt(p8.Position, p8.Position - Vector3.new(0, 1, 0), Vector3.new(0, 0, 1));
            if v11 >= 1 then
                return p8, false;
            else
                return v13:Lerp(p8, v12), true;
            end;
        end
    },
    extract = {
        begin = function(p14) --[[ Name: begin, Line 100 ]]
            -- upvalues: l__InternalSymbols__14 (copy), l__Classes__13 (copy), u3 (copy), l__TweenService__1 (copy), u2 (copy), l__Lighting__4 (copy), u4 (copy)
            local u15 = l__InternalSymbols__14.owner("ShowcasePage", p14);
            local u16 = u15:_getExtractedRarity();
            u15:_cancelExtractIntroRun();
            local l__extract_intro_run_id__15 = u15.extract_intro_run_id;
            local l__item_row__16 = u15:_getUi().item_row;
            l__Classes__13._xfaee1d1d64cdfe93._x9374c60b0eb68ccd = 0;
            local v17 = l__Classes__13._xbe184fb1376a575d:_x7ab8b42cc5920a78("BUILD_UP");
            u15.extract_intro_buildup_sound = v17;
            local v18 = u15.current_reveal_total_duration or 3;
            v17:Play();
            l__item_row__16.Position = u3;
            u15:_scheduleExtractIntro(l__extract_intro_run_id__15, v18 - 0.6, function() --[[ Line: 115 ]]
                -- upvalues: l__TweenService__1 (ref), l__item_row__16 (copy), u2 (ref), u15 (ref)
                local v19 = l__TweenService__1:Create(l__item_row__16, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                    Position = u2
                });
                u15.extract_intro_item_row_tween = v19;
                v19:Play();
            end);
            l__item_row__16.UIGradient.Enabled = false;
            l__item_row__16.ScrollGradient.Enabled = true;
            local v20 = Instance.new("PitchShiftSoundEffect");
            u15.extract_intro_pitch_effect = v20;
            local v21 = l__TweenService__1:Create(v20, TweenInfo.new(v18, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                Octave = 1.5
            });
            u15.extract_intro_pitch_tween = v21;
            v21:Play();
            l__Lighting__4.ExposureCompensation = -100;
            u15:_scheduleExtractIntro(l__extract_intro_run_id__15, v18 - 1.15, function() --[[ Line: 136 ]]
                -- upvalues: u15 (ref), l__Classes__13 (ref)
                u15.extract_intro_windup_sound = l__Classes__13._xbe184fb1376a575d:_x7ab8b42cc5920a78("EXTRACT_WINDUP", true);
            end);
            if u16 == "Classified" then
                u15:_scheduleExtractIntro(l__extract_intro_run_id__15, v18 - 0.69, function() --[[ Line: 141 ]]
                    -- upvalues: l__Classes__13 (ref)
                    l__Classes__13._xbe184fb1376a575d:_x7ab8b42cc5920a78("DNB_BUILDUP", true);
                end);
            end;
            u15:_scheduleExtractIntro(l__extract_intro_run_id__15, v18, function() --[[ Line: 146 ]]
                -- upvalues: u16 (copy), l__Classes__13 (ref), u15 (ref), l__Lighting__4 (ref), l__TweenService__1 (ref), l__item_row__16 (copy), u4 (ref), u2 (ref)
                if u16 == "Exotic" then
                    l__Classes__13._xbe184fb1376a575d:_x7ab8b42cc5920a78("GLIMMER2", true);
                    l__Classes__13._xbe184fb1376a575d:_x7ab8b42cc5920a78("IMPACT_MORE", true);
                elseif u16 == "Elite" then
                    l__Classes__13._xbe184fb1376a575d:_x7ab8b42cc5920a78("IMPACT_MORE", true);
                else
                    l__Classes__13._xbe184fb1376a575d:_x7ab8b42cc5920a78("IMPACT", true);
                end;
                l__Classes__13._xbe184fb1376a575d:_x7ab8b42cc5920a78("TELEPORT_DRAMATIC", true);
                if u16 then
                    u15.camera_intro_context = u15.camera_intro_context or {};
                    u15.camera_intro_context.extracted_rarity = u16;
                end;
                l__Lighting__4.ExposureCompensation = 3;
                l__Classes__13._x255cd8d76027f039:_xee1cb09b95057806(0.5, 3);
                local v22 = l__TweenService__1:Create(l__Lighting__4, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    ExposureCompensation = 0
                });
                u15.extract_intro_exposure_tween = v22;
                v22:Play();
                l__Classes__13._xfaee1d1d64cdfe93._x9374c60b0eb68ccd = 0.8;
                l__item_row__16.Position = u4;
                local v23 = l__TweenService__1:Create(l__item_row__16, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                    Position = u2
                });
                u15.extract_intro_item_row_tween = v23;
                v23:Play();
                l__item_row__16.UIGradient.Enabled = true;
                l__item_row__16.ScrollGradient.Enabled = false;
                if u16 == "Classified" then
                    l__Classes__13._xbe184fb1376a575d:_x7ab8b42cc5920a78("VICTORY", true);
                    l__Classes__13._xbe184fb1376a575d:_x7ab8b42cc5920a78("RESULT", true);
                end;
                if u15.extract_intro_windup_sound then
                    u15.extract_intro_windup_sound:Destroy();
                    u15.extract_intro_windup_sound = nil;
                end;
                if u15.extract_intro_buildup_sound then
                    u15.extract_intro_buildup_sound:Destroy();
                    u15.extract_intro_buildup_sound = nil;
                end;
                if u15.extract_intro_pitch_effect then
                    u15.extract_intro_pitch_effect:Destroy();
                    u15.extract_intro_pitch_effect = nil;
                end;
            end);
        end,
        update = function() --[[ Name: update, Line 198 ]] end
    }
};
local u25 = {
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7
};
local u26 = {
    0,
    1,
    3,
    4,
    5,
    7
};
local u27 = {
    0,
    1,
    4,
    5,
    6
};
local function u32(p28) --[[ Line: 208 ]]
    local v29 = workspace:FindFirstChild("Showcase");
    if v29 then
        local v30 = v29:FindFirstChild(p28);
        if v30 and v30:IsA("BasePart") then
            return v30;
        end;
    end;
    local v31 = workspace:FindFirstChild(p28);
    if v31 and v31:IsA("BasePart") then
        return v31;
    else
        return nil;
    end;
end;
local function u35(p33) --[[ Line: 237 ]]
    if p33.Name == "Empty" then
    else
        for _, v34 in p33:GetChildren() do
            if not v34:IsA("UIListLayout") and (not v34:IsA("UIGridLayout") and (not v34:IsA("UIPadding") and v34.Name ~= "Empty")) then
                v34:Destroy();
            end;
        end;
    end;
end;
local function u44(p36, p37, p38) --[[ Line: 318 ]]
    local v39 = {};
    for v40, v41 in p38 do
        local v42 = math.floor(v41 / 4) % 2 * 2 - 1;
        local v43 = math.floor(v41 / 2) % 2 * 2 - 1;
        v39[v40] = p36 * (p37 * Vector3.new(v42, v43, 2 * (v41 % 2) - 1));
    end;
    return v39;
end;
local function u50(p45) --[[ Line: 330 ]]
    -- upvalues: u26 (copy), u27 (copy), u25 (copy), u44 (copy)
    local v46 = {};
    for _, v47 in p45:GetDescendants() do
        if v47:IsA("BasePart") then
            local v48;
            if v47:IsA("WedgePart") then
                v48 = u26;
            elseif v47:IsA("CornerWedgePart") then
                v48 = u27;
            else
                v48 = u25;
            end;
            for _, v49 in u44(v47.CFrame, v47.Size / 2, v48) do
                table.insert(v46, v49);
            end;
        end;
    end;
    if #v46 == 0 then
        local l__Position__17 = p45:GetPivot().Position;
        table.insert(v46, l__Position__17);
    end;
    return v46;
end;
local function u59(p51) --[[ Line: 350 ]]
    if #p51 == 0 then
        return nil, nil;
    end;
    local v52 = (1 / 0);
    local v53 = (1 / 0);
    local v54 = (1 / 0);
    local v55 = (-1 / 0);
    local v56 = (-1 / 0);
    local v57 = (-1 / 0);
    for _, v58 in p51 do
        v52 = math.min(v52, v58.X);
        v53 = math.min(v53, v58.Y);
        v54 = math.min(v54, v58.Z);
        v55 = math.max(v55, v58.X);
        v56 = math.max(v56, v58.Y);
        v57 = math.max(v57, v58.Z);
    end;
    return Vector3.new(v52, v53, v54), Vector3.new(v55, v56, v57);
end;
local function u70(p60, p61, p62, p63) --[[ Line: 374 ]]
    local v64 = (-1 / 0);
    local v65 = (1 / 0);
    for _, v66 in p60 do
        local v67 = p63 * (p62 - v66.Z);
        local v68 = v66[p61] + v67;
        local v69 = v66[p61] - v67;
        v64 = math.max(v64, v68, v69);
        v65 = math.min(v65, v68, v69);
    end;
    return v64, v65;
end;
local function u83(p71, p72, p73) --[[ Line: 392 ]]
    -- upvalues: u70 (copy)
    local l___points__18 = p71._points;
    if not p71.Model or (not l___points__18 or #l___points__18 == 0) then
        return CFrame.new();
    end;
    local v74 = (p72 - p72.Position):Inverse();
    local v75 = { v74 * l___points__18[1] };
    local l__Z__19 = v75[1].Z;
    for v76 = 2, #l___points__18 do
        local v77 = v74 * l___points__18[v76];
        l__Z__19 = math.min(l__Z__19, v77.Z);
        v75[v76] = v77;
    end;
    local v78, v79 = u70(v75, "X", l__Z__19, p71._viewport.tanxFov2);
    local v80, v81 = u70(v75, "Y", l__Z__19, p71._viewport.tanyFov2);
    local v82 = (v80 - v81) / 2 / (p71._viewport.tanyFov2 * p73);
    return p72 * CFrame.new((v78 + v79) / 2 - -0.33999999999999997 * p71._viewport.tanxFov2 * v82, (v80 + v81) / 2, l__Z__19 + v82);
end;
local function u87(p84) --[[ Line: 423 ]]
    if typeof(p84) ~= "Instance" then
        return nil;
    end;
    if p84:IsA("Model") then
        return p84;
    end;
    local v85 = nil;
    for _, v86 in p84:GetDescendants() do
        if v86:IsA("Model") then
            if v86:FindFirstChild("CharacterMotor6D", true) then
                return v86;
            end;
            v85 = v85 or v86;
        end;
    end;
    return v85;
end;
local function u92(p88) --[[ Line: 446 ]]
    -- upvalues: l__ReplicatedStorage__3 (copy), u87 (copy)
    local v89 = l__ReplicatedStorage__3:FindFirstChild("Assets");
    if v89 then
        v89 = v89:FindFirstChild("Rigs3P");
    end;
    if not v89 then
        return nil;
    end;
    local v90 = u87(v89:FindFirstChild(p88));
    if v90 then
        return v90;
    end;
    for _, v91 in v89:GetChildren() do
        if v91:GetAttribute("item_id") == p88 then
            return u87(v91);
        end;
    end;
    return nil;
end;
local function u94(p93) --[[ Line: 467 ]]
    -- upvalues: u87 (copy), l__SkinDefs__9 (copy), u92 (copy)
    if typeof(p93) == "table" and typeof(p93.item_id) == "string" then
        return typeof(p93.skin_id) == "number" and u87(l__SkinDefs__9.resolveRig3P(p93.item_id, p93.skin_id)) or u92(p93.item_id);
    else
        return nil;
    end;
end;
local function u97(p95) --[[ Line: 482 ]]
    for _, v96 in p95:GetDescendants() do
        if v96:IsA("BasePart") then
            v96.Anchored = true;
            v96.CanCollide = false;
            v96.CanQuery = false;
            v96.CanTouch = false;
        end;
    end;
end;
local function u100(p98) --[[ Line: 493 ]]
    -- upvalues: l__SkinDefs__9 (copy)
    local v99 = {
        priority = 0,
        name = "",
        color = Color3.fromRGB(255, 255, 255)
    };
    if typeof(p98) == "table" then
        local l__rarity__20 = p98.rarity;
        if typeof(l__rarity__20) == "string" then
            return l__SkinDefs__9.RARITIES[l__rarity__20] or {
                priority = 0,
                name = l__rarity__20,
                color = Color3.fromRGB(255, 255, 255)
            };
        elseif typeof(l__rarity__20) == "table" then
            return l__rarity__20;
        else
            return v99;
        end;
    else
        return v99;
    end;
end;
local function u102(p101) --[[ Line: 523 ]]
    if p101 then
        p101 = p101.color;
    end;
    if typeof(p101) == "ColorSequence" then
        return p101;
    elseif typeof(p101) == "Color3" then
        return ColorSequence.new(p101);
    else
        return ColorSequence.new(Color3.fromRGB(255, 255, 255));
    end;
end;
local function u105(p103) --[[ Line: 573 ]]
    -- upvalues: u100 (copy)
    local v104;
    if typeof(p103) == "table" then
        if typeof(p103.rarity) == "string" and p103.rarity ~= "" then
            v104 = p103.rarity;
        else
            local l__def__21 = p103.def;
            if typeof(l__def__21) == "table" and typeof(l__def__21.rarity) == "string" then
                v104 = l__def__21.rarity;
            else
                v104 = nil;
            end;
        end;
    else
        v104 = nil;
    end;
    if typeof(v104) == "string" then
        return u100({
            rarity = v104
        });
    else
        return (typeof(p103) ~= "table" or typeof(p103.def) ~= "table") and {
            priority = 0,
            name = "",
            color = Color3.fromRGB(255, 255, 255)
        } or u100(p103.def);
    end;
end;
local function u108(p106) --[[ Line: 619 ]]
    if typeof(p106) ~= "table" then
        return nil;
    end;
    for _, v107 in ipairs(p106) do
        if typeof(v107) == "table" and v107.is_dummy ~= true then
            return v107;
        end;
    end;
    return nil;
end;
local function u111(p109) --[[ Line: 637 ]]
    if typeof(p109) == "table" and typeof(p109.def) == "table" then
        local l__def__22 = p109.def;
        if typeof(p109.slot_id) == "string" then
            return p109.slot_id;
        else
            return tostring(l__def__22.item_id or "") .. ":" .. tostring(l__def__22.skin_id or "");
        end;
    elseif typeof(p109) == "table" and typeof(p109.slot_id) == "string" then
        return p109.slot_id;
    else
        local v110;
        if typeof(p109) == "table" then
            if typeof(p109.grant_type) == "string" then
                v110 = p109.grant_type;
            else
                v110 = typeof(p109.def) == "table" and "skin" or nil;
            end;
        else
            v110 = nil;
        end;
        if v110 == "title" then
            return "title:" .. tostring(p109.id or (p109.title_cenum or ""));
        elseif v110 == "dummy" then
            return typeof(p109.slot_id) == "string" and p109.slot_id or nil;
        else
            return nil;
        end;
    end;
end;
function u1.new(p112, p113) --[[ Line: 675 ]]
    -- upvalues: u1 (copy), l__InternalSymbols__14 (copy), l__UIAssets__12 (copy), l__Trove__10 (copy)
    local v114 = setmetatable({}, u1);
    v114.menu_session = l__InternalSymbols__14.owner("MenuSession", p113);
    v114.parent_os = p112;
    v114.page_origin = l__UIAssets__12.Menu.ShowcasePage;
    v114.main_page = v114.page_origin.InspectFrame:Clone();
    v114.ui = nil;
    v114.return_page = "loadout_page";
    v114.slot_entries = {};
    v114.selected_slot = nil;
    v114.previous_camera_state = nil;
    v114.hidden_menu_container_states = nil;
    v114.showcase_field_of_view = nil;
    v114.camera_fov_goal = nil;
    v114.camera_current_cframe = nil;
    v114.camera_current_fov = nil;
    v114.camera_last_position = nil;
    v114.camera_roll_goal = 0;
    v114.camera_roll_current = 0;
    v114.camera_mouse_yaw = 0;
    v114.camera_mouse_pitch = 0;
    v114.camera_intro_type = nil;
    v114.camera_intro_elapsed = 0;
    v114.camera_intro_context = nil;
    v114.extract_intro_run_id = 0;
    v114.extract_intro_buildup_sound = nil;
    v114.extract_intro_windup_sound = nil;
    v114.extract_intro_pitch_effect = nil;
    v114.extract_intro_pitch_tween = nil;
    v114.extract_intro_item_row_tween = nil;
    v114.extract_intro_exposure_tween = nil;
    v114.reveal_camera_shake_elapsed = 0.6;
    v114.reveal_camera_shake_seed = 0;
    v114.scroll_blur = nil;
    v114.scroll_blur_tween = nil;
    v114.slot_scroll_tween = nil;
    v114.scene_model = nil;
    v114.model_base_cframe = nil;
    v114.model_bounds_center_position = nil;
    v114.model_trove = nil;
    v114.open_id = 0;
    v114.dragging = false;
    v114.drag_input = nil;
    v114.drag_last_position = nil;
    v114.sway_goal = 0;
    v114.sway_current = 0;
    v114.sway_z_goal = 0;
    v114.sway_z_current = 0;
    v114.current_mode = "inventory";
    v114.return_page_args = nil;
    v114.aggregate_slots = true;
    v114.selection_locked = false;
    v114.reveal_state = nil;
    v114.reveal_banner_id = nil;
    v114.reveal_source_currency = nil;
    v114.current_reveal_scroll_bonus_duration = 0;
    v114.current_reveal_hold_duration = 0;
    v114.current_reveal_scroll_duration = 2.8;
    v114.current_reveal_settle_duration = 0.2;
    v114.current_reveal_total_duration = 3;
    v114.trove = l__Trove__10.new();
    v114.content_trove = v114.trove:Extend();
    v114.scene_trove = v114.trove:Extend();
    v114.reveal_trove = v114.trove:Extend();
    v114.action_trove = v114.trove:Extend();
    v114.trove:Add(v114.main_page);
    return v114;
end;
function u1.cleanUp(p115) --[[ Line: 749 ]]
    p115:_cancelExtractIntroRun();
    if p115.slot_scroll_tween then
        p115.slot_scroll_tween:Cancel();
        p115.slot_scroll_tween = nil;
    end;
    p115.reveal_trove:Clean();
    p115.action_trove:Clean();
    p115:_restoreMenuContainersVisibility();
    p115.trove:Clean();
end;
function u1._hideMenuContainers(p116) --[[ Line: 762 ]]
    if p116.hidden_menu_container_states then
    else
        p116.hidden_menu_container_states = {};
        for _, v117 in { "LeftContainer", "MidContainer" } do
            local v118 = p116.parent_os:FindFirstChild(v117);
            if v118 and v118:IsA("GuiObject") then
                p116.hidden_menu_container_states[v118] = v118.Visible;
                v118.Visible = false;
            end;
        end;
    end;
end;
function u1._restoreMenuContainersVisibility(p119) --[[ Line: 778 ]]
    local l__hidden_menu_container_states__23 = p119.hidden_menu_container_states;
    if l__hidden_menu_container_states__23 then
        for v120, v121 in l__hidden_menu_container_states__23 do
            if v120 and (v120.Parent and v120:IsA("GuiObject")) then
                v120.Visible = v121;
            end;
        end;
        p119.hidden_menu_container_states = nil;
    end;
end;
function u1._getUi(p122) --[[ Line: 793 ]]
    if p122.ui then
        return p122.ui;
    end;
    local l__main_page__24 = p122.main_page;
    local v123 = l__main_page__24:FindFirstChild("Main");
    if not v123 then
        v123 = l__main_page__24:FindFirstChild("Main", true);
        assert(v123, "ShowcasePage UI is missing child: Main");
    end;
    local v124 = v123:FindFirstChild("DetailsContainer");
    if not v124 then
        v124 = v123:FindFirstChild("DetailsContainer", true);
        assert(v124, "ShowcasePage UI is missing child: DetailsContainer");
    end;
    local v125 = v124:FindFirstChild("HeaderFrame");
    if not v125 then
        v125 = v124:FindFirstChild("HeaderFrame", true);
        assert(v125, "ShowcasePage UI is missing child: HeaderFrame");
    end;
    local v126 = v123:FindFirstChild("ItemRow");
    if not v126 then
        v126 = v123:FindFirstChild("ItemRow", true);
        assert(v126, "ShowcasePage UI is missing child: ItemRow");
    end;
    local v127 = v126:FindFirstChild("ScrollingFrame");
    if not v127 then
        v127 = v126:FindFirstChild("ScrollingFrame", true);
        assert(v127, "ShowcasePage UI is missing child: ScrollingFrame");
    end;
    local v128 = v123:FindFirstChild("ActionsContainer");
    if not v128 then
        v128 = v123:FindFirstChild("ActionsContainer", true);
        assert(v128, "ShowcasePage UI is missing child: ActionsContainer");
    end;
    local v129 = v128:FindFirstChild("PrimaryFrame");
    if not v129 then
        v129 = v128:FindFirstChild("PrimaryFrame", true);
        assert(v129, "ShowcasePage UI is missing child: PrimaryFrame");
    end;
    local v130 = v129:FindFirstChild("Info");
    if not v130 then
        v130 = v129:FindFirstChild("Info", true);
        assert(v130, "ShowcasePage UI is missing child: Info");
    end;
    local v131 = v130:FindFirstChild("Button");
    if not v131 then
        v131 = v130:FindFirstChild("Button", true);
        assert(v131, "ShowcasePage UI is missing child: Button");
    end;
    local v132 = v131:IsA("GuiButton");
    assert(v132, "ShowcasePage PrimaryFrame.Info.Button must be a GuiButton");
    local v133 = v128:FindFirstChild("SecondaryFrame");
    if not v133 then
        v133 = v128:FindFirstChild("SecondaryFrame", true);
        assert(v133, "ShowcasePage UI is missing child: SecondaryFrame");
    end;
    local v134 = {
        main = v123,
        details_container = v124
    };
    local v135 = l__main_page__24:FindFirstChild("PageTitle");
    if not v135 then
        v135 = l__main_page__24:FindFirstChild("PageTitle", true);
        assert(v135, "ShowcasePage UI is missing child: PageTitle");
    end;
    v134.page_title = v135;
    local v136 = v125:FindFirstChild("ItemLabel");
    if not v136 then
        v136 = v125:FindFirstChild("ItemLabel", true);
        assert(v136, "ShowcasePage UI is missing child: ItemLabel");
    end;
    v134.item_label = v136;
    local v137 = v125:FindFirstChild("SkinLabel");
    if not v137 then
        v137 = v125:FindFirstChild("SkinLabel", true);
        assert(v137, "ShowcasePage UI is missing child: SkinLabel");
    end;
    v134.skin_label = v137;
    local v138 = v124:FindFirstChild("CreditLabel");
    if not v138 then
        v138 = v124:FindFirstChild("CreditLabel", true);
        assert(v138, "ShowcasePage UI is missing child: CreditLabel");
    end;
    v134.credit_label = v138;
    local v139 = v124:FindFirstChild("RarityLabel");
    if not v139 then
        v139 = v124:FindFirstChild("RarityLabel", true);
        assert(v139, "ShowcasePage UI is missing child: RarityLabel");
    end;
    v134.rarity_label = v139;
    v134.item_row = v126;
    v134.scrolling_frame = v127;
    local v140 = l__main_page__24:FindFirstChild("ReturnButton");
    if not v140 then
        v140 = l__main_page__24:FindFirstChild("ReturnButton", true);
        assert(v140, "ShowcasePage UI is missing child: ReturnButton");
    end;
    v134.return_button = v140;
    v134.actions_container = v128;
    v134.primary_frame = v129;
    local v141 = v129:FindFirstChild("TextLabel");
    if not v141 then
        v141 = v129:FindFirstChild("TextLabel", true);
        assert(v141, "ShowcasePage UI is missing child: TextLabel");
    end;
    v134.primary_label = v141;
    local v142 = v129:FindFirstChild("Button");
    if not v142 then
        v142 = v129:FindFirstChild("Button", true);
        assert(v142, "ShowcasePage UI is missing child: Button");
    end;
    v134.primary_button = v142;
    local v143 = v129:FindFirstChild("Back");
    if not v143 then
        v143 = v129:FindFirstChild("Back", true);
        assert(v143, "ShowcasePage UI is missing child: Back");
    end;
    v134.primary_back = v143;
    v134.primary_info = v130;
    v134.primary_info_button = v131;
    v134.secondary_frame = v133;
    local v144 = v133:FindFirstChild("TextLabel");
    if not v144 then
        v144 = v133:FindFirstChild("TextLabel", true);
        assert(v144, "ShowcasePage UI is missing child: TextLabel");
    end;
    v134.secondary_label = v144;
    local v145 = v133:FindFirstChild("Button");
    if not v145 then
        v145 = v133:FindFirstChild("Button", true);
        assert(v145, "ShowcasePage UI is missing child: Button");
    end;
    v134.secondary_button = v145;
    local v146 = v133:FindFirstChild("Back");
    if not v146 then
        v146 = v133:FindFirstChild("Back", true);
        assert(v146, "ShowcasePage UI is missing child: Back");
    end;
    v134.secondary_back = v146;
    p122.ui = v134;
    return p122.ui;
end;
function u1._setActionFrame(_, p147, p148, p149, p150, p151, p152, p153, p154) --[[ Line: 839 ]]
    if p147:IsA("GuiObject") then
        p147.Visible = p154 ~= false;
    end;
    if p148 and p148:IsA("TextLabel") then
        p148.Text = p151;
    elseif p148 and p148:IsA("TextButton") then
        p148.Text = p151;
    end;
    if p150 then
        if p150:IsA("GuiObject") then
            p150.BackgroundColor3 = p153;
        end;
        if p150:IsA("ImageLabel") then
            p150.ImageColor3 = p153;
        elseif p150:IsA("ImageButton") then
            p150.ImageColor3 = p153;
        end;
    end;
    local v155 = p150:FindFirstChildWhichIsA("UIStroke", true);
    if v155 then
        v155.Color = p153;
    end;
    if p148:IsA("TextLabel") then
        p148.TextTransparency = p152 and 0 or 0.25;
    elseif p148:IsA("TextButton") then
        p148.TextTransparency = p152 and 0 or 0.25;
    end;
    if p149:IsA("GuiButton") then
        p149.Active = p152;
        p149.AutoButtonColor = p152;
        p149.Selectable = p152;
        p149.Interactable = p152;
    end;
end;
function u1._clearRevealExtractButtons(p156) --[[ Line: 866 ]]
    p156.action_trove:Clean();
end;
function u1._shouldShowRevealInfoButton(p157) --[[ Line: 870 ]]
    local l__selected_slot__25 = p157.selected_slot;
    local v158;
    if p157.current_mode == "banner_reveal" and (p157.selection_locked ~= true and (l__selected_slot__25 ~= nil and (l__selected_slot__25.revealed == true and typeof(p157.reveal_banner_id) == "string"))) then
        v158 = p157.reveal_banner_id ~= "";
    else
        v158 = false;
    end;
    return v158;
end;
function u1._setRevealInfoVisible(p159, p160) --[[ Line: 880 ]]
    local v161 = p159:_getUi();
    local l__primary_info__26 = v161.primary_info;
    if l__primary_info__26 and l__primary_info__26:IsA("GuiObject") then
        l__primary_info__26.Visible = p160;
    end;
    local l__primary_info_button__27 = v161.primary_info_button;
    if l__primary_info_button__27 then
        l__primary_info_button__27.Active = p160;
        l__primary_info_button__27.AutoButtonColor = p160;
        l__primary_info_button__27.Selectable = p160;
        l__primary_info_button__27.Interactable = p160;
    end;
end;
function u1._openRevealBannerPreview(p162) --[[ Line: 886 ]]
    -- upvalues: l__InternalSymbols__14 (copy)
    if p162:_shouldShowRevealInfoButton() then
        local l__owner__28 = l__InternalSymbols__14.owner;
        local v163 = "CosmeticsTab";
        local l__menu_session__29 = p162.menu_session;
        if l__menu_session__29 then
            l__menu_session__29 = l__menu_session__29.pages;
        end;
        if l__menu_session__29 then
            l__menu_session__29 = l__menu_session__29.shop_page;
        end;
        if l__menu_session__29 then
            l__menu_session__29 = l__menu_session__29.tabs;
        end;
        if l__menu_session__29 then
            l__menu_session__29 = l__menu_session__29.Cosmetics;
        end;
        local v164 = l__owner__28(v163, l__menu_session__29 and l__menu_session__29.obj or nil);
        if v164 and v164.openBannerPreviewById then
            v164:openBannerPreviewById(p162.reveal_banner_id);
        end;
    end;
end;
function u1._getRevealRerollOption(p165) --[[ Line: 899 ]]
    -- upvalues: l__InternalSymbols__14 (copy)
    if p165.current_mode == "banner_reveal" and not p165.selection_locked then
        local l__selected_slot__30 = p165.selected_slot;
        if l__selected_slot__30 and l__selected_slot__30.revealed == true then
            if typeof(p165.reveal_banner_id) == "string" and p165.reveal_banner_id ~= "" then
                if typeof(p165.reveal_source_currency) == "string" and p165.reveal_source_currency ~= "" then
                    local l__owner__31 = l__InternalSymbols__14.owner;
                    local v166 = "CosmeticsTab";
                    local l__menu_session__32 = p165.menu_session;
                    if l__menu_session__32 then
                        l__menu_session__32 = l__menu_session__32.pages;
                    end;
                    if l__menu_session__32 then
                        l__menu_session__32 = l__menu_session__32.shop_page;
                    end;
                    if l__menu_session__32 then
                        l__menu_session__32 = l__menu_session__32.tabs;
                    end;
                    if l__menu_session__32 then
                        l__menu_session__32 = l__menu_session__32.Cosmetics;
                    end;
                    local v167 = l__owner__31(v166, l__menu_session__32 and l__menu_session__32.obj or nil);
                    if v167 and v167.getRevealRerollOption then
                        return v167:getRevealRerollOption(p165.reveal_banner_id, p165.reveal_source_currency);
                    else
                        return nil;
                    end;
                else
                    return nil;
                end;
            else
                return nil;
            end;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function u1._renderRevealExtractButton(u168, p169) --[[ Line: 925 ]]
    -- upvalues: l__UIAssets__12 (copy), l__InternalSymbols__14 (copy)
    local u170 = u168:_getRevealRerollOption();
    if not u170 then
        return false;
    end;
    local l__Cosmetics__33 = l__UIAssets__12.Menu.ShopPage.Cosmetics;
    if l__Cosmetics__33 then
        l__Cosmetics__33 = l__Cosmetics__33:FindFirstChild("ExtractButton");
    end;
    assert(l__Cosmetics__33, "ShowcasePage reroll is missing ExtractButton template");
    local v171 = u168:_getUi();
    local v172;
    if p169 then
        v172 = v171.secondary_frame;
    else
        v172 = v171.primary_frame;
    end;
    local v173 = l__Cosmetics__33:Clone();
    v173:SetAttribute("GeneratedShowcaseExtractButton", true);
    v173.Visible = true;
    if v173:IsA("GuiObject") and v172:IsA("GuiObject") then
        v173.Position = v172.Position;
        v173.AnchorPoint = v172.AnchorPoint;
        v173.ZIndex = v172.ZIndex;
    end;
    local v174 = v173:FindFirstChild("NumberFrame");
    if not v174 then
        v174 = v173:FindFirstChild("NumberFrame", true);
        assert(v174, "ShowcasePage UI is missing child: NumberFrame");
    end;
    local v175 = v174:FindFirstChild("NumberText");
    if not v175 then
        v175 = v174:FindFirstChild("NumberText", true);
        assert(v175, "ShowcasePage UI is missing child: NumberText");
    end;
    local v176 = v174:FindFirstChild("CrimsonImage");
    if not v176 then
        v176 = v174:FindFirstChild("CrimsonImage", true);
        assert(v176, "ShowcasePage UI is missing child: CrimsonImage");
    end;
    local v177 = v173:FindFirstChild("LockedFrame");
    if not v177 then
        v177 = v173:FindFirstChild("LockedFrame", true);
        assert(v177, "ShowcasePage UI is missing child: LockedFrame");
    end;
    local l__display_text__34 = u170.display_text;
    if v175 and v175:IsA("TextLabel") then
        v175.Text = l__display_text__34;
    elseif v175 and v175:IsA("TextButton") then
        v175.Text = l__display_text__34;
    end;
    local v178 = u170.show_crimson == true;
    if v176 and v176:IsA("GuiObject") then
        v176.Visible = v178;
    end;
    if v177 and v177:IsA("GuiObject") then
        v177.Visible = false;
    end;
    local v179;
    if v173:IsA("GuiButton") then
        v179 = v173;
    else
        v179 = v173:FindFirstChildWhichIsA("ImageButton", true) or v173:FindFirstChildWhichIsA("TextButton", true);
    end;
    if v179 then
        v179.Active = true;
        v179.AutoButtonColor = true;
        v179.Selectable = true;
        v179.Interactable = true;
    end;
    u168.action_trove:Connect(v179.Activated, function() --[[ Line: 957 ]]
        -- upvalues: l__InternalSymbols__14 (ref), u168 (copy), u170 (copy)
        local l__owner__35 = l__InternalSymbols__14.owner;
        local v180 = "CosmeticsTab";
        local l__menu_session__36 = u168.menu_session;
        if l__menu_session__36 then
            l__menu_session__36 = l__menu_session__36.pages;
        end;
        if l__menu_session__36 then
            l__menu_session__36 = l__menu_session__36.shop_page;
        end;
        if l__menu_session__36 then
            l__menu_session__36 = l__menu_session__36.tabs;
        end;
        if l__menu_session__36 then
            l__menu_session__36 = l__menu_session__36.Cosmetics;
        end;
        local v181 = l__owner__35(v180, l__menu_session__36 and l__menu_session__36.obj or nil);
        if v181 and v181.startRevealReroll then
            v181:startRevealReroll(u168, u170.banner_id, u170.currency);
        end;
    end);
    v173.Parent = v171.actions_container;
    u168.action_trove:Add(v173);
    return true;
end;
function u1._applyActionButtonAnchor(_, p182, p183) --[[ Line: 971 ]]
    if p182:IsA("GuiObject") and p183:IsA("GuiObject") then
        p182.Position = p183.Position;
        p182.AnchorPoint = p183.AnchorPoint;
        p182.ZIndex = p183.ZIndex;
    end;
end;
function u1._renderBannerPreviewPurchaseButtons(u184, p185) --[[ Line: 979 ]]
    -- upvalues: l__InternalSymbols__14 (copy), l__UIAssets__12 (copy)
    if u184.selection_locked then
        return false;
    end;
    local l__current_mode__37 = u184.current_mode;
    if l__current_mode__37 == "banner_reveal" then
        local l__selected_slot__38 = u184.selected_slot;
        if not l__selected_slot__38 or l__selected_slot__38.revealed ~= true then
            return false;
        end;
    elseif l__current_mode__37 ~= "banner_preview" then
        return false;
    end;
    if typeof(u184.reveal_banner_id) ~= "string" or u184.reveal_banner_id == "" then
        return false;
    end;
    local l__owner__39 = l__InternalSymbols__14.owner;
    local v186 = "CosmeticsTab";
    local l__menu_session__40 = u184.menu_session;
    if l__menu_session__40 then
        l__menu_session__40 = l__menu_session__40.pages;
    end;
    if l__menu_session__40 then
        l__menu_session__40 = l__menu_session__40.shop_page;
    end;
    if l__menu_session__40 then
        l__menu_session__40 = l__menu_session__40.tabs;
    end;
    if l__menu_session__40 then
        l__menu_session__40 = l__menu_session__40.Cosmetics;
    end;
    local v187 = l__owner__39(v186, l__menu_session__40 and l__menu_session__40.obj or nil);
    if not (v187 and v187.getBannerPurchaseOptions) then
        return false;
    end;
    local v188 = v187:getBannerPurchaseOptions(u184.reveal_banner_id, false);
    if #v188 <= 0 then
        return false;
    end;
    local l__Cosmetics__41 = l__UIAssets__12.Menu.ShopPage.Cosmetics;
    local v189;
    if l__Cosmetics__41 then
        v189 = l__Cosmetics__41:FindFirstChild("ExtractButton");
    else
        v189 = l__Cosmetics__41;
    end;
    if l__Cosmetics__41 then
        l__Cosmetics__41 = l__Cosmetics__41:FindFirstChild("RobuxButton");
    end;
    assert(v189, "ShowcasePage banner preview is missing ExtractButton template");
    assert(l__Cosmetics__41, "ShowcasePage banner preview is missing RobuxButton template");
    local v190 = u184:_getUi();
    local v191;
    if l__current_mode__37 == "banner_reveal" then
        if p185 then
            v191 = #v188 > 1;
        else
            v191 = p185;
        end;
    else
        v191 = false;
    end;
    local v192;
    if v191 then
        v192 = nil;
    elseif p185 then
        v192 = { v190.secondary_frame };
    else
        v192 = { v190.primary_frame, v190.secondary_frame };
    end;
    local v193 = 0;
    for _, u194 in ipairs(v188) do
        local v195 = nil;
        if u194.kind == "extract" then
            v195 = v189:Clone();
            local v196 = v195:FindFirstChild("NumberFrame");
            if not v196 then
                v196 = v195:FindFirstChild("NumberFrame", true);
                assert(v196, "ShowcasePage UI is missing child: NumberFrame");
            end;
            local v197 = v196:FindFirstChild("NumberText");
            if not v197 then
                v197 = v196:FindFirstChild("NumberText", true);
                assert(v197, "ShowcasePage UI is missing child: NumberText");
            end;
            local v198 = v196:FindFirstChild("CrimsonImage");
            if not v198 then
                v198 = v196:FindFirstChild("CrimsonImage", true);
                assert(v198, "ShowcasePage UI is missing child: CrimsonImage");
            end;
            local v199 = v195:FindFirstChild("LockedFrame");
            if not v199 then
                v199 = v195:FindFirstChild("LockedFrame", true);
                assert(v199, "ShowcasePage UI is missing child: LockedFrame");
            end;
            local l__display_text__42 = u194.display_text;
            if v197 and v197:IsA("TextLabel") then
                v197.Text = l__display_text__42;
            elseif v197 and v197:IsA("TextButton") then
                v197.Text = l__display_text__42;
            end;
            local v200 = u194.show_crimson == true;
            if v198 and v198:IsA("GuiObject") then
                v198.Visible = v200;
            end;
            local v201 = u194.locked == true;
            if v199 and v199:IsA("GuiObject") then
                v199.Visible = v201;
            end;
        elseif u194.kind == "robux" or u194.kind == "gift_robux" then
            v195 = l__Cosmetics__41:Clone();
            local v202 = v195:FindFirstChild("PriceText");
            if not v202 then
                v202 = v195:FindFirstChild("PriceText", true);
                assert(v202, "ShowcasePage UI is missing child: PriceText");
            end;
            local v203 = v195:FindFirstChild("Extra");
            if not v203 then
                v203 = v195:FindFirstChild("Extra", true);
                assert(v203, "ShowcasePage UI is missing child: Extra");
            end;
            local v204 = v203:FindFirstChild("NumberFrame");
            if not v204 then
                v204 = v203:FindFirstChild("NumberFrame", true);
                assert(v204, "ShowcasePage UI is missing child: NumberFrame");
            end;
            local v205 = v204:FindFirstChild("NumberText");
            if not v205 then
                v205 = v204:FindFirstChild("NumberText", true);
                assert(v205, "ShowcasePage UI is missing child: NumberText");
            end;
            local l__price_text__43 = u194.price_text;
            if v202 and v202:IsA("TextLabel") then
                v202.Text = l__price_text__43;
            elseif v202 and v202:IsA("TextButton") then
                v202.Text = l__price_text__43;
            end;
            local l__crimson_amount_text__44 = u194.crimson_amount_text;
            if v205 and v205:IsA("TextLabel") then
                v205.Text = l__crimson_amount_text__44;
            elseif v205 and v205:IsA("TextButton") then
                v205.Text = l__crimson_amount_text__44;
            end;
            if u194.direct_purchase == true then
                local v206 = v204:FindFirstChild("CrimsonImage");
                if not v206 then
                    v206 = v204:FindFirstChild("CrimsonImage", true);
                    assert(v206, "ShowcasePage UI is missing child: CrimsonImage");
                end;
                local v207 = v204:FindFirstChild("Get");
                if not v207 then
                    v207 = v204:FindFirstChild("Get", true);
                    assert(v207, "ShowcasePage UI is missing child: Get");
                end;
                v205.Size = UDim2.fromScale(1, 0.8);
                if v206 and v206:IsA("GuiObject") then
                    v206.Visible = false;
                end;
                if v207 and v207:IsA("GuiObject") then
                    v207.Visible = false;
                end;
            end;
            local v208 = u194.extra_visible ~= false;
            if v203 and v203:IsA("GuiObject") then
                v203.Visible = v208;
            end;
        end;
        if v195 then
            v193 = v193 + 1;
            v195:SetAttribute("GeneratedShowcaseExtractButton", true);
            v195.Visible = true;
            if v192 then
                u184:_applyActionButtonAnchor(v195, v192[v193] or v192[#v192]);
            end;
            local v209;
            if v195:IsA("GuiButton") then
                v209 = v195;
            else
                v209 = v195:FindFirstChildWhichIsA("ImageButton", true) or v195:FindFirstChildWhichIsA("TextButton", true);
            end;
            local v210 = u194.enabled == true;
            if v209 then
                v209.Active = v210;
                v209.AutoButtonColor = v210;
                v209.Selectable = v210;
                v209.Interactable = v210;
            end;
            if v209 then
                u184.action_trove:Connect(v209.Activated, function() --[[ Line: 1070 ]]
                    -- upvalues: l__InternalSymbols__14 (ref), u184 (copy), u194 (copy)
                    local l__owner__45 = l__InternalSymbols__14.owner;
                    local v211 = "CosmeticsTab";
                    local l__menu_session__46 = u184.menu_session;
                    if l__menu_session__46 then
                        l__menu_session__46 = l__menu_session__46.pages;
                    end;
                    if l__menu_session__46 then
                        l__menu_session__46 = l__menu_session__46.shop_page;
                    end;
                    if l__menu_session__46 then
                        l__menu_session__46 = l__menu_session__46.tabs;
                    end;
                    if l__menu_session__46 then
                        l__menu_session__46 = l__menu_session__46.Cosmetics;
                    end;
                    local v212 = l__owner__45(v211, l__menu_session__46 and l__menu_session__46.obj or nil);
                    if v212 and v212.activateBannerPurchaseOption then
                        v212:activateBannerPurchaseOption(u184, u194);
                    end;
                end);
            end;
            v195.Parent = v190.actions_container;
            u184.action_trove:Add(v195);
        end;
    end;
    return v193 > 0;
end;
function u1._renderGeneratedActionButtons(p213, p214) --[[ Line: 1087 ]]
    p213:_clearRevealExtractButtons();
    if p213.current_mode == "banner_preview" or p213.current_mode == "banner_reveal" then
        return p213:_renderBannerPreviewPurchaseButtons(p214);
    else
        return p213:_renderRevealExtractButton(p214);
    end;
end;
function u1._getSelectedPrimaryAction(p215) --[[ Line: 1097 ]]
    -- upvalues: u5 (copy)
    local l__selected_slot__47 = p215.selected_slot;
    if not l__selected_slot__47 then
        return {
            text = "",
            enabled = false,
            kind = "none",
            visible = false,
            color = u5.disabled
        };
    end;
    if p215.current_mode ~= "banner_preview" and (not p215.selection_locked and l__selected_slot__47.action_kind ~= "none") then
        local v216;
        if typeof(l__selected_slot__47) == "table" then
            if typeof(l__selected_slot__47.grant_type) == "string" then
                v216 = l__selected_slot__47.grant_type;
            else
                v216 = typeof(l__selected_slot__47.def) == "table" and "skin" or nil;
            end;
        else
            v216 = nil;
        end;
        if v216 == "skin" then
            return l__selected_slot__47.unlocked ~= true and {
                text = "UNOWNED",
                enabled = false,
                kind = "unowned",
                visible = true,
                color = u5.disabled
            } or (l__selected_slot__47.equipped == true and {
                text = "APPLIED",
                enabled = false,
                kind = "equipped",
                visible = true,
                color = u5.equipped
            } or {
                text = "APPLY SKIN",
                enabled = true,
                kind = "equip",
                visible = true,
                color = u5.equip
            });
        end;
    end;
    return {
        text = "",
        enabled = false,
        kind = "none",
        visible = false,
        color = u5.disabled
    };
end;
function u1._updateActions(p217) --[[ Line: 1150 ]]
    -- upvalues: u5 (copy)
    local v218 = p217:_getUi();
    local v219 = p217:_getSelectedPrimaryAction();
    local v220 = v219.visible == true;
    local v221 = p217:_shouldShowRevealInfoButton();
    p217:_setActionFrame(v218.primary_frame, v218.primary_label, v218.primary_button, v218.primary_back, v219.text, v219.enabled, v219.color, v220 or v221);
    local l__primary_label__48 = v218.primary_label;
    if l__primary_label__48 and l__primary_label__48:IsA("GuiObject") then
        l__primary_label__48.Visible = v220;
    end;
    local l__primary_button__49 = v218.primary_button;
    if l__primary_button__49 and l__primary_button__49:IsA("GuiObject") then
        l__primary_button__49.Visible = v220;
    end;
    local l__primary_back__50 = v218.primary_back;
    if l__primary_back__50 and l__primary_back__50:IsA("GuiObject") then
        l__primary_back__50.Visible = v220;
    end;
    p217:_setRevealInfoVisible(v221);
    p217:_setActionFrame(v218.secondary_frame, v218.secondary_label, v218.secondary_button, v218.secondary_back, "", false, u5.disabled, false);
    local v222 = p217:_renderGeneratedActionButtons(v220);
    v218.actions_container.Visible = v220 or (v222 == true and true or v221);
end;
function u1._scheduleExtractIntro(u223, u224, p225, u226) --[[ Line: 1175 ]]
    task.delay(math.max(0, p225), function() --[[ Line: 1176 ]]
        -- upvalues: u223 (copy), u224 (copy), u226 (copy)
        if u223.extract_intro_run_id == u224 then
            u226();
        end;
    end);
end;
function u1._resetExtractIntroEffects(p227) --[[ Line: 1185 ]]
    -- upvalues: u2 (copy), l__Lighting__4 (copy), l__Classes__13 (copy)
    if p227.extract_intro_item_row_tween then
        p227.extract_intro_item_row_tween:Cancel();
        p227.extract_intro_item_row_tween = nil;
    end;
    if p227.extract_intro_exposure_tween then
        p227.extract_intro_exposure_tween:Cancel();
        p227.extract_intro_exposure_tween = nil;
    end;
    if p227.extract_intro_pitch_tween then
        p227.extract_intro_pitch_tween:Cancel();
        p227.extract_intro_pitch_tween = nil;
    end;
    if p227.extract_intro_buildup_sound then
        p227.extract_intro_buildup_sound:Destroy();
        p227.extract_intro_buildup_sound = nil;
    end;
    if p227.extract_intro_windup_sound then
        p227.extract_intro_windup_sound:Destroy();
        p227.extract_intro_windup_sound = nil;
    end;
    if p227.extract_intro_pitch_effect then
        p227.extract_intro_pitch_effect:Destroy();
        p227.extract_intro_pitch_effect = nil;
    end;
    local v228 = p227.ui or p227:_getUi();
    if v228 then
        v228 = v228.item_row;
    end;
    if v228 then
        v228.Position = u2;
        local v229 = v228:FindFirstChild("UIGradient");
        if v229 and v229:IsA("UIGradient") then
            v229.Enabled = true;
        end;
        local v230 = v228:FindFirstChild("ScrollGradient");
        if v230 and v230:IsA("UIGradient") then
            v230.Enabled = false;
        end;
    end;
    l__Lighting__4.ExposureCompensation = 0;
    l__Classes__13._xfaee1d1d64cdfe93._x9374c60b0eb68ccd = 0.8;
end;
function u1._cancelExtractIntroRun(p231) --[[ Line: 1236 ]]
    p231.extract_intro_run_id = p231.extract_intro_run_id + 1;
    p231:_resetExtractIntroEffects();
end;
function u1._resetTransientSceneUiState(p232) --[[ Line: 1241 ]]
    local v233 = p232:_getUi();
    p232:_cancelExtractIntroRun();
    p232.selected_slot = nil;
    p232.reveal_state = nil;
    p232.slot_entries = {};
    p232:_clearDetails();
    p232:_clearRevealExtractButtons();
    p232:_showSceneModel(nil);
    if p232.slot_scroll_tween then
        p232.slot_scroll_tween:Cancel();
        p232.slot_scroll_tween = nil;
    end;
    v233.details_container.Visible = false;
    v233.actions_container.Visible = false;
    p232:_setRevealInfoVisible(false);
    v233.return_button.Visible = false;
    v233.return_button.Interactable = false;
    p232.parent_os.CurrencyLayer.Visible = false;
    v233.scrolling_frame.CanvasPosition = Vector2.new(0, v233.scrolling_frame.CanvasPosition.Y);
end;
function u1._applyEquippedSkin(p234, p235, p236) --[[ Line: 1266 ]]
    -- upvalues: l__SkinDefs__9 (copy), l__Classes__13 (copy)
    local l__menu_session__51 = p234.menu_session;
    if l__menu_session__51 then
        l__menu_session__51 = p234.menu_session.item_profile_data;
    end;
    if l__menu_session__51 then
        if typeof(l__menu_session__51.equipped_skins) ~= "table" then
            l__menu_session__51.equipped_skins = {};
        end;
        if p236 == l__SkinDefs__9.DEFAULT_SKIN_ID then
            l__menu_session__51.equipped_skins[p235] = nil;
        else
            l__menu_session__51.equipped_skins[p235] = p236;
        end;
    end;
    for _, v237 in p234.slot_entries do
        if typeof(v237.def) == "table" and v237.def.item_id == p235 then
            if p236 == l__SkinDefs__9.DEFAULT_SKIN_ID then
                v237.equipped = v237.def.skin_id == l__SkinDefs__9.DEFAULT_SKIN_ID;
            else
                v237.equipped = v237.def.skin_id == p236;
            end;
            p234:_updateSlotVisual(v237, true);
        end;
    end;
    l__Classes__13._xbe184fb1376a575d:_x7ab8b42cc5920a78("BULLET_GAINED", true);
    l__Classes__13._xbe184fb1376a575d:_x7ab8b42cc5920a78("TAPE_MOVE", true);
    p234:_updateActions();
end;
function u1._activatePrimaryAction(p238) --[[ Line: 1309 ]]
    -- upvalues: l__Packets__8 (copy), l__Classes__13 (copy)
    local l__selected_slot__52 = p238.selected_slot;
    if l__selected_slot__52 and (l__selected_slot__52.unlocked == true and (not p238.selection_locked and p238.current_mode ~= "banner_preview")) then
        if l__selected_slot__52.action_kind ~= "none" then
            local v239;
            if typeof(l__selected_slot__52) == "table" then
                if typeof(l__selected_slot__52.grant_type) == "string" then
                    v239 = l__selected_slot__52.grant_type;
                else
                    v239 = typeof(l__selected_slot__52.def) == "table" and "skin" or nil;
                end;
            else
                v239 = nil;
            end;
            if v239 == "skin" then
                local l__def__53 = l__selected_slot__52.def;
                local l__item_id__54 = l__def__53.item_id;
                local l__skin_id__55 = l__def__53.skin_id;
                if typeof(l__item_id__54) == "string" and typeof(l__skin_id__55) == "number" then
                    if l__selected_slot__52.equipped == true then
                    else
                        l__Packets__8._x42104db25560419c:Fire(l__item_id__54, l__skin_id__55);
                        p238:_applyEquippedSkin(l__item_id__54, l__skin_id__55);
                        l__Classes__13._xbe184fb1376a575d:_x7ab8b42cc5920a78("UI_CLICK", true);
                    end;
                end;
            end;
        end;
    end;
end;
function u1._aggregateSlots(_, p240) --[[ Line: 1335 ]]
    -- upvalues: u111 (copy), u100 (copy)
    local v241 = {};
    local v242 = {};
    for _, v243 in p240 or {} do
        if typeof(v243) == "table" and typeof(v243.def) == "table" then
            local v244 = u111(v243);
            if v244 then
                local l__def__56 = v243.def;
                local v245 = v241[v244];
                if not v245 then
                    v245 = {
                        unlocked = false,
                        show_amount = false,
                        equipped = false,
                        amount = 0,
                        frame = nil,
                        def = l__def__56
                    };
                    v241[v244] = v245;
                    table.insert(v242, v245);
                end;
                local v246;
                if typeof(v243.amount) == "number" then
                    local v247 = math.floor(v243.amount);
                    v246 = math.max(1, v247);
                else
                    v246 = 1;
                end;
                v245.amount = v245.amount + v246;
                v245.unlocked = v245.unlocked or v243.unlocked == true;
                v245.show_amount = v245.show_amount or v243.show_amount == true;
                v245.equipped = v245.equipped or v243.equipped == true;
            end;
        end;
    end;
    table.sort(v242, function(p248, p249) --[[ Line: 1373 ]]
        -- upvalues: u100 (ref)
        local v250 = u100(p248.def);
        if v250 then
            v250 = v250.priority;
        end;
        local v251 = typeof(v250) ~= "number" and 0 or v250;
        local v252 = u100(p249.def);
        if v252 then
            v252 = v252.priority;
        end;
        local v253 = typeof(v252) ~= "number" and 0 or v252;
        if v251 == v253 then
            local v254 = tostring(p248.def.item_id or "");
            local v255 = tostring(p249.def.item_id or "");
            if v254 == v255 then
                return tostring(p248.def.skin_id or "") < tostring(p249.def.skin_id or "");
            else
                return v254 < v255;
            end;
        else
            return v251 < v253;
        end;
    end);
    return v242;
end;
function u1._prepareSlots(p256, p257) --[[ Line: 1392 ]]
    -- upvalues: u105 (copy)
    if p256.aggregate_slots ~= false then
        return p256:_aggregateSlots(p257);
    end;
    local v258 = {};
    for v259, v260 in p257 or {} do
        if typeof(v260) == "table" then
            local v261;
            if typeof(v260.amount) == "number" then
                local v262 = math.floor(v260.amount);
                v261 = math.max(1, v262);
            else
                v261 = 1;
            end;
            v260.amount = v261;
            v260.frame = nil;
            v260.source_order = v259;
            if typeof(v260.amount_text) == "string" then
                v260.show_amount = true;
            end;
            table.insert(v258, v260);
        end;
    end;
    if p256.current_mode == "banner_preview" then
        table.sort(v258, function(p263, p264) --[[ Line: 1413 ]]
            -- upvalues: u105 (ref)
            local v265 = u105(p263);
            if v265 then
                v265 = v265.priority;
            end;
            local v266 = typeof(v265) ~= "number" and 0 or v265;
            local v267 = u105(p264);
            if v267 then
                v267 = v267.priority;
            end;
            local v268 = typeof(v267) ~= "number" and 0 or v267;
            if v266 == v268 then
                return (p263.source_order or 0) < (p264.source_order or 0);
            else
                return v266 < v268;
            end;
        end);
    end;
    return v258;
end;
function u1._renderSlotViewport(_, p269, p270, p271) --[[ Line: 1427 ]]
    -- upvalues: u94 (copy), u97 (copy), l__ViewportModel__11 (copy), u83 (copy)
    local v272 = p269:FindFirstChild("ViewportFrame", true);
    if v272 and v272:IsA("ViewportFrame") then
        for _, v273 in v272:GetChildren() do
            if v273:IsA("Camera") or (v273:IsA("Model") or v273:IsA("WorldModel")) then
                v273:Destroy();
            end;
        end;
        if p270.hide_viewport ~= true and p270.is_dummy ~= true then
            local v274 = false;
            local v275;
            if typeof(p270) == "table" then
                if typeof(p270.grant_type) == "string" then
                    v275 = p270.grant_type;
                else
                    v275 = typeof(p270.def) == "table" and "skin" or nil;
                end;
            else
                v275 = nil;
            end;
            if v275 == "skin" then
                if typeof(p270) == "table" then
                    v274 = typeof(p270.def) == "table";
                else
                    v274 = false;
                end;
            end;
            if v274 then
                local v276 = u94(p270.def);
                if v276 then
                    v272.Visible = p270.hide_viewport_until_landed ~= true;
                    local u277 = Instance.new("Camera");
                    u277.Parent = v272;
                    v272.CurrentCamera = u277;
                    p271:Add(u277);
                    local v278 = v276:Clone();
                    u97(v278);
                    v278.Parent = v272;
                    p271:Add(v278);
                    local u279 = l__ViewportModel__11.new(v272, u277);
                    u279:SetModel(v278);
                    local function v280() --[[ Line: 1465 ]]
                        -- upvalues: u279 (copy), u277 (copy), u83 (ref)
                        u279:Calibrate();
                        u277.CFrame = u83(u279, CFrame.new(), 0.75);
                    end;
                    u279:Calibrate();
                    u277.CFrame = u83(u279, CFrame.new(), 0.75);
                    p271:Connect(v272:GetPropertyChangedSignal("AbsoluteSize"), v280);
                    p271:Connect(v272:GetPropertyChangedSignal("AbsolutePosition"), v280);
                    return;
                else
                    v272.Visible = false;
                    return;
                end;
            end;
        end;
        v272.Visible = false;
    end;
end;
function u1._updateSlotVisual(p281, p282, p283) --[[ Line: 1475 ]]
    -- upvalues: l__TweenService__1 (copy)
    local l__frame__57 = p282.frame;
    if l__frame__57 then
        local v284 = l__frame__57:FindFirstChild("Selected");
        if v284 and v284:IsA("GuiObject") then
            local v285 = p282 == p281.selected_slot;
            local v286 = p282.equipped == true;
            v284.Visible = v285 or v286;
            local v287 = v284:FindFirstChildWhichIsA("UIStroke", true);
            if v287 then
                local v288;
                if v286 then
                    v288 = {
                        Thickness = 0.01,
                        Color = Color3.fromRGB(255, 214, 0)
                    };
                else
                    v288 = {
                        Thickness = 0.01,
                        Color = Color3.fromRGB(255, 255, 255)
                    };
                end;
                if p283 then
                    l__TweenService__1:Create(v287, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), v288):Play();
                else
                    v287.Thickness = v288.Thickness;
                    v287.Color = v288.Color;
                end;
            end;
        end;
    end;
end;
function u1._populateSlot(p289, p290, p291, p292) --[[ Line: 1511 ]]
    -- upvalues: u105 (copy), u102 (copy)
    local v293 = u105(p291);
    local v294 = p290:FindFirstChild("AmountLabel", true);
    local v295;
    if typeof(p291.amount_text) == "string" then
        v295 = p291.amount_text;
    else
        v295 = tostring(p291.amount) .. "x";
    end;
    if v294 and v294:IsA("TextLabel") then
        v294.Text = v295;
    elseif v294 and v294:IsA("TextButton") then
        v294.Text = v295;
    end;
    local v296 = p291.show_amount == true;
    if v294 and v294:IsA("GuiObject") then
        v294.Visible = v296;
    end;
    local v297 = p290:FindFirstChild("Lock", true);
    local v298 = p291.unlocked ~= true;
    if v297 and v297:IsA("GuiObject") then
        v297.Visible = v298;
    end;
    local v299 = p290:FindFirstChild("CenterLock", true);
    local v300 = p291.centerlock_visible == true;
    if v299 and v299:IsA("GuiObject") then
        v299.Visible = v300;
    end;
    local v301 = p290:FindFirstChild("Rarities", true);
    if v301 then
        local v302 = v301:FindFirstChild("NameLabel", true);
        local v303;
        if p289.current_mode == "banner_reveal" and (p291 and p291.revealed ~= true) then
            v303 = "???";
        elseif typeof(p291) == "table" then
            if typeof(p291.name) == "string" and p291.name ~= "" then
                v303 = p291.name;
            else
                local l__def__58 = p291.def;
                v303 = typeof(l__def__58) ~= "table" and "" or tostring(l__def__58.name or l__def__58.item_id or "");
            end;
        else
            v303 = "";
        end;
        if v302 and v302:IsA("TextLabel") then
            v302.Text = v303;
        elseif v302 and v302:IsA("TextButton") then
            v302.Text = v303;
        end;
        local v304 = v301:FindFirstChild("ColorGradient", true);
        if v304 and v304:IsA("UIGradient") then
            v304.Color = u102(v293);
        end;
    end;
    if p291.is_dummy == true then
        local v305 = p290:FindFirstChild("ViewportFrame", true);
        if v305 then
            v305:Destroy();
        end;
    else
        p289:_renderSlotViewport(p290, p291, p292);
    end;
    p289:_updateSlotVisual(p291, false);
end;
function u1._renderSlots(u306, p307, p308) --[[ Line: 1547 ]]
    -- upvalues: u35 (copy), u111 (copy)
    local u309 = u306:_getUi();
    if u306.slot_scroll_tween then
        u306.slot_scroll_tween:Cancel();
        u306.slot_scroll_tween = nil;
    end;
    u35(u309.scrolling_frame);
    u309.scrolling_frame.CanvasPosition = Vector2.new(0, u309.scrolling_frame.CanvasPosition.Y);
    u306.slot_entries = u306:_prepareSlots(p307);
    u306.selected_slot = nil;
    local v310;
    if u306.current_mode == "banner_reveal" then
        v310 = nil;
    else
        v310 = u306.slot_entries[1];
    end;
    local u311 = u309.scrolling_frame:FindFirstChildWhichIsA("UIListLayout") or u309.scrolling_frame:FindFirstChildWhichIsA("UIGridLayout");
    if u311 then
        u311.SortOrder = Enum.SortOrder.LayoutOrder;
    end;
    for v312, u313 in u306.slot_entries do
        local v314 = u306.content_trove:Extend();
        local v315 = u306.page_origin.ShowcaseSlot:Clone();
        u313.frame = v315;
        v315.LayoutOrder = v312;
        v315.Parent = u309.scrolling_frame;
        v314:Add(v315);
        u306:_populateSlot(v315, u313, v314);
        local v316 = v315:FindFirstChild("Button");
        if not v316 then
            v316 = v315:FindFirstChild("Button", true);
            assert(v316, "ShowcasePage UI is missing child: Button");
        end;
        v314:Connect(v316.Activated, function() --[[ Line: 1576 ]]
            -- upvalues: u306 (copy), u313 (copy)
            if u306.selection_locked or u313.selectable == false then
            else
                u306:selectSlot(u313, true);
            end;
        end);
        local v317 = not u306.selection_locked;
        if v317 then
            v317 = u313.selectable ~= false;
        end;
        if v316 then
            v316.Active = v317;
            v316.AutoButtonColor = v317;
            v316.Selectable = v317;
            v316.Interactable = v317;
        end;
        if p308 and u111(u313) == p308 then
            v310 = u313;
        end;
    end;
    if u311 then
        u309.scrolling_frame.CanvasSize = UDim2.fromOffset(u311.AbsoluteContentSize.X, u311.AbsoluteContentSize.Y);
        u306.content_trove:Connect(u311:GetPropertyChangedSignal("AbsoluteContentSize"), function() --[[ Name: updateCanvas, Line 1591 ]]
            -- upvalues: u309 (copy), u311 (copy)
            u309.scrolling_frame.CanvasSize = UDim2.fromOffset(u311.AbsoluteContentSize.X, u311.AbsoluteContentSize.Y);
        end);
    end;
    u306:selectSlot(v310, false, true);
end;
function u1.refreshSlots(p318, p319) --[[ Line: 1602 ]]
    -- upvalues: u111 (copy)
    local v320 = u111(p318.selected_slot);
    p318.content_trove:Clean();
    p318:_renderSlots(p319, v320);
end;
function u1._setSlotButtonsEnabled(p321, p322) --[[ Line: 1608 ]]
    for _, v323 in p321.slot_entries do
        local l__frame__59 = v323.frame;
        if l__frame__59 then
            local v324 = l__frame__59:FindFirstChild("Button", true);
            if v324 and v324:IsA("GuiButton") then
                local v325;
                if p322 then
                    v325 = v323.selectable ~= false;
                else
                    v325 = p322;
                end;
                if v324 then
                    v324.Active = v325;
                    v324.AutoButtonColor = v325;
                    v324.Selectable = v325;
                    v324.Interactable = v325;
                end;
            end;
        end;
    end;
end;
function u1._setInteractionLocked(p326, p327) --[[ Line: 1622 ]]
    p326.selection_locked = p327;
    local v328 = p326:_getUi();
    if v328.scrolling_frame:IsA("ScrollingFrame") then
        v328.scrolling_frame.ScrollingEnabled = not p327;
    end;
    local l__return_button__60 = v328.return_button;
    local v329 = not p327;
    if l__return_button__60 then
        l__return_button__60.Active = v329;
        l__return_button__60.AutoButtonColor = v329;
        l__return_button__60.Selectable = v329;
        l__return_button__60.Interactable = v329;
    end;
    p326:_setSlotButtonsEnabled(not p327);
end;
function u1._getCenteredCanvasPosition(p330, p331) --[[ Line: 1634 ]]
    if not (p331 and p331.frame) then
        return nil;
    end;
    local l__scrolling_frame__61 = p330:_getUi().scrolling_frame;
    local l__frame__62 = p331.frame;
    if not (l__frame__62.Parent and l__scrolling_frame__61.Parent) then
        return nil;
    end;
    local l__CanvasPosition__63 = l__scrolling_frame__61.CanvasPosition;
    local v332 = l__CanvasPosition__63.X + (l__frame__62.AbsolutePosition.X + l__frame__62.AbsoluteSize.X / 2) - (l__scrolling_frame__61.AbsolutePosition.X + l__scrolling_frame__61.AbsoluteSize.X / 2);
    local v333 = math.max(0, l__scrolling_frame__61.AbsoluteCanvasSize.X - l__scrolling_frame__61.AbsoluteSize.X);
    local v334 = math.clamp(v332, 0, v333);
    return Vector2.new(v334, l__CanvasPosition__63.Y);
end;
function u1._getRandomLandingCanvasPosition(p335, p336) --[[ Line: 1657 ]]
    if not (p336 and p336.frame) then
        return nil;
    end;
    local v337 = p335:_getCenteredCanvasPosition(p336);
    if not v337 then
        return nil;
    end;
    local l__scrolling_frame__64 = p335:_getUi().scrolling_frame;
    local l__X__65 = p336.frame.AbsoluteSize.X;
    local v338 = math.max(0, l__X__65 / 2 - l__X__65 * 0.4);
    if v338 <= 0 then
        return v337;
    end;
    local v339 = Random.new():NextNumber(0, v338);
    local v340 = math.max(0, l__scrolling_frame__64.AbsoluteCanvasSize.X - l__scrolling_frame__64.AbsoluteSize.X);
    local v341 = math.clamp(v337.X + v339, 0, v340);
    return Vector2.new(v341, v337.Y);
end;
function u1._getSlotCenterCanvasX(p342, p343) --[[ Line: 1684 ]]
    if p343 and p343.frame then
        local l__scrolling_frame__66 = p342:_getUi().scrolling_frame;
        local l__frame__67 = p343.frame;
        if l__frame__67.Parent and l__scrolling_frame__66.Parent then
            return l__scrolling_frame__66.CanvasPosition.X + (l__frame__67.AbsolutePosition.X - l__scrolling_frame__66.AbsolutePosition.X) + l__frame__67.AbsoluteSize.X / 2;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function u1._onRevealSlotTick(_, _, _) --[[ Line: 1701 ]]
    -- upvalues: l__Classes__13 (copy)
    l__Classes__13._xbe184fb1376a575d:_x7ab8b42cc5920a78("SLOT_TICK", true);
end;
function u1._cleanupRevealDummies(p344, p345) --[[ Line: 1705 ]]
    if p345 then
        p345 = p345.winning_slot;
    end;
    if p345 then
        local v346 = {};
        for _, v347 in p344.slot_entries do
            if v347 == p345 then
                table.insert(v346, v347);
            elseif v347.frame and v347.frame.Parent then
                v347.frame:Destroy();
            end;
        end;
        p344.slot_entries = v346;
    end;
end;
function u1._resolveRevealTimings(p348, p349) --[[ Line: 1723 ]]
    local v350 = 2.8 + (p348.current_reveal_scroll_bonus_duration or 0);
    if p349 == true then
        v350 = v350 + Random.new():NextNumber(0, 0.5);
    end;
    p348.current_reveal_scroll_duration = v350;
    p348.current_reveal_settle_duration = 0.2;
    p348.current_reveal_total_duration = v350 + (p348.current_reveal_hold_duration or 0) + 0.2;
end;
function u1._settleRevealToCenter(u351, u352) --[[ Line: 1736 ]]
    -- upvalues: l__TweenService__1 (copy)
    local u353;
    if u352 then
        u353 = u352.winning_slot;
    else
        u353 = u352;
    end;
    if u353 then
        local function u357() --[[ Line: 1742 ]]
            -- upvalues: u351 (copy), u352 (copy), u353 (copy), l__TweenService__1 (ref)
            if u351.reveal_state == u352 then
                local v354 = u351:_getUi();
                local v355 = u351:_getCenteredCanvasPosition(u353);
                if v355 then
                    if u351.slot_scroll_tween then
                        u351.slot_scroll_tween:Cancel();
                        u351.slot_scroll_tween = nil;
                    end;
                    u351.slot_scroll_tween = l__TweenService__1:Create(v354.scrolling_frame, TweenInfo.new(u351.current_reveal_settle_duration, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        CanvasPosition = v355
                    });
                    u351.reveal_trove:Connect(u351.slot_scroll_tween.Completed, function(p356) --[[ Line: 1764 ]]
                        -- upvalues: u351 (ref), u352 (ref)
                        if p356 == Enum.PlaybackState.Completed and u351.reveal_state == u352 then
                            u351.reveal_trove:Clean();
                            u351:_cleanupRevealDummies(u352);
                            u351:_finalizeRevealLanding(u352);
                        end;
                    end);
                    u351.slot_scroll_tween:Play();
                else
                    u351.reveal_trove:Clean();
                    u351:_cleanupRevealDummies(u352);
                    u351:_finalizeRevealLanding(u352);
                end;
            end;
        end;
        local v358 = u351.current_reveal_hold_duration or 0;
        if v358 > 0 then
            task.delay(v358, function() --[[ Line: 1778 ]]
                -- upvalues: u357 (copy)
                u357();
            end);
        else
            u357();
        end;
    end;
end;
function u1._finalizeRevealLanding(p359, p360) --[[ Line: 1787 ]]
    if p360 then
        p360 = p360.winning_slot;
    end;
    if p360 then
        local v361 = p359:_getUi();
        p360.centerlock_visible = false;
        p360.hide_viewport_until_landed = false;
        local v362;
        if typeof(p360) == "table" then
            if typeof(p360.grant_type) == "string" then
                v362 = p360.grant_type;
            else
                v362 = typeof(p360.def) == "table" and "skin" or nil;
            end;
        else
            v362 = nil;
        end;
        p360.hide_viewport = v362 ~= "skin";
        p360.selectable = true;
        p360.revealed = true;
        local l__frame__68 = p360.frame;
        if l__frame__68 then
            local v363 = l__frame__68:FindFirstChild("CenterLock", true);
            if v363 and v363:IsA("GuiObject") then
                v363.Visible = false;
            end;
            local v364 = l__frame__68:FindFirstChild("ViewportFrame", true);
            if v364 and v364:IsA("ViewportFrame") then
                local v365;
                if typeof(p360) == "table" then
                    if typeof(p360.grant_type) == "string" then
                        v365 = p360.grant_type;
                    else
                        v365 = typeof(p360.def) == "table" and "skin" or nil;
                    end;
                else
                    v365 = nil;
                end;
                v364.Visible = v365 == "skin";
            end;
            local v366 = l__frame__68:FindFirstChild("Rarities", true);
            if v366 then
                local v367 = v366:FindFirstChild("NameLabel", true);
                local v368;
                if typeof(p360) == "table" then
                    if typeof(p360.name) == "string" and p360.name ~= "" then
                        v368 = p360.name;
                    else
                        local l__def__69 = p360.def;
                        v368 = typeof(l__def__69) ~= "table" and "" or tostring(l__def__69.name or l__def__69.item_id or "");
                    end;
                else
                    v368 = "";
                end;
                if v367 and v367:IsA("TextLabel") then
                    v367.Text = v368;
                elseif v367 and v367:IsA("TextButton") then
                    v367.Text = v368;
                end;
            end;
        end;
        p359:_setInteractionLocked(false);
        p359:selectSlot(p360, false, true);
        v361.details_container.Visible = true;
        v361.return_button.Visible = true;
        p359.parent_os.CurrencyLayer.Visible = true;
        p359:_updateActions();
        p359:_centerSelectedSlot(p360, true);
    end;
end;
function u1._beginRevealSpin(u369) --[[ Line: 1825 ]]
    -- upvalues: l__RunService__5 (copy), l__TweenService__1 (copy)
    local u370 = u369:_getUi();
    local u371 = nil;
    for _, v372 in u369.slot_entries do
        if v372.is_dummy ~= true then
            u371 = v372;
            break;
        end;
    end;
    if u371 then
        u369.reveal_trove:Clean();
        u369.reveal_state = {
            next_tick_index = 1,
            last_center_x = 0,
            winning_slot = u371,
            tick_slots = {}
        };
        u370.details_container.Visible = false;
        u370.actions_container.Visible = false;
        u369:_setRevealInfoVisible(false);
        u370.return_button.Visible = false;
        u369.parent_os.CurrencyLayer.Visible = false;
        u369:_setInteractionLocked(true);
        task.defer(function() --[[ Line: 1854 ]]
            -- upvalues: l__RunService__5 (ref), u369 (copy), u371 (ref), u370 (copy), l__TweenService__1 (ref)
            l__RunService__5.Heartbeat:Wait();
            local l__reveal_state__70 = u369.reveal_state;
            if u369.reveal_state == l__reveal_state__70 and u371.frame then
                for _, v373 in ipairs(u369.slot_entries) do
                    local v374 = u369:_getSlotCenterCanvasX(v373);
                    if v374 then
                        table.insert(l__reveal_state__70.tick_slots, {
                            slot = v373,
                            center_x = v374
                        });
                    end;
                end;
                local v375 = u370.scrolling_frame.CanvasPosition.X + u370.scrolling_frame.AbsoluteSize.X / 2;
                l__reveal_state__70.last_center_x = v375;
                while l__reveal_state__70.next_tick_index <= #l__reveal_state__70.tick_slots and l__reveal_state__70.tick_slots[l__reveal_state__70.next_tick_index].center_x <= v375 do
                    l__reveal_state__70.next_tick_index = l__reveal_state__70.next_tick_index + 1;
                end;
                local v376 = "ShowcasePageReveal" .. tostring(u369.open_id);
                u369.reveal_trove:BindToRenderStep(v376, Enum.RenderPriority.Last.Value + 1, function() --[[ Line: 1879 ]]
                    -- upvalues: u369 (ref), l__reveal_state__70 (copy), u370 (ref)
                    local l__reveal_state__71 = u369.reveal_state;
                    if l__reveal_state__71 ~= l__reveal_state__70 then
                        return;
                    end;
                    local v377 = u370.scrolling_frame.CanvasPosition.X + u370.scrolling_frame.AbsoluteSize.X / 2;
                    while l__reveal_state__71.next_tick_index <= #l__reveal_state__71.tick_slots do
                        local v378 = l__reveal_state__71.tick_slots[l__reveal_state__71.next_tick_index];
                        if v377 < v378.center_x then
                            break;
                        end;
                        if v378.center_x > l__reveal_state__71.last_center_x then
                            u369:_onRevealSlotTick(v378.slot, l__reveal_state__71.next_tick_index);
                        end;
                        l__reveal_state__71.next_tick_index = l__reveal_state__71.next_tick_index + 1;
                    end;
                    l__reveal_state__71.last_center_x = v377;
                end);
                local v379 = u369:_getRandomLandingCanvasPosition(u371);
                if v379 then
                    if u369.slot_scroll_tween then
                        u369.slot_scroll_tween:Cancel();
                        u369.slot_scroll_tween = nil;
                    end;
                    u369.slot_scroll_tween = l__TweenService__1:Create(u370.scrolling_frame, TweenInfo.new(u369.current_reveal_scroll_duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        CanvasPosition = v379
                    });
                    u369.reveal_trove:Connect(u369.slot_scroll_tween.Completed, function(p380) --[[ Line: 1914 ]]
                        -- upvalues: u369 (ref), l__reveal_state__70 (copy)
                        if p380 == Enum.PlaybackState.Completed and u369.reveal_state == l__reveal_state__70 then
                            u369:_settleRevealToCenter(l__reveal_state__70);
                        end;
                    end);
                    u369.slot_scroll_tween:Play();
                end;
            end;
        end);
    end;
end;
function u1._centerSelectedSlot(p381, p382, p383) --[[ Line: 1925 ]]
    -- upvalues: l__TweenService__1 (copy)
    local v384 = p381:_getCenteredCanvasPosition(p382);
    if v384 then
        if p381.slot_scroll_tween then
            p381.slot_scroll_tween:Cancel();
            p381.slot_scroll_tween = nil;
        end;
        local l__scrolling_frame__72 = p381:_getUi().scrolling_frame;
        if p383 then
            l__scrolling_frame__72.CanvasPosition = v384;
        else
            p381.slot_scroll_tween = l__TweenService__1:Create(l__scrolling_frame__72, TweenInfo.new(0.28, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                CanvasPosition = v384
            });
            p381.slot_scroll_tween:Play();
        end;
    end;
end;
function u1._clearDetails(p385) --[[ Line: 1949 ]]
    local v386 = p385:_getUi();
    local l__item_label__73 = v386.item_label;
    if l__item_label__73 and l__item_label__73:IsA("TextLabel") then
        l__item_label__73.Text = "";
    elseif l__item_label__73 and l__item_label__73:IsA("TextButton") then
        l__item_label__73.Text = "";
    end;
    local l__skin_label__74 = v386.skin_label;
    if l__skin_label__74 and l__skin_label__74:IsA("TextLabel") then
        l__skin_label__74.Text = "";
    elseif l__skin_label__74 and l__skin_label__74:IsA("TextButton") then
        l__skin_label__74.Text = "";
    end;
    local l__credit_label__75 = v386.credit_label;
    if l__credit_label__75 and l__credit_label__75:IsA("TextLabel") then
        l__credit_label__75.Text = "";
    elseif l__credit_label__75 and l__credit_label__75:IsA("TextButton") then
        l__credit_label__75.Text = "";
    end;
    local l__rarity_label__76 = v386.rarity_label;
    if l__rarity_label__76 and l__rarity_label__76:IsA("TextLabel") then
        l__rarity_label__76.Text = "";
    else
        if l__rarity_label__76 and l__rarity_label__76:IsA("TextButton") then
            l__rarity_label__76.Text = "";
        end;
    end;
end;
function u1._setDetails(p387, p388) --[[ Line: 1957 ]]
    -- upvalues: l__ItemDef__7 (copy), u105 (copy)
    if p388 then
        local l__def__77 = p388.def;
        local v389;
        if typeof(l__def__77) == "table" then
            v389 = l__ItemDef__7.getDefs()[l__def__77.item_id] or nil;
        else
            v389 = nil;
        end;
        local v390 = u105(p388);
        local v391 = p387:_getUi();
        local l__item_label__78 = v391.item_label;
        local v392 = tostring(p388.detail_item_text or v389 and v389.name or (l__def__77 and (l__def__77.item_id or "") or ""));
        if l__item_label__78 and l__item_label__78:IsA("TextLabel") then
            l__item_label__78.Text = v392;
        elseif l__item_label__78 and l__item_label__78:IsA("TextButton") then
            l__item_label__78.Text = v392;
        end;
        local l__skin_label__79 = v391.skin_label;
        local l__detail_name_text__80 = p388.detail_name_text;
        if not l__detail_name_text__80 then
            if typeof(p388) == "table" then
                if typeof(p388.name) == "string" and p388.name ~= "" then
                    l__detail_name_text__80 = p388.name;
                else
                    local l__def__81 = p388.def;
                    l__detail_name_text__80 = typeof(l__def__81) ~= "table" and "" or tostring(l__def__81.name or l__def__81.item_id or "");
                end;
            else
                l__detail_name_text__80 = "";
            end;
        end;
        local v393 = tostring(l__detail_name_text__80);
        if l__skin_label__79 and l__skin_label__79:IsA("TextLabel") then
            l__skin_label__79.Text = v393;
        elseif l__skin_label__79 and l__skin_label__79:IsA("TextButton") then
            l__skin_label__79.Text = v393;
        end;
        local l__credit_label__82 = v391.credit_label;
        local v394 = p388.detail_credit_text or "CREATED BY " .. tostring(l__def__77 and l__def__77.creator or "");
        local v395 = tostring(v394);
        if l__credit_label__82 and l__credit_label__82:IsA("TextLabel") then
            l__credit_label__82.Text = v395;
        elseif l__credit_label__82 and l__credit_label__82:IsA("TextButton") then
            l__credit_label__82.Text = v395;
        end;
        local l__rarity_label__83 = v391.rarity_label;
        local v396 = tostring(p388.detail_rarity_text or (v390.name or ""));
        if l__rarity_label__83 and l__rarity_label__83:IsA("TextLabel") then
            l__rarity_label__83.Text = v396;
        else
            if l__rarity_label__83 and l__rarity_label__83:IsA("TextButton") then
                l__rarity_label__83.Text = v396;
            end;
        end;
    else
        p387:_clearDetails();
    end;
end;
function u1._getShowcaseParts(_) --[[ Line: 1974 ]]
    -- upvalues: u32 (copy)
    local v397 = u32("ShowcaseOrigin");
    local v398 = u32("ViewOrigin");
    if v397 then
        if v398 then
            return v397, v398;
        else
            return v397, nil;
        end;
    else
        return nil, nil;
    end;
end;
function u1._updateSceneModelPivot(p399) --[[ Line: 1989 ]]
    if p399.scene_model and p399.model_base_cframe then
        if p399:_getShowcaseParts() then
            local v400 = p399.model_bounds_center_position or p399.model_base_cframe.Position;
            local v401 = CFrame.Angles(p399.sway_z_current, p399.sway_current, 0);
            p399.scene_model:PivotTo(CFrame.new(v400) * v401 * CFrame.new(-v400) * p399.model_base_cframe);
        else
            p399.scene_model:PivotTo(p399.model_base_cframe);
        end;
    end;
end;
function u1._showSceneModel(p402, p403) --[[ Line: 2010 ]]
    -- upvalues: u32 (copy), u94 (copy), u97 (copy), u59 (copy), u50 (copy)
    if p402.model_trove then
        p402.model_trove:Clean();
    end;
    p402.scene_model = nil;
    p402.model_base_cframe = nil;
    p402.model_bounds_center_position = nil;
    p402.sway_goal = 0;
    p402.sway_current = 0;
    p402.sway_z_goal = 0;
    p402.sway_z_current = 0;
    if p403 then
        local v404 = false;
        local v405;
        if typeof(p403) == "table" then
            if typeof(p403.grant_type) == "string" then
                v405 = p403.grant_type;
            else
                v405 = typeof(p403.def) == "table" and "skin" or nil;
            end;
        else
            v405 = nil;
        end;
        if v405 == "skin" then
            if typeof(p403) == "table" then
                v404 = typeof(p403.def) == "table";
            else
                v404 = false;
            end;
        end;
        if v404 then
            local v406 = u32("ShowcaseOrigin");
            if v406 then
                local v407 = u94(p403.def);
                if v407 then
                    local v408 = workspace:FindFirstChild("Showcase") or workspace;
                    local v409 = v407:Clone();
                    u97(v409);
                    v409.Parent = v408;
                    local v410 = v407:GetPivot();
                    local v411 = v410 - v410.Position;
                    local v412 = CFrame.new(v406.Position) * v411;
                    v409:PivotTo(v412);
                    local v413, v414 = u59((u50(v409)));
                    if v413 and v414 then
                        v412 = CFrame.new(v412.Position + (v406.Position - (v413 + v414) / 2)) * v411;
                        v409:PivotTo(v412);
                        local v415, v416 = u59((u50(v409)));
                        if v415 and v416 then
                            p402.model_bounds_center_position = (v415 + v416) / 2;
                        else
                            p402.model_bounds_center_position = v406.Position;
                        end;
                    else
                        p402.model_bounds_center_position = v406.Position;
                    end;
                    p402.model_base_cframe = v412;
                    p402.scene_model = v409;
                    p402.model_trove:Add(v409);
                else
                    warn("[ShowcasePage] No showcase model for skin:", p403.def.item_id, p403.def.skin_id);
                end;
            else
                warn("[ShowcasePage] Missing Workspace/Showcase/ShowcaseOrigin");
            end;
        end;
    end;
end;
function u1._getFitCameraCFrame(p417) --[[ Line: 2075 ]]
    local v418, v419 = p417:_getShowcaseParts();
    if not (v418 and v419) then
        return nil;
    end;
    local l__Position__84 = v418.Position;
    if p417.model_bounds_center_position then
        l__Position__84 = Vector3.new(p417.model_bounds_center_position.X, l__Position__84.Y, l__Position__84.Z);
    end;
    local v420 = l__Position__84 - Vector3.new(0, 0, 4.85);
    return CFrame.lookAt(v420, v420 + Vector3.new(0, 0, 1), Vector3.new(0, 1, 0)), CFrame.new(l__Position__84);
end;
function u1._getDragPosition(p421) --[[ Line: 2092 ]]
    -- upvalues: l__UserInputService__2 (copy)
    if not p421.dragging then
        return nil;
    end;
    if not p421.drag_input or p421.drag_input.UserInputType ~= Enum.UserInputType.Touch then
        return l__UserInputService__2:GetMouseLocation();
    end;
    local l__Position__85 = p421.drag_input.Position;
    return Vector2.new(l__Position__85.X, l__Position__85.Y);
end;
function u1._updateDragSway(p422) --[[ Line: 2105 ]]
    if p422.dragging then
        local v423 = p422:_getDragPosition();
        if v423 then
            if p422.drag_last_position then
                local v424 = v423 - p422.drag_last_position;
                p422.drag_last_position = v423;
                p422.sway_goal = math.clamp(p422.sway_goal + v424.X * 0.0013962634015954637, -1.5707963267948966, 1.5707963267948966);
                p422.sway_z_goal = math.clamp(p422.sway_z_goal - v424.Y * 0.0013962634015954637, -3.141592653589793, 3.141592653589793);
            else
                p422.drag_last_position = v423;
            end;
        end;
    else
        p422.drag_last_position = nil;
        p422.sway_goal = 0;
        p422.sway_z_goal = 0;
    end;
end;
function u1._pulseScrollBlur(p425) --[[ Line: 2138 ]]
    -- upvalues: l__Lighting__4 (copy), l__TweenService__1 (copy)
    if p425.scroll_blur_tween then
        p425.scroll_blur_tween:Cancel();
        p425.scroll_blur_tween = nil;
    end;
    if not (p425.scroll_blur and p425.scroll_blur.Parent) then
        local v426 = Instance.new("BlurEffect");
        v426.Name = "ShowcaseScrollBlur";
        v426.Size = 0;
        v426.Parent = l__Lighting__4;
        p425.scroll_blur = v426;
        p425.scene_trove:Add(v426);
    end;
    p425.scroll_blur.Size = 12;
    p425.scroll_blur_tween = l__TweenService__1:Create(p425.scroll_blur, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = 0
    });
    p425.scroll_blur_tween:Play();
end;
function u1._resetRevealCameraShake(p427) --[[ Line: 2160 ]]
    p427.reveal_camera_shake_elapsed = 0.6;
    p427.reveal_camera_shake_seed = 0;
end;
function u1._triggerRevealCameraShake(p428) --[[ Line: 2165 ]]
    p428.reveal_camera_shake_elapsed = 0;
    p428.reveal_camera_shake_seed = Random.new():NextNumber(-1000, 1000);
end;
function u1._applyRevealCameraShake(p429, p430, p431) --[[ Line: 2170 ]]
    if p429.reveal_camera_shake_elapsed >= 0.6 then
        return p430;
    end;
    p429.reveal_camera_shake_elapsed = math.min(p429.reveal_camera_shake_elapsed + p431, 0.6);
    local v432 = p429.reveal_camera_shake_elapsed / 0.6;
    local v433 = (1 - v432) * (1 - v432);
    local v434 = p429.reveal_camera_shake_seed + p429.reveal_camera_shake_elapsed * 10;
    local v435 = math.noise(v434, 0, 0) * 0.08 * v433;
    local v436 = math.noise(0, v434, 0) * 0.08 * 0.6 * v433;
    local v437 = math.noise(0, 0, v434) * 0.05 * v433;
    local v438 = math.noise(v434, 1, 0) * 0.06981317007977318 * v433;
    local v439 = math.noise(1, v434, 0) * 0.06981317007977318 * v433;
    local v440 = math.noise(0, 1, v434) * 0.06981317007977318 * 0.6 * v433;
    return p430 * CFrame.new(v435, v436, v437) * CFrame.Angles(v438, v439, v440);
end;
function u1._applyCameraMotionSway(p441, p442, p443) --[[ Line: 2191 ]]
    local l__Position__86 = p442.Position;
    if p441.camera_last_position then
        local v444 = -(l__Position__86 - p441.camera_last_position):Dot(Vector3.new(1, 0, 0)) * 90;
        p441.camera_roll_goal = math.clamp(v444, -3, 3);
    end;
    p441.camera_last_position = l__Position__86;
    local v445 = 1 - math.exp(p443 * -12);
    local v446 = 1 - math.exp(p443 * -5);
    p441.camera_roll_current = p441.camera_roll_current + (p441.camera_roll_goal - p441.camera_roll_current) * v445;
    p441.camera_roll_goal = p441.camera_roll_goal + (0 - p441.camera_roll_goal) * v446;
    return p442 * CFrame.Angles(0, 0, (math.rad(p441.camera_roll_current)));
end;
function u1._applyMouseCameraAngle(p447, p448, p449) --[[ Line: 2208 ]]
    -- upvalues: l__UserInputService__2 (copy)
    local l__CurrentCamera__87 = workspace.CurrentCamera;
    if not l__CurrentCamera__87 then
        return p448;
    end;
    local l__ViewportSize__88 = l__CurrentCamera__87.ViewportSize;
    if l__ViewportSize__88.X <= 0 or l__ViewportSize__88.Y <= 0 then
        return p448;
    end;
    local v450 = l__UserInputService__2:GetMouseLocation();
    local v451 = math.clamp((v450.X / l__ViewportSize__88.X - 0.5) * 2, -1, 1);
    local v452 = math.clamp((v450.Y / l__ViewportSize__88.Y - 0.5) * 2, -1, 1);
    local v453 = 70 / math.max(p447.camera_current_fov or (p447.camera_fov_goal or l__CurrentCamera__87.FieldOfView), 1);
    local v454 = math.clamp(v453, 0.75, 2) * 200;
    local v455 = -v451 * 0.00034906585039886593 * v454;
    local v456 = -v452 * 0.00008726646259971648 * v454;
    local v457 = 1 - math.exp(p449 * -6);
    p447.camera_mouse_yaw = p447.camera_mouse_yaw + (v455 - p447.camera_mouse_yaw) * v457;
    p447.camera_mouse_pitch = p447.camera_mouse_pitch + (v456 - p447.camera_mouse_pitch) * v457;
    return p448 * CFrame.Angles(p447.camera_mouse_pitch, p447.camera_mouse_yaw, 0);
end;
function u1._resetCameraIntro(p458) --[[ Line: 2234 ]]
    p458.camera_intro_type = nil;
    p458.camera_intro_elapsed = 0;
end;
function u1._buildCameraIntroContext(p459, p460, p461) --[[ Line: 2239 ]]
    -- upvalues: u108 (copy)
    local v462 = {};
    local v463 = nil;
    local v464;
    if typeof(p461) == "table" and (typeof(p461.extracted_rarity) == "string" and p461.extracted_rarity ~= "") then
        v464 = p461.extracted_rarity;
    else
        v464 = nil;
    end;
    if p459.current_mode == "banner_reveal" then
        v463 = u108(p460);
        if not v464 and v463 then
            if typeof(v463) == "table" then
                if typeof(v463.rarity) == "string" and v463.rarity ~= "" then
                    v464 = v463.rarity;
                else
                    local l__def__89 = v463.def;
                    if typeof(l__def__89) == "table" and typeof(l__def__89.rarity) == "string" then
                        v464 = l__def__89.rarity;
                    else
                        v464 = nil;
                    end;
                end;
            else
                v464 = nil;
            end;
        end;
    end;
    v462.winning_slot = v463;
    v462.extracted_rarity = v464;
    return v462;
end;
function u1._getExtractedRarity(p465) --[[ Line: 2260 ]]
    local l__camera_intro_context__90 = p465.camera_intro_context;
    if typeof(l__camera_intro_context__90) ~= "table" then
        return nil;
    end;
    local l__extracted_rarity__91 = l__camera_intro_context__90.extracted_rarity;
    if typeof(l__extracted_rarity__91) == "string" and l__extracted_rarity__91 ~= "" then
        return l__extracted_rarity__91;
    end;
    local l__winning_slot__92 = l__camera_intro_context__90.winning_slot;
    if typeof(l__winning_slot__92) == "table" then
        local v466;
        if typeof(l__winning_slot__92) == "table" then
            if typeof(l__winning_slot__92.rarity) == "string" and l__winning_slot__92.rarity ~= "" then
                v466 = l__winning_slot__92.rarity;
            else
                local l__def__93 = l__winning_slot__92.def;
                if typeof(l__def__93) == "table" and typeof(l__def__93.rarity) == "string" then
                    v466 = l__def__93.rarity;
                else
                    v466 = nil;
                end;
            end;
        else
            v466 = nil;
        end;
        if typeof(v466) == "string" and v466 ~= "" then
            return v466;
        end;
    end;
    return nil;
end;
function u1._beginCameraIntro(p467, p468) --[[ Line: 2282 ]]
    -- upvalues: u24 (copy)
    p467:_resetCameraIntro();
    if p468 then
        local v469 = u24[p468];
        if v469 then
            p467.camera_intro_type = p468;
            if v469.begin then
                v469.begin(p467);
            end;
        else
            warn("[ShowcasePage] Unknown camera intro type:", p468);
        end;
    end;
end;
function u1._stepCameraIntro(p470, p471, p472) --[[ Line: 2302 ]]
    -- upvalues: u24 (copy)
    local l__camera_intro_type__94 = p470.camera_intro_type;
    if not l__camera_intro_type__94 then
        return p471, false;
    end;
    local v473 = u24[l__camera_intro_type__94];
    if not v473 then
        p470:_resetCameraIntro();
        return p471, false;
    end;
    local v474, v475 = v473.update(p470, p471, p472);
    if not v475 then
        p470:_resetCameraIntro();
    end;
    return v474, v475;
end;
function u1._updateScene(p476, p477) --[[ Line: 2322 ]]
    -- upvalues: l__Classes__13 (copy)
    local l__CurrentCamera__95 = workspace.CurrentCamera;
    if l__CurrentCamera__95 then
        if l__Classes__13._x32ae459de0772e82 then
            l__Classes__13._x32ae459de0772e82._x5b34a8c32cf04968 = true;
        end;
        l__CurrentCamera__95.CameraType = Enum.CameraType.Scriptable;
        p476:_updateDragSway();
        p476.sway_current = p476.sway_current + (p476.sway_goal - p476.sway_current) * math.clamp(p477 * 8, 0, 1);
        p476.sway_z_current = p476.sway_z_current + (p476.sway_z_goal - p476.sway_z_current) * math.clamp(p477 * 8, 0, 1);
        p476:_updateSceneModelPivot();
        local v478, v479 = p476:_getFitCameraCFrame();
        if v478 then
            local v480, v481 = p476:_stepCameraIntro(v478, p477);
            local v482;
            if v481 then
                v482 = v480;
            else
                v482 = p476:_applyMouseCameraAngle(v478, p477);
            end;
            local v483 = 1 - math.exp(p477 * -9);
            if v481 then
                p476.camera_current_cframe = v480;
            elseif p476.camera_current_cframe then
                p476.camera_current_cframe = p476.camera_current_cframe:Lerp(v482, v483);
            else
                p476.camera_current_cframe = v482;
            end;
            l__CurrentCamera__95.CFrame = p476:_applyRevealCameraShake(p476:_applyCameraMotionSway(p476.camera_current_cframe, p477), p477);
            if v479 then
                l__CurrentCamera__95.Focus = v479;
            end;
            if p476.camera_fov_goal then
                if not p476.camera_current_fov then
                    p476.camera_current_fov = l__CurrentCamera__95.FieldOfView;
                end;
                p476.camera_current_fov = p476.camera_current_fov + (p476.camera_fov_goal - p476.camera_current_fov) * v483;
                l__CurrentCamera__95.FieldOfView = p476.camera_current_fov;
            end;
        end;
    end;
end;
function u1._startCameraOverride(u484) --[[ Line: 2371 ]]
    -- upvalues: l__Classes__13 (copy), l__UserInputService__2 (copy)
    local l__CurrentCamera__96 = workspace.CurrentCamera;
    if l__CurrentCamera__96 then
        local l___x199aee2e6ba696d1__97 = l__Classes__13._x199aee2e6ba696d1;
        local v485;
        if l___x199aee2e6ba696d1__97 then
            v485 = l___x199aee2e6ba696d1__97._xbf73a0b250690860 or nil;
        else
            v485 = nil;
        end;
        local v486 = false;
        if l___x199aee2e6ba696d1__97 and l___x199aee2e6ba696d1__97._x81b88048da82fb60 then
            v486 = l___x199aee2e6ba696d1__97:_x81b88048da82fb60();
        elseif l___x199aee2e6ba696d1__97 and (l___x199aee2e6ba696d1__97._x167ca2cf5f109288 == true and l__Classes__13.Util) then
            l__Classes__13.Util:unbindFromRenderStep("SpectatorCam");
            l___x199aee2e6ba696d1__97._x06ea370a96d72e56 = nil;
            l___x199aee2e6ba696d1__97._x167ca2cf5f109288 = false;
            v486 = true;
        end;
        u484.previous_camera_state = {
            camera_type = l__CurrentCamera__96.CameraType,
            camera_subject = l__CurrentCamera__96.CameraSubject,
            cframe = l__CurrentCamera__96.CFrame,
            focus = l__CurrentCamera__96.Focus,
            field_of_view = l__CurrentCamera__96.FieldOfView,
            camera_paused = l__Classes__13._x32ae459de0772e82 and l__Classes__13._x32ae459de0772e82._x5b34a8c32cf04968 or false,
            spectator_target = v485,
            spectator_was_running = v486
        };
        if l__Classes__13._x32ae459de0772e82 then
            l__Classes__13._x32ae459de0772e82._x5b34a8c32cf04968 = true;
        end;
        u484.showcase_field_of_view = 70;
        u484.camera_fov_goal = u484.showcase_field_of_view;
        l__CurrentCamera__96.CameraType = Enum.CameraType.Scriptable;
        u484.camera_current_cframe = nil;
        u484.camera_current_fov = u484.showcase_field_of_view;
        l__CurrentCamera__96.FieldOfView = u484.showcase_field_of_view;
        u484.camera_last_position = nil;
        u484.camera_roll_goal = 0;
        u484.camera_roll_current = 0;
        u484.camera_mouse_yaw = 0;
        u484.camera_mouse_pitch = 0;
        u484:_resetRevealCameraShake();
        u484.scene_trove:Add(function() --[[ Line: 2418 ]]
            -- upvalues: u484 (copy), l__Classes__13 (ref)
            local l__CurrentCamera__98 = workspace.CurrentCamera;
            local l__previous_camera_state__99 = u484.previous_camera_state;
            if l__CurrentCamera__98 and l__previous_camera_state__99 then
                u484.previous_camera_state = nil;
                u484.showcase_field_of_view = nil;
                u484.camera_fov_goal = nil;
                u484.camera_current_cframe = nil;
                u484.camera_current_fov = nil;
                u484.camera_last_position = nil;
                u484.camera_roll_goal = 0;
                u484.camera_roll_current = 0;
                u484.camera_mouse_yaw = 0;
                u484.camera_mouse_pitch = 0;
                u484.camera_intro_context = nil;
                u484:_resetRevealCameraShake();
                u484:_resetCameraIntro();
                u484.scroll_blur = nil;
                u484.scroll_blur_tween = nil;
                u484.dragging = false;
                u484.drag_input = nil;
                u484.drag_last_position = nil;
                u484.sway_goal = 0;
                u484.sway_z_goal = 0;
                if l__previous_camera_state__99.spectator_was_running and l__Classes__13._x199aee2e6ba696d1 then
                    if l__Classes__13._x199aee2e6ba696d1._x9b4936706cf319b5 then
                        l__Classes__13._x199aee2e6ba696d1:_x9b4936706cf319b5(l__previous_camera_state__99.spectator_target);
                    else
                        l__Classes__13._x199aee2e6ba696d1:_x8fcdafeb8ad3312d(false, l__previous_camera_state__99.spectator_target);
                    end;
                else
                    if l__Classes__13._x32ae459de0772e82 then
                        l__Classes__13._x32ae459de0772e82._x5b34a8c32cf04968 = l__previous_camera_state__99.camera_paused;
                    end;
                    l__CurrentCamera__98.CameraType = l__previous_camera_state__99.camera_type;
                    l__CurrentCamera__98.CameraSubject = l__previous_camera_state__99.camera_subject;
                    l__CurrentCamera__98.CFrame = l__previous_camera_state__99.cframe;
                    l__CurrentCamera__98.Focus = l__previous_camera_state__99.focus;
                    l__CurrentCamera__98.FieldOfView = l__previous_camera_state__99.field_of_view;
                end;
            end;
        end);
        u484.scene_trove:Connect(l__UserInputService__2.InputBegan, function(p487) --[[ Line: 2466 ]]
            -- upvalues: u484 (copy)
            if p487.UserInputType == Enum.UserInputType.MouseButton1 or p487.UserInputType == Enum.UserInputType.Touch then
                u484.dragging = true;
                local v488 = u484;
                if p487.UserInputType ~= Enum.UserInputType.Touch then
                    p487 = nil;
                end;
                v488.drag_input = p487;
                u484.drag_last_position = u484:_getDragPosition();
            end;
        end);
        u484.scene_trove:Connect(l__UserInputService__2.InputEnded, function(p489) --[[ Line: 2476 ]]
            -- upvalues: u484 (copy)
            if p489.UserInputType == Enum.UserInputType.MouseButton1 then
                u484.dragging = false;
                u484.drag_input = nil;
                u484.drag_last_position = nil;
                u484.sway_goal = 0;
                u484.sway_z_goal = 0;
            else
                if p489.UserInputType == Enum.UserInputType.Touch and p489 == u484.drag_input then
                    u484.dragging = false;
                    u484.drag_input = nil;
                    u484.drag_last_position = nil;
                    u484.sway_goal = 0;
                    u484.sway_z_goal = 0;
                end;
            end;
        end);
        u484.scene_trove:Connect(l__UserInputService__2.InputChanged, function(p490) --[[ Line: 2492 ]]
            -- upvalues: u484 (copy), l__CurrentCamera__96 (copy)
            if p490.UserInputType == Enum.UserInputType.MouseWheel then
                local l__Z__100 = p490.Position.Z;
                if l__Z__100 == 0 then
                else
                    local v491 = u484.camera_fov_goal or (u484.showcase_field_of_view or l__CurrentCamera__96.FieldOfView);
                    local v492 = math.clamp(v491 - l__Z__100 * 5, 30, 90);
                    if math.abs(v492 - v491) <= 0.001 then
                    else
                        u484.camera_fov_goal = v492;
                        u484:_pulseScrollBlur();
                    end;
                end;
            end;
        end);
        u484.scene_trove:BindToRenderStep("ShowcasePageCamera", Enum.RenderPriority.Last.Value, function(p493) --[[ Line: 2512 ]]
            -- upvalues: u484 (copy)
            u484:_updateScene(p493);
        end);
    end;
end;
function u1.selectSlot(u494, u495, u496, p497) --[[ Line: 2517 ]]
    -- upvalues: l__Classes__13 (copy)
    if u494.selection_locked and p497 ~= true then
    elseif u495 then
        if u494.selected_slot and u494.selected_slot ~= u495 then
            u494:_updateSlotVisual(u494.selected_slot, true);
        end;
        u494.selected_slot = u495;
        for _, v498 in u494.slot_entries do
            u494:_updateSlotVisual(v498, true);
        end;
        if u496 ~= false then
            l__Classes__13._xbe184fb1376a575d:_x7ab8b42cc5920a78("UI_CLICK", true);
        end;
        u494:_setDetails(u495);
        u494:_updateActions();
        u494:_showSceneModel(u495);
        task.defer(function() --[[ Line: 2547 ]]
            -- upvalues: u494 (copy), u495 (copy), u496 (copy)
            if u494.selected_slot == u495 then
                u494:_centerSelectedSlot(u495, u496 == false);
            end;
        end);
    else
        u494.selected_slot = nil;
        u494:_clearDetails();
        u494:_showSceneModel(nil);
        u494:_updateActions();
    end;
end;
function u1.close(u499) --[[ Line: 2554 ]]
    -- upvalues: l__Classes__13 (copy), l__TweenService__1 (copy)
    local l__main_page__101 = u499.main_page;
    u499.open_id = u499.open_id + 1;
    local l__open_id__102 = u499.open_id;
    l__Classes__13._x255cd8d76027f039:_xc899070684394b2b();
    u499:_cancelExtractIntroRun();
    u499.reveal_trove:Clean();
    u499.action_trove:Clean();
    u499.reveal_state = nil;
    u499.reveal_banner_id = nil;
    u499.reveal_source_currency = nil;
    u499.selection_locked = false;
    u499.scene_trove:Clean();
    u499.model_trove = u499.scene_trove:Extend();
    u499:_restoreMenuContainersVisibility();
    if u499.slot_scroll_tween then
        u499.slot_scroll_tween:Cancel();
        u499.slot_scroll_tween = nil;
    end;
    local l__parent_os__103 = u499.parent_os;
    local v500 = l__parent_os__103:FindFirstChild("RightContainer");
    if v500 then
        v500 = v500:FindFirstChild("MainOS");
    end;
    l__main_page__101.Parent = v500 or l__parent_os__103;
    l__main_page__101.Interactable = false;
    task.delay(0.5, function() --[[ Line: 2579 ]]
        -- upvalues: u499 (copy), l__open_id__102 (copy), l__main_page__101 (copy)
        if u499.open_id == l__open_id__102 and (l__main_page__101 and (l__main_page__101.Parent and not l__main_page__101.Interactable)) then
            l__main_page__101.Visible = false;
            u499.content_trove:Clean();
        end;
    end);
    l__TweenService__1:Create(l__main_page__101, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 1
    }):Play();
    l__TweenService__1:Create(l__main_page__101, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        Position = UDim2.fromScale(0, 1)
    }):Play();
end;
function u1.start(u501, p502, p503, p504) --[[ Line: 2594 ]]
    -- upvalues: l__TweenService__1 (copy)
    u501.open_id = u501.open_id + 1;
    u501:_resetTransientSceneUiState();
    local v505;
    if typeof(p503) == "table" then
        v505 = p503.return_page;
    else
        v505 = p503;
        p503 = p504;
    end;
    local v506 = typeof(p503) ~= "table" and {} or p503;
    local v507 = typeof(v506.intro_type) ~= "string" and "start_down" or v506.intro_type;
    local v508;
    if typeof(v506.page_title) == "string" then
        v508 = v506.page_title;
    else
        v508 = v506.title;
    end;
    u501.return_page = typeof(v505) ~= "string" and "loadout_page" or v505;
    local v509;
    if typeof(v506.return_page_args) == "table" then
        v509 = v506.return_page_args;
    else
        v509 = nil;
    end;
    u501.return_page_args = v509;
    u501.current_mode = typeof(v506.mode) ~= "string" and "inventory" or v506.mode;
    u501.aggregate_slots = v506.aggregate_slots ~= false;
    u501.selection_locked = false;
    u501.reveal_state = nil;
    local v510;
    if typeof(v506.banner_id) == "string" then
        v510 = v506.banner_id;
    else
        v510 = nil;
    end;
    u501.reveal_banner_id = v510;
    local v511;
    if typeof(v506.source_currency) == "string" then
        v511 = v506.source_currency;
    else
        v511 = nil;
    end;
    u501.reveal_source_currency = v511;
    u501.current_reveal_scroll_bonus_duration = typeof(v506.reveal_scroll_bonus_duration) ~= "number" and 0 or math.max(0, v506.reveal_scroll_bonus_duration);
    u501.current_reveal_hold_duration = typeof(v506.reveal_hold_duration) ~= "number" and 0 or math.max(0, v506.reveal_hold_duration);
    u501:_resolveRevealTimings(u501.current_mode == "banner_reveal" and true or v507 == "extract");
    u501.content_trove:Clean();
    u501.scene_trove:Clean();
    u501.reveal_trove:Clean();
    u501.action_trove:Clean();
    u501.model_trove = u501.scene_trove:Extend();
    u501.camera_intro_context = u501:_buildCameraIntroContext(p502, v506);
    u501:_beginCameraIntro(v507);
    u501:_hideMenuContainers();
    local l__main_page__104 = u501.main_page;
    l__main_page__104.Interactable = true;
    l__main_page__104.Visible = true;
    l__main_page__104.Parent = u501.parent_os;
    l__main_page__104.GroupTransparency = 1;
    l__TweenService__1:Create(l__main_page__104, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
    l__main_page__104.Position = UDim2.fromScale(0, -0.1);
    l__TweenService__1:Create(l__main_page__104, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0, 0)
    }):Play();
    local u512 = u501:_getUi();
    if typeof(v508) == "string" then
        local l__page_title__105 = u512.page_title;
        if l__page_title__105 and l__page_title__105:IsA("TextLabel") then
            l__page_title__105.Text = v508;
        elseif l__page_title__105 and l__page_title__105:IsA("TextButton") then
            l__page_title__105.Text = v508;
        end;
    end;
    local v513 = u501.current_mode == "banner_reveal";
    u512.details_container.Visible = not v513;
    u512.return_button.Visible = not v513;
    u501.parent_os.CurrencyLayer.Visible = not v513;
    local l__actions_container__106 = u512.actions_container;
    local v514;
    if u501.current_mode == "banner_preview" then
        v514 = false;
    else
        v514 = not v513;
    end;
    l__actions_container__106.Visible = v514;
    u501:_setRevealInfoVisible(false);
    u512.return_button.Interactable = false;
    task.delay(0.5, function() --[[ Line: 2664 ]]
        -- upvalues: u512 (copy), u501 (copy)
        if u512.return_button and u512.return_button.Parent then
            u512.return_button.Interactable = not u501.selection_locked;
        end;
    end);
    u501:_startCameraOverride();
    u501:_renderSlots(p502);
    if u501.current_mode == "banner_reveal" then
        u501:_beginRevealSpin();
    end;
end;
function u1.Init(u515) --[[ Line: 2678 ]]
    local u516 = u515:_getUi();
    u515.trove:Connect(u516.return_button.Activated, function() --[[ Line: 2680 ]]
        -- upvalues: u516 (copy), u515 (copy)
        u516.return_button.Interactable = false;
        u515.menu_session:openPage(u515.return_page or "loadout_page", unpack(u515.return_page_args or {}));
    end);
    u515.trove:Connect(u516.primary_button.Activated, function() --[[ Line: 2684 ]]
        -- upvalues: u515 (copy)
        u515:_activatePrimaryAction();
    end);
    u515.trove:Connect(u516.primary_info_button.Activated, function() --[[ Line: 2687 ]]
        -- upvalues: u515 (copy)
        u515:_openRevealBannerPreview();
    end);
    u515:_updateActions();
end;
return u1;
