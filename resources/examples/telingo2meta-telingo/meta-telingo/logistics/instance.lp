% From AIPS competition aipslog01.pddl
% https://github.com/SoarGroup/Domains-Planning-Domain-Definition-Language/tree/master/pddl
% length parallel 9

city(pgh;bos;la).
package(pack1;pack2;pack3).
airplane(plane1;plane2).

goal_at(pack1,po(bos)).
goal_at(pack2,po(la)).
goal_at(pack3,po(bos)).

%%% #program initial %%%

% Each city has a central, an airport, a post office and a truck initially there

in_city((central(C);airport(C);po(C)),C):- city(C), initially.
truck(truck(C)) :- city(C), initially.
at(truck(C),po(C)) :- city(C), initially.

airport(airport(C)) :- city(C), initially.

at(P,po(pgh)) :- package(P), initially.

at((plane1;plane2),airport(pgh)) :- initially.
