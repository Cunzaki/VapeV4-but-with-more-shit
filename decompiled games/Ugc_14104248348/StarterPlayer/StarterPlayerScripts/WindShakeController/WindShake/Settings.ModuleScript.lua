-- Decompiled from: StarterPlayer.StarterPlayerScripts.WindShakeController.WindShake.Settings
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    new = function(u1) --[[ Name: new, Line 10 ]]
        local u2 = {};
        local u3 = u1:GetAttribute("WindPower");
        local u4 = u1:GetAttribute("WindSpeed");
        local u5 = u1:GetAttribute("WindDirection");
        local v6;
        if typeof(u3) == "number" then
            v6 = u3;
        else
            v6 = nil;
        end;
        u2.WindPower = v6;
        local v7;
        if typeof(u4) == "number" then
            v7 = u4;
        else
            v7 = nil;
        end;
        u2.WindSpeed = v7;
        local v8;
        if typeof(u5) == "Vector3" then
            v8 = u5.Magnitude <= 0 and Vector3.new(0, 0, 0) or u5.Unit;
        else
            v8 = nil;
        end;
        u2.WindDirection = v8;
        local v9;
        if u1:IsA("BasePart") then
            v9 = u1.PivotOffset;
        else
            v9 = nil;
        end;
        u2.PivotOffset = v9;
        local v10;
        if typeof(u2.PivotOffset) == "CFrame" then
            v10 = u2.PivotOffset:Inverse();
        else
            v10 = nil;
        end;
        u2.PivotOffsetInverse = v10;
        local u13 = u1:GetAttributeChangedSignal("WindPower"):Connect(function() --[[ Line: 30 ]]
            -- upvalues: u3 (ref), u1 (copy), u2 (copy)
            u3 = u1:GetAttribute("WindPower");
            local v11 = u2;
            local v12;
            if typeof(u3) == "number" then
                v12 = u3;
            else
                v12 = nil;
            end;
            v11.WindPower = v12;
        end);
        local u16 = u1:GetAttributeChangedSignal("WindSpeed"):Connect(function() --[[ Line: 35 ]]
            -- upvalues: u4 (ref), u1 (copy), u2 (copy)
            u4 = u1:GetAttribute("WindSpeed");
            local v14 = u2;
            local v15;
            if typeof(u4) == "number" then
                v15 = u4;
            else
                v15 = nil;
            end;
            v14.WindSpeed = v15;
        end);
        local u19 = u1:GetAttributeChangedSignal("WindDirection"):Connect(function() --[[ Line: 40 ]]
            -- upvalues: u5 (ref), u1 (copy), u2 (copy)
            u5 = u1:GetAttribute("WindDirection");
            local v17 = u2;
            local v18;
            if typeof(u5) == "Vector3" then
                v18 = u5.Magnitude <= 0 and Vector3.new(0, 0, 0) or u5.Unit;
            else
                v18 = nil;
            end;
            v17.WindDirection = v18;
        end);
        local u20;
        if u1:IsA("BasePart") then
            u20 = u1:GetPropertyChangedSignal("PivotOffset"):Connect(function() --[[ Line: 49 ]]
                -- upvalues: u2 (copy), u1 (copy)
                u2.PivotOffset = u1.PivotOffset;
                u2.PivotOffsetInverse = u2.PivotOffset:Inverse();
            end);
        else
            u20 = nil;
        end;
        function u2.Destroy(_) --[[ Line: 57 ]]
            -- upvalues: u13 (copy), u16 (copy), u19 (copy), u20 (ref), u2 (copy)
            u13:Disconnect();
            u16:Disconnect();
            u19:Disconnect();
            if u20 then
                u20:Disconnect();
            end;
            table.clear(u2);
        end;
        return u2;
    end
};
