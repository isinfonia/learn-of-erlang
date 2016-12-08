-module(t5).
-export([filter/2, reverse/1, concatenate/1,flatten/1]).

filter([Head | Tail], N) ->
	if
		Head =< N	->	[Head | filter(Tail, N)];
		true		-> 	filter(Tail,N)
	end;
filter([], _N)	-> 	[].

reverse(List)	->	reverse_acc(List, []).
reverse_acc([Head | Tail], Acc)	->	reverse_acc(Tail, [Head | Acc]);
reverse_acc([], Acc)	->	Acc.

concatenate([])	->	[];
concatenate([Head | Tail])	->	Head ++ concatenate(Tail).

flatten([])	->	[];
flatten([Head | Tail]) 	->
	if
		is_list(Head) ->
			flatten(Head) ++ flatten(Tail);
		true ->
			[Head|flatten(Tail)]
	end.
