/* PROLOG-program for transforming IEC 61850 ontology to IEC 61499 ontology (a simple transformation rules interpreter) */
/* Version 3a */ 
/* FUNCTIONALITY: 
1) mapping IEC 61850 DO-types and DA-variables to IEC 61499 structure data type variables
2) mapping IEC 61850 LN to IEC 61499 FB instances
3) mapping IEC 61850 DO to IEC 61499 FB input and output variables
4) mapping IEC 61850 LN-connections to IEC 61499 FB- connections
*/
/* INPUT: IEC 61850 ontology based on PROLOG (i.e. after OWL Thea2 processing). Only facts of this ontology should be used. 
   All the axioms in the form of Prolog-rules have to be commented because they has not influence on the results but substantially increase the processing time */
/* OUTPUT:  IEC 61499 ontology based on PROLOG. The newly generated facts of this ontology are output to separate files (it is for simplicity and convenience). 
  The important fact are written to file ''FB_onlology_in_Prolog_4_rules'' while the auxiliary facts are written to file 'Subsidiary_info_4_rules' */
/* Feature:  Usage of "Single iterative sequential execution model" for all rules */

/* ------------------------------------------------------ */

/* Top-level transformation procedure ( a simple interpreter )*/

run_transformation:- 
assert(count_id(1)), 
run_rule11, 
run_rule12, 
run_rule2, 
run_rule31,
run_rule32,
run_rule4,
open('FB_onlology_in_Prolog_4_rules', write, S), 
set_output(S),
list_predicates1('FunctionBlock'), 
list_predicates1('EventOutput'), 
list_predicates1('EventInput'), 	
list_predicates1('OutputVariable'), 
list_predicates1('InputVariable'), 
list_predicates1('StructureType'),
list_predicates1('StructureTypeVariable'),
list_predicates2(is_part_of_FB), 
list_predicates2(e_connect_to), 
list_predicates2(d_connect_to), 
list_predicates2(has_structureVar),
list_predicates2(has_FB_type), 
list_predicates2(hasType), 
list_predicates2(hasName), 
close(S),
open('Subsidiary_info_4_rules', write, S2), 
set_output(S2),
list_predicates2(has_LN_id), 
list_predicates2(hasLNtype), 
list_predicates2(associate), 
list_predicates1(count_id), 
close(S2).

/* --- */

/* Rule 1. Transforming DO-type of IEC 61850 to Structure data type of IEC61499 */

/* Rule1.1 – Creating StructureTypes using DOTypes */

run_rule11:-
'DOType'(Dot),
has_id(Dot, Id),
/* -> */
get_id(St),
createInstance('StructureType', St),
createLink(associate, Dot, St),
createLink(hasName, St, Id),
fail.
run_rule11.

/* Rule1.2 – Creating StructureTypeVariables using DA-elements */

run_rule12:-
'StructureType'(St),
'DOType'(Dot),
associate(Dot, St),
'DA'(Da),
has_DA(Dot, Da),
has_name(Da, DAName),
has_type(Da, Type),
/* -> */
get_id(Stv),
createInstance('StructureTypeVariable', Stv),
createLink(has_structureVar, St, Stv),
createLink(hasName, Stv, DAName),
createLink(hasType, Stv, Type),
fail.
run_rule12.

/* Rule 2. Creating FB instance (using LN instance) */

run_rule2:- 
'LN'(Ln),
has_prefix(Ln, Pr),
has_inst(Ln, Inst),
has_lnType(Ln, T),
/* -> */
get_id(Id_fb),
createInstance('FunctionBlock', Id_fb),
get_id(Id_eo),
createInstance('EventOutput', Id_eo),
get_id(Id_ei),
createInstance('EventIntput', Id_ei),
createLink(associate, Ln, Id_fb),
createLink(is_part_of_FB, Id_eo, Id_fb),
createLink(is_part_of_FB, Id_ei, Id_fb),
string_concat(T, “_”, L1), string_concat(L1, Pr, L2), 
string_concat(L2, “_”, L3), string_concat(L3, Inst, L4), atom_string(FBType_name, L4),
createLink(has_FB_type, Id_fb, FBType_name),  
createLink(hasLNtype, Id_fb, T), /* Добавлено */ 
string_concat(“fb_”, T, N1), string_concat(N1, “_”, N2), string_concat(N2, Pr, N3),
string_concat(N3, “_”, N4), string_concat(N4, Inst, N5), atom_string(FB_name, N5),
createLink(hasName, Id_fb, FB_name),
createLink(hasName, Id_eo, 'INITO'),
createLink(hasName, Id_ei, 'INIT'),
string_concat(Pr, '_', M1), string_concat(M1, T, M2),
string_concat(M2, '_', M3), string_concat(M3, Inst, M4), atom_string(LNid, M4),
createLink(has_LN_id, Ln, LNid),
fail.
run_rule2.

/* Rule 3. Creating LNType-specific input and output variables of FB */

/* Rule3.1 – Creating of input variables of FB */

run_rule31:- 
'LNodeType'(Lnt),
'DO'(Do),
has_DO(Lnt, Do),
has_name(Do, Name),
has_type(Do, Type),
has_DOCategory(Do, X),
atom_string(Y, X),
member(Y,['SP', 'CF', 'SG']),
has_id(Lnt, T),
'FunctionBlock'(Fb),
hasLNtype(Fb, T),
/* -> */
get_id(Iv),
createInstance('InputVariable', Iv),
createLink(is_part_of_FB, Iv, Fb),
createLink(hasName, Iv, Name),
createLink(hasType, Iv, Type),
fail.
run_rule31.

/* Rule3.2 – Creating of output variables of FB */

run_rule32:- 
'LNodeType'(Lnt),
'DO'(Do),
has_DO(Lnt, Do),
has_name(Do, Name),
has_type(Do, Type),
has_DOCategory(Do, X),
atom_string(Y, X),
member(Y,['ST', 'MX']),
has_id(Lnt, T),
'FunctionBlock'(Fb),
hasLNtype(Fb, T),
/* -> */
get_id(Ov),
createInstance('OutputVariable', Ov),
createLink(is_part_of_FB, Ov, Fb),
createLink(hasName, Ov, Name),
createLink(hasType, Ov, Type),
fail.
run_rule32.

/* Rule 4. Creating connections between FB instances */

run_rule4:- 
'LN'(Ln1), 
'LN'(Ln2), 
Ln1\==Ln2, 
'LNConnections'(Lnc), 	
has_LNConnections(Ln1, Lnc), 
has_LNConnections(Ln2, Lnc), 
'FunctionBlock'(Fb1), 	
'FunctionBlock'(Fb2), 	
Fb1\==Fb2, 
associate(Ln1,Fb1), 
associate(Ln2,Fb2), 
has_LN_id(Ln1, From), 
has_LN_id(Ln2, To), 	
'LNC_from'(Lnc, From), 
'LNC_to'(Lnc, To), 
/* -> */
get_id(Id_eo),
createInstance('EventOutput', Id_eo), 	
get_id(Id_ei),
createInstance('EventInput', Id_ei), 
get_id(Id_ov),
createInstance('OutputVariable', Id_ov), 
get_id(Id_iv),
createInstance('InputVariable', Id_iv), 
createLink(is_part_of_FB, Id_ov, Fb1),
createLink(is_part_of_FB, Id_eo, Fb1),
createLink(is_part_of_FB, Id_ei, Fb2),
createLink(is_part_of_FB, Id_iv, Fb2),
createLink(e_connect_to, Id_eo, Id_ei), 
createLink(d_connect_to, Id_ov, Id_iv), 
createLink(hasName, Id_ov, From), 	
createLink(hasName, Id_iv, To), 
string_concat(From, '_Event', EO_name),
createLink(hasName, Id_eo, EO_name), 
string_concat(To, '_Event', EI_name),
createLink(hasName, Id_ei, EI_name), 
fail.
run_rule4.


/* --- */

/*  Utilities  */

/* Get a new ID in the form 'i'<Integer> */
get_id(Id):- 
count_id(X), 
X1 is X+1, 			/* Increment of the identifier number counter */
retract(count_id(X)), 		/* Renew the identifier number counter */
assert(count_id(X1)), 
string_concat('i',X,Id), 		/* Adding the prefix 'i' */
!.

/* Create an individual in the form Class(Instance) */
createInstance(Class, Instance):- 	
functor(X, Class, 1), 
arg(1,X,Instance), 
dynamic(Class/1), 
(not(X), assertz(X); true),!.

/* Create a link in the form Link(Instance1. Instance2) */
createLink(Link, Instance1, Instance2):- 
functor(X, Link, 2), 
arg(1,X,Instance1), 
arg(2,X,Instance2), 
dynamic(Link/2), 
(not(X), assertz(X); true),!.

/* Output the generated predicates of 1-arity */
list_predicates1(X):-
P=..[X,_], dynamic(X/1), P, listing(X).
list_predicates1(_).

/* Output the generated predicates of 2-arity */
list_predicates2(X):-
P=..[X,_,_], dynamic(X/2), P, listing(X).
list_predicates2(_).

/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
