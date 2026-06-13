-- Decompiled from: ReplicatedStorage.Modules.SmartBone
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__HttpService__2 = game:GetService("HttpService");
local l__Players__3 = game:GetService("Players");
local l__RunService__4 = game:GetService("RunService");
local l__Components__5 = script:WaitForChild("Components");
local l__Dependencies__6 = script:WaitForChild("Dependencies");
local l__CeiveImOverlay__7 = require(l__Dependencies__6:WaitForChild("CeiveImOverlay"));
local l__Config__8 = require(l__Dependencies__6:WaitForChild("Config"));
local l__Frustum__9 = require(l__Dependencies__6:WaitForChild("Frustum"));
local l__Utilities__10 = require(l__Dependencies__6:WaitForChild("Utilities"));
local u1 = nil;
local l__Bone__11 = require(l__Components__5:WaitForChild("Bone"));
local l__BoneTree__12 = require(l__Components__5:WaitForChild("BoneTree"));
local l__ColliderObject__13 = require(l__Components__5:WaitForChild("Collision"):WaitForChild("ColliderObject"));
local l__Runtime__14 = l__Dependencies__6:WaitForChild("Runtime");
local l__SB_INDENT_LOG__15 = l__Utilities__10.SB_INDENT_LOG;
local l__SB_UNINDENT_LOG__16 = l__Utilities__10.SB_UNINDENT_LOG;
local l__SB_VERBOSE_LOG__17 = l__Utilities__10.SB_VERBOSE_LOG;
local l__SB_VERBOSE_WARN__18 = l__Utilities__10.SB_VERBOSE_WARN;
local u2 = {};
u2.__index = u2;
function u2.new() --[[ Line: 73 ]]
    -- upvalues: l__HttpService__2 (copy), u2 (copy)
    local v3 = {
        ShouldDestroy = false,
        ID = l__HttpService__2:GenerateGUID(false),
        BoneTrees = {},
        ColliderObjects = {}
    };
    return setmetatable(v3, u2);
end;
function u2.m_AppendBone(_, p4, p5, p6, p7) --[[ Line: 96 ]]
    -- upvalues: l__Utilities__10 (copy), l__Bone__11 (copy), l__SB_VERBOSE_LOG__17 (copy)
    local v8 = l__Utilities__10.GatherBoneSettings(p5);
    local v9 = l__Bone__11.new(p5, p4.Root, p4.RootPart);
    for v10, v12 in v8 do
        if v12 == "¬" or not v12 then
            local v12 = nil;
        end;
        v9[v10] = v12;
    end;
    local v13 = p4.Bones[p6];
    if p6 > 0 then
        local l__Magnitude__19 = (v13.Position - v9.Position).Magnitude;
        v9.FreeLength = l__Magnitude__19;
        v9.Weight = l__Magnitude__19 * 0.7;
        v9.HeirarchyLength = p7;
        v13.HasChild = true;
    end;
    if p7 <= p4.Settings.AnchorDepth then
        l__SB_VERBOSE_LOG__17("Anchoring bone");
        v9.Anchored = true;
    end;
    v9.ParentIndex = p6;
    table.insert(p4.Bones, v9);
end;
function u2.m_CreateBoneTree(u14, p15, p16) --[[ Line: 135 ]]
    -- upvalues: l__Utilities__10 (copy), l__BoneTree__12 (copy), l__SB_VERBOSE_LOG__17 (copy), l__SB_INDENT_LOG__15 (copy), l__SB_UNINDENT_LOG__16 (copy)
    local v17 = l__Utilities__10.GatherObjectSettings(p15);
    local u18 = l__BoneTree__12.new(p16, p15);
    u18.Settings = v17;
    l__SB_VERBOSE_LOG__17((`Creating bone tree {p15.Name}; {p16.Name}`));
    l__SB_INDENT_LOG__15();
    local function u29(p19, p20, p21) --[[ Line: 144 ]]
        -- upvalues: l__SB_VERBOSE_LOG__17 (ref), l__SB_INDENT_LOG__15 (ref), u14 (copy), u18 (copy), u29 (copy), l__SB_UNINDENT_LOG__16 (ref)
        l__SB_VERBOSE_LOG__17((`Adding bone: {p19.Name}; {p20}; {p21}`));
        l__SB_INDENT_LOG__15();
        local v22 = false;
        for _, v23 in p19:GetChildren() do
            if v23:IsA("Bone") then
                u14:m_AppendBone(u18, v23, p20, p21);
                u29(v23, #u18.Bones, p21 + 1);
                v22 = true;
            end;
        end;
        if not v22 then
            l__SB_VERBOSE_LOG__17("Adding tail bone");
            local l__Parent__20 = p19.Parent;
            local v24 = l__Parent__20:IsA("Bone") and l__Parent__20.WorldPosition or l__Parent__20.Position;
            local v25 = p19.WorldCFrame + p19.WorldCFrame.UpVector.Unit * (p19.WorldPosition - v24).Magnitude;
            local v26 = Instance.new("Bone");
            v26.Parent = p19;
            v26.Name = p19.Name .. "_Tail";
            v26.WorldCFrame = v25;
            for v27, v28 in p19:GetAttributes() do
                v26:SetAttribute(v27, v28);
            end;
            u14:m_AppendBone(u18, v26, #u18.Bones, p21);
        end;
        l__SB_UNINDENT_LOG__16();
    end;
    u14:m_AppendBone(u18, p16, 0, 0);
    u29(p16, 1, 1);
    table.insert(u14.BoneTrees, u18);
    l__SB_UNINDENT_LOG__16();
end;
function u2.m_UpdateViewFrustum(p30) --[[ Line: 193 ]]
    -- upvalues: l__Config__8 (copy), l__Frustum__9 (copy)
    if shared.FrameCounter % l__Config__8.FRUSTUM_FREQ == 0 then
        local v31, v32, v33, v34, v35, v36, v37, v38, v39 = l__Frustum__9.GetCFrames(workspace.CurrentCamera, l__Config__8.FAR_PLANE);
        for _, v40 in p30.BoneTrees do
            v40.InView = l__Frustum__9.ObjectInFrustum({
                CFrame = v40.BoundingBoxCFrame,
                Size = v40.BoundingBoxSize
            }, v31, v32, v33, v34, v35, v36, v37, v38, v39);
        end;
    end;
end;
function u2.m_CleanColliders(p41) --[[ Line: 214 ]]
    -- upvalues: l__SB_VERBOSE_WARN__18 (copy), l__SB_INDENT_LOG__15 (copy), l__SB_UNINDENT_LOG__16 (copy)
    local v42 = false;
    if #p41.ColliderObjects ~= 0 then
        for v43, v44 in p41.ColliderObjects do
            if #v44.Colliders == 0 or v44.Destroyed == true then
                l__SB_VERBOSE_WARN__18("Deleting Collider Object");
                l__SB_INDENT_LOG__15();
                v44:Destroy();
                l__SB_UNINDENT_LOG__16();
                table.remove(p41.ColliderObjects, v43);
                v42 = true;
            end;
        end;
    end;
end;
function u2.m_UpdateBoneTree(p45, p46, p47, p48) --[[ Line: 246 ]]
    -- upvalues: l__SB_VERBOSE_LOG__17 (copy)
    if p46.Destroyed then
        p46:Destroy();
        table.remove(p45.BoneTrees, p47);
    else
        p46:PreUpdate(p48);
        if p46.InView and (math.floor(p46.UpdateRate) ~= 0 and p46.InWorkspace) then
            for _, v49 in p45.ColliderObjects do
                v49:Step();
            end;
            local v50 = 1 / p46.UpdateRate;
            p46.AccumulatedDelta = p46.AccumulatedDelta + p48;
            local v51 = false;
            while v50 < p46.AccumulatedDelta do
                p46.AccumulatedDelta = p46.AccumulatedDelta - v50;
                p46:StepPhysics(v50);
                p46:Constrain(p45.ColliderObjects, v50);
                p46:SolveTransform(v50);
                v51 = true;
            end;
            if v51 then
                task.synchronize();
                p46:ApplyTransform();
            end;
        else
            local l__IsSkippingUpdates__21 = p46.IsSkippingUpdates;
            p46:SkipUpdate();
            if not l__IsSkippingUpdates__21 then
                task.synchronize();
                p46:ApplyTransform();
                l__SB_VERBOSE_LOG__17((`Skipping BoneTree, InView: {p46.InView}, Update Rate == 0: {math.floor(p46.UpdateRate) == 0}, InWorkspace: {p46.InWorkspace}`));
            end;
        end;
    end;
end;
function u2.m_CheckDestroy(p52) --[[ Line: 311 ]]
    p52.ShouldDestroy = false;
    if #p52.BoneTrees ~= 0 then
        return false;
    end;
    p52.ShouldDestroy = true;
    return true;
end;
function u2.LoadObject(p53, p54) --[[ Line: 327 ]]
    local v55 = p54:GetAttribute("Roots");
    if v55 then
        local v56 = v55:split(",");
        local v57 = {};
        for _, v58 in p54:GetDescendants() do
            if v58:IsA("Bone") then
                if v57[v58.Name] then
                    warn((`[SmartBone2::LoadObject] Duplicate bones of name: {v58.Name} in RootPart: {p54.Name}`));
                else
                    v57[v58.Name] = v58;
                end;
            end;
        end;
        for _, v59 in v56 do
            local v60 = v57[v59];
            if v60 then
                p53:m_CreateBoneTree(p54, v60);
            else
                warn((`[SmartBone2::LoadObject] Couldn't find Root Bone of name: {v59} in RootPart: {p54.Name}`));
            end;
        end;
    else
        warn((`[SmartBone2::LoadObject] Cannot load an object with no roots defined {p54.Name}`));
    end;
end;
function u2.LoadColliderModule(p61, p62, p63) --[[ Line: 368 ]]
    -- upvalues: l__HttpService__2 (copy), l__ColliderObject__13 (copy)
    assert(p62, "[SmartBone2::LoadColliderModule] No collider module passed in");
    local v64 = l__HttpService__2:JSONDecode((require(p62)));
    local v65 = l__ColliderObject__13.new(v64, p63);
    table.insert(p61.ColliderObjects, v65);
end;
function u2.LoadRawCollider(p66, p67, p68) --[[ Line: 383 ]]
    -- upvalues: l__ColliderObject__13 (copy)
    local v69 = l__ColliderObject__13.new(p67, p68);
    table.insert(p66.ColliderObjects, v69);
end;
function u2.SkipUpdate(p70) --[[ Line: 391 ]]
    for _, v71 in p70.BoneTrees do
        v71:SkipUpdate();
    end;
end;
function u2.StepBoneTrees(p72, p73) --[[ Line: 402 ]]
    -- upvalues: l__SB_VERBOSE_WARN__18 (copy)
    if p72:m_CheckDestroy() then
    elseif p73 <= 0 then
        l__SB_VERBOSE_WARN__18("DeltaTime is zero or sub zero, not updating.");
    else
        p72:m_CleanColliders();
        p72:m_UpdateViewFrustum();
        for v74, v75 in p72.BoneTrees do
            p72:m_UpdateBoneTree(v75, v74, p73);
        end;
    end;
end;
function u2.DrawDebug(p76, p77, p78, p79, p80, p81, p82, p83, p84, p85, p86, p87, p88, p89) --[[ Line: 435 ]]
    for _, v90 in p76.BoneTrees do
        v90:DrawDebug(p78, p79, p80, p81, p82, p87, p88, p89);
    end;
    if p77 then
        for _, v91 in p76.ColliderObjects do
            v91:DrawDebug(p83, p84, p85, p86);
        end;
    end;
end;
function u2.DrawOverlay(p92, p93) --[[ Line: 474 ]]
    -- upvalues: l__Config__8 (copy)
    if not l__Config__8.DEBUG_OVERLAY_ENABLED then
        return;
    end;
    local v94 = Color3.new(1, 0.431373, 0.713725);
    local v95 = Color3.new(1, 1, 1);
    local v96 = Color3.new(0.486275, 0.431373, 1);
    local v97 = Color3.new(1, 1, 1);
    p93.Begin(`SmartBone Instance ID: {p92.ID}`, v94, v95);
    p93.Text((`Frame Counter: {shared.FrameCounter}`));
    if l__Config__8.DEBUG_OVERLAY_TREE then
        for v98, v99 in p92.BoneTrees do
            if l__Config__8.DEBUG_OVERLAY_MAX_TREES > 0 and l__Config__8.DEBUG_OVERLAY_TREE_OFFSET + l__Config__8.DEBUG_OVERLAY_MAX_TREES <= v98 then
                break;
            end;
            if v98 >= l__Config__8.DEBUG_OVERLAY_TREE_OFFSET then
                p93.Begin(`Bone Tree {v98}`, v96, v97);
                v99:DrawOverlay(p93);
                p93.End();
            end;
        end;
    end;
    p93.End();
end;
function u2.Destroy(p100) --[[ Line: 510 ]]
    -- upvalues: l__SB_VERBOSE_LOG__17 (copy)
    l__SB_VERBOSE_LOG__17("Deleting SmartBone Object");
    for _, v101 in p100.BoneTrees do
        v101:Destroy();
    end;
    for _, v102 in p100.ColliderObjects do
        v102:Destroy();
    end;
    setmetatable(p100, nil);
end;
function u2.Start() --[[ Line: 528 ]]
    -- upvalues: l__RunService__4 (copy), u2 (copy), l__Config__8 (copy), l__Players__3 (copy), u1 (ref), l__CollectionService__1 (copy), l__SB_VERBOSE_LOG__17 (copy), l__SB_INDENT_LOG__15 (copy), l__Utilities__10 (copy), l__Runtime__14 (copy), l__SB_UNINDENT_LOG__16 (copy), l__CeiveImOverlay__7 (copy)
    if l__RunService__4:IsClient() then
        if not u2.Running then
            if l__Config__8.STARTUP_PRINT_ENABLED or l__Config__8.LOG_VERBOSE then
                print((`SmartBone2 v{l__Config__8.VERSION} Starting`));
            end;
            u2.Running = true;
            local l__PlayerScripts__22 = l__Players__3.LocalPlayer:WaitForChild("PlayerScripts");
            local u103 = Instance.new("Folder");
            u103.Name = "SmartBone-Actors";
            u103.Parent = l__PlayerScripts__22;
            local v104 = Instance.new("BindableEvent");
            v104.Name = "OverlayEvent";
            v104.Parent = script;
            v104.Event:Connect(function(p105, ...) --[[ Line: 556 ]]
                -- upvalues: l__Config__8 (ref), u1 (ref)
                if l__Config__8.DEBUG_OVERLAY_ENABLED then
                    if p105 == "Text" then
                        u1:Text(...);
                    elseif p105 == "Begin" then
                        u1:Begin(...);
                    else
                        if p105 == "End" then
                            u1:End();
                        end;
                    end;
                end;
            end);
            local function u109() --[[ Line: 570 ]]
                -- upvalues: l__CollectionService__1 (ref), l__SB_VERBOSE_LOG__17 (ref), l__Config__8 (ref)
                local v106 = {
                    Key = {},
                    Raw = {}
                };
                for _, v107 in l__CollectionService__1:GetTagged("SmartCollider") do
                    if v107:IsA("BasePart") then
                        local v108 = v107:GetAttribute("ColliderKey");
                        if v108 then
                            v108 = tostring(v108);
                            if not v106.Key[v108] then
                                v106.Key[v108] = {};
                            end;
                            table.insert(v106.Key[v108], v107);
                        end;
                        l__SB_VERBOSE_LOG__17((`Adding collider: {v107.Name}, Collider Key: {v108}`));
                        table.insert(v106.Raw, v107);
                        if l__Config__8.YIELD_ON_COLLIDER_GATHER then
                            task.wait();
                        end;
                    end;
                end;
                return v106;
            end;
            local function v119(p110) --[[ Line: 604 ]]
                -- upvalues: l__SB_VERBOSE_LOG__17 (ref), l__SB_INDENT_LOG__15 (ref), u109 (copy), l__Utilities__10 (ref), l__Runtime__14 (ref), u103 (copy), l__SB_UNINDENT_LOG__16 (ref)
                if p110:IsA("BasePart") then
                    l__SB_VERBOSE_LOG__17((`Setup Object: {p110.Name}`));
                    l__SB_INDENT_LOG__15();
                    local v111 = u109();
                    local v112 = p110:GetAttribute("ColliderKey");
                    local v113;
                    if v112 then
                        v113 = v111.Key[tostring(v112)] or {};
                    else
                        v113 = v111.Raw or {};
                    end;
                    local v114 = {};
                    for _, v115 in v113 do
                        local v116 = { l__Utilities__10.GetCollider(v115), v115 };
                        table.insert(v114, v116);
                    end;
                    local v117 = Instance.new("Actor");
                    local v118 = l__Runtime__14:Clone();
                    v118.Parent = v117;
                    v118.Enabled = true;
                    v117.Parent = u103;
                    task.wait();
                    v117:SendMessage("Setup", p110, v114, script);
                    l__SB_VERBOSE_LOG__17("Runtime Started");
                    l__SB_UNINDENT_LOG__16();
                end;
            end;
            l__CollectionService__1:GetInstanceAddedSignal("SmartBone"):Connect(v119);
            for _, v120 in l__CollectionService__1:GetTagged("SmartBone") do
                v119(v120);
            end;
            if l__Config__8.DEBUG_OVERLAY_ENABLED then
                u1 = l__CeiveImOverlay__7.new();
                local l__PlayerGui__23 = l__Players__3.LocalPlayer.PlayerGui;
                local v121 = Instance.new("ScreenGui");
                v121.Name = "SmartBoneDebugOverlay";
                v121.IgnoreGuiInset = true;
                v121.ResetOnSpawn = false;
                v121.Parent = l__PlayerGui__23;
                u1.BackFrame.Parent = v121;
                l__RunService__4.RenderStepped:Connect(function() --[[ Line: 664 ]]
                    -- upvalues: u1 (ref)
                    u1:Render();
                end);
            end;
            return {
                Stop = function() --[[ Name: Stop, Line 670 ]]
                    -- upvalues: u2 (ref), l__Config__8 (ref), u103 (copy)
                    u2.Running = false;
                    if l__Config__8.RESET_BONE_ON_DESTROY then
                        for _, v122 in u103:GetChildren() do
                            v122:SendMessage("Destroy");
                        end;
                    else
                        u103:Destroy();
                    end;
                end
            };
        end;
        warn("Cannot call Smartbone.Start() multiple times");
    else
        warn("Smartbone.Start() can only be called in client context.");
    end;
end;
return u2;
