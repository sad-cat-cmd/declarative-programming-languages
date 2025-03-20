parent(man_2, man_1).
parent(man_3, man_2).
parent(man_4, man_3).

parent(man_6, man_7).
parent(man_7, man_8).
parent(man_5, man_9).
parent(man_10, man_6).
parent(man_10, man_4).
parent(girl_2, man_2).
parent(man_4, man_5).

woman(girl_1).
woman(girl_2).

man(man_1).
man(man_2).
man(man_3).
man(man_4).
man(man_5).
man(man_6).
man(man_7).
man(man_8).
man(man_9).
man(man_10).

husband(man_2, girl_1).

wife(girl_1, man_2).

mother(X, Y):- 
    parent(X, Y),
    woman(X).
father(X, Y):- 
    parent(X, Y), 
    man(X).
brother(X, Y):- 
    parent(T, X),
    parent(T, Y),
    man(X), 
    X\=Y.
second_coustin_uncle(X, Y) :-
    man(X),
    parent(P_X, X),
    parent(GP_X, P_X),
    parent(P_Y, Y),
    parent(GP_Y, P_Y),
    parent(GGP_Y, GP_Y),
    brother(GP_X, GGP_Y).
n_coustin_uncle(1, X, Y) :-
    parent(P_Y, Y),
    parent(PP_Y, P_Y),
    brother(P_X, PP_Y),
    parent(P_X, X).
    
n_coustin_uncle(N, X, Y) :-
    parent(P_Y, Y),
    parent(P_X, X),
    N1 is N - 1,
    n_coustin_uncle(N1, P_X, P_Y).
any_coustin_uncle(N, X, Y) :-
    n_coustin_uncle(N, X, Y).

husband_mother(HusbandMother, Wife) :-
    husband(Husband, Wife),
    mother(HusbandMother, Husband).

grandson(Grandson, Grandparent) :-
    parent(Grandparent, Parent),
    parent(Parent, Grandson).

n_grandson(1, S, GGP) :-
    man(S),
    parent(P_S, S),
    parent(GP_S, P_S),
    parent(GGP, GP_S).

n_grandson(N, S, GGP) :-
    N > 1,
    N1 is N-1,
    parent(P_GGP, GGP),
    n_grandson(N1, S, P_GGP).
