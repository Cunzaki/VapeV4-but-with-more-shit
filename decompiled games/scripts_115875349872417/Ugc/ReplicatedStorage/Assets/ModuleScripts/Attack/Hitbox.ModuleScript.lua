-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__TweenService__2 = game:GetService("TweenService");
local l__Debris__3 = game:GetService("Debris");
local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 10 ]]
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.shape = p2.shape or "Box";
    v3.offset = p2.offset or CFrame.new();
    v3.origin = p2.origin or CFrame.new();
    v3.size = p2.size or Vector3.new(3, 3, 3);
    v3.angle = p2.angle or 45;
    v3.visible = p2.visible or false;
    v3.part = p2.part or nil;
    return v3;
end;
function u1.cast(u4) --[[ Line: 29 ]]
    -- upvalues: l__CollectionService__1 (copy), l__Debris__3 (copy), l__TweenService__2 (copy)
    local v5 = l__CollectionService__1:GetTagged("Hurtbox");
    local u6 = u4.origin * u4.offset;
    local u7 = OverlapParams.new();
    u7.FilterType = Enum.RaycastFilterType.Include;
    u7.RespectCanCollide = false;
    u7.FilterDescendantsInstances = v5;
    local function u13(p8, p9) --[[ Line: 37 ]]
        -- upvalues: l__Debris__3 (ref), l__TweenService__2 (ref)
        local v10 = Instance.new("Part");
        v10.Anchored = true;
        v10.CanCollide = false;
        v10.CanQuery = false;
        v10.CastShadow = false;
        v10.Material = Enum.Material.ForceField;
        v10.Color = Color3.fromRGB(255, 0, 0);
        v10.Transparency = 0.5;
        for v11, v12 in pairs(p8) do
            v10[v11] = v12;
        end;
        v10.Parent = workspace;
        l__Debris__3:AddItem(v10, 10);
        l__TweenService__2:Create(v10, TweenInfo.new(10), p9 or {
            Transparency = 1
        }):Play();
        return v10;
    end;
    local v20 = {
        Box = function() --[[ Line: 58 ]]
            -- upvalues: u4 (copy), u13 (copy), u6 (copy), u7 (copy)
            if typeof(u4.size) == "Vector3" then
                if u4.visible then
                    u13({
                        CFrame = u6,
                        Size = u4.size
                    });
                end;
                return workspace:GetPartBoundsInBox(u6, u4.size, u7);
            else
                warn("INVALID SIZE FOR BOX HITBOX:", u4.size);
                return {};
            end;
        end,
        Sphere = function() --[[ Line: 74 ]]
            -- upvalues: u4 (copy), u13 (copy), u6 (copy), u7 (copy)
            if typeof(u4.size) == "number" then
                if u4.visible then
                    u13({
                        Shape = Enum.PartType.Ball,
                        CFrame = u6,
                        Size = Vector3.new(u4.size * 2, u4.size * 2, u4.size * 2)
                    });
                end;
                return workspace:GetPartBoundsInRadius(u6.Position, u4.size, u7);
            else
                warn("INVALID SIZE FOR SPHERE HITBOX (Expects Number):", u4.size);
                return {};
            end;
        end,
        Part = function() --[[ Line: 91 ]]
            -- upvalues: u4 (copy), u6 (copy), u13 (copy), u7 (copy)
            if not u4.part then
                warn("INVALID PART FOR PART HITBOX");
                return {};
            end;
            u4.part.CFrame = u6;
            if u4.visible then
                local v14 = u13({
                    CFrame = u6,
                    Size = u4.part.Size,
                    Shape = u4.part.Shape
                });
                if u4.part:IsA("MeshPart") then
                    v14.Size = u4.part.Size;
                end;
            end;
            return workspace:GetPartsInPart(u4.part, u7);
        end,
        Cone = function() --[[ Line: 115 ]]
            -- upvalues: u4 (copy), u6 (copy), u7 (copy)
            if typeof(u4.size) ~= "number" then
                warn("INVALID SIZE FOR CONE HITBOX (Expects Number Length):", u4.size);
                return {};
            end;
            local l__size__4 = u4.size;
            local l__angle__5 = u4.angle;
            local v15 = workspace:GetPartBoundsInRadius(u6.Position, l__size__4, u7);
            local v16 = math.rad(l__angle__5 / 2);
            local v17 = math.cos(v16);
            local l__Position__6 = u6.Position;
            local l__LookVector__7 = u6.LookVector;
            local v18 = {};
            for _, v19 in ipairs(v15) do
                if v17 <= l__LookVector__7:Dot((v19.Position - l__Position__6).Unit) then
                    table.insert(v18, v19);
                end;
            end;
            return v18;
        end
    };
    if v20[u4.shape] then
        return v20[u4.shape]();
    end;
    warn("INVALID SHAPE TYPE : " .. tostring(u4.shape));
    return {};
end;
return u1;