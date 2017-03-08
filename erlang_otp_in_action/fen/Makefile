compile:
	erlc -o ./simple_cache/ebin ./simple_cache/src/*.erl
	erlc -o ./resource_discovery/ebin ./resource_discovery/src/*.erl
start:
	erl -sname mynode -pa ./simple_cache/ebin/ -pa ./resource_discovery/ebin/
