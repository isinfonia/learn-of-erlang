-module(modtest2).
-export([main/0, loop/0, a/1, do/1]).

main() ->
	register(foo, spawn(modtest2, loop, [])).

loop() ->
	receive
		{Sender, N} ->
			Sender ! a(N)
	end,
	io:put_chars("boo! ~n"),
	modtest2:loop().

do(N) ->
	foo ! {self(), N},
	receive Y -> Y end.

a(N) -> N.