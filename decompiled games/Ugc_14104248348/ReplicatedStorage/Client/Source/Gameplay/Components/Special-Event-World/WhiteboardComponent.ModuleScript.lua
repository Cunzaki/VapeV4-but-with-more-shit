-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Special-Event-World.WhiteboardComponent
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__ContextActionService__3 = game:GetService("ContextActionService");
local l__CurrentCamera__4 = workspace.CurrentCamera;
local l__Mince__5 = require(l__ReplicatedStorage__2.Modules.Mince);
local u1 = l__Mince__5:Get("SelectInteractor");
local u2 = l__Mince__5:Get("Notices");
local u3 = l__Mince__5:Get("InterfaceHandler");
local u4 = l__Mince__5:Get("ConfirmPrompt");
local u5 = l__Mince__5:Get("NotifPrompt");
local u6 = l__Mince__5:Get("Settings");
local u7 = l__Mince__5:Get("TriggerHandler");
local u8 = l__Mince__5:Get("Locomotion");
local u9 = l__Mince__5:GetEvent("WhiteboardInteract");
local v10 = l__Mince__5.Component({
    Tag = "Whiteboard"
});
local u11 = {};
function v10.GenerateUID(_) --[[ Line: 29 ]]
    -- upvalues: u11 (copy)
    local v12;
    repeat
        v12 = math.random(1, 100000000);
    until not u11[v12];
    u11[v12] = true;
    return v12;
end;
function v10.CreateStrokePart(p13, p14, p15) --[[ Line: 40 ]]
    local v16 = Instance.new("Part");
    v16.Size = Vector3.new(0, 0.05, 0.05);
    v16.Position = p14;
    v16.Anchored = true;
    v16.CanCollide = false;
    if not p15 then
        v16.Transparency = 1;
        v16.Color = p13.SelectedColor;
        v16.Parent = p13.Container;
        return v16;
    end;
    local l__Magnitude__6 = (p14 - p15.Position).Magnitude;
    local v17 = CFrame.lookAt(p14, p15.Position);
    v16.Transparency = 0;
    v16.Size = Vector3.new(0, 0.05, l__Magnitude__6);
    v16.CFrame = v17 * CFrame.new(0, 0, -l__Magnitude__6 / 2);
    v16.Color = p15.Color;
    v16.Parent = p15.Container;
    return v16;
end;
function v10.Cast(p18, p19, p20) --[[ Line: 66 ]]
    -- upvalues: l__CurrentCamera__4 (copy)
    local v21 = l__CurrentCamera__4:ScreenPointToRay(p19.X, p19.Y);
    local v22 = RaycastParams.new();
    v22.FilterType = Enum.RaycastFilterType.Include;
    v22.FilterDescendantsInstances = p20 or { p18.Board };
    return workspace:Raycast(v21.Origin, v21.Direction * 100, v22);
end;
function v10.Reset(p23) --[[ Line: 75 ]]
    -- upvalues: u9 (copy)
    p23.HoldingDown = false;
    if #p23.Vectors > 0 then
        local l__Vectors__7 = p23.Vectors;
        local v24 = {
            pos = p23.Vectors[math.max(1, #p23.Vectors - 1)].pos
        };
        table.insert(l__Vectors__7, v24);
        u9:Fire(p23.Instance, "draw", {
            Name = p23.Container.Name,
            Color = p23.SelectedColor,
            Vectors = p23.Vectors
        });
    else
        for _, v25 in p23.Vectors do
            if v25.inst then
                v25.inst:Destroy();
            end;
        end;
    end;
    p23.Vectors = {};
end;
function v10.Draw(p26, p27) --[[ Line: 101 ]]
    if p26.LimitReached then
    else
        local v28 = p26.Vectors[#p26.Vectors];
        local l__pos__8 = v28.pos;
        local v29 = p26:Cast(p27.Position);
        if v29 then
            local v30 = false;
            local l__Position__9 = v29.Position;
            local l__Magnitude__10 = (l__pos__8 - l__Position__9).Magnitude;
            local v31 = CFrame.lookAt(l__pos__8, l__Position__9);
            local v32 = l__Position__9.Unit:Dot(l__pos__8.Unit);
            local v33 = math.acos(v32);
            if not v28.rot then
                v28.rot = math.deg(v33);
            end;
            local v34 = p26.LastRotation and p26.LastRotation > 0.02 and true or (v28.rot and v33 > 0.02 and true or v30);
            p26.LastRotation = math.deg(v33);
            if #p26.Vectors > 249 then
                warn("MAX SEGMENTS REACHED");
                p26:Reset();
            end;
            if l__Magnitude__10 > 0.1 and v34 then
                local l__Vectors__11 = p26.Vectors;
                local v35 = {
                    pos = l__Position__9,
                    inst = p26:CreateStrokePart(l__Position__9)
                };
                table.insert(l__Vectors__11, v35);
            end;
            v28.inst.Transparency = 0;
            v28.inst.Size = Vector3.new(0, 0.05, l__Magnitude__10);
            v28.inst.CFrame = v31 * CFrame.new(0, 0, -l__Magnitude__10 / 2);
            p26.LastDraw = os.clock();
        end;
    end;
end;
function v10.Erase(p36, p37) --[[ Line: 152 ]]
    -- upvalues: u9 (copy)
    local v38 = p36:Cast(p37.Position, { p36.MainContainer });
    if v38 then
        local l__Parent__12 = v38.Instance.Parent;
        u9:Fire(p36.Instance, "erase", l__Parent__12.Name);
        l__Parent__12:Destroy();
    end;
end;
function v10.ListenToInput(u39, _, p40, p41) --[[ Line: 166 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u4 (copy), u9 (copy), u6 (copy), u5 (copy), u2 (copy)
    if not u39.InProximity then
        return Enum.ContextActionResult.Pass;
    end;
    if p40 == Enum.UserInputState.Begin then
        if u39.Inspect.Visible then
            local l__Text__13 = u39.Inspect.TextLabel.Text;
            if l__Text__13 ~= l__LocalPlayer__1.Name then
                u4.Display(`Would you like to report {l__Text__13} for drawing an inappropriate sketch?`, function() --[[ Line: 177 ]]
                    -- upvalues: u39 (copy), u9 (ref), l__Text__13 (copy)
                    print("Sending", u39.Instance:GetAttribute("_id"));
                    u9:Fire(u39.Instance, "report", l__Text__13);
                end);
            end;
        end;
        local v42 = u39:Cast(p41.Position);
        if v42 then
            local l__Position__14 = v42.Position;
            u39.Vectors = {};
            if u39.Mode == "Marker" then
                if not u6.GetValue("Whiteboard") then
                    u5.Display("You can only make drawings that abide by roblox community standards, do you understand?", function() --[[ Line: 199 ]]
                        -- upvalues: u6 (ref)
                        u6.ChangeSetting("Whiteboard", true);
                    end);
                end;
                if u39.LimitReached then
                    u2.Error("You\'ve been limited! Erase some of your strokes!");
                else
                    u39.Container = Instance.new("Model");
                    u39.Container.Name = u39:GenerateUID();
                    u39.Container.Parent = u39.MainContainer;
                    u39.Vectors[1] = {
                        pos = l__Position__14,
                        inst = u39:CreateStrokePart(l__Position__14)
                    };
                end;
            end;
            u39.HoldingDown = true;
        end;
    elseif p40 == Enum.UserInputState.End then
        u39:Reset();
    end;
    u39.Empty = #u39.MainContainer:GetChildren() == 0;
    return Enum.ContextActionResult.Pass;
end;
function v10.UpdateInput(p43, _, p44, p45) --[[ Line: 229 ]]
    -- upvalues: u8 (copy), l__CurrentCamera__4 (copy), u9 (copy)
    if not p43.InProximity then
        return Enum.ContextActionResult.Pass;
    end;
    if p44 == Enum.UserInputState.Change then
        if p43.HoldingDown then
            p43.Inspect.Visible = false;
            if p43.Mode == "Marker" then
                p43:Draw(p45);
            else
                p43:Erase(p45);
            end;
            u8.SetEnabled(false);
            l__CurrentCamera__4.CameraType = Enum.CameraType.Scriptable;
            return Enum.ContextActionResult.Sink;
        end;
        local v46 = p43:Cast(p45.Position, { p43.Instance.Container });
        if v46 then
            p43.Inspect.TextLabel.Text = v46.Instance.Parent.Parent.Name;
            p43.Inspect.Position = UDim2.fromOffset(p45.Position.X, p45.Position.Y);
            p43.Inspect.Visible = true;
        else
            p43.Inspect.Visible = false;
        end;
        u8.SetEnabled(true);
        l__CurrentCamera__4.CameraType = Enum.CameraType.Custom;
    end;
    if not p43.Empty and os.clock() - p43.LastDraw > 240 then
        u9:Fire(p43.Instance, "reset");
        p43.MainContainer:ClearAllChildren();
        p43.Empty = true;
    end;
    return Enum.ContextActionResult.Pass;
end;
function v10.Construct(u47) --[[ Line: 281 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u3 (copy), u1 (copy), u7 (copy), l__ContextActionService__3 (copy), u8 (copy), u9 (copy)
    u47.Vectors = {};
    u47.Cache = {};
    u47.Mode = "Marker";
    u47._id = u47.Instance:GetAttribute("_id");
    u47.Board = u47.Instance.PrimaryPart;
    u47.Tools = u47.Instance.Tools;
    u47.MainContainer = Instance.new("Model");
    u47.MainContainer.Name = l__LocalPlayer__1.Name;
    u47.MainContainer.Parent = u47.Instance.Container;
    u47.MainPriority = u3.GetScreenGui("MainPriority");
    u47.Inspect = u47.MainPriority.BoardInspect;
    u47.LastDraw = os.clock();
    for v48, u49 in u47.Tools:GetChildren() do
        if v48 == 1 then
            u47.SelectedColor = u49.Color;
        end;
        local u50 = u49:GetAttribute("Type");
        local v52 = {
            HoverName = `Select {u49.BrickColor.Name} {u50:lower()}`,
            Target = u49,
            HitCollider = u49,
            Interact = function(_, p51) --[[ Name: Interact, Line 310 ]]
                -- upvalues: u47 (copy), u50 (copy), u49 (copy)
                u47.Mode = u50;
                u47.SelectedColor = u49.Color;
                p51();
            end
        };
        u1.NewInteractionClass(v52);
    end;
    u47.Trigger = u7.GetTrigger(u47._id .. "WhiteboardClear");
    u47.Trigger.Entered:Connect(function() --[[ Line: 320 ]]
        -- upvalues: l__ContextActionService__3 (ref), u47 (copy)
        l__ContextActionService__3:BindAction("WhiteboardWrite" .. u47._id, function(...) --[[ Line: 323 ]]
            -- upvalues: u47 (ref)
            return u47:ListenToInput(...);
        end, false, Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch);
        l__ContextActionService__3:BindAction("WhiteboardUpdate" .. u47._id, function(...) --[[ Line: 333 ]]
            -- upvalues: u47 (ref)
            return u47:UpdateInput(...);
        end, false, Enum.UserInputType.MouseMovement, Enum.UserInputType.Touch);
        u47.InProximity = true;
    end);
    u47.Trigger.Leaved:Connect(function() --[[ Line: 344 ]]
        -- upvalues: l__ContextActionService__3 (ref), u47 (copy), u8 (ref)
        l__ContextActionService__3:UnbindAction("WhiteboardWrite" .. u47._id);
        l__ContextActionService__3:UnbindAction("WhiteboardUpdate" .. u47._id);
        u47.InProximity = false;
        u47.Inspect.Visible = false;
        u8.SetEnabled(true);
    end);
    u9.Event:Connect(function(p53, p54, p55, ...) --[[ Line: 353 ]]
        -- upvalues: u47 (copy), l__LocalPlayer__1 (ref)
        if u47.Instance == p53 and p54 ~= l__LocalPlayer__1 then
            if p55 == "draw" then
                local v56 = ...;
                if not u47.Instance.Container:FindFirstChild(p54.Name) then
                    local v57 = Instance.new("Model");
                    v57.Name = p54.Name;
                    v57.Parent = u47.Instance.Container;
                end;
                local v58 = u47.Instance.Container[p54.Name];
                local v59 = Instance.new("Model");
                v59.Name = v56.Name;
                v59.Parent = v58;
                for v60 = 1, #v56.Vectors - 1 do
                    u47:CreateStrokePart(v56.Vectors[v60].pos, {
                        Position = v56.Vectors[v60 + 1].pos,
                        Container = v59,
                        Color = v56.Color
                    });
                end;
            else
                if p55 == "erase" then
                    local v61 = u47.Instance.Container:FindFirstChild(p54.Name);
                    local v62 = v61 and v61:FindFirstChild((...));
                    if v62 then
                        v62:Destroy();
                    end;
                else
                    if p55 == "limit" then
                        u47.LimitReached = ...;
                        return;
                    end;
                    local v63 = p55 == "reset" and u47.Instance.Container:FindFirstChild(p54.Name);
                    if v63 then
                        v63:ClearAllChildren();
                    end;
                end;
            end;
        end;
    end);
end;
return v10;
