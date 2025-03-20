rule2:-
'LN'(Ln1), 							/* LN(?ln1) */
'LN'(Ln2), 							/* LN(?ln2) */
'FunctionBlock'(Fb1), 						/* FunctionBlock(?fb1) */
'FunctionBlock'(Fb2), 						/* FunctionBlock(?fb2) */
'LNConnections'(Lnc), 						/* LNConnections(?lnc) */
associate(Ln1,Fb1), 						/* associate(?ln1,?fb1) */
associate(Ln2,Fb2), 						/* associate(?ln1,?fb1) */
has_LN_id(Ln1, From), 					/* has_LN_id(?ln1, ?from) */
has_LN_id(Ln2, To), 						/* has_LN_id(?ln2, ?to) */
has_LNConnections(Ln1, Lnc), 				/* has_LNConnections(?ln1, ?lnc) */
has_LNConnections(Ln2, Lnc), 				/* has_LNConnections(?ln2, ?lnc) */
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
createInstance('OutputVariable', Id_iv), 	/*  eswrl:createInstance(InputVariable, ?iv) */
createLink(is_part_of_FB, Id_ov, Fb1),	 /* is_part_of_FB(?ov, ?fb1) */
createLink(is_part_of_FB, Id_eo, Fb1),	 /* is_part_of_FB(?eo, ?fb1) */
createLink(is_part_of_FB, Id_ei, Fb2),	 /* is_part_of_FB(?ei, ?fb2) */
createLink(is_part_of_FB, Id_iv, Fb2),	 /* is_part_of_FB(?iv, ?fb2) */
createLink(e_connect_to, Id_eo, Id_ei), 	/* e_connect_to(?eo, ?ei) */
createLink(d_connect_to, Id_ov, Id_iv), 	/* d_connect_to(?ov, ?iv) */
createLink(has_name, Id_ov, From), 		/* has_name(?ov, ?from) */
createLink(has_name, Id_iv, To), 		/* has_name(?iv, ?to) */
string_concat(From, '_Event', EO_name),
createLink(has_name, Id_eo, EO_name), 	/* has_name(?eo, ?from+”_Event”) */
string_concat(To, '_Event', EI_name),
createLink(has_name, Id_ei, EI_name). 	/* has_name(?ei, ?to++”_Event”) */
