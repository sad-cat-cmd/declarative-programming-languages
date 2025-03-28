% Правило замены: replace(OriginalTerm, Pattern, Replacement, NewTerm)
replace(Term, Term, Replacement, Replacement).  % Базовый случай: если терм совпадает с шаблоном, заменяем его
replace(Term, Pattern, Replacement, Term) :- 
    \+ compound(Term),  % Если Term — атомарный (не составной), оставляем его без изменений
    Term \= Pattern.    % ...и он не совпадает с шаблоном

% Рекурсивная замена в составных термах
replace(Term, Pattern, Replacement, NewTerm) :-
    compound(Term),     % Term — составной (например, plus(...), mult(...) и т.д.)
    Term =.. [Functor | Args],  % Разбираем терм на функтор и аргументы
    replace_args(Args, Pattern, Replacement, NewArgs),  % Рекурсивно заменяем в аргументах
    NewTerm =.. [Functor | NewArgs].  % Собираем новый терм

% Рекурсивная замена в списке аргументов
replace_args([], _, _, []).
replace_args([Arg | Args], Pattern, Replacement, [NewArg | NewArgs]) :-
    replace(Arg, Pattern, Replacement, NewArg),  % Заменяем в текущем аргументе
    replace_args(Args, Pattern, Replacement, NewArgs).  % Заменяем в остальных аргументах

% Пример использования:
transform :-
    OriginalFormula = plus(plus(plus(plus(mult(a, pow(x, 4)), mult(b, pow(x, 3))), mult(c, pow(x, 2))), mult(d, x)), e),
    Pattern = mult(A, B),  % Шаблон для замены (A и B — переменные!)
    Replacement = mult(inv(B), A),  % Замещающий терм
    replace(OriginalFormula, Pattern, Replacement, NewFormula),
    write('Transformed formula: '), write(NewFormula), nl.
