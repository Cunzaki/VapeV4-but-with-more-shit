-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.GamemodesPage
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
local l__ModuleScripts__3 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__4 = require(l__ModuleScripts__3.Packets);
local l__Trove__5 = require(l__ModuleScripts__3.Trove);
local l__CEnum__6 = require(l__ModuleScripts__3.CEnum);
local l__QueueDef__7 = require(l__ModuleScripts__3.QueueDef);
local l__UIAssets__8 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__ClientRoot__9 = require(script.Parent.Parent.Parent.Parent.ClientRoot);
local l__Classes__10 = l__ClientRoot__9.Classes;
local l__InternalSymbols__11 = require(script.Parent.Parent.Parent.Parent.InternalSymbols);
local l__Context__12 = l__ClientRoot__9.Context;
local v2 = l__QueueDef__7.getDef(l__CEnum__6.Queues.Duels1v1);
local v3 = l__QueueDef__7.getDef(l__CEnum__6.Queues.Wingman2v2);
local u4 = false;
local u5 = {
    {
        slot = "queue",
        container_type = "queue",
        thumbnail_id = v2.thumbnail,
        display_name = v2.display_name,
        description = v2.description,
        queue_id = v2.queue_id
    },
    {
        slot = "queue",
        container_type = "queue",
        thumbnail_id = v3.thumbnail,
        display_name = v3.display_name,
        description = v3.description,
        queue_id = v3.queue_id
    },
    {
        slot = "spotlight",
        container_type = "direct",
        display_name = "BATTLEGROUNDS",
        thumbnail_id = "rbxassetid://126185581015558",
        description = "Drop in and fight as you please.",
        public_serverlist = l__CEnum__6.PlaceIds.FFA_PLACE,
        onEnter = function() --[[ Name: onEnter, Line 65 ]]
            -- upvalues: l__Packets__4 (copy), l__CEnum__6 (copy)
            l__Packets__4._x0e45f811eb4ba377:Fire({
                place_id = l__CEnum__6.PlaceIds.FFA_PLACE
            });
        end
    },
    {
        slot = "carousel",
        container_type = "match",
        priority = 20,
        display_name = "TUTORIAL",
        thumbnail_id = "rbxassetid://128990954175604",
        description = "Learn the game!",
        gamemode = l__CEnum__6.Gamemodes.Tutorial
    },
    {
        slot = "carousel",
        container_type = "match",
        thumbnail_id = "rbxassetid://101174142056139",
        priority = 10,
        display_name = "TRAINING",
        description = "No pressure. Just practice.",
        gamemode = l__CEnum__6.Gamemodes.Training
    },
    {
        slot = "return",
        container_type = "direct",
        thumbnail_id = "rbxassetid://117091118360599",
        priority = 10,
        display_name = "RETURN TO LOBBY",
        description = "The gathering place.",
        onEnter = function() --[[ Name: onEnter, Line 94 ]]
            -- upvalues: l__Packets__4 (copy), l__CEnum__6 (copy)
            l__Packets__4._x0e45f811eb4ba377:Fire({
                place_id = l__CEnum__6.PlaceIds.MAIN_PLACE
            });
        end
    }
};
function u1.new(p6, p7) --[[ Line: 100 ]]
    -- upvalues: u1 (copy), l__InternalSymbols__11 (copy), l__Trove__5 (copy), l__UIAssets__8 (copy)
    local v8 = setmetatable({}, u1);
    v8.menu_session = l__InternalSymbols__11.owner("MenuSession", p7);
    v8.parent_os = p6;
    v8.trove = l__Trove__5.new();
    v8.page_origin = l__UIAssets__8.Menu.GamemodesPage;
    v8.main_page = v8.page_origin.GamemodesFrame:Clone();
    v8.queue_containers = {};
    v8.direct_join_modes = {};
    v8.direct_join_cycle_elapsed = 0;
    v8.new_queue_cart = {};
    v8.trove:Add(v8.main_page);
    return v8;
end;
function u1._activateDirectJoinTemplate(_, p9) --[[ Line: 120 ]]
    -- upvalues: u4 (ref), l__Packets__4 (copy)
    if u4 then
    else
        u4 = true;
        task.delay(10, function() --[[ Line: 123 ]]
            -- upvalues: u4 (ref)
            u4 = false;
        end);
        if p9.container_type == "match" then
            l__Packets__4._xb5bc17d25fad4165:Fire({
                gamemode = p9.gamemode
            });
        else
            p9.onEnter();
        end;
    end;
end;
function u1._openDirectJoinServerlist(p10, p11) --[[ Line: 135 ]]
    -- upvalues: l__CEnum__6 (copy)
    if p11.public_serverlist then
        local v12 = l__CEnum__6.reverse(l__CEnum__6.PlaceIds, p11.public_serverlist);
        if v12 then
            p10.menu_session:openPage("serverlist_page", v12);
        else
            warn("NO SUCH SERVERLIST TYPE FOR :", v12);
        end;
    end;
end;
function u1._populateDirectJoinDisplay(_, p13, p14) --[[ Line: 146 ]]
    local l__Main__13 = p13.Main;
    l__Main__13.Thumbnail.ImageColor3 = Color3.fromRGB(230, 230, 230);
    if p14.thumbnail_id then
        l__Main__13.Thumbnail.Image = p14.thumbnail_id;
    end;
    l__Main__13.InformationFrame.ModeLabel.Text = p14.display_name;
    l__Main__13.InformationFrame.CanvasGroup.DescLabel.Text = p14.description;
    l__Main__13.InformationFrame.CanvasGroup.Serverlist.Visible = p14.public_serverlist ~= nil;
end;
function u1._bindDirectJoinHover(_, p15, p16) --[[ Line: 160 ]]
    -- upvalues: l__TweenService__2 (copy)
    local l__Main__14 = p15.Main;
    local l__Button__15 = p15.Button;
    local u17 = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
    local function v18() --[[ Line: 172 ]]
        -- upvalues: l__TweenService__2 (ref), l__Main__14 (copy), u17 (copy)
        l__TweenService__2:Create(l__Main__14.InformationFrame, u17, {
            Position = UDim2.fromScale(0, 1)
        }):Play();
        l__TweenService__2:Create(l__Main__14.InformationFrame.CanvasGroup, u17, {
            GroupTransparency = 1
        }):Play();
        l__TweenService__2:Create(l__Main__14.Thumbnail, u17, {
            Size = UDim2.fromScale(1, 1),
            ImageColor3 = Color3.fromRGB(230, 230, 230)
        }):Play();
    end;
    p16:Connect(l__Button__15.MouseEnter, function() --[[ Name: hoverEnter, Line 166 ]]
        -- upvalues: l__TweenService__2 (ref), l__Main__14 (copy), u17 (copy)
        l__TweenService__2:Create(l__Main__14.InformationFrame, u17, {
            Position = UDim2.fromScale(0, 0.95)
        }):Play();
        l__TweenService__2:Create(l__Main__14.InformationFrame.CanvasGroup, u17, {
            GroupTransparency = 0
        }):Play();
        l__TweenService__2:Create(l__Main__14.Thumbnail, u17, {
            Size = UDim2.fromScale(1.01, 1.01),
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    p16:Connect(l__Button__15.MouseLeave, v18);
end;
function u1._ensureDirectJoinDisplay(u19) --[[ Line: 182 ]]
    if u19.direct_join_display then
    else
        local l__BottomContainer__16 = u19.main_page.Main.DirectJoinContainer.Contents.BottomContainer;
        u19.direct_join_display = l__BottomContainer__16;
        u19:_bindDirectJoinHover(l__BottomContainer__16, u19.trove);
        local l__Main__17 = l__BottomContainer__16.Main;
        u19.trove:Connect(l__Main__17.InformationFrame.CanvasGroup.ActionButton.Activated, function() --[[ Line: 191 ]]
            -- upvalues: u19 (copy)
            if u19.focused_direct_join_mode then
                u19:_activateDirectJoinTemplate(u19.focused_direct_join_mode.template_data);
            end;
        end);
        u19.trove:Connect(l__Main__17.InformationFrame.CanvasGroup.Serverlist.Activated, function() --[[ Line: 196 ]]
            -- upvalues: u19 (copy)
            if u19.focused_direct_join_mode then
                u19:_openDirectJoinServerlist(u19.focused_direct_join_mode.template_data);
            end;
        end);
    end;
end;
function u1._refreshDirectJoinModeSections(p20) --[[ Line: 202 ]]
    for _, v21 in p20.direct_join_modes do
        local v22 = v21 == p20.focused_direct_join_mode and 0 or 0.5;
        local v23 = v21 ~= p20.focused_direct_join_mode and 0 or math.clamp(p20.direct_join_cycle_elapsed / 11, 0, 1);
        local l__mode_section__18 = v21.mode_section;
        l__mode_section__18.BackgroundTransparency = 0.85;
        l__mode_section__18.TextLabel.TextTransparency = v22;
        l__mode_section__18.Fill.BackgroundTransparency = v22;
        l__mode_section__18.Fill.Size = UDim2.fromScale(v23, 1);
    end;
end;
function u1._focusDirectJoinMode(p24, p25) --[[ Line: 214 ]]
    p24:_ensureDirectJoinDisplay();
    p24.focused_direct_join_mode = p25;
    p24.direct_join_cycle_elapsed = 0;
    p24:_populateDirectJoinDisplay(p24.direct_join_display, p25.template_data);
    p24:_refreshDirectJoinModeSections();
end;
function u1._getOrderedDirectJoinModes(p26) --[[ Line: 222 ]]
    local v27 = {};
    for _, v28 in p26.direct_join_modes do
        table.insert(v27, v28);
    end;
    table.sort(v27, function(p29, p30) --[[ Line: 229 ]]
        return p29.priority > p30.priority;
    end);
    return v27;
end;
function u1._getHighestPriorityDirectJoinMode(p31) --[[ Line: 236 ]]
    local v32 = nil;
    for _, v33 in p31.direct_join_modes do
        if not v32 or v33.priority > v32.priority then
            v32 = v33;
        end;
    end;
    return v32;
end;
function u1._getNextDirectJoinMode(p34) --[[ Line: 248 ]]
    local v35 = p34:_getOrderedDirectJoinModes();
    local v36 = table.find(v35, p34.focused_direct_join_mode);
    if v36 then
        return v35[v36 % #v35 + 1];
    else
        return v35[1];
    end;
end;
function u1._updateDirectJoinCycle(p37, p38) --[[ Line: 259 ]]
    if p37.main_page.Parent and (p37.main_page.Visible and p37.main_page.Interactable) then
        if #p37.direct_join_modes == 0 or not p37.focused_direct_join_mode then
        else
            p37.direct_join_cycle_elapsed = p37.direct_join_cycle_elapsed + p38;
            if p37.direct_join_cycle_elapsed >= 11 then
                p37:_focusDirectJoinMode(p37:_getNextDirectJoinMode());
            else
                p37:_refreshDirectJoinModeSections();
            end;
        end;
    end;
end;
function u1.cleanUp(p39) --[[ Line: 271 ]]
    p39.trove:Clean();
    table.clear(p39.new_queue_cart);
end;
function u1.close(p40) --[[ Line: 276 ]]
    -- upvalues: l__TweenService__2 (copy)
    local l__main_page__19 = p40.main_page;
    l__main_page__19.Interactable = false;
    task.delay(0.2, function() --[[ Line: 279 ]]
        -- upvalues: l__main_page__19 (copy)
        if l__main_page__19 and (l__main_page__19.Parent and l__main_page__19.Interactable == false) then
            l__main_page__19.Visible = false;
        end;
    end);
    l__TweenService__2:Create(l__main_page__19, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 1
    }):Play();
end;
function u1.start(p41) --[[ Line: 288 ]]
    -- upvalues: l__TweenService__2 (copy)
    local l__main_page__20 = p41.main_page;
    l__main_page__20.Interactable = true;
    l__main_page__20.Visible = true;
    p41.direct_join_cycle_elapsed = 0;
    p41:_refreshDirectJoinModeSections();
    l__main_page__20.Parent = p41.parent_os;
    l__main_page__20.GroupTransparency = 1;
    l__TweenService__2:Create(l__main_page__20, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
    l__main_page__20.Position = UDim2.fromScale(0, -0.1);
    l__TweenService__2:Create(l__main_page__20, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0, 0)
    }):Play();
end;
function u1._onQueueChanged(p42) --[[ Line: 304 ]]
    -- upvalues: l__Classes__10 (copy)
    local l__main_page__21 = p42.main_page;
    if l__Classes__10.Util:getDictionarySize(p42.new_queue_cart) > 0 then
        l__main_page__21.ConfirmQueue1.Visible = true;
        l__main_page__21.ConfirmQueue2.Visible = true;
    else
        l__main_page__21.ConfirmQueue1.Visible = false;
        l__main_page__21.ConfirmQueue2.Visible = false;
    end;
end;
function u1.confirmQueueCart(p43) --[[ Line: 317 ]]
    p43.menu_session:openPage("empty_page");
    local v44 = {};
    for v45, _ in p43.new_queue_cart do
        local v46 = tonumber(v45);
        table.insert(v44, v46);
    end;
    p43.menu_session:finalizeQueueCart(v44);
    if p43.menu_session.midframe_renderer._client:getQueueState().is_queued then
        p43.menu_session.midframe_renderer:_onQueueButtonActivated();
        p43.menu_session.midframe_renderer:_onQueueButtonActivated();
    else
        p43.menu_session.midframe_renderer:_onQueueButtonActivated();
    end;
end;
function u1.removeFromQueue(p47, p48) --[[ Line: 338 ]]
    local v49 = tostring(p48);
    p47.new_queue_cart[v49] = nil;
    p47:_onQueueChanged();
    for _, v50 in p47.queue_containers do
        if p48 == v50.id then
            v50.inst.Selected.Visible = false;
            v50.is_queued = false;
            return;
        end;
    end;
end;
function u1.addToQueue(p51, p52) --[[ Line: 352 ]]
    local v53 = tostring(p52);
    p51.new_queue_cart[v53] = true;
    p51:_onQueueChanged();
    for _, v54 in p51.queue_containers do
        if p52 == v54.id then
            v54.inst.Selected.Visible = true;
            v54.is_queued = true;
            return;
        end;
    end;
end;
function u1.setupContainer(u55, u56) --[[ Line: 366 ]]
    -- upvalues: l__Context__12 (copy), l__TweenService__2 (copy), l__QueueDef__7 (copy), l__Classes__10 (copy)
    local l__page_origin__22 = u55.page_origin;
    local l__main_page__23 = u55.main_page;
    local u57 = {};
    local v58 = u55.trove:Extend();
    u57._trove = v58;
    if u56.slot == "carousel" then
        local l__Contents__24 = l__main_page__23.Main.DirectJoinContainer.Contents;
        local v59 = l__page_origin__22.ModeSection:Clone();
        local v60 = u56.priority or 0;
        u57.template_data = u56;
        u57.mode_section = v59;
        u57.priority = v60;
        v59.TextLabel.Text = u56.display_name;
        v59.BackgroundTransparency = 0.5;
        v59.TextLabel.TextTransparency = 0.5;
        v59.Fill.BackgroundTransparency = 0.5;
        v59.Fill.Size = UDim2.fromScale(0, 1);
        v59.LayoutOrder = -v60;
        v58:Add(v59);
        v58:Connect(v59.Button.Activated, function() --[[ Line: 391 ]]
            -- upvalues: u55 (copy), u57 (copy)
            u55:_focusDirectJoinMode(u57);
        end);
        table.insert(u55.direct_join_modes, u57);
        v58:Add(function() --[[ Line: 396 ]]
            -- upvalues: u55 (copy), u57 (copy)
            local v61 = table.find(u55.direct_join_modes, u57);
            if v61 then
                table.remove(u55.direct_join_modes, v61);
            end;
        end);
        v59.Parent = l__Contents__24.BottomContainer.ButtonList;
    else
        local v62 = nil;
        local v63 = nil;
        if u56.slot == "spotlight" then
            v62 = l__main_page__23.Main.DirectJoinContainer.Contents.DirectContainer;
        elseif u56.slot == "return" then
            if l__Context__12.is_public_lobby then
                return;
            end;
            v62 = l__main_page__23.Main.ReturnContainer.MainContainer;
        elseif u56.slot == "queue" then
            v62 = l__page_origin__22.QueueContainer:Clone();
            v63 = l__main_page__23.Main.QueueContainer.Contents;
        end;
        u57.inst = v62;
        local l__Main__25 = v62.Main;
        local l__Button__26 = v62.Button;
        local u64 = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
        l__Main__25.Thumbnail.ImageColor3 = Color3.fromRGB(230, 230, 230);
        if u56.thumbnail_id then
            l__Main__25.Thumbnail.Image = u56.thumbnail_id;
        end;
        local function v65() --[[ Line: 436 ]]
            -- upvalues: l__TweenService__2 (ref), l__Main__25 (copy), u64 (copy)
            l__TweenService__2:Create(l__Main__25.InformationFrame, u64, {
                Position = UDim2.fromScale(0, 1)
            }):Play();
            l__TweenService__2:Create(l__Main__25.InformationFrame.CanvasGroup, u64, {
                GroupTransparency = 1
            }):Play();
            l__TweenService__2:Create(l__Main__25.Thumbnail, u64, {
                Size = UDim2.fromScale(1, 1),
                ImageColor3 = Color3.fromRGB(230, 230, 230)
            }):Play();
        end;
        v58:Connect(l__Button__26.MouseEnter, function() --[[ Name: hoverEnter, Line 430 ]]
            -- upvalues: l__TweenService__2 (ref), l__Main__25 (copy), u64 (copy)
            l__TweenService__2:Create(l__Main__25.InformationFrame, u64, {
                Position = UDim2.fromScale(0, 0.95)
            }):Play();
            l__TweenService__2:Create(l__Main__25.InformationFrame.CanvasGroup, u64, {
                GroupTransparency = 0
            }):Play();
            l__TweenService__2:Create(l__Main__25.Thumbnail, u64, {
                Size = UDim2.fromScale(1.01, 1.01),
                ImageColor3 = Color3.fromRGB(255, 255, 255)
            }):Play();
        end);
        v58:Connect(l__Button__26.MouseLeave, v65);
        l__Main__25.InformationFrame.ModeLabel.Text = u56.display_name;
        l__Main__25.InformationFrame.CanvasGroup.DescLabel.Text = u56.description;
        local l__ActionButton__27 = l__Main__25.InformationFrame.CanvasGroup.ActionButton;
        if u56.container_type == "direct" or u56.container_type == "match" then
            local l__Serverlist__28 = l__Main__25.InformationFrame.CanvasGroup.Serverlist;
            v58:Connect(l__ActionButton__27.Activated, function() --[[ Line: 452 ]]
                -- upvalues: u55 (copy), u56 (copy)
                u55:_activateDirectJoinTemplate(u56);
            end);
            if u56.public_serverlist then
                l__Serverlist__28.Visible = true;
                v58:Connect(l__Serverlist__28.Activated, function() --[[ Line: 458 ]]
                    -- upvalues: u55 (copy), u56 (copy)
                    u55:_openDirectJoinServerlist(u56);
                end);
            else
                l__Serverlist__28.Visible = false;
            end;
        elseif u56.container_type == "queue" then
            local v66 = l__QueueDef__7.getDef(u56.queue_id);
            u57.def = v66;
            u57.locked = false;
            u57.is_queued = false;
            u57.id = v66.queue_id;
            local function v67() --[[ Line: 484 ]]
                -- upvalues: u57 (copy), l__ActionButton__27 (copy), u55 (copy), u56 (copy), l__Classes__10 (ref)
                if u57.locked then
                elseif u57.is_queued then
                    l__ActionButton__27.Rotation = 0;
                    u55:removeFromQueue(u56.queue_id);
                    l__Classes__10._x02c5f8f89640473a:_xa2c2f0587694a915("PULL_SWITCH", true);
                else
                    l__ActionButton__27.Rotation = 45;
                    u55:addToQueue(u56.queue_id);
                    l__Classes__10._x02c5f8f89640473a:_xa2c2f0587694a915("PULL_SWITCH", true);
                end;
            end;
            function u57.unqueue() --[[ Line: 478 ]]
                -- upvalues: l__ActionButton__27 (copy), u55 (copy), u56 (copy), l__Classes__10 (ref)
                l__ActionButton__27.Rotation = 0;
                u55:removeFromQueue(u56.queue_id);
                l__Classes__10._x02c5f8f89640473a:_xa2c2f0587694a915("PULL_SWITCH", true);
            end;
            v58:Connect(l__ActionButton__27.Activated, v67);
            v58:Connect(v62.Button.Activated, v67);
            table.insert(u55.queue_containers, u57);
            v58:Add(function() --[[ Line: 499 ]]
                -- upvalues: u55 (copy), u57 (copy)
                table.remove(u55.queue_containers, table.find(u55.queue_containers, u57));
            end);
        end;
        if v63 then
            v62.Parent = v63;
        end;
    end;
end;
function u1.checkQueueEligibility(u68) --[[ Line: 507 ]]
    local v69 = u68.menu_session.midframe_renderer._client:getPartyState();
    local v70 = u68.menu_session.midframe_renderer._client:localPlayerIsLeader();
    local v71 = #v69.members;
    local function v74(p72, p73) --[[ Line: 519 ]]
        -- upvalues: u68 (copy)
        local l__Locked__29 = p72.inst.Locked;
        l__Locked__29.Visible = true;
        l__Locked__29.MainLabel.Text = "TOO MANY IN PARTY";
        l__Locked__29.SubLabel.Text = "(Max. Party of " .. p73 .. ")";
        p72.locked = true;
        if p72.is_queued then
            pcall(p72.unqueue);
        end;
        if u68.new_queue_cart[tostring(p72.def.queue_id)] == true then
            u68:removeFromQueue(p72.def.queue_id);
        end;
    end;
    local function v76(p75) --[[ Line: 534 ]]
        -- upvalues: u68 (copy)
        local l__Locked__30 = p75.inst.Locked;
        l__Locked__30.Visible = true;
        l__Locked__30.MainLabel.Text = "NOT HOST";
        l__Locked__30.SubLabel.Text = "(Only the Host can select Queues for the Party)";
        p75.locked = true;
        if p75.is_queued then
            pcall(p75.unqueue);
        end;
        if u68.new_queue_cart[tostring(p75.def.queue_id)] == true then
            u68:removeFromQueue(p75.def.queue_id);
        end;
    end;
    for _, v77 in u68.queue_containers do
        local l__required_slot_size__31 = v77.def.required_slot_size;
        if v70 then
            if l__required_slot_size__31 < v71 then
                v74(v77, l__required_slot_size__31);
            else
                v77.inst.Locked.Visible = false;
                v77.locked = false;
            end;
        else
            v76(v77);
        end;
    end;
end;
function u1.Init(u78) --[[ Line: 562 ]]
    -- upvalues: l__Packets__4 (copy), l__Context__12 (copy), u5 (copy), l__RunService__1 (copy)
    local l__main_page__32 = u78.main_page;
    u78.trove:Connect(l__main_page__32.OutButton.Activated, function() --[[ Line: 565 ]]
        -- upvalues: u78 (copy)
        u78.menu_session:openPage("empty_page");
    end);
    u78.trove:Connect(l__main_page__32.ConfirmQueue1.Activated, function() --[[ Line: 569 ]]
        -- upvalues: u78 (copy)
        u78:confirmQueueCart();
    end);
    u78.trove:Connect(l__main_page__32.ConfirmQueue2.Activated, function() --[[ Line: 573 ]]
        -- upvalues: u78 (copy)
        u78:confirmQueueCart();
    end);
    local v79 = l__main_page__32.Main.QueueContainer:FindFirstChild("CreateCustomButton", true);
    if v79 and v79:IsA("GuiButton") then
        u78.trove:Connect(v79.Activated, function() --[[ Line: 579 ]]
            -- upvalues: l__Packets__4 (ref)
            l__Packets__4._x851f9a3ff98bf94f:Fire("CREATE");
        end);
    else
        warn("GamemodesPage UI is missing CreateCustomButton");
    end;
    if not l__Context__12.is_public_lobby then
        l__main_page__32.Main.QueueContainer.Visible = false;
    end;
    l__main_page__32.Main.ReturnContainer.Visible = not l__Context__12.is_public_lobby;
    if u78.menu_session.midframe_renderer and u78.menu_session.midframe_renderer._client then
        u78.trove:Connect(u78.menu_session.midframe_renderer._client.partyChanged, function() --[[ Line: 593 ]]
            -- upvalues: u78 (copy)
            u78:checkQueueEligibility();
        end);
        u78:checkQueueEligibility();
    end;
    for _, v80 in u5 do
        u78:setupContainer(v80);
    end;
    local v81 = u78:_getHighestPriorityDirectJoinMode();
    if v81 then
        u78:_focusDirectJoinMode(v81);
    end;
    u78.trove:Connect(l__RunService__1.RenderStepped, function(p82) --[[ Line: 609 ]]
        -- upvalues: u78 (copy)
        u78:_updateDirectJoinCycle(p82);
    end);
end;
return u1;
