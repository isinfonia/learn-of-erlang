-module(t1).
-export([start/0,print/1,stop/0,loop/0]).

start() ->
	Pid = spawn(t1, loop, []),
	register(t1echo, Pid),
	t1echo ! {print, "Hello world"},
	ok.

loop()->
	receive
		{print, Msg} ->
		 	io:format("~p~n",[Msg]),
		 	loop();
		stop ->
			true
	end.

print(Msg) ->
	t1echo ! {print,Msg},
	ok.

stop() ->
	t1echo ! stop,
	ok.

