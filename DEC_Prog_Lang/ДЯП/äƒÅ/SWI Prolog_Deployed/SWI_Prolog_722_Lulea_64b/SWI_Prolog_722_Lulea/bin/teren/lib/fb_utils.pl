% consult('eswrl.pl').

% init_fb(fb,[events]).
init_fb(X,[]) :-                string_concat('interface_', X, I),
                                createInstance(interface, I),
                                createLink(has_interface, X, I).

init_fb(X, [H|T]) :-            string_concat('event_', X, N1),
                                string_concat(N1, '_', N2),
                                string_concat(N2, H, E),
                                createInstance(event, E),
                                createLink(has_name, E, H),

                                string_concat('interface_', X, I),
                                createLink(is_part_of_interface, E, I),
                                
                                init_fb(X,T).

generate_name(Parent, Prefix, Name) :- has_id(Parent, Id), string_concat(Prefix, '_', Name1), string_concat(Name1, Id, Name).
