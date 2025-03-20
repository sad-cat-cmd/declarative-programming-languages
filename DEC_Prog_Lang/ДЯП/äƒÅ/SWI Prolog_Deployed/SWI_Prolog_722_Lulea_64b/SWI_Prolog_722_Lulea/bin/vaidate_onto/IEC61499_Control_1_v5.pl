/* Validation of DTD-oriented IEC 61499 ontology */

/* Querying the FB diagram */
/* ======================= */

/* Query1: “All FBs in (every) FB network have distinct (instances) names” */
/* ---------------- */

all_FBs_in_FBNetworks_have_distint_names:-
forall('FBNetwork'(Net), fbs_in_FBNetwork_have_distint_names(Net)).

fbs_in_FBNetwork_have_distint_names(Net):-
findall(FbName, has_FB_Name2(Net, IdFbInst, FbName), L),
unique(L).

has_FB_Name2(Net, IdFbInst, FbName):-
has_FB(Net, IdFbInst),
has_FB_Name(IdFbInst, FbName).


/* Query2: “Find FB networks in which not all FBs have distinct (instances) names” */
/* ---------------- */

fbNetworks_in_which_FBs_have_no_distint_names(WrongNets):-
findall(Net, fbNetwork_in_which_FBs_have_no_distint_names(Net), WrongNets).

fbNetwork_in_which_FBs_have_no_distint_names(Net):-
'FBNetwork'(Net),
findall(FbName, has_FB_Name2(Net, IdFbInst, FbName), L),
not_unique(L).


/* Query3: “There is only one FB system in the configuration description and this FB system has only one name” */
/* ---------------- */

only_one_FB_system:-
findall(S, 'System'(S), L),
length(L,N),
N==1.

fb_system_has_one_name:-
only_one_FB_system, 
'System'(S),
findall(Name, has_System_Name(S,Name), Names),
length(Names, N),
N==1.


/* Query4: “All applications in the System has a distinct name” */
/* ---------------- */

all_Apps_in_System_have_distint_names:-
findall(AppName, has_Application_Name2(Sys, AppId, AppName), L),
unique(L).

has_Application_Name2(Sys, AppId, AppName):-
has_Application(Sys, AppId),
has_Application_Name(AppId, AppName).


/* Query5: “Every application has only one SubAppNetwork” */
/* ---------------- */

every_App_has_only_one_SubAppNetwork:-
forall('Application'(App), app_has_one_SubAppNetwork(App)).

app_has_one_SubAppNetwork(App):-
findall(SubAppNetworkId, has_SubAppNetwork(App, SubAppNetworkId), L),
length(L, N),
N==1.




/* ------------------------------ */
/* Predicates for list processing */
/* ------------------------------ */
/* Checks that no element of list L is repeated twice */

unique([]):-!.
unique([Head|Tail]):-
  member(Head, Tail), !, fail;
  unique(Tail).


/* Checks that element of list L is repeated at least twice */

not_unique([]):-!,false.
not_unique([Head|Tail]):-
member(Head, Tail), !.
not_unique([Head|Tail]):- not_unique(Tail).




/* ------------------------------------------------------- */
/* DTD-oriented Prolog-based ontology of IEC 61499 (A-box) */
/* ------------------------------------------------------- */
'DataType'('Beh').
'DataType'('CBOpCap').
'DataType'('Health').
'DataType'('Mod').
'DataType'('PhyHealth').
'DataType'(ctlModel).
'DataType'(dirGeneral).
'DataType'('AnalogueValue_1').
'DataType'(myAmpSv).
'DataType'(myBeh).
'DataType'(myBlkOpn).
'DataType'(myCBOpCap).
'DataType'(myHealth).
'DataType'(myMod).
'DataType'(myNamPlt).
'DataType'(myNamPlt2).
'DataType'(myOpCnt).
'DataType'(myPhyHealth).
'DataType'(myPhyNam).
'DataType'(myPos).
'DataType'(myProxy).
'DataType'(myStr).
'DataType'(myTr).
has_DataType_Name('Beh', 'Beh').
has_DataType_Name('CBOpCap', 'CBOpCap').
has_DataType_Name('Health', 'Health').
has_DataType_Name('Mod', 'Mod').
has_DataType_Name('PhyHealth', 'PhyHealth').
has_DataType_Name(ctlModel, ctlModel).
has_DataType_Name(dirGeneral, dirGeneral).
has_DataType_Name('AnalogueValue_1', 'AnalogueValue_1').
has_DataType_Name(myAmpSv, myAmpSv).
has_DataType_Name(myBeh, myBeh).
has_DataType_Name(myBlkOpn, myBlkOpn).
has_DataType_Name(myCBOpCap, myCBOpCap).
has_DataType_Name(myHealth, myHealth).
has_DataType_Name(myMod, myMod).
has_DataType_Name(myNamPlt, myNamPlt).
has_DataType_Name(myNamPlt2, myNamPlt2).
has_DataType_Name(myOpCnt, myOpCnt).
has_DataType_Name(myPhyHealth, myPhyHealth).
has_DataType_Name(myPhyNam, myPhyNam).
has_DataType_Name(myPos, myPos).
has_DataType_Name(myProxy, myProxy).
has_DataType_Name(myStr, myStr).
has_DataType_Name(myTr, myTr).
has_EnumeratedType('Beh', 'Beh_EnumType').
has_EnumeratedType('CBOpCap', 'CBOpCap_EnumType').
has_EnumeratedType('Health', 'Health_EnumType').
has_EnumeratedType('Mod', 'Mod_EnumType').
has_EnumeratedType('PhyHealth', 'PhyHealth_EnumType').
has_EnumeratedType(ctlModel, ctlModel_EnumType).
has_EnumeratedType(dirGeneral, dirGeneral_EnumType).
'EnumeratedType'('Beh_EnumType').
'EnumeratedType'('CBOpCap_EnumType').
'EnumeratedType'('Health_EnumType').
'EnumeratedType'('Mod_EnumType').
'EnumeratedType'('PhyHealth_EnumType').
'EnumeratedType'(ctlModel_EnumType).
'EnumeratedType'(dirGeneral_EnumType).
'EnumeratedValue'('1_on').
'EnumeratedValue'('2_blocked').
'EnumeratedValue'('3_test').
'EnumeratedValue'('4_test-blocked').
'EnumeratedValue'('5_off').
'EnumeratedValue'('1_None').
'EnumeratedValue'('4_Open-Close-Open').
'EnumeratedValue'('5_Close-Open-Close-Open').
'EnumeratedValue'('6_Open-Close-Open-Close-Open').
'EnumeratedValue'('7_more').
'EnumeratedValue'('1_Ok').
'EnumeratedValue'('2_Warning').
'EnumeratedValue'('3_Alarm').
'EnumeratedValue'('4_test/blocked').
'EnumeratedValue'('0_status-only').
'EnumeratedValue'('1_direct-with-normal-security').
'EnumeratedValue'('2_sbo-with-normal-security').
'EnumeratedValue'('3_direct-with-enhanced-security').
'EnumeratedValue'('4_sbo-with-enhanced-security').
'EnumeratedValue'('0_unknown').
'EnumeratedValue'('1_forward').
'EnumeratedValue'('2_backward').
'EnumeratedValue'('3_both').
has_EnumeratedValue('Beh_EnumType', '1_on').
has_EnumeratedValue('Beh_EnumType', '2_blocked').
has_EnumeratedValue('Beh_EnumType', '3_test').
has_EnumeratedValue('Beh_EnumType', '4_test-blocked').
has_EnumeratedValue('Beh_EnumType', '5_off').
has_EnumeratedValue('CBOpCap_EnumType', '1_None').
has_EnumeratedValue('CBOpCap_EnumType', '4_Open-Close-Open').
has_EnumeratedValue('CBOpCap_EnumType', '5_Close-Open-Close-Open').
has_EnumeratedValue('CBOpCap_EnumType', '6_Open-Close-Open-Close-Open').
has_EnumeratedValue('CBOpCap_EnumType', '7_more').
has_EnumeratedValue('Health_EnumType', '1_Ok').
has_EnumeratedValue('Health_EnumType', '2_Warning').
has_EnumeratedValue('Health_EnumType', '3_Alarm').
has_EnumeratedValue('Mod_EnumType', '1_on').
has_EnumeratedValue('Mod_EnumType', '3_test').
has_EnumeratedValue('Mod_EnumType', '4_test/blocked').
has_EnumeratedValue('Mod_EnumType', '5_off').
has_EnumeratedValue('PhyHealth_EnumType', '1_Ok').
has_EnumeratedValue('PhyHealth_EnumType', '2_Warning').
has_EnumeratedValue('PhyHealth_EnumType', '3_Alarm').
has_EnumeratedValue(ctlModel_EnumType, '0_status-only').
has_EnumeratedValue(ctlModel_EnumType, '1_direct-with-normal-security').
has_EnumeratedValue(ctlModel_EnumType, '2_sbo-with-normal-security').
has_EnumeratedValue(ctlModel_EnumType, '3_direct-with-enhanced-security').
has_EnumeratedValue(ctlModel_EnumType, '4_sbo-with-enhanced-security').
has_EnumeratedValue(dirGeneral_EnumType, '0_unknown').
has_EnumeratedValue(dirGeneral_EnumType, '1_forward').
has_EnumeratedValue(dirGeneral_EnumType, '2_backward').
has_EnumeratedValue(dirGeneral_EnumType, '3_both').
has_EnumeratedValue_Name('1_on', '1').
has_EnumeratedValue_Name('2_blocked', '2').
has_EnumeratedValue_Name('3_test', '3').
has_EnumeratedValue_Name('4_test-blocked', '4').
has_EnumeratedValue_Name('5_off', '5').
has_EnumeratedValue_Name('1_None', '1').
has_EnumeratedValue_Name('4_Open-Close-Open', '4').
has_EnumeratedValue_Name('5_Close-Open-Close-Open', '5').
has_EnumeratedValue_Name('6_Open-Close-Open-Close-Open', '6').
has_EnumeratedValue_Name('7_more', '7').
has_EnumeratedValue_Name('1_Ok', '1').
has_EnumeratedValue_Name('2_Warning', '2').
has_EnumeratedValue_Name('3_Alarm', '3').
has_EnumeratedValue_Name('4_test/blocked', '4').
has_EnumeratedValue_Name('0_status-only', '0').
has_EnumeratedValue_Name('1_direct-with-normal-security', '1').
has_EnumeratedValue_Name('2_sbo-with-normal-security', '2').
has_EnumeratedValue_Name('3_direct-with-enhanced-security', '3').
has_EnumeratedValue_Name('4_sbo-with-enhanced-security', '4').
has_EnumeratedValue_Name('0_unknown', '0').
has_EnumeratedValue_Name('1_forward', '1').
has_EnumeratedValue_Name('2_backward', '2').
has_EnumeratedValue_Name('3_both', '3').
has_EnumeratedValue_Comment('1_on', on).
has_EnumeratedValue_Comment('2_blocked', blocked).
has_EnumeratedValue_Comment('3_test', test).
has_EnumeratedValue_Comment('4_test-blocked', 'test-blocked').
has_EnumeratedValue_Comment('5_off', off).
has_EnumeratedValue_Comment('1_None', 'None').
has_EnumeratedValue_Comment('4_Open-Close-Open', 'Open-Close-Open').
has_EnumeratedValue_Comment('5_Close-Open-Close-Open', 'Close-Open-Close-Open').
has_EnumeratedValue_Comment('6_Open-Close-Open-Close-Open', 'Open-Close-Open-Close-Open').
has_EnumeratedValue_Comment('7_more', more).
has_EnumeratedValue_Comment('1_Ok', 'Ok').
has_EnumeratedValue_Comment('2_Warning', 'Warning').
has_EnumeratedValue_Comment('3_Alarm', 'Alarm').
has_EnumeratedValue_Comment('4_test/blocked', 'test/blocked').
has_EnumeratedValue_Comment('0_status-only', 'status-only').
has_EnumeratedValue_Comment('1_direct-with-normal-security', 'direct-with-normal-security').
has_EnumeratedValue_Comment('2_sbo-with-normal-security', 'sbo-with-normal-security').
has_EnumeratedValue_Comment('3_direct-with-enhanced-security', 'direct-with-enhanced-security').
has_EnumeratedValue_Comment('4_sbo-with-enhanced-security', 'sbo-with-enhanced-security').
has_EnumeratedValue_Comment('0_unknown', unknown).
has_EnumeratedValue_Comment('1_forward', forward).
has_EnumeratedValue_Comment('2_backward', backward).
has_EnumeratedValue_Comment('3_both', both).
'StructureType'('AnalogueValue_1_StructureType').
'StructureType'(myAmpSv_StructureType).
'StructureType'(myBeh_StructureType).
'StructureType'(myBlkOpn_StructureType).
'StructureType'(myCBOpCap_StructureType).
'StructureType'(myHealth_StructureType).
'StructureType'(myMod_StructureType).
'StructureType'(myNamPlt_StructureType).
'StructureType'(myNamPlt2_StructureType).
'StructureType'(myOpCnt_StructureType).
'StructureType'(myPhyHealth_StructureType).
'StructureType'(myPhyNam_StructureType).
'StructureType'(myPos_StructureType).
'StructureType'(myProxy_StructureType).
'StructureType'(myStr_StructureType).
'StructureType'(myTr_StructureType).
has_StructureType('AnalogueValue_1', 'AnalogueValue_1_StructureType').
has_StructureType(myAmpSv, myAmpSv_StructureType).
has_StructureType(myBeh, myBeh_StructureType).
has_StructureType(myBlkOpn, myBlkOpn_StructureType).
has_StructureType(myCBOpCap, myCBOpCap_StructureType).
has_StructureType(myHealth, myHealth_StructureType).
has_StructureType(myMod, myMod_StructureType).
has_StructureType(myNamPlt, myNamPlt_StructureType).
has_StructureType(myNamPlt2, myNamPlt2_StructureType).
has_StructureType(myOpCnt, myOpCnt_StructureType).
has_StructureType(myPhyHealth, myPhyHealth_StructureType).
has_StructureType(myPhyNam, myPhyNam_StructureType).
has_StructureType(myPos, myPos_StructureType).
has_StructureType(myProxy, myProxy_StructureType).
has_StructureType(myStr, myStr_StructureType).
has_StructureType(myTr, myTr_StructureType).
'VarDeclaration'('AnalogueValue_1_f').
'VarDeclaration'(myAmpSv_q).
'VarDeclaration'(myBeh_q).
'VarDeclaration'(myBeh_t).
'VarDeclaration'(myBlkOpn_q).
'VarDeclaration'(myBlkOpn_stVal).
'VarDeclaration'(myBlkOpn_t).
'VarDeclaration'(myCBOpCap_q).
'VarDeclaration'(myCBOpCap_t).
'VarDeclaration'(myHealth_q).
'VarDeclaration'(myHealth_t).
'VarDeclaration'(myMod_q).
'VarDeclaration'(myMod_t).
'VarDeclaration'(myNamPlt_configRev).
'VarDeclaration'(myNamPlt_d).
'VarDeclaration'(myNamPlt_ldNs).
'VarDeclaration'(myNamPlt_swRev).
'VarDeclaration'(myNamPlt_vendor).
'VarDeclaration'(myNamPlt2_d).
'VarDeclaration'(myNamPlt2_swRev).
'VarDeclaration'(myNamPlt2_vendor).
'VarDeclaration'(myOpCnt_q).
'VarDeclaration'(myOpCnt_stVal).
'VarDeclaration'(myOpCnt_t).
'VarDeclaration'(myPhyHealth_q).
'VarDeclaration'(myPhyHealth_t).
'VarDeclaration'(myPhyNam_vendor).
'VarDeclaration'(myPos_q).
'VarDeclaration'(myPos_stVal).
'VarDeclaration'(myPos_t).
'VarDeclaration'(myProxy_q).
'VarDeclaration'(myProxy_stVal).
'VarDeclaration'(myProxy_t).
'VarDeclaration'(myStr_general).
'VarDeclaration'(myStr_q).
'VarDeclaration'(myStr_t).
'VarDeclaration'(myTr_general).
'VarDeclaration'(myTr_q).
'VarDeclaration'(myTr_t).
'VarDeclaration'(myAmpSv_instMag).
'VarDeclaration'(myBeh_stVal).
'VarDeclaration'(myBlkOpn_ctlModel).
'VarDeclaration'(myCBOpCap_stVal).
'VarDeclaration'(myHealth_stVal).
'VarDeclaration'(myMod_ctlModel).
'VarDeclaration'(myMod_stVal).
'VarDeclaration'(myPhyHealth_stVal).
'VarDeclaration'(myPos_ctlModel).
'VarDeclaration'(myStr_dirGeneral).
'VarDeclaration'('LN0_Beh').
'VarDeclaration'('LN0_Health').
'VarDeclaration'('LPHDa_Beh').
'VarDeclaration'('LPHDa_PhyHealth').
'VarDeclaration'('LPHDa_Proxy').
'VarDeclaration'('PIOCa_Beh').
'VarDeclaration'('PIOCa_Health').
'VarDeclaration'('PIOCa_Op').
'VarDeclaration'('PIOCa_Str').
'VarDeclaration'('PTRCa_Beh').
'VarDeclaration'('PTRCa_Health').
'VarDeclaration'('PTRCa_Op').
'VarDeclaration'('PTRCa_Tr').
'VarDeclaration'('TCTRa_AmpSv').
'VarDeclaration'('TCTRa_Beh').
'VarDeclaration'('TCTRa_Health').
'VarDeclaration'('XCBRa_Beh').
'VarDeclaration'('XCBRa_CBOpCap').
'VarDeclaration'('XCBRa_Health').
'VarDeclaration'('XCBRa_Loc').
'VarDeclaration'('XCBRa_OpCnt').
'VarDeclaration'('LN0_Mod').
'VarDeclaration'('LN0_NamPlt').
'VarDeclaration'('LPHDa_PhyNam').
'VarDeclaration'('PIOCa_Mod').
'VarDeclaration'('PIOCa_NamPlt').
'VarDeclaration'('PTRCa_Mod').
'VarDeclaration'('PTRCa_NamPlt').
'VarDeclaration'('TCTRa_Mod').
'VarDeclaration'('TCTRa_NamPlt').
'VarDeclaration'('XCBRa_BlkCls').
'VarDeclaration'('XCBRa_BlkOpn').
'VarDeclaration'('XCBRa_Mod').
'VarDeclaration'('XCBRa_NamPlt').
'VarDeclaration'('XCBRa_Pos').
'VarDeclaration'('PIOCa_Op_general').
'VarDeclaration'('PIOCa_Tr_general').
'VarDeclaration'('TCTRa_AmpSv_instMag_f').
'VarDeclaration'('XCBRa_Tr_general').
'VarDeclaration'('PIOCa_AmpSv_instMag_f').
'VarDeclaration'('PTRCa_Op_general').
has_VarDeclaration('AnalogueValue_1_StructureType', 'AnalogueValue_1_f').
has_VarDeclaration(myAmpSv_StructureType, myAmpSv_q).
has_VarDeclaration(myBeh_StructureType, myBeh_q).
has_VarDeclaration(myBeh_StructureType, myBeh_t).
has_VarDeclaration(myBlkOpn_StructureType, myBlkOpn_q).
has_VarDeclaration(myBlkOpn_StructureType, myBlkOpn_stVal).
has_VarDeclaration(myBlkOpn_StructureType, myBlkOpn_t).
has_VarDeclaration(myCBOpCap_StructureType, myCBOpCap_q).
has_VarDeclaration(myCBOpCap_StructureType, myCBOpCap_t).
has_VarDeclaration(myHealth_StructureType, myHealth_q).
has_VarDeclaration(myHealth_StructureType, myHealth_t).
has_VarDeclaration(myMod_StructureType, myMod_q).
has_VarDeclaration(myMod_StructureType, myMod_t).
has_VarDeclaration(myNamPlt_StructureType, myNamPlt_configRev).
has_VarDeclaration(myNamPlt_StructureType, myNamPlt_d).
has_VarDeclaration(myNamPlt_StructureType, myNamPlt_ldNs).
has_VarDeclaration(myNamPlt_StructureType, myNamPlt_swRev).
has_VarDeclaration(myNamPlt_StructureType, myNamPlt_vendor).
has_VarDeclaration(myNamPlt2_StructureType, myNamPlt2_d).
has_VarDeclaration(myNamPlt2_StructureType, myNamPlt2_swRev).
has_VarDeclaration(myNamPlt2_StructureType, myNamPlt2_vendor).
has_VarDeclaration(myOpCnt_StructureType, myOpCnt_q).
has_VarDeclaration(myOpCnt_StructureType, myOpCnt_stVal).
has_VarDeclaration(myOpCnt_StructureType, myOpCnt_t).
has_VarDeclaration(myPhyHealth_StructureType, myPhyHealth_q).
has_VarDeclaration(myPhyHealth_StructureType, myPhyHealth_t).
has_VarDeclaration(myPhyNam_StructureType, myPhyNam_vendor).
has_VarDeclaration(myPos_StructureType, myPos_q).
has_VarDeclaration(myPos_StructureType, myPos_stVal).
has_VarDeclaration(myPos_StructureType, myPos_t).
has_VarDeclaration(myProxy_StructureType, myProxy_q).
has_VarDeclaration(myProxy_StructureType, myProxy_stVal).
has_VarDeclaration(myProxy_StructureType, myProxy_t).
has_VarDeclaration(myStr_StructureType, myStr_general).
has_VarDeclaration(myStr_StructureType, myStr_q).
has_VarDeclaration(myStr_StructureType, myStr_t).
has_VarDeclaration(myTr_StructureType, myTr_general).
has_VarDeclaration(myTr_StructureType, myTr_q).
has_VarDeclaration(myTr_StructureType, myTr_t).
has_VarDeclaration(myAmpSv_StructureType, myAmpSv_instMag).
has_VarDeclaration(myBeh_StructureType, myBeh_stVal).
has_VarDeclaration(myBlkOpn_StructureType, myBlkOpn_ctlModel).
has_VarDeclaration(myCBOpCap_StructureType, myCBOpCap_stVal).
has_VarDeclaration(myHealth_StructureType, myHealth_stVal).
has_VarDeclaration(myMod_StructureType, myMod_ctlModel).
has_VarDeclaration(myMod_StructureType, myMod_stVal).
has_VarDeclaration(myPhyHealth_StructureType, myPhyHealth_stVal).
has_VarDeclaration(myPos_StructureType, myPos_ctlModel).
has_VarDeclaration(myStr_StructureType, myStr_dirGeneral).
has_VarDeclaration('LN0_OutputVars', 'LN0_Beh').
has_VarDeclaration('LN0_OutputVars', 'LN0_Health').
has_VarDeclaration('LPHDa_OutputVars', 'LPHDa_Beh').
has_VarDeclaration('LPHDa_OutputVars', 'LPHDa_PhyHealth').
has_VarDeclaration('LPHDa_OutputVars', 'LPHDa_Proxy').
has_VarDeclaration('PIOCa_OutputVars', 'PIOCa_Beh').
has_VarDeclaration('PIOCa_OutputVars', 'PIOCa_Health').
has_VarDeclaration('PIOCa_OutputVars', 'PIOCa_Op').
has_VarDeclaration('PIOCa_OutputVars', 'PIOCa_Str').
has_VarDeclaration('PTRCa_OutputVars', 'PTRCa_Beh').
has_VarDeclaration('PTRCa_OutputVars', 'PTRCa_Health').
has_VarDeclaration('PTRCa_OutputVars', 'PTRCa_Op').
has_VarDeclaration('PTRCa_OutputVars', 'PTRCa_Tr').
has_VarDeclaration('TCTRa_OutputVars', 'TCTRa_AmpSv').
has_VarDeclaration('TCTRa_OutputVars', 'TCTRa_Beh').
has_VarDeclaration('TCTRa_OutputVars', 'TCTRa_Health').
has_VarDeclaration('XCBRa_OutputVars', 'XCBRa_Beh').
has_VarDeclaration('XCBRa_OutputVars', 'XCBRa_CBOpCap').
has_VarDeclaration('XCBRa_OutputVars', 'XCBRa_Health').
has_VarDeclaration('XCBRa_OutputVars', 'XCBRa_Loc').
has_VarDeclaration('XCBRa_OutputVars', 'XCBRa_OpCnt').
has_VarDeclaration('LN0_InputVars', 'LN0_Mod').
has_VarDeclaration('LN0_InputVars', 'LN0_NamPlt').
has_VarDeclaration('LPHDa_InputVars', 'LPHDa_PhyNam').
has_VarDeclaration('PIOCa_InputVars', 'PIOCa_Mod').
has_VarDeclaration('PIOCa_InputVars', 'PIOCa_NamPlt').
has_VarDeclaration('PTRCa_InputVars', 'PTRCa_Mod').
has_VarDeclaration('PTRCa_InputVars', 'PTRCa_NamPlt').
has_VarDeclaration('TCTRa_InputVars', 'TCTRa_Mod').
has_VarDeclaration('TCTRa_InputVars', 'TCTRa_NamPlt').
has_VarDeclaration('XCBRa_InputVars', 'XCBRa_BlkCls').
has_VarDeclaration('XCBRa_InputVars', 'XCBRa_BlkOpn').
has_VarDeclaration('XCBRa_InputVars', 'XCBRa_Mod').
has_VarDeclaration('XCBRa_InputVars', 'XCBRa_NamPlt').
has_VarDeclaration('XCBRa_InputVars', 'XCBRa_Pos').
has_VarDeclaration('PIOCa_OutputVars', 'PIOCa_Op_general').
has_VarDeclaration('PIOCa_OutputVars', 'PIOCa_Tr_general').
has_VarDeclaration('TCTRa_OutputVars', 'TCTRa_AmpSv_instMag_f').
has_VarDeclaration('XCBRa_InputVars', 'XCBRa_Tr_general').
has_VarDeclaration('PIOCa_InputVars', 'PIOCa_AmpSv_instMag_f').
has_VarDeclaration('PTRCa_InputVars', 'PTRCa_Op_general').
has_VarDeclaration_Name('AnalogueValue_1_f', f).
has_VarDeclaration_Name(myAmpSv_q, q).
has_VarDeclaration_Name(myBeh_q, q).
has_VarDeclaration_Name(myBeh_t, t).
has_VarDeclaration_Name(myBlkOpn_q, q).
has_VarDeclaration_Name(myBlkOpn_stVal, stVal).
has_VarDeclaration_Name(myBlkOpn_t, t).
has_VarDeclaration_Name(myCBOpCap_q, q).
has_VarDeclaration_Name(myCBOpCap_t, t).
has_VarDeclaration_Name(myHealth_q, q).
has_VarDeclaration_Name(myHealth_t, t).
has_VarDeclaration_Name(myMod_q, q).
has_VarDeclaration_Name(myMod_t, t).
has_VarDeclaration_Name(myNamPlt_configRev, configRev).
has_VarDeclaration_Name(myNamPlt_d, d).
has_VarDeclaration_Name(myNamPlt_ldNs, ldNs).
has_VarDeclaration_Name(myNamPlt_swRev, swRev).
has_VarDeclaration_Name(myNamPlt_vendor, vendor).
has_VarDeclaration_Name(myNamPlt2_d, d).
has_VarDeclaration_Name(myNamPlt2_swRev, swRev).
has_VarDeclaration_Name(myNamPlt2_vendor, vendor).
has_VarDeclaration_Name(myOpCnt_q, q).
has_VarDeclaration_Name(myOpCnt_stVal, stVal).
has_VarDeclaration_Name(myOpCnt_t, t).
has_VarDeclaration_Name(myPhyHealth_q, q).
has_VarDeclaration_Name(myPhyHealth_t, t).
has_VarDeclaration_Name(myPhyNam_vendor, vendor).
has_VarDeclaration_Name(myPos_q, q).
has_VarDeclaration_Name(myPos_stVal, stVal).
has_VarDeclaration_Name(myPos_t, t).
has_VarDeclaration_Name(myProxy_q, q).
has_VarDeclaration_Name(myProxy_stVal, stVal).
has_VarDeclaration_Name(myProxy_t, t).
has_VarDeclaration_Name(myStr_general, general).
has_VarDeclaration_Name(myStr_q, q).
has_VarDeclaration_Name(myStr_t, t).
has_VarDeclaration_Name(myTr_general, general).
has_VarDeclaration_Name(myTr_q, q).
has_VarDeclaration_Name(myTr_t, t).
has_VarDeclaration_Name(myAmpSv_instMag, instMag).
has_VarDeclaration_Name(myBeh_stVal, stVal).
has_VarDeclaration_Name(myBlkOpn_ctlModel, ctlModel).
has_VarDeclaration_Name(myCBOpCap_stVal, stVal).
has_VarDeclaration_Name(myHealth_stVal, stVal).
has_VarDeclaration_Name(myMod_ctlModel, ctlModel).
has_VarDeclaration_Name(myMod_stVal, stVal).
has_VarDeclaration_Name(myPhyHealth_stVal, stVal).
has_VarDeclaration_Name(myPos_ctlModel, ctlModel).
has_VarDeclaration_Name(myStr_dirGeneral, dirGeneral).
has_VarDeclaration_Name('LN0_Beh', 'Beh').
has_VarDeclaration_Name('LN0_Health', 'Health').
has_VarDeclaration_Name('LPHDa_Beh', 'Beh').
has_VarDeclaration_Name('LPHDa_PhyHealth', 'PhyHealth').
has_VarDeclaration_Name('LPHDa_Proxy', 'Proxy').
has_VarDeclaration_Name('PIOCa_Beh', 'Beh').
has_VarDeclaration_Name('PIOCa_Health', 'Health').
has_VarDeclaration_Name('PIOCa_Op', 'Op').
has_VarDeclaration_Name('PIOCa_Str', 'Str').
has_VarDeclaration_Name('PTRCa_Beh', 'Beh').
has_VarDeclaration_Name('PTRCa_Health', 'Health').
has_VarDeclaration_Name('PTRCa_Op', 'Op').
has_VarDeclaration_Name('PTRCa_Tr', 'Tr').
has_VarDeclaration_Name('TCTRa_AmpSv', 'AmpSv').
has_VarDeclaration_Name('TCTRa_Beh', 'Beh').
has_VarDeclaration_Name('TCTRa_Health', 'Health').
has_VarDeclaration_Name('XCBRa_Beh', 'Beh').
has_VarDeclaration_Name('XCBRa_CBOpCap', 'CBOpCap').
has_VarDeclaration_Name('XCBRa_Health', 'Health').
has_VarDeclaration_Name('XCBRa_Loc', 'Loc').
has_VarDeclaration_Name('XCBRa_OpCnt', 'OpCnt').
has_VarDeclaration_Name('LN0_Mod', 'Mod').
has_VarDeclaration_Name('LN0_NamPlt', 'NamPlt').
has_VarDeclaration_Name('LPHDa_PhyNam', 'PhyNam').
has_VarDeclaration_Name('PIOCa_Mod', 'Mod').
has_VarDeclaration_Name('PIOCa_NamPlt', 'NamPlt').
has_VarDeclaration_Name('PTRCa_Mod', 'Mod').
has_VarDeclaration_Name('PTRCa_NamPlt', 'NamPlt').
has_VarDeclaration_Name('TCTRa_Mod', 'Mod').
has_VarDeclaration_Name('TCTRa_NamPlt', 'NamPlt').
has_VarDeclaration_Name('XCBRa_BlkCls', 'BlkCls').
has_VarDeclaration_Name('XCBRa_BlkOpn', 'BlkOpn').
has_VarDeclaration_Name('XCBRa_Mod', 'Mod').
has_VarDeclaration_Name('XCBRa_NamPlt', 'NamPlt').
has_VarDeclaration_Name('XCBRa_Pos', 'Pos').
has_VarDeclaration_Name('PIOCa_Op_general', 'Op_general').
has_VarDeclaration_Name('PIOCa_Tr_general', 'Tr_general').
has_VarDeclaration_Name('TCTRa_AmpSv_instMag_f', 'AmpSv_instMag_f').
has_VarDeclaration_Name('XCBRa_Tr_general', 'Tr_general').
has_VarDeclaration_Name('PIOCa_AmpSv_instMag_f', 'AmpSv_instMag_f').
has_VarDeclaration_Name('PTRCa_Op_general', 'Op_general').
has_VarDeclaration_Type('AnalogueValue_1_f', 'FLOAT32').
has_VarDeclaration_Type(myAmpSv_q, 'Quality').
has_VarDeclaration_Type(myBeh_q, 'Quality').
has_VarDeclaration_Type(myBeh_t, 'Timestamp').
has_VarDeclaration_Type(myBlkOpn_q, 'Quality').
has_VarDeclaration_Type(myBlkOpn_stVal, 'BOOLEAN').
has_VarDeclaration_Type(myBlkOpn_t, 'Timestamp').
has_VarDeclaration_Type(myCBOpCap_q, 'Quality').
has_VarDeclaration_Type(myCBOpCap_t, 'Timestamp').
has_VarDeclaration_Type(myHealth_q, 'Quality').
has_VarDeclaration_Type(myHealth_t, 'Timestamp').
has_VarDeclaration_Type(myMod_q, 'Quality').
has_VarDeclaration_Type(myMod_t, 'Timestamp').
has_VarDeclaration_Type(myNamPlt_configRev, 'VisString255').
has_VarDeclaration_Type(myNamPlt_d, 'VisString255').
has_VarDeclaration_Type(myNamPlt_ldNs, 'VisString255').
has_VarDeclaration_Type(myNamPlt_swRev, 'VisString255').
has_VarDeclaration_Type(myNamPlt_vendor, 'VisString255').
has_VarDeclaration_Type(myNamPlt2_d, 'VisString255').
has_VarDeclaration_Type(myNamPlt2_swRev, 'VisString255').
has_VarDeclaration_Type(myNamPlt2_vendor, 'VisString255').
has_VarDeclaration_Type(myOpCnt_q, 'Quality').
has_VarDeclaration_Type(myOpCnt_stVal, 'INT32').
has_VarDeclaration_Type(myOpCnt_t, 'Timestamp').
has_VarDeclaration_Type(myPhyHealth_q, 'Quality').
has_VarDeclaration_Type(myPhyHealth_t, 'Timestamp').
has_VarDeclaration_Type(myPhyNam_vendor, 'VisString255').
has_VarDeclaration_Type(myPos_q, 'Quality').
has_VarDeclaration_Type(myPos_stVal, 'Dbpos').
has_VarDeclaration_Type(myPos_t, 'Timestamp').
has_VarDeclaration_Type(myProxy_q, 'Quality').
has_VarDeclaration_Type(myProxy_stVal, 'BOOLEAN').
has_VarDeclaration_Type(myProxy_t, 'Timestamp').
has_VarDeclaration_Type(myStr_general, 'BOOLEAN').
has_VarDeclaration_Type(myStr_q, 'Quality').
has_VarDeclaration_Type(myStr_t, 'Timestamp').
has_VarDeclaration_Type(myTr_general, 'BOOLEAN').
has_VarDeclaration_Type(myTr_q, 'Quality').
has_VarDeclaration_Type(myTr_t, 'Timestamp').
has_VarDeclaration_Type(myAmpSv_instMag, 'AnalogueValue_1').
has_VarDeclaration_Type(myBeh_stVal, 'Beh').
has_VarDeclaration_Type(myBlkOpn_ctlModel, ctlModel).
has_VarDeclaration_Type(myCBOpCap_stVal, 'CBOpCap').
has_VarDeclaration_Type(myHealth_stVal, 'Health').
has_VarDeclaration_Type(myMod_ctlModel, ctlModel).
has_VarDeclaration_Type(myMod_stVal, 'Mod').
has_VarDeclaration_Type(myPhyHealth_stVal, 'PhyHealth').
has_VarDeclaration_Type(myPos_ctlModel, ctlModel).
has_VarDeclaration_Type(myStr_dirGeneral, dirGeneral).
has_VarDeclaration_Type('LN0_Beh', myBeh).
has_VarDeclaration_Type('LN0_Health', myHealth).
has_VarDeclaration_Type('LPHDa_Beh', myBeh).
has_VarDeclaration_Type('LPHDa_PhyHealth', myPhyHealth).
has_VarDeclaration_Type('LPHDa_Proxy', mySPS).
has_VarDeclaration_Type('PIOCa_Beh', myBeh).
has_VarDeclaration_Type('PIOCa_Health', myHealth).
has_VarDeclaration_Type('PIOCa_Op', myTr).
has_VarDeclaration_Type('PIOCa_Str', myStr).
has_VarDeclaration_Type('PTRCa_Beh', myBeh).
has_VarDeclaration_Type('PTRCa_Health', myHealth).
has_VarDeclaration_Type('PTRCa_Op', myTr).
has_VarDeclaration_Type('PTRCa_Tr', myTr).
has_VarDeclaration_Type('TCTRa_AmpSv', myAmpSv).
has_VarDeclaration_Type('TCTRa_Beh', myBeh).
has_VarDeclaration_Type('TCTRa_Health', myHealth).
has_VarDeclaration_Type('XCBRa_Beh', myBeh).
has_VarDeclaration_Type('XCBRa_CBOpCap', myCBOpCap).
has_VarDeclaration_Type('XCBRa_Health', myHealth).
has_VarDeclaration_Type('XCBRa_Loc', myProxy).
has_VarDeclaration_Type('XCBRa_OpCnt', myOpCnt).
has_VarDeclaration_Type('LN0_Mod', myMod).
has_VarDeclaration_Type('LN0_NamPlt', myNamPlt).
has_VarDeclaration_Type('LPHDa_PhyNam', myPhyNam).
has_VarDeclaration_Type('PIOCa_Mod', myMod).
has_VarDeclaration_Type('PIOCa_NamPlt', myNamPlt2).
has_VarDeclaration_Type('PTRCa_Mod', myMod).
has_VarDeclaration_Type('PTRCa_NamPlt', myNamPlt2).
has_VarDeclaration_Type('TCTRa_Mod', myMod).
has_VarDeclaration_Type('TCTRa_NamPlt', myNamPlt2).
has_VarDeclaration_Type('XCBRa_BlkCls', myBlkOpn).
has_VarDeclaration_Type('XCBRa_BlkOpn', myBlkOpn).
has_VarDeclaration_Type('XCBRa_Mod', myMod).
has_VarDeclaration_Type('XCBRa_NamPlt', myNamPlt2).
has_VarDeclaration_Type('XCBRa_Pos', myPos).
has_VarDeclaration_Type('PIOCa_Op_general', 'BOOLEAN').
has_VarDeclaration_Type('PIOCa_Tr_general', 'BOOLEAN').
has_VarDeclaration_Type('TCTRa_AmpSv_instMag_f', 'REAL').
has_VarDeclaration_Type('XCBRa_Tr_general', 'BOOLEAN').
has_VarDeclaration_Type('PIOCa_AmpSv_instMag_f', 'REAL').
has_VarDeclaration_Type('PTRCa_Op_general', 'BOOLEAN').
'FBType'('LN0').
'FBType'('LPHDa').
'FBType'('PIOCa').
'FBType'('PTRCa').
'FBType'('TCTRa').
'FBType'('XCBRa').
has_FBType_Name('LN0', 'LN0').
has_FBType_Name('LPHDa', 'LPHDa').
has_FBType_Name('PIOCa', 'PIOCa').
has_FBType_Name('PTRCa', 'PTRCa').
has_FBType_Name('TCTRa', 'TCTRa').
has_FBType_Name('XCBRa', 'XCBRa').
'InterfaceList'('LN0_InterfaceList').
'InterfaceList'('LPHDa_InterfaceList').
'InterfaceList'('PIOCa_InterfaceList').
'InterfaceList'('PTRCa_InterfaceList').
'InterfaceList'('TCTRa_InterfaceList').
'InterfaceList'('XCBRa_InterfaceList').
has_InterfaceList('LN0', 'LN0_InterfaceList').
has_InterfaceList('LPHDa', 'LPHDa_InterfaceList').
has_InterfaceList('PIOCa', 'PIOCa_InterfaceList').
has_InterfaceList('PTRCa', 'PTRCa_InterfaceList').
has_InterfaceList('TCTRa', 'TCTRa_InterfaceList').
has_InterfaceList('XCBRa', 'XCBRa_InterfaceList').
'EventInputs'('LN0_EventInput').
'EventInputs'('LPHDa_EventInput').
'EventInputs'('PIOCa_EventInput').
'EventInputs'('PTRCa_EventInput').
'EventInputs'('TCTRa_EventInput').
'EventInputs'('XCBRa_EventInput').
has_EventInputs('LN0_InterfaceList', 'LN0_EventInput').
has_EventInputs('LPHDa_InterfaceList', 'LPHDa_EventInput').
has_EventInputs('PIOCa_InterfaceList', 'PIOCa_EventInput').
has_EventInputs('PTRCa_InterfaceList', 'PTRCa_EventInput').
has_EventInputs('TCTRa_InterfaceList', 'TCTRa_EventInput').
has_EventInputs('XCBRa_InterfaceList', 'XCBRa_EventInput').
'EventOutputs'('LN0_EventOutput').
'EventOutputs'('LPHDa_EventOutput').
'EventOutputs'('PIOCa_EventOutput').
'EventOutputs'('PTRCa_EventOutput').
'EventOutputs'('TCTRa_EventOutput').
'EventOutputs'('XCBRa_EventOutput').
has_EventOutputs('LN0_InterfaceList', 'LN0_EventOutput').
has_EventOutputs('LPHDa_InterfaceList', 'LPHDa_EventOutput').
has_EventOutputs('PIOCa_InterfaceList', 'PIOCa_EventOutput').
has_EventOutputs('PTRCa_InterfaceList', 'PTRCa_EventOutput').
has_EventOutputs('TCTRa_InterfaceList', 'TCTRa_EventOutput').
has_EventOutputs('XCBRa_InterfaceList', 'XCBRa_EventOutput').
'Event'('LN0_INIT').
'Event'('LN0_INITO').
'Event'('LN0_REQ').
'Event'('LN0_CNF').
'Event'('LPHDa_INIT').
'Event'('LPHDa_INITO').
'Event'('LPHDa_REQ').
'Event'('LPHDa_CNF').
'Event'('PIOCa_INIT').
'Event'('PIOCa_INITO').
'Event'('PIOCa_REQ').
'Event'('PIOCa_CNF').
'Event'('PTRCa_INIT').
'Event'('PTRCa_INITO').
'Event'('PTRCa_REQ').
'Event'('PTRCa_CNF').
'Event'('TCTRa_INIT').
'Event'('TCTRa_INITO').
'Event'('TCTRa_REQ').
'Event'('TCTRa_CNF').
'Event'('XCBRa_INIT').
'Event'('XCBRa_INITO').
'Event'('XCBRa_REQ').
'Event'('XCBRa_CNF').
'Event'('PIOCa_Fd1_PTRCa_1').
'Event'('PIOCa_Fd1_XCBRa_1').
'Event'('TCTRa_Fd1_PIOCa_1').
'Event'('PIOCa_Fd2_PTRCa_1').
'Event'('PIOCa_Fd2_XCBRa_1').
'Event'('TCTRa_Fd2_PIOCa_1').
'Event'('PIOCa_Fd3_PTRCa_1').
'Event'('PIOCa_Fd3_XCBRa_1').
'Event'('TCTRa_Fd3_PIOCa_1').
'Event'('PIOCa_Fd4_PTRCa_1').
'Event'('PIOCa_Fd4_XCBRa_1').
'Event'('TCTRa_Fd4_PIOCa_1').
'Event'('PIOCa_Fd5_PTRCa_1').
'Event'('PIOCa_Fd5_XCBRa_1').
'Event'('TCTRa_Fd5_PIOCa_1').
'Event'('PIOCa_Tr1_PTRCa_1').
'Event'('PIOCa_Tr1_XCBRa_1').
'Event'('TCTRa_Tr1_PIOCa_1').
'Event'('XCBRa_Fd1_PTRCa_1').
'Event'('PIOCa_Fd1_TCTRa_1').
'Event'('PTRCa_Fd2_PIOCa_1').
'Event'('XCBRa_Fd2_PTRCa_1').
'Event'('PIOCa_Fd2_TCTRa_1').
'Event'('PTRCa_Fd3_PIOCa_1').
'Event'('XCBRa_Fd3_PTRCa_1').
'Event'('PIOCa_Fd3_TCTRa_1').
'Event'('PTRCa_Fd4_PIOCa_1').
'Event'('XCBRa_Fd4_PTRCa_1').
'Event'('PIOCa_Fd4_TCTRa_1').
'Event'('PTRCa_Fd5_PIOCa_1').
'Event'('XCBRa_Fd5_PTRCa_1').
'Event'('PIOCa_Fd5_TCTRa_1').
'Event'('PTRCa_Tr1_PIOCa_1').
'Event'('XCBRa_Tr1_PTRCa_1').
'Event'('PIOCa_Tr1_TCTRa_1').
has_Event('LN0_EventInput', 'LN0_INIT').
has_Event('LN0_EventOutput', 'LN0_INITO').
has_Event('LN0_EventInput', 'LN0_REQ').
has_Event('LN0_EventOutput', 'LN0_CNF').
has_Event('LPHDa_EventInput', 'LPHDa_INIT').
has_Event('LPHDa_EventOutput', 'LPHDa_INITO').
has_Event('LPHDa_EventInput', 'LPHDa_REQ').
has_Event('LPHDa_EventOutput', 'LPHDa_CNF').
has_Event('PIOCa_EventInput', 'PIOCa_INIT').
has_Event('PIOCa_EventOutput', 'PIOCa_INITO').
has_Event('PIOCa_EventInput', 'PIOCa_REQ').
has_Event('PIOCa_EventOutput', 'PIOCa_CNF').
has_Event('PTRCa_EventInput', 'PTRCa_INIT').
has_Event('PTRCa_EventOutput', 'PTRCa_INITO').
has_Event('PTRCa_EventInput', 'PTRCa_REQ').
has_Event('PTRCa_EventOutput', 'PTRCa_CNF').
has_Event('TCTRa_EventInput', 'TCTRa_INIT').
has_Event('TCTRa_EventOutput', 'TCTRa_INITO').
has_Event('TCTRa_EventInput', 'TCTRa_REQ').
has_Event('TCTRa_EventOutput', 'TCTRa_CNF').
has_Event('XCBRa_EventInput', 'XCBRa_INIT').
has_Event('XCBRa_EventOutput', 'XCBRa_INITO').
has_Event('XCBRa_EventInput', 'XCBRa_REQ').
has_Event('XCBRa_EventOutput', 'XCBRa_CNF').
has_Event('PIOCa_EventOutput', 'PIOCa_Fd1_PTRCa_1').
has_Event('PIOCa_EventOutput', 'PIOCa_Fd1_XCBRa_1').
has_Event('TCTRa_EventOutput', 'TCTRa_Fd1_PIOCa_1').
has_Event('PIOCa_EventOutput', 'PIOCa_Fd2_PTRCa_1').
has_Event('PIOCa_EventOutput', 'PIOCa_Fd2_XCBRa_1').
has_Event('TCTRa_EventOutput', 'TCTRa_Fd2_PIOCa_1').
has_Event('PIOCa_EventOutput', 'PIOCa_Fd3_PTRCa_1').
has_Event('PIOCa_EventOutput', 'PIOCa_Fd3_XCBRa_1').
has_Event('TCTRa_EventOutput', 'TCTRa_Fd3_PIOCa_1').
has_Event('PIOCa_EventOutput', 'PIOCa_Fd4_PTRCa_1').
has_Event('PIOCa_EventOutput', 'PIOCa_Fd4_XCBRa_1').
has_Event('TCTRa_EventOutput', 'TCTRa_Fd4_PIOCa_1').
has_Event('PIOCa_EventOutput', 'PIOCa_Fd5_PTRCa_1').
has_Event('PIOCa_EventOutput', 'PIOCa_Fd5_XCBRa_1').
has_Event('TCTRa_EventOutput', 'TCTRa_Fd5_PIOCa_1').
has_Event('PIOCa_EventOutput', 'PIOCa_Tr1_PTRCa_1').
has_Event('PIOCa_EventOutput', 'PIOCa_Tr1_XCBRa_1').
has_Event('TCTRa_EventOutput', 'TCTRa_Tr1_PIOCa_1').
has_Event('XCBRa_EventInput', 'XCBRa_Fd1_PTRCa_1').
has_Event('PIOCa_EventInput', 'PIOCa_Fd1_TCTRa_1').
has_Event('PTRCa_EventInput', 'PTRCa_Fd2_PIOCa_1').
has_Event('XCBRa_EventInput', 'XCBRa_Fd2_PTRCa_1').
has_Event('PIOCa_EventInput', 'PIOCa_Fd2_TCTRa_1').
has_Event('PTRCa_EventInput', 'PTRCa_Fd3_PIOCa_1').
has_Event('XCBRa_EventInput', 'XCBRa_Fd3_PTRCa_1').
has_Event('PIOCa_EventInput', 'PIOCa_Fd3_TCTRa_1').
has_Event('PTRCa_EventInput', 'PTRCa_Fd4_PIOCa_1').
has_Event('XCBRa_EventInput', 'XCBRa_Fd4_PTRCa_1').
has_Event('PIOCa_EventInput', 'PIOCa_Fd4_TCTRa_1').
has_Event('PTRCa_EventInput', 'PTRCa_Fd5_PIOCa_1').
has_Event('XCBRa_EventInput', 'XCBRa_Fd5_PTRCa_1').
has_Event('PIOCa_EventInput', 'PIOCa_Fd5_TCTRa_1').
has_Event('PTRCa_EventInput', 'PTRCa_Tr1_PIOCa_1').
has_Event('XCBRa_EventInput', 'XCBRa_Tr1_PTRCa_1').
has_Event('PIOCa_EventInput', 'PIOCa_Tr1_TCTRa_1').
has_Event_Name('LN0_INIT', 'INIT').
has_Event_Name('LN0_INITO', 'INITO').
has_Event_Name('LN0_REQ', 'REQ').
has_Event_Name('LN0_CNF', 'CNF').
has_Event_Name('LPHDa_INIT', 'INIT').
has_Event_Name('LPHDa_INITO', 'INITO').
has_Event_Name('LPHDa_REQ', 'REQ').
has_Event_Name('LPHDa_CNF', 'CNF').
has_Event_Name('PIOCa_INIT', 'INIT').
has_Event_Name('PIOCa_INITO', 'INITO').
has_Event_Name('PIOCa_REQ', 'REQ').
has_Event_Name('PIOCa_CNF', 'CNF').
has_Event_Name('PTRCa_INIT', 'INIT').
has_Event_Name('PTRCa_INITO', 'INITO').
has_Event_Name('PTRCa_REQ', 'REQ').
has_Event_Name('PTRCa_CNF', 'CNF').
has_Event_Name('TCTRa_INIT', 'INIT').
has_Event_Name('TCTRa_INITO', 'INITO').
has_Event_Name('TCTRa_REQ', 'REQ').
has_Event_Name('TCTRa_CNF', 'CNF').
has_Event_Name('XCBRa_INIT', 'INIT').
has_Event_Name('XCBRa_INITO', 'INITO').
has_Event_Name('XCBRa_REQ', 'REQ').
has_Event_Name('XCBRa_CNF', 'CNF').
has_Event_Name('PIOCa_Fd1_PTRCa_1', 'Fd1_PTRCa_1').
has_Event_Name('PIOCa_Fd1_XCBRa_1', 'Fd1_XCBRa_1').
has_Event_Name('TCTRa_Fd1_PIOCa_1', 'Fd1_PIOCa_1').
has_Event_Name('PIOCa_Fd2_PTRCa_1', 'Fd2_PTRCa_1').
has_Event_Name('PIOCa_Fd2_XCBRa_1', 'Fd2_XCBRa_1').
has_Event_Name('TCTRa_Fd2_PIOCa_1', 'Fd2_PIOCa_1').
has_Event_Name('PIOCa_Fd3_PTRCa_1', 'Fd3_PTRCa_1').
has_Event_Name('PIOCa_Fd3_XCBRa_1', 'Fd3_XCBRa_1').
has_Event_Name('TCTRa_Fd3_PIOCa_1', 'Fd3_PIOCa_1').
has_Event_Name('PIOCa_Fd4_PTRCa_1', 'Fd4_PTRCa_1').
has_Event_Name('PIOCa_Fd4_XCBRa_1', 'Fd4_XCBRa_1').
has_Event_Name('TCTRa_Fd4_PIOCa_1', 'Fd4_PIOCa_1').
has_Event_Name('PIOCa_Fd5_PTRCa_1', 'Fd5_PTRCa_1').
has_Event_Name('PIOCa_Fd5_XCBRa_1', 'Fd5_XCBRa_1').
has_Event_Name('TCTRa_Fd5_PIOCa_1', 'Fd5_PIOCa_1').
has_Event_Name('PIOCa_Tr1_PTRCa_1', 'Tr1_PTRCa_1').
has_Event_Name('PIOCa_Tr1_XCBRa_1', 'Tr1_XCBRa_1').
has_Event_Name('TCTRa_Tr1_PIOCa_1', 'Tr1_PIOCa_1').
has_Event_Name('XCBRa_Fd1_PTRCa_1', 'Fd1_PTRCa_1').
has_Event_Name('PIOCa_Fd1_TCTRa_1', 'Fd1_TCTRa_1').
has_Event_Name('PTRCa_Fd2_PIOCa_1', 'Fd2_PIOCa_1').
has_Event_Name('XCBRa_Fd2_PTRCa_1', 'Fd2_PTRCa_1').
has_Event_Name('PIOCa_Fd2_TCTRa_1', 'Fd2_TCTRa_1').
has_Event_Name('PTRCa_Fd3_PIOCa_1', 'Fd3_PIOCa_1').
has_Event_Name('XCBRa_Fd3_PTRCa_1', 'Fd3_PTRCa_1').
has_Event_Name('PIOCa_Fd3_TCTRa_1', 'Fd3_TCTRa_1').
has_Event_Name('PTRCa_Fd4_PIOCa_1', 'Fd4_PIOCa_1').
has_Event_Name('XCBRa_Fd4_PTRCa_1', 'Fd4_PTRCa_1').
has_Event_Name('PIOCa_Fd4_TCTRa_1', 'Fd4_TCTRa_1').
has_Event_Name('PTRCa_Fd5_PIOCa_1', 'Fd5_PIOCa_1').
has_Event_Name('XCBRa_Fd5_PTRCa_1', 'Fd5_PTRCa_1').
has_Event_Name('PIOCa_Fd5_TCTRa_1', 'Fd5_TCTRa_1').
has_Event_Name('PTRCa_Tr1_PIOCa_1', 'Tr1_PIOCa_1').
has_Event_Name('XCBRa_Tr1_PTRCa_1', 'Tr1_PTRCa_1').
has_Event_Name('PIOCa_Tr1_TCTRa_1', 'Tr1_TCTRa_1').
'With'('CNF_LN0_Beh_With').
'With'('CNF_LN0_Health_With').
'With'('CNF_LPHDa_Beh_With').
'With'('CNF_LPHDa_PhyHealth_With').
'With'('CNF_LPHDa_Proxy_With').
'With'('CNF_PIOCa_Beh_With').
'With'('CNF_PIOCa_Health_With').
'With'('CNF_PIOCa_Op_With').
'With'('CNF_PIOCa_Str_With').
'With'('CNF_PTRCa_Beh_With').
'With'('CNF_PTRCa_Health_With').
'With'('CNF_PTRCa_Op_With').
'With'('CNF_PTRCa_Tr_With').
'With'('CNF_TCTRa_AmpSv_With').
'With'('CNF_TCTRa_Beh_With').
'With'('CNF_TCTRa_Health_With').
'With'('CNF_XCBRa_Beh_With').
'With'('CNF_XCBRa_CBOpCap_With').
'With'('CNF_XCBRa_Health_With').
'With'('CNF_XCBRa_Loc_With').
'With'('CNF_XCBRa_OpCnt_With').
'With'('REQ_LN0_Mod_With').
'With'('REQ_LN0_NamPlt_With').
'With'('REQ_LPHDa_PhyNam_With').
'With'('REQ_PIOCa_Mod_With').
'With'('REQ_PIOCa_NamPlt_With').
'With'('REQ_PTRCa_Mod_With').
'With'('REQ_PTRCa_NamPlt_With').
'With'('REQ_TCTRa_Mod_With').
'With'('REQ_TCTRa_NamPlt_With').
'With'('REQ_XCBRa_BlkCls_With').
'With'('REQ_XCBRa_BlkOpn_With').
'With'('REQ_XCBRa_Mod_With').
'With'('REQ_XCBRa_NamPlt_With').
'With'('REQ_XCBRa_Pos_With').
'With'('Fd1_PTRCa_1_PIOCa_Op_general_With').
'With'('Fd1_XCBRa_1_PIOCa_Tr_general_With').
'With'('Fd1_PIOCa_1_TCTRa_AmpSv_instMag_f_With').
'With'('Fd2_PTRCa_1_PIOCa_Op_general_With').
'With'('Fd2_XCBRa_1_PIOCa_Tr_general_With').
'With'('Fd2_PIOCa_1_TCTRa_AmpSv_instMag_f_With').
'With'('Fd3_PTRCa_1_PIOCa_Op_general_With').
'With'('Fd3_XCBRa_1_PIOCa_Tr_general_With').
'With'('Fd3_PIOCa_1_TCTRa_AmpSv_instMag_f_With').
'With'('Fd4_PTRCa_1_PIOCa_Op_general_With').
'With'('Fd4_XCBRa_1_PIOCa_Tr_general_With').
'With'('Fd4_PIOCa_1_TCTRa_AmpSv_instMag_f_With').
'With'('Fd5_PTRCa_1_PIOCa_Op_general_With').
'With'('Fd5_XCBRa_1_PIOCa_Tr_general_With').
'With'('Fd5_PIOCa_1_TCTRa_AmpSv_instMag_f_With').
'With'('Tr1_PTRCa_1_PIOCa_Op_general_With').
'With'('Tr1_XCBRa_1_PIOCa_Tr_general_With').
'With'('Tr1_PIOCa_1_TCTRa_AmpSv_instMag_f_With').
'With'('Fd1_PTRCa_1_XCBRa_Tr_general_With').
'With'('Fd1_TCTRa_1_PIOCa_AmpSv_instMag_f_With').
'With'('Fd2_PIOCa_1_PTRCa_Op_general_With').
'With'('Fd2_PTRCa_1_XCBRa_Tr_general_With').
'With'('Fd2_TCTRa_1_PIOCa_AmpSv_instMag_f_With').
'With'('Fd3_PIOCa_1_PTRCa_Op_general_With').
'With'('Fd3_PTRCa_1_XCBRa_Tr_general_With').
'With'('Fd3_TCTRa_1_PIOCa_AmpSv_instMag_f_With').
'With'('Fd4_PIOCa_1_PTRCa_Op_general_With').
'With'('Fd4_PTRCa_1_XCBRa_Tr_general_With').
'With'('Fd4_TCTRa_1_PIOCa_AmpSv_instMag_f_With').
'With'('Fd5_PIOCa_1_PTRCa_Op_general_With').
'With'('Fd5_PTRCa_1_XCBRa_Tr_general_With').
'With'('Fd5_TCTRa_1_PIOCa_AmpSv_instMag_f_With').
'With'('Tr1_PIOCa_1_PTRCa_Op_general_With').
'With'('Tr1_PTRCa_1_XCBRa_Tr_general_With').
'With'('Tr1_TCTRa_1_PIOCa_AmpSv_instMag_f_With').
has_With('LN0_CNF', 'CNF_LN0_Beh_With').
has_With('LN0_CNF', 'CNF_LN0_Health_With').
has_With('LPHDa_CNF', 'CNF_LPHDa_Beh_With').
has_With('LPHDa_CNF', 'CNF_LPHDa_PhyHealth_With').
has_With('LPHDa_CNF', 'CNF_LPHDa_Proxy_With').
has_With('PIOCa_CNF', 'CNF_PIOCa_Beh_With').
has_With('PIOCa_CNF', 'CNF_PIOCa_Health_With').
has_With('PIOCa_CNF', 'CNF_PIOCa_Op_With').
has_With('PIOCa_CNF', 'CNF_PIOCa_Str_With').
has_With('PTRCa_CNF', 'CNF_PTRCa_Beh_With').
has_With('PTRCa_CNF', 'CNF_PTRCa_Health_With').
has_With('PTRCa_CNF', 'CNF_PTRCa_Op_With').
has_With('PTRCa_CNF', 'CNF_PTRCa_Tr_With').
has_With('TCTRa_CNF', 'CNF_TCTRa_AmpSv_With').
has_With('TCTRa_CNF', 'CNF_TCTRa_Beh_With').
has_With('TCTRa_CNF', 'CNF_TCTRa_Health_With').
has_With('XCBRa_CNF', 'CNF_XCBRa_Beh_With').
has_With('XCBRa_CNF', 'CNF_XCBRa_CBOpCap_With').
has_With('XCBRa_CNF', 'CNF_XCBRa_Health_With').
has_With('XCBRa_CNF', 'CNF_XCBRa_Loc_With').
has_With('XCBRa_CNF', 'CNF_XCBRa_OpCnt_With').
has_With('LN0_REQ', 'REQ_LN0_Mod_With').
has_With('LN0_REQ', 'REQ_LN0_NamPlt_With').
has_With('LPHDa_REQ', 'REQ_LPHDa_PhyNam_With').
has_With('PIOCa_REQ', 'REQ_PIOCa_Mod_With').
has_With('PIOCa_REQ', 'REQ_PIOCa_NamPlt_With').
has_With('PTRCa_REQ', 'REQ_PTRCa_Mod_With').
has_With('PTRCa_REQ', 'REQ_PTRCa_NamPlt_With').
has_With('TCTRa_REQ', 'REQ_TCTRa_Mod_With').
has_With('TCTRa_REQ', 'REQ_TCTRa_NamPlt_With').
has_With('XCBRa_REQ', 'REQ_XCBRa_BlkCls_With').
has_With('XCBRa_REQ', 'REQ_XCBRa_BlkOpn_With').
has_With('XCBRa_REQ', 'REQ_XCBRa_Mod_With').
has_With('XCBRa_REQ', 'REQ_XCBRa_NamPlt_With').
has_With('XCBRa_REQ', 'REQ_XCBRa_Pos_With').
has_With('PIOCa_Fd1_PTRCa_1', 'Fd1_PTRCa_1_PIOCa_Op_general_With').
has_With('PIOCa_Fd1_XCBRa_1', 'Fd1_XCBRa_1_PIOCa_Tr_general_With').
has_With('TCTRa_Fd1_PIOCa_1', 'Fd1_PIOCa_1_TCTRa_AmpSv_instMag_f_With').
has_With('PIOCa_Fd2_PTRCa_1', 'Fd2_PTRCa_1_PIOCa_Op_general_With').
has_With('PIOCa_Fd2_XCBRa_1', 'Fd2_XCBRa_1_PIOCa_Tr_general_With').
has_With('TCTRa_Fd2_PIOCa_1', 'Fd2_PIOCa_1_TCTRa_AmpSv_instMag_f_With').
has_With('PIOCa_Fd3_PTRCa_1', 'Fd3_PTRCa_1_PIOCa_Op_general_With').
has_With('PIOCa_Fd3_XCBRa_1', 'Fd3_XCBRa_1_PIOCa_Tr_general_With').
has_With('TCTRa_Fd3_PIOCa_1', 'Fd3_PIOCa_1_TCTRa_AmpSv_instMag_f_With').
has_With('PIOCa_Fd4_PTRCa_1', 'Fd4_PTRCa_1_PIOCa_Op_general_With').
has_With('PIOCa_Fd4_XCBRa_1', 'Fd4_XCBRa_1_PIOCa_Tr_general_With').
has_With('TCTRa_Fd4_PIOCa_1', 'Fd4_PIOCa_1_TCTRa_AmpSv_instMag_f_With').
has_With('PIOCa_Fd5_PTRCa_1', 'Fd5_PTRCa_1_PIOCa_Op_general_With').
has_With('PIOCa_Fd5_XCBRa_1', 'Fd5_XCBRa_1_PIOCa_Tr_general_With').
has_With('TCTRa_Fd5_PIOCa_1', 'Fd5_PIOCa_1_TCTRa_AmpSv_instMag_f_With').
has_With('PIOCa_Tr1_PTRCa_1', 'Tr1_PTRCa_1_PIOCa_Op_general_With').
has_With('PIOCa_Tr1_XCBRa_1', 'Tr1_XCBRa_1_PIOCa_Tr_general_With').
has_With('TCTRa_Tr1_PIOCa_1', 'Tr1_PIOCa_1_TCTRa_AmpSv_instMag_f_With').
has_With('XCBRa_Fd1_PTRCa_1', 'Fd1_PTRCa_1_XCBRa_Tr_general_With').
has_With('PIOCa_Fd1_TCTRa_1', 'Fd1_TCTRa_1_PIOCa_AmpSv_instMag_f_With').
has_With('PTRCa_Fd2_PIOCa_1', 'Fd2_PIOCa_1_PTRCa_Op_general_With').
has_With('XCBRa_Fd2_PTRCa_1', 'Fd2_PTRCa_1_XCBRa_Tr_general_With').
has_With('PIOCa_Fd2_TCTRa_1', 'Fd2_TCTRa_1_PIOCa_AmpSv_instMag_f_With').
has_With('PTRCa_Fd3_PIOCa_1', 'Fd3_PIOCa_1_PTRCa_Op_general_With').
has_With('XCBRa_Fd3_PTRCa_1', 'Fd3_PTRCa_1_XCBRa_Tr_general_With').
has_With('PIOCa_Fd3_TCTRa_1', 'Fd3_TCTRa_1_PIOCa_AmpSv_instMag_f_With').
has_With('PTRCa_Fd4_PIOCa_1', 'Fd4_PIOCa_1_PTRCa_Op_general_With').
has_With('XCBRa_Fd4_PTRCa_1', 'Fd4_PTRCa_1_XCBRa_Tr_general_With').
has_With('PIOCa_Fd4_TCTRa_1', 'Fd4_TCTRa_1_PIOCa_AmpSv_instMag_f_With').
has_With('PTRCa_Fd5_PIOCa_1', 'Fd5_PIOCa_1_PTRCa_Op_general_With').
has_With('XCBRa_Fd5_PTRCa_1', 'Fd5_PTRCa_1_XCBRa_Tr_general_With').
has_With('PIOCa_Fd5_TCTRa_1', 'Fd5_TCTRa_1_PIOCa_AmpSv_instMag_f_With').
has_With('PTRCa_Tr1_PIOCa_1', 'Tr1_PIOCa_1_PTRCa_Op_general_With').
has_With('XCBRa_Tr1_PTRCa_1', 'Tr1_PTRCa_1_XCBRa_Tr_general_With').
has_With('PIOCa_Tr1_TCTRa_1', 'Tr1_TCTRa_1_PIOCa_AmpSv_instMag_f_With').
has_With_Var('CNF_LN0_Beh_With', 'Beh').
has_With_Var('CNF_LN0_Health_With', 'Health').
has_With_Var('CNF_LPHDa_Beh_With', 'Beh').
has_With_Var('CNF_LPHDa_PhyHealth_With', 'PhyHealth').
has_With_Var('CNF_LPHDa_Proxy_With', 'Proxy').
has_With_Var('CNF_PIOCa_Beh_With', 'Beh').
has_With_Var('CNF_PIOCa_Health_With', 'Health').
has_With_Var('CNF_PIOCa_Op_With', 'Op').
has_With_Var('CNF_PIOCa_Str_With', 'Str').
has_With_Var('CNF_PTRCa_Beh_With', 'Beh').
has_With_Var('CNF_PTRCa_Health_With', 'Health').
has_With_Var('CNF_PTRCa_Op_With', 'Op').
has_With_Var('CNF_PTRCa_Tr_With', 'Tr').
has_With_Var('CNF_TCTRa_AmpSv_With', 'AmpSv').
has_With_Var('CNF_TCTRa_Beh_With', 'Beh').
has_With_Var('CNF_TCTRa_Health_With', 'Health').
has_With_Var('CNF_XCBRa_Beh_With', 'Beh').
has_With_Var('CNF_XCBRa_CBOpCap_With', 'CBOpCap').
has_With_Var('CNF_XCBRa_Health_With', 'Health').
has_With_Var('CNF_XCBRa_Loc_With', 'Loc').
has_With_Var('CNF_XCBRa_OpCnt_With', 'OpCnt').
has_With_Var('REQ_LN0_Mod_With', 'Mod').
has_With_Var('REQ_LN0_NamPlt_With', 'NamPlt').
has_With_Var('REQ_LPHDa_PhyNam_With', 'PhyNam').
has_With_Var('REQ_PIOCa_Mod_With', 'Mod').
has_With_Var('REQ_PIOCa_NamPlt_With', 'NamPlt').
has_With_Var('REQ_PTRCa_Mod_With', 'Mod').
has_With_Var('REQ_PTRCa_NamPlt_With', 'NamPlt').
has_With_Var('REQ_TCTRa_Mod_With', 'Mod').
has_With_Var('REQ_TCTRa_NamPlt_With', 'NamPlt').
has_With_Var('REQ_XCBRa_BlkCls_With', 'BlkCls').
has_With_Var('REQ_XCBRa_BlkOpn_With', 'BlkOpn').
has_With_Var('REQ_XCBRa_Mod_With', 'Mod').
has_With_Var('REQ_XCBRa_NamPlt_With', 'NamPlt').
has_With_Var('REQ_XCBRa_Pos_With', 'Pos').
has_With_Var('Fd1_PTRCa_1_PIOCa_Op_general_With', 'Op_general').
has_With_Var('Fd1_XCBRa_1_PIOCa_Tr_general_With', 'Tr_general').
has_With_Var('Fd1_PIOCa_1_TCTRa_AmpSv_instMag_f_With', 'AmpSv_instMag_f').
has_With_Var('Fd2_PTRCa_1_PIOCa_Op_general_With', 'Op_general').
has_With_Var('Fd2_XCBRa_1_PIOCa_Tr_general_With', 'Tr_general').
has_With_Var('Fd2_PIOCa_1_TCTRa_AmpSv_instMag_f_With', 'AmpSv_instMag_f').
has_With_Var('Fd3_PTRCa_1_PIOCa_Op_general_With', 'Op_general').
has_With_Var('Fd3_XCBRa_1_PIOCa_Tr_general_With', 'Tr_general').
has_With_Var('Fd3_PIOCa_1_TCTRa_AmpSv_instMag_f_With', 'AmpSv_instMag_f').
has_With_Var('Fd4_PTRCa_1_PIOCa_Op_general_With', 'Op_general').
has_With_Var('Fd4_XCBRa_1_PIOCa_Tr_general_With', 'Tr_general').
has_With_Var('Fd4_PIOCa_1_TCTRa_AmpSv_instMag_f_With', 'AmpSv_instMag_f').
has_With_Var('Fd5_PTRCa_1_PIOCa_Op_general_With', 'Op_general').
has_With_Var('Fd5_XCBRa_1_PIOCa_Tr_general_With', 'Tr_general').
has_With_Var('Fd5_PIOCa_1_TCTRa_AmpSv_instMag_f_With', 'AmpSv_instMag_f').
has_With_Var('Tr1_PTRCa_1_PIOCa_Op_general_With', 'Op_general').
has_With_Var('Tr1_XCBRa_1_PIOCa_Tr_general_With', 'Tr_general').
has_With_Var('Tr1_PIOCa_1_TCTRa_AmpSv_instMag_f_With', 'AmpSv_instMag_f').
has_With_Var('Fd1_PTRCa_1_XCBRa_Tr_general_With', 'Tr_general').
has_With_Var('Fd1_TCTRa_1_PIOCa_AmpSv_instMag_f_With', 'AmpSv_instMag_f').
has_With_Var('Fd2_PIOCa_1_PTRCa_Op_general_With', 'Op_general').
has_With_Var('Fd2_PTRCa_1_XCBRa_Tr_general_With', 'Tr_general').
has_With_Var('Fd2_TCTRa_1_PIOCa_AmpSv_instMag_f_With', 'AmpSv_instMag_f').
has_With_Var('Fd3_PIOCa_1_PTRCa_Op_general_With', 'Op_general').
has_With_Var('Fd3_PTRCa_1_XCBRa_Tr_general_With', 'Tr_general').
has_With_Var('Fd3_TCTRa_1_PIOCa_AmpSv_instMag_f_With', 'AmpSv_instMag_f').
has_With_Var('Fd4_PIOCa_1_PTRCa_Op_general_With', 'Op_general').
has_With_Var('Fd4_PTRCa_1_XCBRa_Tr_general_With', 'Tr_general').
has_With_Var('Fd4_TCTRa_1_PIOCa_AmpSv_instMag_f_With', 'AmpSv_instMag_f').
has_With_Var('Fd5_PIOCa_1_PTRCa_Op_general_With', 'Op_general').
has_With_Var('Fd5_PTRCa_1_XCBRa_Tr_general_With', 'Tr_general').
has_With_Var('Fd5_TCTRa_1_PIOCa_AmpSv_instMag_f_With', 'AmpSv_instMag_f').
has_With_Var('Tr1_PIOCa_1_PTRCa_Op_general_With', 'Op_general').
has_With_Var('Tr1_PTRCa_1_XCBRa_Tr_general_With', 'Tr_general').
has_With_Var('Tr1_TCTRa_1_PIOCa_AmpSv_instMag_f_With', 'AmpSv_instMag_f').
'InputVars'('LN0_InputVars').
'InputVars'('LPHDa_InputVars').
'InputVars'('PIOCa_InputVars').
'InputVars'('PTRCa_InputVars').
'InputVars'('TCTRa_InputVars').
'InputVars'('XCBRa_InputVars').
has_InputVars('LN0_InterfaceList', 'LN0_InputVars').
has_InputVars('LPHDa_InterfaceList', 'LPHDa_InputVars').
has_InputVars('PIOCa_InterfaceList', 'PIOCa_InputVars').
has_InputVars('PTRCa_InterfaceList', 'PTRCa_InputVars').
has_InputVars('TCTRa_InterfaceList', 'TCTRa_InputVars').
has_InputVars('XCBRa_InterfaceList', 'XCBRa_InputVars').
'OutputVars'('LN0_OutputVars').
'OutputVars'('LPHDa_OutputVars').
'OutputVars'('PIOCa_OutputVars').
'OutputVars'('PTRCa_OutputVars').
'OutputVars'('TCTRa_OutputVars').
'OutputVars'('XCBRa_OutputVars').
has_OutputVars('LN0_InterfaceList', 'LN0_OutputVars').
has_OutputVars('LPHDa_InterfaceList', 'LPHDa_OutputVars').
has_OutputVars('PIOCa_InterfaceList', 'PIOCa_OutputVars').
has_OutputVars('PTRCa_InterfaceList', 'PTRCa_OutputVars').
has_OutputVars('TCTRa_InterfaceList', 'TCTRa_OutputVars').
has_OutputVars('XCBRa_InterfaceList', 'XCBRa_OutputVars').
'System'('SympatheticTrip_System').
has_System_Name('SympatheticTrip_System', 'SympatheticTrip').
has_System_Comment('SympatheticTrip_System', 'Version_1.0').
'Device'('Fd1').
'Device'('Fd2').
'Device'('Fd3').
'Device'('Fd4').
'Device'('Fd5').
'Device'('Tr1').
has_Device('SympatheticTrip_System', 'Fd1').
has_Device('SympatheticTrip_System', 'Fd2').
has_Device('SympatheticTrip_System', 'Fd3').
has_Device('SympatheticTrip_System', 'Fd4').
has_Device('SympatheticTrip_System', 'Fd5').
has_Device('SympatheticTrip_System', 'Tr1').
has_Device_Name('Fd1', 'Fd1').
has_Device_Name('Fd2', 'Fd2').
has_Device_Name('Fd3', 'Fd3').
has_Device_Name('Fd4', 'Fd4').
has_Device_Name('Fd5', 'Fd5').
has_Device_Name('Tr1', 'Tr1').
has_Device_Type('Fd1', 'NXT_RMTDEV').
has_Device_Type('Fd2', 'NXT_RMTDEV').
has_Device_Type('Fd3', 'NXT_RMTDEV').
has_Device_Type('Fd4', 'NXT_RMTDEV').
has_Device_Type('Fd5', 'NXT_RMTDEV').
has_Device_Type('Tr1', 'NXT_RMTDEV').
'Resource'('Fd1_S1_C1').
'Resource'('Fd2_S1_C1').
'Resource'('Fd3_S1_C1').
'Resource'('Fd4_S1_C1').
'Resource'('Fd5_S1_C1').
'Resource'('Tr1_S1_C1').
has_Resource('Fd1', 'Fd1_S1_C1').
has_Resource('Fd2', 'Fd2_S1_C1').
has_Resource('Fd3', 'Fd3_S1_C1').
has_Resource('Fd4', 'Fd4_S1_C1').
has_Resource('Fd5', 'Fd5_S1_C1').
has_Resource('Tr1', 'Tr1_S1_C1').
has_Resource_Name('Fd1_S1_C1', 'C1').
has_Resource_Name('Fd2_S1_C1', 'C1').
has_Resource_Name('Fd3_S1_C1', 'C1').
has_Resource_Name('Fd4_S1_C1', 'C1').
has_Resource_Name('Fd5_S1_C1', 'C1').
has_Resource_Name('Tr1_S1_C1', 'C1').
has_Resource_Type('Fd1_S1_C1', 'EMB_RES').
has_Resource_Type('Fd2_S1_C1', 'EMB_RES').
has_Resource_Type('Fd3_S1_C1', 'EMB_RES').
has_Resource_Type('Fd4_S1_C1', 'EMB_RES').
has_Resource_Type('Fd5_S1_C1', 'EMB_RES').
has_Resource_Type('Tr1_S1_C1', 'EMB_RES').
'FBNetwork'('Fd1_S1_C1_FBNetwork').
'FBNetwork'('Fd2_S1_C1_FBNetwork').
'FBNetwork'('Fd3_S1_C1_FBNetwork').
'FBNetwork'('Fd4_S1_C1_FBNetwork').
'FBNetwork'('Fd5_S1_C1_FBNetwork').
'FBNetwork'('Tr1_S1_C1_FBNetwork').
has_FBNetwork('Fd1_S1_C1', 'Fd1_S1_C1_FBNetwork').
has_FBNetwork('Fd2_S1_C1', 'Fd2_S1_C1_FBNetwork').
has_FBNetwork('Fd3_S1_C1', 'Fd3_S1_C1_FBNetwork').
has_FBNetwork('Fd4_S1_C1', 'Fd4_S1_C1_FBNetwork').
has_FBNetwork('Fd5_S1_C1', 'Fd5_S1_C1_FBNetwork').
has_FBNetwork('Tr1_S1_C1', 'Tr1_S1_C1_FBNetwork').
'EventConnections'('SympatheticTrip_APP_SubAppNetwork_EventConnections').
'EventConnections'('Fd1_S1_C1_FBNetwork_EventConnections').
'EventConnections'('Fd2_S1_C1_FBNetwork_EventConnections').
'EventConnections'('Fd3_S1_C1_FBNetwork_EventConnections').
'EventConnections'('Fd4_S1_C1_FBNetwork_EventConnections').
'EventConnections'('Fd5_S1_C1_FBNetwork_EventConnections').
'EventConnections'('Tr1_S1_C1_FBNetwork_EventConnections').
has_EventConnections('SympatheticTrip_APP_SubAppNetwork', 'SympatheticTrip_APP_SubAppNetwork_EventConnections').
has_EventConnections('Fd1_S1_C1_FBNetwork', 'Fd1_S1_C1_FBNetwork_EventConnections').
has_EventConnections('Fd2_S1_C1_FBNetwork', 'Fd2_S1_C1_FBNetwork_EventConnections').
has_EventConnections('Fd3_S1_C1_FBNetwork', 'Fd3_S1_C1_FBNetwork_EventConnections').
has_EventConnections('Fd4_S1_C1_FBNetwork', 'Fd4_S1_C1_FBNetwork_EventConnections').
has_EventConnections('Fd5_S1_C1_FBNetwork', 'Fd5_S1_C1_FBNetwork_EventConnections').
has_EventConnections('Tr1_S1_C1_FBNetwork', 'Tr1_S1_C1_FBNetwork_EventConnections').
'DataConnections'('SympatheticTrip_APP_SubAppNetwork_DataConnections').
'DataConnections'('Fd1_S1_C1_FBNetwork_DataConnections').
'DataConnections'('Fd2_S1_C1_FBNetwork_DataConnections').
'DataConnections'('Fd3_S1_C1_FBNetwork_DataConnections').
'DataConnections'('Fd4_S1_C1_FBNetwork_DataConnections').
'DataConnections'('Fd5_S1_C1_FBNetwork_DataConnections').
'DataConnections'('Tr1_S1_C1_FBNetwork_DataConnections').
has_DataConnections('SympatheticTrip_APP_SubAppNetwork', 'SympatheticTrip_APP_SubAppNetwork_DataConnections').
has_DataConnections('Fd1_S1_C1_FBNetwork', 'Fd1_S1_C1_FBNetwork_DataConnections').
has_DataConnections('Fd2_S1_C1_FBNetwork', 'Fd2_S1_C1_FBNetwork_DataConnections').
has_DataConnections('Fd3_S1_C1_FBNetwork', 'Fd3_S1_C1_FBNetwork_DataConnections').
has_DataConnections('Fd4_S1_C1_FBNetwork', 'Fd4_S1_C1_FBNetwork_DataConnections').
has_DataConnections('Fd5_S1_C1_FBNetwork', 'Fd5_S1_C1_FBNetwork_DataConnections').
has_DataConnections('Tr1_S1_C1_FBNetwork', 'Tr1_S1_C1_FBNetwork_DataConnections').
'FB'('Fd1_C1_LN0_1').
'FB'('Fd2_C1_LN0_1').
'FB'('Fd3_C1_LN0_1').
'FB'('Fd4_C1_LN0_1').
'FB'('Fd5_C1_LN0_1').
'FB'('Tr1_C1_LN0_1').
'FB'('Fd1_LPHDa_1').
'FB'('Fd1_PIOCa_1').
'FB'('Fd1_PTRCa_1').
'FB'('Fd1_TCTRa_1').
'FB'('Fd1_XCBRa_1').
'FB'('Fd2_LPHDa_1').
'FB'('Fd2_PIOCa_1').
'FB'('Fd2_PTRCa_1').
'FB'('Fd2_TCTRa_1').
'FB'('Fd2_XCBRa_1').
'FB'('Fd3_LPHDa_1').
'FB'('Fd3_PIOCa_1').
'FB'('Fd3_PTRCa_1').
'FB'('Fd3_TCTRa_1').
'FB'('Fd3_XCBRa_1').
'FB'('Fd4_LPHDa_1').
'FB'('Fd4_PIOCa_1').
'FB'('Fd4_PTRCa_1').
'FB'('Fd4_TCTRa_1').
'FB'('Fd4_XCBRa_1').
'FB'('Fd5_LPHDa_1').
'FB'('Fd5_PIOCa_1').
'FB'('Fd5_PTRCa_1').
'FB'('Fd5_TCTRa_1').
'FB'('Fd5_XCBRa_1').
'FB'('Tr1_LPHDa_1').
'FB'('Tr1_PIOCa_1').
'FB'('Tr1_PTRCa_1').
'FB'('Tr1_TCTRa_1').
'FB'('Tr1_XCBRa_1').
'FB'('APP_Fd1_LPHDa_1').
'FB'('APP_Fd1_PIOCa_1').
'FB'('APP_Fd1_PTRCa_1').
'FB'('APP_Fd1_TCTRa_1').
'FB'('APP_Fd1_XCBRa_1').
'FB'('APP_Fd2_LPHDa_1').
'FB'('APP_Fd2_PIOCa_1').
'FB'('APP_Fd2_PTRCa_1').
'FB'('APP_Fd2_TCTRa_1').
'FB'('APP_Fd2_XCBRa_1').
'FB'('APP_Fd3_LPHDa_1').
'FB'('APP_Fd3_PIOCa_1').
'FB'('APP_Fd3_PTRCa_1').
'FB'('APP_Fd3_TCTRa_1').
'FB'('APP_Fd3_XCBRa_1').
'FB'('APP_Fd4_LPHDa_1').
'FB'('APP_Fd4_PIOCa_1').
'FB'('APP_Fd4_PTRCa_1').
'FB'('APP_Fd4_TCTRa_1').
'FB'('APP_Fd4_XCBRa_1').
'FB'('APP_Fd5_LPHDa_1').
'FB'('APP_Fd5_PIOCa_1').
'FB'('APP_Fd5_PTRCa_1').
'FB'('APP_Fd5_TCTRa_1').
'FB'('APP_Fd5_XCBRa_1').
'FB'('APP_Tr1_LPHDa_1').
'FB'('APP_Tr1_PIOCa_1').
'FB'('APP_Tr1_PTRCa_1').
'FB'('APP_Tr1_TCTRa_1').
'FB'('APP_Tr1_XCBRa_1').
has_FB('Fd1_S1_C1_FBNetwork', 'Fd1_C1_LN0_1').
has_FB('Fd2_S1_C1_FBNetwork', 'Fd2_C1_LN0_1').
has_FB('Fd3_S1_C1_FBNetwork', 'Fd3_C1_LN0_1').
has_FB('Fd4_S1_C1_FBNetwork', 'Fd4_C1_LN0_1').
has_FB('Fd5_S1_C1_FBNetwork', 'Fd5_C1_LN0_1').
has_FB('Tr1_S1_C1_FBNetwork', 'Tr1_C1_LN0_1').
has_FB('Fd1_S1_C1_FBNetwork', 'Fd1_LPHDa_1').
has_FB('Fd1_S1_C1_FBNetwork', 'Fd1_PIOCa_1').
has_FB('Fd1_S1_C1_FBNetwork', 'Fd1_PTRCa_1').
has_FB('Fd1_S1_C1_FBNetwork', 'Fd1_TCTRa_1').
has_FB('Fd1_S1_C1_FBNetwork', 'Fd1_XCBRa_1').
has_FB('Fd2_S1_C1_FBNetwork', 'Fd2_LPHDa_1').
has_FB('Fd2_S1_C1_FBNetwork', 'Fd2_PIOCa_1').
has_FB('Fd2_S1_C1_FBNetwork', 'Fd2_PTRCa_1').
has_FB('Fd2_S1_C1_FBNetwork', 'Fd2_TCTRa_1').
has_FB('Fd2_S1_C1_FBNetwork', 'Fd2_XCBRa_1').
has_FB('Fd3_S1_C1_FBNetwork', 'Fd3_LPHDa_1').
has_FB('Fd3_S1_C1_FBNetwork', 'Fd3_PIOCa_1').
has_FB('Fd3_S1_C1_FBNetwork', 'Fd3_PTRCa_1').
has_FB('Fd3_S1_C1_FBNetwork', 'Fd3_TCTRa_1').
has_FB('Fd3_S1_C1_FBNetwork', 'Fd3_XCBRa_1').
has_FB('Fd4_S1_C1_FBNetwork', 'Fd4_LPHDa_1').
has_FB('Fd4_S1_C1_FBNetwork', 'Fd4_PIOCa_1').
has_FB('Fd4_S1_C1_FBNetwork', 'Fd4_PTRCa_1').
has_FB('Fd4_S1_C1_FBNetwork', 'Fd4_TCTRa_1').
has_FB('Fd4_S1_C1_FBNetwork', 'Fd4_XCBRa_1').
has_FB('Fd5_S1_C1_FBNetwork', 'Fd5_LPHDa_1').
has_FB('Fd5_S1_C1_FBNetwork', 'Fd5_PIOCa_1').
has_FB('Fd5_S1_C1_FBNetwork', 'Fd5_PTRCa_1').
has_FB('Fd5_S1_C1_FBNetwork', 'Fd5_TCTRa_1').
has_FB('Fd5_S1_C1_FBNetwork', 'Fd5_XCBRa_1').
has_FB('Tr1_S1_C1_FBNetwork', 'Tr1_LPHDa_1').
has_FB('Tr1_S1_C1_FBNetwork', 'Tr1_PIOCa_1').
has_FB('Tr1_S1_C1_FBNetwork', 'Tr1_PTRCa_1').
has_FB('Tr1_S1_C1_FBNetwork', 'Tr1_TCTRa_1').
has_FB('Tr1_S1_C1_FBNetwork', 'Tr1_XCBRa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'Fd1_C1_LN0_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'Fd2_C1_LN0_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'Fd3_C1_LN0_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'Fd4_C1_LN0_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'Fd5_C1_LN0_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'Tr1_C1_LN0_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd1_LPHDa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd1_PIOCa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd1_PTRCa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd1_TCTRa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd1_XCBRa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd2_LPHDa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd2_PIOCa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd2_PTRCa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd2_TCTRa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd2_XCBRa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd3_LPHDa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd3_PIOCa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd3_PTRCa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd3_TCTRa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd3_XCBRa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd4_LPHDa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd4_PIOCa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd4_PTRCa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd4_TCTRa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd4_XCBRa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd5_LPHDa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd5_PIOCa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd5_PTRCa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd5_TCTRa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Fd5_XCBRa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Tr1_LPHDa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Tr1_PIOCa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Tr1_PTRCa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Tr1_TCTRa_1').
has_FB('SympatheticTrip_APP_SubAppNetwork', 'APP_Tr1_XCBRa_1').
has_FB_Name('Fd1_C1_LN0_1', 'Fd1_C1_LN0_1').
has_FB_Name('Fd2_C1_LN0_1', 'Fd2_C1_LN0_1').
has_FB_Name('Fd3_C1_LN0_1', 'Fd3_C1_LN0_1').
has_FB_Name('Fd4_C1_LN0_1', 'Fd4_C1_LN0_1').
has_FB_Name('Fd5_C1_LN0_1', 'Fd5_C1_LN0_1').
has_FB_Name('Tr1_C1_LN0_1', 'Tr1_C1_LN0_1').
/* has_FB_Name('Fd1_LPHDa_1', 'Fd1_LPHDa_1'). */
has_FB_Name('Fd1_LPHDa_1', 'Fd1_TCTRa_1').      /* error included - duplicate name */ 
has_FB_Name('Fd1_PIOCa_1', 'Fd1_PIOCa_1').
has_FB_Name('Fd1_PTRCa_1', 'Fd1_PTRCa_1').
has_FB_Name('Fd1_TCTRa_1', 'Fd1_TCTRa_1').
has_FB_Name('Fd1_XCBRa_1', 'Fd1_XCBRa_1'). /* dublicate name */
has_FB_Name('Fd2_LPHDa_1', 'Fd2_LPHDa_1').
has_FB_Name('Fd2_PIOCa_1', 'Fd2_PIOCa_1').
has_FB_Name('Fd2_PTRCa_1', 'Fd2_PTRCa_1').
has_FB_Name('Fd2_TCTRa_1', 'Fd2_TCTRa_1').
has_FB_Name('Fd2_XCBRa_1', 'Fd2_XCBRa_1').
has_FB_Name('Fd3_LPHDa_1', 'Fd3_LPHDa_1').
has_FB_Name('Fd3_PIOCa_1', 'Fd3_PIOCa_1').
has_FB_Name('Fd3_PTRCa_1', 'Fd3_PTRCa_1').
has_FB_Name('Fd3_TCTRa_1', 'Fd3_TCTRa_1').
has_FB_Name('Fd3_XCBRa_1', 'Fd3_XCBRa_1').
has_FB_Name('Fd4_LPHDa_1', 'Fd4_LPHDa_1').
has_FB_Name('Fd4_PIOCa_1', 'Fd4_PIOCa_1').
has_FB_Name('Fd4_PTRCa_1', 'Fd4_PTRCa_1').
has_FB_Name('Fd4_TCTRa_1', 'Fd4_TCTRa_1').
has_FB_Name('Fd4_XCBRa_1', 'Fd4_XCBRa_1').
has_FB_Name('Fd5_LPHDa_1', 'Fd5_LPHDa_1').
has_FB_Name('Fd5_PIOCa_1', 'Fd5_PIOCa_1').
has_FB_Name('Fd5_PTRCa_1', 'Fd5_PTRCa_1').
has_FB_Name('Fd5_TCTRa_1', 'Fd5_TCTRa_1').
has_FB_Name('Fd5_XCBRa_1', 'Fd5_XCBRa_1').
has_FB_Name('Tr1_LPHDa_1', 'Tr1_LPHDa_1').
has_FB_Name('Tr1_PIOCa_1', 'Tr1_PIOCa_1').
has_FB_Name('Tr1_PTRCa_1', 'Tr1_PTRCa_1').
has_FB_Name('Tr1_TCTRa_1', 'Tr1_TCTRa_1').
has_FB_Name('Tr1_XCBRa_1', 'Tr1_XCBRa_1').
has_FB_Name('APP_Fd1_LPHDa_1', 'Fd1_LPHDa_1').
has_FB_Name('APP_Fd1_PIOCa_1', 'Fd1_PIOCa_1').
has_FB_Name('APP_Fd1_PTRCa_1', 'Fd1_PTRCa_1').
has_FB_Name('APP_Fd1_TCTRa_1', 'Fd1_TCTRa_1').
has_FB_Name('APP_Fd1_XCBRa_1', 'Fd1_XCBRa_1').
has_FB_Name('APP_Fd2_LPHDa_1', 'Fd2_LPHDa_1').
has_FB_Name('APP_Fd2_PIOCa_1', 'Fd2_PIOCa_1').
has_FB_Name('APP_Fd2_PTRCa_1', 'Fd2_PTRCa_1').
has_FB_Name('APP_Fd2_TCTRa_1', 'Fd2_TCTRa_1').
has_FB_Name('APP_Fd2_XCBRa_1', 'Fd2_XCBRa_1').
has_FB_Name('APP_Fd3_LPHDa_1', 'Fd3_LPHDa_1').
has_FB_Name('APP_Fd3_PIOCa_1', 'Fd3_PIOCa_1').
has_FB_Name('APP_Fd3_PTRCa_1', 'Fd3_PTRCa_1').
has_FB_Name('APP_Fd3_TCTRa_1', 'Fd3_TCTRa_1').
has_FB_Name('APP_Fd3_XCBRa_1', 'Fd3_XCBRa_1').
has_FB_Name('APP_Fd4_LPHDa_1', 'Fd4_LPHDa_1').
has_FB_Name('APP_Fd4_PIOCa_1', 'Fd4_PIOCa_1').
has_FB_Name('APP_Fd4_PTRCa_1', 'Fd4_PTRCa_1').
has_FB_Name('APP_Fd4_TCTRa_1', 'Fd4_TCTRa_1').
has_FB_Name('APP_Fd4_XCBRa_1', 'Fd4_XCBRa_1').
has_FB_Name('APP_Fd5_LPHDa_1', 'Fd5_LPHDa_1').
has_FB_Name('APP_Fd5_PIOCa_1', 'Fd5_PIOCa_1').
has_FB_Name('APP_Fd5_PTRCa_1', 'Fd5_PTRCa_1').
has_FB_Name('APP_Fd5_TCTRa_1', 'Fd5_TCTRa_1').
has_FB_Name('APP_Fd5_XCBRa_1', 'Fd5_XCBRa_1').
has_FB_Name('APP_Tr1_LPHDa_1', 'Tr1_LPHDa_1').
has_FB_Name('APP_Tr1_PIOCa_1', 'Tr1_PIOCa_1').
has_FB_Name('APP_Tr1_PTRCa_1', 'Tr1_PTRCa_1').
has_FB_Name('APP_Tr1_TCTRa_1', 'Tr1_TCTRa_1').
has_FB_Name('APP_Tr1_XCBRa_1', 'Tr1_XCBRa_1').
has_FB_Type('Fd1_C1_LN0_1', 'LN0').
has_FB_Type('Fd2_C1_LN0_1', 'LN0').
has_FB_Type('Fd3_C1_LN0_1', 'LN0').
has_FB_Type('Fd4_C1_LN0_1', 'LN0').
has_FB_Type('Fd5_C1_LN0_1', 'LN0').
has_FB_Type('Tr1_C1_LN0_1', 'LN0').
has_FB_Type('Fd1_LPHDa_1', 'LPHDa').
has_FB_Type('Fd1_PIOCa_1', 'PIOCa').
has_FB_Type('Fd1_PTRCa_1', 'PTRCa').
has_FB_Type('Fd1_TCTRa_1', 'TCTRa').
has_FB_Type('Fd1_XCBRa_1', 'XCBRa').
has_FB_Type('Fd2_LPHDa_1', 'LPHDa').
has_FB_Type('Fd2_PIOCa_1', 'PIOCa').
has_FB_Type('Fd2_PTRCa_1', 'PTRCa').
has_FB_Type('Fd2_TCTRa_1', 'TCTRa').
has_FB_Type('Fd2_XCBRa_1', 'XCBRa').
has_FB_Type('Fd3_LPHDa_1', 'LPHDa').
has_FB_Type('Fd3_PIOCa_1', 'PIOCa').
has_FB_Type('Fd3_PTRCa_1', 'PTRCa').
has_FB_Type('Fd3_TCTRa_1', 'TCTRa').
has_FB_Type('Fd3_XCBRa_1', 'XCBRa').
has_FB_Type('Fd4_LPHDa_1', 'LPHDa').
has_FB_Type('Fd4_PIOCa_1', 'PIOCa').
has_FB_Type('Fd4_PTRCa_1', 'PTRCa').
has_FB_Type('Fd4_TCTRa_1', 'TCTRa').
has_FB_Type('Fd4_XCBRa_1', 'XCBRa').
has_FB_Type('Fd5_LPHDa_1', 'LPHDa').
has_FB_Type('Fd5_PIOCa_1', 'PIOCa').
has_FB_Type('Fd5_PTRCa_1', 'PTRCa').
has_FB_Type('Fd5_TCTRa_1', 'TCTRa').
has_FB_Type('Fd5_XCBRa_1', 'XCBRa').
has_FB_Type('Tr1_LPHDa_1', 'LPHDa').
has_FB_Type('Tr1_PIOCa_1', 'PIOCa').
has_FB_Type('Tr1_PTRCa_1', 'PTRCa').
has_FB_Type('Tr1_TCTRa_1', 'TCTRa').
has_FB_Type('Tr1_XCBRa_1', 'XCBRa').
has_FB_Type('APP_Fd1_LPHDa_1', 'LPHDa').
has_FB_Type('APP_Fd1_PIOCa_1', 'PIOCa').
has_FB_Type('APP_Fd1_PTRCa_1', 'PTRCa').
has_FB_Type('APP_Fd1_TCTRa_1', 'TCTRa').
has_FB_Type('APP_Fd1_XCBRa_1', 'XCBRa').
has_FB_Type('APP_Fd2_LPHDa_1', 'LPHDa').
has_FB_Type('APP_Fd2_PIOCa_1', 'PIOCa').
has_FB_Type('APP_Fd2_PTRCa_1', 'PTRCa').
has_FB_Type('APP_Fd2_TCTRa_1', 'TCTRa').
has_FB_Type('APP_Fd2_XCBRa_1', 'XCBRa').
has_FB_Type('APP_Fd3_LPHDa_1', 'LPHDa').
has_FB_Type('APP_Fd3_PIOCa_1', 'PIOCa').
has_FB_Type('APP_Fd3_PTRCa_1', 'PTRCa').
has_FB_Type('APP_Fd3_TCTRa_1', 'TCTRa').
has_FB_Type('APP_Fd3_XCBRa_1', 'XCBRa').
has_FB_Type('APP_Fd4_LPHDa_1', 'LPHDa').
has_FB_Type('APP_Fd4_PIOCa_1', 'PIOCa').
has_FB_Type('APP_Fd4_PTRCa_1', 'PTRCa').
has_FB_Type('APP_Fd4_TCTRa_1', 'TCTRa').
has_FB_Type('APP_Fd4_XCBRa_1', 'XCBRa').
has_FB_Type('APP_Fd5_LPHDa_1', 'LPHDa').
has_FB_Type('APP_Fd5_PIOCa_1', 'PIOCa').
has_FB_Type('APP_Fd5_PTRCa_1', 'PTRCa').
has_FB_Type('APP_Fd5_TCTRa_1', 'TCTRa').
has_FB_Type('APP_Fd5_XCBRa_1', 'XCBRa').
has_FB_Type('APP_Tr1_LPHDa_1', 'LPHDa').
has_FB_Type('APP_Tr1_PIOCa_1', 'PIOCa').
has_FB_Type('APP_Tr1_PTRCa_1', 'PTRCa').
has_FB_Type('APP_Tr1_TCTRa_1', 'TCTRa').
has_FB_Type('APP_Tr1_XCBRa_1', 'XCBRa').
'Application'('SympatheticTrip_APP').
has_Application('SympatheticTrip_System', 'SympatheticTrip_APP').
has_Application_Name('SympatheticTrip_APP', 'SympatheticTrip_APP').
'SubAppNetwork'('SympatheticTrip_APP_SubAppNetwork').
has_SubAppNetwork('SympatheticTrip_APP', 'SympatheticTrip_APP_SubAppNetwork').
'Mapping'('Fd1_C1_LN0_1_Mapping').
'Mapping'('Fd1_LPHDa_1_Mapping').
'Mapping'('Fd1_PIOCa_1_Mapping').
'Mapping'('Fd1_PTRCa_1_Mapping').
'Mapping'('Fd1_TCTRa_1_Mapping').
'Mapping'('Fd1_XCBRa_1_Mapping').
'Mapping'('Fd2_C1_LN0_1_Mapping').
'Mapping'('Fd2_LPHDa_1_Mapping').
'Mapping'('Fd2_PIOCa_1_Mapping').
'Mapping'('Fd2_PTRCa_1_Mapping').
'Mapping'('Fd2_TCTRa_1_Mapping').
'Mapping'('Fd2_XCBRa_1_Mapping').
'Mapping'('Fd3_C1_LN0_1_Mapping').
'Mapping'('Fd3_LPHDa_1_Mapping').
'Mapping'('Fd3_PIOCa_1_Mapping').
'Mapping'('Fd3_PTRCa_1_Mapping').
'Mapping'('Fd3_TCTRa_1_Mapping').
'Mapping'('Fd3_XCBRa_1_Mapping').
'Mapping'('Fd4_C1_LN0_1_Mapping').
'Mapping'('Fd4_LPHDa_1_Mapping').
'Mapping'('Fd4_PIOCa_1_Mapping').
'Mapping'('Fd4_PTRCa_1_Mapping').
'Mapping'('Fd4_TCTRa_1_Mapping').
'Mapping'('Fd4_XCBRa_1_Mapping').
'Mapping'('Fd5_C1_LN0_1_Mapping').
'Mapping'('Fd5_LPHDa_1_Mapping').
'Mapping'('Fd5_PIOCa_1_Mapping').
'Mapping'('Fd5_PTRCa_1_Mapping').
'Mapping'('Fd5_TCTRa_1_Mapping').
'Mapping'('Fd5_XCBRa_1_Mapping').
'Mapping'('Tr1_C1_LN0_1_Mapping').
'Mapping'('Tr1_LPHDa_1_Mapping').
'Mapping'('Tr1_PIOCa_1_Mapping').
'Mapping'('Tr1_PTRCa_1_Mapping').
'Mapping'('Tr1_TCTRa_1_Mapping').
'Mapping'('Tr1_XCBRa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd1_C1_LN0_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd1_LPHDa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd1_PIOCa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd1_PTRCa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd1_TCTRa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd1_XCBRa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd2_C1_LN0_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd2_LPHDa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd2_PIOCa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd2_PTRCa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd2_TCTRa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd2_XCBRa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd3_C1_LN0_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd3_LPHDa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd3_PIOCa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd3_PTRCa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd3_TCTRa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd3_XCBRa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd4_C1_LN0_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd4_LPHDa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd4_PIOCa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd4_PTRCa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd4_TCTRa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd4_XCBRa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd5_C1_LN0_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd5_LPHDa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd5_PIOCa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd5_PTRCa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd5_TCTRa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Fd5_XCBRa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Tr1_C1_LN0_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Tr1_LPHDa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Tr1_PIOCa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Tr1_PTRCa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Tr1_TCTRa_1_Mapping').
has_Mapping('SympatheticTrip_System', 'Tr1_XCBRa_1_Mapping').
has_Mapping_From('Fd1_C1_LN0_1_Mapping', 'SympatheticTrip_APP.Fd1_C1_LN0_1').
has_Mapping_From('Fd1_LPHDa_1_Mapping', 'SympatheticTrip_APP.Fd1_LPHDa_1').
has_Mapping_From('Fd1_PIOCa_1_Mapping', 'SympatheticTrip_APP.Fd1_PIOCa_1').
has_Mapping_From('Fd1_PTRCa_1_Mapping', 'SympatheticTrip_APP.Fd1_PTRCa_1').
has_Mapping_From('Fd1_TCTRa_1_Mapping', 'SympatheticTrip_APP.Fd1_TCTRa_1').
has_Mapping_From('Fd1_XCBRa_1_Mapping', 'SympatheticTrip_APP.Fd1_XCBRa_1').
has_Mapping_From('Fd2_C1_LN0_1_Mapping', 'SympatheticTrip_APP.Fd2_C1_LN0_1').
has_Mapping_From('Fd2_LPHDa_1_Mapping', 'SympatheticTrip_APP.Fd2_LPHDa_1').
has_Mapping_From('Fd2_PIOCa_1_Mapping', 'SympatheticTrip_APP.Fd2_PIOCa_1').
has_Mapping_From('Fd2_PTRCa_1_Mapping', 'SympatheticTrip_APP.Fd2_PTRCa_1').
has_Mapping_From('Fd2_TCTRa_1_Mapping', 'SympatheticTrip_APP.Fd2_TCTRa_1').
has_Mapping_From('Fd2_XCBRa_1_Mapping', 'SympatheticTrip_APP.Fd2_XCBRa_1').
has_Mapping_From('Fd3_C1_LN0_1_Mapping', 'SympatheticTrip_APP.Fd3_C1_LN0_1').
has_Mapping_From('Fd3_LPHDa_1_Mapping', 'SympatheticTrip_APP.Fd3_LPHDa_1').
has_Mapping_From('Fd3_PIOCa_1_Mapping', 'SympatheticTrip_APP.Fd3_PIOCa_1').
has_Mapping_From('Fd3_PTRCa_1_Mapping', 'SympatheticTrip_APP.Fd3_PTRCa_1').
has_Mapping_From('Fd3_TCTRa_1_Mapping', 'SympatheticTrip_APP.Fd3_TCTRa_1').
has_Mapping_From('Fd3_XCBRa_1_Mapping', 'SympatheticTrip_APP.Fd3_XCBRa_1').
has_Mapping_From('Fd4_C1_LN0_1_Mapping', 'SympatheticTrip_APP.Fd4_C1_LN0_1').
has_Mapping_From('Fd4_LPHDa_1_Mapping', 'SympatheticTrip_APP.Fd4_LPHDa_1').
has_Mapping_From('Fd4_PIOCa_1_Mapping', 'SympatheticTrip_APP.Fd4_PIOCa_1').
has_Mapping_From('Fd4_PTRCa_1_Mapping', 'SympatheticTrip_APP.Fd4_PTRCa_1').
has_Mapping_From('Fd4_TCTRa_1_Mapping', 'SympatheticTrip_APP.Fd4_TCTRa_1').
has_Mapping_From('Fd4_XCBRa_1_Mapping', 'SympatheticTrip_APP.Fd4_XCBRa_1').
has_Mapping_From('Fd5_C1_LN0_1_Mapping', 'SympatheticTrip_APP.Fd5_C1_LN0_1').
has_Mapping_From('Fd5_LPHDa_1_Mapping', 'SympatheticTrip_APP.Fd5_LPHDa_1').
has_Mapping_From('Fd5_PIOCa_1_Mapping', 'SympatheticTrip_APP.Fd5_PIOCa_1').
has_Mapping_From('Fd5_PTRCa_1_Mapping', 'SympatheticTrip_APP.Fd5_PTRCa_1').
has_Mapping_From('Fd5_TCTRa_1_Mapping', 'SympatheticTrip_APP.Fd5_TCTRa_1').
has_Mapping_From('Fd5_XCBRa_1_Mapping', 'SympatheticTrip_APP.Fd5_XCBRa_1').
has_Mapping_From('Tr1_C1_LN0_1_Mapping', 'SympatheticTrip_APP.Tr1_C1_LN0_1').
has_Mapping_From('Tr1_LPHDa_1_Mapping', 'SympatheticTrip_APP.Tr1_LPHDa_1').
has_Mapping_From('Tr1_PIOCa_1_Mapping', 'SympatheticTrip_APP.Tr1_PIOCa_1').
has_Mapping_From('Tr1_PTRCa_1_Mapping', 'SympatheticTrip_APP.Tr1_PTRCa_1').
has_Mapping_From('Tr1_TCTRa_1_Mapping', 'SympatheticTrip_APP.Tr1_TCTRa_1').
has_Mapping_From('Tr1_XCBRa_1_Mapping', 'SympatheticTrip_APP.Tr1_XCBRa_1').
has_Mapping_To('Fd1_C1_LN0_1_Mapping', 'Fd1.C1').
has_Mapping_To('Fd1_LPHDa_1_Mapping', 'Fd1.C1').
has_Mapping_To('Fd1_PIOCa_1_Mapping', 'Fd1.C1').
has_Mapping_To('Fd1_PTRCa_1_Mapping', 'Fd1.C1').
has_Mapping_To('Fd1_TCTRa_1_Mapping', 'Fd1.C1').
has_Mapping_To('Fd1_XCBRa_1_Mapping', 'Fd1.C1').
has_Mapping_To('Fd2_C1_LN0_1_Mapping', 'Fd2.C1').
has_Mapping_To('Fd2_LPHDa_1_Mapping', 'Fd2.C1').
has_Mapping_To('Fd2_PIOCa_1_Mapping', 'Fd2.C1').
has_Mapping_To('Fd2_PTRCa_1_Mapping', 'Fd2.C1').
has_Mapping_To('Fd2_TCTRa_1_Mapping', 'Fd2.C1').
has_Mapping_To('Fd2_XCBRa_1_Mapping', 'Fd2.C1').
has_Mapping_To('Fd3_C1_LN0_1_Mapping', 'Fd3.C1').
has_Mapping_To('Fd3_LPHDa_1_Mapping', 'Fd3.C1').
has_Mapping_To('Fd3_PIOCa_1_Mapping', 'Fd3.C1').
has_Mapping_To('Fd3_PTRCa_1_Mapping', 'Fd3.C1').
has_Mapping_To('Fd3_TCTRa_1_Mapping', 'Fd3.C1').
has_Mapping_To('Fd3_XCBRa_1_Mapping', 'Fd3.C1').
has_Mapping_To('Fd4_C1_LN0_1_Mapping', 'Fd4.C1').
has_Mapping_To('Fd4_LPHDa_1_Mapping', 'Fd4.C1').
has_Mapping_To('Fd4_PIOCa_1_Mapping', 'Fd4.C1').
has_Mapping_To('Fd4_PTRCa_1_Mapping', 'Fd4.C1').
has_Mapping_To('Fd4_TCTRa_1_Mapping', 'Fd4.C1').
has_Mapping_To('Fd4_XCBRa_1_Mapping', 'Fd4.C1').
has_Mapping_To('Fd5_C1_LN0_1_Mapping', 'Fd5.C1').
has_Mapping_To('Fd5_LPHDa_1_Mapping', 'Fd5.C1').
has_Mapping_To('Fd5_PIOCa_1_Mapping', 'Fd5.C1').
has_Mapping_To('Fd5_PTRCa_1_Mapping', 'Fd5.C1').
has_Mapping_To('Fd5_TCTRa_1_Mapping', 'Fd5.C1').
has_Mapping_To('Fd5_XCBRa_1_Mapping', 'Fd5.C1').
has_Mapping_To('Tr1_C1_LN0_1_Mapping', 'Tr1.C1').
has_Mapping_To('Tr1_LPHDa_1_Mapping', 'Tr1.C1').
has_Mapping_To('Tr1_PIOCa_1_Mapping', 'Tr1.C1').
has_Mapping_To('Tr1_PTRCa_1_Mapping', 'Tr1.C1').
has_Mapping_To('Tr1_TCTRa_1_Mapping', 'Tr1.C1').
has_Mapping_To('Tr1_XCBRa_1_Mapping', 'Tr1.C1').
'Connection'('a1:LNC_Fd1_PIOCa_1_DConnection').
'Connection'('a1:LNC_Fd1_PIOCa_1_EConnection').
'Connection'('a1:LNC_Fd1_PIOCa_2_DConnection').
'Connection'('a1:LNC_Fd1_PIOCa_2_EConnection').
'Connection'('a1:LNC_Fd1_PTRCa_1_DConnection').
'Connection'('a1:LNC_Fd1_PTRCa_1_EConnection').
'Connection'('a1:LNC_Fd1_TCTRa_1_DConnection').
'Connection'('a1:LNC_Fd1_TCTRa_1_EConnection').
'Connection'('a1:LNC_Fd2_PIOCa_1_DConnection').
'Connection'('a1:LNC_Fd2_PIOCa_1_EConnection').
'Connection'('a1:LNC_Fd2_PIOCa_2_DConnection').
'Connection'('a1:LNC_Fd2_PIOCa_2_EConnection').
'Connection'('a1:LNC_Fd2_PTRCa_1_DConnection').
'Connection'('a1:LNC_Fd2_PTRCa_1_EConnection').
'Connection'('a1:LNC_Fd2_TCTRa_1_DConnection').
'Connection'('a1:LNC_Fd2_TCTRa_1_EConnection').
'Connection'('a1:LNC_Fd3_PIOCa_1_DConnection').
'Connection'('a1:LNC_Fd3_PIOCa_1_EConnection').
'Connection'('a1:LNC_Fd3_PIOCa_2_DConnection').
'Connection'('a1:LNC_Fd3_PIOCa_2_EConnection').
'Connection'('a1:LNC_Fd3_PTRCa_1_DConnection').
'Connection'('a1:LNC_Fd3_PTRCa_1_EConnection').
'Connection'('a1:LNC_Fd3_TCTRa_1_DConnection').
'Connection'('a1:LNC_Fd3_TCTRa_1_EConnection').
'Connection'('a1:LNC_Fd4_PIOCa_1_DConnection').
'Connection'('a1:LNC_Fd4_PIOCa_1_EConnection').
'Connection'('a1:LNC_Fd4_PIOCa_2_DConnection').
'Connection'('a1:LNC_Fd4_PIOCa_2_EConnection').
'Connection'('a1:LNC_Fd4_PTRCa_1_DConnection').
'Connection'('a1:LNC_Fd4_PTRCa_1_EConnection').
'Connection'('a1:LNC_Fd4_TCTRa_1_DConnection').
'Connection'('a1:LNC_Fd4_TCTRa_1_EConnection').
'Connection'('a1:LNC_Fd5_PIOCa_1_DConnection').
'Connection'('a1:LNC_Fd5_PIOCa_1_EConnection').
'Connection'('a1:LNC_Fd5_PIOCa_2_DConnection').
'Connection'('a1:LNC_Fd5_PIOCa_2_EConnection').
'Connection'('a1:LNC_Fd5_PTRCa_1_DConnection').
'Connection'('a1:LNC_Fd5_PTRCa_1_EConnection').
'Connection'('a1:LNC_Fd5_TCTRa_1_DConnection').
'Connection'('a1:LNC_Fd5_TCTRa_1_EConnection').
'Connection'('a1:LNC_Tr1_PIOCa_1_DConnection').
'Connection'('a1:LNC_Tr1_PIOCa_1_EConnection').
'Connection'('a1:LNC_Tr1_PTRCa_1_DConnection').
'Connection'('a1:LNC_Tr1_PTRCa_1_EConnection').
'Connection'('a1:LNC_Tr1_TCTRa_1_DConnection').
'Connection'('a1:LNC_Tr1_TCTRa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd1_PIOCa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd1_PIOCa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd1_PIOCa_2_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd1_PIOCa_2_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd1_PTRCa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd1_PTRCa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd1_TCTRa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd1_TCTRa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd2_PIOCa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd2_PIOCa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd2_PIOCa_2_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd2_PIOCa_2_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd2_PTRCa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd2_PTRCa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd2_TCTRa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd2_TCTRa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd3_PIOCa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd3_PIOCa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd3_PIOCa_2_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd3_PIOCa_2_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd3_PTRCa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd3_PTRCa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd3_TCTRa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd3_TCTRa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd4_PIOCa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd4_PIOCa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd4_PIOCa_2_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd4_PIOCa_2_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd4_PTRCa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd4_PTRCa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd4_TCTRa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd4_TCTRa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd5_PIOCa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd5_PIOCa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd5_PIOCa_2_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd5_PIOCa_2_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd5_PTRCa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd5_PTRCa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Fd5_TCTRa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Fd5_TCTRa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Tr1_PIOCa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Tr1_PIOCa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Tr1_PTRCa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Tr1_PTRCa_1_EConnection').
'Connection'('DeviceConnections_a1:LNC_Tr1_TCTRa_1_DConnection').
'Connection'('DeviceConnections_a1:LNC_Tr1_TCTRa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd1_PIOCa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd1_PIOCa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd1_PIOCa_2_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd1_PIOCa_2_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd1_PTRCa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd1_PTRCa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd1_TCTRa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd1_TCTRa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd2_PIOCa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd2_PIOCa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd2_PIOCa_2_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd2_PIOCa_2_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd2_PTRCa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd2_PTRCa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd2_TCTRa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd2_TCTRa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd3_PIOCa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd3_PIOCa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd3_PIOCa_2_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd3_PIOCa_2_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd3_PTRCa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd3_PTRCa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd3_TCTRa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd3_TCTRa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd4_PIOCa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd4_PIOCa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd4_PIOCa_2_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd4_PIOCa_2_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd4_PTRCa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd4_PTRCa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd4_TCTRa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd4_TCTRa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd5_PIOCa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd5_PIOCa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd5_PIOCa_2_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd5_PIOCa_2_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd5_PTRCa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd5_PTRCa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Fd5_TCTRa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Fd5_TCTRa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Tr1_PIOCa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Tr1_PIOCa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Tr1_PTRCa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Tr1_PTRCa_1_EConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_DataConnections', 'a1:LNC_Tr1_TCTRa_1_DConnection').
has_Connections('SympatheticTrip_APP_SubAppNetwork_EventConnections', 'a1:LNC_Tr1_TCTRa_1_EConnection').
has_Connections('Fd1_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd1_PIOCa_1_DConnection').
has_Connections('Fd1_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd1_PIOCa_1_EConnection').
has_Connections('Fd1_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd1_PIOCa_2_DConnection').
has_Connections('Fd1_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd1_PIOCa_2_EConnection').
has_Connections('Fd1_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd1_PTRCa_1_DConnection').
has_Connections('Fd1_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd1_PTRCa_1_EConnection').
has_Connections('Fd1_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd1_TCTRa_1_DConnection').
has_Connections('Fd1_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd1_TCTRa_1_EConnection').
has_Connections('Fd2_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd2_PIOCa_1_DConnection').
has_Connections('Fd2_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd2_PIOCa_1_EConnection').
has_Connections('Fd2_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd2_PIOCa_2_DConnection').
has_Connections('Fd2_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd2_PIOCa_2_EConnection').
has_Connections('Fd2_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd2_PTRCa_1_DConnection').
has_Connections('Fd2_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd2_PTRCa_1_EConnection').
has_Connections('Fd2_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd2_TCTRa_1_DConnection').
has_Connections('Fd2_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd2_TCTRa_1_EConnection').
has_Connections('Fd3_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd3_PIOCa_1_DConnection').
has_Connections('Fd3_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd3_PIOCa_1_EConnection').
has_Connections('Fd3_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd3_PIOCa_2_DConnection').
has_Connections('Fd3_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd3_PIOCa_2_EConnection').
has_Connections('Fd3_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd3_PTRCa_1_DConnection').
has_Connections('Fd3_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd3_PTRCa_1_EConnection').
has_Connections('Fd3_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd3_TCTRa_1_DConnection').
has_Connections('Fd3_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd3_TCTRa_1_EConnection').
has_Connections('Fd4_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd4_PIOCa_1_DConnection').
has_Connections('Fd4_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd4_PIOCa_1_EConnection').
has_Connections('Fd4_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd4_PIOCa_2_DConnection').
has_Connections('Fd4_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd4_PIOCa_2_EConnection').
has_Connections('Fd4_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd4_PTRCa_1_DConnection').
has_Connections('Fd4_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd4_PTRCa_1_EConnection').
has_Connections('Fd4_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd4_TCTRa_1_DConnection').
has_Connections('Fd4_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd4_TCTRa_1_EConnection').
has_Connections('Fd5_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd5_PIOCa_1_DConnection').
has_Connections('Fd5_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd5_PIOCa_1_EConnection').
has_Connections('Fd5_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd5_PIOCa_2_DConnection').
has_Connections('Fd5_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd5_PIOCa_2_EConnection').
has_Connections('Fd5_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd5_PTRCa_1_DConnection').
has_Connections('Fd5_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd5_PTRCa_1_EConnection').
has_Connections('Fd5_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Fd5_TCTRa_1_DConnection').
has_Connections('Fd5_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Fd5_TCTRa_1_EConnection').
has_Connections('Tr1_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Tr1_PIOCa_1_DConnection').
has_Connections('Tr1_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Tr1_PIOCa_1_EConnection').
has_Connections('Tr1_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Tr1_PTRCa_1_DConnection').
has_Connections('Tr1_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Tr1_PTRCa_1_EConnection').
has_Connections('Tr1_S1_C1_FBNetwork_DataConnections', 'DeviceConnections_a1:LNC_Tr1_TCTRa_1_DConnection').
has_Connections('Tr1_S1_C1_FBNetwork_EventConnections', 'DeviceConnections_a1:LNC_Tr1_TCTRa_1_EConnection').
has_Connection_Source('a1:LNC_Fd1_PIOCa_1_DConnection', 'Fd1_PIOCa_1.Op_general').
has_Connection_Source('a1:LNC_Fd1_PIOCa_1_EConnection', 'Fd1_PIOCa_1.PTRCa\n').
has_Connection_Source('a1:LNC_Fd1_PIOCa_2_DConnection', 'Fd1_PIOCa_1.Op_general_inform').
has_Connection_Source('a1:LNC_Fd1_PIOCa_2_EConnection', 'Fd1_PIOCa_1.PTRCa_inform').
has_Connection_Source('a1:LNC_Fd1_PTRCa_1_DConnection', 'Fd1_PTRCa_1.Tr_general').
has_Connection_Source('a1:LNC_Fd1_PTRCa_1_EConnection', 'Fd1_PTRCa_1.XCBRa').
has_Connection_Source('a1:LNC_Fd1_TCTRa_1_DConnection', 'Fd1_TCTRa_1.AmpSv_instMag_f').
has_Connection_Source('a1:LNC_Fd1_TCTRa_1_EConnection', 'Fd1_TCTRa_1.PIOCa').
has_Connection_Source('a1:LNC_Fd2_PIOCa_1_DConnection', 'Fd2_PIOCa_1.Op_general').
has_Connection_Source('a1:LNC_Fd2_PIOCa_1_EConnection', 'Fd2_PIOCa_1.PTRCa').
has_Connection_Source('a1:LNC_Fd2_PIOCa_2_DConnection', 'Fd2_PIOCa_1.Op_general_inform').
has_Connection_Source('a1:LNC_Fd2_PIOCa_2_EConnection', 'Fd2_PIOCa_1.PTRCa_inform').
has_Connection_Source('a1:LNC_Fd2_PTRCa_1_DConnection', 'Fd2_PTRCa_1.Tr_general').
has_Connection_Source('a1:LNC_Fd2_PTRCa_1_EConnection', 'Fd2_PTRCa_1.XCBRa').
has_Connection_Source('a1:LNC_Fd2_TCTRa_1_DConnection', 'Fd2_TCTRa_1.AmpSv_instMag_f').
has_Connection_Source('a1:LNC_Fd2_TCTRa_1_EConnection', 'Fd2_TCTRa_1.PIOCa').
has_Connection_Source('a1:LNC_Fd3_PIOCa_1_DConnection', 'Fd3_PIOCa_1.Op_general').
has_Connection_Source('a1:LNC_Fd3_PIOCa_1_EConnection', 'Fd3_PIOCa_1.PTRCa').
has_Connection_Source('a1:LNC_Fd3_PIOCa_2_DConnection', 'Fd3_PIOCa_1.Op_general_inform').
has_Connection_Source('a1:LNC_Fd3_PIOCa_2_EConnection', 'Fd3_PIOCa_1.PTRCa_inform').
has_Connection_Source('a1:LNC_Fd3_PTRCa_1_DConnection', 'Fd3_PTRCa_1.Tr_general').
has_Connection_Source('a1:LNC_Fd3_PTRCa_1_EConnection', 'Fd3_PTRCa_1.XCBRa').
has_Connection_Source('a1:LNC_Fd3_TCTRa_1_DConnection', 'Fd3_TCTRa_1.AmpSv_instMag_f').
has_Connection_Source('a1:LNC_Fd3_TCTRa_1_EConnection', 'Fd3_TCTRa_1.PIOCa').
has_Connection_Source('a1:LNC_Fd4_PIOCa_1_DConnection', 'Fd4_PIOCa_1.Op_general').
has_Connection_Source('a1:LNC_Fd4_PIOCa_1_EConnection', 'Fd4_PIOCa_1.PTRCa').
has_Connection_Source('a1:LNC_Fd4_PIOCa_2_DConnection', 'Fd4_PIOCa_1.Op_general_inform').
has_Connection_Source('a1:LNC_Fd4_PIOCa_2_EConnection', 'Fd4_PIOCa_1.PTRCa_inform').
has_Connection_Source('a1:LNC_Fd4_PTRCa_1_DConnection', 'Fd4_PTRCa_1.Tr_general').
has_Connection_Source('a1:LNC_Fd4_PTRCa_1_EConnection', 'Fd4_PTRCa_1.XCBRa').
has_Connection_Source('a1:LNC_Fd4_TCTRa_1_DConnection', 'Fd4_TCTRa_1.AmpSv_instMag_f').
has_Connection_Source('a1:LNC_Fd4_TCTRa_1_EConnection', 'Fd4_TCTRa_1.PIOCa').
has_Connection_Source('a1:LNC_Fd5_PIOCa_1_DConnection', 'Fd5_PIOCa_1.Op_general').
has_Connection_Source('a1:LNC_Fd5_PIOCa_1_EConnection', 'Fd5_PIOCa_1.PTRCa').
has_Connection_Source('a1:LNC_Fd5_PIOCa_2_DConnection', 'Fd5_PIOCa_1.Op_general_inform').
has_Connection_Source('a1:LNC_Fd5_PIOCa_2_EConnection', 'Fd5_PIOCa_1.PTRCa_inform').
has_Connection_Source('a1:LNC_Fd5_PTRCa_1_DConnection', 'Fd5_PTRCa_1.Tr_general').
has_Connection_Source('a1:LNC_Fd5_PTRCa_1_EConnection', 'Fd5_PTRCa_1.XCBRa').
has_Connection_Source('a1:LNC_Fd5_TCTRa_1_DConnection', 'Fd5_TCTRa_1.AmpSv_instMag_f').
has_Connection_Source('a1:LNC_Fd5_TCTRa_1_EConnection', 'Fd5_TCTRa_1.PIOCa').
has_Connection_Source('a1:LNC_Tr1_PIOCa_1_DConnection', 'Tr1_PIOCa_1.Op_general').
has_Connection_Source('a1:LNC_Tr1_PIOCa_1_EConnection', 'Tr1_PIOCa_1.PTRCa').
has_Connection_Source('a1:LNC_Tr1_PTRCa_1_DConnection', 'Tr1_PTRCa_1.Tr_general').
has_Connection_Source('a1:LNC_Tr1_PTRCa_1_EConnection', 'Tr1_PTRCa_1.XCBRa').
has_Connection_Source('a1:LNC_Tr1_TCTRa_1_DConnection', 'Tr1_TCTRa_1.AmpSv_instMag_f').
has_Connection_Source('a1:LNC_Tr1_TCTRa_1_EConnection', 'Tr1_TCTRa_1.PIOCa').
has_Connection_Source('DeviceConnections_a1:LNC_Fd1_PIOCa_1_DConnection', 'Fd1_PIOCa_1.Op_general').
has_Connection_Source('DeviceConnections_a1:LNC_Fd1_PIOCa_1_EConnection', 'Fd1_PIOCa_1.PTRCa\n').
has_Connection_Source('DeviceConnections_a1:LNC_Fd1_PIOCa_2_DConnection', 'Fd1_PIOCa_1.Op_general_inform').
has_Connection_Source('DeviceConnections_a1:LNC_Fd1_PIOCa_2_EConnection', 'Fd1_PIOCa_1.PTRCa_inform').
has_Connection_Source('DeviceConnections_a1:LNC_Fd1_PTRCa_1_DConnection', 'Fd1_PTRCa_1.Tr_general').
has_Connection_Source('DeviceConnections_a1:LNC_Fd1_PTRCa_1_EConnection', 'Fd1_PTRCa_1.XCBRa').
has_Connection_Source('DeviceConnections_a1:LNC_Fd1_TCTRa_1_DConnection', 'Fd1_TCTRa_1.AmpSv_instMag_f').
has_Connection_Source('DeviceConnections_a1:LNC_Fd1_TCTRa_1_EConnection', 'Fd1_TCTRa_1.PIOCa').
has_Connection_Source('DeviceConnections_a1:LNC_Fd2_PIOCa_1_DConnection', 'Fd2_PIOCa_1.Op_general').
has_Connection_Source('DeviceConnections_a1:LNC_Fd2_PIOCa_1_EConnection', 'Fd2_PIOCa_1.PTRCa').
has_Connection_Source('DeviceConnections_a1:LNC_Fd2_PIOCa_2_DConnection', 'Fd2_PIOCa_1.Op_general_inform').
has_Connection_Source('DeviceConnections_a1:LNC_Fd2_PIOCa_2_EConnection', 'Fd2_PIOCa_1.PTRCa_inform').
has_Connection_Source('DeviceConnections_a1:LNC_Fd2_PTRCa_1_DConnection', 'Fd2_PTRCa_1.Tr_general').
has_Connection_Source('DeviceConnections_a1:LNC_Fd2_PTRCa_1_EConnection', 'Fd2_PTRCa_1.XCBRa').
has_Connection_Source('DeviceConnections_a1:LNC_Fd2_TCTRa_1_DConnection', 'Fd2_TCTRa_1.AmpSv_instMag_f').
has_Connection_Source('DeviceConnections_a1:LNC_Fd2_TCTRa_1_EConnection', 'Fd2_TCTRa_1.PIOCa').
has_Connection_Source('DeviceConnections_a1:LNC_Fd3_PIOCa_1_DConnection', 'Fd3_PIOCa_1.Op_general').
has_Connection_Source('DeviceConnections_a1:LNC_Fd3_PIOCa_1_EConnection', 'Fd3_PIOCa_1.PTRCa').
has_Connection_Source('DeviceConnections_a1:LNC_Fd3_PIOCa_2_DConnection', 'Fd3_PIOCa_1.Op_general_inform').
has_Connection_Source('DeviceConnections_a1:LNC_Fd3_PIOCa_2_EConnection', 'Fd3_PIOCa_1.PTRCa_inform').
has_Connection_Source('DeviceConnections_a1:LNC_Fd3_PTRCa_1_DConnection', 'Fd3_PTRCa_1.Tr_general').
has_Connection_Source('DeviceConnections_a1:LNC_Fd3_PTRCa_1_EConnection', 'Fd3_PTRCa_1.XCBRa').
has_Connection_Source('DeviceConnections_a1:LNC_Fd3_TCTRa_1_DConnection', 'Fd3_TCTRa_1.AmpSv_instMag_f').
has_Connection_Source('DeviceConnections_a1:LNC_Fd3_TCTRa_1_EConnection', 'Fd3_TCTRa_1.PIOCa').
has_Connection_Source('DeviceConnections_a1:LNC_Fd4_PIOCa_1_DConnection', 'Fd4_PIOCa_1.Op_general').
has_Connection_Source('DeviceConnections_a1:LNC_Fd4_PIOCa_1_EConnection', 'Fd4_PIOCa_1.PTRCa').
has_Connection_Source('DeviceConnections_a1:LNC_Fd4_PIOCa_2_DConnection', 'Fd4_PIOCa_1.Op_general_inform').
has_Connection_Source('DeviceConnections_a1:LNC_Fd4_PIOCa_2_EConnection', 'Fd4_PIOCa_1.PTRCa_inform').
has_Connection_Source('DeviceConnections_a1:LNC_Fd4_PTRCa_1_DConnection', 'Fd4_PTRCa_1.Tr_general').
has_Connection_Source('DeviceConnections_a1:LNC_Fd4_PTRCa_1_EConnection', 'Fd4_PTRCa_1.XCBRa').
has_Connection_Source('DeviceConnections_a1:LNC_Fd4_TCTRa_1_DConnection', 'Fd4_TCTRa_1.AmpSv_instMag_f').
has_Connection_Source('DeviceConnections_a1:LNC_Fd4_TCTRa_1_EConnection', 'Fd4_TCTRa_1.PIOCa').
has_Connection_Source('DeviceConnections_a1:LNC_Fd5_PIOCa_1_DConnection', 'Fd5_PIOCa_1.Op_general').
has_Connection_Source('DeviceConnections_a1:LNC_Fd5_PIOCa_1_EConnection', 'Fd5_PIOCa_1.PTRCa').
has_Connection_Source('DeviceConnections_a1:LNC_Fd5_PIOCa_2_DConnection', 'Fd5_PIOCa_1.Op_general_inform').
has_Connection_Source('DeviceConnections_a1:LNC_Fd5_PIOCa_2_EConnection', 'Fd5_PIOCa_1.PTRCa_inform').
has_Connection_Source('DeviceConnections_a1:LNC_Fd5_PTRCa_1_DConnection', 'Fd5_PTRCa_1.Tr_general').
has_Connection_Source('DeviceConnections_a1:LNC_Fd5_PTRCa_1_EConnection', 'Fd5_PTRCa_1.XCBRa').
has_Connection_Source('DeviceConnections_a1:LNC_Fd5_TCTRa_1_DConnection', 'Fd5_TCTRa_1.AmpSv_instMag_f').
has_Connection_Source('DeviceConnections_a1:LNC_Fd5_TCTRa_1_EConnection', 'Fd5_TCTRa_1.PIOCa').
has_Connection_Source('DeviceConnections_a1:LNC_Tr1_PIOCa_1_DConnection', 'Tr1_PIOCa_1.Op_general').
has_Connection_Source('DeviceConnections_a1:LNC_Tr1_PIOCa_1_EConnection', 'Tr1_PIOCa_1.PTRCa').
has_Connection_Source('DeviceConnections_a1:LNC_Tr1_PTRCa_1_DConnection', 'Tr1_PTRCa_1.Tr_general').
has_Connection_Source('DeviceConnections_a1:LNC_Tr1_PTRCa_1_EConnection', 'Tr1_PTRCa_1.XCBRa').
has_Connection_Source('DeviceConnections_a1:LNC_Tr1_TCTRa_1_DConnection', 'Tr1_TCTRa_1.AmpSv_instMag_f').
has_Connection_Source('DeviceConnections_a1:LNC_Tr1_TCTRa_1_EConnection', 'Tr1_TCTRa_1.PIOCa').
has_Connection_Destination('a1:LNC_Fd1_PIOCa_1_DConnection', 'Fd1_PTRCa_1.Op_general').
has_Connection_Destination('a1:LNC_Fd1_PIOCa_1_EConnection', 'Fd1_PTRCa_1.PIOCa').
has_Connection_Destination('a1:LNC_Fd1_PIOCa_2_DConnection', 'Tr1_PTRCa_1.Op_general_F1').
has_Connection_Destination('a1:LNC_Fd1_PIOCa_2_EConnection', 'Tr1_PTRCa_1.PIOCa_external').
has_Connection_Destination('a1:LNC_Fd1_PTRCa_1_DConnection', 'Fd1_XCBRa_1.Tr_general').
has_Connection_Destination('a1:LNC_Fd1_PTRCa_1_EConnection', 'Fd1_XCBRa_1.PIOCa').
has_Connection_Destination('a1:LNC_Fd1_TCTRa_1_DConnection', 'Fd1_PIOCa_1.AmpSv_instMag_f').
has_Connection_Destination('a1:LNC_Fd1_TCTRa_1_EConnection', 'Fd1_PIOCa_1.TCTRa').
has_Connection_Destination('a1:LNC_Fd2_PIOCa_1_DConnection', 'Fd2_PTRCa_1.Op_general').
has_Connection_Destination('a1:LNC_Fd2_PIOCa_1_EConnection', 'Fd2_PTRCa_1.PIOCa').
has_Connection_Destination('a1:LNC_Fd2_PIOCa_2_DConnection', 'Tr1_PTRCa_1.Op_general_F2').
has_Connection_Destination('a1:LNC_Fd2_PIOCa_2_EConnection', 'Tr1_PTRCa_1.Fd2_PIOCa_1').
has_Connection_Destination('a1:LNC_Fd2_PTRCa_1_DConnection', 'Fd2_XCBRa_1.Tr_general').
has_Connection_Destination('a1:LNC_Fd2_PTRCa_1_EConnection', 'Fd2_XCBRa_1.PIOCa').
has_Connection_Destination('a1:LNC_Fd2_TCTRa_1_DConnection', 'Fd2_PIOCa_1.AmpSv_instMag_f').
has_Connection_Destination('a1:LNC_Fd2_TCTRa_1_EConnection', 'Fd2_PIOCa_1.TCTRa').
has_Connection_Destination('a1:LNC_Fd3_PIOCa_1_DConnection', 'Fd3_PTRCa_1.Op_general').
has_Connection_Destination('a1:LNC_Fd3_PIOCa_1_EConnection', 'Fd3_PTRCa_1.PIOCa').
has_Connection_Destination('a1:LNC_Fd3_PIOCa_2_DConnection', 'Tr1_PTRCa_1.Op_general_F3').
has_Connection_Destination('a1:LNC_Fd3_PIOCa_2_EConnection', 'Tr1_PTRCa_1.PIOCa_external').
has_Connection_Destination('a1:LNC_Fd3_PTRCa_1_DConnection', 'Fd3_XCBRa_1.Tr_general').
has_Connection_Destination('a1:LNC_Fd3_PTRCa_1_EConnection', 'Fd3_XCBRa_1.PIOCa').
has_Connection_Destination('a1:LNC_Fd3_TCTRa_1_DConnection', 'Fd3_PIOCa_1.AmpSv_instMag_f').
has_Connection_Destination('a1:LNC_Fd3_TCTRa_1_EConnection', 'Fd3_PIOCa_1.TCTRa').
has_Connection_Destination('a1:LNC_Fd4_PIOCa_1_DConnection', 'Fd4_PTRCa_1.Op_general').
has_Connection_Destination('a1:LNC_Fd4_PIOCa_1_EConnection', 'Fd4_PTRCa_1.PIOCa').
has_Connection_Destination('a1:LNC_Fd4_PIOCa_2_DConnection', 'Tr1_PTRCa_1.Op_general_F4').
has_Connection_Destination('a1:LNC_Fd4_PIOCa_2_EConnection', 'Tr1_PTRCa_1.PIOCa_external').
has_Connection_Destination('a1:LNC_Fd4_PTRCa_1_DConnection', 'Fd4_XCBRa_1.Tr_general').
has_Connection_Destination('a1:LNC_Fd4_PTRCa_1_EConnection', 'Fd4_XCBRa_1.PIOCa').
has_Connection_Destination('a1:LNC_Fd4_TCTRa_1_DConnection', 'Fd4_PIOCa_1.AmpSv_instMag_f').
has_Connection_Destination('a1:LNC_Fd4_TCTRa_1_EConnection', 'Fd4_PIOCa_1.TCTRa').
has_Connection_Destination('a1:LNC_Fd5_PIOCa_1_DConnection', 'Fd5_PTRCa_1.Op_general').
has_Connection_Destination('a1:LNC_Fd5_PIOCa_1_EConnection', 'Fd5_PTRCa_1.PIOCa').
has_Connection_Destination('a1:LNC_Fd5_PIOCa_2_DConnection', 'Tr1_PTRCa_1.Op_general_F5').
has_Connection_Destination('a1:LNC_Fd5_PIOCa_2_EConnection', 'Tr1_PTRCa_1.PIOCa_external').
has_Connection_Destination('a1:LNC_Fd5_PTRCa_1_DConnection', 'Fd5_XCBRa_1.Tr_general').
has_Connection_Destination('a1:LNC_Fd5_PTRCa_1_EConnection', 'Fd5_XCBRa_1.PIOCa').
has_Connection_Destination('a1:LNC_Fd5_TCTRa_1_DConnection', 'Fd5_PIOCa_1.AmpSv_instMag_f').
has_Connection_Destination('a1:LNC_Fd5_TCTRa_1_EConnection', 'Fd5_PIOCa_1.TCTRa').
has_Connection_Destination('a1:LNC_Tr1_PIOCa_1_DConnection', 'Tr1_PTRCa_1.Op_general').
has_Connection_Destination('a1:LNC_Tr1_PIOCa_1_EConnection', 'Tr1_PTRCa_1.PIOCa').
has_Connection_Destination('a1:LNC_Tr1_PTRCa_1_DConnection', 'Tr1_XCBRa_1.Tr_general').
has_Connection_Destination('a1:LNC_Tr1_PTRCa_1_EConnection', 'Tr1_XCBRa_1.PIOCa').
has_Connection_Destination('a1:LNC_Tr1_TCTRa_1_DConnection', 'Tr1_PIOCa_1.AmpSv_instMag_f').
has_Connection_Destination('a1:LNC_Tr1_TCTRa_1_EConnection', 'Tr1_PIOCa_1.TCTRa').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd1_PIOCa_1_DConnection', 'Fd1_PTRCa_1.Op_general').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd1_PIOCa_1_EConnection', 'Fd1_PTRCa_1.PIOCa').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd1_PIOCa_2_DConnection', 'Tr1_PTRCa_1.Op_general_F1').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd1_PIOCa_2_EConnection', 'Tr1_PTRCa_1.PIOCa_external').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd1_PTRCa_1_DConnection', 'Fd1_XCBRa_1.Tr_general').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd1_PTRCa_1_EConnection', 'Fd1_XCBRa_1.PIOCa').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd1_TCTRa_1_DConnection', 'Fd1_PIOCa_1.AmpSv_instMag_f').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd1_TCTRa_1_EConnection', 'Fd1_PIOCa_1.TCTRa').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd2_PIOCa_1_DConnection', 'Fd2_PTRCa_1.Op_general').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd2_PIOCa_1_EConnection', 'Fd2_PTRCa_1.PIOCa').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd2_PIOCa_2_DConnection', 'Tr1_PTRCa_1.Op_general_F2').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd2_PIOCa_2_EConnection', 'Tr1_PTRCa_1.Fd2_PIOCa_1').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd2_PTRCa_1_DConnection', 'Fd2_XCBRa_1.Tr_general').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd2_PTRCa_1_EConnection', 'Fd2_XCBRa_1.PIOCa').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd2_TCTRa_1_DConnection', 'Fd2_PIOCa_1.AmpSv_instMag_f').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd2_TCTRa_1_EConnection', 'Fd2_PIOCa_1.TCTRa').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd3_PIOCa_1_DConnection', 'Fd3_PTRCa_1.Op_general').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd3_PIOCa_1_EConnection', 'Fd3_PTRCa_1.PIOCa').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd3_PIOCa_2_DConnection', 'Tr1_PTRCa_1.Op_general_F3').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd3_PIOCa_2_EConnection', 'Tr1_PTRCa_1.PIOCa_external').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd3_PTRCa_1_DConnection', 'Fd3_XCBRa_1.Tr_general').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd3_PTRCa_1_EConnection', 'Fd3_XCBRa_1.PIOCa').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd3_TCTRa_1_DConnection', 'Fd3_PIOCa_1.AmpSv_instMag_f').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd3_TCTRa_1_EConnection', 'Fd3_PIOCa_1.TCTRa').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd4_PIOCa_1_DConnection', 'Fd4_PTRCa_1.Op_general').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd4_PIOCa_1_EConnection', 'Fd4_PTRCa_1.PIOCa').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd4_PIOCa_2_DConnection', 'Tr1_PTRCa_1.Op_general_F4').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd4_PIOCa_2_EConnection', 'Tr1_PTRCa_1.PIOCa_external').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd4_PTRCa_1_DConnection', 'Fd4_XCBRa_1.Tr_general').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd4_PTRCa_1_EConnection', 'Fd4_XCBRa_1.PIOCa').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd4_TCTRa_1_DConnection', 'Fd4_PIOCa_1.AmpSv_instMag_f').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd4_TCTRa_1_EConnection', 'Fd4_PIOCa_1.TCTRa').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd5_PIOCa_1_DConnection', 'Fd5_PTRCa_1.Op_general').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd5_PIOCa_1_EConnection', 'Fd5_PTRCa_1.PIOCa').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd5_PIOCa_2_DConnection', 'Tr1_PTRCa_1.Op_general_F5').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd5_PIOCa_2_EConnection', 'Tr1_PTRCa_1.PIOCa_external').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd5_PTRCa_1_DConnection', 'Fd5_XCBRa_1.Tr_general').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd5_PTRCa_1_EConnection', 'Fd5_XCBRa_1.PIOCa').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd5_TCTRa_1_DConnection', 'Fd5_PIOCa_1.AmpSv_instMag_f').
has_Connection_Destination('DeviceConnections_a1:LNC_Fd5_TCTRa_1_EConnection', 'Fd5_PIOCa_1.TCTRa').
has_Connection_Destination('DeviceConnections_a1:LNC_Tr1_PIOCa_1_DConnection', 'Tr1_PTRCa_1.Op_general').
has_Connection_Destination('DeviceConnections_a1:LNC_Tr1_PIOCa_1_EConnection', 'Tr1_PTRCa_1.PIOCa').
has_Connection_Destination('DeviceConnections_a1:LNC_Tr1_PTRCa_1_DConnection', 'Tr1_XCBRa_1.Tr_general').
has_Connection_Destination('DeviceConnections_a1:LNC_Tr1_PTRCa_1_EConnection', 'Tr1_XCBRa_1.PIOCa').
has_Connection_Destination('DeviceConnections_a1:LNC_Tr1_TCTRa_1_DConnection', 'Tr1_PIOCa_1.AmpSv_instMag_f').
has_Connection_Destination('DeviceConnections_a1:LNC_Tr1_TCTRa_1_EConnection', 'Tr1_PIOCa_1.TCTRa').