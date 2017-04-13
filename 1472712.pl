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
	Vars ins 0..N,
	N #= S1*S1 + S2*S2 + S3*S3 + S4*S4,
	S1 #=< S2, S2 #=< S3, S3 #=< S4,
	label([S1, S2, S3, S4]).


/*	Question 2
*/
disarm(Adivisions, Bdivisions, Solution) :- disarm(Adivisions, Bdivisions, Solution, 0).

disarm([],[],[],_).

disarm(Adivisions, Bdivisions, [[[X1,X2],[X3]] |RestSolution], LastSum) :-
	append(Adivisions,Bdivisions, Divisions),
	min_list(Divisions, VarMin),
	max_list(Divisions, VarMax),

	Vars = [X1,X2,X3],
	Vars ins VarMin..VarMax,
	X1 #=< X2,
	X1+X2 #= X3,
	LastSum #=< X3,

	select(X1, Adivisions, Ad),
  	select(X2, Ad, NextAdiv),
  	select(X3, Bdivisions, NextBdiv),

	disarm(NextAdiv, NextBdiv, RestSolution, X3). 

disarm(Adivisions, Bdivisions, [[[X3],[X1,X2]] |RestSolution], LastSum) :-
	append(Adivisions,Bdivisions, Divisions),
	min_list(Divisions, VarMin),
	max_list(Divisions, VarMax),

	Vars = [X1,X2,X3],
	Vars ins VarMin..VarMax,
	X1 #=< X2,
	X1+X2 #= X3,
	LastSum #=< X3,

	select(X1, Bdivisions, Bd),
  	select(X2, Bd, NextBdiv),
  	select(X3, Adivisions, NextAdiv),

	disarm(NextAdiv, NextBdiv, RestSolution, X3). 



