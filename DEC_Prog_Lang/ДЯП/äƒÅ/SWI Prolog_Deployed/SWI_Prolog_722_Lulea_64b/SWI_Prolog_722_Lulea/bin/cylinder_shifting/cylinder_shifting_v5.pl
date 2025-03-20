/* Program for finding cylinders sequences to reach the given position */
/* Main predicate to buint sequences:
seq(CurrList,CurrNum,UncheckedList,RezList,RezNum,NZ),
where
CurrList - the current list of the selected cylinders
CurrNum - the cumulative extension distance of the current selected cylinders
UncheckedList - a list of unchecked cylinders
RezList - the result list of the selected cylinders
RezNum - the cumulative extension distance of the resulted selected cylinders
NZ - the given distance of general extension of cylinders
*/
/* Examples for invoking: 
seq([],0,[c1,c2,c3,c4],RezList,RezN,7). 
check_all_goals([c1,c2,c3,c4]).
*/

/* Version 2.0 */

/* exactly -- solution is found */

seq(CL,CN,[F|_],[F|CL],CN2,NZ):-
ext(F,N2),
CN2 is CN+N2,
CN2==NZ.

/* shortage of length with fail (no more possibilities to extend) */

seq(CL,CN,[F|[]],CL,CN,NZ):-
ext(F,N2),
CN2 is CN+N2,
CN2<NZ,
fail.

/* shortage of length with continuing (still there are possibilities to extend) */

seq(CL,CN,[F|T2],RL,RN,NZ):-
ext(F,N2),
CN2 is CN+N2,
CN2<NZ,
seq([F|CL],CN2,T2,RL,RN,NZ).

/* excess of length with fail (the last extension would lead to exceed) */

seq(CL,CN,[F|_],CL,CN,NZ):-
ext(F,N2),
CN2 is CN+N2,
CN2>NZ,
fail.

/* passing the first element from the current UncheckedList for possibility to select another element */

seq(CL,CN,[_|T2],RL,RN,NZ):- 
length(T2,K), K>0, seq(CL,CN,T2,RL,RN,NZ).


/* Try all goals */

check_all_goals(UncheckedList):-
forall(tray(NZ),seq([],0,UncheckedList,_,_,NZ)).


/* ==================================================== */
/*    Source data - Definition of system of cylinders   */
/* ==================================================== */

ext(c1,4).
ext(c2,1).
ext(c3,2).
ext(c4,3).
tray(6).
tray(7).
/* tray(20). */







