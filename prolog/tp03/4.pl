/* 4) */

print_n(_, 0).
print_n(S,N) :- put_char(S), N1 is N-1, print_n(S, N1).

print_string("").
print_string([S | T]) :- char_code(Char, S), 
                         write(Char),
                         print_string(T).

print_text(Text, Symbol, Padding) :- put_char(Symbol),
                                     print_n(' ', Padding),
                                     print_string(Text), 
                                     print_n(' ', Padding), 
                                     put_char(Symbol).

print_edge(Symbol, Padding) :- put_char(Symbol), print_n(' ', Padding), put_char(Symbol), nl.

print_pre_banner(Text, Symbol, Padding) :- length(Text, StringSize),
                                    NewPadding is (2 * Padding) + StringSize,
                                    SymbolsOnly is NewPadding + 2,
                                    print_n(Symbol, SymbolsOnly), nl,
                                    print_edge(Symbol, NewPadding).

print_end_banner(Text, Symbol, Padding) :- length(Text, StringSize),
                                    NewPadding is (2 * Padding) + StringSize,
                                    SymbolsOnly is NewPadding + 2,
                                    print_edge(Symbol, NewPadding),
                                    print_n(Symbol, SymbolsOnly), nl.

print_banner(Text, Symbol, Padding) :-  print_pre_banner(Text, Symbol, Padding),
                                        print_text(Text, Symbol, Padding), nl,
                                        print_end_banner(Text, Symbol, Padding).


read_number_inner(X, X) :- peek_code(10), !.

read_number_inner(X, Y) :- integer(X), !,
                            get_code(Code),
                            Number is Code - 48,
                            Number >= 0,
                            Number < 10,
                            NewTerm is (10 * X) + Number,
                            read_number_inner(NewTerm, Y).

read_number_inner(X, Y) :- get_code(Code),
                            Number is Code - 48,
                            read_number_inner(Number, Y).

read_number(Y) :- read_number_inner(X, Y), get_code(10).

read_until_between(Min, Max, Value) :- repeat,
                                       read_number(Value),
                                       Value >= Min,
                                       Value =< Max,
                                       !.

read_string("") :- peek_code(10), !, get_code(10).
read_string([Char | T]) :- get_code(Char),
                           read_string(T).

banner :- read_string(Text), get_char(Symbol), get_code(10), read_number(Padding), print_banner(Text, Symbol, Padding).

biggest([], []).
biggest([Biggest | T], Biggest) :- length(Biggest, BiggestLen),
                                   biggest(T, SecondBiggest),
                                   length(SecondBiggest, SecondBiggestLen),
                                   SecondBiggestLen =< BiggestLen,
                                   !.
biggest([_ | T], Biggest) :- biggest(T, Biggest).


print_texts([], _, _, _).

print_texts([Text | Tail], Symbol, Padding, Biggest) :- length(Text, CurLength),
                                                        0 is CurLength mod 2,
                                                        char_code(' ', Space),
                                                        append(Text, [Space], NewText),
                                                        print_texts([NewText | Tail], Symbol, Padding, Biggest).

print_texts([Text | Tail], Symbol, Padding, Biggest) :- length(Biggest, MaxLength),
                                                        length(Text, CurLength),
                                                        NewPadding is Padding + (MaxLength - CurLength)//2, 
                                                        print_text(Text, Symbol, NewPadding), nl,
                                                        print_texts(Tail, Symbol, Padding, Biggest).

print_multi_banner(ListOfTexts, Symbol, Padding) :- biggest(ListOfTexts, Biggest),
                                                    print_pre_banner(Biggest, Symbol, Padding),
                                                    print_texts(ListOfTexts, Symbol, Padding, Biggest),
                                                    print_end_banner(Biggest, Symbol, Padding).


oh_christmas_tree(N) :- oh_christmas_tree(0, N).
oh_christmas_tree(Acc, N) :- Acc is N,
                             print_text("*", '', N),
                             !.
oh_christmas_tree(Acc, N) :- char_code('*', Asterisk),
                             NLeaves is Acc*2,
                             repeat(NLeaves, Asterisk, Leaves),
                             append(Leaves, [Asterisk], Section),
                             Padding is N-Acc,
                             print_text(Section, '', Padding), nl,
                             NewAcc is Acc+1,
                             oh_christmas_tree(NewAcc, N).


                                                 