/* -*- Mode: Prolog -*- */

:- module(owl2_java_owlapi,
          [
           create_manager/1,
           create_factory/2,
           create_ontology/3,
           build_ontology/1,
           build_ontology/3,
           save_ontology/3,
           create_reasoner/3,
           reasoner_classify/1,
           reasoner_classify/2,
           reasoner_classify/3,
           reasoner_classify_using/3,
           is_consistent/1,
           inconsistent_class/2,
           inferred_axiom/3,
           reasoner_nr_subClassOf/4,
           reasoner_subClassOf/4,
           reasoner_equivalent_to/4,
           reasoner_individualOf/4,
           reasoner_nr_individualOf/4,
           reasoner_objectPropertyAssertion/5,
           add_axiom/5
           ]).

:- use_module(library(jpl)).
:- use_module(owl2_model).
:- use_module(owl2_metamodel).

:- multifile owlterm_java/4.


prefix('org.semanticweb.owl.model').

atom_javaURI(X,U):-
        sub_atom(X,_,_,_,':'),
        !,
        jpl_call('java.net.URI',create,[X],U).
atom_javaURI(X,U):-
        ontology(Ont),
        !,
        concat_atom([Ont,X],'#',X2),
        jpl_call('java.net.URI',create,[X2],U).
atom_javaURI(X,U):-
        concat_atom(['http://foo.org',X],'#',X2),
        jpl_call('java.net.URI',create,[X2],U).

%% create_manager(?Manager)
create_manager(Manager) :-
        jpl_call('org.semanticweb.owl.apibinding.OWLManager',createOWLOntologyManager,[],Manager).

require_manager(Manager) :-
        var(Manager),
        !,
        create_manager(Manager).
require_manager(_).

%% create_ontology(?Manager,+Name,?Ont)
% @param Manager - manager instance will be created unless this is ground
create_ontology(Manager,Name,Ont) :-
        require_manager(Manager),
        atom_javaURI(Name,URI),
        jpl_call(Manager,createOntology,[URI],Ont).

%% build_ontology(?Ont)
% create an ontology from the current prolog db
build_ontology(Ont) :-
        create_factory(Man,Fac),
        build_ontology(Man,Fac,Ont).
        
%% build_ontology(+Man,+Fac,?Ont)
% create an ontology from the current prolog db
build_ontology(Man,Fac,Ont) :-
        require_manager(Man),
        (   ontology(OntName)
        ->  true
        ;   OntName='http://example.org'),
        create_ontology(Man,OntName,Ont),
        forall(axiom(Ax),
               (   debug(owl2,'Adding axiom: ~w',[Ax]),
                   add_axiom(Man,Fac,Ont,Ax,_))).

:- multifile owl2_io:load_axioms_hook/3.
owl2_io:load_axioms_hook(File,owlapi,Opts) :-
	owl2_io:load_axioms_hook(File,owlapi(_),Opts).
owl2_io:load_axioms_hook(File,owlapi(_Fmt),_Opts) :-
        create_factory(Man,_Fac),
        load_ontology(Man,_Ont,File).

:- multifile owl2_io:save_axioms_hook/3.
owl2_io:save_axioms_hook(File,owlapi,Opts) :-
	owl2_io:save_axioms_hook(File,owlapi(_),Opts).
owl2_io:save_axioms_hook(File,owlapi(_Fmt),_Opts) :-
        create_factory(Man,Fac),
        build_ontology(Man,Fac,Ont),
        save_ontology(Man,Ont,File).

%% load_ontology(+Man,?Ont,+File) is det
% TODO - need to maps java axioms to owlpl axioms
load_ontology(Man,Ont,File) :-
        atom_javaURI(File,URI),
        jpl_call(Man,loadOntologyFromPhysicalURI,[URI],Ont).


%% save_ontology(+Man,+Ont,+File) is det
save_ontology(Man,Ont,File) :-
        (   var(File)
        ->  tmp_file(owl,File),
            Tmp=true
        ;   Tmp=fail),
        atom_javaURI(File,URI),
        jpl_call(Man,saveOntology,[Ont,URI],_),
        (   Tmp
        ->  sformat(Cmd,'cat ~w',[File]),
            shell(Cmd)
        ;   true).



%% create_factory(?Manager,?Factory) is det
% @param Manager - manager instance will be created unless this is ground
create_factory(Manager,Fac) :-
        require_manager(Manager),
        jpl_call(Manager,getOWLDataFactory,[],Fac).

%% create_reasoner(?Manager,?Type,?Reasoner) is nondet
% if Type is ground then this predicate is deterministic
% @param Type - factpp or pellet
create_reasoner(Manager,RN,Reasoner) :-
        require_manager(Manager),
        reasoner_factory(RN,RFacClass),
        jpl_new(RFacClass,[],RFac),
        debug(owl2,'got reasoner factory: ~w',[RFac]),
        jpl_call(RFac,createReasoner,[Manager],Reasoner).

reasoner_factory(pellet,'org.mindswap.pellet.owlapi.PelletReasonerFactory').
reasoner_factory(factpp,'org.semanticweb.reasonerfactory.factpp.FaCTPlusPlusReasonerFactory').

reasoner_classify(Reasoner) :-
        debug(owl2,'classifying...',[]),
        jpl_call(Reasoner,classify,[],_).

reasoner_classify(Reasoner,Ont) :-
        reasoner_classify(Reasoner,_Man,Ont).

reasoner_classify(Reasoner,Man,Ont) :-
        require_manager(Man),
        jpl_call(Man,getImportsClosure,[Ont],IC),
        jpl_call(Reasoner,loadOntologies,[IC],_),
        reasoner_classify(Reasoner).

reasoner_classify_using(Reasoner,Ont,RN) :-
        require_manager(Man),
        create_reasoner(Man,RN,Reasoner),
        reasoner_classify(Reasoner,Man,Ont).


is_consistent(Reasoner) :-
        jpl_call(Reasoner,isConsistent,[],'@'(true)).

inconsistent_class(Reasoner,Class) :-
        jpl_call(Reasoner,getInconsistentClasses,[],JOWLClasses),
        member(JOWLClass,JOWLClasses),
        java_namedentity(JOWLClass,Class).

java_namedentity(J,C) :-
        jpl_call(J,getURI,[],URI),
        jpl_call(URI,toString,[],C).

%% ecsets_class(+JPSetSet,?P) is nondet
% Set<Set<OWLClass>> --> class expression
%  class expression will be
%   equivalentClasses(ECL) |
%   other class expression
ecsets_class(JPSetSet,P) :-
        jpl_call(JPSetSet,toArray,[],JPSetArr),
        jpl_array_to_list(JPSetArr,JPSets),
        member(JPSet,JPSets),
        jpl_call(JPSet,toArray,[],JPArr),
        jpl_array_to_list(JPArr,JPs),
        (   JPs=[JP],
            java_namedentity(JP,P)
        ->  true
        ;   JPs=[]
        ->  fail
        ;   maplist(java_namedentity,JPs,Ps),
            P=equivalentClasses(Ps)).

%% pimap_property_individual(PIMap,P,I) is nondet
%  Map<OWLObjectProperty, Set<OWLIndividual>> --> ?Property ?Individual
% (currently object properties only?)
pimap_property_individual(PIMap,P,I) :-
        jpl_call(PIMap,keySet,[],JPSet),
        jpl_call(JPSet,toArray,[],JPArr),
        jpl_array_to_list(JPArr,JPs),
        member(JP,JPs),
        jpl_call(PIMap,get,[JP],JISet),
        jpl_call(JISet,toArray,[],JIArr),
        jpl_array_to_list(JIArr,JIs),
        member(JI,JIs),
        java_namedentity(JP,P),
        java_namedentity(JI,I).

% converts prolog reference to java
cxj(Fac,C,JC) :-
        (   atom(C)
        ->  owlterm_java(Fac,_,C,JC)
        ;   translate_arg_to_java(Fac,C,_,JC)).


%% inferred_axiom(+R,+Fac,?Axiom)
inferred_axiom(R,Fac,subClassOf(A,B)) :-
        reasoner_subClassOf(R,Fac,A,B).
inferred_axiom(R,Fac,classAssertion(C,I)) :-
        reasoner_individualOf(R,Fac,I,C).
inferred_axiom(R,Fac,classAssertion(C,I)) :-
        reasoner_nr_individualOf(R,Fac,I,C).
inferred_axiom(R,Fac,propertyAssertion(P,I,I2)) :-
        reasoner_objectPropertyAssertion(R,Fac,I,P,I2).

        
%% reasoner_nr_subClassOf(+R,+Fac,?C,?P)
% ?C ?P - find superclasses for all named classes C
% +C ?P - find superclasses
% ?C +P - find subclasses
%
% an unbound variable may be bound to a named class
% or to a class expression using equivalentClasses/1 -- TODO - this is an axiom not expression        
        
% reasoner_nr_subClassOf(+R,+Fac,?C,?P)
reasoner_nr_subClassOf(R,Fac,C,P) :-
        var(C),
        var(P),
        !,
        class(C),
        reasoner_nr_subClassOf(R,Fac,C,P).

% reasoner_nr_subClassOf(+R,+Fac,+C,?P) 
reasoner_nr_subClassOf(R,Fac,C,P) :-
        nonvar(C),
        !,
        cxj(Fac,C,JC),
        jpl_call(R,getSuperClasses,[JC],JPSetSet),
        ecsets_class(JPSetSet,P).

% reasoner_nr_subClassOf(+R,+Fac,?C,+P) 
reasoner_nr_subClassOf(R,Fac,C,P) :-
        nonvar(P),
        !,
        cxj(Fac,P,JP),
        jpl_call(R,getSubClasses,[JP],JCSetSet),
        ecsets_class(JCSetSet,C).


%% reasoner_subClassOf(+R,+Fac,?C,?P)
% ?C ?P - find superclasses for all named classes C
% +C ?P - find superclasses
% ?C +P - find subclasses

% reasoner_subClassOf(+R,+Fac,?C,?P)
reasoner_subClassOf(R,Fac,C,P) :-
        var(C),
        var(P),
        !,
        class(C),
        reasoner_subClassOf(R,Fac,C,P).

% reasoner_subClassOf(+R,+Fac,+C,?P) 
reasoner_subClassOf(R,Fac,C,P) :-
        nonvar(C),
        !,
        cxj(Fac,C,JC),
        jpl_call(R,getAncestorClasses,[JC],JPSetSet),
        ecsets_class(JPSetSet,P).

% reasoner_subClassOf(+R,+Fac,?C,+P) 
reasoner_subClassOf(R,Fac,C,P) :-
        nonvar(P),
        !,
        cxj(Fac,P,JP),
        jpl_call(R,getDescendantClasses,[JP],JCSetSet),
        ecsets_class(JCSetSet,C).

%% reasoner_nr_individualOf(+R,+Fac,?I,?C)
% ?I ?C - find classes for all named individuals I
% +I ?C - find classes
% ?I +C - find individuals

reasoner_nr_individualOf(R,Fac,I,C) :-
        reasoner_individualOf(R,Fac,I,C,true).

%% reasoner_individualOf(+R,+Fac,?I,?C)
reasoner_individualOf(R,Fac,I,C) :-
        reasoner_individualOf(R,Fac,I,C,false).

reasoner_individualOf(R,Fac,I,C,IsDirect) :-
        var(C),
        var(I),
        !,
        class(C),
        reasoner_individualOf(R,Fac,I,C,IsDirect).


reasoner_individualOf(R,Fac,I,C,IsDirect) :-
        nonvar(C),
        !,
        cxj(Fac,C,JC),
        (   IsDirect
        ->  Bool='@'(true)
        ;   Bool='@'(false)),
        jpl_call(R,getIndividuals,[JC,Bool],ISet),
        jset_member(ISet,JI),
        java_namedentity(JI,I).

reasoner_individualOf(R,Fac,I,C,IsDirect) :-
        nonvar(I),
        !,
        cxj(Fac,I,JI),
        (   IsDirect
        ->  Bool='@'(true)
        ;   Bool='@'(false)),
        jpl_call(R,getTypes,[JI,Bool],JCSetSet),
        ecsets_class(JCSetSet,C).

reasoner_objectPropertyAssertion(R,Fac,I,P,I2) :-
        (   var(I)
        ->  classAssertion(_,I)
        ;   true),
        cxj(Fac,I,JI),
        jpl_call(R,getObjectPropertyRelationships,[JI],PropIndivsMap),
        pimap_property_individual(PropIndivsMap,P,I2).



% java util
jset_member(JPSet,JP) :-
        jpl_call(JPSet,toArray,[],JPArr),
        jpl_array_to_list(JPArr,JPs),
        member(JP,JPs).

%% reasoner_equivalent_to(+R,+Fac,+C,?P)
reasoner_equivalent_to(R,Fac,C,P) :-
        (   var(C)
        ->  class(C)
        ;   true),
        owlterm_java(Fac,_,class(C),JC),
        jpl_call(R,getEquivalentClasses,[JC],JPSet),
        jset_member(JPSet,JP),
        java_namedentity(JP,P).

%% add_axiom(+Manager,+Factory,+Ont,+Axiom,?Obj) is det
% adds an axiom to Ont from the prolog databases
add_axiom(Manager,Factory,Ont,Axiom,JAx) :-
        owlterm_java(Factory,_,Axiom,JAx),
        debug(owl2,' axiom ~w = ~w',[Axiom,JAx]),
        (   owl2_model:declarationAxiom(Axiom)
        ->  true
        ;   jpl_new('org.semanticweb.owl.model.AddAxiom',[Ont,JAx],AddAxiom),
            jpl_call(Manager,applyChange,[AddAxiom],_)).

%% owlterm_java(+Factory,?Type,+OWLTerm,?Obj) is det
% translate OWL Axiom or OWL Expression from prolog term to java object

% special rules for ontology declarations - should have been handled previously
owlterm_java(_,_,ontology(_),_) :- !.

% special rules for annotationAssertions
owlterm_java(Fac,_,annotationAssertion(AP,Sub,Val),Obj) :-
        !,
        translate_arg_to_java(Fac,Val,literal,JVal),
        translate_arg_to_java(Fac,Sub,entity,JEntity),
        atom_javaURI(AP,JAP),
        jpl_call(Fac,getOWLConstantAnnotation,[JAP,JVal],JAnno),
        jpl_call(Fac,getOWLEntityAnnotationAxiom,[JEntity,JAnno],Obj).

owlterm_java(Fac,_,OWLTerm,Obj) :-
        OWLTerm =.. [P,X],
        decl_method(P,M),       % declaration axiom
        !,
        debug(owl2,'decl(~w,~w) -- converting to URI: ~w',[P,M,X]),
        atom_javaURI(X,U),
        debug(owl2,'calling: ~w . ~w( ~w )',[Fac,M,U]),
        jpl_call(Fac,M,[U],Obj).

owlterm_java(Fac,_,OWLTerm,Obj) :-
        atom(OWLTerm),          % undeclared atom; TODO; numbers eg card
        !,
        debug(owl2,'converting to URI: ~w',[OWLTerm]),
        atom_javaURI(OWLTerm,U),
        (   class(OWLTerm)
        ->  M=getOWLClass
        ;   objectProperty(OWLTerm)
        ->  M=getOWLObjectProperty
        ;   \+ \+ classAssertion(_,M)
        ->  M=getOWLIndividual
        ;   throw(OWLTerm)),
        jpl_call(Fac,M,[U],Obj). % TODO

% some axioms such as subClassOf are effectively untyped
owlterm_java(Fac,_Type,OWLTerm,Obj) :- % e.g subClassOf
        OWLTerm =.. [P|Args],
        axiom_method(P,M),
        !,
        axiom_arguments(P,ArgTypes),
        debug(owl2,'using java method: ~w, expecting arguments: ~w',[M,ArgTypes]),
        translate_args_to_java(Fac,Args,ArgTypes,Objs),
        jpl_call(Fac,M,Objs,Obj).

% as above, but we must re-order
owlterm_java(Fac,_Type,OWLTerm,Obj) :- % e.g classAssertion
        OWLTerm =.. [P|Args],
        axiom_method(P,M,Objs,ReorderedObjs),
        !,
        axiom_arguments(P,ArgTypes),
        debug(owl2,'using java method: ~w, expecting arguments: ~w',[M,ArgTypes]),
        translate_args_to_java(Fac,Args,ArgTypes,Objs),
        jpl_call(Fac,M,ReorderedObjs,Obj).

% special case translation for property chains
owlterm_java(Fac,_,subPropertyOf(propertyChain(PL),P),Obj) :- % e.g. subObjectPropertyOf
        !,
        debug(owl2,'  translating chain ~w',[PL]),
        translate_args_to_java(Fac,[PL,P],[list(objectPropertyExpression),objectPropertyExpression],Objs),
        debug(owl2,'  translated chain to: ~w',[Objs]),
        jpl_call(Fac,getOWLObjectPropertyChainSubPropertyAxiom,Objs,Obj).

% axioms such as subPropertyOf have two typed variants.
% we use type checking which may require the axiom declaration
% to be asserted in the prolog owl2_model database
owlterm_java(Fac,_,UntypedAxiom,Obj) :- % e.g. subObjectPropertyOf
        UntypedAxiom =.. [UntypedPred|Args],      % e.g subPropertyOf p1 p2
        nonvar(UntypedPred),
        owlpredicate_typed(UntypedPred,TypedPred),
        axiom_method(TypedPred,M),   % e.g. subObjectPropertyOf
        TypeCheckGoal =.. [TypedPred|Args],       
        TypeCheckGoal,
        !,
        debug(owl2,'typed axiom: if ~w is ~w',[UntypedAxiom,TypedPred]),
        owlpredicate_arguments(TypedPred,ArgTypes),
        translate_args_to_java(Fac,Args,ArgTypes,Objs),
        debug(owl2,'  translated ~w :: ~w method: ~w',[Args,ArgTypes,M]),
        jpl_call(Fac,M,Objs,Obj).

% on occasion the owlapi has a different ordering of arguments...
owlterm_java(Fac,_,UntypedAxiom,Obj) :- 
        UntypedAxiom =.. [UntypedPred|Args],
        nonvar(UntypedPred),
        owlpredicate_typed(UntypedPred,TypedPred),
        TypeCheckGoal =.. [TypedPred|Args],       
        TypeCheckGoal,
        debug(owl2,'typed axiom: if ~w is ~w',[UntypedAxiom,TypedPred]),
        owlpredicate_arguments(TypedPred,ArgTypes),
        translate_args_to_java(Fac,Args,ArgTypes,Objs),
        axiom_method(TypedPred,M,Objs,ObjsReordered), % e.g. subObjectPropertyOf
        debug(owl2,'  translated ~w :: ~w method: ~w',[Args,ArgTypes,M]),
        jpl_call(Fac,M,ObjsReordered,Obj).


translate_args_to_java(_Fac,[],[],[]).
translate_args_to_java(Fac,[A|Args],[T|ArgTypes],[Obj|Objs]) :-
        debug(owl2,' translating: ~w  :: ~w',[A,T]),
        translate_arg_to_java(Fac,A,T,Obj),
        debug(owl2,' translated: ~w --> ~w',[A,Obj]),
        translate_args_to_java(Fac,Args,ArgTypes,Objs).

translate_arg_to_java(Fac,L,set(T),Set) :-
        is_list(L),
        !,
        findall(T,member(_,L),Ts),
        translate_args_to_java(Fac,L,Ts,Objs),
        jpl_new('java.util.HashSet',[],Set),
        debug(owl2,' new set: ~w = ~w -- adding objs ~w',[L,Set,Objs]),
        forall(member(Obj,Objs),
               jpl_call(Set,add,[Obj],_)),
        debug(owl2,' made set: ~w ',[Set]).

translate_arg_to_java(Fac,L,list(T),List) :-
        is_list(L),
        !,
        findall(T,member(_,L),Ts),
        translate_args_to_java(Fac,L,Ts,Objs),
        jpl_new('java.util.ArrayList',[],List),
        debug(owl2,' new set: ~w = ~w -- adding objs ~w',[L,List,Objs]),
        forall(member(Obj,Objs),
               jpl_call(List,add,[Obj],_)),
        debug(owl2,' made list: ~w ',[List]).

translate_arg_to_java(_Fac,X,T,X) :- nonvar(T),T=int,!.

translate_arg_to_java(Fac,X,classExpression,Obj) :-
        atom(X),
        !,
        owlterm_java(Fac,_,class(X),Obj).
translate_arg_to_java(Fac,X,objectPropertyExpressionOrChain,Obj) :-
        atom(X),
        !,
        owlterm_java(Fac,_,objectProperty(X),Obj).
translate_arg_to_java(Fac,X,objectPropertyExpression,Obj) :-
        atom(X),
        !,
        owlterm_java(Fac,_,objectProperty(X),Obj).
translate_arg_to_java(Fac,X,dataPropertyExpression,Obj) :-
        atom(X),
        !,
        owlterm_java(Fac,_,dataProperty(X),Obj).
translate_arg_to_java(Fac,X,objectProperty,Obj) :-
        atom(X),
        !,
        owlterm_java(Fac,_,objectProperty(X),Obj).
translate_arg_to_java(Fac,X,individual,Obj) :-
        atom(X),
        !,
        owlterm_java(Fac,_,individual(X),Obj).
translate_arg_to_java(Fac,X,entity,Obj) :-
        atom(X),
        !,
        owlterm_java(Fac,_,entity(X),Obj).
translate_arg_to_java(Fac,Val,literal,Obj) :- % todo - caused by bug in rdf parser
        atom(Val),
        sub_atom(Val,0,_,_,'__'),
        !,
        translate_arg_to_java(Fac,literal(''),literal,Obj).
translate_arg_to_java(Fac,literal(type(_,Val)),literal,Obj) :- % todo - typed constants
        !,
        jpl_call(Fac,getOWLUntypedConstant,[Val],Obj).
translate_arg_to_java(Fac,literal(Val),literal,Obj) :- % todo - typed constants
        !,
        jpl_call(Fac,getOWLUntypedConstant,[Val],Obj).

translate_arg_to_java(_Fac,X,T,Obj) :- % TODO
        atom(X),
        !,
        atom_javaURI(X,U),
        jpl_new(T,U,Obj).

translate_arg_to_java(Fac,X,_T,Obj) :-
        atom(X),
        class(X),
        !,
        debug(owl2,'converting to URI: ~w',[X]),
        atom_javaURI(X,U),
        jpl_call(Fac,getOWLClass,U,Obj).
translate_arg_to_java(Fac,X,_T,Obj) :-
        atom(X),
        \+ \+ classAssertion(_,X),
        !,
        atom_javaURI(X,U),
        jpl_call(Fac,getOWLIndividual,U,Obj).

translate_arg_to_java(Fac,X,_T,Obj) :-
        atom(X),
        objectProperty(X),
        !,
        atom_javaURI(X,U),
        jpl_call(Fac,getOWLObjectProperty,U,Obj).




% typed expressions
translate_arg_to_java(Fac,UntypedExpr,_T,Obj) :-
        UntypedExpr =.. [UntypedPred|Args], % eg intersectionOf(L)
        owlpredicate_typed(UntypedPred,TypedPred),
        owlpredicate_arguments(TypedPred,ArgTypes),
        debug(owl2,'  testing for java expr method ~w',[TypedPred]),
        expr_method(TypedPred,Method),
        Check =.. [TypedPred,UntypedExpr], % eg objectIntersectionOf(intersectionOf(L))
        debug(owl2,'  checking expr ~w',[Check]),
        Check,
        !,
        debug(owl2,'  typed expr ~w -> ~w :: ~w',[UntypedExpr,TypedPred,ArgTypes]),
        translate_args_to_java(Fac,Args,ArgTypes,Objs),
        debug(owl2,'  expr ~w -> java ~w.~w',[UntypedExpr,Method,Objs]),
        jpl_call(Fac,Method,Objs,Obj),
        debug(owl2,'  made obj for ~w = ~w',[UntypedExpr,Obj]).

translate_arg_to_java(Fac,UntypedExpr,_T,Obj) :-
        UntypedExpr =.. [UntypedPred|Args], % eg intersectionOf(L)
        owlpredicate_typed(UntypedPred,TypedPred),
        owlpredicate_arguments(TypedPred,ArgTypes),
        Check =.. [TypedPred,UntypedExpr], % eg objectIntersectionOf(intersectionOf(L))
        debug(owl2,'  checking expr ~w',[Check]),
        Check,
        debug(owl2,'  typed expr ~w -> ~w :: ~w',[UntypedExpr,TypedPred,ArgTypes]),
        translate_args_to_java(Fac,Args,ArgTypes,Objs),
        debug(owl2,'  testing for REORDERED java expr method ~w',[TypedPred]),
        expr_method(TypedPred,Method,Objs,ReorderedObjs),
        !,
        debug(owl2,'  expr ( reordered ) ~w -> java ~w.~w',[UntypedExpr,Method,ReorderedObjs]),
        jpl_call(Fac,Method,ReorderedObjs,Obj),
        debug(owl2,'  made obj for ~w = ~w',[UntypedExpr,Obj]).

translate_arg_to_java(Fac,Expr,_T,Obj) :-
        Expr =.. [Pred|Args],   % eg oneOf(L)
        owlpredicate_arguments(Pred,ArgTypes),
        expr_method(Pred,Method),
        !,
        translate_args_to_java(Fac,Args,ArgTypes,Objs),
        jpl_call(Fac,Method,Objs,Obj).

%add_axiom_method(AP,M) :-
%        atom_chars(AP,[C|Chars]),
%        upcase_atom(AP,AP2),
%        atom_chars(AP2,[C2|Chars]),
%        sformat(M,'get~wAxiom',[AP2]).



%% decl_method(?Predicate,?JavaMethod)
% maps a declaration axiom predicate to the java factory method that will instantiate an instance
decl_method(P,M) :-
        decl_method(P,M,_).

decl_method(class,getOWLClass,classExpression).
decl_method(objectProperty,getOWLObjectProperty,propertyExpression).
decl_method(annotationProperty,getOWLAnnotationProperty,iri).
decl_method(dataType,getOWLDatatype,datatype).
decl_method(dataProperty,getOWLDataProperty,_).
decl_method(individual,getOWLIndividual,_). % anonymous individuals?
decl_method(entity,getOWLIndividual,_). % anonymous individuals?

:- discontiguous axiom_method/2,axiom_method/4.

axiom_method(subClassOf,getOWLSubClassAxiom).
axiom_method(equivalentClasses,getOWLEquivalentClassesAxiom).
%axiom_method(subPropertyOf,getOWLSubObjectPropertyAxiom).
axiom_method(disjointClasses,getOWLDisjointClassesAxiom).
axiom_method(inverseProperties,getOWLInverseObjectPropertiesAxiom).

axiom_method(symmetricProperty,getOWLSymmetricObjectPropertyAxiom).
axiom_method(asymmetricProperty,getOWLAsymmetricObjectPropertyAxiom).
axiom_method(reflexiveProperty,getOWLReflexiveObjectPropertyAxiom).
axiom_method(irreflexiveProperty,getOWLIrreflexiveObjectPropertyAxiom).

axiom_method(functionalObjectProperty,getOWLFunctionalObjectPropertyAxiom).
axiom_method(dataObjectProperty,getOWLFunctionalDataPropertyAxiom).



%axiom_method(objectPropertyAssertion,getOWLObjectPropertyAssertionAxiom).
%axiom_method(dataPropertyAssertion,getOWLDataPropertyAssertionAxiom).
axiom_method(objectPropertyAssertion,getOWLObjectPropertyAssertionAxiom,[P,S,T],[S,P,T]).
axiom_method(dataPropertyAssertion,getOWLDataPropertyAssertionAxiom,[P,S,V],[S,P,V]).


%% axiom_method(?Pred,?JavaGetMethod)
axiom_method(subObjectPropertyOf,getOWLSubObjectPropertyAxiom).
axiom_method(subDataPropertyOf,getOWLSubDataPropertyAxiom).
axiom_method(disjointObjectProperties,getOWLDisjointObjectPropertiesAxiom).
axiom_method(disjointDataProperties,getOWLDisjointDataPropertiesAxiom).
axiom_method(equivalentObjectProperties,getOWLEquivalentObjectPropertiesAxiom).
axiom_method(equivalentDataProperties,getOWLEquivalentDataPropertiesAxiom).

axiom_method(transitiveProperty,getOWLTransitiveObjectPropertyAxiom).
axiom_method(inverseFunctionalProperty,getOWLInverseFunctionalObjectPropertyAxiom).
axiom_method(symmetricProperty,getOWLSymmetricObjectPropertyAxiom).
axiom_method(dataPropertyDomain,getOWLDataPropertyDomainAxiom).
axiom_method(objectPropertyDomain,getOWLObjectPropertyDomainAxiom).
axiom_method(dataPropertyRange,getOWLDataPropertyRangeAxiom).
axiom_method(objectPropertyRange,getOWLObjectPropertyRangeAxiom).

axiom_method(classAssertion,getOWLClassAssertionAxiom,[D,I],[I,D]).

expr_method(objectIntersectionOf,getOWLObjectIntersectionOf).
expr_method(dataIntersectionOf,getOWLObjectIntersectionOf).
expr_method(objectSomeValuesFrom,getOWLObjectSomeRestriction).
expr_method(dataSomeValuesFrom,getOWLDataSomeRestriction).
expr_method(objectHasValue,getOWLObjectValueRestriction).
expr_method(dataHasValue,getOWLDataValueRestriction).
expr_method(objectAllValuesFrom,getOWLObjectAllRestriction).
expr_method(dataAllValuesFrom,getOWLDataAllRestriction).
expr_method(objectComplementOf,getOWLObjectComplementOf).
expr_method(dataComplementOf,getOWLDataComplementOf).
expr_method(objectUnionOf,getOWLObjectUnionOf).
expr_method(dataUnionOf,getOWLDataUnionOf).
expr_method(objectOneOf,getOWLObjectOneOf).
expr_method(dataOneOf,getOWLDataOneOf).

expr_method(inverseOf,getOWLObjectPropertyInverse).


expr_method(objectMinCardinality,getOWLObjectMinCardinalityRestriction,[N,P,CE],[P,N,CE]).
expr_method(objectMinCardinality,getOWLObjectMinCardinalityRestriction,[N,P],[P,N]).
expr_method(dataMinCardinality,getOWLDataMinCardinalityRestriction,[N,P,CE],[P,N,CE]).
expr_method(dataMinCardinality,getOWLDataMinCardinalityRestriction,[N,P],[P,N]).
expr_method(objectMaxCardinality,getOWLObjectMaxCardinalityRestriction,[N,P,CE],[P,N,CE]).
expr_method(objectMaxCardinality,getOWLObjectMaxCardinalityRestriction,[N,P],[P,N]).
expr_method(dataMaxCardinality,getOWLDataMaxCardinalityRestriction,[N,P,CE],[P,N,CE]).
expr_method(dataMaxCardinality,getOWLDataMaxCardinalityRestriction,[N,P],[P,N]).
expr_method(objectExactCardinality,getOWLObjectExactCardinalityRestriction,[N,P,CE],[P,N,CE]).
expr_method(objectExactCardinality,getOWLObjectExactCardinalityRestriction,[N,P],[P,N]).
expr_method(dataExactCardinality,getOWLDataExactCardinalityRestriction,[N,P,CE],[P,N,CE]).
expr_method(dataExactCardinality,getOWLDataExactCardinalityRestriction,[N,P],[P,N]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Hooks for owl2_reasoner.pl  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile owl2_reasoner:initialize_reasoner_hook/3.
:- multifile owl2_reasoner:reasoner_tell_hook/2.
:- multifile owl2_reasoner:reasoner_tell_all_hook/1.
:- multifile owl2_reasoner:reasoner_ask_hook/2.

wrapped_reasoner(pellet).
wrapped_reasoner(factpp).

initialize_reasoner_hook(Type,R,Opts) :-
	wrapped_reasoner(Type),
	initialize_reasoner_hook(owlapi(Type),R,Opts).
initialize_reasoner_hook(owlapi(Type),owlapi(R-Man-Fac),_Opts) :-
	!,
	require_manager(Man),
	create_factory(Man,Fac),
	create_reasoner(Man,Type,R).

%reasoner_tell_hook(R,Axiom) :- foo.

reasoner_tell_all_hook(owlapi(OWLReasoner,Fac)) :-
	build_ontology(Man,Fac,Ont),
	reasoner_classify(OWLReasoner,Man,Ont).

	
reasoner_ask_hook(R,Axiom) :-
	var(Axiom), % allow all?
	!,
	throw(error(reasoner(R,Axiom))).

reasoner_ask_hook(R,subClassOf(A,B)) :-
	reasoner_subClassOf(Reasoner,Fac,A,B),
        

/** <module> bridge to java OWLAPI

---+ Synopsis

using OWLAPI to save files:
  
==
[owl2_model].
[owl2_java_owlapi].
[owl2_from_rdf].
owl_parse_rdf('testfiles/Hydrology.owl'), % parse using prolog/thea
create_factory(Man,Fac),
build_ontology(Man,Fac,Ont),
save_ontology(Man,Ont,'file:///tmp/foo'). % save using owlapi
==  

using a reasoner:

==
create_reasoner(Man,pellet,Reasoner),
create_factory(Man,Fac),
build_ontology(Man,Fac,Ont),
reasoner_classify(Reasoner,Man,Ont),
save_ontology(Man,Ont,'file:///tmp/foo').
==  

==
[owl2_model].
[owl2_java_owlapi].
[owl2_from_rdf].
owl_parse_rdf('testfiles/music_ontology.owl'),
create_factory(Man,Fac),
build_ontology(Man,Fac,Ont),
writeln(classifying),
create_reasoner(Man,pellet,Reasoner),
reasoner_classify(Reasoner,Man,Ont),
writeln(classified),
class(C),
writeln(c=C),
reasoner_subClassOf(Reasoner,Fac,C,P),
writeln(p=P).
==  

queries:

==
someValuesFrom('http://purl.org/ontology/mo/performed','http://purl.org/ontology/mo/Performance')
==

---+ Use

  JPL Required

  Set your CLASSPATH to include owlapi-bin.jar, pellet.jar, ...

  start SWI

---+ Details

  This module is intended to interface with the OWLAPI

  http://owlapi.sourceforge.net/

  This provides access to reasoners such as Pellet and FaCT++

  JPL is required for this module

  Note that this module is not required for the rest of Thea2

@author  Chris Mungall
@version $Revision$
@see     README
@license License


*/
	