-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.chrono.Shared.ApplyMounts
-- Class: ModuleScript
-- Place: Ugc (126691165749976)

-- Decompiled with Potassium's decompiler.

local l__Entity__1 = require(script.Parent.Entity);
local l__Events__2 = require(script.Parent.Events);
local l__Holder__3 = require(script.Parent.Holder);
require(script.Parent.Types);
local u1 = 0;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {};
local function u16(p6) --[[ Line: 14 ]]
    -- upvalues: u1 (ref), u3 (copy), u4 (copy), u2 (copy), l__Entity__1 (copy), l__Holder__3 (copy), u5 (copy)
    local v7 = u1;
    if u3[p6] == v7 then
        return u4[p6];
    end;
    local _ = CFrame.identity;
    local v8 = p6;
    local v9 = 0;
    local v10;
    while true do
        if u3[p6] == v7 then
            v10 = u4[p6];
            break;
        end;
        if u2[p6] == v7 then
            v10 = l__Entity__1.GetAt(p6, l__Entity__1.GetTargetRenderTime(p6)) or (p6.latestCFrame or CFrame.identity);
            u3[p6] = v7;
            u4[p6] = v10;
            l__Entity__1._SetPartCFrame(p6, v10);
            break;
        end;
        u2[p6] = v7;
        local l__mountParentId__4 = p6.mountParentId;
        if not l__mountParentId__4 then
            if p6.isContextOwner then
                local v11 = l__Entity__1.GetPrimaryPart(p6);
                if v11 then
                    v10 = v11.CFrame;
                else
                    v10 = p6.latestCFrame or CFrame.identity;
                end;
            else
                v10 = l__Entity__1.GetAt(p6, l__Entity__1.GetTargetRenderTime(p6)) or (p6.latestCFrame or CFrame.identity);
                l__Entity__1._SetPartCFrame(p6, v10);
            end;
            u3[p6] = v7;
            u4[p6] = v10;
            break;
        end;
        local v12 = l__Holder__3.GetEntityFromId(l__mountParentId__4);
        if not v12 or v12.destroyed then
            v10 = l__Entity__1.GetAt(p6, l__Entity__1.GetTargetRenderTime(p6)) or (p6.latestCFrame or CFrame.identity);
            u3[p6] = v7;
            u4[p6] = v10;
            l__Entity__1._SetPartCFrame(p6, v10);
            break;
        end;
        v9 = v9 + 1;
        u5[v9] = p6;
        p6 = v12;
    end;
    local v13 = v10 or CFrame.identity;
    for v14 = v9, 1, -1 do
        local v15 = u5[v14];
        v13 = v13 * (v15.mountOffset or CFrame.identity);
        u3[v15] = v7;
        u4[v15] = v13;
        l__Entity__1._SetPartCFrame(v15, v13);
        u5[v14] = nil;
    end;
    if u3[v8] ~= v7 then
        u3[v8] = v7;
        u4[v8] = v13;
        l__Entity__1._SetPartCFrame(v8, v13);
    end;
    return u4[v8];
end;
l__Events__2.EntityRemoved:Connect(function(p17) --[[ Line: 94 ]]
    -- upvalues: u3 (copy), u4 (copy)
    u3[p17] = nil;
    u4[p17] = nil;
end);
return function() --[[ Line: 99 ]]
    -- upvalues: l__Holder__3 (copy), u3 (copy), u1 (ref), u16 (copy), l__Entity__1 (copy), u4 (copy)
    local v18 = {};
    for _, v19 in l__Holder__3.idMap do
        if not v19.destroyed and (v19.mountParentId and u3[v19] ~= u1) then
            v18[v19.mountParentId] = true;
            u16(v19);
        end;
    end;
    u1 = u1 + 1;
    for _, v20 in l__Holder__3.idMap do
        if not v20.destroyed and (not v20.mountParentId and v18[v20.id]) then
            if v20.isContextOwner then
                u3[v20] = u1;
                local v21 = l__Entity__1.GetPrimaryPart(v20);
                local v22 = u4;
                local v23;
                if v21 then
                    v23 = v21.CFrame;
                else
                    v23 = v20.latestCFrame or CFrame.identity;
                end;
                v22[v20] = v23;
            else
                local v24 = l__Entity__1.GetAt(v20, l__Entity__1.GetTargetRenderTime(v20)) or v20.latestCFrame;
                if v24 then
                    u3[v20] = u1;
                    u4[v20] = v24;
                end;
            end;
        end;
    end;
end;
