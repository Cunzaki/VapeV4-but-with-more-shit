-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.Holiday.LanternDecorator
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local v1 = {};
local u2 = require(l__ReplicatedStorage__1.Modules.Mince):GetFunction("GetLantern");
local u3 = {
    [0] = {
        meaning = "New Beginnings",
        description = "Fresh starts and potential are born from the yellow hues of dawn, just like the number 0. Its squared shape, like sturdy building blocks, signals a foundation for new adventures. The yellow color echoes the warmth of sunrise and the promise of new beginnings, while the square shape represents stability and grounding, suggesting a firm foundation for growth.",
        funFact = "In Chinese cosmology, the universe was born from a formless void, much like the shapeless potential of 0.",
        lantern = {
            color = "yellow",
            shape = "short and squared"
        }
    },
    [1] = {
        meaning = "First Place or Singlehood",
        description = "The number 1 signifies first place and victory, but also represents singlehood and independence. It reflects both success and solitude. The pure white color symbolizes clarity and singularity, while the round shape suggests completeness and wholeness, reflecting the self-sufficiency of individuality.",
        funFact = "November 11 is celebrated as Singles Day in China, acknowledging those who are single and embracing their individuality.",
        lantern = {
            color = "white",
            shape = "short and bulbous"
        }
    },
    [2] = {
        meaning = "Ease & Brightness",
        description = "The number 2 is considered auspicious in Chinese culture, homophonous with words for \'easy\' and \'bright\'. It symbolizes effortless progress and good fortune. The harmonious green color echoes balance and growth, while the long, ringed shape suggests interconnectedness and flowing energy, representing the effortless flow of good luck.",
        funFact = "People with the lucky number 2 enjoy close relationship with friends and they are good cooperationists.",
        lantern = {
            color = "green",
            shape = "long and ringed"
        }
    },
    [3] = {
        meaning = "Vitality",
        description = "The youthful energy of pink resonates with the vigor of number 3. The long, slender shape represents growth and dynamism, while the roundness signifies fullness and potential. The pink color embodies the youthful energy and vibrancy associated with the number 3.",
        funFact = "In Chinese mythology, the three-legged sunbird is a symbol of vitality and rebirth.",
        lantern = {
            color = "pink",
            shape = "long and round"
        }
    },
    [4] = {
        meaning = "Death",
        description = "The number 4 is considered inauspicious in Chinese culture, homophonous with the word for \'death\'. Many buildings lack a 4th floor due to this association. The black color reflects the mourning and negativity associated with death, while the sharp lines of the square shape further reinforce this association.",
        funFact = "Despite its negative connotations, some believe 4 can symbolize rebirth or a fresh start after overcoming challenges.",
        lantern = {
            color = "black",
            shape = "long and squared"
        }
    },
    [5] = {
        meaning = "Abundance & Harmony",
        description = "The number 5 represents both \'me\' and the five elements in Chinese philosophy. It symbolizes personal fulfillment and harmony within the universe. The rich purple color embodies abundance and prosperity, while the short, squished shape suggests a concentrated source of this abundance.",
        funFact = "The five-clawed dragon, a symbol of imperial power, has five claws, reflecting the association of 5 with the Emperor.",
        lantern = {
            color = "purple",
            shape = "short and squished"
        }
    },
    [6] = {
        meaning = "Smoothness & Success",
        description = "The number 6 sounds like \'smooth\' or \'slick\', signifying a smooth path to success in business and endeavors. The calming light blue color reflects auspiciousness and tranquility, while the balanced, grounded shape of the short rounded lanmtern suggests stability and success.",
        funFact = "Hexagons, representing the number 6, are frequently used in auspicious Chinese patterns due to their association with harmony and stability.",
        lantern = {
            color = "light blue",
            shape = "short and round"
        }
    },
    [7] = {
        meaning = "Relationship & Prosperity",
        description = "The number 7 sounds like \'even\' and \'arise\', implying balance and new beginnings in relationships. It can also be unlucky due to the \'ghost month\'. The passionate red color reflects the positive aspects of relationships, while the upward-pointing temple shape suggests growth and fulfillment.",
        funFact = "The Qixi Festival, also known as the Double Seventh Festival, celebrates love and romance, occurring on the 7th day of the 7th lunar month.",
        lantern = {
            color = "red",
            shape = "long and temple shaped"
        }
    },
    [8] = {
        meaning = "Prosperity & Double Joy",
        description = "The number 8 sounds like \'prosper\' and visually resembles the double joy symbol. It\'s a highly auspicious number symbolizing wealth and good fortune. The gold color directly represents wealth and prosperity, while the multifaceted diamond shape suggests potential and progress.",
        funFact = "The number 8 is often used in license plates and phone numbers due to its lucky connotations.",
        lantern = {
            color = "yellow",
            shape = "long and diamonded"
        }
    },
    [9] = {
        meaning = "Longevity & Imperial Power",
        description = "The number 9 was historically associated with the Emperor, symbolizing longevity and imperial power. It also sounds like \'long lasting\', making it popular in weddings. The vibrant orange color reflects the fullness and abundance associated with longevity, while the bulbous shape further emphasizes this notion.",
        funFact = "The Great Wall of China, originally built with nine strategically placed gates, reflects the historical significance of the number 9.",
        lantern = {
            color = "orange",
            shape = "long and bulbous"
        }
    }
};
local _ = {
    red = { "rbxassetid://16203056152", Color3.fromRGB(255, 87, 87) },
    pink = { "rbxassetid://16203547305", Color3.fromRGB(255, 117, 230) },
    yellow = { "rbxassetid://16203554140", Color3.fromRGB(255, 255, 133) },
    ["light blue"] = { "rbxassetid://16203609473", Color3.fromRGB(158, 245, 255) },
    ["dark blue"] = { "rbxassetid://16217365444", Color3.fromRGB(0, 13, 255) },
    green = { "rbxassetid://16203519456", Color3.fromRGB(128, 255, 82) },
    orange = { "rbxassetid://16217351986", Color3.fromRGB(255, 81, 0) },
    white = { "rbxassetid://16217320313", Color3.fromRGB(255, 255, 255) },
    black = { "rbxassetid://16217272456", Color3.fromRGB(255, 255, 255) },
    purple = { "rbxassetid://16217334843", Color3.fromRGB(197, 0, 197) }
};
function v1.Setup() --[[ Line: 114 ]] end;
function v1.CreateLantern(p4) --[[ Line: 118 ]]
    -- upvalues: u3 (copy), u2 (copy)
    local v5 = u3[p4];
    return u2.Invoke(v5), v5;
end;
function v1.FilterText(p6) --[[ Line: 126 ]]
    return tonumber(p6:sub(1, 1));
end;
return v1;
