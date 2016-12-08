-module(bump).
-export([bump/1]).

% bump([Head|Tail]) -> [Head + 1 | bump(Tail)];
% bump([]) -> [].

bump(List) -> bump_acc(List,[]).

bump_acc([], Acc) -> reverse(Acc);
bump_acc([Head | Tail], Acc) -> bump_acc(Tail, [Head + 1 | Acc]).

reverse(List) -> reverse_acc(List,[]).

reverse_acc([], Acc) -> Acc;
reverse_acc([Head | Tail], Acc) -> reverse_acc(Tail, [Head | Acc]).