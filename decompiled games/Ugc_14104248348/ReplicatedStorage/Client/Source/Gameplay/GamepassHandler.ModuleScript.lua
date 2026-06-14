-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.GamepassHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__MarketplaceService__1 = game:GetService("MarketplaceService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
local l__Mince__4 = require(l__ReplicatedStorage__2.Modules.Mince);
local l__Signal__5 = require(l__ReplicatedStorage__2.Modules.Signal);
local u1 = l__Mince__4:Get("UserProfile");
local u2 = {
    GamepassOwnershipChanged = l__Signal__5.new(),
    LocalOwned = {},
    LookupIDByName = {},
    LookupNameByID = {},
    CachedSignals = {}
};
function u2.UponOwning(_, p3, p4) --[[ Line: 21 ]]
    -- upvalues: u2 (copy)
    if u2:PlayerOwnsGamepass(p3) then
        p4();
    else
        u2:GetGamepassOwnershipChangedSignal(p3):ConnectOnce(p4);
    end;
end;
function u2.GetGamepassOwnershipChangedSignal(_, u5) --[[ Line: 29 ]]
    -- upvalues: u2 (copy), l__Signal__5 (copy)
    if u2.CachedSignals[u5] then
        return u2.CachedSignals[u5];
    end;
    local u6 = l__Signal__5.new();
    u2.GamepassOwnershipChanged:Connect(function(p7) --[[ Line: 35 ]]
        -- upvalues: u5 (copy), u6 (copy)
        if p7 == u5 then
            u6:Fire();
        end;
    end);
    u2.CachedSignals[u5] = u6;
    return u6;
end;
function u2.CheckIfPlayerOwnsGamepass(_, p8) --[[ Line: 46 ]]
    -- upvalues: l__Mince__4 (copy), u2 (copy), l__MarketplaceService__1 (copy), l__LocalPlayer__3 (copy)
    local u9 = l__Mince__4.Config.Products.Gamepasses[p8];
    if u9 then
        if u2.LocalOwned[p8] then
        else
            local v10, v11 = pcall(function() --[[ Line: 56 ]]
                -- upvalues: l__MarketplaceService__1 (ref), l__LocalPlayer__3 (ref), u9 (copy)
                return l__MarketplaceService__1:UserOwnsGamePassAsync(l__LocalPlayer__3.UserId, u9.ID);
            end);
            if v10 and v11 then
                u2:SetGamepassOwnership(p8);
            end;
        end;
    else
        print((`There is no gamepass by the name of '{p8}'. CheckIfPlayerOwnsGamepass() will not work`));
    end;
end;
function u2.PlayerOwnsGamepass(_, p12) --[[ Line: 65 ]]
    -- upvalues: u2 (copy)
    if not u2.LocalOwned[p12] then
        u2:CheckIfPlayerOwnsGamepass(p12);
    end;
    return u2.LocalOwned[p12];
end;
function u2.SetGamepassOwnership(_, p13) --[[ Line: 71 ]]
    -- upvalues: u2 (copy)
    if not u2.LocalOwned[p13] then
        u2.GamepassOwnershipChanged:Fire(p13);
    end;
    u2.LocalOwned[p13] = true;
end;
function u2.GetGamepassNameFromID(_, p14) --[[ Line: 79 ]]
    -- upvalues: u2 (copy)
    return u2.LookupNameByID[p14];
end;
function u2.GetGamepassIDFromName(_, p15) --[[ Line: 83 ]]
    -- upvalues: u2 (copy)
    return u2.LookupIDByName[p15];
end;
function u2.Setup(_) --[[ Line: 87 ]]
    -- upvalues: u1 (copy), u2 (copy), l__MarketplaceService__1 (copy), l__Mince__4 (copy)
    u1.Upon("GamepassOwnership", function(p16) --[[ Line: 88 ]]
        -- upvalues: u2 (ref)
        for v17, _ in p16 do
            u2:SetGamepassOwnership(v17);
        end;
    end);
    l__MarketplaceService__1.PromptGamePassPurchaseFinished:Connect(function(_, p18, p19) --[[ Line: 94 ]]
        -- upvalues: u2 (ref)
        if p19 then
            local v20 = u2.LookupNameByID[p18];
            if v20 then
                u2:SetGamepassOwnership(v20);
            end;
        end;
    end);
    for v21, v22 in l__Mince__4.Config.Products.Gamepasses do
        v22.Name = v21;
        u2.LookupNameByID[v22.ID] = v22.Name;
        u2.LookupIDByName[v22.Name] = v22.ID;
    end;
end;
return u2;
