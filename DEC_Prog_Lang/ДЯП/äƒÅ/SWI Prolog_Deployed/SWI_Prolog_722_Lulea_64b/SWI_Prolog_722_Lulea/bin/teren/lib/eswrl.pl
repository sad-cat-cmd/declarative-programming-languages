createInstance(Class, Instance) :- functor(X, Class, 1), arg(1,X,Instance), dynamic(Class/1), (not(X), assertz(X); X).
createLink(Link, Instance1, Instance2) :- functor(X, Link, 2), arg(1,X,Instance1), arg(2,X,Instance2), dynamic(Link/2), (not(X), assertz(X); X).
