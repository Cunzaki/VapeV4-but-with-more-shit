-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.World.DonateBoard
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__PlayerGui__2 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local l__Special__3 = game.Workspace:WaitForChild("Special");
local l__Mince__4 = require(l__ReplicatedStorage__1.Modules.Mince);
local u1 = l__Mince__4:Get("InterfaceHandler");
local u2 = l__Mince__4:Get("MarketHandler");
local u3 = {};
function u3.SetupBoard() --[[ Line: 21 ]]
    -- upvalues: u3 (copy), u1 (copy), u2 (copy)
    for _, v4 in u3.SurfaceUI.Main.Scroll:GetChildren() do
        local u5 = v4:GetAttribute("ProductID");
        if u5 then
            u1.NewButton(v4).Triggered:Connect(function() --[[ Line: 27 ]]
                -- upvalues: u2 (ref), u5 (copy)
                u2.StartProductPurchase(u5);
            end);
        end;
    end;
end;
function u3.Setup() --[[ Line: 34 ]]
    -- upvalues: u3 (copy), l__Special__3 (copy), l__PlayerGui__2 (copy)
    u3.SurfaceUI = l__Special__3:WaitForChild("DonateBoard");
    u3.SurfaceUI.Parent = l__PlayerGui__2;
    u3.SetupBoard();
end;
return u3;
