-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__LocalPlayer__3 = l__Players__1.LocalPlayer;
local l__Debris__4 = game:GetService("Debris");
local l__new__5 = Vector3.new;
local l__new__6 = Instance.new;
local _ = math.rad;
local l__random__7 = math.random;
local l__abs__8 = math.abs;
local l__new__9 = CFrame.new;
local l__Angles__10 = CFrame.Angles;
local l__new__11 = BrickColor.new;
local l__new__12 = Color3.new;
local l__fromRGB__13 = Color3.fromRGB;
local u1 = typeof;
local l__new__14 = ColorSequence.new;
local l__new__15 = ColorSequenceKeypoint.new;
local l__Neon__16 = Enum.Material.Neon;
local l__SmoothPlastic__17 = Enum.Material.SmoothPlastic;
local v2 = {};
local u3 = 10;
local l__Effects__18 = require(script:WaitForChild("Effects"));
local l__ANEXOEffects__19 = script:WaitForChild("ANEXOEffects");
pcall(function() --[[ Line: 33 ]]
    -- upvalues: u3 (ref)
    game.GraphicsQualityChangeRequest:Connect(function() --[[ Line: 34 ]]
        -- upvalues: u3 (ref)
        u3 = UserSettings():GetService("UserGameSettings").SavedQualityLevel.Value;
    end);
    spawn(function() --[[ Line: 38 ]]
        -- upvalues: u3 (ref)
        u3 = UserSettings():GetService("UserGameSettings").SavedQualityLevel.Value;
        while wait(5) do
            u3 = UserSettings():GetService("UserGameSettings").SavedQualityLevel.Value;
        end;
    end);
end);
local function u6(p4) --[[ Line: 64 ]]
    -- upvalues: l__Players__1 (copy)
    for _, v5 in pairs(l__Players__1:GetPlayers()) do
        if v5.Character ~= nil and (v5.Character:FindFirstChild("Humanoid") and p4:IsDescendantOf(v5.Character) == true) then
            return v5.Character:FindFirstChild("Humanoid"), v5;
        end;
    end;
end;
function lerp(p7, p8, p9)
    return p7 + (p8 - p7) * p9;
end;
function clerp(p10, p11, p12)
    -- upvalues: l__new__12 (copy)
    return l__new__12(lerp(p10.r, p11.r, p12), lerp(p10.g, p11.g, p12), lerp(p10.b, p11.b, p12));
end;
function Get_posicion(p13)
    -- upvalues: u1 (copy)
    if p13 == nil then
        return nil;
    end;
    local v14 = u1(p13);
    if v14 == "Instance" and p13:IsA("BasePart") then
        return p13.Position;
    end;
    if v14 == "Instance" and p13:IsA("Attachment") then
        return p13.WorldPosition;
    end;
    if v14 == "Vector3" then
        return p13;
    end;
    if v14 == "CFrame" then
        return p13.p;
    end;
end;
v2[tostring("lastanexo")] = function(p15, ...) --[[ Line: 100 ]]
    -- upvalues: l__new__6 (copy), l__ANEXOEffects__19 (copy), l__Debris__4 (copy)
    local v16 = { ... };
    if p15 == nil then
    else
        local v17 = v16[1];
        local v18 = v16[2];
        if v17 == nil then
        elseif v18 == nil then
        else
            local v19 = workspace:FindFirstChild("FE_Ignorable");
            if v19 == nil then
                v19 = l__new__6("Folder", workspace);
                v19.Name = "FE_Ignorable";
            end;
            local v20 = Instance.new("Attachment");
            local v21 = v20:Clone();
            v20.Parent = workspace.Terrain;
            v21.Parent = workspace.Terrain;
            v20.WorldPosition = v17.WorldPosition;
            v21.WorldPosition = v18;
            local v22 = l__ANEXOEffects__19:Clone();
            v22.Parent = workspace.Terrain;
            for _, v23 in pairs(v22:GetChildren()) do
                if v23:IsA("Beam") then
                    v23.Attachment0 = v20;
                    v23.Attachment1 = v21;
                    if v23.Name == "BeamColor" then
                        v23.Color = ColorSequence.new(p15.TeamColor.Color);
                    end;
                end;
            end;
            l__Debris__4:AddItem(v20, 0.065);
            l__Debris__4:AddItem(v21, 0.065);
            l__Debris__4:AddItem(v22, 0.065);
        end;
    end;
end;
v2[tostring("arctorianimperiummedic")] = function(p24, ...) --[[ Line: 140 ]]
    -- upvalues: l__new__6 (copy), l__Debris__4 (copy)
    local v25 = { ... };
    if p24 == nil then
    else
        local v26 = v25[1];
        local v27 = v25[2];
        if v26 == nil then
        elseif v27 == nil then
        else
            local v28 = workspace:FindFirstChild("FE_Ignorable");
            if v28 == nil then
                v28 = l__new__6("Folder", workspace);
                v28.Name = "FE_Ignorable";
            end;
            local l__Magnitude__20 = (v26.Position - v27).Magnitude;
            local v29 = Instance.new("Part");
            v29.Name = p24.Name;
            v29.Material = Enum.Material.Neon;
            v29.Anchored = true;
            v29.CanCollide = false;
            v29.CanTouch = false;
            v29.BrickColor = BrickColor.new("Lime green");
            v29.Massless = true;
            v29.Size = Vector3.new(0.08, 0.08, l__Magnitude__20);
            v29.CFrame = CFrame.new(v26.CFrame.p, v27) * CFrame.new(0, 0, -l__Magnitude__20 / 2);
            v29.Parent = v28;
            l__Debris__4:AddItem(v29, 0.03);
        end;
    end;
end;
v2[tostring("arctorianimperium")] = function(p30, ...) --[[ Line: 171 ]]
    -- upvalues: l__new__6 (copy), l__Debris__4 (copy)
    local v31 = { ... };
    if p30 == nil then
    else
        local v32 = v31[1];
        local v33 = v31[2];
        if v32 == nil then
        elseif v33 == nil then
        else
            local v34 = workspace:FindFirstChild("FE_Ignorable");
            if v34 == nil then
                v34 = l__new__6("Folder", workspace);
                v34.Name = "FE_Ignorable";
            end;
            local l__Magnitude__21 = (v32.Position - v33).Magnitude;
            local v35 = Instance.new("Part");
            v35.Name = p30.Name;
            v35.Material = Enum.Material.Neon;
            v35.Anchored = true;
            v35.CanCollide = false;
            v35.CanTouch = false;
            v35.BrickColor = p30.TeamColor;
            v35.Massless = true;
            v35.Size = Vector3.new(0.08, 0.08, l__Magnitude__21);
            v35.CFrame = CFrame.new(v32.CFrame.p, v33) * CFrame.new(0, 0, -l__Magnitude__21 / 2);
            v35.Parent = v34;
            l__Debris__4:AddItem(v35, 0.03);
        end;
    end;
end;
v2[tostring("prime")] = function(p36, ...) --[[ Line: 202 ]]
    -- upvalues: l__new__6 (copy), l__Effects__18 (copy), u3 (ref)
    local v37 = { ... };
    if p36 == nil then
    else
        local v38 = v37[1];
        local v39 = v37[2];
        local v40 = v37[3];
        local _ = v37[4];
        if v38 == nil then
        elseif v39 == nil then
        else
            local l__Barrel__22 = v38.Barrel;
            local v41 = workspace:FindFirstChild("FE_Ignorable");
            if v41 == nil then
                v41 = l__new__6("Folder", workspace);
                v41.Name = "FE_Ignorable";
            end;
            l__Barrel__22.Fire:Emit(1);
            l__Effects__18:HandleStandardFiredGunEffects(v38, v39, v40 ~= nil, u3);
        end;
    end;
end;
v2[tostring("gloryheal")] = function(_, ...) --[[ Line: 227 ]]
    local v42 = { ... };
    local v43 = v42[1];
    local v44 = v42[2];
    if v44 ~= nil then
        v44 = v44:FindFirstChildOfClass("Attachment");
    end;
    v43.Attachment1 = v44;
end;
v2[tostring("glory")] = function(p45, ...) --[[ Line: 241 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__11 (copy), l__Debris__4 (copy)
    local v46 = { ... };
    local v47 = Get_posicion(v46[1]);
    local v48 = Get_posicion(v46[2]);
    if v47 == nil or v48 == nil then
    elseif p45 == nil then
    else
        local v49 = workspace:FindFirstChild("FE_Ignorable");
        if v49 == nil then
            v49 = l__new__6("Folder", workspace);
            v49.Name = "FE_Ignorable";
        end;
        local l__magnitude__23 = (v48 - v47).magnitude;
        local v50 = l__new__6("Part");
        v50.Anchored = true;
        v50.CanCollide = false;
        v50.CanQuery = false;
        v50.Size = Vector3.new(1, 1, 1);
        local v51 = l__new__6("BlockMesh", v50);
        local v52 = l__new__6("Part");
        v52.Anchored = true;
        v52.CanCollide = false;
        v52.CanQuery = false;
        v52.Size = Vector3.new(1, 1, 1);
        local v53 = l__new__6("BlockMesh", v52);
        v50.CFrame = CFrame.new((v47 + v48) / 2, v48);
        v52.CFrame = CFrame.new((v47 + v48) / 2, v48);
        v51.Scale = Vector3.new(1, 1, l__magnitude__23 * 5);
        v53.Scale = Vector3.new(1, 1, l__magnitude__23 * 10);
        v50.Material = l__Neon__16;
        v52.Material = l__Neon__16;
        v50.Size = Vector3.new(0.2, 0.2, 0.2);
        v52.Size = Vector3.new(0.05, 0.05, 0.1);
        v50.BrickColor = p45.TeamColor;
        v52.BrickColor = l__new__11("White");
        v50.Transparency = 0.15;
        v50.Reflectance = 0;
        l__Debris__4:AddItem(v50, 0.03);
        l__Debris__4:AddItem(v52, 0.03);
        v50.Parent = v49;
        v52.Parent = v49;
    end;
end;
v2[tostring("tod")] = function(p54, ...) --[[ Line: 288 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__11 (copy), l__Debris__4 (copy)
    local v55 = { ... };
    local v56 = Get_posicion(v55[1]);
    local v57 = Get_posicion(v55[2]);
    if v56 == nil or v57 == nil then
    elseif p54 == nil then
    else
        local v58 = workspace:FindFirstChild("FE_Ignorable");
        if v58 == nil then
            v58 = l__new__6("Folder", workspace);
            v58.Name = "FE_Ignorable";
        end;
        local l__magnitude__24 = (v57 - v56).magnitude;
        local v59 = l__new__6("Part");
        v59.Anchored = true;
        v59.CanCollide = false;
        v59.CanQuery = false;
        v59.Size = Vector3.new(1, 1, 1);
        local v60 = l__new__6("BlockMesh", v59);
        local v61 = l__new__6("Part");
        v61.Anchored = true;
        v61.CanCollide = false;
        v61.CanQuery = false;
        v61.Size = Vector3.new(1, 1, 1);
        local v62 = l__new__6("BlockMesh", v61);
        v59.CFrame = CFrame.new((v56 + v57) / 2, v57);
        v61.CFrame = CFrame.new((v56 + v57) / 2, v57);
        v60.Scale = Vector3.new(0.8, 0.8, l__magnitude__24 * 5);
        v62.Scale = Vector3.new(0.8, 0.8, l__magnitude__24 * 10);
        v59.Material = l__Neon__16;
        v61.Material = l__Neon__16;
        v59.Size = Vector3.new(0.2, 0.2, 0.2);
        v61.Size = Vector3.new(0.15, 0.15, 0.1);
        v59.BrickColor = p54.TeamColor;
        v61.BrickColor = l__new__11("Light blue");
        v59.Transparency = 0.7;
        v59.Reflectance = 0;
        l__Debris__4:AddItem(v59, 0.03);
        l__Debris__4:AddItem(v61, 0.03);
        v59.Parent = v58;
        v61.Parent = v58;
    end;
end;
v2[tostring("valania")] = function(p63, ...) --[[ Line: 335 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__9 (copy), l__new__5 (copy), l__Debris__4 (copy)
    local v64 = { ... };
    local v65 = Get_posicion(v64[1]);
    local v66 = Get_posicion(v64[2]);
    local _ = v64[3];
    if v65 == nil or v66 == nil then
    elseif p63 == nil then
    else
        local v67 = workspace:FindFirstChild("FE_Ignorable");
        if v67 == nil then
            v67 = l__new__6("Folder", workspace);
            v67.Name = "FE_Ignorable";
        end;
        local _ = (v66 - v65).magnitude;
        local v68 = l__new__6("Part");
        v68.Anchored = true;
        v68.CanCollide = false;
        v68.CanQuery = false;
        v68.Size = Vector3.new(1, 1, 1);
        local v69 = l__new__6("BlockMesh", v68);
        v68.Material = l__Neon__16;
        v68.Size = Vector3.new(0.2, 0.2, 0.05);
        v68.BrickColor = p63.TeamColor;
        v68.Transparency = 0.25;
        v68.Reflectance = 0.2;
        v68.CFrame = l__new__9((v65 + v66) / 2, v66);
        v69.Scale = l__new__5(0.5, 0.5, (v65 - v66).magnitude * 20);
        l__Debris__4:AddItem(v68, 0.06);
        v68.Parent = v67;
    end;
end;
v2[tostring("mesmer")] = function(p70, ...) --[[ Line: 364 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__9 (copy), l__new__5 (copy), l__Debris__4 (copy)
    local v71 = { ... };
    local v72 = Get_posicion(v71[1]);
    local v73 = Get_posicion(v71[2]);
    local _ = v71[3];
    if v72 == nil or v73 == nil then
    elseif p70 == nil then
    else
        local v74 = workspace:FindFirstChild("FE_Ignorable");
        if v74 == nil then
            v74 = l__new__6("Folder", workspace);
            v74.Name = "FE_Ignorable";
        end;
        local _ = (v73 - v72).magnitude;
        local v75 = l__new__6("Part");
        v75.Anchored = true;
        v75.CanCollide = false;
        v75.CanQuery = false;
        v75.Size = Vector3.new(1, 1, 1);
        local v76 = l__new__6("BlockMesh", v75);
        v75.Material = l__Neon__16;
        v75.Size = Vector3.new(0.1, 0.1, 0.05);
        v75.BrickColor = p70.TeamColor;
        v75.Transparency = 0;
        v75.CFrame = l__new__9((v72 + v73) / 2, v73);
        v76.Scale = l__new__5(2.5, 2.5, (v72 - v73).magnitude * 20);
        l__Debris__4:AddItem(v75, 0.03);
        v75.Parent = v74;
    end;
end;
v2[tostring("ror")] = function(p77, ...) --[[ Line: 392 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__11 (copy), l__new__9 (copy), l__new__5 (copy), l__Debris__4 (copy)
    local v78 = { ... };
    local v79 = Get_posicion(v78[1]);
    local v80 = Get_posicion(v78[2]);
    local v81 = v78[3];
    if v79 == nil or v80 == nil then
    elseif p77 == nil then
    else
        local v82 = workspace:FindFirstChild("FE_Ignorable");
        if v82 == nil then
            v82 = l__new__6("Folder", workspace);
            v82.Name = "FE_Ignorable";
        end;
        local _ = (v80 - v79).magnitude;
        local v83 = l__new__6("Part");
        v83.Anchored = true;
        v83.CanCollide = false;
        v83.CanQuery = false;
        v83.Size = Vector3.new(1, 1, 1);
        local v84 = l__new__6("BlockMesh", v83);
        v83.Material = l__Neon__16;
        v83.Size = Vector3.new(0.05, 0.05, 0.05);
        v83.BrickColor = p77.TeamColor;
        if v81 == true then
            v83.BrickColor = l__new__11("Lime green");
        end;
        v83.Transparency = 0.65;
        v83.CFrame = l__new__9((v79 + v80) / 2, v80);
        v84.Scale = l__new__5(3, 3, (v79 - v80).magnitude * 20);
        l__Debris__4:AddItem(v83, 0.06);
        v83.Parent = v82;
        local v85 = l__new__6("Part");
        v85.Anchored = true;
        v85.CanCollide = false;
        v85.CanQuery = false;
        v85.Size = Vector3.new(1, 1, 1);
        local v86 = l__new__6("BlockMesh", v85);
        v85.Material = l__Neon__16;
        v85.Size = Vector3.new(0.05, 0.05, 0.05);
        v85.BrickColor = l__new__11("White");
        v85.CFrame = v83.CFrame;
        v85.Transparency = 0.5;
        v86.Scale = l__new__5(1.5, 1.5, (v79 - v80).magnitude * 20);
        l__Debris__4:AddItem(v85, 0.06);
        v85.Parent = v82;
    end;
end;
v2[tostring("aztec")] = function(p87, ...) --[[ Line: 434 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__9 (copy), l__new__5 (copy), l__Debris__4 (copy)
    local v88 = { ... };
    local v89 = Get_posicion(v88[1]);
    local v90 = Get_posicion(v88[2]);
    if v89 == nil or v90 == nil then
    elseif p87 == nil then
    else
        local v91 = workspace:FindFirstChild("FE_Ignorable");
        if v91 == nil then
            v91 = l__new__6("Folder", workspace);
            v91.Name = "FE_Ignorable";
        end;
        local l__magnitude__25 = (v90 - v89).magnitude;
        local v92 = l__new__6("Part");
        v92.Anchored = true;
        v92.CanCollide = false;
        v92.CanQuery = false;
        v92.Size = Vector3.new(1, 1, 1);
        local v93 = l__new__6("BlockMesh", v92);
        v92.Transparency = 0.3;
        v92.Material = l__Neon__16;
        v92.Size = Vector3.new(0.2, 0.2, 0.2);
        v92.CFrame = l__new__9((v89 + v90) / 2, v90);
        v92.BrickColor = p87.TeamColor;
        v93.Scale = l__new__5(0.4, 0.4, l__magnitude__25 * 5);
        v92.Parent = v91;
        l__Debris__4:AddItem(v92, 0.1);
        local v94 = l__new__6("Part");
        v94.Anchored = true;
        v94.CanCollide = false;
        v94.CanQuery = false;
        v94.Size = Vector3.new(1, 1, 1);
        local v95 = l__new__6("BlockMesh", v94);
        v94.Transparency = 0.9;
        v94.Material = l__Neon__16;
        v94.Size = Vector3.new(0.2, 0.2, 0.2);
        v94.CFrame = l__new__9((v89 + v90) / 2, v90);
        v94.BrickColor = p87.TeamColor;
        v95.Scale = l__new__5(0.8, 0.8, l__magnitude__25 * 5);
        v94.Parent = v91;
        l__Debris__4:AddItem(v94, 0.07);
    end;
end;
v2[tostring("exobtr")] = function(p96, ...) --[[ Line: 479 ]]
    -- upvalues: l__new__6 (copy), l__new__9 (copy), l__new__5 (copy), l__Debris__4 (copy)
    local v97 = { ... };
    local v98 = Get_posicion(v97[1]);
    local v99 = Get_posicion(v97[2]);
    if v98 == nil or v99 == nil then
    elseif p96 == nil then
    else
        local v100 = workspace:FindFirstChild("FE_Ignorable");
        if v100 == nil then
            v100 = l__new__6("Folder", workspace);
            v100.Name = "FE_Ignorable";
        end;
        local l__magnitude__26 = (v99 - v98).magnitude;
        local v101 = l__new__6("Part");
        v101.Anchored = true;
        v101.CanCollide = false;
        v101.CanQuery = false;
        v101.Size = Vector3.new(1, 1, 1);
        local v102 = l__new__6("BlockMesh", v101);
        v101.Transparency = 0.25;
        v101.Reflectance = 0.2;
        v101.Size = Vector3.new(0.2, 0.2, 0.2);
        v101.CFrame = l__new__9((v98 + v99) / 2, v99);
        v101.BrickColor = p96.TeamColor;
        v102.Scale = l__new__5(0.75, 0.75, l__magnitude__26 * 5);
        v101.Parent = v100;
        l__Debris__4:AddItem(v101, 0.06);
    end;
end;
v2[tostring("irf")] = function(p103, ...) --[[ Line: 511 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__9 (copy), l__new__5 (copy), l__Debris__4 (copy)
    local v104 = { ... };
    local v105 = Get_posicion(v104[1]);
    local v106 = Get_posicion(v104[2]);
    if v105 == nil or v106 == nil then
        return nil;
    end;
    local l__magnitude__27 = (v106 - v105).magnitude;
    local v107 = workspace:FindFirstChild("FE_Ignorable");
    if v107 == nil then
        v107 = l__new__6("Folder", workspace);
        v107.Name = "FE_Ignorable";
    end;
    local v108 = l__new__6("Part");
    v108.Anchored = true;
    v108.CanCollide = false;
    v108.CanQuery = false;
    v108.Size = Vector3.new(1, 1, 1);
    local v109 = l__new__6("BlockMesh", v108);
    v108.Size = Vector3.new(0.1, 0.1, 1);
    v108.Reflectance = 0.2;
    v108.Transparency = 0.25;
    v108.Material = l__Neon__16;
    v108.CFrame = l__new__9(v105, v106) * l__new__9(0, 0, -l__magnitude__27 / 2);
    v108.BrickColor = p103.TeamColor;
    local v110 = workspace:FindFirstChild("FE_Ignorable");
    if v110 == nil then
        v110 = l__new__6("Folder", workspace);
        v110.Name = "FE_Ignorable";
    end;
    v108.Parent = v110;
    v109.Scale = l__new__5(0.75, 0.75, l__magnitude__27);
    l__Debris__4:AddItem(v108, 0.06);
end;
v2[tostring("vakheal")] = function(_, ...) --[[ Line: 540 ]]
    local v111 = { ... };
    local v112 = v111[1];
    local v113 = v111[2];
    if v112 ~= nil then
        local v114;
        if v113 == nil then
            v114 = nil;
        else
            v114 = v113:FindFirstChildOfClass("Attachment");
        end;
        v112.Attachment1 = v114;
    end;
end;
v2[tostring("ne-x")] = function(_, ...) --[[ Line: 559 ]]
    local v115 = { ... };
    local v116 = v115[1];
    local v117 = v115[2];
    local v118 = v115[3];
    if v118 ~= nil then
        v118 = v118:FindFirstChildOfClass("Attachment");
    end;
    if v116 ~= nil then
        v116.Attachment1 = v118;
    end;
    if v117 ~= nil then
        v117.Attachment1 = v118;
    end;
end;
v2[tostring("rsf")] = function(p119, ...) --[[ Line: 579 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__9 (copy), l__Angles__10 (copy), l__random__7 (copy), l__new__11 (copy), l__new__5 (copy), l__Debris__4 (copy)
    local v120 = { ... };
    local v121 = Get_posicion(v120[1]);
    local v122 = Get_posicion(v120[2]);
    local v123 = v120[3];
    if v121 == nil or v122 == nil then
        return nil;
    end;
    local l__magnitude__28 = (v122 - v121).magnitude;
    local v124 = workspace:FindFirstChild("FE_Ignorable");
    if v124 == nil then
        v124 = l__new__6("Folder", workspace);
        v124.Name = "FE_Ignorable";
    end;
    local v125 = l__new__6("Part");
    v125.Anchored = true;
    v125.CanCollide = false;
    v125.CanQuery = false;
    v125.Size = Vector3.new(1, 1, 1);
    local v126 = l__new__6("BlockMesh", v125);
    local v127 = l__new__6("Part");
    v127.Anchored = true;
    v127.CanCollide = false;
    v127.CanQuery = false;
    v127.Size = Vector3.new(1, 1, 1);
    local v128 = l__new__6("BlockMesh", v127);
    v125.Size = Vector3.new(0.2, 0.2, 1);
    v127.Size = Vector3.new(0.2, 0.2, 1);
    v125.Material = l__Neon__16;
    v127.Material = l__Neon__16;
    v125.CFrame = l__new__9(v121, v122) * l__Angles__10(-3.141592653589793, 0, l__random__7(0, 360));
    v127.CFrame = l__new__9(v121, v122) * l__Angles__10(-3.141592653589793, 0, l__random__7(0, 360));
    if v123 == true then
        v125.BrickColor = l__new__11("Bright green");
    else
        v127.BrickColor = p119.TeamColor;
        v125.BrickColor = p119.TeamColor;
    end;
    v126.Offset = l__new__5(0, 0, l__magnitude__28 / 4);
    v128.Offset = l__new__5(0, 0, l__magnitude__28 / 4 * 3);
    v126.Scale = l__new__5(1, 1, l__magnitude__28 / 2);
    v128.Scale = l__new__5(1, 1, l__magnitude__28 / 2);
    l__Debris__4:AddItem(v125, 0.03);
    l__Debris__4:AddItem(v127, 0.06);
    v125.Parent = v124;
    v127.Parent = v124;
end;
v2[tostring("surge")] = function(p129, ...) --[[ Line: 628 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__Debris__4 (copy), l__new__5 (copy), l__new__9 (copy)
    local v130 = { ... };
    local v131 = Get_posicion(v130[1]);
    local v132 = Get_posicion(v130[2]);
    local v133 = v130[3];
    local v134 = v130[4];
    if v131 == nil or v132 == nil then
        return nil;
    end;
    local l__magnitude__29 = (v132 - v131).magnitude;
    local v135 = workspace:FindFirstChild("FE_Ignorable");
    if v135 == nil then
        v135 = l__new__6("Folder", workspace);
        v135.Name = "FE_Ignorable";
    end;
    local v136 = l__new__6("Part");
    v136.Anchored = true;
    v136.CanCollide = false;
    v136.CanQuery = false;
    v136.Size = Vector3.new(1, 1, 1);
    local v137 = l__new__6("BlockMesh", v136);
    v136.Size = Vector3.new(0.7, 0.7, 1);
    v136.BrickColor = p129.TeamColor;
    v136.Transparency = 0;
    v136.Material = l__Neon__16;
    v136.Name = "Rayo_surge_" .. tostring(p129.UserId);
    v136.BrickColor = p129.TeamColor;
    if v134 == true and v133 ~= nil then
        v136.BrickColor = BrickColor.new("Sea green");
        local v138 = Instance.new("PointLight", v133);
        v138.Name = "Light";
        v138.Brightness = 8;
        v138.Color = Color3.new(0, 1, 0);
        v138.Range = 10;
        v138.Shadows = true;
        l__Debris__4:AddItem(v138, 0.11);
    end;
    v137.Scale = l__new__5(0.22, 0.22, l__magnitude__29);
    v136.CFrame = l__new__9(v131, v132) * l__new__9(0, 0, -l__magnitude__29 / 2);
    v136.Parent = v135;
    l__Debris__4:AddItem(v136, 0.03);
end;
v2[tostring("nexorian")] = function(p139, ...) --[[ Line: 673 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__5 (copy), l__new__11 (copy), l__new__9 (copy), l__Debris__4 (copy)
    local v140 = { ... };
    local v141 = Get_posicion(v140[1]);
    local v142 = Get_posicion(v140[2]);
    local v143 = v140[3];
    if v141 == nil or v142 == nil then
        return nil;
    end;
    local l__magnitude__30 = (v142 - v141).magnitude;
    local v144 = workspace:FindFirstChild("FE_Ignorable");
    if v144 == nil then
        v144 = l__new__6("Folder", workspace);
        v144.Name = "FE_Ignorable";
    end;
    local v145 = l__new__6("Part");
    v145.Anchored = true;
    v145.CanCollide = false;
    v145.CanQuery = false;
    v145.Size = Vector3.new(1, 1, 1);
    local v146 = l__new__6("BlockMesh", v145);
    v145.Material = l__Neon__16;
    v145.Size = Vector3.new(0.1, 0.1, 1);
    v146.Scale = l__new__5(1, 1, l__magnitude__30);
    v145.BrickColor = v143 == true and l__new__11("Lime green") or p139.TeamColor;
    v145.CFrame = l__new__9((v141 + v142) / 2, v142);
    v145.Parent = v144;
    l__Debris__4:AddItem(v145, 0.06);
end;
v2[tostring("fear")] = function(p147, ...) --[[ Line: 702 ]]
    -- upvalues: l__new__6 (copy), l__new__5 (copy), l__Neon__16 (copy), l__new__9 (copy), l__Debris__4 (copy)
    local v148 = { ... };
    local v149 = Get_posicion(v148[1]);
    local v150 = Get_posicion(v148[2]);
    local _ = v148[3];
    if v149 == nil or v150 == nil then
        return nil;
    end;
    local l__magnitude__31 = (v150 - v149).magnitude;
    local v151 = workspace:FindFirstChild("FE_Ignorable");
    if v151 == nil then
        v151 = l__new__6("Folder", workspace);
        v151.Name = "FE_Ignorable";
    end;
    local v152 = l__new__6("Part");
    v152.Anchored = true;
    v152.CanCollide = false;
    v152.CanQuery = false;
    v152.Size = Vector3.new(1, 1, 1);
    local v153 = l__new__6("BlockMesh", v152);
    v152.Size = Vector3.new(0.1, 0.1, 1);
    v153.Scale = l__new__5(1, 1, l__magnitude__31);
    v152.Material = l__Neon__16;
    v152.Reflectance = 0;
    v152.Transparency = 0.2;
    v152.BrickColor = p147.TeamColor;
    v152.CFrame = l__new__9((v149 + v150) / 2, v150);
    v152.Parent = v151;
    l__Debris__4:AddItem(v152, 0.03);
end;
v2[tostring("delta")] = function(p154, ...) --[[ Line: 734 ]]
    -- upvalues: l__new__6 (copy), l__new__5 (copy), l__Neon__16 (copy), l__new__9 (copy), l__Debris__4 (copy)
    local v155 = { ... };
    local v156 = Get_posicion(v155[1]);
    local v157 = Get_posicion(v155[2]);
    local _ = v155[3];
    if v156 == nil or v157 == nil then
        return nil;
    end;
    local l__magnitude__32 = (v157 - v156).magnitude;
    local v158 = workspace:FindFirstChild("FE_Ignorable");
    if v158 == nil then
        v158 = l__new__6("Folder", workspace);
        v158.Name = "FE_Ignorable";
    end;
    local v159 = l__new__6("Part");
    v159.Anchored = true;
    v159.CanCollide = false;
    v159.CanQuery = false;
    v159.Size = Vector3.new(1, 1, 1);
    local v160 = l__new__6("BlockMesh", v159);
    v159.Size = Vector3.new(0.4, 0.4, 1);
    v160.Scale = l__new__5(0.5, 0.5, l__magnitude__32);
    v159.Material = l__Neon__16;
    v159.Reflectance = 0;
    v159.Transparency = 0;
    v159.BrickColor = p154.TeamColor;
    v159.CFrame = l__new__9((v156 + v157) / 2, v157);
    v159.Parent = v158;
    l__Debris__4:AddItem(v159, 0.03);
end;
v2[tostring("eradicatorheal")] = function(_, p161, p162, p163) --[[ Line: 765 ]]
    -- upvalues: l__LocalPlayer__3 (copy), l__new__15 (copy), l__new__12 (copy), l__new__14 (copy)
    p163.Attachment0 = p161;
    p163.Attachment1 = p162;
    if l__LocalPlayer__3 then
        local v164 = {};
        for v165 = 0, 2 do
            if v165 % 2 == 0 then
                v164[#v164 + 1] = l__new__15(v165 / 2, l__LocalPlayer__3.TeamColor.Color, l__new__12(0.4, 0.4, 0.4), 0.7);
            else
                v164[#v164 + 1] = l__new__15(v165 / 2, l__LocalPlayer__3.TeamColor.Color, l__new__12(1, 1, 1), 0.6);
            end;
        end;
        p163.Color = l__new__14(v164);
    end;
end;
v2[tostring("eradicator")] = function(p166, ...) --[[ Line: 783 ]]
    -- upvalues: l__new__6 (copy), l__new__5 (copy), l__Neon__16 (copy), l__new__9 (copy), l__Debris__4 (copy)
    local v167 = { ... };
    local v168 = Get_posicion(v167[1]);
    local v169 = Get_posicion(v167[2]);
    local _ = v167[3];
    if v168 == nil or v169 == nil then
        return nil;
    end;
    local l__magnitude__33 = (v169 - v168).magnitude;
    local v170 = workspace:FindFirstChild("FE_Ignorable");
    if v170 == nil then
        v170 = l__new__6("Folder", workspace);
        v170.Name = "FE_Ignorable";
    end;
    local v171 = l__new__6("Part");
    v171.Anchored = true;
    v171.CanCollide = false;
    v171.CanQuery = false;
    v171.Size = Vector3.new(1, 1, 1);
    local v172 = l__new__6("BlockMesh", v171);
    v171.Size = Vector3.new(0.2, 0.2, 0.2);
    v172.Scale = l__new__5(0.75, 0.75, l__magnitude__33 * 5);
    v171.Material = l__Neon__16;
    v171.Reflectance = 0.2;
    v171.Transparency = 0.25;
    v171.BrickColor = p166.TeamColor;
    v171.CFrame = l__new__9((v168 + v169) / 2, v169);
    v171.Parent = v170;
    l__Debris__4:AddItem(v171, 0.06);
end;
v2[tostring("cosmos")] = function(p173, ...) --[[ Line: 814 ]]
    -- upvalues: l__new__6 (copy), l__new__5 (copy), l__Neon__16 (copy), l__new__11 (copy), l__new__9 (copy), l__Debris__4 (copy)
    local v174 = { ... };
    local v175 = Get_posicion(v174[1]);
    local v176 = Get_posicion(v174[2]);
    local v177 = v174[3];
    if v175 == nil or v176 == nil then
        return nil;
    end;
    local l__magnitude__34 = (v176 - v175).magnitude;
    local v178 = workspace:FindFirstChild("FE_Ignorable");
    if v178 == nil then
        v178 = l__new__6("Folder", workspace);
        v178.Name = "FE_Ignorable";
    end;
    local v179 = l__new__6("Part");
    v179.Anchored = true;
    v179.CanCollide = false;
    v179.CanQuery = false;
    v179.Size = Vector3.new(1, 1, 1);
    local v180 = l__new__6("BlockMesh", v179);
    v179.Size = Vector3.new(0.2, 0.2, 0.2);
    v180.Scale = l__new__5(0.75, 0.75, l__magnitude__34 * 5);
    v179.Material = l__Neon__16;
    v179.Transparency = 0.25;
    if v177 == true then
        v179.BrickColor = l__new__11("Bright green");
    else
        v179.BrickColor = p173.TeamColor;
    end;
    v179.CFrame = l__new__9((v175 + v176) / 2, v176);
    v179.Parent = v178;
    l__Debris__4:AddItem(v179, 0.06);
end;
v2[tostring("vakmedic")] = function(_, ...) --[[ Line: 848 ]]
    -- upvalues: l__new__6 (copy), l__new__11 (copy), l__Neon__16 (copy), l__new__9 (copy), l__Angles__10 (copy), l__random__7 (copy), l__new__5 (copy), l__Debris__4 (copy)
    local v181 = { ... };
    local v182 = Get_posicion(v181[1]);
    local v183 = Get_posicion(v181[2]);
    if v182 == nil then
        return nil;
    end;
    if v183 == nil then
        return nil;
    end;
    local v184 = workspace:FindFirstChild("FE_Ignorable");
    if v184 == nil then
        v184 = l__new__6("Folder", workspace);
        v184.Name = "FE_Ignorable";
    end;
    local v185 = l__new__6("Part");
    v185.Anchored = true;
    v185.CanCollide = false;
    v185.CanQuery = false;
    v185.Size = Vector3.new(1, 1, 1);
    local v186 = l__new__6("BlockMesh", v185);
    v185.Name = "HealRay";
    v185.BrickColor = l__new__11("Lime green");
    v185.Anchored = true;
    v185.CanCollide = false;
    v185.Material = l__Neon__16;
    v185.Size = Vector3.new(0.2, 0.2, 0.2);
    v185.CFrame = l__new__9(v182, v183) * l__Angles__10(0, 0, l__random__7(0, 360));
    v186.Parent = v185;
    v186.Scale = l__new__5(0.5, 0.5, (v182 - v183).magnitude * 5);
    v186.Offset = l__new__5(0, 0, -(v182 - v183).magnitude * 0.5);
    v185.Parent = v184;
    l__Debris__4:AddItem(v185, 0.11);
end;
v2[tostring("tni")] = function(p187, ...) --[[ Line: 900 ]]
    -- upvalues: l__new__6 (copy), l__new__5 (copy), l__Neon__16 (copy), l__new__11 (copy), l__new__9 (copy), l__Debris__4 (copy)
    local v188 = { ... };
    local v189 = Get_posicion(v188[1]);
    local v190 = Get_posicion(v188[2]);
    local v191 = v188[3];
    if v189 == nil or v190 == nil then
        return nil;
    end;
    local l__magnitude__35 = (v190 - v189).magnitude;
    local v192 = workspace:FindFirstChild("FE_Ignorable");
    if v192 == nil then
        v192 = l__new__6("Folder", workspace);
        v192.Name = "FE_Ignorable";
    end;
    local v193 = l__new__6("Part");
    v193.Anchored = true;
    v193.CanCollide = false;
    v193.CanQuery = false;
    v193.Size = Vector3.new(1, 1, 1);
    local v194 = l__new__6("BlockMesh", v193);
    v193.Size = Vector3.new(0.3, 0.3, 1);
    v194.Scale = l__new__5(0.3, 0.3, l__magnitude__35);
    v193.Material = l__Neon__16;
    v193.Transparency = 0.2;
    if v191 == true then
        v193.BrickColor = l__new__11("Bright green");
    else
        v193.BrickColor = p187.TeamColor;
    end;
    v193.CFrame = l__new__9(v189, v190) * l__new__9(0, 0, -l__magnitude__35 / 2);
    v193.Parent = v192;
    l__Debris__4:AddItem(v193, 0.05);
end;
v2[tostring("vak")] = function(p195, ...) --[[ Line: 934 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__9 (copy), l__Angles__10 (copy), l__random__7 (copy), l__new__5 (copy), l__new__11 (copy), l__Debris__4 (copy)
    local v196 = { ... };
    local v197 = Get_posicion(v196[1]);
    local v198 = Get_posicion(v196[2]);
    local v199 = v196[3];
    if v197 == nil or v198 == nil then
        return nil;
    end;
    local l__magnitude__36 = (v198 - v197).magnitude;
    local v200 = workspace:FindFirstChild("FE_Ignorable");
    if v200 == nil then
        v200 = l__new__6("Folder", workspace);
        v200.Name = "FE_Ignorable";
    end;
    local v201 = l__new__6("Part");
    v201.Anchored = true;
    v201.CanCollide = false;
    v201.CanQuery = false;
    v201.Size = Vector3.new(1, 1, 1);
    local v202 = l__new__6("BlockMesh", v201);
    local v203 = l__new__6("Part");
    v203.Anchored = true;
    v203.CanCollide = false;
    v203.CanQuery = false;
    v203.Size = Vector3.new(1, 1, 1);
    local v204 = l__new__6("BlockMesh", v203);
    v201.Size = Vector3.new(0.2, 0.2, 1);
    v203.Size = Vector3.new(0.2, 0.2, 1);
    v201.Transparency = 0.3;
    v203.Transparency = 0.3;
    v201.Material = l__Neon__16;
    v203.Material = l__Neon__16;
    v201.CFrame = l__new__9(v197, v198) * l__Angles__10(-3.141592653589793, 0, l__random__7(0, 360));
    v203.CFrame = l__new__9(v197, v198) * l__Angles__10(-3.141592653589793, 0, l__random__7(0, 360));
    local v205 = l__new__6("Part");
    v205.Anchored = true;
    v205.CanCollide = false;
    v205.CanQuery = false;
    v205.Size = Vector3.new(1, 1, 1);
    local v206 = l__new__6("BlockMesh", v205);
    local v207 = l__new__6("Part");
    v207.Anchored = true;
    v207.CanCollide = false;
    v207.CanQuery = false;
    v207.Size = Vector3.new(1, 1, 1);
    local v208 = l__new__6("BlockMesh", v207);
    v205.Size = Vector3.new(0.2, 0.2, 1);
    v207.Size = Vector3.new(0.2, 0.2, 1);
    v205.Transparency = 0.6;
    v207.Transparency = 0.6;
    v201.Material = l__Neon__16;
    v203.Material = l__Neon__16;
    v205.CFrame = l__new__9(v197, v198) * l__Angles__10(-3.141592653589793, 0, l__random__7(0, 360));
    v207.CFrame = l__new__9(v197, v198) * l__Angles__10(-3.141592653589793, 0, l__random__7(0, 360));
    v206.Scale = l__new__5(0.75, 0.75, l__magnitude__36 / 2);
    v208.Scale = l__new__5(0.75, 0.75, l__magnitude__36 / 2);
    v206.Offset = l__new__5(0, 0, l__magnitude__36 / 4);
    v208.Offset = l__new__5(0, 0, l__magnitude__36 / 4 * 3);
    if v199 == true then
        v201.BrickColor = l__new__11("Bright green");
    else
        v203.BrickColor = p195.TeamColor;
        v201.BrickColor = p195.TeamColor;
        v207.BrickColor = p195.TeamColor;
        v205.BrickColor = p195.TeamColor;
    end;
    v202.Scale = l__new__5(0.35, 0.35, l__magnitude__36 / 2);
    v204.Scale = l__new__5(0.35, 0.35, l__magnitude__36 / 2);
    v202.Offset = l__new__5(0, 0, l__magnitude__36 / 4);
    v204.Offset = l__new__5(0, 0, l__magnitude__36 / 4 * 3);
    l__Debris__4:AddItem(v201, 0.05);
    l__Debris__4:AddItem(v203, 0.1);
    l__Debris__4:AddItem(v205, 0.05);
    l__Debris__4:AddItem(v207, 0.1);
    v201.Parent = v200;
    v203.Parent = v200;
    v205.Parent = v200;
    v207.Parent = v200;
end;
v2[tostring("astorian")] = function(p209, ...) --[[ Line: 1018 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__11 (copy), l__new__5 (copy), l__new__9 (copy), l__Debris__4 (copy)
    local v210 = { ... };
    local v211 = Get_posicion(v210[1]);
    local v212 = Get_posicion(v210[2]);
    local v213 = v210[3];
    if v211 == nil or v212 == nil then
        return nil;
    end;
    local _ = (v212 - v211).magnitude;
    local v214 = workspace:FindFirstChild("FE_Ignorable");
    if v214 == nil then
        v214 = l__new__6("Folder", workspace);
        v214.Name = "FE_Ignorable";
    end;
    local v215 = l__new__6("Part");
    v215.Anchored = true;
    v215.CanCollide = false;
    v215.CanQuery = false;
    v215.Size = Vector3.new(1, 1, 1);
    local v216 = l__new__6("BlockMesh", v215);
    v215.Size = Vector3.new(0.05, 0.05, 0.05);
    v215.Transparency = 0;
    v215.Material = l__Neon__16;
    if v213 == true then
        v215.BrickColor = l__new__11("Bright green");
    else
        v215.BrickColor = p209.TeamColor;
    end;
    v216.Scale = l__new__5(3, 3, (v211 - v212).magnitude * 20);
    v215.CFrame = l__new__9((v211 + v212) / 2, v212);
    v215.Name = "Rayo_astorian" .. tostring(p209.UserId);
    v215.Parent = v214;
    l__Debris__4:AddItem(v215, 0.06);
end;
v2[tostring("varcia")] = function(p217, ...) --[[ Line: 1057 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__5 (copy), l__new__9 (copy), l__Debris__4 (copy)
    local v218 = { ... };
    local v219 = Get_posicion(v218[1]);
    local v220 = Get_posicion(v218[2]);
    if v219 == nil or v220 == nil then
        return nil;
    end;
    local l__magnitude__37 = (v220 - v219).magnitude;
    local v221 = workspace:FindFirstChild("FE_Ignorable");
    if v221 == nil then
        v221 = l__new__6("Folder", workspace);
        v221.Name = "FE_Ignorable";
    end;
    local v222 = l__new__6("Part");
    v222.Anchored = true;
    v222.CanCollide = false;
    v222.CanQuery = false;
    v222.Size = Vector3.new(1, 1, 1);
    local v223 = l__new__6("BlockMesh", v222);
    v222.Size = Vector3.new(0.2, 0.2, 0.2);
    v222.BrickColor = p217.TeamColor;
    v222.Transparency = 0;
    v222.Material = l__Neon__16;
    v223.Scale = l__new__5(0.45, 0.45, l__magnitude__37 * 2.5);
    local v224 = l__new__6("Part");
    v224.Anchored = true;
    v224.CanCollide = false;
    v224.CanQuery = false;
    v224.Size = Vector3.new(1, 1, 1);
    local v225 = l__new__6("BlockMesh", v224);
    v224.Size = Vector3.new(0.2, 0.2, 0.2);
    v224.BrickColor = p217.TeamColor;
    v224.Transparency = 0;
    v224.Material = l__Neon__16;
    v225.Scale = l__new__5(0.45, 0.45, l__magnitude__37 * 2.5);
    v222.CFrame = l__new__9(v219, v220) * l__new__9(0, 0, -l__magnitude__37 * 0.25);
    v224.CFrame = l__new__9(v219, v220) * l__new__9(0, 0, -l__magnitude__37 * 0.75);
    v222.Name = "Rayo_varcia_" .. tostring(p217.UserId);
    v224.Name = "Rayo_varcia_" .. tostring(p217.UserId);
    v222.Parent = v221;
    v224.Parent = v221;
    l__Debris__4:AddItem(v222, 0.05);
    l__Debris__4:AddItem(v224, 0.1);
end;
v2[tostring("anexo")] = function(p226, ...) --[[ Line: 1098 ]]
    -- upvalues: l__new__6 (copy), l__new__11 (copy), l__Neon__16 (copy), l__new__5 (copy), l__new__9 (copy), l__Debris__4 (copy)
    local v227 = { ... };
    local v228 = Get_posicion(v227[1]);
    local v229 = Get_posicion(v227[2]);
    local v230 = v227[3];
    if v228 == nil or v229 == nil then
        return nil;
    end;
    local l__magnitude__38 = (v229 - v228).magnitude;
    local v231 = workspace:FindFirstChild("FE_Ignorable");
    if v231 == nil then
        v231 = l__new__6("Folder", workspace);
        v231.Name = "FE_Ignorable";
    end;
    local v232 = l__new__6("Part");
    v232.Anchored = true;
    v232.CanCollide = false;
    v232.CanQuery = false;
    v232.Size = Vector3.new(1, 1, 1);
    local v233 = l__new__6("BlockMesh", v232);
    v232.Size = Vector3.new(0.1, 0.1, 1);
    if v230 == true then
        v232.BrickColor = l__new__11("Sea green");
    else
        v232.BrickColor = p226.TeamColor;
    end;
    v232.Transparency = 0.25;
    v232.Material = l__Neon__16;
    v233.Scale = l__new__5(1, 1, l__magnitude__38);
    v232.CFrame = l__new__9(v228, v229) * l__new__9(0, 0, -l__magnitude__38 / 2);
    v232.Name = "Rayo_anexo_" .. tostring(p226.UserId);
    v232.Parent = v231;
    l__Debris__4:AddItem(v232, 0.06);
end;
v2[tostring("evo")] = function(p234, ...) --[[ Line: 1130 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__9 (copy), l__new__5 (copy), l__Debris__4 (copy)
    local v235 = { ... };
    local v236 = Get_posicion(v235[1]);
    local v237 = Get_posicion(v235[2]);
    if v236 == nil or v237 == nil then
        return nil;
    end;
    local l__magnitude__39 = (v237 - v236).magnitude;
    local v238 = workspace:FindFirstChild("FE_Ignorable");
    if v238 == nil then
        v238 = l__new__6("Folder", workspace);
        v238.Name = "FE_Ignorable";
    end;
    local v239 = l__new__6("Part");
    v239.Anchored = true;
    v239.CanCollide = false;
    v239.CanQuery = false;
    v239.Size = Vector3.new(1, 1, 1);
    local v240 = l__new__6("BlockMesh", v239);
    v239.Size = Vector3.new(0.4, 0.4, 1);
    v239.BrickColor = p234.TeamColor;
    v239.Transparency = 0;
    v239.Material = l__Neon__16;
    v239.CFrame = l__new__9(v236, v237) * l__new__9(0, 0, -l__magnitude__39 / 2);
    v239.Name = "Rayo_evo_" .. tostring(p234.UserId);
    v239.Parent = v238;
    v240.Scale = l__new__5(0.5, 0.5, l__magnitude__39);
    l__Debris__4:AddItem(v239, 0.03);
end;
v2[tostring("smg")] = function(p241, ...) --[[ Line: 1159 ]]
    -- upvalues: l__new__6 (copy), l__new__11 (copy), l__new__9 (copy), l__new__5 (copy), l__Debris__4 (copy)
    local v242 = { ... };
    local v243 = Get_posicion(v242[1]);
    local v244 = Get_posicion(v242[2]);
    if v243 == nil or v244 == nil then
        return nil;
    end;
    local l__magnitude__40 = (v244 - v243).magnitude;
    local v245 = workspace:FindFirstChild("FE_Ignorable");
    if v245 == nil then
        v245 = l__new__6("Folder", workspace);
        v245.Name = "FE_Ignorable";
    end;
    local v246 = l__new__6("Part");
    v246.Anchored = true;
    v246.CanCollide = false;
    v246.CanQuery = false;
    v246.Size = Vector3.new(1, 1, 1);
    local v247 = l__new__6("BlockMesh", v246);
    v246.Size = Vector3.new(0.15, 0.15, 1);
    v246.BrickColor = l__new__11("White");
    v246.Transparency = 0.5;
    v246.CFrame = l__new__9(v243, v244) * l__new__9(0, 0, -l__magnitude__40 / 2);
    v246.Name = "Rayo_smg_" .. tostring(p241.UserId);
    v246.Parent = v245;
    v247.Scale = l__new__5(1, 1, l__magnitude__40);
    l__Debris__4:AddItem(v246, 0.06);
end;
v2[tostring("maxhoek")] = function(p248, ...) --[[ Line: 1187 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__9 (copy), l__new__5 (copy), l__Debris__4 (copy)
    local v249 = { ... };
    local v250 = Get_posicion(v249[1]);
    local v251 = Get_posicion(v249[2]);
    if v250 == nil or v251 == nil then
        return nil;
    end;
    local l__magnitude__41 = (v251 - v250).magnitude;
    local v252 = workspace:FindFirstChild("FE_Ignorable");
    if v252 == nil then
        v252 = l__new__6("Folder", workspace);
        v252.Name = "FE_Ignorable";
    end;
    local v253 = l__new__6("Part");
    v253.Anchored = true;
    v253.CanCollide = false;
    v253.CanQuery = false;
    v253.Size = Vector3.new(1, 1, 1);
    local v254 = l__new__6("BlockMesh", v253);
    v253.Size = Vector3.new(0.2, 0.2, 0.2);
    v253.BrickColor = p248.TeamColor;
    v253.Transparency = 0;
    v253.Material = l__Neon__16;
    v253.CFrame = l__new__9(v250, v251) * l__new__9(0, 0, -l__magnitude__41 * 0.25);
    local v255 = l__new__6("Part");
    v255.Anchored = true;
    v255.CanCollide = false;
    v255.CanQuery = false;
    v255.Size = Vector3.new(1, 1, 1);
    local v256 = l__new__6("BlockMesh", v255);
    v255.Size = Vector3.new(0.2, 0.2, 0.2);
    v255.BrickColor = p248.TeamColor;
    v255.Transparency = 0;
    v255.Material = l__Neon__16;
    v255.CFrame = l__new__9(v250, v251) * l__new__9(0, 0, -l__magnitude__41 * 0.75);
    v253.Name = "Rayo_anexo_" .. tostring(p248.UserId);
    v255.Name = "Rayo_anexo_" .. tostring(p248.UserId);
    v253.Parent = v252;
    v255.Parent = v252;
    v254.Scale = l__new__5(0.45, 0.45, l__magnitude__41 * 2.5);
    v256.Scale = l__new__5(0.45, 0.45, l__magnitude__41 * 2.5);
    l__Debris__4:AddItem(v253, 0.05);
    l__Debris__4:AddItem(v255, 0.1);
end;
v2[tostring("marex")] = function(p257, ...) --[[ Line: 1227 ]]
    -- upvalues: l__new__6 (copy), l__new__5 (copy), l__Neon__16 (copy), l__new__9 (copy), l__LocalPlayer__3 (copy), l__new__11 (copy), l__Debris__4 (copy)
    local v258 = { ... };
    local v259 = Get_posicion(v258[1]);
    local v260 = Get_posicion(v258[2]);
    if v259 == nil or v260 == nil then
        return nil;
    end;
    local v261 = v258[3];
    local l__magnitude__42 = (v260 - v259).magnitude;
    local v262 = workspace:FindFirstChild("FE_Ignorable");
    if v262 == nil then
        v262 = l__new__6("Folder", workspace);
        v262.Name = "FE_Ignorable";
    end;
    local v263 = l__new__6("Part");
    v263.Anchored = true;
    v263.CanCollide = false;
    v263.CanQuery = false;
    v263.Size = Vector3.new(1, 1, 1);
    local v264 = l__new__6("BlockMesh", v263);
    v263.Size = l__new__5(0.2, 0.2, l__magnitude__42);
    v263.Transparency = 0;
    v263.Material = l__Neon__16;
    v263.CFrame = l__new__9(v259, v260) * l__new__9(0, 0, -l__magnitude__42 / 2);
    v263.Name = "Rayo_marex_" .. tostring(l__LocalPlayer__3.UserId);
    if v261 == true then
        v263.BrickColor = l__new__11("Sea green");
    else
        v263.BrickColor = p257.TeamColor;
    end;
    v263.Parent = v262;
    v264.Scale = Vector3.new(0.6, 0.6, 1);
    l__Debris__4:AddItem(v263, 0.03);
end;
v2[tostring("m71")] = function(p265, ...) --[[ Line: 1262 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__5 (copy), l__new__9 (copy), l__Debris__4 (copy)
    local v266 = { ... };
    local v267 = Get_posicion(v266[1]);
    local v268 = Get_posicion(v266[2]);
    if v267 == nil or v268 == nil then
        return nil;
    end;
    local l__magnitude__43 = (v268 - v267).magnitude;
    local v269 = workspace:FindFirstChild("FE_Ignorable");
    if v269 == nil then
        v269 = l__new__6("Folder", workspace);
        v269.Name = "FE_Ignorable";
    end;
    local v270 = l__new__6("Part");
    v270.Anchored = true;
    v270.CanCollide = false;
    v270.CanQuery = false;
    v270.Size = Vector3.new(1, 1, 1);
    local v271 = l__new__6("BlockMesh", v270);
    v270.Size = Vector3.new(0.7, 0.7, 1);
    v270.BrickColor = p265.TeamColor;
    v270.Transparency = 0;
    v270.Material = l__Neon__16;
    v270.Name = "Rayo_surge_" .. tostring(p265.UserId);
    v271.Scale = l__new__5(0.1, 0.1, l__magnitude__43);
    v270.CFrame = l__new__9(v267, v268) * l__new__9(0, 0, -l__magnitude__43 / 2);
    v270.Mesh.Scale = l__new__5(0.1, 0.1, l__magnitude__43);
    v270.BrickColor = p265.TeamColor;
    v270.Parent = v269;
    l__Debris__4:AddItem(v270, 0.05);
end;
v2[tostring("axurial")] = function(p272, ...) --[[ Line: 1293 ]]
    -- upvalues: l__new__6 (copy), l__new__5 (copy), l__Neon__16 (copy), l__new__9 (copy), l__Debris__4 (copy)
    local v273 = { ... };
    local v274 = Get_posicion(v273[1]);
    local v275 = Get_posicion(v273[2]);
    if v274 == nil or v275 == nil then
        return nil;
    end;
    local l__magnitude__44 = (v275 - v274).magnitude;
    local v276 = workspace:FindFirstChild("FE_Ignorable");
    if v276 == nil then
        v276 = l__new__6("Folder", workspace);
        v276.Name = "FE_Ignorable";
    end;
    local v277 = l__new__6("Part");
    v277.Anchored = true;
    v277.CanCollide = false;
    v277.CanQuery = false;
    v277.Size = Vector3.new(1, 1, 1);
    local v278 = l__new__6("BlockMesh", v277);
    v277.Size = l__new__5(0.1, 0.1, l__magnitude__44 / 2);
    v277.BrickColor = p272.TeamColor;
    v277.Transparency = 0;
    v277.Material = l__Neon__16;
    v277.CFrame = l__new__9(v274, v275) * l__new__9(0, 0, -l__magnitude__44 * 0.25);
    local v279 = l__new__6("Part");
    v279.Anchored = true;
    v279.CanCollide = false;
    v279.CanQuery = false;
    v279.Size = Vector3.new(1, 1, 1);
    local v280 = l__new__6("BlockMesh", v279);
    v279.Size = l__new__5(0.1, 0.1, l__magnitude__44 / 2);
    v279.BrickColor = p272.TeamColor;
    v279.Transparency = 0;
    v279.Material = l__Neon__16;
    v279.CFrame = l__new__9(v274, v275) * l__new__9(0, 0, -l__magnitude__44 * 0.75);
    v277.Name = "Rayo_axurial_" .. tostring(p272.UserId);
    v279.Name = "Rayo_axurial_" .. tostring(p272.UserId);
    v277.Parent = v276;
    v279.Parent = v276;
    v278.Scale = Vector3.new(0.75, 0.75, 1);
    v280.Scale = Vector3.new(0.75, 0.75, 1);
    l__Debris__4:AddItem(v277, 0.01);
    l__Debris__4:AddItem(v279, 0.045);
end;
v2[tostring("codex")] = function(p281, ...) --[[ Line: 1333 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__9 (copy), l__new__5 (copy), l__Debris__4 (copy)
    local v282 = { ... };
    local v283 = Get_posicion(v282[1]);
    local v284 = Get_posicion(v282[2]);
    if v283 == nil or v284 == nil then
        return nil;
    end;
    local l__magnitude__45 = (v284 - v283).magnitude;
    local v285 = workspace:FindFirstChild("FE_Ignorable");
    if v285 == nil then
        v285 = l__new__6("Folder", workspace);
        v285.Name = "FE_Ignorable";
    end;
    local v286 = l__new__6("Part");
    v286.Anchored = true;
    v286.CanCollide = false;
    v286.CanQuery = false;
    v286.Size = Vector3.new(1, 1, 1);
    local v287 = l__new__6("BlockMesh", v286);
    v286.Size = Vector3.new(0.1, 0.1, 1);
    v286.BrickColor = p281.TeamColor;
    v286.Transparency = 0.5;
    v286.Material = l__Neon__16;
    v286.CFrame = l__new__9(v283, v284) * l__new__9(0, 0, -l__magnitude__45 / 2);
    v286.Name = "Rayo_codex_" .. tostring(p281.UserId);
    v286.Parent = v285;
    local v288 = l__new__6("ParticleEmitter");
    v288.Color = ColorSequence.new(p281.TeamColor.Color);
    v288:Emit(l__magnitude__45 * 3);
    v288.Size = NumberSequence.new(0.1);
    v288.Transparency = NumberSequence.new(0.8, 0.9);
    v288.LockedToPart = true;
    v288.Acceleration = Vector3.new(0, -10, 0);
    v288.EmissionDirection = Enum.NormalId.Front;
    v288.Texture = "http://www.roblox.com/asset/?id=578032378";
    v288.Lifetime = NumberRange.new(2, 2);
    v288.Rate = 9000;
    v288.Speed = NumberRange.new(10, 10);
    v288.SpreadAngle = Vector2.new(35, 35);
    v287.Scale = l__new__5(1, 1, l__magnitude__45);
    l__Debris__4:AddItem(v286, 0.05);
end;
v2[tostring("sleetclan")] = function(_, ...) --[[ Line: 1378 ]] end;
v2[tostring("rcl")] = function(p289, ...) --[[ Line: 1382 ]]
    -- upvalues: l__new__6 (copy), l__new__9 (copy), l__new__5 (copy), l__Debris__4 (copy)
    local v290 = { ... };
    local v291 = Get_posicion(v290[1]);
    local v292 = Get_posicion(v290[2]);
    if v291 == nil or v292 == nil then
        return nil;
    end;
    local l__magnitude__46 = (v292 - v291).magnitude;
    local v293 = workspace:FindFirstChild("FE_Ignorable");
    if v293 == nil then
        v293 = l__new__6("Folder", workspace);
        v293.Name = "FE_Ignorable";
    end;
    local v294 = l__new__6("Part");
    v294.Anchored = true;
    v294.CanCollide = false;
    v294.CanQuery = false;
    v294.Size = Vector3.new(1, 1, 1);
    local v295 = l__new__6("BlockMesh", v294);
    v294.Size = Vector3.new(1, 1, 1);
    v294.BrickColor = p289.TeamColor;
    v294.Transparency = 0;
    v294.CFrame = l__new__9(v291, v292) * l__new__9(0, 0, -l__magnitude__46 * 0.25);
    v294.Name = "Rayo_rcl_" .. tostring(p289.UserId);
    local v296 = l__new__6("Part");
    v296.Anchored = true;
    v296.CanCollide = false;
    v296.CanQuery = false;
    v296.Size = Vector3.new(1, 1, 1);
    local v297 = l__new__6("BlockMesh", v296);
    v296.Size = Vector3.new(1, 1, 1);
    v296.BrickColor = p289.TeamColor;
    v296.Transparency = 0;
    v296.CanCollide = false;
    v296.Anchored = true;
    v296.CFrame = l__new__9(v291, v292) * l__new__9(0, 0, -l__magnitude__46 * 0.75);
    v296.Name = "Rayo_rcl_" .. tostring(p289.UserId);
    v295.Scale = l__new__5(0.2, 0.2, l__magnitude__46 / 2);
    v297.Scale = l__new__5(0.2, 0.2, l__magnitude__46 / 2);
    v294.Parent = v293;
    v296.Parent = v293;
    l__Debris__4:AddItem(v294, 0.03);
    l__Debris__4:AddItem(v296, 0.06);
end;
v2[tostring("spectrar")] = function(p298, ...) --[[ Line: 1424 ]]
    -- upvalues: l__new__6 (copy), l__Neon__16 (copy), l__new__9 (copy), l__new__5 (copy), l__Debris__4 (copy)
    local v299 = { ... };
    local v300 = Get_posicion(v299[1]);
    local v301 = Get_posicion(v299[2]);
    if v300 == nil or v301 == nil then
        return nil;
    end;
    local l__magnitude__47 = (v301 - v300).magnitude;
    local v302 = workspace:FindFirstChild("FE_Ignorable");
    if v302 == nil then
        v302 = l__new__6("Folder", workspace);
        v302.Name = "FE_Ignorable";
    end;
    local v303 = l__new__6("Part");
    v303.Anchored = true;
    v303.CanCollide = false;
    v303.CanQuery = false;
    v303.Size = Vector3.new(1, 1, 1);
    local v304 = l__new__6("BlockMesh", v303);
    v303.Size = Vector3.new(0.4, 0.4, 1);
    v303.BrickColor = p298.TeamColor;
    v303.Transparency = 0;
    v303.Material = l__Neon__16;
    v303.CFrame = l__new__9(v300, v301) * l__new__9(0, 0, -l__magnitude__47 * 0.25);
    v303.Name = "Rayo_Spectrar_" .. tostring(p298.UserId);
    v303.Parent = v302;
    local v305 = l__new__6("Part");
    v305.Anchored = true;
    v305.CanCollide = false;
    v305.CanQuery = false;
    v305.Size = Vector3.new(1, 1, 1);
    local v306 = l__new__6("BlockMesh", v305);
    v305.Size = Vector3.new(0.4, 0.4, 1);
    v305.BrickColor = p298.TeamColor;
    v305.Transparency = 0;
    v305.Material = l__Neon__16;
    v305.CFrame = l__new__9(v300, v301) * l__new__9(0, 0, -l__magnitude__47 * 0.75);
    v305.Name = "Rayo_Spectrar_" .. tostring(p298.UserId);
    v303.Parent = v302;
    v305.Parent = v302;
    v304.Scale = l__new__5(0.2, 0.2, l__magnitude__47 / 2);
    v306.Scale = l__new__5(0.2, 0.2, l__magnitude__47 / 2);
    l__Debris__4:AddItem(v303, 0.025);
    l__Debris__4:AddItem(v305, 0.035);
end;
v2[tostring("katiba")] = function(p307, ...) --[[ Line: 1468 ]]
    -- upvalues: l__new__6 (copy), l__new__11 (copy), l__new__9 (copy), l__Angles__10 (copy), l__new__5 (copy), l__Debris__4 (copy)
    local v308 = { ... };
    local v309 = Get_posicion(v308[1]);
    local v310 = Get_posicion(v308[2]);
    if v309 == nil or v310 == nil then
        return nil;
    end;
    local l__magnitude__48 = (v310 - v309).magnitude;
    local v311 = workspace:FindFirstChild("FE_Ignorable");
    if v311 == nil then
        v311 = l__new__6("Folder", workspace);
        v311.Name = "FE_Ignorable";
    end;
    local v312 = l__new__6("Part");
    v312.Anchored = true;
    v312.CanCollide = false;
    v312.CanQuery = false;
    v312.Size = Vector3.new(1, 1, 1);
    local v313 = l__new__6("BlockMesh", v312);
    v312.Name = "Rayo_katiba_" .. tostring(p307.UserId);
    v312.Transparency = 0;
    v312.Material = Enum.Material.Concrete;
    v312.BrickColor = l__new__11("Bright yellow");
    v312.Size = Vector3.new(0.1, 1, 0.1);
    v312.CFrame = l__new__9((v309 + v310) / 2, v310) * l__Angles__10(1.5707963267948966, 0, 0);
    v312.Parent = v311;
    v313.Scale = l__new__5(1, l__magnitude__48, 1);
    l__Debris__4:AddItem(v312, 0.04);
end;
v2[tostring("reaper-8")] = function(p314, ...) --[[ Line: 1497 ]]
    -- upvalues: l__new__6 (copy), l__new__11 (copy), l__SmoothPlastic__17 (copy), l__new__9 (copy), l__new__5 (copy), l__ReplicatedStorage__2 (copy), l__abs__8 (copy), u6 (copy), l__new__14 (copy), l__fromRGB__13 (copy), l__Debris__4 (copy)
    local v315 = { ... };
    local v316 = Get_posicion(v315[1]);
    local v317 = Get_posicion(v315[2]);
    if v316 == nil or v317 == nil then
        return nil;
    end;
    local v318 = v315[3];
    local v319 = v315[4];
    local l__magnitude__49 = (v317 - v316).magnitude;
    local v320 = workspace:FindFirstChild("FE_Ignorable");
    if v320 == nil then
        v320 = l__new__6("Folder", workspace);
        v320.Name = "FE_Ignorable";
    end;
    local v321 = l__new__6("Part");
    v321.Anchored = true;
    v321.CanCollide = false;
    v321.CanQuery = false;
    v321.Size = Vector3.new(1, 1, 1);
    local v322 = l__new__6("BlockMesh", v321);
    v321.BrickColor = l__new__11("Cool yellow");
    v321.Material = l__SmoothPlastic__17;
    v321.Size = Vector3.new(1, 1, 1);
    v321.Transparency = 0.7;
    v321.Locked = true;
    v322.Scale = Vector3.new(0.15, 0.15, 1);
    local v323 = l__new__6("Part");
    v323.Anchored = true;
    v323.CanCollide = false;
    v323.CanQuery = false;
    v323.Size = Vector3.new(1, 1, 1);
    local v324 = l__new__6("BlockMesh", v323);
    v323.BrickColor = l__new__11("Cool yellow");
    v323.Material = l__SmoothPlastic__17;
    v323.Size = Vector3.new(1, 1, 1);
    v323.Transparency = 0.5;
    v323.Locked = true;
    v324.Scale = Vector3.new(0.1, 0.1, 1);
    v321.CFrame = l__new__9(v316, v317) * l__new__9(0, 0, -l__magnitude__49 / 2);
    v323.CFrame = l__new__9(v316, v317) * l__new__9(0, 0, -l__magnitude__49 / 2);
    v322.Scale = l__new__5(0.15, 0.15, l__magnitude__49);
    v324.Scale = l__new__5(0.1, 0.1, l__magnitude__49);
    local v325 = workspace:FindFirstChild("FE_Ignorable");
    if v325 == nil then
        v325 = l__new__6("Folder", workspace);
        v325.Name = "FE_Ignorable";
    end;
    v321.Name = "Rayo_reaper8_" .. tostring(p314.UserId);
    v323.Name = "Rayo_reaper8_" .. tostring(p314.UserId);
    v321.Parent = v325;
    v323.Parent = v325;
    if l__ReplicatedStorage__2:FindFirstChild("dot") and v318 ~= nil then
        local v326 = l__ReplicatedStorage__2:FindFirstChild("dot"):clone();
        v326.Parent = v325;
        v326.CFrame = l__new__9(v317);
        v326.Name = "Dot_reaper8_" .. tostring(p314.UserId);
        if l__abs__8(v318.Z) > l__abs__8(v318.Y) and l__abs__8(v318.Z) > l__abs__8(v318.X) then
            if v318.Z > 0 then
                v326.Effect.EmissionDirection = "Back";
                v326.Dust.EmissionDirection = "Back";
            else
                v326.Effect.EmissionDirection = "Front";
                v326.Dust.EmissionDirection = "Front";
            end;
        elseif l__abs__8(v318.Y) > l__abs__8(v318.Z) and l__abs__8(v318.Y) > l__abs__8(v318.X) then
            if v318.Y > 0 then
                v326.Effect.EmissionDirection = "Top";
                v326.Dust.EmissionDirection = "Top";
            else
                v326.Effect.EmissionDirection = "Bottom";
                v326.Dust.EmissionDirection = "Bottom";
            end;
        elseif l__abs__8(v318.X) > l__abs__8(v318.Z) and l__abs__8(v318.X) > l__abs__8(v318.Y) then
            if v318.X > 0 then
                v326.Effect.EmissionDirection = "Right";
                v326.Dust.EmissionDirection = "Right";
            else
                v326.Effect.EmissionDirection = "Left";
                v326.Dust.EmissionDirection = "Left";
            end;
        end;
        if v319 ~= nil and u6(v319) ~= nil then
            v326.Effect.Color = l__new__14(l__fromRGB__13(255, 0, 0));
        end;
        l__Debris__4:AddItem(v326, 0.25);
    end;
    l__Debris__4:AddItem(v321, 0.03);
    l__Debris__4:AddItem(v323, 0.03);
end;
return v2;