:- dynamic connected_with/2.

% Первый этап трансформации:
step_1 :-   convey(C), has_id(C, Id), 
            /* -> */
            generate_name(C, 'ctrl', N), 
            createInstance(fb_control_block, N),
            createLink(has_id, N, Id),
            init_fb(N, [inito, straight, divert, init, inc, dec, cnf_dvrt, is_bag, pusho]).


% Второй этап трансформации:
step_2 :-   convey(C1), convey(C2), 
            has_straight_connection(C1, C2), 
            has_id(C1, Id1), has_id(C2, Id2),

            fb_control_block(Ct1), fb_control_block(Ct2), 
            has_id(Ct1, Id1), has_id(Ct2, Id2),

            has_interface(Ct1, I1), has_interface(Ct2, I2),

            is_part_of_interface(E1, I1), has_name(E1, 'inito'),
            is_part_of_interface(E2, I1), has_name(E2, 'straight'),
            is_part_of_interface(E3, I2), has_name(E3, 'init'),
            is_part_of_interface(E4, I2), has_name(E4, 'inc'),                               
            /* -> */
			createLink(connected_with, E1, E3), createLink(connected_with, E2, E4).


step_2 :-   convey(C1), convey(C2), 
            has_divert_connection(C1, C2), 
            has_id(C1, Id1), has_id(C2, Id2),

            fb_control_block(Ct1), fb_control_block(Ct2), 
            has_id(Ct1, Id1), has_id(Ct2, Id2),

            has_interface(Ct1, I1), has_interface(Ct2, I2),

            is_part_of_interface(E1, I1), has_name(E1, 'inito'),
            is_part_of_interface(E2, I1), has_name(E2, 'divert'),
            is_part_of_interface(E3, I2), has_name(E3, 'init'),
            is_part_of_interface(E4, I2), has_name(E4, 'inc'),                               
            /* -> */
			createLink(connected_with, E1, E3), createLink(connected_with, E2, E4).


% Третий этап трансформации:
step_3 :-   fb_control_block(Ct1), fb_control_block(Ct2), 
            has_id(Ct1, Id1), has_id(Ct2, Id2),

            has_interface(Ct1, I1), has_interface(Ct2, I2),

            is_part_of_interface(E1, I1), has_name(E1, 'inito'),
            is_part_of_interface(E2, I2), has_name(E2, 'init'),

            connected_with(E1, E2),
            /* -> */
            generate_name(Ct1, 'photo_eye_control', P1), generate_name(Ct2, 'photo_eye_control', P2), 
            createInstance(fb_photo_eye, P1), createInstance(fb_photo_eye, P2),
            createLink(has_id, P1, Id1), createLink(has_id, P2, Id2),
            createLink(has_name, P1, 'control'), createLink(has_name, P2, 'control'), 
            init_fb(P1, [change]), init_fb(P2, [change]).          


% Четвертый этап трансформации:
step_4 :-   fb_photo_eye(P), has_name(P, 'control'), has_id(P, Id),
            fb_control_block(Ct), has_id(Ct, Id),

            has_interface(Ct, I1), has_interface(P, I2), 

            is_part_of_interface(E1, I1), has_name(E1, 'dec'),
            is_part_of_interface(E2, I2), has_name(E2, 'change'),
            
            /* -> */
            createLink(connected_with, E2, E1).


% Пятый этап трансформации:
step_5 :-   fb_control_block(Ct),
            has_id(Ct, Id),
            has_interface(Ct, I1),

            is_part_of_interface(E1, I1), has_name(E1, 'divert'),
            connected_with(E1, _),
            /* -> */
            generate_name(Ct, 'photo_eye_divert', P),
            createInstance(fb_photo_eye, P),
            createLink(has_id, P, Id), 
            createLink(has_name, P, 'divert'),

            generate_name(Ct, 'diverter', Div),
            createInstance(fb_diverter, Div),
            createLink(has_id, Div, Id),

            init_fb(P, [change]), init_fb(Div, [push, cnf]).



% Шестой этап трансформации:
step_6 :-   fb_photo_eye(P), has_name(P, 'divert'), has_id(P, Id),
            fb_diverter(Div), has_id(Div, Id),
            fb_control_block(Ct), has_id(Ct, Id),

            has_interface(Ct, I1), has_interface(P, I2), has_interface(Div, I3),

            is_part_of_interface(E1, I1), has_name(E1, 'cnf_dvrt'),
            is_part_of_interface(E2, I1), has_name(E2, 'is_bag'),
            is_part_of_interface(E3, I1), has_name(E3, 'pusho'),
            is_part_of_interface(E4, I2), has_name(E4, 'change'),
            is_part_of_interface(E5, I3), has_name(E5, 'push'),
            is_part_of_interface(E6, I3), has_name(E6, 'cnf'),
            /* -> */
		    createLink(connected_with, E3, E5),
		    createLink(connected_with, E6, E1), 
		    createLink(connected_with, E4, E2).


% Функция общей трансформации:
transform_onto :- step_1; step_2; step_3; step_4; step_5; step_6.
