-- Decompiled from: ReplicatedStorage.Modules.VRBottomBar
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Workspace__1 = game:GetService("Workspace");
local l__Players__2 = game:GetService("Players");
local l__RunService__3 = game:GetService("RunService");
local l__TopbarPlusContext__4 = require(script:WaitForChild("TopbarPlusContext"));
require(script:WaitForChild("Types"));
return {
    SetUpCalled = false,
    Frames = {},
    GetFrameIndex = function(p1, p2) --[[ Name: GetFrameIndex, Line 32 ]]
        for v3, v4 in p1.Frames do
            if p2 == v4 then
                return v3;
            end;
        end;
        return nil;
    end,
    UpdateFrames = function(p5) --[[ Name: UpdateFrames, Line 43 ]]
        for v6, v7 in p5.Frames do
            v7.LayoutOrder = v6;
        end;
        if p5.SurfaceGui then
            p5.SurfaceGui.Enabled = #p5.Frames > 0;
        end;
    end,
    Add = function(p8, p9, p10) --[[ Name: Add, Line 59 ]]
        if p8:GetFrameIndex(p9) then
            error("GuiObject " .. tostring(p9) .. " was already added.");
        end;
        if p9.Size.Width.Scale ~= 0 and p9.SizeConstraint ~= Enum.SizeConstraint.RelativeYY then
            error("GuiObject " .. tostring(p9) .. " has a non-zero relative width but SizeConstraint is not RelativeYY. This will cause problems with bar sizing.");
        end;
        if p8.FrameContainer then
            p9.Parent = p8.FrameContainer;
        end;
        if p10 then
            table.insert(p8.Frames, p10, p9);
        else
            table.insert(p8.Frames, p9);
        end;
        p8:UpdateFrames();
    end,
    AddRelative = function(p11, p12, p13, p14) --[[ Name: AddRelative, Line 86 ]]
        local v15 = p11:GetFrameIndex(p13);
        if not v15 then
            error("GuiObject " .. tostring(p12) .. " not found.");
        end;
        p11:Add(p12, v15 + p14);
    end,
    AddBefore = function(p16, p17, p18) --[[ Name: AddBefore, Line 98 ]]
        p16:AddRelative(p17, p18, 0);
    end,
    AddAfter = function(p19, p20, p21) --[[ Name: AddAfter, Line 106 ]]
        p19:AddRelative(p20, p21, 1);
    end,
    WithTopbarPlus = function(p22, p23) --[[ Name: WithTopbarPlus, Line 113 ]]
        -- upvalues: l__TopbarPlusContext__4 (copy)
        if not p22.TopbarPlusContext then
            p22.TopbarPlusContext = l__TopbarPlusContext__4.new(p22, p23);
        end;
        return p22.TopbarPlusContext;
    end,
    SetUp = function(u24) --[[ Name: SetUp, Line 124 ]]
        -- upvalues: l__Workspace__1 (copy), l__Players__2 (copy), l__RunService__3 (copy)
        if u24.SetUpCalled then
        else
            u24.SetUpCalled = true;
            task.spawn(function() --[[ Line: 131 ]]
                -- upvalues: l__Workspace__1 (ref), l__Players__2 (ref), u24 (copy), l__RunService__3 (ref)
                local l__BottomBar_Part__5 = l__Workspace__1.CurrentCamera:WaitForChild("VRCorePanelParts"):WaitForChild("BottomBar_Part");
                local u25 = Instance.new("Part");
                u25.Transparency = 1;
                u25.Name = "ExtendedBottomBar";
                u25.CanCollide = false;
                u25.CanTouch = false;
                u25.Parent = l__BottomBar_Part__5.Parent;
                local u26 = Instance.new("SurfaceGui");
                u26.Name = "VRSecondaryBottomBar";
                u26.ResetOnSpawn = false;
                u26.AlwaysOnTop = true;
                u26.CanvasSize = Vector2.new(0, 240);
                u26.Adornee = u25;
                u26.Parent = l__Players__2.LocalPlayer:WaitForChild("PlayerGui");
                u24.SurfaceGui = u26;
                local v27 = Instance.new("Frame");
                v27.BackgroundTransparency = 0.25;
                v27.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                v27.Size = UDim2.new(1, 0, 1, 0);
                v27.BackgroundColor3 = Color3.fromRGB(46, 46, 46);
                v27.Parent = u26;
                local v28 = Instance.new("UICorner");
                v28.CornerRadius = UDim.new(0.1, 0);
                v28.Parent = v27;
                local v29 = Instance.new("Frame");
                v29.BackgroundTransparency = 1;
                v29.Size = UDim2.new(1, -40, 1, -40);
                v29.Position = UDim2.new(0, 20, 0, 20);
                v29.Parent = v27;
                u24.FrameContainer = v29;
                local u30 = Instance.new("UIListLayout");
                u30.SortOrder = Enum.SortOrder.LayoutOrder;
                u30.FillDirection = Enum.FillDirection.Horizontal;
                u30.Padding = UDim.new(0, 30);
                u30.Parent = v29;
                for _, v31 in u24.Frames do
                    v31.Parent = v29;
                end;
                local u32 = Instance.new("Weld");
                u32.Part0 = l__BottomBar_Part__5;
                u32.Part1 = u25;
                u32.Parent = u25;
                u32.AncestryChanged:Connect(function() --[[ Line: 186 ]]
                    -- upvalues: u32 (ref), l__BottomBar_Part__5 (copy), u25 (copy)
                    if u32.Parent then
                    else
                        u32 = Instance.new("Weld");
                        u32.Part0 = l__BottomBar_Part__5;
                        u32.Part1 = u25;
                        u32.Parent = u25;
                    end;
                end);
                l__RunService__3:BindToRenderStep("ExtendedVRBottomBarUpdate", Enum.RenderPriority.First.Value + 1, function() --[[ Line: 194 ]]
                    -- upvalues: u30 (copy), u25 (copy), l__BottomBar_Part__5 (copy), u32 (ref), u26 (copy)
                    local v33 = u30.AbsoluteContentSize.X + 40;
                    u25.Size = Vector3.new(l__BottomBar_Part__5.Size.Y * (v33 / 240), l__BottomBar_Part__5.Size.Y, l__BottomBar_Part__5.Size.Z);
                    u32.C1 = CFrame.new(0, 1.1 * l__BottomBar_Part__5.Size.Y, 0);
                    u26.CanvasSize = Vector2.new(v33, 240);
                end);
                u24:UpdateFrames();
            end);
        end;
    end
};
