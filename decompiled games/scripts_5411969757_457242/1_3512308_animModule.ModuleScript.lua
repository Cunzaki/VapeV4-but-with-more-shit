-- Decompiled with Potassium's decompiler.

local v2 = setmetatable({}, {
    __index = function(_, p1) --[[ Name: __index, Line 2 ]]
        return game:GetService(p1);
    end
});
local v3 = Instance.new("Animation");
local l__Humanoid__1 = v2.Players.LocalPlayer.Character:WaitForChild("Humanoid", 300);
repeat
    wait();
until l__Humanoid__1:FindFirstChild("Animator");
local v4 = l__Humanoid__1:FindFirstChild("Animator");
repeat
    wait();
until workspace:IsAncestorOf(v4);
local v5 = {};
local v6 = v3:Clone();
v6.AnimationId = "http://www.roblox.com/Asset?ID=2465046464";
local v7 = v3:Clone();
v7.AnimationId = "http://www.roblox.com/Asset?ID=2465051052";
local v8 = v3:Clone();
v8.AnimationId = "http://www.roblox.com/Asset?ID=2465051624";
local v9 = v3:Clone();
v9.AnimationId = "http://www.roblox.com/Asset?ID=5188747633";
local v10 = v3:Clone();
v10.AnimationId = "http://www.roblox.com/Asset?ID=2465058867";
local v11 = v3:Clone();
v11.AnimationId = "http://www.roblox.com/Asset?ID=2465062933";
local v12 = v3:Clone();
v12.AnimationId = "http://www.roblox.com/Asset?ID=2465063543";
local v13 = v3:Clone();
v13.AnimationId = "http://www.roblox.com/Asset?ID=2465064370";
local v14 = v3:Clone();
v14.AnimationId = "http://www.roblox.com/Asset?ID=2465064988";
local v15 = v3:Clone();
v15.AnimationId = "http://www.roblox.com/Asset?ID=2465065704";
local v16 = v3:Clone();
v16.AnimationId = "http://www.roblox.com/Asset?ID=2465067682";
local v17 = v3:Clone();
v17.AnimationId = "http://www.roblox.com/Asset?ID=2465038862";
local v18 = v3:Clone();
v18.AnimationId = "http://www.roblox.com/Asset?ID=2465039411";
local v19 = v3:Clone();
v19.AnimationId = "http://www.roblox.com/Asset?ID=2465040022";
local v20 = v3:Clone();
v20.AnimationId = "http://www.roblox.com/Asset?ID=2465033222";
local v21 = v3:Clone();
v21.AnimationId = "http://www.roblox.com/Asset?ID=2465034628";
local v22 = v3:Clone();
v22.AnimationId = "http://www.roblox.com/Asset?ID=2465035138";
local v23 = v3:Clone();
v23.AnimationId = "http://www.roblox.com/Asset?ID=2465036852";
local v24 = v3:Clone();
v24.AnimationId = "http://www.roblox.com/Asset?ID=2465031052";
v5.AnimTable = {
    ["StA-55"] = {
        HoldTrack = v4:LoadAnimation(v6),
        RecoilTrack = v4:LoadAnimation(v7),
        SprintTrack = v4:LoadAnimation(v8)
    },
    ["StA-25"] = {
        HoldTrack = v4:LoadAnimation(v6),
        RecoilTrack = v4:LoadAnimation(v7),
        SprintTrack = v4:LoadAnimation(v8)
    },
    ["StA-11"] = {
        HoldTrack = v4:LoadAnimation(v10),
        RecoilTrack = v4:LoadAnimation(v11),
        SprintTrack = v4:LoadAnimation(v12)
    },
    ["StA-3"] = {
        HoldTrack = v4:LoadAnimation(v6),
        RecoilTrack = v4:LoadAnimation(v7),
        SprintTrack = v4:LoadAnimation(v8)
    },
    ["StA-62"] = {
        HoldTrack = v4:LoadAnimation(v13),
        RecoilTrack = v4:LoadAnimation(v14),
        SprintTrack = v4:LoadAnimation(v8)
    },
    ["VC-32"] = {
        HoldTrack = v4:LoadAnimation(v6),
        RecoilTrack = v4:LoadAnimation(v7),
        SprintTrack = v4:LoadAnimation(v8),
        ZoomTrack = v4:LoadAnimation(v15),
        ZoomFireTrack = v4:LoadAnimation(v16)
    },
    ["StA-19"] = {
        HoldTrack = v4:LoadAnimation(v17),
        RecoilTrack = v4:LoadAnimation(v18),
        SprintTrack = v4:LoadAnimation(v19)
    },
    ["Medi-Gun"] = {
        HoldTrack = v4:LoadAnimation(v20),
        SprintTrack = v4:LoadAnimation(v21)
    },
    ["Medi-Gun [MEDIC]"] = {
        HoldTrack = v4:LoadAnimation(v20),
        SprintTrack = v4:LoadAnimation(v21)
    },
    ["VC-30"] = {
        HoldTrack = v4:LoadAnimation(v6),
        RecoilTrack = v4:LoadAnimation(v7),
        SprintTrack = v4:LoadAnimation(v8)
    },
    ["StA-19 [OFF]"] = {
        HoldTrack = v4:LoadAnimation(v22),
        RecoilTrack = v4:LoadAnimation(v23),
        SprintTrack = v4:LoadAnimation(v19)
    },
    ["StA-19 [OO]"] = {
        HoldTrack = v4:LoadAnimation(v17),
        RecoilTrack = v4:LoadAnimation(v18),
        SprintTrack = v4:LoadAnimation(v19)
    },
    ["Global-Animations"] = {
        Global_Crouch = v4:LoadAnimation(v9),
        Global_Salute = v4:LoadAnimation(v24)
    },
    M55 = {
        HoldTrack = v4:LoadAnimation(v6),
        RecoilTrack = v4:LoadAnimation(v7),
        SprintTrack = v4:LoadAnimation(v8)
    },
    LS12 = {
        HoldTrack = v4:LoadAnimation(v10),
        RecoilTrack = v4:LoadAnimation(v11),
        SprintTrack = v4:LoadAnimation(v12)
    },
    ["M224-A1"] = {
        HoldTrack = v4:LoadAnimation(v6),
        RecoilTrack = v4:LoadAnimation(v7),
        SprintTrack = v4:LoadAnimation(v8)
    },
    LS18 = {
        HoldTrack = v4:LoadAnimation(v6),
        RecoilTrack = v4:LoadAnimation(v7),
        SprintTrack = v4:LoadAnimation(v8)
    },
    M42 = {
        HoldTrack = v4:LoadAnimation(v6),
        RecoilTrack = v4:LoadAnimation(v7),
        SprintTrack = v4:LoadAnimation(v8),
        ZoomTrack = v4:LoadAnimation(v15),
        ZoomFireTrack = v4:LoadAnimation(v16)
    },
    ["M4 Revolver"] = {
        HoldTrack = v4:LoadAnimation(v17),
        RecoilTrack = v4:LoadAnimation(v18),
        SprintTrack = v4:LoadAnimation(v19)
    }
};
return v5;