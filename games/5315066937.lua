local function getgev2()
    local v1 = game:GetService("Players")
    local v2 = game:GetService("RunService")
    local v3 = game:GetService("UserInputService")
    local v4 = game:GetService("VirtualInputManager")
    local v5 = game:GetService("TeleportService")
    local v6 = game:GetService("Lighting")
    local v7 = game:GetService("ReplicatedStorage")
    local v8 = game:GetService("Workspace")
    local v9 = v1.LocalPlayer
    local v10 = v9.Character or v9.CharacterAdded:Wait()
    local v11 = {
        Services = {
            Players = v1,
            RunService = v2,
            UserInputService = v3,
            VirtualInputManager = v4,
            TeleportService = v5,
            Lighting = v6,
            ReplicatedStorage = v7,
            Workspace = v8
        },
        LocalPlayer = v9,
        Character = v10,
        HumanoidRootPart = v10:WaitForChild("HumanoidRootPart"),
        Humanoid = v10:WaitForChild("Humanoid")
    }
    return v11
end

local function getRemote(name)
    local rs = game:GetService("ReplicatedStorage")
    local success, result = pcall(function()
        return rs:WaitForChild(name, 5)
    end)
    return success and result or nil
end

local function getGameModule(name)
    local ss = game:GetService("ReplicatedStorage"):WaitForChild("Shared", 5)
    if not ss then return nil end
    local success, result = pcall(function()
        for _, child in ss:GetChildren() do
            if child.Name == name and child:IsA("ModuleScript") then
                return require(child)
            end
        end
        return nil
    end)
    return success and result or nil
end

local function createSpeedExploit()
    local entity = getgev2()
    local services = entity.Services
    
    local SpeedExploit = {
        Enabled = false,
        Multiplier = 1.5,
        VerticalBoost = 0,
        AutoHopEnabled = false,
        LastJumpTime = 0,
        JumpCooldown = 0.03
    }
    
    local function getVelocity()
        local hrp = entity.HumanoidRootPart
        return hrp.AssemblyLinearVelocity
    end
    
    local function setVelocity(vec3)
        local hrp = entity.HumanoidRootPart
        hrp.AssemblyLinearVelocity = vec3
    end
    
    local function getHorizontalSpeed()
        local vel = getVelocity()
        return math.sqrt(vel.X * vel.X + vel.Z * vel.Z)
    end
    
    local function getGroundState()
        local hrp = entity.HumanoidRootPart
        return hrp.IsGround
    end
    
    SpeedExploit.ApplySpeed = function()
        if not SpeedExploit.Enabled then return end
        local hrp = entity.HumanoidRootPart
        local currentVel = getVelocity()
        local horizontalSpeed = math.sqrt(currentVel.X * currentVel.X + currentVel.Z * currentVel.Z)
        local targetSpeed = horizontalSpeed * SpeedExploit.Multiplier
        if targetSpeed > 1 then
            local scale = targetSpeed / horizontalSpeed
            local newVel = Vector3.new(
                currentVel.X * scale,
                currentVel.Y + SpeedExploit.VerticalBoost,
                currentVel.Z * scale
            )
            setVelocity(newVel)
        end
    end
    
    SpeedExploit.AutoHop = function()
        if not SpeedExploit.AutoHopEnabled then return end
        local now = tick()
        if now - SpeedExploit.LastJumpTime < SpeedExploit.JumpCooldown then return end
        local hrp = entity.HumanoidRootPart
        if hrp and hrp.IsGround then
            SpeedExploit.LastJumpTime = now
            return true
        end
        return false
    end
    
    return SpeedExploit
end

local SpeedExploitModule = {
    Name = "SpeedExploit",
    CreateModule = function(self, api)
        local mod = createSpeedExploit()
        mod.Api = api
        return mod
    end
}

local function createVelocityExploit()
    local entity = getgev2()
    local services = entity.Services
    
    local VelocityExploit = {
        Enabled = false,
        BaseSpeed = 50,
        BoostMultiplier = 1.0,
        GravityMultiplier = 1.0,
        GroundFriction = 0.5,
        AirFriction = 0.02,
        TickRate = 60
    }
    
    local lastTick = 0
    local velocityHistory = {}
    
    VelocityExploit.ProcessTick = function(dt)
        if not VelocityExploit.Enabled then return end
        local hrp = entity.HumanoidRootPart
        if not hrp then return end
        local currentVel = hrp.AssemblyLinearVelocity
        local isGrounded = hrp.IsGround
        local friction = isGrounded and VelocityExploit.GroundFriction or VelocityExploit.AirFriction
        local frictionForce = currentVel * friction * dt * VelocityExploit.TickRate
        local newVel = currentVel - frictionForce
        newVel = newVel + Vector3.new(0, -50 * dt * VelocityExploit.GravityMultiplier, 0)
        local horizontalSpeed = math.sqrt(newVel.X * newVel.X + newVel.Z * newVel.Z)
        if horizontalSpeed > VelocityExploit.BaseSpeed then
            local scale = VelocityExploit.BaseSpeed / horizontalSpeed
            newVel = Vector3.new(newVel.X * scale, newVel.Y, newVel.Z * scale)
        else
            local boost = VelocityExploit.BoostMultiplier
            newVel = Vector3.new(newVel.X * boost, newVel.Y * boost, newVel.Z * boost)
        end
        hrp.AssemblyLinearVelocity = newVel
    end
    
    return VelocityExploit
end

local VelocityExploitModule = {
    Name = "VelocityExploit",
    CreateModule = function(self, api)
        local mod = createVelocityExploit()
        mod.Api = api
        return mod
    end
end

local function createBHopExploit()
    local entity = getgev2()
    local services = entity.Services
    
    local BHopExploit = {
        Enabled = false,
        AutoJump = false,
        JumpDelay = 0,
        VelocityRetention = 1.0,
        MinHeight = 3,
        PerfectSync = false,
        SyncAngle = 90,
        LastJumpTime = 0
    }
    
    local function getMouse()
        return services.UserInputService:GetMouseLocation()
    end
    
    local function isMoving()
        local hrp = entity.HumanoidRootPart
        local vel = hrp.AssemblyLinearVelocity
        local speed = math.sqrt(vel.X * vel.X + vel.Z * vel.Z)
        return speed > 1
    end
    
    BHopExploit.ShouldJump = function()
        if not BHopExploit.Enabled then return false end
        local hrp = entity.HumanoidRootPart
        if not hrp then return false end
        local now = tick()
        if now - BHopExploit.LastJumpTime < BHopExploit.JumpDelay then return false end
        if hrp.IsGround then
            local vel = hrp.AssemblyLinearVelocity
            local speed = math.sqrt(vel.X * vel.X + vel.Z * vel.Z)
            if speed > 5 then
                BHopExploit.LastJumpTime = now
                return true
            end
        end
        return false
    end
    
    BHopExploit.GetStrafeAngle = function()
        local hrp = entity.HumanoidRootPart
        local vel = hrp.AssemblyLinearVelocity
        local cam = services.Workspace.CurrentCamera
        if not cam then return 0 end
        local lookCFrame = CFrame.new((hrp.Position), cam.CFrame.Position)
        local lookAngle = math.atan2(lookCFrame.LookVector.Z, lookCFrame.LookVector.X)
        local moveAngle = math.atan2(vel.Z, vel.X)
        local angleDiff = math.deg(moveAngle - lookAngle)
        return angleDiff
    end
    
    return BHopExploit
end

local BHopExploitModule = {
    Name = "BHopExploit",
    CreateModule = function(self, api)
        local mod = createBHopExploit()
        mod.Api = api
        return mod
    end
end

local function createTeleportExploit()
    local entity = getgev2()
    local services = entity.Services
    
    local TeleportExploit = {
        Enabled = false,
        TargetPosition = nil,
        SmoothTeleport = false,
        TeleportDelay = 0
    }
    
    TeleportExploit.TeleportTo = function(pos)
        local hrp = entity.HumanoidRootPart
        if not hrp then return end
        if TeleportExploit.SmoothTeleport then
            local startPos = hrp.Position
            local steps = 5
            for i = 1, steps do
                local t = i / steps
                local newPos = startPos:Lerp(pos, t)
                hrp.CFrame = CFrame.new(newPos)
                services.RunService.Heartbeat:Wait()
            end
        else
            hrp.CFrame = CFrame.new(pos)
        end
    end
    
    TeleportExploit.TeleportToPlayer = function(playerName)
        local targetPlayer = nil
        for _, player in services.Players:GetPlayers() do
            if player.Name:lower():find(playerName:lower()) == 1 then
                targetPlayer = player
                break
            end
        end
        if targetPlayer and targetPlayer.Character then
            local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                TeleportExploit.TeleportTo(hrp.Position)
            end
        end
    end
    
    return TeleportExploit
end

local TeleportExploitModule = {
    Name = "TeleportExploit",
    CreateModule = function(self, api)
        local mod = createTeleportExploit()
        mod.Api = api
        return mod
    end
end

return {
    Name = "5315066937",
    SpeedExploit = SpeedExploitModule,
    VelocityExploit = VelocityExploitModule,
    BHopExploit = BHopExploitModule,
    TeleportExploit = TeleportExploitModule
}
