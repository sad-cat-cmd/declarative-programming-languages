/* ------------------------------------------------------ */
/* PROLOG-program for transforming IEC 61850 ontology to IEC 61499 ontology (a simple transformation rules interpreter) */
/* Version 2b */ 

/* INPUT: IEC 61850 ontology based on PROLOG (i.e. after OWL Thea2 processing). Only facts of this ontology should be used. 
   All the axioms in the form of Prolog-rules have to be commented because they has not influence on the results but substantially increase the processing time */

/* OUTPUT:  IEC 61499 ontology based on PROLOG. The newly generated facts of this ontology are output to separate files (it is for simplicity and  convenience). 
  The important fact are written to file 'FB_onlology_in_Prolog' while the auxiliary facts are written to file 'Subsidiary_info' */

/* Feature:  Usage of "Single iterative sequential execution model" for both Rule1 and Rule2 */

/* Guide of usage: 
   -- Start SWI Prolog
   -- Load the Prolog-based IEC 61850 ontology (for example, consult "<path to the file>." or in another way)
   -- Load the transformation rules interpreter (for example, consult "<path to the file>." or in another way)
   -- Input the goal: run_transformation.
   -- Look at the generated Prolog-based IEC 61499 ontology  
   -- Further the generated Prolog-based IEC 61499 ontology could be used for quering and to translate to FB XML (FB OWL)
*/
/* ------------------------------------------------------ */

/* Top-level transformation procedure ( a simple interpreter )*/
run_transformation:- 
assert(count_id(1)), 			/* set an initial identifier number to “1” */
run_rule1, 				/* execute Rule1 */
run_rule2, 				/* execute Rule2 */
open('FB_onlology_in_Prolog', write, S),  /* write the generated FB ontology to the file */
set_output(S),
list_predicates1('FunctionBlock'), 		/* output the generated FB instances */
list_predicates1('EventOutput'), 			/* output the generated Event Outputs */
list_predicates1('EventIntput'), 			/* output the generated Event Inputs */
list_predicates1('OutputVariable'), 		/* output the generated OutputVariable */
list_predicates1('InputVariable'), 		/* output the generated InputVariable */
list_predicates2(is_part_of_FB), 		/* output the generated is_part_of_FB links */
list_predicates2(e_connect_to), 			/* output the generated e_connect_to links */
list_predicates2(d_connect_to), 			/* output the generated d_connect_to links */
list_predicates2(has_FB_type), 			/* output the generated has_FB_type links */
list_predicates2(hasName), 			/* output the generated hasName links */
close(S),
open('Subsidiary_info', write, S2), 		/* write the generated subsidiary info to the file */
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

run_rule3:- 						
'LN'(Ln1), 							/* LN(?ln1) */
'LN'(Ln2), 							/* LN(?ln2) */
Ln1\==Ln2, 							/* swrlb:differentFrom(?ln1, ?ln2) */
'LNConnections'(Lnc), 						/* LNConnections(?lnc) */
has_LNConnections(Ln1, Lnc), 				/* has_LNConnections(?ln1, ?lnc) */
has_LNConnections(Ln2, Lnc), 				/* has_LNConnections(?ln2, ?lnc) */
has_LN_id(Ln1, From), 					/* has_LN_id(?ln1, ?from) */
has_LN_id(Ln2, To), 						/* has_LN_id(?ln2, ?to) */
'LNC_from'(Lnc, From), 					/* LNC_from(?lnc, ?from) */
'LNC_to'(Lnc, To), 						/* LNC_to(?lnc, ?to) */
writeln(Ln1+"--->"+Ln2+"CONN:"+Lnc),
fail.



run_rule4:- 						
'LN'(Ln1), 							/* LN(?ln1) */
'LN'(Ln2), 							/* LN(?ln2) */
Ln1\==Ln2, 							/* swrlb:differentFrom(?ln1, ?ln2) */
has_LNConnections(Ln1, Lnc), 				/* has_LNConnections(?ln1, ?lnc) */
has_LNConnections(Ln2, Lnc), 				/* has_LNConnections(?ln2, ?lnc) */
/* 'LNConnections'(Lnc), */						/* LNConnections(?lnc) */
writeln(Ln1+"--->"+Ln2+"CONN:"+Lnc),
fail.



rrun_rule5:-
ant5(Ln1,Ln2,Lnc),
cons5(Ln1,Ln2,Lnc),
fail.

ant5(Ln1,Ln2,Lnc):-
'LN'(Ln1), 							
'LN'(Ln2), 							
Ln1\==Ln2, 							
has_LNConnections(Ln1, Lnc), 				
has_LNConnections(Ln2, Lnc).
/* 'LNConnections'(Lnc).*/

con5(Ln1,Ln2,Lnc):-
writeln(Ln1+"--->"+Ln2+"CONN:"+Lnc),!.


/* ant5(X,Y,'a1:LNC_iPTRC_T_1'). */
/* ant5('a1:Tr_1_LDevice_1_iPTRC_1',Y,'a1:LNC_iPTRC_T_1'). */

/*  Utilities  */

/* Get a new ID in the form 'i'<Integer> */
get_id(Id):- 
count_id(X), 
X1 is X+1, 			/* Increment of the identifier number counter */
retract(count_id(X)), 		/* Renew the identifier number counter */
assert(count_id(X1)), 
string_concat('i',X,Id). 		/* Adding the prefix 'i' */

/* Create an individual in the form Class(Instance) */
createInstance(Class, Instance):- 	
functor(X, Class, 1), 
arg(1,X,Instance), 
dynamic(Class/1), 
(not(X), assertz(X); X).

/* Create a link in the form Link(Instance1. Instance2) */
createLink(Link, Instance1, Instance2):- 
functor(X, Link, 2), 
arg(1,X,Instance1), 
arg(2,X,Instance2), 
dynamic(Link/2), 
(not(X), assertz(X); X).

/* Output the generated predicates of 1-arity */
list_predicates1(X):-
P=..[X,_], dynamic(X/1), P, listing(X).
list_predicates1(_).

/* Output the generated predicates of 2-arity */
list_predicates2(X):-
P=..[X,_,_], dynamic(X/2), P, listing(X).
list_predicates2(_).


/* --- */
/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */

/*------------------------------- */
/* IEC 61850 ontology (wit A-box) */
/*------------------------------- */

'AccessPoint'('a1:F1_1_AP_1').
'AccessPoint'('a1:F2_1_AP_1').
'AccessPoint'('a1:F3_1_AP_1').
'AccessPoint'('a1:F4_1_AP_1').
'AccessPoint'('a1:F5_1_AP_1').
'AccessPoint'('a1:Tr_1_AP_1').
'Address'('a1:F1_ConnectedAP_1_Address_1').
'Address'('a1:F2_ConnectedAP_1_Address_1').
'Address'('a1:F3_ConnectedAP_1_Address_1').
'Address'('a1:F4_ConnectedAP_1_Address_1').
'Address'('a1:F5_ConnectedAP_1_Address_1').
'Address'('a1:Tr_ConnectedAP_1_Address_1').
'BDA'('a1:AnalogueValue_1_BDA1').
'BDA'('a1:AnalogueValue_1_BDA2').
'ConnectedAP'('a1:F1_ConnectedAP_1').
'ConnectedAP'('a1:F2_ConnectedAP_1').
'ConnectedAP'('a1:F3_ConnectedAP_1').
'ConnectedAP'('a1:F4_ConnectedAP_1').
'ConnectedAP'('a1:F5_ConnectedAP_1').
'ConnectedAP'('a1:Tr_ConnectedAP_1').
'DA'('a1:ACT_1_Tr_1_DA1').
'DA'('a1:DPC_1_Pos_1_DA1').
'DA'('a1:DPL_1_PhyNam_1_DA1').
'DA'('a1:SAV_1_AmpSV_1_DA1').
'DAType'('a1:AnalogueValue_1_1').
'DO'('a1:LLN01_1_DO1').
'DO'('a1:LPHD1_1_DO1').
'DO'('a1:iPIOC_1_DO1').
'DO'('a1:iPTRC_1_DO1').
'DO'('a1:iTCTR_1_DO1').
'DO'('a1:iXCBR_1_DO1').
'DOType'('a1:ACT_1_Tr_1').
'DOType'('a1:DPC_1_Pos_1').
'DOType'('a1:DPL_1_PhyNam_1').
'DOType'('a1:SAV_1_AmpSv_1').
'DataSet'('a1:F1_DataSet_1').
'DataSet'('a1:F2_DataSet_1').
'DataSet'('a1:F3_DataSet_1').
'DataSet'('a1:F4_DataSet_1').
'DataSet'('a1:F5_DataSet_1').
'DataSet'('a1:Tr_DataSet_1').
'DataSet'('a1:Tr_DataSet_2').
'DataSet'('a1:Tr_DataSet_3').
'DataSet'('a1:Tr_DataSet_4').
'DataSet'('a1:Tr_DataSet_5').
'DataSet'('a1:Tr_DataSet_6').
'EnumType'('a1:Beh_1').
'EnumType'('a1:Health_1').
'EnumType'('a1:Mod_1').
'EnumType'('a1:PhyHealth_1').
'EnumType'('a1:ctlModel_1').
'EnumVal'('a1:Beh_1_EnumVal1').
'EnumVal'('a1:Beh_1_EnumVal2').
'EnumVal'('a1:Beh_1_EnumVal3').
'EnumVal'('a1:Beh_1_EnumVal4').
'EnumVal'('a1:Beh_1_EnumVal5').
'EnumVal'('a1:Health_1_EnumVal1').
'EnumVal'('a1:Health_1_EnumVal2').
'EnumVal'('a1:Health_1_EnumVal3').
'EnumVal'('a1:Mod_1_EnumVal1').
'EnumVal'('a1:Mod_1_EnumVal2').
'EnumVal'('a1:Mod_1_EnumVal3').
'EnumVal'('a1:Mod_1_EnumVal4').
'EnumVal'('a1:Mod_1_EnumVal5').
'EnumVal'('a1:PhyHealth_1_EnumVal1').
'EnumVal'('a1:PhyHealth_1_EnumVal2').
'EnumVal'('a1:PhyHealth_1_EnumVal3').
'EnumVal'('a1:ctlModel_1_EnumVal1').
'EnumVal'('a1:ctlModel_1_EnumVal2').
'EnumVal'('a1:ctlModel_1_EnumVal3').
'EnumVal'('a1:ctlModel_1_EnumVal4').
'EnumVal'('a1:ctlModel_1_EnumVal5').
'FCDA'('a1:F1_FeederTrip_FCDA_1').
'FCDA'('a1:F2_FeederTrip_FCDA_1').
'FCDA'('a1:F3_FeederTrip_FCDA_1').
'FCDA'('a1:F4_FeederTrip_FCDA_1').
'FCDA'('a1:F5_FeederTrip_FCDA_1').
'FCDA'('a1:Tr_FeederTrip_FCDA_1').
'FCDA'('a1:Tr_TripF1_FCDA_1').
'FCDA'('a1:Tr_TripF2_FCDA_1').
'FCDA'('a1:Tr_TripF3_FCDA_1').
'FCDA'('a1:Tr_TripF4_FCDA_1').
'FCDA'('a1:Tr_TripF5_FCDA_1').
'IED'('a1:IED_Feeder_1').
'IED'('a1:IED_Feeder_2').
'IED'('a1:IED_Feeder_3').
'IED'('a1:IED_Feeder_4').
'IED'('a1:IED_Feeder_5').
'IED'('a1:IED_Transformer_1').
'LDevice'('a1:F1_1_LDevice_1').
'LDevice'('a1:F2_1_LDevice_1').
'LDevice'('a1:F3_1_LDevice_1').
'LDevice'('a1:F4_1_LDevice_1').
'LDevice'('a1:F5_1_LDevice_1').
'LDevice'('a1:Tr_1_LDevice_1').
'LN'('a1:F1_1_LDevice_1_iPIOC_1').
'LN'('a1:F1_1_LDevice_1_iPTRC_1').
'LN'('a1:F1_1_LDevice_1_iTCTR_1').
'LN'('a1:F1_1_LDevice_1_iXCBR_1').
'LN'('a1:F2_1_LDevice_1_iPIOC_1').
'LN'('a1:F2_1_LDevice_1_iPTRC_1').
'LN'('a1:F2_1_LDevice_1_iTCTR_1').
'LN'('a1:F2_1_LDevice_1_iXCBR_1').
'LN'('a1:F3_1_LDevice_1_iPIOC_1').
'LN'('a1:F3_1_LDevice_1_iPTRC_1').
'LN'('a1:F3_1_LDevice_1_iTCTR_1').
'LN'('a1:F3_1_LDevice_1_iXCBR_1').
'LN'('a1:F4_1_LDevice_1_iPIOC_1').
'LN'('a1:F4_1_LDevice_1_iPTRC_1').
'LN'('a1:F4_1_LDevice_1_iTCTR_1').
'LN'('a1:F4_1_LDevice_1_iXCBR_1').
'LN'('a1:F5_1_LDevice_1_iPIOC_1').
'LN'('a1:F5_1_LDevice_1_iPTRC_1').
'LN'('a1:F5_1_LDevice_1_iTCTR_1').
'LN'('a1:F5_1_LDevice_1_iXCBR_1').
'LN'('a1:Tr_1_LDevice_1_iPIOC_1').
'LN'('a1:Tr_1_LDevice_1_iPTRC_1').
'LN'('a1:Tr_1_LDevice_1_iTCTR_1').
'LN'('a1:Tr_1_LDevice_1_iXCBR_1').
'LN0'('a1:F1_LLN01').
'LN0'('a1:F2_LLN01').
'LN0'('a1:F3_LLN01').
'LN0'('a1:F4_LLN01').
'LN0'('a1:F5_LLN01').
'LN0'('a1:Tr_LLN01').
'LNConnections'('a1:LNC_iPIOC_F1_1').
'LNConnections'('a1:LNC_iPIOC_F2_1').
'LNConnections'('a1:LNC_iPIOC_F3_1').
'LNConnections'('a1:LNC_iPIOC_F4_1').
'LNConnections'('a1:LNC_iPIOC_F5_1').
'LNConnections'('a1:LNC_iPIOC_T_1').
'LNConnections'('a1:LNC_iPTRC_F1_1').
'LNConnections'('a1:LNC_iPTRC_F1_2').
'LNConnections'('a1:LNC_iPTRC_F1_3').
'LNConnections'('a1:LNC_iPTRC_F1_4').
'LNConnections'('a1:LNC_iPTRC_F1_5').
'LNConnections'('a1:LNC_iPTRC_F1_6').
'LNConnections'('a1:LNC_iPTRC_F2_1').
'LNConnections'('a1:LNC_iPTRC_F2_2').
'LNConnections'('a1:LNC_iPTRC_F2_3').
'LNConnections'('a1:LNC_iPTRC_F2_4').
'LNConnections'('a1:LNC_iPTRC_F2_5').
'LNConnections'('a1:LNC_iPTRC_F2_6').
'LNConnections'('a1:LNC_iPTRC_F3_1').
'LNConnections'('a1:LNC_iPTRC_F3_2').
'LNConnections'('a1:LNC_iPTRC_F3_3').
'LNConnections'('a1:LNC_iPTRC_F3_4').
'LNConnections'('a1:LNC_iPTRC_F3_5').
'LNConnections'('a1:LNC_iPTRC_F3_6').
'LNConnections'('a1:LNC_iPTRC_F4_1').
'LNConnections'('a1:LNC_iPTRC_F4_2').
'LNConnections'('a1:LNC_iPTRC_F4_3').
'LNConnections'('a1:LNC_iPTRC_F4_4').
'LNConnections'('a1:LNC_iPTRC_F4_5').
'LNConnections'('a1:LNC_iPTRC_F4_6').
'LNConnections'('a1:LNC_iPTRC_F5_1').
'LNConnections'('a1:LNC_iPTRC_F5_2').
'LNConnections'('a1:LNC_iPTRC_F5_3').
'LNConnections'('a1:LNC_iPTRC_F5_4').
'LNConnections'('a1:LNC_iPTRC_F5_5').
'LNConnections'('a1:LNC_iPTRC_F5_6').
'LNConnections'('a1:LNC_iPTRC_T_1').
'LNConnections'('a1:LNC_iPTRC_T_2').
'LNConnections'('a1:LNC_iPTRC_T_3').
'LNConnections'('a1:LNC_iPTRC_T_4').
'LNConnections'('a1:LNC_iPTRC_T_5').
'LNConnections'('a1:LNC_iPTRC_T_6').
'LNConnections'('a1:LNC_iTCTR_F1_1').
'LNConnections'('a1:LNC_iTCTR_F2_1').
'LNConnections'('a1:LNC_iTCTR_F3_1').
'LNConnections'('a1:LNC_iTCTR_F4_1').
'LNConnections'('a1:LNC_iTCTR_F5_1').
'LNConnections'('a1:LNC_iTCTR_T_1').
'LNodeType'('a1:LLN01_1').
'LNodeType'('a1:LPHD1_1').
'LNodeType'('a1:iPIOC_1').
'LNodeType'('a1:iPTRC_1').
'LNodeType'('a1:iTCTR_1').
'LNodeType'('a1:iXCBR_1').
'P'('a1:F1_Address_1_P_1').
'P'('a1:F2_Address_1_P_1').
'P'('a1:F3_Address_1_P_1').
'P'('a1:F4_Address_1_P_1').
'P'('a1:F5_Address_1_P_1').
'P'('a1:Tr_Address_1_P_1').
'Server'('a1:F1_1_Server_1').
'Server'('a1:F2_1_Server_1').
'Server'('a1:F3_1_Server_1').
'Server'('a1:F4_1_Server_1').
'Server'('a1:F5_1_Server_1').
'Server'('a1:Tr_1_Server_1').
'SubNetwork'('a1:SubNetwork_1').

/* ====================================================================*/

/*   ALL AXIOMS SHOUL BE COMMENTED

'IED'(X):-
     has_AccessPoint(X,'_').
'ConnectedAP'(X):-
     has_Address(X,'_').
'DAType'(X):-
     has_BDA(X,'_').
'SCL'(X):-
     has_Communication(X,'_').
'SubNetwork'(X):-
     has_ConnectedAP(X,'_').
'DOType'(X):-
     has_DA(X,'_').
'DOI'(X):-
     has_DAI(X,'_').
'SDI'(X):-
     has_DAI(X,'_').
'DataTypeTemplates'(X):-
     has_DAType(X,'_').
'LNodeType'(X):-
     has_DO(X,'_').
'AnyLN'(X):-
     has_DOI(X,'_').
'DataTypeTemplates'(X):-
     has_DOType(X,'_').
'AnyLN'(X):-
     has_DataSet(X,'_').
'SCL'(X):-
     has_DataTypeTemplates(X,'_').
'DataTypeTemplates'(X):-
     has_EnumType(X,'_').
'EnumType'(X):-
     has_EnumVal(X,'_').
'DataSet'(X):-
     has_FCDA(X,'_').
'SCL'(X):-
     has_Header(X,'_').
'SCL'(X):-
     has_IED(X,'_').
'Server'(X):-
     has_LDevice(X,'_').
'AccessPoint'(X):-
     has_LN(X,'_').
'LDevice'(X):-
     has_LN(X,'_').
'LDevice'(X):-
     has_LN0(X,'_').
'LN'(X):-
     has_LNConnections(X,'_').
'DataTypeTemplates'(X):-
     has_LNodeType(X,'_').
'Address'(X):-
     has_P(X,'_').
'SDI'(X):-
     has_SD(X,'_').
'DOI'(X):-
     has_SDI(X,'_').
'DOType'(X):-
     has_SDO(X,'_').
'AccessPoint'(X):-
     has_Server(X,'_').
'IED'(X):-
     has_Services(X,'_').
'Communication'(X):-
     has_SubNetwork(X,'_').
'SCL'(X):-
     has_Substation(X,'_').
'AbstractDataAttribute'(X):-
     has_Val(X,'_').
string(X):-
     'a1_LNC_from'(_,X).
string(X):-
     'a1_LNC_name'(_,X).
string(X):-
     'a1_LNC_to'(_,X).
string(X):-
     'a1_LNC_type'(_,X).
string(X):-
     'a1_from_DA'(_,X).
string(X):-
     'a1_from_DO'(_,X).
'AccessPoint'(X):-
     has_AccessPoint(_,X).
'Address'(X):-
     has_Address(_,X).
'BDA'(X):-
     has_BDA(_,X).
'Communication'(X):-
     has_Communication(_,X).
'ConnectedAP'(X):-
     has_ConnectedAP(_,X).
'DA'(X):-
     has_DA(_,X).
'DAI'(X):-
     has_DAI(_,X).
'DAType'(X):-
     has_DAType(_,X).
'DO'(X):-
     has_DO(_,X).
'DOI'(X):-
     has_DOI(_,X).
'DOType'(X):-
     has_DOType(_,X).
'DataSet'(X):-
     has_DataSet(_,X).
'DataTypeTemplates'(X):-
     has_DataTypeTemplates(_,X).
'EnumType'(X):-
     has_EnumType(_,X).
'EnumVal'(X):-
     has_EnumVal(_,X).
'FCDA'(X):-
     has_FCDA(_,X).
'Header'(X):-
     has_Header(_,X).
'IED'(X):-
     has_IED(_,X).
'LDevice'(X):-
     has_LDevice(_,X).
'LN'(X):-
     has_LN(_,X).
'LN0'(X):-
     has_LN0(_,X).
'LNConnections'(X):-
     has_LNConnections(_,X).
'LNodeType'(X):-
     has_LNodeType(_,X).
'P'(X):-
     has_P(_,X).
'SDI'(X):-
     has_SD(_,X).
'SDI'(X):-
     has_SDI(_,X).
'SDO'(X):-
     has_SDO(_,X).
'Server'(X):-
     has_Server(_,X).
'Services'(X):-
     has_Services(_,X).
'SubNetwork'(X):-
     has_SubNetwork(_,X).
'Substation'(X):-
     has_Substation(_,X).
'Val'(X):-
     has_Val(_,X).
string(X):-
     'a1_has_Value'(_,X).
string(X):-
     'a1_has_apName'(_,X).
string(X):-
     'a1_has_bType'(_,X).
string(X):-
     'a1_has_cdc'(_,X).
string(X):-
     'a1_has_configVersion'(_,X).
string(X):-
     'a1_has_daName'(_,X).
string(X):-
     'a1_has_doName'(_,X).
string(X):-
     'a1_has_fc'(_,X).
string(X):-
     'a1_has_id'(_,X).
string(X):-
     'a1_has_iedName'(_,X).
string(X):-
     'a1_has_inst'(_,X).
string(X):-
     'a1_has_ldInst'(_,X).
string(X):-
     'a1_has_ldName'(_,X).
string(X):-
     'a1_has_lnClass'(_,X).
string(X):-
     'a1_has_lnInst'(_,X).
string(X):-
     'a1_has_manufacturer'(_,X).
string(X):-
     'a1_has_name'(_,X).
integer(X):-
     'a1_has_ord'(_,X).
string(X):-
     'a1_has_prefix'(_,X).
string(X):-
     'a1_has_revision'(_,X).
string(X):-
     'a1_has_type'(_,X).
string(X):-
     'a1_has_version'(_,X).
'BDA'(X):-
     'AbstractDataAttribute'(X).
'UnNaming'(X):-
     'AbstractDataAttribute'(X).
'UnNaming'(X):-
     'AccessPoint'(X).
'Thing'(X):-
     'a1_Address'(X).
'UnNaming'(X):-
     'AnyLN'(X).
'AbstractDataAttribute'(X):-
     'BDA'(X).
'UnNaming'(X):-
     'Communication'(X).
'UnNaming'(X):-
     'ConnectedAP'(X).
'AbstractDataAttribute'(X):-
     'DA'(X).
'UnNaming'(X):-
     'DAI'(X).
'IDNaming'(X):-
     'DAType'(X).
'UnNaming'(X):-
     'DO'(X).
'UnNaming'(X):-
     'DOI'(X).
'IDNaming'(X):-
     'DOType'(X).
'UnNaming'(X):-
     'DataSet'(X).
'Thing'(X):-
     'a1_DataTypeTemplates'(X).
'IDNaming'(X):-
     'EnumType'(X).
'UnNaming'(X):-
     'IED'(X).
'UnNaming'(X):-
     'LDevice'(X).
'AnyLN'(X):-
     'LN'(X).
'AnyLN'(X):-
     'LN0'(X).
'IDNaming'(X):-
     'LNodeType'(X).
'PAddr'(X):-
     'P'(X).
'Thing'(X):-
     'a1_SCL'(X).
'UnNaming'(X):-
     'SDI'(X).
'UnNaming'(X):-
     'SDO'(X).
'UnNaming'(X):-
     'Server'(X).
'UnNaming'(X):-
     'Services'(X).
'Naming'(X):-
     'SubNetwork'(X).
'AbstractDataAttribute'(X):-
     'UnNaming'(X).

END OF COMMENTED AXIOMS */
/* ====================================================================*/

'LNC_from'('a1:LNC_iPIOC_F1_1','F1_iPIOC_1').
'LNC_from'('a1:LNC_iPIOC_F2_1','F2_iPIOC_1').
'LNC_from'('a1:LNC_iPIOC_F3_1','F3_iPIOC_1').
'LNC_from'('a1:LNC_iPIOC_F4_1','F4_iPIOC_1').
'LNC_from'('a1:LNC_iPIOC_F5_1','F5_iPIOC_1').
'LNC_from'('a1:LNC_iPIOC_T_1','Tr_iPIOC_1').
'LNC_from'('a1:LNC_iPTRC_F1_1','F1_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F1_2','F1_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F1_3','F1_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F1_4','F1_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F1_5','F1_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F1_6','F1_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F2_1','F2_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F2_2','F2_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F2_3','F2_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F2_4','F2_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F2_5','F2_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F2_6','F2_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F3_1','F3_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F3_2','F3_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F3_3','F3_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F3_4','F3_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F3_5','F3_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F3_6','F3_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F4_1','F4_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F4_2','F4_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F4_3','F4_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F4_4','F4_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F4_5','F4_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F4_6','F4_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F5_1','F5_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F5_2','F5_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F5_3','F5_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F5_4','F5_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F5_5','F5_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_F5_6','F5_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_T_1','Tr_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_T_2','Tr_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_T_3','Tr_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_T_4','Tr_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_T_5','Tr_iPTRC_1').
'LNC_from'('a1:LNC_iPTRC_T_6','Tr_iPTRC_1').
'LNC_from'('a1:LNC_iTCTR_F1_1','F1_iTCTR_1').
'LNC_from'('a1:LNC_iTCTR_F2_1','F2_iTCTR_1').
'LNC_from'('a1:LNC_iTCTR_F3_1','F3_iTCTR_1').
'LNC_from'('a1:LNC_iTCTR_F4_1','F4_iTCTR_1').
'LNC_from'('a1:LNC_iTCTR_F5_1','F5_iTCTR_1').
'LNC_from'('a1:LNC_iTCTR_T_1','Tr_iTCTR_1').
'LNC_name'('a1:LNC_iPIOC_F1_1',iPIOC_F1_Op_general).
'LNC_name'('a1:LNC_iPIOC_F2_1',iPIOC_F2_Op_general).
'LNC_name'('a1:LNC_iPIOC_F3_1',iPIOC_F3_Op_general).
'LNC_name'('a1:LNC_iPIOC_F4_1',iPIOC_F4_Op_general).
'LNC_name'('a1:LNC_iPIOC_F5_1',iPIOC_F5_Op_general).
'LNC_name'('a1:LNC_iPIOC_T_1',iPIOC_T_Op_general).
'LNC_name'('a1:LNC_iPTRC_F1_1',iPTRC_F1_Tr_general).
'LNC_name'('a1:LNC_iPTRC_F1_2','Tr_general_iPTRC_F1_iPIOC_T').
'LNC_name'('a1:LNC_iPTRC_F1_3','Tr_general_iPTRC_F1_iPIOC_F4').
'LNC_name'('a1:LNC_iPTRC_F1_4','Tr_general_iPTRC_F1_iPIOC_F4').
'LNC_name'('a1:LNC_iPTRC_F1_5','Tr_general_iPTRC_F1_iPIOC_F3').
'LNC_name'('a1:LNC_iPTRC_F1_6','Tr_general_iPTRC_F1_iPIOC_F2').
'LNC_name'('a1:LNC_iPTRC_F2_1',iPTRC_F2_Tr_general).
'LNC_name'('a1:LNC_iPTRC_F2_2','Tr_general_iPTRC_F2_iPIOC_T').
'LNC_name'('a1:LNC_iPTRC_F2_3','Tr_general_iPTRC_F2_iPIOC_F4').
'LNC_name'('a1:LNC_iPTRC_F2_4','Tr_general_iPTRC_F2_iPIOC_F3').
'LNC_name'('a1:LNC_iPTRC_F2_5','Tr_general_iPTRC_F2_iPIOC_F5').
'LNC_name'('a1:LNC_iPTRC_F2_6','Tr_general_iPTRC_F2_iPIOC_F1').
'LNC_name'('a1:LNC_iPTRC_F3_1',iPTRC_F3_Tr_general).
'LNC_name'('a1:LNC_iPTRC_F3_2','Tr_general_iPTRC_F3_iPIOC_T').
'LNC_name'('a1:LNC_iPTRC_F3_3','Tr_general_iPTRC_F3_iPIOC_F4').
'LNC_name'('a1:LNC_iPTRC_F3_4','Tr_general_iPTRC_F3_iPIOC_F5').
'LNC_name'('a1:LNC_iPTRC_F3_5','Tr_general_iPTRC_F3_iPIOC_F2').
'LNC_name'('a1:LNC_iPTRC_F3_6','Tr_general_iPTRC_F3_iPIOC_F1').
'LNC_name'('a1:LNC_iPTRC_F4_1',iPTRC_F4_Tr_general).
'LNC_name'('a1:LNC_iPTRC_F4_2','Tr_general_iPTRC_F4_iPIOC_T').
'LNC_name'('a1:LNC_iPTRC_F4_3','Tr_general_iPTRC_F4_iPIOC_F1').
'LNC_name'('a1:LNC_iPTRC_F4_4','Tr_general_iPTRC_F4_iPIOC_F2').
'LNC_name'('a1:LNC_iPTRC_F4_5','Tr_general_iPTRC_F4_iPIOC_F5').
'LNC_name'('a1:LNC_iPTRC_F4_6','Tr_general_iPTRC_F4_iPIOC_F3').
'LNC_name'('a1:LNC_iPTRC_F5_1',iPTRC_F5_Tr_general).
'LNC_name'('a1:LNC_iPTRC_F5_2','Tr_general_iPTRC_F5_iPIOC_T').
'LNC_name'('a1:LNC_iPTRC_F5_3','Tr_general_iPTRC_F5_iPIOC_F4').
'LNC_name'('a1:LNC_iPTRC_F5_4','Tr_general_iPTRC_F5_iPIOC_F3').
'LNC_name'('a1:LNC_iPTRC_F5_5','Tr_general_iPTRC_F5_iPIOC_F2').
'LNC_name'('a1:LNC_iPTRC_F5_6','Tr_general_iPTRC_F5_iPIOC_F1').
'LNC_name'('a1:LNC_iPTRC_T_1',iPTRC_T_Tr_general).
'LNC_name'('a1:LNC_iPTRC_T_2','Tr_general_iPTRC_T_iXCBR_F1').
'LNC_name'('a1:LNC_iPTRC_T_3','Tr_general_iPTRC_T_iXCBR_F2').
'LNC_name'('a1:LNC_iPTRC_T_4','Tr_general_iPTRC_T_iXCBR_F3').
'LNC_name'('a1:LNC_iPTRC_T_5','Tr_general_iPTRC_T_iXCBR_F4').
'LNC_name'('a1:LNC_iPTRC_T_6','Tr_general_iPTRC_T_iXCBR_F5').
'LNC_name'('a1:LNC_iTCTR_F1_1',iTCTR_F1_AmpSv_instMag).
'LNC_name'('a1:LNC_iTCTR_F2_1',iTCTR_F2_AmpSv_instMag).
'LNC_name'('a1:LNC_iTCTR_F3_1',iTCTR_F3_AmpSv_instMag).
'LNC_name'('a1:LNC_iTCTR_F4_1',iTCTR_F4_AmpSv_instMag).
'LNC_name'('a1:LNC_iTCTR_F5_1',iTCTR_F5_AmpSv_instMag).
'LNC_name'('a1:LNC_iTCTR_T_1',iTCTR_T_AmpSv_instMag).
'LNC_to'('a1:LNC_iPIOC_F1_1','F1_iPTRC_1').
'LNC_to'('a1:LNC_iPIOC_F2_1','F2_iPTRC_1').
'LNC_to'('a1:LNC_iPIOC_F3_1','F3_iPTRC_1').
'LNC_to'('a1:LNC_iPIOC_F4_1','F4_iPTRC_1').
'LNC_to'('a1:LNC_iPIOC_F5_1','F5_iPTRC_1').
'LNC_to'('a1:LNC_iPIOC_T_1','Tr_iPTRC_1').
'LNC_to'('a1:LNC_iPTRC_F1_1','F1_iXCBR_1').
'LNC_to'('a1:LNC_iPTRC_F1_2','Tr_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F1_3','F4_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F1_4','F5_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F1_5','F3_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F1_6','F2_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F2_1','F2_iXCBR_1').
'LNC_to'('a1:LNC_iPTRC_F2_2','Tr_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F2_3','F4_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F2_4','F3_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F2_5','F5_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F2_6','F1_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F3_1','F3_iXCBR_1').
'LNC_to'('a1:LNC_iPTRC_F3_2','Tr_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F3_3','F4_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F3_4','F5_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F3_5','F2_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F3_6','F1_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F4_1','F4_iXCBR_1').
'LNC_to'('a1:LNC_iPTRC_F4_2','Tr_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F4_3','F1_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F4_4','F2_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F4_5','F5_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F4_6','F3_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F5_1','F5_iXCBR_1').
'LNC_to'('a1:LNC_iPTRC_F5_2','Tr_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F5_3','F4_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F5_4','F3_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F5_5','F2_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_F5_6','F1_iPIOC_1').
'LNC_to'('a1:LNC_iPTRC_T_1','Tr_iXCBR_1').
'LNC_to'('a1:LNC_iPTRC_T_2','F1_iXCBR_1').
'LNC_to'('a1:LNC_iPTRC_T_3','F2_iXCBR_1').
'LNC_to'('a1:LNC_iPTRC_T_4','F3_iXCBR_1').
'LNC_to'('a1:LNC_iPTRC_T_5','F4_iXCBR_1').
'LNC_to'('a1:LNC_iPTRC_T_6','F5_iXCBR_1').
'LNC_to'('a1:LNC_iTCTR_F1_1','F1_iPIOC_1').
'LNC_to'('a1:LNC_iTCTR_F2_1','F2_iPIOC_1').
'LNC_to'('a1:LNC_iTCTR_F3_1','F3_iPIOC_1').
'LNC_to'('a1:LNC_iTCTR_F4_1','F4_iPIOC_1').
'LNC_to'('a1:LNC_iTCTR_F5_1','F5_iPIOC_1').
'LNC_to'('a1:LNC_iTCTR_T_1','Tr_iPIOC_1').
'LNC_type'('a1:LNC_iPIOC_F1_1','BOOLEAN').
'LNC_type'('a1:LNC_iPIOC_F2_1','BOOLEAN').
'LNC_type'('a1:LNC_iPIOC_F3_1','BOOLEAN').
'LNC_type'('a1:LNC_iPIOC_F4_1','BOOLEAN').
'LNC_type'('a1:LNC_iPIOC_F5_1','BOOLEAN').
'LNC_type'('a1:LNC_iPIOC_T_1','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F1_1','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F1_2','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F1_3','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F1_4','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F1_5','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F1_6','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F2_1','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F2_2','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F2_3','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F2_4','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F2_5','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F2_6','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F3_1','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F3_2','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F3_3','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F3_4','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F3_5','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F3_6','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F4_1','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F4_2','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F4_3','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F4_4','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F4_5','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F4_6','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F5_1','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F5_2','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F5_3','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F5_4','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F5_5','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_F5_6','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_T_1','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_T_2','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_T_3','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_T_4','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_T_5','BOOLEAN').
'LNC_type'('a1:LNC_iPTRC_T_6','BOOLEAN').
'LNC_type'('a1:LNC_iTCTR_F1_1','REAL').
'LNC_type'('a1:LNC_iTCTR_F2_1','REAL').
'LNC_type'('a1:LNC_iTCTR_F3_1','REAL').
'LNC_type'('a1:LNC_iTCTR_F4_1','REAL').
'LNC_type'('a1:LNC_iTCTR_F5_1','REAL').
'LNC_type'('a1:LNC_iTCTR_T_1','REAL').
from_DA('a1:ACT_1_Tr_1_DA1','ACT_1_Tr_1_DA1').
from_DO('a1:iPIOC_1_DO1',iPIOC_1_DO1).
has_AccessPoint('a1:IED_Feeder_1','a1:F1_1_AP_1').
has_AccessPoint('a1:IED_Feeder_2','a1:F2_1_AP_1').
has_AccessPoint('a1:IED_Feeder_3','a1:F3_1_AP_1').
has_AccessPoint('a1:IED_Feeder_4','a1:F4_1_AP_1').
has_AccessPoint('a1:IED_Transformer_1','a1:Tr_1_AP_1').
has_Address('a1:F1_ConnectedAP_1','a1:F1_ConnectedAP_1_Address_1').
has_Address('a1:F2_ConnectedAP_1','a1:F2_ConnectedAP_1_Address_1').
has_Address('a1:F3_ConnectedAP_1','a1:F3_ConnectedAP_1_Address_1').
has_Address('a1:F4_ConnectedAP_1','a1:F4_ConnectedAP_1_Address_1').
has_Address('a1:F5_ConnectedAP_1','a1:F5_ConnectedAP_1_Address_1').
has_Address('a1:Tr_ConnectedAP_1','a1:Tr_ConnectedAP_1_Address_1').
has_BDA('a1:AnalogueValue_1_1','a1:AnalogueValue_1_BDA1').
has_BDA('a1:SAV_1_AmpSV_1_DA1','a1:AnalogueValue_1_BDA1').
has_ConnectedAP('a1:SubNetwork_1','a1:F1_ConnectedAP_1').
has_ConnectedAP('a1:SubNetwork_1','a1:F2_ConnectedAP_1').
has_ConnectedAP('a1:SubNetwork_1','a1:Tr_ConnectedAP_1').
has_DA('a1:ACT_1_Tr_1','a1:ACT_1_Tr_1_DA1').
has_DA('a1:DPC_1_Pos_1','a1:DPC_1_Pos_1_DA1').
has_DA('a1:DPL_1_PhyNam_1','a1:DPL_1_PhyNam_1_DA1').
has_DA('a1:SAV_1_AmpSv_1','a1:SAV_1_AmpSV_1_DA1').
has_DO('a1:LLN01_1','a1:LLN01_1_DO1').
has_DO('a1:LPHD1_1','a1:LPHD1_1_DO1').
has_DO('a1:iPIOC_1','a1:iPIOC_1_DO1').
has_DO('a1:iPTRC_1','a1:iPTRC_1_DO1').
has_DO('a1:iTCTR_1','a1:iTCTR_1_DO1').
has_DO('a1:iXCBR_1','a1:iXCBR_1_DO1').
has_DO('a1:iXCBR_1_DO1','a1:iXCBR_1_DO1').
has_DataSet('a1:F1_LLN01','a1:F1_DataSet_1').
has_DataSet('a1:F2_LLN01','a1:F2_DataSet_1').
has_DataSet('a1:F3_LLN01','a1:F3_DataSet_1').
has_DataSet('a1:F4_LLN01','a1:F4_DataSet_1').
has_DataSet('a1:F5_LLN01','a1:F5_DataSet_1').
has_DataSet('a1:Tr_LLN01','a1:Tr_DataSet_1').
has_DataSet('a1:Tr_LLN01','a1:Tr_DataSet_2').
has_EnumVal('a1:Beh_1','a1:Beh_1_EnumVal1').
has_EnumVal('a1:Beh_1','a1:Beh_1_EnumVal2').
has_EnumVal('a1:Beh_1','a1:Beh_1_EnumVal3').
has_EnumVal('a1:Beh_1','a1:Beh_1_EnumVal4').
has_EnumVal('a1:Beh_1','a1:Beh_1_EnumVal5').
has_EnumVal('a1:Health_1','a1:Health_1_EnumVal1').
has_EnumVal('a1:Health_1','a1:Health_1_EnumVal2').
has_EnumVal('a1:Health_1','a1:Health_1_EnumVal3').
has_EnumVal('a1:Mod_1','a1:Mod_1_EnumVal1').
has_EnumVal('a1:Mod_1','a1:Mod_1_EnumVal2').
has_EnumVal('a1:Mod_1','a1:Mod_1_EnumVal3').
has_EnumVal('a1:Mod_1','a1:Mod_1_EnumVal4').
has_EnumVal('a1:Mod_1','a1:Mod_1_EnumVal5').
has_EnumVal('a1:PhyHealth_1','a1:PhyHealth_1_EnumVal1').
has_EnumVal('a1:PhyHealth_1','a1:PhyHealth_1_EnumVal2').
has_EnumVal('a1:PhyHealth_1','a1:PhyHealth_1_EnumVal3').
has_EnumVal('a1:ctlModel_1','a1:ctlModel_1_EnumVal1').
has_EnumVal('a1:ctlModel_1','a1:ctlModel_1_EnumVal2').
has_EnumVal('a1:ctlModel_1','a1:ctlModel_1_EnumVal3').
has_EnumVal('a1:ctlModel_1','a1:ctlModel_1_EnumVal4').
has_EnumVal('a1:ctlModel_1','a1:ctlModel_1_EnumVal5').
has_FCDA('a1:F1_DataSet_1','a1:F1_FeederTrip_FCDA_1').
has_FCDA('a1:F2_DataSet_1','a1:F2_FeederTrip_FCDA_1').
has_FCDA('a1:F3_DataSet_1','a1:F3_FeederTrip_FCDA_1').
has_FCDA('a1:F4_DataSet_1','a1:F4_FeederTrip_FCDA_1').
has_FCDA('a1:F5_DataSet_1','a1:F5_FeederTrip_FCDA_1').
has_FCDA('a1:Tr_DataSet_1','a1:Tr_FeederTrip_FCDA_1').
has_FCDA('a1:Tr_DataSet_2','a1:Tr_TripF1_FCDA_1').
has_FCDA('a1:Tr_DataSet_3','a1:Tr_TripF2_FCDA_1').
has_FCDA('a1:Tr_DataSet_4','a1:Tr_TripF3_FCDA_1').
has_FCDA('a1:Tr_DataSet_5','a1:Tr_TripF4_FCDA_1').
has_FCDA('a1:Tr_DataSet_6','a1:Tr_TripF5_FCDA_1').
has_LDevice('a1:F1_1_Server_1','a1:F1_1_LDevice_1').
has_LDevice('a1:F2_1_Server_1','a1:F2_1_LDevice_1').
has_LDevice('a1:F3_1_Server_1','a1:F3_1_LDevice_1').
has_LDevice('a1:F4_1_Server_1','a1:F4_1_LDevice_1').
has_LDevice('a1:F5_1_Server_1','a1:F5_1_LDevice_1').
has_LDevice('a1:Tr_1_Server_1','a1:Tr_1_LDevice_1').
has_LN('a1:F1_1_LDevice_1','a1:F1_1_LDevice_1_iPIOC_1').
has_LN('a1:F1_1_LDevice_1','a1:F1_1_LDevice_1_iPTRC_1').
has_LN('a1:F1_1_LDevice_1','a1:F1_1_LDevice_1_iTCTR_1').
has_LN('a1:F1_1_LDevice_1','a1:F1_1_LDevice_1_iXCBR_1').
has_LN('a1:F2_1_LDevice_1','a1:F2_1_LDevice_1_iPIOC_1').
has_LN('a1:F2_1_LDevice_1','a1:F2_1_LDevice_1_iPTRC_1').
has_LN('a1:F2_1_LDevice_1','a1:F2_1_LDevice_1_iTCTR_1').
has_LN('a1:F2_1_LDevice_1','a1:F2_1_LDevice_1_iXCBR_1').
has_LN('a1:F3_1_LDevice_1','a1:F3_1_LDevice_1_iPIOC_1').
has_LN('a1:F3_1_LDevice_1','a1:F3_1_LDevice_1_iPTRC_1').
has_LN('a1:F3_1_LDevice_1','a1:F3_1_LDevice_1_iTCTR_1').
has_LN('a1:F3_1_LDevice_1','a1:F3_1_LDevice_1_iXCBR_1').
has_LN('a1:F4_1_LDevice_1','a1:F4_1_LDevice_1_iPIOC_1').
has_LN('a1:F4_1_LDevice_1','a1:F4_1_LDevice_1_iPTRC_1').
has_LN('a1:F4_1_LDevice_1','a1:F4_1_LDevice_1_iTCTR_1').
has_LN('a1:F4_1_LDevice_1','a1:F4_1_LDevice_1_iXCBR_1').
has_LN('a1:F5_1_LDevice_1','a1:F5_1_LDevice_1_iPIOC_1').
has_LN('a1:F5_1_LDevice_1','a1:F5_1_LDevice_1_iPTRC_1').
has_LN('a1:F5_1_LDevice_1','a1:F5_1_LDevice_1_iTCTR_1').
has_LN('a1:F5_1_LDevice_1','a1:F5_1_LDevice_1_iXCBR_1').
has_LN('a1:IED_Feeder_5','a1:F5_1_AP_1').
has_LN('a1:Tr_1_LDevice_1','a1:Tr_1_LDevice_1_iPIOC_1').
has_LN('a1:Tr_1_LDevice_1','a1:Tr_1_LDevice_1_iPTRC_1').
has_LN('a1:Tr_1_LDevice_1','a1:Tr_1_LDevice_1_iTCTR_1').
has_LN('a1:Tr_1_LDevice_1','a1:Tr_1_LDevice_1_iXCBR_1').
has_LN0('a1:F1_1_LDevice_1','a1:F1_LLN01').
has_LN0('a1:F2_1_LDevice_1','a1:F2_LLN01').
has_LN0('a1:F3_1_LDevice_1','a1:F3_LLN01').
has_LN0('a1:F4_1_LDevice_1','a1:F4_LLN01').
has_LN0('a1:F5_1_LDevice_1','a1:F5_LLN01').
has_LN0('a1:Tr_1_LDevice_1','a1:Tr_LLN01').
has_LNConnections('a1:F1_1_LDevice_1_iPIOC_1','a1:LNC_iPIOC_F1_1').
has_LNConnections('a1:F1_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F2_6').
has_LNConnections('a1:F1_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F3_6').
has_LNConnections('a1:F1_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F4_3').
has_LNConnections('a1:F1_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F5_6').
has_LNConnections('a1:F1_1_LDevice_1_iPIOC_1','a1:LNC_iTCTR_F1_1').
has_LNConnections('a1:F1_1_LDevice_1_iPTRC_1','a1:LNC_iPIOC_F1_1').
has_LNConnections('a1:F1_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F1_1').
has_LNConnections('a1:F1_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F1_2').
has_LNConnections('a1:F1_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F1_3').
has_LNConnections('a1:F1_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F1_4').
has_LNConnections('a1:F1_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F1_5').
has_LNConnections('a1:F1_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F1_6').
has_LNConnections('a1:F1_1_LDevice_1_iTCTR_1','a1:LNC_iTCTR_F1_1').
has_LNConnections('a1:F1_1_LDevice_1_iXCBR_1','a1:LNC_iPTRC_F1_1').
has_LNConnections('a1:F1_1_LDevice_1_iXCBR_1','a1:LNC_iPTRC_T_2').
has_LNConnections('a1:F2_1_LDevice_1_iPIOC_1','a1:LNC_iPIOC_F2_1').
has_LNConnections('a1:F2_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F1_6').
has_LNConnections('a1:F2_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F3_5').
has_LNConnections('a1:F2_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F4_4').
has_LNConnections('a1:F2_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F5_5').
has_LNConnections('a1:F2_1_LDevice_1_iPIOC_1','a1:LNC_iTCTR_F2_1').
has_LNConnections('a1:F2_1_LDevice_1_iPTRC_1','a1:LNC_iPIOC_F2_1').
has_LNConnections('a1:F2_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F2_1').
has_LNConnections('a1:F2_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F2_2').
has_LNConnections('a1:F2_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F2_3').
has_LNConnections('a1:F2_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F2_4').
has_LNConnections('a1:F2_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F2_5').
has_LNConnections('a1:F2_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F2_6').
has_LNConnections('a1:F2_1_LDevice_1_iTCTR_1','a1:LNC_iTCTR_F2_1').
has_LNConnections('a1:F2_1_LDevice_1_iXCBR_1','a1:LNC_iPTRC_F2_1').
has_LNConnections('a1:F2_1_LDevice_1_iXCBR_1','a1:LNC_iPTRC_T_3').
has_LNConnections('a1:F3_1_LDevice_1_iPIOC_1','a1:LNC_iPIOC_F3_1').
has_LNConnections('a1:F3_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F1_5').
has_LNConnections('a1:F3_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F2_4').
has_LNConnections('a1:F3_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F4_6').
has_LNConnections('a1:F3_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F5_4').
has_LNConnections('a1:F3_1_LDevice_1_iPIOC_1','a1:LNC_iTCTR_F3_1').
has_LNConnections('a1:F3_1_LDevice_1_iPTRC_1','a1:LNC_iPIOC_F3_1').
has_LNConnections('a1:F3_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F3_1').
has_LNConnections('a1:F3_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F3_2').
has_LNConnections('a1:F3_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F3_3').
has_LNConnections('a1:F3_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F3_4').
has_LNConnections('a1:F3_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F3_5').
has_LNConnections('a1:F3_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F3_6').
has_LNConnections('a1:F3_1_LDevice_1_iTCTR_1','a1:LNC_iTCTR_F3_1').
has_LNConnections('a1:F3_1_LDevice_1_iXCBR_1','a1:LNC_iPTRC_F3_1').
has_LNConnections('a1:F3_1_LDevice_1_iXCBR_1','a1:LNC_iPTRC_T_4').
has_LNConnections('a1:F4_1_LDevice_1_iPIOC_1','a1:LNC_iPIOC_F4_1').
has_LNConnections('a1:F4_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F1_3').
has_LNConnections('a1:F4_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F2_3').
has_LNConnections('a1:F4_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F3_3').
has_LNConnections('a1:F4_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F5_3').
has_LNConnections('a1:F4_1_LDevice_1_iPIOC_1','a1:LNC_iTCTR_F4_1').
has_LNConnections('a1:F4_1_LDevice_1_iPTRC_1','a1:LNC_iPIOC_F4_1').
has_LNConnections('a1:F4_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F4_1').
has_LNConnections('a1:F4_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F4_2').
has_LNConnections('a1:F4_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F4_3').
has_LNConnections('a1:F4_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F4_4').
has_LNConnections('a1:F4_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F4_5').
has_LNConnections('a1:F4_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F4_6').
has_LNConnections('a1:F4_1_LDevice_1_iTCTR_1','a1:LNC_iTCTR_F4_1').
has_LNConnections('a1:F4_1_LDevice_1_iXCBR_1','a1:LNC_iPTRC_F4_1').
has_LNConnections('a1:F4_1_LDevice_1_iXCBR_1','a1:LNC_iPTRC_T_5').
has_LNConnections('a1:F5_1_LDevice_1_iPIOC_1','a1:LNC_iPIOC_F5_1').
has_LNConnections('a1:F5_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F1_4').
has_LNConnections('a1:F5_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F2_5').
has_LNConnections('a1:F5_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F3_4').
has_LNConnections('a1:F5_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F4_5').
has_LNConnections('a1:F5_1_LDevice_1_iPIOC_1','a1:LNC_iTCTR_F5_1').
has_LNConnections('a1:F5_1_LDevice_1_iPTRC_1','a1:LNC_iPIOC_F5_1').
has_LNConnections('a1:F5_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F5_1').
has_LNConnections('a1:F5_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F5_2').
has_LNConnections('a1:F5_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F5_3').
has_LNConnections('a1:F5_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F5_4').
has_LNConnections('a1:F5_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F5_5').
has_LNConnections('a1:F5_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_F5_6').
has_LNConnections('a1:F5_1_LDevice_1_iTCTR_1','a1:LNC_iTCTR_F5_1').
has_LNConnections('a1:F5_1_LDevice_1_iXCBR_1','a1:LNC_iPTRC_F5_1').
has_LNConnections('a1:F5_1_LDevice_1_iXCBR_1','a1:LNC_iPTRC_T_6').
has_LNConnections('a1:Tr_1_LDevice_1_iPIOC_1','a1:LNC_iPIOC_T_1').
has_LNConnections('a1:Tr_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F1_2').
has_LNConnections('a1:Tr_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F2_2').
has_LNConnections('a1:Tr_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F3_2').
has_LNConnections('a1:Tr_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F4_2').
has_LNConnections('a1:Tr_1_LDevice_1_iPIOC_1','a1:LNC_iPTRC_F5_2').
has_LNConnections('a1:Tr_1_LDevice_1_iPIOC_1','a1:LNC_iTCTR_T_1').
has_LNConnections('a1:Tr_1_LDevice_1_iPTRC_1','a1:LNC_iPIOC_T_1').
has_LNConnections('a1:Tr_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_T_1').
has_LNConnections('a1:Tr_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_T_2').
has_LNConnections('a1:Tr_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_T_3').
has_LNConnections('a1:Tr_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_T_4').
has_LNConnections('a1:Tr_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_T_5').
has_LNConnections('a1:Tr_1_LDevice_1_iPTRC_1','a1:LNC_iPTRC_T_6').
has_LNConnections('a1:Tr_1_LDevice_1_iTCTR_1','a1:LNC_iTCTR_T_1').
has_LNConnections('a1:Tr_1_LDevice_1_iXCBR_1','a1:LNC_iPTRC_T_1').
has_P('a1:F1_ConnectedAP_1_Address_1','a1:F1_Address_1_P_1').
has_P('a1:F2_ConnectedAP_1_Address_1','a1:F2_Address_1_P_1').
has_P('a1:F3_ConnectedAP_1_Address_1','a1:F3_Address_1_P_1').
has_P('a1:F4_ConnectedAP_1_Address_1','a1:F4_Address_1_P_1').
has_P('a1:F5_ConnectedAP_1_Address_1','a1:F5_Address_1_P_1').
has_P('a1:Tr_ConnectedAP_1_Address_1','a1:Tr_Address_1_P_1').
has_Server('a1:F1_1_AP_1','a1:F1_1_Server_1').
has_Server('a1:F2_1_AP_1','a1:F2_1_Server_1').
has_Server('a1:F3_1_AP_1','a1:F3_1_Server_1').
has_Server('a1:F4_1_AP_1','a1:F4_1_Server_1').
has_Server('a1:F5_1_AP_1','a1:F5_1_Server_1').
has_Server('a1:Tr_1_AP_1','a1:Tr_1_Server_1').
has_Value('a1:F1_Address_1_P_1','192.168.1.1').
has_Value('a1:F2_Address_1_P_1','192.168.1.1').
has_Value('a1:F3_Address_1_P_1','192.168.1.1').
has_Value('a1:F4_Address_1_P_1','192.168.1.1').
has_Value('a1:F5_Address_1_P_1','192.168.1.1').
has_Value('a1:Tr_Address_1_P_1','192.168.1.1').
has_apName('a1:Tr_ConnectedAP_1',accessPoint1).
has_bType('a1:AnalogueValue_1_BDA1','FLOAT32').
has_bType('a1:AnalogueValue_1_BDA2','INT32').
has_bType('a1:DPC_1_Pos_1_DA1','Dbpos').
has_bType('a1:DPL_1_PhyNam_1_DA1','VisString255').
has_cdc('a1:ACT_1_Tr_1','ACT').
has_cdc('a1:DPC_1_Pos_1','DPC').
has_cdc('a1:DPL_1_PhyNam_1','DPL').
has_cdc('a1:SAV_1_AmpSv_1','SAV').
has_daName('a1:F1_FeederTrip_FCDA_1',general).
has_daName('a1:F2_FeederTrip_FCDA_1',general).
has_daName('a1:F3_FeederTrip_FCDA_1',general).
has_daName('a1:F4_FeederTrip_FCDA_1',general).
has_daName('a1:F5_FeederTrip_FCDA_1',general).
has_daName('a1:Tr_FeederTrip_FCDA_1',general).
has_daName('a1:Tr_TripF1_FCDA_1',general).
has_daName('a1:Tr_TripF2_FCDA_1',general).
has_daName('a1:Tr_TripF3_FCDA_1',general).
has_daName('a1:Tr_TripF4_FCDA_1',general).
has_daName('a1:Tr_TripF5_FCDA_1',general).
has_doName('a1:F1_FeederTrip_FCDA_1','Op').
has_doName('a1:F2_FeederTrip_FCDA_1','Op').
has_doName('a1:F3_FeederTrip_FCDA_1','Op').
has_doName('a1:F4_FeederTrip_FCDA_1','Op').
has_doName('a1:F5_FeederTrip_FCDA_1','Op').
has_doName('a1:Tr_FeederTrip_FCDA_1','Op').
has_doName('a1:Tr_TripF1_FCDA_1','Op').
has_doName('a1:Tr_TripF2_FCDA_1','Op').
has_doName('a1:Tr_TripF3_FCDA_1','Op').
has_doName('a1:Tr_TripF4_FCDA_1','Op').
has_doName('a1:Tr_TripF5_FCDA_1','Op').
has_fc('a1:ACT_1_Tr_1_DA1','ST').
has_fc('a1:DPC_1_Pos_1_DA1','ST').
has_fc('a1:DPL_1_PhyNam_1_DA1','DC').
has_fc('a1:F1_FeederTrip_FCDA_1','ST').
has_fc('a1:F2_FeederTrip_FCDA_1','ST').
has_fc('a1:F3_FeederTrip_FCDA_1','ST').
has_fc('a1:F4_FeederTrip_FCDA_1','ST').
has_fc('a1:F5_FeederTrip_FCDA_1','ST').
has_fc('a1:SAV_1_AmpSV_1_DA1','MX').
has_fc('a1:Tr_FeederTrip_FCDA_1','ST').
has_fc('a1:Tr_TripF1_FCDA_1','ST').
has_fc('a1:Tr_TripF2_FCDA_1','ST').
has_fc('a1:Tr_TripF3_FCDA_1','ST').
has_fc('a1:Tr_TripF4_FCDA_1','ST').
has_fc('a1:Tr_TripF5_FCDA_1','ST').
has_id('a1:ACT_1_Tr_1','ACT_1_Tr').
has_id('a1:AnalogueValue_1_1','AnalogueValue_1').
has_id('a1:Beh_1','Beh').
has_id('a1:DPC_1_Pos_1','DPC_1_Pos').
has_id('a1:DPL_1_PhyNam_1','DPL_1_PhyNam').
has_id('a1:Health_1','Health').
has_id('a1:LLN01_1','LLN01').
has_id('a1:LPHD1_1','LPHD1').
has_id('a1:Mod_1','Mod').
has_id('a1:PhyHealth_1','PhyHealth').
has_id('a1:SAV_1_AmpSv_1','SAV_1_AmpSv').
has_id('a1:ctlModel_1',ctlModel).
has_id('a1:iPIOC_1',iPIOC).
has_id('a1:iPTRC_1',iPTRC).
has_id('a1:iTCTR_1',iTCTR).
has_id('a1:iXCBR_1',iXCBR).
has_iedName('a1:F1_ConnectedAP_1','IED1_D3_Q1').
has_iedName('a1:F2_ConnectedAP_1','IED2_D3_Q2').
has_iedName('a1:F3_ConnectedAP_1','IED3_D3_Q3').
has_iedName('a1:F4_ConnectedAP_1','IED4_D3_Q4').
has_iedName('a1:F5_ConnectedAP_1','IED5_D3_Q5').
has_iedName('a1:Tr_ConnectedAP_1','TransformerIED').
has_inst('a1:F1_1_LDevice_1','LD1').
has_inst('a1:F1_1_LDevice_1_iPIOC_1','1').
has_inst('a1:F1_1_LDevice_1_iPTRC_1','1').
has_inst('a1:F1_1_LDevice_1_iTCTR_1','1').
has_inst('a1:F1_1_LDevice_1_iXCBR_1','1').
has_inst('a1:F1_LLN01','1').
has_inst('a1:F2_1_LDevice_1','LD1').
has_inst('a1:F2_1_LDevice_1_iPIOC_1','1').
has_inst('a1:F2_1_LDevice_1_iPTRC_1','1').
has_inst('a1:F2_1_LDevice_1_iTCTR_1','1').
has_inst('a1:F2_1_LDevice_1_iXCBR_1','1').
has_inst('a1:F2_LLN01','1').
has_inst('a1:F3_1_LDevice_1','LD1').
has_inst('a1:F3_1_LDevice_1_iPIOC_1','1').
has_inst('a1:F3_1_LDevice_1_iPTRC_1','1').
has_inst('a1:F3_1_LDevice_1_iTCTR_1','1').
has_inst('a1:F3_1_LDevice_1_iXCBR_1','1').
has_inst('a1:F3_LLN01','1').
has_inst('a1:F4_1_LDevice_1','LD1').
has_inst('a1:F4_1_LDevice_1_iPIOC_1','1').
has_inst('a1:F4_1_LDevice_1_iPTRC_1','1').
has_inst('a1:F4_1_LDevice_1_iTCTR_1','1').
has_inst('a1:F4_1_LDevice_1_iXCBR_1','1').
has_inst('a1:F4_LLN01','1').
has_inst('a1:F5_1_LDevice_1','LD1').
has_inst('a1:F5_1_LDevice_1_iPIOC_1','1').
has_inst('a1:F5_1_LDevice_1_iPTRC_1','1').
has_inst('a1:F5_1_LDevice_1_iTCTR_1','1').
has_inst('a1:F5_1_LDevice_1_iXCBR_1','1').
has_inst('a1:F5_LLN01','1').
has_inst('a1:Tr_1_LDevice_1','LD1').
has_inst('a1:Tr_1_LDevice_1_iPIOC_1','1').
has_inst('a1:Tr_1_LDevice_1_iPTRC_1','1').
has_inst('a1:Tr_1_LDevice_1_iTCTR_1','1').
has_inst('a1:Tr_1_LDevice_1_iXCBR_1','1').
has_inst('a1:Tr_LLN01','1').
has_ldInst('a1:F1_FeederTrip_FCDA_1','LD1').
has_ldInst('a1:F2_FeederTrip_FCDA_1','LD1').
has_ldInst('a1:F3_FeederTrip_FCDA_1','LD1').
has_ldInst('a1:F4_FeederTrip_FCDA_1','LD1').
has_ldInst('a1:F5_FeederTrip_FCDA_1','LD1').
has_ldInst('a1:Tr_FeederTrip_FCDA_1','LD1').
has_ldInst('a1:Tr_TripF1_FCDA_1','LD1').
has_ldInst('a1:Tr_TripF2_FCDA_1','LD1').
has_ldInst('a1:Tr_TripF3_FCDA_1','LD1').
has_ldInst('a1:Tr_TripF4_FCDA_1','LD1').
has_ldInst('a1:Tr_TripF5_FCDA_1','LD1').
has_lnClass('a1:F1_1_LDevice_1_iPIOC_1','PIOC').
has_lnClass('a1:F1_1_LDevice_1_iPTRC_1','PTRC').
has_lnClass('a1:F1_1_LDevice_1_iTCTR_1','TCTR').
has_lnClass('a1:F1_1_LDevice_1_iXCBR_1','XCBR').
has_lnClass('a1:F1_FeederTrip_FCDA_1','PIOC').
has_lnClass('a1:F1_LLN01','LLN0').
has_lnClass('a1:F2_1_LDevice_1_iPIOC_1','PIOC').
has_lnClass('a1:F2_1_LDevice_1_iPTRC_1','PTRC').
has_lnClass('a1:F2_1_LDevice_1_iTCTR_1','TCTR').
has_lnClass('a1:F2_1_LDevice_1_iXCBR_1','XCBR').
has_lnClass('a1:F2_FeederTrip_FCDA_1','PIOC').
has_lnClass('a1:F2_LLN01','LLN0').
has_lnClass('a1:F3_1_LDevice_1_iPIOC_1','PIOC').
has_lnClass('a1:F3_1_LDevice_1_iPTRC_1','PTRC').
has_lnClass('a1:F3_1_LDevice_1_iTCTR_1','TCTR').
has_lnClass('a1:F3_1_LDevice_1_iXCBR_1','XCBR').
has_lnClass('a1:F3_FeederTrip_FCDA_1','PIOC').
has_lnClass('a1:F3_LLN01','LLN0').
has_lnClass('a1:F4_1_LDevice_1_iPIOC_1','PIOC').
has_lnClass('a1:F4_1_LDevice_1_iPTRC_1','PTRC').
has_lnClass('a1:F4_1_LDevice_1_iTCTR_1','TCTR').
has_lnClass('a1:F4_1_LDevice_1_iXCBR_1','XCBR').
has_lnClass('a1:F4_FeederTrip_FCDA_1','PIOC').
has_lnClass('a1:F4_LLN01','LLN0').
has_lnClass('a1:F5_1_LDevice_1_iPIOC_1','PIOC').
has_lnClass('a1:F5_1_LDevice_1_iPTRC_1','PTRC').
has_lnClass('a1:F5_1_LDevice_1_iTCTR_1','TCTR').
has_lnClass('a1:F5_1_LDevice_1_iXCBR_1','XCBR').
has_lnClass('a1:F5_FeederTrip_FCDA_1','PIOC').
has_lnClass('a1:F5_LLN01','LLN0').
has_lnClass('a1:LLN01_1','LLN0').
has_lnClass('a1:LPHD1_1','LPHD').
has_lnClass('a1:Tr_1_LDevice_1_iPIOC_1','PIOC').
has_lnClass('a1:Tr_1_LDevice_1_iPTRC_1','PTRC').
has_lnClass('a1:Tr_1_LDevice_1_iTCTR_1','TCTR').
has_lnClass('a1:Tr_1_LDevice_1_iXCBR_1','XCBR').
has_lnClass('a1:Tr_FeederTrip_FCDA_1','PIOC').
has_lnClass('a1:Tr_LLN01','LLN0').
has_lnClass('a1:Tr_TripF1_FCDA_1','PTRC').
has_lnClass('a1:Tr_TripF2_FCDA_1','PTRC').
has_lnClass('a1:Tr_TripF3_FCDA_1','PTRC').
has_lnClass('a1:Tr_TripF4_FCDA_1','PTRC').
has_lnClass('a1:Tr_TripF5_FCDA_1','PTRC').
has_lnClass('a1:iPIOC_1','PIOC').
has_lnClass('a1:iPTRC_1','PTRC').
has_lnClass('a1:iTCTR_1','TCTR').
has_lnClass('a1:iXCBR_1','XCBR').
has_lnInst('a1:F1_FeederTrip_FCDA_1','1').
has_lnInst('a1:F2_FeederTrip_FCDA_1','1').
has_lnInst('a1:F3_FeederTrip_FCDA_1','1').
has_lnInst('a1:F4_FeederTrip_FCDA_1','1').
has_lnInst('a1:F5_FeederTrip_FCDA_1','1').
has_lnInst('a1:Tr_FeederTrip_FCDA_1','1').
has_lnInst('a1:Tr_TripF1_FCDA_1','2').
has_lnInst('a1:Tr_TripF2_FCDA_1','3').
has_lnInst('a1:Tr_TripF3_FCDA_1','4').
has_lnInst('a1:Tr_TripF4_FCDA_1','5').
has_lnInst('a1:Tr_TripF5_FCDA_1','6').
has_lnType('a1:F1_1_LDevice_1_iPIOC_1',iPIOC).
has_lnType('a1:F1_1_LDevice_1_iPTRC_1',iPTRC).
has_lnType('a1:F1_1_LDevice_1_iTCTR_1',iTCTR).
has_lnType('a1:F1_1_LDevice_1_iXCBR_1',iXCBR).
has_lnType('a1:F1_LLN01','LLN01').
has_lnType('a1:F2_1_LDevice_1_iPIOC_1',iPIOC).
has_lnType('a1:F2_1_LDevice_1_iPTRC_1',iPTRC).
has_lnType('a1:F2_1_LDevice_1_iTCTR_1',iTCTR).
has_lnType('a1:F2_1_LDevice_1_iXCBR_1',iXCBR).
has_lnType('a1:F2_LLN01','LLN01').
has_lnType('a1:F3_1_LDevice_1_iPIOC_1',iPIOC).
has_lnType('a1:F3_1_LDevice_1_iPTRC_1',iPTRC).
has_lnType('a1:F3_1_LDevice_1_iTCTR_1',iTCTR).
has_lnType('a1:F3_1_LDevice_1_iXCBR_1',iXCBR).
has_lnType('a1:F3_LLN01','LLN01').
has_lnType('a1:F4_1_LDevice_1_iPIOC_1',iPIOC).
has_lnType('a1:F4_1_LDevice_1_iPTRC_1',iPTRC).
has_lnType('a1:F4_1_LDevice_1_iTCTR_1',iTCTR).
has_lnType('a1:F4_1_LDevice_1_iXCBR_1',iXCBR).
has_lnType('a1:F4_LLN01','LLN01').
has_lnType('a1:F5_1_LDevice_1_iPIOC_1',iPIOC).
has_lnType('a1:F5_1_LDevice_1_iPTRC_1',iPTRC).
has_lnType('a1:F5_1_LDevice_1_iTCTR_1',iTCTR).
has_lnType('a1:F5_1_LDevice_1_iXCBR_1',iXCBR).
has_lnType('a1:F5_LLN01','LLN01').
has_lnType('a1:Tr_1_LDevice_1_iPIOC_1',iPIOC).
has_lnType('a1:Tr_1_LDevice_1_iPTRC_1',iPTRC).
has_lnType('a1:Tr_1_LDevice_1_iTCTR_1',iTCTR).
has_lnType('a1:Tr_1_LDevice_1_iXCBR_1',iXCBR).
has_lnType('a1:Tr_LLN01','LLN01').
has_name('a1:ACT_1_Tr_1_DA1',general).
has_name('a1:AnalogueValue_1_BDA1',f).
has_name('a1:AnalogueValue_1_BDA2',i).
has_name('a1:DPC_1_Pos_1_DA1',stVal).
has_name('a1:DPL_1_PhyNam_1_DA1',vendor).
has_name('a1:F1_1_AP_1',accessPoint1).
has_name('a1:F1_DataSet_1','FeederTrip').
has_name('a1:F2_1_AP_1',accessPoint1).
has_name('a1:F2_DataSet_1','FeederTrip').
has_name('a1:F3_1_AP_1',accessPoint1).
has_name('a1:F3_DataSet_1','FeederTrip').
has_name('a1:F4_1_AP_1',accessPoint1).
has_name('a1:F4_DataSet_1','FeederTrip').
has_name('a1:F5_1_AP_1',accessPoint1).
has_name('a1:F5_DataSet_1','FeederTrip').
has_name('a1:IED_Feeder_1','IED1_D3_Q1').
has_name('a1:IED_Feeder_2','IED2_D3_Q2').
has_name('a1:IED_Feeder_3','IED3_D3_Q3').
has_name('a1:IED_Feeder_4','IED4_D3_Q4').
has_name('a1:IED_Feeder_5','IED5_D3_Q5').
has_name('a1:IED_Transformer_1','TransformerIED').
has_name('a1:LLN01_1_DO1','Mod').
has_name('a1:LPHD1_1_DO1','Beh').
has_name('a1:SAV_1_AmpSV_1_DA1',instMag).
has_name('a1:SubNetwork_1',subnetwork1).
has_name('a1:Tr_1_AP_1',accessPoint1).
has_name('a1:Tr_DataSet_1','FeederTrip').
has_name('a1:Tr_DataSet_2','TripF1').
has_name('a1:Tr_DataSet_3','TripF2').
has_name('a1:Tr_DataSet_4','TripF3').
has_name('a1:Tr_DataSet_5','TripF4').
has_name('a1:Tr_DataSet_6','TripF5').
has_name('a1:iPIOC_1_DO1','Tr').
has_name('a1:iPTRC_1_DO1','Op').
has_name('a1:iTCTR_1_DO1','AmpSv').
has_name('a1:iXCBR_1_DO1','Mod').
has_ord('a1:Beh_1_EnumVal1','1').
has_ord('a1:Beh_1_EnumVal2','2').
has_ord('a1:Beh_1_EnumVal3','3').
has_ord('a1:Beh_1_EnumVal4','4').
has_ord('a1:Beh_1_EnumVal5','5').
has_ord('a1:Health_1_EnumVal1','1').
has_ord('a1:Health_1_EnumVal2','2').
has_ord('a1:Health_1_EnumVal3','3').
has_ord('a1:Mod_1_EnumVal1','1').
has_ord('a1:Mod_1_EnumVal2','2').
has_ord('a1:Mod_1_EnumVal3','3').
has_ord('a1:Mod_1_EnumVal4','4').
has_ord('a1:Mod_1_EnumVal5','5').
has_ord('a1:PhyHealth_1_EnumVal1','1').
has_ord('a1:PhyHealth_1_EnumVal2','2').
has_ord('a1:PhyHealth_1_EnumVal3','3').
has_ord('a1:ctlModel_1_EnumVal1','0').
has_ord('a1:ctlModel_1_EnumVal2','1').
has_ord('a1:ctlModel_1_EnumVal3','2').
has_ord('a1:ctlModel_1_EnumVal4','3').
has_ord('a1:ctlModel_1_EnumVal5','4').
has_prefix('a1:F1_1_LDevice_1_iPIOC_1','F1').
has_prefix('a1:F1_1_LDevice_1_iPTRC_1','F1').
has_prefix('a1:F1_1_LDevice_1_iTCTR_1','F1').
has_prefix('a1:F1_1_LDevice_1_iXCBR_1','F1').
has_prefix('a1:F1_FeederTrip_FCDA_1','F1').
has_prefix('a1:F2_1_LDevice_1_iPIOC_1','F2').
has_prefix('a1:F2_1_LDevice_1_iPTRC_1','F2').
has_prefix('a1:F2_1_LDevice_1_iTCTR_1','F2').
has_prefix('a1:F2_1_LDevice_1_iXCBR_1','F2').
has_prefix('a1:F2_FeederTrip_FCDA_1','F2').
has_prefix('a1:F3_1_LDevice_1_iPIOC_1','F3').
has_prefix('a1:F3_1_LDevice_1_iPTRC_1','F3').
has_prefix('a1:F3_1_LDevice_1_iTCTR_1','F3').
has_prefix('a1:F3_1_LDevice_1_iXCBR_1','F3').
has_prefix('a1:F3_FeederTrip_FCDA_1','F3').
has_prefix('a1:F4_1_LDevice_1_iPIOC_1','F4').
has_prefix('a1:F4_1_LDevice_1_iPTRC_1','F4').
has_prefix('a1:F4_1_LDevice_1_iTCTR_1','F4').
has_prefix('a1:F4_1_LDevice_1_iXCBR_1','F4').
has_prefix('a1:F4_FeederTrip_FCDA_1','F4').
has_prefix('a1:F5_1_LDevice_1_iPIOC_1','F5').
has_prefix('a1:F5_1_LDevice_1_iPTRC_1','F5').
has_prefix('a1:F5_1_LDevice_1_iTCTR_1','F5').
has_prefix('a1:F5_1_LDevice_1_iXCBR_1','F5').
has_prefix('a1:F5_FeederTrip_FCDA_1','F5').
has_prefix('a1:Tr_1_LDevice_1_iPIOC_1','Tr').
has_prefix('a1:Tr_1_LDevice_1_iPTRC_1','Tr').
has_prefix('a1:Tr_1_LDevice_1_iTCTR_1','Tr').
has_prefix('a1:Tr_1_LDevice_1_iXCBR_1','Tr').
has_prefix('a1:Tr_FeederTrip_FCDA_1','Tr').
has_prefix('a1:Tr_TripF1_FCDA_1','F1').
has_prefix('a1:Tr_TripF2_FCDA_1','F2').
has_prefix('a1:Tr_TripF3_FCDA_1','F3').
has_prefix('a1:Tr_TripF4_FCDA_1','F4').
has_prefix('a1:Tr_TripF5_FCDA_1','F5').
has_type('a1:ACT_1_Tr_1_DA1','BOOLEAN').
has_type('a1:F1_Address_1_P_1','IP').
has_type('a1:F2_Address_1_P_1','IP').
has_type('a1:F3_Address_1_P_1','IP').
has_type('a1:F4_Address_1_P_1','IP').
has_type('a1:F5_Address_1_P_1','IP').
has_type('a1:LLN01_1_DO1','ENC_1_Mod').
has_type('a1:LPHD1_1_DO1','ENS_1_Beh').
has_type('a1:SAV_1_AmpSV_1_DA1','AnalogueValue_1').
has_type('a1:SubNetwork_1','8-MMS').
has_type('a1:Tr_Address_1_P_1','IP').
has_type('a1:iPIOC_1_DO1','ACT_1_Tr').
has_type('a1:iPTRC_1_DO1','ACT_1_Tr').
has_type('a1:iTCTR_1_DO1','SAV_1_AmpSv').
has_type('a1:iXCBR_1_DO1','DPC_1_Pos').





