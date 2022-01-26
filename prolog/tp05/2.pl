:-use_module(library(lists)).

% my_arg(Index, Term, Arg).

my_arg(Index, Term, Arg) :- Term =.. [_Name | Args],
                            nth1(Index, Args, Arg).

% my_functor(Term, Name, Arity).

my_functor(Term, Name, Arity) :- Term =.. [Name | Args],
                                 length(Args, Arity).

get_args(0, _, []).
get_args(Arity, Goal, [H | T]) :- arg(Arity, Goal, H),
                                  NewVal is Arity - 1,
                                  get_args(NewVal, Goal, T).

univ(Term, [Name | Args]) :- functor(Term, Name, Arity),
                             get_args(Arity, Term, RevArgs),
                             reverse(RevArgs, Args).

:-op(1, xfx, univ).

na(X,Y) :- Y is X * 2.

:-op(500, xfx, na).
:-op(500, yfx, la).
:-op(500, xfy, ra).

