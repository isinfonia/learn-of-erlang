-module(sum).
-export([sum/1]).

% sum([]) -> 0;
% sum([Head | Tail]) -> Head + sum(Tail).

sum(List) -> sum_acc(List, []).

sum_acc([], Sum) -> Sum;
sum_acc([Head | Tail], Sum) -> sum_acc(Tail, Sum + Tail).
