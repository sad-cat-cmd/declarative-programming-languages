/* Programs for structural analysis of the generated ontological representation of FB systems */
/* ------------------------------------------------------------------------------------------ */

/* Enumerate all FBs which are (are not) in cycles */

write_fb_in_cycle:- 
writeln("---------------------------------------------------"), 
writeln("info about function blocks in cycles"), 
writeln("----------------------------------------------------"),
dynamic('functionblock'/1), 'functionblock'(fb), hasname(fb, namefb), writeln(" ###"), write("fb name: "), string_concat(namefb, "/", n1), string_concat(n1, fb, n2), write(n2), write(": "), 
write_fb_status(fb), fail.
Write_fb_in_cycle.

Write_fb_status(fb):- cycle(fb), write("in cycle"), !.
Write_fb_status(fb):- write("no").

Cycle(x) :-
  cycle(x, []).

Cycle(curr , visited) :-
  member(curr, visited),
  !. 
Cycle(curr , visited) :-
  edge(curr , next),
  cycle(next , [curr|visited]).

Edge(fb1,fb2):- 'functionblock'(fb1), 'functionblock'(fb2), 'eventinput'(ei), 'eventoutput'(eo), is_part_of_fb(ei,fb2), is_part_of_fb(eo,fb1), e_connect_to(eo,ei).


/* Construct and print a reachability relation between FBs by means event connections */

Write_event_reachability(n):- 
writeln("---------------------------------------------------"), 
writeln("event reachability"), 
writeln("----------------------------------------------------"),
dynamic('functionblock'/1), 'functionblock'(fb1), 'functionblock'(fb2),
hasname(fb1, namefb1), hasname(fb2, namefb2),   path(fb1,fb2,l), l>=n, writeln(" ###"),
write("there is a path from fb : "), string_concat(namefb1, "/", n1), string_concat(n1, fb1, n2), write(n2), write(" to fb : "), string_concat(namefb2, "/", l1), string_concat(l1, fb2, l2), write(l2),
write("  length of path = "), write(l),
fail.
Write_event_reachability(_).

Path(x,y,1):- arc(x,y),!.
Path(x,y,l):- arc(x,z), path(z,y,l2), l is l2+1, !.

Arc(fb1,fb2):- 'functionblock'(fb1), 'functionblock'(fb2), 'eventinput'(ei), 'eventoutput'(eo), is_part_of_fb(ei,fb2), is_part_of_fb(eo,fb1), e_connect_to(eo,ei),!.


/* Enumeration of event paths between two fb */

path2(sourcefb, destinationfb, visitedfb) :-
  member(destinationfb, visitedfb),
  !. 
Path2(sourcefb, destinationfb, visitedfb) :-
  edge(sourcefb, nextfb),
  cycle(nextfb, [sourcefb|visitedfb]).



/* ---------------------------------------------------------------------------------- */
/* ------------------------ The generated IEC 61499 ontology ------------------------ */
/* ---------------------------------------------------------------------------------- */

:- Dynamic'functionblock'/1.

'Functionblock'(i20).
'Functionblock'(i23).
'Functionblock'(i26).
'Functionblock'(i29).
'Functionblock'(i32).
'Functionblock'(i35).
'Functionblock'(i38).
'Functionblock'(i41).
'Functionblock'(i44).
'Functionblock'(i47).
'Functionblock'(i50).
'Functionblock'(i53).
'Functionblock'(i56).
'Functionblock'(i59).
'Functionblock'(i62).
'Functionblock'(i65).
'Functionblock'(i68).
'Functionblock'(i71).
'Functionblock'(i74).
'Functionblock'(i77).

:- Dynamic'eventoutput'/1.

'Eventoutput'(i21).
'Eventoutput'(i24).
'Eventoutput'(i27).
'Eventoutput'(i30).
'Eventoutput'(i33).
'Eventoutput'(i36).
'Eventoutput'(i39).
'Eventoutput'(i42).
'Eventoutput'(i45).
'Eventoutput'(i48).
'Eventoutput'(i51).
'Eventoutput'(i54).
'Eventoutput'(i57).
'Eventoutput'(i60).
'Eventoutput'(i63).
'Eventoutput'(i66).
'Eventoutput'(i69).
'Eventoutput'(i72).
'Eventoutput'(i75).
'Eventoutput'(i78).
'Eventoutput'(i80).
'Eventoutput'(i84).
'Eventoutput'(i88).
'Eventoutput'(i92).
'Eventoutput'(i96).
'Eventoutput'(i100).
'Eventoutput'(i104).
'Eventoutput'(i108).
'Eventoutput'(i112).
'Eventoutput'(i116).
'Eventoutput'(i120).
'Eventoutput'(i124).
'Eventoutput'(i128).
'Eventoutput'(i132).
'Eventoutput'(i136).
'Eventoutput'(i140).
'Eventoutput'(i144).
'Eventoutput'(i148).
'Eventoutput'(i152).
'Eventoutput'(i156).
'Eventoutput'(i160).
'Eventoutput'(i164).
'Eventoutput'(i168).
'Eventoutput'(i172).
'Eventoutput'(i176).
'Eventoutput'(i180).
'Eventoutput'(i184).
'Eventoutput'(i188).
'Eventoutput'(i192).
'Eventoutput'(i196).
'Eventoutput'(i200).
'Eventoutput'(i204).
'Eventoutput'(i208).
'Eventoutput'(i212).
'Eventoutput'(i216).

:- Dynamic'eventinput'/1.

'Eventinput'(i22).
'Eventinput'(i25).
'Eventinput'(i28).
'Eventinput'(i31).
'Eventinput'(i34).
'Eventinput'(i37).
'Eventinput'(i40).
'Eventinput'(i43).
'Eventinput'(i46).
'Eventinput'(i49).
'Eventinput'(i52).
'Eventinput'(i55).
'Eventinput'(i58).
'Eventinput'(i61).
'Eventinput'(i64).
'Eventinput'(i67).
'Eventinput'(i70).
'Eventinput'(i73).
'Eventinput'(i76).
'Eventinput'(i79).
'Eventinput'(i81).
'Eventinput'(i85).
'Eventinput'(i89).
'Eventinput'(i93).
'Eventinput'(i97).
'Eventinput'(i101).
'Eventinput'(i105).
'Eventinput'(i109).
'Eventinput'(i113).
'Eventinput'(i117).
'Eventinput'(i121).
'Eventinput'(i125).
'Eventinput'(i129).
'Eventinput'(i133).
'Eventinput'(i137).
'Eventinput'(i141).
'Eventinput'(i145).
'Eventinput'(i149).
'Eventinput'(i153).
'Eventinput'(i157).
'Eventinput'(i161).
'Eventinput'(i165).
'Eventinput'(i169).
'Eventinput'(i173).
'Eventinput'(i177).
'Eventinput'(i181).
'Eventinput'(i185).
'Eventinput'(i189).
'Eventinput'(i193).
'Eventinput'(i197).
'Eventinput'(i201).
'Eventinput'(i205).
'Eventinput'(i209).
'Eventinput'(i213).
'Eventinput'(i217).

:- Dynamic'outputvariable'/1.

'Outputvariable'(i82).
'Outputvariable'(i86).
'Outputvariable'(i90).
'Outputvariable'(i94).
'Outputvariable'(i98).
'Outputvariable'(i102).
'Outputvariable'(i106).
'Outputvariable'(i110).
'Outputvariable'(i114).
'Outputvariable'(i118).
'Outputvariable'(i122).
'Outputvariable'(i126).
'Outputvariable'(i130).
'Outputvariable'(i134).
'Outputvariable'(i138).
'Outputvariable'(i142).
'Outputvariable'(i146).
'Outputvariable'(i150).
'Outputvariable'(i154).
'Outputvariable'(i158).
'Outputvariable'(i162).
'Outputvariable'(i166).
'Outputvariable'(i170).
'Outputvariable'(i174).
'Outputvariable'(i178).
'Outputvariable'(i182).
'Outputvariable'(i186).
'Outputvariable'(i190).
'Outputvariable'(i194).
'Outputvariable'(i198).
'Outputvariable'(i202).
'Outputvariable'(i206).
'Outputvariable'(i210).
'Outputvariable'(i214).
'Outputvariable'(i218).

:- Dynamic'inputvariable'/1.

'Inputvariable'(i83).
'Inputvariable'(i87).
'Inputvariable'(i91).
'Inputvariable'(i95).
'Inputvariable'(i99).
'Inputvariable'(i103).
'Inputvariable'(i107).
'Inputvariable'(i111).
'Inputvariable'(i115).
'Inputvariable'(i119).
'Inputvariable'(i123).
'Inputvariable'(i127).
'Inputvariable'(i131).
'Inputvariable'(i135).
'Inputvariable'(i139).
'Inputvariable'(i143).
'Inputvariable'(i147).
'Inputvariable'(i151).
'Inputvariable'(i155).
'Inputvariable'(i159).
'Inputvariable'(i163).
'Inputvariable'(i167).
'Inputvariable'(i171).
'Inputvariable'(i175).
'Inputvariable'(i179).
'Inputvariable'(i183).
'Inputvariable'(i187).
'Inputvariable'(i191).
'Inputvariable'(i195).
'Inputvariable'(i199).
'Inputvariable'(i203).
'Inputvariable'(i207).
'Inputvariable'(i211).
'Inputvariable'(i215).
'Inputvariable'(i219).

:- Dynamic'structuretype'/1.

'Structuretype'(i1).
'Structuretype'(i2).
'Structuretype'(i3).
'Structuretype'(i4).

:- Dynamic'structuretypevariable'/1.

'Structuretypevariable'(i5).
'Structuretypevariable'(i6).

:- Dynamic is_part_of_fb/2.

Is_part_of_fb(i21, i20).
Is_part_of_fb(i22, i20).
Is_part_of_fb(i24, i23).
Is_part_of_fb(i25, i23).
Is_part_of_fb(i27, i26).
Is_part_of_fb(i28, i26).
Is_part_of_fb(i30, i29).
Is_part_of_fb(i31, i29).
Is_part_of_fb(i33, i32).
Is_part_of_fb(i34, i32).
Is_part_of_fb(i36, i35).
Is_part_of_fb(i37, i35).
Is_part_of_fb(i39, i38).
Is_part_of_fb(i40, i38).
Is_part_of_fb(i42, i41).
Is_part_of_fb(i43, i41).
Is_part_of_fb(i45, i44).
Is_part_of_fb(i46, i44).
Is_part_of_fb(i48, i47).
Is_part_of_fb(i49, i47).
Is_part_of_fb(i51, i50).
Is_part_of_fb(i52, i50).
Is_part_of_fb(i54, i53).
Is_part_of_fb(i55, i53).
Is_part_of_fb(i57, i56).
Is_part_of_fb(i58, i56).
Is_part_of_fb(i60, i59).
Is_part_of_fb(i61, i59).
Is_part_of_fb(i63, i62).
Is_part_of_fb(i64, i62).
Is_part_of_fb(i66, i65).
Is_part_of_fb(i67, i65).
Is_part_of_fb(i69, i68).
Is_part_of_fb(i70, i68).
Is_part_of_fb(i72, i71).
Is_part_of_fb(i73, i71).
Is_part_of_fb(i75, i74).
Is_part_of_fb(i76, i74).
Is_part_of_fb(i78, i77).
Is_part_of_fb(i79, i77).
Is_part_of_fb(i82, i20).
Is_part_of_fb(i80, i20).
Is_part_of_fb(i81, i23).
Is_part_of_fb(i83, i23).
Is_part_of_fb(i86, i23).
Is_part_of_fb(i84, i23).
Is_part_of_fb(i85, i29).
Is_part_of_fb(i87, i29).
Is_part_of_fb(i90, i23).
Is_part_of_fb(i88, i23).
Is_part_of_fb(i89, i32).
Is_part_of_fb(i91, i32).
Is_part_of_fb(i94, i23).
Is_part_of_fb(i92, i23).
Is_part_of_fb(i93, i44).
Is_part_of_fb(i95, i44).
Is_part_of_fb(i98, i23).
Is_part_of_fb(i96, i23).
Is_part_of_fb(i97, i56).
Is_part_of_fb(i99, i56).
Is_part_of_fb(i102, i23).
Is_part_of_fb(i100, i23).
Is_part_of_fb(i101, i68).
Is_part_of_fb(i103, i68).
Is_part_of_fb(i106, i26).
Is_part_of_fb(i104, i26).
Is_part_of_fb(i105, i20).
Is_part_of_fb(i107, i20).
Is_part_of_fb(i110, i32).
Is_part_of_fb(i108, i32).
Is_part_of_fb(i109, i35).
Is_part_of_fb(i111, i35).
Is_part_of_fb(i114, i35).
Is_part_of_fb(i112, i35).
Is_part_of_fb(i113, i20).
Is_part_of_fb(i115, i20).
Is_part_of_fb(i118, i35).
Is_part_of_fb(i116, i35).
Is_part_of_fb(i117, i41).
Is_part_of_fb(i119, i41).
Is_part_of_fb(i122, i35).
Is_part_of_fb(i120, i35).
Is_part_of_fb(i121, i44).
Is_part_of_fb(i123, i44).
Is_part_of_fb(i126, i35).
Is_part_of_fb(i124, i35).
Is_part_of_fb(i125, i56).
Is_part_of_fb(i127, i56).
Is_part_of_fb(i130, i35).
Is_part_of_fb(i128, i35).
Is_part_of_fb(i129, i68).
Is_part_of_fb(i131, i68).
Is_part_of_fb(i134, i38).
Is_part_of_fb(i132, i38).
Is_part_of_fb(i133, i32).
Is_part_of_fb(i135, i32).
Is_part_of_fb(i138, i44).
Is_part_of_fb(i136, i44).
Is_part_of_fb(i137, i47).
Is_part_of_fb(i139, i47).
Is_part_of_fb(i142, i47).
Is_part_of_fb(i140, i47).
Is_part_of_fb(i141, i20).
Is_part_of_fb(i143, i20).
Is_part_of_fb(i146, i47).
Is_part_of_fb(i144, i47).
Is_part_of_fb(i145, i32).
Is_part_of_fb(i147, i32).
Is_part_of_fb(i150, i47).
Is_part_of_fb(i148, i47).
Is_part_of_fb(i149, i53).
Is_part_of_fb(i151, i53).
Is_part_of_fb(i154, i47).
Is_part_of_fb(i152, i47).
Is_part_of_fb(i153, i56).
Is_part_of_fb(i155, i56).
Is_part_of_fb(i158, i47).
Is_part_of_fb(i156, i47).
Is_part_of_fb(i157, i68).
Is_part_of_fb(i159, i68).
Is_part_of_fb(i162, i50).
Is_part_of_fb(i160, i50).
Is_part_of_fb(i161, i44).
Is_part_of_fb(i163, i44).
Is_part_of_fb(i166, i56).
Is_part_of_fb(i164, i56).
Is_part_of_fb(i165, i59).
Is_part_of_fb(i167, i59).
Is_part_of_fb(i170, i59).
Is_part_of_fb(i168, i59).
Is_part_of_fb(i169, i20).
Is_part_of_fb(i171, i20).
Is_part_of_fb(i174, i59).
Is_part_of_fb(i172, i59).
Is_part_of_fb(i173, i32).
Is_part_of_fb(i175, i32).
Is_part_of_fb(i178, i59).
Is_part_of_fb(i176, i59).
Is_part_of_fb(i177, i44).
Is_part_of_fb(i179, i44).
Is_part_of_fb(i182, i59).
Is_part_of_fb(i180, i59).
Is_part_of_fb(i181, i65).
Is_part_of_fb(i183, i65).
Is_part_of_fb(i186, i59).
Is_part_of_fb(i184, i59).
Is_part_of_fb(i185, i68).
Is_part_of_fb(i187, i68).
Is_part_of_fb(i190, i62).
Is_part_of_fb(i188, i62).
Is_part_of_fb(i189, i56).
Is_part_of_fb(i191, i56).
Is_part_of_fb(i194, i68).
Is_part_of_fb(i192, i68).
Is_part_of_fb(i193, i71).
Is_part_of_fb(i195, i71).
Is_part_of_fb(i198, i71).
Is_part_of_fb(i196, i71).
Is_part_of_fb(i197, i29).
Is_part_of_fb(i199, i29).
Is_part_of_fb(i202, i71).
Is_part_of_fb(i200, i71).
Is_part_of_fb(i201, i41).
Is_part_of_fb(i203, i41).
Is_part_of_fb(i206, i71).
Is_part_of_fb(i204, i71).
Is_part_of_fb(i205, i53).
Is_part_of_fb(i207, i53).
Is_part_of_fb(i210, i71).
Is_part_of_fb(i208, i71).
Is_part_of_fb(i209, i65).
Is_part_of_fb(i211, i65).
Is_part_of_fb(i214, i71).
Is_part_of_fb(i212, i71).
Is_part_of_fb(i213, i77).
Is_part_of_fb(i215, i77).
Is_part_of_fb(i218, i74).
Is_part_of_fb(i216, i74).
Is_part_of_fb(i217, i68).
Is_part_of_fb(i219, i68).

:- Dynamic e_connect_to/2.

E_connect_to(i80, i81).
E_connect_to(i84, i85).
E_connect_to(i88, i89).
E_connect_to(i92, i93).
E_connect_to(i96, i97).
E_connect_to(i100, i101).
E_connect_to(i104, i105).
E_connect_to(i108, i109).
E_connect_to(i112, i113).
E_connect_to(i116, i117).
E_connect_to(i120, i121).
E_connect_to(i124, i125).
E_connect_to(i128, i129).
E_connect_to(i132, i133).
E_connect_to(i136, i137).
E_connect_to(i140, i141).
E_connect_to(i144, i145).
E_connect_to(i148, i149).
E_connect_to(i152, i153).
E_connect_to(i156, i157).
E_connect_to(i160, i161).
E_connect_to(i164, i165).
E_connect_to(i168, i169).
E_connect_to(i172, i173).
E_connect_to(i176, i177).
E_connect_to(i180, i181).
E_connect_to(i184, i185).
E_connect_to(i188, i189).
E_connect_to(i192, i193).
E_connect_to(i196, i197).
E_connect_to(i200, i201).
E_connect_to(i204, i205).
E_connect_to(i208, i209).
E_connect_to(i212, i213).
E_connect_to(i216, i217).

:- Dynamic d_connect_to/2.

D_connect_to(i82, i83).
D_connect_to(i86, i87).
D_connect_to(i90, i91).
D_connect_to(i94, i95).
D_connect_to(i98, i99).
D_connect_to(i102, i103).
D_connect_to(i106, i107).
D_connect_to(i110, i111).
D_connect_to(i114, i115).
D_connect_to(i118, i119).
D_connect_to(i122, i123).
D_connect_to(i126, i127).
D_connect_to(i130, i131).
D_connect_to(i134, i135).
D_connect_to(i138, i139).
D_connect_to(i142, i143).
D_connect_to(i146, i147).
D_connect_to(i150, i151).
D_connect_to(i154, i155).
D_connect_to(i158, i159).
D_connect_to(i162, i163).
D_connect_to(i166, i167).
D_connect_to(i170, i171).
D_connect_to(i174, i175).
D_connect_to(i178, i179).
D_connect_to(i182, i183).
D_connect_to(i186, i187).
D_connect_to(i190, i191).
D_connect_to(i194, i195).
D_connect_to(i198, i199).
D_connect_to(i202, i203).
D_connect_to(i206, i207).
D_connect_to(i210, i211).
D_connect_to(i214, i215).
D_connect_to(i218, i219).

:- Dynamic is_with_event/2.

Is_with_event(i83, i81).
Is_with_event(i82, i80).
Is_with_event(i87, i85).
Is_with_event(i86, i84).
Is_with_event(i91, i89).
Is_with_event(i90, i88).
Is_with_event(i95, i93).
Is_with_event(i94, i92).
Is_with_event(i99, i97).
Is_with_event(i98, i96).
Is_with_event(i103, i101).
Is_with_event(i102, i100).
Is_with_event(i107, i105).
Is_with_event(i106, i104).
Is_with_event(i111, i109).
Is_with_event(i110, i108).
Is_with_event(i115, i113).
Is_with_event(i114, i112).
Is_with_event(i119, i117).
Is_with_event(i118, i116).
Is_with_event(i123, i121).
Is_with_event(i122, i120).
Is_with_event(i127, i125).
Is_with_event(i126, i124).
Is_with_event(i131, i129).
Is_with_event(i130, i128).
Is_with_event(i135, i133).
Is_with_event(i134, i132).
Is_with_event(i139, i137).
Is_with_event(i138, i136).
Is_with_event(i143, i141).
Is_with_event(i142, i140).
Is_with_event(i147, i145).
Is_with_event(i146, i144).
Is_with_event(i151, i149).
Is_with_event(i150, i148).
Is_with_event(i155, i153).
Is_with_event(i154, i152).
Is_with_event(i159, i157).
Is_with_event(i158, i156).
Is_with_event(i163, i161).
Is_with_event(i162, i160).
Is_with_event(i167, i165).
Is_with_event(i166, i164).
Is_with_event(i171, i169).
Is_with_event(i170, i168).
Is_with_event(i175, i173).
Is_with_event(i174, i172).
Is_with_event(i179, i177).
Is_with_event(i178, i176).
Is_with_event(i183, i181).
Is_with_event(i182, i180).
Is_with_event(i187, i185).
Is_with_event(i186, i184).
Is_with_event(i191, i189).
Is_with_event(i190, i188).
Is_with_event(i195, i193).
Is_with_event(i194, i192).
Is_with_event(i199, i197).
Is_with_event(i198, i196).
Is_with_event(i203, i201).
Is_with_event(i202, i200).
Is_with_event(i207, i205).
Is_with_event(i206, i204).
Is_with_event(i211, i209).
Is_with_event(i210, i208).
Is_with_event(i215, i213).
Is_with_event(i214, i212).
Is_with_event(i219, i217).
Is_with_event(i218, i216).

:- Dynamic is_mapped_to/2.

Is_mapped_to(i20, i15).
Is_mapped_to(i23, i15).
Is_mapped_to(i26, i15).
Is_mapped_to(i29, i15).
Is_mapped_to(i32, i16).
Is_mapped_to(i35, i16).
Is_mapped_to(i38, i16).
Is_mapped_to(i41, i16).
Is_mapped_to(i44, i17).
Is_mapped_to(i47, i17).
Is_mapped_to(i50, i17).
Is_mapped_to(i53, i17).
Is_mapped_to(i56, i18).
Is_mapped_to(i59, i18).
Is_mapped_to(i62, i18).
Is_mapped_to(i65, i18).
Is_mapped_to(i68, i19).
Is_mapped_to(i71, i19).
Is_mapped_to(i74, i19).
Is_mapped_to(i77, i19).

:- Dynamic has_structurevar/2.

Has_structurevar(i1, i5).
Has_structurevar(i4, i6).

:- Dynamic has_var_type/2.

Has_var_type(i5, 'boolean').
Has_var_type(i6, 'analoguevalue_1').
Has_var_type(i82, 'boolean').
Has_var_type(i83, 'boolean').
Has_var_type(i86, 'boolean').
Has_var_type(i87, 'boolean').
Has_var_type(i90, 'boolean').
Has_var_type(i91, 'boolean').
Has_var_type(i94, 'boolean').
Has_var_type(i95, 'boolean').
Has_var_type(i98, 'boolean').
Has_var_type(i99, 'boolean').
Has_var_type(i102, 'boolean').
Has_var_type(i103, 'boolean').
Has_var_type(i106, 'real').
Has_var_type(i107, 'real').
Has_var_type(i110, 'boolean').
Has_var_type(i111, 'boolean').
Has_var_type(i114, 'boolean').
Has_var_type(i115, 'boolean').
Has_var_type(i118, 'boolean').
Has_var_type(i119, 'boolean').
Has_var_type(i122, 'boolean').
Has_var_type(i123, 'boolean').
Has_var_type(i126, 'boolean').
Has_var_type(i127, 'boolean').
Has_var_type(i130, 'boolean').
Has_var_type(i131, 'boolean').
Has_var_type(i134, 'real').
Has_var_type(i135, 'real').
Has_var_type(i138, 'boolean').
Has_var_type(i139, 'boolean').
Has_var_type(i142, 'boolean').
Has_var_type(i143, 'boolean').
Has_var_type(i146, 'boolean').
Has_var_type(i147, 'boolean').
Has_var_type(i150, 'boolean').
Has_var_type(i151, 'boolean').
Has_var_type(i154, 'boolean').
Has_var_type(i155, 'boolean').
Has_var_type(i158, 'boolean').
Has_var_type(i159, 'boolean').
Has_var_type(i162, 'real').
Has_var_type(i163, 'real').
Has_var_type(i166, 'boolean').
Has_var_type(i167, 'boolean').
Has_var_type(i170, 'boolean').
Has_var_type(i171, 'boolean').
Has_var_type(i174, 'boolean').
Has_var_type(i175, 'boolean').
Has_var_type(i178, 'boolean').
Has_var_type(i179, 'boolean').
Has_var_type(i182, 'boolean').
Has_var_type(i183, 'boolean').
Has_var_type(i186, 'boolean').
Has_var_type(i187, 'boolean').
Has_var_type(i190, 'real').
Has_var_type(i191, 'real').
Has_var_type(i194, 'boolean').
Has_var_type(i195, 'boolean').
Has_var_type(i198, 'boolean').
Has_var_type(i199, 'boolean').
Has_var_type(i202, 'boolean').
Has_var_type(i203, 'boolean').
Has_var_type(i206, 'boolean').
Has_var_type(i207, 'boolean').
Has_var_type(i210, 'boolean').
Has_var_type(i211, 'boolean').
Has_var_type(i214, 'boolean').
Has_var_type(i215, 'boolean').
Has_var_type(i218, 'real').
Has_var_type(i219, 'real').

:- Dynamic has_fb_type/2.

Has_fb_type(i20, ipioc_f1_1).
Has_fb_type(i23, iptrc_f1_1).
Has_fb_type(i26, itctr_f1_1).
Has_fb_type(i29, ixcbr_f1_1).
Has_fb_type(i32, ipioc_f2_1).
Has_fb_type(i35, iptrc_f2_1).
Has_fb_type(i38, itctr_f2_1).
Has_fb_type(i41, ixcbr_f2_1).
Has_fb_type(i44, ipioc_f3_1).
Has_fb_type(i47, iptrc_f3_1).
Has_fb_type(i50, itctr_f3_1).
Has_fb_type(i53, ixcbr_f3_1).
Has_fb_type(i56, ipioc_f4_1).
Has_fb_type(i59, iptrc_f4_1).
Has_fb_type(i62, itctr_f4_1).
Has_fb_type(i65, ixcbr_f4_1).
Has_fb_type(i68, ipioc_tr_1).
Has_fb_type(i71, iptrc_tr_1).
Has_fb_type(i74, itctr_tr_1).
Has_fb_type(i77, ixcbr_tr_1).

:- Dynamic hasname/2.

Hasname(i1, 'act_1_tr').
Hasname(i2, 'dpc_1_pos').
Hasname(i3, 'dpl_1_phynam').
Hasname(i4, 'sav_1_ampsv').
Hasname(i5, general).
Hasname(i6, instmag).
Hasname(i7, 'substation_1').
Hasname(i8, 'substation_1').
Hasname(i9, 'ied1_d3_q1').
Hasname(i10, 'ied2_d3_q2').
Hasname(i11, 'ied3_d3_q3').
Hasname(i12, 'ied4_d3_q4').
Hasname(i13, 'ied5_d3_q5').
Hasname(i14, 'transformeried').
Hasname(i15, 'ied1_d3_q1.Accesspoint1_ld1').
Hasname(i16, 'ied2_d3_q2.Accesspoint1_ld1').
Hasname(i17, 'ied3_d3_q3.Accesspoint1_ld1').
Hasname(i18, 'ied4_d3_q4.Accesspoint1_ld1').
Hasname(i19, 'transformeried.Accesspoint1_ld1').
Hasname(i20, fb_ipioc_f1_1).
Hasname(i21, 'inito').
Hasname(i22, 'init').
Hasname(i23, fb_iptrc_f1_1).
Hasname(i24, 'inito').
Hasname(i25, 'init').
Hasname(i26, fb_itctr_f1_1).
Hasname(i27, 'inito').
Hasname(i28, 'init').
Hasname(i29, fb_ixcbr_f1_1).
Hasname(i30, 'inito').
Hasname(i31, 'init').
Hasname(i32, fb_ipioc_f2_1).
Hasname(i33, 'inito').
Hasname(i34, 'init').
Hasname(i35, fb_iptrc_f2_1).
Hasname(i36, 'inito').
Hasname(i37, 'init').
Hasname(i38, fb_itctr_f2_1).
Hasname(i39, 'inito').
Hasname(i40, 'init').
Hasname(i41, fb_ixcbr_f2_1).
Hasname(i42, 'inito').
Hasname(i43, 'init').
Hasname(i44, fb_ipioc_f3_1).
Hasname(i45, 'inito').
Hasname(i46, 'init').
Hasname(i47, fb_iptrc_f3_1).
Hasname(i48, 'inito').
Hasname(i49, 'init').
Hasname(i50, fb_itctr_f3_1).
Hasname(i51, 'inito').
Hasname(i52, 'init').
Hasname(i53, fb_ixcbr_f3_1).
Hasname(i54, 'inito').
Hasname(i55, 'init').
Hasname(i56, fb_ipioc_f4_1).
Hasname(i57, 'inito').
Hasname(i58, 'init').
Hasname(i59, fb_iptrc_f4_1).
Hasname(i60, 'inito').
Hasname(i61, 'init').
Hasname(i62, fb_itctr_f4_1).
Hasname(i63, 'inito').
Hasname(i64, 'init').
Hasname(i65, fb_ixcbr_f4_1).
Hasname(i66, 'inito').
Hasname(i67, 'init').
Hasname(i68, fb_ipioc_tr_1).
Hasname(i69, 'inito').
Hasname(i70, 'init').
Hasname(i71, fb_iptrc_tr_1).
Hasname(i72, 'inito').
Hasname(i73, 'init').
Hasname(i74, fb_itctr_tr_1).
Hasname(i75, 'inito').
Hasname(i76, 'init').
Hasname(i77, fb_ixcbr_tr_1).
Hasname(i78, 'inito').
Hasname(i79, 'init').
Hasname(i82, ipioc_f1_op_general).
Hasname(i83, ipioc_f1_op_general).
Hasname(i80, "ipioc_f1_op_general_ev").
Hasname(i81, "ipioc_f1_op_general_ev").
Hasname(i86, iptrc_f1_tr_general).
Hasname(i87, iptrc_f1_tr_general).
Hasname(i84, "iptrc_f1_tr_general_ev").
Hasname(i85, "iptrc_f1_tr_general_ev").
Hasname(i90, 'tr_general_iptrc_f1_ipioc_f2').
Hasname(i91, 'tr_general_iptrc_f1_ipioc_f2').
Hasname(i88, "tr_general_iptrc_f1_ipioc_f2_ev").
Hasname(i89, "tr_general_iptrc_f1_ipioc_f2_ev").
Hasname(i94, 'tr_general_iptrc_f1_ipioc_f3').
Hasname(i95, 'tr_general_iptrc_f1_ipioc_f3').
Hasname(i92, "tr_general_iptrc_f1_ipioc_f3_ev").
Hasname(i93, "tr_general_iptrc_f1_ipioc_f3_ev").
Hasname(i98, 'tr_general_iptrc_f1_ipioc_f4').
Hasname(i99, 'tr_general_iptrc_f1_ipioc_f4').
Hasname(i96, "tr_general_iptrc_f1_ipioc_f4_ev").
Hasname(i97, "tr_general_iptrc_f1_ipioc_f4_ev").
Hasname(i102, 'tr_general_iptrc_f1_ipioc_t').
Hasname(i103, 'tr_general_iptrc_f1_ipioc_t').
Hasname(i100, "tr_general_iptrc_f1_ipioc_t_ev").
Hasname(i101, "tr_general_iptrc_f1_ipioc_t_ev").
Hasname(i106, itctr_f1_ampsv_instmag).
Hasname(i107, itctr_f1_ampsv_instmag).
Hasname(i104, "itctr_f1_ampsv_instmag_ev").
Hasname(i105, "itctr_f1_ampsv_instmag_ev").
Hasname(i110, ipioc_f2_op_general).
Hasname(i111, ipioc_f2_op_general).
Hasname(i108, "ipioc_f2_op_general_ev").
Hasname(i109, "ipioc_f2_op_general_ev").
Hasname(i114, 'tr_general_iptrc_f2_ipioc_f1').
Hasname(i115, 'tr_general_iptrc_f2_ipioc_f1').
Hasname(i112, "tr_general_iptrc_f2_ipioc_f1_ev").
Hasname(i113, "tr_general_iptrc_f2_ipioc_f1_ev").
Hasname(i118, iptrc_f2_tr_general).
Hasname(i119, iptrc_f2_tr_general).
Hasname(i116, "iptrc_f2_tr_general_ev").
Hasname(i117, "iptrc_f2_tr_general_ev").
Hasname(i122, 'tr_general_iptrc_f2_ipioc_f3').
Hasname(i123, 'tr_general_iptrc_f2_ipioc_f3').
Hasname(i120, "tr_general_iptrc_f2_ipioc_f3_ev").
Hasname(i121, "tr_general_iptrc_f2_ipioc_f3_ev").
Hasname(i126, 'tr_general_iptrc_f2_ipioc_f4').
Hasname(i127, 'tr_general_iptrc_f2_ipioc_f4').
Hasname(i124, "tr_general_iptrc_f2_ipioc_f4_ev").
Hasname(i125, "tr_general_iptrc_f2_ipioc_f4_ev").
Hasname(i130, 'tr_general_iptrc_f2_ipioc_t').
Hasname(i131, 'tr_general_iptrc_f2_ipioc_t').
Hasname(i128, "tr_general_iptrc_f2_ipioc_t_ev").
Hasname(i129, "tr_general_iptrc_f2_ipioc_t_ev").
Hasname(i134, itctr_f2_ampsv_instmag).
Hasname(i135, itctr_f2_ampsv_instmag).
Hasname(i132, "itctr_f2_ampsv_instmag_ev").
Hasname(i133, "itctr_f2_ampsv_instmag_ev").
Hasname(i138, ipioc_f3_op_general).
Hasname(i139, ipioc_f3_op_general).
Hasname(i136, "ipioc_f3_op_general_ev").
Hasname(i137, "ipioc_f3_op_general_ev").
Hasname(i142, 'tr_general_iptrc_f3_ipioc_f1').
Hasname(i143, 'tr_general_iptrc_f3_ipioc_f1').
Hasname(i140, "tr_general_iptrc_f3_ipioc_f1_ev").
Hasname(i141, "tr_general_iptrc_f3_ipioc_f1_ev").
Hasname(i146, 'tr_general_iptrc_f3_ipioc_f2').
Hasname(i147, 'tr_general_iptrc_f3_ipioc_f2').
Hasname(i144, "tr_general_iptrc_f3_ipioc_f2_ev").
Hasname(i145, "tr_general_iptrc_f3_ipioc_f2_ev").
Hasname(i150, iptrc_f3_tr_general).
Hasname(i151, iptrc_f3_tr_general).
Hasname(i148, "iptrc_f3_tr_general_ev").
Hasname(i149, "iptrc_f3_tr_general_ev").
Hasname(i154, 'tr_general_iptrc_f3_ipioc_f4').
Hasname(i155, 'tr_general_iptrc_f3_ipioc_f4').
Hasname(i152, "tr_general_iptrc_f3_ipioc_f4_ev").
Hasname(i153, "tr_general_iptrc_f3_ipioc_f4_ev").
Hasname(i158, 'tr_general_iptrc_f3_ipioc_t').
Hasname(i159, 'tr_general_iptrc_f3_ipioc_t').
Hasname(i156, "tr_general_iptrc_f3_ipioc_t_ev").
Hasname(i157, "tr_general_iptrc_f3_ipioc_t_ev").
Hasname(i162, itctr_f3_ampsv_instmag).
Hasname(i163, itctr_f3_ampsv_instmag).
Hasname(i160, "itctr_f3_ampsv_instmag_ev").
Hasname(i161, "itctr_f3_ampsv_instmag_ev").
Hasname(i166, ipioc_f4_op_general).
Hasname(i167, ipioc_f4_op_general).
Hasname(i164, "ipioc_f4_op_general_ev").
Hasname(i165, "ipioc_f4_op_general_ev").
Hasname(i170, 'tr_general_iptrc_f4_ipioc_f1').
Hasname(i171, 'tr_general_iptrc_f4_ipioc_f1').
Hasname(i168, "tr_general_iptrc_f4_ipioc_f1_ev").
Hasname(i169, "tr_general_iptrc_f4_ipioc_f1_ev").
Hasname(i174, 'tr_general_iptrc_f4_ipioc_f2').
Hasname(i175, 'tr_general_iptrc_f4_ipioc_f2').
Hasname(i172, "tr_general_iptrc_f4_ipioc_f2_ev").
Hasname(i173, "tr_general_iptrc_f4_ipioc_f2_ev").
Hasname(i178, 'tr_general_iptrc_f4_ipioc_f3').
Hasname(i179, 'tr_general_iptrc_f4_ipioc_f3').
Hasname(i176, "tr_general_iptrc_f4_ipioc_f3_ev").
Hasname(i177, "tr_general_iptrc_f4_ipioc_f3_ev").
Hasname(i182, iptrc_f4_tr_general).
Hasname(i183, iptrc_f4_tr_general).
Hasname(i180, "iptrc_f4_tr_general_ev").
Hasname(i181, "iptrc_f4_tr_general_ev").
Hasname(i186, 'tr_general_iptrc_f4_ipioc_t').
Hasname(i187, 'tr_general_iptrc_f4_ipioc_t').
Hasname(i184, "tr_general_iptrc_f4_ipioc_t_ev").
Hasname(i185, "tr_general_iptrc_f4_ipioc_t_ev").
Hasname(i190, itctr_f4_ampsv_instmag).
Hasname(i191, itctr_f4_ampsv_instmag).
Hasname(i188, "itctr_f4_ampsv_instmag_ev").
Hasname(i189, "itctr_f4_ampsv_instmag_ev").
Hasname(i194, ipioc_t_op_general).
Hasname(i195, ipioc_t_op_general).
Hasname(i192, "ipioc_t_op_general_ev").
Hasname(i193, "ipioc_t_op_general_ev").
Hasname(i198, 'tr_general_iptrc_t_ixcbr_f1').
Hasname(i199, 'tr_general_iptrc_t_ixcbr_f1').
Hasname(i196, "tr_general_iptrc_t_ixcbr_f1_ev").
Hasname(i197, "tr_general_iptrc_t_ixcbr_f1_ev").
Hasname(i202, 'tr_general_iptrc_t_ixcbr_f2').
Hasname(i203, 'tr_general_iptrc_t_ixcbr_f2').
Hasname(i200, "tr_general_iptrc_t_ixcbr_f2_ev").
Hasname(i201, "tr_general_iptrc_t_ixcbr_f2_ev").
Hasname(i206, 'tr_general_iptrc_t_ixcbr_f3').
Hasname(i207, 'tr_general_iptrc_t_ixcbr_f3').
Hasname(i204, "tr_general_iptrc_t_ixcbr_f3_ev").
Hasname(i205, "tr_general_iptrc_t_ixcbr_f3_ev").
Hasname(i210, 'tr_general_iptrc_t_ixcbr_f4').
Hasname(i211, 'tr_general_iptrc_t_ixcbr_f4').
Hasname(i208, "tr_general_iptrc_t_ixcbr_f4_ev").
Hasname(i209, "tr_general_iptrc_t_ixcbr_f4_ev").
Hasname(i214, iptrc_t_tr_general).
Hasname(i215, iptrc_t_tr_general).
Hasname(i212, "iptrc_t_tr_general_ev").
Hasname(i213, "iptrc_t_tr_general_ev").
Hasname(i218, itctr_t_ampsv_instmag).
Hasname(i219, itctr_t_ampsv_instmag).
Hasname(i216, "itctr_t_ampsv_instmag_ev").
Hasname(i217, "itctr_t_ampsv_instmag_ev").

/* ---------------------------------------------------------------------------------- */
/* -------------------- End of the generated IEC 61499 ontology --------------------- */
/* ---------------------------------------------------------------------------------- */






