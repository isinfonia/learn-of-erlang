-module(t1).
-export([sum/1,sum/2]).

sum(N) ->
	if
		N > 0 -> 	N + sum(N-1);
		N =< 0 ->	0
	end.

sum(N, M) -> 
	if
		N =< M -> N + sum(N + 1, M);
		N > M -> 0
	end.