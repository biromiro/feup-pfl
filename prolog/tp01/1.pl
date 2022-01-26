female(grace).
female(dede).
female(gloria).
female(merle).
female(claire).
female(cameron).
female(pameron).
female(haley).
female(lily).
female(poppy).

male(frank).
male(jay).
male(javier).
male(barb).
male(phil).
male(mitchell).
male(joe).
male(manny).
male(bo).
male(dylan).
male(alex).
male(luke).
male(rexford).
male(calhoun).
male(george).

parent(phil, grace).
parent(phil, frank).
parent(claire, dede).
parent(claire, jay).
parent(mitchell, dede).
parent(mitchell, jay).
parent(joe, jay).
parent(joe, gloria).
parent(manny, gloria).
parent(manny, javier).
parent(cameron, barb).
parent(cameron, merle).
parent(pameron, barb).
parent(pameron, merle).
parent(haley, phil).
parent(haley, claire).
parent(alex, phil).
parent(alex, claire).
parent(luke, phil).
parent(luke, claire).
parent(lily, mitchell).
parent(lily, cameron).
parent(rexford, mitchell).
parent(rexford, cameron).
parent(calhoun, pameron).
parent(calhoun, bo).
parent(george, dylan).
parent(george, haley).
parent(poppy, dylan).
parent(poppy, haley).

grandparent(X,Z) :- parent(Y,Z) , parent(X,Y).
grandmother(X,Y) :- grandparent(X,Y) , female(Y).
grandfather(X,Y) :- grandparent(X,Y) , male(Y).
father(X,Y) :- parent(X,Y) , male(Y).
mother(X,Y) :- parent(X,Y) , female(Y).
son(Y,X) :- parent(X,Y) , male(X).
daughter(Y,X) :- parent(X,Y) , female(X).
siblings(X,Y) :- parent(X,M) , parent(Y,M), parent(X,F), parent(Y,F), (X\=Y).
halfsiblings(X,Y) :- parent(X,K) , parent(Y,K) , \+siblings(X,Y).
uncle(X,Z) :- parent(X,K) , siblings(K,Z), male(Z).
aunt(X,Z) :- parent(X,K) , siblings(K,Z), female(Z).
cousins(X,Y) :- parent(X,K) , parent(Y,L) , siblings(K,L).

married(jay,gloria,2008).
married(jay,dede,1968).
divorced(jay,dede,2003).
