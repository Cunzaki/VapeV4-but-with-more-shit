-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__CurrentCamera__2 = game.Workspace.CurrentCamera;
local l__min__3 = math.min;
local l__tan__4 = math.tan;
local l__rad__5 = math.rad;
local l__new__6 = Ray.new;
local u1 = nil;
local u2 = nil;
local function v5() --[[ Line: 27 ]]
    -- upvalues: l__CurrentCamera__2 (copy), l__rad__5 (copy), u2 (ref), l__tan__4 (copy), u1 (ref)
    local v3 = l__rad__5(l__CurrentCamera__2.FieldOfView);
    local l__ViewportSize__7 = l__CurrentCamera__2.ViewportSize;
    local v4 = l__ViewportSize__7.X / l__ViewportSize__7.Y;
    u2 = l__tan__4(v3 / 2) * 2;
    u1 = v4 * u2;
end;
l__CurrentCamera__2:GetPropertyChangedSignal("FieldOfView"):Connect(v5);
l__CurrentCamera__2:GetPropertyChangedSignal("ViewportSize"):Connect(v5);
local v6 = l__rad__5(l__CurrentCamera__2.FieldOfView);
local l__ViewportSize__8 = l__CurrentCamera__2.ViewportSize;
local v7 = l__ViewportSize__8.X / l__ViewportSize__8.Y;
u2 = l__tan__4(v6 / 2) * 2;
u1 = v7 * u2;
local l__NearPlaneZ__9 = l__CurrentCamera__2.NearPlaneZ;
l__CurrentCamera__2:GetPropertyChangedSignal("NearPlaneZ"):Connect(function() --[[ Line: 42 ]]
    -- upvalues: l__NearPlaneZ__9 (ref), l__CurrentCamera__2 (copy)
    l__NearPlaneZ__9 = l__CurrentCamera__2.NearPlaneZ;
end);
local u8 = {};
local u9 = {};
local function v19(u10) --[[ Line: 59 ]]
    -- upvalues: u9 (copy), u8 (ref)
    local function v13() --[[ Line: 64 ]]
        -- upvalues: u9 (ref), u10 (copy), u8 (ref)
        u9[u10] = nil;
        local v11 = 1;
        u8 = {};
        for _, v12 in pairs(u9) do
            u8[v11] = v12;
            v11 = v11 + 1;
        end;
    end;
    u10.CharacterAdded:Connect(function(p14) --[[ Name: characterAdded, Line 60 ]]
        -- upvalues: u9 (ref), u10 (copy), u8 (ref)
        u9[u10] = p14;
        local v15 = 1;
        u8 = {};
        for _, v16 in pairs(u9) do
            u8[v15] = v16;
            v15 = v15 + 1;
        end;
    end);
    u10.CharacterRemoving:Connect(v13);
    if u10.Character then
        u9[u10] = u10.Character;
        local v17 = 1;
        u8 = {};
        for _, v18 in pairs(u9) do
            u8[v17] = v18;
            v17 = v17 + 1;
        end;
    end;
end;
local function v23(p20) --[[ Line: 76 ]]
    -- upvalues: u9 (copy), u8 (ref)
    u9[p20] = nil;
    local v21 = 1;
    u8 = {};
    for _, v22 in pairs(u9) do
        u8[v21] = v22;
        v21 = v21 + 1;
    end;
end;
l__Players__1.PlayerAdded:Connect(v19);
l__Players__1.PlayerRemoving:Connect(v23);
local u24 = u2;
local u25 = u1;
local u26 = l__NearPlaneZ__9;
for _, v27 in ipairs(l__Players__1:GetPlayers()) do
    v19(v27);
end;
local v28 = 1;
u8 = {};
local u29 = u8;
for _, v30 in pairs(u9) do
    u29[v28] = v30;
    v28 = v28 + 1;
end;
local u31 = nil;
local u32 = nil;
l__CurrentCamera__2:GetPropertyChangedSignal("CameraSubject"):Connect(function() --[[ Line: 110 ]]
    -- upvalues: l__CurrentCamera__2 (copy), u32 (ref)
    local l__CameraSubject__10 = l__CurrentCamera__2.CameraSubject;
    if l__CameraSubject__10:IsA("Humanoid") then
        u32 = l__CameraSubject__10.RootPart;
    elseif l__CameraSubject__10:IsA("BasePart") then
        u32 = l__CameraSubject__10;
    else
        u32 = nil;
    end;
end);
local u33 = {
    Vector2.new(0.4, 0),
    Vector2.new(-0.4, 0),
    Vector2.new(0, -0.4),
    Vector2.new(0, 0.4),
    Vector2.new(0, 0.2)
};
local function u43(p34, p35) --[[ Line: 146 ]]
    -- upvalues: u29 (ref), l__new__6 (copy)
    local v36 = #u29;
    while true do
        local v37, v38 = workspace:FindPartOnRayWithIgnoreList(l__new__6(p34, p35), u29, false, true);
        if v37 then
            if v37.CanCollide then
                local v39 = u29;
                for v40 = #v39, v36 + 1, -1 do
                    v39[v40] = nil;
                end;
                return v38, true;
            end;
            u29[#u29 + 1] = v37;
        end;
        if not v37 then
            local v41 = u29;
            for v42 = #v41, v36 + 1, -1 do
                v41[v42] = nil;
            end;
            return p34 + p35, false;
        end;
    end;
end;
local function u63(p44, p45, p46, p47) --[[ Line: 168 ]]
    -- upvalues: u29 (ref), u26 (ref), l__new__6 (copy), u31 (ref)
    debug.profilebegin("queryPoint");
    local v48 = #u29;
    local v49 = p46 + u26;
    local v50 = p44 + p45 * v49;
    local v51 = p44;
    local v52 = (1 / 0);
    local v53 = (1 / 0);
    while true do
        local v54, v55 = workspace:FindPartOnRayWithIgnoreList(l__new__6(p44, v50 - p44), u29, false, true);
        local v56;
        if v54 then
            local v57;
            if 1 - (1 - v54.Transparency) * (1 - v54.LocalTransparencyModifier) < 0.25 then
                v57 = v54.CanCollide;
                if v57 then
                    if u31 == (v54:GetRootPart() or v54) then
                        v57 = false;
                    else
                        v57 = not v54:IsA("TrussPart");
                    end;
                end;
            else
                v57 = false;
            end;
            if v57 then
                local v58 = { v54 };
                local v59 = workspace:FindPartOnRayWithWhitelist(l__new__6(v50, v55 - v50), v58, true);
                v56 = (v55 - v51).Magnitude;
                if v59 then
                    local v60;
                    if p47 then
                        v60 = workspace:FindPartOnRayWithWhitelist(l__new__6(p47, v50 - p47), v58, true) or workspace:FindPartOnRayWithWhitelist(l__new__6(v50, p47 - v50), v58, true);
                    else
                        v60 = false;
                    end;
                    if v60 then
                        v52 = v56;
                        v56 = v53;
                    elseif v49 >= v53 then
                        v56 = v53;
                    end;
                else
                    v52 = v56;
                    v56 = v53;
                end;
            else
                v56 = v53;
            end;
            u29[#u29 + 1] = v54;
            p44 = v55 - p45 * 0.001;
        else
            v56 = v53;
        end;
        if v52 < (1 / 0) or not v54 then
            local v61 = u29;
            for v62 = #v61, v48 + 1, -1 do
                v61[v62] = nil;
            end;
            debug.profileend();
            return v56 - u26, v52 - u26;
        end;
        v53 = v56;
    end;
end;
local function u74(p64, p65) --[[ Line: 222 ]]
    -- upvalues: l__CurrentCamera__2 (copy), u25 (ref), u24 (ref), u26 (ref), u63 (copy)
    debug.profilebegin("queryViewport");
    local l__p__11 = p64.p;
    local l__rightVector__12 = p64.rightVector;
    local l__upVector__13 = p64.upVector;
    local v66 = -p64.lookVector;
    local l__ViewportSize__14 = l__CurrentCamera__2.ViewportSize;
    local v67 = (1 / 0);
    local v68 = (1 / 0);
    for v69 = 0, 1 do
        local v70 = l__rightVector__12 * ((v69 - 0.5) * u25);
        for v71 = 0, 1 do
            local v72, v73 = u63(l__p__11 + u26 * (v70 + l__upVector__13 * ((v71 - 0.5) * u24)), v66, p65, l__CurrentCamera__2:ViewportPointToRay(l__ViewportSize__14.x * v69, l__ViewportSize__14.y * v71).Origin);
            if v73 >= v67 then
                v73 = v67;
            end;
            if v72 < v68 then
                v68 = v72;
                v67 = v73;
            else
                v67 = v73;
            end;
        end;
    end;
    debug.profileend();
    return v68, v67;
end;
local function u83(p75, p76, p77) --[[ Line: 263 ]]
    -- upvalues: u43 (copy), l__min__3 (copy), u63 (copy), u33 (copy)
    debug.profilebegin("testPromotion");
    local l__p__15 = p75.p;
    local l__rightVector__16 = p75.rightVector;
    local l__upVector__17 = p75.upVector;
    local v78 = -p75.lookVector;
    debug.profilebegin("extrapolate");
    local l__Magnitude__18 = (u43(l__p__15, p77.posVelocity * 1.25) - l__p__15).Magnitude;
    for v79 = 0, l__min__3(1.25, p77.rotVelocity.magnitude + l__Magnitude__18 / p77.posVelocity.magnitude), 0.0625 do
        local v80 = p77.extrapolate(v79);
        if p76 <= u63(v80.p, -v80.lookVector, p76) then
            return false;
        end;
    end;
    debug.profileend();
    debug.profilebegin("testOffsets");
    for _, v81 in ipairs(u33) do
        local v82 = u43(l__p__15, l__rightVector__16 * v81.x + l__upVector__17 * v81.y);
        if u63(v82, (l__p__15 + v78 * p76 - v82).Unit, p76) == (1 / 0) then
            return false;
        end;
    end;
    debug.profileend();
    debug.profileend();
    return true;
end;
return function(p84, p85, p86) --[[ Name: Popper, Line 312 ]]
    -- upvalues: u31 (ref), u32 (ref), u74 (copy), u83 (copy)
    debug.profilebegin("popper");
    u31 = u32 and u32:GetRootPart() or u32;
    local v87, v88 = u74(p84, p85);
    if v88 >= p85 then
        v88 = p85;
    end;
    if v87 < v88 then
        if not u83(p84, p85, p86) then
            v87 = v88;
        end;
    else
        v87 = v88;
    end;
    u31 = nil;
    debug.profileend();
    return v87;
end;