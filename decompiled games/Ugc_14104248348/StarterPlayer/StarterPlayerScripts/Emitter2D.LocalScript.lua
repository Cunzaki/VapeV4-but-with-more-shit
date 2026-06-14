-- Decompiled from: StarterPlayer.StarterPlayerScripts.Emitter2D
-- Class: LocalScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local u1 = 0;
local u2 = {};
local u3 = nil;
local function u10(u4, u5) --[[ Line: 25 ]]
    -- upvalues: u1 (ref), u3 (ref)
    if u5.Module:GetAttribute("Enabled") then
        local v6 = u5.EntityList[u4];
        if v6 then
            warn(u5.ClassName .. " client entity for [" .. u4:GetFullName() .. "] already exists (" .. v6.ID .. ")");
            return v6;
        end;
        u1 = u1 + 1;
        local u7 = u5.new();
        u7.ID = u1;
        u5.EntityList[u4] = u7;
        function u7.Deactivate(_) --[[ Line: 42 ]]
            -- upvalues: u3 (ref), u4 (copy), u5 (copy)
            u3(u4, u5);
        end;
        u7.Thread = task.spawn(function() --[[ Line: 46 ]]
            -- upvalues: u5 (copy), u7 (copy), u4 (copy)
            local v8 = u5;
            v8.EntityLoadingCount = v8.EntityLoadingCount + 1;
            u7.Loading = true;
            u7:Initiate(u4);
            u7.Loading = false;
            local v9 = u5;
            v9.EntityLoadingCount = v9.EntityLoadingCount - 1;
        end);
    end;
end;
u3 = function(p11, p12) --[[ Line: 56 ]]
    local v13 = p12.EntityList[p11];
    if v13 then
        p12.EntityList[p11] = nil;
        v13.Disabled = true;
        if coroutine.status(v13.Thread) ~= "dead" then
            task.cancel(v13.Thread);
            v13.Loading = false;
            p12.EntityLoadingCount = p12.EntityLoadingCount - 1;
        end;
        v13:Disable();
    end;
end;
local u14 = u3;
for _, u15 in pairs(script:GetDescendants()) do
    if u15:IsA("ModuleScript") then
        task.spawn(function() --[[ Line: 79 ]]
            -- upvalues: u15 (copy), l__LocalPlayer__2 (copy), l__CollectionService__1 (copy), u10 (ref), u14 (ref), u2 (copy)
            local l__Name__3 = u15.Name;
            if u15:GetAttribute("Require_UserId") then
                l__Name__3 = l__Name__3 .. "_" .. l__LocalPlayer__2.UserId;
            end;
            local u16 = require(u15);
            u16.Module = u15;
            u16.ClassName = l__Name__3;
            u16.EntityList = {};
            u16.EntityCount = 0;
            u16.EntityLoadingCount = 0;
            l__CollectionService__1:GetInstanceAddedSignal(l__Name__3):Connect(function(p17) --[[ Line: 101 ]]
                -- upvalues: u10 (ref), u16 (copy)
                u10(p17, u16);
            end);
            l__CollectionService__1:GetInstanceRemovedSignal(l__Name__3):Connect(function(p18) --[[ Line: 105 ]]
                -- upvalues: u14 (ref), u16 (copy)
                u14(p18, u16);
            end);
            if u15:GetAttribute("Asynchronous") then
                for _, v19 in pairs(l__CollectionService__1:GetTagged(l__Name__3)) do
                    u10(v19, u16);
                end;
            else
                for _, v20 in pairs(l__CollectionService__1:GetTagged(l__Name__3)) do
                    task.spawn(u10, v20, u16);
                end;
            end;
            u15:GetAttributeChangedSignal("Enabled"):Connect(function() --[[ Line: 119 ]]
                -- upvalues: u15 (ref), l__CollectionService__1 (ref), l__Name__3 (ref), u10 (ref), u16 (copy), u14 (ref)
                if u15:GetAttribute("Enabled") then
                    for _, v21 in pairs(l__CollectionService__1:GetTagged(l__Name__3)) do
                        task.spawn(u10, v21, u16);
                    end;
                else
                    for _, v22 in pairs(l__CollectionService__1:GetTagged(l__Name__3)) do
                        task.spawn(u14, v22, u16);
                    end;
                end;
            end);
            u2[l__Name__3] = u16;
        end);
    end;
end;
