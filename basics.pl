:- use_module(library(make)).

girl(priya).
girl(tiyasha).
girl(jaya).
can_cook(priya).

parent(alex, bob).
parent(bob, cameron).

predecessor(X, Z) :- parent(X, Z).
predecessor(X, Z) :- parent(X, Y),predecessor(Y, Z).

is_prime_helper(N, I) :-
    (I * I =< N,
      (N mod I =\= 0, P is I+1, is_prime_helper(N, P))
    );
    (I * I > N, true).

is_prime(N) :-
  (N =< 1, fail);
  (N > 1, is_prime_helper(N, 2)).

