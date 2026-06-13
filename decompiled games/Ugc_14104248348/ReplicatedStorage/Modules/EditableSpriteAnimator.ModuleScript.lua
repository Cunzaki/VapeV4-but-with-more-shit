-- Decompiled from: ReplicatedStorage.Modules.EditableSpriteAnimator
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__AssetService__1 = game:GetService("AssetService");
local u1 = {};
u1.__index = u1;
function u1.new(p2) --[[ Line: 6 ]]
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3._Library = {};
    v3._CurrentAnim = nil;
    v3._CurrentFrameIndex = 0;
    v3._TimeAccumulator = 0;
    v3._CurrentFPS = 12;
    v3._IsPlaying = false;
    v3._IsFlipped = false;
    v3.ProjectionBuffer = nil;
    v3._Scratchpad = nil;
    if p2.Sprites then
        for v4, v5 in pairs(p2.Sprites) do
            v3:_RegisterSprite(v4, v5, p2);
        end;
    end;
    return v3;
end;
function u1.SetFlipped(p6, p7) --[[ Line: 29 ]]
    if p6._IsFlipped ~= p7 then
        p6._IsFlipped = p7;
        p6:_UpdateBuffer();
    end;
end;
function u1._RegisterSprite(p8, p9, p10, p11) --[[ Line: 36 ]]
    -- upvalues: l__AssetService__1 (copy)
    local l__Images__2 = p10.Images;
    if l__Images__2 then
        local v12 = {
            TotalFrames = 0,
            Sheets = {},
            DefaultFPS = p10.FPS or 12,
            _Cache = {},
            Background = p10.Background or (p11.Background or Color3.fromRGB(0, 0, 0)),
            BackgroundTransparency = p10.BackgroundTransparency or (p11.BackgroundTransparency or 0)
        };
        for v13, v14 in ipairs(l__Images__2) do
            local l__Image__3 = v14.Image;
            local v15, v16 = pcall(function() --[[ Line: 52 ]]
                -- upvalues: l__AssetService__1 (ref), l__Image__3 (copy)
                return l__AssetService__1:CreateEditableImageAsync(l__Image__3);
            end);
            if v15 and v16 then
                local l__X__4 = v16.Size.X;
                local l__Y__5 = v16.Size.Y;
                local v17 = v16:ReadPixelsBuffer(Vector2.zero, v16.Size);
                v16:Destroy();
                local v18 = v14.Rows or 1;
                local v19 = v14.Columns or (v14.Frames or 1);
                local v20 = math.floor(l__X__4 / v19);
                local v21 = math.floor(l__Y__5 / v18);
                local v22 = Vector2.new(v20, v21);
                local v23 = v18 * v19;
                local v24 = v14.Frames or v23;
                local l__Sheets__6 = v12.Sheets;
                local v25 = {
                    SourceBuffer = v17,
                    SourceSize = Vector2.new(l__X__4, l__Y__5),
                    Rows = v18,
                    Columns = v19,
                    FrameSize = v22,
                    Count = math.min(v24, v23),
                    StartIndex = v12.TotalFrames
                };
                table.insert(l__Sheets__6, v25);
                v12.TotalFrames = v12.TotalFrames + v24;
            else
                warn("SpriteAnimator: Failed to load sheet " .. v13 .. " for \'" .. p9 .. "\'");
            end;
        end;
        p8._Library[p9] = v12;
    end;
end;
function u1.Play(p26, p27, p28, p29) --[[ Line: 93 ]]
    local v30 = p26._Library[p27];
    if v30 then
        if p28 == nil then
            p28 = false;
        end;
        p26._IsFlipped = p28;
        if p26._CurrentAnim == v30 and p26._IsPlaying then
            if p29 and p26._CurrentFPS ~= p29 then
                p26._CurrentFPS = p29;
            end;
            p26:_UpdateBuffer();
        else
            p26._CurrentAnim = v30;
            p26._CurrentFPS = p29 or (v30.DefaultFPS or 12);
            p26._CurrentFrameIndex = 0;
            p26._TimeAccumulator = 0;
            p26._IsPlaying = true;
            p26:_UpdateBuffer();
        end;
    end;
end;
function u1.Update(p31, p32) --[[ Line: 116 ]]
    if not (p31._IsPlaying and p31._CurrentAnim) then
        return false;
    end;
    p31._TimeAccumulator = p31._TimeAccumulator + p32;
    local v33 = 1 / p31._CurrentFPS;
    if v33 > p31._TimeAccumulator then
        return false;
    end;
    p31._TimeAccumulator = p31._TimeAccumulator - v33;
    p31._CurrentFrameIndex = (p31._CurrentFrameIndex + 1) % p31._CurrentAnim.TotalFrames;
    p31:_UpdateBuffer();
    return true;
end;
function u1._UpdateBuffer(p34) --[[ Line: 137 ]]
    -- upvalues: l__AssetService__1 (copy)
    local l___CurrentAnim__7 = p34._CurrentAnim;
    local l___CurrentFrameIndex__8 = p34._CurrentFrameIndex;
    local v35 = l___CurrentFrameIndex__8 .. "_" .. (p34._IsFlipped and "Flipped" or "Normal");
    local u36 = nil;
    local v37 = 0;
    for _, v38 in ipairs(l___CurrentAnim__7.Sheets) do
        if v38.StartIndex <= l___CurrentFrameIndex__8 and l___CurrentFrameIndex__8 < v38.StartIndex + v38.Count then
            v37 = l___CurrentFrameIndex__8 - v38.StartIndex;
            u36 = v38;
            break;
        end;
    end;
    if u36 then
        if not p34.ProjectionBuffer or p34.ProjectionBuffer.Size ~= u36.FrameSize then
            if p34.ProjectionBuffer then
                p34.ProjectionBuffer:Destroy();
            end;
            local v39, v40 = pcall(function() --[[ Line: 157 ]]
                -- upvalues: l__AssetService__1 (ref), u36 (ref)
                return l__AssetService__1:CreateEditableImage({
                    Size = u36.FrameSize
                });
            end);
            if not v39 then
                return;
            end;
            p34.ProjectionBuffer = v40;
        end;
        if l___CurrentAnim__7._Cache[v35] then
            p34.ProjectionBuffer:WritePixelsBuffer(Vector2.zero, u36.FrameSize, l___CurrentAnim__7._Cache[v35]);
        else
            if not p34._Scratchpad or p34._Scratchpad.Size ~= u36.SourceSize then
                if p34._Scratchpad then
                    p34._Scratchpad:Destroy();
                end;
                p34._Scratchpad = l__AssetService__1:CreateEditableImage({
                    Size = u36.SourceSize
                });
            end;
            p34._Scratchpad:WritePixelsBuffer(Vector2.zero, u36.SourceSize, u36.SourceBuffer);
            local v41 = v37 % u36.Columns;
            local v42 = math.floor(v37 / u36.Columns);
            local v43 = Vector2.new(v41 * u36.FrameSize.X, v42 * u36.FrameSize.Y);
            local v44 = u36.FrameSize / 2;
            p34.ProjectionBuffer:DrawRectangle(Vector2.zero, u36.FrameSize, l___CurrentAnim__7.Background, l___CurrentAnim__7.BackgroundTransparency, Enum.ImageCombineType.Overwrite);
            if p34._IsFlipped then
                p34.ProjectionBuffer:DrawImageTransformed(v44, Vector2.new(-1, 1), 0, p34._Scratchpad, {
                    CombineType = Enum.ImageCombineType.AlphaBlend,
                    PivotPoint = v43 + v44
                });
            else
                p34.ProjectionBuffer:DrawImageTransformed(v44, Vector2.new(1, 1), 0, p34._Scratchpad, {
                    CombineType = Enum.ImageCombineType.AlphaBlend,
                    PivotPoint = v43 + v44
                });
            end;
            local v45 = p34.ProjectionBuffer:ReadPixelsBuffer(Vector2.zero, u36.FrameSize);
            l___CurrentAnim__7._Cache[v35] = v45;
        end;
    end;
end;
function u1.Destroy(p46) --[[ Line: 220 ]]
    if p46.ProjectionBuffer then
        p46.ProjectionBuffer:Destroy();
    end;
    if p46._Scratchpad then
        p46._Scratchpad:Destroy();
    end;
    p46._Library = {};
end;
return u1;
