-- Decompiled from: Start.Client.Classes.MenuManager.MenuSession.ServerlistPage
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: 7788d2d7-e8a6-45f7-b466-9d5660dc4a7c

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__3 = require(l__ModuleScripts__2.Packets);
local l__Trove__4 = require(l__ModuleScripts__2.Trove);
local l__CEnum__5 = require(l__ModuleScripts__2.CEnum);
local l__UIAssets__6 = game:GetService("ReplicatedStorage").Assets.UIAssets;
local u1 = {};
u1.__index = u1;
local l__ClientRoot__7 = require(script.Parent.Parent.Parent.Parent.ClientRoot);
local l__Classes__8 = l__ClientRoot__7.Classes;
local l__InternalSymbols__9 = require(script.Parent.Parent.Parent.Parent.InternalSymbols);
local l__Context__10 = l__ClientRoot__7.Context;
local u2 = {
    {
        server_type = "FFA_PLACE",
        display_text = "FFA",
        place_id = l__CEnum__5.PlaceIds.FFA_PLACE
    },
    {
        server_type = "MAIN_PLACE",
        display_text = "LOBBY",
        place_id = l__CEnum__5.PlaceIds.MAIN_PLACE
    }
};
local u3 = {};
local u4 = {
    {
        region_text = "ALL REGIONS",
        allow_list = {}
    },
    {
        region_text = "AMERICA",
        allow_list = {
            ["America/"] = true
        }
    },
    {
        region_text = "EUROPE",
        allow_list = {
            ["Europe/"] = true
        }
    },
    {
        region_text = "ASIA",
        allow_list = {
            ["Asia/"] = true
        }
    },
    {
        region_text = "OCEANIA",
        allow_list = {
            ["Oceania/"] = true,
            ["Australia/"] = true,
            ["Pacific/"] = true
        }
    },
    {
        region_text = "AFRICA",
        allow_list = {
            ["Africa/"] = true
        }
    },
    {
        region_text = "ANTARCTICA",
        allow_list = {
            ["Antarctica/"] = true
        }
    }
};
for v5, v6 in u2 do
    u3[v6.server_type] = v5;
end;
local function u16(p7) --[[ Line: 110 ]]
    local v8 = {};
    local v9 = {};
    if type(p7.list) == "table" then
        for _, v10 in ipairs(p7.list) do
            if type(v10) == "table" then
                local l__job_id__11 = v10.job_id;
                local v11;
                if type(l__job_id__11) == "string" and l__job_id__11 ~= "" then
                    v11 = v9[l__job_id__11] ~= true;
                    v9[l__job_id__11] = true;
                else
                    v11 = true;
                end;
                if v11 then
                    local v12 = #v8 + 1;
                    local v13 = {};
                    for v14, v15 in pairs(v10) do
                        if v14 ~= "inst" then
                            v13[v14] = v15;
                        end;
                    end;
                    v8[v12] = v13;
                end;
            end;
        end;
    end;
    return {
        op = p7.op,
        server_type = p7.server_type,
        list = v8,
        limit = p7.limit,
        total = p7.total,
        has_more = p7.has_more
    };
end;
function u1.new(p17, p18) --[[ Line: 139 ]]
    -- upvalues: u1 (copy), l__InternalSymbols__9 (copy), l__Trove__4 (copy), l__UIAssets__6 (copy), u3 (copy), l__Context__10 (copy)
    local v19 = setmetatable({}, u1);
    v19.menu_session = l__InternalSymbols__9.owner("MenuSession", p18);
    v19.parent_os = p17;
    v19.trove = l__Trove__4.new();
    v19.page_origin = l__UIAssets__6.Menu.ServerlistPage;
    v19.main_page = v19.page_origin.ServerlistFrame:Clone();
    v19.trove:Add(v19.main_page);
    v19.current_server_type = nil;
    v19.server_records = {};
    v19.snapshot_cache = {};
    v19.snapshot_request_times = {};
    v19.render_id = 0;
    v19.list_trove = v19.trove:Extend();
    v19.load_more_db = false;
    v19.refresh_db = false;
    v19.region_index = 1;
    v19.server_type_index = u3[l__Context__10.serverlist_type] or 1;
    v19:setRegionFilter(v19.region_index);
    v19:refreshServerTypeFilter();
    return v19;
end;
function u1.cleanUp(p20) --[[ Line: 171 ]]
    p20.trove:Clean();
end;
function u1.close(p21) --[[ Line: 175 ]]
    -- upvalues: l__TweenService__1 (copy)
    local l__main_page__12 = p21.main_page;
    l__main_page__12.Parent = p21.parent_os.RightContainer.MainOS;
    l__main_page__12.Interactable = false;
    l__TweenService__1:Create(l__main_page__12, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 1
    }):Play();
    l__TweenService__1:Create(l__main_page__12, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        Position = UDim2.fromScale(0, 1)
    }):Play();
end;
function u1.refreshRegionFilter(p22) --[[ Line: 184 ]]
    -- upvalues: u4 (copy)
    local v23 = u4[p22.region_index];
    p22.main_page.Borders.RegionFrame.Frame.TextButton.Text = v23.region_text;
    if p22.region_index == 1 then
        for _, v24 in p22.server_records do
            if v24.inst and v24.inst.Parent ~= nil then
                v24.inst.Visible = true;
            end;
        end;
    else
        local l__allow_list__13 = v23.allow_list;
        for _, v25 in p22.server_records do
            local l__region__14 = v25.region;
            local v26;
            if type(l__region__14) == "string" then
                v26 = l__region__14:match("^[^/]+/");
            else
                v26 = nil;
            end;
            if l__allow_list__13[v26] then
                v25.inst.Visible = true;
            else
                v25.inst.Visible = false;
            end;
        end;
    end;
end;
function u1.cycleRegionFilter(p27) --[[ Line: 218 ]]
    -- upvalues: l__Classes__8 (copy), u4 (copy)
    l__Classes__8._xbe184fb1376a575d:_x7ab8b42cc5920a78("CASETTE_PLAY", true);
    if p27.region_index + 1 > #u4 then
        p27.region_index = 1;
    else
        p27.region_index = p27.region_index + 1;
    end;
    p27:refreshRegionFilter();
end;
function u1.setRegionFilter(p28, p29) --[[ Line: 229 ]]
    -- upvalues: u4 (copy)
    p28.region_index = math.clamp(p29, 1, #u4);
    p28:refreshRegionFilter();
end;
function u1.refreshServerTypeFilter(p30) --[[ Line: 234 ]]
    -- upvalues: u2 (copy)
    p30.main_page.Borders.ServerFrame.Frame.TextButton.Text = u2[p30.server_type_index].display_text;
end;
function u1.cycleServerTypeFilter(p31) --[[ Line: 241 ]]
    -- upvalues: l__Classes__8 (copy), u2 (copy)
    l__Classes__8._xbe184fb1376a575d:_x7ab8b42cc5920a78("CASETTE_PLAY", true);
    if p31.server_type_index + 1 > #u2 then
        p31.server_type_index = 1;
    else
        p31.server_type_index = p31.server_type_index + 1;
    end;
    p31:requestSnapshot(u2[p31.server_type_index].server_type);
end;
function u1.setServerTypeFilter(p32, p33) --[[ Line: 254 ]]
    -- upvalues: u3 (copy)
    local v34 = u3[p33];
    if v34 then
        p32.server_type_index = v34;
        p32:refreshServerTypeFilter();
    end;
end;
function u1.getSelectedServerType(p35) --[[ Line: 262 ]]
    -- upvalues: u2 (copy)
    return u2[p35.server_type_index].server_type;
end;
function u1.clearRenderedList(p36) --[[ Line: 266 ]]
    local l__ScrollingFrame__15 = p36.main_page.Borders.Serverlist.ScrollingFrame;
    p36.render_id = p36.render_id + 1;
    p36.list_trove:Clean();
    table.clear(p36.server_records);
    l__ScrollingFrame__15.LoadMore.Visible = false;
end;
function u1.sendSnapshotRequest(p37, p38, p39) --[[ Line: 276 ]]
    -- upvalues: u3 (copy), l__Packets__3 (copy)
    if type(p38) ~= "string" or not u3[p38] then
        p38 = nil;
    end;
    if p38 then
        local v40 = os.clock();
        local v41 = p37.snapshot_request_times[p38];
        if p39 or (not v41 or v40 - v41 >= 5) then
            p37.snapshot_request_times[p38] = v40;
            l__Packets__3._xe98e3ab9d7e26ed2:Fire({
                op = "get_snapshot",
                server_type = p38
            });
        end;
    end;
end;
function u1.requestSnapshot(p42, p43, p44) --[[ Line: 296 ]]
    -- upvalues: u3 (copy)
    if type(p43) ~= "string" or not u3[p43] then
        p43 = nil;
    end;
    local v45 = p43 or p42:getSelectedServerType();
    p42.current_server_type = v45;
    p42:setServerTypeFilter(v45);
    local v46 = p42.snapshot_cache[v45];
    if v46 then
        p42:renderSnapshot(v46);
    else
        p42:clearRenderedList();
    end;
    p42:sendSnapshotRequest(v45, p44);
end;
function u1.prefetchServerTypes(p47) --[[ Line: 311 ]]
    -- upvalues: u2 (copy)
    for _, v48 in u2 do
        if v48.server_type ~= p47.current_server_type and not p47.snapshot_cache[v48.server_type] then
            p47:sendSnapshotRequest(v48.server_type, false);
        end;
    end;
end;
function u1.requestLoadMore(u49) --[[ Line: 319 ]]
    -- upvalues: l__Classes__8 (copy), l__Packets__3 (copy)
    if u49.load_more_db then
    else
        u49.load_more_db = true;
        task.delay(1, function() --[[ Line: 322 ]]
            -- upvalues: u49 (copy)
            u49.load_more_db = false;
        end);
        local v50 = {
            op = "load_more",
            server_type = u49.current_server_type
        };
        l__Classes__8._xbe184fb1376a575d:_x7ab8b42cc5920a78("CASETTE_PLAY", true);
        l__Packets__3._xe98e3ab9d7e26ed2:Fire(v50);
    end;
end;
function u1.renderSnapshot(u51, p52) --[[ Line: 336 ]]
    -- upvalues: u3 (copy), u2 (copy), l__Classes__8 (copy), l__TweenService__1 (copy)
    local l__server_type__16 = p52.server_type;
    if type(l__server_type__16) ~= "string" or not u3[l__server_type__16] then
        l__server_type__16 = nil;
    end;
    if l__server_type__16 then
        u51:setServerTypeFilter(l__server_type__16);
        u51.render_id = u51.render_id + 1;
        local l__render_id__17 = u51.render_id;
        local l__page_origin__18 = u51.page_origin;
        local l__ScrollingFrame__19 = u51.main_page.Borders.Serverlist.ScrollingFrame;
        u51.list_trove:Clean();
        table.clear(u51.server_records);
        l__ScrollingFrame__19.LoadMore.Visible = p52.has_more == true;
        local function u64(p53, p54) --[[ Line: 353 ]]
            -- upvalues: u51 (copy), l__render_id__17 (copy), l__page_origin__18 (copy), u3 (ref), u2 (ref), l__ScrollingFrame__19 (copy), l__Classes__8 (ref), l__TweenService__1 (ref)
            if u51.render_id == l__render_id__17 then
                local u55 = l__page_origin__18.ServerEntry:Clone();
                local u56 = {};
                for v57, v58 in pairs(p54) do
                    if v57 ~= "inst" then
                        u56[v57] = v58;
                    end;
                end;
                u56.inst = u55;
                u51.server_records[p53] = u56;
                u55.LayoutOrder = p53;
                if u56.player_count and u56.max_players then
                    u55.Container.PlayersOnline.Text = "● " .. u56.player_count .. "/" .. u56.max_players .. " ONLINE";
                end;
                if u56.region then
                    u55.Container.Region.Text = u56.region;
                end;
                if u56.server_type then
                    local l__ServerType__20 = u55.Container.ServerType;
                    local l__server_type__21 = u56.server_type;
                    local v59 = u3[l__server_type__21];
                    local v60;
                    if v59 then
                        v60 = u2[v59].display_text;
                    else
                        v60 = tostring(l__server_type__21 or "");
                    end;
                    l__ServerType__20.Text = v60;
                end;
                u55.Parent = l__ScrollingFrame__19;
                u55.ServerActions.IdFrame.Visible = false;
                local l__ServerActions__22 = u55.ServerActions;
                local u61 = false;
                local u62 = u55.Button.Activated:Connect(function() --[[ Line: 379 ]]
                    -- upvalues: l__Classes__8 (ref), u61 (ref), l__ServerActions__22 (copy), l__TweenService__1 (ref)
                    l__Classes__8._xbe184fb1376a575d:_x7ab8b42cc5920a78("UI_CLICK", true);
                    if u61 then
                        u61 = false;
                        task.delay(0.2, function() --[[ Line: 383 ]]
                            -- upvalues: u61 (ref), l__ServerActions__22 (ref)
                            if not u61 and (l__ServerActions__22 and l__ServerActions__22.Parent ~= nil) then
                                l__ServerActions__22.Visible = false;
                            end;
                        end);
                        l__TweenService__1:Create(l__ServerActions__22, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                            Position = UDim2.fromScale(0, 1.4)
                        }):Play();
                    else
                        u61 = true;
                        l__ServerActions__22.Visible = true;
                        l__TweenService__1:Create(l__ServerActions__22, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                            Position = UDim2.fromScale(0, 1)
                        }):Play();
                    end;
                end);
                local u63 = u55.ServerActions.JoinFrame.JoinServer.Activated:Connect(function() --[[ Line: 396 ]]
                    -- upvalues: u61 (ref), u51 (ref), u56 (ref)
                    if u61 then
                        u51:tryJoinServer(u56);
                    end;
                end);
                u51.list_trove:Add(function() --[[ Name: clean, Line 402 ]]
                    -- upvalues: u55 (copy), u62 (ref), u63 (ref)
                    if u55 then
                        u55:Destroy();
                    end;
                    if u62 then
                        u62:Disconnect();
                        u62 = nil;
                    end;
                    if u63 then
                        u63:Disconnect();
                        u63 = nil;
                    end;
                end);
            end;
        end;
        for u65, u66 in ipairs(p52.list) do
            task.spawn(function() --[[ Line: 420 ]]
                -- upvalues: u51 (copy), l__render_id__17 (copy), u64 (copy), u65 (copy), u66 (copy)
                if u51.render_id == l__render_id__17 then
                    u64(u65, u66);
                end;
            end);
        end;
        u51:refreshRegionFilter();
    end;
end;
function u1.onNewSnapshot(p67, p68) --[[ Line: 429 ]]
    -- upvalues: u3 (copy), u16 (copy)
    local l__server_type__23 = p68.server_type;
    if type(l__server_type__23) ~= "string" or not u3[l__server_type__23] then
        l__server_type__23 = nil;
    end;
    if l__server_type__23 then
        local v69 = u16(p68);
        v69.server_type = l__server_type__23;
        p67.snapshot_cache[l__server_type__23] = v69;
        if l__server_type__23 == p67.current_server_type then
            p67:renderSnapshot(v69);
        end;
    end;
end;
function u1.start(p70, p71) --[[ Line: 444 ]]
    -- upvalues: l__TweenService__1 (copy), u3 (copy), l__Context__10 (copy)
    local l__main_page__24 = p70.main_page;
    l__main_page__24.Interactable = true;
    l__main_page__24.Parent = p70.parent_os.RightContainer.MainOS;
    l__main_page__24.GroupTransparency = 1;
    l__TweenService__1:Create(l__main_page__24, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        GroupTransparency = 0
    }):Play();
    l__main_page__24.Position = UDim2.fromScale(0, -0.1);
    l__TweenService__1:Create(l__main_page__24, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0, 0)
    }):Play();
    if type(p71) ~= "string" or not u3[p71] then
        p71 = nil;
    end;
    if not p71 then
        p71 = l__Context__10.serverlist_type;
        if type(p71) ~= "string" or not u3[p71] then
            p71 = nil;
        end;
    end;
    if p71 then
        p70:requestSnapshot(p71, true);
        p70:prefetchServerTypes();
    else
        warn("PLACE ID :", game.PlaceId, " OPENED SERVERLIST WITH NO SERVER TYPE");
    end;
end;
function u1.refreshList(u72) --[[ Line: 465 ]]
    -- upvalues: l__Classes__8 (copy), l__TweenService__1 (copy)
    local l__RefreshButton__25 = u72.main_page.Borders.RefreshButton;
    if u72.current_server_type and not u72.refresh_db then
        u72.refresh_db = true;
        task.delay(1, function() --[[ Line: 471 ]]
            -- upvalues: u72 (copy)
            u72.refresh_db = false;
        end);
        l__Classes__8._xbe184fb1376a575d:_x7ab8b42cc5920a78("CASETTE_PLAY", true);
        u72:requestSnapshot(u72.current_server_type, true);
        l__TweenService__1:Create(l__RefreshButton__25, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Rotation = l__RefreshButton__25.Rotation + 360
        }):Play();
    end;
end;
function u1.tryJoinServer(_, p73) --[[ Line: 481 ]]
    -- upvalues: u3 (copy), u2 (copy), l__Classes__8 (copy), l__Packets__3 (copy)
    if type(p73) == "table" then
        local v74;
        if type(p73.place_id) == "number" then
            v74 = p73.place_id;
        else
            local l__server_type__26 = p73.server_type;
            if type(l__server_type__26) ~= "string" or not u3[l__server_type__26] then
                l__server_type__26 = nil;
            end;
            if l__server_type__26 then
                v74 = u2[u3[l__server_type__26]].place_id;
            else
                v74 = nil;
            end;
        end;
        if type(v74) == "number" then
            local v75 = {
                place_id = v74
            };
            if type(p73.job_id) == "string" and p73.job_id ~= "" then
                v75.job_id = p73.job_id;
            end;
            if type(p73.server_type) == "string" and p73.server_type ~= "" then
                v75.server_type = p73.server_type;
            end;
            l__Classes__8._xbe184fb1376a575d:_x7ab8b42cc5920a78("TAPE_MOVE", true);
            l__Packets__3._xd5a9d73c53b4d910:Fire(v75);
        end;
    end;
end;
function u1.Init(u76) --[[ Line: 501 ]]
    -- upvalues: l__Packets__3 (copy)
    local l__main_page__27 = u76.main_page;
    local l__ScrollingFrame__28 = l__main_page__27.Borders.Serverlist.ScrollingFrame;
    u76.trove:Add(l__Packets__3._xe98e3ab9d7e26ed2.OnClientEvent:Connect(function(p77) --[[ Line: 505 ]]
        -- upvalues: u76 (copy)
        if p77.op == "snapshot" then
            u76:onNewSnapshot(p77);
        end;
    end));
    local l__TextButton__29 = l__ScrollingFrame__28.LoadMore.Frame.TextButton;
    local l__RefreshButton__30 = l__main_page__27.Borders.RefreshButton;
    local l__TextButton__31 = l__main_page__27.Borders.RegionFrame.Frame.TextButton;
    local l__TextButton__32 = l__main_page__27.Borders.ServerFrame.Frame.TextButton;
    u76.trove:Add(l__TextButton__29.Activated:Connect(function() --[[ Line: 516 ]]
        -- upvalues: u76 (copy)
        u76:requestLoadMore();
    end));
    u76.trove:Add(l__RefreshButton__30.Activated:Connect(function() --[[ Line: 520 ]]
        -- upvalues: u76 (copy)
        u76:refreshList();
    end));
    u76.trove:Add(l__TextButton__31.Activated:Connect(function() --[[ Line: 524 ]]
        -- upvalues: u76 (copy)
        u76:cycleRegionFilter();
    end));
    u76.trove:Add(l__TextButton__32.Activated:Connect(function() --[[ Line: 528 ]]
        -- upvalues: u76 (copy)
        u76:cycleServerTypeFilter();
    end));
end;
return u1;
