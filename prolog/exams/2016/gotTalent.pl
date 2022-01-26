:-use_module(library(lists)).

% participant(id, age, performance).

participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de Esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

% juri de E elementos
% performance(id, times).

performance(1234, [120, 120, 120, 120]).
performance(3423, [32, 120, 45, 120]).
performance(3788, [110, 2, 6, 43]).
performance(4865, [120, 120, 110, 120]).
performance(8937, [97, 101, 105, 110]).

% madeItThrough(+Participant). 
madeItThrough(Pid) :- participant(Pid, _, _),
                      performance(Pid, Times),
                      memberchk(120, Times).

% juriTimes(+Participants, +JuriMember, -Times, -Total).


juriTimes([], _, []).
juriTimes([Pid | Participants], JuriMember, [Time | Times]) :- participant(Pid, _, _),
                                                                      performance(Pid, LstTimes),
                                                                      nth1(JuriMember, LstTimes, Time),
                                                                      juriTimes(Participants, JuriMember, Times).

juriTimes(Participants, JuriMember, Times, Total) :- juriTimes(Participants, JuriMember, Times),
                                                     sumlist(Times, Total).

%patientJuri(+JuriMember).

patientJuri(JuriMember) :- performance(P1, Lst1),
                           performance(P2, Lst2),
                           P1 \= P2, 
                           nth1(JuriMember, Lst1, 120),
                           nth1(JuriMember, Lst2, 120).

% bestParticipant(+P1, +P2, -P).


cmpBestSum(_P1, _P2, Sum1, Sum2, _P) :-  Sum1 = Sum2, !, fail.
cmpBestSum(_P1, P2, Sum1, Sum2, P) :- Sum1 < Sum2, P is P2, !.
cmpBestSum(_P1, _P2, _, _, _P1).

bestParticipant(P1, P2, P) :- participant(P1, _, _), participant(P2, _, _),
                              performance(P1, P1Times), performance(P2, P2Times),
                              sumlist(P1Times, Sum1), sumlist(P2Times, Sum2),
                              cmpBestSum(P1, P2, Sum1, Sum2, P).

% allPerfs.

allPerfs :- \+ allPerfsAux.

allPerfsAux :-  participant(Id, _, Performance),
                performance(Id, Lst),
                write(Id), write(':'),
                write(Performance), write(':'),
                write(Lst), nl, fail.

% nSuccessfulParticipants(-T).

nSuccessfulParticipants(T) :- findall(Id, (performance(Id, Times), remove_dups(Times, Pruned), Pruned = [120]), Lst), length(Lst, T).

% juriFans(juriFansList),

getNotPressedIdsList([], _, []).
getNotPressedIdsList([Time | Times], Idx, [Id | Ids]) :- Time = 120,
                                                         Id = Idx, !,
                                                         NewIdx is Idx + 1,
                                                         getNotPressedIdsList(Times, NewIdx, Ids).

getNotPressedIdsList([_ | Times], Idx, Ids) :- NewIdx is Idx + 1,
                                                         getNotPressedIdsList(Times, NewIdx, Ids).

getNotPressedIdsList(Times, Ids) :- getNotPressedIdsList(Times, 1, Ids).

juriFans(L) :- findall(Pid-Lst, (performance(Pid, Times), getNotPressedIdsList(Times, Lst)), L).

eligibleOutcome(Id, Perf, TT) :- performance(Id, Times),
                                 madeItThrough(Id),
                                 participant(Id, _, Perf),
                                 sumlist(Times, TT).

% nextPhase(+N, -Participants).

nextPhase(N, P) :- findall(TT-Id-Perf, eligibleOutcome(Id, Perf, TT), Lst),
                   keysort(Lst, PReversed), 
                   reverse(PReversed, SortedP),
                   length(SortedP, L),
                   L >= N,
                   sublist(SortedP, P, _, N, _), !.

% predX/3

predX(Q, [R|Rs], [P|Ps]) :- participant(R,I,P), I =< Q, !, predX(Q, Rs, Ps).
predX(Q, [R|Rs], Ps) :- participant(R,I,_), I > Q, predX(Q, Rs, Ps).
predX(_,[],[]).


% Green Cut -> Outputs the performance description of the given performance IDs which have an age smaller than Q.