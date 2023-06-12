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
:- true(initially,T), T>0, formula(initially).

% finally
true(finally,horizon) :- formula(finally).
:- true(finally,T), T<horizon, formula(finally).

% prev
formula(F) :- formula(prev(F)).
true(F,T-1) :- true(prev(F),T), formula(prev(F)), time(T), time(T-1).
true(prev(F),T) :- true(F,T-1), formula(prev(F)), time(T), time(T-1).
:- true(prev(F),0), formula(prev(F)).

% wprev


% next


% wnext


% eventually
formula(F) :- formula(eventually(F)).

% insert rules below to handle head and body occurance of eventually/1.

% hint: to handle occurances of eventually(F) in the body, we can use
% a conditional literal that ranges over the possible time points in
% which we will derive F to be true

% eventually_before


% always


% always_before


% until
formula(F) :- formula(until(F,G)).
formula(G) :- formula(until(F,G)).

% insert rules below to handle head and body occurance of until/2.

% hint: using Kamp's translation, until is defined as
% [until(A,B)]k: ∃x(k≤x ∧ [B]x ∧ ∀y(k≤y ∧ y<x → [A]y))
% define auxiliary predicate  true(until(A,B),K,X) to have
% the same truth value as (k≤x ∧ [B]x ∧ ∀y(k≤y ∧ y<x → [A]y))

% Then, for body rule derive true(until(A,B),K) from true(until(A,B),K,X).
% And for head rule, encode ∃x: true(until(A,B),K,X) using disjunction.


% release


% while


% since


% trigger

%
% Boolean operators to be used in nested formulas
%

% negation

% and

%
% Defined predicates
%

#defined literal_tuple/1.
#defined literal_tuple/2.
#defined rule/2.
#defined atom_tuple/2.
#defined weighted_literal_tuple/3.
