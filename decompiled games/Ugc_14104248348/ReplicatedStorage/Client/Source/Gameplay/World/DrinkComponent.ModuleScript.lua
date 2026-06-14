-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.DrinkComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
require(l__ReplicatedStorage__1.Modules.Maid);
local l__Mince__2 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__2:Get("Settings");
local u2 = l__Mince__2:Get("SoundHandler");
local u3 = l__Mince__2.Component({
    Tag = "Drink"
});
function u3.ReplicateChangeState(p4, p5) --[[ Line: 18 ]]
    -- upvalues: u2 (copy)
    if p5 == "ItemIsBurnt" then
        for _, v6 in p4.Sounds do
            v6:Destroy();
        end;
        local v7 = u2.PlaySoundAt("grill_explode", p4.HitCollider, { 5, 35 });
        if v7 then
            table.insert(p4.Sounds, v7);
        end;
        for _, v8 in p4.Instance:GetChildren() do
            if v8:IsA("BasePart") and v8.Transparency < 1 then
                v8.Color = Color3.new(0, 0, 0);
            end;
        end;
        for _, v9 in game.ReplicatedStorage.Assets.Particles.GrillFire2:GetChildren() do
            v9:Clone().Parent = p4.Handle;
        end;
    end;
    if p5 == "Clear" then
        for _, v10 in p4.Sounds do
            v10:Destroy();
        end;
    end;
end;
function u3.Work(p11) --[[ Line: 43 ]]
    p11.Job = p11.Job or 0;
    p11.Job = p11.Job + 1;
    if p11.Job > 100 then
        p11.Job = 0;
        task.wait();
    end;
end;
function u3.Construct(u12) --[[ Line: 49 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u3 (copy), u1 (copy)
    u12.Handle = u12.Instance:WaitForChild("Handle");
    u12.Sounds = {};
    u12.Instance:GetAttributeChangedSignal("DrinkState"):Connect(function() --[[ Line: 53 ]]
        -- upvalues: u12 (copy)
        u12:ReplicateChangeState(u12.Instance:GetAttribute("DrinkState"));
    end);
    if u12.Instance.Parent == l__ReplicatedStorage__1.Assets.Tools then
        u12.Invalid = true;
    end;
    u12.CurrentMode = 1;
    task.wait();
    u3.SetMode(u12, u1.GetValue("GraphicMode"));
end;
function u3.SetMode(p13, p14) --[[ Line: 66 ]]
    if p13.Invalid then
    elseif p13.Instance.Parent and p13.Instance.Parent:IsA("ViewportFrame") then
    elseif p14 == 1 or p14 == 2 then
        for _, v15 in p13.Instance:GetChildren() do
            if v15:IsA("BasePart") and v15.Transparency > 0 then
                v15.LocalTransparencyModifier = 0;
            end;
        end;
    else
        if p14 == 33 then
            for _, v16 in p13.Instance:GetChildren() do
                if v16:IsA("BasePart") and v16.Transparency > 0 then
                    v16.LocalTransparencyModifier = -2;
                end;
            end;
        end;
    end;
end;
function u3.Setup(_) --[[ Line: 85 ]]
    -- upvalues: u1 (copy), u3 (copy)
    u1.SettingChanged("GraphicMode"):Connect(function(p17) --[[ Line: 86 ]]
        -- upvalues: u3 (ref)
        for _, v18 in u3:GetAll() do
            u3.SetMode(v18, p17);
            u3:Work();
        end;
    end);
end;
return u3;
