-- Decompiled with Potassium's decompiler.

local v1 = {};
for _, v2 in {
    script:WaitForChild("Serialized_Blank"),
    script:WaitForChild("Serialized_Blind"),
    script:WaitForChild("Serialized_Chat"),
    script:WaitForChild("Serialized_CommandBar"),
    script:WaitForChild("Serialized_Credit"),
    script:WaitForChild("Serialized_Error"),
    script:WaitForChild("Serialized_Help"),
    script:WaitForChild("Serialized_Hint"),
    script:WaitForChild("Serialized_List"),
    script:WaitForChild("Serialized_Msg"),
    script:WaitForChild("Serialized_Search"),
    script:WaitForChild("Serialized_Settings"),
    script:WaitForChild("Serialized_Timer"),
    script:WaitForChild("Serialized_Vote"),
    script:WaitForChild("Serialized_Direct"),
    script:WaitForChild("Serialized_Resize"),
    script:WaitForChild("Serialized_Note")
} do
    v1[v2.Name:gsub("Serialized_", "")] = require(v2);
end;
return v1;