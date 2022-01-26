/* 2) 
    a) one; two; three; five.
    b) one;
    c) one, one; one, two; one, three;
*/

data(one).
data(two).
data(three).

cut_test_a(X) :- data(X).
cut_test_a('five').

cut_test_b(X) :- data(X), !.
cut_test_b('five').

cut_test_c(X,Y) :- data(X), !, data(Y).
cut_test_c('five').