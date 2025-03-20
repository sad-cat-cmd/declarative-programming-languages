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
/* Example for invoking: 
seq([],0,[c1,c2,c3],RezList,RezN,5). */

/* Version 1.0 */



/* exactly -- solution is found */

seq(CL,CN,[F|T2],[F|CL],CN2,NZ):-
ext(F,N2),
CN2 is CN+N2,
CN2==NZ.

/* shortage with fail (no more possibilities to extend) */

seq(CL,CN,[F|[]],CL,CN,NZ):-
ext(F,N2),
CN2 is CN+N2,
CN2<NZ,
fail.

/* shortage with continuing (still there are possibilities to extend) */

seq(CL,CN,[F|T2],RL,RN,NZ):-
ext(F,N2),
CN2 is CN+N2,
CN2<NZ,
seq([F|CL],CN2,T2,RL,RN,NZ).

/* excess with fail (the last extension would lead to exceed) */

seq(CL,CN,[F|[]],CL,CN,NZ):-
ext(F,N2),
CN2 is CN+N2,
CN2>NZ,
fail.

/* excess with continuing (the current element has been passed, it will be trying to extend with another element) */

seq(CL,CN,[F|T2],RL,RN,NZ):-
ext(F,N2),
CN2 is CN+N2,
CN2>NZ,
seq(CL,CN,T2,RL,RN,NZ).


/* ==================================================== */
/*    Source data - Definition of system of cylinders   */
/* ==================================================== */

ext(c1,4).
ext(c2,1).
ext(c3,2).

offset(5).






