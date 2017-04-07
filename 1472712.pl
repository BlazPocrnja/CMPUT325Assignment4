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

