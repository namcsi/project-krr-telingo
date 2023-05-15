% From AIPS competition aipslog01.pddl
% https://github.com/SoarGroup/Domains-Planning-Domain-Definition-Language/tree/master/pddl
% length parallel 9
% --- #program always. ---
city(pgh;bos;la).
airplane(plane1;plane2).
package(pack1;pack2;pack3).
truck(truck(C)) :- city(C).
airport(airport(C)) :- city(C).
in_city((central(C); airport(C); po(C)),C) :- city(C).

% --- #program initial. ---

% Each city has a central, an airport, a post office and a truck initially there
at(truck(C),po(C)) :- city(C), initially.
at(P,po(pgh)) :- package(P), initially.
at((plane1;plane2),airport(pgh)) :- initially.

% --- #program final. ---
goal_at(pack1,po(bos)) :- finally.
goal_at(pack2,po(la))  :- finally.
goal_at(pack3,po(bos)) :- finally.
