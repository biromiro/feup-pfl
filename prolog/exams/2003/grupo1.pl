% remove_todos(+X, ?Lista, ?Nova).

remove_todos(_, [], []).
remove_todos(X, [Elem | Lista], [ElemRep | Nova]) :- Elem \= X, !,
                                                     Elem = ElemRep,
                                                     remove_todos(X, Lista, Nova).

remove_todos(_X, [_ | _Lista], _Nova) :- remove_todos(_X, _Lista, _Nova).

% extremos(+Lista, -Maximo, -Minimo).

extremosAux([], _Max, _Min, _Max, _Min).
extremosAux([Elem | Lst], CurMax, _CurMin, _Max, _Min) :- Elem > CurMax, !,
                                                       extremosAux(Lst, Elem, _CurMin, _Max, _Min).

extremosAux([Elem | Lst], _CurMax, CurMin, _Max, _Min) :- Elem < CurMin, !,
                                                       extremosAux(Lst, _CurMax, Elem, _Max, _Min).

extremosAux([_ | Lst], _CurMax, _CurMin, _Max, _Min) :- extremosAux(Lst, _CurMax, _CurMin, _Max, _Min).

extremosAux([], null, null).
extremos([Elem | Lst], Maximo, Minimo) :- extremosAux(Lst, Elem, Elem, Maximo, Minimo).


europa(lisboa, portugal, capital, 900).
europa(porto, portugal, cidade, 300).
europa(madrid, espanha, capital, 3100).
europa(barcelona, espanha, cidade, 2900).
europa(espinho, portugal, cidade, 40).
europa(gaia, portugal, cidade, 260).
europa(arcozelo, portugal, vila, 15).
europa(coimbra, portugal, cidade, 105).

% cidades_grandes(+Pais, -Lista, -Pop_Total).

getPopTotal([], _Pop_Total, _Pop_Total).
getPopTotal([(_, Pop) | _Lst], Acc, _Pop_Total) :- NewAcc is Acc + Pop,
                                                      getPopTotal(_Lst, NewAcc, _Pop_Total).

cidades_grandes(Pais, Lista, Pop_Total) :- findall((Cidade,Pop_Total), (europa(Cidade, Pais, cidade, Pop_Total), Pop_Total > 100), Lista),
                                            getPopTotal(Lista, 0, Pop_Total).

% capitais(-Lista_Capitais).
capitais(Lista_Capitais) :- findall(Capital*Num, (europa(Capital, Pais, capital, _), findall(Cidade, europa(Cidade, Pais, _, _), Lst), length(Lst, Num)), Lista_Capitais).