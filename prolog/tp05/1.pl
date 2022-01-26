:-use_module(library(lists)).

% map(+Pred, +List1, ?List2)

double(X,Y) :- Y is X*2.

map(_, [], []).
map(Pred, [H | T], [R | K]) :- G =.. [Pred, H, R], G,
                               map(Pred, T, K).

% fold(+Pred, +StartValue, +List, ?FinalValue),

sum(A, B, S):- S is A+B.

fold(_, Value, [], Value).
fold(Pred, StartValue, [H | T], FinalValue) :- G =.. [Pred, StartValue, H, Folded], G,
                                                   fold(Pred, Folded, T, FinalValue).

% separate(+List, +Pred, -Yes, -No)

even(X):- 0 is (X mod 2).

separate([], _Pred, [], []).
separate([H | T], Pred, [H | YT], N) :- G =.. [Pred, H], G, !, separate(T, Pred, YT, N).
separate([H | T], Pred, Y, [H | NT]) :- separate(T, Pred, Y, NT).

% ask_execute/0

get_args(0, _, []).
get_args(Arity, Goal, [H | T]) :- arg(Arity, Goal, H),
                                  NewVal is Arity - 1,
                                  get_args(NewVal, Goal, T).

%ask_execute :- format("Insira o que deseja executar", []), nl,
%               read(Goal),
%               functor(Goal, Name, Arity),
%               get_args(Arity, Goal, Args),
%               reverse(Args, ReversedArgs),
%               G =.. [Name | ReversedArgs], G.

ask_execute :- format("Insira o que deseja executar", []), nl,
               read(Goal), Goal.