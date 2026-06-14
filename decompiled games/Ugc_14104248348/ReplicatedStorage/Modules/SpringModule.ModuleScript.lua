-- Decompiled from: ReplicatedStorage.Modules.SpringModule
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    new = function(_, p1, p2, p3, p4) --[[ Name: new, Line 11 ]]
        return {
            Target = Vector3.new(),
            Position = Vector3.new(),
            Velocity = Vector3.new(),
            Mass = p1 or 5,
            Force = p2 or 50,
            Damping = p3 or 4,
            Speed = p4 or 4,
            getstats = function(p5) --[[ Name: getstats, Line 24 ]]
                return p5.Mass, p5.Force, p5.Damping, p5.Speed;
            end,
            changestats = function(p6, p7, p8, p9, p10) --[[ Name: changestats, Line 28 ]]
                p6.Mass = p7 or p6.Mass;
                p6.Force = p8 or p6.Force;
                p6.Damping = p9 or p6.Damping;
                p6.Speed = p10 or p6.Speed;
            end,
            shove = function(p11, p12) --[[ Name: shove, Line 35 ]]
                local l__X__1 = p12.X;
                local l__Y__2 = p12.Y;
                local l__Z__3 = p12.Z;
                p11.Velocity = p11.Velocity + Vector3.new((l__X__1 ~= l__X__1 or (l__X__1 == (1 / 0) or l__X__1 == (-1 / 0))) and 0 or l__X__1, (l__Y__2 ~= l__Y__2 or (l__Y__2 == (1 / 0) or l__Y__2 == (-1 / 0))) and 0 or l__Y__2, (l__Z__3 ~= l__Z__3 or (l__Z__3 == (1 / 0) or l__Z__3 == (-1 / 0))) and 0 or l__Z__3);
            end,
            update = function(p13, p14) --[[ Name: update, Line 49 ]]
                local v15 = p14 * p13.Speed / 8;
                for _ = 1, 8 do
                    p13.Velocity = p13.Velocity + ((p13.Target - p13.Position) * p13.Force / p13.Mass - p13.Velocity * p13.Damping) * v15;
                    p13.Position = p13.Position + p13.Velocity * v15;
                end;
                return p13.Position;
            end
        };
    end
};
