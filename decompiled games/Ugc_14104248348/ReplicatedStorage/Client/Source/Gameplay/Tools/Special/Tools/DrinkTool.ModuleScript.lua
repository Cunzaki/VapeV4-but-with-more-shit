-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Tools.Special.Tools.DrinkTool
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__RunService__3 = game:GetService("RunService");
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Utility__5 = require(l__ReplicatedStorage__1.Modules.Utility);
local l__RotatedRegion3__6 = require(l__ReplicatedStorage__1.Modules.RotatedRegion3);
local u1 = l__Mince__4:Get("Settings");
local u2 = l__Mince__4:Get("Frostbite");
local u3 = l__Mince__4:Get("Intoxication");
local u4 = l__Mince__4:Get("UserProfile");
local u5 = l__Mince__4:Get("ToolHandler");
local u6 = l__Mince__4:Get("NotifPrompt");
l__Mince__4:Get("DrinkHandler");
local u7 = l__Mince__4:Get("PlayerCharacterReplication");
local u8 = l__Mince__4:Get("SelectInteractor");
local u9 = l__Mince__4:GetEvent("InteractDrink");
local u10 = l__Mince__4:GetEvent("ExpireIntent");
local u11 = {
    DrinkingEnabled = true,
    DrinkAnimations = l__Utility__5.CreateFuzzyFinder({
        "Drink",
        "Drink2",
        "Drink3",
        "Drink4"
    }),
    DrinkRandom = Random.new(os.clock()),
    LoadedAnimations = {},
    LastDrink = os.clock() - 3
};
function u11.Update(_) --[[ Line: 36 ]]
    -- upvalues: u11 (copy), l__RotatedRegion3__6 (copy)
    debug.profilebegin("DrinkClient :: UpdateVR (WIP)");
    if u11.HeadTouch and u11.CurrentTool then
        local v12 = u11.CurrentTool:FindFirstChild("Handle");
        if v12 and (l__RotatedRegion3__6.FromPart(u11.HeadTouch):CastPoint(v12.Position) and os.clock() - u11.LastDrink > (u11.CurrentTool:GetAttribute("DrinkCooldown") or 3)) then
            u11.ForceInteractDrink();
        end;
    end;
    debug.profileend();
end;
function u11.ActivateTool() --[[ Line: 52 ]]
    -- upvalues: u11 (copy), u3 (copy)
    if not u11.DrinkingEnabled then
        return "Pass";
    end;
    if not u11.ToolActive then
        return "Pass";
    end;
    local v13 = u11.GetThisDrinkAnimation();
    if not u3:IsPassedOut() and (u11.CurrentTool:GetAttribute("CanDrink") and (not v13.IsPlaying and os.clock() - u11.LastDrink > (u11.CurrentTool:GetAttribute("DrinkCooldown") or 3))) then
        u11.NextDrinkAnimation();
        u11.GetThisDrinkAnimation():Play();
    end;
    return "Pass";
end;
function u11.GetThisDrinkAnimation() --[[ Line: 71 ]]
    -- upvalues: u11 (copy)
    return u11.LoadedDrinkAnimations[u11.CurrentDrinkAnimationIndex];
end;
function u11.NextDrinkAnimation() --[[ Line: 75 ]]
    -- upvalues: u11 (copy)
    u11.CurrentDrinkAnimationIndex = u11.DrinkRandom:NextInteger(1, #u11.LoadedDrinkAnimations);
end;
function u11.ForceInteractDrink() --[[ Line: 79 ]]
    -- upvalues: u11 (copy), u9 (copy), u3 (copy), u2 (copy)
    u11.LastDrink = os.clock();
    u9:Fire();
    local v14 = u11.CurrentTool:GetAttribute("ALCLevel") or 0;
    u3.Consume(v14);
    local v15 = u11.CurrentTool:GetAttribute("FrostLevel") or 0;
    u2.Consume(v15);
end;
function u11.CheckToolAsync(p16) --[[ Line: 91 ]]
    -- upvalues: u4 (copy), l__Mince__4 (copy), u10 (copy), u6 (copy)
    u4:WaitUntilLoaded();
    if p16:GetAttribute("UserCreator") and l__Mince__4.Config.LocalProfile.Intents.FIRST_USE_PLAYER_CREATED then
        u10:Fire("FIRST_USE_PLAYER_CREATED");
        u6.Display("This is a player generated item! Any item that has \'\' is created by players, not us.");
    end;
end;
function u11.StartTool(u17) --[[ Line: 100 ]]
    -- upvalues: l__Mince__4 (copy), u11 (copy), u7 (copy), l__UserInputService__2 (copy), u9 (copy), l__RunService__3 (copy)
    if l__Mince__4.Config.Humanoid then
        u11.ToolActive = true;
        u11.LoadedAnimations = {};
        u11.LoadedDrinkAnimations = {};
        u11.CurrentDrinkAnimationIndex = 1;
        u11.CurrentTool = u17;
        if u17:GetAttribute("EquipHandset") then
            u7.SetHandset(u17:GetAttribute("EquipHandset"));
            u11.ThisToolContainsAHandset = true;
        end;
        for _, v18 in u17:WaitForChild("Animations"):GetChildren() do
            local v19 = l__Mince__4.Config.Humanoid:LoadAnimation(v18);
            u11.LoadedAnimations[v18.Name] = v19;
            if u11.DrinkAnimations[v18.Name] then
                table.insert(u11.LoadedDrinkAnimations, v19);
            end;
        end;
        u11.NextDrinkAnimation();
        if not l__UserInputService__2.VREnabled then
            u11.LoadedAnimations.Idle:Play();
        end;
        for _, v20 in u11.LoadedDrinkAnimations do
            v20:GetMarkerReachedSignal("Drink"):Connect(function() --[[ Line: 133 ]]
                -- upvalues: u11 (ref)
                u11.ForceInteractDrink();
            end);
            v20.Ended:Connect(function() --[[ Line: 137 ]]
                -- upvalues: u17 (copy), u9 (ref)
                if u17:GetAttribute("Uses") == 0 and u17:GetAttribute("ReportUponUsesZero") then
                    u9:Fire();
                end;
            end);
        end;
        task.spawn(u11.CheckToolAsync, u17);
        if l__UserInputService__2.VREnabled and l__Mince__4.Config.Character then
            local l__Head__7 = l__Mince__4.Config.Character:WaitForChild("Head");
            local v21 = Instance.new("Part");
            v21.Transparency = 1;
            v21.Size = Vector3.new(2, 2, 2);
            v21.Parent = l__Head__7;
            v21.Name = "VR HEAD TOUCH";
            v21.CanQuery = true;
            v21.CanTouch = true;
            v21.CanCollide = false;
            u11.HeadTouch = v21;
            local v22 = Instance.new("Motor6D", l__Head__7);
            v22.Part0 = l__Head__7;
            v22.Part1 = v21;
            if u11.UpdateEvent then
                u11.UpdateEvent:Disconnect();
            end;
            u11.UpdateEvent = l__RunService__3.Heartbeat:Connect(function(p23) --[[ Line: 167 ]]
                -- upvalues: u11 (ref)
                u11.Update(p23);
            end);
        end;
    end;
end;
function u11.EndTool() --[[ Line: 173 ]]
    -- upvalues: u11 (copy), u7 (copy)
    u11.ToolActive = false;
    if u11.ThisToolContainsAHandset then
        u7.SetHandset(nil);
        u11.ThisToolContainsAHandset = false;
    end;
    for _, v24 in u11.LoadedAnimations do
        v24:Stop();
    end;
    u11.HeadTouch = nil;
    u11.LoadedAnimations = {};
    if u11.UpdateEvent then
        u11.UpdateEvent:Disconnect();
    end;
end;
function u11.Setup() --[[ Line: 191 ]]
    -- upvalues: u5 (copy), u11 (copy), u8 (copy), u1 (copy)
    local v25 = u5.TagEquipped({ "Drink", "AnimateTool" });
    v25.Equipped:Connect(u11.StartTool);
    v25.Unequipped:Connect(u11.EndTool);
    u8.BindToInteract(100, u11.ActivateTool);
    u1.SettingChanged("Drinking"):Connect(function(p26) --[[ Line: 199 ]]
        -- upvalues: u11 (ref)
        u11.DrinkingEnabled = p26;
    end);
end;
return u11;
