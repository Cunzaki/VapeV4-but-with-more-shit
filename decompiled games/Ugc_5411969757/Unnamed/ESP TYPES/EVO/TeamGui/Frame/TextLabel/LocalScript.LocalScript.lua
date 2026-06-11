-- Decompiled from: .ESP TYPES.EVO.TeamGui.Frame.TextLabel.LocalScript
-- Class: LocalScript
-- Place: Ugc (5411969757)

-- Decompiled with Potassium's decompiler.

local l__Parent__1 = script.Parent.Parent.Parent.Adornee.Parent;
if l__Parent__1:findFirstChild("Humanoid") ~= nil then
    l__Parent__1.Humanoid.HealthChanged:connect(function(p1) --[[ Line: 9 ]]
        if p1 <= 50 and p1 > 20 then
            script.Parent.TextColor3 = BrickColor.new("Bright yellow").Color;
        elseif p1 > 50 then
            script.Parent.TextColor3 = BrickColor.new("White").Color;
        elseif p1 <= 20 and p1 > 0 then
            script.Parent.TextColor3 = BrickColor.new("Bright red").Color;
        else
            if p1 <= 0 then
                script.Parent.TextColor3 = BrickColor.new("Black").Color;
            end;
        end;
    end);
end;
