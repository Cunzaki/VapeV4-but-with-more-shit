-- Decompiled from: ReplicatedStorage.Modules.Mince.Addons.character
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__MinceRef__1 = _G.MinceRef;
local l__Players__2 = game:GetService("Players");
return {
    Identity = function(p1) --[[ Name: Identity, Line 29 ]]
        -- upvalues: l__Players__2 (copy), l__MinceRef__1 (copy)
        if p1 == "Client" then
            local l__LocalPlayer__3 = l__Players__2.LocalPlayer;
            local function v3(p2) --[[ Line: 7 ]]
                -- upvalues: l__MinceRef__1 (ref)
                local l__Humanoid__4 = p2:WaitForChild("Humanoid");
                local l__HumanoidRootPart__5 = p2:WaitForChild("HumanoidRootPart");
                l__MinceRef__1.Character = p2;
                l__MinceRef__1.HumanoidRootPart = l__HumanoidRootPart__5;
                l__MinceRef__1.Humanoid = l__Humanoid__4;
                l__MinceRef__1.LastCharacterSpawn = os.clock();
                l__Humanoid__4.Died:Connect(function() --[[ Line: 16 ]]
                    -- upvalues: l__MinceRef__1 (ref)
                    l__MinceRef__1.Character = nil;
                    l__MinceRef__1.HumanoidRootPart = nil;
                    l__MinceRef__1.Humanoid = nil;
                end);
            end;
            l__LocalPlayer__3.CharacterAdded:Connect(v3);
            if l__LocalPlayer__3.Character then
                v3(l__LocalPlayer__3.Character);
            end;
        end;
    end
};
