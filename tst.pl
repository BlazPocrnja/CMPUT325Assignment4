/*
CMPUT 325 Assignment 3
Author: Arash Karimi

You can test your code based on the following testcases.
Just copy and paste it at the beginning of your code and call head predicates from terminal.

1: You can try different control options (in labeling/2) and check (and compare) the runtime
of your program using the given helper functions: p1T/2 and p2T/1.

2: You will be docked marks if your code runs "considerably slowly" compared to our runtime 
results shown in the testcase.

*/

:- use_module(library(clpfd)).

%% Q1

%tc1
tc1(Var) :- fourSquares(20, Var).
%Var = [0, 0, 2, 4] ;
%Var = [1, 1, 3, 3] ;
%false.

%tc2
tc2(Var) :- fourSquares(-20, Var).
%false.

%tc3
tc3(Var) :- fourSquares(1, Var).
%Var = [0, 0, 0, 1].

p1T(N,V) :- statistics(runtime,[T0|_]),
	fourSquares(N,V),
	statistics(runtime, [T1|_]),
	T is T1 - T0,
	format('fourSquares/2 takes ~3d sec.~n', [T]).
%% Q2

%tc4
p1(S) :- disarm([1,3,3,4,6,10,12],[3,4,7,9,16],S).
%S = [[[1, 3], [4]], [[3, 6], [9]], [[10], [3, 7]], [[4, 12], [16]]].

p2 :- disarm([],[],[]).
%true.

p3(S) :- disarm([1,2,3,3,8,5,5],[3,6,4,4,10],S).
%S = [[[1, 2], [3]], [[3, 3], [6]], [[8], [4, 4]], [[5, 5], [10]]].


p4(S) :- disarm([1,2,2,3,3,8,5],[3,2,6,4,4,10],S).
%false.

p5(S) :- disarm([1,2,2,3,3,8,5,5,6,7],[3,2,6,4,4,10,1,5,2],S).
%false.

p6(S) :- disarm([1,2,2,116,3,3,5,2,5,8,5,6,6,8,32,2],[3,5,11,4,37,1,4,121,3,3,14],S).
%S = [[[1, 2], [3]], [[2, 2], [4]], [[2, 3], [5]], [[5], [4, 1]], [[6], [3, 3]], [[3, 8], [11]], [[6|...], [...]], [[...|...]|...], [...|...]].


p2T(S) :- statistics(runtime,[T0|_]),
	p6(S),
	statistics(runtime, [T1|_]),
	T is T1 - T0,
	format('p6/1 takes ~3d sec.~n', [T]).
%p6/1 takes 10.532 sec.
%S = [[[1, 2], [3]], [[2, 2], [4]], [[2, 3], [5]], [[5], [4, 1]], [[6], [3, 3]], [[3, 8], [11]], [[6|...], [...]], [[...|...]|...], [...|...]].