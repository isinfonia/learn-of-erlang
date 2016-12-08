-module(example).
-export([even/1, number/1]).

% even(Int) -> 
% 	case Int rem 2 of
% 		0 -> true;
% 		1 -> false
% 	end.

% number(Number) ->
% 	if 
% 		is_integer(Number) 	-> integer;
% 		is_float(Number) 	-> float;
% 		true				-> false
% 	end.

even(Int) when Int rem 2 == 0 -> true;
even(Int) when Int rem 2 == 1 -> false.

number(Num) when is_float(Num) 		-> float;
number(Num) when is_integer(Num)	-> integer;
number(_other) 						-> false.