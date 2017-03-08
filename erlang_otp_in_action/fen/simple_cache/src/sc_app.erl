-module(sc_app).

-behaviour(application).

-export([start/2, stop/1]).

-define(WAIT_FOR_REASOURCES, 5000).

start(_StartType, _StartArgs) ->
    ok = ensure_contact(),
    resource_discovery:add_local_resource(simple_cache, node()),
    resource_discovery:add_target_resource_type(simple_cache),
    resource_discovery:trade_resources(),
    timer:sleep(?WAIT_FOR_REASOURCES),
    sc_store:init(),
    case sc_sup:start_link() of
        {ok, Pid} ->
            {ok, Pid};
        Other ->
            {error, Other}
    end.

stop(_State) ->
    ok.

ensure_contact() ->
    DefaultNodes = ['contact1@localhost', 'contact2@localhost'],
    case get_env(simple_cache, contact_nodes, DefaultNodes) of
        [] ->
            {error, no_contact_node};
        ContactNode ->
            ensure_contact(ContactNode)
    end.
ensure_contact(ContactNode) ->
    Answering = [N || N <- ContactNode, net_adm:ping(N) =:= pong],
    case Answering of
        [] ->
            {error, no_contact_node_reachable};
        _ ->
            DefaultTime = 6000,
            WaitTime = get_env(simple_cache, wait_time, DefaultTime),
            wait_for_nodes(length(Answering), WaitTime)
     end.

wait_for_nodes(MinNodes, WaitTime) ->
    Slices = 10,
    SliceTime = round(WaitTime/Slices),
    wait_for_nodes(MinNodes, SliceTime, Slices). 

wait_for_nodes(_MinNodes, _SliceTime, 0) ->
    ok;
wait_for_nodes(MinNodes, SliceTime, Iterations) ->
    case length(nodes()) > MinNodes of 
        true ->
            ok;
        false ->
            timer:sleep(SliceTime),
            wait_for_nodes(MinNodes, SliceTime, Iterations - 1)
    end.

get_env(AppName, Key, Default) ->
    case application:get_env(AppName, Key) of
        undefined -> Default;
        {ok, Value} -> Value
    end.

