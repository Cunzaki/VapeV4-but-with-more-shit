-- Decompiled from: ReplicatedStorage.Modules.Mince.TypeCheck
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {
    TypesSet = {
        AttributeIndex = { "string" },
        AttributeValue = {
            "string",
            "boolean",
            "number",
            "UDim",
            "UDim2",
            "BrickColor",
            "Color3",
            "Vector2",
            "Vector3",
            "CFrame",
            "NumberSequence",
            "ColorSequence",
            "NumberRange",
            "Rect",
            "Font"
        }
    }
};
function u1.Init() --[[ Line: 10 ]]
    -- upvalues: u1 (copy)
    for _, v2 in u1.TypesSet do
        for _, v3 in v2 do
            v2[v3] = true;
        end;
    end;
end;
function u1.Set(p4, p5) --[[ Line: 19 ]]
    -- upvalues: u1 (copy)
    local v6 = u1.TypesSet[p4];
    if not v6 then
        error((`No TypesSet by the name of {p4 or "<TypeCheck1>"}.`));
    end;
    local v7 = typeof(p5);
    local v8 = nil;
    if v7 == "Instance" then
        v8 = p5.ClassName;
    elseif v7 == "table" then
        v8 = p5.__type;
    end;
    if not v6[v7] then
        error((`TypeCheckError: Cannot use type {v8 or v7} for '{p4}'.`));
    end;
end;
u1.Init();
return u1;
