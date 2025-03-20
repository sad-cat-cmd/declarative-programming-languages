/* PROLOG-program for inferencing FB system structure on the basis of automaton specifying WP sequences */
/* Version 2.0 */
/* ============================== */

/* Rules for computing (inferencing) Function Blocks */

/* Rule for inferencing FB having neither initial token nor repetition  */
function_block(Id,Color,false,false,NRep):-
transition(Id,FromState,ToState,Color,NRep),
not(initial_state(FromState)), 
FromState\==ToState.

/* Rule for inferencing FB having no initial token but having repetition  */
function_block(Id,Color,false,true,NRep):-
transition(Id,State,State,Color,NRep),
not(initial_state(State)).

/* Rule for inferencing FB having initial token but not having repetition  */
function_block(Id,Color,true,false,NRep):-
transition(Id,FromState,ToState,Color,NRep),
initial_state(FromState), 
FromState\==ToState.

/* Rule for inferencing FB having initial token and repetition  */
function_block(Id,Color,true,true,NRep):-
transition(Id,State,State,Color,NRep), 
initial_state(State).

/* Rules for computing (inferencing) of Connections */

/* Rules for inferencing connections of type “set” */
connection(T1,T2,set):-
transition(T1,S1,S2,_,_),
S1\==S2,
transition(T2,S2,_,_,_),
function_block(T1,_,_,_,_),
function_block(T2,_,_,_,_).

/* Rules for inferencing connections of type “reset” */
connection(FB1,FB2,reset):-
function_block(FBX,_,_,_,_),
connection(FBX,FB1,set),
not(transition(FB1,S,S,_,_)),
connection(FBX,FB2,set),
FB1\==FB2.

/* Print the list of FBs */
print_fbs:- 
function_block(Id,Color,FlagToken,FlagIteration,NRep),
string_concat("Function Block:  ID= ",Id,String1),
string_concat(String1, "; Color= ",String2),
string_concat(String2, Color, String3),
string_concat(String3,"; FlagToken= ", String4),
string_concat(String4,FlagToken,String5),
string_concat(String5,"; FlagIteration= ",String6),
string_concat(String6,FlagIteration,String7),
string_concat(String7,"; Num of repet= ",String8),
string_concat(String8,NRep,String9),
writeln(String9),
fail.
print_fbs.

/* Print the list of connections of type “set” */
print_sconn:-
connection(FB1,FB2,set),
string_concat("S-Connection: From FB: ",FB1,String1),
string_concat(String1, "  to FB: ", String2),
string_concat(String2,FB2,String3),
writeln(String3),
fail.
print_sconn.

/* Print the list of connections of type “reset” */
print_rconn:-
connection(FB1,FB2,reset),
string_concat("R-Connection: From FB: ",FB1,String1),
string_concat(String1, "  to FB: ", String2),
string_concat(String2,FB2,String3),
writeln(String3),
fail.
print_rconn.





