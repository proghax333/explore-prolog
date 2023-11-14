
go :-
  start(Start),
  solve(Start, P),
  reverse(P, L),
  print(L).

% solve( Node, Solution):
%    Solution is an acyclic path (in reverse order) between Node and a goal
solve( Node, Solution)  :-
  depthfirst( [], Node, Solution).


% depthfirst( Path, Node, Solution):
%   extending the path [Node | Path] to a goal gives Solution
depthfirst( Path, Node, [Node | Path] )  :-
   goal( Node).

depthfirst( Path, Node, Sol)  :-
  next_state( Node, Node1),
  \+ member( Node1, Path),                % Prevent a cycle
  depthfirst( [Node | Path], Node1, Sol).

start((0, 0)).

% the goal state is to measure 2 gallons of water:
goal((4, _)).
goal((_, 4)).

% fill up the 5-gallon jug if it is not already filled:
next_state((X, Y), (5, Y)) :- X < 5.

% fill up the 3-gallon jug if it is not already filled:
next_state((X, Y), (X, 3)) :- Y < 3.

% if there is water in the 3-gallon jug Y > 0) and there is room in the 5-gallon jug (X < 5) THEN use it to fill up
% the 5-gallon jug until it is full (5-gallon jug = 5 in the new state) and leave the rest in the 3-gallon jug:
next_state((X, Y), (5, Z)) :- Y > 0, X < 5,
                  Aux is X + Y, Aux >= 5,
                  Z is Y - (5 - X).

% if there is water in the 5-gallon jug (X > 0) and there is room in the 3-gallon jug (Y < 3) THEN use it to fill up
% the 3-gallon jug until it is full (3-gallon jug = 3 in the new state) and leave the rest in the 5-gallon jug:
next_state((X, Y), (Z, 3)) :- X > 0, Y < 3,
                  Aux is X + Y, Aux >= 3,
                  Z is X - (3 - Y).

% there is something in the 3-gallon jug (Y > 0) and together with the amount in the 5-gallon jug it fits in the
% 5-gallon jug (Aux is X + Y, Aux =< 5) THEN fill it all (Y is 0 in the new state) into the 5-gallon jug (Z is Y + X):
next_state((X, Y),(Z, 0)) :- Y > 0,
                 Aux is X + Y, Aux =< 5,
                 Z is Y + X.

% there is something in the 5-gallon jug (X > 0) and together with the amount in the 3-gallon jug it fits in the
% 3-gallon jug (Aux is X + Y, Aux =< 3) THEN fill it all (X is 0 in the new state) into the 3-gallon jug (Z is Y + X):
next_state((X, Y),(0, Z)) :- X > 0,
                 Aux is X + Y, Aux =< 3,
                 Z is Y + X.

% empty the 5-gallon jug IF it is not already empty (X > 0):
next_state((X, Y), (0, Y)) :- X > 0.

% empty the 3-gallon jug IF it is not already empty (Y > 0):
next_state((X, Y), (X, 0)) :- Y > 0.

print([]).
print([H|T]):-write(H),nl,print(T).

/*
Output:

?- go.
0,0
5,0
5,3
0,3
3,0
3,3
5,1
0,1
1,0
1,3
4,0
true ;
0,0
5,0
5,3
0,3
3,0
3,3
5,1
0,1
1,0
1,3
4,0
4,3
true .

*/
