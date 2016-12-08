-module(hof1).
-export([times/1]).

% doubleAll([]) -> [];
% doubleAll([X | Xs]) -> [X*2 | doubleAll(Xs)].


% map(_F, []) -> [];
% map(F, [X | Xs]) -> [F(X) | map(F,Xs)]. 

% doubleAll(Xs) -> 
% 	map(fun(X) -> X*2 end, Xs).

% foreach(_F, []) ->
% 	ok;
% foreach(F, [X|Xs]) ->
% 	F(X),
% 	foreach(F, Xs).

% evens([]) -> [];
% evens([X | Xs]) -> 
% 	case X rem 2 == 0 of
% 		true -> 
% 			[X | evens(Xs)];
% 		_ ->
% 			evens(Xs)
% 	end.

times(X) ->
	fun(Y) -> X*Y end.
