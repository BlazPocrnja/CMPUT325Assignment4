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
disarm([],[],[]).
disarm(Adivisions, Bdivisions, Solution) :-
	Vars = [X1,X2,X3],
	Vars ins inf..sup,
	X1+X2 #= X3,

	((select(X1, Adivisions, Ad), select(X2, Ad, NextAdiv), select(X3, Bdivisions, NextBdiv)) ;
	(select(X1, Bdivisions, Bd), select(X2, Bd, NextBdiv), select(X3, Adivisions, NextAdiv))),

	subtract_once(Adivisions, NextAdiv, ThisA),
	subtract_once(Bdivisions, NextBdiv, ThisB),
	
	disarm(NextAdiv, NextBdiv, RestSolution),
	append([[ThisA,ThisB]], RestSolution, Solution).




subtract_once(List, [], List).
subtract_once(List, [Item|Delete], Result):-
  (select(Item, List, NList)->
    subtract_once(NList, Delete, Result);
    (List\=[],subtract_once(List, Delete, Result))).