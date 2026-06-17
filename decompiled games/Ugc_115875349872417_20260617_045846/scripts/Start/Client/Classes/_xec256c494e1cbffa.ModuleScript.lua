-- Decompiled from: Start.Client.Classes._xec256c494e1cbffa
-- Class: ModuleScript
-- Place: Ugc (115875349872417)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__ItemData__2 = script.Parent.Parent.ItemData;
local u1 = {};
u1.__index = u1;
local u2 = {
    melee = {
        Nothing = l__ItemData__2.Melee._x6dc4f40b6426528e,
        Redliner = l__ItemData__2.Melee._x71d405555be1e808
    },
    gun = {
        BaseGun = l__ItemData__2.Gun._x327d038b4e5405f0,
        Castigate = l__ItemData__2.Gun._x78d6d6a2c0fe5e39,
        Phoenix = l__ItemData__2.Gun._xbc9d33b83896b42a,
        Siege = l__ItemData__2.Gun._xac86e5818fcadc69,
        Monarch = l__ItemData__2.Gun._x6fc0a74ac461b9a3
    },
    augment = {
        Grappler = l__ItemData__2.Augment._x9c5be4395d89f51b
    }
};
function u1._x83ed94bfb82a8c9f() --[[ Line: 35 ]]
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3._x9d6a964d990ca9e1 = false;
    return v3;
end;
function u1._x39572a515f8412a3(p4) --[[ Line: 42 ]]
    -- upvalues: l__ItemData__2 (copy), l__ReplicatedStorage__1 (copy)
    if p4._x9d6a964d990ca9e1 then
    else
        local v5 = l__ItemData__2:GetDescendants();
        local l__Assets__3 = l__ReplicatedStorage__1:WaitForChild("Assets");
        local u6 = l__Assets__3:FindFirstChild("Animations");
        if not u6 then
            u6 = Instance.new("Folder");
            u6.Name = "Animations";
            u6.Parent = l__Assets__3;
        end;
        local u7 = {
            ["0"] = "Idle",
            ["1"] = "Movement",
            ["2"] = "Action",
            ["3"] = "Action2",
            ["4"] = "Action3",
            ["5"] = "Action4"
        };
        local function v21(p8) --[[ Line: 65 ]]
            -- upvalues: u6 (ref), u7 (copy)
            local v9 = p8:GetAttributes();
            local v10 = p8:FindFirstAncestorWhichIsA("Model");
            if v10 and next(v9) ~= nil then
                local v11 = u6:FindFirstChild(v10.Name);
                if v11 and not v11:IsA("Folder") then
                    warn("ANIMATION TARGET EXISTS BUT IS NOT A FOLDER : " .. v10.Name);
                else
                    if not v11 then
                        v11 = Instance.new("Folder");
                        v11.Name = v10.Name;
                        v11.Parent = u6;
                    end;
                    local function v14(p12) --[[ Line: 83 ]]
                        local v13 = p12:lower();
                        return (v13:find("loop") or (v13:find("idle") or (v13:find("run") or (v13:find("walk") or v13:find("aerial"))))) and true or false;
                    end;
                    for v15, v16 in v9 do
                        local v17 = u7[v15:sub(1, 1)];
                        local v18 = v14(v15);
                        if v17 then
                            local v19 = v15:sub(3);
                            local v20 = v11:FindFirstChild(v19);
                            if not (v20 and v20:IsA("Animation")) then
                                v20 = Instance.new("Animation");
                                v20.Parent = v11;
                            end;
                            v20.Name = v19;
                            v20.AnimationId = v16;
                            v20:SetAttribute("Priority", v17);
                            v20:SetAttribute("Looped", v18);
                            v20:SetAttribute("GeneratedByItemRegistry", true);
                        else
                            warn("INVALID PRIORITY VALUE OF animation_name : " .. v15);
                        end;
                    end;
                end;
            end;
        end;
        for _, v22 in v5 do
            if v22:IsA("Animator") then
                v21(v22);
            end;
        end;
        p4._x9d6a964d990ca9e1 = true;
    end;
end;
function u1._xf8b880f970bb89d8(p23, p24, p25) --[[ Line: 129 ]]
    -- upvalues: u2 (copy)
    p23:_x39572a515f8412a3();
    if u2[p24] then
        return u2[p24][p25];
    else
        return nil;
    end;
end;
function u1._x66dbf1eceb70e977(_, p26) --[[ Line: 138 ]]
    -- upvalues: u2 (copy)
    for v27, v28 in pairs(u2) do
        for v29, _ in pairs(v28) do
            if v29 == p26 then
                return v27;
            end;
        end;
    end;
    return nil;
end;
function u1._x44bcd6af41218f92(p30) --[[ Line: 149 ]]
    p30:_x39572a515f8412a3();
end;
return u1;
