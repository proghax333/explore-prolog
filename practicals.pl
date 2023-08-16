:- use_module(library(clpfd)).

% Helpers
list_at_helper([X|XS], N, I, Result) :-
  (I = N, Result is X);
  (
    IS is I + 1,
    list_at_helper(XS, N, IS, Result)
  )
  .

list_at(XS, N, Result) :- list_at_helper(XS, N, 0, Result).



% 8 queens


n_queens(N, Qs) :-
        length(Qs, N),
        Qs ins 1..N,
        safe_queens(Qs).

safe_queens([]).
safe_queens([Q|Qs]) :- safe_queens(Qs, Q, 1), safe_queens(Qs).

safe_queens([], _, _).
safe_queens([Q|Qs], Q0, D0) :-
        Q0 #\= Q,
        abs(Q0 - Q) #\= D0,
        D1 #= D0 + 1,
        safe_queens(Qs, Q0, D1).

