-- Decompiled from: 
-- Class: ModuleScript
-- Place: Ugc (5315066937)
-- JobId: 2dad3d5f-9cef-4138-9e81-01bb4fe3ee56
-- Recovered: false

-- Decompiled with Potassium's decompiler.

local l__clear__1 = table.clear;
local u1 = workspace;
local l__BulkMoveTo__2 = u1.BulkMoveTo;
local l__FireCFrameChanged__3 = Enum.BulkMoveMode.FireCFrameChanged;
local u2 = {};
local u3 = 0;
local u4 = {};
local u5 = {};
return {
    Flush = function(p6) --[[ Name: Flush, Line 24 ]]
        -- upvalues: u3 (ref), u4 (copy), l__BulkMoveTo__2 (copy), u1 (copy), u5 (copy), l__FireCFrameChanged__3 (copy), l__clear__1 (copy), u2 (copy)
        if u3 ~= 0 then
            if p6 then
                for _, v7 in u4 do
                    if v7:GetAttribute("p") then
                        v7:SetAttribute("p", nil);
                        v7:SetAttribute("x", nil);
                        v7:SetAttribute("y", nil);
                        v7:SetAttribute("z", nil);
                    end;
                end;
            end;
            l__BulkMoveTo__2(u1, u4, u5, l__FireCFrameChanged__3);
            l__clear__1(u2);
            l__clear__1(u4);
            l__clear__1(u5);
            u3 = 0;
        end;
    end,
    DeferCFrame = function(p8, p9) --[[ Name: DeferCFrame, Line 13 ]]
        -- upvalues: u2 (copy), u5 (copy), u3 (ref), u4 (copy)
        local v10 = u2[p8];
        if v10 then
            u5[v10] = p9;
        else
            u3 = u3 + 1;
            u4[u3] = p8;
            u5[u3] = p9;
        end;
    end
};
