-- Decompiled from: ReplicatedStorage.Modules.InstanceCache
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
function u1.new(p2, p3) --[[ Line: 4 ]]
    -- upvalues: u1 (copy)
    local v4 = setmetatable({}, u1);
    v4:Init(p2, p3);
    return v4;
end;
function u1.Init(p5, p6, p7) --[[ Line: 10 ]]
    p5.CacheItems = {};
    p5.OriginalItem = p7:Clone();
    p5.OriginalParent = p5.OriginalItem.Parent;
    for _ = 1, p6 do
        p5:InsertCacheCopy();
    end;
end;
function u1.InsertCacheCopy(u8, p9, p10) --[[ Line: 20 ]]
    local v11 = u8.OriginalItem:Clone();
    v11.Parent = p10 or u8.OriginalParent;
    local u12 = {
        Used = false,
        Item = v11
    };
    v11.AncestryChanged:Connect(function(_, p13) --[[ Line: 29 ]]
        -- upvalues: u8 (copy), u12 (copy)
        if not p13 then
            u8:RemoveDestroyedItem(u12);
        end;
    end);
    if p9 then
        u12.Used = p9;
    end;
    table.insert(u8.CacheItems, u12);
    return u12;
end;
function u1.Get(p14, p15) --[[ Line: 46 ]]
    for _, v16 in ipairs(p14.CacheItems) do
        if not v16.Used then
            v16.Item.Parent = p15;
            v16.Used = true;
            return v16.Item;
        end;
    end;
    return p14:InsertCacheCopy(true, p15).Item;
end;
function u1.Free(p17, p18) --[[ Line: 58 ]]
    for _, v19 in ipairs(p17.CacheItems) do
        if v19.Item == p18 then
            v19.Used = false;
            return;
        end;
    end;
    error("This Instance does not belong to this cache. Therefore it cannot be freed!");
end;
function u1.RemoveDestroyedItem(p20, p21) --[[ Line: 69 ]]
    for v22, v23 in ipairs(p20.CacheItems) do
        if v23 == p21 then
            table.remove(p20.CacheItems, v22);
            return;
        end;
    end;
end;
return u1;
