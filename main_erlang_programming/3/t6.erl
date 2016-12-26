-module(t6).
-export([qsort/1,mergesort/1]).

% %% 快排
% filter_min([Head | Tail], N) ->
% 	if
% 		Head =< N	->	[Head | filter_min(Tail, N)];
% 		true		-> 	filter_min(Tail,N)
% 	end;
% filter_min([], _N)	-> 	[].

% filter_max([Head | Tail], N) ->
% 	if
% 		Head > N	->	[Head | filter_max(Tail, N)];
% 		true		-> 	filter_max(Tail,N)
% 	end;
% filter_max([], _N)	-> 	[].

% qsort([]) -> [];
% qsort([Head | Tail]) ->
% 	qsort(filter_min(Tail, Head)) ++ [Head] ++ qsort(filter_max(Tail, Head)).

%% 快排精简版
qsort([]) -> [];
qsort([Head | Rest]) ->
	qsort([X || X <- Rest, X<Head]) ++ [Head] ++ qsort([X || X <-Rest, X>=Head]).



%% 归并排序

mergesort(List) ->
	{List1, List2} = lists:split
	



%%排序外壳
mergesort([]) -> [];
mergesort([E]) -> [E];
mergesort(L) ->
	{L1, L2} = lists:split(round(length(L)/2), L),
	merge(mergesort(L1), mergesort(L2)).

%%归并操作
merge([], L2) -> L2;
merge(L1, []) -> L1;
merge([H1|T1]=L1, [H2|T2]=L2) ->
	if H1＜H2 ->  [H1] ++ merge(T1, L2);
	   true	 ->  [H2] ++ merge(L1, T2)
	end.