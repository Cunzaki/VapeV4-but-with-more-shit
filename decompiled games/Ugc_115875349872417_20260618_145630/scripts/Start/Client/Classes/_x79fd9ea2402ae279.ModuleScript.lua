-- Decompiled from: Start.Client.Classes._x79fd9ea2402ae279
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__ModuleScripts__2 = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__Packets__3 = require(l__ModuleScripts__2.Packets);
local l__Trove__4 = require(l__ModuleScripts__2.Trove);
local u1 = {};
u1.__index = u1;
local l__Classes__5 = require(script.Parent.Parent.ClientRoot).Classes;
local l__InternalSymbols__6 = require(script.Parent.Parent.InternalSymbols);
function u1._x90d4581ac99dd483() --[[ Line: 17 ]]
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._xbd3d0268a280c124 = {};
    v2._x970206ebb8c0860b = false;
    return v2;
end;
function u1._x2b5ed2174747324a(_, p3, p4) --[[ Line: 26 ]]
    -- upvalues: l__TweenService__1 (copy)
    if p3 then
        if p4.objective_text then
            p3.Main.ObjectiveLabel.Text = p4.objective_text;
        end;
        if p4.progress_text and p3.Main.ProgressLabel then
            p3.Main.ProgressLabel.Text = p4.progress_text;
        end;
        if p4.progress_fill and p3.Main.Progress.Frame then
            l__TweenService__1:Create(p3.Main.Progress.Frame, TweenInfo.new(0.33, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(p4.progress_fill, 1)
            }):Play();
        end;
    end;
end;
function u1._x19c9a1da1329eb24(u5, u6) --[[ Line: 46 ]]
    -- upvalues: l__Classes__5 (copy), l__InternalSymbols__6 (copy)
    local v7 = l__Classes__5._xd0d75b75975ea69f:_xb6b5eb80e16aa458();
    if not v7 then
        return nil, nil;
    end;
    local v8 = u5._xbd3d0268a280c124[u6.id];
    local l__owner__7 = l__InternalSymbols__6.owner;
    local v9 = "";
    local v10;
    if v8 then
        v10 = v8.side_notif;
    else
        v10 = v8;
    end;
    local v11 = l__owner__7(v9, v10);
    local l__payload__8 = u6.payload;
    if not l__payload__8 then
        return nil, nil;
    end;
    if v8 and (v11 and (v11:_xb12f917d3f269459() and v11._x0da22addcae663b5 == v7)) then
        return v11, v8.goal_asset;
    end;
    local u12 = l__InternalSymbols__6.owner("", l__Classes__5._xd0d75b75975ea69f:_x54f11bcb5880e791({
        play_sound = false,
        lifetime = l__payload__8.notif_appearance == "Persistent" and -1 or 5,
        Reactive = l__payload__8.notif_appearance == "Reactive",
        members = {
            {
                kind = "Header",
                args = { l__payload__8.header_text, l__payload__8.icon_name, l__payload__8.icon_color }
            }
        }
    }));
    u12._xbd519c918208ce0e:Add(function() --[[ Line: 82 ]]
        -- upvalues: u5 (copy), u6 (copy), u12 (copy)
        local v13 = u5._xbd3d0268a280c124[u6.id];
        if v13 and v13.side_notif == u12 then
            v13.visible = false;
            v13.side_notif = nil;
            v13.goal_asset = nil;
        end;
    end;
    local v14 = nil;
    if l__payload__8.notif_type == "Goal" then
        local v15;
        v15, v14 = u12:_x0624adee72df345e();
        _ = v15;
    elseif l__payload__8.notif_type == "GoalTracker" then
        local v16;
        v16, v14 = u12:_x7ff26cd44b4789c4();
        _ = v16;
    end;
    if not v14 then
        warn("ObjectiveClient: unknown notif_type \'" .. tostring(l__payload__8.notif_type) .. "\' for id " .. tostring(u6.id));
        return u12, nil;
    end;
    if v8 then
        v8.latest_full = u6;
        v8.side_notif = u12;
        v8.goal_asset = v14;
        v8.visible = true;
    end;
    u5:_x2b5ed2174747324a(v14, l__payload__8);
    return u12, v14;
end;
function u1._x81bbebccf58cd0d1(u17, u18) --[[ Line: 115 ]]
    -- upvalues: l__Trove__4 (copy), l__Classes__5 (copy)
    local v19 = {
        latest_full = u18,
        trove = l__Trove__4.new(),
        is_completing = false
    };
    v19.trove:Connect(l__Classes__5._xd0d75b75975ea69f._x3ea326512e2ff25c, function(_) --[[ Line: 121 ]]
        -- upvalues: u17 (copy), u18 (copy)
        local v20 = u17._xbd3d0268a280c124[u18.id];
        if v20 then
            if v20.is_completing then
            elseif v20.latest_full and v20.latest_full.payload then
                if v20.latest_full.payload.notif_appearance == "Reactive" then
                else
                    u17:_x19c9a1da1329eb24(v20.latest_full);
                end;
            end;
        end;
    end;
    u17._xbd3d0268a280c124[u18.id] = v19;
    if u18.payload and u18.payload.notif_appearance ~= "Reactive" then
        u17:_x19c9a1da1329eb24(u18);
    end;
end;
function u1._x0485033edd4d744d(p21, p22, p23) --[[ Line: 142 ]]
    -- upvalues: l__InternalSymbols__6 (copy)
    local v24 = p21._xbd3d0268a280c124[p22];
    if v24 then
        v24.latest_full.payload = p23;
        local v25, v26 = p21:_x19c9a1da1329eb24(v24.latest_full);
        local v27 = l__InternalSymbols__6.owner("", v25);
        p21:_x2b5ed2174747324a(v26, p23);
        if p23.notif_appearance == "Reactive" and v27 then
            v27:_x1347724e25e65f68(5);
        end;
    end;
end;
function u1._xe1623c0a4e5a7dda(p28, p29, p30) --[[ Line: 156 ]]
    -- upvalues: l__Classes__5 (copy), l__TweenService__1 (copy)
    local v31 = p28._xbd3d0268a280c124[p29];
    if v31 then
        v31.is_completing = true;
        v31.trove:Clean();
        if not p30 then
            l__Classes__5._xbe184fb1376a575d:_x7ab8b42cc5920a78("GOAL_COMPLETE", true);
        end;
        local l__goal_asset__9 = v31.goal_asset;
        local l__side_notif__10 = v31.side_notif;
        if l__goal_asset__9 then
            local l__CompleteImage__11 = l__goal_asset__9.Main.CompleteImage;
            local l__CompleteFlash__12 = l__goal_asset__9.Main.CompleteFlash;
            l__CompleteImage__11.Visible = true;
            l__TweenService__1:Create(l__CompleteImage__11.Outward, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(5, 5)
            }):Play();
            l__TweenService__1:Create(l__CompleteImage__11.Outward, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
            l__CompleteFlash__12.BackgroundTransparency = 0;
            l__TweenService__1:Create(l__CompleteFlash__12, TweenInfo.new(0.83, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            }):Play();
            l__TweenService__1:Create(l__CompleteFlash__12, TweenInfo.new(0.83, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(2, 1)
            }):Play();
        end;
        task.delay(5, function() --[[ Line: 183 ]]
            -- upvalues: l__side_notif__10 (copy)
            if l__side_notif__10 then
                pcall(function() --[[ Line: 185 ]]
                    -- upvalues: l__side_notif__10 (ref)
                    l__side_notif__10:close();
                end;
            end;
        end;
    end;
end;
function u1._x186af26e0a54ffc8(p32, p33) --[[ Line: 192 ]]
    local v34 = p32._xbd3d0268a280c124[p33];
    if v34 then
        v34.trove:Clean();
        local l__side_notif__13 = v34.side_notif;
        if l__side_notif__13 then
            pcall(function() --[[ Line: 200 ]]
                -- upvalues: l__side_notif__13 (copy)
                l__side_notif__13:close();
            end;
        end;
        p32._xbd3d0268a280c124[p33] = nil;
    end;
end;
function u1._xe53615d96cf36a6b(u35) --[[ Line: 208 ]]
    -- upvalues: l__Packets__3 (copy)
    l__Packets__3._x43501f4d2e65af28.OnClientEvent:Connect(function(p36) --[[ Line: 209 ]]
        -- upvalues: u35 (copy)
        if p36.op == "update" then
            if u35._xbd3d0268a280c124[p36.id] then
                u35:_x0485033edd4d744d(p36.id, p36.payload);
                return;
            end;
            u35:_x81bbebccf58cd0d1(p36);
            if p36.payload and p36.payload.notif_appearance == "Reactive" then
                u35:_x0485033edd4d744d(p36.id, p36.payload);
            end;
        else
            if p36.op == "complete" then
                if p36.silence == true and u35._x970206ebb8c0860b then
                    return;
                else
                    if u35._xbd3d0268a280c124[p36.id] then
                        if p36.payload then
                            u35:_x0485033edd4d744d(p36.id, p36.payload);
                        end;
                    else
                        if not p36.payload then
                            return;
                        end;
                        u35:_x81bbebccf58cd0d1({
                            id = p36.id,
                            key = p36.key,
                            payload = p36.payload
                        });
                        u35:_x0485033edd4d744d(p36.id, p36.payload);
                    end;
                    u35:_xe1623c0a4e5a7dda(p36.id, p36.silence);
                    return;
                end;
            end;
            if p36.op == "destroy" then
                if not u35._xbd3d0268a280c124[p36.id] then
                    return;
                end;
                u35:_x186af26e0a54ffc8(p36.id);
            end;
        end;
    end;
end;
return u1;
