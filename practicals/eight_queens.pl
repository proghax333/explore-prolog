
:- use_module(library(clpfd)).

eight_queens(Solution) :-
        n_queens(8, Solution),
        label(Solution).

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

go :-
        eight_queens(Qs),
        write(Qs).

/*
Output:

?- go.
[1,5,8,6,3,7,2,4]
true ;
[1,6,8,3,7,4,2,5]
true ;
[1,7,4,6,8,2,5,3]
true ;
[1,7,5,8,2,4,6,3]
true .

*/
