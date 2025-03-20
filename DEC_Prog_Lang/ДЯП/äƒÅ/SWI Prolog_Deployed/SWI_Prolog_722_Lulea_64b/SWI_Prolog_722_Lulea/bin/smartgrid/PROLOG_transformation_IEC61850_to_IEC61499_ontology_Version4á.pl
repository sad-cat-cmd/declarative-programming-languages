/* PROLOG-program for transforming IEC 61850 ontology to IEC 61499 ontology (a simple transformation rules interpreter) */
/* Version 4a */ 
/* FUNCTIONALITY: 
1) mapping IEC 61850 DO-types and DA-variables to IEC 61499 structure data type variables
2) mapping IEC 61850 LN to IEC 61499 FB instances
3) mapping IEC 61850 DO to IEC 61499 FB input and output variables
4) mapping IEC 61850 LN-connections to IEC 61499 FB- connections
*/
/* INPUT: IEC 61850 ontology based on PROLOG (i.e. after OWL Thea2 processing). Only facts of this ontology should be used. 
   All the axioms in the form of Prolog-rules have to be commented because they has not influence on the results but substantially increase the processing time */
/* OUTPUT:  IEC 61499 ontology based on PROLOG. The newly generated facts of this ontology are output to separate files (it is for simplicity and convenience). 
  The important fact are written to file ''FB_onlology_in_Prolog_7_rules.pl' while the auxiliary facts are written to file 'Subsidiary_info_7_rules.pl' */
/* Feature:  Usage of "Single iterative sequential execution model" for all rules */

/* ------------------------------------------------------ */

/* Top-level transformation procedure ( a simple interpreter )*/

run_transformation:- 
assert(count_id(1)), 
run_rule11, 
run_rule12, 
run_rule2,
run_rule3,
run_rule4,
run_rule5,
run_rule61,
run_rule62,
run_rule7,
open('FB_onlology_in_Prolog_7_rules.pl', write, S), 
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
list_predicates2(is_with_event),
list_predicates2(has_structureVar),
list_predicates2(has_var_type), 
list_predicates2(has_FB_type), 
list_predicates2(hasName), 
close(S),
open('Subsidiary_info_7_rules.pl', write, S2), 
set_output(S2),
list_predicates2(has_LN_id), 
list_predicates2(associate), 
list_predicates1(count_id), 
close(S2),
write_SG_statistics,
write_FB_statistics.

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
createLink(has_var_type, Stv, Type),
fail.
run_rule12.


/* Rule 2. Creating System/Application */

run_rule2:- 
'SCL'(Scl),
has_name(Scl, SCLname),
/* -> */
get_id(Sys),
createInstance('System', Sys),
get_id(App),
createInstance('Application', App),
createLink(is_part_of_system, App, Sys),
createLink(hasName, Sys, SCLname),
createLink(hasName, App, SCLname),
createLink(associate, Scl, Sys),
fail.
run_rule2.

/* Rule 3. Creating Device */

run_rule3:- 
'SCL'(Scl),
associate(Scl,Sys),
has_IED(Scl,Ied),
'IED'(Ied),
has_name(Ied,IEDname),
/* -> */
get_id(Dev),
createInstance('Device',Dev),
createLink(is_part_of_system, Dev, Sys),
createLink(associate, Ied, Dev),
createLink(hasName, Dev, IEDname),
createLink(has_device_type,Dev,'NXT_RMTDEV'),
fail.
run_rule3.

/* Rule 4. Creating Resource */

run_rule4:- 
'IED'(Ied),
has_name(Ied,IEDname),
associate(Ied,Dev),
has_AccessPoint(Ied,Ap),
'AccessPoint'(Ap),
has_name(Ap,APname),
has_Server(Ap,Serv),
'Server'(Serv),
has_LDevice(Serv,Ldev),
'LDevice'(Ldev),
has_inst(Ldev,LdevInst),
/* -> */
get_id(Res),
createInstance('Resource',Res),
createLink(is_part_of_device, Res, Dev),
createLink(associate, Ldev, Res),
string_concat(IEDname, ".", N1), string_concat(N1, APname, N2),
string_concat(N2, "_", N3), string_concat(N3, LdevInst, N4), 
atom_string(RES_name, N4),
createLink(hasName, Res, Res_name),
createLink(has_resource_type, Res, 'EMB_RES'),
fail.
run_rule4.


/* Rule 5. Creating FB instance and mapping to resource */

run_rule5:- 
'SCL'(Scl),
'IED'(Ied),
'AccessPoint'(Ap),
'Server'(Ser),
'LDevice'(Ldev),
'LN'(Ln),
'System'(Sys),
'Device'(Dev),
'Resource'(Res),
'Application'(App),
associate(Scl,Sys),
associate(Ied,Dev),
associate(Ldev,Res),
has_IED(Scl,Ied),
has_AccessPoint(Ied,Ap),
has_Server(Ap,Ser),
has_LDevice(Ser,Ldev),
has_LN(Ldev,Ln),
has_prefix(Ln, Pr),
has_inst(Ln, Inst),
has_lnType(Ln, T),
is_part_of_system(Dev,Sys),
is_part_of_system(App,Sys),
is_part_of_device(Res,Dev),
/* -> */
get_id(Fb),
createInstance('FunctionBlock', Fb),
get_id(Eo),
createInstance('EventOutput', Eo),
get_id(Ei),
createInstance('EventIntput', Ei),
createLink(associate, Ln, Fb),
createLink(is_part_of_FB, Eo, Fb),
createLink(is_part_of_FB, Ei, Fb),
string_concat(T, "_", L1), string_concat(L1, Pr, L2), 
string_concat(L2, "_", L3), string_concat(L3, Inst, L4), atom_string(FBType_name, L4),
createLink(has_FB_type, Fb, FBType_name), 
string_concat("fb_", T, N1), string_concat(N1, "_", N2), string_concat(N2, Pr, N3),
string_concat(N3, "_", N4), string_concat(N4, Inst, N5), atom_string(FB_name, N5),
createLink(hasName, Fb, FB_name),
createLink(hasName, Eo, 'INITO'),
createLink(hasName, Ei, 'INIT'),
string_concat(Pr, "_", M1), string_concat(M1, T, M2),
string_concat(M2, "_", M3), string_concat(M3, Inst, M4), atom_string(LNid, M4),
createLink(has_LN_id, Ln, LNid),
createLink(is_mapped_to,Fb,Res),
createLink(associate,Ln,Fb),
createLink(is_part_of_application,Fb,App),
fail.
run_rule5.


/* Rule 6. Creating LNType-specific input and output variables of FB */

/* Rule6.1 – Creating of input variables of FB */

run_rule61:- 
'LNodeType'(Lnt),
'DO'(Do),
'DOType'(Dot),
'FunctionBlock'(Fb),
'LN'(Ln),
'StructureType'(St),
has_DO(Lnt, Do),
has_name(Do, Name),
has_name(Dot,Name),
has_DOCategory(Do, X),
atom_string(Y, X),
member(Y,['SP', 'CF', 'SG']),
has_id(Lnt, T),
has_lnType(Ln,T),
associate(Ln,Fb),
associate(Dot,St),
/* -> */
get_id(Iv),
createInstance('InputVariable', Iv),
createLink(is_part_of_FB, Iv, Fb),
createLink(hasName, Iv, Name),
createLink(has_var_type, Iv, St),
fail.
run_rule61.

/* Rule6.2 – Creating of output variables of FB */

run_rule62:- 
'LNodeType'(Lnt),
'DO'(Do),
'DOType'(Dot),
'FunctionBlock'(Fb),
'LN'(Ln),
'StructureType'(St),
has_DO(Lnt, Do),
has_name(Do, Name),
has_name(Dot,Name),
has_DOCategory(Do, X),
atom_string(Y, X),
member(Y,['ST','MX']),
has_id(Lnt, T),
has_lnType(Ln,T),
associate(Ln,Fb),
associate(Dot,St),
/* -> */
get_id(Iv),
createInstance('OutputVariable', Ov),
createLink(is_part_of_FB, Ov, Fb),
createLink(hasName, Ov, Name),
createLink(has_var_type, Ov, St),
fail.
run_rule62.


/* Rule 7. Creating connections between FB instances */

run_rule7:- 
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
'LNC_name'(Lnc, LncName),
'LNC_type'(Lnc, LncType),
/* -> */
get_id(Eo),
createInstance('EventOutput', Eo), 	
get_id(Ei),
createInstance('EventInput', Ei), 
get_id(Ov),
createInstance('OutputVariable', Ov), 
get_id(Iv),
createInstance('InputVariable', Iv), 
createLink(is_part_of_FB, Ov, Fb1),
createLink(is_part_of_FB, Eo, Fb1),
createLink(is_part_of_FB, Ei, Fb2),
createLink(is_part_of_FB, Iv, Fb2),
createLink(e_connect_to, Eo, Ei), 
createLink(d_connect_to, Ov, Iv), 

createLink(is_with_event, Iv, Ei),
createLink(is_with_event, Ov, Eo),

createLink(hasName, Ov, LncName), 	
createLink(hasName, Iv, LncName), 
string_concat(From, "_Ev", EO_name),
createLink(hasName, Eo, EO_name), 
string_concat(To, "_Ev", EI_name),
createLink(hasName, Ei, EI_name), 
fail.
run_rule7.


/* --- */

/*  Utilities  */

/* Get a new ID in the form 'i'<Integer> of type atom */
get_id(Id):- 
count_id(X), 
X1 is X+1, 			/* Increment of the identifier number counter */
retract(count_id(X)), 		/* Renew the identifier number counter */
assert(count_id(X1)), 
string_concat("i", X, Y), 		/* Adding the prefix 'i' */
atom_string(Id, Y),
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

/* Write statistics (metrics) about ontologies */

/* Write statistics (metrics) about FB ontology A-Box */

write_FB_statistics:- 
writeln("--------------------------------------------------------------------------------"), 
writeln("Statistics (metrics) about the generated IEC 61499 ontology A-Box"), 
writeln("--------------------------------------------------------------------------------"),
write_ns, write_app, write_nd, write_nr, write_nst, write_nstv, 
write_nfb, write_nei, write_nei2, write_neo, write_neo2, write_niv, write_niv2, write_nov, write_nov2, 
write_nec, write_ndc, write_nipfb, write_nips, write_nipd.

write_nfb:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nfb, c(N), string_concat("Number of FunctionBlock= ",N,N2), writeln(N2), retract(c(_)).
calc_nfb:- dynamic('FunctionBlock'/1), 'FunctionBlock'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nfb.

write_nei:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nei, c(N), string_concat("Number of EventInput= ",N,N2), writeln(N2), retract(c(_)).
calc_nei:- dynamic('EventInput'/1), 'EventInput'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nei.

write_nei2:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nei2, c(N), string_concat("-- including Number of dangling EventInput= ",N,N2), writeln(N2), retract(c(_)).
calc_nei2:- dynamic('EventInput'/1), 'EventInput'(X), not(e_connect_to(_,X))), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nei2.

write_neo:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_neo, c(N), string_concat("Number of EventOutput= ",N,N2), writeln(N2), retract(c(_)).
calc_neo:- dynamic('EventOutput'/1), 'EventOutput'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_neo.

write_neo2:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_neo2, c(N), string_concat("-- including Number of dangling EventOutput= ",N,N2), writeln(N2), retract(c(_)).
calc_neo2:- dynamic('EventOutput'/1), 'EventOutput'(X), not(e_connect_to(X,_))), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_neo2.


write_niv:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_niv, c(N), string_concat("Number of InputVariable= ",N,N2), writeln(N2), retract(c(_)).
calc_niv:- dynamic('InputVariable'/1), 'InputVariable'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_niv.

write_niv2:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_niv2, c(N), string_concat("-- including Number of dangling InputVariable= ",N,N2), writeln(N2), retract(c(_)).
calc_niv2:- dynamic('InputVariable'/1), 'InputVariable'(X), not(d_connect_to(_,X))), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_niv2.

write_nov:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nov, c(N), string_concat("Number of OutputVariable= ",N,N2), writeln(N2), retract(c(_)).
calc_nov:- dynamic('OutputVariable'/1), 'OutputVariable'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nov.

write_nov2:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nov2, c(N), string_concat("-- including Number of dangling OutputVariable= ",N,N2), writeln(N2), retract(c(_)).
calc_nov2:- dynamic('OutputVariable'/1), 'OutputVariable'(X), not(d_connect_to(X,_))), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nov2.


write_nst:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nst, c(N), string_concat("Number of StructureType= ",N,N2), writeln(N2), retract(c(_)).
calc_nst:- dynamic('StructureType'/1), 'StructureType'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nst.

write_nstv:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nstv, c(N), string_concat("Number of StructureTypeVariable= ",N,N2), writeln(N2), retract(c(_)).
calc_nstv:- dynamic('StructureTypeVariable'/1), 'StructureTypeVariable'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nstv.

write_nr:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nr, c(N), string_concat("Number of Resource= ",N,N2), writeln(N2), retract(c(_)).
calc_nr:- dynamic('Resource'/1),'Resource'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nr.

write_nd:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nd, c(N), string_concat("Number of Device= ",N,N2), writeln(N2), retract(c(_)).
calc_nd:- dynamic('Device'/1), 'Device'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nd.

write_ns:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_ns, c(N), string_concat("Number of System= ",N,N2), writeln(N2), retract(c(_)).
calc_ns:- dynamic('System'/1), 'System'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_ns.

write_app:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_app, c(N), string_concat("Number of Application= ",N,N2), writeln(N2), retract(c(_)).
calc_app:- dynamic('Application'/1), 'Application'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_app.


write_nec:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nec, c(N), string_concat("Number of e_connect_to= ",N,N2), writeln(N2), retract(c(_)).
calc_nec:- dynamic('e_connect_to'/2), 'e_connect_to'(_,_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nec.

write_ndc:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_ndc, c(N), string_concat("Number of d_connect_to= ",N,N2), writeln(N2), retract(c(_)).
calc_ndc:- dynamic('d_connect_to'/2), 'd_connect_to'(_,_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_ndc.

write_nipfb:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nipfb, c(N), string_concat("Number of is_part_of_FB= ",N,N2), writeln(N2), retract(c(_)).
calc_nipfb:- dynamic('is_part_of_FB'/2), 'is_part_of_FB'(_,_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nipfb.

write_nips:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nips, c(N), string_concat("Number of is_part_of_system= ",N,N2), writeln(N2), retract(c(_)).
calc_nips:- dynamic('is_part_of_system'/2), 'is_part_of_system'(_,_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nips.

write_nipd:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nipd, c(N), string_concat("Number of is_part_of_device= ",N,N2), writeln(N2), retract(c(_)).
calc_nipd:- dynamic('is_part_of_device'/2), 'is_part_of_device'(_,_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nipd.


/* Write statistics (metrics) about SmartGrid ontology A-Box */

write_SG_statistics:- 
writeln("-----------------------------------------------------------------------"), 
writeln("Statistics (metrics) about the IEC 61850 ontology A-Box"), 
writeln("-----------------------------------------------------------------------"),
write_nln, write_nlnc, write_nlnt, write_ndo, write_ndot, write_nda, write_nscl, 
write_nied, write_nap, write_nser, write_nld.

write_nln:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nln, c(N), string_concat("Number of LN= ",N,N2), writeln(N2), retract(c(_)).
calc_nln:- 'LN'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nln.

write_nlnc:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nlnc, c(N), string_concat("Number of LNConnections= ",N,N2), writeln(N2), retract(c(_)).
calc_nlnc:- 'LNConnections'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nlnc.

write_nlnt:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nlnt, c(N), string_concat("Number of LNodeType= ",N,N2), writeln(N2), retract(c(_)).
calc_nlnt:- 'LNodeType'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nlnt.

write_ndo:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_ndo, c(N), string_concat("Number of DO= ",N,N2), writeln(N2), retract(c(_)).
calc_ndo:- 'DO'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_ndo.

write_ndot:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_ndot, c(N), string_concat("Number of DOType= ",N,N2), writeln(N2), retract(c(_)).
calc_ndot:- 'DOType'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_ndot.

write_nda:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nda, c(N), string_concat("Number of DA= ",N,N2), writeln(N2), retract(c(_)).
calc_nda:- 'DA'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nda.

write_nscl:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nscl, c(N), string_concat("Number of SCL= ",N,N2), writeln(N2), retract(c(_)).
calc_nscl:- 'SCL'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nscl.

write_nied:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nied, c(N), string_concat("Number of IED= ",N,N2), writeln(N2), retract(c(_)).
calc_nied:- 'IED'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nied.

write_nap:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nap, c(N), string_concat("Number of AccessPoint= ",N,N2), writeln(N2), retract(c(_)).
calc_nap:- 'AccessPoint'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nap.

write_nser:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nser, c(N), string_concat("Number of Server= ",N,N2), writeln(N2), retract(c(_)).
calc_nser:- 'Server'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nser.

write_nld:- dynamic(c/1), (not(c(_)), assert(c(0)); true), calc_nld, c(N), string_concat("Number of LDevice= ",N,N2), writeln(N2), retract(c(_)).
calc_nld:- 'LDevice'(_), c(N), N1 is N+1, retract(c(N)), assert(c(N1)), fail.
calc_nld.


































