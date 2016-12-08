-module(echo2).
-export([go/0,loop/0]).

go() ->
	register(echo, Pid = spawn(echo2, loop, [])),
	echo ! {self(), hello},
	receive
		{Pid, Msg} ->
			io:format("~w~n",[Msg])
	end.

loop()->
	receive
		{From, Msg} ->
		 	From ! {self(), Msg} ,
		 	loop();
		stop ->
			true
	end.