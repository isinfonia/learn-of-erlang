-module(rings).
-export([start/3,start/5]).
 
%%采用第二种方法：环里面的新进程产生下一个进程。
 
%%将第一个进程的PID绑定到变量OriginalPid，随函数start/5传递到最后一个进程。N环中进程数；M为发送消息次数；Msg为消息内容；N（参数中第二个N）映射到OriginalN，用来计算进程号，使IO:FORMAT输出内容更易读。
start(N,M,Msg) -> OriginalPid=self(),start(N,M,Msg,N,OriginalPid).   
 
 
%%生成N个进程组成的进程环    
%%进程数(N)大于1时继续生成新进程并向新进程发送消息
start(N,M,Msg,OriginalN,OriginalPid) when N>1 ->  
    Npid=spawn(rings,start,[N-1,M,Msg,OriginalN,OriginalPid]),  
    send(M,Msg,Npid),
    loop(N,M,OriginalN,M);
%%当进程数（N）等于1，环中进程生成完毕，不再生成新进程，像第一个进程（OrginalPid）发送消息。
start(1,M,Msg,OriginalN,OriginalPid)->    
     send(M,Msg,OriginalPid),
     loop(1,M,OriginalN,M).
 
 
%%发送M条消息。
send(M,Msg,Npid) when M>0 ->       %%发送并且M-1循环调用。
    Npid ! {msg,Msg},send(M-1,Msg,Npid);
send(0,_,Npid)->                   %%M条Msg发送完毕，发送stop终止目标进程。
    Npid ! {sys,stop}.
 
 
%%接收消息。OriginalM是由M映射过来，用来计算接受消息的数目，使io:format更易读。
loop(N,M,OriginalN,OriginalM)->
    receive {msg,Msg}->case OriginalN-N>0 of    
                      %%除第一个进程之外的进程，打印出本进程（OriginalN-N+1）收到源进程（OriginalN-N）的第M条消息Msg，
                      true -> io:format("Process~p receive ~p Msg \"~p\" from Process~p.~n",[OriginalN-N+1,OriginalM-M+1,Msg,OriginalN-N]),loop(N,M-1,OriginalN,OriginalM);
                      %%第一个进程收到消息后，打印进程1收到最后一个进程（OriginalN）的第M条消息Msg。
             false -> io:format("Process1 receive ~p Msg \"~p\" from Process~p.~n",[OriginalM-M+1,Msg,OriginalN]),loop(N,M-1,OriginalN,OriginalM) end;
       {sys,stop} -> io:format("Process~p is stoped!\n",[OriginalN-N+1]) end.%%进程收到stop后终止。
