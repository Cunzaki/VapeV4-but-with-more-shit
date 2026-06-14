-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.CutsceneHandler
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local l__Workspace__2 = game:GetService("Workspace");
local l__RunService__3 = game:GetService("RunService");
game:GetService("Debris");
local _ = l__Workspace__2.CurrentCamera;
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__Signal__5 = require(l__ReplicatedStorage__1.Modules.Signal);
local u1 = l__Mince__4:Get("HideDuringCutscene");
l__Mince__4:Get("InterfaceHandler");
l__Mince__4:Get("SelectInteractor");
l__Mince__4:Get("SoundHandler");
local u2 = {
    Cutscenes = {}
};
local u3 = {};
u3.__index = u3;
function u3.New(p4) --[[ Line: 25 ]]
    -- upvalues: u3 (copy), l__Signal__5 (copy)
    local v5 = setmetatable(p4, u3);
    v5.Stopped = l__Signal__5.new();
    v5.Loaded = l__Signal__5.new();
    v5.IsLoaded = false;
    v5.Active = false;
    return v5;
end;
function u3.Play(u6) --[[ Line: 35 ]]
    -- upvalues: u1 (copy), l__Workspace__2 (copy), u2 (copy), l__RunService__3 (copy)
    u1.HideAll();
    l__Workspace__2.CurrentCamera.FieldOfView = 30;
    if u2.Connection then
        u2.Connection:Disconnect();
    end;
    u2.Connection = l__RunService__3.RenderStepped:Connect(function() --[[ Line: 46 ]]
        -- upvalues: l__Workspace__2 (ref), u6 (copy)
        l__Workspace__2.CurrentCamera.CFrame = u6.CameraPart.CFrame;
    end);
    u6.Active = true;
    if u6.Audio then
        u6.Audio:Play();
    end;
    for _, u7 in u6.Rigs do
        task.spawn(function() --[[ Line: 57 ]]
            -- upvalues: u7 (copy), u6 (copy)
            for _, v8 in ipairs(u7) do
                if not u6.Active then
                    break;
                end;
                v8:Play();
                v8.Ended:Wait();
            end;
        end);
    end;
    task.delay(u6.TimeLength, function() --[[ Line: 67 ]]
        -- upvalues: u6 (copy)
        if u6.Active then
            u6:Stop();
        end;
    end);
end;
function u3.Stop(p9) --[[ Line: 74 ]]
    -- upvalues: u1 (copy), u2 (copy), l__Workspace__2 (copy), l__ReplicatedStorage__1 (copy)
    p9.Active = false;
    u1.ShowAll();
    u2.Connection:Disconnect();
    u2.Connection = nil;
    l__Workspace__2.CurrentCamera.FieldOfView = 70;
    for _, u10 in p9.Rigs do
        task.defer(function() --[[ Line: 85 ]]
            -- upvalues: u10 (copy)
            for _, v11 in u10 do
                v11:Stop();
            end;
        end);
    end;
    p9.Folder.Parent = l__ReplicatedStorage__1.Assets.Cutscenes;
    p9.Stopped:Fire();
end;
function u2.LoadRig(_, p12) --[[ Line: 99 ]]
    local v13 = p12:FindFirstChild("Animations");
    local l__Animator__6 = (p12:FindFirstChildOfClass("AnimationController") or p12:FindFirstChildOfClass("Humanoid")):WaitForChild("Animator", 1);
    local v14 = {};
    for _, v15 in v13:GetChildren() do
        local v16 = l__Animator__6:LoadAnimation(v15);
        v14[tonumber(v15.Name)] = v16;
    end;
    return v14;
end;
function u2.LoadCutscene(_, p17) --[[ Line: 112 ]]
    -- upvalues: u2 (copy), l__ReplicatedStorage__1 (copy), l__Workspace__2 (copy), u3 (copy)
    if u2.Cutscenes[p17] then
        return u2.Cutscenes[p17];
    end;
    local v18 = l__ReplicatedStorage__1.Assets.Cutscenes:FindFirstChild(p17);
    local v19 = `Cannot find cutscene folder {p17}!`;
    assert(v18, v19);
    local v20 = v18:Clone();
    v20.Parent = l__Workspace__2;
    local u21 = u3.New({
        TimeLength = 0,
        Folder = v20,
        Rigs = {}
    });
    local v22 = {};
    for _, v23 in v20:GetDescendants() do
        if v23:FindFirstChildOfClass("AnimationController") or v23:FindFirstChildOfClass("Humanoid") then
            table.insert(v22, v23);
        elseif v23.Name == "CamLock" then
            u21.CameraPart = v23;
        elseif v23.Name == "Audio" then
            u21.Audio = v23;
        end;
    end;
    for _, v24 in v22 do
        local v25 = u2:LoadRig(v24);
        u21.Rigs[v24] = v25;
    end;
    u21.IsLoaded = false;
    task.defer(function() --[[ Line: 149 ]]
        -- upvalues: u21 (copy)
        while not u21.IsLoaded do
            task.wait(0.05);
            u21.IsLoaded = true;
            for _, v26 in u21.Rigs do
                for _, v27 in v26 do
                    if v27.Length == 0 then
                        u21.IsLoaded = false;
                    elseif v27.Length > u21.TimeLength then
                        u21.TimeLength = v27.Length;
                    end;
                end;
            end;
            if u21.Audio and u21.Audio.TimeLength == 0 then
                u21.IsLoaded = false;
            end;
        end;
        u21.Loaded:Fire();
    end);
    u2.Cutscenes[p17] = u21;
    return u21;
end;
function u2.Setup(_) --[[ Line: 177 ]] end;
return u2;
