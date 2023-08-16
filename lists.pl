:- use_module(library(make)).

list_member(X, [X|_]).
list_member(X, [_|XS]) :- list_member(X, XS).

list_length([], 0).
list_length([_|XS], N) :- N1 is N - 1, list_length(XS, N1).

list_concat([],L,L).
list_concat([X1|L1],L2,[X1|L3]) :- list_concat(L1,L2,L3).

range(B, B, [B]).
range(A, B, [A|AS]) :- AX is A + 1, range(AX, B, AS).
