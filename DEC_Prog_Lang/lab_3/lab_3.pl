append([], L, L).
append([H|T], L2, [H|R]) :- append(T, L2, R). 


