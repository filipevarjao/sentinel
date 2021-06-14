%%%-------------------------------------------------------------------
%% @doc sentinel public API
%% @end
%%%-------------------------------------------------------------------

-module(sentinel_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    LagerRet = lager:start(),
    io:format("### lager start ret:~p~n", [LagerRet]),
    sentinel_sup:start_link().

stop(_State) ->
    'ok'.

%% internal functions
