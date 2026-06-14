-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.BadgeData
-- Class: ModuleScript
-- Place: Ugc (126691165749976)

-- Decompiled with Potassium's decompiler.

local _ = game:GetService("ReplicatedStorage").Assets.ModuleScripts;
local l__LocalPlayer__1 = game.Players.LocalPlayer;
local function v3(p1) --[[ Line: 4 ]]
    local v2 = {};
    if p1.asset_name then
        v2.asset_name = p1.asset_name;
        v2.interactable = p1.interactable or false;
        v2.onInteract = p1.onInteract or function() --[[ Line: 11 ]] end;
        v2.clientPredicate = p1.clientPredicate;
        v2.tooltip = p1.tooltip;
        return v2;
    end;
    warn("NO ASSET NAME FOR BADGE : ", p1);
end;
return {
    Friend = v3({
        asset_name = "FriendBadge",
        interactable = false,
        clientPredicate = function(p4) --[[ Name: clientPredicate, Line 24 ]]
            -- upvalues: l__LocalPlayer__1 (copy)
            return p4:IsFriendsWithAsync(l__LocalPlayer__1.UserId);
        end
    }),
    Premium = v3({
        asset_name = "PremiumBadge",
        interactable = false,
        clientPredicate = function(p5) --[[ Name: clientPredicate, Line 31 ]]
            return p5.HasRobloxSubscription;
        end
    }),
    Star = v3({
        asset_name = "StarBadge",
        interactable = false,
        clientPredicate = function(p6) --[[ Name: clientPredicate, Line 38 ]]
            return p6:IsInGroupAsync(4199740);
        end
    }),
    Dev = v3({
        asset_name = "DevBadge",
        interactable = false,
        clientPredicate = function(p7) --[[ Name: clientPredicate, Line 45 ]]
            return p7.UserId == 72929869;
        end
    })
};
