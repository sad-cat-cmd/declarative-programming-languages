%:- dynamic interface/1.

interface('interface_ctrl_1').
interface('interface_ctrl_2').
interface('interface_ctrl_3').
interface('interface_ctrl_4').
interface('interface_photo_eye_control_1').
interface('interface_photo_eye_control_2').
interface('interface_photo_eye_control_3').
interface('interface_photo_eye_control_4').
interface('interface_photo_eye_divert_2').
interface('interface_diverter_2').


%:- dynamic event/1.

event('event_ctrl_1_inito').
event('event_ctrl_1_straight').
event('event_ctrl_1_divert').
event('event_ctrl_1_init').
event('event_ctrl_1_inc').
event('event_ctrl_1_dec').
event('event_ctrl_1_cnf_dvrt').
event('event_ctrl_1_is_bag').
event('event_ctrl_1_pusho').
event('event_ctrl_2_inito').
event('event_ctrl_2_straight').
event('event_ctrl_2_divert').
event('event_ctrl_2_init').
event('event_ctrl_2_inc').
event('event_ctrl_2_dec').
event('event_ctrl_2_cnf_dvrt').
event('event_ctrl_2_is_bag').
event('event_ctrl_2_pusho').
event('event_ctrl_3_inito').
event('event_ctrl_3_straight').
event('event_ctrl_3_divert').
event('event_ctrl_3_init').
event('event_ctrl_3_inc').
event('event_ctrl_3_dec').
event('event_ctrl_3_cnf_dvrt').
event('event_ctrl_3_is_bag').
event('event_ctrl_3_pusho').
event('event_ctrl_4_inito').
event('event_ctrl_4_straight').
event('event_ctrl_4_divert').
event('event_ctrl_4_init').
event('event_ctrl_4_inc').
event('event_ctrl_4_dec').
event('event_ctrl_4_cnf_dvrt').
event('event_ctrl_4_is_bag').
event('event_ctrl_4_pusho').
event('event_photo_eye_control_1_change').
event('event_photo_eye_control_2_change').
event('event_photo_eye_control_3_change').
event('event_photo_eye_control_4_change').
event('event_photo_eye_divert_2_change').
event('event_diverter_2_push').
event('event_diverter_2_cnf').


%:- dynamic is_part_of_interface/2.

is_part_of_interface('event_ctrl_1_inito', 'interface_ctrl_1').
is_part_of_interface('event_ctrl_1_straight', 'interface_ctrl_1').
is_part_of_interface('event_ctrl_1_divert', 'interface_ctrl_1').
is_part_of_interface('event_ctrl_1_init', 'interface_ctrl_1').
is_part_of_interface('event_ctrl_1_inc', 'interface_ctrl_1').
is_part_of_interface('event_ctrl_1_dec', 'interface_ctrl_1').
is_part_of_interface('event_ctrl_1_cnf_dvrt', 'interface_ctrl_1').
is_part_of_interface('event_ctrl_1_is_bag', 'interface_ctrl_1').
is_part_of_interface('event_ctrl_1_pusho', 'interface_ctrl_1').
is_part_of_interface('event_ctrl_2_inito', 'interface_ctrl_2').
is_part_of_interface('event_ctrl_2_straight', 'interface_ctrl_2').
is_part_of_interface('event_ctrl_2_divert', 'interface_ctrl_2').
is_part_of_interface('event_ctrl_2_init', 'interface_ctrl_2').
is_part_of_interface('event_ctrl_2_inc', 'interface_ctrl_2').
is_part_of_interface('event_ctrl_2_dec', 'interface_ctrl_2').
is_part_of_interface('event_ctrl_2_cnf_dvrt', 'interface_ctrl_2').
is_part_of_interface('event_ctrl_2_is_bag', 'interface_ctrl_2').
is_part_of_interface('event_ctrl_2_pusho', 'interface_ctrl_2').
is_part_of_interface('event_ctrl_3_inito', 'interface_ctrl_3').
is_part_of_interface('event_ctrl_3_straight', 'interface_ctrl_3').
is_part_of_interface('event_ctrl_3_divert', 'interface_ctrl_3').
is_part_of_interface('event_ctrl_3_init', 'interface_ctrl_3').
is_part_of_interface('event_ctrl_3_inc', 'interface_ctrl_3').
is_part_of_interface('event_ctrl_3_dec', 'interface_ctrl_3').
is_part_of_interface('event_ctrl_3_cnf_dvrt', 'interface_ctrl_3').
is_part_of_interface('event_ctrl_3_is_bag', 'interface_ctrl_3').
is_part_of_interface('event_ctrl_3_pusho', 'interface_ctrl_3').
is_part_of_interface('event_ctrl_4_inito', 'interface_ctrl_4').
is_part_of_interface('event_ctrl_4_straight', 'interface_ctrl_4').
is_part_of_interface('event_ctrl_4_divert', 'interface_ctrl_4').
is_part_of_interface('event_ctrl_4_init', 'interface_ctrl_4').
is_part_of_interface('event_ctrl_4_inc', 'interface_ctrl_4').
is_part_of_interface('event_ctrl_4_dec', 'interface_ctrl_4').
is_part_of_interface('event_ctrl_4_cnf_dvrt', 'interface_ctrl_4').
is_part_of_interface('event_ctrl_4_is_bag', 'interface_ctrl_4').
is_part_of_interface('event_ctrl_4_pusho', 'interface_ctrl_4').
is_part_of_interface('event_photo_eye_control_1_change', 'interface_photo_eye_control_1').
is_part_of_interface('event_photo_eye_control_2_change', 'interface_photo_eye_control_2').
is_part_of_interface('event_photo_eye_control_3_change', 'interface_photo_eye_control_3').
is_part_of_interface('event_photo_eye_control_4_change', 'interface_photo_eye_control_4').
is_part_of_interface('event_photo_eye_divert_2_change', 'interface_photo_eye_divert_2').
is_part_of_interface('event_diverter_2_push', 'interface_diverter_2').
is_part_of_interface('event_diverter_2_cnf', 'interface_diverter_2').


%:- dynamic has_interface/2.

has_interface('ctrl_1', 'interface_ctrl_1').
has_interface('ctrl_2', 'interface_ctrl_2').
has_interface('ctrl_3', 'interface_ctrl_3').
has_interface('ctrl_4', 'interface_ctrl_4').
has_interface('photo_eye_control_1', 'interface_photo_eye_control_1').
has_interface('photo_eye_control_2', 'interface_photo_eye_control_2').
has_interface('photo_eye_control_3', 'interface_photo_eye_control_3').
has_interface('photo_eye_control_4', 'interface_photo_eye_control_4').
has_interface('photo_eye_divert_2', 'interface_photo_eye_divert_2').
has_interface('diverter_2', 'interface_diverter_2').


%:- dynamic fb_control_block/1.

fb_control_block('ctrl_1').
fb_control_block('ctrl_2').
fb_control_block('ctrl_3').
fb_control_block('ctrl_4').


%:- dynamic connected_with/2.

connected_with('event_ctrl_1_inito', 'event_ctrl_2_init').
connected_with('event_ctrl_1_straight', 'event_ctrl_2_inc').
connected_with('event_ctrl_2_inito', 'event_ctrl_3_init').
connected_with('event_ctrl_2_straight', 'event_ctrl_3_inc').
connected_with('event_ctrl_2_inito', 'event_ctrl_4_init').
connected_with('event_ctrl_2_divert', 'event_ctrl_4_inc').
connected_with('event_photo_eye_control_1_change', 'event_ctrl_1_dec').
connected_with('event_photo_eye_control_2_change', 'event_ctrl_2_dec').
connected_with('event_photo_eye_control_3_change', 'event_ctrl_3_dec').
connected_with('event_photo_eye_control_4_change', 'event_ctrl_4_dec').
connected_with('event_ctrl_2_pusho', 'event_diverter_2_push').
connected_with('event_diverter_2_cnf', 'event_ctrl_2_cnf_dvrt').
connected_with('event_photo_eye_divert_2_change', 'event_ctrl_2_is_bag').


%:- dynamic fb_diverter/1.

fb_diverter('diverter_2').


%:- dynamic has_name/2.

has_name('event_ctrl_1_inito', inito).
has_name('event_ctrl_1_straight', straight).
has_name('event_ctrl_1_divert', divert).
has_name('event_ctrl_1_init', init).
has_name('event_ctrl_1_inc', inc).
has_name('event_ctrl_1_dec', dec).
has_name('event_ctrl_1_cnf_dvrt', cnf_dvrt).
has_name('event_ctrl_1_is_bag', is_bag).
has_name('event_ctrl_1_pusho', pusho).
has_name('event_ctrl_2_inito', inito).
has_name('event_ctrl_2_straight', straight).
has_name('event_ctrl_2_divert', divert).
has_name('event_ctrl_2_init', init).
has_name('event_ctrl_2_inc', inc).
has_name('event_ctrl_2_dec', dec).
has_name('event_ctrl_2_cnf_dvrt', cnf_dvrt).
has_name('event_ctrl_2_is_bag', is_bag).
has_name('event_ctrl_2_pusho', pusho).
has_name('event_ctrl_3_inito', inito).
has_name('event_ctrl_3_straight', straight).
has_name('event_ctrl_3_divert', divert).
has_name('event_ctrl_3_init', init).
has_name('event_ctrl_3_inc', inc).
has_name('event_ctrl_3_dec', dec).
has_name('event_ctrl_3_cnf_dvrt', cnf_dvrt).
has_name('event_ctrl_3_is_bag', is_bag).
has_name('event_ctrl_3_pusho', pusho).
has_name('event_ctrl_4_inito', inito).
has_name('event_ctrl_4_straight', straight).
has_name('event_ctrl_4_divert', divert).
has_name('event_ctrl_4_init', init).
has_name('event_ctrl_4_inc', inc).
has_name('event_ctrl_4_dec', dec).
has_name('event_ctrl_4_cnf_dvrt', cnf_dvrt).
has_name('event_ctrl_4_is_bag', is_bag).
has_name('event_ctrl_4_pusho', pusho).
has_name('photo_eye_control_1', control).
has_name('photo_eye_control_2', control).
has_name('event_photo_eye_control_1_change', change).
has_name('event_photo_eye_control_2_change', change).
has_name('photo_eye_control_3', control).
has_name('event_photo_eye_control_3_change', change).
has_name('photo_eye_control_4', control).
has_name('event_photo_eye_control_4_change', change).
has_name('photo_eye_divert_2', divert).
has_name('event_photo_eye_divert_2_change', change).
has_name('event_diverter_2_push', push).
has_name('event_diverter_2_cnf', cnf).


%:- dynamic has_id/2.

has_id('ctrl_1', '1').
has_id('ctrl_2', '2').
has_id('ctrl_3', '3').
has_id('ctrl_4', '4').
has_id('photo_eye_control_1', '1').
has_id('photo_eye_control_2', '2').
has_id('photo_eye_control_3', '3').
has_id('photo_eye_control_4', '4').
has_id('photo_eye_divert_2', '2').
has_id('diverter_2', '2').


%:- dynamic fb_photo_eye/1.

fb_photo_eye('photo_eye_control_1').
fb_photo_eye('photo_eye_control_2').
fb_photo_eye('photo_eye_control_3').
fb_photo_eye('photo_eye_control_4').
fb_photo_eye('photo_eye_divert_2').
