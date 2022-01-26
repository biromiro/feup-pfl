% impoe(X,L).

impoe(X, L) :- length(Mid, X),
               append(L1, [X|_], L), append(_,[X|Mid], L1).

% langford(+N, -L).

verifyIntegrity(0, _).
verifyIntegrity(N,L) :- impoe(N,L),
                        NewN is N - 1,
                        verifyIntegrity(NewN,L).

langford(N,L) :- length(L, Len),
                 Len is 2*N, !,
                 verifyIntegrity(N,L).
