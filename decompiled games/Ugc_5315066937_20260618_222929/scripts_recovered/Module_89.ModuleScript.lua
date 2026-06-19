-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local v1 = l__obtain__1("Signal");
local u2 = l__obtain__1("Remote");
local l__LocalPlayer__2 = l__obtain__1("PlayerManager").LocalPlayer;
local u3 = v1();
local u4 = v1();
local u5 = {};
return {
    Init = function() --[[ Name: Init, Line 15 ]]
        -- upvalues: l__LocalPlayer__2 (copy), u3 (copy), u2 (copy), u5 (copy), u4 (copy)
        local v6 = l__LocalPlayer__2:GetRankInGroup(2607715);
        if not v6 or v6 < 145 then
            return false;
        end;
        u3:Call();
        u2.Add("SetUserStatus", function(p7, p8) --[[ Line: 22 ]]
            -- upvalues: u5 (ref), u4 (ref)
            u5[p7] = p8;
            u4:Call(p7, p8);
        end);
        u2.Call("GetUserStatuses");
    end,
    ApprovalStatus = u5,
    ShowModerationSignal = u3,
    UserStatusChanged = u4
};
