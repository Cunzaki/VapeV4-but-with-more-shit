-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Drink.Components.PickupDrink
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__Maid__3 = require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__ModelTweenOG__5 = require(l__ReplicatedStorage__1.Modules.ModelTweenOG);
local u1 = l__Mince__4:GetEvent("PickupDrink");
local u2 = l__Mince__4:Get("SoundHandler");
local u3 = l__Mince__4:Get("DrinkHandler");
local u4 = l__Mince__4:Get("SelectInteractor");
local u5 = l__Mince__4:Get("PlacementHandler");
local u6 = l__Mince__4.Component({
    Tag = "PickupDrink",
    CreationParents = { game.Workspace },
    Bounce = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
});
function u6.ReplicateChangeState(p7, p8) --[[ Line: 24 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), l__RunService__2 (copy), l__ModelTweenOG__5 (copy), u6 (copy)
    if p8 == "GrillMachineGrilling" then
        p7.SoundController:Play("active_grill", p7.HitCollider);
        local v9 = l__ReplicatedStorage__1.Assets.Particles.Smoke:Clone();
        v9.Parent = p7.HitCollider;
        p7.ReplicateMade:Add(v9);
    end;
    if p8 == "GrillMachineBurnt" then
        p7.SoundController:Play("grill_explode", p7.HitCollider);
        for _, v10 in p7.Instance:GetChildren() do
            if v10:IsA("BasePart") and v10.Transparency < 1 then
                v10.Color = Color3.new(0, 0, 0);
            end;
            if v10:IsA("MeshPart") then
                v10.TextureID = "";
            end;
        end;
        for _, v11 in game.ReplicatedStorage.Assets.Particles.GrillFire2:GetChildren() do
            local v12 = v11:Clone();
            v12.Parent = p7.HitCollider;
            p7.ReplicateMade:Add(v12);
        end;
    end;
    if p8 == "Flashing" then
        local u13 = {};
        for _, v14 in p7.Instance:GetChildren() do
            if v14:IsA("BasePart") and v14:GetAttribute("IsFlashingPart") then
                u13[v14] = v14.Color;
            end;
        end;
        local u15 = 0;
        p7.ReplicateMade:Add(l__RunService__2.Heartbeat:Connect(function(p16) --[[ Line: 63 ]]
            -- upvalues: u15 (ref), u13 (copy)
            u15 = u15 + p16;
            if u15 < 0.5 then
            else
                u15 = u15 - 0.5;
                for v17, v18 in u13 do
                    v17.Color = v18:Lerp(Color3.new(0, 0, 0), math.random());
                end;
            end;
        end));
    end;
    if p8 == "FloatingCup" then
        local v19 = l__ModelTweenOG__5.new(p7.Instance, u6.Bounce, p7.Instance:GetPivot():ToWorldSpace(CFrame.new(0, 0.2, 0)));
        v19.Play();
        p7.ReplicateMade:Add(v19);
    end;
    if p8 == "Clear" then
        p7.SoundController:StopAll();
        p7.ReplicateMade:Clean();
    end;
end;
function u6.Removing(p20) --[[ Line: 84 ]]
    -- upvalues: u4 (copy)
    p20.SoundController:Destroy();
    p20.ReplicateMade:Clean();
    u4.CollapseClass(p20);
end;
function u6.Construct(u21) --[[ Line: 90 ]]
    -- upvalues: l__Maid__3 (copy), u2 (copy), u3 (copy), u1 (copy), u6 (copy), u5 (copy), u4 (copy)
    u21.HitCollider = u21.Instance:FindFirstChild("Collider") or u21.Instance:WaitForChild("Handle");
    u21.HoverName = u21.Instance.Name;
    u21.Target = u21.Instance;
    u21.ReplicateMade = l__Maid__3.new();
    u21.Sounds = {};
    u21.SoundController = u2.controller(false);
    u21.SoundController.RollOff = { 5, 45 };
    if u21.UserCreator then
        u21.MetaText = `Created By {u21.UserCreator}`;
    end;
    for _, v22 in u21.Instance:GetChildren() do
        if v22:IsA("BasePart") and v22 ~= u21.HitCollider then
            v22.CanQuery = false;
        end;
    end;
    function u21.OnHover(p23) --[[ Line: 112 ]]
        -- upvalues: u3 (ref)
        local v24 = u3.GetEquippedTool();
        return (v24 and p23.Instance:GetAttribute("UnblockPlacements") or v24 and v24:GetAttribute("PreventPickupsWhileEquipped")) and "Unselect" or true;
    end;
    function u21.Interact(p25, p26) --[[ Line: 121 ]]
        -- upvalues: u1 (ref)
        u1:Fire(p25.Instance);
        p26();
    end;
    if u21.ReplicateState then
        u6.ReplicateChangeState(u21, u21.ReplicateState);
    end;
    u21.Instance:GetAttributeChangedSignal("ReplicateState"):Connect(function() --[[ Line: 127 ]]
        -- upvalues: u6 (ref), u21 (copy)
        u6.ReplicateChangeState(u21, u21.Instance:GetAttribute("ReplicateState"));
    end);
    u21.Instance:GetPropertyChangedSignal("Name"):Connect(function() --[[ Line: 131 ]]
        -- upvalues: u21 (copy), u5 (ref), u4 (ref)
        u21.HoverName = u21.Instance.Name;
        u5.GetNewestToolInformation();
        for _, v27 in u4.GetSelections() do
            if v27 == u21 and v27.CurrentSource then
                v27.CurrentSource:Unselect();
            end;
        end;
    end);
    u4.NewInteractionClass(u21);
end;
return u6;
