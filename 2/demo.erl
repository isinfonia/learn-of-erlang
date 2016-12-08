-module(demo).
-compile(export_all).
% -export([double/1]).
% -export([times/2]).

double(Value) ->
	times(Value,2).
times(X, Y) ->
	X * Y.