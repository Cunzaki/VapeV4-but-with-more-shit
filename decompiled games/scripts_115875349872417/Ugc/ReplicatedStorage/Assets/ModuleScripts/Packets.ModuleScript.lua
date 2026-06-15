-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__Packet__2 = require(script.Packet);
local l__CheckServerPredicate__3 = l__Packet__2.CheckServerPredicate;
local v1 = {
    _x42bf71a00fad346c = l__Packet__2("_x919d9c74ce9022ac", l__Packet__2.Any),
    _xa5cd30aff568ab2b = l__Packet__2("_x1c34ecda2f112e6f", l__Packet__2.Any),
    _x5f5c9057d57f77dd = l__Packet__2("_x17580f99bb48c3fa", l__Packet__2.Any),
    _xc2915548d25f77de = l__Packet__2("_x52f61523c2e48a40", l__Packet__2.Any),
    _x5885ef99bde095ee = l__Packet__2("_x9dff0787a27fc66a", l__Packet__2.Any),
    _x0c8d775997f65b04 = l__Packet__2("_xf67bbc2c670e45ae"):Response(l__Packet__2.Any),
    _xfbbac22bb38ae8fe = l__Packet__2("_x3c40098c7f491902", l__Packet__2.Any),
    _xec69a99c4f5069c4 = l__Packet__2("_xe388a6cb8b90f05b", l__Packet__2.Any),
    _x547c4b3f346ef6af = l__Packet__2("_x6fa0415402579bb6", l__Packet__2.String, l__Packet__2.String, l__Packet__2.String):Response(l__Packet__2.Any),
    _x1761e6dc6421b5f7 = l__Packet__2("_x15b1d5280e260c58", l__Packet__2.String),
    _x7f478f00464c302e = l__Packet__2("_x95f7a6ae4d1965c2", l__Packet__2.String),
    _xd0d2e4f16cf63974 = l__Packet__2("_x05cf9a2387c252e3", l__Packet__2.Any),
    _x0f49793f47f60a2c = l__Packet__2("_x75c37391695182e3", l__Packet__2.String, l__Packet__2.String, l__Packet__2.NumberU16),
    _x824a8e00e0e79453 = l__Packet__2("_x092323febcd7dae9", l__Packet__2.String, l__Packet__2.String):Response(l__Packet__2.Boolean8),
    _x1d57a7bcf03e08b2 = l__Packet__2("_x4118529727d7ee32", l__Packet__2.String, l__Packet__2.String),
    _x98954753694fb517 = l__Packet__2("_x8e39922151b9fcd7", l__Packet__2.String, l__Packet__2.String):Response(l__Packet__2.Any),
    _xef0b2277203c2e18 = l__Packet__2("_x684d0c46cedecbed", l__Packet__2.Any):Response(l__Packet__2.Any),
    _x0718de96fcdbb2cb = l__Packet__2("_x8bdef99c67d68c3a", l__Packet__2.String, l__Packet__2.NumberU16),
    _x15f77d251c70b496 = l__Packet__2("_x35a175bb424210b5", l__Packet__2.Any),
    _xcc00a7b482c2657e = l__Packet__2("_x93d405e8854024d6", l__Packet__2.NumberF32),
    _xec7b9f860192098d = l__Packet__2("_x68e7dd7bea6e8485", l__Packet__2.Any),
    _x03d52885f4243bb6 = l__Packet__2("_x1578c941ad54e3d7", l__Packet__2.Any),
    _x9658205c9f5878a1 = l__Packet__2("_x79ce76fafbbc5beb", l__Packet__2.Any),
    _x50812052ce1094fd = l__Packet__2("_x9302c5bb254900ad", l__Packet__2.Any),
    _x3c371686e12243c1 = l__Packet__2("_x2828aaea48c37bd2", l__Packet__2.Any),
    _x01d1e6369b1ddabb = l__Packet__2("_x303236fe52ef1a4a"),
    _xe19bd04b1425e9fa = l__Packet__2("_xa25f9b42311bfbb2"):Response(l__Packet__2.Boolean8, l__Packet__2.Any),
    _xd62c578b7c77d170 = l__Packet__2("_xf8893e1bdccd0f12"),
    _xafbba193769c2d04 = l__Packet__2("_xba2bc6de11dc1191", l__Packet__2.String, l__Packet__2.String):Response(l__Packet__2.Any),
    _x8578682308584ad6 = l__Packet__2("_xaeb3e46233126fb0", l__Packet__2.String, l__Packet__2.Any):Response(l__Packet__2.Boolean8),
    _xefd6d8e74acc7f88 = l__Packet__2("_xd3a9b5cfeb13442b", l__Packet__2.String, l__Packet__2.Vector3F32, l__Packet__2.Vector3F32, l__Packet__2.String),
    _x0ecb2c7d58d87f7c = l__Packet__2("_xef7bb4a65238ad1e", l__Packet__2.String, l__Packet__2.Vector3F32, l__Packet__2.Vector3F32, l__Packet__2.Any, l__Packet__2.String),
    _xcbe604ff7aa7a075 = l__Packet__2("_xf240b19b6c8c6a58", l__Packet__2.Any),
    _xbddb58201adb89be = l__Packet__2("_x26112cb1484cfc98", l__Packet__2.Any),
    _xf7747bc86b651d7a = l__Packet__2("_x08c3165a66f27068", l__Packet__2.Any),
    _xa873db53beaadf6d = l__Packet__2("_x59c7d5d4cbba8614", l__Packet__2.String, l__Packet__2.Any),
    _x53c55d919490b907 = l__Packet__2("_x486cb608d4fb27fb", l__Packet__2.Any),
    _xd107c8ee5ed343a1 = l__Packet__2("_x63f4d93765ce98fa", l__Packet__2.Any),
    _xb0f5f2d2d71ad910 = l__Packet__2("_xe9dc0f2e8e56893d", l__Packet__2.Any),
    _x743587ebef43dd00 = l__Packet__2("_x031f1b89e99a6ce0", l__Packet__2.Any),
    _x8571c4851a09df7a = l__Packet__2("_x4cfe2cb7e05eadad", l__Packet__2.String, l__Packet__2.String, l__Packet__2.String, { l__Packet__2.Any }),
    _x8af24abb93051b81 = l__Packet__2("_xa7cdb1b97d8fc0dc", l__Packet__2.String):Response(l__Packet__2.String),
    _x0cb8e1ed73d5a692 = l__Packet__2("_xc322bab754e02734", l__Packet__2.String),
    _x2e2c62e0acfc88ae = l__Packet__2("_xe6cbd0bf2a4cf278", l__Packet__2.String, l__Packet__2.String, l__Packet__2.String, l__Packet__2.Vector3F24, { l__Packet__2.Instance }, l__Packet__2.Any),
    _x4f650e8e91652cc9 = l__Packet__2("_xc299c790bf35fdba", l__Packet__2.String),
    _x2b80b9b0eee78387 = l__Packet__2("_xa19d33690c6be96a"),
    _x609f99d3a8520d69 = l__Packet__2("_xffad4ae250faa7b7"),
    _x65d117c21ab35208 = l__Packet__2("_xe3dea9911c7cff5e"),
    _x54d2d509e605e4a2 = l__Packet__2("_x53ec38f733365fe2"),
    _xfcd85354108f32c4 = l__Packet__2("_x15f57c1494457540", l__Packet__2.String),
    _xa85e9ac8b65618a4 = l__Packet__2("_xf0aa5b1f864057dd", l__Packet__2.Any, l__Packet__2.Any),
    _x1b62682bd6f16761 = l__Packet__2("_xaeb9987159329e4e", l__Packet__2.StringLong),
    _x471df2faea508528 = l__Packet__2("_xbf12de42ebe659fb", l__Packet__2.Any),
    _xb02950605ce4d2bc = l__Packet__2("_xca5ee8a72132f28d", l__Packet__2.Any),
    _x7b59efeaacc66e16 = l__Packet__2("_xf28a1a7bfeae6ba3", l__Packet__2.Any),
    _xfc3d3b5e71267fb1 = l__Packet__2("_x83e6d058d9ea2032", l__Packet__2.String, l__Packet__2.Any),
    _x68977eba95725f85 = l__Packet__2("_xdcbcba880d6e714c", l__Packet__2.String, l__Packet__2.Any),
    _x5962b203e0f968e5 = l__Packet__2("_x2dbf52a6ee4f085c"),
    _xd072640b833c43f6 = l__Packet__2("_x4f732dc6b1472def", l__Packet__2.Instance, l__Packet__2.Any),
    _x489d4e2c9b1db08e = l__Packet__2("_x031cb7e591e094b8", l__Packet__2.Instance),
    _xdce6104c079e4c66 = l__Packet__2("_x4f703ef07a417906", l__Packet__2.Instance, l__Packet__2.Any),
    _xfa0d0cdb5e28525c = l__Packet__2("_x54757c98b7c5c851"),
    _x1a76bdb4b5ac1626 = l__Packet__2("_x2e0ffc3f34acf065", l__Packet__2.Any),
    _x7988d8d64cb8f58e = l__Packet__2("_x0afbc2cceddfbfdc", l__Packet__2.Any, l__Packet__2.Any),
    _xdb2548bded1dd8e3 = l__Packet__2("_x13ace50f584b449e", l__Packet__2.NumberF16),
    _x803fb597e29aa8b8 = l__Packet__2("_x199506708c83768b", l__Packet__2.Any),
    _xbdf0cfbe82f87173 = l__Packet__2("_x0f929dd124532b4e", l__Packet__2.Any),
    _xfe276089fac8bc25 = l__Packet__2("_x4b787e53c07d0a44", l__Packet__2.Any),
    _x34754b6705aa3689 = l__Packet__2("_xa30ff6d3fa84cd83", l__Packet__2.Instance, l__Packet__2.Any),
    _x79961bff1a8a3f4c = l__Packet__2("_x8554b516e12fed1e", l__Packet__2.Instance, l__Packet__2.String),
    _xf29dcc6a78e136c2 = l__Packet__2("_x451287230edfc358", l__Packet__2.String, l__Packet__2.Instance, l__Packet__2.Any),
    _x0b2e7b7fe0af03fc = l__Packet__2("_x30241a03fd59ab44", l__Packet__2.String, l__Packet__2.Instance, l__Packet__2.Any),
    _x4c793ce9df8f8ba6 = l__Packet__2("_xcbd54bdc17f64acc", l__Packet__2.Any, l__Packet__2.Any),
    _xebecb58ecfa71a67 = l__Packet__2("_xaa14e34248ff8287", l__Packet__2.Boolean8, l__Packet__2.Any, l__Packet__2.String),
    _x6e9214eccf062dbf = l__Packet__2("_x269df06629253b4c", l__Packet__2.String, l__Packet__2.Any),
    _x8c8bc87c3fc21bf3 = l__Packet__2("_xa26a3767dd42809e", l__Packet__2.String, l__Packet__2.Any),
    _x6c88e4f6651dfa8e = l__Packet__2("_x0f9a651da920e2c4", l__Packet__2.String, l__Packet__2.Any),
    _xbbc4a0659c684667 = l__Packet__2("_x9ba74587123cc93a"),
    _x6058574c8f1e416c = l__Packet__2("_x555fdebd8d4fcc3c"):Response(l__Packet__2.Any),
    _x1e8f270f7b6f5329 = l__Packet__2("_xad3d043737dde5cb", l__Packet__2.Any),
    _xd280acb67659621a = l__Packet__2("_x2e0827961231eae1"),
    _xfc69375ed1634248 = l__Packet__2("_x3132e0407062f39b"),
    _x19f6b3e5d3e8ee74 = l__Packet__2("_x9ac2e3a744bf0390", l__Packet__2.Any),
    _x77a8b8d28b943359 = l__Packet__2("_xf3679e1e333be24e", l__Packet__2.String, l__Packet__2.NumberF32, l__Packet__2.NumberF32, l__Packet__2.Boolean8, l__Packet__2.NumberF32, l__Packet__2.Vector3F32, l__Packet__2.String, l__Packet__2.NumberU32, l__Packet__2.NumberU32),
    unreliablePackets = {
        _xb881b1d13c8068a4 = l__Packet__2("_x8089bd0b29a4721a", l__Packet__2.NumberF16),
        _x6e915d67a1f06f56 = l__Packet__2("_xfd4cdf41a5e210a4", l__Packet__2.Boolean8),
        _x6b11fde7f06edda2 = l__Packet__2("_xb4369a01ad7f2649", l__Packet__2.NumberF16, l__Packet__2.NumberF16),
        _xb6e64d336fe43aa7 = l__Packet__2("_xd74607f93e6bbc30", l__Packet__2.NumberF16),
        _xbd2cb2a1aa5e781f = l__Packet__2("_x83eef369b6a97869", l__Packet__2.NumberF16, l__Packet__2.NumberF16),
        _x8e4db6c83cd1f1b6 = l__Packet__2("_xae026e9685d1af54", l__Packet__2.Any),
        _xe68977d6b045970c = l__Packet__2("_xf22356325f4d21b5", l__Packet__2.Any),
        _x4139fa5f31e80cc1 = l__Packet__2("_x3fa7e4034868788d", l__Packet__2.Any),
        _x577c1497904bf674 = l__Packet__2("_x3a0df71a7a6fb917"),
        _x969b1629861a7499 = l__Packet__2("_x3c64dc11aba41ccd", l__Packet__2.Any),
        _x708f07fc0d0b370b = l__Packet__2("_xcf751cf0990cc503", l__Packet__2.Instance, l__Packet__2.Vector3F32, l__Packet__2.Vector3F32, l__Packet__2.Vector3F32, l__Packet__2.NumberF64, l__Packet__2.NumberU32),
        _x47fd55153a58f398 = l__Packet__2("_xe4a03306edfd0636", l__Packet__2.String, l__Packet__2.Vector3F32, l__Packet__2.NumberU32),
        _xccd26d6aa027d1d5 = l__Packet__2("_x845abf67a240bf3c", l__Packet__2.String, l__Packet__2.Any, l__Packet__2.NumberU32)
    }
};
local function v10(u2) --[[ Line: 210 ]]
    -- upvalues: l__CheckServerPredicate__3 (copy), l__RunService__1 (copy)
    local u3 = Instance.new("UnreliableRemoteEvent");
    u3.Name = u2.Name;
    u3.Parent = script;
    u3.OnServerEvent:Connect(function(p4, ...) --[[ Line: 214 ]]
        -- upvalues: u2 (copy), l__CheckServerPredicate__3 (ref), l__RunService__1 (ref)
        local v5, v6 = pcall(function(...) --[[ Line: 215 ]]
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
    function u2.Fire(p7, ...) --[[ Line: 232 ]]
        -- upvalues: u3 (copy)
        u3:FireAllClients(p7:Serialize(...));
    end;
    function u2.FireClient(p8, p9, ...) --[[ Line: 236 ]]
        -- upvalues: u3 (copy)
        u3:FireClient(p9, p8:Serialize(...));
    end;
end;
local function v14(u11) --[[ Line: 241 ]]
    local u12 = script:WaitForChild(u11.Name);
    u12.OnClientEvent:Connect(function(...) --[[ Line: 243 ]]
        -- upvalues: u11 (copy)
        u11.OnClientEvent:Fire(u11:Deserialize(...));
    end);
    function u11.Fire(p13, ...) --[[ Line: 247 ]]
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