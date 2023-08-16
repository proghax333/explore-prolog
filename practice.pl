% Utilities

list_first([X|_], X).

list_length([], 0).
list_length([_], 1).
list_length([_|XS], N) :- p4_list_length(XS, NS), N is NS + 1.

list_empty([]).

list_repeat(_, 0, []).
list_repeat(X, N, Result) :-
  NS is N - 1,
  list_repeat(X, NS, P),
  append([X], P, Result).

list_extract(XS, XS).



%%%   --[  Problems  ]--   %%%

% p1: Find the last element of a list
p1_last_list_element([X], X).
p1_last_list_element([_|XS], N) :- p1_last_list_element(XS, N).


% p3: Find the K'th element of a list
p3_helper(P, [X|XS], Y, I) :- (Y = I, P is X); (IS is I + 1, p3_helper(P, XS, Y, IS)).

p3_find_kth(P, XS, Y) :- p3_helper(P, XS, Y, 1).


% p4: Find the number of elements
p4_list_length([], 0).
p4_list_length([_], 1).
p4_list_length([_|XS], N) :- p4_list_length(XS, NS), N is NS + 1.


% p5: Reverse a list
p5_list_reverse([], L, L).
p5_list_reverse([X|XS], LS, Acc) :- p5_list_reverse(XS, LS, [X|Acc]).


% p6: Check if the list is a palindrome.
p6_list_equals([], []).
p6_list_equals([X1|L1], [X2|L2]) :- X1 = X2, p6_list_equals(L1, L2).
p6_is_list_palindrome(L1) :- p5_list_reverse(L1, L2, []), p6_list_equals(L1, L2).


% p7: Flatten a nested list structure.
p7_flatten_list([], []).
p7_flatten_list([X|XS], Result) :-
  (is_list(X),
    p7_flatten_list(X, P),
    p7_flatten_list(XS, Q),
    append(P, Q, Result)
  );
  (not(is_list(X)),
    p7_flatten_list(XS, P),
    append([X], P, Result)
  ).


% p8: Eliminate consecutive duplicates of list elements.

p8_helper([], []).
p8_helper([X], [X]).
p8_helper([X|XS], Result) :- list_first(XS, First), 
  (
    (X = First, p8_helper(XS, Result));
    (
      p8_helper(XS, P),
      append([X], P, Result)
    )
  ).

p8_compress(XS, Result) :- p8_helper(XS, Result).


% p9: Pack consecutive duplicates of list elements into sublists.
p9_combine([X], [X], []).
p9_combine([], [], []).
p9_combine([X|XS], Result, Rest) :-
  list_first(XS, Next),
  (
    (
      Next = X,
      p9_combine(XS, P, Rest),
      append([X], P, Result)
    );
    append([X], [], Result),
    append(XS, [], Rest)
  ).

p9_pack([], []).
p9_pack([X], [[X]]).
p9_pack(XS, Result) :-
  p9_combine(XS, P, Rest),
  p9_pack(Rest, Q),
  append([P], Q, Result).


% p10: Run-length encoding of a list
p10_helper([], []).
p10_helper([X|XS], Result) :-
  list_first(X, First),
  list_length(X, Length),
  p10_helper(XS, P),
  append([[Length, First]], P, Result)
  .

p10_encode(XS, Result) :-
  p9_pack(XS, P),
  p10_helper(P, Result).


% p11: Modified run length encoding
p11_helper([], []).
p11_helper([X|XS], Result) :-
  list_first(X, First),
  list_length(X, Length),
  p11_helper(XS, P),

  (
    (
      Length =:= 1,
      append([First], P, Result)
    );
    (
      append([[Length, First]], P, Result)
    )
  )
  .

p11_encode_modified(XS, Result) :-
  p9_pack(XS, P),
  p11_helper(P, Result).


% Decode a run-length encoded list.

p12_helper([], []).
p12_helper([X|XS], Result) :-
  p12_helper(XS, P),
  (
    (
      is_list(X),
      list_extract(X, [Length, Letter]),
      list_repeat(Letter, Length, Repeated),
      append(Repeated, P, Result)
    );
    append([X], P, Result)
  )
  .

p12_decode_run_length(XS, Result) :- p12_helper(XS, Result).


% p13: Run-length encoding of a list (direct solution).
p13_count([], [], 0).
p13_count([_], [], 1).
p13_count([X|XS], Rest, Result) :-
  list_first(XS, Next),
  (
    (
      X = Next,
      p13_count(XS, P, Q),
      Result is Q + 1,
      append(P, [], Rest)
    );
    (
      Result is 1,
      append(XS, [], Rest)
    )
  )
  .

p13_encode_direct([], []).
p13_encode_direct([X|XS], Result) :-
  p13_count([X|XS], Rest, Count),
  p13_encode_direct(Rest, Q),

  (
    (
      Count = 1,
      append([X], Q, Result)
    );
    (
      append([[Count, X]], Q, Result)
    )
  )
  .


% p14: Duplicate the elements of a list.
p14_dupli([], []).
p14_dupli([X|XS], Result) :-
  p14_dupli(XS, P),
  list_repeat(X, 2, Dups),
  append(Dups, P, Result)
  .


% p15: Duplicate the elements of a list a given number of times.
p15_dupli([], _, []).
p15_dupli([X|XS], N, Result) :-
  p15_dupli(XS, N, P),
  list_repeat(X, N, Dups),
  append(Dups, P, Result)
  .

