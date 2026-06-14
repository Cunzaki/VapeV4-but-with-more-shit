-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.SeatHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
local l__Case__4 = require(l__ReplicatedStorage__1.Modules.Case);
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__5:Get("Emote");
local u2 = l__Mince__5:Get("Intoxication");
local u3 = {
    IsSat = false,
    CanSitCase = l__Case__4.new(),
    ProximityPrompts = {},
    Animations = {}
};
u3.CanSitCase:Extend():Set(true);
function u3.GetSittingState() --[[ Line: 24 ]]
    -- upvalues: u3 (copy)
    return u3.IsSat;
end;
function u3.GetAnimation(p4) --[[ Line: 28 ]]
    -- upvalues: u3 (copy), l__ReplicatedStorage__1 (copy)
    if u3.Animations[p4] then
        return u3.Animations[p4];
    end;
    local v5 = l__ReplicatedStorage__1.Assets.SeatAnimations:FindFirstChild(p4);
    if v5 then
        local v6 = u3.Humanoid:LoadAnimation(v5);
        u3.Animations[p4] = v6;
        return v6;
    end;
end;
function u3.CreateNewSeat(u7) --[[ Line: 42 ]]
    -- upvalues: u3 (copy), u1 (copy), u2 (copy)
    local l__Seat__6 = u7:WaitForChild("Seat", 5);
    if l__Seat__6 then
        l__Seat__6:GetAttributes();
        local function v9() --[[ Line: 48 ]]
            -- upvalues: u3 (ref), u1 (ref), u2 (ref), l__Seat__6 (copy)
            if u3.CanSitCase:GetValue() then
                if u1.IsActive() then
                elseif u2.IsPassedOut() then
                elseif l__Seat__6.Occupant then
                else
                    local v8 = l__Seat__6:GetAttributes();
                    if v8.IntialCFrame then
                        l__Seat__6:PivotTo(v8.IntialCFrame);
                    end;
                    l__Seat__6:Sit(u3.Humanoid);
                    u3.EmoteExtendCase:Set(false);
                end;
            end;
        end;
        local u10 = Instance.new("ProximityPrompt");
        u10:SetAttribute("Type", "Radial");
        u10.ObjectText = "Sit";
        u10.MaxActivationDistance = 5;
        u10.Style = Enum.ProximityPromptStyle.Custom;
        u10.Parent = u7;
        u10.RequiresLineOfSight = false;
        l__Seat__6:GetPropertyChangedSignal("Occupant"):Connect(function() --[[ Line: 70 ]]
            -- upvalues: u3 (ref), u10 (copy), l__Seat__6 (copy), u7 (copy)
            if not u3.IsSat then
                u10.Enabled = l__Seat__6.Occupant == nil;
            end;
            if l__Seat__6.Occupant == u3.Humanoid then
                u3.IsSat = true;
                u3.LastSat = l__Seat__6;
                u3.SetEnabled(false);
                u3.EmoteExtendCase:Set(false);
                local v11 = u7:GetAttribute("Animation") and u3.GetAnimation(u7:GetAttribute("Animation"));
                if v11 then
                    v11:Play(0.25);
                end;
            end;
            if l__Seat__6 == u3.LastSat and l__Seat__6.Occupant == nil then
                for v12, v13 in u3.ProximityPrompts do
                    v13.Enabled = v12.Occupant == nil;
                end;
                u3.IsSat = false;
                u3.EmoteExtendCase:Set(true);
                local v14 = u7:GetAttribute("Animation") and u3.GetAnimation(u7:GetAttribute("Animation"));
                if v14 then
                    v14:Stop();
                end;
            end;
        end);
        u10.TriggerEnded:Connect(v9);
        u3.ProximityPrompts[l__Seat__6] = u10;
    end;
end;
function u3.SetupItem(p15, p16) --[[ Line: 107 ]]
    -- upvalues: l__CollectionService__2 (copy)
    for _, v17 in l__CollectionService__2:GetTagged(p15) do
        task.defer(p16, v17);
    end;
    l__CollectionService__2:GetInstanceAddedSignal(p15):Connect(p16);
end;
function u3.SetEnabled(p18) --[[ Line: 115 ]]
    -- upvalues: u3 (copy)
    for _, v19 in u3.ProximityPrompts do
        v19.Enabled = p18;
    end;
    if not p18 then
        for _, v20 in u3.Animations do
            v20:Stop();
        end;
    end;
end;
function u3.NewCharacter(p21) --[[ Line: 127 ]]
    -- upvalues: u3 (copy)
    local l__Humanoid__7 = p21:WaitForChild("Humanoid");
    l__Humanoid__7.StateChanged:Connect(function(p22) --[[ Line: 129 ]]
        -- upvalues: u3 (ref)
        if p22 == Enum.HumanoidStateType.Seated then
            u3.EmoteExtendCase:Set(true);
        end;
    end);
    l__Humanoid__7.Died:Connect(function() --[[ Line: 135 ]]
        -- upvalues: u3 (ref)
        u3.Humanoid = nil;
    end);
    u3.Animations = {};
    u3.IsSat = false;
    u3.SetEnabled(true);
    u3.Humanoid = l__Humanoid__7;
    u3.EmoteExtendCase:Set(true);
end;
function u3.Setup() --[[ Line: 146 ]]
    -- upvalues: u3 (copy), u1 (copy), l__LocalPlayer__3 (copy)
    u3.EmoteExtendCase = u1.EmoteCase:Extend();
    l__LocalPlayer__3.CharacterAdded:Connect(u3.NewCharacter);
    if l__LocalPlayer__3.Character then
        u3.NewCharacter(l__LocalPlayer__3.Character);
    end;
end;
l__Mince__5.Component({
    Tag = "Seat"
}).Construct = function(p23) --[[ Name: Construct, Line 155 ]]
    -- upvalues: u3 (copy)
    u3.CreateNewSeat(p23.Instance);
end;
return u3;
