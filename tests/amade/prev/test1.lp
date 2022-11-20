a :- initially.
a  :- prev(a).
c  :- prev(prev(a)).
 :-  not c, finally.
#show show(a).
#show show(c).
#external initially.
#external finally.
#external prev(a).
#external prev(prev(a)).