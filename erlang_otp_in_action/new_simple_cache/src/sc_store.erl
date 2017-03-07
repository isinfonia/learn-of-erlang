-module(sc_store).

-export([init/0, insert/2, delete/1, lookup/1]).

-record(key_to_pid, {key, pid}).

-define(TABLE_ID, ?MODULE).

init() ->
    mnesia:start(),
    mnesia:create_table(key_to_pid, [{index, [pid]}, {attributes, record_info(fields, key_to_pid)}]).

insert(Key, Pid) ->
    mnesia:dirty_write(#key_to_pid{key = Key, pid = Pid}).

lookup(Key) ->
    case mnesia:dirty_read(key_to_pid, Key) of
        [{key_to_pid, Key, Pid}] -> {ok, Pid};
        [] -> {error, not_found}
    end.

delete(Pid) ->
    ets:match_delete(?TABLE_ID, {'_', Pid}).


