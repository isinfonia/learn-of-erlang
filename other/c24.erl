-module(c24).
-export([game/4]).
-define(ANS, 24).

game(A, B, C, D) -> 
	Table = ets:new(myTable, []),
	solve(1, 2, [{A, integer_to_list(A)}, {B, integer_to_list(B)}, {C, integer_to_list(C)}, {D, integer_to_list(D)}], Table).

solve(I, J, List, Table) ->
	Len = length(List),
	case Len of
		1 ->
			[{Num, Str} | _Tail] = List,
			NewStr = lists:droplast(Str -- "(") ++ "=" ++ integer_to_list(?ANS),
			Test = ets:member(Table, NewStr),
			if
			 	Num == ?ANS ->
			 		if 
			 			Test == false ->
			 				io:format("~p~n",[NewStr]),
			 				ets:insert(Table, {NewStr});
			 			true ->
			 				[]
			 		end;
			 	true -> []
			end;
		_ ->
			if
				I >= Len -> [];
				J > Len -> solve(I+1, I+2, List, Table);
				true ->
					{X, Xs} = lists:nth(I, List),
					{Y, Ys} = lists:nth(J, List),
					NewList = lists:delete({X, Xs}, lists:delete({Y, Ys}, List)),
					if
						Xs < Ys ->
							solve(1, 2, [{X+Y, "(" ++ Xs ++ "+" ++ Ys ++ ")"} | NewList], Table),
							solve(1, 2, [{X*Y, "(" ++ Xs ++ "*" ++ Ys ++ ")"} | NewList], Table);
						true ->
							solve(1, 2, [{X+Y, "(" ++ Ys ++ "+" ++ Xs ++ ")"} | NewList], Table),
							solve(1, 2, [{X*Y, "(" ++ Ys ++ "*" ++ Xs ++ ")"} | NewList], Table)
					end,
					solve(1, 2, [{X-Y, "(" ++ Xs ++ "-" ++ Ys ++ ")"} | NewList], Table),
					solve(1, 2, [{Y-X, "(" ++ Ys ++ "-" ++ Xs ++ ")"} | NewList], Table),
					di(X, Y, Xs, Ys, NewList, Table),
					di(Y, X, Ys, Xs, NewList, Table),
					solve(I, J+1, List, Table)
			end
	end.

di(X, Y, Xs, Ys, List, Table) when Y /= 0->
	solve(1, 2, [{X/Y, "(" ++ Xs ++ "/" ++ Ys ++ ")"} | List], Table);
di(_X, _Y, _Xs, _Ys, _List, _Table) -> [].
