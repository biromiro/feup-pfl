%player(Name, Username, Age)

player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Johnny', 'A Player', 16).

%game(Name, Categories, MinAge)

game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

:- dynamic played/4.

%played(Player, Game, HoursPlayed, PercentUnlocked)

played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).


achievedALot(Player) :- played(Player, _, _, Percent),
                        Percent > 80.

isAgeAppropriate(Name, Game) :- player(Name, _, Age),
                                game(Game, _, MinAge),
                                MinAge < Age.

timePlayingGamesAux(_, [], [], Acc, Acc).
timePlayingGamesAux(Player, [Game | Games], [Time | Times], Acc, _SumTimes) :- 
                                    played(Player, Game, Time, _), !,
                                    NewAcc is Acc + Time,
                                    timePlayingGamesAux(Player, Games, Times, NewAcc, _SumTimes).
timePlayingGamesAux(_Player, [ _ | _Games], [Time | _Times], _Acc, _SumTimes) :- 
                                    Time is 0,
                                    timePlayingGamesAux(_Player, _Games,  _Times, _Acc, _SumTimes).

timePlayingGames(Player, Games, Times, SumTimes) :- timePlayingGamesAux(Player, Games, Times, 0, SumTimes).

listGamesOfCategoryAux(Cat) :- game(GameName, Cats, Age),
                            memberchk(Cat, Cats),
                            format('~s (~d)', [GameName, Age]), nl,
                            fail.

listGamesOfCategory(Cat) :- \+ listGamesOfCategoryAux(Cat).

updatePlayer(Player, Game, Hours, Percentage) :- played(Player, Game, PrevHours, PrevPercentage),
        	                                     retract((played(Player, Game, PrevHours, PrevPercentage))),
                                                 NewHours is Hours + PrevHours,
                                                 NewPercentage is Percentage + PrevPercentage,
                                                 assert((played(Player, Game, NewHours, NewPercentage))).


fewHours(Player, Acc, Games) :- played(Player, NG, Hours, _),
                                \+ memberchk(NG, Acc),
                                Hours < 10, !,
                                append(Acc, [NG], NewAcc),
                                fewHours(Player, NewAcc,Games).
fewHours(_, Acc, Acc).

fewHours(Player, Games) :- fewHours(Player, [], Games).

:-use_module(library(lists)).

ageRange(MinAge, MaxAge, Players) :- findall(Name, (player(Name, _, Age), Age =< MaxAge, Age >= MinAge), Players).

averageAge(Game, AA) :- findall(Age, (played(Player, Game, _, _ ), player(_, Player, Age)), Ages),
                        length(Ages, Len),
                        sumlist(Ages, Sum),
                        AA is Sum/Len.

getBest([], _, []).
getBest([Score-Name | P], Score, [Name | NP]) :- getBest(P, Score, NP), !.
getBest([ _ | P], Score, NP) :- getBest(P, Score, NP).

mostEffectivePlayers(Game, Players) :- findall(Score-Player, (played(Player, Game, Hours, Percent), Score is Percent/Hours), PlayerScore),
                                        keysort(PlayerScore, PlayerScoreSortedReversed),
                                        reverse(PlayerScoreSortedReversed, PlayerScoreSorted),
                                        PlayerScoreSorted = [Score-_ | _],
                                        getBest(PlayerScoreSorted, Score, Players).

dendogram(Name).
dendogram(node(Left, Right)) :- 
        dendenogram(Left),
        dendenogram(Right).


dendogramfig2 :-  node(node(node(node(node(australia, node(node(sta_helena, angula), georgia_do_sul)), reino_unido), node(servia, franca)), node(node(niger, india), irlanda)), brasil)

