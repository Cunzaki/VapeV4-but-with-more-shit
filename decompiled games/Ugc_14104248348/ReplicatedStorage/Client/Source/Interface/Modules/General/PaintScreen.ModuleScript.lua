-- Decompiled from: ReplicatedStorage.Client.Source.Interface.Modules.General.PaintScreen
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__AssetService__2 = game:GetService("AssetService");
local l__GuiService__3 = game:GetService("GuiService");
local l__LocalPlayer__4 = game:GetService("Players").LocalPlayer;
local u1 = l__GuiService__3:GetGuiInset();
local l__Mince__5 = require(l__ReplicatedStorage__1.Modules.Mince);
local l__BaseX__6 = require(l__ReplicatedStorage__1.Modules.BaseX);
local l__Compress__7 = require(l__ReplicatedStorage__1.Modules.Compress);
local l__Numerics__8 = require(l__ReplicatedStorage__1.Modules.Numerics);
local l__Signal__9 = require(l__ReplicatedStorage__1.Modules.Signal);
local u2 = l__Mince__5:Get("Notices");
local u3 = l__Mince__5:Get("BindManager");
local u4 = l__Mince__5:Get("MarketHandler");
local u5 = l__Mince__5:Get("NotifPrompt");
local u6 = l__Mince__5:Get("ConfirmPrompt");
local u7 = l__Mince__5:Get("InterfaceHandler");
local u8 = l__Mince__5:Get("GamepassHandler");
local u9 = l__Mince__5:Get("SelectInteractor");
local u10 = l__Mince__5:GetEvent("PurchaseCanvas");
local u11 = {
    StrokeActive = false,
    ColorPickerVisible = true,
    Mode = "Draw",
    BrushRound = 0,
    BrushSize = 1,
    BrushTransparency = 0,
    MaxBrushSize = 5,
    MaxRoundSize = 2,
    HistoryPosition = 0,
    MaxHistory = 32,
    CurrentResolution = 0,
    Cursor = Vector2.one,
    CurrentColor = Color3.new(1, 0, 0),
    ColorHSV = { 1, 1, 1 },
    CanvasSize = Vector2.new(32, 32),
    History = {},
    Resolutions = {
        [0] = Vector2.new(32, 32),
        [1] = Vector2.new(64, 64)
    },
    Prices = {
        [0] = 25,
        [1] = 100
    },
    DrawingPublished = l__Signal__9.new()
};
local function u21(p12, p13, p14) --[[ Line: 60 ]]
    local l__X__10 = p12.X;
    local l__Y__11 = p12.Y;
    local l__X__12 = p13.X;
    local l__Y__13 = p13.Y;
    local v15 = math.abs(l__X__12 - l__X__10);
    local v16 = math.abs(l__Y__13 - l__Y__11);
    local v17 = l__X__10 < l__X__12 and 1 or -1;
    local v18 = l__Y__11 < l__Y__13 and 1 or -1;
    local v19 = v15 - v16;
    while true do
        p14(Vector2.new(l__X__10, l__Y__11));
        if l__X__10 == l__X__12 and l__Y__11 == l__Y__13 then
            break;
        end;
        local v20 = v19 * 2;
        if -v16 < v20 then
            v19 = v19 - v16;
            l__X__10 = l__X__10 + v17;
        end;
        if v20 < v15 then
            v19 = v19 + v15;
            l__Y__11 = l__Y__11 + v18;
        end;
    end;
end;
function FloorTo(p22, p23)
    return math.floor(p22 / p23) * p23;
end;
function u11.MouseMoved(p24, p25) --[[ Line: 93 ]]
    -- upvalues: u11 (copy), u1 (copy), u21 (copy)
    local v26 = p24 - u11.Content.AbsolutePosition.X;
    local v27 = p25 - u11.Content.AbsolutePosition.Y - u1.Y;
    local l__AbsoluteSize__14 = u11.Content.AbsoluteSize;
    local v28 = math.clamp(v26, 0, l__AbsoluteSize__14.X);
    local v29 = math.clamp(v27, 0, l__AbsoluteSize__14.Y);
    local v30 = l__AbsoluteSize__14.X / u11.CanvasSize.X;
    local v31 = l__AbsoluteSize__14.Y / u11.CanvasSize.Y;
    local v32 = (u11.BrushSize - 1) / 2;
    local v33 = v28 - v30 * v32;
    local v34 = v29 - v31 * v32;
    local v35 = v33 / l__AbsoluteSize__14.X;
    local v36 = v34 / l__AbsoluteSize__14.Y;
    local v37 = math.floor(v35 * u11.CanvasSize.X);
    local v38 = math.floor(v36 * u11.CanvasSize.Y);
    u11.Content.Select.Position = UDim2.fromScale(v37 / u11.CanvasSize.X, v38 / u11.CanvasSize.Y);
    u11.Cursor = Vector2.new(v37, v38);
    local u39 = Vector2.one * math.floor(u11.BrushSize / 2);
    if u11.Mode == "Draw" or u11.Mode == "Erase" then
        local u40 = u11.Mode == "Erase";
        if u11.StrokeActive then
            u11.StrokeWasCreated = true;
            local v41 = Vector2.new(v37, v38);
            if v41 == u11.LastStrokePosition then
                return;
            end;
            u21(u11.LastStrokePosition or v41, v41, function(p42) --[[ Line: 139 ]]
                -- upvalues: u11 (ref), u39 (copy), u40 (copy)
                u11.CanvasEditable:DrawImageTransformed(p42 + u39, Vector2.one, 0, u40 and u11.EraseImage or u11.BrushImage, {
                    CombineType = Enum.ImageCombineType.BlendSourceOver,
                    SamplingMode = Enum.ResamplerMode.Pixelated,
                    PivotPoint = u39
                });
            end);
            u11.LastStrokePosition = v41;
        end;
    end;
end;
function u11.MouseLeave() --[[ Line: 153 ]]
    -- upvalues: u11 (copy)
    u11.LastStrokePosition = nil;
end;
function u11.FloodFill(p43, p44) --[[ Line: 157 ]]
    -- upvalues: u11 (copy)
    local v45 = u11.CanvasEditable:ReadPixelsBuffer(p43, Vector2.one);
    local v46 = Color3.fromRGB(buffer.readu8(v45, 0), buffer.readu8(v45, 1), (buffer.readu8(v45, 2)));
    if v46 == p44 then
    else
        local function v49(p47) --[[ Line: 169 ]]
            -- upvalues: u11 (ref)
            if p47.X < 0 or (p47.X >= u11.CanvasSize.X or (p47.Y < 0 or p47.Y >= u11.CanvasSize.Y)) then
                return nil;
            end;
            local v48 = u11.CanvasEditable:ReadPixelsBuffer(p47, Vector2.one);
            return Color3.fromRGB(buffer.readu8(v48, 0), buffer.readu8(v48, 1), (buffer.readu8(v48, 2)));
        end;
        local v50 = { p43 };
        local v51 = {};
        while #v50 > 0 do
            local v52 = table.remove(v50, 1);
            local v53 = v52.X .. "," .. v52.Y;
            if not v51[v53] then
                v51[v53] = true;
                local v54 = v49(v52);
                if v54 and v54 == v46 then
                    u11.CanvasEditable:DrawRectangle(v52, Vector2.one, p44, 0, Enum.ImageCombineType.Overwrite);
                    local v55 = v52 + Vector2.new(1, 0);
                    table.insert(v50, v55);
                    local v56 = v52 + Vector2.new(-1, 0);
                    table.insert(v50, v56);
                    local v57 = v52 + Vector2.new(0, 1);
                    table.insert(v50, v57);
                    local v58 = v52 + Vector2.new(0, -1);
                    table.insert(v50, v58);
                end;
            end;
        end;
        u11.SaveCanvasIntoHistory();
        u11.ClearAllFutures();
    end;
end;
function u11.UpdateStrokeActive(p59) --[[ Line: 207 ]]
    -- upvalues: u11 (copy)
    if u11.StrokeActive and not p59 then
        u11.StrokeActive = p59;
        u11.LastStrokePosition = nil;
        if u11.StrokeWasCreated then
            u11.StrokeWasCreated = false;
            u11.SaveCanvasIntoHistory();
            u11.ClearAllFutures();
        end;
    elseif not u11.StrokeActive and p59 then
        u11.StrokeWasCreated = false;
        u11.StrokeActive = p59;
    end;
end;
function u11.SaveCanvasIntoHistory() --[[ Line: 226 ]]
    -- upvalues: u11 (copy)
    local v60 = u11;
    v60.HistoryPosition = v60.HistoryPosition + 1;
    u11.History[u11.HistoryPosition] = u11.CanvasEditable:ReadPixelsBuffer(Vector2.zero, u11.CanvasSize);
    u11:UpdateHistoryButtons();
end;
function u11.ConstructNewColor(p61) --[[ Line: 232 ]]
    -- upvalues: u11 (copy)
    for v62, v63 in pairs(p61) do
        u11.ColorHSV[v62] = v63;
    end;
    u11.CurrentColor = Color3.fromHSV(table.unpack(u11.ColorHSV));
    u11:RenderBrush();
    u11:UpdateColorsRefs();
end;
function u11.UpdateColorsRefs(_) --[[ Line: 242 ]]
    -- upvalues: u11 (copy)
    u11.Content.Select.ImageColor3 = u11.CurrentColor;
    u11.ColorPicker.Value.BackgroundColor3 = Color3.fromHSV(u11.ColorHSV[1], u11.ColorHSV[2], 1);
end;
function u11.Trigger() --[[ Line: 251 ]]
    -- upvalues: u11 (copy)
    u11.Interface.Trigger();
end;
function u11.SetupColorPickers(_) --[[ Line: 255 ]]
    -- upvalues: u7 (copy), u11 (copy)
    local v64 = u7.NewSlider(u11.ColorPicker.Value, "Y");
    v64.Changed:Connect(function(p65) --[[ Line: 257 ]]
        -- upvalues: u11 (ref)
        u11.ConstructNewColor({
            [3] = 1 - p65
        });
    end);
    local v66 = u7.NewSlidepad(u11.ColorPicker.Color);
    v66.Changed:Connect(function(p67) --[[ Line: 264 ]]
        -- upvalues: u11 (ref)
        u11.ConstructNewColor({ p67.X, 1 - p67.Y });
    end);
    u11.Slider = v64;
    u11.Slidepad = v66;
end;
function u11.ClearAllFutures() --[[ Line: 275 ]]
    -- upvalues: u11 (copy)
    for v68 = u11.HistoryPosition + 1, #u11.History do
        u11.History[v68] = nil;
    end;
end;
function u11.Fill(_) --[[ Line: 281 ]]
    -- upvalues: u11 (copy)
    u11.ColorPicker.Visible = false;
    u11.Container.ActionText.Visible = true;
    u11.Container.ActionText.Text = "Click a pixel to fill";
    u11.Mode = "Fill";
end;
function u11.Dropper(_) --[[ Line: 290 ]]
    -- upvalues: u11 (copy)
    u11.ColorPicker.Visible = false;
    u11.Container.ActionText.Visible = true;
    u11.Container.ActionText.Text = "Click a pixel to copy color";
    u11.Mode = "Dropper";
end;
function u11.Erase(_) --[[ Line: 299 ]]
    -- upvalues: u11 (copy)
    u11.ColorPicker.Visible = false;
    u11.Container.ActionText.Visible = true;
    u11.Container.ActionText.Text = "Click a pixel to erase";
    u11.Mode = "Erase";
end;
function u11.Undo(_) --[[ Line: 308 ]]
    -- upvalues: u11 (copy)
    local v69 = u11.History[u11.HistoryPosition - 1];
    if v69 then
        local v70 = u11;
        v70.HistoryPosition = v70.HistoryPosition - 1;
        u11.CanvasEditable:WritePixelsBuffer(Vector2.zero, u11.CanvasSize, v69);
    end;
    u11:UpdateHistoryButtons();
end;
function u11.Redo(_) --[[ Line: 317 ]]
    -- upvalues: u11 (copy)
    local v71 = u11.History[u11.HistoryPosition + 1];
    if v71 then
        local v72 = u11;
        v72.HistoryPosition = v72.HistoryPosition + 1;
        u11.CanvasEditable:WritePixelsBuffer(Vector2.zero, u11.CanvasSize, v71);
    end;
    u11:UpdateHistoryButtons();
end;
function u11.UpdateHistoryButtons(_) --[[ Line: 329 ]]
    -- upvalues: u11 (copy)
    u11.Tools.Undo.Visible = u11.History[u11.HistoryPosition - 1] ~= nil;
    u11.Tools.Redo.Visible = u11.History[u11.HistoryPosition + 1] ~= nil;
end;
function u11.SyncToColor(_, p73) --[[ Line: 334 ]]
    -- upvalues: u11 (copy)
    u11.CurrentColor = p73;
    u11.ColorHSV = { p73:ToHSV() };
    u11:RenderBrush();
    u11:BackwardsSlidepad();
end;
function u11.BackwardsSlidepad(_) --[[ Line: 341 ]]
    -- upvalues: u11 (copy)
    local v74, v75, v76 = u11.CurrentColor:ToHSV();
    u11.Slidepad.SetPosition(Vector2.new(v74, 1 - v75));
    u11.Slider.SetPosition(1 - v76);
end;
function u11.Reset(_) --[[ Line: 348 ]]
    -- upvalues: u11 (copy)
    u11.CurrentColor = Color3.new(1, 0, 0);
    u11.ColorHSV = { 1, 1, 1 };
    u11.StrokeActive = false;
    u11.ColorPickerVisible = true;
    u11.History = {};
    u11.HistoryPosition = 0;
    u11.CanvasEditable:DrawRectangle(Vector2.zero, u11.CanvasSize, Color3.new(1, 1, 1), 1, Enum.ImageCombineType.Overwrite);
    u11.SaveCanvasIntoHistory();
    u11:CancelPending();
    u11:BackwardsSlidepad();
    u11:UpdateLayout();
    u11:UpdateHistoryButtons();
    u11:RenderBrush();
end;
function u11.UpdateLayout(_) --[[ Line: 366 ]]
    -- upvalues: u11 (copy)
    u11.ColorPicker.Visible = u11.ColorPickerVisible;
    u11.Brush.Visible = false;
    u11:UpdateColorsRefs();
end;
function u11.SetupGUI(_) --[[ Line: 374 ]]
    -- upvalues: u7 (copy), u11 (copy), l__BaseX__6 (copy), l__Compress__7 (copy), u2 (copy), u5 (copy), u6 (copy), u10 (copy), l__Numerics__8 (copy)
    u7.NewButton(u11.Container.Export.CloseButton).Activated:Connect(function() --[[ Line: 376 ]]
        -- upvalues: u11 (ref)
        u11.Export.Visible = false;
    end);
    u7.NewButton(u11.Container.Import.CloseButton).Activated:Connect(function() --[[ Line: 381 ]]
        -- upvalues: u11 (ref)
        u11.Import.Visible = false;
    end);
    u7.NewButton(u11.Container.Brush.BackButton).Activated:Connect(function() --[[ Line: 386 ]]
        -- upvalues: u11 (ref)
        u11:UpdateLayout();
    end);
    u7.NewButton(u11.Container.Import.Import).Activated:Connect(function() --[[ Line: 391 ]]
        -- upvalues: u11 (ref), l__BaseX__6 (ref), l__Compress__7 (ref), u2 (ref)
        local l__Text__15 = u11.Container.Import.Code.Text;
        u11.Container.Import.Code.Text = "";
        local v77 = 0;
        local v78 = u11.Resolutions[0];
        if l__Text__15:sub(1, 1) == "~" and #l__Text__15 > 3 then
            local v79 = tostring(l__Text__15:sub(2, 2));
            local v80 = u11.Resolutions[tonumber(v79) or 0];
            if v80 then
                v77 = tonumber(v79);
            end;
            l__Text__15 = l__Text__15:sub(3, -1);
            v78 = v80 or v78;
        end;
        local v81 = l__BaseX__6.DISCORD:decode(l__Text__15);
        local v82 = buffer.fromstring(l__Compress__7.decompress(v81) or "");
        if v78.X * v78.Y * 4 == buffer.len(v82) then
            if u11.CanvasSize ~= v78 then
                u11:UpdateResolution(v78);
            end;
            u11.CurrentResolution = v77;
            u11:Reset();
            u11.CanvasEditable:WritePixelsBuffer(Vector2.zero, u11.CanvasSize, v82);
            u11.SaveCanvasIntoHistory();
        else
            u2.Error("INVALID IMAGE DATA!");
        end;
    end);
    u7.NewButton(u11.Options.CloseButton).Activated:Connect(function() --[[ Line: 435 ]]
        -- upvalues: u11 (ref)
        u11.Interface.Close();
    end);
    u7.NewButton(u11.Options.HexButton).Activated:Connect(function() --[[ Line: 440 ]]
        -- upvalues: u11 (ref)
        u11.HexInput.Visible = not u11.HexInput.Visible;
    end);
    u7.NewButton(u11.HexInput.CloseButton).Activated:Connect(function() --[[ Line: 445 ]]
        -- upvalues: u11 (ref)
        u11.HexInput.Visible = false;
    end);
    u7.NewButton(u11.HexInput.Import).Activated:Connect(function() --[[ Line: 450 ]]
        -- upvalues: u11 (ref), u2 (ref)
        local l__Text__16 = u11.HexInput.Code.Text;
        local v83, v84 = pcall(function() --[[ Line: 452 ]]
            -- upvalues: l__Text__16 (copy)
            return Color3.fromHex(l__Text__16);
        end);
        u11.HexInput.Visible = false;
        if v83 then
            u11.HexInput.Code.Text = "";
            u11:SyncToColor(v84);
            u11:UpdateColorsRefs();
        else
            u2.Error("Invalid Hex Code!");
        end;
    end);
    u7.NewButton(u11.Options.BuyButton).Activated:Connect(function() --[[ Line: 473 ]]
        -- upvalues: u5 (ref), u11 (ref), u6 (ref), u10 (ref)
        u5.Display("All Drawings must align with roblox community standards.\n Inappropiate Drawings will result in a in-game ban!", function() --[[ Line: 474 ]]
            -- upvalues: u11 (ref), u6 (ref), u10 (ref)
            u6.Display(u11.CurrentResolution == 1 and "Purchase your drawing for 100 coins? (Non Inventory Item!)" or "Purchase your drawing for 25 coins? (Non Inventory Item!)", function() --[[ Line: 478 ]]
                -- upvalues: u11 (ref), u10 (ref)
                os.clock();
                local v85 = buffer.tostring(u11.CanvasEditable:ReadPixelsBuffer(Vector2.zero, u11.CanvasSize));
                task.wait(0.2);
                u10:Fire(v85, u11.CanvasSize);
            end);
        end);
    end);
    u11.TransSlider = u7.NewSlider(u11.Brush.Options.TransSlide);
    u11.TransSlider.Changed:Connect(function(p86) --[[ Line: 490 ]]
        -- upvalues: u11 (ref), l__Numerics__8 (ref)
        u11.BrushTransparency = p86;
        u11.Brush.Options.TransDetail.Text = `Transparency ({l__Numerics__8.Round(p86, 1)})`;
        u11:UpdateBrush();
        u11:RenderBrush();
    end);
    u11.TransSlider.SetPosition(0);
    u11.RoundSlider = u7.NewSlider(u11.Brush.Options.RoundSlide);
    u11.RoundSlider.Step = 1 / u11.MaxRoundSize;
    u11.RoundSlider.Changed:Connect(function(p87) --[[ Line: 502 ]]
        -- upvalues: u11 (ref)
        local v88 = p87 * (u11.MaxRoundSize - 1) * u11.MaxRoundSize;
        u11:UpdateBrush();
        u11:RenderBrush();
        u11.BrushRound = v88;
        u11.Brush.Options.RoundDetail.Text = `Round Amount ({v88})`;
    end);
    u11.RoundSlider.SetPosition(0);
    u11.BrushSlider = u7.NewSlider(u11.Brush.Options.BrushSlide);
    u11.BrushSlider.Step = 1 / (u11.MaxBrushSize - 1);
    u11.BrushSlider.Changed:Connect(function(p89) --[[ Line: 515 ]]
        -- upvalues: u11 (ref)
        local v90 = p89 * (u11.MaxBrushSize - 1) + 1;
        u11.BrushSize = v90;
        u11.Brush.Options.BrushDetail.Text = `Brush Size ({v90})`;
        u11:UpdateBrush();
        u11:RenderBrush();
        u11.Brush.Options.RoundSlide.Visible = v90 > 2;
        u11.Brush.Options.RoundDetail.Visible = v90 > 2;
    end);
    u11.BrushSlider.SetPosition(0);
end;
function u11.SetupTools(_) --[[ Line: 530 ]]
    -- upvalues: u11 (copy), u7 (copy), u8 (copy), u4 (copy), u6 (copy), l__BaseX__6 (copy), l__Compress__7 (copy)
    local v91 = {};
    local v92 = {
        "Reset",
        "Dropper",
        "Export",
        "Import",
        "Fill",
        "Undo",
        "Redo",
        "Brush",
        "Color",
        "Eraser",
        "Resolution"
    };
    local u93 = {};
    for _, v94 in { "Left", "Right", "RightTop" } do
        for _, v95 in u11.Container[v94]:GetChildren() do
            v91[v95.Name] = v95;
        end;
    end;
    u11.Tools = v91;
    for _, v96 in ipairs(v92) do
        u93[v96] = u7.NewButton(u11.Tools[v96].Button);
    end;
    u93.Resolution.Activated:Connect(function() --[[ Line: 554 ]]
        -- upvalues: u8 (ref), u4 (ref), u6 (ref), u11 (ref), u93 (copy)
        if u8:PlayerOwnsGamepass("CanvasMaster") then
            u6.Display("Are you sure you want to change resolution? This will erase everything!", function() --[[ Line: 559 ]]
                -- upvalues: u11 (ref), u93 (ref)
                if u11.CurrentResolution == 0 then
                    u11.CurrentResolution = 1;
                elseif u11.CurrentResolution == 1 then
                    u11.CurrentResolution = 0;
                end;
                u11:UpdateResolution(u11.Resolutions[u11.CurrentResolution]);
                u93.Resolution.TweenFrame.ButtonName.Text = `{u11.CanvasSize.X} x {u11.CanvasSize.Y}`;
            end);
        else
            u4.StartGamepassPurchase(u8:GetGamepassIDFromName("CanvasMaster"));
        end;
    end);
    u93.Eraser.Activated:Connect(function() --[[ Line: 571 ]]
        -- upvalues: u11 (ref)
        u11:CancelPending();
        u11:Erase();
    end);
    u93.Color.Activated:Connect(function() --[[ Line: 575 ]]
        -- upvalues: u11 (ref)
        u11:CancelPending();
    end);
    u93.Reset.Activated:Connect(function() --[[ Line: 578 ]]
        -- upvalues: u6 (ref), u11 (ref)
        u6.Display("Are you sure you want to reset? (ERASE EVERYTHING)", function() --[[ Line: 579 ]]
            -- upvalues: u11 (ref)
            u11:Reset();
        end);
    end);
    u93.Import.Activated:Connect(function() --[[ Line: 583 ]]
        -- upvalues: u11 (ref)
        u11.Export.Visible = false;
        u11.Import.Visible = true;
    end);
    u93.Export.Activated:Connect(function() --[[ Line: 588 ]]
        -- upvalues: l__BaseX__6 (ref), l__Compress__7 (ref), u11 (ref)
        local v97 = l__BaseX__6.DISCORD:encode(l__Compress__7.compress(buffer.tostring(u11.CanvasEditable:ReadPixelsBuffer(Vector2.zero, u11.CanvasSize))));
        if u11.CurrentResolution ~= 0 then
            v97 = `~{u11.CurrentResolution}{v97}`;
        end;
        u11.Import.Visible = false;
        u11.Export.Visible = true;
        u11.Export.Scroll.Code.Text = v97;
    end);
    u11.Export.Scroll.Code:GetPropertyChangedSignal("TextBounds"):Connect(function() --[[ Line: 602 ]]
        -- upvalues: u11 (ref)
        u11.Export.Scroll.CanvasSize = UDim2.fromOffset(u11.Export.Scroll.Code.TextBounds.X, 0);
    end);
    u93.Brush.Activated:Connect(function() --[[ Line: 606 ]]
        -- upvalues: u11 (ref)
        u11:CancelPending();
        u11.ColorPicker.Visible = false;
        u11.Brush.Visible = true;
    end);
    u93.Fill.Activated:Connect(function() --[[ Line: 613 ]]
        -- upvalues: u11 (ref)
        u11:CancelPending();
        u11:Fill();
    end);
    u93.Dropper.Activated:Connect(function() --[[ Line: 617 ]]
        -- upvalues: u11 (ref)
        u11:CancelPending();
        u11:Dropper();
    end);
    u93.Undo.Activated:Connect(function() --[[ Line: 621 ]]
        -- upvalues: u11 (ref)
        u11:Undo();
    end);
    u93.Redo.Activated:Connect(function() --[[ Line: 624 ]]
        -- upvalues: u11 (ref)
        u11:Redo();
    end);
    u11.ToolButtons = u93;
end;
function GetRgbDifference(p98, p99)
    return math.sqrt((p98.R - p99.R) ^ 2 + (p98.G - p99.G) ^ 2 + (p98.B - p99.B) ^ 2) / 441.6729559300637;
end;
function u11.UpdateBrush(_) --[[ Line: 646 ]]
    -- upvalues: u11 (copy), l__AssetService__2 (copy)
    u11.Content.Select.Size = UDim2.fromScale(1 / u11.CanvasSize.X * u11.BrushSize, 1 / u11.CanvasSize.Y * u11.BrushSize);
    u11.BrushImage = l__AssetService__2:CreateEditableImage({
        Size = Vector2.one * u11.BrushSize
    });
    u11.EraseImage = l__AssetService__2:CreateEditableImage({
        Size = Vector2.one * u11.BrushSize
    });
    u11.EraseImage:DrawRectangle(Vector2.zero, Vector2.one * u11.BrushSize, Color3.new(1, 1, 1), 0, Enum.ImageCombineType.Overwrite);
    u11.Brush.Preview.BrushImage.Size = UDim2.fromScale(u11.BrushSize / 5, u11.BrushSize / 5);
    u11.Brush.Preview.BrushImage.ImageContent = Content.fromObject(u11.BrushImage);
end;
function u11.RenderBrush(_) --[[ Line: 661 ]]
    -- upvalues: u11 (copy)
    local function v101() --[[ Line: 662 ]]
        -- upvalues: u11 (ref)
        local v100 = math.clamp(u11.BrushTransparency + 0.3, 0, 1);
        u11.BrushImage:DrawRectangle(Vector2.new(1, 0), Vector2.new(2, 1), u11.CurrentColor, v100, Enum.ImageCombineType.Overwrite);
        u11.BrushImage:DrawRectangle(Vector2.new(1, 3), Vector2.new(2, 1), u11.CurrentColor, v100, Enum.ImageCombineType.Overwrite);
        u11.BrushImage:DrawRectangle(Vector2.new(0, 1), Vector2.new(1, 2), u11.CurrentColor, v100, Enum.ImageCombineType.Overwrite);
        u11.BrushImage:DrawRectangle(Vector2.new(3, 1), Vector2.new(1, 2), u11.CurrentColor, v100, Enum.ImageCombineType.Overwrite);
        u11.BrushImage:DrawRectangle(Vector2.one, Vector2.one * 2, u11.CurrentColor, u11.BrushTransparency, Enum.ImageCombineType.Overwrite);
    end;
    u11.BrushImage:DrawRectangle(Vector2.zero, Vector2.one * u11.BrushSize, Color3.new(1, 1, 1), 1, Enum.ImageCombineType.Overwrite);
    if u11.BrushRound > 0 and u11.BrushSize > 2 then
        if u11.BrushRound == 1 then
            if u11.BrushSize == 4 then
                v101();
                return;
            else
                local v102 = math.floor(u11.BrushSize / 2);
                for v103 = 0, u11.BrushSize - 1 do
                    local v104 = math.abs(v103 - v102);
                    local v105 = u11.BrushSize - v104 * 2;
                    local _ = u11.BrushTransparency;
                    local v106 = v104 / (v102 + 0.5);
                    local v107;
                    if v105 <= 2 or v106 >= 0.7 then
                        v107 = math.clamp(u11.BrushTransparency + 0.3, 0, 1);
                    else
                        v107 = math.clamp(u11.BrushTransparency * (1 - v106), 0, 1);
                    end;
                    u11.BrushImage:DrawRectangle(Vector2.new(v104, v103), Vector2.new(v105, 1), u11.CurrentColor, v107, Enum.ImageCombineType.Overwrite);
                end;
                return;
            end;
        end;
        if u11.BrushRound == 2 then
            if u11.BrushSize == 4 then
                v101();
            else
                u11.BrushImage:DrawCircle(Vector2.one * u11.BrushSize * 0.5, u11.BrushSize / 2, u11.CurrentColor, u11.BrushTransparency, Enum.ImageCombineType.Overwrite);
                local v108 = u11.BrushImage:ReadPixelsBuffer(Vector2.zero, Vector2.one * u11.BrushSize);
                for v109 = 0, buffer.len(v108), 4 do
                    if v109 ~= buffer.len(v108) then
                        local v110 = buffer.readu8(v108, v109 + 0);
                        local v111 = buffer.readu8(v108, v109 + 1);
                        local v112 = buffer.readu8(v108, v109 + 2);
                        local _ = (255 - buffer.readu8(v108, v109 + 3)) / 255;
                        local v113 = math.floor(u11.CurrentColor.R * 255);
                        local v114 = math.floor(u11.CurrentColor.G * 255);
                        local v115 = math.floor(u11.CurrentColor.B * 255);
                        if v113 ~= v110 or (v114 ~= v111 or v115 ~= v112) then
                            buffer.writeu8(v108, v109 + 0, v113);
                            buffer.writeu8(v108, v109 + 1, v114);
                            buffer.writeu8(v108, v109 + 2, v115);
                        end;
                    end;
                end;
                u11.BrushImage:WritePixelsBuffer(Vector2.zero, Vector2.one * u11.BrushSize, v108);
            end;
        end;
    else
        u11.BrushImage:DrawRectangle(Vector2.zero, Vector2.one * u11.BrushSize, u11.CurrentColor, u11.BrushTransparency, Enum.ImageCombineType.Overwrite);
    end;
end;
function u11.CancelPending(_) --[[ Line: 740 ]]
    -- upvalues: u11 (copy)
    if u11.Brush.Visible then
        u11.Brush.Visible = false;
        u11.ColorPicker.Visible = true;
    end;
    if u11.Mode == "Dropper" or (u11.Mode == "Fill" or u11.Mode == "Erase") then
        u11.ColorPickerVisible = true;
        u11.Container.ActionText.Visible = false;
        u11.Mode = "Draw";
        u11:UpdateLayout();
    end;
end;
function u11.ThisDrawingAnFuture(_, p116) --[[ Line: 754 ]]
    -- upvalues: u11 (copy)
    if u11.ThisDrawing then
        p116(u11.ThisDrawing);
    end;
    u11.DrawingPublished:Connect(p116);
end;
function u11.UpdateResolution(_, p117) --[[ Line: 762 ]]
    -- upvalues: u11 (copy), l__AssetService__2 (copy)
    u11.Options.BuyButton.CoinLabel.Text = u11.Prices[u11.CurrentResolution];
    u11.CanvasSize = p117;
    u11.Content.Select.Size = UDim2.fromScale(1 / u11.CanvasSize.X, 1 / u11.CanvasSize.Y);
    u11.CanvasEditable = l__AssetService__2:CreateEditableImage({
        Size = u11.CanvasSize
    });
    u11.CanvasEditable:DrawRectangle(Vector2.zero, u11.CanvasSize, Color3.new(1, 1, 1), 1, Enum.ImageCombineType.Overwrite);
    local v118 = Content.fromObject(u11.CanvasEditable);
    u11.Content.Canvas.ImageContent = v118;
    u11.ThisDrawing = v118;
    u11.DrawingPublished:Fire(v118);
    u11:Reset();
end;
function u11.Setup(_) --[[ Line: 781 ]]
    -- upvalues: u11 (copy), u7 (copy), u9 (copy), u3 (copy), l__LocalPlayer__4 (copy), u1 (copy)
    u11.Interface = u7.Get("PaintScreen");
    u11.Container = u11.Interface.TweenFrame.Container;
    u11.ColorPicker = u11.Container.ColorPicker;
    u11.Options = u11.Container.Options;
    u11.Export = u11.Container.Export;
    u11.Import = u11.Container.Import;
    u11.Brush = u11.Container.Brush;
    u11.HexInput = u11.Container.HexInput;
    u11.Content = u11.Container.Content;
    u11.Content.Select.ImageColor3 = u11.CurrentColor;
    u11.Interface.Opened:Connect(function() --[[ Line: 794 ]]
        -- upvalues: u9 (ref)
        u9.StartInteractions();
    end);
    u11.Interface.Closed:Connect(function() --[[ Line: 797 ]]
        -- upvalues: u9 (ref)
        u9.EndInteractions();
    end);
    u11:SetupColorPickers();
    u11:SetupGUI();
    u11:SetupTools();
    u11:UpdateLayout();
    u11:UpdateHistoryButtons();
    u11:UpdateBrush();
    u11:RenderBrush();
    u11.Content.MouseLeave:Connect(u11.MouseLeave);
    u11.Content.MouseMoved:Connect(u11.MouseMoved);
    u11:UpdateResolution(u11.Resolutions[0]);
    u11.SaveCanvasIntoHistory();
    u11.DrawBind = u3.Get("DrawWrite");
    u11.DrawBind.OnAction:Connect(function(p119, p120) --[[ Line: 817 ]]
        -- upvalues: u11 (ref), l__LocalPlayer__4 (ref), u1 (ref)
        if p119 == Enum.UserInputState.Begin then
            if u11.Mode == "Dropper" then
                u11:CancelPending();
                local v121 = u11.CanvasEditable:ReadPixelsBuffer(u11.Cursor, Vector2.one);
                u11:SyncToColor((Color3.fromRGB(buffer.readu8(v121, 0), buffer.readu8(v121, 1), (buffer.readu8(v121, 2)))));
                u11:UpdateColorsRefs();
                return;
            end;
            if u11.Mode == "Fill" then
                u11:CancelPending();
                u11.FloodFill(u11.Cursor, u11.CurrentColor);
                return;
            end;
            if u11.Mode == "Draw" or u11.Mode == "Erase" then
                local v122 = false;
                for _, v123 in l__LocalPlayer__4.PlayerGui:GetGuiObjectsAtPosition(p120.Position.X, p120.Position.Y) do
                    if v123 == u11.Content.Canvas then
                        v122 = true;
                        break;
                    end;
                end;
                if v122 then
                    u11.UpdateStrokeActive(true);
                    u11.MouseMoved(p120.Position.X, p120.Position.Y + u1.Y);
                end;
            end;
        else
            u11.UpdateStrokeActive(false);
        end;
    end);
end;
return u11;
