-- Decompiled from: ReplicatedStorage.Modules.NexusVRBackpack.NexusVRBackpack.UI.ToolGrid
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ToolIcon__1 = require(script.Parent:WaitForChild("ToolIcon"));
local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 28 ]]
    -- upvalues: u1 (copy)
    local v2 = {
        IconGroups = {}
    };
    setmetatable(v2, u1);
    local v3 = Instance.new("Frame");
    v3.BackgroundTransparency = 1;
    v3.AnchorPoint = Vector2.new(0.5, 0.5);
    v3.Position = UDim2.new(0.5, 0, 0.5, 0);
    v2.AdornFrame = v3;
    return v2;
end;
function u1.CreateToolIcon(p4, p5, p6) --[[ Line: 49 ]]
    -- upvalues: l__ToolIcon__1 (copy)
    return l__ToolIcon__1.new(p4.AdornFrame, p5, p6);
end;
function u1.SetRadius(p7, p8) --[[ Line: 56 ]]
    local v9 = math.max(1, p8);
    if v9 == #p7.IconGroups then
    else
        for v10 = #p7.IconGroups + 1, v9 do
            local v11 = {};
            for v12 = 1, v10 + 1 do
                table.insert(v11, p7:CreateToolIcon(-(v10 + 1) / 2 + v12 - 0.5, -v10));
            end;
            local v13 = v10 + 1;
            local v14 = {};
            for v15 = 2, v10 * 2 do
                if v15 <= v10 + 1 then
                    v13 = v13 + 1;
                else
                    v13 = v13 + -1;
                end;
                table.insert(v14, p7:CreateToolIcon(-v13 / 2 + 1 - 0.5, -v10 + v15 - 1));
                table.insert(v11, p7:CreateToolIcon(-v13 / 2 + v13 - 0.5, -v10 + v15 - 1));
            end;
            for v16 = v10 + 1, 1, -1 do
                table.insert(v11, p7:CreateToolIcon(-(v10 + 1) / 2 + v16 - 0.5, v10));
            end;
            for v17 = #v14, 1, -1 do
                table.insert(v11, v14[v17]);
            end;
            table.insert(p7.IconGroups, v11);
        end;
        for v18 = #p7.IconGroups, v9 + 1, -1 do
            local v19 = p7.IconGroups[v18];
            table.remove(p7.IconGroups, v18);
            for _, v20 in v19 do
                v20:Destroy();
            end;
        end;
    end;
end;
function u1.SetTools(p21, p22) --[[ Line: 106 ]]
    local v23 = 6;
    local v24 = 1;
    while v23 < #p22 do
        v24 = v24 + 1;
        v23 = v23 + v24 * 6;
    end;
    p21:SetRadius(v24);
    local v25 = 1;
    for _, v26 in p21.IconGroups do
        for _, v27 in v26 do
            v27:SetTool(p22[v25]);
            v25 = v25 + 1;
        end;
    end;
end;
function u1.UpdateFocusedIcon(p28, p29, p30) --[[ Line: 129 ]]
    local v31 = 0.5;
    local v32 = nil;
    for _, v33 in p28.IconGroups do
        for _, v34 in v33 do
            local v35 = ((p29 - v34.RelativePositionX) ^ 2 + (p30 - v34.RelativePositionY) ^ 2) ^ 0.5;
            if v35 < v31 then
                v32 = v34;
                v31 = v35;
            end;
        end;
    end;
    if v32 ~= p28.FocusedIcon then
        if p28.FocusedIcon then
            p28.FocusedIcon:SetFocused(false);
        end;
        if v32 then
            v32:SetFocused(true);
        end;
        p28.FocusedIcon = v32;
    end;
end;
function u1.Destroy(p36) --[[ Line: 158 ]]
    p36.AdornFrame:Destroy();
    for _, v37 in p36.IconGroups do
        for _, v38 in v37 do
            v38:Destroy();
        end;
    end;
    p36.IconGroups = {};
end;
return u1;
