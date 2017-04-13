/*
CMPUT 325 Assignment 4
Author: Blaz Pocrnja
Student ID: 1472712
*/

:- use_module(library(clpfd)).

/*	Question 1
	
	fourSquares(+N, [-S1, -S2, -S3, -S4])

	Given any positive integer N greater than 0, it returns a list of 
	non-negative integers [S1,S2,S3,S4] such that the sum of their squares is N.

	e.g.	fourSquares(20, Var).
			-> Var = [0, 0, 2, 4] ;
			-> Var = [1, 1, 3, 3] .

*/
fourSquares(N, [S1, S2, S3, S4]) :- 
	Vars = [S1, S2, S3, S4],
	Vars ins 0..N,
	N #= S1*S1 + S2*S2 + S3*S3 + S4*S4,
	S1 #=< S2, S2 #=< S3, S3 #=< S4,
	label([S1, S2, S3, S4]).


/*	Question 2
	
	disarm(+Adivisions, +Bdivisions,-Solution)

	Where Adivisions and Bdivisions are lists containing the strength of each 
	countrys divisions, and Solution is a list describing the successive dismantlements.

	A dismantlement is a list containing two elements: the first element is a list 
	of country A's dismantlements and the second is a list of country B's dismantlements, which
	must be equal in strength. The total strength of one month's dismantlement is less than or 
	equal to the total strength of next month's dismantlement.

	e.g. 	disarm([1,3,3,4,6,10,12],[3,4,7,9,16],S).
			-> S = [[[1, 3], [4]], [[3, 6], [9]], [[10], [3, 7]], [[4, 12], [16]]].

*/
disarm(Adivisions, Bdivisions, Solution) :- disarm(Adivisions, Bdivisions, Solution, 0).

disarm([],[],[],_).

/*
	disarm/4 

	Added an extra parameter LastSum, which keeps track of the total power of the previous
	dismantlement.

	Returns true if A dismantles 2 divisions, and B dismantles 1 with the given constraints.
*/
disarm(Adivisions, Bdivisions, [[[X1,X2],[X3]] |RestSolution], LastSum) :-
	%The lower and upper bounds for the variables domain must be the min and max values 
	% of the given divisions lists, respectively.
	append(Adivisions,Bdivisions, Divisions),
	min_list(Divisions, VarMin),
	max_list(Divisions, VarMax),

	Vars = [X1,X2,X3],
	Vars ins VarMin..VarMax,

	%The sum of a country's dismantlement of two divisions must be equal to the other's single dismantlement.
	X1 #=< X2,
	X1+X2 #= X3,

	%The total power dismantlement of last month has to be less than or equal to the current dismantlement.
	LastSum #=< X3,

	%Remove selected divisions out of both Adivisions and Bdivisions.
	select(X1, Adivisions, Ad),
  	select(X2, Ad, NextAdiv),
  	select(X3, Bdivisions, NextBdiv),

  	%Disarm the rest, using X3 as the sum to compare to the next dismantlement.
	disarm(NextAdiv, NextBdiv, RestSolution, X3). 

/*	
	Similar to above, except returns true if B dismantles 2 divisions, 
	and A dismantles 1 with the given constraints.
*/
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



