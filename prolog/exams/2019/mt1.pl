:-use_module(library(lists)).

jogo(1,sporting,porto,1-2).
jogo(1,maritimo,benfica,2-0).
jogo(2,sporting,benfica,0-2).
jogo(2,porto,maritimo,1-0).
jogo(3,maritimo,sporting,1-1).
jogo(3,benfica,porto,0-2).

treinadores(porto,[[1-3]-sergio_conceicao]).
treinadores(sporting,[[1-2]-silas,[3-3]-ruben_amorim]).
treinadores(benfica,[[1-3]-bruno_lage]).
treinadores(maritimo,[[1-3]-jose_gomes]).

n_treinadores(Equipa, Numero) :- treinadores(Equipa, TreinadoresLst),
                                 length(TreinadoresLst, Numero).

checkNumJornadas(Treinador, NumeroJornadas, [[Ini-Fin]-Treinador | _]) :-  NumeroJornadas is Fin - Ini + 1.
checkNumJornadas(Treinador, NumeroJornadas, [_ | Lst]) :- checkNumJornadas(Treinador, NumeroJornadas, Lst).
checkNumJornadas(_Treinador, _NumeroJornadas, []) :- fail.


n_jornadas_treinador(Treinador, NumeroJornadas) :- treinadores(_, Jornadas),
                                                    checkNumJornadas(Treinador, NumeroJornadas, Jornadas).

ganhou(Jornada, EquipaVencedora, EquipaDerrotada) :- jogo(Jornada, EquipaVencedora, EquipaDerrotada, Maior-Menor),
                                                     Maior > Menor.
ganhou(Jornada, EquipaVencedora, EquipaDerrotada) :- jogo(Jornada, EquipaDerrotada, EquipaVencedora, Menor-Maior),
                                                     Maior > Menor.


:-op(180, fx, o).
:-op(200, xfx, venceu).

o X venceu o Y :- ganhou(_, X, Y).

predX(N,N,_).
predX(N,A,B):-
        !,
        A \= B,
        A1 is A + sign(B - A),
        predX(N,A1,B).

getJornadas(Treinador, [Jornadas-Treinador | _], Jornadas).
getJornadas(Treinador, [ _ | Lst], Jornadas) :- getJornadas(Treinador, Lst, Jornadas).
getJornadas(_Treinador, [], _) :- fail.

lostNoGame(_Equipa, Ini, Fin) :- Ini > Fin.
lostNoGame(Equipa, Jornada, Fin) :- \+ ganhou(Jornada, _, Equipa),
                                    NewJornada is Jornada + 1,
                                    lostNoGame(Equipa, NewJornada, Fin).

treinador_bom(Treinador) :- treinadores(Equipa, Jornadas),
                            getJornadas(Treinador, Jornadas, [Ini-Fin]),
                            lostNoGame(Equipa, Ini, Fin).

imprime_totobola(1, '1').
imprime_totobola(0, 'X').
imprime_totobola(-1, '2').
imprime_texto(X,'vitoria da casa'):-
                                X = 1.
imprime_texto(X,'empate'):-
                        X = 0.
imprime_texto(X,'derrota da casa'):-
                                X = -1.



resultado(Casa-Fora, Res) :- Casa < Fora, !, Res is -1.
resultado(Casa-Fora, Res) :- Casa > Fora, !, Res is 1.
resultado(_, Res) :- Res is 0.

imprime_jogos_aux(Func) :- jogo(Jornada, Casa, Fora, Score),
                            resultado(Score, Res),
                            Term =.. [Func, Res, Output],
                            Term,
                            format('Jornada ~d: ~s x ~s - ~s', [Jornada, Casa, Fora, Output]), nl,
                            fail.

imprime_jogos(Func) :- \+ (imprime_jogos_aux(Func)).

treinador_equipa([], _) :- fail.
treinador_equipa([_-Treinador | _], Treinador).
treinador_equipa([_ | Lst], Treinador) :- treinador_equipa(Lst, Treinador).

lista_treinadores(L) :- findall(Treinador, (treinadores(_, Treinadores), treinador_equipa(Treinadores, Treinador)), L).

duracao_treinadores(L) :- findall(
    NumJornadas-Treinador,
        (
            treinadores(_, Treinadores),
            treinador_equipa(Treinadores, Treinador), 
            getJornadas(Treinador, Treinadores, [Ini-Fin]),
            NumJornadas is Fin - Ini + 1
        ), Lst),
    keysort(Lst, RevL), reverse(RevL, L).

/*
calc_line(_, 1, _, [1]).
calc_line(N, N, LN1, [1 | Lst]) :- PrevIdx is N - 1,
                                    calc_line(N, PrevIdx, LN1, Lst).
calc_line(N, Idx, LN1, [Res | Lst]) :-   PrevIdx is Idx - 1,
                                        nth1(PrevIdx, LN1, S1),
                                        nth1(Idx, LN1, S2),
                                        Res is S1 + S2,
                                        calc_line(N, PrevIdx, LN1, Lst).

pascal(2, [1,1]) :- !.
pascal(1, [1]) :- !.
pascal(0, []) :- !.
pascal(N, L) :- PrevN is N - 1, 
                pascal(PrevN, L1),
                calc_line(N, N, L1, L).*/

:- dynamic factorial/2.

factorial(0, 1) :- !.
factorial(1, 1) :- !.
factorial(N, Res) :- N1 is N - 1,
                factorial(N1, Res1),
                Res is Res1*N,
                asserta((factorial(N, Res):-!)).

calc_line(_, 0, []) :- !.
calc_line(N, Idx, [Elem | Lst]) :- factorial(N, Quot),
                                   factorial(Idx, Div1),
                                   Diff is N - Idx,
                                   factorial(Diff, Div2),
                                   Div is Div1 * Div2,
                                   Elem is Quot div Div,
                                   NewIdx is Idx - 1,
                                   calc_line(N,NewIdx, Lst).

pascal(2, [1,1]) :- !.
pascal(1, [1]) :- !.
pascal(0, []) :- !.
pascal(N, L) :- calc_line(N, N, L), !.