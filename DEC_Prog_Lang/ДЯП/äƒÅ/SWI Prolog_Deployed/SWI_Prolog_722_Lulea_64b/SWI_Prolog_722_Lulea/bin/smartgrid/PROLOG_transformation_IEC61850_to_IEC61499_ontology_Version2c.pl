/* ------------------------------------------------------ */
/* PROLOG-program for transforming IEC 61850 ontology to IEC 61499 ontology (a simple transformation rules interpreter) */
/* Version 2c */ 
/* Individuals are generated as atom but not string */ 


/* INPUT: IEC 61850 ontology based on PROLOG (i.e. after OWL Thea2 processing). Only facts of this ontology should be used. 
   All the axioms in the form of Prolog-rules have to be commented because they has not influence on the results but substantially increase the processing time */

/* OUTPUT:  IEC 61499 ontology based on PROLOG. The newly generated facts of this ontology are output to separate files (it is for simplicity and  convenience). 
  The important fact are written to file 'FB_onlology_in_Prolog' while the auxiliary facts are written to file 'Subsidiary_info' */

/* Feature:  Usage of "Single iterative sequential execution model" for both Rule1 and Rule2 */

/* Guide of usage: 
   -- Start SWI Prolog (if it was started as /bin/swipl-win.exe then the current work folder will be /bin, otherwise the current work folder is as default (/users/<user>/My documents/Prolog)
   -- Load the Prolog-based IEC 61850 ontology. For example, input in the command line: consult("<path to the file>/PROLOG_transformation_IEC61850_to_IEC61499_ontology_Version2b.pl") or select: File->Consult
   -- Load the transformation rules interpreter. For example, input in the command line: consult("<path to the file>/PROLOG_based_IEC61850_ontology.pl") or in another way
   -- Input the goal: run_transformation.
   -- Look at the generated Prolog-based IEC 61499 ontology, for example, in a text editor
   -- Further the generated Prolog-based IEC 61499 ontology could be open in Prolog and queried as well as used to translate to FB XML (FB OWL)
*/
/* ------------------------------------------------------ */

/* Top-level transformation procedure ( a simple interpreter )*/

run_transformation:- 
assert(count_id(1)), 			/* set an initial identifier number to “1” */
run_rule1, 				/* execute Rule1 */
run_rule2, 				/* execute Rule2 */
open('FB_onlology_in_Prolog_ex2c.pl', write, S),  /* write the generated FB ontology to the file */
set_output(S),
list_predicates1('FunctionBlock'), 		/* output the generated FB instances */
list_predicates1('EventOutput'), 			/* output the generated Event Outputs */
list_predicates1('EventInput'), 			/* output the generated Event Inputs */
list_predicates1('OutputVariable'), 		/* output the generated OutputVariable */
list_predicates1('InputVariable'), 		/* output the generated InputVariable */
list_predicates2(is_part_of_FB), 		/* output the generated is_part_of_FB links */
list_predicates2(e_connect_to), 			/* output the generated e_connect_to links */
list_predicates2(d_connect_to), 			/* output the generated d_connect_to links */
list_predicates2(has_FB_type), 			/* output the generated has_FB_type links */
list_predicates2(hasName), 			/* output the generated hasName links */
close(S),
open('Subsidiary_info_ex2c.pl', write, S2), 		/* write the generated subsidiary info to the file */
set_output(S2),
listing(has_LN_id), 			/* output the generated has_LN_id links */
listing(associate), 			/* output the generated associate links */
listing(count_id), 			/* output the value of the identifier number counter */
close(S2).


/* --- */

/* Implementation of Rule1 in Prolog */

run_rule1:- 
'LN'(Ln), 					/* LN(?ln) */
has_lnClass(Ln, Cl), 				/* has_lnClass(?ln, ?cl) */
has_prefix(Ln, Pr), 				/* has_prefix(?ln, ?pr) */
has_inst(Ln, Inst), 				/* has_inst(?ln, ?inst) */
has_lnType(Ln, T), 				/* has_lnType(?ln, ?t) */
/* -> */
get_id(Id_fb),
createInstance('FunctionBlock', Id_fb), 	/*  eswrl:createInstance(FunctionBlock, ?fb) */
get_id(Id_eo),
createInstance('EventOutput', Id_eo), 	 /* eswrl:createInstance(EventOutput, ?eo) */
get_id(Id_ei),
createInstance('EventIntput', Id_ei), 		 /* eswrl:createInstance(EventIntput, ?ei) */
createLink(associate, Ln, Id_fb), 		/* associate(?ln, ?fb) */
createLink(is_part_of_FB, Id_eo, Id_fb),	 /* is_part_of_FB(?eo, ?fb) */
createLink(is_part_of_FB, Id_ei, Id_fb), 	/* is_part_of_FB(?ei, ?fb) */
string_concat('i', Cl, FBType_name),
createLink(has_FB_type, Id_fb, FBType_name), 		/* has_FB_type(?fb, “i”+?cl) */
string_concat('fb_', Cl, N1),
string_concat(N1, Pr, N2),
string_concat(N2, Inst, FB_name),
createLink(hasName, Id_fb, FB_name), 	/* has_name(?fb, fb+”_”+?cl+”_”+?pr+”_”+?inst) */
createLink(hasName, Id_eo, 'INITO'), 		/* has_name(?eo, “INITO”) */
createLink(hasName, Id_ei, 'INIT'), 		/* has_name(?ei, “INIT”) */
string_concat(Pr, '_', M1),
string_concat(M1, T, M2),
string_concat(M2, '_', M3),
string_concat(M3, Inst, M4),
atom_string(LNid, M4),
createLink(has_LN_id, Ln, LNid), 		/* has_LN_id(?ln, “i”+?t + ”_” + ?pr + ?inst) */
fail.
run_rule1.

/* --- */

/* Implementation of Rule2 in Prolog */

run_rule2:- 						
'LN'(Ln1), 							/* LN(?ln1) */
'LN'(Ln2), 							/* LN(?ln2) */
Ln1\==Ln2, 							/* swrlb:differentFrom(?ln1, ?ln2) */
'LNConnections'(Lnc), 						/* LNConnections(?lnc) */
has_LNConnections(Ln1, Lnc), 				/* has_LNConnections(?ln1, ?lnc) */
has_LNConnections(Ln2, Lnc), 				/* has_LNConnections(?ln2, ?lnc) */
'FunctionBlock'(Fb1), 						/* FunctionBlock(?fb1) */
'FunctionBlock'(Fb2), 						/* FunctionBlock(?fb2) */
Fb1\==Fb2, 							/* swrlb:differentFrom(?fb1, ?fb2) */
associate(Ln1,Fb1), 						/* associate(?ln1,?fb1) */
associate(Ln2,Fb2), 						/* associate(?ln1,?fb1) */
has_LN_id(Ln1, From), 					/* has_LN_id(?ln1, ?from) */
has_LN_id(Ln2, To), 						/* has_LN_id(?ln2, ?to) */
'LNC_from'(Lnc, From), 					/* LNC_from(?lnc, ?from) */
'LNC_to'(Lnc, To), 						/* LNC_to(?lnc, ?to) */
/* -> */
get_id(Id_eo),
createInstance('EventOutput', Id_eo), 	/*  eswrl:createInstance(EventOutput, ?eo) */
get_id(Id_ei),
createInstance('EventInput', Id_ei), 		/*  eswrl:createInstance(EventInput, ?ei) */
get_id(Id_ov),
createInstance('OutputVariable', Id_ov), 	/*  eswrl:createInstance(OutputVariable, ?ov) */
get_id(Id_iv),
createInstance('InputVariable', Id_iv), 	/*  eswrl:createInstance(InputVariable, ?iv) */
createLink(is_part_of_FB, Id_ov, Fb1),	 /* is_part_of_FB(?ov, ?fb1) */
createLink(is_part_of_FB, Id_eo, Fb1),	 /* is_part_of_FB(?eo, ?fb1) */
createLink(is_part_of_FB, Id_ei, Fb2),	 /* is_part_of_FB(?ei, ?fb2) */
createLink(is_part_of_FB, Id_iv, Fb2),	 /* is_part_of_FB(?iv, ?fb2) */
createLink(e_connect_to, Id_eo, Id_ei), 	/* e_connect_to(?eo, ?ei) */
createLink(d_connect_to, Id_ov, Id_iv), 	/* d_connect_to(?ov, ?iv) */
createLink(hasName, Id_ov, From), 		/* hasName(?ov, ?from) */
createLink(hasName, Id_iv, To), 		/* hasName(?iv, ?to) */
string_concat(From, '_Event', EO_name),
createLink(hasName, Id_eo, EO_name), 	/* hasName(?eo, ?from+”_Event”) */
string_concat(To, '_Event', EI_name),
createLink(hasName, Id_ei, EI_name), 	/* hasName(?ei, ?to++”_Event”) */
fail.
run_rule2.

/* --- */

/*  Utilities  */

/* Get a new ID in the form 'i'<Integer> */

get_id(Id):- 
count_id(CurrentCounterValue), 
NewCounterValue is CurrentCounterValue+1, 			/* Increment of the identifier number counter */
retract(count_id(CurrentCounterValue)), 		/* Renew the identifier number counter */
assert(count_id(NewCounterValue)), 
string_concat('i',CurrentCounterValue,Str), 		/* Adding the prefix 'i' */
atom_string(Id, Str).

/* Create an individual in the form Class(Instance) */

createInstance(Class, Instance):- 	
functor(X, Class, 1), 
arg(1,X,Instance), 
dynamic(Class/1), 
(not(X), assertz(X); true),!.

/* Create a link in the form Link(Instance1. Instance2) */

createLink(Link, Instance1, Instance2):- 
functor(X, Link, 2), 
atom_string(Par1, Instance1),
atom_string(Par2, Instance2),
arg(1,X,Par1), 
arg(2,X,Par2), 
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
