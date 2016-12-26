-module(t5).
-export([fab/1]).

fab(0) -> 1;
fab(1) -> 1;
fab(N) -> 
	if 
		N >= 0 -> fab(N-1) + fab(N-2);
		true -> error
	end.
