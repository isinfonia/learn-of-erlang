-module(t3).
-export([p/1]).

p(N) -> io:format("Number:~p~n",[solve(N,2)]).

% solve(N, Index)	->
% 	if
% 		N >= Index	->	[Index | solve(N, Index + 2)];
% 		true		->	[]
% 	end.

solve(N, Index)	when N >= Index	->	[Index | solve(N, Index + 2)];
solve(N, Index) when N <  Index ->	[].
