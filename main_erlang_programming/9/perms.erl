-module(perms).
-export([perms/1]).

perms([]) ->
	[[]];
perms([X|Xs]) ->
	[insert(X, As, Bs) || Ps <- perms(Xs), {As, Bs} <- splits(Ps)].

splits([]) ->
	[{[], []}];
splits([X|Xs] = Ys) ->
	[ {[],Ys} | [ { [X|As] , Bs} || {As, Bs} <- splits(Xs) ] ].

insert(X, As, Bs) ->
	lists:append([As, [X], Bs]).