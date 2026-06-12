-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__Materials__2 = game:GetService("ReplicatedStorage"):WaitForChild("FTPStorage"):WaitForChild("Remotes"):WaitForChild("Materials");
local l__SmoothPlastic__3 = Enum.Material.SmoothPlastic;
local l__Glass__4 = Enum.Material.Glass;
local l__Neon__5 = Enum.Material.Neon;
local l__ForceField__6 = Enum.Material.ForceField;
local l__DefaultGraphics__7 = l__LocalPlayer__1:WaitForChild("DefaultGraphics");
local u1 = nil;
local function u5() --[[ Line: 27 ]]
    -- upvalues: l__SmoothPlastic__3 (copy), l__Glass__4 (copy), l__Neon__5 (copy), l__ForceField__6 (copy)
    local v2 = workspace:GetDescendants();
    for _, v3 in pairs(v2) do
        if v3:IsA("BasePart") and (v3.Material ~= l__SmoothPlastic__3 and (v3.Material ~= l__Glass__4 and (v3.Material ~= l__Neon__5 and v3.Material ~= l__ForceField__6))) then
            if v3:FindFirstChild("OrigMat_") == nil then
                local v4 = Instance.new("StringValue");
                v4.Name = "OrigMat_";
                v4.Value = v3.Material.Name;
                v4.Parent = v3;
            end;
            v3.Material = l__SmoothPlastic__3;
        end;
    end;
end;
local function u9() --[[ Line: 37 ]]
    -- upvalues: l__SmoothPlastic__3 (copy)
    local v6 = workspace:GetDescendants();
    for _, v7 in pairs(v6) do
        if v7:IsA("BasePart") and v7.Material == l__SmoothPlastic__3 then
            local v8 = v7:FindFirstChild("OrigMat_");
            if v8 ~= nil then
                v7.Material = Enum.Material[v8.Value];
            end;
        end;
    end;
end;
l__Materials__2.OnClientEvent:connect(function(p10) --[[ Line: 61 ]]
    -- upvalues: l__DefaultGraphics__7 (copy), l__SmoothPlastic__3 (copy), l__Glass__4 (copy), l__Neon__5 (copy), l__ForceField__6 (copy)
    if p10 == nil then
    elseif typeof(p10) == "Instance" then
        if l__DefaultGraphics__7.Value == true then
        else
            for _, v11 in pairs(p10:GetDescendants()) do
                if v11:IsA("BasePart") and (v11.Material ~= l__SmoothPlastic__3 and (v11.Material ~= l__Glass__4 and (v11.Material ~= l__Neon__5 and v11.Material ~= l__ForceField__6))) then
                    if v11:FindFirstChild("OrigMat_") == nil then
                        local v12 = Instance.new("StringValue");
                        v12.Name = "OrigMat_";
                        v12.Value = v11.Material.Name;
                        v12.Parent = v11;
                    end;
                    v11.Material = l__SmoothPlastic__3;
                end;
            end;
        end;
    end;
end);
l__DefaultGraphics__7.Changed:connect(function() --[[ Line: 74 ]]
    -- upvalues: l__DefaultGraphics__7 (copy), u1 (ref), u9 (copy), u5 (copy)
    local l__Value__8 = l__DefaultGraphics__7.Value;
    if l__Value__8 == true and (u1 == false or u1 == nil) then
        u1 = true;
        u9();
    else
        if l__Value__8 == false and (u1 == true or u1 == nil) then
            u1 = false;
            u5();
        end;
    end;
end);
local l__Value__9 = l__DefaultGraphics__7.Value;
if l__Value__9 == true and (u1 == false or u1 == nil) then
    u1 = true;
    u9();
elseif l__Value__9 == false and (u1 == true or u1 == nil) then
    u1 = false;
    u5();
end;