-- Decompiled from: ReplicatedStorage.NexusVRCharacterModel.State.CharacterService
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__Character__2 = require(script.Parent.Parent:WaitForChild("Character"));
local u1 = {};
u1.__index = u1;
local u2 = nil;
function u1.new() --[[ Line: 25 ]]
    -- upvalues: u1 (copy), l__Players__1 (copy)
    local u3 = setmetatable({
        Characters = {}
    }, u1);
    l__Players__1.PlayerRemoving:Connect(function(p4) --[[ Line: 32 ]]
        -- upvalues: u3 (copy)
        u3.Characters[p4] = nil;
    end);
    return u3;
end;
function u1.GetInstance() --[[ Line: 43 ]]
    -- upvalues: u2 (ref), u1 (copy)
    if not u2 then
        u2 = u1.new();
    end;
    return u2;
end;
function u1.GetCharacter(p5, p6) --[[ Line: 53 ]]
    -- upvalues: l__Character__2 (copy)
    if not (p6.Character and p6.Character:FindFirstChild("Head")) then
        return nil;
    end;
    local v7 = p5.Characters[p6];
    if not v7 or v7.Character ~= p6.Character then
        p5.Characters[p6] = {
            Character = p6.Character,
            VRCharacter = l__Character__2.new(p6.Character)
        };
    end;
    return p5.Characters[p6].VRCharacter;
end;
function u1.RefreshAllCharacters(p8) --[[ Line: 75 ]]
    for _, v9 in p8.Characters do
        v9.VRCharacter:RefreshCharacter();
    end;
end;
return u1;
