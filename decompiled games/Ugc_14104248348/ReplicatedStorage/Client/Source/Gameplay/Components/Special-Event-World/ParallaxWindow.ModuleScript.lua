-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.ParallaxWindow
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__Players__3 = game:GetService("Players");
game:GetService("GuiService");
local l__Lighting__4 = game:GetService("Lighting");
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
require(l__ReplicatedStorage__1.Modules.Signal);
local l__Util__6 = require(script.Util);
local u1 = l__Mince__5:Get("TriggerHandler");
local l__LocalPlayer__7 = l__Players__3.LocalPlayer;
local u2 = {
    __IsAsyncSetup = true,
    Radius = 200,
    UpdateRateFalloff = 4,
    Quality = 1024,
    MidQuality = 30,
    LowQuality = 15,
    HighQualityThreshold = 35,
    MidQualityThreshold = 70
};
local u3 = l__Mince__5.Component({
    Tag = "ParallaxWindow"
});
local u4 = CFrame.fromEulerAngles(0, 3.141592653589793, 0);
function u2.Setup() --[[ Line: 40 ]]
    -- upvalues: u2 (copy), l__ReplicatedStorage__1 (copy), l__Mince__5 (copy), u1 (copy), u3 (copy), l__RunService__2 (copy)
    u2.LastUpdate = tick();
    u2.Rooms = l__ReplicatedStorage__1.Assets:WaitForChild("ParallaxRooms").Normal:GetChildren();
    u2.LargeRooms = l__ReplicatedStorage__1.Assets:WaitForChild("ParallaxRooms").Long:GetChildren();
    u2.Special = l__ReplicatedStorage__1.Assets:WaitForChild("ParallaxRooms").Special;
    l__Mince__5.Config.Stats.Parallax = { 150, "IDLE" };
    local v5 = u1.GetTrigger("ParallaxArea");
    v5.Leaved:Connect(function() --[[ Line: 50 ]]
        -- upvalues: u2 (ref), u3 (ref)
        u2.IsEnabled = false;
        if u2.__UpdateEvent then
            u2.__UpdateEvent:Disconnect();
            u2.__UpdateEvent = nil;
        end;
        for _, v6 in u3:GetAll() do
            v6:Hide();
        end;
    end);
    v5.Entered:Connect(function() --[[ Line: 62 ]]
        -- upvalues: u2 (ref), l__RunService__2 (ref)
        u2.IsEnabled = true;
        if u2.__UpdateEvent then
            u2.__UpdateEvent:Disconnect();
            u2.__UpdateEvent = nil;
        end;
        u2.__UpdateEvent = l__RunService__2.RenderStepped:Connect(u2.Update);
    end);
end;
function u2.Update() --[[ Line: 74 ]]
    -- upvalues: u3 (copy), u2 (copy), u4 (copy), l__Util__6 (copy), l__Mince__5 (copy)
    debug.profilebegin("Parallax Window Update");
    local v7 = os.clock();
    local l__CurrentCamera__8 = game.Workspace.CurrentCamera;
    local v8 = u3:GetAll();
    local v9 = l__CurrentCamera__8:GetRenderCFrame();
    for _, v10 in v8 do
        if v10.Running then
            if u2.IsEnabled then
                local l__Base__9 = v10.Base;
                local l__Camera__10 = v10.Camera;
                if (l__Base__9.Position - v9.Position).Magnitude >= u2.Radius - 1 then
                    v10:Hide();
                else
                    local v11 = v10.Surface:ToObjectSpace(v9);
                    if v11.Z > 0 then
                        v10:Hide();
                    else
                        u2.SlowUpdate(l__CurrentCamera__8, v10);
                        if u2.ShouldUpdate(l__CurrentCamera__8, v10) then
                            v10:Show();
                            local l__RoomOrigin__11 = v10.RoomOrigin;
                            for v12, v13 in l__Util__6.ComputeCamData(l__RoomOrigin__11 * u4 * v11, l__RoomOrigin__11 * u4, v10.SurfaceSize, l__CurrentCamera__8) do
                                l__Camera__10[v12] = v13;
                            end;
                        end;
                    end;
                end;
            else
                v10:Hide();
            end;
        end;
    end;
    l__Mince__5.Config.Stats.Parallax[2] = `LastFrameTime -> {os.clock() - v7}, WindowCount:{#v8}`;
    debug.profileend();
end;
function u2.ShouldUpdate(_, p14) --[[ Line: 127 ]]
    -- upvalues: u2 (copy)
    local l__Magnitude__12 = (p14.Surface.Position - workspace.CurrentCamera:GetRenderCFrame().Position).Magnitude;
    if (l__Magnitude__12 > u2.Radius and 20 or l__Magnitude__12 / u2.Radius * u2.UpdateRateFalloff) > p14.Frame then
        return false;
    end;
    p14.Frame = 0;
    return true;
end;
function u2.SlowUpdate(p15, p16) --[[ Line: 142 ]]
    -- upvalues: l__Util__6 (copy), u2 (copy)
    p16.Frame = p16.Frame + 1;
    if tick() - p16.LastUpdate < 1 + p16.Index * 0.001 then
    else
        p16.LastUpdate = tick();
        local v17, v18 = l__Util__6.WorldToScreenPoint(p15, p16.Surface);
        local l__Y__13 = Vector3.new(v18:ToOrientation()).Y;
        local v19 = math.deg(l__Y__13);
        if math.abs(v19) < 1500 / p15.FieldOfView + 18 then
            p16:Hide();
            return true;
        end;
        local v20 = l__Util__6.WorldToScreenSize(p15, p16.Surface.Position, p16.SurfaceSize.Magnitude);
        if not l__Util__6.IsCircleVisible(v17, v20 / 2, p15) then
            p16:Hide();
            return true;
        end;
        local l__Magnitude__14 = (p16.Surface.Position - workspace.CurrentCamera:GetRenderCFrame().Position).Magnitude;
        p16.Gui.PixelsPerStud = l__Magnitude__14 <= u2.HighQualityThreshold and u2.Quality or (l__Magnitude__14 <= u2.MidQualityThreshold and u2.MidQuality or u2.LowQuality);
    end;
end;
function u3.Show(p21) --[[ Line: 171 ]]
    if not p21.Visible then
        for _, v22 in p21.Extras do
            v22.Transparency = 0.9;
            v22.CanCollide = false;
        end;
        p21.Visible = true;
    end;
    if not p21.Gui.Enabled then
        p21.Gui.Enabled = true;
    end;
end;
function u3.Hide(p23) --[[ Line: 186 ]]
    if p23.Visible then
        for _, v24 in p23.Extras do
            v24.Transparency = 0;
            v24.CanCollide = false;
        end;
        p23.Visible = false;
    end;
    if p23.Gui.Enabled then
        p23.Gui.Enabled = false;
    end;
end;
function u3.Construct(p25) --[[ Line: 201 ]]
    -- upvalues: u2 (copy), l__Util__6 (copy), l__Lighting__4 (copy), l__LocalPlayer__7 (copy), u3 (copy)
    repeat
        task.wait();
    until u2.Rooms;
    local l__Instance__15 = p25.Instance;
    l__Instance__15.CanCollide = true;
    p25.Visible = false;
    p25.Extras = p25.Instance:FindFirstChild("Extras");
    if p25.Extras then
        p25.ExtrasClone = p25.Extras:Clone();
        p25.ExtrasClone.Parent = game.Workspace;
        for _, v26 in p25.ExtrasClone:GetChildren() do
            v26.Anchored = true;
            v26.CanCollide = true;
            v26.Transparency = 1;
        end;
        p25.Extras = p25.Extras:GetChildren();
    end;
    p25.Extras = p25.Extras or {};
    local v27 = math.cos(l__Instance__15.Position.Magnitude) * 100000;
    local v28 = math.floor(v27);
    local v29 = Random.new(v28);
    local v30, v31 = l__Util__6.GetSurfaceInfo(l__Instance__15);
    local _ = l__Lighting__4.Ambient;
    local v32 = l__Instance__15.Size.X > 20;
    local v33 = Instance.new("SurfaceGui");
    v33.Parent = l__LocalPlayer__7.PlayerGui;
    v33.ResetOnSpawn = false;
    v33.Adornee = l__Instance__15;
    v33.Face = Enum.NormalId.Front;
    v33.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
    v33.PixelsPerStud = 5;
    v33.ClipsDescendants = true;
    v33.LightInfluence = 0;
    v33.MaxDistance = u2.Radius;
    v33.Name = "WindowParallax";
    local v34 = Instance.new("Camera");
    v34.Parent = v33;
    v34.CameraType = Enum.CameraType.Scriptable;
    local u35 = Instance.new("ViewportFrame");
    u35.Parent = v33;
    u35.CurrentCamera = v34;
    u35.Size = UDim2.fromScale(1, 1);
    u35.Position = UDim2.fromScale(0, 0);
    u35.AnchorPoint = Vector2.zero;
    u35.BackgroundTransparency = 1;
    u35.ImageTransparency = 0.15;
    u35.LightColor = Color3.new(1, 1, 1);
    u35.LightDirection = -l__Lighting__4:GetSunDirection();
    u35.Ambient = Color3.new((l__Lighting__4.Ambient.R + 1) / 2, (l__Lighting__4.Ambient.G + 1) / 2, (l__Lighting__4.Ambient.B + 1) / 2);
    local v36;
    if l__Instance__15:GetAttribute("Special") then
        v36 = u2.Special[l__Instance__15:GetAttribute("Special")]:Clone();
    else
        v36 = v32 and u2.LargeRooms[v29:NextInteger(1, #u2.LargeRooms)]:Clone() or u2.Rooms[v29:NextInteger(1, #u2.Rooms)]:Clone();
    end;
    v36.Parent = u35;
    p25.Camera = v34;
    p25.Base = l__Instance__15;
    p25.RoomOrigin = v36.PrimaryPart.CFrame;
    p25.Viewport = u35;
    p25.Running = true;
    p25.Visibility = 0;
    p25.Gui = v33;
    p25.Surface = v30;
    p25.Frame = 0;
    p25.LastUpdate = tick();
    p25.SurfaceSize = v31;
    p25.Index = #u3:GetAll() + 1;
    v36.PrimaryPart:Destroy();
    p25.LightingConnection = l__Lighting__4:GetPropertyChangedSignal("Ambient"):Connect(function() --[[ Line: 287 ]]
        -- upvalues: u35 (copy), l__Lighting__4 (ref)
        u35.Ambient = Color3.new((l__Lighting__4.Ambient.R + 1) / 2, (l__Lighting__4.Ambient.G + 1) / 2, (l__Lighting__4.Ambient.B + 1) / 2);
    end);
end;
return u2;
