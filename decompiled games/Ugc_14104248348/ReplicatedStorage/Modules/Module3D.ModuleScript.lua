-- Decompiled from: ReplicatedStorage.Modules.Module3D
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u25 = {
    new = function(u1) --[[ Name: new, Line 57 ]]
        local u2 = CFrame.new();
        local u3 = 1;
        local u4 = {
            Object3D = u1
        };
        if u1:IsA("BasePart") then
            local v5 = Instance.new("Model");
            v5.Name = "Model3D";
            u1.Parent = v5;
            v5.PrimaryPart = u1;
            u1 = v5;
            u4.Object3D = u1;
        end;
        local u6 = Instance.new("ViewportFrame");
        u6.BackgroundTransparency = 1;
        u4.AdornFrame = u6;
        local u7 = Instance.new("Camera");
        u7.Parent = u6;
        u6.CurrentCamera = u7;
        local l__PrimaryPart__1 = u1.PrimaryPart;
        if not l__PrimaryPart__1 then
            u1.PrimaryPart = u1:FindFirstChildWhichIsA("BasePart", true);
        end;
        if u1.PrimaryPart then
            u1:SetPrimaryPartCFrame(CFrame.new(Vector3.new(0, 10000, 0) - u1.PrimaryPart.Position) * u1.PrimaryPart.CFrame);
            u1.PrimaryPart = l__PrimaryPart__1;
        end;
        u1.Parent = u6;
        local function u14() --[[ Line: 101 ]]
            -- upvalues: u1 (ref), u7 (copy), u3 (ref), u2 (ref)
            local v8, v9 = u1:GetBoundingBox();
            local l__p__2 = v8.p;
            local v10 = math.max(v9.X, v9.Y, v9.Z);
            local v11 = math.rad(u7.FieldOfView);
            local v12 = v10 / math.tan(v11) * u3;
            local v13 = CFrame.new(l__p__2);
            u7.CFrame = v13 * u2 * CFrame.new(0, 0, v10 / 2 + v12);
            u7.Focus = v13;
        end;
        function u4.Update(_) --[[ Line: 116 ]]
            -- upvalues: u14 (copy)
            u14();
        end;
        function u4.SetActive(_, p15) --[[ Line: 123 ]]
            -- upvalues: u6 (copy)
            u6.Visible = p15;
        end;
        function u4.GetActive(_) --[[ Line: 130 ]]
            -- upvalues: u6 (copy)
            return u6.Visible;
        end;
        function u4.SetCFrame(_, p16) --[[ Line: 137 ]]
            -- upvalues: u2 (ref), u14 (copy)
            u2 = p16;
            u14();
        end;
        function u4.GetCFrame(_) --[[ Line: 145 ]]
            -- upvalues: u2 (ref)
            return u2;
        end;
        function u4.SetDepthMultiplier(_, p17) --[[ Line: 152 ]]
            -- upvalues: u3 (ref), u14 (copy)
            u3 = p17;
            u14();
        end;
        function u4.GetDepthMultiplier(_) --[[ Line: 160 ]]
            -- upvalues: u3 (ref)
            return u3;
        end;
        function u4.Destroy(p18) --[[ Line: 167 ]]
            p18.AdornFrame:Destroy();
            p18.Object3D:Destroy();
        end;
        function u4.End(p19) --[[ Line: 175 ]]
            p19:Destroy();
        end;
        local v20 = {};
        setmetatable(u4, v20);
        function v20.__index(_, p21) --[[ Line: 182 ]]
            -- upvalues: u6 (copy), u4 (copy)
            if p21 == "Camera" then
                return u6.CurrentCamera;
            else
                local v22 = rawget(u4, p21);
                if v22 == nil then
                    return u6[p21];
                else
                    return v22;
                end;
            end;
        end;
        function v20.__newindex(_, p23, p24) --[[ Line: 197 ]]
            -- upvalues: u6 (copy)
            u6[p23] = p24;
        end;
        u14();
        return u4;
    end
};
function u25.Attach3D(_, u26, p27) --[[ Line: 209 ]]
    -- upvalues: u25 (copy)
    local u28 = u25.new(p27);
    u28.AnchorPoint = Vector2.new(0.5, 0.5);
    u28.Position = UDim2.new(0.5, 0, 0.5, 0);
    u28.Visible = false;
    u28.Parent = u26;
    local u31 = u26.Changed:Connect(function() --[[ Name: UpdateFrameSize, Line 220 ]]
        -- upvalues: u26 (copy), u28 (copy)
        local l__AbsoluteSize__3 = u26.AbsoluteSize;
        local v29 = math.min(l__AbsoluteSize__3.X, l__AbsoluteSize__3.Y);
        local v30 = math.abs(v29);
        u28.AdornFrame.Size = UDim2.new(0, v30, 0, v30);
    end);
    local l__AbsoluteSize__4 = u26.AbsoluteSize;
    local v32 = math.min(l__AbsoluteSize__4.X, l__AbsoluteSize__4.Y);
    local v33 = math.abs(v32);
    u28.AdornFrame.Size = UDim2.new(0, v33, 0, v33);
    local l__Destroy__5 = u28.Destroy;
    rawset(u28, "Destroy", function(p34) --[[ Name: NewDesstroy, Line 230 ]]
        -- upvalues: l__Destroy__5 (copy), u31 (ref)
        l__Destroy__5(p34);
        if u31 then
            u31:Disconnect();
            u31 = nil;
        end;
    end);
    return u28;
end;
return u25;
