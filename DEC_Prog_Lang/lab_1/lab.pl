parent(pame, bob).
parent(tom, bob).
parent(tom, lize).
parent(bob, anna).
parent(bob, pate).
parent(pate, jhim).

woman(pame).
woman(lize).
woman(pate).
woman(anna).
man(tom).
man(bob).
man(jhim).

mother(X, Y):- parent(X, Y), woman(X).

predok(X, Z):- parent(X, Z).
predok(X, Z):- parent(X, Y), predok(Y, Z). 
