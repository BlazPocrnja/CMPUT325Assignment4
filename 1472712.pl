/*
CMPUT 325 Assignment 4
Author: Blaz Pocrnja
Student ID: 1472712
*/

:- use_module(library(clpfd)).

/*	Question 1
*/
fourSquares(N, [S1, S2, S3, S4]) :- 
	Vars = [S1, S2, S3, S4],
	Vars ins 0..sup,
	N #= S1*S1 + S2*S2 + S3*S3 + S4*S4,
	S1 #=< S2, S2 #=< S3, S3 #=< S4,
	label([S1, S2, S3, S4]).


/*	Question 2
*/
/*
disarm([],[],[]).
disarm(Adivisions, Bdivisions, Solution) :- 
	Solution = [ThisMonth, NextMonth | Rest],
	ThisMonth = [ThisA, ThisB],
	NextMonth = [NextA, NextB],

	Lengths = [ALen, BLen, NALen, NBLen],
	Lengths ins 1..2,
	ALen #\= BLen,
	NALen #\= NBLen,

	length(ThisA, ALen), 
	length(ThisB, BLen),
	length(NextA, NALen), 
	length(NextB, NBLen),

	ThisA ins inf..sup,
	ThisB ins inf..sup,
	NextA ins inf..sup,
	NextB ins inf..sup,

	Sums = [Sum1,Sum2],
	Sums ins inf..sup,
	Sum1 #=< Sum2,

	sum(ThisA, #=, Sum1),
	sum(ThisB, #=, Sum1),
	sum(NextA, #=, Sum2),
	sum(NextB, #=, Sum2),

	subset(ThisA, Adivisions),
	subset(ThisB, Bdivisions),

	subtract_once(Adivisions, ThisA, NextAdiv),
	subtract_once(Bdivisions, ThisB, NextBdiv),

	disarm(NextAdiv, NextBdiv, [NextMonth | Rest]).
*/

disarm([],[],[]).
disarm(Adivisions, Bdivisions, Solution) :- 
	ThisMonth = [ThisA, ThisB],
	NextMonth = [NextA, NextB],

	Lengths = [ALen, BLen, NALen, NBLen],
	Lengths ins 1..2,
	ALen #\= BLen,
	NALen #\= NBLen,

	length(ThisA, ALen), 
	length(ThisB, BLen),
	length(NextA, NALen), 
	length(NextB, NBLen),

	ThisA ins inf..sup,
	ThisB ins inf..sup,
	NextA ins inf..sup,
	NextB ins inf..sup,

	Sums = [Sum1,Sum2],
	Sums ins inf..sup,
	Sum1 #=< Sum2,

	sum(ThisA, #=, Sum1),
	sum(ThisB, #=, Sum1),
	sum(NextA, #=, Sum2),
	sum(NextB, #=, Sum2),

	subset(ThisA, Adivisions),
	subset(ThisB, Bdivisions),

	subtract_once(Adivisions, ThisA, NextAdiv),
	subtract_once(Bdivisions, ThisB, NextBdiv),

	disarm(NextAdiv, NextBdiv, [NextMonth | Rest]),
	append([ThisMonth], [NextMonth|Rest], Solution).





subtract_once(List, [], List).
subtract_once(List, [Item|Delete], Result):-
  (select(Item, List, NList)->
    subtract_once(NList, Delete, Result);
    (List\=[],subtract_once(List, Delete, Result))).