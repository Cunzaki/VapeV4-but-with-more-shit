-- Decompiled from: ReplicatedStorage.Client.Class.HumanoidDescriptionApplier
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
game:GetService("Players"):GetHumanoidDescriptionFromUserId(1);
local u1 = {
    MaxItems = 50,
    InitialHumanoidDescriptions = {}
};
function u1.ModifyAccessories(p2, p3, p4, p5) --[[ Line: 12 ]]
    -- upvalues: u1 (copy)
    local v6 = p5 or {};
    if p3 then
        if p2 then
            if type(p4) == "table" then
                for v7, v8 in p4 do
                    if type(v7) ~= "number" then
                        return;
                    end;
                    if type(v8) ~= "table" then
                        return;
                    end;
                    if type(v8.AssetId) ~= "number" then
                        return;
                    end;
                    if typeof(v8.AccessoryType) ~= "EnumItem" then
                        return;
                    end;
                end;
                if #p4 > u1.MaxItems then
                else
                    local l__Parent__1 = p2.Parent;
                    for _, v9 in { "Pants", "Shirt" } do
                        local v10 = l__Parent__1:FindFirstChildWhichIsA(v9);
                        if v10 and v6[v9] then
                            v10:Destroy();
                        end;
                    end;
                    task.wait();
                    local v11 = p3:Clone();
                    v11:SetAccessories(p4, true);
                    v11.Pants = v6.Pants or p3.Pants;
                    v11.Shirt = v6.Shirt or p3.Shirt;
                    p2:ApplyDescription(p3);
                    p2:ApplyDescription(v11);
                end;
            end;
        end;
    end;
end;
function u1.Setup() --[[ Line: 51 ]] end;
return u1;
