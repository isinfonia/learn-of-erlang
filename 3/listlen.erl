-module(listlen).
-compile(export_all).

% listlen([]) -> 0;
% listlen([_|Xs]) -> 1 + listlen(Xs).

listlen(Y)  ->
	case Y of
		[]		-> 0;
		[_|Xs]	-> 1 + listlen(Xs)
	end.
