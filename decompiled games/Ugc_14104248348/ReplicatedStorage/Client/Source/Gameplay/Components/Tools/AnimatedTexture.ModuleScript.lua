-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Components.Tools.AnimatedTexture
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__AssetService__2 = game:GetService("AssetService");
local l__RunService__3 = game:GetService("RunService");
local l__Maid__4 = require(l__ReplicatedStorage__1.Modules.Maid);
local u1 = require(l__ReplicatedStorage__1.Modules.Mince).Component({
    Tag = "AnimatedTexture",
    TextureCache = {}
});
function u1.GetTextures(_, p2, p3) --[[ Line: 14 ]]
    -- upvalues: u1 (copy), l__AssetService__2 (copy)
    if u1.TextureCache[p3.Name] then
        return u1.TextureCache[p3.Name];
    end;
    local v4 = l__AssetService__2:CreateEditableImageAsync((`rbxthumb://type=Asset&id={string.gsub(p2, "^rbxassetid://", "")}&w=420&h=420`));
    if v4 then
        local u5 = v4:ReadPixelsBuffer(Vector2.zero, v4.Size);
        local v6 = v4.Size.X * v4.Size.Y * 4;
        local v7 = {};
        for v8 = 1, p3.Frames do
            local v9 = v8 / p3.Frames;
            local v10 = l__AssetService__2:CreateEditableImage({
                Size = v4.Size
            });
            local v11 = buffer.create(v6);
            buffer.copy(v11, 0, u5);
            for v12 = 0, v4.Size.X - 1 do
                for v13 = 0, v4.Size.Y - 1 do
                    Vector2.new(math.floor(v9 * v4.Size.X), 0);
                    local v14 = Vector2.new(v12, v13);
                    local v15 = Vector2.new((v12 + math.floor(v9 * v4.Size.X)) % v4.Size.X, v13);
                    local u16 = (v15.Y * v4.Size.X + v15.X) * 4;
                    local v17 = (v13 * v4.Size.X + v12) * 4;
                    for u18 = 0, 3 do
                        local v19, v20 = pcall(function() --[[ Line: 54 ]]
                            -- upvalues: u5 (copy), u16 (copy), u18 (copy)
                            return buffer.readu8(u5, u16 + u18);
                        end);
                        if not v19 then
                            warn(v6);
                            warn(v15, u16);
                            error("Something went wrong", v14, v15, v20);
                        end;
                        buffer.writeu8(v11, v17 + u18, v20);
                    end;
                end;
            end;
            v10:WritePixelsBuffer(Vector2.zero, v4.Size, v11);
            table.insert(v7, Content.fromObject(v10));
        end;
        u1.TextureCache[p3.Name] = v7;
        return v7;
    end;
    print("Failed to load ColorMap->", v4, p2);
end;
function u1.Update(p21, p22) --[[ Line: 80 ]]
    p21.TimeElapsed = p21.TimeElapsed + p22;
    if p21.TimeElapsed > 1 / p21.FPS then
        p21.TimeElapsed = 0;
        p21.CurrentTexture = p21.CurrentTexture + 1;
        if p21.CurrentTexture > #p21.Textures then
            p21.CurrentTexture = 1;
        end;
        local v23 = p21.Textures[p21.CurrentTexture];
        if v23 then
            p21.Instance.TextureContent = v23;
        end;
    end;
end;
function u1.Construct(u24) --[[ Line: 97 ]]
    -- upvalues: l__Maid__4 (copy), u1 (copy), l__RunService__3 (copy)
    u24.Maid = l__Maid__4.new();
    u24.Frames = u24.Frames or 18;
    u24.FPS = u24.FPS or 20;
    u24.TimeElapsed = 0;
    u24.Name = u24.Name or u24.Instance.TextureID;
    u24.CurrentTexture = 1;
    u24.Textures = u1:GetTextures(u24.Instance.TextureID, u24);
    u24.Maid:Add(l__RunService__3.Heartbeat:Connect(function(p25) --[[ Line: 107 ]]
        -- upvalues: u24 (copy)
        u24:Update(p25);
    end));
end;
function u1.Removing(p26) --[[ Line: 112 ]]
    p26.Maid:Destroy();
end;
return u1;
