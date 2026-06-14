-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.ZombieOffenseTool
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Players");
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("ToolHandler");
local v2 = l__Mince__2:GetEvent("BossEvents");
local u3 = v2:Extend("StartSwingSignal");
local u4 = v2:Extend("GiveMyselfTargeting");
local u18 = {
    InteractBind = 500,
    Tags = { "SwordTool" },
    Activate = function(p5) --[[ Name: Activate, Line 21 ]]
        if not p5.Active then
            p5.Active = true;
            p5.Animations[p5:GetNextActionName()]:Play(0.2, 1, 1.6);
            return "Sink";
        end;
    end,
    GetNextActionName = function(p6) --[[ Name: GetNextActionName, Line 32 ]]
        p6.CursorPosition = p6.CursorPosition + 1;
        if p6.CursorPosition == 1 then
            return "Action";
        end;
        if p6.Animations[`Action{p6.CursorPosition}`] then
            return `Action{p6.CursorPosition}`;
        end;
        p6.CursorPosition = 1;
        return "Action";
    end,
    SetTrailsEnabled = function(p7, p8) --[[ Name: SetTrailsEnabled, Line 48 ]]
        for _, v9 in p7.Blade:GetDescendants() do
            if v9:IsA("Trail") then
                v9.Enabled = p8;
            end;
        end;
    end,
    Equipped = function(u10) --[[ Name: Equipped, Line 58 ]]
        -- upvalues: l__Mince__2 (copy), u4 (copy), u3 (copy)
        if l__Mince__2.Config.Humanoid then
            u10.Active = false;
            u10.CursorPosition = 0;
            u10.Blade = u10.Tool:WaitForChild("Blade");
            u10.Animations = {};
            u10.AnimationFolder = u10.Tool:FindFirstChild("Animations");
            for _, v11 in u10.AnimationFolder:GetChildren() do
                u10.Animations[v11.Name] = l__Mince__2.Config.Humanoid:LoadAnimation(v11);
            end;
            u4:Fire(true);
            local u12 = nil;
            local function v14(p13) --[[ Line: 72 ]]
                -- upvalues: u10 (copy), u3 (ref), u12 (ref)
                p13:AdjustSpeed(4);
                u10.EquipMaid:Add(p13:GetMarkerReachedSignal("StartSwing"):Connect(function() --[[ Line: 76 ]]
                    -- upvalues: u10 (ref), u3 (ref)
                    u10:SetTrailsEnabled(true);
                    u3:Fire(true);
                end));
                u10.EquipMaid:Add(p13:GetMarkerReachedSignal("EndSwing"):Connect(function() --[[ Line: 81 ]]
                    -- upvalues: u10 (ref), u3 (ref), u12 (ref)
                    u10:SetTrailsEnabled(false);
                    u3:Fire(false);
                    if u12 and coroutine.status(u12) == "suspended" then
                        task.cancel(u12);
                        u12 = nil;
                    end;
                    u12 = task.delay(0.25, function() --[[ Line: 89 ]]
                        -- upvalues: u10 (ref)
                        u10.Active = false;
                    end);
                end));
                u10.EquipMaid:Add(p13.Stopped:Connect(function() --[[ Line: 94 ]]
                    -- upvalues: u12 (ref), u10 (ref)
                    if u12 and coroutine.status(u12) == "suspended" then
                        task.cancel(u12);
                        u12 = nil;
                    end;
                    u10.Active = false;
                end));
            end;
            local v15 = u10:GetNextActionName();
            repeat
                v14(u10.Animations[v15]);
                v15 = u10:GetNextActionName();
            until v15 == "Action";
            u10.Animations.Idle:Play();
        end;
    end,
    Unequipped = function(p16) --[[ Name: Unequipped, Line 113 ]]
        -- upvalues: u4 (copy)
        u4:Fire(false);
        p16:SetTrailsEnabled(false);
        for _, v17 in p16.Animations do
            v17:Stop();
        end;
    end
};
function u18.Setup() --[[ Line: 122 ]]
    -- upvalues: u1 (copy), u18 (copy)
    u1.Component(u18);
end;
return u18;
