-- Decompiled from: ReplicatedStorage.Client.Source.Gameplay.MinigameHandler.Components.Chess
-- Class: ModuleScript
-- Place: Ugc (14104248348)

-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local l__CurrentCamera__2 = workspace.CurrentCamera;
local u1 = l__LocalPlayer__1:GetMouse();
game:GetService("Debris");
local l__TweenService__3 = game:GetService("TweenService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__UserInputService__5 = game:GetService("UserInputService");
local l__Chess__6 = l__ReplicatedStorage__4.Assets.Minigame.Chess;
local l__RunService__7 = game:GetService("RunService");
local l__Mince__8 = require(l__ReplicatedStorage__4.Modules.Mince);
local u2 = l__Mince__8:Get("BindManager");
local u3 = l__Mince__8:Get("SoundHandler");
local u4 = l__Mince__8:Get("SelectInteractor");
local u5 = l__Mince__8:Get("InterfaceHandler");
local v6 = {
    King = nil,
    Check = false,
    CanPlay = false,
    Client = {},
    BlockedSpots = {}
};
local u7 = Color3.fromRGB(85, 255, 0);
local u8 = Color3.fromRGB(255, 0, 0);
local u9 = TweenInfo.new(0.1);
local u10 = {
    {
        Name = "White",
        End = "8",
        Flip = false,
        Color = Color3.fromRGB(255, 255, 255),
        Roster = l__Chess__6.Roster
    },
    {
        Name = "Black",
        End = "1",
        Flip = true,
        Color = Color3.fromRGB(50, 50, 50),
        Roster = l__Chess__6.Roster
    }
};
function v6.FindChipFromLocation(p11, p12, p13) --[[ Line: 112 ]]
    for _, v14 in p11.Instance.Chips:GetChildren() do
        if v14:GetAttribute("Location") == `{p12},{p13}` then
            return v14;
        end;
    end;
end;
function v6.GetChipFromName(p15, p16) --[[ Line: 122 ]]
    return p15.Instance.Chips:FindFirstChild(p16);
end;
function v6.Construct(p17) --[[ Line: 126 ]]
    -- upvalues: u5 (copy)
    for _, v18 in p17.Instance.Players:GetChildren() do
        if v18:IsA("Seat") then
            p17:AddSeatJoinSource(v18, (tonumber(v18.Name)));
        else
            p17:AddProximityJoinSource(v18:WaitForChild("Position"), (tonumber(v18.Name)));
        end;
    end;
    local v19 = u5.GetScreenGui("Chess");
    local l__Spots__9 = p17.Instance.Board.Spots;
    local _ = p17.Instance.Chips;
    local v20 = l__Spots__9["1"]["1"];
    p17.RaycastWhitelist = RaycastParams.new();
    p17.RaycastWhitelist.FilterDescendantsInstances = l__Spots__9:GetChildren();
    p17.RaycastWhitelist.FilterType = Enum.RaycastFilterType.Include;
    p17.Highlight = script.Highlight;
    p17.DefaultHeight = v20.Position.Y;
    p17.Spots = l__Spots__9;
    p17.Gui = v19;
end;
function v6.GetSpotFromLocation(p21, p22, p23) --[[ Line: 154 ]]
    local v24 = p21.Spots:FindFirstChild(p22);
    if v24 then
        return v24:FindFirstChild(p23);
    end;
end;
function v6.GetSpotFromPiece(p25, p26) --[[ Line: 162 ]]
    if not p26 then
        return nil;
    end;
    local v27 = string.split(p26:GetAttribute("Location"), ",");
    return p25:GetSpotFromLocation(v27[1], v27[2]);
end;
function v6.GetPieceType(_, p28) --[[ Line: 171 ]]
    if p28 then
        p28 = p28.Name:match("_(%a)_");
    end;
    return p28;
end;
function v6.GetPieceColor(_, p29) --[[ Line: 175 ]]
    if p29 then
        p29 = p29.Name:match("(%a+)_");
    end;
    return p29;
end;
function v6.ParsePieceLocation(_, p30) --[[ Line: 179 ]]
    local v31 = string.split(p30:GetAttribute("Location"), ",");
    return tonumber(v31[1]), tonumber(v31[2]);
end;
function v6.GetPieceAtSpot(p32, p33) --[[ Line: 184 ]]
    if not p33 then
        return nil;
    end;
    local v34 = p32:FindChipFromLocation(tonumber(p33.Parent.Name), (tonumber(p33.Name)));
    if v34 then
        return v34;
    end;
    local v35 = p33:GetAttribute("OccupiedBy");
    if v35 then
        return p32:GetChipFromName(v35);
    end;
end;
function v6.IsEnemyPiece(p36, p37, p38) --[[ Line: 203 ]]
    if p37 and p38 then
        return p36:GetPieceColor(p37) ~= p36:GetPieceColor(p38);
    else
        return false;
    end;
end;
function v6.IsFriendlyPiece(p39, p40, p41) --[[ Line: 211 ]]
    if p40 and p41 then
        return p39:GetPieceColor(p40) == p39:GetPieceColor(p41);
    else
        return false;
    end;
end;
function v6.AddMoveIfValid(p42, p43, p44, p45, p46) --[[ Line: 219 ]]
    local v47 = p42:GetSpotFromLocation(p45, p46);
    if not v47 then
        return false;
    end;
    local v48 = p42:GetPieceAtSpot(v47);
    if not v48 then
        p44[v47] = true;
        return true;
    end;
    if p42:IsFriendlyPiece(p43, v48) then
        return false;
    end;
    if p42:GetPieceType(v48) == "K" then
        return false;
    end;
    p44[v47] = v48;
    return false;
end;
function v6.AddSlidingMoves(p49, p50, p51, p52, p53, p54) --[[ Line: 247 ]]
    for _, v55 in p54 do
        local v56 = p52 + v55[1];
        local v57 = p53 + v55[2];
        while true do
            local v58 = p49:GetSpotFromLocation(v56, v57);
            if not v58 then
                break;
            end;
            local v59 = p49:GetPieceAtSpot(v58);
            if v59 then
                if p49:IsEnemyPiece(p50, v59) and p49:GetPieceType(v59) ~= "K" then
                    p51[v58] = v59;
                end;
                break;
            end;
            p51[v58] = true;
            v56 = v56 + v55[1];
            v57 = v57 + v55[2];
        end;
    end;
end;
function v6.IsWithinBoard(_, p60, p61) --[[ Line: 276 ]]
    local v62;
    if p60 >= 1 and (p60 <= 8 and p61 >= 1) then
        v62 = p61 <= 8;
    else
        v62 = false;
    end;
    return v62;
end;
function v6.GetEnPassantState(p63) --[[ Line: 280 ]]
    local v64 = p63.Instance:GetAttribute("EnPassantTarget");
    local v65 = p63.Instance:GetAttribute("EnPassantPawn");
    if not (v64 and v65) then
        return nil;
    end;
    local v66 = p63:GetChipFromName(v65);
    return v66 and {
        TargetLocation = v64,
        Pawn = v66
    } or nil;
end;
function v6.GetEnPassantMoveData(p67, p68, p69) --[[ Line: 299 ]]
    if p67:GetPieceType(p68) ~= "P" or not p69 then
        return nil;
    end;
    local v70 = p67:GetEnPassantState();
    if not v70 then
        return nil;
    end;
    local v71, v72 = p67:ParsePieceLocation(p68);
    local v73 = tonumber(p69.Parent.Name);
    local v74 = tonumber(p69.Name);
    if v73 ~= v71 + (p67:GetPieceColor(p68) == "White" and 1 or -1) or math.abs(v74 - v72) ~= 1 then
        return nil;
    end;
    if v70.TargetLocation ~= `{v73},{v74}` then
        return nil;
    end;
    local l__Pawn__10 = v70.Pawn;
    if not l__Pawn__10 or (l__Pawn__10 == p68 or p67:GetPieceType(l__Pawn__10) ~= "P") then
        return nil;
    end;
    if not p67:IsEnemyPiece(p68, l__Pawn__10) then
        return nil;
    end;
    local v75, v76 = p67:ParsePieceLocation(l__Pawn__10);
    if v75 ~= v71 or v76 ~= v74 then
        return nil;
    end;
    local v77 = p67:GetSpotFromPiece(l__Pawn__10);
    return v77 and not p67:GetPieceAtSpot(p69) and {
        Special = "EnPassant",
        CapturePawn = l__Pawn__10,
        CaptureSpot = v77
    } or nil;
end;
function v6.AddEnPassantMoves(p78, p79, p80, p81, p82) --[[ Line: 348 ]]
    if p78:GetPieceType(p79) == "P" then
        local v83 = p78:GetPieceColor(p79) == "White" and 1 or -1;
        for _, v84 in { -1, 1 } do
            local v85 = p78:GetSpotFromLocation(p81 + v83, p82 + v84);
            local v86 = p78:GetEnPassantMoveData(p79, v85);
            if v86 then
                p80[v85] = v86;
            end;
        end;
    end;
end;
function v6.GetCastleMoveData(p87, p88, p89) --[[ Line: 365 ]]
    if p87:GetPieceType(p88) ~= "K" or not p89 then
        return nil;
    end;
    local v90, v91 = p87:ParsePieceLocation(p88);
    local v92 = tonumber(p89.Parent.Name);
    local v93 = tonumber(p89.Name);
    if v90 ~= v92 or math.abs(v93 - v91) ~= 2 then
        return nil;
    end;
    local v94 = v91 < v93 and 1 or -1;
    local v95 = nil;
    local v96 = nil;
    for _, v97 in p87:GetPiecesByType("R", (p87:GetPieceColor(p88))) do
        local v98, v99 = p87:ParsePieceLocation(v97);
        if v98 == v90 and (v94 == 1 and v91 < v99 or v94 == -1 and v99 < v91) and (not v95 or v94 == 1 and v95 < v99 or v94 == -1 and v99 < v95) then
            v96 = v97;
            v95 = v99;
        end;
    end;
    if not v96 then
        return nil;
    end;
    local v100 = p87:GetSpotFromLocation(v90, v91 + v94);
    return v100 and {
        Special = "Castle",
        Rook = v96,
        RookTarget = v100
    } or nil;
end;
function v6.AddCastleMoves(p101, p102, p103, p104, p105) --[[ Line: 410 ]]
    if p101:GetPieceType(p102) ~= "K" or p102:GetAttribute("HasMoved") then
        return;
    end;
    local v106 = p101:GetPieceColor(p102);
    local v107 = v106 == "White" and "Black" or "White";
    if p101:IsKingInCheck(v106) then
        return;
    end;
    for _, v108 in p101:GetPiecesByType("R", v106) do
        local v109, v110 = p101:ParsePieceLocation(v108);
        if v109 == p104 and not v108:GetAttribute("HasMoved") then
            local v111 = p105 < v110 and 1 or -1;
            local v112 = p101:GetSpotFromLocation(p104, p105 + v111);
            local v113 = p101:GetSpotFromLocation(p104, p105 + 2 * v111);
            local v114 = p101:GetSpotFromLocation(p104, p105 + v111);
            if v112 and (v113 and v114) then
                local v115 = false;
                for v116 = math.min(p105, v110) + 1, math.max(p105, v110) - 1 do
                    local v117 = p101:GetSpotFromLocation(p104, v116);
                    if v117 and p101:GetPieceAtSpot(v117) then
                        v115 = true;
                        break;
                    end;
                end;
                if not (v115 or (p101:IsSpotAttackedByColor(v112, v107) or p101:IsSpotAttackedByColor(v113, v107))) then
                    p103[v113] = {
                        Special = "Castle",
                        Rook = v108,
                        RookTarget = v114
                    };
                end;
            end;
        end;
    end;
end;
function v6.IsSpotAttackedByColor(p118, p119, p120) --[[ Line: 463 ]]
    if not p119 then
        return false;
    end;
    local v121 = tonumber(p119.Parent.Name);
    local v122 = tonumber(p119.Name);
    for _, v123 in p118.Instance.Chips:GetChildren() do
        if p118:GetPieceColor(v123) == p120 then
            local v124 = p118:GetPieceType(v123);
            local v125, v126 = p118:ParsePieceLocation(v123);
            if v124 == "P" then
                if v125 + (p120 == "White" and 1 or -1) == v121 and (v126 + 1 == v122 or v126 - 1 == v122) then
                    return true;
                end;
            elseif v124 == "N" then
                for _, v127 in {
                    { 1, 2 },
                    { 1, -2 },
                    { -1, 2 },
                    { -1, -2 },
                    { 2, 1 },
                    { 2, -1 },
                    { -2, 1 },
                    { -2, -1 }
                } do
                    if v125 + v127[1] == v121 and v126 + v127[2] == v122 then
                        return true;
                    end;
                end;
            elseif v124 == "K" then
                if math.abs(v125 - v121) <= 1 and math.abs(v126 - v122) <= 1 then
                    return true;
                end;
            else
                local v128 = v124 == "B" and {
                    { 1, 1 },
                    { 1, -1 },
                    { -1, 1 },
                    { -1, -1 }
                } or (v124 == "R" and {
                    { 1, 0 },
                    { -1, 0 },
                    { 0, 1 },
                    { 0, -1 }
                } or (v124 == "Q" and {
                    { 1, 1 },
                    { 1, -1 },
                    { -1, 1 },
                    { -1, -1 },
                    { 1, 0 },
                    { -1, 0 },
                    { 0, 1 },
                    { 0, -1 }
                } or nil));
                if v128 then
                    for _, v129 in v128 do
                        local v130 = v125 + v129[1];
                        local v131 = v126 + v129[2];
                        while p118:IsWithinBoard(v130, v131) do
                            local v132 = p118:GetSpotFromLocation(v130, v131);
                            if v130 == v121 and v131 == v122 then
                                return true;
                            end;
                            if p118:GetPieceAtSpot(v132) then
                                break;
                            end;
                            v130 = v130 + v129[1];
                            v131 = v131 + v129[2];
                        end;
                    end;
                end;
            end;
        end;
    end;
    return false;
end;
function v6.IsKingInCheck(p133, p134) --[[ Line: 543 ]]
    local v135 = p133:GetPiecesByType("K", p134)[1];
    if v135 then
        v135 = p133:GetSpotFromPiece(v135);
    end;
    if v135 then
        return p133:IsSpotAttackedByColor(v135, p134 == "White" and "Black" or "White");
    else
        return false;
    end;
end;
function v6.WouldMoveLeaveKingInCheck(p136, p137, p138, p139) --[[ Line: 555 ]]
    local v140 = p136:GetSpotFromPiece(p137);
    if not (v140 and p138) then
        return true;
    end;
    local v141 = p136:GetPieceAtSpot(p138);
    local v142 = p137:GetAttribute("Location");
    local v143 = v140:GetAttribute("OccupiedBy");
    local v144 = p138:GetAttribute("OccupiedBy");
    local v145;
    if v141 then
        v145 = v141:GetAttribute("Location");
    else
        v145 = v141;
    end;
    local v146 = p136:GetPieceColor(p137);
    local v147;
    if typeof(p139) == "table" and (p139.Special == "Castle" and p139) then
        v147 = p139;
    else
        v147 = p136:GetCastleMoveData(p137, p138);
    end;
    local v148;
    if v147 then
        v148 = v147.Rook;
    else
        v148 = v147;
    end;
    local v149;
    if v148 then
        v149 = p136:GetSpotFromPiece(v148);
    else
        v149 = v148;
    end;
    if v147 then
        v147 = v147.RookTarget;
    end;
    local v150;
    if v148 then
        v150 = v148:GetAttribute("Location");
    else
        v150 = v148;
    end;
    local v151;
    if v149 then
        v151 = v149:GetAttribute("OccupiedBy");
    else
        v151 = v149;
    end;
    local v152;
    if v147 then
        v152 = v147:GetAttribute("OccupiedBy");
    else
        v152 = v147;
    end;
    if typeof(p139) ~= "table" or (p139.Special ~= "EnPassant" or not p139) then
        p139 = p136:GetEnPassantMoveData(p137, p138);
    end;
    local v153;
    if p139 then
        v153 = p139.CapturePawn;
    else
        v153 = p139;
    end;
    if p139 then
        p139 = p139.CaptureSpot;
    end;
    local v154;
    if v153 then
        v154 = v153:GetAttribute("Location");
    else
        v154 = v153;
    end;
    local v155;
    if p139 then
        v155 = p139:GetAttribute("OccupiedBy");
    else
        v155 = p139;
    end;
    v140:SetAttribute("OccupiedBy", nil);
    p138:SetAttribute("OccupiedBy", p137.Name);
    p137:SetAttribute("Location", (`{p138.Parent.Name},{p138.Name}`));
    if v141 then
        v141:SetAttribute("Location", "0,0");
    end;
    if v148 and (v149 and v147) then
        v149:SetAttribute("OccupiedBy", nil);
        v147:SetAttribute("OccupiedBy", v148.Name);
        v148:SetAttribute("Location", (`{v147.Parent.Name},{v147.Name}`));
    end;
    if v153 and p139 then
        p139:SetAttribute("OccupiedBy", nil);
        v153:SetAttribute("Location", "0,0");
    end;
    local v156 = p136:IsKingInCheck(v146);
    p137:SetAttribute("Location", v142);
    v140:SetAttribute("OccupiedBy", v143);
    p138:SetAttribute("OccupiedBy", v144);
    if v141 then
        v141:SetAttribute("Location", v145);
    end;
    if v148 and (v149 and v147) then
        v148:SetAttribute("Location", v150);
        v149:SetAttribute("OccupiedBy", v151);
        v147:SetAttribute("OccupiedBy", v152);
    end;
    if v153 and p139 then
        v153:SetAttribute("Location", v154);
        p139:SetAttribute("OccupiedBy", v155);
    end;
    return v156;
end;
function v6.GetLegalMoveDirection(p157, p158) --[[ Line: 626 ]]
    local _, v159 = p157:GetMoveDirection(p158);
    local v160 = {};
    for v161, v162 in v159 do
        if not p157:WouldMoveLeaveKingInCheck(p158, v161, v162) then
            v160[v161] = v162;
        end;
    end;
    return false, v160;
end;
function v6.GetPiecesByType(p163, p164, p165) --[[ Line: 639 ]]
    -- upvalues: u10 (copy)
    local v166 = p165 or u10[p163:GetLocalSlot()].Name;
    local v167 = {};
    for _, v168 in p163.Instance.Chips:GetChildren() do
        if v168.Name:match((`{v166}_{p164:upper()}`)) then
            table.insert(v167, v168);
        end;
    end;
    return v167;
end;
function v6.GetMoveDirection(p169, p170) --[[ Line: 655 ]]
    local v171 = {};
    local v172 = p169:GetPieceType(p170);
    local v173, v174 = p169:ParsePieceLocation(p170);
    local v175 = p170:GetAttribute("HasMoved");
    if v172 == "P" then
        local v176 = p169:GetPieceColor(p170) == "White" and 1 or -1;
        local v177 = p169:GetSpotFromLocation(v173 + v176, v174);
        if v177 and not p169:GetPieceAtSpot(v177) then
            v171[v177] = true;
            local v178 = p169:GetSpotFromLocation(v173 + v176 * 2, v174);
            local v179 = p169:GetSpotFromLocation(v173 + v176, v174);
            if not v175 and (v179 and (not p169:GetPieceAtSpot(v179) and (v178 and not p169:GetPieceAtSpot(v178)))) then
                v171[v178] = true;
            end;
        end;
        for _, v180 in { -1, 1 } do
            local v181 = p169:GetSpotFromLocation(v173 + v176, v174 + v180);
            local v182 = p169:GetPieceAtSpot(v181);
            if v182 and (p169:IsEnemyPiece(p170, v182) and p169:GetPieceType(v182) ~= "K") then
                v171[v181] = v182;
            end;
        end;
        p169:AddEnPassantMoves(p170, v171, v173, v174);
    elseif v172 == "N" then
        for _, v183 in {
            { 1, 2 },
            { 1, -2 },
            { -1, 2 },
            { -1, -2 },
            { 2, 1 },
            { 2, -1 },
            { -2, 1 },
            { -2, -1 }
        } do
            p169:AddMoveIfValid(p170, v171, v173 + v183[1], v174 + v183[2]);
        end;
    elseif v172 == "B" then
        p169:AddSlidingMoves(p170, v171, v173, v174, {
            { 1, 1 },
            { 1, -1 },
            { -1, 1 },
            { -1, -1 }
        });
    elseif v172 == "R" then
        p169:AddSlidingMoves(p170, v171, v173, v174, {
            { 1, 0 },
            { -1, 0 },
            { 0, 1 },
            { 0, -1 }
        });
    elseif v172 == "Q" then
        p169:AddSlidingMoves(p170, v171, v173, v174, {
            { 1, 1 },
            { 1, -1 },
            { -1, 1 },
            { -1, -1 },
            { 1, 0 },
            { -1, 0 },
            { 0, 1 },
            { 0, -1 }
        });
    elseif v172 == "K" then
        for _, v184 in {
            { 1, 1 },
            { 1, 0 },
            { 1, -1 },
            { 0, 1 },
            { 0, -1 },
            { -1, 1 },
            { -1, 0 },
            { -1, -1 }
        } do
            p169:AddMoveIfValid(p170, v171, v173 + v184[1], v174 + v184[2]);
        end;
        p169:AddCastleMoves(p170, v171, v173, v174);
    end;
    return false, v171;
end;
function v6.SpectateStart(u185) --[[ Line: 728 ]]
    local v187 = u185:WatchStateChange("Turn", function() --[[ Line: 732 ]]
        -- upvalues: u185 (copy)
        local v186 = u185.Slots[u185.ReplicatedState.Turn];
        if v186 then
            u185:TimedInspect(`It's {v186.Name}'s turn!`, 3);
        end;
    end);
    u185.SpectateMaid:Mark(v187);
end;
function v6.Client.SimulateMove(_, p188, p189) --[[ Line: 744 ]]
    -- upvalues: l__TweenService__3 (copy), u9 (copy), u3 (copy)
    local v190 = l__TweenService__3:Create(p188, u9, {
        Position = p189 - Vector3.new(0, p188.PivotOffset.Y, 0)
    });
    u3.PlaySound("Checkers.Move");
    v190:Play();
end;
function v6.HandleInput(p191) --[[ Line: 755 ]]
    -- upvalues: u10 (copy), l__TweenService__3 (copy), u9 (copy), u7 (copy), u8 (copy), u3 (copy)
    local l__SelectedChip__11 = p191.SelectedChip;
    local l__Name__12 = u10[p191:GetLocalSlot()].Name;
    if p191.CanPlay and (l__SelectedChip__11 and l__SelectedChip__11.Name:match(l__Name__12)) then
        local v192 = p191.FocusedChip == l__SelectedChip__11;
        local l__Position__13 = l__SelectedChip__11.Position;
        if v192 then
            if p191.MoveableSpots then
                for v193, _ in p191.MoveableSpots do
                    l__TweenService__3:Create(v193, u9, {
                        Transparency = 1
                    }):Play();
                end;
            end;
            if p191.TargetSpot then
                local v194 = l__SelectedChip__11.Name:match("_(%a)_");
                local v195 = string.split(l__SelectedChip__11:GetAttribute("Location"), ",");
                local v196 = p191:GetSpotFromLocation(v195[1], v195[2]);
                if p191.TargetSpot then
                    local l__Name__14 = p191.TargetSpot.Parent.Name;
                    if v194 == "P" and (l__Name__14 == "8" or l__Name__14 == "1") then
                        p191:Promote(l__SelectedChip__11);
                    end;
                    l__Position__13 = p191.TargetSpot.Position;
                    v196.Transparency = 1;
                    p191.CanPlay = false;
                    p191.Server:Move(l__SelectedChip__11, p191.TargetSpot);
                end;
            end;
            p191.MoveableSpots = nil;
        else
            local _, v197 = p191:GetLegalMoveDirection(l__SelectedChip__11);
            for v198, _ in v197 do
                local v199 = l__TweenService__3:Create(v198, u9, {
                    Transparency = 0.5
                });
                v198.Color = u7;
                if v198:GetAttribute("OccupiedBy") then
                    v198.Color = u8;
                end;
                v199:Play();
            end;
            p191.MoveableSpots = v197;
        end;
        l__TweenService__3:Create(l__SelectedChip__11, u9, {
            Position = Vector3.new(l__Position__13.X, p191.DefaultHeight - (v192 and 0 or -0.2) - l__SelectedChip__11.PivotOffset.Y, l__Position__13.Z)
        }):Play();
        u3.PlaySound("Checkers.Select");
        if v192 or not l__SelectedChip__11 then
            l__SelectedChip__11 = nil;
        end;
        p191.FocusedChip = l__SelectedChip__11;
        p191.Highlight.OutlineTransparency = 0;
    else
        u3.PlaySound("TicTacToe.Error");
    end;
end;
function v6.Promote(u200, u201) --[[ Line: 843 ]]
    -- upvalues: l__CurrentCamera__2 (copy)
    local v202 = l__CurrentCamera__2:WorldToScreenPoint(u201.Position);
    local l__Promotion__15 = u200.Gui.Promotion;
    local u203 = {};
    for _, u204 in l__Promotion__15.Viewer:GetChildren() do
        if u204:IsA("ImageButton") then
            u203[u204] = u204.MouseButton1Down:Once(function() --[[ Line: 851 ]]
                -- upvalues: u200 (copy), u201 (copy), u204 (copy), l__Promotion__15 (copy), u203 (copy)
                u200.Server:Promote(u201, u204.Name);
                l__Promotion__15.Visible = false;
                for _, v205 in u203 do
                    v205:Disconnect();
                end;
            end);
        end;
    end;
    u200.CanPlay = false;
    l__Promotion__15.Position = UDim2.fromOffset(v202.X, v202.Y);
    l__Promotion__15.Visible = true;
end;
function v6.UpdateCheckStatus(p206) --[[ Line: 867 ]]
    -- upvalues: u10 (copy), u8 (copy)
    p206.BlockedSpots = {};
    local l__Name__16 = u10[p206:GetLocalSlot()].Name;
    local l__King__17 = p206.King;
    if l__King__17 then
        l__King__17 = p206:GetSpotFromPiece(p206.King);
    end;
    p206.Check = p206:IsKingInCheck(l__Name__16);
    if p206.Check and l__King__17 then
        l__King__17.Transparency = 0.5;
        l__King__17.Color = u8;
    end;
end;
function v6.Hook(u207) --[[ Line: 882 ]]
    -- upvalues: u10 (copy), l__RunService__7 (copy), l__CurrentCamera__2 (copy), u1 (copy), u7 (copy), u8 (copy)
    local l__Name__18 = u10[u207:GetLocalSlot()].Name;
    local v212 = l__RunService__7.Heartbeat:Connect(function(p208) --[[ Line: 886 ]]
        -- upvalues: l__CurrentCamera__2 (ref), u1 (ref), u207 (copy), l__Name__18 (copy), u7 (ref), u8 (ref)
        local v209 = l__CurrentCamera__2:ScreenPointToRay(u1.X, u1.Y);
        local v210 = workspace:Raycast(v209.Origin, v209.Direction * 30, u207.RaycastWhitelist);
        if u207.FocusedChip then
            if v210 then
                v210 = v210.Instance;
            end;
            if v210 then
                u207.TargetSpot = u207.MoveableSpots[v210] and v210 and v210 or nil;
            else
                u207.TargetSpot = nil;
            end;
        else
            if v210 then
                v210 = v210.Instance:GetAttribute("OccupiedBy");
            end;
            if v210 then
                local v211 = u207:GetChipFromName(v210);
                local l__CanPlay__19 = u207.CanPlay;
                if l__CanPlay__19 then
                    l__CanPlay__19 = v211.Name:match(l__Name__18);
                end;
                u207.Highlight.OutlineColor = u207.Highlight.OutlineColor:Lerp(l__CanPlay__19 and u7 or u8, p208 * 10);
                if v211 ~= u207.SelectedChip then
                    u207.Highlight.OutlineTransparency = 1;
                    u207.Highlight.Adornee = v211;
                    u207.SelectedChip = v211;
                end;
            else
                u207.SelectedChip = nil;
            end;
            local l__Highlight__20 = u207.Highlight;
            local l__OutlineTransparency__21 = u207.Highlight.OutlineTransparency;
            l__Highlight__20.OutlineTransparency = l__OutlineTransparency__21 + ((v210 and 0 or 1) - l__OutlineTransparency__21) * (p208 * 10);
        end;
    end);
    u207.Maid:Mark(v212);
end;
function v6.Enter(p213) --[[ Line: 937 ]]
    -- upvalues: u4 (copy), l__Mince__8 (copy)
    p213:StartInspect("Waiting for players..");
    u4.StartInteractions();
    if l__Mince__8.Config.Humanoid then
        l__Mince__8.Config.Humanoid:UnequipTools();
    end;
end;
function v6.Start(u214) --[[ Line: 946 ]]
    -- upvalues: u3 (copy), u2 (copy), l__UserInputService__5 (copy)
    u214:StopInspect();
    u214.SelectedChip = nil;
    u214.Check = false;
    u214.BlockedSpots = {};
    u214.King = nil;
    u214.CanPlay = false;
    local u215 = u214:GetLocalSlot();
    local u216 = true;
    if not u215 then
        error("Could not retrieve your slot!");
    end;
    u214:DistanceRoundedCameraPan(u214.Instance.Players[u215].Camera.WorldCFrame);
    u214:Hook();
    local v218 = u214:WatchStateChange("Turn", function() --[[ Line: 965 ]]
        -- upvalues: u214 (copy), u215 (copy), u216 (ref), u3 (ref)
        local l__Turn__22 = u214.ReplicatedState.Turn;
        local v217 = u214.Slots[l__Turn__22];
        if v217 then
            u214:UpdateCheckStatus();
            u214.Turn = l__Turn__22;
            u214.CanPlay = u214.Turn == u215;
            if not u216 then
                u3.PlaySound("Checkers.Move");
            end;
            u214:TimedInspect(`It's {v217.Name}'s turn!`, 3);
            u216 = false;
        end;
    end);
    local v220 = u2.Get("Interact").OnAction:Connect(function(p219) --[[ Line: 983 ]]
        -- upvalues: u214 (copy)
        if p219 == Enum.UserInputState.Begin then
            u214:HandleInput();
        end;
    end);
    local v221 = l__UserInputService__5.TouchTapInWorld:Connect(function() --[[ Line: 989 ]]
        -- upvalues: u214 (copy)
        u214:HandleInput();
    end);
    u214.King = u214:GetPiecesByType("K")[1];
    u214.Maid:Mark(v220);
    u214.Maid:Mark(v221);
    u214.Maid:Mark(v218);
end;
function v6.Complete(u222, p223, p224) --[[ Line: 1000 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u3 (copy)
    warn("Completion!", p223, p224);
    if p224 == "Draw" then
        u222:TimedInspect("It\'s a tie!", 3);
    elseif p224:IsA("Player") then
        u222:TimedInspect(`The winner of this game is {p224.Name}!`, 3);
    end;
    local l__Animator__23 = l__LocalPlayer__1.Character.Humanoid.Animator;
    local v225 = {
        Win = l__Animator__23:LoadAnimation(script.Victory),
        Lose = l__Animator__23:LoadAnimation(script.Defeat)
    };
    if p224 == l__LocalPlayer__1 then
        u3.PlaySound("TicTacToe.Win");
        v225.Win:Play();
    else
        u3.PlaySound("TicTacToe.Lose");
        v225.Lose:Play();
    end;
    task.wait(1);
    local v226 = u222:GetFirstOpponent();
    if v226 then
        local l__Character__24 = v226.Character;
        if l__Character__24 then
            l__Character__24 = v226.Character:FindFirstChild("HumanoidRootPart");
        end;
        if l__Character__24 then
            local u227 = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, l__Character__24.Position);
            task.spawn(function() --[[ Line: 1038 ]]
                -- upvalues: u222 (copy), u227 (copy)
                u222:CameraPan(u227);
            end);
        end;
    end;
end;
function v6.Exit(p228) --[[ Line: 1047 ]]
    -- upvalues: u4 (copy)
    u4.EndInteractions();
    p228.Gui.Promotion.Visible = false;
    p228.SelectedChip = nil;
    p228.Check = false;
    p228.BlockedSpots = {};
    p228.King = nil;
    p228.CanPlay = false;
    p228:DistanceLinearRevertCamera();
    p228:UnlockPlayerMovement();
end;
return v6;
