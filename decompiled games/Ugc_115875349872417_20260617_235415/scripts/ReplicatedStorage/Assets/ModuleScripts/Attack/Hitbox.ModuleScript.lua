-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Attack.Hitbox
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

if not LPH_OBFUSCATED then
    function LPH_JIT_MAX(p1)
        return p1;
    end;
end;
local l__CollectionService__1 = game:GetService("CollectionService");
local l__TweenService__2 = game:GetService("TweenService");
local l__Debris__3 = game:GetService("Debris");
local u2 = {};
u2.__index = u2;
function u2.new(p3) --[[ Line: 18 ]]
    -- upvalues: u2 (copy)
    local v4 = setmetatable({}, u2);
    v4.shape = p3.shape or "Box";
    v4.offset = p3.offset or CFrame.new();
    v4.origin = p3.origin or CFrame.new();
    v4.size = p3.size or Vector3.new(3, 3, 3);
    v4.angle = p3.angle or 45;
    v4.visible = p3.visible or false;
    v4.part = p3.part or nil;
    return v4;
end;
u2.cast = LPH_JIT_MAX(function(u5) --[[ Line: 37 ]]
    -- upvalues: l__CollectionService__1 (copy), l__Debris__3 (copy), l__TweenService__2 (copy)
    local v6 = l__CollectionService__1:GetTagged("Hurtbox");
    local u7 = u5.origin * u5.offset;
    local u8 = OverlapParams.new();
    u8.FilterType = Enum.RaycastFilterType.Include;
    u8.RespectCanCollide = false;
    u8.FilterDescendantsInstances = v6;
    local function u14(p9, p10) --[[ Line: 45 ]]
        -- upvalues: l__Debris__3 (ref), l__TweenService__2 (ref)
        local v11 = Instance.new("Part");
        v11.Anchored = true;
        v11.CanCollide = false;
        v11.CanQuery = false;
        v11.CastShadow = false;
        v11.Material = Enum.Material.ForceField;
        v11.Color = Color3.fromRGB(255, 0, 0);
        v11.Transparency = 0.5;
        for v12, v13 in pairs(p9) do
            v11[v12] = v13;
        end;
        v11.Parent = workspace;
        l__Debris__3:AddItem(v11, 10);
        l__TweenService__2:Create(v11, TweenInfo.new(10), p10 or {
            Transparency = 1
        }):Play();
        return v11;
    end;
    local v21 = {
        Box = function() --[[ Line: 66 ]]
            -- upvalues: u5 (copy), u14 (copy), u7 (copy), u8 (copy)
            if typeof(u5.size) == "Vector3" then
                if u5.visible then
                    u14({
                        CFrame = u7,
                        Size = u5.size
                    });
                end;
                return workspace:GetPartBoundsInBox(u7, u5.size, u8);
            else
                warn("INVALID SIZE FOR BOX HITBOX:", u5.size);
                return {};
            end;
        end,
        Sphere = function() --[[ Line: 82 ]]
            -- upvalues: u5 (copy), u14 (copy), u7 (copy), u8 (copy)
            if typeof(u5.size) == "number" then
                if u5.visible then
                    u14({
                        Shape = Enum.PartType.Ball,
                        CFrame = u7,
                        Size = Vector3.new(u5.size * 2, u5.size * 2, u5.size * 2)
                    });
                end;
                return workspace:GetPartBoundsInRadius(u7.Position, u5.size, u8);
            else
                warn("INVALID SIZE FOR SPHERE HITBOX (Expects Number):", u5.size);
                return {};
            end;
        end,
        Part = function() --[[ Line: 99 ]]
            -- upvalues: u5 (copy), u7 (copy), u14 (copy), u8 (copy)
            if not u5.part then
                warn("INVALID PART FOR PART HITBOX");
                return {};
            end;
            u5.part.CFrame = u7;
            if u5.visible then
                local v15 = u14({
                    CFrame = u7,
                    Size = u5.part.Size,
                    Shape = u5.part.Shape
                });
                if u5.part:IsA("MeshPart") then
                    v15.Size = u5.part.Size;
                end;
            end;
            return workspace:GetPartsInPart(u5.part, u8);
        end,
        Cone = function() --[[ Line: 123 ]]
            -- upvalues: u5 (copy), u7 (copy), u8 (copy)
            if typeof(u5.size) ~= "number" then
                warn("INVALID SIZE FOR CONE HITBOX (Expects Number Length):", u5.size);
                return {};
            end;
            local l__size__4 = u5.size;
            local l__angle__5 = u5.angle;
            local v16 = workspace:GetPartBoundsInRadius(u7.Position, l__size__4, u8);
            local v17 = math.rad(l__angle__5 / 2);
            local v18 = math.cos(v17);
            local l__Position__6 = u7.Position;
            local l__LookVector__7 = u7.LookVector;
            local v19 = {};
            for _, v20 in ipairs(v16) do
                if v18 <= l__LookVector__7:Dot((v20.Position - l__Position__6).Unit) then
                    table.insert(v19, v20);
                end;
            end;
            return v19;
        end
    };
    if v21[u5.shape] then
        return v21[u5.shape]();
    end;
    warn("INVALID SHAPE TYPE : " .. tostring(u5.shape));
    return {};
end);
return u2;
