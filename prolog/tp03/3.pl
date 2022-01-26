/* 3)
    a) vermelho
    b) verdes
 
*/

person(miro).
turtle(carlito).
spider(marquito).
bat(owo).


age(miro, 19).
age(carlito, 20).
age(marquito, 2).
age(owo, 3).

immature(X):- adult(X), !, fail.
immature(X).
adult(X):- person(X), !, age(X, N), N >=18.
adult(X):- turtle(X), !, age(X, N), N >=50.
adult(X):- spider(X), !, age(X, N), N>=1.
adult(X):- bat(X), !, age(X, N), N >=5.
