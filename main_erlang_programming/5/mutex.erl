-module(mutex).
-export([start/0, stop/0]).
-export([wait/0, signal/0]).
-export([init/0]).

start() ->
	register(mutex, spawn(mutex, init, [])).

stop() ->
	mutex ! stop.

wait() ->
	mutex ! {wait, self()},
	receive  ok -> ok end.

signal() ->
	mutex ! {signal, self()},
	ok.

init() ->
	free().

% FSM
free() ->
	receive 
		{wait, Pid} ->
			Pid ! ok,
			busy(Pid);
		stop ->
			terminal()
	end.

busy(Pid) ->
	receive
		{signal, Pid} ->
			free()
	end.

terminal() ->
	receive
		{wait, Pid} ->
			exit(Pid, kill),
			terminal()
	after
		0 -> ok
	end.


	