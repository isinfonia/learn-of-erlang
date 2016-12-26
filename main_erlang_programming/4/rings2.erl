-module(rings2).
-export([start/3,loop/2]).
 
%%第一种方法。。先用一个进程创建进程环，并启动消息发送
 
%%调用PROCESS/2创建进程环，并启动消息发送。
start(N,M,Msg)->
    A=97,
    io:format("Pid is ~p.~n",[self()]),   
    process(N,[A]),
    list_to_atom([A]) ! {start,M,Msg}.          %%启动消息发送
 
  %% 创建进程环的函数
process(N,[A]) when N>0 ->
    spawn(rings2,loop,[N,A]),
    process(N-1,[A+1]);
process(0,_)->
    io:format("All processes is started!\n",[]).
 
 
%%进程环中的进程，注册自己的进程，调动消息发送和接受
loop(N,A)->
     register(list_to_atom([A]),self()),
    io:format("The process ~p is started!\n",[[A]]),
    loopin(N,A).
 
 
  %%环中除了最后一个进程的消息发送和接受。并通过发送消息启动下一个进程的消息发送
loopin(N,A) when N>1->
    receive {start,M,Msg}->
       list_to_atom([A+1])!{start,M,Msg}, send(M,Msg,A+1),loopin(N,A);
    {msg,Msg} -> io:format("The process ~p has received the Msg \"~p\".\n",[[A],Msg]),loopin(N,A);
       {sys,stop} -> io:format("Process~p is stoped!\n",[[A]]) end;
 
 
  %%环中最后一个进程的消息发送和接受，和环中其他进程的区别是，不再发送启动消息
loopin(1,A)->
    receive {start,M,Msg}->
        send(M,Msg,97),
        loopin(1,A);
        {msg,Msg} -> io:format("The process ~p has received the Msg \"~p\".\n",[[A],Msg]),loopin(1,A);
       {sys,stop} -> io:format("Process~p is stoped!\n",[[A]]) end.
 
     
  %%发送M次Msg
send(M,Msg,A) when M>0 ->       
       list_to_atom([A])!{msg,Msg},send(M-1,Msg,A);
send(0,_,A)->                   
    list_to_atom([A]) ! {sys,stop}.