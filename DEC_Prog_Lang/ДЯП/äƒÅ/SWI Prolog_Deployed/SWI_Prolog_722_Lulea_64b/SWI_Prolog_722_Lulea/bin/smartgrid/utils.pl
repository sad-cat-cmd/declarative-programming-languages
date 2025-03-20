get_id(Id):- 
count_id(X), 
X1 is X+1, 
retract(count_id(X)), 
assert(count_id(X1)), 
string_concat('i',X,Id).			