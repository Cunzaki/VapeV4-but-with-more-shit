-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Enemy.Indicators
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("PhysicsService");
local l__TweenService__2 = game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
local _ = game:GetService("Players").LocalPlayer;
local _ = script.Parent;
require(l__ReplicatedStorage__1.Modules.Mince):Get("SoundHandler");
local u1 = {
    LiveTime = 0.4,
    FadeTime = 0.1,
    UpwardForce = { 50, 50 },
    DirectionalForce = { -20, 20 }
};
function GenerateFloat(p2, p3)
    return math.random(p2 * 10000, p3 * 10000) / 10000;
end;
function u1.GenerateValue(p4) --[[ Line: 27 ]]
    return GenerateFloat(table.unpack(p4));
end;
function u1.UseNotifer(p5, p6, p7) --[[ Line: 32 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), l__RunService__3 (copy), l__TweenService__2 (copy)
    local u8 = l__ReplicatedStorage__1.Assets.Misc.Notifier:Clone();
    local u9 = {
        Age = 0,
        LifeTime = 0.4,
        FadeTime = 0.15,
        Part = u8,
        Values = {}
    };
    if p6 then
        u8.BillboardGui.Container.Label.TextColor = BrickColor.new(p6);
    end;
    u8.BillboardGui.Container.Label.Text = p7;
    u8.Position = p5;
    u8.Parent = game.Workspace;
    local u10 = u8.BodyVelocity.Velocity * 5;
    local l__Velocity__4 = u8.BodyVelocity.Velocity;
    local u11 = nil;
    u11 = l__RunService__3.Heartbeat:Connect(function(p12) --[[ Line: 55 ]]
        -- upvalues: u9 (copy), l__TweenService__2 (ref), u8 (copy), u10 (copy), l__Velocity__4 (copy), u11 (ref)
        local v13 = l__TweenService__2:GetValue(math.min(1, u9.Age / u9.LifeTime), Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
        u8.BodyVelocity.Velocity = u10:Lerp(l__Velocity__4, v13);
        local v14 = u9;
        v14.Age = v14.Age + p12;
        if u9.Age > u9.LifeTime then
            u8.BillboardGui.Container.GroupTransparency = (u9.Age - u9.LifeTime) / u9.FadeTime;
            if u9.Age > u9.LifeTime + u9.FadeTime then
                u8:Destroy();
                u11:Disconnect();
            end;
        end;
    end);
end;
function u1.NewIndicator(p15, p16, p17) --[[ Line: 79 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u1 (copy), l__RunService__3 (copy)
    local u18 = l__ReplicatedStorage__1.Assets.Models.Indicator:Clone();
    local v19 = u1.GenerateValue(u1.UpwardForce);
    local v20 = u1.GenerateValue(u1.DirectionalForce);
    local u21 = Vector3.new(v20, v19, u1.GenerateValue(u1.DirectionalForce));
    if p16 then
        u18.BillboardGui.Container.Label.TextColor = BrickColor.new(p16);
    end;
    u18.BillboardGui.Container.Label.Text = p17;
    u18.CollisionGroup = "NPC";
    u18.Position = p15;
    u18.Anchored = false;
    u18.Parent = game.Workspace;
    u18.BodyVelocity.Velocity = u21;
    local u22 = 0;
    local u23 = nil;
    u23 = l__RunService__3.Heartbeat:Connect(function(_) --[[ Line: 101 ]]
        -- upvalues: u22 (ref), u18 (copy), u21 (copy), u1 (ref), u23 (ref)
        local v24 = task.wait();
        u22 = u22 + v24;
        if u18.BodyVelocity.Velocity.Y > 0 then
            local l__BodyVelocity__5 = u18.BodyVelocity;
            l__BodyVelocity__5.Velocity = l__BodyVelocity__5.Velocity - u21.Unit * v24 * 250;
        else
            local l__BodyVelocity__6 = u18.BodyVelocity;
            l__BodyVelocity__6.Velocity = l__BodyVelocity__6.Velocity - u21.Unit * v24 * 20;
        end;
        if u22 > u1.LiveTime then
            local v25 = (u22 - u1.LiveTime) / (u1.FadeTime + u1.LiveTime);
            u18.BillboardGui.Container.Label.TextTransparency = v25;
            if v25 > 1 then
                u18:Destroy();
                u23:Disconnect();
            end;
        end;
    end);
end;
function u1.Setup() --[[ Line: 129 ]] end;
return u1;
