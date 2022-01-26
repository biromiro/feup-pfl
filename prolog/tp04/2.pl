:-use_module(library(lists)).

% flight(origin, destination, company, code, hour, duration)

flight(porto, lisbon, tap, tp1949, 1615, 60).
flight(lisbon, madrid, tap, tp1018, 1805, 75).
flight(lisbon, paris, tap, tp440, 1810, 150).
flight(lisbon, london, tap, tp1366, 1955, 165).
flight(london, lisbon, tap, tp1361, 1630, 160).
flight(porto, madrid, iberia, ib3095, 1640, 80).
flight(madrid, porto, iberia, ib3094, 1545, 80).
flight(madrid, lisbon, iberia, ib3106, 1945, 80).
flight(madrid, paris, iberia, ib3444, 1640, 125).
flight(madrid, london, iberia, ib3166, 1550, 145).
flight(london, madrid, iberia, ib3163, 1030, 140).
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).


not(X):- X, !, fail.
not(_X).

get_all_nodes(ListOfAirports) :- setof(LA, (Flight, Company, Code, Hour, Duration)^(flight(LA, Flight, Company, Code, Hour, Duration); flight(Flight, LA, Company, Code, Hour, Duration)), ListOfAirports).



company_destinies(Company, Destinies) :- setof(D, (Origin, Code, Hour, Duration)^(flight(Origin, D, Company, Code, Hour, Duration)) , Destinies).

score(Company, Score) :- company_destinies(Company, Destinies), length(Destinies, Score);

most_diversified([Company], Company).

most_diversified([Company | L], Company) :- most_diversified(L, SecondBest),
                                            score(Company, Score1),
                                            score(SecondBest, Score2),
                                            Score1 >= Score2.

most_diversified([T | L], Company) :- score(T, Score1),
                                      score(Company, Score2),   
                                      Score2 >= Score1,
                                      most_diversified(L, Company).

most_diversified(Company) :- setof(C, (Or,Dt,C,Cd,Hr,Dr)^(flight(Or,Dt,C,Cd,Hr,Dr)), Companies),
                             most_diversified(Companies, Company).


find_flight(Origin, Destination, T) :- find_flights(Origin, Destination, T, []).


find_flights(Destination, Destination, [], _) :- !.
find_flights(Origin, Destination, [Flight | T], R) :- flight(Origin, N, _, Flight, _, _),
                                           not(member(Origin, R)),
                                           find_flights(N, Destination, T, [Origin | R]).


find_flights(Origin, Destination, Flights) :- setof(Journey, find_flight(Origin, Destination, Journey), Flights).