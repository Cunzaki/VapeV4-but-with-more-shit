-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.GamemodesPage
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

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
            l__Packets__4._xd5a9d73c53b4d910:Fire({
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
            l__Packets__4._xd5a9d73c53b4d910:Fire({
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
            l__Packets__4._xf1a5e1b80bd07564:Fire({
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
function u1.confirmQueueCart(u43) --[[ Line: 317 ]]
    u43.menu_session:openPage("empty_page");
    local u44 = {};
    for v45, _ in u43.new_queue_cart do
        local v46 = tonumber(v45);
        table.insert(u44, v46);
    end;
    u43.menu_session:finalizeQueueCart(u44);
    local l__midframe_renderer__22 = u43.menu_session.midframe_renderer;
    local u47;
    if l__midframe_renderer__22 then
        u47 = l__midframe_renderer__22._client;
    else
        u47 = l__midframe_renderer__22;
    end;
    if u47 and #u44 ~= 0 then
        local v48 = u47:getQueueState();
        if v48.is_queued then
            u47:dequeue();
            task.spawn(function() --[[ Line: 338 ]]
                -- upvalues: u47 (copy), u43 (copy), l__midframe_renderer__22 (copy), u44 (copy)
                local v49 = os.clock() + 3;
                while u47:isQueued() and (not u47:isMatchPending() and os.clock() < v49) do
                    task.wait();
                end;
                if u43.menu_session.midframe_renderer == l__midframe_renderer__22 and l__midframe_renderer__22._client == u47 then
                    if not (u47:isQueued() or u47:isMatchPending()) then
                        u47:enqueue(u44);
                    end;
                end;
            end);
        else
            if not v48.is_match_pending then
                u47:enqueue(u44);
            end;
        end;
    end;
end;
function u1.removeFromQueue(p50, p51) --[[ Line: 357 ]]
    local v52 = tostring(p51);
    p50.new_queue_cart[v52] = nil;
    p50:_onQueueChanged();
    for _, v53 in p50.queue_containers do
        if p51 == v53.id then
            v53.inst.Selected.Visible = false;
            v53.is_queued = false;
            return;
        end;
    end;
end;
function u1.addToQueue(p54, p55) --[[ Line: 371 ]]
    local v56 = tostring(p55);
    p54.new_queue_cart[v56] = true;
    p54:_onQueueChanged();
    for _, v57 in p54.queue_containers do
        if p55 == v57.id then
            v57.inst.Selected.Visible = true;
            v57.is_queued = true;
            return;
        end;
    end;
end;
function u1.setupContainer(u58, u59) --[[ Line: 385 ]]
    -- upvalues: l__Context__12 (copy), l__TweenService__2 (copy), l__QueueDef__7 (copy), l__Classes__10 (copy)
    local l__page_origin__23 = u58.page_origin;
    local l__main_page__24 = u58.main_page;
    local u60 = {};
    local v61 = u58.trove:Extend();
    u60._trove = v61;
    if u59.slot == "carousel" then
        local l__Contents__25 = l__main_page__24.Main.DirectJoinContainer.Contents;
        local v62 = l__page_origin__23.ModeSection:Clone();
        local v63 = u59.priority or 0;
        u60.template_data = u59;
        u60.mode_section = v62;
        u60.priority = v63;
        v62.TextLabel.Text = u59.display_name;
        v62.BackgroundTransparency = 0.5;
        v62.TextLabel.TextTransparency = 0.5;
        v62.Fill.BackgroundTransparency = 0.5;
        v62.Fill.Size = UDim2.fromScale(0, 1);
        v62.LayoutOrder = -v63;
        v61:Add(v62);
        v61:Connect(v62.Button.Activated, function() --[[ Line: 410 ]]
            -- upvalues: u58 (copy), u60 (copy)
            u58:_focusDirectJoinMode(u60);
        end);
        table.insert(u58.direct_join_modes, u60);
        v61:Add(function() --[[ Line: 415 ]]
            -- upvalues: u58 (copy), u60 (copy)
            local v64 = table.find(u58.direct_join_modes, u60);
            if v64 then
                table.remove(u58.direct_join_modes, v64);
            end;
        end);
        v62.Parent = l__Contents__25.BottomContainer.ButtonList;
    else
        local v65 = nil;
        local v66 = nil;
        if u59.slot == "spotlight" then
            v65 = l__main_page__24.Main.DirectJoinContainer.Contents.DirectContainer;
        elseif u59.slot == "return" then
            if l__Context__12.is_public_lobby then
                return;
            end;
            v65 = l__main_page__24.Main.ReturnContainer.MainContainer;
        elseif u59.slot == "queue" then
            v65 = l__page_origin__23.QueueContainer:Clone();
            v66 = l__main_page__24.Main.QueueContainer.Contents;
        end;
        u60.inst = v65;
        local l__Main__26 = v65.Main;
        local l__Button__27 = v65.Button;
        local u67 = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
        l__Main__26.Thumbnail.ImageColor3 = Color3.fromRGB(230, 230, 230);
        if u59.thumbnail_id then
            l__Main__26.Thumbnail.Image = u59.thumbnail_id;
        end;
        local function v68() --[[ Line: 455 ]]
            -- upvalues: l__TweenService__2 (ref), l__Main__26 (copy), u67 (copy)
            l__TweenService__2:Create(l__Main__26.InformationFrame, u67, {
                Position = UDim2.fromScale(0, 1)
            }):Play();
            l__TweenService__2:Create(l__Main__26.InformationFrame.CanvasGroup, u67, {
                GroupTransparency = 1
            }):Play();
            l__TweenService__2:Create(l__Main__26.Thumbnail, u67, {
                Size = UDim2.fromScale(1, 1),
                ImageColor3 = Color3.fromRGB(230, 230, 230)
            }):Play();
        end;
        v61:Connect(l__Button__27.MouseEnter, function() --[[ Name: hoverEnter, Line 449 ]]
            -- upvalues: l__TweenService__2 (ref), l__Main__26 (copy), u67 (copy)
            l__TweenService__2:Create(l__Main__26.InformationFrame, u67, {
                Position = UDim2.fromScale(0, 0.95)
            }):Play();
            l__TweenService__2:Create(l__Main__26.InformationFrame.CanvasGroup, u67, {
                GroupTransparency = 0
            }):Play();
            l__TweenService__2:Create(l__Main__26.Thumbnail, u67, {
                Size = UDim2.fromScale(1.01, 1.01),
                ImageColor3 = Color3.fromRGB(255, 255, 255)
            }):Play();
        end);
        v61:Connect(l__Button__27.MouseLeave, v68);
        l__Main__26.InformationFrame.ModeLabel.Text = u59.display_name;
        l__Main__26.InformationFrame.CanvasGroup.DescLabel.Text = u59.description;
        local l__ActionButton__28 = l__Main__26.InformationFrame.CanvasGroup.ActionButton;
        if u59.container_type == "direct" or u59.container_type == "match" then
            local l__Serverlist__29 = l__Main__26.InformationFrame.CanvasGroup.Serverlist;
            v61:Connect(l__ActionButton__28.Activated, function() --[[ Line: 471 ]]
                -- upvalues: u58 (copy), u59 (copy)
                u58:_activateDirectJoinTemplate(u59);
            end);
            if u59.public_serverlist then
                l__Serverlist__29.Visible = true;
                v61:Connect(l__Serverlist__29.Activated, function() --[[ Line: 477 ]]
                    -- upvalues: u58 (copy), u59 (copy)
                    u58:_openDirectJoinServerlist(u59);
                end);
            else
                l__Serverlist__29.Visible = false;
            end;
        elseif u59.container_type == "queue" then
            local v69 = l__QueueDef__7.getDef(u59.queue_id);
            u60.def = v69;
            u60.locked = false;
            u60.is_queued = false;
            u60.id = v69.queue_id;
            local function v70() --[[ Line: 503 ]]
                -- upvalues: u60 (copy), l__ActionButton__28 (copy), u58 (copy), u59 (copy), l__Classes__10 (ref)
                if u60.locked then
                elseif u60.is_queued then
                    l__ActionButton__28.Rotation = 0;
                    u58:removeFromQueue(u59.queue_id);
                    l__Classes__10._xbe184fb1376a575d:_x7ab8b42cc5920a78("PULL_SWITCH", true);
                else
                    l__ActionButton__28.Rotation = 45;
                    u58:addToQueue(u59.queue_id);
                    l__Classes__10._xbe184fb1376a575d:_x7ab8b42cc5920a78("PULL_SWITCH", true);
                end;
            end;
            function u60.unqueue() --[[ Line: 497 ]]
                -- upvalues: l__ActionButton__28 (copy), u58 (copy), u59 (copy), l__Classes__10 (ref)
                l__ActionButton__28.Rotation = 0;
                u58:removeFromQueue(u59.queue_id);
                l__Classes__10._xbe184fb1376a575d:_x7ab8b42cc5920a78("PULL_SWITCH", true);
            end;
            v61:Connect(l__ActionButton__28.Activated, v70);
            v61:Connect(v65.Button.Activated, v70);
            table.insert(u58.queue_containers, u60);
            v61:Add(function() --[[ Line: 518 ]]
                -- upvalues: u58 (copy), u60 (copy)
                table.remove(u58.queue_containers, table.find(u58.queue_containers, u60));
            end);
        end;
        if v66 then
            v65.Parent = v66;
        end;
    end;
end;
function u1.checkQueueEligibility(u71) --[[ Line: 526 ]]
    local v72 = u71.menu_session.midframe_renderer._client:getPartyState();
    local v73 = u71.menu_session.midframe_renderer._client:localPlayerIsLeader();
    local v74 = #v72.members;
    local function v77(p75, p76) --[[ Line: 538 ]]
        -- upvalues: u71 (copy)
        local l__Locked__30 = p75.inst.Locked;
        l__Locked__30.Visible = true;
        l__Locked__30.MainLabel.Text = "TOO MANY IN PARTY";
        l__Locked__30.SubLabel.Text = "(Max. Party of " .. p76 .. ")";
        p75.locked = true;
        if p75.is_queued then
            pcall(p75.unqueue);
        end;
        if u71.new_queue_cart[tostring(p75.def.queue_id)] == true then
            u71:removeFromQueue(p75.def.queue_id);
        end;
    end;
    local function v79(p78) --[[ Line: 553 ]]
        -- upvalues: u71 (copy)
        local l__Locked__31 = p78.inst.Locked;
        l__Locked__31.Visible = true;
        l__Locked__31.MainLabel.Text = "NOT HOST";
        l__Locked__31.SubLabel.Text = "(Only the Host can select Queues for the Party)";
        p78.locked = true;
        if p78.is_queued then
            pcall(p78.unqueue);
        end;
        if u71.new_queue_cart[tostring(p78.def.queue_id)] == true then
            u71:removeFromQueue(p78.def.queue_id);
        end;
    end;
    for _, v80 in u71.queue_containers do
        local l__required_slot_size__32 = v80.def.required_slot_size;
        if v73 then
            if l__required_slot_size__32 < v74 then
                v77(v80, l__required_slot_size__32);
            else
                v80.inst.Locked.Visible = false;
                v80.locked = false;
            end;
        else
            v79(v80);
        end;
    end;
end;
function u1.Init(u81) --[[ Line: 581 ]]
    -- upvalues: l__Packets__4 (copy), l__Context__12 (copy), u5 (copy), l__RunService__1 (copy)
    local l__main_page__33 = u81.main_page;
    u81.trove:Connect(l__main_page__33.OutButton.Activated, function() --[[ Line: 584 ]]
        -- upvalues: u81 (copy)
        u81.menu_session:openPage("empty_page");
    end);
    u81.trove:Connect(l__main_page__33.ConfirmQueue1.Activated, function() --[[ Line: 588 ]]
        -- upvalues: u81 (copy)
        u81:confirmQueueCart();
    end);
    u81.trove:Connect(l__main_page__33.ConfirmQueue2.Activated, function() --[[ Line: 592 ]]
        -- upvalues: u81 (copy)
        u81:confirmQueueCart();
    end);
    local v82 = l__main_page__33.Main.QueueContainer:FindFirstChild("CreateCustomButton", true);
    if v82 and v82:IsA("GuiButton") then
        u81.trove:Connect(v82.Activated, function() --[[ Line: 598 ]]
            -- upvalues: l__Packets__4 (ref)
            l__Packets__4._xba9fc88ff1172d6c:Fire("CREATE");
        end);
    else
        warn("GamemodesPage UI is missing CreateCustomButton");
    end;
    if not l__Context__12.is_public_lobby then
        l__main_page__33.Main.QueueContainer.Visible = false;
    end;
    l__main_page__33.Main.ReturnContainer.Visible = not l__Context__12.is_public_lobby;
    if u81.menu_session.midframe_renderer and u81.menu_session.midframe_renderer._client then
        u81.trove:Connect(u81.menu_session.midframe_renderer._client.partyChanged, function() --[[ Line: 612 ]]
            -- upvalues: u81 (copy)
            u81:checkQueueEligibility();
        end);
        u81:checkQueueEligibility();
    end;
    for _, v83 in u5 do
        u81:setupContainer(v83);
    end;
    local v84 = u81:_getHighestPriorityDirectJoinMode();
    if v84 then
        u81:_focusDirectJoinMode(v84);
    end;
    u81.trove:Connect(l__RunService__1.RenderStepped, function(p85) --[[ Line: 628 ]]
        -- upvalues: u81 (copy)
        u81:_updateDirectJoinCycle(p85);
    end);
end;
return u1;
