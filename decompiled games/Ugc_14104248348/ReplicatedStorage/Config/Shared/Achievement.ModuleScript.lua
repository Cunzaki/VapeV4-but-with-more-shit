-- Decompiled from: ReplicatedStorage.Config.Shared.Achievement
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

return {
    Groups = {
        Pre = {
            Order = 1,
            Color = Color3.new(0, 0.517647, 1)
        },
        Easy = {
            Order = 5,
            Color = Color3.new(0.0509804, 1, 0)
        },
        Medium = {
            Order = 8,
            Color = Color3.new(1, 0.54902, 0)
        },
        Hard = {
            Order = 10,
            Color = Color3.new(1, 0, 0)
        },
        Extreme = {
            Order = 11,
            Color = Color3.new(0.54902, 0, 1)
        }
    },
    Items = {
        {
            ID = "HALLO_ZOMBIE_1",
            Name = "Strong Zombie Disliker",
            Description = "Kill 5 Zombies",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 100
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    ENEMY_KILLED_ZOMBIEH25 = 5
                }
            }
        },
        {
            ID = "HALLO_ZOMBIE_2",
            Name = "Zombie Hunter",
            Description = "Kill 25 Zombies",
            Group = "Medium",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 500
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    ENEMY_KILLED_ZOMBIEH25 = 25
                }
            }
        },
        {
            ID = "HALLO_ZOMBIE_3",
            Name = "Zombie\'s Worst Nightmare",
            Description = "Kill 50 Zombies",
            Group = "Hard",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 1000
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    ENEMY_KILLED_ZOMBIEH25 = 50
                }
            }
        },
        {
            ID = "HALLO_ZOMBIE_4",
            Name = "Leave Them Zombies Alone!",
            Description = "Kill 150 Zombies",
            Group = "Extreme",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 2000
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    ENEMY_KILLED_ZOMBIEH25 = 150
                }
            }
        },
        {
            ID = "UNDERWATRER",
            Name = "Secret Undawata",
            Description = "Visit the underwater cave",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 50
                }
            },
            Requirements = {
                Type = "InsecureClientTrigger",
                Key = "Underwater"
            }
        },
        {
            ID = "WITCHHUT",
            Name = "Witches Hut",
            Description = "Visit the Witches Hut.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 50
                }
            },
            Requirements = {
                Type = "InsecureClientTrigger",
                Key = "Witch"
            }
        },
        {
            ID = "TRIVIA",
            Name = "Umm ackshually...",
            Description = "Get 5 questions right in trivia.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 100
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    CorrectTriviaAnswers = 5
                }
            }
        },
        {
            ID = "TRIVIAJOIN",
            Name = "Trivia",
            Description = "Visit Poly\'s Trivia",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 5
                }
            },
            Requirements = {
                Type = "InsecureClientTrigger",
                Key = "Trivia"
            }
        },
        {
            ID = "VISITZOWIE",
            Name = "Cuppa joe",
            Description = "Visit Zowie\'s cafe",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 5
                }
            },
            Requirements = {
                Type = "InsecureClientTrigger",
                Key = "Zowie"
            }
        },
        {
            ID = "VISITLOFT",
            Name = "The Loft",
            Description = "Visit Anchor Loft",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 5
                }
            },
            Requirements = {
                Type = "InsecureClientTrigger",
                Key = "Loft"
            }
        },
        {
            ID = "VISITSEWER",
            Name = "It stinks in here.",
            Description = "Visit the Sewer",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 5
                }
            },
            Requirements = {
                Type = "InsecureClientTrigger",
                Key = "Sewer"
            }
        },
        {
            ID = "VISITWHIM",
            Name = "Whim and Co",
            Description = "Visit Whim and co",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 5
                }
            },
            Requirements = {
                Type = "InsecureClientTrigger",
                Key = "Whim"
            }
        },
        {
            ID = "VISITINTYTSTORE",
            Name = "NT Store",
            Description = "Visit NT Store",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 5
                }
            },
            Requirements = {
                Type = "InsecureClientTrigger",
                Key = "IntyStore"
            }
        },
        {
            ID = "FIRE",
            Name = "Whoops!",
            Description = "Take a step into the flames...",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 5
                }
            },
            Requirements = {
                Type = "InsecureClientTrigger",
                Key = "Fire"
            }
        },
        {
            ID = "APPTMENT",
            Name = "Butterz was here!",
            Description = "Visit Intykat\'s secret out of bounds appartment",
            Group = "Hard",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 10
                }
            },
            Requirements = {
                Type = "InsecureClientTrigger",
                Key = "Inty"
            }
        },
        {
            ID = "VISITRIG",
            Name = "RIG",
            Description = "Meet Rig...",
            Group = "Medium",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 5
                }
            },
            Requirements = {
                Type = "InsecureClientTrigger",
                Key = "Dummy"
            }
        },
        {
            ID = "MC",
            Name = "BLOCK HOUSE",
            Description = "Visit the grave of that \'game\'... because you know copyright infringment?.",
            Group = "Hard",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 10
                }
            },
            Requirements = {
                Type = "InsecureClientTrigger",
                Key = "Mc"
            }
        },
        {
            ID = "LootboxesOpened_1",
            Name = "popa needs a new pair of shoes..",
            Description = "Open 1 lootbox.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 10
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    Total_Opened_Lootboxes = 1
                }
            }
        },
        {
            ID = "LootboxesOpened_2",
            Name = "Just one more...",
            Description = "Open 10 lootbox(s).",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 300
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    Total_Opened_Lootboxes = 10
                }
            }
        },
        {
            ID = "LootboxesOpened_3",
            Name = "gamble addict",
            Description = "Open 50 lootbox(s).",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 1000
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    Total_Opened_Lootboxes = 50
                }
            }
        },
        {
            ID = "ItemsBought_1",
            Name = "First Purchase",
            Description = "Buy 1 item.",
            Group = "Pre",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 100
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    ItemsBought = 1
                }
            }
        },
        {
            ID = "ItemsBought_2",
            Name = "Shopping Spree",
            Description = "Buy 10 items.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 500
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    ItemsBought = 10
                }
            }
        },
        {
            ID = "ItemsBought_3",
            Name = "Materialist",
            Description = "Buy 50 items.",
            Group = "Medium",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 1000
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    ItemsBought = 50
                }
            }
        },
        {
            ID = "CanvasBought_1",
            Name = "Aspiring Artist",
            Description = "Buy 1 canvas.",
            Group = "Pre",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 100
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    CanvasBought = 1
                }
            }
        },
        {
            ID = "CanvasBought_2",
            Name = "Dedicated Creator",
            Description = "Buy 10 canvases.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 250
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    CanvasBought = 10
                }
            }
        },
        {
            ID = "CanvasBought_3",
            Name = "Master Painter",
            Description = "Buy 25 canvases.",
            Group = "Medium",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 500
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    CanvasBought = 25
                }
            }
        },
        {
            ID = "DRINK_DRANK_1",
            Name = "I don\'t feel too good...",
            Description = "Drink 1 drink(s).",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 5
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    DrinksDrank = 1
                }
            }
        },
        {
            ID = "DRINK_DRANK_1.5",
            Name = "Jr Drinker",
            Description = "Drink 10 drink(s).",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 5
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    DrinksDrank = 10
                }
            }
        },
        {
            ID = "DRINK_DRANK_2",
            Name = "Yummy!",
            Description = "Drink 50 drink(s).",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 10
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    DrinksDrank = 50
                }
            }
        },
        {
            ID = "DRINK_DRANK_3",
            Name = "I am thirsty.",
            Description = "Drink 300 drink(s).",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 25
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    DrinksDrank = 300
                }
            }
        },
        {
            ID = "DRINK_DRANK_4",
            Name = "Master drinker",
            Description = "Drink 2500 drink(s).",
            Group = "Medium",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 250
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    DrinksDrank = 2500
                }
            }
        },
        {
            ID = "DRINK_DRANK_5",
            Name = "I am a whale.",
            Description = "Drink 5000 drink(s).",
            Group = "Hard",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 1000
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    DrinksDrank = 5000
                }
            }
        },
        {
            ID = "DRINK_DRANK_6",
            Name = "The Watery Grave",
            Description = "Drink 10000 drink(s).",
            Group = "Extreme",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 2000
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    DrinksDrank = 10000
                }
            }
        },
        {
            ID = "CHECKERSWIN",
            Name = "Crowned!",
            Description = "Win a game of checkers.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 25
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    CheckersGamesWon = 1
                }
            }
        },
        {
            ID = "CHECKERSTIE",
            Name = "Fair play!",
            Description = "Tie a game of checkers.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 25
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    CheckersGamesTied = 1
                }
            }
        },
        {
            ID = "CHESSWIN",
            Name = "Checkmate!",
            Description = "Win a game of chess.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 25
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    ChessGamesWon = 1
                }
            }
        },
        {
            ID = "CHESSTIE",
            Name = "Stalemate!",
            Description = "Tie a game of chess.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 25
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    ChessGamesTied = 1
                }
            }
        },
        {
            ID = "DDRWIN",
            Name = "Dancer",
            Description = "Win a game of Rhythm.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 25
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    DDRGamesWon = 1
                }
            }
        },
        {
            ID = "TICTACTOEWIN",
            Name = "Logical",
            Description = "Win a game of tic tac toe.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 25
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    TicTacToeGamesWon = 1
                }
            }
        },
        {
            ID = "TICTACTOETIE",
            Name = "CAT!",
            Description = "Tie a game of tic tac toe.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 25
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    TicTacToeGamesTied = 1
                }
            }
        },
        {
            ID = "4ROWWIN",
            Name = "I win!",
            Description = "Win a game of 4 Row.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 25
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    ["4RowGamesWon"] = 1
                }
            }
        },
        {
            ID = "ARMWRESTLINGWIN",
            Name = "Rahhhh",
            Description = "Win a game of arm wrestling.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 25
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    ArmWrestlingGamesWon = 1
                }
            }
        },
        {
            ID = "TICTACTOE50",
            Name = "Committed",
            Description = "Place 50 pieces in tic tac toe.",
            Group = "Medium",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 50
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    TicTacToePieces = 50
                }
            }
        },
        {
            ID = "PUNCH850",
            Name = "Angry",
            Description = "Get an accumulative score of over 850 in a punching machine.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 25
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    PunchScore = 850
                }
            }
        },
        {
            ID = "PUNCH100K",
            Name = "Agressive",
            Description = "Get an accumulative score of over 100k in a punching machine.",
            Group = "Medium",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 1000
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    PunchScore = 100000
                }
            }
        },
        {
            ID = "PUNCH500K",
            Name = "Outraged",
            Description = "Get an accumulative score of over 500k in a punching machine.",
            Group = "Hard",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 2500
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    PunchScore = 500000
                }
            }
        },
        {
            ID = "PUNCH1M",
            Name = "Fuming",
            Description = "Get an accumulative score of over 1M in a punching machine.",
            Group = "Hard",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 5000
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    PunchScore = 1000000
                }
            }
        },
        {
            ID = "GAMESPLAYED_1",
            Name = "Game Addict",
            Description = "Play 10 games of any kind.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 25
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    GamesPlayed = 10
                }
            }
        },
        {
            ID = "GAMESPLAYED_2",
            Name = "Competitive",
            Description = "Play 50 games of any kind.",
            Group = "Medium",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 150
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    GamesPlayed = 50
                }
            }
        },
        {
            ID = "GAMESPLAYED_3",
            Name = "A True Gamer",
            Description = "Play 100 games of any kind.",
            Group = "Hard",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 500
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    GamesPlayed = 100
                }
            }
        },
        {
            ID = "MinigamesWon_1",
            Name = "Minigame Maestro",
            Description = "Win 10 minigames.",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 50
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    MinigamesWon = 10
                }
            }
        },
        {
            ID = "MinigamesWon_2",
            Name = "Jack of All Games",
            Description = "Win 50 minigames.",
            Group = "Medium",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 250
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    MinigamesWon = 50
                }
            }
        },
        {
            ID = "MinigamesWon_3",
            Name = "Tournament Champion",
            Description = "Win 200 minigames.",
            Group = "Hard",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 1000
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    MinigamesWon = 200
                }
            }
        },
        {
            ID = "PlayersMegaPunched_1",
            Name = "shaa-blamo",
            Description = "Using a fight tool, mega punch 1 player(s)",
            Group = "Pre",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 5
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    PlayersMegaPunched = 1
                }
            }
        },
        {
            ID = "PlayersMegaPunched_2",
            Name = "Get outta here!",
            Description = "Using a fight tool, mega punch 10 player(s)",
            Group = "Medium",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 100
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    PlayersMegaPunched = 10
                }
            }
        },
        {
            ID = "PlayersMegaPunched_3",
            Name = "omega punch",
            Description = "Using a fight tool, mega punch 50 player(s)",
            Group = "Medium",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 500
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    PlayersMegaPunched = 50
                }
            }
        },
        {
            ID = "PlayersSuperPunched_1",
            Name = "That felt good...",
            Description = "Using a fight tool, super punch 1 player(s)",
            Group = "Pre",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 5
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    PlayersSuperPunched = 1
                }
            }
        },
        {
            ID = "PlayersSuperPunched_2",
            Name = "Lethal Weapon",
            Description = "Using a fight tool, super punch 10 player(s)",
            Group = "Medium",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 50
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    PlayersSuperPunched = 10
                }
            }
        },
        {
            ID = "PlayersSuperPunched_3",
            Name = "BAM! BAM! BAM!",
            Description = "Using a fight tool, super punch 50 player(s)",
            Group = "Medium",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 100
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    PlayersSuperPunched = 10
                }
            }
        },
        {
            ID = "PlayersPunched_1",
            Name = "Take That!",
            Description = "Using a fight tool, punch 1 player(s)",
            Group = "Pre",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 5
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    PlayersPunched = 1
                }
            }
        },
        {
            ID = "PlayersPunched_3",
            Name = "Certified Bully",
            Description = "Using a fight tool, punch 25 player(s)",
            Group = "Easy",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 25
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    PlayersPunched = 25
                }
            }
        },
        {
            ID = "PlayersPunched_4",
            Name = "Street Fighter",
            Description = "Using a fight tool, punch 100 player(s)",
            Group = "Medium",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 100
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    PlayersPunched = 100
                }
            }
        },
        {
            ID = "PlayersPunched_5",
            Name = "The One Punch Man",
            Description = "Using a fight tool, punch 500 player(s)",
            Group = "Hard",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 250
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    PlayersPunched = 500
                }
            }
        },
        {
            ID = "PlayersPunched_6",
            Name = "Trained Killer",
            Description = "Using a fight tool, punch 2000 player(s)",
            Group = "Extreme",
            Rewards = {
                {
                    Type = "Coins",
                    Value = 1000
                }
            },
            Requirements = {
                Type = "Statistic",
                Data = {
                    PlayersPunched = 2000
                }
            }
        }
    }
};
