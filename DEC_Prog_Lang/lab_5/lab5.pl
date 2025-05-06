% Предикат для замены подтерма
replace(Term, Old, New, Result) :-
    Term == Old, !,
    Result = New.
replace(Term, _, _, Term) :-
    atomic(Term), !.
replace(Term, Old, New, Result) :-
    compound(Term),
    Term =.. [Functor|Args],
    replace_list(Args, Old, New, NewArgs),
    Result =.. [Functor|NewArgs].

% Предикат для замены в списке аргументов
replace_list([], _, _, []).
replace_list([H|T], Old, New, [NewH|NewT]) :-
    replace(H, Old, New, NewH),
    replace_list(T, Old, New, NewT).

% Основной предикат для трансформации формулы
transform(Formula, Old, New, Result) :-
    replace(Formula, Old, New, Result).


