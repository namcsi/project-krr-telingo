% Note: horizon=7 should give solution.

item(fox;beans;goose).
route(river_bank,far_bank). route(far_bank,river_bank).
eats(fox,goose). eats(goose,beans).

%%% #program initial. %%%

% Initially, everything is at the river bank
at(farmer,river_bank) :- initially.
at(X,river_bank) :- item(X), initially.

%%% #program dynamic. %%%

% Choose moving exactly one item
0 {move(X):item(X)} 1 :- not initially.

% The farmer is always moving
move(farmer) :- not initially.

% Effect axiom for moving
at(X,B) :- prev(at(X,A)), move(X), route(A,B), not initially.

% Items not moved stay where they are
at(X,A) :- prev(at(X,A)), not move(X), not initially.

% The farmer cannot move item X if it is at the opposite bank
:- move(X), item(X), prev(at(farmer,A)), not prev(at(X,A)), not initially.

%%% #program always. %%%

% Neither farmer nor items can be at both banks
:- at(X,A), at(X,B), A<B.

% If an item eats anther items, we cannot leave them alone
:- eats(X,Y), at(X,A), at(Y,A), not at(farmer,A).

%%% #program final. %%%

% Finally, everything has to be at the far bank
:- at(X,river_bank), finally.

% aux atoms for show statement
loc(X) :- route(X,_).
loc(Y) :- route(_,Y).
animal(X) :- item(X).
animal(farmer).

#external prev(at(O,L)) : animal(O), loc(L).
#external initially.
#external finally.

#show show(at(O,L)) : animal(O), loc(L).
#show show(move(O)) : animal(O).
