-- Decompiled from: ReplicatedStorage.Modules.BaseX
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local u1 = nil;
local v11 = {
    __call = function(_, p2) --[[ Name: __call, Line 53 ]]
        -- upvalues: u1 (ref)
        local v3 = #p2;
        local v4 = p2:sub(1, 1);
        local v5 = {};
        for v6 = 1, v3 do
            v5[p2:sub(v6, v6)] = v6 - 1;
        end;
        return setmetatable({
            alphabet = p2,
            base = v3,
            leader = v4,
            alphabet_map = v5
        }, u1);
    end,
    __index = function(p7, p8) --[[ Name: __index, Line 69 ]]
        local v9 = p7.alphabets[p8:upper()];
        if not v9 then
            return nil;
        end;
        local v10 = p7(v9);
        p7[p8] = v10;
        return v10;
    end
};
u1 = {
    __index = {
        encode = function(p12, p13, p14) --[[ Name: encode, Line 81 ]]
            if #p13 == 0 then
                return "";
            end;
            local v15 = { 0 };
            for v16 = 1, #p13 do
                local v17 = p13:byte(v16, v16);
                for v18 = 1, #v15 do
                    local v19 = v17 + v15[v18] * 256;
                    v15[v18] = v19 % p12.base;
                    v17 = math.floor(v19 / p12.base);
                end;
                while v17 > 0 do
                    table.insert(v15, v17 % p12.base);
                    v17 = math.floor(v17 / p12.base);
                    if p14 then
                        p14();
                    end;
                end;
            end;
            for v20 = 1, #p13 - 1 do
                if p13:byte(v20, v20) ~= 0 then
                    break;
                end;
                table.insert(v15, 0);
            end;
            local v21 = #v15;
            local v22 = 1;
            while true do
                local v23 = p12.alphabet:sub(v15[v22] + 1, v15[v22] + 1);
                v15[v22] = p12.alphabet:sub(v15[v21] + 1, v15[v21] + 1);
                v15[v21] = v23;
                v22 = v22 + 1;
                v21 = v21 - 1;
                if v21 < v22 then
                    break;
                end;
                if p14 then
                    p14();
                end;
            end;
            return table.concat(v15);
        end,
        decode = function(p24, p25) --[[ Name: decode, Line 123 ]]
            if #p25 == 0 then
                return "";
            end;
            local v26 = { 0 };
            for v27 = 1, #p25 do
                local v28 = p24.alphabet_map[p25:sub(v27, v27)];
                if v28 == nil then
                    return nil, "Non-base" .. p24.base .. " character";
                end;
                for v29 = 1, #v26 do
                    local v30 = v28 + v26[v29] * p24.base;
                    v26[v29] = v30 % 256;
                    v28 = math.floor(v30 / 256);
                end;
                while v28 > 0 do
                    table.insert(v26, v28 % 256);
                    v28 = math.floor(v28 / 256);
                end;
            end;
            for v31 = 1, #p25 - 1 do
                if p25:sub(v31, v31) ~= p24.leader then
                    break;
                end;
                table.insert(v26, 0);
            end;
            local v32 = "";
            for v33 = #v26, 1, -1 do
                v32 = v32 .. string.char(v26[v33]);
            end;
            return v32;
        end
    }
};
return setmetatable({
    _VERSION = "0.2.0",
    _URL = "https://github.com/un-def/lua-basex",
    _DESCRIPTION = "Base encoding/decoding of any given alphabet using bitcoin style leading zero compression",
    _LICENSE = "    Copyright (c) 2016-2017, un.def\n    All rights reserved.\n\n    Redistribution and use in source and binary forms, with or without\n    modification, are permitted provided that the following conditions are met:\n\n     * Redistributions of source code must retain the above copyright notice,\n       this list of conditions and the following disclaimer.\n     * Redistributions in binary form must reproduce the above copyright\n       notice, this list of conditions and the following disclaimer in the\n       documentation and/or other materials provided with the distribution.\n\n    THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS\'\' AND ANY\n    EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED\n    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE\n    DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY\n    DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES\n    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR\n    SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER\n    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT\n    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY\n    OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH\n    DAMAGE.\n  ",
    alphabets = {
        BASE16LOWER = "0123456789abcdef",
        BASE16UPPER = "0123456789ABCDEF",
        BASE58BITCOIN = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz",
        BASE58FLICKR = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ",
        BASE58RIPPLE = "rpshnaf39wBUDNEGHJKLM4PQRST7VWXYZ2bcdeCg65jkm8oFqi1tuvAxyz",
        DISCORD = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!$%&()+,./:;<=?@^{|}\"",
        DISCORDZ = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!$%&()+,./:;<=?@^{|}€‚ƒ„…†‡ˆ\"‰Š‹ŒŽ‘’“”•–—˜™š›œžŸ¡¢£¤¥¦§¨©ª«¬®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ",
        BASE91 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,./:;<=>?@[]^_`{|}~\""
    }
}, v11);
