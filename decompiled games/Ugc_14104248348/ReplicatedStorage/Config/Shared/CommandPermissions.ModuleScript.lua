-- Decompiled from: ReplicatedStorage.Config.Shared.CommandPermissions
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Owner = {
        "DefaultUtil",
        "GameAccess",
        "DefaultAdmin",
        "GameElevated",
        "GameAdmin",
        "GameManager",
        "GameOwner",
        "GameBanPermission",
        "ManagePlayerDrinks",
        "JoinFullGaters",
        "BanPlayerNotes",
        "CreateEventServer",
        "EventServerAccess",
        "EventServerKickPermission",
        "EmojiPermission"
    },
    FouledAnchors = {
        "DefaultUtil",
        "GameAccess",
        "DefaultAdmin",
        "GameElevated",
        "GameAdmin",
        "GameManager",
        "GameOwner",
        "GameBanPermission",
        "ManagePlayerDrinks",
        "JoinFullGaters",
        "BanPlayerNotes",
        "CreateEventServer",
        "EventServerAccess",
        "EventServerKickPermission",
        "EmojiPermission"
    },
    Whimsical = {
        "DefaultUtil",
        "GameAccess",
        "DefaultAdmin",
        "GameElevated",
        "GameAdmin",
        "GameManager",
        "GameOwner",
        "GameBanPermission",
        "ManagePlayerDrinks",
        "JoinFullGaters",
        "BanPlayerNotes",
        "CreateEventServer",
        "EventServerAccess",
        "EventServerKickPermission",
        "EmojiPermission"
    },
    Developer = {
        "DefaultUtil",
        "GameAccess",
        "DefaultAdmin",
        "GameElevated",
        "GameAdmin",
        "GameManager",
        "GameOwner",
        "GameBanPermission",
        "ManagePlayerDrinks",
        "JoinFullGaters",
        "BanPlayerNotes",
        "CreateEventServer",
        "EventServerAccess",
        "EventServerKickPermission",
        "EmojiPermission"
    },
    Manager = {
        "DefaultUtil",
        "GameAccess",
        "DefaultAdmin",
        "GameElevated",
        "GameAdmin",
        "GameManager",
        "GameOwner",
        "GameBanPermission",
        "ManagePlayerDrinks",
        "JoinFullGaters",
        "BanPlayerNotes",
        "CreateEventServer",
        "EventServerAccess",
        "EventServerKickPermission"
    },
    Moderator = {
        "ManagePlayerDrinks",
        "JoinFullGaters",
        "BanPlayerNotes",
        "CreateEventServer",
        "EventServerAccess",
        "EventServerKickPermission",
        "GameBanPermission"
    },
    Security = {
        "ManagePlayerDrinks",
        "JoinFullGaters",
        "BanPlayerNotes",
        "EventServerAccess",
        "EventServerKickPermission"
    },
    ["Event Host"] = { "CreateEventServer", "EventServerAccess", "EventServerKickPermission" },
    ["Event Team"] = { "EventServerAccess", "EventServerKickPermission" },
    HasPermission = function(p1, p2, p3) --[[ Name: HasPermission, Line 12 ]]
        if game:GetService("RunService"):IsStudio() then
            return true;
        end;
        local v4 = p1[p2:GetRoleInGroup(game.CreatorId) or "Non-Member"] or {};
        for _, v5 in ipairs(v4) do
            if v5 == p3 then
                return true;
            end;
        end;
    end
};
