% annotationProperty('http://www.w3.org/2000/01/rdf-schema#comment') 
% annotationProperty('http://www.w3.org/2000/01/rdf-schema#label') 
% class('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#convey') 
% class('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#diverter') 
% class('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#photo_eye') 
% dataProperty('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_id') 
% dataProperty('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_name') 
% namedIndividual('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c1') 
% namedIndividual('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2') 
% namedIndividual('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c3') 
% namedIndividual('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c4') 
% namedIndividual('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#d2') 
% namedIndividual('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p1') 
% namedIndividual('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p2') 
% namedIndividual('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p3') 
% namedIndividual('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p4') 
% objectProperty('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_divert_connection') 
% objectProperty('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_diverter') 
% objectProperty('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_photo_eye') 
% objectProperty('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_straight_connection') 
% ontology('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl') 
% classAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#convey','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c1') 
convey('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c1').
% classAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#convey','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2') 
convey('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2').
% classAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#convey','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c3') 
convey('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c3').
% classAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#convey','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c4') 
convey('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c4').
% classAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#diverter','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#d2') 
diverter('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#d2').
% classAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#photo_eye','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p1') 
photo_eye('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p1').
% classAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#photo_eye','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p2') 
photo_eye('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p2').
% classAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#photo_eye','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p3') 
photo_eye('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p3').
% classAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#photo_eye','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p4') 
photo_eye('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p4').
% propertyRange('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_id','http://www.w3.org/2001/XMLSchema#int') 
int(X):-
     'http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_id'(_,X).
% propertyRange('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_name','http://www.w3.org/2001/XMLSchema#string') 
string(X):-
     'http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_name'(_,X).
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_divert_connection','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c4') 
has_divert_connection('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c4').
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_diverter','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#d2') 
has_diverter('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#d2').
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_id','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c1',literal(type('http://www.w3.org/2001/XMLSchema#int','111'))) 
has_id('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c1','111').
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_id','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2',literal(type('http://www.w3.org/2001/XMLSchema#int','222'))) 
has_id('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2','222').
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_id','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c3',literal(type('http://www.w3.org/2001/XMLSchema#int','333'))) 
has_id('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c3','333').
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_id','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c4',literal(type('http://www.w3.org/2001/XMLSchema#int','444'))) 
has_id('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c4','444').
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_name','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c1',literal(type('http://www.w3.org/2001/XMLSchema#string',abc))) 
has_name('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c1',abc).
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_name','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2',literal(type('http://www.w3.org/2001/XMLSchema#string',def))) 
has_name('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2',def).
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_name','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c3',literal(type('http://www.w3.org/2001/XMLSchema#string',xyz))) 
has_name('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c3',xyz).
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_name','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c4',literal(type('http://www.w3.org/2001/XMLSchema#string',klm))) 
has_name('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c4',klm).
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_photo_eye','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c1','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p1') 
has_photo_eye('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c1','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p1').
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_photo_eye','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p2') 
has_photo_eye('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p2').
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_photo_eye','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c3','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p3') 
has_photo_eye('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c3','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p3').
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_photo_eye','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c4','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p4') 
has_photo_eye('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c4','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#p4').
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_straight_connection','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c1','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2') 
has_straight_connection('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c1','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2').
% propertyAssertion('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#has_straight_connection','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c3') 
has_straight_connection('http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c2','http://www.semanticweb.org/ontologies/2012/4/Ontology1338113342645.owl#c3').
