% annotationProperty('http://www.w3.org/2000/01/rdf-schema#comment') 
% annotationProperty('http://www.w3.org/2000/01/rdf-schema#label') 
% class('http://mmm/untitled-ontology-64#EventInput') 
% class('http://mmm/untitled-ontology-64#EventOutput') 
% class('http://mmm/untitled-ontology-64#FunctionBlock') 
% class('http://mmm/untitled-ontology-64#InputVariable') 
% class('http://mmm/untitled-ontology-64#OutputVariable') 
% dataProperty('http://mmm/untitled-ontology-64#has_name') 
% dataProperty('http://mmm/untitled-ontology-64#has_type_name') 
% objectProperty('http://mmm/untitled-ontology-64#d_coonect_to') 
% objectProperty('http://mmm/untitled-ontology-64#e_coonect_to') 
% objectProperty('http://mmm/untitled-ontology-64#is_part_of_FB') 
% ontology('http://mmm/untitled-ontology-64') 
% propertyDomain('http://mmm/untitled-ontology-64#d_coonect_to','http://mmm/untitled-ontology-64#OutputVariable') 
'OutputVariable'(X):-
     d_coonect_to(X,'_').
% propertyDomain('http://mmm/untitled-ontology-64#e_coonect_to','http://mmm/untitled-ontology-64#EventOutput') 
'EventOutput'(X):-
     e_coonect_to(X,'_').
% propertyDomain('http://mmm/untitled-ontology-64#is_part_of_FB','http://mmm/untitled-ontology-64#EventInput') 
'EventInput'(X):-
     is_part_of_FB(X,'_').
% propertyDomain('http://mmm/untitled-ontology-64#is_part_of_FB','http://mmm/untitled-ontology-64#EventOutput') 
'EventOutput'(X):-
     is_part_of_FB(X,'_').
% propertyDomain('http://mmm/untitled-ontology-64#is_part_of_FB','http://mmm/untitled-ontology-64#InputVariable') 
'InputVariable'(X):-
     is_part_of_FB(X,'_').
% propertyDomain('http://mmm/untitled-ontology-64#is_part_of_FB','http://mmm/untitled-ontology-64#OutputVariable') 
'OutputVariable'(X):-
     is_part_of_FB(X,'_').
% propertyRange('http://mmm/untitled-ontology-64#d_coonect_to','http://mmm/untitled-ontology-64#InputVariable') 
'InputVariable'(X):-
     d_coonect_to(_,X).
% propertyRange('http://mmm/untitled-ontology-64#e_coonect_to','http://mmm/untitled-ontology-64#EventInput') 
'EventInput'(X):-
     e_coonect_to(_,X).
% propertyRange('http://mmm/untitled-ontology-64#is_part_of_FB','http://mmm/untitled-ontology-64#FunctionBlock') 
'FunctionBlock'(X):-
     is_part_of_FB(_,X).
