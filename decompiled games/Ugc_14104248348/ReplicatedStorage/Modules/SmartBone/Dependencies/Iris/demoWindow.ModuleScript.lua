-- Decompiled from: ReplicatedStorage.Modules.SmartBone.Dependencies.Iris.demoWindow
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

require(script.Parent.Types);
return function(u1) --[[ Line: 3 ]]
    local u2 = u1.State(true);
    local u3 = u1.State(false);
    local u4 = u1.State(false);
    local u5 = u1.State(false);
    local u6 = u1.State(false);
    local u7 = u1.State(false);
    local function u10(p8) --[[ Line: 12 ]]
        -- upvalues: u1 (copy)
        u1.PushConfig({
            TextColor = u1._config.TextDisabledColor
        });
        local v9 = u1.Text({ "(?)" });
        u1.PopConfig();
        u1.PushConfig({
            ContentWidth = UDim.new(0, 350)
        });
        if v9.hovered() then
            u1.Tooltip({ p8 });
        end;
        u1.PopConfig();
    end;
    local u42 = {
        Basic = function() --[[ Name: Basic, Line 26 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Basic" });
            u1.SeparatorText({ "Basic" });
            local v11 = u1.State(1);
            u1.Button({ "Button" });
            u1.SmallButton({ "SmallButton" });
            u1.Text({ "Text" });
            u1.TextWrapped({ string.rep("Text Wrapped ", 5) });
            u1.TextColored({ "Colored Text", Color3.fromRGB(255, 128, 0) });
            u1.Text({
                "Rich Text: <b>bold text</b> <i>italic text</i> <u>underline text</u> <s>strikethrough text</s> <font color= \"rgb(240, 40, 10)\">red text</font> <font size=\"32\">bigger text</font>",
                true,
                nil,
                true
            });
            u1.SameLine();
            u1.RadioButton({ "Index \'1\'", 1 }, {
                index = v11
            });
            u1.RadioButton({ "Index \'two\'", "two" }, {
                index = v11
            });
            if u1.RadioButton({ "Index \'false\'", false }, {
                index = v11
            }).active() == false and u1.SmallButton({ "Select last" }).clicked() then
                v11:set(false);
            end;
            u1.End();
            u1.Text({ "The Index is: " .. tostring(v11.value) });
            u1.SeparatorText({ "Inputs" });
            u1.InputNum({});
            u1.DragNum({});
            u1.SliderNum({});
            u1.End();
        end,
        Tree = function() --[[ Name: Tree, Line 57 ]]
            -- upvalues: u1 (copy), u10 (copy)
            u1.Tree({ "Trees" });
            u1.Tree({
                "Tree using SpanAvailWidth",
                [u1.Args.Tree.SpanAvailWidth] = true
            });
            u10("SpanAvailWidth determines if the Tree is selectable from its entire with, or only the text area");
            u1.End();
            local v12 = u1.Tree({ "Tree with Children" });
            u1.Text({ "Im inside the first tree!" });
            u1.Button({ "Im a button inside the first tree!" });
            u1.Tree({ "Im a tree inside the first tree!" });
            u1.Text({ "I am the innermost text!" });
            u1.End();
            u1.End();
            u1.Checkbox({ "Toggle above tree" }, {
                isChecked = v12.state.isUncollapsed
            });
            u1.End();
        end,
        CollapsingHeader = function() --[[ Name: CollapsingHeader, Line 76 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Collapsing Headers" });
            u1.CollapsingHeader({ "A header" });
            u1.Text({ "This is under the first header!" });
            u1.End();
            local v13 = u1.State(true);
            u1.CollapsingHeader({ "Another header" }, {
                isUncollapsed = v13
            });
            if u1.Button({ "Shhh... secret button!" }).clicked() then
                v13:set(true);
            end;
            u1.End();
            u1.End();
        end,
        Group = function() --[[ Name: Group, Line 91 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Groups" });
            u1.SameLine();
            u1.Group();
            u1.Text({ "I am in group A" });
            u1.Button({ "Im also in A" });
            u1.End();
            u1.Separator();
            u1.Group();
            u1.Text({ "I am in group B" });
            u1.Button({ "Im also in B" });
            u1.Button({ "Also group B" });
            u1.End();
            u1.End();
            u1.End();
        end,
        Indent = function() --[[ Name: Indent, Line 110 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Indents" });
            u1.Text({ "Not Indented" });
            u1.Indent();
            u1.Text({ "Indented" });
            u1.Indent({ 7 });
            u1.Text({ "Indented by 7 more pixels" });
            u1.End();
            u1.Indent({ -7 });
            u1.Text({ "Indented by 7 less pixels" });
            u1.End();
            u1.End();
            u1.End();
        end,
        Input = function() --[[ Name: Input, Line 126 ]]
            -- upvalues: u1 (copy), u10 (copy)
            u1.Tree({ "Input" });
            local v14 = u1.State(false);
            local v15 = u1.State(false);
            local v16 = u1.State(0);
            local v17 = u1.State(100);
            local v18 = u1.State(1);
            local v19 = u1.State("%d");
            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            local v20 = u1.InputNum({
                "Input Number",
                [u1.Args.InputNum.NoButtons] = v15.value,
                [u1.Args.InputNum.Min] = v16.value,
                [u1.Args.InputNum.Max] = v17.value,
                [u1.Args.InputNum.Increment] = v18.value,
                [u1.Args.InputNum.Format] = { v19.value }
            });
            u1.PopConfig();
            u1.Text({ "The Value is: " .. v20.number.value });
            if u1.Button({ "Randomize Number" }).clicked() then
                v20.number:set(math.random(1, 99));
            end;
            local v21 = u1.Checkbox({ "NoField" }, {
                isChecked = v14
            });
            local v22 = u1.Checkbox({ "NoButtons" }, {
                isChecked = v15
            });
            if v21.checked() and v22.isChecked.value == true then
                v22.isChecked:set(false);
            end;
            if v22.checked() and v21.isChecked.value == true then
                v21.isChecked:set(false);
            end;
            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            u1.InputVector2({ "InputVector2" });
            u1.InputVector3({ "InputVector3" });
            u1.InputUDim({ "InputUDim" });
            u1.InputUDim2({ "InputUDim2" });
            local v23 = u1.State(false);
            local v24 = u1.State(false);
            local v25 = u1.State(Color3.new());
            local v26 = u1.State(0);
            u1.SliderNum({
                "Transparency",
                0.01,
                0,
                1
            }, {
                number = v26
            });
            u1.InputColor3({ "InputColor3", v23:get(), v24:get() }, {
                color = v25
            });
            u1.InputColor4({ "InputColor4", v23:get(), v24:get() }, {
                color = v25,
                transparency = v26
            });
            u1.SameLine();
            u1.Text({ v25:get():ToHex() });
            u1.Checkbox({ "Use Floats" }, {
                isChecked = v23
            });
            u1.Checkbox({ "Use HSV" }, {
                isChecked = v24
            });
            u1.End();
            u1.PopConfig();
            u1.Separator();
            u1.SameLine();
            u1.Text({ "Slider Numbers" });
            u10("ctrl + click slider number widgets to input a number");
            u1.End();
            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            u1.SliderNum({
                "Slide Int",
                1,
                1,
                8
            });
            u1.SliderNum({
                "Slide Float",
                0.01,
                0,
                100
            });
            u1.SliderNum({
                "Small Numbers",
                0.001,
                -2,
                1,
                "%f radians"
            });
            u1.SliderNum({
                "Odd Ranges",
                0.001,
                -3.141592653589793,
                3.141592653589793,
                "%f radians"
            });
            u1.SliderNum({
                "Big Numbers",
                10000,
                100000,
                10000000
            });
            u1.SliderNum({
                "Few Numbers",
                1,
                0,
                3
            });
            u1.PopConfig();
            u1.Separator();
            u1.SameLine();
            u1.Text({ "Drag Numbers" });
            u10("ctrl + click or double click drag number widgets to input a number, hold shift/alt while dragging to increase/decrease speed");
            u1.End();
            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            u1.DragNum({ "Drag Int" });
            u1.DragNum({
                "Slide Float",
                0.001,
                -10,
                10
            });
            u1.DragNum({
                "Percentage",
                1,
                0,
                100,
                "%d %%"
            });
            u1.PopConfig();
            u1.End();
        end,
        InputText = function() --[[ Name: InputText, Line 203 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Input Text" });
            u1.PushConfig({
                ContentWidth = UDim.new(0, 250)
            });
            local v27 = u1.InputText({
                "Input Text Test",
                [u1.Args.InputText.TextHint] = "Input Text here"
            });
            u1.PopConfig();
            u1.Text({ "The text is: " .. v27.text.value });
            u1.End();
        end,
        MultiInput = function() --[[ Name: MultiInput, Line 212 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Multi-Component Input" });
            local v28 = u1.State(Vector2.new());
            local v29 = u1.State((Vector3.new()));
            local v30 = u1.State(UDim.new());
            local v31 = u1.State(UDim2.new());
            local v32 = u1.State(Color3.new());
            local v33 = u1.State(Rect.new(0, 0));
            u1.SeparatorText({ "Input" });
            u1.InputVector2({}, {
                number = v28
            });
            u1.InputVector3({}, {
                number = v29
            });
            u1.InputUDim({}, {
                number = v30
            });
            u1.InputUDim2({}, {
                number = v31
            });
            u1.InputRect({}, {
                number = v33
            });
            u1.SeparatorText({ "Drag" });
            u1.DragVector2({}, {
                number = v28
            });
            u1.DragVector3({}, {
                number = v29
            });
            u1.DragUDim({}, {
                number = v30
            });
            u1.DragUDim2({}, {
                number = v31
            });
            u1.DragRect({}, {
                number = v33
            });
            u1.SeparatorText({ "Slider" });
            u1.SliderVector2({}, {
                number = v28
            });
            u1.SliderVector3({}, {
                number = v29
            });
            u1.SliderUDim({}, {
                number = v30
            });
            u1.SliderUDim2({}, {
                number = v31
            });
            u1.SliderRect({}, {
                number = v33
            });
            u1.SeparatorText({ "Color" });
            u1.InputColor3({}, {
                color = v32
            });
            u1.InputColor4({}, {
                color = v32
            });
            u1.End();
        end,
        Tooltip = function() --[[ Name: Tooltip, Line 254 ]]
            -- upvalues: u1 (copy)
            u1.PushConfig({
                ContentWidth = UDim.new(0, 250)
            });
            u1.Tree({ "Tooltip" });
            if u1.Text({ "Hover over me to reveal a tooltip" }).hovered() then
                u1.Tooltip({ "I am some helpful tooltip text" });
            end;
            local v34 = u1.State("Hello ");
            local v35 = u1.State(1);
            if u1.InputNum({
                "# of repeat",
                1,
                1,
                50
            }, {
                number = v35
            }).numberChanged() then
                v34:set(string.rep("Hello ", v35:get()));
            end;
            if u1.Checkbox({ "Show dynamic text tooltip" }).isChecked.value then
                u1.Tooltip({ v34:get() });
            end;
            u1.End();
            u1.PopConfig();
        end,
        Selectable = function() --[[ Name: Selectable, Line 272 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Selectable" });
            local v36 = u1.State(2);
            u1.Selectable({ "Selectable #1", 1 }, {
                index = v36
            });
            u1.Selectable({ "Selectable #2", 2 }, {
                index = v36
            });
            if u1.Selectable({ "Double click Selectable", 3, true }, {
                index = v36
            }).doubleClicked() then
                v36:set(3);
            end;
            u1.Selectable({ "Impossible to select", 4, true }, {
                index = v36
            });
            if u1.Button({ "Select last" }).clicked() then
                v36:set(4);
            end;
            u1.Selectable({ "Independent Selectable" });
            u1.End();
        end,
        Combo = function() --[[ Name: Combo, Line 288 ]]
            -- upvalues: u1 (copy)
            u1.Tree({ "Combo" });
            u1.PushConfig({
                ContentWidth = UDim.new(1, -120)
            });
            local v37 = u1.State("No Selection");
            u1.SameLine();
            local v38 = u1.Checkbox({ "No Preview" });
            local v39 = u1.Checkbox({ "No Button" });
            if v38.checked() and v39.isChecked.value == true then
                v39.isChecked:set(false);
            end;
            if v39.checked() and v38.isChecked.value == true then
                v38.isChecked:set(false);
            end;
            u1.End();
            u1.Combo({ "Basic Usage", v39.isChecked:get(), v38.isChecked:get() }, {
                index = v37
            });
            u1.Selectable({ "Select 1", "One" }, {
                index = v37
            });
            u1.Selectable({ "Select 2", "Two" }, {
                index = v37
            });
            u1.Selectable({ "Select 3", "Three" }, {
                index = v37
            });
            u1.End();
            u1.ComboArray({ "Using ComboArray" }, {
                index = "No Selection"
            }, { "Red", "Green", "Blue" });
            local v40 = u1.State("7 AM");
            u1.Combo({ "Combo with Inner widgets" }, {
                index = v40
            });
            u1.Tree({ "Morning Shifts" });
            u1.Selectable({ "Shift at 7 AM", "7 AM" }, {
                index = v40
            });
            u1.Selectable({ "Shift at 11 AM", "11 AM" }, {
                index = v40
            });
            u1.Selectable({ "Shist at 3 PM", "3 PM" }, {
                index = v40
            });
            u1.End();
            u1.Tree({ "Night Shifts" });
            u1.Selectable({ "Shift at 6 PM", "6 PM" }, {
                index = v40
            });
            u1.Selectable({ "Shift at 9 PM", "9 PM" }, {
                index = v40
            });
            u1.End();
            u1.End();
            local v41 = u1.ComboEnum({ "Using ComboEnum" }, {
                index = Enum.UserInputState.Begin
            }, Enum.UserInputState);
            u1.Text({ "Selected: " .. v41.index:get().Name });
            u1.PopConfig();
            u1.End();
        end
    };
    local u43 = {
        "Basic",
        "Tree",
        "CollapsingHeader",
        "Group",
        "Indent",
        "Input",
        "MultiInput",
        "InputText",
        "Tooltip",
        "Selectable",
        "Combo"
    };
    local function u44() --[[ Line: 331 ]]
        -- upvalues: u1 (copy), u44 (copy)
        if u1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
            u44();
        end;
        u1.End();
    end;
    local function u47(p45) --[[ Line: 339 ]]
        -- upvalues: u1 (copy), u47 (copy)
        u1.Window({ "Recursive Window" }, {
            size = u1.State(Vector2.new(175, 100)),
            isOpened = p45
        });
        local v46 = u1.Checkbox({ "Recurse Again" });
        u1.End();
        if v46.isChecked.value then
            u47(v46.isChecked);
        end;
    end;
    local function u68() --[[ Line: 349 ]]
        -- upvalues: u1 (copy), u4 (copy), u10 (copy)
        local v48 = u1.Window({ "Runtime Info" }, {
            isOpened = u4
        });
        local l___lastVDOM__1 = u1.Internal._lastVDOM;
        local l___states__2 = u1.Internal._states;
        local v49 = u1.State(3);
        local v50 = u1.State(0);
        local v51 = u1.State(os.clock());
        u1.SameLine();
        u1.InputNum({
            "",
            [u1.Args.InputNum.Format] = "%d Seconds",
            [u1.Args.InputNum.Max] = 10
        }, {
            number = v49
        });
        if u1.Button({ "Disable" }).clicked() then
            u1.Disabled = true;
            task.delay(v49:get(), function() --[[ Line: 362 ]]
                -- upvalues: u1 (ref)
                u1.Disabled = false;
            end);
        end;
        u1.End();
        local v52 = os.clock();
        v50.value = v50.value + (v52 - v51.value - v50.value) * 0.2;
        v51.value = v52;
        u1.Text({ string.format("Average %.3f ms/frame (%.1f FPS)", v50.value * 1000, 1 / v50.value) });
        u1.Text({ string.format("Window Position: (%d, %d), Window Size: (%d, %d)", v48.position.value.X, v48.position.value.Y, v48.size.value.X, v48.size.value.Y) });
        u1.SameLine();
        u1.Text({ "Enter an ID to learn more about it." });
        u10("every widget and state has an ID which Iris tracks to remember which widget is which. below lists all widgets and states, with their respective IDs");
        u1.End();
        u1.PushConfig({
            ItemWidth = UDim.new(1, -150)
        });
        local l__value__3 = u1.InputText({ "ID field" }, {
            text = u1.State(v48.ID)
        }).text.value;
        u1.PopConfig();
        u1.Indent();
        local v53 = l___lastVDOM__1[l__value__3];
        local v54 = l___states__2[l__value__3];
        if v53 then
            u1.Table({
                1,
                [u1.Args.Table.RowBg] = false
            });
            u1.Text({ string.format("The ID, \"%s\", is a widget", l__value__3) });
            u1.NextRow();
            u1.Text({ string.format("Widget is type: %s", v53.type) });
            u1.NextRow();
            u1.Tree({ "Widget has Args:" }, {
                isUncollapsed = u1.State(true)
            });
            for v55, v56 in v53.arguments do
                u1.Text({ v55 .. " - " .. tostring(v56) });
            end;
            u1.End();
            u1.NextRow();
            if v53.state then
                u1.Tree({ "Widget has State:" }, {
                    isUncollapsed = u1.State(true)
                });
                for v57, v58 in v53.state do
                    u1.Text({ v57 .. " - " .. tostring(v58.value) });
                end;
                u1.End();
            end;
            u1.End();
        elseif v54 then
            u1.Table({
                1,
                [u1.Args.Table.RowBg] = false
            });
            u1.Text({ string.format("The ID, \"%s\", is a state", l__value__3) });
            u1.NextRow();
            u1.Text({ string.format("Value is type: %s, Value = %s", typeof(v54.value), (tostring(v54.value))) });
            u1.NextRow();
            u1.Tree({ "state has connected widgets:" }, {
                isUncollapsed = u1.State(true)
            });
            for v59, v60 in v54.ConnectedWidgets do
                u1.Text({ v59 .. " - " .. v60.type });
            end;
            u1.End();
            u1.NextRow();
            u1.Text({ string.format("state has: %d connected functions", #v54.ConnectedFunctions) });
            u1.End();
        else
            u1.Text({ string.format("The ID, \"%s\", is not a state or widget", l__value__3) });
        end;
        u1.End();
        if u1.Tree({ "Widgets" }).isUncollapsed.value then
            local v61 = 0;
            local v62 = "";
            for _, v63 in l___lastVDOM__1 do
                v61 = v61 + 1;
                v62 = v62 .. "\n" .. v63.ID .. " - " .. v63.type;
            end;
            u1.Text({ "Number of Widgets: " .. v61 });
            u1.Text({ v62 });
        end;
        u1.End();
        if u1.Tree({ "States" }).isUncollapsed.value then
            local v64 = 0;
            local v65 = "";
            for v66, v67 in l___states__2 do
                v64 = v64 + 1;
                v65 = v65 .. "\n" .. v66 .. " - " .. tostring(v67.value);
            end;
            u1.Text({ "Number of States: " .. v64 });
            u1.Text({ v65 });
        end;
        u1.End();
        u1.End();
    end;
    local function u69() --[[ Line: 464 ]]
        -- upvalues: u1 (copy), u69 (copy)
        if u1.Menu({ "Recursive" }).state.isOpened.value then
            u1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl });
            u1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl });
            u1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl });
            u1.Separator();
            u1.MenuToggle({ "Autosave" });
            u1.MenuToggle({ "Checked" });
            u1.Separator();
            u1.Menu({ "Options" });
            u1.MenuItem({ "Red" });
            u1.MenuItem({ "Yellow" });
            u1.MenuItem({ "Green" });
            u1.MenuItem({ "Blue" });
            u1.Separator();
            u69();
            u1.End();
        end;
        u1.End();
    end;
    local function u70() --[[ Line: 488 ]]
        -- upvalues: u1 (copy), u69 (copy), u3 (copy), u6 (copy), u7 (copy), u4 (copy), u5 (copy)
        u1.MenuBar();
        u1.Menu({ "File" });
        u1.MenuItem({ "New", Enum.KeyCode.N, Enum.ModifierKey.Ctrl });
        u1.MenuItem({ "Open", Enum.KeyCode.O, Enum.ModifierKey.Ctrl });
        u1.MenuItem({ "Save", Enum.KeyCode.S, Enum.ModifierKey.Ctrl });
        u69();
        u1.MenuItem({ "Quit", Enum.KeyCode.Q, Enum.ModifierKey.Alt });
        u1.End();
        u1.Menu({ "Examples" });
        u1.MenuToggle({ "Recursive Window" }, {
            isChecked = u3
        });
        u1.MenuToggle({ "Windowless" }, {
            isChecked = u6
        });
        u1.MenuToggle({ "Main Menu Bar" }, {
            isChecked = u7
        });
        u1.End();
        u1.Menu({ "Tools" });
        u1.MenuToggle({ "Runtime Info" }, {
            isChecked = u4
        });
        u1.MenuToggle({ "Style Editor" }, {
            isChecked = u5
        });
        u1.End();
        u1.End();
    end;
    local function u89() --[[ Line: 526 ]]
        -- upvalues: u1 (copy), u5 (copy)
        local v71 = u1.State(1);
        local v86 = {
            { "Sizing", function() --[[ Line: 532 ]]
                    -- upvalues: u1 (ref)
                    local v72 = u1.State({});
                    if u1.Button({ "Update Config" }).clicked() then
                        u1.UpdateGlobalConfig(v72:get());
                        v72:set({});
                    end;
                    for _, v73 in {
                        {
                            "ItemWidth",
                            nil,
                            UDim.new(),
                            UDim.new(1, 200)
                        },
                        {
                            "ContentWidth",
                            nil,
                            UDim.new(),
                            UDim.new(1, 200)
                        }
                    } do
                        local v74 = u1.SliderUDim({ table.unpack(v73) }, {
                            number = u1.WeakState(u1._config[v73[1]])
                        });
                        if v74.numberChanged() then
                            v72:get()[v73[1]] = v74.number:get();
                        end;
                    end;
                    for _, v75 in {
                        {
                            "WindowPadding",
                            nil,
                            Vector2.zero,
                            Vector2.one * 20
                        },
                        {
                            "WindowResizePadding",
                            nil,
                            Vector2.zero,
                            Vector2.one * 20
                        },
                        {
                            "FramePadding",
                            nil,
                            Vector2.zero,
                            Vector2.one * 20
                        },
                        {
                            "ItemSpacing",
                            nil,
                            Vector2.zero,
                            Vector2.one * 20
                        },
                        {
                            "ItemInnerSpacing",
                            nil,
                            Vector2.zero,
                            Vector2.one * 20
                        },
                        {
                            "CellPadding",
                            nil,
                            Vector2.zero,
                            Vector2.one * 20
                        },
                        {
                            "DisplaySafeAreaPadding",
                            nil,
                            Vector2.zero,
                            Vector2.one * 20
                        }
                    } do
                        local v76 = u1.SliderVector2({ table.unpack(v75) }, {
                            number = u1.WeakState(u1._config[v75[1]])
                        });
                        if v76.numberChanged() then
                            v72:get()[v75[1]] = v76.number:get();
                        end;
                    end;
                    for _, v77 in {
                        {
                            "TextSize",
                            1,
                            4,
                            20
                        },
                        {
                            "FrameBorderSize",
                            0.1,
                            0,
                            1
                        },
                        {
                            "FrameRounding",
                            1,
                            0,
                            12
                        },
                        {
                            "GrabRounding",
                            1,
                            0,
                            12
                        },
                        {
                            "WindowBorderSize",
                            0.1,
                            0,
                            1
                        },
                        {
                            "PopupBorderSize",
                            0.1,
                            0,
                            1
                        },
                        {
                            "PopupRounding",
                            1,
                            0,
                            12
                        },
                        {
                            "ScrollbarSize",
                            1,
                            0,
                            20
                        },
                        {
                            "GrabMinSize",
                            1,
                            0,
                            20
                        }
                    } do
                        local v78 = u1.SliderNum({ table.unpack(v77) }, {
                            number = u1.WeakState(u1._config[v77[1]])
                        });
                        if v78.numberChanged() then
                            v72:get()[v77[1]] = v78.number:get();
                        end;
                    end;
                    for _, v79 in { "WindowTitleAlign" } do
                        local v80 = u1.ComboEnum({ v79 }, {
                            index = u1.WeakState(u1._config[v79])
                        }, u1._config[v79].EnumType);
                        if v80.closed() then
                            u1.UpdateGlobalConfig({
                                [v79] = v80.index:get()
                            });
                        end;
                    end;
                end },
            { "Colors", function() --[[ Line: 599 ]]
                    -- upvalues: u1 (ref)
                    local v81 = u1.State({});
                    if u1.Button({ "Update Config" }).clicked() then
                        u1.UpdateGlobalConfig(v81:get());
                        v81:set({});
                    end;
                    for _, v82 in { "BorderColor", "BorderActiveColor" } do
                        local v83 = u1.InputColor3({ v82 }, {
                            color = u1.WeakState(u1._config[v82])
                        });
                        if v83.numberChanged() then
                            u1.UpdateGlobalConfig({
                                [v82] = v83.color:get()
                            });
                        end;
                    end;
                    for _, v84 in {
                        "Text",
                        "TextDisabled",
                        "WindowBg",
                        "ScrollbarGrab",
                        "TitleBg",
                        "TitleBgActive",
                        "TitleBgCollapsed",
                        "MenubarBg",
                        "FrameBg",
                        "FrameBgHovered",
                        "FrameBgActive",
                        "Button",
                        "ButtonHovered",
                        "ButtonActive",
                        "SliderGrab",
                        "SliderGrabActive",
                        "Header",
                        "HeaderHovered",
                        "HeaderActive",
                        "SelectionImageObject",
                        "SelectionImageObjectBorder",
                        "TableBorderStrong",
                        "TableBorderLight",
                        "TableRowBg",
                        "TableRowBgAlt",
                        "NavWindowingHighlight",
                        "NavWindowingDimBg",
                        "Separator",
                        "CheckMark"
                    } do
                        local v85 = u1.InputColor4({ v84 }, {
                            color = u1.WeakState(u1._config[v84 .. "Color"]),
                            transparency = u1.WeakState(u1._config[v84 .. "Transparency"])
                        });
                        if v85.numberChanged() then
                            v81:get()[v84 .. "Color"] = v85.color:get();
                            v81:get()[v84 .. "Transparency"] = v85.transparency:get();
                        end;
                    end;
                end }
        };
        u1.Window({ "Style Editor" }, {
            isOpened = u5
        });
        u1.Text({ "Customize the look of Iris in realtime." });
        u1.SameLine();
        if u1.SmallButton({ "Light Theme" }).clicked() then
            u1.UpdateGlobalConfig(u1.TemplateConfig.colorLight);
        end;
        if u1.SmallButton({ "Dark Theme" }).clicked() then
            u1.UpdateGlobalConfig(u1.TemplateConfig.colorDark);
        end;
        u1.End();
        u1.SameLine();
        if u1.SmallButton({ "Classic Size" }).clicked() then
            u1.UpdateGlobalConfig(u1.TemplateConfig.sizeDefault);
        end;
        if u1.SmallButton({ "Larger Size" }).clicked() then
            u1.UpdateGlobalConfig(u1.TemplateConfig.sizeClear);
        end;
        u1.End();
        if u1.SmallButton({ "Reset Everything" }).clicked() then
            u1.UpdateGlobalConfig(u1.TemplateConfig.colorDark);
            u1.UpdateGlobalConfig(u1.TemplateConfig.sizeDefault);
        end;
        u1.Separator();
        u1.SameLine();
        for v87, v88 in ipairs(v86) do
            u1.RadioButton({ v88[1], v87 }, {
                index = v71
            });
        end;
        u1.End();
        v86[v71:get()][2]();
        u1.End();
    end;
    local function u96() --[[ Line: 699 ]]
        -- upvalues: u1 (copy)
        u1.CollapsingHeader({ "Widget Event Interactivity" });
        local v90 = u1.State(0);
        if u1.Button({ "Click to increase Number" }).clicked() then
            v90:set(v90:get() + 1);
        end;
        u1.Text({ "The Number is: " .. v90:get() });
        u1.Separator();
        local v91 = u1.State(false);
        local v92 = u1.State("clicked");
        u1.SameLine();
        u1.RadioButton({ "clicked", "clicked" }, {
            index = v92
        });
        u1.RadioButton({ "rightClicked", "rightClicked" }, {
            index = v92
        });
        u1.RadioButton({ "doubleClicked", "doubleClicked" }, {
            index = v92
        });
        u1.RadioButton({ "ctrlClicked", "ctrlClicked" }, {
            index = v92
        });
        u1.End();
        u1.SameLine();
        if u1.Button({ v92:get() .. " to reveal text" })[v92:get()]() then
            v91:set(not v91:get());
        end;
        if v91:get() then
            u1.Text({ "Here i am!" });
        end;
        u1.End();
        u1.Separator();
        local v93 = u1.State(0);
        u1.SameLine();
        if u1.Button({ "Click to show text for 20 frames" }).clicked() then
            v93:set(20);
        end;
        if v93:get() > 0 then
            u1.Text({ "Here i am!" });
        end;
        u1.End();
        local v94 = v93:get() - 1;
        v93:set((math.max(0, v94)));
        u1.Text({ "Text Timer: " .. v93:get() });
        local v95 = u1.Checkbox({ "Event-tracked checkbox" });
        u1.Indent();
        u1.Text({ "unchecked: " .. tostring(v95.unchecked()) });
        u1.Text({ "checked: " .. tostring(v95.checked()) });
        u1.End();
        u1.SameLine();
        if u1.Button({ "Hover over me" }).hovered() then
            u1.Text({ "The button is hovered" });
        end;
        u1.End();
        u1.End();
    end;
    local function u106() --[[ Line: 755 ]]
        -- upvalues: u1 (copy)
        u1.CollapsingHeader({ "Widget State Interactivity" });
        local v97 = u1.Checkbox({ "Widget-Generated State" });
        u1.Text({ (`isChecked: {v97.state.isChecked.value}\n`) });
        local v98 = u1.State(false);
        local v99 = u1.Checkbox({ "User-Generated State" }, {
            isChecked = v98
        });
        u1.Text({ (`isChecked: {v99.state.isChecked.value}\n`) });
        local v100 = u1.Checkbox({ "Widget Coupled State" });
        local v101 = u1.Checkbox({ "Coupled to above Checkbox" }, {
            isChecked = v100.state.isChecked
        });
        u1.Text({ (`isChecked: {v101.state.isChecked.value}\n`) });
        local v102 = u1.State(false);
        u1.Checkbox({ "Widget and Code Coupled State" }, {
            isChecked = v102
        });
        if u1.Button({ "Click to toggle above checkbox" }).clicked() then
            v102:set(not v102:get());
        end;
        u1.Text({ (`isChecked: {v102.value}\n`) });
        local v103 = u1.State(true);
        local v105 = u1.ComputedState(v103, function(p104) --[[ Line: 777 ]]
            return not p104;
        end);
        u1.Checkbox({ "ComputedState (dynamic coupling)" }, {
            isChecked = v103
        });
        u1.Checkbox({ "Inverted of above checkbox" }, {
            isChecked = v105
        });
        u1.Text({ (`isChecked: {v105.value}\n`) });
        u1.End();
    end;
    local function u110() --[[ Line: 787 ]]
        -- upvalues: u1 (copy), u10 (copy)
        u1.CollapsingHeader({ "Dynamic Styles" });
        local v107 = u1.State(0);
        u1.SameLine();
        if u1.Button({ "Change Color" }).clicked() then
            v107:set(math.random());
        end;
        local l__Text__4 = u1.Text;
        local v108 = {};
        local v109 = v107:get() * 255;
        v108[1] = "Hue: " .. math.floor(v109);
        l__Text__4(v108);
        u10("Using PushConfig with a changing value, this can be done with any config field");
        u1.End();
        u1.PushConfig({
            TextColor = Color3.fromHSV(v107:get(), 1, 1)
        });
        u1.Text({ "Text with a unique and changable color" });
        u1.PopConfig();
        u1.End();
    end;
    local function u123() --[[ Line: 803 ]]
        -- upvalues: u1 (copy), u10 (copy)
        local v111 = u1.State(false);
        u1.CollapsingHeader({ "Tables & Columns" }, {
            isUncollapsed = v111
        });
        if v111.value == false then
            u1.End();
        else
            u1.SameLine();
            u1.Text({ "Table using NextRow and NextColumn syntax:" });
            u10("calling Iris.NextRow() in the outer loop, and Iris.NextColumn()in the inner loop");
            u1.End();
            u1.Table({ 3 });
            for v112 = 1, 4 do
                u1.NextRow();
                for v113 = 1, 3 do
                    u1.NextColumn();
                    u1.Text({ (`Row: {v112}, Column: {v113}`) });
                end;
            end;
            u1.End();
            u1.Text({ "" });
            u1.SameLine();
            u1.Text({ "Table using NextColumn only syntax:" });
            u10("only calling Iris.NextColumn() in the inner loop, the result is identical");
            u1.End();
            u1.Table({ 2 });
            for v114 = 1, 4 do
                for v115 = 1, 2 do
                    u1.NextColumn();
                    u1.Text({ (`Row: {v114}, Column: {v115}`) });
                end;
            end;
            u1.End();
            u1.Separator();
            local v116 = u1.State(false);
            local v117 = u1.State(false);
            local v118 = u1.State(true);
            local v119 = u1.State(true);
            local v120 = u1.State(3);
            u1.Text({ "Table with Customizable Arguments" });
            u1.Table({
                4,
                [u1.Args.Table.RowBg] = v116.value,
                [u1.Args.Table.BordersOuter] = v117.value,
                [u1.Args.Table.BordersInner] = v118.value
            });
            for v121 = 1, v120:get() do
                for v122 = 1, 4 do
                    u1.NextColumn();
                    if v119.value then
                        u1.Button({ (`Month: {v121}, Week: {v122}`) });
                    else
                        u1.Text({ (`Month: {v121}, Week: {v122}`) });
                    end;
                end;
            end;
            u1.End();
            u1.Checkbox({ "RowBg" }, {
                isChecked = v116
            });
            u1.Checkbox({ "BordersOuter" }, {
                isChecked = v117
            });
            u1.Checkbox({ "BordersInner" }, {
                isChecked = v118
            });
            u1.SameLine();
            u1.RadioButton({ "Buttons", true }, {
                index = v119
            });
            u1.RadioButton({ "Text", false }, {
                index = v119
            });
            u1.End();
            u1.InputNum({
                "Number of rows",
                [u1.Args.InputNum.Min] = 0,
                [u1.Args.InputNum.Max] = 100,
                [u1.Args.InputNum.Format] = "%d"
            }, {
                number = v120
            });
            u1.End();
        end;
    end;
    local function u126() --[[ Line: 888 ]]
        -- upvalues: u1 (copy), u10 (copy)
        u1.CollapsingHeader({ "Widget Layout" });
        u1.Tree({ "Content Width" });
        local v124 = u1.State(50);
        local v125 = u1.State(Enum.Axis.X);
        u1.Text({ "The Content Width is a size property which determines the width of input fields." });
        u1.SameLine();
        u1.Text({ "By default the value is UDim.new(0.65, 0)" });
        u10("This is the default value from Dear ImGui.\nIt is 65% of the window width.");
        u1.End();
        u1.Text({ "This works well, but sometimes we know how wide elements are going to be and want to maximise the space." });
        u1.Text({ "Therefore, we can use Iris.PushConfig() to change the width" });
        u1.Separator();
        u1.SameLine();
        u1.Text({ "Content Width = 150 pixels" });
        u10("UDim.new(0, 150)");
        u1.End();
        u1.PushConfig({
            ContentWidth = UDim.new(0, 150)
        });
        u1.DragNum({
            "number",
            1,
            0,
            100
        }, {
            number = v124
        });
        u1.ComboEnum({ "axis" }, {
            index = v125
        }, Enum.Axis);
        u1.PopConfig();
        u1.SameLine();
        u1.Text({ "Content Width = 50% window width" });
        u10("UDim.new(0.5, 0)");
        u1.End();
        u1.PushConfig({
            ContentWidth = UDim.new(0.5, 0)
        });
        u1.DragNum({
            "number",
            1,
            0,
            100
        }, {
            number = v124
        });
        u1.ComboEnum({ "axis" }, {
            index = v125
        }, Enum.Axis);
        u1.PopConfig();
        u1.SameLine();
        u1.Text({ "Content Width = -150 pixels from the right side" });
        u10("UDim.new(1, -150)");
        u1.End();
        u1.PushConfig({
            ContentWidth = UDim.new(1, -150)
        });
        u1.DragNum({
            "number",
            1,
            0,
            100
        }, {
            number = v124
        });
        u1.InputEnum({ "axis" }, {
            index = v125
        }, Enum.Axis);
        u1.PopConfig();
        u1.End();
        u1.End();
    end;
    local function u127() --[[ Line: 935 ]]
        -- upvalues: u1 (copy), u10 (copy)
        u1.PushConfig({
            ItemWidth = UDim.new(0, 150)
        });
        u1.SameLine();
        u1.TextWrapped({ "Windowless widgets" });
        u10("Widgets which are placed outside of a window will appear on the top left side of the screen.");
        u1.End();
        u1.Button({});
        u1.Tree({});
        u1.InputText({});
        u1.End();
        u1.PopConfig();
    end;
    return function() --[[ Line: 949 ]]
        -- upvalues: u1 (copy), u2 (copy), u70 (copy), u96 (copy), u106 (copy), u44 (copy), u110 (copy), u43 (copy), u42 (copy), u123 (copy), u126 (copy), u3 (copy), u47 (copy), u4 (copy), u68 (copy), u5 (copy), u89 (ref), u6 (copy), u127 (copy), u7 (copy)
        local v128 = u1.State(false);
        local v129 = u1.State(false);
        local v130 = u1.State(false);
        local v131 = u1.State(true);
        local v132 = u1.State(false);
        local v133 = u1.State(false);
        local v134 = u1.State(false);
        local v135 = u1.State(false);
        local v136 = u1.State(false);
        if u2.value == false then
            u1.Checkbox({ "Open main window" }, {
                isChecked = u2
            });
        else
            u1.Window({
                "Iris Demo Window",
                [u1.Args.Window.NoTitleBar] = v128.value,
                [u1.Args.Window.NoBackground] = v129.value,
                [u1.Args.Window.NoCollapse] = v130.value,
                [u1.Args.Window.NoClose] = v131.value,
                [u1.Args.Window.NoMove] = v132.value,
                [u1.Args.Window.NoScrollbar] = v133.value,
                [u1.Args.Window.NoResize] = v134.value,
                [u1.Args.Window.NoNav] = v135.value,
                [u1.Args.Window.NoMenu] = v136.value
            }, {
                size = u1.State(Vector2.new(600, 550)),
                position = u1.State(Vector2.new(100, 25)),
                isOpened = u2
            });
            u70();
            u1.Text({ "Iris says hello. (2.1.1)" });
            u1.CollapsingHeader({ "Window Options" });
            u1.Table({
                3,
                false,
                false,
                false
            });
            u1.NextColumn();
            u1.Checkbox({ "NoTitleBar" }, {
                isChecked = v128
            });
            u1.NextColumn();
            u1.Checkbox({ "NoBackground" }, {
                isChecked = v129
            });
            u1.NextColumn();
            u1.Checkbox({ "NoCollapse" }, {
                isChecked = v130
            });
            u1.NextColumn();
            u1.Checkbox({ "NoClose" }, {
                isChecked = v131
            });
            u1.NextColumn();
            u1.Checkbox({ "NoMove" }, {
                isChecked = v132
            });
            u1.NextColumn();
            u1.Checkbox({ "NoScrollbar" }, {
                isChecked = v133
            });
            u1.NextColumn();
            u1.Checkbox({ "NoResize" }, {
                isChecked = v134
            });
            u1.NextColumn();
            u1.Checkbox({ "NoNav" }, {
                isChecked = v135
            });
            u1.NextColumn();
            u1.Checkbox({ "NoMenu" }, {
                isChecked = v136
            });
            u1.End();
            u1.End();
            u96();
            u106();
            u1.CollapsingHeader({ "Recursive Tree" });
            if u1.Tree({ "Recursive Tree" }).state.isUncollapsed.value then
                u44();
            end;
            u1.End();
            u1.End();
            u110();
            u1.Separator();
            u1.CollapsingHeader({ "Widgets" });
            for _, v137 in u43 do
                u42[v137]();
            end;
            u1.End();
            u123();
            u126();
            u1.End();
            if u3.value then
                u47(u3);
            end;
            if u4.value then
                u68();
            end;
            if u5.value then
                u89();
            end;
            if u6.value then
                u127();
            end;
            if u7.value then
                local _ = u1.Internal._rootWidget.Instance.PseudoWindowScreenGui.AbsoluteSize;
                u70();
            end;
        end;
    end;
end;
