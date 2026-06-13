-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.DebugUi
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
local function u5(p3, p4) --[[ Line: 4 ]]
    p3.PushConfig({
        TextColor = p3._config.TextDisabledColor
    });
    p3.Text({ p4 });
    p3.PopConfig();
end;
local function u9(p6, p7) --[[ Line: 10 ]]
    p6.PushConfig({
        TextColor = p6._config.TextDisabledColor
    });
    local v8 = p6.Text({ "(?)" });
    p6.PopConfig();
    p6.PushConfig({
        ContentWidth = UDim.new(0, 350)
    });
    if v8.hovered() then
        p6.Tooltip({ p7 });
    end;
    p6.PopConfig();
end;
local function u19(p10, p11) --[[ Line: 22 ]]
    -- upvalues: u1 (copy)
    local v12 = p10.Window({ (`Editing bone: {p11.Bone.Name}`) });
    v12.isOpened.value = true;
    p11.Radius = p10.InputNum({
        "Radius",
        0.1,
        0,
        (1 / 0),
        "%.3f"
    }, {
        number = p11.Radius
    }).number.value;
    p11.RotationLimit = p10.InputNum({
        "Rotation Limit",
        0.1,
        0,
        180,
        "%.3f"
    }, {
        number = p11.RotationLimit
    }).number.value;
    p11.Anchored = p10.Checkbox({ "Anchored" }, {
        isChecked = p11.Anchored
    }).isChecked.value;
    p10.Text("Axis Lock");
    p10.Indent();
    p10.SameLine();
    p10.Text("X: ");
    local v13 = p10.Checkbox({ "" }, {
        isChecked = p11.AxisLocked[1]
    });
    p10.Text("Y: ");
    local v14 = p10.Checkbox({ "" }, {
        isChecked = p11.AxisLocked[2]
    });
    p10.Text("Z: ");
    local v15 = p10.Checkbox({ "" }, {
        isChecked = p11.AxisLocked[3]
    });
    p10.End();
    p10.End();
    local v16 = p10.State(Vector2.new(p11.XAxisLimits.Min, p11.XAxisLimits.Max));
    local v17 = p10.State(Vector2.new(p11.YAxisLimits.Min, p11.YAxisLimits.Max));
    local v18 = p10.State(Vector2.new(p11.ZAxisLimits.Min, p11.ZAxisLimits.Max));
    p10.Text("Axis Limits");
    p10.Indent();
    p10.DragVector2({
        "X Axis Limit",
        0.05,
        nil,
        nil,
        { "Min: %.2f", "Max: %.2f" }
    }, {
        number = v16
    });
    p10.DragVector2({
        "Y Axis Limit",
        0.05,
        nil,
        nil,
        { "Min: %.2f", "Max: %.2f" }
    }, {
        number = v17
    });
    p10.DragVector2({
        "Z Axis Limit",
        0.05,
        nil,
        nil,
        { "Min: %.2f", "Max: %.2f" }
    }, {
        number = v18
    });
    p10.End();
    p10.End();
    p11.AxisLocked[1] = v13.isChecked.value;
    p11.AxisLocked[2] = v14.isChecked.value;
    p11.AxisLocked[3] = v15.isChecked.value;
    p11.XAxisLimits = NumberRange.new(v16:get().X, v16:get().Y);
    p11.YAxisLimits = NumberRange.new(v17:get().X, v17:get().Y);
    p11.ZAxisLimits = NumberRange.new(v18:get().X, v18:get().Y);
    if v12.closed() then
        u1[p11] = nil;
    end;
end;
local function u27(p20, p21) --[[ Line: 77 ]]
    -- upvalues: u2 (copy)
    local v22 = p20.Window({ (`Editing collider of type: {p21.Type}`) });
    v22.isOpened.value = true;
    local v23 = p20.State(p21.Type);
    local v24 = p20.State(p21.Scale);
    local v25 = p20.State(p21.Offset);
    local v26 = p20.State(p21.Rotation);
    p20.Combo({ "Collider Type" }, {
        index = v23
    });
    p20.Selectable({ "Box", "Box" }, {
        index = v23
    });
    p20.Selectable({ "Sphere", "Sphere" }, {
        index = v23
    });
    p20.Selectable({ "Capsule", "Capsule" }, {
        index = v23
    });
    p20.End();
    p20.DragVector3({
        "Scale",
        0.1,
        0,
        nil
    }, {
        number = v24
    });
    p20.DragVector3({
        "Offset",
        0.1,
        nil,
        nil
    }, {
        number = v25
    });
    p20.DragVector3({
        "Rotation",
        0.5,
        -180,
        180
    }, {
        number = v26
    });
    p21.Type = v23:get();
    p21.Scale = v24:get();
    p21.Offset = v25:get();
    p21.Rotation = v26:get();
    p20.End();
    if v22.closed() then
        u2[p21] = nil;
    end;
end;
return function(p28, p29, p30) --[[ Line: 108 ]]
    -- upvalues: u1 (copy), u19 (copy), u2 (copy), u27 (copy), u9 (copy), u5 (copy)
    local v31 = {};
    for _, v32 in p29.BoneTrees do
        local l__RootPart__1 = v32.RootPart;
        local v33 = v31[l__RootPart__1];
        if not v33 then
            v31[l__RootPart__1] = {};
            v33 = v31[l__RootPart__1];
        end;
        table.insert(v33, v32);
    end;
    for v34, _ in u1 do
        local v35 = `{p29.ID} - {v34.ParentIndex + 1}`;
        p28.PushId(v35);
        u19(p28, v34);
        p28.PopId();
    end;
    for v36, _ in u2 do
        p28.PushId(v36.GUID);
        u27(p28, v36);
        p28.PopId();
    end;
    local v37 = #p29.BoneTrees;
    local v38 = #p29.ColliderObjects;
    local v39 = `{v37} BoneTree{v37 == 1 and "" or "s"}`;
    local v40 = `{v38} Collider{v38 == 1 and "" or "s"}`;
    p28.Window({
        `SmartBone Runtime Editor. {v39}, {v40}`,
        [p28.Args.Window.NoClose] = true
    });
    p28.Tree({ "Debug Gizmos", true }, {
        isUncollapsed = true
    });
    p28.SameLine();
    p28.Checkbox({ "Draw Internal Bone" }, {
        isChecked = p30.DRAW_BONE
    });
    u9(p28, "Draws a sphere with the specified radius of the bone around where SmartBone believes the bone is.");
    p28.End();
    p28.SameLine();
    p28.Checkbox({ "Draw Physical Bone" }, {
        isChecked = p30.DRAW_PHYSICAL_BONE
    });
    u9(p28, "Draws the actual bone objects CFrame with axis arrows.");
    p28.End();
    p28.SameLine();
    p28.Checkbox({ "Draw Root Part" }, {
        isChecked = p30.DRAW_ROOT_PART
    });
    u9(p28, "Draws a bounding box and fills in the root part.");
    p28.End();
    p28.SameLine();
    p28.Checkbox({ "Draw Bounding Box" }, {
        isChecked = p30.DRAW_BOUNDING_BOX
    });
    u9(p28, "Draws the bounding box used for frustum culling");
    p28.End();
    p28.SameLine();
    p28.Checkbox({ "Draw Axis Limits" }, {
        isChecked = p30.DRAW_AXIS_LIMITS
    });
    u9(p28, "Draws the axis limits for each bone.");
    p28.End();
    p28.SameLine();
    p28.Checkbox({ "Draw Rotation Limits" }, {
        isChecked = p30.DRAW_ROTATION_LIMITS
    });
    u9(p28, "Draws the rotation limits for each bone.");
    p28.End();
    p28.SameLine();
    p28.Checkbox({ "Draw Acceleration Info" }, {
        isChecked = p30.DRAW_ACCELERATION_INFO
    });
    u9(p28, "Draws the acceleration and the required values to derive it.");
    p28.End();
    p28.SameLine();
    p28.Checkbox({ "Draw Colliders" }, {
        isChecked = p30.DRAW_COLLIDERS
    });
    u9(p28, "Draws all the colliders this root object can collide with.");
    p28.End();
    p28.SameLine();
    p28.Checkbox({ "Draw Collider Influence" }, {
        isChecked = p30.DRAW_COLLIDER_INFLUENCE
    });
    u9(p28, "Shows the sphere of influence around each collider.");
    p28.End();
    p28.SameLine();
    p28.Checkbox({ "Draw Collider Awake" }, {
        isChecked = p30.DRAW_COLLIDER_AWAKE
    });
    u9(p28, "Shows if a collider is awake or asleep.");
    p28.End();
    p28.SameLine();
    p28.Checkbox({ "Draw Collider Broadphase" }, {
        isChecked = p30.DRAW_COLLIDER_BROADPHASE
    });
    u9(p28, "Shows if a collider isn\'t reaching narrowphase.");
    p28.End();
    p28.SameLine();
    p28.Checkbox({ "Draw Fill Colliders" }, {
        isChecked = p30.DRAW_FILL_COLLIDERS
    });
    u9(p28, "Fills all colliders this root object can collide with.");
    p28.End();
    p28.SameLine();
    p28.Checkbox({ "Draw Contacts" }, {
        isChecked = p30.DRAW_CONTACTS
    });
    u9(p28, "Draws the position and normal of the points which bones collide with colliders.");
    p28.End();
    p28.End();
    p28.Separator();
    u5(p28, "Simulated Objects");
    for v41, v42 in v31 do
        p28.Tree((`{v41.Name} - Root Part`));
        for v43, v44 in v42 do
            p28.Tree((`BoneTree #{v43}`));
            u5(p28, (`Throttled Update Rate: {string.format("%.1f", v44.UpdateRate)} / {string.format("%.1f", v44.Settings.UpdateRate)} fps`));
            u5(p28, (`In View: {v44.InView}`));
            local v45 = p28.State(v44.Settings.Constraint);
            local v46 = p28.State(v44.Settings.WindType);
            local v47 = p28.State(v44.Settings.UpdateRate);
            local v48 = p28.State(v44.Settings.ActivationDistance);
            local v49 = p28.State(v44.Settings.ThrottleDistance);
            p28.SameLine();
            u9(p28, "The constraint used, distance is more flowy while spring is more rigid.");
            p28.Combo({ "Constraint Type" }, {
                index = v45
            });
            p28.Selectable({ "Distance", "Distance" }, {
                index = v45
            });
            p28.Selectable({ "Spring", "Spring" }, {
                index = v45
            });
            p28.End();
            p28.End();
            p28.SameLine();
            u9(p28, "The wind solver used, sine is a smoother wind, noise is more chaotic and hybrid is a mix of the two.");
            p28.Combo({ "Wind Type" }, {
                index = v46
            });
            p28.Selectable({ "Sine", "Sine" }, {
                index = v46
            });
            p28.Selectable({ "Noise", "Noise" }, {
                index = v46
            });
            p28.Selectable({ "Hybrid", "Hybrid" }, {
                index = v46
            });
            p28.End();
            p28.End();
            p28.SameLine();
            u9(p28, "The target update rate for the bone tree");
            p28.SliderNum({
                "Update Rate",
                5,
                0,
                120
            }, {
                number = v47
            });
            p28.End();
            p28.SameLine();
            u9(p28, "The distance at which the bone tree stops updating");
            p28.SliderNum({
                "Activation Distance",
                1,
                0,
                500
            }, {
                number = v48
            });
            p28.End();
            p28.SameLine();
            u9(p28, "The distance at which the bone tree starts throttling its update rate");
            p28.SliderNum({
                "Throttle Distance",
                1,
                0,
                500
            }, {
                number = v49
            });
            p28.End();
            v44.Settings.Constraint = v45:get();
            v44.Settings.WindType = v46:get();
            v44.Settings.UpdateRate = v47:get();
            v44.Settings.ActivationDistance = v48:get();
            v44.Settings.ThrottleDistance = v49:get();
            p28.Table({
                4,
                false,
                false,
                false
            });
            p28.NextColumn();
            p28.Text("Bone #");
            p28.NextColumn();
            p28.Text("Bone Name");
            p28.NextColumn();
            p28.Text("Parent #");
            p28.NextColumn();
            p28.Text("Edit");
            p28.End();
            p28.Table({ 4 });
            for v50, v51 in v44.Bones do
                p28.NextColumn();
                p28.Text((tostring(v50)));
                p28.NextColumn();
                p28.Text(v51.Bone.Name);
                p28.NextColumn();
                p28.Text((tostring(v51.ParentIndex)));
                p28.NextColumn();
                p28.SameLine();
                p28.Text("");
                if p28.SmallButton({ "Edit" }).clicked() then
                    u1[v51] = true;
                end;
                p28.End();
            end;
            p28.End();
            p28.End();
        end;
        p28.End();
    end;
    u5(p28, "Active Colliders");
    for _, v52 in p29.ColliderObjects do
        p28.Tree({ v52.m_Object.Name });
        u5(p28, "Colliders adorned to this object");
        p28.Table({
            5,
            false,
            false,
            false
        });
        p28.NextColumn();
        p28.Text("Type");
        p28.NextColumn();
        p28.Text("Scale");
        p28.NextColumn();
        p28.Text("Offset");
        p28.NextColumn();
        p28.Text("Rotation");
        p28.NextColumn();
        p28.Text("Edit");
        p28.End();
        p28.Table({ 5 });
        for _, v53 in v52.Colliders do
            p28.NextColumn();
            p28.Text((tostring(v53.Type)));
            p28.NextColumn();
            p28.Text((tostring(v53.Scale)));
            p28.NextColumn();
            p28.Text((tostring(v53.Offset)));
            p28.NextColumn();
            p28.Text((tostring(v53.Rotation)));
            p28.NextColumn();
            p28.SameLine();
            p28.Text("");
            if p28.SmallButton({ "Edit" }).clicked() then
                u2[v53] = true;
            end;
            p28.End();
        end;
        p28.End();
        p28.End();
    end;
    p28.End();
end;
