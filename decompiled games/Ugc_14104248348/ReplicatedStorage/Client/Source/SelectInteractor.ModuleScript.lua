-- Decompiled from: ReplicatedStorage.Client.Source.SelectInteractor
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__UserInputService__1 = game:GetService("UserInputService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__StarterPlayer__3 = game:GetService("StarterPlayer");
local l__RunService__4 = game:GetService("RunService");
local l__StarterGui__5 = game:GetService("StarterGui");
local l__Players__6 = game:GetService("Players");
local l__Workspace__7 = game:GetService("Workspace");
local l__HapticService__8 = game:GetService("HapticService");
local l__LocalPlayer__9 = l__Players__6.LocalPlayer;
local u1 = l__LocalPlayer__9:GetMouse();
local l__Mince__10 = require(l__ReplicatedStorage__2.Modules.Mince);
local l__Signal__11 = require(l__ReplicatedStorage__2.Modules.Signal);
local l__Utility__12 = require(l__ReplicatedStorage__2.Modules.Utility);
local u2 = l__Mince__10:Get("Highlight");
local u3 = l__Mince__10:Get("BindManager");
local u4 = l__Mince__10:Get("InterfaceHandler");
local u5 = l__Mince__10:Get("Settings");
local u6 = {};
local u8 = {
    InteractionActive = false,
    InteractionIsReadyToRegister = false,
    DontUseReachBased = true,
    ReachDistance = 0.25,
    DefaultReachDistance = 0.25,
    InteractionBindings = {},
    InteractionSources = {},
    InteractionReady = l__Signal__11.new(),
    InteractionHitColliderLookup = {},
    InteractionHitColliders = {},
    InteractionClassProtoType = {
        HoverName = "InteractionClass.HoverName",
        Interact = function(_, p7) --[[ Name: Interact, Line 70 ]]
            warn("InteractionClass:Interact()");
            p7();
        end
    },
    SelectionEnded = l__Signal__11.new(),
    SelectionBegin = l__Signal__11.new(),
    AssistedReachDistance = {
        Mobile = 0.3,
        Computer = 0.25,
        VR = 0.3,
        Console = 0.35
    },
    ForceAssitedReach = l__UserInputService__1.TouchEnabled or l__UserInputService__1.VREnabled,
    CONSTANTS = {
        MAX_CHARACTER_DISTANCE = 10,
        MAX_DISTANCE = l__StarterPlayer__3.CameraMaxZoomDistance + 3,
        HAND_POSITION_INPUTS = {
            RightHand = {
                AttachmentName = "RightGripAttachment",
                BindName = "VRRightHandInteract",
                Key = Enum.UserCFrame.RightHand,
                HapticMotor = Enum.VibrationMotor.RightHand
            },
            LeftHand = {
                AttachmentName = "LeftGripAttachment",
                BindName = "VRLeftHandInteract",
                Key = Enum.UserCFrame.LeftHand,
                HapticMotor = Enum.VibrationMotor.LeftHand
            }
        },
        VALID_INTERACTION_RESULTS = l__Utility__12.CreateFuzzyFinder({ "Sink", "Pass" })
    }
};
local l__CONSTANTS__13 = u8.CONSTANTS;
function u6.ShowInspectInWorldSpace(p9) --[[ Line: 117 ]]
    -- upvalues: l__Workspace__7 (copy), l__Players__6 (copy)
    p9.ShowsInspectAtMousePosition = false;
    if p9.InspectWorldPart then
        p9.InspectWorldPart:Destroy();
        p9.InspectWorldPart = nil;
    end;
    if p9.InspectWorldBillboardGui then
        p9.InspectWorldBillboardGui:Destroy();
        p9.InspectWorldBillboardGui = nil;
    end;
    local v10 = Instance.new("Part");
    v10.Name = "InspectWorldSpace" .. tostring(p9.Key);
    v10.Transparency = 1;
    v10.Anchored = true;
    v10.CanCollide = false;
    v10.CanQuery = false;
    v10.Size = Vector3.new(0.2, 0.2, 0.2);
    v10.Parent = l__Workspace__7.CurrentCamera;
    p9.InspectWorldPart = v10;
    local v11 = Instance.new("BillboardGui");
    v11.Name = "InspectWorldSpace" .. tostring(p9.Key);
    v11.Size = UDim2.new(0, 500, 0, 100);
    v11.AlwaysOnTop = true;
    v11.ResetOnSpawn = false;
    v11.Adornee = v10;
    v11.Parent = l__Players__6.LocalPlayer:WaitForChild("PlayerGui");
    p9.InspectWorldBillboardGui = v11;
    p9.Inspect.Parent = v11;
    p9.Inspect.Position = UDim2.new(0.5, 0, 0.5, 0);
end;
function u6.ConnectBind(u12, p13) --[[ Line: 153 ]]
    -- upvalues: u3 (copy)
    u12.CustomBindingActive = true;
    u3.Get(p13).OnAction:Connect(function(p14) --[[ Line: 155 ]]
        -- upvalues: u12 (copy)
        if p14 == Enum.UserInputState.Begin then
            if u12.InteractionActive then
                return;
            end;
            if not u12.CurrentSelection then
                return;
            end;
            u12:BeginInteractionWithSelection();
        end;
    end);
end;
function u6.SelectNew(u15, p16) --[[ Line: 164 ]]
    -- upvalues: l__HapticService__8 (copy), u8 (copy)
    if u15.CurrentSelection ~= p16 then
        u15.CurrentSelection = p16;
        p16.CurrentSource = u15;
        u15.Inspect.Visible = true;
        u15.Inspect.TextLabel.Text = p16.HoverName;
        if p16.MetaText then
            u15.Inspect.TextLabel.MetaLabel.Text = p16.MetaText;
        else
            u15.Inspect.TextLabel.MetaLabel.Text = "";
        end;
        u15.Highlight:Set(p16.Target or p16.HitCollider);
        if u15.HapticMotor then
            local u17 = tick();
            u15.HapticMotorLastStartTime = u17;
            l__HapticService__8:SetMotor(Enum.UserInputType.Gamepad1, u15.HapticMotor, u15.HapticMotorIntensity);
            task.delay(u15.HapticMotorDuration, function() --[[ Line: 188 ]]
                -- upvalues: u15 (copy), u17 (copy), l__HapticService__8 (ref)
                if u15.HapticMotorLastStartTime == u17 then
                    l__HapticService__8:SetMotor(Enum.UserInputType.Gamepad1, u15.HapticMotor, 0);
                end;
            end);
        end;
        u8.SelectionBegin:Fire(u15.CurrentSelection);
    end;
    u15:RemoveInvalidation();
end;
function u6.Unselect(p18) --[[ Line: 201 ]]
    -- upvalues: u8 (copy)
    if p18.CurrentSelection then
        p18.Highlight:Clear();
        p18.Inspect.Visible = false;
        p18.CurrentSelection.CurrentSource = nil;
        u8.SelectionEnded:Fire(p18.CurrentSelection);
        p18.CurrentSelection = nil;
    end;
    p18:RemoveInvalidation();
end;
function u6.RemoveInvalidation(p19) --[[ Line: 215 ]]
    -- upvalues: u1 (copy)
    if p19.SelectionWasInvalid then
        u1.Icon = "";
        p19.SelectionWasInvalid = nil;
    end;
end;
function u6.InvalidSelection(p20) --[[ Line: 223 ]]
    -- upvalues: u1 (copy)
    if not p20.SelectionWasInvalid then
        u1.Icon = "rbxassetid://14122618737";
        p20.SelectionWasInvalid = true;
    end;
end;
function u6.BeginInteractionWithSelection(p21) --[[ Line: 230 ]]
    -- upvalues: u8 (copy)
    local l__CurrentSelection__14 = p21.CurrentSelection;
    p21:Unselect();
    p21.InteractionActive = true;
    u8.CheckInteractionStatus();
    l__CurrentSelection__14:Interact(p21.EndThisInteraction, p21.Key);
end;
function u6.EndInteraction(p22) --[[ Line: 242 ]]
    -- upvalues: u8 (copy)
    p22.InteractionActive = false;
    u8.CheckInteractionStatus();
end;
function u8.AddInteractionSource(p23, p24) --[[ Line: 249 ]]
    -- upvalues: u6 (copy), l__ReplicatedStorage__2 (copy), u8 (copy), u2 (copy)
    local v25 = type(p24) == "function";
    assert(v25, "Expected GetPointVectors to be a function");
    local u26 = setmetatable({
        ShowsInspectAtMousePosition = true,
        CustomBindingActive = false,
        HapticMotorIntensity = 1,
        HapticMotorDuration = 0.1,
        Key = p23,
        HapticMotor = Enum.VibrationMotor.Small
    }, {
        __index = u6
    });
    u26.Inspect = l__ReplicatedStorage__2.Assets.Interface.Inspect:Clone();
    u26.Inspect.Name = "Inspect.InteractionSource";
    u26.Inspect.Parent = u8.MainPriority;
    u26.Inspect.TextLabel.Text = "";
    u26.Highlight = u2.newSet();
    u26.GetInteraction = p24;
    function u26.EndThisInteraction() --[[ Line: 268 ]]
        -- upvalues: u26 (copy)
        u26:EndInteraction();
    end;
    u8.InteractionSources[p23] = u26;
    return u26;
end;
function u8.AddRaycastInteractionSource(p27, u28) --[[ Line: 279 ]]
    -- upvalues: u8 (copy), l__Players__6 (copy), l__Workspace__7 (copy), l__CONSTANTS__13 (copy)
    local v29 = type(u28) == "function";
    assert(v29, "Expected GetPointVectors to be a function");
    return u8.AddInteractionSource(p27, function() --[[ Line: 281 ]]
        -- upvalues: l__Players__6 (ref), u28 (copy), u8 (ref), l__Workspace__7 (ref), l__CONSTANTS__13 (ref)
        local l__Character__15 = l__Players__6.LocalPlayer.Character;
        if not l__Character__15 then
            return nil, nil;
        end;
        local v30 = l__Character__15:FindFirstChild("HumanoidRootPart");
        if not v30 then
            return nil, nil;
        end;
        local v31, v32 = u28();
        if not (v31 and v32) then
            return nil, nil;
        end;
        local v33;
        if u8.DontUseReachBased then
            v33 = l__Workspace__7:Raycast(v31, v32 * l__CONSTANTS__13.MAX_DISTANCE, u8.InteractParams);
        else
            v33 = l__Workspace__7:Spherecast(v31, u8.ReachDistance, v32 * l__CONSTANTS__13.MAX_DISTANCE, u8.InteractParams);
        end;
        if not v33 then
            return nil, nil;
        end;
        local l__Magnitude__16 = (v30.Position - v33.Position).Magnitude;
        local l__Position__17 = v33.Position;
        local v34 = u8.InteractionHitColliderLookup[v33.Instance];
        if (v34 and v34.MaxCharacterDistance or l__CONSTANTS__13.MAX_CHARACTER_DISTANCE) >= l__Magnitude__16 then
            return l__Position__17, v34;
        end;
    end);
end;
function u8.AddPositionInteractionSource(p35, u36) --[[ Line: 309 ]]
    -- upvalues: u8 (copy)
    local v37 = type(u36) == "function";
    assert(v37, "Expected GetPosition to be a function");
    return u8.AddInteractionSource(p35, function() --[[ Line: 311 ]]
        -- upvalues: u36 (copy), u8 (ref)
        local v38 = u36();
        if not v38 then
            return nil, nil;
        end;
        for v39, v40 in u8.InteractionHitColliderLookup do
            if v40.Disabled ~= true then
                local v41 = v39.CFrame:Inverse() * CFrame.new(v38);
                if math.abs(v41.X) <= v39.Size.X / 2 and (math.abs(v41.Y) <= v39.Size.Y / 2 and math.abs(v41.Z) <= v39.Size.Z / 2) then
                    return v38, v40;
                end;
            end;
        end;
        return nil, nil;
    end);
end;
function u8.CheckInteractionStatus() --[[ Line: 325 ]]
    -- upvalues: u8 (copy), l__StarterGui__5 (copy)
    local v42 = false;
    for _, v43 in u8.InteractionSources do
        if v43.InteractionActive then
            v42 = true;
            break;
        end;
    end;
    l__StarterGui__5:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, not v42);
end;
function u8.BindToInteract(p44, p45) --[[ Line: 337 ]]
    -- upvalues: u8 (copy)
    table.insert(u8.InteractionBindings, {
        Priority = p44,
        CallbackFn = p45
    });
    table.sort(u8.InteractionBindings, function(p46, p47) --[[ Line: 344 ]]
        return p46.Priority < p47.Priority;
    end);
end;
function u8.CollapseClass(p48) --[[ Line: 351 ]]
    -- upvalues: u8 (copy)
    if not u8.InteractionIsReadyToRegister then
        u8.InteractionReady:Wait();
    end;
    local v49 = typeof(p48) == "table";
    assert(v49, "InteractionClass Must be an \'InteractionClass\'.");
    local l__HitCollider__18 = p48.HitCollider;
    if l__HitCollider__18 then
        l__HitCollider__18 = p48.HitCollider:IsA("BasePart");
    end;
    assert(l__HitCollider__18, "InteractionClass.HitCollider is required.");
    local v50 = table.find(u8.InteractionHitColliders, p48.HitCollider);
    if v50 then
        table.remove(u8.InteractionHitColliders, v50);
    end;
    u8.InteractParams.FilterDescendantsInstances = u8.InteractionHitColliders;
    u8.InteractionHitColliderLookup[p48.HitCollider] = nil;
end;
function u8.NewInteractionClass(u51) --[[ Line: 365 ]]
    -- upvalues: u8 (copy), l__RunService__4 (copy)
    if not u8.InteractionIsReadyToRegister then
        u8.InteractionReady:Wait();
    end;
    if not (u51.HitCollider and u51.HitCollider:IsA("BasePart")) and l__RunService__4:IsStudio() then
        warn("Studio DEBUG HELPER! InteractionClass failed due to hitcollider");
        warn(u51);
        warn(debug.traceback(nil, 5));
    end;
    local v52 = typeof(u51) == "table";
    assert(v52, "InteractionClass Must be an \'InteractionClass\'.");
    local l__HitCollider__19 = u51.HitCollider;
    if l__HitCollider__19 then
        l__HitCollider__19 = u51.HitCollider:IsA("BasePart");
    end;
    assert(l__HitCollider__19, "InteractionClass.HitCollider is required.");
    local l__HitCollider__20 = u51.HitCollider;
    l__HitCollider__20.CanQuery = true;
    l__HitCollider__20.CanTouch = false;
    setmetatable(u51, {
        __index = u8.InteractionClassProtoType
    });
    table.insert(u8.InteractionHitColliders, l__HitCollider__20);
    u8.InteractParams.FilterDescendantsInstances = u8.InteractionHitColliders;
    u8.InteractionHitColliderLookup[l__HitCollider__20] = u51;
    local u53 = false;
    local u54 = {};
    u54.Destroying = l__HitCollider__20.Destroying:Connect(function() --[[ Line: 388 ]]
        -- upvalues: u53 (ref), u8 (ref), u51 (copy), u54 (copy)
        if u53 then
        else
            u53 = true;
            u8.CollapseClass(u51);
            for _, v55 in u54 do
                v55:Disconnect();
            end;
        end;
    end);
    u54.ParentToNil = l__HitCollider__20.AncestryChanged:Connect(function() --[[ Line: 402 ]]
        -- upvalues: l__HitCollider__20 (copy), u53 (ref), u8 (ref), u51 (copy), u54 (copy)
        if l__HitCollider__20.Parent == nil then
            if u53 then
                return;
            end;
            u53 = true;
            u8.CollapseClass(u51);
            for _, v56 in u54 do
                v56:Disconnect();
            end;
        end;
    end);
    u51.ColliderEvents = u54;
    return u51;
end;
function u8.GetSelections() --[[ Line: 414 ]]
    -- upvalues: u8 (copy)
    local v57 = {};
    for v58, v59 in u8.InteractionSources do
        if v59.CurrentSelection then
            v57[v58] = v59.CurrentSelection;
        end;
    end;
    return v57;
end;
function u8.GetSelection() --[[ Line: 424 ]]
    -- upvalues: u8 (copy)
    return u8.GetSelections()[Enum.UserInputType.MouseMovement];
end;
function u8.Update() --[[ Line: 429 ]]
    -- upvalues: u1 (copy), u8 (copy)
    local v60 = Vector2.new(u1.X, u1.Y);
    for _, v61 in u8.InteractionSources do
        if not v61.InteractionActive then
            local v62, v63 = v61.GetInteraction();
            if v62 and (v63 and v63.Disabled ~= true) then
                if v61.ShowsInspectAtMousePosition then
                    v61.Inspect.Position = UDim2.fromOffset(v60.X, v60.Y);
                end;
                if v61.InspectWorldPart then
                    v61.InspectWorldPart.CFrame = CFrame.new(v62);
                end;
                local l__OnHover__21 = v63.OnHover;
                if l__OnHover__21 then
                    local v64 = l__OnHover__21(v63);
                    if not v64 then
                        v61:Unselect();
                        v61:InvalidSelection();
                        return;
                    end;
                    if v64 == "Unselect" then
                        v61:Unselect();
                        return;
                    end;
                end;
                if v63 == v61.CurrentSelection then
                    return;
                end;
                v61:SelectNew(v63);
            else
                v61:Unselect();
            end;
        end;
    end;
end;
function u8.IsInteractionActive() --[[ Line: 477 ]]
    -- upvalues: u8 (copy)
    local v65 = false;
    for _, v66 in u8.InteractionSources do
        if v66.InteractionActive then
            return true;
        end;
    end;
    return v65;
end;
function u8.IsInvalidSelection() --[[ Line: 489 ]]
    -- upvalues: u8 (copy)
    return u8.SelectionWasInvalid;
end;
function u8.StartInteractions() --[[ Line: 495 ]]
    -- upvalues: u8 (copy)
    for _, v67 in u8.InteractionSources do
        v67.InteractionActive = true;
    end;
    u8.CheckInteractionStatus();
end;
function u8.EndInteractions() --[[ Line: 503 ]]
    -- upvalues: u8 (copy)
    for _, v68 in u8.InteractionSources do
        v68.InteractionActive = false;
    end;
    u8.CheckInteractionStatus();
end;
function u8.TriggerInteraction() --[[ Line: 511 ]]
    -- upvalues: u8 (copy)
    for _, v69 in u8.InteractionSources do
        if not v69.CustomBindingActive then
            if v69.InteractionActive then
                return "Sink";
            end;
            if v69.CurrentSelection then
                v69:BeginInteractionWithSelection();
                return "Sink";
            end;
        end;
    end;
    return "Pass";
end;
function u8.Interact() --[[ Line: 532 ]]
    -- upvalues: u8 (copy), l__CONSTANTS__13 (copy)
    for _, v70 in u8.InteractionBindings do
        local v71 = v70.CallbackFn();
        local v72 = l__CONSTANTS__13.VALID_INTERACTION_RESULTS[v71];
        local v73 = `BindingResult is Either 'Sink' or 'Pass'. Got '{v71 or "None"}'`;
        assert(v72, v73);
        if v71 == "Sink" then
            return;
        end;
    end;
end;
function u8.__SetupInteractionConnections() --[[ Line: 543 ]]
    -- upvalues: u3 (copy), u8 (copy), l__UserInputService__1 (copy)
    u3.Get("Interact").OnAction:Connect(function(p74) --[[ Line: 544 ]]
        -- upvalues: u8 (ref)
        if p74 == Enum.UserInputState.Begin then
            u8.Interact();
        end;
    end);
    l__UserInputService__1.TouchTapInWorld:Connect(function(_, p75) --[[ Line: 550 ]]
        -- upvalues: u8 (ref)
        if p75 then
        else
            u8.Interact();
        end;
    end);
end;
function u8.AddBlocker(p76) --[[ Line: 557 ]]
    -- upvalues: u8 (copy)
    local v77;
    if p76 then
        v77 = typeof(p76) == "Instance";
    else
        v77 = p76;
    end;
    assert(v77, "InteractionClass.HitCollider is required.");
    table.insert(u8.InteractionHitColliders, p76);
end;
function u8.RemoveBlocker(p78) --[[ Line: 562 ]]
    -- upvalues: u8 (copy)
    local v79 = table.find(u8.InteractionHitColliders, p78);
    if v79 then
        table.remove(u8.InteractionHitColliders, v79);
    end;
end;
function u8.NewCharacter(_) --[[ Line: 567 ]]
    -- upvalues: u8 (copy)
    u8.EndInteractions();
end;
function u8.Init() --[[ Line: 571 ]]
    -- upvalues: u8 (copy), u2 (copy), l__UserInputService__1 (copy), u5 (copy), l__Players__6 (copy), l__Workspace__7 (copy), u1 (copy)
    local v80 = RaycastParams.new();
    v80.FilterType = Enum.RaycastFilterType.Include;
    u8.InteractParams = v80;
    u8.Highlight = u2.newSet();
    u8.InteractionIsReadyToRegister = true;
    u8.InteractionReady:Fire();
    if l__UserInputService__1.VREnabled then
        for u81, v82 in u8.CONSTANTS.HAND_POSITION_INPUTS do
            local l__AttachmentName__22 = v82.AttachmentName;
            local v85 = u8.AddPositionInteractionSource(v82.Key, function() --[[ Line: 585 ]]
                -- upvalues: u5 (ref), l__Players__6 (ref), u81 (copy), l__AttachmentName__22 (copy)
                if u5.GetValue("VRExperimentalMode") == true then
                    local l__Character__23 = l__Players__6.LocalPlayer.Character;
                    if l__Character__23 then
                        local v83 = l__Character__23:FindFirstChild(u81);
                        if v83 then
                            local v84 = v83:FindFirstChild(l__AttachmentName__22);
                            if v84 then
                                return v84.WorldPosition;
                            else
                                return nil;
                            end;
                        else
                            return nil;
                        end;
                    else
                        return nil;
                    end;
                else
                    return nil;
                end;
            end);
            v85.HapticMotor = v82.HapticMotor;
            v85:ConnectBind(v82.BindName);
            v85:ShowInspectInWorldSpace();
        end;
    end;
    local v87 = u8.AddRaycastInteractionSource(Enum.UserInputType.MouseMovement, function() --[[ Line: 604 ]]
        -- upvalues: l__UserInputService__1 (ref), u5 (ref), l__Players__6 (ref), l__Workspace__7 (ref), u1 (ref)
        if l__UserInputService__1.VREnabled then
            if u5.GetValue("VRExperimentalMode") == true then
                return nil, nil;
            else
                local l__Character__24 = l__Players__6.LocalPlayer.Character;
                if l__Character__24 then
                    local v86 = l__Character__24:FindFirstChild("RightHand");
                    if v86 then
                        return v86.Position, -v86.CFrame.UpVector;
                    else
                        return nil, nil;
                    end;
                else
                    return nil, nil;
                end;
            end;
        else
            local l__Position__25 = l__Workspace__7.CurrentCamera.CFrame.Position;
            return l__Position__25, (u1.Hit.Position - l__Position__25).Unit;
        end;
    end);
    if l__UserInputService__1.VREnabled then
        v87.HapticMotor = Enum.VibrationMotor.RightHand;
        v87:ShowInspectInWorldSpace();
    else
        if l__UserInputService__1.TouchEnabled then
            v87.HapticMotor = nil;
        end;
    end;
end;
function u8.ReactToNewInputMode(p88) --[[ Line: 633 ]]
    -- upvalues: u8 (copy)
    for _, v89 in u8.InteractionSources do
        if p88 == "Console" then
            v89.Inspect.TextLabel.Size = UDim2.fromScale(40, 1000);
        else
            v89.Inspect.TextLabel.Size = UDim2.fromScale(20, 1000);
        end;
    end;
end;
function u8.GetPlatformReachDistance() --[[ Line: 643 ]]
    -- upvalues: u8 (copy), u3 (copy)
    return u8.AssistedReachDistance[u3.GetMode()] or u8.DefaultReachDistance;
end;
function u8.Setup() --[[ Line: 647 ]]
    -- upvalues: u8 (copy), u4 (copy), u3 (copy), l__LocalPlayer__9 (copy), l__RunService__4 (copy)
    u8.MainPriority = u4.GetScreenGui("MainPriority");
    u8.Inspect = u8.MainPriority.Inspect;
    u8.Init();
    u8.__SetupInteractionConnections();
    u8.BindToInteract(0, u8.TriggerInteraction);
    u3.WhenModeChanges(function(p90) --[[ Line: 656 ]]
        -- upvalues: u8 (ref)
        u8.ReactToNewInputMode(p90);
        u8.ReachDistance = u8.GetPlatformReachDistance();
    end);
    l__LocalPlayer__9.CharacterAdded:Connect(u8.NewCharacter);
    if l__LocalPlayer__9.Character then
        u8.NewCharacter(l__LocalPlayer__9.Character);
    end;
    l__RunService__4.Heartbeat:Connect(u8.Update);
end;
return u8;
