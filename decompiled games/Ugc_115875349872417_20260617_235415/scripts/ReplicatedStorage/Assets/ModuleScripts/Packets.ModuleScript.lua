-- Decompiled from: ReplicatedStorage.Assets.ModuleScripts.Packets
-- Class: ModuleScript
-- Place: Ugc (115875349872417)
-- JobId: eb997104-f05b-4f40-8972-25defa1faf45

-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__Packet__2 = require(script.Packet);
local l__CheckServerPredicate__3 = l__Packet__2.CheckServerPredicate;
local v1 = {
    _xbe7dde9a4c999d70 = l__Packet__2("_x713eb5ed6cfd244c", l__Packet__2.String, l__Packet__2.String):Response(l__Packet__2.Boolean8),
    _xa1b346ef877bc52a = l__Packet__2("_xed3989fa2e113ac9", l__Packet__2.Any):Response(l__Packet__2.Any),
    _x37821f9f8b2dd72c = l__Packet__2("_x282148f3d6dcb6a2", l__Packet__2.NumberF32),
    _xb25cbf8ed4ab781d = l__Packet__2("_xb6d0f27b650533d3"):Response(l__Packet__2.Any),
    _x38ed1f49b70152bd = l__Packet__2("_x52bab5e6a906de3d", l__Packet__2.Any),
    _xbd05509855a2a927 = l__Packet__2("_x29779f16469314c1", l__Packet__2.String),
    _xe4e49c228dd6efef = l__Packet__2("_xea2b8089ff87216e"),
    _xbe3951814b64e389 = l__Packet__2("_x170497601f92e1b1", l__Packet__2.String, l__Packet__2.String, l__Packet__2.String),
    _x1a960b7277e0f42d = l__Packet__2("_x82586791b07205ae"),
    _x8558823a46f1bd44 = l__Packet__2("_x35945ad86509e33c"),
    _x0ccfe7515ba66c63 = l__Packet__2("_xf73246190bcd051b"):Response(l__Packet__2.Boolean8, l__Packet__2.Any),
    _x7f93448307b05ecf = l__Packet__2("_x4908bce40368966f", l__Packet__2.Any),
    _x54e801d0c00ece13 = l__Packet__2("_x0f8f22a7c450ee5d", l__Packet__2.String, l__Packet__2.String),
    _x851f9a3ff98bf94f = l__Packet__2("_xea2547d0242221ce", l__Packet__2.String, l__Packet__2.Any),
    _xf5e1e1983608ed25 = l__Packet__2("_xf6afcf3c8b6be378", l__Packet__2.String, l__Packet__2.String, l__Packet__2.String, l__Packet__2.Vector3F24, { l__Packet__2.Instance }, l__Packet__2.Any),
    _xcfd25ad2550161be = l__Packet__2("_x5b2d6fe7c17fcfc7", l__Packet__2.String),
    _xd1d1ed4c2ff2e856 = l__Packet__2("_xfc9586b94ab7a64a", l__Packet__2.String, l__Packet__2.Any):Response(l__Packet__2.Boolean8),
    _xe3f2932c4e467d66 = l__Packet__2("_x1e6ea11558c37157", l__Packet__2.String, l__Packet__2.String):Response(l__Packet__2.Any),
    _x46607a58775a7f10 = l__Packet__2("_x2267e83ac6b5c9d4", l__Packet__2.String, l__Packet__2.Vector3F32, l__Packet__2.Vector3F32, l__Packet__2.String),
    _x6f11420c13d0d5ee = l__Packet__2("_xc4325acde1be82fe", l__Packet__2.String, l__Packet__2.Vector3F32, l__Packet__2.Vector3F32, l__Packet__2.Any, l__Packet__2.String),
    _xb0f023e4d9d34617 = l__Packet__2("_x675210b1016c35c7", l__Packet__2.String, l__Packet__2.String):Response(l__Packet__2.Any),
    _xc5a43c7f94f9f910 = l__Packet__2("_x89c91615694b5497", l__Packet__2.NumberF64, l__Packet__2.Vector3F32, l__Packet__2.NumberF32, l__Packet__2.Boolean8, l__Packet__2.Boolean8):Response(l__Packet__2.String, l__Packet__2.Boolean8, l__Packet__2.Boolean8),
    _x27cb9fed7e43d530 = l__Packet__2("_xddd1f3e11b31b1fc", l__Packet__2.Any),
    _x19083cea6d9c3cec = l__Packet__2("_x42b9925971b0c052", l__Packet__2.Any),
    _xe543f884b99a8f87 = l__Packet__2("_xad4d587a17bfd36a", l__Packet__2.Any),
    _xb107e17a2a93fbac = l__Packet__2("_x33f91cef3a311d30", l__Packet__2.Any),
    _x56d68a6b15750fcf = l__Packet__2("_x57c09d3dd635dcdc", l__Packet__2.Any),
    _x2cc339cff5a4e1eb = l__Packet__2("_x97485362c7da4a0a"):Response(l__Packet__2.Any),
    _x16343f5702c10d0e = l__Packet__2("_x9aedc19de1cd5892", l__Packet__2.Any),
    _xb091fe04e773fa7b = l__Packet__2("_x673923c9b9b4f17f", l__Packet__2.Any),
    _x40d842b9563b38e9 = l__Packet__2("_xb3ad89c35aedc2ed", l__Packet__2.String, l__Packet__2.String, l__Packet__2.String):Response(l__Packet__2.Any),
    _x7a8eb03e390ff2a8 = l__Packet__2("_x04514ae45f6082a1", l__Packet__2.String),
    _x9a2160c1e6226f77 = l__Packet__2("_x42c0780b814ce9b7", l__Packet__2.String),
    _x8d8e8ab8b399dc7b = l__Packet__2("_x818262e8c82bfe1a", l__Packet__2.Any),
    _x1111971a4ba469c5 = l__Packet__2("_x6fc2f58ce3fbc0ea", l__Packet__2.String, l__Packet__2.String, l__Packet__2.NumberU16),
    _x44ecb119ed705f12 = l__Packet__2("_xdc031e0f5728dbd2", l__Packet__2.String, l__Packet__2.NumberU16),
    _xe7f8171a9d1134f8 = l__Packet__2("_xadff6a5efdaa3764", l__Packet__2.Any),
    _x5b73d7c52eb7333c = l__Packet__2("_xaf063ff9da279ba5", l__Packet__2.Any),
    _xbdcb7a090a5c3d5a = l__Packet__2("_xd896134e293ece52", l__Packet__2.Any),
    _x02ac3521dbed3d9d = l__Packet__2("_x65b6503cc4cf62fa", l__Packet__2.Any),
    _xf1028078c3d0db09 = l__Packet__2("_x7a2cf177dcc4cc31", l__Packet__2.Any),
    _x3d8fafaf89950026 = l__Packet__2("_x96ca84dcd21584a7"),
    _x97a14f34b8ed4a3f = l__Packet__2("_x1831273b3451ed9d", l__Packet__2.Any),
    _x2925dacc9725d2ce = l__Packet__2("_x8c3b362cd85e9a58", l__Packet__2.Any),
    _x88051fb7128eb54b = l__Packet__2("_x5ce538cf221e6f3f", l__Packet__2.Any),
    _x7a2ae673a30543e6 = l__Packet__2("_x9e96bfc4e2de93d2", l__Packet__2.Any),
    _x0e45f811eb4ba377 = l__Packet__2("_x222f9b83c4d304d5", l__Packet__2.Any),
    _xb5bc17d25fad4165 = l__Packet__2("_xc5ae4953da5e0a60", l__Packet__2.Any),
    _x8b76331abaa56758 = l__Packet__2("_x77644879721c2efd", l__Packet__2.Any),
    _xff9e8e66a100da8b = l__Packet__2("_xa454b2d0eac516e2", l__Packet__2.String, l__Packet__2.String, l__Packet__2.String, { l__Packet__2.Any }),
    _x57c165550ede3092 = l__Packet__2("_xd329079298ae11be", l__Packet__2.String):Response(l__Packet__2.String),
    _x5e5bc1afecb1e60f = l__Packet__2("_xb41fbc5552fb7b3b", l__Packet__2.String),
    _x95a7dcd2ba19667f = l__Packet__2("_x68d200d9b333583e"),
    _xd23343573495bac5 = l__Packet__2("_xc6629d7c5578c126"),
    _x0801b594706a3943 = l__Packet__2("_xa978e1f280c2e77a"),
    _x27f295938e2db2f2 = l__Packet__2("_x702d89f1b150b631", l__Packet__2.String),
    _x95c5751a8734f30a = l__Packet__2("_x435569acf0428016", l__Packet__2.Any, l__Packet__2.Any),
    _x3129728123d8b7b9 = l__Packet__2("_x1d460d9a23f8e5ae", l__Packet__2.StringLong),
    _xe671a0aa8a52fedd = l__Packet__2("_xd94ee4d7b0f89710", l__Packet__2.Any),
    _xfcd03f970df1d778 = l__Packet__2("_x054b49776cce69fe", l__Packet__2.Any),
    _x03bd34ec23e0dfa7 = l__Packet__2("_x3fe9996453a64623", l__Packet__2.Any),
    _x3a51da27a23b5652 = l__Packet__2("_x4e8da03c8572bbd8", l__Packet__2.String, l__Packet__2.Any),
    _x2789e1e99395ef5d = l__Packet__2("_xcdee55d488ec5154", l__Packet__2.String, l__Packet__2.Any),
    _xbbc61c8e01527b7c = l__Packet__2("_x27acb6414def676b"),
    _x3d559977708a04d1 = l__Packet__2("_x6ade6018d93f63b8", l__Packet__2.Instance, l__Packet__2.Any),
    _xe3bfd4393906a1b6 = l__Packet__2("_x96acd07e020ffa89", l__Packet__2.Instance),
    _x27f7514677f64b93 = l__Packet__2("_x1b471f5bd215233e", l__Packet__2.Instance, l__Packet__2.Any),
    _x7ffd0a407efb61ef = l__Packet__2("_x65b283a5a702bec9"),
    _xf83bd5b1e5c00bd6 = l__Packet__2("_x212ccc82cb2df5e9", l__Packet__2.Any),
    _xf0d64c6a69399585 = l__Packet__2("_x5df6cdaac6464408", l__Packet__2.Any, l__Packet__2.Any),
    _x71a4ac7aba517193 = l__Packet__2("_xae93b0718fb79a13", l__Packet__2.NumberF16),
    _x7385f04acbd3d15f = l__Packet__2("_x1ad07969543d1bef", l__Packet__2.Any),
    _x13adfdc69dfdf777 = l__Packet__2("_x0083dc438a027d48", l__Packet__2.Any),
    _x48db504631e9f96b = l__Packet__2("_x89518238d189a081", l__Packet__2.Any),
    _xc2cd69c902ae68f8 = l__Packet__2("_xb62037a63953e4ef", l__Packet__2.Instance, l__Packet__2.Any),
    _xfb6e8daf30b26df5 = l__Packet__2("_xd60be9b9d7f96400", l__Packet__2.Instance, l__Packet__2.String),
    _x62371b6ac34c03a2 = l__Packet__2("_xd2756a5b16054b0d", l__Packet__2.String, l__Packet__2.Instance, l__Packet__2.Any),
    _x2abba096e4373872 = l__Packet__2("_x1857c9b9e9d01933", l__Packet__2.String, l__Packet__2.Instance, l__Packet__2.Any),
    _x972e4673467ce2e8 = l__Packet__2("_x4934c9398933577d", l__Packet__2.Any, l__Packet__2.Any),
    _x5f8c156db21e404c = l__Packet__2("_xf3e726210b7ecb50", l__Packet__2.Boolean8, l__Packet__2.Any, l__Packet__2.String),
    _xf6572b5f33c564ab = l__Packet__2("_xdd04825d772bbdb3", l__Packet__2.String, l__Packet__2.Any),
    _xce117dc071f0657f = l__Packet__2("_x836649ac17174f74", l__Packet__2.String, l__Packet__2.Any),
    _x30fe2fdd1023f141 = l__Packet__2("_x7bcd70b3b0ca8910", l__Packet__2.String, l__Packet__2.Any),
    _x4dc83f2504cf2f57 = l__Packet__2("_xb9e155b6976c5b3f"),
    _xe61783d51fe09499 = l__Packet__2("_x4bbf014334919d9c", l__Packet__2.Any),
    _x8458a1cfd21149ba = l__Packet__2("_x002c19ae4b5a1c3c", l__Packet__2.String, l__Packet__2.NumberF32, l__Packet__2.NumberF32, l__Packet__2.Boolean8, l__Packet__2.NumberF32, l__Packet__2.Vector3F32, l__Packet__2.String, l__Packet__2.NumberU32, l__Packet__2.NumberU32),
    unreliablePackets = {
        _xedf0e52fe5242c34 = l__Packet__2("_x393baa013c7a6148", l__Packet__2.NumberF16),
        _x7ad20ae11b77256d = l__Packet__2("_x8371d86140cae339", l__Packet__2.Boolean8),
        _x03b97699d899b5d1 = l__Packet__2("_x4417cf43d8d21071", l__Packet__2.NumberF16, l__Packet__2.NumberF16),
        _x1d1745d6dbcc3ee7 = l__Packet__2("_xd585f3d7037d31b4", l__Packet__2.NumberF16),
        _x5b55b35800d88aa6 = l__Packet__2("_x5a980501d2754995", l__Packet__2.NumberF16, l__Packet__2.NumberF16),
        _x6f165cf1c8a4a502 = l__Packet__2("_x387751ff780111fc", l__Packet__2.Any),
        _x0b71847ea26b42a0 = l__Packet__2("_xcbe4709deb4284c7", l__Packet__2.Any),
        _xa2a67982acc88b27 = l__Packet__2("_xfba9aa478a3292c7", l__Packet__2.Any),
        _x2f1f30453b260ca6 = l__Packet__2("_x595c2f427f967cb7"),
        _x4fd12adee42ecc3e = l__Packet__2("_xffddc221dd51b7ea", l__Packet__2.Any),
        _x9e6c7370a3b25bd0 = l__Packet__2("_x8f79315dd18acfa6", l__Packet__2.Instance, l__Packet__2.Vector3F32, l__Packet__2.Vector3F32, l__Packet__2.Vector3F32, l__Packet__2.NumberF64, l__Packet__2.NumberU32),
        _xc5c849e156666c7d = l__Packet__2("_xbc58c214c4b2b09b", l__Packet__2.String, l__Packet__2.Vector3F32, l__Packet__2.NumberU32),
        _xdf1db5767df9f29a = l__Packet__2("_x8821d111ee209c26", l__Packet__2.String, l__Packet__2.Any, l__Packet__2.NumberU32)
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
    end);
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
    end);
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
