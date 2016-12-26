-module(fg).
-compile(export_all).

% f(X) 		-> Y = X + 1, Y * X.
% g([Y|Xs]) 	-> Y + g(Xs);
% g([]) 		-> 0.

unsafe(X) ->
	if
		X > 10 ->
			bigger;
		true ->
			smaller
	end.