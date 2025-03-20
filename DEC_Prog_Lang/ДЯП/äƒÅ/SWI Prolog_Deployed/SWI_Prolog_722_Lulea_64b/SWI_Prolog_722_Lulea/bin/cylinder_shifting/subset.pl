a(b).
a(r).
a(d).
a(e).

sub_set([], []).
sub_set([X|Y],[X|W]) :- sub_set(Y,W).
sub_set(X,[_|Z]) :- sub_set(X, Z).

subset_a([]).
subset_a(XS) :- a(L), a(R), middle(L, R, Z), sub_set(X, Z), uni([L|X], [R], XS).

middle(X, X, []) :- !.
middle(X, Y, Middle) :- before(X, XB), before(Y, YB), member(X, YB), diff(YB, [X|XB], Middle).

before(X, Y) :- before(X, [], Y).
before(X, E, Y) :- a(XB), not(member(XB, E)), !, fringe(X, XB, E, Y).

fringe(X, X, E, E) :- !.
fringe(X, XB, E, Y) :- before(X, [XB|E], Y).

diff(X, [], X) :- !.
diff([], _, []) :- !.
diff([X|XS], Y, [X|YS]) :- not(member(X, Y)), !, diff(XS, Y, YS).
diff([_|XS], Y, YS) :- diff(XS, Y, YS).

uni(X, [], X) :- !.
uni([], X, X) :- !.
uni([X|XS], Y, [X|YS]) :- not(member(X,Y)), !, uni(XS, Y, YS).
uni([_|XS], Y, YS) :- uni(XS, Y, YS).