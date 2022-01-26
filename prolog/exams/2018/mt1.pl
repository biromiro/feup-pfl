% airport(Name, ICAO, Country)

airport('Aeroporto Francisco Sá Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeropuerto Adolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aéroport de Paris-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Fiumicino - Leonardo da Vinci', 'LIRF', 'Italy').

% company (ICAO, Name, Year, Country)

company('TAP', 'TAP Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('AFR', 'Société Air France, S.A.', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').

% flight (Designation, Origin, Destination, DepartureTime, Duration, Company)

flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('FR5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('FR5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'AFR').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'AFR').


short(Flight) :- flight(Flight, _, _, _, Time, _),
                 Time < 90.

getShorter(Flight1, _, Time1, Time2, Flight1) :- Time1 < Time2.
getShorter(_, Flight2, Time1, Time2, Flight2) :- Time1 > Time2.
getShorter(_, _, _, _, _) :- fail.


shorter(Flight1, Flight2, ShorterFlight) :- flight(Flight1, _, _, _, Time1, _),
                                            flight(Flight2, _, _, _, Time2, _),
                                            getShorter(Flight1, Flight2, Time1, Time2, ShorterFlight).

arrivalTime(Flight, ArrivalTime) :- flight(Flight, _, _, DepartureTime, Time, _),
                                    HoursDepart is DepartureTime // 100,
                                    MinutesDepart is DepartureTime mod 100,
                                    MinutesFlight is MinutesDepart + Time,
                                    HoursFlight is MinutesFlight // 60,
                                    Hours is ((HoursDepart + HoursFlight) mod 24) * 100,
                                    Minutes is MinutesFlight mod 60,
                                    ArrivalTime is Hours + Minutes.

operatesInCountry(Company, Country) :- flight(_, Airport1, _, _, _, Company),
                                        airport(_, Airport1, Country).

operatesInCountry(Company, Country) :- flight(_, _, Airport1, _, _, Company),
                                        airport(_, Airport1, Country).

countriesAux(Company, Acc, ListOfCountries) :- operatesInCountry(Company, Country),
                                                \+ memberchk(Country, Acc),
                                                append(Acc, [Country], NewAcc),
                                                countriesAux(Company, NewAcc, ListOfCountries), !.

countriesAux(_, Acc, Acc).

countries(Company, ListOfCountries) :- countriesAux(Company, [], ListOfCountries).

convTimeToMin(Time, Minutes) :- Hours is Time // 100,
                                MinutesTime is Time mod 100,
                                HoursToMinutes is Hours * 60,
                                Minutes is MinutesTime + HoursToMinutes.

pairableFlightsAux :- flight(Flight1, _, Bridge, _, _, _),
                      flight(Flight2, Bridge, _, DepartureTime, _, _),
                      arrivalTime(Flight1, Arrival1),
                      convTimeToMin(Arrival1, ArrivalInMinutes),
                      convTimeToMin(DepartureTime, DepartureInMinutes),
                      MinDeparture is ArrivalInMinutes + 30,
                      MaxDeparture is ArrivalInMinutes + 90,
                      DepartureInMinutes >= MinDeparture,
                      DepartureInMinutes =< MaxDeparture,
                      format('~s - ~s \\ ~s', [Bridge, Flight1, Flight2]), nl, fail.

pairableFlights :- \+ pairableFlightsAux.


tripDaysAux(_, [], _, AccFlightTimes, AccFlightTimes, AccDays, AccDays).

tripDaysAux(Orig, [Dest | Next],  Time, AccFlightTimes, FlightTimes, AccDays, Days) :-
                            flight(Flight, DepartAirport, DestAirport, TimeToCatch, _, _),
                            airport(_, DepartAirport, Orig),
                            airport(_, DestAirport, Dest),
                            convTimeToMin(TimeToCatch, TimeToCatchInMin),
                            TimeToCatchInMin >= Time,
                            append(AccFlightTimes, [TimeToCatch], NewAccFlightTimes),
                            arrivalTime(Flight, ArrivalTime),
                            convTimeToMin(ArrivalTime, ArrivalTimeMin),
                            NewTime is ArrivalTimeMin + 30,
                            tripDaysAux(Dest, Next, NewTime, NewAccFlightTimes, FlightTimes, AccDays, Days).

tripDaysAux(Orig, [Dest | Next], Time, AccFlightTimes, FlightTimes, AccDays, Days) :-
        flight(_, DepartAirport, DestAirport, TimeToCatch, _, _ ),
        airport(_, DepartAirport, Orig),
        airport(_, DestAirport, Dest),
        convTimeToMin(TimeToCatch, TimeToCatchInMin),
        TimeToCatchInMin < Time, !,
        NewAccDays is AccDays + 1,
        tripDaysAux(Orig, [Dest | Next], 0, AccFlightTimes, FlightTimes, NewAccDays, Days).

tripDays([Curr_Country | Next], Time, FlightTimes, Days) :- 
                convTimeToMin(Time, Minutes),
                tripDaysAux(Curr_Country, Next, Minutes, [], FlightTimes, 1, Days), !.

:-use_module(library(lists)).

avgFlightLengthFromAirport(Airport, AvgLength) :- findall(Time, flight(_, Airport, _, _, Time, _), Times),
                                                  length(Times, Len),
                                                  sumlist(Times, Sum),
                                                  AvgLength is Sum / Len.

getMostInternational([], _, []).
getMostInternational([Count-Company | Rest], Count, [Company | RestNames]) :- getMostInternational(Rest, Count, RestNames).
getMostInternational([_ | Rest], Count, RestNames) :- getMostInternational(Rest, Count, RestNames).

mostInternational(ListOfCompanies) :- findall(Count-Company, 
    (company(Company, _, _, _),
    findall(
        Flight,
        (
            flight(Flight, Departure, Arrival, _, _, Company),
            airport(_, Departure, CountryDeparture),
            airport(_, Arrival, CountryArrival),
            CountryDeparture \= CountryArrival
        ),
        Flights
        )
    , length(Flights, Count)
    ), CountCompanyPairs),
    keysort(CountCompanyPairs, Sorted),
    reverse(Sorted, Reversed),
    Reversed = [Best-_ | _],
    getMostInternational(Reversed, Best, ListOfCompanies), !.


make_pairs(L, P, [X-Y|Zs]) :-
    select(X, L, L2),
    select(Y, L2, L3),
    G =.. [P, X, Y], G,
    make_pairs(L3, P, Zs).

make_pairs(L, P, Zs) :-
    select(_, L, L2),
    select(_, L2, L3),
    make_pairs(L3, P, Zs).

make_pairs([], _, []).
make_pairs([_],_,[]).

make_max_pairs(L, P, S) :- setof(Pair, (L,P,M)^(make_pairs(L, P, M), memberchk(Pair, M)), S).

dif_max_2(X,Y) :- X < Y, X >= Y-2.
