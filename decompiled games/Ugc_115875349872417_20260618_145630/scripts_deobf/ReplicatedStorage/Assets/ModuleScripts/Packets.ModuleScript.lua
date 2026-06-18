-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Packets
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: d21c1b0a-cbe1-4207-9199-12d11b3e8c58

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__Packet__2 = require(script.Packet);
local l__CheckServerPredicate__3 = l__Packet__2.CheckServerPredicate;
local v1 = {
    _x65704612d32cd5fd = l__Packet__2("_xcb1850a5156b957b", l__Packet__2.String, l__Packet__2.String):Response(l__Packet__2.Boolean8),
    _xb36b470092ff17d7 = l__Packet__2("_x6bc5db5e92e996ed", l__Packet__2.Any):Response(l__Packet__2.Any),
    _x42ceccfc7e7a492b = l__Packet__2("_x412d5aba81a45805", l__Packet__2.NumberF32),
    _x3f12d9c922d8fa3c = l__Packet__2("_x81b05b22e54c8fdb"):Response(l__Packet__2.Any),
    _x8d4e0a4e661af272 = l__Packet__2("_x5084728f559eb268", l__Packet__2.Any),
    _xa9d3d3daafd1bf9a = l__Packet__2("_xd79d506e7793040d", l__Packet__2.String),
    _xcd0b4f0c94c61f1b = l__Packet__2("_xb497c6058c655258"),
    _x0d647d9e553b52e8 = l__Packet__2("_x1c03c43425a7a954", l__Packet__2.String, l__Packet__2.String, l__Packet__2.String),
    _x000cd2957912ab21 = l__Packet__2("_xee8395a675f67a0e"),
    _xceeb9bb38d6dafa5 = l__Packet__2("_x4e47cb92315ea87c"),
    _xf332c7eb89e7cb16 = l__Packet__2("_x87a92d3904d0058a"):Response(l__Packet__2.Boolean8, l__Packet__2.Any),
    _x547622139233bbdd = l__Packet__2("_xa6a95329591b7150", l__Packet__2.Any),
    _x990948d8235bab65 = l__Packet__2("_x14bf1a6d530022e2", l__Packet__2.String, l__Packet__2.String),
    _xba9fc88ff1172d6c = l__Packet__2("_x579b2099b2c94aa0", l__Packet__2.String, l__Packet__2.Any),
    _xa20c1ad6e56c96e7 = l__Packet__2("_xceaa8f46f10f30a1", l__Packet__2.String, l__Packet__2.String, l__Packet__2.String, l__Packet__2.Vector3F24, { l__Packet__2.Instance }, l__Packet__2.Any),
    _x334266a937df41a9 = l__Packet__2("_x7780c481a501510a", l__Packet__2.String),
    _x67790e3a4ae7698a = l__Packet__2("_x3c527c68d296e427", l__Packet__2.String, l__Packet__2.Any):Response(l__Packet__2.Boolean8),
    _x064f9c5cc00bec7e = l__Packet__2("_x7eb9eef427c2a5f9", l__Packet__2.String, l__Packet__2.String):Response(l__Packet__2.Any),
    _x055d17c7b310ad24 = l__Packet__2("_x03eb4a5ededbf8b2", l__Packet__2.String, l__Packet__2.Vector3F32, l__Packet__2.Vector3F32, l__Packet__2.String),
    _x909c506c0531ca26 = l__Packet__2("_xb3451698f9db2ef6", l__Packet__2.String, l__Packet__2.Vector3F32, l__Packet__2.Vector3F32, l__Packet__2.Any, l__Packet__2.String),
    _xade50db7ec690d88 = l__Packet__2("_x73cad6b5a2d37c78", l__Packet__2.String, l__Packet__2.String):Response(l__Packet__2.Any),
    _xa20cd8b23f1f9c68 = l__Packet__2("_xfaa75855f5be68a6", l__Packet__2.NumberF64, l__Packet__2.Vector3F32, l__Packet__2.NumberF32, l__Packet__2.Boolean8, l__Packet__2.Boolean8):Response(l__Packet__2.String, l__Packet__2.Boolean8, l__Packet__2.Boolean8),
    _x51cb2066c94db9ba = l__Packet__2("_x0aab5a2677833870", l__Packet__2.Any),
    _x6c53c187238c8a23 = l__Packet__2("_xd69c0d72428d6b93", l__Packet__2.Any),
    _x63e68dbc76b16aa6 = l__Packet__2("_x9cc7798ea2e8e7f1", l__Packet__2.Any),
    _x4a9e94f14df7f3b8 = l__Packet__2("_xe33219488c3c6b62", l__Packet__2.Any),
    _xfaa2c2e4ef7509b5 = l__Packet__2("_x87f2b527430a6477", l__Packet__2.Any),
    _x63ad7818d7c3e77b = l__Packet__2("_x50466f2f5d2edd06"):Response(l__Packet__2.Any),
    _xee2089b47d2ef51a = l__Packet__2("_x8bc9e8b9a8a13be9", l__Packet__2.Any),
    _x5adbe1c2dab6c690 = l__Packet__2("_xe6061216fc83ba56", l__Packet__2.Any),
    _xd5755b1b02f60b99 = l__Packet__2("_x20a2769890d31b80", l__Packet__2.String, l__Packet__2.String, l__Packet__2.String):Response(l__Packet__2.Any),
    _xd1b838f7b98a592f = l__Packet__2("_x764441dc256e5768", l__Packet__2.String),
    _x12b8faffd292dd32 = l__Packet__2("_x1f710b090edc8770", l__Packet__2.String),
    _x1ed148e14a64125c = l__Packet__2("_x770628eee42bd85f", l__Packet__2.Any),
    _x62a9dc84762d3b26 = l__Packet__2("_x7c8e7bb1ff7b45ae", l__Packet__2.String, l__Packet__2.String, l__Packet__2.NumberU16),
    _x42104db25560419c = l__Packet__2("_xf40a46f3b6bf2bf3", l__Packet__2.String, l__Packet__2.NumberU16),
    _x94530fd1c3062c95 = l__Packet__2("_x9981989ddd338ddc", l__Packet__2.Any),
    _x161153098656f9c2 = l__Packet__2("_x82bd379fbfc6a150", l__Packet__2.Any),
    _x194a94be82e192db = l__Packet__2("_x227b69aee67e50ef", l__Packet__2.Any),
    _x43501f4d2e65af28 = l__Packet__2("_x01849f4bf521b4e4", l__Packet__2.Any),
    _xb597a1f2d80824ed = l__Packet__2("_xe02ce32c51b8fa92", l__Packet__2.Any),
    _xf2ec37c51f251f47 = l__Packet__2("_x53842475f4512933"),
    _xeb5f1417d5dd7629 = l__Packet__2("_x9dc46e688114a007", l__Packet__2.Any),
    _xee714a71a277a1a3 = l__Packet__2("_x83cf9903ce6225af", l__Packet__2.Any),
    _x1f462271ad5f7099 = l__Packet__2("_x3c05bcf9e2ba1fc2", l__Packet__2.Any),
    _xe98e3ab9d7e26ed2 = l__Packet__2("_x443a0fff818e7690", l__Packet__2.Any),
    _xd5a9d73c53b4d910 = l__Packet__2("_x0ab9efbd0274efdc", l__Packet__2.Any),
    _xf1a5e1b80bd07564 = l__Packet__2("_xe2f1a787d7a1580f", l__Packet__2.Any),
    _xc0f7f29018718841 = l__Packet__2("_x05fb8446fc8e903f", l__Packet__2.Any),
    _x0cdd43b25777bec6 = l__Packet__2("_xf79f32f314e05aac", l__Packet__2.String, l__Packet__2.String, l__Packet__2.String, { l__Packet__2.Any }),
    _xbfaa5820a4100b86 = l__Packet__2("_xae295ea597938276", l__Packet__2.String):Response(l__Packet__2.String),
    _x63a336634450c99d = l__Packet__2("_x16dae9ae9d994ebb", l__Packet__2.String),
    _xf02780962360a20d = l__Packet__2("_x165b818bbde759db"),
    _x1e60efff7ef01a3a = l__Packet__2("_x164ef6f5bdd7bd3b"),
    _x1554ede5375131b3 = l__Packet__2("_x41b28418ca3f424e"),
    _x6c957041bc9a5148 = l__Packet__2("_xf065988454214a08", l__Packet__2.String),
    _x63c8955f84a980a6 = l__Packet__2("_xa88251b0a8566697", l__Packet__2.Any, l__Packet__2.Any),
    _xba32886466402e05 = l__Packet__2("_x4311926a1dfcbcdb", l__Packet__2.StringLong),
    _xb808d95d66c8eda8 = l__Packet__2("_x6d2c212c3202eae8", l__Packet__2.Any),
    _x0d1866f15119fb98 = l__Packet__2("_x70bb848bbe39e597", l__Packet__2.Any),
    _x90aa1001178059e0 = l__Packet__2("_x0099b15b7798a383", l__Packet__2.Any),
    _xb683881048afb304 = l__Packet__2("_x377af95c659cfb17", l__Packet__2.String, l__Packet__2.Any),
    _xf59f4a521d72be14 = l__Packet__2("_xfb52090d16b80b77", l__Packet__2.String, l__Packet__2.Any),
    _x75a938726f9fe95f = l__Packet__2("_xae485e1964539943"),
    _xa512847493af8250 = l__Packet__2("_x4a72276d5700fe94", l__Packet__2.Instance, l__Packet__2.Any),
    _x525bd43c8a54795b = l__Packet__2("_xc89c7c4b395f7084", l__Packet__2.Instance),
    _x1b774e73c6cfb3a6 = l__Packet__2("_x264c7bf48f015d60", l__Packet__2.Instance, l__Packet__2.Any),
    _x25612d831eaed003 = l__Packet__2("_x0b9a3dfaebd1a086"),
    _x4245eccb88c28d52 = l__Packet__2("_x41e003cb5f87d531", l__Packet__2.Any),
    _x531476857d90e575 = l__Packet__2("_x8bc8ae74d2e849f4", l__Packet__2.Any, l__Packet__2.Any),
    _xc9c4207c75682687 = l__Packet__2("_x616e762e9441abcb", l__Packet__2.NumberF16),
    _x506bc57f88c7fb18 = l__Packet__2("_xeca114ba53f09789", l__Packet__2.Any),
    _x37a4b30a0b3cb2b9 = l__Packet__2("_xd462bd0df0b434de", l__Packet__2.Any),
    _xbfc686825bdb8cdf = l__Packet__2("_xa4cbb2dbd10fc690", l__Packet__2.Any),
    _x65729782b2a34ba4 = l__Packet__2("_x828a01e2ead6fa86", l__Packet__2.Instance, l__Packet__2.Any),
    _xfaeb5b6dbfe4a213 = l__Packet__2("_x8cce311203bb937a", l__Packet__2.Instance, l__Packet__2.String),
    _xeab8c95de187561c = l__Packet__2("_xca335fe3dfbc5ea2", l__Packet__2.String, l__Packet__2.Instance, l__Packet__2.Any),
    _xc496960301642853 = l__Packet__2("_x114a8f45ec604d4b", l__Packet__2.String, l__Packet__2.Instance, l__Packet__2.Any),
    _x1d844bfc9ae8096f = l__Packet__2("_x5a8e1dc054dda288", l__Packet__2.Any, l__Packet__2.Any),
    _xfeb73535ced43c5e = l__Packet__2("_x023f03a21df722b4", l__Packet__2.Boolean8, l__Packet__2.Any, l__Packet__2.String),
    _xd41219a82fb9b0a8 = l__Packet__2("_x80117ffbfc726803", l__Packet__2.String, l__Packet__2.Any),
    _x9af13bc53d02488c = l__Packet__2("_xe1e77d299be44453", l__Packet__2.String, l__Packet__2.Any),
    _x666ba571031b7cd7 = l__Packet__2("_xa47f7a6f927894b6", l__Packet__2.String, l__Packet__2.Any),
    _xf4f412e8abf108a3 = l__Packet__2("_x942e3ad6b03ef5c5"),
    _x2c1d4db5b621bd47 = l__Packet__2("_x61a84e162b121414", l__Packet__2.Any),
    _xd58269903cb88850 = l__Packet__2("_x9e5c0475032eddfe", l__Packet__2.String, l__Packet__2.NumberF32, l__Packet__2.NumberF32, l__Packet__2.Boolean8, l__Packet__2.NumberF32, l__Packet__2.Vector3F32, l__Packet__2.String, l__Packet__2.NumberU32, l__Packet__2.NumberU32),
    unreliablePackets = {
        _x5ae310e9248fdbec = l__Packet__2("_xc76cd0af979a81f2", l__Packet__2.NumberF16),
        _x8183092ff6492439 = l__Packet__2("_x63a6dc5dade7b86f", l__Packet__2.Boolean8),
        _xb2c4d57f1a1d68e0 = l__Packet__2("_x864c918cc8939c7d", l__Packet__2.NumberF16, l__Packet__2.NumberF16),
        _x8dc5443e6942d6de = l__Packet__2("_x5b6f178171bc787a", l__Packet__2.NumberF16),
        _x32655291067177dc = l__Packet__2("_x65bb0f985e50439b", l__Packet__2.NumberF16, l__Packet__2.NumberF16),
        _xeaae65f9581e0520 = l__Packet__2("_xdc89f05a9b1d0362", l__Packet__2.Any),
        _x5cb98f3c4fec7a9c = l__Packet__2("_x3c2c7637ea9172f8", l__Packet__2.Any),
        _x1da5b0409e108466 = l__Packet__2("_x88a8536e432fb56a", l__Packet__2.Any),
        _x67d64518d3944c3c = l__Packet__2("_x9556480f0aba83ca"),
        _xc3b93db57f8bb584 = l__Packet__2("_x642165be1833e507", l__Packet__2.Any),
        _xeaed22345e877d6f = l__Packet__2("_x1f9f795f7ef5ed8d", l__Packet__2.Instance, l__Packet__2.Vector3F32, l__Packet__2.Vector3F32, l__Packet__2.Vector3F32, l__Packet__2.NumberF64, l__Packet__2.NumberU32),
        _x59619b2167cd6dd9 = l__Packet__2("_x1cd43e7a5c29482e", l__Packet__2.String, l__Packet__2.Vector3F32, l__Packet__2.NumberU32),
        _x87742c78e4506257 = l__Packet__2("_x081606ff389e4fa1", l__Packet__2.String, l__Packet__2.Any, l__Packet__2.NumberU32)
    }
};
local function v10(u2) --[[ Line: 219 ]]
    -- upvalues: l__CheckServerPredicate__3 (copy), l__RunService__1 (copy)
    local u3 = Instance.new("UnreliableRemoteEvent");
    u3.Name = u2.Name;
    u3.Parent = script;
    u3.OnServerEvent:Connect(function(p4, ...) --[[ Line: 223 ]]
        -- upvalues: u2 (copy), l__CheckServerPredicate__3 (ref), l__RunService__1 (ref)
        local v5, v6 = pcall(function(...) --[[ Line: 224 ]]
            -- upvalues: u2 (ref)
            return table.pack(u2:Deserialize(...));
        end, ...);
        if v5 then
            if l__CheckServerPredicate__3(p4, u2, "Event", false, v6) then
                u2.OnServerEvent:Fire(p4, table.unpack(v6, 1, v6.n));
            end;
        else
            l__CheckServerPredicate__3(p4, u2, "Event", false, table.pack(...));
            if l__RunService__1:IsStudio() then
                warn("Failed to deserialize unreliable packet:", u2.Name, v6);
            end;
        end;
    end;
    function u2.Fire(p7, ...) --[[ Line: 241 ]]
        -- upvalues: u3 (copy)
        u3:FireAllClients(p7:Serialize(...));
    end;
    function u2.FireClient(p8, p9, ...) --[[ Line: 245 ]]
        -- upvalues: u3 (copy)
        u3:FireClient(p9, p8:Serialize(...));
    end;
end;
local function v14(u11) --[[ Line: 250 ]]
    local u12 = script:WaitForChild(u11.Name);
    u12.OnClientEvent:Connect(function(...) --[[ Line: 252 ]]
        -- upvalues: u11 (copy)
        u11.OnClientEvent:Fire(u11:Deserialize(...));
    end;
    function u11.Fire(p13, ...) --[[ Line: 256 ]]
        -- upvalues: u12 (copy)
        u12:FireServer(p13:Serialize(...));
    end;
end;
for _, v15 in v1.unreliablePackets do
    if l__RunService__1:IsServer() then
        v10(v15);
    else
        v14(v15);
    end;
end;
return v1;
