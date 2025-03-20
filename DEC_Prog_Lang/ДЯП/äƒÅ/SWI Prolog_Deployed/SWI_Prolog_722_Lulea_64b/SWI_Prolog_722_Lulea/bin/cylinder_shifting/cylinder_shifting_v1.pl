ext(c1,4).
ext(c2,1).
ext(c3,2).

offset(5).


seq([],0).
seq([F|T],L):-
ext(F,Ext), seq(T,L2), not(member(F,T)), L is (L2+Ext).
