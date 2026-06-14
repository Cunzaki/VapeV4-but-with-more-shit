-- Decompiled from: ReplicatedStorage.Client.Source.Cmdr.Cmdr
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__TextChatService__4 = game:GetService("TextChatService");
local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
local l__Mince__6 = require(l__ReplicatedStorage__3.Modules.Mince);
local l__CmdrClient__7 = require(l__ReplicatedStorage__3:WaitForChild("CmdrClient"));
l__Mince__6:Get("BindManager");
return {
    Setup = function() --[[ Name: Setup, Line 18 ]]
        -- upvalues: l__LocalPlayer__5 (copy), l__CmdrClient__7 (copy), l__RunService__2 (copy), l__TextChatService__4 (copy)
        local u1 = l__LocalPlayer__5:GetRoleInGroup(game.CreatorId) or "NonMember";
        l__CmdrClient__7:SetActivationKeys({});
        l__CmdrClient__7:SetHideOnLostFocus(false);
        if l__RunService__2:IsStudio() then
            l__CmdrClient__7:SetActivationKeys({ Enum.KeyCode.F2 });
        else
            l__CmdrClient__7:SetActivationKeys({ Enum.KeyCode.F3 });
        end;
        l__LocalPlayer__5.Chatted:Connect(function(p2) --[[ Line: 29 ]]
            -- upvalues: u1 (copy), l__CmdrClient__7 (ref)
            if p2 == "::cmdr" and u1 ~= "NonMember" then
                l__CmdrClient__7:Show();
            end;
        end);
        l__TextChatService__4.GameCommands.ServerList.Triggered:Connect(function() --[[ Line: 37 ]]
            warn("---->");
        end);
    end
};
