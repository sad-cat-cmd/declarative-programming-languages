rule1:-
'LN'(Ln), 					/* LN(?ln) */
has_InClass(Ln, Cl), 				/* has_InClass(?ln, ?cl) */
has_prefix(Ln, Pr), 				/* has_prefix(?ln, ?pr) */
has_inst(Ln, Inst), 				/* has_inst(?ln, ?inst) */
has_inType(Ln, T), 				/* has_inType(?ln, ?t) */
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
createLink(has_type, Id_fb, FBType_name), 		/* has_type(?fb, “i”+?cl) */
string_concat('fb_', Cl, N1),
string_concat(N1, Pr, N2),
string_concat(N2, Inst, FB_name),
createLink(has_name, Id_fb, FB_name), 	/* has_name(?fb, fb+”_”+?cl+”_”+?pr+”_”+?inst) */
createLink(has_name, Id_eo, 'INITO'), 		/* has_name(?eo, “INITO”) */
createLink(has_name, Id_ei, 'INIT'), 		/* has_name(?ei, “INIT”) */
string_concat(T, '_', N1),
string_concat(N1, Pr, N2),
string_concat(N2, Inst, LNid),
createLink(has_name, Ln, LNid). 		/* has_LN_id(?ln, ?t + ”_” + ?pr + ?inst) */

