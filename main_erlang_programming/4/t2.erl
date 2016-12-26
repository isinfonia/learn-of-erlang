-module(t2).
-export([]).

start(M,N,Msg) ->
  Name = 92,
  process(N, [Name]),

process(N, [Name]) ->
  spawn(t2, loop, [N, Name]),
  process(N-1, [A+1]);
process(0, _) ->
  io:format("All processes are started!~n",[]).

loop()


loop(M, N, Msg, Pid) ->
  if
    N > 0 -> NPid = spawn(t2, loop, [M-1, N-1, Pid]),
  NPid ! Msg,
  receive
    stop -> true;
    Msg -> io:format("~p~n",[Msg]);
  end.

start(Num) ->
  start_proc(Num, self()).

start_proc(0, Pid) ->
  Pid ! ok;
start_proc(Num, Pid) ->
  NPid = spawn(myring, start_proc, [Num-1, Pid]),
  NPid ! ok,
  receive ok -> ok end.