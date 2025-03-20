/* ================================================= */
/*    PROLOG-based representation of Automaton A3    */
/* ================================================= */

state(s0).
state(s1).

transition(t1,s0,s1,b,0).
transition(t2,s0,s0,o,999).
transition(t3,s1,s0,b,0).
transition(t4,s1,s1,g,2).

initial_state(s0).