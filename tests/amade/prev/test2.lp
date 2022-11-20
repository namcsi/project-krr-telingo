a :- initially.
a  :- prev(a), not initially.
prev(c)  :-  a, not initially.
#external initially.
#external finally.
#external prev(a).
#external prev(c).
#show show(a).
#show show(c).