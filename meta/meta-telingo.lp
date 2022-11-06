%
% Meta-encoding using hold(A,T)
%
% In our meta-encoding input we consider rules of the input program to
% apply for all time points of a trace. That is, using temporal logic
% terminology, rules are interpreted as being encosed in an always
% operator; or, using telingo's input language, as being under the
% subprogram #always.
%
% This property can be seen encoded in the rules below.
%

conjunction(B,T) :- literal_tuple(B), time(T),
        hold(L,T) : literal_tuple(B, L), L > 0;
    not hold(L,T) : literal_tuple(B,-L), L > 0.

body(normal(B),T) :- rule(_,normal(B)), conjunction(B,T), time(T).
body(sum(B,G),T)  :- rule(_,sum(B,G)), time(T),
    #sum { W,L :     hold(L,T), weighted_literal_tuple(B, L,W), L > 0 ;
           W,L : not hold(L,T), weighted_literal_tuple(B,-L,W), L > 0 } >= G.

  hold(A,T) : atom_tuple(H,A)   :- rule(disjunction(H),B), body(B,T), time(T).
{ hold(A,T) : atom_tuple(H,A) } :- rule(     choice(H),B), body(B,T), time(T).

time(0..horizon).

#show.
#show (S,T) : output(show(S),_), true(S,T).


%
% Connect true/2 with hold/2
%

true(O,T) :- hold(L,T), output(O,B), literal_tuple(B,L).
hold(L,T) :- true(O,T), output(O,B), literal_tuple(B,L).

%
% the next rule is also needed to represent the facts
%  O.
% of the input logic program, for which clingo generates
%  output(O,0).
% and no literal_tuple of the form literal_tuple(0,L)
%
% 
true(O,T) :- time(T), output(O,B), not literal_tuple(B,_).

%
% Temporal connectives using true/2
%

% formulas
formula(O) :- output(O,_).

% initially
true(initially,0) :- formula(initially).

% finally
true(finally,horizon) :- formula(finally).

% prev
formula(F) :- formula(prev(F)).
true(prev(F),T) :- true(F,T-1), formula(prev(F)), time(T), time(T-1).

% wprev


% next


% wnext


% eventually


% eventually_before


% always


% always_before


% until


% release


% while


% since


% trigger


%
% Defined predicates
%

#defined literal_tuple/1.
#defined literal_tuple/2.
#defined rule/2.
#defined atom_tuple/2.
#defined weighted_literal_tuple/3.
