/* ------------------------------------------------------ */
/* PROLOG-program for transformation for transforming IEC 61850 ontology to IEC 61499 ontology */
/* Example 2 */ 
/* Features:  Single iterative sequential execution model for Rule1*/
/* Features:  Single pass sequential execution model for Rule2 */
/* ------------------------------------------------------ */



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


/* 'LNConnections'('a1:LNC_iPTRC_T_1').  */


/* 'LNC_from'('a1:LNC_iPTRC_T_1', From).  */


run_rule4:- 						
'LN'(Ln1), 							/* LN(?ln1) */
'LN'(Ln2), 							/* LN(?ln2) */
Ln1\==Ln2, 							/* swrlb:differentFrom(?ln1, ?ln2) */
has_LNConnections(Ln1, Lnc), 				/* has_LNConnections(?ln1, ?lnc) */
has_LNConnections(Ln2, Lnc), 				/* has_LNConnections(?ln2, ?lnc) */
/* 'LNConnections'(Lnc), */						/* LNConnections(?lnc) */
writeln(Ln1+"--->"+Ln2+"CONN:"+Lnc),
fail.



run_rule5:-
ant5(Ln1,Ln2,Lnc),
cons5(Ln1,Ln2,Lnc),
fail.

ant5(Ln1,Ln2,Lnc):-
'LN'(Ln1), 							
'LN'(Ln2), 							
Ln1\==Ln2, 							
has_LNConnections(Ln1, Lnc), 				
has_LNConnections(Ln2, Lnc).

con5(Ln1,Ln2,Lnc):-
writeln(Ln1+"--->"+Ln2+"CONN:"+Lnc),!.


/* ant5(X,Y,'a1:LNC_iPTRC_T_1'). */
/* ant5('a1:Tr_1_LDevice_1_iPTRC_1',Y,'a1:LNC_iPTRC_T_1'). */
/* has_LNConnections(X,'a1:LNC_iPTRC_T_1'). */

'LN'('a1:Tr_1_LDevice_1_iPTRC_1').
'LN'('a1:Tr_1_LDevice_1_iXCBR_1').


'LN'('a1:F1_1_LDevice_1_iPIOC_1').  /* не то */
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
'LN'('a1:Tr_1_LDevice_1_iTCTR_1').



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




