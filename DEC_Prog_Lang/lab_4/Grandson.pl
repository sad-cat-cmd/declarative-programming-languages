grandson(Grandson, Grandparent) :-
    parent(Grandparent, Parent),
    parent(Parent, Grandson).