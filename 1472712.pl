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
	Vars = [X1,X2,X3,X4],
	Vars ins inf..sup,
	X1+X2 #= X3,
	X3 #=< X4,

	((select(X1, Adivisions, Ad), select(X2, Ad, NextAdiv), select(X3, Bdivisions, NextBdiv)) ;
	(select(X1, Bdivisions, Bd), select(X2, Bd, NextBdiv), select(X3, Adivisions, NextAdiv))),

	subtract_once(Adivisions, NextAdiv, ThisA),
	subtract_once(Bdivisions, NextBdiv, ThisB),
	
	disarm(NextAdiv, NextBdiv, RestSolution),
	%((RestSolution = [[NextA,_] |_] , sum(NextA, #=, X4)) ; (RestSolution = [])),
	append([[ThisA,ThisB]], RestSolution, Solution).
*/
/*
disarm([],[],[]).
disarm(Adivisions, Bdivisions, Solution) :-
	/*
	Lengths = [ALen, BLen],
	Lengths ins 0..sup,
	ALen #\= BLen,

	length(Adivisions, ALen),
	length(Bdivisions, BLen),
	*/

	min_list(Adivisions, AMin),
	min_list(Bdivisions, BMin),
	max_list(Adivisions, AMax),
	max_list(Bdivisions, BMax),

	VarMin is min(AMin,BMin),
	VarMax is max(AMax,BMax),
	

	Vars = [X1,X2,X3,X4],
	Vars ins VarMin..VarMax,
	X1+X2 #= X3,
	X3 #=< X4,

	(NextA = [_,_] ; NextA = [_]),
	sum(NextA, #=, X4),
	labeling([ff],Vars),

	(	(select(X3, Bdivisions, NextBdiv), select(X1, Adivisions, Ad), select(X2, Ad, NextAdiv)) 
		;
		(select(X3, Adivisions, NextAdiv), select(X1, Bdivisions, Bd), select(X2, Bd, NextBdiv))
	),

	disarm(NextAdiv, NextBdiv, RestSolution),
	((RestSolution = []) ; (RestSolution = [[NextA,_] |_])),

	subtract_once(Adivisions, NextAdiv, ThisA),
	subtract_once(Bdivisions, NextBdiv, ThisB),
	append([[ThisA,ThisB]], RestSolution, Solution).
*/
disarm([],[],[]).

/*
disarm([A,B],[C], S) :- 
	plus(A,B,C),
	S = [[A,B], [C]] ; S = [[B,A], [C]].

disarm([A],[B,C], S) :- 
	plus(B,C,A),
	S = [[A], [B,C]] ; S = [[A], [C, B]].
*/

disarm(Adivisions, Bdivisions, Solution) :-
	append(Adivisions,Bdivisions, Divisions),
	min_list(Divisions, VarMin),
	max_list(Divisions, VarMax),

	Vars = [X1,X2,X3],
	NextVars = [X4,X5,X6],

	Vars ins VarMin..VarMax,
	NextVars ins VarMin..VarMax,

	X1+X2 #= X3,
	X4+X5 #= X6,
	X3 #=< X6,

	(	(select(X3, Bdivisions, NextBdiv), select(X1, Adivisions, Ad), select(X2, Ad, NextAdiv)) 
		;
		(select(X3, Adivisions, NextAdiv), select(X1, Bdivisions, Bd), select(X2, Bd, NextBdiv))
	),

	subtract_once(Adivisions, NextAdiv, ThisA),
	subtract_once(Bdivisions, NextBdiv, ThisB),

	((NextA = [X4,X5] , NextB = [X6]) ; (NextB = [X4,X5] , NextA = [X6])),

	(my_subset(NextAdiv, NextA) ; NextAdiv = []),
 	(my_subset(NextBdiv, NextB) ; NextBdiv = []),

	NextMonth = [NextA, NextB],
	(RestSolution = [] ; RestSolution = [ NextMonth | _]),

	disarm(NextAdiv, NextBdiv, RestSolution),
	append([[ThisA,ThisB]], RestSolution, Solution).

my_subset([], []).
my_subset([E|Tail], [E|NTail]):-
  my_subset(Tail, NTail).
my_subset([_|Tail], NTail):-
  my_subset(Tail, NTail).

subtract_once(List, [], List).
subtract_once(List, [Item|Delete], Result):-
  (select(Item, List, NList)->
    subtract_once(NList, Delete, Result);
    (List\=[],subtract_once(List, Delete, Result))).