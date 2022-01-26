:-use_module(library(ordsets)).

leciona(algoritmos, adalberto).
leciona(bases_de_dados, bernardete).
leciona(compiladores, capitolino).
leciona(estatistica, diogenes).
leciona(redes, ermelinda).


frequenta(algoritmos, alberto).
frequenta(algoritmos, bruna).
frequenta(algoritmos, cristina).
frequenta(algoritmos, diogo).
frequenta(algoritmos, eduarda).

frequenta(bases_de_dados, antonio).
frequenta(bases_de_dados, bruno).
frequenta(bases_de_dados, cristina).
frequenta(bases_de_dados, duarte).
frequenta(bases_de_dados, eduardo).

frequenta(compiladores, alberto).
frequenta(compiladores, bernardo).
frequenta(compiladores, clara).
frequenta(compiladores, diana).
frequenta(compiladores, eurico).

frequenta(estatistica, antonio).
frequenta(estatistica, bruna).
frequenta(estatistica, claudio).
frequenta(estatistica, duarte).
frequenta(estatistica, eva).

frequenta(redes, alvaro).
frequenta(redes, beatriz).
frequenta(redes, claudio).
frequenta(redes, diana).
frequenta(redes, eduardo).

% teachers(-T)

teachers(T) :- setof(T, UC^leciona(UC, T), T).

% students_of(+T, -S)

aluno(S, T) :- frequenta(UC, S), leciona(UC, T).

students_of(T, S) :- setof(S, aluno(S,T), S).

% teachers_of(+S, -T)

teachers_of(S, T) :- setof(T, aluno(S,T), T).

%  common_courses(+S1, +S2, -C)

common_courses(S1, S2, UCs) :- setof(UC, (frequenta(UC, S1), frequenta(UC, S2)), UCs).

% more_than_one_course(-L) 

more_than_one_course(L) :- setof(S, (UC1, UC2)^(frequenta(UC1, S), frequenta(UC2, S), UC1 \= UC2), L).


remove_equi_pairs([], Acc, Acc).
remove_equi_pairs([S1-S2 | T], Acc, R) :-  \+ memberchk(S2-S1, Acc), !,
                                        remove_equi_pairs(T, [S1-S2 | Acc], R).
remove_equi_pairs([_ | T], Acc, R) :- remove_equi_pairs(T, Acc, R).

% strangers(-L) 

strangers(L) :- setof(S1-S2, (UC1, UC2)^(frequenta(UC1,S1), frequenta(UC2, S2), S1 \= S2) , All),
                setof(S1-S2, UC^(frequenta(UC, S1), frequenta(UC, S2), S1 \= S2) , Colleagues),
                ord_subtract(All, Colleagues, Res),
                remove_equi_pairs(Res, [], L).

% good_groups(-L)

good_groups(L) :- setof(S1-S2, (UC1, UC2)^(frequenta(UC1, S1), frequenta(UC1, S2), frequenta(UC2, S1), frequenta(UC2, S2), S1 \= S2, UC1 \= UC2), Res),
                  remove_equi_pairs(Res, [], L).