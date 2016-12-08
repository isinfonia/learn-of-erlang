-module(t2).
-export([create/1,reverse_create/1]).

reverse_create(N) -> 
	if
		N > 0 	-> 	[N | reverse_create(N-1)];
		true 	->	[]
	end.

create(N) -> r_c_a(N, 1).

r_c_a(N, Index) ->
	if
		N >= Index	->	[Index | r_c_a(N, Index + 1)];
		true 		-> 	[]
	end.