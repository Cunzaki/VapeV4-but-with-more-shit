-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.State.DefaultCursorService
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Workspace__1 = game:GetService("Workspace");
local l__StarterGui__2 = game:GetService("StarterGui");
local l__RunService__3 = game:GetService("RunService");
local u1 = {};
u1.__index = u1;
local u2 = nil;
function u1.new() --[[ Line: 25 ]]
    -- upvalues: l__StarterGui__2 (copy), l__RunService__3 (copy), l__Workspace__1 (copy), u1 (copy)
    return setmetatable({
        CursorOptionsList = { "Detect", "Enabled", "Disabled" },
        CursorOptions = {
            Detect = function() --[[ Name: Detect, Line 29 ]]
                -- upvalues: l__StarterGui__2 (ref), l__RunService__3 (ref), l__Workspace__1 (ref)
                l__StarterGui__2:SetCore("VRLaserPointerMode", "Pointer");
                l__RunService__3.Stepped:Wait();
                l__RunService__3:BindToRenderStep("NexusVRCharacterModel_MoveCursorWorkaround", Enum.RenderPriority.Last.Value + 1, function() --[[ Line: 38 ]]
                    -- upvalues: l__Workspace__1 (ref)
                    local v3 = l__Workspace__1.CurrentCamera:FindFirstChild("VRCoreEffectParts");
                    if v3 then
                        local v4 = v3:FindFirstChild("LaserPointerOrigin");
                        local v5 = v3:FindFirstChild("Cursor");
                        if v4 and v5 then
                            local v6 = v5:FindFirstChild("CursorSurfaceGui");
                            if v6 and not v6.Enabled then
                                v4.CFrame = CFrame.new(0, (1 / 0), 0);
                            end;
                        end;
                    end;
                end);
            end,
            Enabled = function() --[[ Name: Enabled, Line 53 ]]
                -- upvalues: l__StarterGui__2 (ref)
                l__StarterGui__2:SetCore("VRLaserPointerMode", "Pointer");
            end,
            Disabled = function() --[[ Name: Disabled, Line 56 ]]
                -- upvalues: l__StarterGui__2 (ref)
                l__StarterGui__2:SetCore("VRLaserPointerMode", "Disabled");
            end
        },
        CursorDisabledOptions = {
            Detect = function() --[[ Name: Detect, Line 61 ]]
                -- upvalues: l__RunService__3 (ref)
                l__RunService__3:UnbindFromRenderStep("NexusVRCharacterModel_MoveCursorWorkaround");
            end
        }
    }, u1);
end;
function u1.GetInstance() --[[ Line: 71 ]]
    -- upvalues: u2 (ref), u1 (copy)
    if not u2 then
        u2 = u1.new();
    end;
    return u2;
end;
function u1.SetCursorState(p7, p8) --[[ Line: 81 ]]
    if p7.CurrentCursorState == p8 then
    else
        if p7.CurrentCursorState and p7.CursorDisabledOptions[p7.CurrentCursorState] then
            p7.CursorDisabledOptions[p7.CurrentCursorState]();
        end;
        p7.CurrentCursorState = p8;
        task.spawn(p7.CursorOptions[p8]);
    end;
end;
return u1;
