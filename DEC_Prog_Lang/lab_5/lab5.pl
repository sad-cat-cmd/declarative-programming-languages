% Предикат замены термов
replace(Old, New, Old, New) :- !.  
replace(_Old, _New, Term, Term) :- atomic(Term), !.  
replace(Old, New, Term, NewTerm) :-
    Term =.. [F|Args],
    replace_list(Old, New, Args, NewArgs),
    NewTerm =.. [F|NewArgs].

% Замена в списке аргументов
replace_list(_, _, [], []).
replace_list(Old, New, [H|T], [NH|NT]) :-
    replace(Old, New, H, NH),
    replace_list(Old, New, T, NT).

% Тестовый запрос
test :-
    % Исходная формула
    Source = plus(plus(plus(plus(mult(a,pow(x,4)), mult(b,pow(x,3))), 
             mult(c,pow(x,2))), mult(d,x)), e),
    
    % Заменяемая формула (шаблон для поиска)
    Old = mult(A,B),
    
    % Замещающая формула
    New = mult(inv(B),A),
    
    % Выполняем замену
    replace(Old, New, Source, Result),
    write('Результат: '), write(Result), nl.

% Запуск теста
:- test.
