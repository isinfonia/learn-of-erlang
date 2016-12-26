-module(t4).
-export([fruit/1]).

fruit(F) ->
	case F of
		apple -> 1;
		pinapple -> 2;
		pair -> 3;
		_other -> error
	end.