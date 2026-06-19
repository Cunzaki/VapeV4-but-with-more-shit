-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__obtain__1 = _G.obtain;
local l__DeferCFrame__2 = l__obtain__1("BulkMove").DeferCFrame;
local u1 = l__obtain__1("FixLocalPlayer");
local l__GetContext__3 = l__obtain__1("ContextManager").GetContext;
local l__CharacterInfos__4 = l__obtain__1("CharacterManager").CharacterInfos;
local l__Angles__5 = CFrame.Angles;
local u2 = CFrame.new(0, 0.5, 0);
local function u11(p3, p4, p5) --[[ Line: 40 ]]
    -- upvalues: l__Angles__5 (copy), u2 (copy), l__DeferCFrame__2 (copy)
    if p3 and p4 then
        local _, _, _, _, _, _, _, v6, v7, _, _, _ = p4:components();
        local v8 = math.atan2(-v7, v6);
        local v9 = v8 < -1.5707963267948966 and -1.5707963267948966 or (v8 > 1.5707963267948966 and 1.5707963267948966 or v8);
        local v10 = p4 * l__Angles__5(-v9, 0, 0) * u2;
        if p3.HRP then
            l__DeferCFrame__2(p3.HRP, v10);
        elseif p3.Torso then
            l__DeferCFrame__2(p3.Torso, v10);
        end;
        if p3.Neck then
            p3.Neck.C0 = l__Angles__5(v9 * (p5 or 0.5), 0, 0) + Vector3.new(0, 1.25, 0);
        end;
    end;
end;
return {
    SetCharacterCFrameFromPlayer = function(p12, p13) --[[ Name: SetCharacterCFrameFromPlayer, Line 56 ]]
        -- upvalues: l__GetContext__3 (copy), u11 (copy), l__CharacterInfos__4 (copy), u1 (copy)
        local v14 = l__GetContext__3(p13);
        local v15 = v14 and (v14.Context and v14.Context:GetCFrame());
        if v15 then
            u11(l__CharacterInfos__4[u1(p12)], v15 + v14.MapOffset);
        end;
    end,
    SetCharacterCFrame = u11
};
